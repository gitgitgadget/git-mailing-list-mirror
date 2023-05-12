Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5143CC77B75
	for <git@archiver.kernel.org>; Fri, 12 May 2023 08:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240136AbjELIEW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 04:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240240AbjELIEM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 04:04:12 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8542EE73C
        for <git@vger.kernel.org>; Fri, 12 May 2023 01:03:50 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-54fdc9b8351so2116184eaf.0
        for <git@vger.kernel.org>; Fri, 12 May 2023 01:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683878629; x=1686470629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FFEGWOkTDRTYD+pNddx00TPC1Btt47YBQd8AoEYSpA=;
        b=M/a8ym21sI06yVYJhHNyqhp0Q5KkWYSSzxxHKfxtRp/vyuJ9M69Q+bM3CllVUCxDTS
         Uv5P1X6d2c6/Dr6oVlA7keGWAj3u1ZvLCaR2RHfAML0iwz84K8NDGaQ+yFlp6zLK8ri8
         61Cy+QssoEtqDLB9C0KYbTLGMXk2G+tgmTqH8dDFR9auCKj+ml+kqfx91ZKOWnbPcdj2
         V11QuCMG01cGWsAL2pkxYNaMGy+fCV6/MS3U14yylbYK8gMcvAvckmPgte73aM1npjyb
         /QHYpHtcGR+KH+86vCz4CckH38dsUwsJWmVprb8kXn/Q2z24YbCUcZCMIdQ4jOnut5Z4
         qqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683878629; x=1686470629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7FFEGWOkTDRTYD+pNddx00TPC1Btt47YBQd8AoEYSpA=;
        b=XHOOq1mAPmYXZweneqyJPyz0XxWjtrXWRnOz4wC/LF8kJhWAUZNG4i9O1MBX3DvI3q
         al3RnzqJNDqPOGUKnsb2K+fI4ZmRd2/yf9YXAh8v9F/6KSSjUCWX0TRHEI6XNZOgGowj
         m3I5WllGL7WAZ89vwQ/vLQHua8mWwBB/XvkMsfCojbIOMpLC0hNUf/i/55n9hS5bBI6G
         F8XYqERyTYz+ZBgeLWgam2ZxCvHkX97koTkG0OV69a+Zi/VffONTIisVLg3I89nWRgJS
         +wJr+2pEY7aOt84LKukPyIkeWYWgY9opwIOQT7agunlG2xNkM1kiJB93X3curpDuiT1p
         RhrA==
X-Gm-Message-State: AC+VfDzIhY2tIzYE368TMfhpRGi2j2kxpzXiddPrisKoblsujq3EkvAx
        hT24lp4KceoAIEskvn2L1ov29UkkTQ8=
X-Google-Smtp-Source: ACHHUZ7RlXZnqjlRf4aLaAddXifXY7Tt96HKkzTFCkWnEB1kVVPbXGG1OXowHij2B12vzIQLMprRPA==
X-Received: by 2002:a05:6808:302a:b0:395:1c40:64b5 with SMTP id ay42-20020a056808302a00b003951c4064b5mr218477oib.7.1683878629528;
        Fri, 12 May 2023 01:03:49 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id h12-20020a056808014c00b00394627263a0sm1080504oie.57.2023.05.12.01.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 01:03:49 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 7/7] diff: remove DIFF_FORMAT_NO_OUTPUT
Date:   Fri, 12 May 2023 02:03:39 -0600
Message-Id: <20230512080339.2186324-8-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230512080339.2186324-1-felipe.contreras@gmail.com>
References: <20230512080339.2186324-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead use an empty output_format (0) as NO_OUTPUT.

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 blame.c                     |  6 +++---
 builtin/log.c               |  2 +-
 builtin/stash.c             |  2 +-
 builtin/submodule--helper.c |  2 +-
 combine-diff.c              | 10 ++++------
 diff.c                      | 21 ++++++++++-----------
 diff.h                      |  1 -
 log-tree.c                  |  4 ++--
 merge-ort.c                 |  4 ++--
 merge-recursive.c           |  4 ++--
 notes-merge.c               |  4 ++--
 revision.c                  |  2 +-
 tree-diff.c                 |  2 +-
 13 files changed, 30 insertions(+), 34 deletions(-)

