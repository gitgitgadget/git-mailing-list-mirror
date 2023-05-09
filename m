Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3069C77B7F
	for <git@archiver.kernel.org>; Tue,  9 May 2023 00:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbjEIAo0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 20:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjEIAoU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 20:44:20 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A999023
        for <git@vger.kernel.org>; Mon,  8 May 2023 17:44:14 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-54cb8d72c0bso2764741eaf.3
        for <git@vger.kernel.org>; Mon, 08 May 2023 17:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683593053; x=1686185053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgSHoxbWGvqPfS/3t7TICHJ3cxYsmnuZQ++iCu7WvtE=;
        b=g+/wykQsLT3+c+W1o8niJT4y/Aco9y/4Wa1v7YEzCUgVmyn8oqARCt66Friztp10Th
         vf20QgjpKymvYgQx15eXSFfQoXKjbxJBTnL1yF3fOIMpcniey/tfalKuHfpvZmWSHiC9
         ti6LAQhypLAzKpB2niDgOtLMkAUUyrpF1KWfmcUK9Xdu8swOOjI734WNbSZqThI+Vx++
         OgG3IW8STWIJjcsyBOB/nlMKxFAEPWn6f8wS8/iSTOXtUnWSu1KGXY2Y5wyPgYU8UTCY
         beDcSBVKQ0/fN2Zv0rw8VLUptncuHIj8G44MwpzLFzDuRH6NKOFq5TaVxwd8+zuNvbqy
         l8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683593053; x=1686185053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgSHoxbWGvqPfS/3t7TICHJ3cxYsmnuZQ++iCu7WvtE=;
        b=Cy2jnggOSozvuMaE4nz9OG38iUVz4TFthK9377rAaKn+swi9hElIwMgBgdZxSYLEA1
         PdXcaxjrptslfWXlSdDEqXPoWfLLS+DbTCjZ+7l7b7VnsHCtignIw/lZtnP5TcdwxIaj
         ZE/SO3RVJGFLNulHnS9UC3cyhnEfFDuRT0mXSp/Pk/NyigFod6nu1bd7jIjnpiv2qBpi
         L450mQ07PMObwzwDgwSuE3J2e+HxEYZSJiSuunrLGnIWi4zDXKIkeTfrN06A1At54SAE
         k5Lgh9+v9CRvkpqT6R7UqyXyGSirDa+kcozkYsEKpmrG9vVRWh7bwPHgt1YL+DcHIqBr
         g4+Q==
X-Gm-Message-State: AC+VfDxPsbVLHQeGnptCwmz3gCBHH7OaqlaOqyp7WUfzlQecyWUmilXn
        7JRkWKg2xmZsnnHQn/hieZ1t3r1o93U=
X-Google-Smtp-Source: ACHHUZ6+/UNl60Yc7aa/QcEFj1/zfNQLolcLdtC/qvhvWM6NA+R87ut/CnTWsQWTospMc7DdjThpLg==
X-Received: by 2002:a05:6808:311:b0:38c:4943:9f0f with SMTP id i17-20020a056808031100b0038c49439f0fmr408507oie.40.1683593053035;
        Mon, 08 May 2023 17:44:13 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id n206-20020acabdd7000000b0038cabdbe3a7sm641716oif.3.2023.05.08.17.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 17:44:12 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 4/4] diff: remove DIFF_FORMAT_NO_OUTPUT
Date:   Mon,  8 May 2023 18:44:06 -0600
Message-Id: <20230509004406.1786033-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230509004406.1786033-1-felipe.contreras@gmail.com>
References: <20230509004406.1786033-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead use an empty output_format (0) as NO_OUTPUT.

This makes it so `--no-patch` only negates the effect of `--patch`, not
shut down all output.

So now `git diff --no-patch --raw` works correctly, as it's the opposite
of `git diff --patch --raw`.

Semantically `--no-patch` used to be considered a format, now it's the
opposite of the `--patch` format.

