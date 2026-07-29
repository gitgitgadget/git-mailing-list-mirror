Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977423E00BE
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 23:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785367941; cv=none; b=BXNHJ+BF5Nv10t6LQWwpN9XCJfOLzT5AQ6Dz4ymyj1/vSr81vTJqYiektyNC5X3wnu4QmaG4xi/neVY2wv8uv4AGX4tXZz6n5YfgOTVZqdqnDu+eQpS03QvLDaSOXg23K1QKAOQ+SkcvFG4bAEgoT3xk63fyrm/CQVycbElGD7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785367941; c=relaxed/simple;
	bh=JvPvZ4XucGL9yZGARIV3iowxllQ8XkSj6a0viZ+zlEk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d1ka/9s0Oys8Sxih2HpnseKkZEaKgkAbm+uM7SA+XoytaTXWPEWtonVKHcSXYW4aA72DnADxR/7YXsK0K/ERsTU27JrpEgN81J2KoS79jlQgxdA6v6tJ1MXnfMIawpDwf7XsR7+ImKIDJR4AA/xYEdiE+fYwKkrNxmVmibxjIFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=mn5HsA1i; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="mn5HsA1i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1785367938;
	bh=JvPvZ4XucGL9yZGARIV3iowxllQ8XkSj6a0viZ+zlEk=;
	h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
	 Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
	 References:Content-Type:Content-Disposition;
	b=mn5HsA1iJ0cOzraeC1SldJQtppOLIBLUC74z5u3upaJEJCJJONF9vYymtqlIeaFbM
	 JHsMFKzQ5Q5gWe4CZVhzC+xRl7LyHlw8DBSz5hz+QgzXBTsKWOhBEhmYuODgSpXyZT
	 wCLseeR2tBhY0spAYCIPBlJI4qWZ7nt7tbvgBZb+dfMgmcuURVB9dA6wD6tMxib7mt
	 EzZj/zo3MggtFEZXNgX6tWSEVXvJMhMb31u2tS06K0BljXuMYi5iLeVXHoBvYFyGn2
	 s72nVgJc/ujAwn8ASLuokib+bJJ+MADlmVMx04WI8s08z1QnQh17lzhlbakH53MPCG
	 Suo5xalAKZg3wrGt+ja9h6MSHEjKP5MpwHKIVnEjEBUUXcsIntEh1SFjHQTikN/RZe
	 it6yXNYpcN3dnqzobZHtY71RuwniF2B5dakZLiWynJvj2Pr1mm8Bkxq1bHiFBDTr+t
	 EIbBq90dNtkIk7V+os63XlUKSPz0qfbldCQ6j9C134Er7MeigaK
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:c292:4852:9051:fdce])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 9946B2010E
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 23:32:18 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Subject: [RFC PATCH 1/6] hex: add functionality for lowercase-only hex
Date: Wed, 29 Jul 2026 23:32:10 +0000
Message-ID: <20260729233215.398654-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.53.0.697.g625c4fb2daa
In-Reply-To: <20260729233215.398654-1-sandals@crustytoothpaste.net>
References: <20260729233215.398654-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We currently allow both upper and lower case for all hex values in Git.
However, in a future commit, we'll want to change that to allow only
lowercase values in some cases.  To prepare for that case, provide a
table to convert hex values using lowercase only and an enum to let us
choose which we want, wiring it up to the hexval function.

For now, keep things completely the same by specifying only the
variant that accepts both lowercase and uppercase to avoid changing
behavior.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 color.c    |  2 +-
 hex-ll.c   | 37 ++++++++++++++++++++++++++++++++++++-
 hex-ll.h   | 14 ++++++++++----
 pkt-line.c |  8 ++++----
 4 files changed, 51 insertions(+), 10 deletions(-)

diff --git a/color.c b/color.c
index 00b53f97ac..9015d0faf1 100644
--- a/color.c
+++ b/color.c
@@ -72,7 +72,7 @@ static int get_hex_color(const char **inp, int width, unsigned char *out)
 	unsigned int val;
 
 	assert(width == 1 || width == 2);