diff --git a/blame.c b/blame.c
index b830654062..d382af6798 100644
--- a/blame.c
+++ b/blame.c
@@ -1337,7 +1337,7 @@ static struct blame_origin *find_origin(struct repository *r,
 	repo_diff_setup(r, &diff_opts);
 	diff_opts.flags.recursive = 1;
 	diff_opts.detect_rename = 0;
-	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	diff_opts.output_format = 0;
 	paths[0] = origin->path;
 	paths[1] = NULL;
 
@@ -1420,7 +1420,7 @@ static struct blame_origin *find_rename(struct repository *r,
 	repo_diff_setup(r, &diff_opts);
 	diff_opts.flags.recursive = 1;
 	diff_opts.detect_rename = DIFF_DETECT_RENAME;
-	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	diff_opts.output_format = 0;
 	diff_opts.single_follow = origin->path;
 	diff_setup_done(&diff_opts);
 
@@ -2242,7 +2242,7 @@ static void find_copy_in_parent(struct blame_scoreboard *sb,
 
 	repo_diff_setup(sb->repo, &diff_opts);
 	diff_opts.flags.recursive = 1;
-	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	diff_opts.output_format = 0;
 
 	diff_setup_done(&diff_opts);
 
diff --git a/builtin/log.c b/builtin/log.c
index d2a81f36c2..4fbdbd349d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -277,7 +277,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 			     PARSE_OPT_KEEP_DASHDASH);
 
 	if (quiet)
-		rev->diffopt.output_format = DIFF_FORMAT_NO_OUTPUT;
+		rev->diffopt.output_format = 0;
 	argc = setup_revisions(argc, argv, rev, opt);
 
 	/* Any arguments at this point are not recognized */
diff --git a/builtin/stash.c b/builtin/stash.c
index 398e3c9f61..d7a4ade8d4 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -437,7 +437,7 @@ static void unstage_changes_unless_new(struct object_id *orig_tree)
 	repo_diff_setup(the_repository, &diff_opts);
 	diff_opts.flags.recursive = 1;
 	diff_opts.detect_rename = 0;
-	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	diff_opts.output_format = 0;
 	diff_setup_done(&diff_opts);
 
 	do_diff_cache(orig_tree, &diff_opts);
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6bf8d666ce..885cd57e90 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1120,7 +1120,7 @@ static int compute_summary_module_list(struct object_id *head_oid,
 	rev.abbrev = 0;
 	precompose_argv_prefix(diff_args.nr, diff_args.v, NULL);
 	setup_revisions(diff_args.nr, diff_args.v, &rev, &opt);
-	rev.diffopt.output_format = DIFF_FORMAT_NO_OUTPUT | DIFF_FORMAT_CALLBACK;
+	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = submodule_summary_callback;
 	rev.diffopt.format_callback_data = &list;
 
diff --git a/combine-diff.c b/combine-diff.c
index 1e3cd7fb17..b054177b20 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1394,7 +1394,7 @@ static struct combine_diff_path *find_paths_generic(const struct object_id *oid,
 	int output_format = opt->output_format;
 	const char *orderfile = opt->orderfile;
 
-	opt->output_format = DIFF_FORMAT_NO_OUTPUT;
+	opt->output_format = 0;
 	/* tell diff_tree to emit paths in sorted (=tree) order */
 	opt->orderfile = NULL;
 
@@ -1408,17 +1408,15 @@ static struct combine_diff_path *find_paths_generic(const struct object_id *oid,
 		if (i == 0 && stat_opt)
 			opt->output_format = stat_opt;
 		else
-			opt->output_format = DIFF_FORMAT_NO_OUTPUT;
+			opt->output_format = 0;
 		diff_tree_oid(&parents->oid[i], oid, "", opt);
 		diffcore_std(opt);
 		paths = intersect_paths(paths, i, num_parent,
 					combined_all_paths);
 
 		/* if showing diff, show it in requested order */
-		if (opt->output_format != DIFF_FORMAT_NO_OUTPUT &&
-		    orderfile) {
+		if (opt->output_format && orderfile)
 			diffcore_order(orderfile);
-		}
 
 		diff_flush(opt);
 	}
@@ -1521,7 +1519,7 @@ void diff_tree_combined(const struct object_id *oid,
 		show_log(rev);
 
 		if (rev->verbose_header && opt->output_format &&
-		    opt->output_format != DIFF_FORMAT_NO_OUTPUT &&
+		    opt->output_format &&
 		    !commit_format_is_empty(rev->commit_format))
 			printf("%s%c", diff_line_prefix(opt),
 			       opt->line_termination);
diff --git a/diff.c b/diff.c
index d171f155b1..1f87127a93 100644
--- a/diff.c
+++ b/diff.c
@@ -4801,8 +4801,7 @@ void diff_setup_done(struct diff_options *options)
 
 	if (options->output_format & (DIFF_FORMAT_NAME |
 				      DIFF_FORMAT_NAME_STATUS |
-				      DIFF_FORMAT_CHECKDIFF |
-				      DIFF_FORMAT_NO_OUTPUT))
+				      DIFF_FORMAT_CHECKDIFF))
 		options->output_format &= ~(DIFF_FORMAT_RAW |
 					    DIFF_FORMAT_NUMSTAT |
 					    DIFF_FORMAT_DIFFSTAT |
@@ -4846,7 +4845,7 @@ void diff_setup_done(struct diff_options *options)
 	 * exit code in such a case either.
 	 */
 	if (options->flags.quick) {
-		options->output_format = DIFF_FORMAT_NO_OUTPUT;
+		options->output_format = 0;
 		options->flags.exit_with_status = 1;
 	}
 
@@ -4987,7 +4986,7 @@ static int diff_opt_diff_filter(const struct option *option,
 
 static void enable_patch_output(int *fmt)
 {
-	*fmt &= ~(DIFF_FORMAT_DEFAULT | DIFF_FORMAT_NO_OUTPUT);
+	*fmt &= ~DIFF_FORMAT_DEFAULT;
 	*fmt |= DIFF_FORMAT_PATCH;
 }
 
@@ -5492,16 +5491,16 @@ struct option *add_diff_options(const struct option *opts,
 		OPT_GROUP(N_("Diff output format options")),
 		OPT_BITOP('p', "patch", &options->output_format,
 			  N_("generate patch"),
-			  DIFF_FORMAT_PATCH, DIFF_FORMAT_DEFAULT | DIFF_FORMAT_NO_OUTPUT),
+			  DIFF_FORMAT_PATCH, DIFF_FORMAT_DEFAULT),
 		OPT_SET_INT_F('s', "silent", &options->output_format,
 			  N_("suppress diff output"),
-			  DIFF_FORMAT_NO_OUTPUT, PARSE_OPT_NONEG),
+			  0, PARSE_OPT_NONEG),
 		OPT_BITOP(0, "no-patch", &options->output_format,
 			  N_("negate --patch"),
-			  DIFF_FORMAT_NO_OUTPUT, DIFF_FORMAT_PATCH | DIFF_FORMAT_DEFAULT),
+			  0, DIFF_FORMAT_PATCH | DIFF_FORMAT_DEFAULT),
 		OPT_BITOP('u', NULL, &options->output_format,
 			  N_("generate patch"),
-			  DIFF_FORMAT_PATCH, DIFF_FORMAT_DEFAULT | DIFF_FORMAT_NO_OUTPUT),
+			  DIFF_FORMAT_PATCH, DIFF_FORMAT_DEFAULT),
 		OPT_CALLBACK_F('U', "unified", options, N_("<n>"),
 			       N_("generate diffs with <n> lines context"),
 			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG, diff_opt_unified),
@@ -5513,11 +5512,11 @@ struct option *add_diff_options(const struct option *opts,
 		OPT_BITOP(0, "patch-with-raw", &options->output_format,
 			  N_("synonym for '-p --raw'"),
 			  DIFF_FORMAT_PATCH | DIFF_FORMAT_RAW,
-			  DIFF_FORMAT_DEFAULT | DIFF_FORMAT_NO_OUTPUT),
+			  DIFF_FORMAT_DEFAULT),
 		OPT_BITOP(0, "patch-with-stat", &options->output_format,
 			  N_("synonym for '-p --stat'"),
 			  DIFF_FORMAT_PATCH | DIFF_FORMAT_DIFFSTAT,
-			  DIFF_FORMAT_DEFAULT | DIFF_FORMAT_NO_OUTPUT),
+			  DIFF_FORMAT_DEFAULT),
 		OPT_BITOP(0, "numstat", &options->output_format,
 			  N_("machine friendly --stat"),
 			  DIFF_FORMAT_NUMSTAT, DIFF_FORMAT_DEFAULT),
@@ -6648,7 +6647,7 @@ void diff_flush(struct diff_options *options)
 		separator++;
 	}
 
