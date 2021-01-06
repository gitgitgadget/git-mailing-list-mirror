Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC14DC43331
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 14:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B79B23100
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 14:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbhAFOou (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 09:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbhAFOou (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 09:44:50 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4834EC061358
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 06:44:09 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id k10so2640425wmi.3
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 06:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OdNAEZ7+kK8MVwNqDDxH2+zt2t/Si4j2DFAaYl/bCzo=;
        b=aHrDMQl+SXeb8gm+HswAlN/jMY5BR6HkfE3aDVRedwu1QVanO1UcvzB0U8EYWJhcn/
         /88csasdTNZ1XQyhmPZb3FV27XeFWi3NzN1XUuMkUwwsZDNgHP1OZWqTlG78qcIBShop
         py3bZ9WG4EvhY21OMnM858t7Bji39MHgd1Xler36L4NnlZzWGtVaj1m3UWCIk6nj75wG
         nMkXE4WyVY1u4keYUqQDYe2NiBlH/VCIakaWh8Y6K4ZcpTeg3BFzci4TCU66BDm2y+iQ
         X0PhwyhBJ3L4FjgC67Drn0Ar8sMzJHOcEraLL9O3J9zegEstyfencBQMovwm3farlMKg
         fPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OdNAEZ7+kK8MVwNqDDxH2+zt2t/Si4j2DFAaYl/bCzo=;
        b=YIn6zPnlSUIsYvVsgblG1X0OnlkeRBhHY877mBEpuudgEWb5IICeEJNgoEs29eploY
         waU3vt9sbFnOg/iC4u9NY/Kvjf9ovF/vvnyzy/XRNJ6mfLhQrhkOGUVVujW0tNkxHjT/
         YmA22A60F6/60TQLmZF90mMPC8PSGAJyPL/LCBWArUg5UnPXJNACEzEE7RaEplx52gWI
         LzJ6Wju0PCIJMwtq6OO5jvRW3z8WgiRP6HIV2uTcnYhhyXz0MAxpIXZolgILweycsQHD
         N4V15PNK4Nv8FynsiL+ompAToTQo08YCUotdz+HU19UnhXJZ3+/5yg0kBZj9d6OLc8jH
         rPwg==
X-Gm-Message-State: AOAM532bph2HwcWflZ863uD2dOb5AdisLaTloCHrc4XMGB+WCmaJdE2n
        D9HznF9HCJ9TI8neYIznmsmvtBr+NjU=
X-Google-Smtp-Source: ABdhPJzqaqSfNxFhAnzHT9W62A0ytkDpKkx5PYgbzT6q4omHJYMK+yn2umgchcFIfclObnk6EbijPg==
X-Received: by 2002:a1c:6287:: with SMTP id w129mr3903037wmb.71.1609944247472;
        Wed, 06 Jan 2021 06:44:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s63sm3625956wms.18.2021.01.06.06.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 06:44:06 -0800 (PST)
Message-Id: <d3eb6dcff1468645560c16e1d8753002cbd7f143.1609944243.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.822.v3.git.1609944243.gitgitgadget@gmail.com>
References: <pull.822.v2.git.1609933875.gitgitgadget@gmail.com>
        <pull.822.v3.git.1609944243.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 Jan 2021 14:44:03 +0000
Subject: [PATCH v3 2/2] builtin/*: update usage format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88?= <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

According to the guidelines in parse-options.h,
we should not end in a full stop or start with
a capital letter. Fix old error and usage
messages to match this expectation.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 builtin/am.c                |  4 ++--
 builtin/blame.c             | 48 ++++++++++++++++++-------------------
 builtin/commit-graph.c      |  6 ++---
 builtin/fast-export.c       | 22 ++++++++---------
 builtin/log.c               |  8 +++----
 builtin/shortlog.c          | 10 ++++----
 builtin/submodule--helper.c | 24 +++++++++----------
 7 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index f22c73a05b0..8355e3566ff 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2284,10 +2284,10 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 			N_("skip the current patch"),
 			RESUME_SKIP),
 		OPT_CMDMODE(0, "abort", &resume.mode,
-			N_("restore the original branch and abort the patching operation."),
+			N_("restore the original branch and abort the patching operation"),
 			RESUME_ABORT),
 		OPT_CMDMODE(0, "quit", &resume.mode,
-			N_("abort the patching operation but keep HEAD where it is."),
+			N_("abort the patching operation but keep HEAD where it is"),
 			RESUME_QUIT),
 		{ OPTION_CALLBACK, 0, "show-current-patch", &resume.mode,
 		  "(diff|raw)",
diff --git a/builtin/blame.c b/builtin/blame.c
index 6f7e32411a8..2c1c02c455d 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -866,33 +866,33 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	const char *revs_file = NULL;
 	const char *contents_from = NULL;
 	const struct option options[] = {
-		OPT_BOOL(0, "incremental", &incremental, N_("Show blame entries as we find them, incrementally")),
-		OPT_BOOL('b', NULL, &blank_boundary, N_("Do not show object names of boundary commits (Default: off)")),
-		OPT_BOOL(0, "root", &show_root, N_("Do not treat root commits as boundaries (Default: off)")),
-		OPT_BOOL(0, "show-stats", &show_stats, N_("Show work cost statistics")),
-		OPT_BOOL(0, "progress", &show_progress, N_("Force progress reporting")),
-		OPT_BIT(0, "score-debug", &output_option, N_("Show output score for blame entries"), OUTPUT_SHOW_SCORE),
-		OPT_BIT('f', "show-name", &output_option, N_("Show original filename (Default: auto)"), OUTPUT_SHOW_NAME),
-		OPT_BIT('n', "show-number", &output_option, N_("Show original linenumber (Default: off)"), OUTPUT_SHOW_NUMBER),
-		OPT_BIT('p', "porcelain", &output_option, N_("Show in a format designed for machine consumption"), OUTPUT_PORCELAIN),
-		OPT_BIT(0, "line-porcelain", &output_option, N_("Show porcelain format with per-line commit information"), OUTPUT_PORCELAIN|OUTPUT_LINE_PORCELAIN),
-		OPT_BIT('c', NULL, &output_option, N_("Use the same output mode as git-annotate (Default: off)"), OUTPUT_ANNOTATE_COMPAT),
-		OPT_BIT('t', NULL, &output_option, N_("Show raw timestamp (Default: off)"), OUTPUT_RAW_TIMESTAMP),
-		OPT_BIT('l', NULL, &output_option, N_("Show long commit SHA1 (Default: off)"), OUTPUT_LONG_OBJECT_NAME),
-		OPT_BIT('s', NULL, &output_option, N_("Suppress author name and timestamp (Default: off)"), OUTPUT_NO_AUTHOR),
-		OPT_BIT('e', "show-email", &output_option, N_("Show author email instead of name (Default: off)"), OUTPUT_SHOW_EMAIL),
-		OPT_BIT('w', NULL, &xdl_opts, N_("Ignore whitespace differences"), XDF_IGNORE_WHITESPACE),
-		OPT_STRING_LIST(0, "ignore-rev", &ignore_rev_list, N_("rev"), N_("Ignore <rev> when blaming")),
-		OPT_STRING_LIST(0, "ignore-revs-file", &ignore_revs_file_list, N_("file"), N_("Ignore revisions from <file>")),
+		OPT_BOOL(0, "incremental", &incremental, N_("show blame entries as we find them, incrementally")),
+		OPT_BOOL('b', NULL, &blank_boundary, N_("do not show object names of boundary commits (Default: off)")),
+		OPT_BOOL(0, "root", &show_root, N_("do not treat root commits as boundaries (Default: off)")),
+		OPT_BOOL(0, "show-stats", &show_stats, N_("show work cost statistics")),
+		OPT_BOOL(0, "progress", &show_progress, N_("force progress reporting")),
+		OPT_BIT(0, "score-debug", &output_option, N_("show output score for blame entries"), OUTPUT_SHOW_SCORE),
+		OPT_BIT('f', "show-name", &output_option, N_("show original filename (Default: auto)"), OUTPUT_SHOW_NAME),
+		OPT_BIT('n', "show-number", &output_option, N_("show original linenumber (Default: off)"), OUTPUT_SHOW_NUMBER),
+		OPT_BIT('p', "porcelain", &output_option, N_("show in a format designed for machine consumption"), OUTPUT_PORCELAIN),
+		OPT_BIT(0, "line-porcelain", &output_option, N_("show porcelain format with per-line commit information"), OUTPUT_PORCELAIN|OUTPUT_LINE_PORCELAIN),
+		OPT_BIT('c', NULL, &output_option, N_("use the same output mode as git-annotate (Default: off)"), OUTPUT_ANNOTATE_COMPAT),
+		OPT_BIT('t', NULL, &output_option, N_("show raw timestamp (Default: off)"), OUTPUT_RAW_TIMESTAMP),
+		OPT_BIT('l', NULL, &output_option, N_("show long commit SHA1 (Default: off)"), OUTPUT_LONG_OBJECT_NAME),
+		OPT_BIT('s', NULL, &output_option, N_("suppress author name and timestamp (Default: off)"), OUTPUT_NO_AUTHOR),
+		OPT_BIT('e', "show-email", &output_option, N_("show author email instead of name (Default: off)"), OUTPUT_SHOW_EMAIL),
+		OPT_BIT('w', NULL, &xdl_opts, N_("ignore whitespace differences"), XDF_IGNORE_WHITESPACE),
+		OPT_STRING_LIST(0, "ignore-rev", &ignore_rev_list, N_("rev"), N_("ignore <rev> when blaming")),
+		OPT_STRING_LIST(0, "ignore-revs-file", &ignore_revs_file_list, N_("file"), N_("ignore revisions from <file>")),
 		OPT_BIT(0, "color-lines", &output_option, N_("color redundant metadata from previous line differently"), OUTPUT_COLOR_LINE),
 		OPT_BIT(0, "color-by-age", &output_option, N_("color lines by age"), OUTPUT_SHOW_AGE_WITH_COLOR),
-		OPT_BIT(0, "minimal", &xdl_opts, N_("Spend extra cycles to find better match"), XDF_NEED_MINIMAL),
-		OPT_STRING('S', NULL, &revs_file, N_("file"), N_("Use revisions from <file> instead of calling git-rev-list")),
-		OPT_STRING(0, "contents", &contents_from, N_("file"), N_("Use <file>'s contents as the final image")),
-		OPT_CALLBACK_F('C', NULL, &opt, N_("score"), N_("Find line copies within and across files"), PARSE_OPT_OPTARG, blame_copy_callback),
-		OPT_CALLBACK_F('M', NULL, &opt, N_("score"), N_("Find line movements within and across files"), PARSE_OPT_OPTARG, blame_move_callback),
+		OPT_BIT(0, "minimal", &xdl_opts, N_("spend extra cycles to find better match"), XDF_NEED_MINIMAL),
+		OPT_STRING('S', NULL, &revs_file, N_("file"), N_("use revisions from <file> instead of calling git-rev-list")),
+		OPT_STRING(0, "contents", &contents_from, N_("file"), N_("use <file>'s contents as the final image")),
+		OPT_CALLBACK_F('C', NULL, &opt, N_("score"), N_("find line copies within and across files"), PARSE_OPT_OPTARG, blame_copy_callback),
+		OPT_CALLBACK_F('M', NULL, &opt, N_("score"), N_("find line movements within and across files"), PARSE_OPT_OPTARG, blame_move_callback),
 		OPT_STRING_LIST('L', NULL, &range_list, N_("range"),
-				N_("Process only line range <start>,<end> or function :<funcname>")),
+				N_("process only line range <start>,<end> or function :<funcname>")),
 		OPT__ABBREV(&abbrev),
 		OPT_END()
 	};
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 78fa08f43af..cd863152216 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -78,7 +78,7 @@ static int graph_verify(int argc, const char **argv)
 	static struct option builtin_commit_graph_verify_options[] = {
 		OPT_STRING(0, "object-dir", &opts.obj_dir,
 			   N_("dir"),
-			   N_("The object directory to store the graph")),
+			   N_("the object directory to store the graph")),
 		OPT_BOOL(0, "shallow", &opts.shallow,
 			 N_("if the commit-graph is split, only verify the tip file")),
 		OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting")),
@@ -208,7 +208,7 @@ static int graph_write(int argc, const char **argv)
 	static struct option builtin_commit_graph_write_options[] = {
 		OPT_STRING(0, "object-dir", &opts.obj_dir,
 			N_("dir"),
-			N_("The object directory to store the graph")),
+			N_("the object directory to store the graph")),
 		OPT_BOOL(0, "reachable", &opts.reachable,
 			N_("start walk at all refs")),
 		OPT_BOOL(0, "stdin-packs", &opts.stdin_packs,
@@ -314,7 +314,7 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
 	static struct option builtin_commit_graph_options[] = {
 		OPT_STRING(0, "object-dir", &opts.obj_dir,
 			N_("dir"),
-			N_("The object directory to store the graph")),
+			N_("the object directory to store the graph")),
 		OPT_END(),
 	};
 
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 0a60356b06e..85a76e0ef8b 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -1205,32 +1205,32 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 			     N_("select handling of commit messages in an alternate encoding"),
 			     parse_opt_reencode_mode),
 		OPT_STRING(0, "export-marks", &export_filename, N_("file"),
-			     N_("Dump marks to this file")),
+			     N_("dump marks to this file")),
 		OPT_STRING(0, "import-marks", &import_filename, N_("file"),
-			     N_("Import marks from this file")),
+			     N_("import marks from this file")),
 		OPT_STRING(0, "import-marks-if-exists",
 			     &import_filename_if_exists,
 			     N_("file"),
-			     N_("Import marks from this file if it exists")),
+			     N_("import marks from this file if it exists")),
 		OPT_BOOL(0, "fake-missing-tagger", &fake_missing_tagger,
-			 N_("Fake a tagger when tags lack one")),
+			 N_("fake a tagger when tags lack one")),
 		OPT_BOOL(0, "full-tree", &full_tree,
-			 N_("Output full tree for each commit")),
+			 N_("output full tree for each commit")),
 		OPT_BOOL(0, "use-done-feature", &use_done_feature,
-			     N_("Use the done feature to terminate the stream")),
-		OPT_BOOL(0, "no-data", &no_data, N_("Skip output of blob data")),
+			     N_("use the done feature to terminate the stream")),
+		OPT_BOOL(0, "no-data", &no_data, N_("skip output of blob data")),
 		OPT_STRING_LIST(0, "refspec", &refspecs_list, N_("refspec"),
-			     N_("Apply refspec to exported refs")),
+			     N_("apply refspec to exported refs")),
 		OPT_BOOL(0, "anonymize", &anonymize, N_("anonymize output")),
 		OPT_CALLBACK_F(0, "anonymize-map", &anonymized_seeds, N_("from:to"),
 			       N_("convert <from> to <to> in anonymized output"),
 			       PARSE_OPT_NONEG, parse_opt_anonymize_map),
 		OPT_BOOL(0, "reference-excluded-parents",
-			 &reference_excluded_commits, N_("Reference parents which are not in fast-export stream by object id")),
+			 &reference_excluded_commits, N_("reference parents which are not in fast-export stream by object id")),
 		OPT_BOOL(0, "show-original-ids", &show_original_ids,
-			    N_("Show original object ids of blobs/commits")),
+			    N_("show original object ids of blobs/commits")),
 		OPT_BOOL(0, "mark-tags", &mark_tags,
-			    N_("Label tags with mark ids")),
+			    N_("label tags with mark ids")),
 
 		OPT_END()
 	};
diff --git a/builtin/log.c b/builtin/log.c
index bd6ff4f9f95..f23ccdbec32 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -177,7 +177,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	const struct option builtin_log_options[] = {
 		OPT__QUIET(&quiet, N_("suppress diff output")),
 		OPT_BOOL(0, "source", &source, N_("show source")),
-		OPT_BOOL(0, "use-mailmap", &mailmap, N_("Use mail map file")),
+		OPT_BOOL(0, "use-mailmap", &mailmap, N_("use mail map file")),
 		OPT_ALIAS(0, "mailmap", "use-mailmap"),
 		OPT_STRING_LIST(0, "decorate-refs", &decorate_refs_include,
 				N_("pattern"), N_("only decorate refs that match <pattern>")),
@@ -186,7 +186,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 		OPT_CALLBACK_F(0, "decorate", NULL, NULL, N_("decorate options"),
 			       PARSE_OPT_OPTARG, decorate_callback),
 		OPT_CALLBACK('L', NULL, &line_cb, "range:file",
-			     N_("Trace the evolution of line range <start>,<end> or function :<funcname> in <file>"),
+			     N_("trace the evolution of line range <start>,<end> or function :<funcname> in <file>"),
 			     log_line_range_callback),
 		OPT_END()
 	};
@@ -1757,13 +1757,13 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		OPT_INTEGER(0, "filename-max-length", &fmt_patch_name_max,
 			    N_("max length of output filename")),
 		OPT_CALLBACK_F(0, "rfc", &rev, NULL,
-			    N_("Use [RFC PATCH] instead of [PATCH]"),
+			    N_("use [RFC PATCH] instead of [PATCH]"),
 			    PARSE_OPT_NOARG | PARSE_OPT_NONEG, rfc_callback),
 		OPT_STRING(0, "cover-from-description", &cover_from_description_arg,
 			    N_("cover-from-description-mode"),
 			    N_("generate parts of a cover letter based on a branch's description")),
 		OPT_CALLBACK_F(0, "subject-prefix", &rev, N_("prefix"),
-			    N_("Use [<prefix>] instead of [PATCH]"),
+			    N_("use [<prefix>] instead of [PATCH]"),
 			    PARSE_OPT_NONEG, subject_prefix_callback),
 		OPT_CALLBACK_F('o', "output-directory", &output_directory,
 			    N_("dir"), N_("store resulting files in <dir>"),
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index c52e4ccd19a..1c0b3a9b05e 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -360,19 +360,19 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 
 	const struct option options[] = {
 		OPT_BIT('c', "committer", &log.groups,
-			N_("Group by committer rather than author"),
+			N_("group by committer rather than author"),
 			SHORTLOG_GROUP_COMMITTER),
 		OPT_BOOL('n', "numbered", &log.sort_by_number,
 			 N_("sort output according to the number of commits per author")),
 		OPT_BOOL('s', "summary", &log.summary,
-			 N_("Suppress commit descriptions, only provides commit count")),
+			 N_("suppress commit descriptions, only provides commit count")),
 		OPT_BOOL('e', "email", &log.email,
-			 N_("Show the email address of each author")),
+			 N_("show the email address of each author")),
 		OPT_CALLBACK_F('w', NULL, &log, N_("<w>[,<i1>[,<i2>]]"),
-			N_("Linewrap output"), PARSE_OPT_OPTARG,
+			N_("linewrap output"), PARSE_OPT_OPTARG,
 			&parse_wrap_args),
 		OPT_CALLBACK(0, "group", &log, N_("field"),
-			N_("Group by field"), parse_group_option),
+			N_("group by field"), parse_group_option),
 		OPT_END(),
 	};
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c30896c8978..c2bd882d17e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -562,9 +562,9 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 	struct module_list list = MODULE_LIST_INIT;
 
 	struct option module_foreach_options[] = {
-		OPT__QUIET(&info.quiet, N_("Suppress output of entering each submodule command")),
+		OPT__QUIET(&info.quiet, N_("suppress output of entering each submodule command")),
 		OPT_BOOL(0, "recursive", &info.recursive,
-			 N_("Recurse into nested submodules")),
+			 N_("recurse into nested submodules")),
 		OPT_END()
 	};
 
@@ -706,7 +706,7 @@ static int module_init(int argc, const char **argv, const char *prefix)
 	int quiet = 0;
 
 	struct option module_init_options[] = {
-		OPT__QUIET(&quiet, N_("Suppress output for initializing a submodule")),
+		OPT__QUIET(&quiet, N_("suppress output for initializing a submodule")),
 		OPT_END()
 	};
 
@@ -883,8 +883,8 @@ static int module_status(int argc, const char **argv, const char *prefix)
 	int quiet = 0;
 
 	struct option module_status_options[] = {
-		OPT__QUIET(&quiet, N_("Suppress submodule status output")),
-		OPT_BIT(0, "cached", &info.flags, N_("Use commit stored in the index instead of the one stored in the submodule HEAD"), OPT_CACHED),
+		OPT__QUIET(&quiet, N_("suppress submodule status output")),
+		OPT_BIT(0, "cached", &info.flags, N_("use commit stored in the index instead of the one stored in the submodule HEAD"), OPT_CACHED),
 		OPT_BIT(0, "recursive", &info.flags, N_("recurse into nested submodules"), OPT_RECURSIVE),
 		OPT_END()
 	};
@@ -1482,9 +1482,9 @@ static int module_sync(int argc, const char **argv, const char *prefix)
 	int recursive = 0;
 
 	struct option module_sync_options[] = {
-		OPT__QUIET(&quiet, N_("Suppress output of synchronizing submodule url")),
+		OPT__QUIET(&quiet, N_("suppress output of synchronizing submodule url")),
 		OPT_BOOL(0, "recursive", &recursive,
-			N_("Recurse into nested submodules")),
+			N_("recurse into nested submodules")),
 		OPT_END()
 	};
 
@@ -1620,9 +1620,9 @@ static int module_deinit(int argc, const char **argv, const char *prefix)
 	int all = 0;
 
 	struct option module_deinit_options[] = {
-		OPT__QUIET(&quiet, N_("Suppress submodule status output")),
-		OPT__FORCE(&force, N_("Remove submodule working trees even if they contain local changes"), 0),
-		OPT_BOOL(0, "all", &all, N_("Unregister all submodules")),
+		OPT__QUIET(&quiet, N_("suppress submodule status output")),
+		OPT__FORCE(&force, N_("remove submodule working trees even if they contain local changes"), 0),
+		OPT_BOOL(0, "all", &all, N_("unregister all submodules")),
 		OPT_END()
 	};
 
@@ -2337,7 +2337,7 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "dissociate", &suc.dissociate,
 			   N_("use --reference only while cloning")),
 		OPT_STRING(0, "depth", &suc.depth, "<depth>",
-			   N_("Create a shallow clone truncated to the "
+			   N_("create a shallow clone truncated to the "
 			      "specified number of revisions")),
 		OPT_INTEGER('j', "jobs", &suc.max_jobs,
 			    N_("parallel jobs")),
@@ -2678,7 +2678,7 @@ static int module_set_url(int argc, const char **argv, const char *prefix)
 	char *config_name;
 
 	struct option options[] = {
-		OPT__QUIET(&quiet, N_("Suppress output for setting url of a submodule")),
+		OPT__QUIET(&quiet, N_("suppress output for setting url of a submodule")),
 		OPT_END()
 	};
 	const char *const usage[] = {
-- 
gitgitgadget
