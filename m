Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0234B1F6BF
	for <e@80x24.org>; Sat,  3 Sep 2016 16:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753975AbcICQBK (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Sep 2016 12:01:10 -0400
Received: from mout.web.de ([212.227.17.11]:60342 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753471AbcICQBG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Sep 2016 12:01:06 -0400
Received: from [192.168.178.36] ([79.237.54.191]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MAMpq-1bmEhV0P7K-00BfiO; Sat, 03 Sep 2016 17:59:23
 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] introduce hex2chr() for converting two hexadecimal digits to
 a character
Message-ID: <ac454d89-e1cc-083e-5cea-fc9751de9a0f@web.de>
Date:   Sat, 3 Sep 2016 17:59:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:yWZhmJjoTog41rAKyQmkIiTbY0wdgBd25o1T+FHU5T/uMWTzeJC
 f3avWwtQro4r1LrBscALp2xZ0SjWiFKT2/6xIM1W63lq+8NOtlA5QZQil0LwKzDy9dbQPLF
 mNbNYm3+gIVuXvI5G2cYMhCxqLnxX63DkMNJ+4rrjKfIK9NCBVhlK7sLEz0mZ3okliMH5VY
 Xh6/kj+xYaFwrmU1CDV+Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jg5IBFOBzPQ=:AxVy78JnHFc1Im+WT8YNi8
 dgbbYPJCQrtiEetQVo2K0k+CD5FphZf+GjqXAdcgGsy10B/uclVFD0pGjqmpxgtrAiBES5jR+
 QjmTG027LUuVRTHzb1+OvdOzVydl8ZhuDRWe20rPLPhOfCtZfRI70caaG/MTyzzYXF8mETmS6
 sJTvwpwtjFGb7G2Dm6zryAntGQ05Zmiy5cueGAObTRBF6EROobp5AK84vzvDRvbAjC4NfLUlW
 idwO7onbu6rIYNjnLXPsZ+SwhvsrMpbzWMEJ1ao/8FaEk+LtHFwMwNv87a6J4QthnKw5tPD+0
 lhKJNCxGPA4cDwb/oWENKvr6RMy6TRqfVFs9IgggCiIo3gVEUy8MGhvPGu8woQMblcLmlkrLi
 aZo2q96XbQIzSxVXhXh/PpufjMGozD6QUpQkzFZcJC9o9DqsY4dwbsF+Zx+/fnCMNO4TZI2gP
 3ANKmd61g4S8AD9k7VqUTS9iG54jyINzkqzZ6TZ0vjDjvP/VJ5RHX8xVPcsXQfR0FIia2zKZx
 y2Yo605UvLY87i3jArWIH9PrYfVg8y901EH6RHFlQJMWEaJ3YqDobVT+cxIv2qrj2Fwa5rsqD
 0GcUzxbVe284KVfkLfbK0ihd+zqEAol1+tGw+ZlZY3SQQ8r4yF6tgBD9JqyRYVb29lbpUxadC
 JU95W3Pq0HW261MbV8JSJbHkTqarsvXOt8pzvIX1IgN0VlRN108irN1lIqGMlw7mgveRpOci3
 6MobgEO6is1rRqhtN1OddaM2e4u6RQf7X7du5SfDLkXXuEwhRsWfBIC5yO0cwH78ytfVBiE4I
 i/rUJ9b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add and use a helper function that decodes the char value of two
hexadecimal digits.  It returns a negative number on error, avoids
running over the end of the given string and doesn't shift negative
values.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 cache.h      | 10 ++++++++++
 hex.c        | 12 ++----------
 pkt-line.c   | 23 ++---------------------
 pretty.c     | 13 +++++--------
 ref-filter.c | 20 +-------------------
 url.c        | 21 +--------------------
 6 files changed, 21 insertions(+), 78 deletions(-)

diff --git a/cache.h b/cache.h
index b780a91..b0dae4b 100644
--- a/cache.h
+++ b/cache.h
@@ -1139,6 +1139,16 @@ static inline unsigned int hexval(unsigned char c)
 	return hexval_table[c];
 }
 
+/*
+ * Convert two consecutive hexadecimal digits into a char.  Return a
+ * negative value on error.  Don't run over the end of short strings.
+ */
+static inline int hex2chr(const char *s)
+{
+	int val = hexval(s[0]);
+	return (val < 0) ? val : (val << 4) | hexval(s[1]);
+}
+
 /* Convert to/from hex/sha1 representation */
 #define MINIMUM_ABBREV minimum_abbrev
 #define DEFAULT_ABBREV default_abbrev
diff --git a/hex.c b/hex.c
index 9619b67..ab2610e 100644
--- a/hex.c
+++ b/hex.c
@@ -39,16 +39,8 @@ int get_sha1_hex(const char *hex, unsigned char *sha1)
 {
 	int i;
 	for (i = 0; i < GIT_SHA1_RAWSZ; i++) {
-		unsigned int val;
-		/*
-		 * hex[1]=='\0' is caught when val is checked below,
-		 * but if hex[0] is NUL we have to avoid reading
-		 * past the end of the string:
-		 */
-		if (!hex[0])
-			return -1;
-		val = (hexval(hex[0]) << 4) | hexval(hex[1]);
-		if (val & ~0xff)
+		int val = hex2chr(hex);
+		if (val < 0)
 			return -1;
 		*sha1++ = val;
 		hex += 2;
diff --git a/pkt-line.c b/pkt-line.c
index 62fdb37..30489c6 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -172,27 +172,8 @@ static int get_packet_data(int fd, char **src_buf, size_t *src_size,
 
 static int packet_length(const char *linelen)
 {
-	int n;
-	int len = 0;
-
-	for (n = 0; n < 4; n++) {
-		unsigned char c = linelen[n];
-		len <<= 4;
-		if (c >= '0' && c <= '9') {
-			len += c - '0';
-			continue;
-		}
-		if (c >= 'a' && c <= 'f') {
-			len += c - 'a' + 10;
-			continue;
-		}
-		if (c >= 'A' && c <= 'F') {
-			len += c - 'A' + 10;
-			continue;
-		}
-		return -1;
-	}
-	return len;
+	int val = hex2chr(linelen);
+	return (val < 0) ? val : (val << 8) | hex2chr(linelen + 2);
 }
 
 int packet_read(int fd, char **src_buf, size_t *src_len,
diff --git a/pretty.c b/pretty.c
index 9609afb..9788bd8 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1065,7 +1065,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 	const struct commit *commit = c->commit;
 	const char *msg = c->message;
 	struct commit_list *p;
-	int h1, h2;
+	int ch;
 
 	/* these are independent of the commit */
 	switch (placeholder[0]) {
@@ -1089,14 +1089,11 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		return 1;
 	case 'x':
 		/* %x00 == NUL, %x0a == LF, etc. */
-		if (0 <= (h1 = hexval_table[0xff & placeholder[1]]) &&
-		    h1 <= 16 &&
-		    0 <= (h2 = hexval_table[0xff & placeholder[2]]) &&
-		    h2 <= 16) {
-			strbuf_addch(sb, (h1<<4)|h2);
-			return 3;
-		} else
+		ch = hex2chr(placeholder + 1);
+		if (ch < 0)
 			return 0;
+		strbuf_addch(sb, ch);
+		return 3;
 	case 'w':
 		if (placeholder[1] == '(') {
 			unsigned long width = 0, indent1 = 0, indent2 = 0;
diff --git a/ref-filter.c b/ref-filter.c
index bc551a7..9adbb8a 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1576,24 +1576,6 @@ void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
 	qsort(array->items, array->nr, sizeof(struct ref_array_item *), compare_refs);
 }
 
-static int hex1(char ch)
-{
-	if ('0' <= ch && ch <= '9')
-		return ch - '0';
-	else if ('a' <= ch && ch <= 'f')
-		return ch - 'a' + 10;
-	else if ('A' <= ch && ch <= 'F')
-		return ch - 'A' + 10;
-	return -1;
-}
-static int hex2(const char *cp)
-{
-	if (cp[0] && cp[1])
-		return (hex1(cp[0]) << 4) | hex1(cp[1]);
-	else
-		return -1;
-}
-
 static void append_literal(const char *cp, const char *ep, struct ref_formatting_state *state)
 {
 	struct strbuf *s = &state->stack->output;
@@ -1603,7 +1585,7 @@ static void append_literal(const char *cp, const char *ep, struct ref_formatting
 			if (cp[1] == '%')
 				cp++;
 			else {
-				int ch = hex2(cp + 1);
+				int ch = hex2chr(cp + 1);
 				if (0 <= ch) {
 					strbuf_addch(s, ch);
 					cp += 3;
diff --git a/url.c b/url.c
index 2d89ad1..eaf4f07 100644
--- a/url.c
+++ b/url.c
@@ -29,25 +29,6 @@ int is_url(const char *url)
 	return (url[0] == ':' && url[1] == '/' && url[2] == '/');
 }
 
-static int url_decode_char(const char *q)
-{
-	int i;
-	unsigned char val = 0;
-	for (i = 0; i < 2; i++) {
-		unsigned char c = *q++;
-		val <<= 4;
-		if (c >= '0' && c <= '9')
-			val += c - '0';
-		else if (c >= 'a' && c <= 'f')
-			val += c - 'a' + 10;
-		else if (c >= 'A' && c <= 'F')
-			val += c - 'A' + 10;
-		else
-			return -1;
-	}
-	return val;
-}
-
 static char *url_decode_internal(const char **query, int len,
 				 const char *stop_at, struct strbuf *out,
 				 int decode_plus)
@@ -66,7 +47,7 @@ static char *url_decode_internal(const char **query, int len,
 		}
 
 		if (c == '%') {
-			int val = url_decode_char(q + 1);
+			int val = hex2chr(q + 1);
 			if (0 <= val) {
 				strbuf_addch(out, val);
 				q += 3;
-- 
2.10.0

