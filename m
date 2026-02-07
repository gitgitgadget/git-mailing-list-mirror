Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585DF33C19E
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 20:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770494706; cv=none; b=KM25ZJU4KcUeREQXviZOPnXrylboabNWfKT+HMGpTUzZCkMKEfguQ1/g2/zKBXNTsjIGMK2T+4Hx69tlU1he1Tndf+f0goH/7vOpvrnfuc/nxFH+PU2Kw5e0FOKsJIAp+bvXi8WTrtMmi/UGs/IFeTa+zxoNd915pbEk8mq/HcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770494706; c=relaxed/simple;
	bh=Lo+vVknVElOBA9UQM8jltxXSkTFkdb7NKYT9Iszwglg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YpRaOLGe81EkvPhdKfUY9Dk+MJUReIvAXwyH4vv/a1RINo5qJuHlEF0GDWIqZ5xwbKu/4UeDqxeBtuEo8GVaeDVrj78qKM2dJlCo2WfEqMrGf5LJv5mNANS6gc6O9dpY7wQHgJaKYuL2Qd/sL7K2hRxf6CX8/wQFs28+9q2m9gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=qAo9rKrZ; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="qAo9rKrZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1770494697;
	bh=Lo+vVknVElOBA9UQM8jltxXSkTFkdb7NKYT9Iszwglg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=qAo9rKrZE7GqSDiUDE8ZVlCflVE/edTWzsbsDzccnOFTBOE8EkD4IbOyddARhoeAj
	 j7hlwhfMonfVmfPIu1AcAEu6bKEMVJ+stdWydCWqDCaO8A4FxbxPr5u23iaGCyCeKa
	 pJGdhh4Mn+6wLEXeVGmk8qqCwo9XzOzokADQ0qEHkmZ7u6ZdkZnWY1D6ROrh0vw3IB
	 ZmaQPjjZJp1+dBeGdTwcwiTJiaGfP2VvIQ5jsscZ28FpaLKNJF2IqTuyk0ULq5rl08
	 9Aqih3VZwoA2RxwlUwT2R79mcVl/CbaQ2FR1bHTZWnjcRpA/dpglZ2FrCNf/WaiBjh
	 3RHjo/av5zeRNwy+ER65fJ8tWk6G6z93qVrRj9oZ5AbNXArX5ohlb7XHntwt8Wt+3W
	 noka7fH/YdTLLRWlUChJfbUa+mbKKrZ2iDZaOZYSSxoMmPM64fZja+NA1GLMp4A24h
	 OW9jZIg5hjZ4E6ChRCUb0gTO2A88C/YcYKdaZJP+HAwB8hF5764
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9a58:ad83:8db9:6f4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id EBC00243EB;
	Sat,  7 Feb 2026 20:04:57 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 15/16] rust: add a small wrapper around the hashfile code
Date: Sat,  7 Feb 2026 20:04:45 +0000
Message-ID: <20260207200446.2837699-16-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
In-Reply-To: <20260207200446.2837699-1-sandals@crustytoothpaste.net>
References: <20251117221621.2863243-1-sandals@crustytoothpaste.net>
 <20260207200446.2837699-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Our new binary object map code avoids needing to be intimately involved
with file handling by simply writing data to an object implement Write.
This makes it very easy to test by writing to a Cursor wrapping a Vec
for tests, and thus decouples it from intimate knowledge about how we
handle files.

However, we will actually want to write our data to an actual file,
since that's the most practical way to persist data.  Implement a
wrapper around the hashfile code that implements the Write trait so that
we can write our object map into a file.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Makefile         |  1 +
 src/csum_file.rs | 81 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/lib.rs       |  1 +
 src/meson.build  |  1 +
 4 files changed, 84 insertions(+)
 create mode 100644 src/csum_file.rs

diff --git a/Makefile b/Makefile
index acb7768cb8..9e16ce64e2 100644
--- a/Makefile
+++ b/Makefile
@@ -1545,6 +1545,7 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
 
