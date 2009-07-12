#--
#
# This file is one part of:
#
# Ruby-SDL-FFI - Ruby-FFI bindings to SDL
#
# Copyright (c) 2009 John Croisant
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
#++


require 'nice-ffi'


module SDL

  ALPHA_OPAQUE      = 255
  ALPHA_TRANSPARENT = 0

  class Rect < NiceFFI::Struct
    layout( :x, :int16,
            :y, :int16,
            :w, :uint16,
            :h, :uint16 )
  end

  class Color < NiceFFI::Struct
    layout( :r,      :uint8,
            :g,      :uint8,
            :b,      :uint8,
            :unused, :uint8 )

    hidden( :unused )

  end

  class Palette < NiceFFI::Struct
    layout( :ncolors, :int,
            :colors,  :pointer )
  end

  class PixelFormat < NiceFFI::Struct
    layout( :palette,       NiceFFI::TypedPointer( Palette ),
            :BitsPerPixel,  :uint8,
            :BytesPerPixel, :uint8,
            :Rloss,         :uint8,
            :Gloss,         :uint8,
            :Bloss,         :uint8,
            :Aloss,         :uint8,
            :Rshift,        :uint8,
            :Gshift,        :uint8,
            :Bshift,        :uint8,
            :Ashift,        :uint8,
            :Rmask,         :uint32,
            :Gmask,         :uint32,
            :Bmask,         :uint32,
            :Amask,         :uint32,
            :colorkey,      :uint32,
            :alpha,         :uint8 )
  end

  class Surface < NiceFFI::Struct
    layout( :flags,          :uint32,
            :format,         NiceFFI::TypedPointer( PixelFormat ),
            :w,              :int,
            :h,              :int,
            :pitch,          :uint16,
            :pixels,         :pointer,
            :offset,         :int,
            :hwdata,         :pointer,
            :clip_rect,      SDL::Rect,
            :unused1,        :uint32,
            :locked,         :uint32,
            :map,            :pointer,
            :format_version, :uint,
            :refcount,       :int )

    read_only( :flags, :format, :w, :h,
               :pitch, :clip_rect, :refcount )

    hidden( :offset, :hwdata, :unused1,
            :locked, :map, :format_version )

  end


  SWSURFACE   = 0x00000000
  HWSURFACE   = 0x00000001
  ASYNCBLIT   = 0x00000004
  ANYFORMAT   = 0x10000000
  HWPALETTE   = 0x20000000
  DOUBLEBUF   = 0x40000000
  FULLSCREEN  = 0x80000000
  OPENGL      = 0x00000002
  OPENGLBLIT  = 0x0000000A
  RESIZABLE   = 0x00000010
  NOFRAME     = 0x00000020
  HWACCEL     = 0x00000100
  SRCCOLORKEY = 0x00001000
  RLEACCELOK  = 0x00002000
  RLEACCEL    = 0x00004000
  SRCALPHA    = 0x00010000
  PREALLOC    = 0x01000000

  callback(:blit_cb, [ :pointer, :pointer, :pointer, :pointer ], :int)

