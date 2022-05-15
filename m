Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320A6C433EF
	for <git@archiver.kernel.org>; Sun, 15 May 2022 21:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbiEOVTD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 May 2022 17:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiEOVTB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 May 2022 17:19:01 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A347C3587A
        for <git@vger.kernel.org>; Sun, 15 May 2022 14:19:00 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r30so410755wra.13
        for <git@vger.kernel.org>; Sun, 15 May 2022 14:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=wr27IUaGFSi9LZI9UIxT/xCicp0l0b/95Iwb8gBAxjI=;
        b=E/mBcrWeI4jP2n9oXI3kq3HWgdZLjtT5HZpxqzHOFQIbMzeYCO7s76YFwgx90ll9hr
         9NUwsanW0C9waufJWibenT/yEfWKwLu7kjyEiu2lb9tACU/mGuBBf+5qUx2KP+OeGgen
         2CIzREWkKJKP9IYrSozkWoKN/ie011ADjk6A/a61HIsmFTtiJt2qdA0RaePnA1xtnwVl
         j1a97wOMuH4ARO/sOntAhFbX8MYMuZ2CMQh8c3sviXtbitPSZhrThIyCSUA5mLB78Pt1
         Go+ckzk1Yg+HYN6BTthYJ0KOe1WqKDQC4iI+WnHOPeppX2fYvO2yUd2qOPZwOw9D+dK7
         mcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wr27IUaGFSi9LZI9UIxT/xCicp0l0b/95Iwb8gBAxjI=;
        b=wS750z3ED2uiONDZhAUP3TPiaHb9Brn+nYMmuxiC3BWQZMMl0g0757x9A+tEVbPGuj
         mfqURQMvyB/T6jstwneTdoMBfJO1reDCEXWKCrwWATsKVbQbLMRO+Srw3evYOtqOiY+e
         rd+V7wE3Q06P33vAK+RVWIBgMvvmBMlFdSgntqhdlQxzswXA9vZ+6Dq/77abnlq5eFoU
         utiAOk99yZBxv6C7LIm49drj4Ns9YUQPKe5H29gudwWyzBpzBgjSL7oqox+8j+rH8BE5
         v+7vEu29DjajsqZVMz4c7DlRDgxxg1F3HuGzIWN6JKPA9JEeqdR9uYUcwPS/aRpO0Nd7
         yGlg==
X-Gm-Message-State: AOAM530hyLsYb+gw1w4LB9ZQIp9rOf8UGJTrwQu8fjiYlZjv0IIX8t04
        3RbWguRapdbrj2bDz5z73bgCX2WiE9c=
X-Google-Smtp-Source: ABdhPJzXv9bazmQ9XsAkEvj4/pszVpzwmp3q4U5zjAbcmcd3c3Dpf2TRDhpUUSixkIMaQhVnsgVP8A==
X-Received: by 2002:a05:6000:100c:b0:20a:c8db:69d2 with SMTP id a12-20020a056000100c00b0020ac8db69d2mr11619330wrx.19.1652649538807;
        Sun, 15 May 2022 14:18:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d17-20020adfa411000000b0020d07958bb3sm1873111wra.3.2022.05.15.14.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 14:18:58 -0700 (PDT)
Message-Id: <pull.1232.git.1652649537647.gitgitgadget@gmail.com>
From:   "Nadav Goldstein via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 15 May 2022 21:18:57 +0000
Subject: [PATCH] stash: added safety flag for stash clear subcommand
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nadav Goldstein <nadav.goldstein96@gmail.com>,
        Nadav Goldstein <nadav.goldstein@blazepod.co>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nadav Goldstein <nadav.goldstein@blazepod.co>

Introduced a flag (git stash clear -i) when when used,
instead of silently clearing the stash, will present a
confirmation to the user regarding the action which he's
about to perform. Took the inspiration from rm -rf -i flag.
This flag also outputs extra logs (abort/success) to let
the user know more "interactively" what is happening with
the stash (hence the flag name).

