Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7B72F7ADE
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 20:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770494704; cv=none; b=kH+XoGKvgshyZGproCCUnNraybhaIxL1NNT5A7rGe0JHCGheascuqLQBE3QmLvO+YwjhUceILCa0GizG8GJQ/VihmaZWXbMoePtohevhirzga6A3UHwtLTkWrY/JDGQ5S+C3EZAX/+6DdVDk211Lq8j0lKY76nTBmT+bExQe9mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770494704; c=relaxed/simple;
	bh=PhdvHKZGV67UryZuMCWlC6ciJo673YhktWOe/es86PM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UE88BeNWdUgwoE5V/U/0qUN4EkBXXRTH0abCP2BMdOgLFYj4Cw0QYPgts2+ULZkZCWMfcI+7H/ZcCB4+N17OjBUvJaBi/VTSBStDcEwJIHaT4hImfvK4+Ni479G4P3kvE+QpliJ5bOcMreUSvOr7GqCoxa54qPjlhKlQ1pl6Zh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=CcPvdKxr; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="CcPvdKxr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1770494697;
	bh=PhdvHKZGV67UryZuMCWlC6ciJo673YhktWOe/es86PM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=CcPvdKxrLfgcXkcgHNf4ELlN1dhOLZtU4YBxnlG9tJGYYBMvvvt6J/diGeuSVCNkL
	 24AOeGp8kPHy/l2SbyxfS9HXJahQdHKjPQQaozrnASbgVpzJwuibGFYM+vHL8rVbH+
	 j0taXAWKm3l1Zym546vyYDBLN2dZXKM/rvFaPq1QTPevknG3idGHZERA52NsnqepG1
	 F4YzB8sTaHVehZ3dlAn9MwFVRNedibxSvlp8t/smwGo7ZDku/Lmo1tr9t2SRlhzQAp
	 JxpDYHj6WEfrnF/nTeZJbDjMM82zcKVNQjVjdnNlsicWOZ3cBdPlI76IUTlPKh2FV6
	 4LJuOtRWMTSr1atOzSjzv42Yunjq2KyZrlu5OoQcJOqCkvw5JlGl5Pf4xvNDol6WmL
	 +zfKstwERVul30YIyRfuPKfbspx3pq8Bp53kBLyVgunkaM1+ZYZtC0AgQyDDhP5gi9
	 xDPRFRwuwjMl0e/5fg6pltY/jpGbJ04NJDWDovIMEYfOTeKS4K+
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9a58:ad83:8db9:6f4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 7F71A231F9;
	Sat,  7 Feb 2026 20:04:57 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 04/16] rust: add a ObjectID struct
Date: Sat,  7 Feb 2026 20:04:34 +0000
Message-ID: <20260207200446.2837699-5-sandals@crustytoothpaste.net>
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

We'd like to be able to write some Rust code that can work with object
IDs.  Add a structure here that's identical to struct object_id in C,
for easy use in sharing across the FFI boundary.  We will use this
structure in several places in hot paths, such as index-pack or
pack-objects when converting between algorithms, so prioritize efficient
interchange over a more idiomatic Rust approach.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Makefile        |  1 +
 src/hash.rs     | 21 +++++++++++++++++++++
 src/lib.rs      |  1 +
 src/meson.build |  1 +
 4 files changed, 24 insertions(+)
 create mode 100644 src/hash.rs

diff --git a/Makefile b/Makefile
index 8aa489f3b6..88ae4c4b2f 100644
--- a/Makefile
+++ b/Makefile
@@ -1545,6 +1545,7 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
 
+RUST_SOURCES += src/hash.rs
 RUST_SOURCES += src/lib.rs
 RUST_SOURCES += src/varint.rs
 
diff --git a/src/hash.rs b/src/hash.rs
new file mode 100644
index 0000000000..0219391820
--- /dev/null
+++ b/src/hash.rs
@@ -0,0 +1,21 @@
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
+pub const GIT_MAX_RAWSZ: usize = 32;
+
+/// A binary object ID.
+#[repr(C)]
+#[derive(Debug, Clone, Ord, PartialOrd, Eq, PartialEq)]
+pub struct ObjectID {
+    pub hash: [u8; GIT_MAX_RAWSZ],
+    pub algo: u32,
+}
diff --git a/src/lib.rs b/src/lib.rs
index 9da70d8b57..cf7c962509 100644
--- a/src/lib.rs
+++ b/src/lib.rs
@@ -1 +1,2 @@
+pub mod hash;
 pub mod varint;
diff --git a/src/meson.build b/src/meson.build
index 25b9ad5a14..c77041a3fa 100644
--- a/src/meson.build
+++ b/src/meson.build
@@ -1,4 +1,5 @@
 libgit_rs_sources = [
+  'hash.rs',
   'lib.rs',
   'varint.rs',
 ]
