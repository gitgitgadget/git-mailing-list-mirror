Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 578B11F453
	for <e@80x24.org>; Fri, 26 Apr 2019 19:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfDZTVO (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Apr 2019 15:21:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35516 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfDZTVN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Apr 2019 15:21:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id h1so2070005pgs.2
        for <git@vger.kernel.org>; Fri, 26 Apr 2019 12:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VTnscqqTxCdKttZknuiVR4oea6vxDOrjzR7p2ihiUD0=;
        b=dS5JN2dbX6l4YOVmhgJ+0Yg0MpANr3b8SlEdlj2lGqhZFCQyodQNJ7RBXHUjH7PUcg
         M9fEgeNmyGb9qTQdpvxPbv3rokPEjeKXHTLhkR0ef8f1oP9V/DCL/TZndh5m7so8SNpS
         EgT2bCTSyLGKahxFPGr8IBUFlVvvD8T5GhsGru7nDh79BtayleBotfJfzj0Tf0RZACkW
         PZoSCOwsP1h9jlRUWi58ETShOJz4UsHAU5QtoC8spFUxqNCsxwT557s5C8KpYn/jt2xw
         qj1OaevAHEJcxXGQbiR8OmxVlWxYPqMmWtthnakYvlomE0F00Zl1mkihYPyBr+VijXpU
         nlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VTnscqqTxCdKttZknuiVR4oea6vxDOrjzR7p2ihiUD0=;
        b=UQN7SQJWtyfeK7LJmILqi34MbDVNlEy/oDP84a2HrByk3joTda5xXiKQuj1mF7vXkY
         p53kKdTeoy7SRZZ1H71dU60M6Vq8NR7M+64IImH4LRz0ZFTaio5mMPolMOvq2501bWMv
         VaDO4GuJ+/rnyCofIsuOoSonQ/qCu3gIGwazrc01Hvfj0VcZCuQ77BMou5MXx6x+ynVm
         pdmOs83bgRaBn5g9E40rdJhXrVNyneZbduJrDlPvqUzCKZQMlagz7bSBUQoC8Ufbvb/A
         NklKPKODcaOk1Bs+jw1q3EWHxhjkCHWhBYq691kv0qETJSu2crN49XYfYbxYKonpJ2/B
         azSg==
X-Gm-Message-State: APjAAAW50kMt5pn86outI90MUM7VYxS6KcguN8JYTqFAW0zxfWT0vj4o
        ggOXx+3s1k9OXJaxMO0g8mQnz2hgJYg=
X-Google-Smtp-Source: APXvYqw/gtU8dhCUm6MQP0UpUt+PlKkjpyO0geGyvQWAOVXy/YbCuJYjaRKPNzN0Tk11aEj2cXKaWw==
X-Received: by 2002:a65:638f:: with SMTP id h15mr45342955pgv.147.1556306472233;
        Fri, 26 Apr 2019 12:21:12 -0700 (PDT)
Received: from dev-l ([149.28.199.249])
        by smtp.gmail.com with ESMTPSA id x128sm47686132pfx.103.2019.04.26.12.21.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 12:21:11 -0700 (PDT)
Date:   Fri, 26 Apr 2019 12:21:11 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/3] branch: make create_branch accept a merge base rev
Message-ID: <c91c7535a7908febb70499e570e1db3209dd465f.1556305561.git.liu.denton@gmail.com>
References: <cover.1556226502.git.liu.denton@gmail.com>
 <cover.1556305561.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556305561.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
 Documentation/git-branch.txt |  6 +++++-
 branch.c                     |  2 +-
 t/t2018-checkout-branch.sh   |  4 ++--
 t/t3200-branch.sh            | 14 ++++++++++----
 4 files changed, 18 insertions(+), 8 deletions(-)

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
index 3cd142657a..822381dd9d 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -66,7 +66,7 @@ test_expect_success 'checkout -b to a new branch, set to HEAD' '
 	do_checkout branch2
 '
 
-test_expect_failure 'checkout -b to a merge base' '
+test_expect_success 'checkout -b to a merge base' '
 	test_when_finished "
 		git checkout branch1 &&
 		test_might_fail git branch -D branch2" &&
@@ -133,7 +133,7 @@ test_expect_success 'checkout -B to an existing branch resets branch to HEAD' '
 	do_checkout branch2 "" -B
 '
 
-test_expect_failure 'checkout -B to a merge base' '
+test_expect_success 'checkout -B to a merge base' '
 	git checkout branch1 &&
 
 	git checkout -B branch2 branch1...
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
2.21.0.1033.g0e8cc1100c

