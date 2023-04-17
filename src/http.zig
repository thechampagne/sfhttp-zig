// Copyright 2023 XXIV
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
pub const http_status_t = enum(c_uint) {
    HTTP_STATUS_PENDING,
    HTTP_STATUS_COMPLETED,
    HTTP_STATUS_FAILED
};

pub const http_t = extern struct {
    status: http_status_t,
    status_code: c_int,
    reason_phrase: [*c]const u8,
    content_type: [*c]const u8,
    response_size: usize,
    response_data: ?*anyopaque,
};

pub extern "C" fn http_get(url: [*c]const u8, memctx: ?*anyopaque) [*c]http_t;
pub extern "C" fn http_post(url: [*c]const u8, data: ?*const anyopaque, size: usize, memctx: ?*anyopaque) [*c]http_t;
pub extern "C" fn http_process(http: [*c]http_t) http_status_t;
pub extern "C" fn http_release(http: [*c]http_t) void;
