Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04792C433E0
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 13:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1CBA64DB1
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 13:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhBNNKN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 08:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhBNNKL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 08:10:11 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6C2C061574
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 05:09:30 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id o10so3110895wmc.1
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 05:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=49UV4j+8UdIqC6mRnJqGywHD+cCjtn4DqTDs5RuklOI=;
        b=PemyORS6Yz3aQTGX9qzAd03+tOCa6MPFGjC8Foqxuzkg2J+NPFh5+j3WKho0PSDRTy
         L+2X1N+U7rjJof5jxv/WFvxvPQV/orptH2fzZ0PGRXTCU1A2axnHbysrdmYxHOmvtThh
         UqaAYf3b9FQAXUJRBQd6n5bXvUO4QNHkh2k+MBT/Rv6EIXzicyeOCHOmeUC5qpTG++jP
         GS7Zguz8YLKk3yxnvTcDqhyZm8Sw/U3OAvSF3P7ebSe0aPqaWdg7vTnQ33RWk45Srdp5
         n/Y3KC4LgMrEwassrWvlCbTC1i7MWuW2SHg/67Hvu/MC+Ck3wouz48DD7QwQk3N/6tUw
         zErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=49UV4j+8UdIqC6mRnJqGywHD+cCjtn4DqTDs5RuklOI=;
        b=lfCcJkKtpimAHGd3FRmtBldUrLPVDQzjRUczB9sSENDe/wbWgaBJZXHTvcp+pFfCn2
         hgzob4ZHe6SYyTNNW059LOygZT11FG5D9z0+E34943k8mVx6US70vWybrbHvgqcKZzvi
         868D++7Yu8fueQe7QXVU8dvgLpPDe0IN21Lnmm2Tek5IiW2y+LelUG8aCf0AT3r1+3Nj
         NLrPvtPfsmaZrRq2DGK7Xa7XgF7kU8KE8+gn5C2/dBZvAsYjF6PgE9bQkGRRAdJhEsH+
         /a5azf4z3Yju3xySN35y6+CT7984cFr0ydX8C7cO5FquzCZ+Q0FbCrQA8y5B9U3h7qP1
         A9XQ==
X-Gm-Message-State: AOAM53165em/FOnFd+ClUqMNmuGe0f8AboIe24zSqKA86cE7M2/dNL7f
        uUd4YNTkNTpuDlyDQBuJnA7OjbhJOw4=
X-Google-Smtp-Source: ABdhPJxnHEq+xlzpjcsisJyQ8mSKr1UsXcbPWqgfFhV1qFWNUIqVq/+vTV7nyipT/hA1Sjv+dLo6WQ==
X-Received: by 2002:a05:600c:4c11:: with SMTP id d17mr10382048wmp.86.1613308168650;
        Sun, 14 Feb 2021 05:09:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l2sm9213694wrm.6.2021.02.14.05.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 05:09:27 -0800 (PST)
Message-Id: <pull.870.v4.git.1613308167239.gitgitgadget@gmail.com>
In-Reply-To: <pull.870.v3.git.1612884654078.gitgitgadget@gmail.com>
References: <pull.870.v3.git.1612884654078.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 14 Feb 2021 13:09:26 +0000
Subject: [PATCH v4] difftool.c: learn a new way start at specified file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Ryan Zoeller <rtzoeller@rtzoeller.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

`git difftool` only allow us to select file to view in turn.
If there is a commit with many files and we exit in the search,
We will have to traverse list again to get the file diff which
we want to see. Therefore, here is a new method: user can use
`git difftool --start-from=<filename>` to start viewing from
the specified file, This will improve the user experience.

`difftool --start-from=<file>` will pass the file name to
`diffcore-rotate`, it will traverse all files in diff_queue,
if it finds a matching file, it will rearrange the order of
diff_filepair of diff_queue, Rotate the file specified by the
user to the first one. If the file name specified by the user
does not match any item in the diff queue, Git will also rotate
the queue, it will find the the first file name larger than the
specified file name as the first element of the new diff_queue.
This will help users find their mistakes.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    difftool.c: learn a new way start at specified file
    
    git user may should travel the diff list to choice file diff to view, if
    they exit in midway,they must travel it again. By starting from the
    specified file method, provides a possibility for this user-friendly
    solution.
    
    this patch's origin discuss is here:
    https://lore.kernel.org/git/gOXOaoqn-E9A2ob7ykWEcDc7ZxmSwAjcP5CCFKfr5ejCOWZQ1lfAUZcbgYT9AyQCcDgJvCrnrtziXiels-Hxol3xlkGTVHk24SvAdaSUtKQ=@rtzoeller.com/
    
    Maybe this patch is more like skip to in Junio's original thread than
    the previous versions.
    
    Thanks!

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-870%2Fadlternative%2Fdifftool_save_point-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-870/adlternative/difftool_save_point-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/870

