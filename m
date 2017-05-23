Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20EB22023D
	for <e@80x24.org>; Tue, 23 May 2017 02:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936012AbdEWClY (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 22:41:24 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36150 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965509AbdEWClN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 22:41:13 -0400
Received: by mail-pf0-f181.google.com with SMTP id m17so99602458pfg.3
        for <git@vger.kernel.org>; Mon, 22 May 2017 19:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fXxoHdDsPqZp5/OPjuc/Msfd1V4oPzqr9xJla2aaUlU=;
        b=QX7Lat4Q8uP9wBPFm0cLtFdZga+eBS1w9QCflShjbRjQ4g38Hskp2MMKEE6kKq4yLQ
         g2RKnbHmqjazU12QAaeYUfyfWaWC4FalMwN47xNA+hiipn1XglahfjKy4ApYWf/0vAvB
         31IhT5Vha3rYNGkpoO91XreJDTnw/7du6K1GHj8zdCPpvmmudYebObZWCppDgWYfiOVW
         fXzxRPygvPhmYF/3k1a2Y9P401SdXVsD1xc5A1Kc9oH+jN1nmlEAsyAJF+rutJi81mpP
         wa6efzB2OFARWpn80SYsy3keMWxPrQ7tg8bAqkVmUMpMz9wUiKAL21UXhA9Xa1RLrOwF
         Gb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fXxoHdDsPqZp5/OPjuc/Msfd1V4oPzqr9xJla2aaUlU=;
        b=PejxTfIjDshk+Vju1y67Y55iGnKWYvzKKBAs9YEsLVGneMlFLhpt4R5iPp1VG2yq2F
         I8sEGGHcv+je3FO+Bmaw8XN3Hud82b0rQ4wK9g6Y5rYftdJd/NO30cTjzgdiquw4h+tp
         6BPQ4MOICIfHXDXfqYNaDO1IfE6+s65f06HZNMvHr0yuMoS9YY7/oNA9l9Qso2ld5Qry
         AkJ78wgZ5gHJmkfUXroNSFJXcnZ6Xr+tsPuf4Ah02d2CBd3EccbyAwzb5RYfrQ9GfzCr
         abO6FzYJkEemgA99W+Vy6BD1lrsGx9ut2p5Lxc9PGQY76AXr6lNgfnvRfwOMh5ugOLoO
         Hy5w==
X-Gm-Message-State: AODbwcBZPGbP4zAOf6NHSKcPjDnh3E3o8p2s09UzJlEyaT4SjevoOxxd
        B3jUFZOZne1kueE30jjdjQ==
X-Received: by 10.84.173.195 with SMTP id p61mr32962499plb.83.1495507272675;
        Mon, 22 May 2017 19:41:12 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:6dc1:8d70:6f8f:1c2a])
        by smtp.gmail.com with ESMTPSA id p76sm32342224pfa.53.2017.05.22.19.41.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 22 May 2017 19:41:11 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        jonathantanmy@google.com, peff@peff.net, mhagger@alum.mit.edu,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 09/17] submodule.c: convert show_submodule_summary to use emit_line_fmt
Date:   Mon, 22 May 2017 19:40:40 -0700
Message-Id: <20170523024048.16879-10-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170523024048.16879-1-sbeller@google.com>
References: <20170518193746.486-1-sbeller@google.com>
 <20170523024048.16879-1-sbeller@google.com>
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

As the submodule process is no longer attached to the
same stdout as the superprojects process we need to
pass on the usage of colors explicitly.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c      | 14 ++++++----
 diff.h      |  3 +++
 submodule.c | 89 +++++++++++++++++++++++++++++++++----------------------------
 submodule.h |  9 +++----
 4 files changed, 63 insertions(+), 52 deletions(-)

diff --git a/diff.c b/diff.c
index ca6b48cf49..3357c0fca3 100644
--- a/diff.c
+++ b/diff.c
@@ -562,6 +562,12 @@ static void emit_line_fmt(struct diff_options *o,
 	strbuf_release(&sb);
 }
 
