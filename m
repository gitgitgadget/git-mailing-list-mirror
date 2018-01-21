Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 813F31F404
	for <e@80x24.org>; Sun, 21 Jan 2018 12:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750919AbeAUMAC (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Jan 2018 07:00:02 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:32812 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbeAUMAB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Jan 2018 07:00:01 -0500
Received: by mail-wr0-f193.google.com with SMTP id p6so5592278wrd.0
        for <git@vger.kernel.org>; Sun, 21 Jan 2018 04:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sH6/nHd9hLQxVi+OvDoEoBJTi9ItRKyp2aXCd2uq9GU=;
        b=gK2/mtU7gFQWRQDnoZo7d6iSYEszfGXN05ceLrE7V0RGNXjvuGIOZgzH8L12vTCj7b
         bnw+CS/JoF6PE6q1JvdzzroRMe1pFUikukLhM3ufdG22hiHOj+mU8hlurj1p4VfMLbPf
         jepj2d5r2u3SWdN7z3dYQrrsEXjFcAywnjqKo1nyQLMdKZyrc2+GdABv7mVZ/xZNBVDL
         K3glPFbPMIpEtoiwYYYcSIlZwcLRrLcaiHPW2ZVxtjD0PHFYpUn3OVS/lhO3S/vqfB4f
         O6CbjC/bZh0UESDeUgl2j2bG6l84KiR2QDuA7MxVOmAiigLM+tRX41qmtIU4hMDSdQ/d
         w74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sH6/nHd9hLQxVi+OvDoEoBJTi9ItRKyp2aXCd2uq9GU=;
        b=l5qfbZ1vaCl3MYmjFJ0LkPQ3haHFFl4uMoBK7tXwAtzPl88jgSP+KSBGbE2hWj6C7Y
         HdCXhRTUSTCI178+tN81NYXvF/JrHaV+7YdvwFVZQIpfByLKvtzaVBuNGSTkELdhRT3a
         RNuYQIgh1B6UwXWOW4k7km7A998IgtpRq3ywkPZG+J4Vu0AYxKRXFjzcATW356VHhQA4
         YZXfeqYgZY6Ib7uNDcKCIn17cH2DpW07pkzN8HvQLKenOBzMPILTIUgvY/d1opQKEZMM
         jIjH4U3Z7qDbTZ5X4v4NSoegYIvMBStEyXWor1uhedz0AaJBA1JsJuvaD6yGtxcncWqE
         6rtQ==
X-Gm-Message-State: AKwxytfAGfG6M7lNlPtt5T466dWz3s11luQfkVZk5PL/bum3uqlNdDDN
        yb1pOW5jfEdgCAYawn2wyM5LYnIk
X-Google-Smtp-Source: AH8x2272i7CBzY3LX6yH3/OH7Wz7WPe8oEX8/ooXnydnerMnch6FBaybYevQsCBLbNCwtb7I9f1ovg==
X-Received: by 10.223.190.142 with SMTP id i14mr3794578wrh.111.1516535999742;
        Sun, 21 Jan 2018 03:59:59 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id 66sm13998139wmn.30.2018.01.21.03.59.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Jan 2018 03:59:59 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH] worktree: teach "add" to check out existing branches
Date:   Sun, 21 Jan 2018 12:02:08 +0000
Message-Id: <20180121120208.12760-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.16.0.312.g896df04e46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently 'git worktree add <path>' creates a new branch named after the
basename of the path by default.  If a branch with that name already
exists, the command refuses to do anything, unless the '--force' option
is given.

However we can do a little better than that, and check the branch out if
it is not checked out anywhere else.  This will help users who just want
to check an existing branch out into a new worktree, and save a few
keystrokes.

As the current behaviour is to simply 'die()' when a brach with the name
of the basename of the path already exists, there are no backwards
compatibility worries here.

We will still 'die()' if the branch is checked out in another worktree,
unless the --force flag is passed.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

This is a follow-up to
https://public-inbox.org/git/20171118181345.GC32324@hank/, where this
was first suggested, but I didn't want to do it as part of that
series.  Now I finally got around to implementing it.

 Documentation/git-worktree.txt |  9 +++++++--
 builtin/worktree.c             | 22 +++++++++++++++-------
 t/t2025-worktree-add.sh        | 15 ++++++++++++---
 3 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 41585f535d..98731b71a7 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -61,8 +61,13 @@ $ git worktree add --track -b <branch> <path> <remote>/<branch>
 ------------
 +
 If `<commit-ish>` is omitted and neither `-b` nor `-B` nor `--detach` used,
-then, as a convenience, a new branch based at HEAD is created automatically,
-as if `-b $(basename <path>)` was specified.
+then, as a convenience, a worktree with a branch named after
+`$(basename <path>)` (call it `<branch>`) is created.  If `<branch>`
+doesn't exist, a new branch based on HEAD is automatically created as
+if `-b <branch>` was given.  If `<branch>` exists in the repository,
+it will be checked out in the new worktree, if it's not checked out
+anywhere else, otherwise the command will refuse to create the
+worktree.
 
 list::
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 7cef5b120b..148a864bb9 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -411,13 +411,21 @@ static int add(int ac, const char **av, const char *prefix)
 	if (ac < 2 && !opts.new_branch && !opts.detach) {
 		int n;
 		const char *s = worktree_basename(path, &n);
-		opts.new_branch = xstrndup(s, n);
-		if (guess_remote) {
-			struct object_id oid;
-			const char *remote =
-				unique_tracking_name(opts.new_branch, &oid);
-			if (remote)
-				branch = remote;
+		const char *branchname = xstrndup(s, n);
+		struct strbuf ref = STRBUF_INIT;
+		if (!strbuf_check_branch_ref(&ref, branchname) &&
+		    ref_exists(ref.buf)) {
+			branch = branchname;
+			opts.checkout = 1;
+		} else {
+			opts.new_branch = branchname;
+			if (guess_remote) {
+				struct object_id oid;
+				const char *remote =
+					unique_tracking_name(opts.new_branch, &oid);
+				if (remote)
+					branch = remote;
+			}
 		}
 	}
 
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index 2b95944973..721b0e4c26 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -198,13 +198,22 @@ test_expect_success '"add" with <branch> omitted' '
 	test_cmp_rev HEAD bat
 '
 
-test_expect_success '"add" auto-vivify does not clobber existing branch' '
+test_expect_success '"add" auto-vivify checks out existing branch' '
 	test_commit c1 &&
 	test_commit c2 &&
 	git branch precious HEAD~1 &&
-	test_must_fail git worktree add precious &&
+	git worktree add precious &&
 	test_cmp_rev HEAD~1 precious &&
-	test_path_is_missing precious
+	(
+		cd precious &&
+		test_cmp_rev precious HEAD
+	)
+'
+
+test_expect_success '"add" auto-vivify fails with checked out branch' '
+	git checkout -b test-branch &&
+	test_must_fail git worktree add test-branch &&
+	test_path_is_missing test-branch
 '
 
 test_expect_success '"add" no auto-vivify with --detach and <branch> omitted' '
-- 
2.16.0.312.g896df04e46

