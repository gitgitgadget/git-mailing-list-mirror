From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v12 04/15] Refactor quote_path_relative, remove unused params
Date: Sat, 18 May 2013 11:18:56 +0800
Message-ID: <fdbb3acad0dfa2dbf6b558918196567f836034ea.1368846844.git.worldhello.net@gmail.com>
References: <cover.1368846844.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 18 05:19:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdXgT-0004GC-Oc
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 05:19:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447Ab3ERDTf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 23:19:35 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:34072 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932424Ab3ERDTe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 23:19:34 -0400
Received: by mail-pb0-f48.google.com with SMTP id md12so1144983pbc.7
        for <git@vger.kernel.org>; Fri, 17 May 2013 20:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=qz1XD8tZUq+XFO3xCwuKp2m7p0chFUlqd4QzBPgCTXg=;
        b=p37utUy5Nb7t4Q6hCgYJTfr6NXYui+CdQjUtbA9osGI632/re/G0cY5n9tWluwp+v7
         O0WQzSSnaLxEn9MT70pxe0R0mjpyhLvLxN/DlEEW1SP0m5Wo7PRsA5Kli7RFMqm/SzkF
         QA+A6JEHF5d4KMGHlz5Uwicg8zIRZsl+QfJjsDPNC3m7zmIQZpCzRAGaIJYMxN/3D+LY
         3NXhSr2g/+0DwNR2a29seLWGDNZ5VkQaya6TPIcqwdfdp08siNk+K5b5BBWcpVJEU8xG
         sCwr0LEM4ltsbYzDr8PyKqcxM0nIlN6s97i6+socI297MajKAD2W7WfqtaLkGUinnHB3
         1h6g==
X-Received: by 10.66.147.129 with SMTP id tk1mr4151467pab.191.1368847173401;
        Fri, 17 May 2013 20:19:33 -0700 (PDT)
Received: from localhost.localdomain ([114.248.155.144])
        by mx.google.com with ESMTPSA id fn2sm13676683pbc.15.2013.05.17.20.19.30
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 17 May 2013 20:19:32 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.26.g7472058
In-Reply-To: <cover.1368846844.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368846844.git.worldhello.net@gmail.com>
References: <cover.1368782129.git.worldhello.net@gmail.com> <cover.1368846844.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224756>

After substitute path_relative() in quote.c with relative_path() from
path.c, parameters (such as len and prefix_len) are obsolete in function
quote_path_relative(). Remove unused parameters and change the order of
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
1.8.3.rc2.26.g7472058
