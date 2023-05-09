Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE86C7EE22
	for <git@archiver.kernel.org>; Tue,  9 May 2023 00:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjEIAoV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 20:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjEIAoP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 20:44:15 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7683B72A6
        for <git@vger.kernel.org>; Mon,  8 May 2023 17:44:12 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-38e7ce73ca0so2575775b6e.2
        for <git@vger.kernel.org>; Mon, 08 May 2023 17:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683593051; x=1686185051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Jvf09mIbxCSwWervwM0gqUIUoW/eOPVTzLRShPiJHc=;
        b=A+AcFgTiurCwY/s+VUhMUcK7T7nTxaJIS2tEMvoHlzICPVR3VmtLgiNUMK0i85fjbs
         cWUECzYkVqGAKAOZ5vKLsTG7GTI6iRoKa9+Hk5GW9ZDOFxtQt2BddQU8cWuGmnh04Oq0
         QmJPhRaC5D7PW+pxDsdwFLeDM8adqEqdLqANhJsYj8vuANxreuwkiu19o2KlFvaSpW86
         j6s5+e5+8acMTrROiwZCl8iDqgY7coh0VunhP1DbzAc9291avhB6ijBwTeX4NiWoJ6OM
         cyTFFTmBu/dUqgHXU2IzJmUp/OY4HeVqU8mXsmTh/DAta+f2GJyUXbBaHdeKB+WwOWf6
         mt2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683593051; x=1686185051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Jvf09mIbxCSwWervwM0gqUIUoW/eOPVTzLRShPiJHc=;
        b=kA11bBi5QU/FGlmmxJ52oIWOUAzITnpWp+qsQMGYjiSYA2l4wlOst7Pg6PXgY/ypIP
         CP00/uhvn5DtWieaQ+5wTyl5obDm8GA3SXsX988C9Ya2gENwo8WU1fvgDbb4EBwbkWwH
         8ghQ9rY2yMV4O3o53p/RByliiGtDGjRr/3xFCDb56coN1qOXgVL6nAZPufSKYFSz8cXi
         67GOrL2MJXbI8/d83yBZFwqfl8cEw3wl5z/ampCukW/ltFBEgMroW6GdmiXY7dagkbRt
         9mttg90ldh4RuHVgA7Uf5xPRfAmCYgmUmO1/7hG19PO9/i+DQlxOliawEyLZHi7xZAjj
         XDzw==
X-Gm-Message-State: AC+VfDzwt0nspL4jY0pZx+A7nIvUCtJ6ZtYdQM6olW8J39wgd1FEXVoT
        mf7eSc3DhS98vRESpzXBkmPRZX0dSB4=
X-Google-Smtp-Source: ACHHUZ4ulvyolO8gGtHXbkicoDP+BSDo/6XNqvrKIt8JY2KwIe6bbonWa00VbMgnzNveSpJOHPg7nA==
X-Received: by 2002:aca:1803:0:b0:392:3ba:3a28 with SMTP id h3-20020aca1803000000b0039203ba3a28mr476404oih.11.1683593051331;
        Mon, 08 May 2023 17:44:11 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id x132-20020acae08a000000b0038c66c39131sm647533oig.5.2023.05.08.17.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 17:44:10 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 3/4] diff: introduce DIFF_FORMAT_DEFAULT
