Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B418C43381
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31CBE64FB0
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbhBEWYd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 17:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbhBEOaP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 09:30:15 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8932C0617AA
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 08:08:02 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id a16so8149669wmm.0
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 08:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gLFyWWyf63kMkMmrC/QpWHrwmC2+b8vzawu1k6VOlUQ=;
        b=W07Pns7juhsxZGI+N8msIkwu+UgMImewj8qHSW/XRnlMJ4DN2vUxpiRjhYMolyJXgN
         LWFSlF5uMPjDQVqGXLo/M+rU3+M7BbrUyUfxKkeq1YqAPn8FEEA6Ga2aQhYXoVfaifCW
         u4AOpgoEDUtGT8jOXqRcjJYd/qgujSwMLVbQpsKyZ4xIrP+2F0khQqIN7W7lF/XBqYGy
         z/+62yNX6Uu2NIIZrvbSKmU9VVFDHws6vpfNcJO/SEwNLizKKalp3Pmgr5ULaue0pGJQ
         x7mAZzv/SflKKtXUKmOwCWKjTPn2zH6jf1GlZoWs//Bhk+WUhngQnA+bcXVZcQEW1NHn
         QvtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gLFyWWyf63kMkMmrC/QpWHrwmC2+b8vzawu1k6VOlUQ=;
        b=E5MyyONlkRllVE/4keYDYOPkIWbB6x/vBfTf7saX1cG+A5TVH9fnbeMSu2DWakP2Gw
         vItvKuStpVylYFUpKFqP8UTVAjE63xsGBSE3OTwI6T7epYE9xBTqJk+0JvHkZBSpo/Zn
         dlyf4EcwrdCiqxYan5Z0Kqg4PjooPYR8zRHzYFIde+nriplUmo5dgJ/4U5ysY887zQip
         o7F9DYimoQkRUYy6PqEoTf5Frw8VY9iJsq5bYTgJxzj+e0jvyKrIk1mZD7Y9PxKzA+YU
         zKbgMLoo1/lmTxtMkyaZLGcwtMIhRKsRqG6Lx6FBZZzwWmh+QCoI7fnPuNN02SUw2Bid
         qcKA==
X-Gm-Message-State: AOAM532RoIYVMCDJqyd1G/pi0SJw5lck0jtM2Q7TeUONcemX0bNVjUVA
        Pk9nT3dT3qsjzRWTx0mAiRRE4g4iYu4HRA==
X-Google-Smtp-Source: ABdhPJw+ya3XM0cHOkTyElnDwgRC0MhSsJ+PlGcdevtKoS7xNDmj6n9+nBZzKTEmN3GgGi6hlFCn5A==
X-Received: by 2002:a05:600c:2e46:: with SMTP id q6mr1168743wmf.78.1612534655229;
        Fri, 05 Feb 2021 06:17:35 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j15sm12630172wrw.9.2021.02.05.06.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 06:17:34 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <michal@isc.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] diff: add an API for deferred freeing
Date:   Fri,  5 Feb 2021 15:13:19 +0100
Message-Id: <20210205141320.18076-1-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20201020064809.14297-1-michal@isc.org>
References: <20201020064809.14297-1-michal@isc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a diff_free() function to free anything we may have allocated in
the "diff_options" struct, and the ability to make calling it a noop
by setting "no_free" in "diff_options".

This is required because when e.g. "git diff" is run we'll allocate
things in that struct, use the diff machinery once, and then exit, but
if we run e.g. "git log -p" we're going to re-use what we allocated
across multiple diff_flush() calls, and only want to free things at
the end.

We've thus ended up with features like the recently added "diff -I"[1]
where we'll leak memory. As it turns out it could have simply used the
pattern established in 6ea57703f6 (log: prepare log/log-tree to reuse
the diffopt.close_file attribute, 2016-06-22).

Manually adding more such flags to things log_tree_commit() every time
we need to allocate something would be tedious.