+void diff_emit_line(struct diff_options *o, const char *set, const char *reset,
+		    const char *line, int len)
+{
+	emit_line(o, set, reset, 1, 0, line, len);
+}
+
 static int new_blank_line_at_eof(struct emit_callback *ecbdata, const char *line, int len)
 {
 	if (!((ecbdata->ws_rule & WS_BLANK_AT_EOF) &&
@@ -2384,8 +2390,7 @@ static void builtin_diff(const char *name_a,
 	    (!two->mode || S_ISGITLINK(two->mode))) {
 		const char *del = diff_get_color_opt(o, DIFF_FILE_OLD);
 		const char *add = diff_get_color_opt(o, DIFF_FILE_NEW);
-		show_submodule_summary(o->file, one->path ? one->path : two->path,
-				line_prefix,
+		show_submodule_summary(o, one->path ? one->path : two->path,
 				&one->oid, &two->oid,
 				two->dirty_submodule,
 				meta, del, add, reset);
@@ -2395,11 +2400,10 @@ static void builtin_diff(const char *name_a,
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
index 5be1ee77a7..9ad546361a 100644
--- a/diff.h
+++ b/diff.h
@@ -188,6 +188,9 @@ struct diff_options {
 	int diff_path_counter;
 };
 
+void diff_emit_line(struct diff_options *o, const char *set, const char *reset,
+		    const char *line, int len);
+
 enum color_diff {
 	DIFF_RESET = 0,
 	DIFF_CONTEXT = 1,
diff --git a/submodule.c b/submodule.c
index d3299e29c0..428c996c97 100644
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
+			diff_emit_line(o, del, reset, sb.buf, sb.len);
+		else if (add)
+			diff_emit_line(o, add, reset, sb.buf, sb.len);
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
@@ -425,12 +418,17 @@ static void show_submodule_header(FILE *f, const char *path,
 	struct strbuf sb = STRBUF_INIT;
 	int fast_forward = 0, fast_backward = 0;
 
-	if (dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
-		fprintf(f, "%sSubmodule %s contains untracked content\n",
-			line_prefix, path);
-	if (dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
-		fprintf(f, "%sSubmodule %s contains modified content\n",
-			line_prefix, path);
+	if (dirty_submodule & DIRTY_SUBMODULE_UNTRACKED) {
+		strbuf_addf(&sb, "Submodule %s contains untracked content\n", path);
+		diff_emit_line(o, NULL, NULL, sb.buf, sb.len);
+		strbuf_reset(&sb);
+	}
+
+	if (dirty_submodule & DIRTY_SUBMODULE_MODIFIED) {
+		strbuf_addf(&sb, "Submodule %s contains modified content\n", path);
+		diff_emit_line(o, NULL, NULL, sb.buf, sb.len);
+		strbuf_reset(&sb);
+	}
 
 	if (is_null_oid(one))
 		message = "(new submodule)";
@@ -472,21 +470,20 @@ static void show_submodule_header(FILE *f, const char *path,
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
+	diff_emit_line(o, meta, reset, sb.buf, sb.len);
 
 	strbuf_release(&sb);
 }
 
-void show_submodule_summary(FILE *f, const char *path,
-		const char *line_prefix,
+void show_submodule_summary(struct diff_options *o, const char *path,
 		struct object_id *one, struct object_id *two,
 		unsigned dirty_submodule, const char *meta,
 		const char *del, const char *add, const char *reset)
@@ -495,7 +492,7 @@ void show_submodule_summary(FILE *f, const char *path,
 	struct commit *left = NULL, *right = NULL;
 	struct commit_list *merge_bases = NULL;
 
-	show_submodule_header(f, path, line_prefix, one, two, dirty_submodule,
+	show_submodule_header(o, path, one, two, dirty_submodule,
 			      meta, reset, &left, &right, &merge_bases);
 
 	/*
@@ -508,11 +505,12 @@ void show_submodule_summary(FILE *f, const char *path,
 
 	/* Treat revision walker failure the same as missing commits */
 	if (prepare_submodule_summary(&rev, path, left, right, merge_bases)) {
-		fprintf(f, "%s(revision walker failed)\n", line_prefix);
+		const char *error = "(revision walker failed)\n";
+		diff_emit_line(o, NULL, NULL, error, strlen(error));
 		goto out;
 	}
 
-	print_submodule_summary(&rev, f, line_prefix, del, add, reset);
+	print_submodule_summary(&rev, o, del, add, reset);
 
 out:
 	if (merge_bases)
@@ -521,20 +519,18 @@ void show_submodule_summary(FILE *f, const char *path,
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
@@ -547,15 +543,16 @@ void show_submodule_inline_diff(FILE *f, const char *path,
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
+	if (o->use_color)
+		argv_array_push(&cp.args, "--color=always");
+	argv_array_pushf(&cp.args, "--line-prefix=%s", diff_line_prefix(o));
 	if (DIFF_OPT_TST(o, REVERSE_DIFF)) {
 		argv_array_pushf(&cp.args, "--src-prefix=%s%s/",
 				 o->b_prefix, path);
@@ -578,11 +575,21 @@ void show_submodule_inline_diff(FILE *f, const char *path,
 		argv_array_push(&cp.args, oid_to_hex(new));
 
 	prepare_submodule_repo_env(&cp.env_array);
-	if (run_command(&cp))
-		fprintf(f, "(diff failed)\n");
+	if (start_command(&cp)) {
+		const char *error = "(diff failed)\n";
+		diff_emit_line(o, NULL, NULL, error, strlen(error));
+	}
+
+	while (strbuf_getwholeline_fd(&sb, cp.out, '\n') != EOF)
+		diff_emit_line(o, NULL, NULL, sb.buf, sb.len);
+
+	if (finish_command(&cp)) {
+		const char *error = "(diff failed)\n";
+		diff_emit_line(o, NULL, NULL, error, strlen(error));
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

