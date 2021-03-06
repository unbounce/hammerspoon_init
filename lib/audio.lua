-- https://github.com/af/dotfiles/blob/master/hammerspoon/audio.lua

local Audio = {}
local VOLUME_MIN = 0
local VOLUME_MAX = 100
local VOLUME_STEP = 10

-- display a unicode volume meter via hs.alert
-- Characters found via http://changaco.net/unicode-progress-bars/
local showVolumeAlert = function(volume)
  -- show a 10-bar volume meter (10% increments)
  local numBars = math.floor(volume/VOLUME_STEP)
  local numSpaces = (100/VOLUME_STEP) - numBars
  local volumeBar = string.rep('⣿', numBars) .. string.rep('⣀', numSpaces)

  hs.alert.closeAll()
  hs.alert(volumeBar)
end

Audio.toggleMute = function()
  local device = hs.audiodevice.defaultOutputDevice()
  local wasMuted = device:muted()
  device:setMuted(not wasMuted)
  showVolumeAlert(wasMuted and device:volume() or 0)
end

Audio.decVolume = function()
  local device = hs.audiodevice.defaultOutputDevice()
  local targetVolume = math.max(device:volume() - VOLUME_STEP, VOLUME_MIN)
  device:setMuted(false)
  device:setVolume(targetVolume)
  showVolumeAlert(targetVolume)
end

Audio.incVolume = function()
  local device = hs.audiodevice.defaultOutputDevice()
  local targetVolume = math.min(device:volume() + VOLUME_STEP, VOLUME_MAX)
  device:setMuted(false)
  device:setVolume(targetVolume)
  showVolumeAlert(targetVolume)
end

return Audio
