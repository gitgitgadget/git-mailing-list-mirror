Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F423C77B7C
	for <git@archiver.kernel.org>; Fri, 12 May 2023 08:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240183AbjELIDv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 04:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240136AbjELIDq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 04:03:46 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8801BFA
        for <git@vger.kernel.org>; Fri, 12 May 2023 01:03:44 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1929818d7faso56105626fac.0
        for <git@vger.kernel.org>; Fri, 12 May 2023 01:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683878623; x=1686470623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVjmBB5YDIDifLGj1oI9I78bKgR6D8yOOd6FyYOfyw8=;
        b=sOV2OHC0k6gpVVPDsxSNUOnEU9SkixP3heaZrnQoTRdALXePodOT17Qbadsbjtg4QI
         2HWJGal7O7fk6PsNLjcmjHlWLCZvHYzlmmVdIyo08a5Lxy+ZvrCse5RRQBM+m3lcIe1i
         dw676K7NqP1tGbLrtJ/vnP1eDwuXs+syf/geSVqKFhqVF490Yk0Olnk4xJCwO2lQJtKM
         FzFRXrI4+eTL56RCSfiSkptqmaJIduewUafUWBie44cinVtFNvTaJsAkNnKaj78iz4tI
         iK7NnidMJRRTgxRQe0PJyK7GbGKIhynhO/5IK6a90ojlpGnsa4c1C0ZHGZHHWfqSC/BK
         z6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683878623; x=1686470623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rVjmBB5YDIDifLGj1oI9I78bKgR6D8yOOd6FyYOfyw8=;
        b=bUe4WozzlkLX0sLqk+FSEmHMsPZpdqT/L35Fwsoy0gfTcjwGkrx7tjxaLRWY157f1F
         eW2iCeGL4aR5ZHx6u2lGQGY4QE1ALbeWpvwHBjBqeg5lUno8ubmTK05ny0euujSEAGYY
         svmLMJNMLeGf/gx2tuDUirdt3UHdZQW3alj3JtswPXC99GbP4HkBY5jFXzjr6Hf4uvzL
         vA3IOoyxYefkwOFkV3PvsYWRGcGNVN4yyeTxL/5Y4Vfg0J3Ib5zNalZGP/gp1XwS7sjM
         Ywsk7YpsHFstEZemqwxrE5FOMIasH8parvQ9ofIeTsuL/juvCIrz0xzrVzUhmBdIYrwf
         5LwQ==
X-Gm-Message-State: AC+VfDyaF7ludD2nJfJleQadLvGECfL4+mw/LWRRg59+yKH6ejo8pezy
        y7iQ8ElFhL43IbXdjxgcdnT6hslHpvU=
X-Google-Smtp-Source: ACHHUZ42s6Z0W5odv47quMOaiHLGuKgsHnrQHYjeO9GeEDmtQ6PrFPBjOOY6FmqDjrk/K12davUTpQ==
X-Received: by 2002:aca:bdc4:0:b0:38e:a925:8f95 with SMTP id n187-20020acabdc4000000b0038ea9258f95mr5592794oif.26.1683878622927;
        Fri, 12 May 2023 01:03:42 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id v3-20020acade03000000b0038dd5bf922bsm4281300oig.22.2023.05.12.01.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 01:03:42 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 2/7] diff: introduce DIFF_FORMAT_DEFAULT
Date:   Fri, 12 May 2023 02:03:34 -0600
Message-Id: <20230512080339.2186324-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230512080339.2186324-1-felipe.contreras@gmail.com>
References: <20230512080339.2186324-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As the name suggests this is the default format, which means no format
was specified.

This is not the same as DIFF_FORMAT_PATCH, as some commands like `git
diff-files` use a different default.

This makes it possible to distinguish `git diff` (DEFAULT)
from  `git diff --no-patch` (0).

Will help further changes.

There should be no functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/diff-files.c |  2 +-
 builtin/diff-index.c |  2 +-
 builtin/diff-tree.c  |  2 +-
 builtin/diff.c       |  2 +-
 builtin/log.c        | 13 ++++++++-----
 builtin/stash.c      |  2 +-
 diff-merges.c        |  2 +-
 diff-no-index.c      |  2 +-
 diff.c               | 39 ++++++++++++++++++++-------------------
 diff.h               |  1 +
 range-diff.c         |  2 +-
 revision.c           |  4 ++--
 12 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index dc991f753b..b831b89236 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -52,7 +52,7 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 			usage(diff_files_usage);
 		argv++; argc--;
 	}
-	if (!rev.diffopt.output_format)
+	if (rev.diffopt.output_format == DIFF_FORMAT_DEFAULT)
 		rev.diffopt.output_format = DIFF_FORMAT_RAW;
 	rev.diffopt.rotate_to_strict = 1;
 
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index b9a19bb7d3..863c51c9b5 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -48,7 +48,7 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 		else
 			usage(diff_cache_usage);
 	}
