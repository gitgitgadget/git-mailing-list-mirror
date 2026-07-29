Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5A23DB64E
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 23:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785367941; cv=none; b=Kem5DAWN3eaIYMKseCsRtz8Tj7jgjHWHNU3bgqVilho5xdzfFg2m0Q2TLhE60MX7qA4SXw9ZkW6EgUmLoo88gDkIRw8c5WJGDZjxsXD+vdZMMmR+Qo7Oqc0d6mmDwwEFpkJ9EviFyjaOj978dAqnhhGwj4zAJZ6fqCmVvK1wcgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785367941; c=relaxed/simple;
	bh=ELqe+EbtNs4I8jqNSs1yllNDkMrAF3XUs38LpzVtQVY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KF/S7ESyitazgkKrXpBZ0/Vcsuy33CRahJx/fIzBulvP4SzW2nfVhjfCJyMWn7EUakrJydFqAmz3flVToAr81hXAnOhJMUEwNdg1dtwVOqgd0PwlcNUOefFxQvIlmuicRPOsMD0HI+b/q01EpzmJQ+qe3EJFHpDDCo4qnEE/4XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=CjbdoXRs; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="CjbdoXRs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1785367938;
	bh=ELqe+EbtNs4I8jqNSs1yllNDkMrAF3XUs38LpzVtQVY=;
	h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
	 Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
	 References:Content-Type:Content-Disposition;
	b=CjbdoXRsc4yM0WjjexGFklcapb+PjaVs751sZ6gvtRF4ONABde2l6JozKB7P4S2oz
	 tuOhht5yyo06jTgZlCfz2zxTY/KhWDw+E6fGxAW6au0kFF+q9wchVaOPeksVMN0TlY
	 IW9P2NaFlszsYWv9D7N8yjqkGr3mueiCH4PPxhDkkQgy5/+EpdBCFIbRRaRXR4mMeh
	 7oPs7wOHpy0Qo3VBdwfhzr/aaKogAFVC0DX5/c8uWWXvC9pzQxZRwvUCqdtLUaVuHb
	 RXerZVvddejbbBHTAW3oC0yCiFBGozYD3g0iKMi/BmMOC0XAqgctRiAE5ZfHYWvEKz
	 RGu0O0OuzA4MJ49XEA5k6by8vBTzTP0R3xe60s85JzD9ahECp7qZA1dZRfRaynCPNO
	 TaPKV38MGKTt+cK62p74/ZBNn8aoPFz92SUSmOOmzM/d7jpAW5JEgUd2T8V+a2ijIl
	 1n4zJCCxqmS3Ls3/TM+9q57Vk8XYP0LxBwutTBYaZ3t4ZXPsGzx
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:c292:4852:9051:fdce])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 9EDCA20192
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 23:32:18 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Subject: [RFC PATCH 2/6] hex: allow specifying hex type with hex2chr
Date: Wed, 29 Jul 2026 23:32:11 +0000
Message-ID: <20260729233215.398654-3-sandals@crustytoothpaste.net>
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

We have several places where we use hex2chr.  One of those is parsing
object IDs, but others decode quoted-printable or percent encoding.  All
of them accept both uppercase and lowercase hex.

In a future commit, we'll change some of these cases, so make hex2chr
accept the kind of encoding to use: lowercase only hex or any kind of
hex.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 hex-ll.h     | 6 +++---
 hex.c        | 2 +-
 mailinfo.c   | 2 +-
 ref-filter.c | 2 +-
 strbuf.c     | 2 +-
 url.c        | 2 +-
 urlmatch.c   | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/hex-ll.h b/hex-ll.h
index da1b5239b2..26847c7b2f 100644
--- a/hex-ll.h
+++ b/hex-ll.h
@@ -17,10 +17,10 @@ static inline unsigned int hexval(unsigned char c, enum hexkind kind)
  * Convert two consecutive hexadecimal digits into a char.  Return a
  * negative value on error.  Don't run over the end of short strings.
  */
-static inline int hex2chr(const char *s)
+static inline int hex2chr(const char *s, enum hexkind kind)
 {
-	unsigned int val = hexval(s[0], HEX_KIND_MIXED);
-	return (val & ~0xf) ? val : (val << 4) | hexval(s[1], HEX_KIND_MIXED);
+	unsigned int val = hexval(s[0], kind);
+	return (val & ~0xf) ? val : (val << 4) | hexval(s[1], kind);
 }
 
 /*
diff --git a/hex.c b/hex.c
index f02832140d..6150bdcbf8 100644
--- a/hex.c
+++ b/hex.c
@@ -9,7 +9,7 @@ static int get_hash_hex_algop(const char *hex, unsigned char *hash,
 			      const struct git_hash_algo *algop)
 {
 	for (size_t i = 0; i < algop->rawsz; i++) {
-		int val = hex2chr(hex);
+		int val = hex2chr(hex, HEX_KIND_MIXED);
 		if (val < 0)
 			return -1;
 		*hash++ = val;
diff --git a/mailinfo.c b/mailinfo.c
index 13949ff31e..85c3119048 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -396,7 +396,7 @@ static int decode_q_segment(struct strbuf *out, const struct strbuf *q_seg,
 			int ch, d = *in;
 			if (d == '\n' || !d)
 				break; /* drop trailing newline */
-			ch = hex2chr(in);
+			ch = hex2chr(in, HEX_KIND_MIXED);
 			if (ch >= 0) {
 				strbuf_addch(out, ch);
 				in += 2;
diff --git a/ref-filter.c b/ref-filter.c
index 29aca08ce7..884bcd8fc5 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -3567,7 +3567,7 @@ static void append_literal(const char *cp, const char *ep, struct ref_formatting
 			if (cp[1] == '%')
 				cp++;
 			else {
-				int ch = hex2chr(cp + 1);
+				int ch = hex2chr(cp + 1, HEX_KIND_MIXED);
 				if (0 <= ch) {
 					strbuf_addch(s, ch);
 					cp += 3;
diff --git a/strbuf.c b/strbuf.c
index 44955669e8..88d23f8ac5 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -457,7 +457,7 @@ size_t strbuf_expand_literal(struct strbuf *sb, const char *placeholder)
 		return 1;
 	case 'x':
 		/* %x00 == NUL, %x0a == LF, etc. */
-		ch = hex2chr(placeholder + 1);
+		ch = hex2chr(placeholder + 1, HEX_KIND_MIXED);
 		if (ch < 0)
 			return 0;
 		strbuf_addch(sb, ch);
diff --git a/url.c b/url.c
index a59818278f..b4d72f784a 100644
--- a/url.c
+++ b/url.c
@@ -62,7 +62,7 @@ static char *url_decode_internal(const char **query, int len,
 		}
 
 		if (c == '%' && (len < 0 || len >= 3)) {
-			int val = hex2chr(q + 1);
+			int val = hex2chr(q + 1, HEX_KIND_MIXED);
 			if (0 < val) {
 				strbuf_addch(out, val);
 				q += 3;
diff --git a/urlmatch.c b/urlmatch.c
index 20bc2d009c..989f1d794b 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -50,7 +50,7 @@ static int append_normalized_escapes(struct strbuf *buf,
 		if (ch == '%') {
 			if (from_len < 2)
 				return 0;
-			ch = hex2chr(from);
+			ch = hex2chr(from, HEX_KIND_MIXED);
 			if (ch < 0)
 				return 0;
 			from += 2;
