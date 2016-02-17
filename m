From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 00/11] ref-filter: use parsing functions
Date: Wed, 17 Feb 2016 23:36:08 +0530
Message-ID: <1455732379-22479-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 19:05:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW6Tt-0006eI-LC
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 19:05:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423425AbcBQSFh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 13:05:37 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34823 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423145AbcBQSFg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 13:05:36 -0500
Received: by mail-pa0-f44.google.com with SMTP id ho8so15543900pac.2
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 10:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=qVq8OlKTeBXnQcMZNEe3K6rpHc76TVsUCuHHyAZR3XI=;
        b=FjI4bFRKyLiS1iFziSS9Quq5gMT73trRwBAkOWa5uFwFpQA3YIyHRVswTVhDub1ux8
         zrerXj695Cnds3bZSBd/ydQF7E7Zah+0SrS+nXfVv+98xyJQn5MRRh3HbkwGxYNHA8WE
         7Wdvi8JcBeCa4IhvBvH4EDuHPUA176EmHJu3UEuYDm+jT3V9DwXx9HoOJqox2nDCUYA6
         9soaAamqXY7WIxRrnBdTK0OJIA7uoIMvyPepUY4wAMZTYORR7oe2mOuhU+bsb6ufEZsb
         H6SUT4fohhz8Ym9Cb/jy7+svU9elCMMtBvC0cr3em6BJA9FGGYtxcXCxAYw2qJF9MeA6
         L8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qVq8OlKTeBXnQcMZNEe3K6rpHc76TVsUCuHHyAZR3XI=;
        b=LRsxjpxg12LyE11w2PQelwMt2r/uacjbADwAZ1kCs/0VMKLxSJABIrkcYJJBauJP2s
         +ydahG86pebK6nvLKEILhBQM9iOS/87RWyyBL+soHJRepkgIQNC4StcrvHKwF/rzRhSk
         n8Rf5wGeb49LR7qXnSsrElrV2/55GCu3pmFVzMwdW1VaPHHzlL5lsMfd550HiZ9YLSIF
         AkIYRDA1wLFvlEH7ahVsxxFXdPzSrGXIYgaex786eTnD1mJ3Y0fAuwplyyjMQAk/7lAS
         ua08y9v1z04taAk6vjA/fbeA/tun0FOD2rs1+w5wHhi7Dh1RFtlYn3YqPuRoemQNTaI4
         flTQ==
X-Gm-Message-State: AG10YOTFeaXZHnIpHjTlucMtllMEgIu5qeo/Gry0AZTvQn6ANTUWlVr2WC+mgWhBjcJj+Q==
X-Received: by 10.66.118.7 with SMTP id ki7mr3957483pab.153.1455732336578;
        Wed, 17 Feb 2016 10:05:36 -0800 (PST)
Received: from ashley.localdomain ([106.51.133.38])
        by smtp.gmail.com with ESMTPSA id cf6sm4105793pad.41.2016.02.17.10.05.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Feb 2016 10:05:35 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286518>

This series cleans up populate_value() in ref-filter, by moving out
the parsing part of atoms to separate parsing functions. This ensures
that parsing is only done once and also improves the modularity of the
code.

v1: http://thread.gmane.org/gmane.comp.version-control.git/281180
v2: http://thread.gmane.org/gmane.comp.version-control.git/282563
v3: http://thread.gmane.org/gmane.comp.version-control.git/283350
v4: http://thread.gmane.org/gmane.comp.version-control.git/285158
v5: http://thread.gmane.org/gmane.comp.version-control.git/286414

Changes:
* As per Jeff's suggestion ($gmane/286425) we drop creation and
usage of strbuf_split_str_omit_term() and use string_list_split()
instead.

Jeff King (1):
  ref-filter: use string_list_split over strbuf_split

Karthik Nayak (10):
  ref-filter: bump 'used_atom' and related code to the top
  ref-filter: introduce struct used_atom
  ref-filter: introduce parsing functions for each valid atom
  ref-filter: introduce color_atom_parser()
  ref-filter: introduce parse_align_position()
  ref-filter: introduce align_atom_parser()
  ref-filter: align: introduce long-form syntax
  ref-filter: introduce remote_ref_atom_parser()
  ref-filter: introduce contents_atom_parser()
  ref-filter: introduce objectname_atom_parser()

 Documentation/git-for-each-ref.txt |  20 +-
 ref-filter.c                       | 434 +++++++++++++++++++++----------------
 t/t6302-for-each-ref-filter.sh     |  42 ++++
 3 files changed, 304 insertions(+), 192 deletions(-)

Interdiff:

