Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE0830EF71
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 00:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761526437; cv=none; b=hJI1XGMSbVZEPrApPTvAiL4wPB9bsqqU0nXQqqsR+qTz/ykauYtlOIfm2sr/HlGIKh/3U7k20s/o9rF48OxwJt2mQxtv/6P/GyraBagui/OS/oqIK7XKYchxGyFYZbsTjsNsPc4Qh981HGHVDzU0WtJaXxA5CTAhEasX7M2KhZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761526437; c=relaxed/simple;
	bh=sKbTeKQ6MTkfkLxB4xf2/F8zXYUOz7F6CzObi78jvgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QzqA576UGxOI/esOUeUni1nZY8uo9S6rGKRnfz0e/EQFyO2nHvj2Zox2ZCJJDtIJQd1YBIzZpzQzniZZGuxFc6RNEuUvDlxrZJHo4ZB+Te2AYSQhaEaxyA2BYc2h4zZ3MntL4r+7+YF8fCCBpVoWoIMkz2VJjOoLltLm3iT6RIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=MxDAwVRb; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="MxDAwVRb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1761525867;
	bh=sKbTeKQ6MTkfkLxB4xf2/F8zXYUOz7F6CzObi78jvgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=MxDAwVRb0vjhdDPGTQa9ZkFA+KfMi6FzuhP98oIeIcnuMkDBExEPW7FNYjUzl4QfM
	 6EN3RtMH9MWS6xmpa9o5T32RLaSdCdGUM9dGsWpklr8RLyj89URMzYJMVKKe0kUm51
	 WCtnkxVaEIotmK3/rU/pPNab7TPm6JcQ64YilW1/CO3J53OANe9qIcpEjHah0nbS3P
	 FeFHfsV5V9rY+agFIwH9p9FVr+WN3WOxjKPqi8x8qOUPNl2vNcB9+NgqglqquUsqxf
	 fHom6ewt3IN+ierwzXbxeXYxoiLWRBPAZozdEfpu1aPXE+dHJ71xbqyRYKBfJExLHm
	 DTx4FWjMnigkk09jm3uOAySfIm4mD5EARP2o/hfZhu6EyJcj+P/nQcvaUeACP+Djb9
	 zXQZFjB/FL51IPEEy/nrOHi/JRwTaDIKP10b/TheCtydpMnO69r926kQsb2CuAu7AY
	 XGb74xMDQ9DUyB/QHMoVHO+kewcdqflEESZBhFebAXU65GmEKay
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:5675:b769:afe:3fa2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id A4D9D2019A;
	Mon, 27 Oct 2025 00:44:27 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: [PATCH 04/14] rust: add a ObjectID struct
Date: Mon, 27 Oct 2025 00:43:54 +0000
Message-ID: <20251027004404.2152927-5-sandals@crustytoothpaste.net>
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

We'd like to be able to write some Rust code that can work with object
IDs.  Add a structure here that's identical to struct object_id in C.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Makefile        |  1 +
 src/hash.rs     | 21 +++++++++++++++++++++
 src/lib.rs      |  1 +
 src/meson.build |  1 +
 4 files changed, 24 insertions(+)
 create mode 100644 src/hash.rs

diff --git a/Makefile b/Makefile
index 1919d35bf3..7e5a735ca6 100644
--- a/Makefile
+++ b/Makefile
@@ -1521,6 +1521,7 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 
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
