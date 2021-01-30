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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F66AC433DB
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 15:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17B0464DFA
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 15:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbhA3Pub (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 10:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbhA3Pq3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jan 2021 10:46:29 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAE9C0613ED
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 07:45:47 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id q7so11855316wre.13
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 07:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=BY5J7tBmjh7jJISx6wvV+k47i95eNuZhaYMRjPcT3aY=;
        b=YAj5m22wdX5BrQmKFDN60IbUxd7H63bPW68OH5MWav2ia+3tsMaR30aeY/JIjMKva9
         g6HvN1zqHKOIP3UgRkl+WB91Oh/EVdx8EylPh5ELgDxT4eKg8MRJ9mO6FbNtmToDGVLa
         ucrh+yP9wKI7dKn5/ZkjgcJUiTO4RTYD7A6RGQsxlv1k8d6904z8t7750wZvAYuL9LZD
         dEBta6icld6WSz3Xx6TuXnxtjCrrbHgrWbnzhkVL7ytmoKTF9AklQtC0osDDGYMjgnLx
         sW7A2Qp+JoYqyyxpzTikldEt21w+MfxcZa1mJMrOZL1M9QDuN7dFRV2legcY47Ip5hUt
         t0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BY5J7tBmjh7jJISx6wvV+k47i95eNuZhaYMRjPcT3aY=;
        b=lXDPk3ueKyIlV4kDUHaNSA4KTUOuqCSIhg98fdLC5LOe1NP9tc3xRfZbrV3rgLzUDb
         YIGJLUscP6SJMSpFZTu9U7CJcAxZkAizLP0xhk2l+yfPRBI3CJYLbWWViOvE2H1u02Mq
         Lgm8tfi+0tmq0UNVvstROm93XglmEVpSPyagOZla+NbHXMFjxy9BkILopP0WbvC1kksl
         pJXUzR4nd+IvSLCQ/NqwgdG8wxzgQljtzBTWXgoPatG7AdqkeuDJXQac1+XuGNFZg22S
         nT2ixdvKEJPUf1u+/73w9ivxM6LndToXzdwM/xi3Ao+ZGMpU1tjYFIGRWHB33Z1/69Nz
         D1Zg==
X-Gm-Message-State: AOAM533X1AdDuhIKV7aKGmsuSD6oYKkbh3cif34l/9d2k/88IgxSoxxN
        9CtMANpFm13uKIbbhJUPVdT+jHFCows=
X-Google-Smtp-Source: ABdhPJy37rU1W+c49FlzM2oj0TOd2Zac3VCNRUAD/teZ8oU1PQZtuVrvGvb402Op+zIz4A+t6uZePQ==
X-Received: by 2002:adf:e392:: with SMTP id e18mr9862186wrm.116.1612021546043;
        Sat, 30 Jan 2021 07:45:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a27sm18365449wrc.94.2021.01.30.07.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 07:45:45 -0800 (PST)
Message-Id: <pull.854.git.1612021544723.gitgitgadget@gmail.com>
From:   "Lance Ward via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 30 Jan 2021 15:45:44 +0000
Subject: [PATCH] status: learn --color for piping colored output
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Lance Ward <ljward10@gmail.com>, Lance Ward <ljward10@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lance Ward <ljward10@gmail.com>

Many users like to pipe colored results of git status to other commands
such as more or less, but by default colors are lost when piping without
changing the user's git configuration.  Many other commands such as diff,
show, log and grep have a --color option to easily override this behavior.
This allows the status command to have a similar --color option providing
a simpler mechanism for temporarily forcing piped colored output.

Signed-off-by: Lance Ward <ljward10@gmail.com>
---
    status: learn --color for piping colored output
    
    Many users like to pipe colored results of git status to other commands
    such as more or less, but by default colors are lost when piping without
    changing the user's git configuration. Many other commands such as diff,
    show, log and grep have a --color option to easily override this
    behavior. This allows the status command to have a similar --color
    option providing a simpler mechanism for temporarily forcing piped
    colored output.
    
    Signed-off-by: Lance Ward ljward10@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-854%2Fljward10%2Flw-add-status-color-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-854/ljward10/lw-add-status-color-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/854

 builtin/commit.c             |  7 ++++
 diff.c                       |  5 +++
 diff.h                       |  1 +
 t/t7527-status-color-pipe.sh | 69 ++++++++++++++++++++++++++++++++++++
 4 files changed, 82 insertions(+)
 create mode 100755 t/t7527-status-color-pipe.sh

diff --git a/builtin/commit.c b/builtin/commit.c
index 739110c5a7f..1579f7cc9ed 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1355,6 +1355,7 @@ static int git_status_config(const char *k, const char *v, void *cb)
 int cmd_status(int argc, const char **argv, const char *prefix)
 {
 	static int no_renames = -1;
+	static int use_color = GIT_COLOR_AUTO;
 	static const char *rename_score_arg = (const char *)-1;
 	static struct wt_status s;
 	unsigned int progress_flag = 0;
@@ -1378,6 +1379,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 			    STATUS_FORMAT_LONG),
 		OPT_BOOL('z', "null", &s.null_termination,
 			 N_("terminate entries with NUL")),
+		OPT__COLOR(&use_color, N_("use colored output")),
 		{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg,
 		  N_("mode"),
 		  N_("show untracked files, optional modes: all, normal, no. (Default: all)"),
@@ -1410,6 +1412,11 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	handle_untracked_files_arg(&s);
 	handle_ignored_arg(&s);
 
+	if (use_color != GIT_COLOR_AUTO) {
+		s.use_color=use_color;
+		set_diff_color(use_color);
+	}
+
 	if (s.show_ignored_mode == SHOW_MATCHING_IGNORED &&
 	    s.show_untracked_files == SHOW_NO_UNTRACKED_FILES)
 		die(_("Unsupported combination of ignored and untracked-files arguments"));
diff --git a/diff.c b/diff.c
index 69e3bc00ed8..fe7ffce6803 100644
--- a/diff.c
+++ b/diff.c
@@ -261,6 +261,11 @@ void init_diff_ui_defaults(void)
 	diff_detect_rename_default = DIFF_DETECT_RENAME;
 }
 
+void set_diff_color(int use_color)
+{
+       diff_use_color_default = use_color;
+}
+
 int git_diff_heuristic_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "diff.indentheuristic"))
