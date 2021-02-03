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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DC6C433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 21:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C94C64F5F
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 21:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhBCVlW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 16:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbhBCVlV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 16:41:21 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B072C061573
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 13:40:41 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id b3so1003862wrj.5
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 13:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Da4goLVMOCm83o8unNmD/chqJbb2Y0SIKwYNpWj3Hac=;
        b=OiY3L0Gik7nBMNZcmlWhTMgk9ef0+qShBcT7P5T0z95OVOK8tjWKzAQnqptL1fMbLR
         96R3/GSKk8WHPB4A4K7zoCmSZxK8SyNK6/ZhSdBq88nIJcCZWdK+czqciQUXwx9K7/D/
         gEt/WStk5Fh2rBLHTXq3NokGh2IbgFzOMPL1IVV2wHGb6dDqfAvAUmVEaF63X8vbNDUO
         tadsWqtzP9jL4u3xbK2SseQ3GCg14uAJtXWhyUApr3Y4SSqyfM2Df9Y9pQWHi1hK7RIW
         AuYwEoDUvCwod5S0+ulu+vzIFULoGDcHCRGsw15DG79Hum4xXL5CdRngFmiFksSTrI7x
         /Bsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Da4goLVMOCm83o8unNmD/chqJbb2Y0SIKwYNpWj3Hac=;
        b=Ofl8cOLRoCHmgqFJ4jbc1UT8QRcPDSIv6QxMt7oXt7IM/H0ODKyolASRf54gJ6Zs/b
         Mic48Wf8iEm7SWoikMB1xFsezVQUpMBJ0+Mfp4tEAo+bJw7FOoa0Ez5zUILmFv2x7Hyo
         r8JYWQJ8Y2pROi/dGHjHFSv4tnhbK4es1JN9XLelDhKVmPKlTBtuoUgRqA3AhJL9JXsD
         d6yTJBWnK6JQTFcsYdcu1tXs9AhsEG6gjoZ3iaKDJSQSsHpQU77g7PVvk1MC2AVpbfky
         uax18X31qAvFY25pSAELC+ERAQm/UlZdRtrotF+evwc3fbAmbM7niny0je5+EMleqcZH
         kmuA==
X-Gm-Message-State: AOAM531B1slxy6qo4IyJ96irIN91vxPM89uOWpnP3kjwqDGKOkd5rd3K
        1G3rs+x4EwjuNmNBYG+fOOb54WQfXNU=
X-Google-Smtp-Source: ABdhPJx8yr6+M65ApQu7Hk3SzpjbEPaHwha4q47MKwzA/BGNguRubefZDKe7aHl3Q8vObz48U/Xhcw==
X-Received: by 2002:a5d:6cb4:: with SMTP id a20mr5744541wra.192.1612388439701;
        Wed, 03 Feb 2021 13:40:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i6sm4823465wrs.71.2021.02.03.13.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 13:40:39 -0800 (PST)
Message-Id: <pull.955.git.git.1612388438497.gitgitgadget@gmail.com>
From:   "Lance Ward via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 03 Feb 2021 21:40:38 +0000
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
    status: learn --color command line option
    
    Many users like to pipe colored results of git status to other commands
    such as more or less, but by default colors are lost when piping without
    changing the user's git configuration. Many other commands such as diff,
    show, log and grep have a --color option to easily override this
    behavior. This allows the status command to have a similar --color
    option providing a simpler mechanism for temporarily forcing piped
    colored output.
    
    Signed-off-by: Lance Ward ljward10@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-955%2Fljward10%2Flw-add-status-color-option-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-955/ljward10/lw-add-status-color-option-v1
Pull-Request: https://github.com/git/git/pull/955

 Documentation/git-status.txt   |  9 ++++++++
 builtin/commit.c               |  6 +++++
 t/t7528-status-color-option.sh | 40 ++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+)
 create mode 100755 t/t7528-status-color-option.sh

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index c0764e850a44..d5655d051841 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -32,6 +32,15 @@ OPTIONS
 --branch::
 	Show the branch and tracking info even in short-format.
 
+--color[=<when>]::
+	Color status output, overriding configuration file setting.
+	The value must be always (the default), never, or auto.
+
+--no-color::
+	Turn off color ouput, even when the configuration file gives
+	the default to color output.
+	Same as `--color=never`.
+
 --show-stash::
 	Show the number of entries currently stashed away.
 
diff --git a/builtin/commit.c b/builtin/commit.c
index 739110c5a7f6..7f0a9d07a0ee 100644
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
@@ -1410,6 +1412,10 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	handle_untracked_files_arg(&s);
 	handle_ignored_arg(&s);
 
+	if (use_color != GIT_COLOR_AUTO) {
+		s.use_color=use_color;
+	}
+
 	if (s.show_ignored_mode == SHOW_MATCHING_IGNORED &&
 	    s.show_untracked_files == SHOW_NO_UNTRACKED_FILES)
 		die(_("Unsupported combination of ignored and untracked-files arguments"));
diff --git a/t/t7528-status-color-option.sh b/t/t7528-status-color-option.sh
new file mode 100755
index 000000000000..d14ea03f92c3
--- /dev/null
+++ b/t/t7528-status-color-option.sh
@@ -0,0 +1,40 @@
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
+	git status >raw &&
+	test_decode_color <raw >out &&
+	grep "original$" out
+'
+
+# Test new color option with never (expect same as above)
+test_expect_success 'git status --color=never' '
+	git status --color=never >raw &&
+	test_decode_color <raw >out &&
+	grep "original$" out
+'
+
+# Test new color (default is always)
+test_expect_success 'git status --color' '
+	git status --color >raw &&
+	test_decode_color <raw >out &&
+	grep "original<RESET>$" out
+'
+
+# Test new color option with always
+test_expect_success 'git status --color=always' '
+	git status --color=always >raw &&
+	test_decode_color <raw >out &&
+	grep "original<RESET>$" out
+'
+
+test_done

base-commit: e6362826a0409539642a5738db61827e5978e2e4
-- 
gitgitgadget
