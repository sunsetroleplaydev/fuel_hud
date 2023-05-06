-- For support join my discord: https://discord.gg/Z9Mxu72zZ6
local vehicle = nil
local vehClass = nil
local driver = nil

CreateThread(function()
    Wait(500)
    while true do
        Wait(300)
        local ped = PlayerPedId()
        vehicle = GetVehiclePedIsIn(ped)
        vehClass = GetVehicleClass(vehicle)
        driver = GetPedInVehicleSeat(vehicle, -1)
    end
end)

CreateThread(function()
    while true do
        Wait(0)
        if vehicle ~= 0 and vehClass ~= 13 and driver then
            if config.fuelSystem == "nd" or config.fuelSystem == "ox" then
                local fuelLevel = (0.141 * GetVehicleFuelLevel(vehicle)) / 100 -- Fuel Value x Max Bar Width Show The Level Range Within The Bar
            elseif config.fuelSystem == "legacy" then
                local fuelLevel = (0.141 * exports["LegacyFuel"]:GetFuel(vehicle)) / 100 -- Fuel Value x Max Bar Width Show The Level Range Within The Bar
            elseif config.fuelSystem == "cdn" then
                local fuelLevel = (0.141 * exports["cdn-fuel"]:GetFuel(vehicle)) / 100 -- Fuel Value x Max Bar Width Show The Level Range Within The Bar
            elseif config.fuelSystem == "ps" then
                local fuelLevel = (0.141 * exports["ps-fuel"]:GetFuel(vehicle)) / 100 -- Fuel Value x Max Bar Width Show The Level Range Within The Bar
            end   
            DrawRect(0.0855, 0.8, 0.141, 0.010 + 0.006, 40, 40, 40, 150)  -- Bar Background (Black)
            if config.electricVehiles[GetEntityModel(vehicle)] then
                DrawRect(0.0855, 0.8, 0.141, 0.010, 20, 140, 255, 100)  -- Bar Background (lighter blue)
                DrawRect(0.0855 - (0.141 - fuelLevel) / 2, 0.8, fuelLevel, 0.010, 20, 140, 255, 255)  -- Current Fuel (Blue)
            else
                DrawRect(0.0855, 0.8, 0.141, 0.010, 206, 145, 40, 100)  -- Bar Background (lighter yellow)
                DrawRect(0.0855 - (0.141 - fuelLevel) / 2, 0.8, fuelLevel, 0.010, 206, 145, 0, 255)  -- Current Fuel (Yellow)
            end
        end
    end
end)
