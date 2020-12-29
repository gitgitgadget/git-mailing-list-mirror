Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DACCC433DB
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 08:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53B5A207CF
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 08:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgL2Iz6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Dec 2020 03:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgL2Iz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Dec 2020 03:55:57 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD14DC061793
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 00:55:16 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id c133so2086723wme.4
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 00:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=EesnEpbzpSwcqtZJtmr2IIUlJtE4nAnX9Q/4nKMi9zI=;
        b=odzkTUoVE7Ow3BA1os/nJ6aab2kdDed6ch/df2qS0+3mgJ1jzWGpVy0A5E2X3CwRgN
         V8ErdF/KSUG1bJiE5JTqcl9tcyjMQ7z2Merzc3/NNxIAHafNboFhuft2u2bNcEUuXKhS
         ELrh8aJ1HrGEcu4i1w2z4qh9NjZmrBUDhBOaMGrCEoaZBAtxnOofn4N6wENuXKso4uT6
         OVXBzfXelaZYBpX34LfDUo1E0bhB4ITJcei2HQXL9Mtc4OlpbRwGc5qgFXoxlmUT+q+r
         4FzsEZy1CjESzJVEqvunf2ip+RGKdAZ7NAfBjlGUFWGDDk2YuuCfmuJmziU5mSDu330v
         rCtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EesnEpbzpSwcqtZJtmr2IIUlJtE4nAnX9Q/4nKMi9zI=;
        b=Nfo4KVj85BuPiWqPVcL9VAhGfe95VbUju2N4w/SxPK4cg3VgJCoWnkMp80cLk3DSHE
         KhEkT/BWc/y/9fUHiXDgAl+So/mE41jnr/dvkfk7SsYbTyLzQKVNhSR0TKxlVjao3bhn
         0LO1vrB9NibmSEBdwQrKhQL3LCYUxXsG6XJxz2BWJlLyoMXnyNK7zb4XwKD1KcEKDyyr
         xBYCSn47h4kmN4X+aeGDJUd4ILBmASTiwl69zRtsxgNlSWQuBnU1Qh869z6fdZr6DLeM
         uCGBLiPjYxl6nUYnG7rp+mweR2MBbRyRB8G5144yOQHx+BHAGPUC5lTszkJGo0TR1RSM
         ZEdQ==
X-Gm-Message-State: AOAM531kYDSoPsUHIWQddxUi1QUMp/e3lbClyV/+T93U10HhhsvnofJh
        gcwB3T5RA29y0Z4dXBVrOrd+jbWh/xQ=
X-Google-Smtp-Source: ABdhPJwQ41SJ4j86ZpPzL3GjKTdfEIGR6ut/R3Kv5wnKoU1QjWPCMy0Mbuo0y/hGGzn5pX6W0r6f4Q==
X-Received: by 2002:a1c:7909:: with SMTP id l9mr2602147wme.120.1609232115156;
        Tue, 29 Dec 2020 00:55:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t10sm57604849wrp.39.2020.12.29.00.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 00:55:14 -0800 (PST)
Message-Id: <pull.822.git.1609232114080.gitgitgadget@gmail.com>
From:   "=?UTF-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Tue, 29 Dec 2020 08:55:13 +0000
Subject: [PATCH] builtin/*: update usage format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88?= <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

According to the "Error Messages" section of
Documentation/CodingGuidelines, we should not end in a full
stop or start with a capital letter. Fix old error and usage
messages to match this expectation.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    builtin/*: update usage format
    
    According to the "Error Messages" section of
    Documentation/CodingGuidelines, we should not end in a full stop or
    start with a capital letter. Fix old error and usage messages to match
    this expectation.
    
    Signed-off-by: adl 1607364851@qq.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-822%2Fadlternative%2Fdev-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-822/adlternative/dev-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/822

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

base-commit: 6d3ef5b467eccd2769f1aa1c555d317d3c8dc707
-- 
gitgitgadget
