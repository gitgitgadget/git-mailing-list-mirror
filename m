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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF06C433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 15:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAC4D64EBC
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 15:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbhBIPbj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 10:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbhBIPbi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 10:31:38 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4861EC061786
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 07:30:57 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id m13so22408889wro.12
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 07:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=f23oMQh+OBQ/9EQVkamUj1Reon6vxzP4TTZNCvUbiQ8=;
        b=GAuiVIh8vMoRcMGY/c3JMmntEmCxkf/P9VccN2n9Q9o7xrNpz3RbM0oyo0e/uthEQB
         wZ+8aMzRSPtplRWzZ8HhNRhx/GuHBhZElw1c3kRweS6DbtiggWw8bhs7Jyu8yCP9q9v0
         BzZRqAT5Gq0VdsFuocBiWjExG+ukogpehfr4Mf0OhnlXlxfABtEs9yv3/jhCpFSpHYJO
         sJjtbnPYyKqnFNLeroBnom2dzlVi8sN9z+tfpLVYV3y+tH7N1HYpFklcwwVuoNBATENw
         H7P5BuXjh472o5/swjfWPYzuqL6xRE/vCA/qO6qMJsr6uBY4fQCJHyQZnldZU3RU7t6p
         GWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=f23oMQh+OBQ/9EQVkamUj1Reon6vxzP4TTZNCvUbiQ8=;
        b=VywYkUgMHdh4/G2zx6RSZ/pOul0zorRUZceZysF6Juh4qQWUdiUVE7XJjBE+BS+E7V
         cCoHmXCCSrX1CkfOwuBFjLTWjoW+wMhod4BrLOewbMkyYoUkDYJStq2QFFo6Fu2gtLf1
         YXyoLy5MCxFiDvK32IBQelCNHbr0ICua7RIEXKTrFulN1P3oQp7CX4A7aNaHpqjCFBk5
         qMXZ2uEs5LxYbRWInEsJSuMaGUlDd/vNlFpeObS4HryMrIiKBnbX8Xiy5PahRirAxWFu
         3zinO3XUS05FD8NEu6LlJ9MbDEUBAnX58msEtT1oiMJITLUx1cFn5JIRLnLmePhLEJtk
         GgkQ==
X-Gm-Message-State: AOAM533v96VeffVrGU1vrLRT538oMGGKgke/Wrk+haUFqfh5WL3xGFl1
        yvSjkytoK9N+T4j4LaXRM6CuVEqi6Mo=
X-Google-Smtp-Source: ABdhPJwMQ/eh8QcxtUhk/Hd5Vq8jzZrJewtjMrs/4uB1LNqkuf8xqasVyiqajsJ258NFVOmIt25izw==
X-Received: by 2002:a5d:464f:: with SMTP id j15mr18869658wrs.390.1612884655671;
        Tue, 09 Feb 2021 07:30:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e16sm12322960wrt.36.2021.02.09.07.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 07:30:55 -0800 (PST)
Message-Id: <pull.870.v3.git.1612884654078.gitgitgadget@gmail.com>
In-Reply-To: <pull.870.v2.git.1612803744188.gitgitgadget@gmail.com>
References: <pull.870.v2.git.1612803744188.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Feb 2021 15:30:53 +0000
Subject: [PATCH v3] difftool.c: learn a new way start from specified file
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
the specified file. This will improve the user experience.
At the same time, turn bit field constants into bit shift format
in `diff.h`.

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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-870%2Fadlternative%2Fdifftool_save_point-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-870/adlternative/difftool_save_point-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/870

Range-diff vs v2:

 1:  2468eaff322b < -:  ------------ git-difftool-helper.sh: learn a new way go back to last save point
 -:  ------------ > 1:  29fc6b4bc08f difftool.c: learn a new way start from specified file


 Documentation/git-difftool.txt |  3 +++
 builtin/difftool.c             |  7 ++++++-
 diff.c                         |  9 +++++++++
 diff.h                         | 20 ++++++++++----------
 t/t7800-difftool.sh            | 12 ++++++++++++
 5 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 484c485fd06c..552be097dfea 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -34,6 +34,9 @@ OPTIONS
 	This is the default behaviour; the option is provided to
 	override any configuration settings.
 
