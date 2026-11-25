Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795630814;
	b=nMCDkpH8Tpr9yNGu0MzzkDiuN4b8IUp2KV6g3ba/hLJ1dYtyYkPyJ9hH6ADlczmkg8pU
	 0WajgOmMTyhFzJuNPVlGk7OSUJpSS/j0+iZ4lzAcBZNZ90AJ1/d4xZ6i3ozDhw8okLw6Y
	 0BG0p71xRN3qXdYgGYMFfWxJb62gPyCLv9aqcLjKddDzlaC1jnasUWKQhsuedMUQgH4ow
	 ESc/Xt2WBjgfmubDLO+1A2rPm+2RdA5NXvuaSssf/bW751R/JDN03pGYsMvaO+4BD0Cnp
	 oedYopJlEeh35zkXzB/88+lTc8uoGwCJOfZ8xQWM5MK4E6q6MZDBhXFPxYWKTYgTn5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630814;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Tfoex84X7qgFaiZEEKLOTc7x8KG2x8MDO0MXh54qWng=;
	b=gAoaL6X1DqAEtw1vyOptGNxMi8tfG9WFEtHPg8ff+Fgez3oNtUeaTkG/XAc5QTivcizH
	 NiywwbZ0Y/NtDz0hQV4MmcxL6Z6ms0jQWIbstB7im8LUK+A3MsZc+bE/BgdRsEL2URpqU
	 9GlCOheynPBJ+zKexwvd4VjMG77I58YUAr6+w7PP0wPWD18onZa/VD+23smo8ZGfEzwqi
	 tyec3j8fhN1W19QGWSgDhu6WLLwdenelS197Sahak0u8SbSZX4Ak2vuuGbffko9f09YKy
	 VWVPORKowEHLohsCtnaA9qFFI3+6LnJ+HqSK+vPReEZba1Up9vxwWOQlojYQh0XKq+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=aTAsMVzl;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE4E606A327
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 18:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DE4E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=aTAsMVzl
Received: from lena.gouders.net (ip-109-41-50-35.web.vodafone.de [109.41.50.35])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6APIJxx52481769
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 25 Nov 2026 19:20:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795630808; bh=Tfoex84X7qgFaiZEEKLOTc7x8KG2x8MDO0MXh54qWng=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aTAsMVzl7/7qZZUf1OGXMgU6sSx/w+L4HNAZuqAAiL9jTvhKaxl2q4b/jKD+TI0y/
	 Tvcj2bRmIOVDdlzBJRv9ABi3CJxuMOpksdoZ6Uhsdkiz1m+K8c+JNiNYCiFS2/2J8C
	 F+W0lVaiaKbrd23B9akvU7LejVSPjJSeodG+BulI=
From: Dirk Gouders <dirk@gouders.net>
Date: Wed, 25 Nov 2026 19:19:43 +0100
Subject: [PATCH v6 3/4] utf8: respect string boundaries after skipping ANSI
 escape sequences
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-master-v6-3-cb60af83d189@gouders.net>
References: <20261125-master-v6-0-cb60af83d189@gouders.net>
In-Reply-To: <20261125-master-v6-0-cb60af83d189@gouders.net>
To: git@vger.kernel.org
Cc: "Junio C Hamano <gitster@pobox.com>, Andy Koppe" <andy.koppe@gmail.com>,
        Dirk Gouders <dirk@gouders.net>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3646; i=dirk@gouders.net;
 h=from:subject:message-id; bh=tJeR4AflWLeOGVQacNk4M7kHVbuIYjL7H8h6jeovdf4=;
 b=owGbwMvMwMW4JPzVNXNTrzmMp9WSGLLZ1a5KlIrkmnTsf7g5bz5z9gVG5UVFz4ReX3rzWfDC3
 usPXXfpdDJOYGFg5GKoElNkWTqpyC5NZcWLsm+qmTCDWJlApkiLNDAAAQsDX25iXqmRjpGeqbah
 niGQoWPkAJHjZ9BIL0h3SM8vTUktKtbLSy1xNLU0MjcydjUzMzJxtHC1MDdzMzMyNbN0NDE1d3V
 0MTM2NzY1cbR0ZuDiFIBZF+bJwbDAUUBcRWHVrrN7g7ZZzNhc7iUqf5pFdIJzn9DR+vb0lz/iFW
 sVoquT4s8+C+hdplsevLp2/tJTsb7TKtTZmKdnLeQ9Yn1zUt5i/qLe3b7b5yltOXmt9uPX1X9kz
 z+r+XCM+f7ikEC2xd1PvF/+CuWcWJH7LVKLlzvgccyv1ZKx76ccY5jqb8bZbBl30tXfbMbmXpWD
 e5P5b2uWXeosS37RuiE1cv1UBxXDkvt+8n/epRzNfbb23qNfsaeUH686e3PnYYYpBw38BD+3yhr
 Nc2c3l9yQlDPzffvaOc/P+wdcPXVc0PqRe60J343mrT01BTt2nD8lIl5w65jvCf8HBcdWy4otTZ
 Q85rCIeY2wbB8A
