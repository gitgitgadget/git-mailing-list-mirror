Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E88A1F453
	for <e@80x24.org>; Sat, 27 Apr 2019 12:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfD0MC0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Apr 2019 08:02:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32899 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfD0MC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Apr 2019 08:02:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id h5so3022411pfo.0
        for <git@vger.kernel.org>; Sat, 27 Apr 2019 05:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hCC4VKAHHPYaszMbc1dYi0iwBKhPoXUq+pCWS04bxFA=;
        b=Ex78/i4xHWwhNvLkqMX2pOn0DZHZUBciYrS8kE9bCjza8h+TP1AaLd0DyoGEt8QGkf
         h3dzvKqokuR44nMepP6vhJUkHfBgZd/xGH2IwF63AcJJAi7Ez0opUGuSzIgSFVKS+xgg
         XYwb5ZyA0oUUDDw6eymp9AwDcdgjdjuQe+GxEN3HAeAj2eINnKGLs/QzbQ394PpyPJ+R
         hU7tT89ya3Jur8fPJl+ZvwRBRvI1jcbdchKscNTIqheu7MCFxHGX+cj0az5fucx755CH
         zFyOrfZGiT3lr6vTjofwBOLpVeIGb8B8uKkG7pfYMC3myaz6iBwXKYyJS1QyEpa3Hrbk
         wjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hCC4VKAHHPYaszMbc1dYi0iwBKhPoXUq+pCWS04bxFA=;
        b=QDXVmntzIu6h1iJqr9mndQByDd0wPN/6OvCmrit4bB9Z2PDr/W2zQiZMxGmTYaH06E
         e9r1DpSPR+WNH+mEhvLv6vEcpby4o7A2LYOXkIDHDPBuEpSPwgJZ0gBXP9+trGCDBwHI
         R8HjJZlFtzJI3UgyAFSBdK+DF+xz35WTze1KyVaAiHFjgiVAt6/YVolHA5CB0GotASOf
         F4m4InruZS4clzQQuFq/pbQReHzQjXj0QQU2v7JpXVHC9bm5CJGWyjj7i0jQFrxBKvLd
         DskokoVORjoLwBCFPGfDg9oWlYhkwt945TeUKJOZKIjdyTlfJls78HIcv8gSbxHBwAum
         5rxA==
X-Gm-Message-State: APjAAAWupagsF2N+De7IOj8E2C3lNFJyciSDHK7CT/pGevgqVOcKSSxf
        AYQz29j9gnMJwYXuJR1/oo8ubc16
X-Google-Smtp-Source: APXvYqyYrzgoIT/37LmeWh+C3pdLwhhAk8H4zOr4Ao989DT0hYQGJis7SSssB5ePBqmRacfvaSQ0VA==
X-Received: by 2002:aa7:8dcf:: with SMTP id j15mr30307085pfr.175.1556366545164;
        Sat, 27 Apr 2019 05:02:25 -0700 (PDT)
Received: from archbookpro.localdomain ([216.9.110.14])
        by smtp.gmail.com with ESMTPSA id x66sm64457769pfb.78.2019.04.27.05.02.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Apr 2019 05:02:24 -0700 (PDT)
Date:   Sat, 27 Apr 2019 05:02:22 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/2] branch: make create_branch accept a merge base rev
Message-ID: <bb258527407126fa6e3d56de64dc76fd52c5d504.1556366347.git.liu.denton@gmail.com>
References: <cover.1556305561.git.liu.denton@gmail.com>
 <cover.1556366347.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556366347.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we ran something like

    $ git checkout -b test master...

it would fail with the message

    fatal: Not a valid object name: 'master...'.

This was caused by the call to `create_branch` where `start_name` is
expected to be a valid rev. However, git-checkout allows the branch to
be a valid _merge base_ rev (i.e. with a "...") so it was possible for
an invalid rev to be passed in.

Make `create_branch` accept a merge base rev so that this case does not
error out.

As a side-effect, teach git-branch how to handle merge base revs as
well.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-branch.txt   |  6 +++++-
 Documentation/git-checkout.txt |  4 ++++
 branch.c                       |  2 +-
 t/t2018-checkout-branch.sh     | 13 +++++++++++++
 t/t3200-branch.sh              | 14 ++++++++++----
 5 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 0cd87ddeff..6ebd512b4f 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -45,7 +45,11 @@ argument is missing it defaults to `HEAD` (i.e. the tip of the current
 branch).
 
 The command's second form creates a new branch head named <branchname>