+RUST_SOURCES += src/csum_file.rs
 RUST_SOURCES += src/hash.rs
 RUST_SOURCES += src/lib.rs
 RUST_SOURCES += src/loose.rs
diff --git a/src/csum_file.rs b/src/csum_file.rs
new file mode 100644
index 0000000000..7f2c6c4fcb
--- /dev/null
+++ b/src/csum_file.rs
@@ -0,0 +1,81 @@
+// This program is free software; you can redistribute it and/or modify
+// it under the terms of the GNU General Public License as published by
+// the Free Software Foundation: version 2 of the License, dated June 1991.
+//
+// This program is distributed in the hope that it will be useful,
+// but WITHOUT ANY WARRANTY; without even the implied warranty of
+// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+// GNU General Public License for more details.
+//
+// You should have received a copy of the GNU General Public License along
+// with this program; if not, see <https://www.gnu.org/licenses/>.
+
+use crate::hash::{HashAlgorithm, GIT_MAX_RAWSZ};
+use std::ffi::CStr;
+use std::io::{self, Write};
+use std::os::raw::c_void;
+
+/// A writer that can write files identified by their hash or containing a trailing hash.
+pub struct HashFile {
+    ptr: *mut c_void,
+    algo: HashAlgorithm,
+}
+
+impl HashFile {
+    /// Create a new HashFile.
+    ///
+    /// The hash used will be `algo`, its name should be in `name`, and an open file descriptor
+    /// pointing to that file should be in `fd`.
+    pub fn new(algo: HashAlgorithm, fd: i32, name: &CStr) -> HashFile {
+        HashFile {
+            ptr: unsafe { c::hashfd(algo.hash_algo_ptr(), fd, name.as_ptr()) },
+            algo,
+        }
+    }
+
+    /// Finalize this HashFile instance.
+    ///
+    /// Returns the hash computed over the data.
+    pub fn finalize(self, component: u32, flags: u32) -> Vec<u8> {
+        let mut result = vec![0u8; GIT_MAX_RAWSZ];
+        unsafe { c::finalize_hashfile(self.ptr, result.as_mut_ptr(), component, flags) };
+        result.truncate(self.algo.raw_len());
+        result
+    }
+}
+
+impl Write for HashFile {
+    fn write(&mut self, data: &[u8]) -> io::Result<usize> {
+        for chunk in data.chunks(u32::MAX as usize) {
+            unsafe {
+                c::hashwrite(
+                    self.ptr,
+                    chunk.as_ptr() as *const c_void,
+                    chunk.len() as u32,
+                )
+            };
+        }
+        Ok(data.len())
+    }
+
+    fn flush(&mut self) -> io::Result<()> {
+        unsafe { c::hashflush(self.ptr) };
+        Ok(())
+    }
+}
+
+pub mod c {
+    use std::os::raw::{c_char, c_int, c_void};
+
+    extern "C" {
+        pub fn hashfd(algop: *const c_void, fd: i32, name: *const c_char) -> *mut c_void;
+        pub fn hashwrite(f: *mut c_void, data: *const c_void, len: u32);
+        pub fn hashflush(f: *mut c_void);
+        pub fn finalize_hashfile(
+            f: *mut c_void,
+            data: *mut u8,
+            component: u32,
+            flags: u32,
+        ) -> c_int;
+    }
+}
diff --git a/src/lib.rs b/src/lib.rs
index 442f9433dc..0c598298b1 100644
--- a/src/lib.rs
+++ b/src/lib.rs
@@ -1,3 +1,4 @@
+pub mod csum_file;
 pub mod hash;
 pub mod loose;
 pub mod varint;
diff --git a/src/meson.build b/src/meson.build
index 1eea068519..45739957b4 100644
--- a/src/meson.build
+++ b/src/meson.build
@@ -1,4 +1,5 @@
 libgit_rs_sources = [
+  'csum_file.rs',
   'hash.rs',
   'lib.rs',
   'loose.rs',
