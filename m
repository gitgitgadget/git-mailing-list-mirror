Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 423F51F404
	for <e@80x24.org>; Sun, 15 Apr 2018 20:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752916AbeDOU31 (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 16:29:27 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37773 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752899AbeDOU3V (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 16:29:21 -0400
Received: by mail-wr0-f195.google.com with SMTP id l49so20519278wrl.4
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 13:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d21vROObPGP8nFwmkaXYtYkOc/S5mP6FT6K8XtS1aCE=;
        b=Lp8PXJ5QyQHZlIMfLoUPmZu2kURM7e+jVWVb4dI9XdcsF4EbFPa99quTJ6BrDfxEwU
         4yNXwRu0cmyfIyOzwMArJWbgmvNNsn6hsCpOkBDonOepYR6SbeqN9oj5FlV/ck0qXv27
         DDnNFwv0rOYhO3sBMCX50Hfo/7q0JI9HEbx3VulwF/FhoViz3dSR9VjPthXOF2OWrWOe
         otJAlup1BqqpMU+nr3I1/g2JH58I3aGWjXfvBvHmDgmMsLGG2BAodEgC12fBy6D4pin0
         taGyaYgyMs7Aaz8/KGIcs/I1qBIIsTpvqEQarRLeUHdW3iy8zUL25xmFf1UO0HO8gW+Q
         mo/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d21vROObPGP8nFwmkaXYtYkOc/S5mP6FT6K8XtS1aCE=;
        b=GV5MmWvnBFCZdQj0HfaKpwKv6XvRvT+NpF8RTBQX2k3YNHQKImS2zkxyCCVshBOSS7
         uCrP9Sr7iBAcyLrDeI1Z+eZJmPOlqwWRLiygAe+p+mR9bTrQbs0IsteincYO/hfLAxYs
         fd2QiXnjLnSWM792xI/QdQWLPP3vIl7DNsWGOCNstKfpsKOzSNj/RP9V//5Pktddz13Y
         r+rek1PVFr6of6FmjXxJ7O/eST/Aj7F2mB7Q9HfehFoY8L9Yk643CSn2Pi073GmomIFb
         D9AINtssFEbHQQ3Jmt5iwdkk2tCirzN9tlJotGAWNtHyWM7XH/1pAqCi1cketAiO2WTV
         kiQg==
X-Gm-Message-State: ALQs6tCYFB1oYZaZLNN+23pTqfLp/uUBmEiq7jkcz1y1yEoRA7VL6pny
        0A4iAGe5xD0qZbmv7EiOOXelOpMN
X-Google-Smtp-Source: AIpwx49cbTwQoOQx+WB9OZ1/8sgp9aW69DK4ctFDWJteReevTMfZ5pucscklVm9Bh0+2OhaqTIcOig==
X-Received: by 10.223.225.2 with SMTP id d2mr8770132wri.56.1523824159416;
        Sun, 15 Apr 2018 13:29:19 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id p128sm11149901wmd.45.2018.04.15.13.29.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Apr 2018 13:29:18 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v7 4/4] worktree: teach "add" to check out existing branches
Date:   Sun, 15 Apr 2018 21:29:17 +0100
Message-Id: <20180415202917.4360-5-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.252.gfe0a9eaf31
In-Reply-To: <20180415202917.4360-1-t.gummerer@gmail.com>
References: <20180331151804.30380-1-t.gummerer@gmail.com>
 <20180415202917.4360-1-t.gummerer@gmail.com>
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
 builtin/worktree.c             | 30 ++++++++++++++++++++++++------
 t/t2025-worktree-add.sh        | 26 +++++++++++++++++++-------
 3 files changed, 50 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 41585f535d..5d54f36a71 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -61,8 +61,13 @@ $ git worktree add --track -b <branch> <path> <remote>/<branch>
 ------------
 +
 If `<commit-ish>` is omitted and neither `-b` nor `-B` nor `--detach` used,
-then, as a convenience, a new branch based at HEAD is created automatically,
-as if `-b $(basename <path>)` was specified.
+then, as a convenience, the new worktree is associated with a branch
+(call it `<branch>`) named after `$(basename <path>)`.  If `<branch>`
+doesn't exist, a new branch based on HEAD is automatically created as
+if `-b <branch>` was given.  If `<branch>` does exist, it will be
+checked out in the new worktree, if it's not checked out anywhere
+else, otherwise the command will refuse to create the worktree (unless
+`--force` is used).
 
 list::
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 893139629a..f5a5283b39 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -355,9 +355,12 @@ static int add_worktree(const char *path, const char *refname,
 
 static void print_preparing_worktree_line(const char *branch,
 					  const char *new_branch,
-					  const char *new_branch_force)
+					  const char *new_branch_force,
+					  int checkout_existing_branch)
 {
-	if (new_branch_force) {
+	if (checkout_existing_branch) {
+		printf_ln(_("Preparing worktree (checking out '%s')"), branch);
+	} else if (new_branch_force) {
 		struct commit *commit = lookup_commit_reference_by_name(new_branch_force);
 		if (!commit)
 			printf_ln(_("Preparing worktree (new branch '%s')"), new_branch_force);
@@ -378,11 +381,23 @@ static void print_preparing_worktree_line(const char *branch,
 	}
 }
 
-static const char *dwim_branch(const char *path, const char **new_branch)
+static const char *dwim_branch(const char *path, const char **new_branch,
+			       int *checkout_existing_branch)
 {
 	int n;
 	const char *s = worktree_basename(path, &n);
-	*new_branch = xstrndup(s, n);
+	const char *branchname = xstrndup(s, n);
+	struct strbuf ref = STRBUF_INIT;
+
+	if (!strbuf_check_branch_ref(&ref, branchname) &&
+	    ref_exists(ref.buf)) {
+		*checkout_existing_branch = 1;
+		strbuf_release(&ref);
+		UNLEAK(branchname);
+		return branchname;
+	}
+
+	*new_branch = branchname;
 	if (guess_remote) {
 		struct object_id oid;
 		const char *remote =
@@ -397,6 +412,7 @@ static int add(int ac, const char **av, const char *prefix)
 	struct add_opts opts;
 	const char *new_branch_force = NULL;
 	char *path;
+	int checkout_existing_branch = 0;
 	const char *branch;
 	const char *new_branch = NULL;
 	const char *opt_track = NULL;
@@ -444,7 +460,8 @@ static int add(int ac, const char **av, const char *prefix)
 	}
 
 	if (ac < 2 && !new_branch && !opts.detach) {
-		const char *s = dwim_branch(path, &new_branch);
+		const char *s = dwim_branch(path, &new_branch,
+					    &checkout_existing_branch);
 		if (s)
 			branch = s;
 	}
@@ -464,7 +481,8 @@ static int add(int ac, const char **av, const char *prefix)
 		}
 	}
 
-	print_preparing_worktree_line(branch, new_branch, new_branch_force);
+	print_preparing_worktree_line(branch, new_branch, new_branch_force,
+				      checkout_existing_branch);
 
 	if (new_branch) {
 		struct child_process cp = CHILD_PROCESS_INIT;
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index 2b95944973..ad38507d00 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -198,13 +198,25 @@ test_expect_success '"add" with <branch> omitted' '
 	test_cmp_rev HEAD bat
 '
 
-test_expect_success '"add" auto-vivify does not clobber existing branch' '
-	test_commit c1 &&
-	test_commit c2 &&
-	git branch precious HEAD~1 &&
-	test_must_fail git worktree add precious &&
-	test_cmp_rev HEAD~1 precious &&
-	test_path_is_missing precious
+test_expect_success '"add" checks out existing branch of dwimd name' '
+	git branch dwim HEAD~1 &&
+	git worktree add dwim &&
+	test_cmp_rev HEAD~1 dwim &&
+	(
+		cd dwim &&
+		test_cmp_rev HEAD dwim
+	)
+'
+
+test_expect_success '"add <path>" dwim fails with checked out branch' '
+	git checkout -b test-branch &&
+	test_must_fail git worktree add test-branch &&
+	test_path_is_missing test-branch
+'
+
+test_expect_success '"add --force" with existing dwimd name doesnt die' '
+	git checkout test-branch &&
+	git worktree add --force test-branch
 '
 
 test_expect_success '"add" no auto-vivify with --detach and <branch> omitted' '
-- 
2.17.0.252.gfe0a9eaf31