-which points to the current `HEAD`, or <start-point> if given.
+which points to the current `HEAD`, or <start-point> if given. As a
+special case, for <start-point>, you may use `"A...B"` as a shortcut for
+the merge base of `A` and `B` if there is exactly one merge base. You
+can leave out at most one of `A` and `B`, in which case it defaults to
+`HEAD`.
 
 Note that this will create the new branch, but it will not switch the
 working tree to it; use "git checkout <newbranch>" to switch to the
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 877e5f503a..964f912d29 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -313,6 +313,10 @@ leave out at most one of `A` and `B`, in which case it defaults to `HEAD`.
 <start_point>::
 	The name of a commit at which to start the new branch; see
 	linkgit:git-branch[1] for details. Defaults to HEAD.
++
+As a special case, you may use `"A...B"` as a shortcut for the
+merge base of `A` and `B` if there is exactly one merge base. You can
+leave out at most one of `A` and `B`, in which case it defaults to `HEAD`.
 
 <tree-ish>::
 	Tree to checkout from (when paths are given). If not specified,
diff --git a/branch.c b/branch.c
index 28b81a7e02..a84c8aaca2 100644
--- a/branch.c
+++ b/branch.c
@@ -268,7 +268,7 @@ void create_branch(struct repository *r,
 	}
 
 	real_ref = NULL;
-	if (get_oid(start_name, &oid)) {
+	if (get_oid_mb(start_name, &oid)) {
 		if (explicit_tracking) {
 			if (advice_set_upstream_failure) {
 				error(_(upstream_missing), start_name);
diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index f1c7023e1a..822381dd9d 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -66,6 +66,13 @@ test_expect_success 'checkout -b to a new branch, set to HEAD' '
 	do_checkout branch2
 '
 
+test_expect_success 'checkout -b to a merge base' '
+	test_when_finished "
+		git checkout branch1 &&
+		test_might_fail git branch -D branch2" &&
+	git checkout -b branch2 branch1...
+'
+
 test_expect_success 'checkout -b to a new branch, set to an explicit ref' '
 	test_when_finished "
 		git checkout branch1 &&
@@ -126,6 +133,12 @@ test_expect_success 'checkout -B to an existing branch resets branch to HEAD' '
 	do_checkout branch2 "" -B
 '
 
+test_expect_success 'checkout -B to a merge base' '
+	git checkout branch1 &&
+
+	git checkout -B branch2 branch1...
+'
+
 test_expect_success 'checkout -B to an existing branch from detached HEAD resets branch to HEAD' '
 	git checkout $(git rev-parse --verify HEAD) &&
 
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 478b82cf9b..acb16b62dd 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -42,6 +42,10 @@ test_expect_success 'git branch a/b/c should create a branch' '
 	git branch a/b/c && test_path_is_file .git/refs/heads/a/b/c
 '
 
+test_expect_success 'git branch mb master... should create a branch' '
+	git branch mb master... && test_path_is_file .git/refs/heads/mb
+'
+
 test_expect_success 'git branch HEAD should fail' '
 	test_must_fail git branch HEAD
 '
@@ -292,8 +296,8 @@ test_expect_success 'git branch --list -v with --abbrev' '
 test_expect_success 'git branch --column' '
 	COLUMNS=81 git branch --column=column >actual &&
 	cat >expected <<\EOF &&
-  a/b/c     bam       foo       l       * master    n         o/p       r
-  abc       bar       j/k       m/m       master2   o/o       q
+  a/b/c     bam       foo       l       * master    mb        o/o       q
+  abc       bar       j/k       m/m       master2   n         o/p       r
 EOF
 	test_cmp expected actual
 '
@@ -315,6 +319,7 @@ test_expect_success 'git branch --column with an extremely long branch name' '
   m/m
 * master
   master2
+  mb
   n
   o/o
   o/p
@@ -332,8 +337,8 @@ test_expect_success 'git branch with column.*' '
 	git config --unset column.branch &&
 	git config --unset column.ui &&
 	cat >expected <<\EOF &&
-  a/b/c   bam   foo   l   * master    n     o/p   r
-  abc     bar   j/k   m/m   master2   o/o   q
+  a/b/c   bam   foo   l   * master    mb   o/o   q
+  abc     bar   j/k   m/m   master2   n    o/p   r
 EOF
 	test_cmp expected actual
 '
@@ -357,6 +362,7 @@ test_expect_success 'git branch -v with column.ui ignored' '
   m/m
 * master
   master2
+  mb
   n
   o/o
   o/p
-- 
2.21.0.1000.g11cd861522