diff --git a/ref-filter.c b/ref-filter.c
index 21f4937..d13d002 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -127,18 +127,19 @@ static align_type parse_align_position(const char *s)
 static void align_atom_parser(struct used_atom *atom, const char *arg)
 {
 	struct align *align = &atom->u.align;
-	struct strbuf **v, **to_free;
+	struct string_list params = STRING_LIST_INIT_DUP;
+	int i;
 	unsigned int width = ~0U;
 
 	if (!arg)
 		die(_("expected format: %%(align:<width>,<position>)"));
-	v = to_free = strbuf_split_str_omit_term(arg, ',', 0);
 
 	align->position = ALIGN_LEFT;
 
-	while (*v) {
+	string_list_split(&params, arg, ',', -1);
+	for (i = 0; i < params.nr; i++) {
+		const char *s = params.items[i].string;
 		int position;
-		const char *s = v[0]->buf;
 
 		if (skip_prefix(s, "position=", &s)) {
 			position = parse_align_position(s);
@@ -154,13 +155,12 @@ static void align_atom_parser(struct used_atom *atom, const char *arg)
 			align->position = position;
 		else
 			die(_("unrecognized %%(align) argument: %s"), s);
-		v++;
 	}
 
 	if (width == ~0U)
 		die(_("positive width expected with the %%(align) atom"));
 	align->width = width;
-	strbuf_list_free(to_free);
+	string_list_clear(&params, 0);
 }
 
 static struct {
diff --git a/strbuf.c b/strbuf.c
index 4a93e2a..bab316d 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -115,7 +115,7 @@ void strbuf_tolower(struct strbuf *sb)
 }
 
 struct strbuf **strbuf_split_buf(const char *str, size_t slen,
-				 int terminator, int max, int omit_term)
+				 int terminator, int max)
 {
 	struct strbuf **ret = NULL;
 	size_t nr = 0, alloc = 0;
@@ -123,18 +123,14 @@ struct strbuf **strbuf_split_buf(const char *str, size_t slen,
 
 	while (slen) {
 		int len = slen;
-		int copylen = len;
-		const char *end = NULL;
 		if (max <= 0 || nr + 1 < max) {
-			end = memchr(str, terminator, slen);
-			if (end) {
+			const char *end = memchr(str, terminator, slen);
+			if (end)
 				len = end - str + 1;
-				copylen = len - !!omit_term;
-			}
 		}
 		t = xmalloc(sizeof(struct strbuf));
-		strbuf_init(t, copylen);
-		strbuf_add(t, str, copylen);
+		strbuf_init(t, len);
+		strbuf_add(t, str, len);
 		ALLOC_GROW(ret, nr + 2, alloc);
 		ret[nr++] = t;
 		str += len;
diff --git a/strbuf.h b/strbuf.h
index 6115e72..f72fd14 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -466,12 +466,11 @@ static inline int strbuf_strip_suffix(struct strbuf *sb, const char *suffix)
 /**
  * Split str (of length slen) at the specified terminator character.
  * Return a null-terminated array of pointers to strbuf objects
- * holding the substrings.  If omit_term is true, the terminator will
- * be stripped from all substrings. Otherwise, substrings will include
- * the terminator, except for the final substring, if the original
- * string lacked a terminator.  If max is positive, then split the
- * string into at most max substrings (with the last substring
- * containing everything following the (max-1)th terminator
+ * holding the substrings.  The substrings include the terminator,
+ * except for the last substring, which might be unterminated if the
+ * original string did not end with a terminator.  If max is positive,
+ * then split the string into at most max substrings (with the last
+ * substring containing everything following the (max-1)th terminator
  * character).
  *
  * The most generic form is `strbuf_split_buf`, which takes an arbitrary
@@ -482,25 +481,19 @@ static inline int strbuf_strip_suffix(struct strbuf *sb, const char *suffix)
  * For lighter-weight alternatives, see string_list_split() and
  * string_list_split_in_place().
  */
-extern struct strbuf **strbuf_split_buf(const char *str, size_t slen,
-					int terminator, int max, int omit_term);
-
-static inline struct strbuf **strbuf_split_str_omit_term(const char *str,
-							    int terminator, int max)
-{
-	return strbuf_split_buf(str, strlen(str), terminator, max, 1);
-}
+extern struct strbuf **strbuf_split_buf(const char *, size_t,
+					int terminator, int max);
 
 static inline struct strbuf **strbuf_split_str(const char *str,
 					       int terminator, int max)
 {
-	return strbuf_split_buf(str, strlen(str), terminator, max, 0);
+	return strbuf_split_buf(str, strlen(str), terminator, max);
 }
 
 static inline struct strbuf **strbuf_split_max(const struct strbuf *sb,
 						int terminator, int max)
 {
-	return strbuf_split_buf(sb->buf, sb->len, terminator, max, 0);
+	return strbuf_split_buf(sb->buf, sb->len, terminator, max);
 }
 
 static inline struct strbuf **strbuf_split(const struct strbuf *sb,


-- 
2.7.1
