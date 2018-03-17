Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E4F01F404
	for <e@80x24.org>; Sat, 17 Mar 2018 22:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752832AbeCQWUh (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 18:20:37 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39416 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751722AbeCQWUc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 18:20:32 -0400
Received: by mail-wr0-f193.google.com with SMTP id c24so3151171wrc.6
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 15:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rIMHg3iM/Vk0k98AwcRVm1czgEB7rbfuYDiQOKzpAPw=;
        b=SrPjbAvjNw17/+v3DTiErJFNUQQ2697LnQDdfXe3yAaOcjox2FEhwgpp4BZ4cHnv73
         8hSmXe7RJ4Lr4+SiM0+a/jxUvXZ+NlybYmpf/zTzSTuGz2OptG9vvAekjrj7Y2nS5hyo
         ccDtufdgz1KUfXu+0uxpvaPgFSj92qYoE4IXLD10xrtDU21qOf0WMa68wdRLRP/JhkYA
         Bi7GhU5bHMT8v/P4V92WHcQOYNTpRfyW2UGBfK8wswU4N+7R7Ej8Hx1SH/D5ihlxEUii
         LQHCAPFXHGpO454urHDlhxpqXeECQig5+twXRWecBAcbf03RYNfLlMqjRErieH+Hm8z7
         8bsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rIMHg3iM/Vk0k98AwcRVm1czgEB7rbfuYDiQOKzpAPw=;
        b=lDaW4A4YK7wvo2sauo+nTAZybiuLNWvZ6ZrE37ancgtB6kcYhNfIij9nk6wufdCxOO
         mOpYNpvaTBg4rdB4GeliTi/w/anQiJCs6rUdh28rlUi0sGzA2a5THhCNPciyV1iLX3H1
         yggoMHaZIjDijmVsd2QvJs8GZ6TyZDQ3gldih7Mb2STtz3VMHXiYSOH83pamn6mlIj0Z
         fut48WLFnRi57KrzaehSrK6ndEmtHyh8j8H9luJYaNDpe3FZnuUV6RFJSJf/L4Nt7KMn
         v8Fl0pa/ERk12mvpO2R8yADMLQIURye/XkRZ/4YeSpFR0aPY/qrdhmPUljSrKtLqrxBV
         Y3JQ==
X-Gm-Message-State: AElRT7GebSFEu9JbtoVp6QY7giJwAzEia0jEY/fK7mAzTxRI358WgR6A
        fr7tUhJow4RqZkJgvmNAp9075BaB
X-Google-Smtp-Source: AG47ELuH6zkePH0AwstWnsU81S+f7agwsiKSDiJlb6gAaAArmOFKREm+OcPljhKrgmFDnfidOGoMEw==
X-Received: by 10.223.184.68 with SMTP id u4mr5120164wrf.154.1521325231044;
        Sat, 17 Mar 2018 15:20:31 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id k130sm11096934wmg.9.2018.03.17.15.20.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Mar 2018 15:20:30 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 4/4] worktree: teach "add" to check out existing branches
Date:   Sat, 17 Mar 2018 22:22:19 +0000
Message-Id: <20180317222219.4940-5-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.231.g781580f06
In-Reply-To: <20180317222219.4940-1-t.gummerer@gmail.com>
References: <20180317220830.30963-1-t.gummerer@gmail.com>
 <20180317222219.4940-1-t.gummerer@gmail.com>
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
 builtin/worktree.c             | 21 ++++++++++++++++++---
 t/t2025-worktree-add.sh        | 15 ++++++++++++---
 3 files changed, 37 insertions(+), 8 deletions(-)

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
index 52049b447a..df5c0427ba 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -29,6 +29,7 @@ struct add_opts {
 	int keep_locked;
 	const char *new_branch;
 	int force_new_branch;
+	int checkout_existing_branch;
 };
 
 static int show_only;
@@ -318,8 +319,11 @@ static int add_worktree(const char *path, const char *refname,
 	if (ret)
 		goto done;
 
-	if (opts->new_branch)
-		fprintf(stderr, _("creating new branch '%s'"), opts->new_branch);
+	if (opts->checkout_existing_branch)
+		fprintf(stderr, _("checking out branch '%s'"),
+			refname);
+	else if (opts->new_branch)
+		fprintf(stderr, _("creating branch '%s'"), opts->new_branch);
 
 	fprintf(stderr, _("worktree HEAD is now at %s"),
 		find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV));
@@ -371,7 +375,18 @@ static const char *dwim_branch(const char *path, struct add_opts *opts)
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
2.17.0.rc0.231.g781580f06

