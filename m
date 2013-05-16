From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v10 03/14] Refactor quote_path_relative, remove unused params
Date: Thu, 16 May 2013 17:53:34 +0800
Message-ID: <54ede52ead25b1f3db1c5d026a5bffdca6f23a68.1368696028.git.worldhello.net@gmail.com>
References: <cover.1368696028.git.worldhello.net@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 16 11:54:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcutA-0000qG-Uu
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 11:54:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992Ab3EPJyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 05:54:11 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:45476 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959Ab3EPJyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 05:54:09 -0400
Received: by mail-pa0-f42.google.com with SMTP id bj3so2355376pad.29
        for <git@vger.kernel.org>; Thu, 16 May 2013 02:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=G5Sg/GJthZJVFknoKNY+2ByfO8ygwmuCM792QXp2cYM=;
        b=SdpSkoZmC5f2Ya1Og2ucFmD3KKjQ9kiDRJSfk6wr+91sd4O9v5m06iLV0OVYH3M/GU
         3CvDl3ChftFBnZXB+Zvvuqlb8rDMfWDaBT8eAl5X5I7bipZLohdcI8ftrYh+qEv7ihPG
         kFrCoMz+PnjcjsqB3LYSvBPLecmgTU9ohdsDmQ3bRA+P4E0gfRdus1cqPOmYL9e/ytSJ
         2vIgbqSdzqc/oRyoTwK0QwDMJ0ZxcjCunbfKYw6yZeZ8piMfEhnIYtOHnHeZGMZIJ5kU
         DVBnUDBqyQFeD/rrrdfpb3itbZmf7oSbVjKCrWlAw14Vi3dxazesz8JqwybaA0WBuGjB
         6Hsg==
X-Received: by 10.66.149.170 with SMTP id ub10mr42913740pab.58.1368698048301;
        Thu, 16 May 2013 02:54:08 -0700 (PDT)
Received: from localhost.localdomain ([114.248.153.37])
        by mx.google.com with ESMTPSA id cd2sm6183092pbd.35.2013.05.16.02.54.05
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 16 May 2013 02:54:07 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.407.g762149a
In-Reply-To: <cover.1368696028.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368696028.git.worldhello.net@gmail.com>
References: <cover.1368696028.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224532>

