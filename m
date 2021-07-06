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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13860C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 05:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E04AB613D1
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 05:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhGFFuN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 01:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbhGFFuM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 01:50:12 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1091C061574
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 22:47:33 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id w13so12710658wmc.3
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 22:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=xH27lZxMUZh+HgU6NTn3hQ1nwJ0ZkXU5Thwg0/8qVWk=;
        b=snualrgcDp/ZYhebwNS4WjfKWiGltXIj3WQHOx2LaV3NRUcu72Sd+WNjwQ7QAlVnz+
         PXpKFC1NZOfr7r/H7IclrTfChf2oiUaKp8gFHFAxuOM8bPMPAocAIdkfKY203rp90ayF
         AwQzr0cdnfEVJ6FwLRTVNe0QmItoyzhXS/n7vc3AqihZnQlfcsq6nqpfiF5kRsA285QB
         Loo+FdTOMDoMNhizBfaMVGIwK7zvsikl+f1Ynwk1V62p5VaOBlwMamBmtdbrqffqFnY6
         54jc9QJm46XN/oh3XqmOL4Vouu592LgLd5hjHqi6oxfIIQwcKSYOWtA9OdHxY+SF+DG4
         vANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xH27lZxMUZh+HgU6NTn3hQ1nwJ0ZkXU5Thwg0/8qVWk=;
        b=dZkkgKvM/zxdXaVMLqFsfe0gh3FVQoQTIjqs6LiMViucQfA9JkLipbtNmCzJBSfiox
         1pHvr+EpLs6bCD1IsOPDKzuWhFLOTFyfN6QnwcAIGBRVULLk166/pMupf2pRUjbkT26q
         yauUiVloBEvk/u9Oh+Z4LP3d+WtSrHUId0r8mW8C2H0XmwJOFElYlxdXMZUeBf03D/WA
         XAJLSoHjENUeW5CZHCDYDjn3doDIF1FfcbQ8WWANYY4dpICminljFNzXITR7FQbTG9dH
         PF1OPo9FtKJlidjnIedm/07V9Q4L0GtHswgl312JIoLWLCrZYF1lgv4PgLh7BAMqzHoz
         x90w==
X-Gm-Message-State: AOAM530bG30jLbEx+W35WVeVWbiQezXfqcvVhHxj5nnc9lb0DrRGL+9v
        8aPdVNBktMRNXJshPNn0aEzcw75G4xI=
X-Google-Smtp-Source: ABdhPJxypt4hjc6zqQ1akuGQN/T9MHyKRwmSMMzSmvNDObgUxzEKXgdvFSS5oHtxvgXEk8fN9l457w==
X-Received: by 2002:a05:600c:154a:: with SMTP id f10mr2667248wmg.26.1625550452380;
        Mon, 05 Jul 2021 22:47:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u2sm9179672wmc.42.2021.07.05.22.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 22:47:31 -0700 (PDT)
Message-Id: <pull.992.git.1625550451038.gitgitgadget@gmail.com>
From:   "Stephen Manz via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Jul 2021 05:47:30 +0000
Subject: [PATCH] worktree: teach `add` to accept --reason <string> with --lock
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Stephen Manz <smanz@alum.mit.edu>,
        Stephen Manz <smanz@alum.mit.edu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stephen Manz <smanz@alum.mit.edu>

The default reason stored in the lock file, "added with --lock",
is unlikely to be what the user would have given in a separate
`git worktree lock` command. Allowing `--reason` to be specified
along with `--lock` when adding a working tree gives the user control
over the reason for locking without needing a second command.

Signed-off-by: Stephen Manz <smanz@alum.mit.edu>
---
    worktree: teach add to accept --reason with --lock
    
    The default reason stored in the lock file, "added with --lock", is
    unlikely to be what the user would have given in a separate git worktree
    lock command. Allowing --reason to be specified along with --lock when
    adding a working tree gives the user control over the reason for locking
    without needing a second command.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-992%2FSRManz%2Flock_reason-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-992/SRManz/lock_reason-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/992

 Documentation/git-worktree.txt |  4 ++--
 builtin/worktree.c             | 16 +++++++++++++---
 t/t2400-worktree-add.sh        | 13 ++++++++++++-
 3 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index f1bb1fa5f5a..720663746ba 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -9,7 +9,7 @@ git-worktree - Manage multiple working trees
 SYNOPSIS
 --------
 [verse]