-	if (!rev.diffopt.output_format)
+	if (rev.diffopt.output_format == DIFF_FORMAT_DEFAULT)
 		rev.diffopt.output_format = DIFF_FORMAT_RAW;
 
 	rev.diffopt.rotate_to_strict = 1;
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 0b02c62b85..7e9164187c 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -100,7 +100,7 @@ COMMON_DIFF_OPTIONS_HELP;
 
 static void diff_tree_tweak_rev(struct rev_info *rev, struct setup_revision_opt *opt)
 {
-	if (!rev->diffopt.output_format) {
+	if (rev->diffopt.output_format == DIFF_FORMAT_DEFAULT) {
 		if (rev->dense_combined_merges)
 			rev->diffopt.output_format = DIFF_FORMAT_PATCH;
 		else
diff --git a/builtin/diff.c b/builtin/diff.c
index 7b64659fe7..2decf5e531 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -505,7 +505,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	if (nongit)
 		die(_("Not a git repository"));
 	argc = setup_revisions(argc, argv, &rev, NULL);
-	if (!rev.diffopt.output_format) {
+	if (rev.diffopt.output_format == DIFF_FORMAT_DEFAULT) {
 		rev.diffopt.output_format = DIFF_FORMAT_PATCH;
 		diff_setup_done(&rev.diffopt);
 	}
diff --git a/builtin/log.c b/builtin/log.c
index 712bfbf5c2..d2a81f36c2 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -277,7 +277,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 			     PARSE_OPT_KEEP_DASHDASH);
 
 	if (quiet)
-		rev->diffopt.output_format |= DIFF_FORMAT_NO_OUTPUT;
+		rev->diffopt.output_format = DIFF_FORMAT_NO_OUTPUT;
 	argc = setup_revisions(argc, argv, rev, opt);
 
 	/* Any arguments at this point are not recognized */
@@ -633,7 +633,7 @@ int cmd_whatchanged(int argc, const char **argv, const char *prefix)
 	opt.def = "HEAD";
 	opt.revarg_opt = REVARG_COMMITTISH;
 	cmd_log_init(argc, argv, prefix, &rev, &opt);
-	if (!rev.diffopt.output_format)
+	if (rev.diffopt.output_format == DIFF_FORMAT_DEFAULT)
 		rev.diffopt.output_format = DIFF_FORMAT_RAW;
 	return cmd_log_deinit(cmd_log_walk(&rev), &rev);
 }
@@ -725,7 +725,7 @@ static void show_setup_revisions_tweak(struct rev_info *rev,
 		diff_merges_default_to_first_parent(rev);
 	else
 		diff_merges_default_to_dense_combined(rev);
-	if (!rev->diffopt.output_format)
+	if (rev->diffopt.output_format == DIFF_FORMAT_DEFAULT)
 		rev->diffopt.output_format = DIFF_FORMAT_PATCH;
 }
 
@@ -891,9 +891,12 @@ int cmd_log(int argc, const char **argv, const char *prefix)
 	opt.tweak = log_setup_revisions_tweak;
 	cmd_log_init(argc, argv, prefix, &rev, &opt);
 
-	if (!rev.diffopt.output_format)
+	if (rev.diffopt.output_format == DIFF_FORMAT_DEFAULT) {
 		if (rev.line_level_traverse)
 			rev.diffopt.output_format = DIFF_FORMAT_PATCH;
+		else
+			rev.diffopt.output_format = 0;
+	}
 
 	return cmd_log_deinit(cmd_log_walk(&rev), &rev);
 }
@@ -2126,7 +2129,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		die(_("--remerge-diff does not make sense"));
 
 	if (!use_patch_format &&
-		(!rev.diffopt.output_format ||
+		(rev.diffopt.output_format == DIFF_FORMAT_DEFAULT ||
 		 rev.diffopt.output_format == DIFF_FORMAT_PATCH))
 		rev.diffopt.output_format = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_SUMMARY;
 	if (!rev.diffopt.stat_width)
diff --git a/builtin/stash.c b/builtin/stash.c
index a7e17ffe38..398e3c9f61 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -944,7 +944,7 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 	argc = setup_revisions(revision_args.nr, revision_args.v, &rev, NULL);
 	if (argc > 1)
 		goto usage;
-	if (!rev.diffopt.output_format) {
+	if (rev.diffopt.output_format == DIFF_FORMAT_DEFAULT) {
 		rev.diffopt.output_format = DIFF_FORMAT_PATCH;
 		diff_setup_done(&rev.diffopt);
 	}
diff --git a/diff-merges.c b/diff-merges.c
index ec97616db1..9960d7cc36 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -183,7 +183,7 @@ void diff_merges_setup_revs(struct rev_info *revs)
 	if (revs->merges_imply_patch)
 		revs->diff = 1;
 	if (revs->merges_imply_patch || revs->merges_need_diff) {
-		if (!revs->diffopt.output_format)
+		if (revs->diffopt.output_format == DIFF_FORMAT_DEFAULT)
 			revs->diffopt.output_format = DIFF_FORMAT_PATCH;
 	}
 }
diff --git a/diff-no-index.c b/diff-no-index.c
index 4296940f90..45596cb1be 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -282,7 +282,7 @@ int diff_no_index(struct rev_info *revs,
 	fixup_paths(paths, &replacement);
 
 	revs->diffopt.skip_stat_unmatch = 1;
-	if (!revs->diffopt.output_format)
+	if (revs->diffopt.output_format == DIFF_FORMAT_DEFAULT)
 		revs->diffopt.output_format = DIFF_FORMAT_PATCH;
 
 	revs->diffopt.flags.no_index = 1;
diff --git a/diff.c b/diff.c
index 71513d92e8..387944f289 100644
--- a/diff.c
+++ b/diff.c
@@ -4669,6 +4669,7 @@ void repo_diff_setup(struct repository *r, struct diff_options *options)
 	options->file = stdout;
 	options->repo = r;
 
+	options->output_format = DIFF_FORMAT_DEFAULT;
 	options->output_indicators[OUTPUT_INDICATOR_NEW] = '+';
 	options->output_indicators[OUTPUT_INDICATOR_OLD] = '-';
 	options->output_indicators[OUTPUT_INDICATOR_CONTEXT] = ' ';
@@ -4987,7 +4988,7 @@ static int diff_opt_diff_filter(const struct option *option,
 
 static void enable_patch_output(int *fmt)
 {
-	*fmt &= ~DIFF_FORMAT_NO_OUTPUT;
+	*fmt &= ~(DIFF_FORMAT_DEFAULT | DIFF_FORMAT_NO_OUTPUT);
 	*fmt |= DIFF_FORMAT_PATCH;
 }
 
@@ -5492,13 +5493,13 @@ struct option *add_diff_options(const struct option *opts,
 		OPT_GROUP(N_("Diff output format options")),
 		OPT_BITOP('p', "patch", &options->output_format,
 			  N_("generate patch"),
-			  DIFF_FORMAT_PATCH, DIFF_FORMAT_NO_OUTPUT),
-		OPT_BIT_F('s', "no-patch", &options->output_format,
+			  DIFF_FORMAT_PATCH, DIFF_FORMAT_DEFAULT | DIFF_FORMAT_NO_OUTPUT),
+		OPT_BITOP('s', "no-patch", &options->output_format,
 			  N_("suppress diff output"),
-			  DIFF_FORMAT_NO_OUTPUT, PARSE_OPT_NONEG),
+			  DIFF_FORMAT_NO_OUTPUT, DIFF_FORMAT_DEFAULT | DIFF_FORMAT_PATCH),
 		OPT_BITOP('u', NULL, &options->output_format,
 			  N_("generate patch"),
-			  DIFF_FORMAT_PATCH, DIFF_FORMAT_NO_OUTPUT),
+			  DIFF_FORMAT_PATCH, DIFF_FORMAT_DEFAULT | DIFF_FORMAT_NO_OUTPUT),
 		OPT_CALLBACK_F('U', "unified", options, N_("<n>"),
 			       N_("generate diffs with <n> lines context"),
 			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG, diff_opt_unified),
@@ -5510,17 +5511,17 @@ struct option *add_diff_options(const struct option *opts,
 		OPT_BITOP(0, "patch-with-raw", &options->output_format,
 			  N_("synonym for '-p --raw'"),
 			  DIFF_FORMAT_PATCH | DIFF_FORMAT_RAW,
-			  DIFF_FORMAT_NO_OUTPUT),
+			  DIFF_FORMAT_DEFAULT | DIFF_FORMAT_NO_OUTPUT),
 		OPT_BITOP(0, "patch-with-stat", &options->output_format,
 			  N_("synonym for '-p --stat'"),
 			  DIFF_FORMAT_PATCH | DIFF_FORMAT_DIFFSTAT,
-			  DIFF_FORMAT_NO_OUTPUT),
-		OPT_BIT_F(0, "numstat", &options->output_format,
+			  DIFF_FORMAT_DEFAULT | DIFF_FORMAT_NO_OUTPUT),
+		OPT_BITOP(0, "numstat", &options->output_format,
 			  N_("machine friendly --stat"),
-			  DIFF_FORMAT_NUMSTAT, PARSE_OPT_NONEG),
-		OPT_BIT_F(0, "shortstat", &options->output_format,
+			  DIFF_FORMAT_NUMSTAT, DIFF_FORMAT_DEFAULT),
+		OPT_BITOP(0, "shortstat", &options->output_format,
 			  N_("output only the last line of --stat"),
-			  DIFF_FORMAT_SHORTSTAT, PARSE_OPT_NONEG),
+			  DIFF_FORMAT_SHORTSTAT, DIFF_FORMAT_DEFAULT),
 		OPT_CALLBACK_F('X', "dirstat", options, N_("<param1,param2>..."),
 			       N_("output the distribution of relative amount of changes for each sub-directory"),
 			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
@@ -5533,18 +5534,18 @@ struct option *add_diff_options(const struct option *opts,
 			       N_("synonym for --dirstat=files,param1,param2..."),
 			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
 			       diff_opt_dirstat),
-		OPT_BIT_F(0, "check", &options->output_format,
+		OPT_BITOP(0, "check", &options->output_format,
 			  N_("warn if changes introduce conflict markers or whitespace errors"),
-			  DIFF_FORMAT_CHECKDIFF, PARSE_OPT_NONEG),
-		OPT_BIT_F(0, "summary", &options->output_format,
+			  DIFF_FORMAT_CHECKDIFF, DIFF_FORMAT_DEFAULT),
+		OPT_BITOP(0, "summary", &options->output_format,
 			  N_("condensed summary such as creations, renames and mode changes"),
-			  DIFF_FORMAT_SUMMARY, PARSE_OPT_NONEG),
-		OPT_BIT_F(0, "name-only", &options->output_format,
+			  DIFF_FORMAT_SUMMARY, DIFF_FORMAT_DEFAULT),
+		OPT_BITOP(0, "name-only", &options->output_format,
 			  N_("show only names of changed files"),
-			  DIFF_FORMAT_NAME, PARSE_OPT_NONEG),
-		OPT_BIT_F(0, "name-status", &options->output_format,
+			  DIFF_FORMAT_NAME, DIFF_FORMAT_DEFAULT),
+		OPT_BITOP(0, "name-status", &options->output_format,
 			  N_("show only names and status of changed files"),
-			  DIFF_FORMAT_NAME_STATUS, PARSE_OPT_NONEG),
+			  DIFF_FORMAT_NAME_STATUS, DIFF_FORMAT_DEFAULT),
 		OPT_CALLBACK_F(0, "stat", options, N_("<width>[,<name-width>[,<count>]]"),
 			       N_("generate diffstat"),
 			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG, diff_opt_stat),
diff --git a/diff.h b/diff.h
index 3a7a9e8b88..15a7bf2c9f 100644
--- a/diff.h
+++ b/diff.h
@@ -101,6 +101,7 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 #define DIFF_FORMAT_PATCH	0x0010
 #define DIFF_FORMAT_SHORTSTAT	0x0020
 #define DIFF_FORMAT_DIRSTAT	0x0040
+#define DIFF_FORMAT_DEFAULT	0x0080
 
 /* These override all above */
 #define DIFF_FORMAT_NAME	0x0100
diff --git a/range-diff.c b/range-diff.c
index 6a704e6f47..6c1ae9dd34 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -492,7 +492,7 @@ static void output(struct string_list *a, struct string_list *b,
 		repo_diff_setup(the_repository, &opts);
 
 	opts.no_free = 1;
-	if (!opts.output_format)
+	if (opts.output_format == DIFF_FORMAT_DEFAULT)
 		opts.output_format = DIFF_FORMAT_PATCH;
 	opts.flags.suppress_diff_headers = 1;
 	opts.flags.dual_color_diffed_diffs =
diff --git a/revision.c b/revision.c
index b33cc1d106..cf68b533fd 100644
--- a/revision.c
+++ b/revision.c
@@ -2966,7 +2966,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	}
 
 	/* Did the user ask for any diff output? Run the diff! */
-	if (revs->diffopt.output_format & ~DIFF_FORMAT_NO_OUTPUT)
+	if (revs->diffopt.output_format & ~(DIFF_FORMAT_DEFAULT | DIFF_FORMAT_NO_OUTPUT))
 		revs->diff = 1;
 
 	/* Pickaxe, diff-filter and rename following need diffs */
@@ -3030,7 +3030,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		die(_("the option '%s' requires '%s'"), "--grep-reflog", "--walk-reflogs");
 
 	if (revs->line_level_traverse &&
-	    (revs->diffopt.output_format & ~(DIFF_FORMAT_PATCH | DIFF_FORMAT_NO_OUTPUT)))
+	    (revs->diffopt.output_format & ~(DIFF_FORMAT_DEFAULT | DIFF_FORMAT_PATCH | DIFF_FORMAT_NO_OUTPUT)))
 		die(_("-L does not yet support diff formats besides -p and -s"));
 
 	if (revs->expand_tabs_in_log < 0)
-- 
2.40.0+fc1