Range-diff vs v3:

 1:  29fc6b4bc08f ! 1:  3accfb942301 difftool.c: learn a new way start from specified file
     @@ Metadata
      Author: ZheNing Hu <adlternative@gmail.com>
      
       ## Commit message ##
     -    difftool.c: learn a new way start from specified file
     +    difftool.c: learn a new way start at specified file
      
          `git difftool` only allow us to select file to view in turn.
          If there is a commit with many files and we exit in the search,
          We will have to traverse list again to get the file diff which
          we want to see. Therefore, here is a new method: user can use
          `git difftool --start-from=<filename>` to start viewing from
     -    the specified file. This will improve the user experience.
     -    At the same time, turn bit field constants into bit shift format
     -    in `diff.h`.
     +    the specified file, This will improve the user experience.
     +
     +    `difftool --start-from=<file>` will pass the file name to
     +    `diffcore-rotate`, it will traverse all files in diff_queue,
     +    if it finds a matching file, it will rearrange the order of
     +    diff_filepair of diff_queue, Rotate the file specified by the
     +    user to the first one. If the file name specified by the user
     +    does not match any item in the diff queue, Git will also rotate
     +    the queue, it will find the the first file name larger than the
     +    specified file name as the first element of the new diff_queue.
     +    This will help users find their mistakes.
      
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
      
     @@ Documentation/git-difftool.txt: OPTIONS
       	This is the default behaviour; the option is provided to
       	override any configuration settings.
       
     -+--start-from::
     ++--start-from=<file>::
      +	Start viewing diff from the specified file.
      +
       -t <tool>::
       --tool=<tool>::
       	Use the diff tool specified by <tool>.  Valid values include
      
     - ## builtin/difftool.c ##
     -@@ builtin/difftool.c: int cmd_difftool(int argc, const char **argv, const char *prefix)
     - {
     - 	int use_gui_tool = 0, dir_diff = 0, prompt = -1, symlinks = 0,
     - 	    tool_help = 0, no_index = 0;
     --	static char *difftool_cmd = NULL, *extcmd = NULL;
     -+	static char *difftool_cmd = NULL, *extcmd = NULL, *start_file = NULL;
     - 	struct option builtin_difftool_options[] = {
     - 		OPT_BOOL('g', "gui", &use_gui_tool,
     - 			 N_("use `diff.guitool` instead of `diff.tool`")),
     -@@ builtin/difftool.c: int cmd_difftool(int argc, const char **argv, const char *prefix)
     - 		OPT_STRING('x', "extcmd", &extcmd, N_("command"),
     - 			   N_("specify a custom command for viewing diffs")),
     - 		OPT_ARGUMENT("no-index", &no_index, N_("passed to `diff`")),
     -+		OPT_STRING(0, "start-from", &start_file, N_("start-from"),
     -+			   N_("start viewing diff from the specified file")),
     - 		OPT_END()
     - 	};
     - 
     -@@ builtin/difftool.c: int cmd_difftool(int argc, const char **argv, const char *prefix)
     - 			     builtin_difftool_usage, PARSE_OPT_KEEP_UNKNOWN |
     - 			     PARSE_OPT_KEEP_DASHDASH);
     - 
     -+	if (start_file)
     -+		setenv("START_FILE", start_file, 1);
     -+
     - 	if (tool_help)
     - 		return print_tool_help();
     - 
     + ## Makefile ##
     +@@ Makefile: LIB_OBJS += diffcore-delta.o
     + LIB_OBJS += diffcore-order.o
     + LIB_OBJS += diffcore-pickaxe.o
     + LIB_OBJS += diffcore-rename.o
     ++LIB_OBJS += diffcore-rotate.o
     + LIB_OBJS += dir-iterator.o
     + LIB_OBJS += dir.o
     + LIB_OBJS += editor.o
      
       ## diff.c ##
     -@@ diff.c: static void run_external_diff(const char *pgm,
     - 			      const char *xfrm_msg,
     - 			      struct diff_options *o)
     - {
     -+	const char *start_file = NULL;
     - 	struct strvec argv = STRVEC_INIT;
     - 	struct strvec env = STRVEC_INIT;
     - 	struct diff_queue_struct *q = &diff_queued_diff;
     -@@ diff.c: static void run_external_diff(const char *pgm,
     - 
     - 	diff_free_filespec_data(one);
     - 	diff_free_filespec_data(two);
     -+
     -+	start_file = xstrdup_or_null(getenv("START_FILE"));
     -+	if (start_file) {
     -+		if (strcmp(start_file, name))
     -+			goto finish;
     -+		unsetenv("START_FILE");
     -+	}
     - 	if (run_command_v_opt_cd_env(argv.v, RUN_USING_SHELL, NULL, env.v))
     - 		die(_("external diff died, stopping at %s"), name);
     - 
     -+finish:
     - 	remove_tempfile();
     - 	strvec_clear(&argv);
     - 	strvec_clear(&env);
     +@@ diff.c: static void prep_parse_options(struct diff_options *options)
     + 			  DIFF_PICKAXE_REGEX, PARSE_OPT_NONEG),
     + 		OPT_FILENAME('O', NULL, &options->orderfile,
     + 			     N_("control the order in which files appear in the output")),
     ++		OPT_STRING(0, "rotate-to", &options->rotate_to, N_("<path>"),
     ++			   N_("show the change in the specified path first")),
     ++		OPT_STRING(0, "start-from", &options->rotate_to, N_("<path>"),
     ++			   N_("pass from difftool to diff, has the same effort as `rotate-to`")),
     + 		OPT_CALLBACK_F(0, "find-object", options, N_("<object-id>"),
     + 			       N_("look for differences that change the number of occurrences of the specified object"),
     + 			       PARSE_OPT_NONEG, diff_opt_find_object),
     +@@ diff.c: void diffcore_std(struct diff_options *options)
     + 		diffcore_pickaxe(options);
     + 	if (options->orderfile)
     + 		diffcore_order(options->orderfile);
     ++	if (options->rotate_to)
     ++		diffcore_rotate(options->rotate_to);
     + 	if (!options->found_follow)
     + 		/* See try_to_follow_renames() in tree-diff.c */
     + 		diff_resolve_rename_copy();
      
       ## diff.h ##
     -@@ diff.h: typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
     - 
     - typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data);
     - 
     --#define DIFF_FORMAT_RAW		0x0001
     --#define DIFF_FORMAT_DIFFSTAT	0x0002
     --#define DIFF_FORMAT_NUMSTAT	0x0004
     --#define DIFF_FORMAT_SUMMARY	0x0008
     --#define DIFF_FORMAT_PATCH	0x0010
     --#define DIFF_FORMAT_SHORTSTAT	0x0020
     --#define DIFF_FORMAT_DIRSTAT	0x0040
     -+#define DIFF_FORMAT_RAW		(1U<<0)
     -+#define DIFF_FORMAT_DIFFSTAT	(1U<<1)
     -+#define DIFF_FORMAT_NUMSTAT	(1U<<2)
     -+#define DIFF_FORMAT_SUMMARY	(1U<<3)
     -+#define DIFF_FORMAT_PATCH	(1U<<4)
     -+#define DIFF_FORMAT_SHORTSTAT	(1U<<5)
     -+#define DIFF_FORMAT_DIRSTAT	(1U<<6)
     +@@ diff.h: enum diff_submodule_format {
     +  */
     + struct diff_options {
     + 	const char *orderfile;
     ++	const char *rotate_to;
       
     - /* These override all above */
     --#define DIFF_FORMAT_NAME	0x0100
     --#define DIFF_FORMAT_NAME_STATUS	0x0200
     --#define DIFF_FORMAT_CHECKDIFF	0x0400
     -+#define DIFF_FORMAT_NAME	(1U<<8)
     -+#define DIFF_FORMAT_NAME_STATUS	(1U<<9)
     -+#define DIFF_FORMAT_CHECKDIFF	(1U<<10)
     + 	/**
     + 	 * A constant string (can and typically does contain newlines to look for
     +
     + ## diffcore-rotate.c (new) ##
     +@@
     ++/*
     ++ * Copyright (C) 2021, Google LLC.
     ++ * Based on diffcore-order.c, which is Copyright (C) 2005, Junio C Hamano
     ++ */
     ++#include "cache.h"
     ++#include "diff.h"
     ++#include "diffcore.h"
     ++
     ++void diffcore_rotate(const char *rotate_to_filename)
     ++{
     ++	struct diff_queue_struct *q = &diff_queued_diff;
     ++	struct diff_queue_struct outq;
     ++	int rotate_to, i;
     ++
     ++	if (!q->nr)
     ++		return;
     ++
     ++	for (i = 0; i < q->nr; i++)
     ++		if (strcmp(rotate_to_filename, q->queue[i]->two->path) <= 0)
     ++			break;
     ++	/* we did not find the specified path */
     ++	if (q->nr <= i)
     ++		return;
     ++
     ++	DIFF_QUEUE_CLEAR(&outq);
     ++	rotate_to = i;
     ++
     ++	for (i = rotate_to; i < q->nr; i++)
     ++		diff_q(&outq, q->queue[i]);
     ++	for (i = 0; i < rotate_to; i++)
     ++		diff_q(&outq, q->queue[i]);
     ++
     ++	free(q->queue);
     ++	*q = outq;
     ++}
     +
     + ## diffcore.h ##
     +@@ diffcore.h: void diffcore_rename(struct diff_options *);
     + void diffcore_merge_broken(void);
     + void diffcore_pickaxe(struct diff_options *);
     + void diffcore_order(const char *orderfile);
     ++void diffcore_rotate(const char *rotate_to_filename);
       
     - /* Same as output_format = 0 but we know that -s flag was given
     -  * and we should not give default value to output_format.
     + /* low-level interface to diffcore_order */
     + struct obj_order {
      
       ## t/t7800-difftool.sh ##
      @@ t/t7800-difftool.sh: test_expect_success 'difftool --gui, --tool and --extcmd are mutually exclusive'
     @@ t/t7800-difftool.sh: test_expect_success 'difftool --gui, --tool and --extcmd ar
      +	test_when_finished git reset --hard &&
      +	echo 1 >1 &&
      +	echo 2 >2 &&
     -+	echo 3 >3 &&
     -+	git add 1 2 3 &&
     -+	git commit -a -m "123" &&
     -+	git difftool --start-from="2" HEAD^ 2>&1 >output &&
     -+	test_line_count = 4 output
     ++	echo 4 >4 &&
     ++	git add 1 2 4 &&
     ++	git commit -a -m "124" &&
     ++	git difftool --no-prompt --extcmd=cat --start-from="2" HEAD^  >output &&
     ++	cat >expect <<-\EOF &&
     ++	2
     ++	4
     ++	1
     ++	EOF
     ++	test_cmp output expect &&
     ++	git difftool --no-prompt --extcmd=cat --start-from="3" HEAD^  >output &&
     ++	cat >expect <<-\EOF &&
     ++	4
     ++	1
     ++	2
     ++	EOF
     ++	test_cmp output expect
      +'
     -+
       test_done


 Documentation/git-difftool.txt |  3 +++
 Makefile                       |  1 +
 diff.c                         |  6 ++++++
 diff.h                         |  1 +
 diffcore-rotate.c              | 35 ++++++++++++++++++++++++++++++++++
 diffcore.h                     |  1 +
 t/t7800-difftool.sh            | 23 ++++++++++++++++++++++
 7 files changed, 70 insertions(+)
 create mode 100644 diffcore-rotate.c

diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 484c485fd06c..b2bb4e00f683 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -34,6 +34,9 @@ OPTIONS
 	This is the default behaviour; the option is provided to
 	override any configuration settings.
 
+--start-from=<file>::
+	Start viewing diff from the specified file.
+
 -t <tool>::
 --tool=<tool>::
 	Use the diff tool specified by <tool>.  Valid values include
diff --git a/Makefile b/Makefile
index 4edfda3e009d..6b1f6b72629a 100644
--- a/Makefile
+++ b/Makefile
@@ -882,6 +882,7 @@ LIB_OBJS += diffcore-delta.o
 LIB_OBJS += diffcore-order.o
 LIB_OBJS += diffcore-pickaxe.o
 LIB_OBJS += diffcore-rename.o
+LIB_OBJS += diffcore-rotate.o
 LIB_OBJS += dir-iterator.o
 LIB_OBJS += dir.o
 LIB_OBJS += editor.o
diff --git a/diff.c b/diff.c
index 69e3bc00ed8f..c41bdcabb791 100644
--- a/diff.c
+++ b/diff.c
@@ -5599,6 +5599,10 @@ static void prep_parse_options(struct diff_options *options)
 			  DIFF_PICKAXE_REGEX, PARSE_OPT_NONEG),
 		OPT_FILENAME('O', NULL, &options->orderfile,
 			     N_("control the order in which files appear in the output")),
+		OPT_STRING(0, "rotate-to", &options->rotate_to, N_("<path>"),
+			   N_("show the change in the specified path first")),
+		OPT_STRING(0, "start-from", &options->rotate_to, N_("<path>"),
+			   N_("pass from difftool to diff, has the same effort as `rotate-to`")),
 		OPT_CALLBACK_F(0, "find-object", options, N_("<object-id>"),
 			       N_("look for differences that change the number of occurrences of the specified object"),
 			       PARSE_OPT_NONEG, diff_opt_find_object),
@@ -6669,6 +6673,8 @@ void diffcore_std(struct diff_options *options)
 		diffcore_pickaxe(options);
 	if (options->orderfile)
 		diffcore_order(options->orderfile);
+	if (options->rotate_to)
+		diffcore_rotate(options->rotate_to);
 	if (!options->found_follow)
 		/* See try_to_follow_renames() in tree-diff.c */
 		diff_resolve_rename_copy();
diff --git a/diff.h b/diff.h
index 2ff2b1c7f2ca..0801469e6390 100644
--- a/diff.h
+++ b/diff.h
@@ -226,6 +226,7 @@ enum diff_submodule_format {
  */
 struct diff_options {
 	const char *orderfile;
+	const char *rotate_to;
 
 	/**
 	 * A constant string (can and typically does contain newlines to look for
diff --git a/diffcore-rotate.c b/diffcore-rotate.c
new file mode 100644
index 000000000000..1bcfd935cf50
--- /dev/null
+++ b/diffcore-rotate.c
@@ -0,0 +1,35 @@
+/*
+ * Copyright (C) 2021, Google LLC.
+ * Based on diffcore-order.c, which is Copyright (C) 2005, Junio C Hamano
+ */
+#include "cache.h"
+#include "diff.h"
+#include "diffcore.h"
+
+void diffcore_rotate(const char *rotate_to_filename)
+{
+	struct diff_queue_struct *q = &diff_queued_diff;
+	struct diff_queue_struct outq;
+	int rotate_to, i;
+
+	if (!q->nr)
+		return;
+
+	for (i = 0; i < q->nr; i++)
+		if (strcmp(rotate_to_filename, q->queue[i]->two->path) <= 0)
+			break;
+	/* we did not find the specified path */
+	if (q->nr <= i)
+		return;
+
+	DIFF_QUEUE_CLEAR(&outq);
+	rotate_to = i;
+
+	for (i = rotate_to; i < q->nr; i++)
+		diff_q(&outq, q->queue[i]);
+	for (i = 0; i < rotate_to; i++)
+		diff_q(&outq, q->queue[i]);
+
+	free(q->queue);
+	*q = outq;
+}
diff --git a/diffcore.h b/diffcore.h
index d2a63c5c71f4..bd5959375bf4 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -164,6 +164,7 @@ void diffcore_rename(struct diff_options *);
 void diffcore_merge_broken(void);
 void diffcore_pickaxe(struct diff_options *);
 void diffcore_order(const char *orderfile);
+void diffcore_rotate(const char *rotate_to_filename);
 
 /* low-level interface to diffcore_order */
 struct obj_order {
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 9662abc1e784..949d07d70fe1 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -762,4 +762,27 @@ test_expect_success 'difftool --gui, --tool and --extcmd are mutually exclusive'
 	test_must_fail git difftool --gui --tool=test-tool --extcmd=cat
 '
 
+test_expect_success 'difftool --start-from' '
+	difftool_test_setup &&
+	test_when_finished git reset --hard &&
+	echo 1 >1 &&
+	echo 2 >2 &&
+	echo 4 >4 &&
+	git add 1 2 4 &&
+	git commit -a -m "124" &&
+	git difftool --no-prompt --extcmd=cat --start-from="2" HEAD^  >output &&
+	cat >expect <<-\EOF &&
+	2
+	4
+	1
+	EOF
+	test_cmp output expect &&
+	git difftool --no-prompt --extcmd=cat --start-from="3" HEAD^  >output &&
+	cat >expect <<-\EOF &&
+	4
+	1
+	2
+	EOF
+	test_cmp output expect
+'
 test_done

base-commit: e6362826a0409539642a5738db61827e5978e2e4
-- 
gitgitgadget