+--start-from::
+	Start viewing diff from the specified file.
+
 -t <tool>::
 --tool=<tool>::
 	Use the diff tool specified by <tool>.  Valid values include
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 6e18e623fddf..67d2befa1210 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -690,7 +690,7 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 {
 	int use_gui_tool = 0, dir_diff = 0, prompt = -1, symlinks = 0,
 	    tool_help = 0, no_index = 0;
-	static char *difftool_cmd = NULL, *extcmd = NULL;
+	static char *difftool_cmd = NULL, *extcmd = NULL, *start_file = NULL;
 	struct option builtin_difftool_options[] = {
 		OPT_BOOL('g', "gui", &use_gui_tool,
 			 N_("use `diff.guitool` instead of `diff.tool`")),
@@ -714,6 +714,8 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 		OPT_STRING('x', "extcmd", &extcmd, N_("command"),
 			   N_("specify a custom command for viewing diffs")),
 		OPT_ARGUMENT("no-index", &no_index, N_("passed to `diff`")),
+		OPT_STRING(0, "start-from", &start_file, N_("start-from"),
+			   N_("start viewing diff from the specified file")),
 		OPT_END()
 	};
 
@@ -724,6 +726,9 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 			     builtin_difftool_usage, PARSE_OPT_KEEP_UNKNOWN |
 			     PARSE_OPT_KEEP_DASHDASH);
 
+	if (start_file)
+		setenv("START_FILE", start_file, 1);
+
 	if (tool_help)
 		return print_tool_help();
 
diff --git a/diff.c b/diff.c
index 69e3bc00ed8f..cdad26f99063 100644
--- a/diff.c
+++ b/diff.c
@@ -4249,6 +4249,7 @@ static void run_external_diff(const char *pgm,
 			      const char *xfrm_msg,
 			      struct diff_options *o)
 {
+	const char *start_file = NULL;
 	struct strvec argv = STRVEC_INIT;
 	struct strvec env = STRVEC_INIT;
 	struct diff_queue_struct *q = &diff_queued_diff;
@@ -4272,9 +4273,17 @@ static void run_external_diff(const char *pgm,
 
 	diff_free_filespec_data(one);
 	diff_free_filespec_data(two);
+
+	start_file = xstrdup_or_null(getenv("START_FILE"));
+	if (start_file) {
+		if (strcmp(start_file, name))
+			goto finish;
+		unsetenv("START_FILE");
+	}
 	if (run_command_v_opt_cd_env(argv.v, RUN_USING_SHELL, NULL, env.v))
 		die(_("external diff died, stopping at %s"), name);
 
+finish:
 	remove_tempfile();
 	strvec_clear(&argv);
 	strvec_clear(&env);
diff --git a/diff.h b/diff.h
index 2ff2b1c7f2ca..f67c43f5af95 100644
--- a/diff.h
+++ b/diff.h
@@ -86,18 +86,18 @@ typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 
 typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data);
 
-#define DIFF_FORMAT_RAW		0x0001
-#define DIFF_FORMAT_DIFFSTAT	0x0002
-#define DIFF_FORMAT_NUMSTAT	0x0004
-#define DIFF_FORMAT_SUMMARY	0x0008
-#define DIFF_FORMAT_PATCH	0x0010
-#define DIFF_FORMAT_SHORTSTAT	0x0020
-#define DIFF_FORMAT_DIRSTAT	0x0040
+#define DIFF_FORMAT_RAW		(1U<<0)
+#define DIFF_FORMAT_DIFFSTAT	(1U<<1)
+#define DIFF_FORMAT_NUMSTAT	(1U<<2)
+#define DIFF_FORMAT_SUMMARY	(1U<<3)
+#define DIFF_FORMAT_PATCH	(1U<<4)
+#define DIFF_FORMAT_SHORTSTAT	(1U<<5)
+#define DIFF_FORMAT_DIRSTAT	(1U<<6)
 
 /* These override all above */
-#define DIFF_FORMAT_NAME	0x0100
-#define DIFF_FORMAT_NAME_STATUS	0x0200
-#define DIFF_FORMAT_CHECKDIFF	0x0400
+#define DIFF_FORMAT_NAME	(1U<<8)
+#define DIFF_FORMAT_NAME_STATUS	(1U<<9)
+#define DIFF_FORMAT_CHECKDIFF	(1U<<10)
 
 /* Same as output_format = 0 but we know that -s flag was given
  * and we should not give default value to output_format.
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 9662abc1e784..74baac96a23f 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -762,4 +762,16 @@ test_expect_success 'difftool --gui, --tool and --extcmd are mutually exclusive'
 	test_must_fail git difftool --gui --tool=test-tool --extcmd=cat
 '
 
+test_expect_success 'difftool --start-from' '
+	difftool_test_setup &&
+	test_when_finished git reset --hard &&
+	echo 1 >1 &&
+	echo 2 >2 &&
+	echo 3 >3 &&
+	git add 1 2 3 &&
+	git commit -a -m "123" &&
+	git difftool --start-from="2" HEAD^ 2>&1 >output &&
+	test_line_count = 4 output
+'
+
 test_done

base-commit: e6362826a0409539642a5738db61827e5978e2e4
-- 
gitgitgadget