Let's instead move that fclose() code it to a new diff_free(), in
anticipation of freeing more things in that function in follow-up
commits. I'm renaming the "close_file" struct member to "fclose_file"
for the ease of validating this, we can be certain that these are all
the relevant callsites.

Some functions such as log_tree_commit() need an idiom of optionally
retaining a previous "no_free", as they may either free the memory
themselves, or their caller may do so. I'm keeping that idiom in
log_show_early() even though I don't think it's currently called in
this manner, since it also gets passed an existing "struct rev_info"..

1. 296d4a94e7 (diff: add -I<regex> that ignores matching changes,
   2020-10-20)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/add.c |  2 +-
 builtin/am.c  |  6 ++++--
 builtin/log.c | 27 ++++++++++++++-------------
 diff.c        | 18 +++++++++++++-----
 diff.h        | 14 +++++++++++++-
 log-tree.c    | 10 ++++++----
 wt-status.c   |  2 +-
 7 files changed, 52 insertions(+), 27 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index a825887c50..6319710186 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -282,7 +282,7 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
 	if (out < 0)
 		die(_("Could not open '%s' for writing."), file);
 	rev.diffopt.file = xfdopen(out, "w");
-	rev.diffopt.close_file = 1;
+	rev.diffopt.fclose_file = 1;
 	if (run_diff_files(&rev, 0))
 		die(_("Could not write patch"));
 
diff --git a/builtin/am.c b/builtin/am.c
index 8355e3566f..157d264583 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1315,7 +1315,7 @@ static void write_commit_patch(const struct am_state *state, struct commit *comm
 	rev_info.diffopt.flags.full_index = 1;
 	rev_info.diffopt.use_color = 0;
 	rev_info.diffopt.file = fp;
-	rev_info.diffopt.close_file = 1;
+	rev_info.diffopt.fclose_file = 1; /* log_tree_commit() sets .no_free=1 */
 	add_pending_object(&rev_info, &commit->object, "");
 	diff_setup_done(&rev_info.diffopt);
 	log_tree_commit(&rev_info, commit);
@@ -1347,10 +1347,12 @@ static void write_index_patch(const struct am_state *state)
 	rev_info.diffopt.output_format = DIFF_FORMAT_PATCH;
 	rev_info.diffopt.use_color = 0;
 	rev_info.diffopt.file = fp;
-	rev_info.diffopt.close_file = 1;
+	rev_info.diffopt.fclose_file = 1;
+	rev_info.diffopt.no_free = 1;
 	add_pending_object(&rev_info, &tree->object, "");
 	diff_setup_done(&rev_info.diffopt);
 	run_diff_index(&rev_info, 1);
+	diff_free(&rev_info.diffopt);
 }
 
 /**
diff --git a/builtin/log.c b/builtin/log.c
index fd282def43..604ee29ec0 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -306,10 +306,11 @@ static struct itimerval early_output_timer;
 
 static void log_show_early(struct rev_info *revs, struct commit_list *list)
 {
-	int i = revs->early_output, close_file = revs->diffopt.close_file;
+	int i = revs->early_output;
 	int show_header = 1;
+	int no_free = revs->diffopt.no_free;
 
-	revs->diffopt.close_file = 0;
+	revs->diffopt.no_free = 0;
 	sort_in_topological_order(&list, revs->sort_order);
 	while (list && i) {
 		struct commit *commit = list->item;
@@ -326,8 +327,8 @@ static void log_show_early(struct rev_info *revs, struct commit_list *list)
 		case commit_ignore:
 			break;
 		case commit_error:
-			if (close_file)
-				fclose(revs->diffopt.file);
+			revs->diffopt.no_free = no_free;
+			diff_free(&revs->diffopt);
 			return;
 		}
 		list = list->next;
@@ -335,8 +336,8 @@ static void log_show_early(struct rev_info *revs, struct commit_list *list)
 
 	/* Did we already get enough commits for the early output? */
 	if (!i) {
-		if (close_file)
-			fclose(revs->diffopt.file);
+		revs->diffopt.no_free = 0;
+		diff_free(&revs->diffopt);
 		return;
 	}
 
