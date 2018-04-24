Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B8381F424
	for <e@80x24.org>; Tue, 24 Apr 2018 21:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751360AbeDXV5T (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 17:57:19 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37594 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751323AbeDXV5Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 17:57:16 -0400
Received: by mail-wm0-f65.google.com with SMTP id l16so3321640wmh.2
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 14:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Tb7qo0qEUG/g2MpDD08qiiVqF4J5YjomR6V0l0z2zDo=;
        b=GDYR5HybpZU4ChRsn7QF9BTpLe8pHg/ukvBG24G2/M+1IhvvDonfmFMhfH/nLnjJtW
         i8OQIhOF397A1M1oNqgrSxOzHz+7EEC14Pe4IkxXQMe+qpRewDZbadNAbL+Nax8ou4nw
         yFQpDMvQKbGw1WK9cvmm7gS5/eSXeqT+yeR/WTsXRGyne0KNwILIXtrJUKxkA1qV5IaJ
         Wygl8o/R9rQQpf4a9qg9iRFG0NVCnD32uOrSMJZEumIW8fAR/lFX9WmIsNz5dibEWmDF
         CbUiqP2/6+/fdDcgeKKmuI5CYGKhhzzogjVJglbTAeH7NvZxpwPyktEmCYkiSaS5JZWO
         98sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Tb7qo0qEUG/g2MpDD08qiiVqF4J5YjomR6V0l0z2zDo=;
        b=RPMZvMFqcQaJDFdov79stY/iWEUAFiC17G5R7fz0X9PoRo5asZs/z4Mk+BOIMl9UDE
         SZoMxcyQsMlhcIdFNgseLmDDi0W2gzh/cjKfcqS5mebKw+O/nTYMEDWBQUtz9wzgfmju
         4e1TbT4hz1wOY3KujaeQvU/HxXKxaHQSax8xbylya0hUJVhi3RNa53Kv6qwq21motqnq
         zjXyaG0HcedMjFqUh5cm0c9UDoqDWi6bMVygMlkpjUlM2q4E4LkRCoqF36O2zafZFrhL
         BefXj14QmJ0Kvba9aRsvY4+DKRIqB7c73wRaoOTvjaURw1y7IeXypH7timZ5vwRuFgz3
         8GDA==
X-Gm-Message-State: ALQs6tDa7BdvQD0Abf7dghyjBgRrylakaUoQSvN2cS+uWnhRDeFqXsss
        4JbK15uhgj116RVUCgZ+KWP4xkxZ
X-Google-Smtp-Source: AB8JxZp5BUyuqr+wObioFgZJwHsdMjVLS8Kpd+WiAyWF8jgJ2kXXl7BGLITSI+mKuRpt3t8/Q8BAdQ==
X-Received: by 10.28.150.211 with SMTP id y202mr2617438wmd.106.1524607034491;
        Tue, 24 Apr 2018 14:57:14 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id m78sm14287118wma.25.2018.04.24.14.57.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Apr 2018 14:57:13 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v9 4/4] worktree: teach "add" to check out existing branches
Date:   Tue, 24 Apr 2018 22:56:35 +0100
Message-Id: <20180424215635.9183-5-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.16.1.76.ga910c1dec4
In-Reply-To: <20180424215635.9183-1-t.gummerer@gmail.com>
References: <20180423193848.5159-1-t.gummerer@gmail.com>
 <20180424215635.9183-1-t.gummerer@gmail.com>
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

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-worktree.txt |  9 +++++++--
 builtin/worktree.c             | 13 +++++++++++--
 t/t2025-worktree-add.sh        | 26 +++++++++++++++++++-------
 3 files changed, 37 insertions(+), 11 deletions(-)

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
index 6bd32b6090..d3aeb4877d 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -391,8 +391,17 @@ static const char *dwim_branch(const char *path, const char **new_branch)
 {
 	int n;
 	const char *s = worktree_basename(path, &n);
-	*new_branch = xstrndup(s, n);
-	UNLEAK(*new_branch);
+	const char *branchname = xstrndup(s, n);
+	struct strbuf ref = STRBUF_INIT;
+
+	UNLEAK(branchname);
+	if (!strbuf_check_branch_ref(&ref, branchname) &&
+	    ref_exists(ref.buf)) {
+		strbuf_release(&ref);
+		return branchname;
+	}
+
+	*new_branch = branchname;
 	if (guess_remote) {
 		struct object_id oid;
 		const char *remote =
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

