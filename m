Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C19C352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 18:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiLGSLB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 13:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiLGSLA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 13:11:00 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80826D7E0
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 10:10:58 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id v7so14318566wmn.0
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 10:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G1LZOWqzrkdeINoyV4Km7+gO114phAEvtDQxFLh9YPU=;
        b=gHUQgLWXCv1QMb/GAoSwEl0PCnJlG+gV+kPWCqOkiN4QgX6R+rDqMJTYTQaR4hESw5
         AlQtyZnxlsoADUSXh4+8FGUqLXxkhDXNUrx+HNYzo0I2C+R3clVYMJ1MCewHdszLpDYV
         h+scwm1JkH1fo1CBPXaMj1sZBX9nc0IDVbVvNi5LcAvJW08tfp2Phda2PP84WHrRXSvg
         gJ0b0bZmoHmjReLxajTgTggfNDMdAh2pJI5sj/gYCYNlpCztJdL1ZSoD8+RVD36Uw1CU
         772+HT579YTz7a0b7uWuQ8ZwmHUPVBXdQhORzUfnwY9CGJPntn6zzPfkhZXwDFv4D5sK
         T7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G1LZOWqzrkdeINoyV4Km7+gO114phAEvtDQxFLh9YPU=;
        b=qSETtfiWbQYa5f/L71GlIgDimvVckuEQZtz9AEAKqb0A1IyT8Cy7JZjUSBv9j0UXqv
         4lu5Jqf430QoWadNjUvNCkInyu7pZa0XXakxteddCVBtwdUqcJpu6VqZB4kgJ3qkayLS
         IeyYiB9omQ/Bg6BsoNqS0XzE2hjgbqtpkM+LImmvDu6Kf+NCQiQUozIu+5psrIPIjl+n
         l7HjC0RhBL8WlWXIjZiojqp3yGSKT4ULe0pCBfcor620Klrm+y7knbakFCzfCb7nGNzE
         4hKLSIVippExwfLN/GwCo17LOJiskFg0vr6ZIuJI15gILPXcrSMO51/b9VYZohnleiIy
         QuXQ==
X-Gm-Message-State: ANoB5plYeTgJhaXZJbPtMMCd56dFOvXkJbmJmx6/ggF7OvfJ2XCzNz6t
        9OTxif5Rq8xfFz8mGH/n1D7VOvuo4fk=
X-Google-Smtp-Source: AA0mqf6HUwJWFm8jiWfVPOPJOz7GKrqKujtop9Wt1jbh0gjL0IQ8VWcq5gNv4cDD0cuohjiC9AnpCQ==
X-Received: by 2002:a05:600c:1e85:b0:3cf:84be:aaf9 with SMTP id be5-20020a05600c1e8500b003cf84beaaf9mr53127591wmb.111.1670436657342;
        Wed, 07 Dec 2022 10:10:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f13-20020a7bcd0d000000b003b47ff307e1sm2327170wmj.31.2022.12.07.10.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 10:10:57 -0800 (PST)
Message-Id: <pull.1441.git.1670436656379.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Dec 2022 18:10:56 +0000
Subject: [PATCH] scalar: use verbose mode in clone
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Sometimes when users use scalar to download a monorepo
with a long commit history, they want to check the
progress bar to know how long they still need to wait
during the fetch process, but scalar suppresses this
output by default.