-	val = (hexval(in[0]) << 4) | hexval(in[width - 1]);
+	val = (hexval(in[0], HEX_KIND_MIXED) << 4) | hexval(in[width - 1], HEX_KIND_MIXED);
 	if (val & ~0xff)
 		return -1;
 	*inp += width;
diff --git a/hex-ll.c b/hex-ll.c
index 4d7ece1de5..fa85e91827 100644
--- a/hex-ll.c
+++ b/hex-ll.c
@@ -36,10 +36,45 @@ const signed char hexval_table[256] = {
 	 -1, -1, -1, -1, -1, -1, -1, -1,		/* f8-ff */
 };
 
+const signed char hexval_lc_table[256] = {
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 00-07 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 08-0f */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 10-17 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 18-1f */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 20-27 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 28-2f */
+	  0,  1,  2,  3,  4,  5,  6,  7,		/* 30-37 */
+	  8,  9, -1, -1, -1, -1, -1, -1,		/* 38-3f */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 40-47 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 48-4f */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 50-57 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 58-5f */
+	 -1, 10, 11, 12, 13, 14, 15, -1,		/* 60-67 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 68-67 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 70-77 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 78-7f */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 80-87 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 88-8f */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 90-97 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 98-9f */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* a0-a7 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* a8-af */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* b0-b7 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* b8-bf */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* c0-c7 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* c8-cf */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* d0-d7 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* d8-df */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* e0-e7 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* e8-ef */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* f0-f7 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* f8-ff */
+};
+
 int hex_to_bytes(unsigned char *binary, const char *hex, size_t len)
 {
 	for (; len; len--, hex += 2) {
-		unsigned int val = (hexval(hex[0]) << 4) | hexval(hex[1]);
+		unsigned int val = (hexval(hex[0], HEX_KIND_MIXED) << 4) | hexval(hex[1], HEX_KIND_MIXED);
 
 		if (val & ~0xff)
 			return -1;
diff --git a/hex-ll.h b/hex-ll.h
index a381fa8556..da1b5239b2 100644
--- a/hex-ll.h
+++ b/hex-ll.h
@@ -1,10 +1,16 @@
 #ifndef HEX_LL_H
 #define HEX_LL_H
 
+enum hexkind {
+	HEX_KIND_MIXED = 0,
+	HEX_KIND_LOWER = 1,
+};
+
 extern const signed char hexval_table[256];
-static inline unsigned int hexval(unsigned char c)
+extern const signed char hexval_lc_table[256];
+static inline unsigned int hexval(unsigned char c, enum hexkind kind)
 {
-	return hexval_table[c];
+	return kind == HEX_KIND_MIXED ? hexval_table[c] : hexval_lc_table[c];
 }
 
 /*
@@ -13,8 +19,8 @@ static inline unsigned int hexval(unsigned char c)
  */
 static inline int hex2chr(const char *s)
 {
-	unsigned int val = hexval(s[0]);
-	return (val & ~0xf) ? val : (val << 4) | hexval(s[1]);
+	unsigned int val = hexval(s[0], HEX_KIND_MIXED);
+	return (val & ~0xf) ? val : (val << 4) | hexval(s[1], HEX_KIND_MIXED);
 }
 
 /*
diff --git a/pkt-line.c b/pkt-line.c
index 3fc3e9ea70..338075558c 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -378,10 +378,10 @@ int packet_length(const char lenbuf_hex[4], size_t size)
 {
 	if (size < 4)
 		BUG("buffer too small");
-	return	hexval(lenbuf_hex[0]) << 12 |
-		hexval(lenbuf_hex[1]) <<  8 |
-		hexval(lenbuf_hex[2]) <<  4 |
-		hexval(lenbuf_hex[3]);
+	return	hexval(lenbuf_hex[0], HEX_KIND_MIXED) << 12 |
+		hexval(lenbuf_hex[1], HEX_KIND_MIXED) <<  8 |
+		hexval(lenbuf_hex[2], HEX_KIND_MIXED) <<  4 |
+		hexval(lenbuf_hex[3], HEX_KIND_MIXED);
 }
 
 static const char *find_packfile_uri_path(const char *buffer)