@@ -400,7 +401,7 @@ static int cmd_log_walk(struct rev_info *rev)
 {
 	struct commit *commit;
 	int saved_nrl = 0;
-	int saved_dcctc = 0, close_file = rev->diffopt.close_file;
+	int saved_dcctc = 0;
 
 	if (rev->early_output)
 		setup_early_output();
@@ -416,7 +417,7 @@ static int cmd_log_walk(struct rev_info *rev)
 	 * and HAS_CHANGES being accumulated in rev->diffopt, so be careful to
 	 * retain that state information if replacing rev->diffopt in this loop
 	 */
-	rev->diffopt.close_file = 0;
+	rev->diffopt.no_free = 1;
 	while ((commit = get_revision(rev)) != NULL) {
 		if (!log_tree_commit(rev, commit) && rev->max_count >= 0)
 			/*
@@ -441,8 +442,8 @@ static int cmd_log_walk(struct rev_info *rev)
 	}
 	rev->diffopt.degraded_cc_to_c = saved_dcctc;
 	rev->diffopt.needed_rename_limit = saved_nrl;
-	if (close_file)
-		fclose(rev->diffopt.file);
+	rev->diffopt.no_free = 0;
+	diff_free(&rev->diffopt);
 
 	if (rev->diffopt.output_format & DIFF_FORMAT_CHECKDIFF &&
 	    rev->diffopt.flags.check_failed) {
@@ -1952,18 +1953,18 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (rev.show_notes)
 		load_display_notes(&rev.notes_opt);
 
-	if (use_stdout + rev.diffopt.close_file + !!output_directory > 1)
+	if (use_stdout + rev.diffopt.fclose_file + !!output_directory > 1)
 		die(_("--stdout, --output, and --output-directory are mutually exclusive"));
 
 	if (use_stdout) {
 		setup_pager();
-	} else if (rev.diffopt.close_file) {
+	} else if (rev.diffopt.fclose_file) {
 		/*
 		 * The diff code parsed --output; it has already opened the
 		 * file, but but we must instruct it not to close after each
 		 * diff.
 		 */
-		rev.diffopt.close_file = 0;
+		rev.diffopt.no_free = 1;
 	} else {
 		int saved;
 
diff --git a/diff.c b/diff.c
index 69e3bc00ed..3e6f8f0a71 100644
--- a/diff.c
+++ b/diff.c
@@ -5187,7 +5187,7 @@ static enum parse_opt_result diff_opt_output(struct parse_opt_ctx_t *ctx,
 	BUG_ON_OPT_NEG(unset);
 	path = prefix_filename(ctx->prefix, arg);
 	options->file = xfopen(path, "w");
-	options->close_file = 1;
+	options->fclose_file = 1;
 	if (options->use_color != GIT_COLOR_ALWAYS)
 		options->use_color = GIT_COLOR_NEVER;
 	free(path);
@@ -6399,10 +6399,10 @@ void diff_flush(struct diff_options *options)
 		 * options->file to /dev/null should be safe, because we
 		 * aren't supposed to produce any output anyway.
 		 */
-		if (options->close_file)
+		if (options->fclose_file)
 			fclose(options->file);
 		options->file = xfopen("/dev/null", "w");
-		options->close_file = 1;
+		options->fclose_file = 1;
 		options->color_moved = 0;
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
@@ -6433,8 +6433,7 @@ void diff_flush(struct diff_options *options)
 free_queue:
 	free(q->queue);
 	DIFF_QUEUE_CLEAR(q);
-	if (options->close_file)
-		fclose(options->file);
+	diff_free(options);
 
 	/*
 	 * Report the content-level differences with HAS_CHANGES;
@@ -6449,6 +6448,15 @@ void diff_flush(struct diff_options *options)
 	}
 }
 
+void diff_free(struct diff_options *options)
+{
+	if (options->no_free)
+		return;
+	if (options->fclose_file)
+		fclose(options->file);
+}
+	
+
 static int match_filter(const struct diff_options *options, const struct diff_filepair *p)
 {
 	return (((p->status == DIFF_STATUS_MODIFIED) &&
diff --git a/diff.h b/diff.h
index 2ff2b1c7f2..d1d74c3a9e 100644
--- a/diff.h
+++ b/diff.h
@@ -49,7 +49,16 @@
  * - Once you finish feeding the pairs of files, call `diffcore_std()`.
  * This will tell the diffcore library to go ahead and do its work.
  *
+ * - The `diff_opt_parse()` etc. functions might allocate memory in
+ *  `struct diff_options`. When running the API `N > 1` set `.no_free
+ *  = 1` to make the `diff_free()` invoked by `diff_flush()` below a
+ *  noop.
+ *
  * - Calling `diff_flush()` will produce the output.
+ *
+ * - If you set `.no_free = 1` before set it to `0` and call
+ *   `diff_free()` again. If `.no_free = 1` was not set there's no
+ *   need to call `diff_free()`, `diff_flush()` will call it.
  */
 
 struct combine_diff_path;
@@ -328,7 +337,7 @@ struct diff_options {
 	void (*set_default)(struct diff_options *);
 
 	FILE *file;
-	int close_file;
+	int fclose_file;
 
 #define OUTPUT_INDICATOR_NEW 0
 #define OUTPUT_INDICATOR_OLD 1
@@ -365,6 +374,8 @@ struct diff_options {
 
 	struct repository *repo;
 	struct option *parseopts;
+
+	int no_free;
 };
 
 unsigned diff_filter_bit(char status);
@@ -559,6 +570,7 @@ void diffcore_fix_diff_index(void);
 
 int diff_queue_is_empty(void);
 void diff_flush(struct diff_options*);
+void diff_free(struct diff_options*);
 void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc);
 
 /* diff-raw status letters */
diff --git a/log-tree.c b/log-tree.c
index fd0dde97ec..bb946f15f1 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -952,12 +952,14 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 int log_tree_commit(struct rev_info *opt, struct commit *commit)
 {
 	struct log_info log;
-	int shown, close_file = opt->diffopt.close_file;
+	int shown;
+	/* maybe called by e.g. cmd_log_walk(), maybe stand-alone */
+	int no_free = opt->diffopt.no_free;
 
 	log.commit = commit;
 	log.parent = NULL;
 	opt->loginfo = &log;
-	opt->diffopt.close_file = 0;
+	opt->diffopt.no_free = 1;
 
 	if (opt->line_level_traverse)
 		return line_log_print(opt, commit);
@@ -974,7 +976,7 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
 		fprintf(opt->diffopt.file, "\n%s\n", opt->break_bar);
 	opt->loginfo = NULL;
 	maybe_flush_or_die(opt->diffopt.file, "stdout");
-	if (close_file)
-		fclose(opt->diffopt.file);
+	opt->diffopt.no_free = no_free;
+	diff_free(&opt->diffopt);
 	return shown;
 }
diff --git a/wt-status.c b/wt-status.c
index 0c8287a023..41b08474e5 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1052,7 +1052,7 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
 	rev.diffopt.rename_limit = s->rename_limit >= 0 ? s->rename_limit : rev.diffopt.rename_limit;
 	rev.diffopt.rename_score = s->rename_score >= 0 ? s->rename_score : rev.diffopt.rename_score;
 	rev.diffopt.file = s->fp;
-	rev.diffopt.close_file = 0;
+	rev.diffopt.fclose_file = 0; /* wt_status owns the s->fp */
 	/*
 	 * If we're not going to stdout, then we definitely don't
 	 * want color, since we are going to the commit message
-- 
2.30.0.284.gd98b1dd5eaa7

