pub const std = @import("std");
// pub const s = @import("string.zig");
// pub const str = s.str;
// pub const String = s.String;
pub const json = @import("json.zig");
pub const as = @import("cast.zig");
pub const io = std.Io;
pub const alloc = std.mem.Allocator;
pub const mem = std.mem;
pub const time = std.time;
pub const atomic = std.atomic;
pub const http = std.http;
pub const fmt = std.fmt;

// pub const text = @import("text.zig").Text;

pub const str = []const u8;
pub const cstr = [:0]const u8;
pub const String = std.ArrayList(u8);

pub fn print(comptime txt: str) void {
    std.debug.print(txt ++ "\n", .{});
}
pub fn log(comptime txt: str, args: anytype) void {
    std.log.err(txt, args);
}
pub fn err(comptime txt: str, er: anyerror) void {
    std.log.err(txt ++ " {} ({s})", .{ er, @errorName(er) });
}
pub fn warn(comptime txt: str, args: anytype) void {
    std.log.warn(txt, args);
}
pub fn debug(comptime txt: str, args: anytype) void {
    std.log.debug(txt, args);
}

pub fn list(comptime T: type) std.ArrayList(T) {
    return std.ArrayList(T).empty;
}

pub fn map(comptime K: type, comptime V: type) std.AutoHashMapUnmanaged(K, V) {
    return std.AutoHashMap(K, V).empty;
}

pub fn eq(s1: []const u8, s2: []const u8) bool {
    return std.mem.eql(u8, s1, s2);
}

pub fn lines(s: []const u8) std.mem.SplitIterator([]const u8) {
    return std.mem.splitScalar([]const u8, s, '\n');
}

pub fn parse(comptime T: type, s: []const u8) !T {
    return switch (@TypeOf(T)) {
        .float => try std.fmt.parseFloat(T, s),
        .int => try std.fmt.parseInt(T, s, 10),
        else => std.fmt.ParseIntError.InvalidCharacter,
    };
}
