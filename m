Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8630330E84A
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 00:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761525877; cv=none; b=JZ7HW4AtTwCVXwQHOelESRRhqqQPZ/k8DZAGAPNmbgM+6fLNKIKYg38n+02Pa+Rb07ZbWGXP/3Sz+Y36rHncSUla8yXIbEe0zO3hFOysn672qE6Mt8zGMYx9MT1DbteMfkaixalGGV5HGQuvC++aKLErDEaVzQ32SJqMR6wJrgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761525877; c=relaxed/simple;
	bh=hXz185Dw8ORo4BT4fuUyqjvOahQ4nMirXJcAMV5XNMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ct0TOsQDM3Zk3m/Gevb02b7Kf/s7CvBUD1smULTxtNOYIGksx20RnAr/6x3i/XSKzp6/1eAvrHFhyM7xt4v9icDCzmb7UgOZMR2z3NuAW9tmkY6kl7D5/nyZueDLb1REUC3A4Y16y9COxcS+rGaHqS0UXbFo+E4cuf7lSS03Wl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Za0MZGF1; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Za0MZGF1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1761525867;
	bh=hXz185Dw8ORo4BT4fuUyqjvOahQ4nMirXJcAMV5XNMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=Za0MZGF1XYAZSS2Ktevon+yTjMJeab3/FAU6bJp0w5NCu0YT3kfbi4UQRLKSrPTSw
	 ISUhZshzlAGeQ5yZttx/w6BCI6LL0fJYIr7DBi0UnhDa87/oVR+fqQegv8fvHP36Up
	 7noGPeGCqQTM8rrjmML71rMW1OLor4/xSn9+7Jyl7xs+xb++evV/6wxu02Mlt2qWQN
	 24jFbuYAJTJNpgnxSelje+Do+7HQaJRZ6/dmY14BU0xu8nfiFFO63WOfwkla/uyrm8
	 1Ig9KFAtxXVAmCINuBYqm2E+S3F0qNQwbuQyQ/NeYCmaDiSh7RS4jjru6w6J4P9Lfw
	 ePDY0qyImNtOytQ70Qz3bd3FJr0ejdFA6JtL1RpFcWf0AE4x8LCoUH3kGR0NI+oTkR
	 krHnzb9wgi3kmHlvevDMNwZWNmVWcN/asF4ZSDf3RuskAOxk+g/yW+6qwbEyNP6KKL
	 foNpLJ+HiBLssfJnxEFxkFstxz3jI+6FwnBIOMCR7ew73ZasO3R
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:5675:b769:afe:3fa2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id EBCCF23200;
	Mon, 27 Oct 2025 00:44:27 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: [PATCH 13/14] rust: add a small wrapper around the hashfile code
Date: Mon, 27 Oct 2025 00:44:03 +0000
Message-ID: <20251027004404.2152927-14-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
In-Reply-To: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Our new binary loose object map code avoids needing to be intimately
involved with file handling by simply writing data to an object
implement Write.  This makes it very easy to test by writing to a Cursor
wrapping a Vec for tests, and thus decouples it from intimate knowledge
about how we handle files.

However, we will actually want to write our data to an actual file,
since that's the most practical way to persist data.  Implement a
wrapper around the hashfile code that implements the Write trait so that
we can write our loose object map into a file.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Makefile         |  1 +
 src/csum_file.rs | 81 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/lib.rs       |  1 +
 src/meson.build  |  1 +
 4 files changed, 84 insertions(+)
 create mode 100644 src/csum_file.rs

diff --git a/Makefile b/Makefile
index 2081b13780..8eb31aeed2 100644
--- a/Makefile
+++ b/Makefile
@@ -1521,6 +1521,7 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 
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