## Don't know how to implement this.
#
#   class VideoInfo < NiceFFI::Struct
#     layout( :hw_available,  :uint32,  #bitfield: 1
#             :wm_available,  :uint32,  #bitfield: 1
#             :UnusedBits1,   :uint32,  #bitfield: 6
#             :UnusedBits2,   :uint32,  #bitfield: 1
#             :blit_hw,       :uint32,  #bitfield: 1
#             :blit_hw_CC,    :uint32,  #bitfield: 1
#             :blit_hw_A,     :uint32,  #bitfield: 1
#             :blit_sw,       :uint32,  #bitfield: 1
#             :blit_sw_CC,    :uint32,  #bitfield: 1
#             :blit_sw_A,     :uint32,  #bitfield: 1
#             :blit_fill,     :uint32,  #bitfield: 1
#             :UnusedBits3,   :uint32,  #bitfield: 16
#             :video_mem,     :uint32,
#             :vfmt,          NiceFFI::TypedPointer( PixelFormat ),
#             :current_w,     :int,
#             :current_h,     :int )
#
#     hidden( :UnusedBits1, :UnusedBits2, :UnusedBits3 )
#
#   end


  YV12_OVERLAY = 0x32315659
  IYUV_OVERLAY = 0x56555949
  YUY2_OVERLAY = 0x32595559
  UYVY_OVERLAY = 0x59565955
  YVYU_OVERLAY = 0x55595659

  class Overlay < NiceFFI::Struct
    layout( :format,     :uint32,
            :w,          :int,
            :h,          :int,
            :planes,     :int,
            :pitches,    :pointer,
            :pixels,     :pointer,
            :hwfuncs,    :pointer,
            :hwdata,     :pointer,
            :hw_overlay, :uint32,
            :UnusedBits, :uint32 )

    read_only( :format, :w, :h, :planes,
               :pitches, :hw_overlay )

    hidden( :hwfuncs, :hwdata, :UnusedBits )

  end


  GL_RED_SIZE           = 0
  GL_GREEN_SIZE         = 1
  GL_BLUE_SIZE          = 2
  GL_ALPHA_SIZE         = 3
  GL_BUFFER_SIZE        = 4
  GL_DOUBLEBUFFER       = 5
  GL_DEPTH_SIZE         = 6
  GL_STENCIL_SIZE       = 7
  GL_ACCUM_RED_SIZE     = 8
  GL_ACCUM_GREEN_SIZE   = 9
  GL_ACCUM_BLUE_SIZE    = 10
  GL_ACCUM_ALPHA_SIZE   = 11
  GL_STEREO             = 12
  GL_MULTISAMPLEBUFFERS = 13
  GL_MULTISAMPLESAMPLES = 14
  GL_ACCELERATED_VISUAL = 15
  GL_SWAP_CONTROL       = 16

  LOGPAL  = 0x01
  PHYSPAL = 0x02


  attach_function  :SDL_VideoInit,       [ :string, :uint32 ], :int
  attach_function  :SDL_VideoQuit,       [  ], :void
  attach_function  :SDL_VideoDriverName, [ :string, :int ], :string
  attach_function  :SDL_GetVideoSurface, [  ], NiceFFI::TypedPointer( SDL::Surface )

  ## Depends on SDL::VideoInfo, which I don't know how to implement.
  #attach_function  :SDL_GetVideoInfo,    [  ], NiceFFI::TypedPointer( SDL::VideoInfo )

  attach_function  :SDL_VideoModeOK,     [ :int, :int, :int, :uint32 ], :int

  ## Don't know how to implement this one. :-\
  # attach_function  :SDL_ListModes,       [ :pointer, :uint32 ], :pointer

  attach_function  :SDL_SetVideoMode, [ :int, :int, :int, :uint32 ],
                   NiceFFI::TypedPointer( SDL::Surface )


  attach_function  :SDL_UpdateRects, [ :pointer, :int, :pointer ], :void
  attach_function  :SDL_UpdateRect,  [ :pointer, :int32, :int32,
                                       :uint32, :uint32 ], :void
  attach_function  :SDL_Flip,        [ :pointer ], :int


  attach_function  :SDL_SetGamma,     [ :float, :float, :float       ], :int
  attach_function  :SDL_SetGammaRamp, [ :pointer, :pointer, :pointer ], :int


  attach_function  :__SDL_GetGammaRamp, "SDL_GetGammaRamp",
                   [ :pointer, :pointer, :pointer ], :int

  def self.SDL_GetGammaRamp()
    rtable = FFI::Buffer.new( :uint16, 256 )
    gtable = FFI::Buffer.new( :uint16, 256 )
    btable = FFI::Buffer.new( :uint16, 256 )

    n = __SDL_GetGammaRamp( rtable, gtable, btable )

    if( n == -1 )
      return nil
    else
      return [ rtable.get_array_of_uint16(0, 256),
               gtable.get_array_of_uint16(0, 256),
               btable.get_array_of_uint16(0, 256) ]
    end
  end


  attach_function  :SDL_SetColors,
                   [ :pointer, :pointer, :int, :int ], :int

  attach_function  :SDL_SetPalette,
                   [ :pointer, :int, :pointer, :int, :int ], :int

  attach_function  :SDL_MapRGB,
                   [ :pointer, :uint8, :uint8, :uint8 ], :uint32

  attach_function  :SDL_MapRGBA,
                   [ :pointer, :uint8, :uint8, :uint8, :uint8 ], :uint32



  attach_function  :__SDL_GetRGB, "SDL_GetRGB",
                   [ :uint32, :pointer, :pointer,
                     :pointer, :pointer ], :void

  def self.SDL_GetRGB( uint32, format )
    r = FFI::MemoryPointer.new( :uint8 )
    g = FFI::MemoryPointer.new( :uint8 )
    b = FFI::MemoryPointer.new( :uint8 )
    __SDL_GetRGB( uint32, format, r, g, b )
    return [r.get_uint8(0), g.get_uint8(0), b.get_uint8(0)]
  end



  attach_function  :__SDL_GetRGBA, "SDL_GetRGBA",
                   [ :uint32, :pointer, :pointer, :pointer,
                     :pointer, :pointer ], :void

  def self.SDL_GetRGBA( uint32, format )
    r = FFI::MemoryPointer.new( :uint8 )
    g = FFI::MemoryPointer.new( :uint8 )
    b = FFI::MemoryPointer.new( :uint8 )
    a = FFI::MemoryPointer.new( :uint8 )
    __SDL_GetRGBA( uint32, format, r, g, b, a )
    return [r.get_uint8(0), g.get_uint8(0), b.get_uint8(0), a.get_uint8(0)]
  end



  attach_function  :SDL_CreateRGBSurface,
                   [ :uint32, :int, :int, :int,
                     :uint32, :uint32, :uint32, :uint32 ],
                   NiceFFI::TypedPointer( SDL::Surface )

  attach_function  :SDL_CreateRGBSurfaceFrom,
                   [ :pointer, :int, :int, :int, :int,
                     :uint32, :uint32, :uint32, :uint32 ],
                   NiceFFI::TypedPointer( SDL::Surface )


  attach_function  :SDL_FreeSurface,   [ :pointer ], :void
  attach_function  :SDL_LockSurface,   [ :pointer ], :int
  attach_function  :SDL_UnlockSurface, [ :pointer ], :void


  attach_function  :SDL_LoadBMP_RW,    [ :pointer, :int ],
                   NiceFFI::TypedPointer( SDL::Surface )

  attach_function  :SDL_SaveBMP_RW,    [ :pointer, :pointer, :int   ], :int


  attach_function  :SDL_SetColorKey,   [ :pointer, :uint32, :uint32 ], :int
  attach_function  :SDL_SetAlpha,      [ :pointer, :uint32, :uint8  ], :int


  attach_function  :SDL_SetClipRect,   [ :pointer, :pointer ], SDL::BOOL


  attach_function  :__SDL_GetClipRect, "SDL_GetClipRect",
                   [ :pointer, :pointer ], :void

  def self.SDL_GetClipRect( surface )
    mp = FFI::MemoryPointer.new( Rect )
    __SDL_GetClipRect( surface, mp )
    return Rect.new( mp )
  end


  attach_function  :SDL_ConvertSurface, [ :pointer, :pointer, :uint32 ],
                   NiceFFI::TypedPointer( SDL::Surface )

  attach_function  :SDL_BlitSurface, "SDL_UpperBlit",
                   [ :pointer, :pointer, :pointer, :pointer ], :int

  attach_function  :SDL_FillRect, [ :pointer, :pointer, :uint32 ], :int


  attach_function  :SDL_DisplayFormat,      [ :pointer ],
                   NiceFFI::TypedPointer( SDL::Surface )

  attach_function  :SDL_DisplayFormatAlpha, [ :pointer ],
                   NiceFFI::TypedPointer( SDL::Surface )


  attach_function  :SDL_CreateYUVOverlay, [ :int, :int, :uint32, :pointer ],
                   NiceFFI::TypedPointer( SDL::Overlay )

  attach_function  :SDL_LockYUVOverlay,    [ :pointer ], :int
  attach_function  :SDL_UnlockYUVOverlay,  [ :pointer ], :void
  attach_function  :SDL_DisplayYUVOverlay, [ :pointer, :pointer ], :int
  attach_function  :SDL_FreeYUVOverlay,    [ :pointer ], :void


  attach_function  :SDL_GL_LoadLibrary, [ :string ], :int
  attach_function  :SDL_GL_GetProcAddress, [ :string ], :pointer
  attach_function  :SDL_GL_SetAttribute, [ SDL::GLATTR, :int ], :int
  attach_function  :SDL_GL_GetAttribute, [ SDL::GLATTR, :pointer ], :int
  attach_function  :SDL_GL_SwapBuffers, [  ], :void
  attach_function  :SDL_GL_UpdateRects, [ :int, :pointer ], :void
  attach_function  :SDL_GL_Lock,        [  ], :void
  attach_function  :SDL_GL_Unlock,      [  ], :void


  attach_function  :SDL_WM_SetCaption, [ :string, :string ], :void


  attach_function  :__SDL_WM_GetCaption, "SDL_WM_GetCaption",
                   [ :pointer, :pointer ], :void

  def self.SDL_WM_GetCaption()
    title = FFI::MemoryPointer.new( :pointer )
    icont = FFI::MemoryPointer.new( :pointer )
    __SDL_WM_GetCaption( title, icont )
    return [ title.get_pointer(0).get_string(0),
             icont.get_pointer(0).get_string(0) ]
  end


  attach_function  :SDL_WM_SetIcon,    [ :pointer, :pointer ], :void
  attach_function  :SDL_WM_IconifyWindow,    [  ], :int
  attach_function  :SDL_WM_ToggleFullScreen, [ :pointer ], :int

  GRAB_QUERY      = -1
  GRAB_OFF        = 0
  GRAB_ON         = 1
  GRAB_FULLSCREEN = 2

  attach_function  :SDL_WM_GrabInput, [ SDL::ENUM ], SDL::ENUM

end