-	if (output_format == DIFF_FORMAT_NO_OUTPUT &&
+	if (!output_format &&
 	    options->flags.exit_with_status &&
 	    options->flags.diff_from_contents) {
 		/*
diff --git a/diff.h b/diff.h
index 44da1a4ca7..48e8ff962e 100644
--- a/diff.h
+++ b/diff.h
@@ -94,7 +94,6 @@ typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 
 typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data);
 
-#define DIFF_FORMAT_NO_OUTPUT	0x0000
 #define DIFF_FORMAT_RAW		0x0001
 #define DIFF_FORMAT_DIFFSTAT	0x0002
 #define DIFF_FORMAT_NUMSTAT	0x0004
diff --git a/log-tree.c b/log-tree.c
index f4b22a60cc..b073e1dea4 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -874,7 +874,7 @@ int log_tree_diff_flush(struct rev_info *opt)
 
 	if (diff_queue_is_empty(&opt->diffopt)) {
 		int saved_fmt = opt->diffopt.output_format;
-		opt->diffopt.output_format = DIFF_FORMAT_NO_OUTPUT;
+		opt->diffopt.output_format = 0;
 		diff_flush(&opt->diffopt);
 		opt->diffopt.output_format = saved_fmt;
 		return 0;
@@ -882,7 +882,7 @@ int log_tree_diff_flush(struct rev_info *opt)
 
 	if (opt->loginfo && !opt->no_commit_id) {
 		show_log(opt);
-		if ((opt->diffopt.output_format & ~DIFF_FORMAT_NO_OUTPUT) &&
+		if (opt->diffopt.output_format &&
 		    opt->verbose_header &&
 		    opt->commit_format != CMIT_FMT_ONELINE &&
 		    !commit_format_is_empty(opt->commit_format)) {
diff --git a/merge-ort.c b/merge-ort.c
index a50b095c47..392549a24b 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3248,7 +3248,7 @@ static int detect_regular_renames(struct merge_options *opt,
 		diff_opts.rename_limit = 7000;
 	diff_opts.rename_score = opt->rename_score;
 	diff_opts.show_rename_progress = opt->show_rename_progress;
-	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	diff_opts.output_format = 0;
 	diff_setup_done(&diff_opts);
 
 	diff_queued_diff = renames->pairs[side_index];
@@ -3269,7 +3269,7 @@ static int detect_regular_renames(struct merge_options *opt,
 
 	renames->pairs[side_index] = diff_queued_diff;
 
-	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	diff_opts.output_format = 0;
 	diff_queued_diff.nr = 0;
 	diff_queued_diff.queue = NULL;
 	diff_flush(&diff_opts);
diff --git a/merge-recursive.c b/merge-recursive.c
index 8e87b6386d..d5678424f3 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1904,7 +1904,7 @@ static struct diff_queue_struct *get_diffpairs(struct merge_options *opt,
 	opts.rename_limit = (opt->rename_limit >= 0) ? opt->rename_limit : 7000;
 	opts.rename_score = opt->rename_score;
 	opts.show_rename_progress = opt->show_rename_progress;
-	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	opts.output_format = 0;
 	diff_setup_done(&opts);
 	diff_tree_oid(&o_tree->object.oid, &tree->object.oid, "", &opts);
 	diffcore_std(&opts);
@@ -1914,7 +1914,7 @@ static struct diff_queue_struct *get_diffpairs(struct merge_options *opt,
 	ret = xmalloc(sizeof(*ret));
 	*ret = diff_queued_diff;
 
-	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	opts.output_format = 0;
 	diff_queued_diff.nr = 0;
 	diff_queued_diff.queue = NULL;
 	diff_flush(&opts);
diff --git a/notes-merge.c b/notes-merge.c
index 233e49e319..9a8bac2579 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -139,7 +139,7 @@ static struct notes_merge_pair *diff_tree_remote(struct notes_merge_options *o,
 
 	repo_diff_setup(o->repo, &opt);
 	opt.flags.recursive = 1;
-	opt.output_format = DIFF_FORMAT_NO_OUTPUT;
+	opt.output_format = 0;
 	diff_setup_done(&opt);
 	diff_tree_oid(base, remote, "", &opt);
 	diffcore_std(&opt);
@@ -201,7 +201,7 @@ static void diff_tree_local(struct notes_merge_options *o,
 
 	repo_diff_setup(o->repo, &opt);
 	opt.flags.recursive = 1;
-	opt.output_format = DIFF_FORMAT_NO_OUTPUT;
+	opt.output_format = 0;
 	diff_setup_done(&opt);
 	diff_tree_oid(base, local, "", &opt);
 	diffcore_std(&opt);
diff --git a/revision.c b/revision.c
index 07d653c197..52c2f415c7 100644
--- a/revision.c
+++ b/revision.c
@@ -2966,7 +2966,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	}
 
 	/* Did the user ask for any diff output? Run the diff! */
-	if (revs->diffopt.output_format & ~(DIFF_FORMAT_DEFAULT | DIFF_FORMAT_NO_OUTPUT))
+	if (revs->diffopt.output_format & ~DIFF_FORMAT_DEFAULT)
 		revs->diff = 1;
 
 	/* Pickaxe, diff-filter and rename following need diffs */
diff --git a/tree-diff.c b/tree-diff.c
index 20bb15f38d..757a271348 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -627,7 +627,7 @@ static void try_to_follow_renames(const struct object_id *old_oid,
 	repo_diff_setup(opt->repo, &diff_opts);
 	diff_opts.flags.recursive = 1;
 	diff_opts.flags.find_copies_harder = 1;
-	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	diff_opts.output_format = 0;
 	diff_opts.single_follow = opt->pathspec.items[0].match;
 	diff_opts.break_opt = opt->break_opt;
 	diff_opts.rename_score = opt->rename_score;
-- 
2.40.0+fc1