-'git worktree add' [-f] [--detach] [--checkout] [--lock] [-b <new-branch>] <path> [<commit-ish>]
+'git worktree add' [-f] [--detach] [--checkout] [--lock [--reason <string>]] [-b <new-branch>] <path> [<commit-ish>]
 'git worktree list' [--porcelain]
 'git worktree lock' [--reason <string>] <worktree>
 'git worktree move' <worktree> <new-path>
@@ -242,7 +242,7 @@ With `list`, annotate missing working trees as prunable if they are
 older than `<time>`.
 
 --reason <string>::
-	With `lock`, an explanation why the working tree is locked.
+	With `lock` or with `add --lock`, an explanation why the working tree is locked.
 
 <worktree>::
 	Working trees can be identified by path, either relative or
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 976bf8ed063..9f890af7243 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -31,6 +31,7 @@ struct add_opts {
 	int quiet;
 	int checkout;
 	int keep_locked;
+	const char *lock_reason;
 };
 
 static int show_only;
@@ -302,10 +303,15 @@ static int add_worktree(const char *path, const char *refname,
 	 * after the preparation is over.
 	 */
 	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
-	if (!opts->keep_locked)
+	if (!opts->keep_locked) {
 		write_file(sb.buf, "initializing");
-	else
-		write_file(sb.buf, "added with --lock");
+	}
+	else {
+		if (opts->lock_reason)
+			write_file(sb.buf, "%s", opts->lock_reason);
+		else
+			write_file(sb.buf, _("added with --lock"));
+	}
 
 	strbuf_addf(&sb_git, "%s/.git", path);
 	if (safe_create_leading_directories_const(sb_git.buf))
@@ -486,6 +492,8 @@ static int add(int ac, const char **av, const char *prefix)
 		OPT_BOOL('d', "detach", &opts.detach, N_("detach HEAD at named commit")),
 		OPT_BOOL(0, "checkout", &opts.checkout, N_("populate the new working tree")),
 		OPT_BOOL(0, "lock", &opts.keep_locked, N_("keep the new working tree locked")),
+		OPT_STRING(0, "reason", &opts.lock_reason, N_("string"),
+			   N_("reason for locking")),
 		OPT__QUIET(&opts.quiet, N_("suppress progress reporting")),
 		OPT_PASSTHRU(0, "track", &opt_track, NULL,
 			     N_("set up tracking mode (see git-branch(1))"),
@@ -500,6 +508,8 @@ static int add(int ac, const char **av, const char *prefix)
 	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
 	if (!!opts.detach + !!new_branch + !!new_branch_force > 1)
 		die(_("-b, -B, and --detach are mutually exclusive"));
+	if (opts.lock_reason && !opts.keep_locked)
+		die(_("--reason requires --lock"));
 	if (ac < 1 || ac > 2)
 		usage_with_options(worktree_usage, options);
 
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 96dfca15542..1f432d0f7d7 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -67,11 +67,22 @@ test_expect_success '"add" worktree' '
 '
 
 test_expect_success '"add" worktree with lock' '
-	git rev-parse HEAD >expect &&
 	git worktree add --detach --lock here-with-lock main &&
 	test -f .git/worktrees/here-with-lock/locked
 '
 
+test_expect_success '"add" worktree with lock and reason' '
+	git worktree add --detach --lock --reason "why not" here-with-lock-reason main &&
+	test -f .git/worktrees/here-with-lock-reason/locked &&
+	echo why not >expect &&
+	test_cmp expect .git/worktrees/here-with-lock-reason/locked
+'
+
+test_expect_failure '"add" worktree with reason but no lock' '
+	git worktree add --detach --reason "why not" here-with-reason-only main &&
+	test -f .git/worktrees/here-with-reason-only/locked
+'
+
 test_expect_success '"add" worktree from a subdir' '
 	(
 		mkdir sub &&

base-commit: 670b81a890388c60b7032a4f5b879f2ece8c4558
-- 
gitgitgadget