X-Developer-Key: i=dirk@gouders.net; a=openpgp;
 fpr=943B4FA3CAB8EBC55754E5EA0DA2395F431875F6

utf8_strnwidth() can skip ANSI escape sequences and it is possible
that such sequences end the string within the given boundary.

For example, if the escape sequence "\033[31m" of length 5 bytes is
             part of a string

                  "\033[31mdon't touch me"
                   ^       ^
                   |       |
                   0       5

and this is passed to utf8_strnwidth(), len arguments that limit the
length of the string near the end of the escape sequence are
interesting:

len = 4: in this case, display_mode_esc_sequence_len_counted() will
         return 0, because it inspects an incomplete sequence
         "\033[31" (the 'm' is missing).
         utf8_strnwidth() will then accumulate the widths of all four
         characters in "\033[31" which will be 3, because "\033" has
         width 0.  Correct.

len = 5: in this case, display_mode_esc_sequence_len_counted() returns
         5, because it detects a valid sequence and the string pointer
         is advanced to "dont't touch me".

         Here, we should be done with the loop but this string is then
         passed to utf8_width() before the loop can be exited.
         utf8_width() sees a character 'd' (outside of the given
         bound) of width 1.

         1 is returned for a string that should result in width 0.

len = 6: in this case, display_mode_esc_sequence_len_counted() also
         returns the length of the escape sequence but this time, one
         byte ('d') of the string is left for width calculation and 1
         is returned which also is correct.

And, the situation can be very different from the example; we never
know what exactly is at or beyond string[len].

Check for such situations before proceeding and calling utf8_width().

Add tests that test such corner cases.

Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
 t/unit-tests/u-utf8-width.c | 17 +++++++++++++++++
 utf8.c                      | 12 ++++++++----
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/t/unit-tests/u-utf8-width.c b/t/unit-tests/u-utf8-width.c
index 86e09c3574..4b6aa621ea 100644
--- a/t/unit-tests/u-utf8-width.c
+++ b/t/unit-tests/u-utf8-width.c
@@ -2,6 +2,23 @@
 #include "utf8.h"
 #include "strbuf.h"
 
+/*
+ * TODO: When the interfaces of utf8_strwidth and utf8_strnwidth are fixed to
+ * return `size_t`, cl_assert_equal_u must be used instead of
+ * cl_assert_equal_i, for the tests.
+ */
+
+/*
+ * Test utf8_strnwidth for strings with SGR sequences and corner case length
+ * arguments.
+ */
+void test_utf8_width__strnwidth_ansi(void)
+{
+	cl_assert_equal_i(3, utf8_strnwidth("\033[31mhello", 4, 1));
+	cl_assert_equal_i(0, utf8_strnwidth("\033[31mhello", 5, 1));
+	cl_assert_equal_i(1, utf8_strnwidth("\033[31mhello", 6, 1));
+}
+
 /*
  * Test utf8_strnwidth with various Chinese strings
  * Chinese characters typically have a width of 2 columns when displayed
diff --git a/utf8.c b/utf8.c
index 92c3bf29d1..87d32f8bcd 100644
--- a/utf8.c
+++ b/utf8.c
@@ -230,10 +230,14 @@ int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
 		int glyph_width;
 		size_t skip;
 
-		while (skip_ansi &&
-		       (skip = display_mode_esc_sequence_len_counted(string,
-							orig + len - string)) != 0)
-			string += skip;
+		if (skip_ansi) {
+			while ((skip = display_mode_esc_sequence_len_counted(string,
+									     orig + len - string)))
+				string += skip;
+
+			if (string >= orig + len)
+				break;
+		}
 
 		glyph_width = utf8_width(&string, NULL);
 		if (glyph_width > 0)

-- 
2.55.0

