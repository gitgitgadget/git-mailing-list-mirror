Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BDEE2023D
	for <e@80x24.org>; Wed, 17 May 2017 02:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752073AbdEQC7j (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 22:59:39 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:34067 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752910AbdEQC73 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 22:59:29 -0400
Received: by mail-pg0-f44.google.com with SMTP id u28so85475048pgn.1
        for <git@vger.kernel.org>; Tue, 16 May 2017 19:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QZzJQLf+5wjYzNyZVL1RrXzscPBgEZpuptk0JhJERbs=;
        b=JosfQd6L9XWRYTK9c+KaAYSstN00xeyIXszbpkeMgvXl4u1Q8DVmV1cJvAvAbWvoxv
         wTM7kBGUeVu9phGK/9SKXaM+anOldHHhfOrDGlxgANAPq8+vffAG4FAmrGQoMkCMte2N
         IRNKcDoEs2c58xlnSI9Nl5Q/l0sUnr44XXFMozvNbg3CELT7chyOhQBRSqWM7GJwypgR
         tjyWdAtVG7EB7h/W6pqnAWluUcUQ4mj1s1UT0t/pGQFwoiy5Di40eDleoMH8NUyIXQkf
         fTqTzGW5rt5hd5Ny7A3ERIsGWev97fyrYEHj+O5DjSL0wa/TDg3qRFGCafvz7E+kSKJJ
         373w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QZzJQLf+5wjYzNyZVL1RrXzscPBgEZpuptk0JhJERbs=;
        b=gSLcMnyd3+Bma0qkENuQRvRIR+VLhtk74I+I4a+ebn9et37N1Av8aQ+FlJqLveOw9C
         tA3znNL3qRGBHRqPYrIgtfsecHX0B08xhVv/KNa3YGds6se333pODcP4xwIDjBPWNZwX
         bVk7K9wDgi6fXFxAOcYH/3zPGRuoRvzYiiAGmS47AhVZ61mL7SE28Zi9wH9ZzbbTKFbt
         RE/CmQa50hf1UU8gI0PKeBgEclLkgj+kuAtFY5TWTT26AMhVK0wubTLiiB0swgIfjupC
         jr8YpCHWb2tQY9FZcGZ3fTBq0DuHQJJwYUb09wQ9ESZaTg68KDPGTjaGz+I8Gq/9ZbAD
         Nnug==
X-Gm-Message-State: AODbwcCdzsBn6tRHmK6LkulZwVDJBl1h3HHktYC/dNDVJcn/rSrut/p9
        zdRKab8AncTL1OKW
X-Received: by 10.99.107.201 with SMTP id g192mr1304773pgc.149.1494989958707;
        Tue, 16 May 2017 19:59:18 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:b4bc:dafd:125e:c48a])
        by smtp.gmail.com with ESMTPSA id y20sm643156pfb.93.2017.05.16.19.59.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 May 2017 19:59:18 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, gitster@pobox.com, jonathantanmy@google.com,
        bmwill@google.com, peff@peff.net, mhagger@alum.mit.edu,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 12/20] submodule.c: convert show_submodule_summary to use emit_line_fmt
Date:   Tue, 16 May 2017 19:58:49 -0700
Message-Id: <20170517025857.32320-13-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170517025857.32320-1-sbeller@google.com>
References: <20170514040117.25865-1-sbeller@google.com>
 <20170517025857.32320-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later patch, I want to propose an option to detect&color
moved lines in a diff, which cannot be done in a one-pass over
the diff. Instead we need to go over the whole diff twice,
because we cannot detect the first line of the two corresponding
lines (+ and -) that got moved.

So to prepare the diff machinery for two pass algorithms
(i.e. buffer it all up and then operate on the result),
move all emissions to places, such that the only emitting
function is emit_line_0.

This prepares the code for submodules to go through the
emit_line function.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c      | 20 +++++++---------
 diff.h      |  5 ++++
 submodule.c | 78 ++++++++++++++++++++++++++++++-------------------------------
 submodule.h |  9 +++----
 4 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/diff.c b/diff.c
index 690794aeb8..7c8d6a5d12 100644
--- a/diff.c
+++ b/diff.c
@@ -516,8 +516,8 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
 	ecbdata->blank_at_eof_in_postimage = (at - l2) + 1;
 }
 
