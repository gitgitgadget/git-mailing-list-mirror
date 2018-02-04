Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75B1B1F404
	for <e@80x24.org>; Sun,  4 Feb 2018 22:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752167AbeBDWNT (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Feb 2018 17:13:19 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33157 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752110AbeBDWNN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Feb 2018 17:13:13 -0500
Received: by mail-wm0-f67.google.com with SMTP id x4-v6so10571450wmc.0
        for <git@vger.kernel.org>; Sun, 04 Feb 2018 14:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jMfzbjsvSR6fYaMYZnlsj3OKlB/9AQRv6hEIx3znRGM=;
        b=XqmeGYWhQOH/BPoJIATvjoOrOtwfYUglHoiLYnCoItgMz3MF7l+s0zvF5sCsYVzgL4
         ZDwny5LGMLjMYmlmgxMvaoJ46rHdzS3uOuG/oFFyaDlZ7aWUAxBeFJrceKM58ZETIMqU
         VoTDcyXRxZ1Im66W+htLcWTozFZLIRvyquoP4gBvvSy50a4bCMUXfneL8ksTALrSO2ye
         10GgiPM+nv2ww9I6cgHOXFIBM21oZsgevshv0SJGul5OY94cBDYp53DwlfhrlNLUTJ+Q
         AGmvomjWphoGjphrDmUMhu3tKZZwyhtHLfV2dUBQ5bLoawh1I1S/2ugzMTSASETBEP06
         tqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jMfzbjsvSR6fYaMYZnlsj3OKlB/9AQRv6hEIx3znRGM=;
        b=rDHK962vYR86uvkoBUrtZfl8tWC7KyA6PT97q5Y3ry7w07dy2QvoDzB2Lr+WlkF7L7
         U6kbo09IDiB90o3ZDJmMbEvT5yMJzj9qHAFdPr36WXfKAY7KfgRjkUcG/vGI0f01URrm
         gvY9BPFMRyVFj7Z8Hpm35mOQZwTJ4o1sdIehwdJfDYZ9ubpGFYZnGQbjS2EnBOPlEYDd
         4gYA5h90mQvR6M4hWEwv1U3JAZ5koWQFweyAp3cRWoPA6bpXcsxeFImSIpgZhAj6pEyM
         9m0kBfs7hM6P6weatsj9xnyR1Fc4yGCYUQhLZgj9R1nKg+QS+GJ46bVI7lqJ5rDj6upJ
         5efQ==
X-Gm-Message-State: AKwxytcRztQ0synJW+WELe9M6hE/wL5QfZ88uLxakleNBH52CH8V34zd
        Mz2879GudngqHPc3Ois8I6BumAmC
X-Google-Smtp-Source: AH8x226V7imDET76Yg8Awbvott1Qct3Uff5/f+J/Cm9XPP1f34ZLBR0wKhXCtuq82bCOgtsnDo/RIw==
X-Received: by 10.28.170.195 with SMTP id t186mr36861530wme.93.1517782391003;
        Sun, 04 Feb 2018 14:13:11 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id 44sm12893531wrv.0.2018.02.04.14.13.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Feb 2018 14:13:10 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 3/3] worktree: teach "add" to check out existing branches
Date:   Sun,  4 Feb 2018 22:13:05 +0000
Message-Id: <20180204221305.28300-4-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.16.1.101.gde0f0111ea
In-Reply-To: <20180204221305.28300-1-t.gummerer@gmail.com>
References: <20180121120208.12760-1-t.gummerer@gmail.com>
 <20180204221305.28300-1-t.gummerer@gmail.com>
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

As the current behaviour is to simply 'die()' when a branch with the name
of the basename of the path already exists, there are no backwards
compatibility worries here.

We will still 'die()' if the branch is checked out in another worktree,
unless the --force flag is passed.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-worktree.txt |  9 +++++++--
 builtin/worktree.c             | 31 +++++++++++++++++++++++--------
 t/t2025-worktree-add.sh        | 15 ++++++++++++---
 3 files changed, 42 insertions(+), 13 deletions(-)

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
index 74a853c2a3..ea420bb90b 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -29,6 +29,7 @@ struct add_opts {
 	int keep_locked;
 	const char *new_branch;
 	int force_new_branch;
+	int checkout_existing_branch;
 };
 
 static int show_only;
@@ -320,7 +321,10 @@ static int add_worktree(const char *path, const char *refname,
 	if (ret)
 		goto done;
 
-	if (opts->new_branch)
+	if (opts->checkout_existing_branch)
+		fprintf(stderr, _(", checking out existing branch '%s'"),
+			refname);
+	else if (opts->new_branch)
 		fprintf(stderr, _(", creating new branch '%s'"), opts->new_branch);
 
 	fprintf(stderr, _(", setting HEAD to %s"),
@@ -423,14 +427,25 @@ static int add(int ac, const char **av, const char *prefix)
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
+
+		if (!strbuf_check_branch_ref(&ref, branchname) &&
+		    ref_exists(ref.buf)) {
+			branch = branchname;
+			opts.checkout_existing_branch = 1;
+			UNLEAK(branch);
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
+		strbuf_release(&ref);
 	}
 
 	if (ac == 2 && !opts.new_branch && !opts.detach) {
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
2.16.1.101.gde0f0111ea