Date:   Mon,  8 May 2023 18:44:05 -0600
Message-Id: <20230509004406.1786033-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230509004406.1786033-1-felipe.contreras@gmail.com>
References: <20230509004406.1786033-1-felipe.contreras@gmail.com>
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
index 385c2d0230..75e5e96d05 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -99,7 +99,7 @@ COMMON_DIFF_OPTIONS_HELP;
 
 static void diff_tree_tweak_rev(struct rev_info *rev, struct setup_revision_opt *opt)
 {
-	if (!rev->diffopt.output_format) {
+	if (rev->diffopt.output_format == DIFF_FORMAT_DEFAULT) {
 		if (rev->dense_combined_merges)
 			rev->diffopt.output_format = DIFF_FORMAT_PATCH;
 		else
diff --git a/builtin/diff.c b/builtin/diff.c
index 5a6a5d7f4b..a01de13194 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -504,7 +504,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	if (nongit)
 		die(_("Not a git repository"));
 	argc = setup_revisions(argc, argv, &rev, NULL);
-	if (!rev.diffopt.output_format) {
+	if (rev.diffopt.output_format == DIFF_FORMAT_DEFAULT) {
 		rev.diffopt.output_format = DIFF_FORMAT_PATCH;
 		diff_setup_done(&rev.diffopt);
 	}
diff --git a/builtin/log.c b/builtin/log.c
index 568207916b..13c196c391 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -276,7 +276,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 			     PARSE_OPT_KEEP_DASHDASH);
 
 	if (quiet)
-		rev->diffopt.output_format |= DIFF_FORMAT_NO_OUTPUT;
+		rev->diffopt.output_format = DIFF_FORMAT_NO_OUTPUT;
 	argc = setup_revisions(argc, argv, rev, opt);
 
 	/* Any arguments at this point are not recognized */
@@ -632,7 +632,7 @@ int cmd_whatchanged(int argc, const char **argv, const char *prefix)
 	opt.def = "HEAD";
 	opt.revarg_opt = REVARG_COMMITTISH;
 	cmd_log_init(argc, argv, prefix, &rev, &opt);
-	if (!rev.diffopt.output_format)
+	if (rev.diffopt.output_format == DIFF_FORMAT_DEFAULT)
 		rev.diffopt.output_format = DIFF_FORMAT_RAW;
 	return cmd_log_deinit(cmd_log_walk(&rev), &rev);
 }
@@ -724,7 +724,7 @@ static void show_setup_revisions_tweak(struct rev_info *rev,
 		diff_merges_default_to_first_parent(rev);
 	else
 		diff_merges_default_to_dense_combined(rev);
-	if (!rev->diffopt.output_format)
+	if (rev->diffopt.output_format == DIFF_FORMAT_DEFAULT)
 		rev->diffopt.output_format = DIFF_FORMAT_PATCH;
 }
 
@@ -890,9 +890,12 @@ int cmd_log(int argc, const char **argv, const char *prefix)
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
@@ -2125,7 +2128,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
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
index 1e83aaee6b..c9077bfed6 100644
--- a/diff.c
+++ b/diff.c
@@ -4667,6 +4667,7 @@ void repo_diff_setup(struct repository *r, struct diff_options *options)
 	options->file = stdout;
 	options->repo = r;
 
+	options->output_format = DIFF_FORMAT_DEFAULT;
 	options->output_indicators[OUTPUT_INDICATOR_NEW] = '+';
 	options->output_indicators[OUTPUT_INDICATOR_OLD] = '-';
 	options->output_indicators[OUTPUT_INDICATOR_CONTEXT] = ' ';
@@ -4985,7 +4986,7 @@ static int diff_opt_diff_filter(const struct option *option,
 
 static void enable_patch_output(int *fmt)
 {
-	*fmt &= ~DIFF_FORMAT_NO_OUTPUT;
+	*fmt &= ~(DIFF_FORMAT_DEFAULT | DIFF_FORMAT_NO_OUTPUT);
 	*fmt |= DIFF_FORMAT_PATCH;
 }
 
@@ -5490,13 +5491,13 @@ struct option *add_diff_options(const struct option *opts,
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
@@ -5508,17 +5509,17 @@ struct option *add_diff_options(const struct option *opts,
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
@@ -5531,18 +5532,18 @@ struct option *add_diff_options(const struct option *opts,
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
index 6a0737b9c3..35bdbc40fa 100644
--- a/diff.h
+++ b/diff.h
@@ -102,6 +102,7 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 #define DIFF_FORMAT_PATCH	0x0010
 #define DIFF_FORMAT_SHORTSTAT	0x0020
 #define DIFF_FORMAT_DIRSTAT	0x0040
+#define DIFF_FORMAT_DEFAULT	0x0080
 
 /* These override all above */
 #define DIFF_FORMAT_NAME	0x0100
diff --git a/range-diff.c b/range-diff.c
index a1e0cffb9f..240f13d8dd 100644
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