-static void emit_line(struct diff_options *o, const char *set, const char *reset,
-		      int add_line_prefix, int sign, const char *line, int len)
+void emit_line(struct diff_options *o, const char *set, const char *reset,
+	       int add_line_prefix, int sign, const char *line, int len)
 {
 	int has_trailing_newline, has_trailing_carriage_return;
 	FILE *file = o->file;
@@ -547,10 +547,10 @@ static void emit_line(struct diff_options *o, const char *set, const char *reset
 		fputc('\n', file);
 }
 
-static void emit_line_fmt(struct diff_options *o,
-			  const char *set, const char *reset,
-			  int add_line_prefix,
-			  const char *fmt, ...)
+void emit_line_fmt(struct diff_options *o,
+		   const char *set, const char *reset,
+		   int add_line_prefix,
+		   const char *fmt, ...)
 {
 	struct strbuf sb = STRBUF_INIT;
 	va_list ap;
@@ -2386,8 +2386,7 @@ static void builtin_diff(const char *name_a,
 	    (!two->mode || S_ISGITLINK(two->mode))) {
 		const char *del = diff_get_color_opt(o, DIFF_FILE_OLD);
 		const char *add = diff_get_color_opt(o, DIFF_FILE_NEW);
-		show_submodule_summary(o->file, one->path ? one->path : two->path,
-				line_prefix,
+		show_submodule_summary(o, one->path ? one->path : two->path,
 				&one->oid, &two->oid,
 				two->dirty_submodule,
 				meta, del, add, reset);
@@ -2397,11 +2396,10 @@ static void builtin_diff(const char *name_a,
 		   (!two->mode || S_ISGITLINK(two->mode))) {
 		const char *del = diff_get_color_opt(o, DIFF_FILE_OLD);
 		const char *add = diff_get_color_opt(o, DIFF_FILE_NEW);
-		show_submodule_inline_diff(o->file, one->path ? one->path : two->path,
-				line_prefix,
+		show_submodule_inline_diff(o, one->path ? one->path : two->path,
 				&one->oid, &two->oid,
 				two->dirty_submodule,
-				meta, del, add, reset, o);
+				meta, del, add, reset);
 		return;
 	}
 
diff --git a/diff.h b/diff.h
index 5be1ee77a7..6e14100102 100644
--- a/diff.h
+++ b/diff.h
@@ -188,6 +188,11 @@ struct diff_options {
 	int diff_path_counter;
 };
 
+void emit_line_fmt(struct diff_options *o, const char *set, const char *reset,
+		   int add_line_prefix, const char *fmt, ...);
+void emit_line(struct diff_options *o, const char *set, const char *reset,
+	       int add_line_prefix, int sign, const char *line, int len);
+
 enum color_diff {
 	DIFF_RESET = 0,
 	DIFF_CONTEXT = 1,
diff --git a/submodule.c b/submodule.c
index d3299e29c0..5996ebca44 100644
--- a/submodule.c
+++ b/submodule.c
@@ -362,8 +362,8 @@ static int prepare_submodule_summary(struct rev_info *rev, const char *path,
 	return prepare_revision_walk(rev);
 }
 
-static void print_submodule_summary(struct rev_info *rev, FILE *f,
-		const char *line_prefix,
+static void print_submodule_summary(struct rev_info *rev,
+		struct diff_options *o,
 		const char *del, const char *add, const char *reset)
 {
 	static const char format[] = "  %m %s";
@@ -375,18 +375,12 @@ static void print_submodule_summary(struct rev_info *rev, FILE *f,
 		ctx.date_mode = rev->date_mode;
 		ctx.output_encoding = get_log_output_encoding();
 		strbuf_setlen(&sb, 0);
-		strbuf_addstr(&sb, line_prefix);
-		if (commit->object.flags & SYMMETRIC_LEFT) {
-			if (del)
-				strbuf_addstr(&sb, del);
-		}
-		else if (add)
-			strbuf_addstr(&sb, add);
 		format_commit_message(commit, format, &sb, &ctx);
-		if (reset)
-			strbuf_addstr(&sb, reset);
 		strbuf_addch(&sb, '\n');
-		fprintf(f, "%s", sb.buf);
+		if (commit->object.flags & SYMMETRIC_LEFT)
+			emit_line(o, del, reset, 1, 0, sb.buf, sb.len);
+		else if (add)
+			emit_line(o, add, reset, 1, 0, sb.buf, sb.len);
 	}
 	strbuf_release(&sb);
 }
@@ -413,8 +407,7 @@ void prepare_submodule_repo_env(struct argv_array *out)
  * attempt to lookup both the left and right commits and put them into the
  * left and right pointers.
  */
-static void show_submodule_header(FILE *f, const char *path,
-		const char *line_prefix,
+static void show_submodule_header(struct diff_options *o, const char *path,
 		struct object_id *one, struct object_id *two,
 		unsigned dirty_submodule, const char *meta,
 		const char *reset,
@@ -426,11 +419,11 @@ static void show_submodule_header(FILE *f, const char *path,
 	int fast_forward = 0, fast_backward = 0;
 
 	if (dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
-		fprintf(f, "%sSubmodule %s contains untracked content\n",
-			line_prefix, path);
+		emit_line_fmt(o, NULL, NULL, 1,
+			      "Submodule %s contains untracked content\n", path);
 	if (dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
-		fprintf(f, "%sSubmodule %s contains modified content\n",
-			line_prefix, path);
+		emit_line_fmt(o, NULL, NULL, 1,
+			      "Submodule %s contains modified content\n", path);
 
 	if (is_null_oid(one))
 		message = "(new submodule)";
@@ -472,21 +465,20 @@ static void show_submodule_header(FILE *f, const char *path,
 	}
 
 output_header:
-	strbuf_addf(&sb, "%s%sSubmodule %s ", line_prefix, meta, path);
+	strbuf_addf(&sb, "Submodule %s ", path);
 	strbuf_add_unique_abbrev(&sb, one->hash, DEFAULT_ABBREV);
 	strbuf_addstr(&sb, (fast_backward || fast_forward) ? ".." : "...");
 	strbuf_add_unique_abbrev(&sb, two->hash, DEFAULT_ABBREV);
 	if (message)
-		strbuf_addf(&sb, " %s%s\n", message, reset);
+		strbuf_addf(&sb, " %s\n", message);
 	else
-		strbuf_addf(&sb, "%s:%s\n", fast_backward ? " (rewind)" : "", reset);
-	fwrite(sb.buf, sb.len, 1, f);
+		strbuf_addf(&sb, "%s:\n", fast_backward ? " (rewind)" : "");
+	emit_line(o, meta, reset, 1, 0,  sb.buf, sb.len);
 
 	strbuf_release(&sb);
 }
 
-void show_submodule_summary(FILE *f, const char *path,
-		const char *line_prefix,
+void show_submodule_summary(struct diff_options *o, const char *path,
 		struct object_id *one, struct object_id *two,
 		unsigned dirty_submodule, const char *meta,
 		const char *del, const char *add, const char *reset)
@@ -495,7 +487,7 @@ void show_submodule_summary(FILE *f, const char *path,
 	struct commit *left = NULL, *right = NULL;
 	struct commit_list *merge_bases = NULL;
 
-	show_submodule_header(f, path, line_prefix, one, two, dirty_submodule,
+	show_submodule_header(o, path, one, two, dirty_submodule,
 			      meta, reset, &left, &right, &merge_bases);
 
 	/*
@@ -508,11 +500,12 @@ void show_submodule_summary(FILE *f, const char *path,
 
 	/* Treat revision walker failure the same as missing commits */
 	if (prepare_submodule_summary(&rev, path, left, right, merge_bases)) {
-		fprintf(f, "%s(revision walker failed)\n", line_prefix);
+		const char *error = "(revision walker failed)\n";
+		emit_line(o, NULL, NULL, 1, 0, error, strlen(error));
 		goto out;
 	}
 
-	print_submodule_summary(&rev, f, line_prefix, del, add, reset);
+	print_submodule_summary(&rev, o, del, add, reset);
 
 out:
 	if (merge_bases)
@@ -521,20 +514,18 @@ void show_submodule_summary(FILE *f, const char *path,
 	clear_commit_marks(right, ~0);
 }
 
-void show_submodule_inline_diff(FILE *f, const char *path,
-		const char *line_prefix,
+void show_submodule_inline_diff(struct diff_options *o, const char *path,
 		struct object_id *one, struct object_id *two,
 		unsigned dirty_submodule, const char *meta,
-		const char *del, const char *add, const char *reset,
-		const struct diff_options *o)
+		const char *del, const char *add, const char *reset)
 {
 	const struct object_id *old = &empty_tree_oid, *new = &empty_tree_oid;
 	struct commit *left = NULL, *right = NULL;
 	struct commit_list *merge_bases = NULL;
-	struct strbuf submodule_dir = STRBUF_INIT;
 	struct child_process cp = CHILD_PROCESS_INIT;
+	struct strbuf sb = STRBUF_INIT;
 
-	show_submodule_header(f, path, line_prefix, one, two, dirty_submodule,
+	show_submodule_header(o, path, one, two, dirty_submodule,
 			      meta, reset, &left, &right, &merge_bases);
 
 	/* We need a valid left and right commit to display a difference */
@@ -547,15 +538,14 @@ void show_submodule_inline_diff(FILE *f, const char *path,
 	if (right)
 		new = two;
 
-	fflush(f);
 	cp.git_cmd = 1;
 	cp.dir = path;
-	cp.out = dup(fileno(f));
+	cp.out = -1;
 	cp.no_stdin = 1;
 
 	/* TODO: other options may need to be passed here. */
 	argv_array_push(&cp.args, "diff");
-	argv_array_pushf(&cp.args, "--line-prefix=%s", line_prefix);
+	argv_array_pushf(&cp.args, "--line-prefix=%s", diff_line_prefix(o));
 	if (DIFF_OPT_TST(o, REVERSE_DIFF)) {
 		argv_array_pushf(&cp.args, "--src-prefix=%s%s/",
 				 o->b_prefix, path);
@@ -578,11 +568,21 @@ void show_submodule_inline_diff(FILE *f, const char *path,
 		argv_array_push(&cp.args, oid_to_hex(new));
 
 	prepare_submodule_repo_env(&cp.env_array);
-	if (run_command(&cp))
-		fprintf(f, "(diff failed)\n");
+	if (start_command(&cp)) {
+		const char *error = "(diff failed)\n";
+		emit_line(o, NULL, NULL, 1, 0, error, strlen(error));
+	}
+
+	while (strbuf_getwholeline_fd(&sb, cp.out, '\n') != EOF)
+		emit_line(o, NULL, NULL, 1, 0, sb.buf, sb.len);
+
+	if (finish_command(&cp)) {
+		const char *error = "(diff failed)\n";
+		emit_line(o, NULL, NULL, 1, 0, error, strlen(error));
+	}
 
 done:
-	strbuf_release(&submodule_dir);
+	strbuf_release(&sb);
 	if (merge_bases)
 		free_commit_list(merge_bases);
 	if (left)
diff --git a/submodule.h b/submodule.h
index 1277480add..9df0a3aea2 100644
--- a/submodule.h
+++ b/submodule.h
@@ -53,17 +53,14 @@ extern int parse_submodule_update_strategy(const char *value,
 		struct submodule_update_strategy *dst);
 extern const char *submodule_strategy_to_string(const struct submodule_update_strategy *s);
 extern void handle_ignore_submodules_arg(struct diff_options *, const char *);
-extern void show_submodule_summary(FILE *f, const char *path,
-		const char *line_prefix,
+extern void show_submodule_summary(struct diff_options *o, const char *path,
 		struct object_id *one, struct object_id *two,
 		unsigned dirty_submodule, const char *meta,
 		const char *del, const char *add, const char *reset);
-extern void show_submodule_inline_diff(FILE *f, const char *path,
-		const char *line_prefix,
+extern void show_submodule_inline_diff(struct diff_options *o, const char *path,
 		struct object_id *one, struct object_id *two,
 		unsigned dirty_submodule, const char *meta,
-		const char *del, const char *add, const char *reset,
-		const struct diff_options *opt);
+		const char *del, const char *add, const char *reset);
 extern void set_config_fetch_recurse_submodules(int value);
 extern void set_config_update_recurse_submodules(int value);
 /* Check if we want to update any submodule.*/
-- 
2.13.0.18.g7d86cc8ba0

