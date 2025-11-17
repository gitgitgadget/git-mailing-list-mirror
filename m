Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4340734D3A3
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 22:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763417789; cv=none; b=KgakcgWPwuiqX6wRDXXq1V21l1RFLV+fVAbnUbcZT4gsB1INE4gncXrx9ntPW8LlU1mKaYV+QM/qYwXg9LHDZoQpK2xkZ3LEqs3oy0cD2NTEbtviy/EWv5b2M9PqgpzlJbKKnpTbSypISAXKm79Bv+aw5B2C56n9tMa9nOujq5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763417789; c=relaxed/simple;
	bh=GhwWhW8crB2FvV4qMpB4zBEtcm6nmCvCOeiJ3tK02Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCTclouOUKWhVpf9y//sXGPK4pUHRt5GvRlr5T/jAqkYqNrNg/iI2waQoPyjCXimrBhEm8CHuTB7dBYzdNRiOLLtCrWLpfZ0eAS5oR0ZwN0SgMns9ocfjmnLNq7oaV2Q5E/5dXpPwAmZDtxIcxJxvWnMSBMVWYAYi/5dg1Wmwa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=iGC6qed1; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="iGC6qed1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1763417786;
	bh=GhwWhW8crB2FvV4qMpB4zBEtcm6nmCvCOeiJ3tK02Ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=iGC6qed14+M7coVXhWhA+ng50WhKtInPpBkQOTrA5c5Hzd6JK38OTf47n+XMK79yw
	 XJuxJjYAkrTiXPLJlPvFoa5edAT533pKy+Mbah3uh+h+q5beVIsyFYW+rQhfPCh9su
	 XbRwEjSNcpsl1+qr81ARd3KoE899mEpthBSeqR0JbMENFw2Srj8FSp/3AR273OQjXV
	 1Snx/ThoDHMZajMHHAu0rnv6FcpUJKXnH7ZfQaP+DazcDEjb0Vjki47OtnKz4xzHcu
	 gcI3A8ie5PoHhCgJHVeiAqmgVulOb9k2XBsp9PGWRSZV+LQGbgjig+pBwcGypdq9+7
	 h3XsIbQCNBo0gIxrINR64tw8B0dsjggr9Wv6MiFQEDb+f2Ulc7GQLxI+slluXEDAO4
	 5I9Vvaa2Zy330eOIJ1g1fn3tFPGI96t5l35FhSu/th/t6O5nUdlubqL5AroQ+cmX+0
	 esnRtJiEsE6vJGUlE9IyaXOBbYYHD95Fu9QXBaZRGDdmLACRFIX
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:b6c6:bf88:c872:dae4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 1970B25525;
	Mon, 17 Nov 2025 22:16:26 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: [PATCH v2 04/15] rust: add a ObjectID struct
Date: Mon, 17 Nov 2025 22:16:10 +0000
Message-ID: <20251117221621.2863243-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
In-Reply-To: <20251117221621.2863243-1-sandals@crustytoothpaste.net>
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <20251117221621.2863243-1-sandals@crustytoothpaste.net>
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
index 7e0f77e298..e1d0ae3691 100644
--- a/Makefile
+++ b/Makefile
@@ -1534,6 +1534,7 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 
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
