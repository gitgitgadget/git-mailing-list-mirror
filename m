From: santiago@nyu.edu
Subject: [PATCH v3 4/4] tag: use pgp_verify_function in tag -v call
Date: Sat,  2 Apr 2016 19:16:15 -0400
Message-ID: <1459638975-17705-5-git-send-email-santiago@nyu.edu>
References: <1459638975-17705-1-git-send-email-santiago@nyu.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Santiago Torres <santiago@nyu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 01:17:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amUmy-0004ZP-5m
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 01:17:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbcDBXQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2016 19:16:59 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33668 "EHLO
	mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbcDBXQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2016 19:16:57 -0400
Received: by mail-qk0-f193.google.com with SMTP id d3so738168qke.0
        for <git@vger.kernel.org>; Sat, 02 Apr 2016 16:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RD+NennceD26BfXPlSjqjYxvLbBz/Wxgr1xMZDkz/NM=;
        b=gPslFzYs8e3K1TTCQ3HBhBTTnhO7hZHYo0MjHlcScGSo8+PDEEUoOvKGhrQS4KedqR
         ipnIrfndfM8GjX5bIIfEq7KWIOoMyMrRKoJtZiJXffxqin68RMfJ8HJR28BEon99errd
         gSK+QXwTdC7Z9+ISdI5gwpODmEkMJJdlFjdeUyxji64j40Eo3NJevbLceukvV+OgjQhe
         1peRbvfvFgxY5FJW2ULU4pXAVoiueqEV4rkhqTH/lqHoedl4F5LmFm78XormW+D0R0/b
         /8YUPy1nVGs0tDztG1YlFjMXzrhQs6IYIffHyHFQ/6pgBGtTBvHJuLrDq9l1JH16Qkrb
         YcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RD+NennceD26BfXPlSjqjYxvLbBz/Wxgr1xMZDkz/NM=;
        b=SJRR4sj/5cqSL2VWNu0GAQc61z/Kh0awU9W8pHUmIfOwugjY+GLw1cNAwJQgI6cd5Z
         3ko+Pc6a6aZPXghUVzkZwFOrGy0I+UnFUxZJZSb1o91kUdu4MjzXr9Kp/v/KQWfnKD16
         fJ+pkyp6/z4EfnIaL5UGNwuv1rtUlRbC9sZYJEmQusipS+kn03wEeJ8gXOiEbXR8mNcB
         ifnVWxY3RSlDbCZ786jTOr/xXi/IBN2CNX+8lWpkGBhY9ZVgC/uPsimcz3ZriLeprxGX
         0TU3xCiM0uWStskKwOd29rXa7WKlC0LiL/LSDtbbUx20sLW++rz0PbU0m6xtJs9OuVhr
         BDxQ==
X-Gm-Message-State: AD7BkJJAYQ/Yx0h1F/ATN09Dj3ZqRVrcqG4rFRN8hWN/hsv6ajJQALKT7ertPoM/PLQrCQnz
X-Received: by 10.55.72.67 with SMTP id v64mr8908903qka.101.1459639016242;
        Sat, 02 Apr 2016 16:16:56 -0700 (PDT)
Received: from LykOS.localdomain ([2604:2000:8183:da00:b6b6:76ff:fe46:8151])
        by smtp.gmail.com with ESMTPSA id l33sm9199788qge.11.2016.04.02.16.16.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 02 Apr 2016 16:16:55 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1459638975-17705-1-git-send-email-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290612>

From: Santiago Torres <santiago@nyu.edu>

Instead of running the verify-tag plumbing command, we use the
pgp_verify_tag(). This avoids the usage of an extra fork call. To do
this, we extend the number of parameters that tag.c takes, and
verify-tag passes. Redundant calls done in the pgp_verify_tag function
are removed.

Signed-off-by: Santiago Torres <santiago@nyu.edu>
---
 Notes:
 - In this version I fixed the issues with the brackets (the old patch
   doesn't work in this case due to the new test.

 builtin/tag.c        | 28 +++++++++-------------------
 builtin/verify-tag.c | 14 ++++++++++++--
 tag.c                |  7 ++-----
 tag.h                |  3 ++-
 4 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 1705c94..3dffdff 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -65,9 +65,10 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, con
 }
 
 typedef int (*each_tag_name_fn)(const char *name, const char *ref,
-				const unsigned char *sha1);
+				const unsigned char *sha1, unsigned flags);
 