Cc: Sergey Organov <sorganov@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 blame.c                     |  6 +++---
 builtin/log.c               |  2 +-
 builtin/stash.c             |  2 +-
 builtin/submodule--helper.c |  2 +-
 combine-diff.c              | 10 ++++------
 diff.c                      | 26 ++++++++++++--------------
 diff.h                      |  5 -----
 log-tree.c                  |  4 ++--
 merge-ort.c                 |  4 ++--
 merge-recursive.c           |  4 ++--
 notes-merge.c               |  4 ++--
 range-diff.c                |  2 +-
 revision.c                  |  6 +++---
 t/t4013-diff-various.sh     |  5 +----
 tree-diff.c                 |  2 +-
 15 files changed, 36 insertions(+), 48 deletions(-)

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
index 13c196c391..b3e6ee8782 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -276,7 +276,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
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
index f7e9fb5747..86e01b2634 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1393,7 +1393,7 @@ static struct combine_diff_path *find_paths_generic(const struct object_id *oid,
 	int output_format = opt->output_format;
 	const char *orderfile = opt->orderfile;
 
-	opt->output_format = DIFF_FORMAT_NO_OUTPUT;
+	opt->output_format = 0;
 	/* tell diff_tree to emit paths in sorted (=tree) order */
 	opt->orderfile = NULL;
 
@@ -1407,17 +1407,15 @@ static struct combine_diff_path *find_paths_generic(const struct object_id *oid,
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
@@ -1520,7 +1518,7 @@ void diff_tree_combined(const struct object_id *oid,
 		show_log(rev);
 
 		if (rev->verbose_header && opt->output_format &&
-		    opt->output_format != DIFF_FORMAT_NO_OUTPUT &&
+		    opt->output_format &&
 		    !commit_format_is_empty(rev->commit_format))
 			printf("%s%c", diff_line_prefix(opt),
 			       opt->line_termination);
diff --git a/diff.c b/diff.c
index c9077bfed6..afe2f849b0 100644
--- a/diff.c
+++ b/diff.c
@@ -4748,8 +4748,7 @@ void diff_setup_done(struct diff_options *options)
 {
 	unsigned check_mask = DIFF_FORMAT_NAME |
 			      DIFF_FORMAT_NAME_STATUS |
-			      DIFF_FORMAT_CHECKDIFF |
-			      DIFF_FORMAT_NO_OUTPUT;
+			      DIFF_FORMAT_CHECKDIFF;
 	/*
 	 * This must be signed because we're comparing against a potentially
 	 * negative value.
@@ -4760,8 +4759,8 @@ void diff_setup_done(struct diff_options *options)
 		options->set_default(options);
 
 	if (HAS_MULTI_BITS(options->output_format & check_mask))
-		die(_("options '%s', '%s', '%s', and '%s' cannot be used together"),
-			"--name-only", "--name-status", "--check", "-s");
+		die(_("options '%s', '%s', and '%s' cannot be used together"),
+			"--name-only", "--name-status", "--check");
 
 	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_MASK))
 		die(_("options '%s', '%s', and '%s' cannot be used together"),
@@ -4800,8 +4799,7 @@ void diff_setup_done(struct diff_options *options)
 
 	if (options->output_format & (DIFF_FORMAT_NAME |
 				      DIFF_FORMAT_NAME_STATUS |
-				      DIFF_FORMAT_CHECKDIFF |
-				      DIFF_FORMAT_NO_OUTPUT))
+				      DIFF_FORMAT_CHECKDIFF))
 		options->output_format &= ~(DIFF_FORMAT_RAW |
 					    DIFF_FORMAT_NUMSTAT |
 					    DIFF_FORMAT_DIFFSTAT |
@@ -4845,7 +4843,7 @@ void diff_setup_done(struct diff_options *options)
 	 * exit code in such a case either.
 	 */
 	if (options->flags.quick) {
-		options->output_format = DIFF_FORMAT_NO_OUTPUT;
+		options->output_format = 0;
 		options->flags.exit_with_status = 1;
 	}
 
@@ -4986,7 +4984,7 @@ static int diff_opt_diff_filter(const struct option *option,
 
 static void enable_patch_output(int *fmt)
 {
-	*fmt &= ~(DIFF_FORMAT_DEFAULT | DIFF_FORMAT_NO_OUTPUT);
+	*fmt &= ~DIFF_FORMAT_DEFAULT;
 	*fmt |= DIFF_FORMAT_PATCH;
 }
 
@@ -5491,13 +5489,13 @@ struct option *add_diff_options(const struct option *opts,
 		OPT_GROUP(N_("Diff output format options")),
 		OPT_BITOP('p', "patch", &options->output_format,
 			  N_("generate patch"),
-			  DIFF_FORMAT_PATCH, DIFF_FORMAT_DEFAULT | DIFF_FORMAT_NO_OUTPUT),
+			  DIFF_FORMAT_PATCH, DIFF_FORMAT_DEFAULT),
 		OPT_BITOP('s', "no-patch", &options->output_format,
 			  N_("suppress diff output"),
-			  DIFF_FORMAT_NO_OUTPUT, DIFF_FORMAT_DEFAULT | DIFF_FORMAT_PATCH),
+			  0, DIFF_FORMAT_DEFAULT | DIFF_FORMAT_PATCH),
 		OPT_BITOP('u', NULL, &options->output_format,
 			  N_("generate patch"),
-			  DIFF_FORMAT_PATCH, DIFF_FORMAT_DEFAULT | DIFF_FORMAT_NO_OUTPUT),
+			  DIFF_FORMAT_PATCH, DIFF_FORMAT_DEFAULT),
 		OPT_CALLBACK_F('U', "unified", options, N_("<n>"),
 			       N_("generate diffs with <n> lines context"),
 			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG, diff_opt_unified),
@@ -5509,11 +5507,11 @@ struct option *add_diff_options(const struct option *opts,
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
@@ -6644,7 +6642,7 @@ void diff_flush(struct diff_options *options)
 		separator++;
 	}
 
-	if (output_format & DIFF_FORMAT_NO_OUTPUT &&
+	if (!output_format &&
 	    options->flags.exit_with_status &&
 	    options->flags.diff_from_contents) {
 		/*
diff --git a/diff.h b/diff.h
index 35bdbc40fa..31375b7e8a 100644
--- a/diff.h
+++ b/diff.h
@@ -109,11 +109,6 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 #define DIFF_FORMAT_NAME_STATUS	0x0200
 #define DIFF_FORMAT_CHECKDIFF	0x0400
 
-/* Same as output_format = 0 but we know that -s flag was given
- * and we should not give default value to output_format.
- */
-#define DIFF_FORMAT_NO_OUTPUT	0x0800
-
 #define DIFF_FORMAT_CALLBACK	0x1000
 
 #define DIFF_FLAGS_INIT { 0 }
diff --git a/log-tree.c b/log-tree.c
index 143b86fecf..0b1097c0bf 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -873,7 +873,7 @@ int log_tree_diff_flush(struct rev_info *opt)
 
 	if (diff_queue_is_empty(&opt->diffopt)) {
 		int saved_fmt = opt->diffopt.output_format;
-		opt->diffopt.output_format = DIFF_FORMAT_NO_OUTPUT;
+		opt->diffopt.output_format = 0;
 		diff_flush(&opt->diffopt);
 		opt->diffopt.output_format = saved_fmt;
 		return 0;
@@ -881,7 +881,7 @@ int log_tree_diff_flush(struct rev_info *opt)
 
 	if (opt->loginfo && !opt->no_commit_id) {
 		show_log(opt);
-		if ((opt->diffopt.output_format & ~DIFF_FORMAT_NO_OUTPUT) &&
+		if (opt->diffopt.output_format &&
 		    opt->verbose_header &&
 		    opt->commit_format != CMIT_FMT_ONELINE &&
 		    !commit_format_is_empty(opt->commit_format)) {
diff --git a/merge-ort.c b/merge-ort.c
index 34ec2675a2..f1d1db4970 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3247,7 +3247,7 @@ static int detect_regular_renames(struct merge_options *opt,
 		diff_opts.rename_limit = 7000;
 	diff_opts.rename_score = opt->rename_score;
 	diff_opts.show_rename_progress = opt->show_rename_progress;
-	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	diff_opts.output_format = 0;
 	diff_setup_done(&diff_opts);
 
 	diff_queued_diff = renames->pairs[side_index];
@@ -3268,7 +3268,7 @@ static int detect_regular_renames(struct merge_options *opt,
 
 	renames->pairs[side_index] = diff_queued_diff;
 
-	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	diff_opts.output_format = 0;
 	diff_queued_diff.nr = 0;
 	diff_queued_diff.queue = NULL;
 	diff_flush(&diff_opts);
diff --git a/merge-recursive.c b/merge-recursive.c
index 9875bdb11c..3cc8c956eb 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1902,7 +1902,7 @@ static struct diff_queue_struct *get_diffpairs(struct merge_options *opt,
 	opts.rename_limit = (opt->rename_limit >= 0) ? opt->rename_limit : 7000;
 	opts.rename_score = opt->rename_score;
 	opts.show_rename_progress = opt->show_rename_progress;
-	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	opts.output_format = 0;
 	diff_setup_done(&opts);
 	diff_tree_oid(&o_tree->object.oid, &tree->object.oid, "", &opts);
 	diffcore_std(&opts);
@@ -1912,7 +1912,7 @@ static struct diff_queue_struct *get_diffpairs(struct merge_options *opt,
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
diff --git a/range-diff.c b/range-diff.c
index 240f13d8dd..db3f2a4958 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -542,7 +542,7 @@ static void output(struct string_list *a, struct string_list *b,
 			a_util = a->items[b_util->matching].util;
 			output_pair_header(&opts, patch_no_width,
 					   &buf, &dashes, a_util, b_util);
-			if (!(opts.output_format & DIFF_FORMAT_NO_OUTPUT))
+			if (opts.output_format)
 				patch_diff(a->items[b_util->matching].string,
 					   b->items[j].string, &opts);
 			a_util->shown = 1;
diff --git a/revision.c b/revision.c
index cf68b533fd..52c2f415c7 100644
--- a/revision.c
+++ b/revision.c
@@ -2966,7 +2966,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	}
 
 	/* Did the user ask for any diff output? Run the diff! */
-	if (revs->diffopt.output_format & ~(DIFF_FORMAT_DEFAULT | DIFF_FORMAT_NO_OUTPUT))
+	if (revs->diffopt.output_format & ~DIFF_FORMAT_DEFAULT)
 		revs->diff = 1;
 
 	/* Pickaxe, diff-filter and rename following need diffs */
@@ -3030,8 +3030,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		die(_("the option '%s' requires '%s'"), "--grep-reflog", "--walk-reflogs");
 
 	if (revs->line_level_traverse &&
-	    (revs->diffopt.output_format & ~(DIFF_FORMAT_DEFAULT | DIFF_FORMAT_PATCH | DIFF_FORMAT_NO_OUTPUT)))
-		die(_("-L does not yet support diff formats besides -p and -s"));
+	    (revs->diffopt.output_format & ~(DIFF_FORMAT_DEFAULT | DIFF_FORMAT_PATCH)))
+		die(_("-L does not yet support diff formats besides -p"));
 
 	if (revs->expand_tabs_in_log < 0)
 		revs->expand_tabs_in_log = revs->expand_tabs_in_log_default;
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index f876b0cc8e..3a43edb8d8 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -457,10 +457,7 @@ diff-tree --stat --compact-summary initial mode
 diff-tree -R --stat --compact-summary initial mode
 EOF
 
-# This should succeed as --patch followed by --no-patch sequence is to
-# be a no-op according to the manual page. In reality it breaks --raw
-# though. Needs to be fixed.
-test_expect_failure '--no-patch cancels --patch only' '
+test_expect_success '--no-patch cancels --patch only' '
 	git log --raw master >result &&
 	process_diffs result >expected &&
 	git log --patch --no-patch --raw >result &&
diff --git a/tree-diff.c b/tree-diff.c
index 69031d7cba..a2e872fbe7 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -613,7 +613,7 @@ static void try_to_follow_renames(const struct object_id *old_oid,
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

