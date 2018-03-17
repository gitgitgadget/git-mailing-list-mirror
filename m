Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 150AF1F404
	for <e@80x24.org>; Sat, 17 Mar 2018 22:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752699AbeCQWGA (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 18:06:00 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53533 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751867AbeCQWF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 18:05:59 -0400
Received: by mail-wm0-f67.google.com with SMTP id e194so9067461wmd.3
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 15:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DXeRZC0E0h+hLF+OqeWOy2g35tlq+uRqp2baS8TIljY=;
        b=ThgC0otuVI4LqTmYpwnh5qa/wFrsRGwD9UoLNW4Nrpj89IiYQLI1aDdg37JmnQPgi1
         DeQzBt0qYCZYnY/3497DEykMajzO4nMZQScmqFsxNzKVu8f0iCSYoHNtc1+foGxKyOyg
         pYzK6FVEp4EgSYIbAxRY5DTpevK1ZKEsQmdj6Lyw3jzuEKq9KqU2j1cWL4S7ZanQbMJz
         a1oAEXguPxMlejJu6AbpUvu89zu1De2BcKty1hcgz5StIxfL9QgQjlY/37UqCXn+Matm
         +W0eKJMwKMDG0lLzK1tgM+WRznKp/kcvntvPsCVJLkbP9hL6+R5s36zVYRYvZagoHxAS
         nGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DXeRZC0E0h+hLF+OqeWOy2g35tlq+uRqp2baS8TIljY=;
        b=hom3nnOqfeNfEYxmOrOUyJXOk59ug3/L9CsVBOLKOu9afinNx02L6JlygR1Sa6pnhv
         6xwEvoTzkONZfKYqhIKiGMew++eJae51I3g1bQYPXt51mxqH1Du/WlsBdQRb79NPBG+S
         yyQ2sUoRfqJinLHoN3C9Q6kvYTsvCriM85XhDr6es3tSw1AvMch0Kue41Pt+xsfuECRr
         PhvkzgyHHbbC8dyuksixH7298SW/wgXqgI71Z4mrvZE1swK51QYWqKNyl40pjDTL/Myb
         MysZbsXBFFOd658T4OVrtPNJoeY8ujl5zNA7oQeh9Q1UwpKiHkjmONSXPUF5x5xlrNCo
         srRQ==
X-Gm-Message-State: AElRT7FFSlgu/hA7JpcL8ORfoo8g4IpZPDDWiP9vb6W7lHAYhW+ZuXhz
        5RfIEZsSfPVCRJsJsQEf5Cz6qLqr
X-Google-Smtp-Source: AG47ELvedDvX5LinBWnpeBEmF5om8RE4K0yE7Anbt30azHqENrD3Ear9G1WiJ3Ze3m0kAUFAN4QtOA==
X-Received: by 10.28.22.210 with SMTP id 201mr4636416wmw.66.1521324358071;
        Sat, 17 Mar 2018 15:05:58 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id j21sm15613998wrb.49.2018.03.17.15.05.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Mar 2018 15:05:57 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 4/4] worktree: teach "add" to check out existing branches
Date:   Sat, 17 Mar 2018 22:08:30 +0000
Message-Id: <20180317220830.30963-5-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.231.g781580f06
In-Reply-To: <20180317220830.30963-1-t.gummerer@gmail.com>
References: <20180204221305.28300-1-t.gummerer@gmail.com>
 <20180317220830.30963-1-t.gummerer@gmail.com>
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
 t/t2025-worktree-add.sh        | 15 ++++++++++++---
 3 files changed, 38 insertions(+), 8 deletions(-)

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
index 52049b447a..b5d273751f 100644
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
@@ -371,7 +375,19 @@ static const char *dwim_branch(const char *path, struct add_opts *opts)
 {
 	int n;
 	const char *s = worktree_basename(path, &n);
-	opts->new_branch = xstrndup(s, n);
+	const char *branchname = xstrndup(s, n);
+	struct strbuf ref = STRBUF_INIT;
+
+	if (!strbuf_check_branch_ref(&ref, branchname) &&
+	    ref_exists(ref.buf)) {
+		*branch = branchname;
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