Signed-off-by: Nadav Goldstein <nadav.goldstein@blazepod.co>
---
    stash clear: added safety flag for stash clear subcommand
    
    Added a flag to git stash clear (-i|--interactive), which prompts the
    user to confirm he indeed wants to clear the stash, otherwise it will
    abort.
    
    I found it useful as a frequent stash clear user which means my terminal
    always have it in recent commands, which could mean accidental erase of
    work. This flag ensures accidental fires won't clear hard work :)
    
    I also thought it would be better to do it opt in, to not change the way
    the command works in prod, only add to it.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1232%2Fnadav96%2Fclear-stash-prompt-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1232/nadav96/clear-stash-prompt-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1232

 Documentation/git-stash.txt |  9 +++++++--
 builtin/stash.c             | 21 +++++++++++++++++++--
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 6e15f475257..a7ab5379779 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -17,7 +17,7 @@ SYNOPSIS
 	     [-u|--include-untracked] [-a|--all] [-m|--message <message>]
 	     [--pathspec-from-file=<file> [--pathspec-file-nul]]
 	     [--] [<pathspec>...]]
-'git stash' clear
+'git stash' clear [-i|--interactive]
 'git stash' create [<message>]
 'git stash' store [-m|--message <message>] [-q|--quiet] <commit>
 
@@ -127,7 +127,7 @@ the stash entry is applied on top of the commit that was HEAD at the
 time `git stash` was run, it restores the originally stashed state
 with no conflicts.
 
-clear::
+clear [-i|--interactive]::
 	Remove all the stash entries. Note that those entries will then
 	be subject to pruning, and may be impossible to recover (see
 	'Examples' below for a possible strategy).
@@ -160,6 +160,11 @@ OPTIONS
 All ignored and untracked files are also stashed and then cleaned
 up with `git clean`.
 
+-i::
+--interactive::
+	This option is only valid for clear command, when applied, will request
+	a confirmation from the user before proceeding to clear the stash.
+
 -u::
 --include-untracked::
 --no-include-untracked::
diff --git a/builtin/stash.c b/builtin/stash.c
index 0c7b6a95882..b012d24ef38 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -26,7 +26,7 @@ static const char * const git_stash_usage[] = {
 	N_("git stash drop [-q|--quiet] [<stash>]"),
 	N_("git stash ( pop | apply ) [--index] [-q|--quiet] [<stash>]"),
 	N_("git stash branch <branchname> [<stash>]"),
-	"git stash clear",
+	"git stash clear [-i|--interactive]",
 	N_("git stash [push [-p|--patch] [-S|--staged] [-k|--[no-]keep-index] [-q|--quiet]\n"
 	   "          [-u|--include-untracked] [-a|--all] [-m|--message <message>]\n"
 	   "          [--pathspec-from-file=<file> [--pathspec-file-nul]]\n"
@@ -67,7 +67,7 @@ static const char * const git_stash_branch_usage[] = {
 };
 
 static const char * const git_stash_clear_usage[] = {
-	"git stash clear",
+	"git stash clear [-i|--interactive]",
 	NULL
 };
 
@@ -215,7 +215,10 @@ static int do_clear_stash(void)
 
 static int clear_stash(int argc, const char **argv, const char *prefix)
 {
+	int is_prompt;
 	struct option options[] = {
+		OPT_BOOL('i', "interactive", &is_prompt,
+			 N_("confirm clearing stash")),
 		OPT_END()
 	};
 
@@ -226,7 +229,21 @@ static int clear_stash(int argc, const char **argv, const char *prefix)
 	if (argc)
 		return error(_("git stash clear with arguments is "
 			       "unimplemented"));
+	if (is_prompt == 1) {
+		char code[2];
+		printf("Are you sure you want to clear your stash? [y/N]: ");
+		if (fgets(code, 2, stdin) != NULL) {
+			if (code[0] == 'y' || code[0] == 'Y') {
+				printf_ln(_("Clearing stash"));
+				return do_clear_stash();
+			}
+			else {
+				printf_ln(_("Aborting clear"));
+			}
+		}
 
+		return 0;
+	}
 	return do_clear_stash();
 }
 

base-commit: e8005e4871f130c4e402ddca2032c111252f070a
-- 
gitgitgadget
