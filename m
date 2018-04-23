Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8A521F424
	for <e@80x24.org>; Mon, 23 Apr 2018 19:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932393AbeDWTph (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 15:45:37 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36613 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932244AbeDWTpg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 15:45:36 -0400
Received: by mail-wr0-f193.google.com with SMTP id u18-v6so17176038wrg.3
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 12:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eniu4NcTg4e2yhfV91MB/XFgAVFfRPOuORaJ+qyXJfs=;
        b=gcaFtqHj+zD/q6114wpuU1PsjLNabeVIFtOFfF7KUqxm05qPL6la/Npd44eDWH9z4J
         WvFJ/f8TVU0nUEHPQBs7iItbzFD0/1xnUaDr/8TFuxN6fQ70q3KkP+MkdGrNc1fs29YC
         rjPFc9DZ4j4Em2fSnW6qb7QlCvxEnWFZbcvezUBR+LTRT+OwfWoTdIc8kBoDpqAT4KHI
         hvpCwFmYHrh5MxqqueMiWNOEJPSvBWV3uq4oU34xruSYWY9Z08rXhtUQITHh3qPf8eyH
         CX8p1X37cdOt3fHLtZSUQ7YpdSq9MIPHl2RK9W990VGgOEziGqjswZbXCqoWUvUOkg8B
         PyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eniu4NcTg4e2yhfV91MB/XFgAVFfRPOuORaJ+qyXJfs=;
        b=gUacrMwWk02sOgvl6udWiqQmxc1RUeEerGBxWWPv3qXf3KBQaLUvpUi0OwgD6YT6hx
         DExkf77F1tURlv3vvh997UP9iK4GJdAjNnE/iVFflB7EUZthFQKQGbfcgN9sT7HVLq+Z
         exH4JmFMP11pjT4Eg6IGP2RnL06MwoGwNG3blPoG3arTFR/Brgx4o8LDjy4xX9RiQalK
         +SXbkz3TjaSIJAsAlx3y8wkxBo6nHEakOCOI0RVRiEap2W4qOCOHGVHo0SHJj2Q0SJyp
         BVipDCz4OdbKbIMSXunv6cucfiH3klClvmpFlcwX2ENmEUdCu/03PbWIF+l+rMeZy+RN
         mgXg==
X-Gm-Message-State: ALQs6tCoE8oj2H6suC5C37yl/d6xjrCJO7oxjPTj9aUFwHA4TmEkNE72
        qd0lfimPvgym3wHnb7dP6mwBFGys
X-Google-Smtp-Source: AIpwx49qm0FBLhW3+YYdvgXVsrIbYa/zH5msk16LuRgRUB46R07JqBCS6/UdxRFyyluM/aZliHVUow==
X-Received: by 10.28.5.198 with SMTP id 189mr9822161wmf.155.1524512735022;
        Mon, 23 Apr 2018 12:45:35 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id a69sm8237035wma.7.2018.04.23.12.45.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 12:45:33 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v8 4/4] worktree: teach "add" to check out existing branches
Date:   Mon, 23 Apr 2018 20:38:48 +0100
Message-Id: <20180423193848.5159-5-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.16.1.74.g7afd1c25cc.dirty
In-Reply-To: <20180423193848.5159-1-t.gummerer@gmail.com>
References: <20180415202917.4360-1-t.gummerer@gmail.com>
 <20180423193848.5159-1-t.gummerer@gmail.com>
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
index bd4cf4583f..d52495f312 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -356,9 +356,12 @@ static int add_worktree(const char *path, const char *refname,
 static void print_preparing_worktree_line(int detach,
 					  const char *branch,
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
@@ -387,11 +390,23 @@ static void print_preparing_worktree_line(int detach,
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
@@ -406,6 +421,7 @@ static int add(int ac, const char **av, const char *prefix)
 	struct add_opts opts;
 	const char *new_branch_force = NULL;
 	char *path;
+	int checkout_existing_branch = 0;
 	const char *branch;
 	const char *new_branch = NULL;
 	const char *opt_track = NULL;
@@ -453,7 +469,8 @@ static int add(int ac, const char **av, const char *prefix)
 	}
 
 	if (ac < 2 && !new_branch && !opts.detach) {
-		const char *s = dwim_branch(path, &new_branch);
+		const char *s = dwim_branch(path, &new_branch,
+					    &checkout_existing_branch);
 		if (s)
 			branch = s;
 	}
@@ -473,7 +490,8 @@ static int add(int ac, const char **av, const char *prefix)
 		}
 	}
 
-	print_preparing_worktree_line(opts.detach, branch, new_branch, new_branch_force);
+	print_preparing_worktree_line(opts.detach, branch, new_branch, new_branch_force,
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
2.16.1.74.g7afd1c25cc.dirty