diff --git a/diff.h b/diff.h
index 2ff2b1c7f2c..10196d9b040 100644
--- a/diff.h
+++ b/diff.h
@@ -501,6 +501,7 @@ int parse_long_opt(const char *opt, const char **argv,
 int git_diff_basic_config(const char *var, const char *value, void *cb);
 int git_diff_heuristic_config(const char *var, const char *value, void *cb);
 void init_diff_ui_defaults(void);
+void set_diff_color(int use_color);
 int git_diff_ui_config(const char *var, const char *value, void *cb);
 #ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
 #define diff_setup(diffopts) repo_diff_setup(the_repository, diffopts)
diff --git a/t/t7527-status-color-pipe.sh b/t/t7527-status-color-pipe.sh
new file mode 100755
index 00000000000..ee4ab2ea821
--- /dev/null
+++ b/t/t7527-status-color-pipe.sh
@@ -0,0 +1,69 @@
+#!/bin/sh
+
+test_description='git status color option'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo 1 >original &&
+	git add .
+'
+
+# Normal git status does not pipe colors
+test_expect_success 'git status' '
+	git status >out &&
+	test_i18ngrep "original$" out
+'
+
+# Test new color option with never (expect same as above)
+test_expect_success 'git status --color=never' '
+	git status --color=never >out &&
+	test_i18ngrep "original$" out
+'
+
+# Test new color (default is always)
+test_expect_success 'git status --color' '
+	git status --color |
+	test_decode_color >out &&
+	test_i18ngrep "original<RESET>$" out
+'
+
+# Test new color option with always
+test_expect_success 'git status --color=always' '
+	git status --color=always |
+	test_decode_color >out &&
+	test_i18ngrep "original<RESET>$" out
+'
+
+# Test verbose (default)
+test_expect_success 'git status -v' '
+	git status -v |
+	test_decode_color >out &&
+	test_i18ngrep "+1" out
+'
+
+# Test verbose --color=never
+test_expect_success 'git status -v --color=never' '
+	git status -v --color=never |
+	test_decode_color >out &&
+	test_i18ngrep "+1" out
+'
+
+# Test verbose --color (default always)
+test_expect_success 'git status -v --color' '
+	git status -v --color |
+	test_decode_color >out &&
+	test_i18ngrep "<CYAN>@@ -0,0 +1 @@<RESET>" out &&
+	test_i18ngrep "<GREEN>+<RESET><GREEN>1<RESET>" out
+'
+
+test_done
+# Test verbose --color=always
+test_expect_success 'git status -v --color=always' '
+	git status -v --color=always |
+	test_decode_color >out &&
+	test_i18ngrep "<CYAN>@@ -0,0 +1 @@<RESET>" out &&
+	test_i18ngrep "GREEN>+<RESET><GREEN>1<RESET>" out
+'
+
+test_done

base-commit: e6362826a0409539642a5738db61827e5978e2e4
-- 
gitgitgadget
