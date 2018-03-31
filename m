Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A64D1F404
	for <e@80x24.org>; Sat, 31 Mar 2018 15:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752900AbeCaPO5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 11:14:57 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55062 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752870AbeCaPOz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 11:14:55 -0400
Received: by mail-wm0-f68.google.com with SMTP id h76so19347929wme.4
        for <git@vger.kernel.org>; Sat, 31 Mar 2018 08:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VX2a1tFalh1UdnX7aN5PfoBiIcqQ482L97XcQV5HFKE=;
        b=M9en39Z/V5+/DUEUKIF1c+dQv/WF77f+ufZOBdXrwiW5lgA2ljZG6XyS2Tk2p0z9ha
         Km5YxPbvG4PToxmUF1hyRMdBEVNKyWtoMMYCWrUrTplVn5abec+IK2flapboU7qAcERZ
         yXAUM4wyxx2txHI99UGYxSzTjJA7YxcmALVG1nuZJw5mOJCc4OIOt86elW54WeUyZzWf
         Zglwrn1NFFlLTcP7giFNS2c+MFAIRzM6cEH9s5OuM52hvXiutOqFdTi8BZyRoDMjX1jG
         oz0p/EC1avHgLuYY8IHyW985YFD3JyyWvrW/W8K0Q/HmJ1XjgC9Rbv8M3x84eIC8B4Vv
         rzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VX2a1tFalh1UdnX7aN5PfoBiIcqQ482L97XcQV5HFKE=;
        b=R6bknVW0rzwOKOllHH6/ZVvZ97RsqSFKBonfLRWzVjqurolmMfE8zC1WkClbalaEPl
         recm1+c/9Fo39bhD7h65h47anrinJzD+UbMOrpvmJ8zu0YK90SkxZy12XEBJKICx2FwP
         tulLN5gnBkf2VtfBoFBpARKigooiM8NNbYNE5oGoMHI8+Uu/uNbx6bJPgJeNSNxwx/KH
         1MBo0wfN43WEoPNw2hWVSMNz7R1uUn2HLzt/GS8cYo1QnS3fFCYVYktMm2/yCW4ArtHl
         s+QPDvef808AwoEZWjOjclIAZd4u2cwh37tIs7O6/IniwXSs/ytovJqNCCN3QZKwv+ID
         WFNw==
X-Gm-Message-State: ALQs6tDrUrI0tgTn4XTatkvUPMzReoVW08aVfmPnSljCj/gEsuh+islg
        dsu0DZy8+aJeupOEkZSFCy2beZ9d
X-Google-Smtp-Source: AIpwx4/ozEXy7+u0dTUtfnnKPFCPLkIS0oVIXJbfHNI0mth9nGIzV285Q6yxeHtoXiG0sqT/wBic5Q==
X-Received: by 10.28.136.199 with SMTP id k190mr1847138wmd.154.1522509293652;
        Sat, 31 Mar 2018 08:14:53 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id p14sm23963540wrc.30.2018.03.31.08.14.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 31 Mar 2018 08:14:52 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v6 6/6] worktree: teach "add" to check out existing branches
Date:   Sat, 31 Mar 2018 16:18:04 +0100
Message-Id: <20180331151804.30380-7-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.16.1.78.ga2082135d8
In-Reply-To: <20180331151804.30380-1-t.gummerer@gmail.com>
References: <20180325134947.25828-1-t.gummerer@gmail.com>
 <20180331151804.30380-1-t.gummerer@gmail.com>
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
 builtin/worktree.c             | 22 +++++++++++++++++++---
 t/t2025-worktree-add.sh        | 25 ++++++++++++++++++-------
 3 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 41585f535d..eaa6bf713f 100644
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
+worktree (unless `--force` is used).
 
 list::
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 47189d50dd..511d0aa370 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -363,11 +363,23 @@ static int add_worktree(const char *path, const char *refname,
 	return ret;
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
@@ -385,6 +397,7 @@ static int add(int ac, const char **av, const char *prefix)
 	const char *branch;
 	const char *new_branch = NULL;
 	const char *opt_track = NULL;
+	int checkout_existing_branch = 0;
 	struct option options[] = {
 		OPT__FORCE(&opts.force, N_("checkout <branch> even if already checked out in other worktree")),
 		OPT_STRING('b', NULL, &new_branch, N_("branch"),
@@ -429,7 +442,8 @@ static int add(int ac, const char **av, const char *prefix)
 	}
 
 	if (ac < 2 && !new_branch && !opts.detach) {
-		const char *s = dwim_branch(path, &new_branch);
+		const char *s = dwim_branch(path, &new_branch,
+					    &checkout_existing_branch);
 		if (s)
 			branch = s;
 	}
@@ -464,6 +478,8 @@ static int add(int ac, const char **av, const char *prefix)
 		if (run_command(&cp))
 			return -1;
 		branch = new_branch;
+	} else if (checkout_existing_branch) {
+		  fprintf_ln(stderr, _("Checking out branch '%s'"), branch);
 	} else if (opt_track) {
 		die(_("--[no-]track can only be used if a new branch is created"));
 	}
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index 2b95944973..f72cb0eb0b 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -198,13 +198,24 @@ test_expect_success '"add" with <branch> omitted' '
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
+		test_cmp_rev dwim HEAD
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
+	git worktree add --force test-branch
 '
 
 test_expect_success '"add" no auto-vivify with --detach and <branch> omitted' '
-- 
2.16.1.78.ga2082135d8

