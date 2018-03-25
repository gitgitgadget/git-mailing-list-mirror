Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C04021F404
	for <e@80x24.org>; Sun, 25 Mar 2018 13:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753349AbeCYNqn (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 09:46:43 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38921 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752749AbeCYNqi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 09:46:38 -0400
Received: by mail-wr0-f194.google.com with SMTP id c24so16312660wrc.6
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 06:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PJWkyZf8NaKxoy4IiKLCv5d+dil/xlNuFIdmrIOXxwI=;
        b=PmKOlAViVzvjcbEvD/XztAkLGFPWwLWvXksbvVIkuXTVs1/23EaBX4EcNi32AbXE8z
         rJjTL19Og2G/ui0C23fnDmeKWGNpqDbyL5nPH/dZtyWxOThL7hM+2FJlmpgzZse0Fzz9
         5v7gAgPClgnL8HOFdErjbISpeirquGD13E2p6YasWJp9o9QdVGHAVg7lK2e4+W42lOX5
         lehs6U/yFjXxSaAra5SmgOHJ0OGis/9BTJqcITrNorxFDwk6th/dOtIEMyvgt7LFpuje
         /X6o53nvxKbKBJssYjUVkbT/UVu3OabN9L5rbli2+yIY+a46ToOvr6yWZ7HPiuKZd4/0
         X5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PJWkyZf8NaKxoy4IiKLCv5d+dil/xlNuFIdmrIOXxwI=;
        b=ryaPzjaUwfc2yL/bbYyxAfm9qVy2J6lnBCXFpJuI6EbLXhBRZhpl+6iI4PBrhyNWnL
         sIjVBGCyTFsRkIm+mHjScR8XWkK7WAC1DTwInGzmnxi7abq1QOZ8MsedgNO3YfQKk1US
         /KCL+EDkHpjiBqmwrQLNxDaFTyMNA6cOJTCf1GtJpUQ/V2ZBTb01hEdxDqNfWbrswLAX
         Q6m73mxrcEQLMIlLcc3VTeSBuD/haqfYrEWPXr/jlsGTA6oajURxucrAyn6hxu9yuplX
         WIvkmFl6r4YbpyRIb+UcA3hoCbEyLjMi85WxRGzBSOVjBE92gyom5uBelUzHAj1e8sEW
         GE+w==
X-Gm-Message-State: AElRT7Gwd7IygHQALk05jDM48NwIexq+V8EgKKWf/VzZoiSJSz+5Dafm
        jw2JISPbv6ti44SrTt2GSbcljNA1
X-Google-Smtp-Source: AG47ELuni1mu6gH0KmwLq/C8zVIMBpOtil3lLm5+tTBZrNWng7KihQKJNq1SGVQnUomQhAHilFnTOg==
X-Received: by 10.223.160.78 with SMTP id l14mr25943770wrl.153.1521985597118;
        Sun, 25 Mar 2018 06:46:37 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id o88sm13685088wrb.44.2018.03.25.06.46.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Mar 2018 06:46:36 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v5 5/6] worktree: teach "add" to check out existing branches
Date:   Sun, 25 Mar 2018 14:49:46 +0100
Message-Id: <20180325134947.25828-6-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.16.1.77.g8685934aa2
In-Reply-To: <20180325134947.25828-1-t.gummerer@gmail.com>
References: <20180317222219.4940-1-t.gummerer@gmail.com>
 <20180325134947.25828-1-t.gummerer@gmail.com>
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
 builtin/worktree.c             | 19 +++++++++++++++++--
 t/t2025-worktree-add.sh        | 19 ++++++++++++++++---
 3 files changed, 40 insertions(+), 7 deletions(-)

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
index c296c3eacb..895838b943 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -28,6 +28,7 @@ struct add_opts {
 	int checkout;
 	int keep_locked;
 	const char *new_branch;
+	int checkout_existing_branch;
 };
 
 static int show_only;
@@ -317,7 +318,10 @@ static int add_worktree(const char *path, const char *refname,
 	if (ret)
 		goto done;
 
-	if (opts->new_branch)
+	if (opts->checkout_existing_branch)
+		fprintf_ln(stderr, _("checking out branch '%s'"),
+			   refname);
+	else if (opts->new_branch)
 		fprintf_ln(stderr, _("creating branch '%s'"), opts->new_branch);
 
 	fprintf(stderr, _("new worktree HEAD is now at %s"),
@@ -370,7 +374,18 @@ static const char *dwim_branch(const char *path, struct add_opts *opts)
 {
 	int n;
 	const char *s = worktree_basename(path, &n);
-	opts->new_branch = xstrndup(s, n);
+	const char *branchname = xstrndup(s, n);
+	struct strbuf ref = STRBUF_INIT;
+
+	if (!strbuf_check_branch_ref(&ref, branchname) &&
+	    ref_exists(ref.buf)) {
+		opts->checkout_existing_branch = 1;
+		strbuf_release(&ref);
+		UNLEAK(branchname);
+		return branchname;
+	}
+
+	opts->new_branch = branchname;
 	if (guess_remote) {
 		struct object_id oid;
 		const char *remote =
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index 2b95944973..ae602cf20e 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -198,13 +198,26 @@ test_expect_success '"add" with <branch> omitted' '
 	test_cmp_rev HEAD bat
 '
 
-test_expect_success '"add" auto-vivify does not clobber existing branch' '
+test_expect_success '"add" checks out existing branch of dwimd name' '
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
+'
+
+test_expect_success '"add --force" with existing dwimd name doesnt die' '
+	git worktree add --force test-branch
 '
 
 test_expect_success '"add" no auto-vivify with --detach and <branch> omitted' '
-- 
2.16.1.77.g8685934aa2