-static int for_each_tag_name(const char **argv, each_tag_name_fn fn)
+static int for_each_tag_name(const char **argv, each_tag_name_fn fn,
+		unsigned flags)
 {
 	const char **p;
 	char ref[PATH_MAX];
@@ -86,33 +87,21 @@ static int for_each_tag_name(const char **argv, each_tag_name_fn fn)
 			had_error = 1;
 			continue;
 		}
-		if (fn(*p, ref, sha1))
+		if (fn(*p, ref, sha1, flags))
 			had_error = 1;
 	}
 	return had_error;
 }
 
 static int delete_tag(const char *name, const char *ref,
-				const unsigned char *sha1)
+				const unsigned char *sha1, unsigned flags)
 {
-	if (delete_ref(ref, sha1, 0))
+	if (delete_ref(ref, sha1, flags))
 		return 1;
 	printf(_("Deleted tag '%s' (was %s)\n"), name, find_unique_abbrev(sha1, DEFAULT_ABBREV));
 	return 0;
 }
 
-static int verify_tag(const char *name, const char *ref,
-				const unsigned char *sha1)
-{
-	const char *argv_verify_tag[] = {"verify-tag",
-					"-v", "SHA1_HEX", NULL};
-	argv_verify_tag[2] = sha1_to_hex(sha1);
-
-	if (run_command_v_opt(argv_verify_tag, RUN_GIT_CMD))
-		return error(_("could not verify the tag '%s'"), name);
-	return 0;
-}
-
 static int do_sign(struct strbuf *buffer)
 {
 	return sign_buffer(buffer, buffer, get_signing_key());
@@ -424,9 +413,10 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (filter.merge_commit)
 		die(_("--merged and --no-merged option are only allowed with -l"));
 	if (cmdmode == 'd')
-		return for_each_tag_name(argv, delete_tag);
+		return for_each_tag_name(argv, delete_tag, 0);
 	if (cmdmode == 'v')
-		return for_each_tag_name(argv, verify_tag);
+		return for_each_tag_name(argv, pgp_verify_tag,
+				GPG_VERIFY_VERBOSE);
 
 	if (msg.given || msgfile) {
 		if (msg.given && msgfile)
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index f776778..8abc357 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -30,6 +30,8 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 {
 	int i = 1, verbose = 0, had_error = 0;
 	unsigned flags = 0;
+	unsigned char sha1[20];
+	const char *name;
 	const struct option verify_tag_options[] = {
 		OPT__VERBOSE(&verbose, N_("print tag contents")),
 		OPT_BIT(0, "raw", &flags, N_("print raw gpg status output"), GPG_VERIFY_RAW),
@@ -46,8 +48,16 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 	if (verbose)
 		flags |= GPG_VERIFY_VERBOSE;
 
-	while (i < argc)
-		if (pgp_verify_tag(argv[i++], flags))
+	while (i < argc) {
+		name = argv[i++];
+		if (get_sha1(name, sha1)) {
+			error("tag '%s' not found.", name);
 			had_error = 1;
+		}
+
+		if (pgp_verify_tag(name, NULL, sha1, flags))
+			had_error = 1;
+
+	}
 	return had_error;
 }
diff --git a/tag.c b/tag.c
index 918ae39..2a0b24c 100644
--- a/tag.c
+++ b/tag.c
@@ -29,18 +29,15 @@ static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
 	return ret;
 }
 
-int pgp_verify_tag(const char *name, unsigned flags)
+int pgp_verify_tag(const char *name, const char *ref,
+		const unsigned char *sha1, unsigned flags)
 {
 
 	enum object_type type;
 	unsigned long size;
-	unsigned char sha1[20];
 	char* buf;
 	int ret;
 
-	if (get_sha1(name, sha1))
-		return error("tag '%s' not found.", name);
-
 	type = sha1_object_info(sha1, NULL);
 	if (type != OBJ_TAG)
 		return error("%s: cannot verify a non-tag object of type %s.",
diff --git a/tag.h b/tag.h
index 09e71f9..22289a5 100644
--- a/tag.h
+++ b/tag.h
@@ -17,6 +17,7 @@ extern int parse_tag_buffer(struct tag *item, const void *data, unsigned long si
 extern int parse_tag(struct tag *item);
 extern struct object *deref_tag(struct object *, const char *, int);
 extern struct object *deref_tag_noverify(struct object *);
-extern int pgp_verify_tag(const char *name, unsigned flags);
+extern int pgp_verify_tag(const char *name, const char *ref,
+		const unsigned char *sha1, unsigned flags);
 
 #endif /* TAG_H */
-- 
2.8.0