So add `[--verbose| -v]` to scalar clone, to enable
fetch's output.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    scalar: use verbose mode in clone
    
    When users use scalar to download a monorepo with a long commit history
    (or the client and server network communication is very poor), we often
    need to spend a long time in the fetch phase of scalar, some users may
    want to check this progress bar To understand the progress of fetch and
    how long they have to wait, so we should enable scalar to display fetch
    progress.
    
    v1. add [--verbose| -v] to scalar clone.
    
    Note: output look like this:
    
    $ scalar clone -v git@github.com:git/git.git
    Initialized empty Git repository in /Users/adl/test/git/src/.git/
    remote: Enumerating objects: 209091, done.
    remote: Counting objects: 100% (991/991), done.
    remote: Compressing objects: 100% (944/944), done.
    Receiving objects: 100% (209085/209085), 81.39 MiB | 126.00 KiB/s, done.
    remote: Total 209085 (delta 54), reused 979 (delta 47), pack-reused 208094
    Resolving deltas: 100% (134000/134000), done.
    From github.com:git/git
     * [new branch]          jch         -> origin/jch
     * [new branch]          main        -> origin/main
     * [new branch]          maint       -> origin/maint
     * [new branch]          master      -> origin/master
     * [new branch]          next        -> origin/next
     * [new branch]          seen        -> origin/seen
     * [new branch]          todo        -> origin/todo
     * [new tag]             v2.39.0-rc2 -> v2.39.0-rc2
     * [new tag]             gitgui-0.10.0    -> gitgui-0.10.0
     * [new tag]             gitgui-0.10.1    -> gitgui-0.10.1
     * [new tag]             gitgui-0.10.2    -> gitgui-0.10.2
     * [new tag]             gitgui-0.11.0    -> gitgui-0.11.0
     ...
    
    
    "new branch", "new tag" output is a bit annoying, it would be better to
    suppress them, but keep the progress.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1441%2Fadlternative%2Fzh%2Fscalar-verbosity-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1441/adlternative/zh/scalar-verbosity-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1441

 Documentation/scalar.txt |  7 ++++++-
 scalar.c                 | 11 ++++++++---
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/scalar.txt b/Documentation/scalar.txt
index f33436c7f65..7ff37b43945 100644
--- a/Documentation/scalar.txt
+++ b/Documentation/scalar.txt
@@ -8,7 +8,7 @@ scalar - A tool for managing large Git repositories
 SYNOPSIS
 --------
 [verse]
-scalar clone [--single-branch] [--branch <main-branch>] [--full-clone] <url> [<enlistment>]
+scalar clone [--single-branch] [--branch <main-branch>] [--verbose | -v] [--full-clone] <url> [<enlistment>]
 scalar list
 scalar register [<enlistment>]
 scalar unregister [<enlistment>]
@@ -84,6 +84,11 @@ cloning. If the HEAD at the remote did not point at any branch when
 	A sparse-checkout is initialized by default. This behavior can be
 	turned off via `--full-clone`.
 
+-v::
+--verbose::
+	When scalar executes `git fetch`, `--quiet` is used by default to
+	suppress the output of fetch, use verbose mode for cancel this.
+
 List
 ~~~~
 
diff --git a/scalar.c b/scalar.c
index 6c52243cdf1..b1d4504d136 100644
--- a/scalar.c
+++ b/scalar.c
@@ -404,7 +404,7 @@ void load_builtin_commands(const char *prefix, struct cmdnames *cmds)
 static int cmd_clone(int argc, const char **argv)
 {
 	const char *branch = NULL;
-	int full_clone = 0, single_branch = 0;
+	int full_clone = 0, single_branch = 0, verbosity = 0;
 	struct option clone_options[] = {
 		OPT_STRING('b', "branch", &branch, N_("<branch>"),
 			   N_("branch to checkout after clone")),
@@ -413,6 +413,7 @@ static int cmd_clone(int argc, const char **argv)
 		OPT_BOOL(0, "single-branch", &single_branch,
 			 N_("only download metadata for the branch that will "
 			    "be checked out")),
+		OPT__VERBOSITY(&verbosity),
 		OPT_END(),
 	};
 	const char * const clone_usage[] = {
@@ -499,7 +500,9 @@ static int cmd_clone(int argc, const char **argv)
 	if (set_recommended_config(0))
 		return error(_("could not configure '%s'"), dir);
 
-	if ((res = run_git("fetch", "--quiet", "origin", NULL))) {
+	if ((res = run_git("fetch", "origin",
+			   verbosity ? NULL : "--quiet",
+			   NULL))) {
 		warning(_("partial clone failed; attempting full clone"));
 
 		if (set_config("remote.origin.promisor") ||
@@ -508,7 +511,9 @@ static int cmd_clone(int argc, const char **argv)
 			goto cleanup;
 		}
 
-		if ((res = run_git("fetch", "--quiet", "origin", NULL)))
+		if ((res = run_git("fetch", "origin",
+				   verbosity ? NULL : "--quiet",
+				   NULL)))
 			goto cleanup;
 	}
 

base-commit: 2e71cbbddd64695d43383c25c7a054ac4ff86882
-- 
gitgitgadget