After substitude path_relative() in quote.c with relative_path() from
path.c, parameters (such as len and prefix_len) are obsolte in function
quote_path_relative(). Remove unused parameters and the order of
parameters for quote_path_relative() function.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/clean.c    | 18 +++++++++---------
 builtin/grep.c     |  5 ++---
 builtin/ls-files.c |  2 +-
 quote.c            |  7 ++-----
 quote.h            |  4 ++--
 wt-status.c        | 17 ++++++++---------
 6 files changed, 24 insertions(+), 29 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 04e39..f77f95 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -56,7 +56,7 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 	if ((force_flag & REMOVE_DIR_KEEP_NESTED_GIT) &&
 			!resolve_gitlink_ref(path->buf, "HEAD", submodule_head)) {
 		if (!quiet) {
-			quote_path_relative(path->buf, strlen(path->buf), &quoted, prefix);
+			quote_path_relative(path->buf, prefix, &quoted);
 			printf(dry_run ?  _(msg_would_skip_git_dir) : _(msg_skip_git_dir),
 					quoted.buf);
 		}
@@ -70,7 +70,7 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 		/* an empty dir could be removed even if it is unreadble */
 		res = dry_run ? 0 : rmdir(path->buf);
 		if (res) {
-			quote_path_relative(path->buf, strlen(path->buf), &quoted, prefix);
+			quote_path_relative(path->buf, prefix, &quoted);
 			warning(_(msg_warn_remove_failed), quoted.buf);
 			*dir_gone = 0;
 		}
@@ -94,7 +94,7 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 			if (remove_dirs(path, prefix, force_flag, dry_run, quiet, &gone))
 				ret = 1;
 			if (gone) {
-				quote_path_relative(path->buf, strlen(path->buf), &quoted, prefix);
+				quote_path_relative(path->buf, prefix, &quoted);
 				string_list_append(&dels, quoted.buf);
 			} else
 				*dir_gone = 0;
@@ -102,10 +102,10 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 		} else {
 			res = dry_run ? 0 : unlink(path->buf);
 			if (!res) {
-				quote_path_relative(path->buf, strlen(path->buf), &quoted, prefix);
+				quote_path_relative(path->buf, prefix, &quoted);
 				string_list_append(&dels, quoted.buf);
 			} else {
-				quote_path_relative(path->buf, strlen(path->buf), &quoted, prefix);
+				quote_path_relative(path->buf, prefix, &quoted);
 				warning(_(msg_warn_remove_failed), quoted.buf);
 				*dir_gone = 0;
 				ret = 1;
@@ -127,7 +127,7 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 		if (!res)
 			*dir_gone = 1;
 		else {
-			quote_path_relative(path->buf, strlen(path->buf), &quoted, prefix);
+			quote_path_relative(path->buf, prefix, &quoted);
 			warning(_(msg_warn_remove_failed), quoted.buf);
 			*dir_gone = 0;
 			ret = 1;
@@ -262,7 +262,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 				if (remove_dirs(&directory, prefix, rm_flags, dry_run, quiet, &gone))
 					errors++;
 				if (gone && !quiet) {
-					qname = quote_path_relative(directory.buf, directory.len, &buf, prefix);
+					qname = quote_path_relative(directory.buf, prefix, &buf);
 					printf(dry_run ? _(msg_would_remove) : _(msg_remove), qname);
 				}
 			}
@@ -272,11 +272,11 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 				continue;
 			res = dry_run ? 0 : unlink(ent->name);
 			if (res) {
-				qname = quote_path_relative(ent->name, -1, &buf, prefix);
+				qname = quote_path_relative(ent->name, prefix, &buf);
 				warning(_(msg_warn_remove_failed), qname);
 				errors++;
 			} else if (!quiet) {
-				qname = quote_path_relative(ent->name, -1, &buf, prefix);
+				qname = quote_path_relative(ent->name, prefix, &buf);
 				printf(dry_run ? _(msg_would_remove) : _(msg_remove), qname);
 			}
 		}
diff --git a/builtin/grep.c b/builtin/grep.c
index 159e65..a419c 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -286,8 +286,7 @@ static int grep_sha1(struct grep_opt *opt, const unsigned char *sha1,
 	struct strbuf pathbuf = STRBUF_INIT;
 
 	if (opt->relative && opt->prefix_length) {
-		quote_path_relative(filename + tree_name_len, -1, &pathbuf,
-				    opt->prefix);
+		quote_path_relative(filename + tree_name_len, opt->prefix, &pathbuf);
 		strbuf_insert(&pathbuf, 0, filename, tree_name_len);
 	} else {
 		strbuf_addstr(&pathbuf, filename);
@@ -318,7 +317,7 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 	struct strbuf buf = STRBUF_INIT;
 
 	if (opt->relative && opt->prefix_length)
-		quote_path_relative(filename, -1, &buf, opt->prefix);
+		quote_path_relative(filename, opt->prefix, &buf);
 	else
 		strbuf_addstr(&buf, filename);
 
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 220207..00f07 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -389,7 +389,7 @@ int report_path_error(const char *ps_matched, const char **pathspec, const char
 		if (found_dup)
 			continue;
 
-		name = quote_path_relative(pathspec[num], -1, &sb, prefix);
+		name = quote_path_relative(pathspec[num], prefix, &sb);
 		error("pathspec '%s' did not match any file(s) known to git.",
 		      name);
 		errors++;
diff --git a/quote.c b/quote.c
index 64ff3..ebb8 100644
--- a/quote.c
+++ b/quote.c
@@ -325,8 +325,8 @@ void write_name_quoted_relative(const char *name, size_t len,
 }
 
 /* quote path as relative to the given prefix */
-char *quote_path_relative(const char *in, int len,
-			  struct strbuf *out, const char *prefix)
+char *quote_path_relative(const char *in, const char *prefix,
+			  struct strbuf *out)
 {
 	struct strbuf sb = STRBUF_INIT;
 	const char *rel = relative_path(in, prefix, &sb);
@@ -334,9 +334,6 @@ char *quote_path_relative(const char *in, int len,
 	quote_c_style_counted(rel, strlen(rel), out, NULL, 0);
 	strbuf_release(&sb);
 
-	if (!out->len)
-		strbuf_addstr(out, "./");
-
 	return out->buf;
 }
 
diff --git a/quote.h b/quote.h
index 13315..5610159 100644
--- a/quote.h
+++ b/quote.h
@@ -65,8 +65,8 @@ extern void write_name_quoted_relative(const char *name, size_t len,
 		FILE *fp, int terminator);
 
 /* quote path as relative to the given prefix */
-extern char *quote_path_relative(const char *in, int len,
-			  struct strbuf *out, const char *prefix);
+extern char *quote_path_relative(const char *in, const char *prefix,
+			  struct strbuf *out);
 
 /* quoting as a string literal for other languages */
 extern void perl_quote_print(FILE *stream, const char *src);
diff --git a/wt-status.c b/wt-status.c
index bf84a..ef0fc 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -243,7 +243,7 @@ static void wt_status_print_unmerged_data(struct wt_status *s,
 	struct strbuf onebuf = STRBUF_INIT;
 	const char *one, *how = _("bug");
 
-	one = quote_path(it->string, -1, &onebuf, s->prefix);
+	one = quote_path(it->string, s->prefix, &onebuf);
 	status_printf(s, color(WT_STATUS_HEADER, s), "\t");
 	switch (d->stagemask) {
 	case 1: how = _("both deleted:"); break;
@@ -297,8 +297,8 @@ static void wt_status_print_change_data(struct wt_status *s,
 		    change_type);
 	}
 
-	one = quote_path(one_name, -1, &onebuf, s->prefix);
-	two = quote_path(two_name, -1, &twobuf, s->prefix);
+	one = quote_path(one_name, s->prefix, &onebuf);
+	two = quote_path(two_name, s->prefix, &twobuf);
 
 	status_printf(s, color(WT_STATUS_HEADER, s), "\t");
 	switch (status) {
@@ -706,8 +706,7 @@ static void wt_status_print_other(struct wt_status *s,
 		struct string_list_item *it;
 		const char *path;
 		it = &(l->items[i]);
-		path = quote_path(it->string, strlen(it->string),
-				  &buf, s->prefix);
+		path = quote_path(it->string, s->prefix, &buf);
 		if (column_active(s->colopts)) {
 			string_list_append(&output, path);
 			continue;
@@ -1289,7 +1288,7 @@ static void wt_shortstatus_unmerged(struct string_list_item *it,
 	} else {
 		struct strbuf onebuf = STRBUF_INIT;
 		const char *one;
-		one = quote_path(it->string, -1, &onebuf, s->prefix);
+		one = quote_path(it->string, s->prefix, &onebuf);
 		printf(" %s\n", one);
 		strbuf_release(&onebuf);
 	}
@@ -1317,7 +1316,7 @@ static void wt_shortstatus_status(struct string_list_item *it,
 		struct strbuf onebuf = STRBUF_INIT;
 		const char *one;
 		if (d->head_path) {
-			one = quote_path(d->head_path, -1, &onebuf, s->prefix);
+			one = quote_path(d->head_path, s->prefix, &onebuf);
 			if (*one != '"' && strchr(one, ' ') != NULL) {
 				putchar('"');
 				strbuf_addch(&onebuf, '"');
@@ -1326,7 +1325,7 @@ static void wt_shortstatus_status(struct string_list_item *it,
 			printf("%s -> ", one);
 			strbuf_release(&onebuf);
 		}
-		one = quote_path(it->string, -1, &onebuf, s->prefix);
+		one = quote_path(it->string, s->prefix, &onebuf);
 		if (*one != '"' && strchr(one, ' ') != NULL) {
 			putchar('"');
 			strbuf_addch(&onebuf, '"');
@@ -1345,7 +1344,7 @@ static void wt_shortstatus_other(struct string_list_item *it,
 	} else {
 		struct strbuf onebuf = STRBUF_INIT;
 		const char *one;
-		one = quote_path(it->string, -1, &onebuf, s->prefix);
+		one = quote_path(it->string, s->prefix, &onebuf);
 		color_fprintf(s->fp, color(WT_STATUS_UNTRACKED, s), "%s", sign);
 		printf(" %s\n", one);
 		strbuf_release(&onebuf);
-- 
1.8.3.rc1.407.g762149a
