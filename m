Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC8FC0018C
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 01:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCC1722D74
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 01:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733013AbgLQBIm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 20:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731346AbgLQBIg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 20:08:36 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CBAC0611CA
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 17:07:22 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id c133so4005678wme.4
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 17:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MeH4rM/i67JHhIGyTsFD//oSSG/Lbc59NaptuEiqD9U=;
        b=YQOsUXK6eRUsLjnr5+wxAqnumsYCyZmj1x5wEK+VmnoiGGnrjTXRQIKgwBc5QCtYrJ
         bI833nd0GoIQquQH7v1KFpT3C5oLKUqdSVFVETieNbEEsvZA3fwi7l4VYSFfQgSVMzLG
         mhhmDUUfFQ1MhmnXlhOTK8hvYcxoRvpgDMd0tw0H8b3hyhHA+a4PI0X6lMhgyEtJIuvM
         PSc7s3j7fnQirl6rSTZN5s8FQB+i/WX2Xjoni0PChjHVWA23pCE7EKHabD3a7aDi1o7g
         w+DMi73qV1dKLNoBxf1szwEjrTJcWx1xRkbYLZQtmQ7nRVZFQrPzdHgbLis9eDRVBA+s
         oc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MeH4rM/i67JHhIGyTsFD//oSSG/Lbc59NaptuEiqD9U=;
        b=JJ+Iso2kVh0z0j3uQV9mOBvnUQ30OQ1tv1U6rVE189WlI4K8s20n1kV4q+RY5v8hm8
         ezEfqUJX/l8QbA+nLMOwjyFgG5FMBIZU1ltbkuxa9g1f/1h6U7GKIsEX46VrobrF3WMe
         fRI2AGSOoFwbL8x55vt+eanWt7Gs4AjX6fXSCu3tC9rkrlGopqkQs2cAMluN4y8HP4/m
         8IfApA/hA3DG5sFISMYzCyu86etYY8NUIWW6xoOgdj73+9eboo42VWJlFgXZ8YZmmRSh
         9pjkMDIYO+2FPC7DN1K9IeJdiGs8h1HmQ9vVUPH/Hvcqp8QVtQLP00zFXICZAtY/YGES
         fWEQ==
X-Gm-Message-State: AOAM53220q1Czla1kCuK0KLO85joqwLwJApofnWy/s6qRgyZyarQaNtF
        Kx4/HjQGyz9huIBlcv/tPZkyd6hKTn8=
X-Google-Smtp-Source: ABdhPJwLO/6DyjfUKpLUw/i47aEasBY926cSSDf7PXiBa5bR1gGQpULvRv3Lw8KgH7/KbwHqMPtmuw==
X-Received: by 2002:a1c:8016:: with SMTP id b22mr5876917wmd.135.1608167240231;
        Wed, 16 Dec 2020 17:07:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h29sm5859663wrc.68.2020.12.16.17.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 17:07:19 -0800 (PST)
Message-Id: <ba7d113587597fdce68860ab9d9074cbf12e1368.1608167230.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.816.git.1608167230.gitgitgadget@gmail.com>
References: <pull.816.git.1608167230.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Dec 2020 01:07:09 +0000
Subject: [PATCH 10/11] t9902: use `main` as initial branch name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 8164360fc86 (t9902: prepare a test for the upcoming default branch
name, 2020-10-23), we started adjusting this test script for the default
initial branch name changing to `main`.

However, there is no need to wait for that: let's adjust the test script
to stop relying on a specific initial branch name by setting it
explicitly. This allows us to drop the `PREPARE_FOR_MAIN_BRANCH` prereq
from one test case.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t9902-completion.sh | 309 +++++++++++++++++++++---------------------
 1 file changed, 155 insertions(+), 154 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 81a728c7433..a1c4f1f6d40 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -136,7 +136,7 @@ fi
 test_expect_success 'setup for __git_find_repo_path/__gitdir tests' '
 	mkdir -p subdir/subsubdir &&
 	mkdir -p non-repo &&
-	git init otherrepo
+	git init -b main otherrepo
 '
 
 test_expect_success '__git_find_repo_path - from command line (through $__git_dir)' '
@@ -614,12 +614,13 @@ test_expect_success '__git_is_configured_remote' '
 
 test_expect_success 'setup for ref completion' '
 	git commit --allow-empty -m initial &&
+	git branch -M main &&
 	git branch matching-branch &&
 	git tag matching-tag &&
 	(
 		cd otherrepo &&
 		git commit --allow-empty -m initial &&
-		git branch -m master master-in-other &&
+		git branch -m main main-in-other &&
 		git branch branch-in-other &&
 		git tag tag-in-other
 	) &&
@@ -632,10 +633,10 @@ test_expect_success 'setup for ref completion' '
 test_expect_success '__git_refs - simple' '
 	cat >expected <<-EOF &&
 	HEAD
-	master
+	main
 	matching-branch
 	other/branch-in-other
-	other/master-in-other
+	other/main-in-other
 	matching-tag
 	EOF
 	(
@@ -647,10 +648,10 @@ test_expect_success '__git_refs - simple' '
 
 test_expect_success '__git_refs - full refs' '
 	cat >expected <<-EOF &&
-	refs/heads/master
+	refs/heads/main
 	refs/heads/matching-branch
 	refs/remotes/other/branch-in-other
-	refs/remotes/other/master-in-other
+	refs/remotes/other/main-in-other
 	refs/tags/matching-tag
 	EOF
 	(
@@ -664,7 +665,7 @@ test_expect_success '__git_refs - repo given on the command line' '
 	cat >expected <<-EOF &&
 	HEAD
 	branch-in-other
-	master-in-other
+	main-in-other
 	tag-in-other
 	EOF
 	(
@@ -679,7 +680,7 @@ test_expect_success '__git_refs - remote on local file system' '
 	cat >expected <<-EOF &&
 	HEAD
 	branch-in-other
-	master-in-other
+	main-in-other
 	tag-in-other
 	EOF
 	(
@@ -692,7 +693,7 @@ test_expect_success '__git_refs - remote on local file system' '
 test_expect_success '__git_refs - remote on local file system - full refs' '
 	cat >expected <<-EOF &&
 	refs/heads/branch-in-other
-	refs/heads/master-in-other
+	refs/heads/main-in-other
 	refs/tags/tag-in-other
 	EOF
 	(
@@ -706,7 +707,7 @@ test_expect_success '__git_refs - configured remote' '
 	cat >expected <<-EOF &&
 	HEAD
 	branch-in-other
-	master-in-other
+	main-in-other
 	EOF
 	(
 		cur= &&
@@ -719,7 +720,7 @@ test_expect_success '__git_refs - configured remote - full refs' '
 	cat >expected <<-EOF &&
 	HEAD
 	refs/heads/branch-in-other
-	refs/heads/master-in-other
+	refs/heads/main-in-other
 	refs/tags/tag-in-other
 	EOF
 	(
@@ -733,7 +734,7 @@ test_expect_success '__git_refs - configured remote - repo given on the command
 	cat >expected <<-EOF &&
 	HEAD
 	branch-in-other
-	master-in-other
+	main-in-other
 	EOF
 	(
 		cd thirdrepo &&
@@ -748,7 +749,7 @@ test_expect_success '__git_refs - configured remote - full refs - repo given on
 	cat >expected <<-EOF &&
 	HEAD
 	refs/heads/branch-in-other
-	refs/heads/master-in-other
+	refs/heads/main-in-other
 	refs/tags/tag-in-other
 	EOF
 	(
@@ -764,7 +765,7 @@ test_expect_success '__git_refs - configured remote - remote name matches a dire
 	cat >expected <<-EOF &&
 	HEAD
 	branch-in-other
-	master-in-other
+	main-in-other
 	EOF
 	mkdir other &&
 	test_when_finished "rm -rf other" &&
@@ -779,7 +780,7 @@ test_expect_success '__git_refs - URL remote' '
 	cat >expected <<-EOF &&
 	HEAD
 	branch-in-other
-	master-in-other
+	main-in-other
 	tag-in-other
 	EOF
 	(
@@ -793,7 +794,7 @@ test_expect_success '__git_refs - URL remote - full refs' '
 	cat >expected <<-EOF &&
 	HEAD
 	refs/heads/branch-in-other
-	refs/heads/master-in-other
+	refs/heads/main-in-other
 	refs/tags/tag-in-other
 	EOF
 	(
@@ -849,23 +850,23 @@ test_expect_success '__git_refs - not in a git repository' '
 test_expect_success '__git_refs - unique remote branches for git checkout DWIMery' '
 	cat >expected <<-EOF &&
 	HEAD
-	master
+	main
 	matching-branch
 	other/ambiguous
 	other/branch-in-other
-	other/master-in-other
+	other/main-in-other
 	remote/ambiguous
 	remote/branch-in-remote
 	matching-tag
 	branch-in-other
 	branch-in-remote
-	master-in-other
+	main-in-other
 	EOF
 	for remote_ref in refs/remotes/other/ambiguous \
 		refs/remotes/remote/ambiguous \
 		refs/remotes/remote/branch-in-remote
 	do
-		git update-ref $remote_ref master &&
+		git update-ref $remote_ref main &&
 		test_when_finished "git update-ref -d $remote_ref"
 	done &&
 	(
@@ -878,10 +879,10 @@ test_expect_success '__git_refs - unique remote branches for git checkout DWIMer
 test_expect_success '__git_refs - after --opt=' '
 	cat >expected <<-EOF &&
 	HEAD
-	master
+	main
 	matching-branch
 	other/branch-in-other
-	other/master-in-other
+	other/main-in-other
 	matching-tag
 	EOF
 	(
@@ -893,10 +894,10 @@ test_expect_success '__git_refs - after --opt=' '
 
 test_expect_success '__git_refs - after --opt= - full refs' '
 	cat >expected <<-EOF &&
-	refs/heads/master
+	refs/heads/main
 	refs/heads/matching-branch
 	refs/remotes/other/branch-in-other
-	refs/remotes/other/master-in-other
+	refs/remotes/other/main-in-other
 	refs/tags/matching-tag
 	EOF
 	(
@@ -909,10 +910,10 @@ test_expect_success '__git_refs - after --opt= - full refs' '
 test_expect_success '__git refs - excluding refs' '
 	cat >expected <<-EOF &&
 	^HEAD
-	^master
+	^main
 	^matching-branch
 	^other/branch-in-other
-	^other/master-in-other
+	^other/main-in-other
 	^matching-tag
 	EOF
 	(
@@ -924,10 +925,10 @@ test_expect_success '__git refs - excluding refs' '
 
 test_expect_success '__git refs - excluding full refs' '
 	cat >expected <<-EOF &&
-	^refs/heads/master
+	^refs/heads/main
 	^refs/heads/matching-branch
 	^refs/remotes/other/branch-in-other
-	^refs/remotes/other/master-in-other
+	^refs/remotes/other/main-in-other
 	^refs/tags/matching-tag
 	EOF
 	(
@@ -948,17 +949,17 @@ test_expect_success 'setup for filtering matching refs' '
 test_expect_success '__git_refs - do not filter refs unless told so' '
 	cat >expected <<-EOF &&
 	HEAD
-	master
+	main
 	matching-branch
 	matching/branch
 	other/branch-in-other
-	other/master-in-other
+	other/main-in-other
 	other/matching/branch-in-other
 	matching-tag
 	matching/tag
 	EOF
 	(
-		cur=master &&
+		cur=main &&
 		__git_refs >"$actual"
 	) &&
 	test_cmp expected "$actual"
@@ -992,7 +993,7 @@ test_expect_success '__git_refs - only matching refs - full refs' '
 
 test_expect_success '__git_refs - only matching refs - remote on local file system' '
 	cat >expected <<-EOF &&
-	master-in-other
+	main-in-other
 	matching/branch-in-other
 	EOF
 	(
@@ -1004,7 +1005,7 @@ test_expect_success '__git_refs - only matching refs - remote on local file syst
 
 test_expect_success '__git_refs - only matching refs - configured remote' '
 	cat >expected <<-EOF &&
-	master-in-other
+	main-in-other
 	matching/branch-in-other
 	EOF
 	(
@@ -1016,7 +1017,7 @@ test_expect_success '__git_refs - only matching refs - configured remote' '
 
 test_expect_success '__git_refs - only matching refs - remote - full refs' '
 	cat >expected <<-EOF &&
-	refs/heads/master-in-other
+	refs/heads/main-in-other
 	refs/heads/matching/branch-in-other
 	EOF
 	(
@@ -1038,7 +1039,7 @@ test_expect_success '__git_refs - only matching refs - checkout DWIMery' '
 		refs/remotes/remote/ambiguous \
 		refs/remotes/remote/branch-in-remote
 	do
-		git update-ref $remote_ref master &&
+		git update-ref $remote_ref main &&
 		test_when_finished "git update-ref -d $remote_ref"
 	done &&
 	(
@@ -1055,9 +1056,9 @@ test_expect_success 'teardown after filtering matching refs' '
 	git -C otherrepo branch -D matching/branch-in-other
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH '__git_refs - for-each-ref format specifiers in prefix' '
+test_expect_success '__git_refs - for-each-ref format specifiers in prefix' '
 	cat >expected <<-EOF &&
-	evil-%%-%42-%(refname)..master
+	evil-%%-%42-%(refname)..main
 	EOF
 	(
 		cur="evil-%%-%42-%(refname)..mai" &&
@@ -1069,10 +1070,10 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH '__git_refs - for-each-ref format sp
 test_expect_success '__git_complete_refs - simple' '
 	sed -e "s/Z$//" >expected <<-EOF &&
 	HEAD Z
-	master Z
+	main Z
 	matching-branch Z
 	other/branch-in-other Z
-	other/master-in-other Z
+	other/main-in-other Z
 	matching-tag Z
 	EOF
 	(
@@ -1100,7 +1101,7 @@ test_expect_success '__git_complete_refs - remote' '
 	sed -e "s/Z$//" >expected <<-EOF &&
 	HEAD Z
 	branch-in-other Z
-	master-in-other Z
+	main-in-other Z
 	EOF
 	(
 		cur= &&
@@ -1113,13 +1114,13 @@ test_expect_success '__git_complete_refs - remote' '
 test_expect_success '__git_complete_refs - track' '
 	sed -e "s/Z$//" >expected <<-EOF &&
 	HEAD Z
-	master Z
+	main Z
 	matching-branch Z
 	other/branch-in-other Z
-	other/master-in-other Z
+	other/main-in-other Z
 	matching-tag Z
 	branch-in-other Z
-	master-in-other Z
+	main-in-other Z
 	EOF
 	(
 		cur= &&
@@ -1158,10 +1159,10 @@ test_expect_success '__git_complete_refs - prefix' '
 test_expect_success '__git_complete_refs - suffix' '
 	cat >expected <<-EOF &&
 	HEAD.
-	master.
+	main.
 	matching-branch.
 	other/branch-in-other.
-	other/master-in-other.
+	other/main-in-other.
 	matching-tag.
 	EOF
 	(
@@ -1176,7 +1177,7 @@ test_expect_success '__git_complete_fetch_refspecs - simple' '
 	sed -e "s/Z$//" >expected <<-EOF &&
 	HEAD:HEAD Z
 	branch-in-other:branch-in-other Z
-	master-in-other:master-in-other Z
+	main-in-other:main-in-other Z
 	EOF
 	(
 		cur= &&
@@ -1202,7 +1203,7 @@ test_expect_success '__git_complete_fetch_refspecs - prefix' '
 	sed -e "s/Z$//" >expected <<-EOF &&
 	+HEAD:HEAD Z
 	+branch-in-other:branch-in-other Z
-	+master-in-other:master-in-other Z
+	+main-in-other:main-in-other Z
 	EOF
 	(
 		cur="+" &&
@@ -1215,7 +1216,7 @@ test_expect_success '__git_complete_fetch_refspecs - prefix' '
 test_expect_success '__git_complete_fetch_refspecs - fully qualified' '
 	sed -e "s/Z$//" >expected <<-EOF &&
 	refs/heads/branch-in-other:refs/heads/branch-in-other Z
-	refs/heads/master-in-other:refs/heads/master-in-other Z
+	refs/heads/main-in-other:refs/heads/main-in-other Z
 	refs/tags/tag-in-other:refs/tags/tag-in-other Z
 	EOF
 	(
@@ -1229,7 +1230,7 @@ test_expect_success '__git_complete_fetch_refspecs - fully qualified' '
 test_expect_success '__git_complete_fetch_refspecs - fully qualified & prefix' '
 	sed -e "s/Z$//" >expected <<-EOF &&
 	+refs/heads/branch-in-other:refs/heads/branch-in-other Z
-	+refs/heads/master-in-other:refs/heads/master-in-other Z
+	+refs/heads/main-in-other:refs/heads/main-in-other Z
 	+refs/tags/tag-in-other:refs/tags/tag-in-other Z
 	EOF
 	(
@@ -1243,8 +1244,8 @@ test_expect_success '__git_complete_fetch_refspecs - fully qualified & prefix' '
 test_expect_success 'git switch - with no options, complete local branches and unique remote branch names for DWIM logic' '
 	test_completion "git switch " <<-\EOF
 	branch-in-other Z
-	master Z
-	master-in-other Z
+	main Z
+	main-in-other Z
 	matching-branch Z
 	EOF
 '
@@ -1253,25 +1254,25 @@ test_expect_success 'git checkout - completes refs and unique remote branches fo
 	test_completion "git checkout " <<-\EOF
 	HEAD Z
 	branch-in-other Z
-	master Z
-	master-in-other Z
+	main Z
+	main-in-other Z
 	matching-branch Z
 	matching-tag Z
 	other/branch-in-other Z
-	other/master-in-other Z
+	other/main-in-other Z
 	EOF
 '
 
 test_expect_success 'git switch - with --no-guess, complete only local branches' '
 	test_completion "git switch --no-guess " <<-\EOF
-	master Z
+	main Z
 	matching-branch Z
 	EOF
 '
 
 test_expect_success 'git switch - with GIT_COMPLETION_CHECKOUT_NO_GUESS=1, complete only local branches' '
 	GIT_COMPLETION_CHECKOUT_NO_GUESS=1 test_completion "git switch " <<-\EOF
-	master Z
+	main Z
 	matching-branch Z
 	EOF
 '
@@ -1279,8 +1280,8 @@ test_expect_success 'git switch - with GIT_COMPLETION_CHECKOUT_NO_GUESS=1, compl
 test_expect_success 'git switch - --guess overrides GIT_COMPLETION_CHECKOUT_NO_GUESS=1, complete local branches and unique remote names for DWIM logic' '
 	GIT_COMPLETION_CHECKOUT_NO_GUESS=1 test_completion "git switch --guess " <<-\EOF
 	branch-in-other Z
-	master Z
-	master-in-other Z
+	main Z
+	main-in-other Z
 	matching-branch Z
 	EOF
 '
@@ -1288,15 +1289,15 @@ test_expect_success 'git switch - --guess overrides GIT_COMPLETION_CHECKOUT_NO_G
 test_expect_success 'git switch - a later --guess overrides previous --no-guess, complete local and remote unique branches for DWIM' '
 	test_completion "git switch --no-guess --guess " <<-\EOF
 	branch-in-other Z
-	master Z
-	master-in-other Z
+	main Z
+	main-in-other Z
 	matching-branch Z
 	EOF
 '
 
 test_expect_success 'git switch - a later --no-guess overrides previous --guess, complete only local branches' '
 	test_completion "git switch --guess --no-guess " <<-\EOF
-	master Z
+	main Z
 	matching-branch Z
 	EOF
 '
@@ -1304,11 +1305,11 @@ test_expect_success 'git switch - a later --no-guess overrides previous --guess,
 test_expect_success 'git checkout - with GIT_COMPLETION_NO_GUESS=1 only completes refs' '
 	GIT_COMPLETION_CHECKOUT_NO_GUESS=1 test_completion "git checkout " <<-\EOF
 	HEAD Z
-	master Z
+	main Z
 	matching-branch Z
 	matching-tag Z
 	other/branch-in-other Z
-	other/master-in-other Z
+	other/main-in-other Z
 	EOF
 '
 
@@ -1316,23 +1317,23 @@ test_expect_success 'git checkout - --guess overrides GIT_COMPLETION_NO_GUESS=1,
 	GIT_COMPLETION_CHECKOUT_NO_GUESS=1 test_completion "git checkout --guess " <<-\EOF
 	HEAD Z
 	branch-in-other Z
-	master Z
-	master-in-other Z
+	main Z
+	main-in-other Z
 	matching-branch Z
 	matching-tag Z
 	other/branch-in-other Z
-	other/master-in-other Z
+	other/main-in-other Z
 	EOF
 '
 
 test_expect_success 'git checkout - with --no-guess, only completes refs' '
 	test_completion "git checkout --no-guess " <<-\EOF
 	HEAD Z
-	master Z
+	main Z
 	matching-branch Z
 	matching-tag Z
 	other/branch-in-other Z
-	other/master-in-other Z
+	other/main-in-other Z
 	EOF
 '
 
@@ -1340,23 +1341,23 @@ test_expect_success 'git checkout - a later --guess overrides previous --no-gues
 	test_completion "git checkout --no-guess --guess " <<-\EOF
 	HEAD Z
 	branch-in-other Z
-	master Z
-	master-in-other Z
+	main Z
+	main-in-other Z
 	matching-branch Z
 	matching-tag Z
 	other/branch-in-other Z
-	other/master-in-other Z
+	other/main-in-other Z
 	EOF
 '
 
 test_expect_success 'git checkout - a later --no-guess overrides previous --guess, complete only refs' '
 	test_completion "git checkout --guess --no-guess " <<-\EOF
 	HEAD Z
-	master Z
+	main Z
 	matching-branch Z
 	matching-tag Z
 	other/branch-in-other Z
-	other/master-in-other Z
+	other/main-in-other Z
 	EOF
 '
 
@@ -1364,11 +1365,11 @@ test_expect_success 'git checkout - with checkout.guess = false, only completes
 	test_config checkout.guess false &&
 	test_completion "git checkout " <<-\EOF
 	HEAD Z
-	master Z
+	main Z
 	matching-branch Z
 	matching-tag Z
 	other/branch-in-other Z
-	other/master-in-other Z
+	other/main-in-other Z
 	EOF
 '
 
@@ -1377,12 +1378,12 @@ test_expect_success 'git checkout - with checkout.guess = true, completes refs a
 	test_completion "git checkout " <<-\EOF
 	HEAD Z
 	branch-in-other Z
-	master Z
-	master-in-other Z
+	main Z
+	main-in-other Z
 	matching-branch Z
 	matching-tag Z
 	other/branch-in-other Z
-	other/master-in-other Z
+	other/main-in-other Z
 	EOF
 '
 
@@ -1391,12 +1392,12 @@ test_expect_success 'git checkout - a later --guess overrides previous checkout.
 	test_completion "git checkout --guess " <<-\EOF
 	HEAD Z
 	branch-in-other Z
-	master Z
-	master-in-other Z
+	main Z
+	main-in-other Z
 	matching-branch Z
 	matching-tag Z
 	other/branch-in-other Z
-	other/master-in-other Z
+	other/main-in-other Z
 	EOF
 '
 
@@ -1404,75 +1405,75 @@ test_expect_success 'git checkout - a later --no-guess overrides previous checko
 	test_config checkout.guess true &&
 	test_completion "git checkout --no-guess " <<-\EOF
 	HEAD Z
-	master Z
+	main Z
 	matching-branch Z
 	matching-tag Z
 	other/branch-in-other Z
-	other/master-in-other Z
+	other/main-in-other Z
 	EOF
 '
 
 test_expect_success 'git switch - with --detach, complete all references' '
 	test_completion "git switch --detach " <<-\EOF
 	HEAD Z
-	master Z
+	main Z
 	matching-branch Z
 	matching-tag Z
 	other/branch-in-other Z
-	other/master-in-other Z
+	other/main-in-other Z
 	EOF
 '
 
 test_expect_success 'git checkout - with --detach, complete only references' '
 	test_completion "git checkout --detach " <<-\EOF
 	HEAD Z
-	master Z
+	main Z
 	matching-branch Z
 	matching-tag Z
 	other/branch-in-other Z
-	other/master-in-other Z
+	other/main-in-other Z
 	EOF
 '
 
 test_expect_success 'git switch - with -d, complete all references' '
 	test_completion "git switch -d " <<-\EOF
 	HEAD Z
-	master Z
+	main Z
 	matching-branch Z
 	matching-tag Z
 	other/branch-in-other Z
-	other/master-in-other Z
+	other/main-in-other Z
 	EOF
 '
 
 test_expect_success 'git checkout - with -d, complete only references' '
 	test_completion "git checkout -d " <<-\EOF
 	HEAD Z
-	master Z
+	main Z
 	matching-branch Z
 	matching-tag Z
 	other/branch-in-other Z
-	other/master-in-other Z
+	other/main-in-other Z
 	EOF
 '
 
 test_expect_success 'git switch - with --track, complete only remote branches' '
 	test_completion "git switch --track " <<-\EOF
 	other/branch-in-other Z
-	other/master-in-other Z
+	other/main-in-other Z
 	EOF
 '
 
 test_expect_success 'git checkout - with --track, complete only remote branches' '
 	test_completion "git checkout --track " <<-\EOF
 	other/branch-in-other Z
-	other/master-in-other Z
+	other/main-in-other Z
 	EOF
 '
 
 test_expect_success 'git switch - with --no-track, complete only local branch names' '
 	test_completion "git switch --no-track " <<-\EOF
-	master Z
+	main Z
 	matching-branch Z
 	EOF
 '
@@ -1480,151 +1481,151 @@ test_expect_success 'git switch - with --no-track, complete only local branch na
 test_expect_success 'git checkout - with --no-track, complete only local references' '
 	test_completion "git checkout --no-track " <<-\EOF
 	HEAD Z
-	master Z
+	main Z
 	matching-branch Z
 	matching-tag Z
 	other/branch-in-other Z
-	other/master-in-other Z
+	other/main-in-other Z
 	EOF
 '
 
 test_expect_success 'git switch - with -c, complete all references' '
 	test_completion "git switch -c new-branch " <<-\EOF
 	HEAD Z
-	master Z
+	main Z
 	matching-branch Z
 	matching-tag Z
 	other/branch-in-other Z
-	other/master-in-other Z
+	other/main-in-other Z
 	EOF
 '
 
 test_expect_success 'git switch - with -C, complete all references' '
 	test_completion "git switch -C new-branch " <<-\EOF
 	HEAD Z
-	master Z
+	main Z
 	matching-branch Z
 	matching-tag Z
 	other/branch-in-other Z
-	other/master-in-other Z
+	other/main-in-other Z
 	EOF
 '
 
 test_expect_success 'git switch - with -c and --track, complete all references' '
 	test_completion "git switch -c new-branch --track " <<-EOF
 	HEAD Z
-	master Z
+	main Z
 	matching-branch Z
 	matching-tag Z
 	other/branch-in-other Z
-	other/master-in-other Z
+	other/main-in-other Z
 	EOF
 '
 
 test_expect_success 'git switch - with -C and --track, complete all references' '
 	test_completion "git switch -C new-branch --track " <<-EOF
 	HEAD Z
-	master Z
+	main Z
 	matching-branch Z
 	matching-tag Z
 	other/branch-in-other Z
-	other/master-in-other Z
+	other/main-in-other Z
 	EOF
 '
 
 test_expect_success 'git switch - with -c and --no-track, complete all references' '
 	test_completion "git switch -c new-branch --no-track " <<-\EOF
 	HEAD Z
-	master Z
+	main Z
 	matching-branch Z
 	matching-tag Z
 	other/branch-in-other Z
-	other/master-in-other Z
+	other/main-in-other Z
 	EOF
 '
 
 test_expect_success 'git switch - with -C and --no-track, complete all references' '
 	test_completion "git switch -C new-branch --no-track " <<-\EOF
 	HEAD Z
-	master Z
+	main Z
 	matching-branch Z
 	matching-tag Z
 	other/branch-in-other Z
-	other/master-in-other Z
+	other/main-in-other Z
 	EOF
 '
 
 test_expect_success 'git checkout - with -b, complete all references' '
 	test_completion "git checkout -b new-branch " <<-\EOF
 	HEAD Z
-	master Z
+	main Z
 	matching-branch Z
 	matching-tag Z
 	other/branch-in-other Z
-	other/master-in-other Z
+	other/main-in-other Z
 	EOF
 '
 
 test_expect_success 'git checkout - with -B, complete all references' '
 	test_completion "git checkout -B new-branch " <<-\EOF
 	HEAD Z
-	master Z
+	main Z
 	matching-branch Z
 	matching-tag Z
 	other/branch-in-other Z
-	other/master-in-other Z
+	other/main-in-other Z
 	EOF
 '
 
 test_expect_success 'git checkout - with -b and --track, complete all references' '
 	test_completion "git checkout -b new-branch --track " <<-EOF
 	HEAD Z
-	master Z
+	main Z
 	matching-branch Z
 	matching-tag Z
 	other/branch-in-other Z
-	other/master-in-other Z
+	other/main-in-other Z
 	EOF
 '
 
 test_expect_success 'git checkout - with -B and --track, complete all references' '
 	test_completion "git checkout -B new-branch --track " <<-EOF
 	HEAD Z
-	master Z
+	main Z
 	matching-branch Z
 	matching-tag Z
 	other/branch-in-other Z
-	other/master-in-other Z
+	other/main-in-other Z
 	EOF
 '
 
 test_expect_success 'git checkout - with -b and --no-track, complete all references' '
 	test_completion "git checkout -b new-branch --no-track " <<-\EOF
 	HEAD Z
-	master Z
+	main Z
 	matching-branch Z
 	matching-tag Z
 	other/branch-in-other Z
-	other/master-in-other Z
+	other/main-in-other Z
 	EOF
 '
 
 test_expect_success 'git checkout - with -B and --no-track, complete all references' '
 	test_completion "git checkout -B new-branch --no-track " <<-\EOF
 	HEAD Z
-	master Z
+	main Z
 	matching-branch Z
 	matching-tag Z
 	other/branch-in-other Z
-	other/master-in-other Z
+	other/main-in-other Z
 	EOF
 '
 
 test_expect_success 'git switch - for -c, complete local branches and unique remote branches' '
 	test_completion "git switch -c " <<-\EOF
 	branch-in-other Z
-	master Z
-	master-in-other Z
+	main Z
+	main-in-other Z
 	matching-branch Z
 	EOF
 '
@@ -1632,36 +1633,36 @@ test_expect_success 'git switch - for -c, complete local branches and unique rem
 test_expect_success 'git switch - for -C, complete local branches and unique remote branches' '
 	test_completion "git switch -C " <<-\EOF
 	branch-in-other Z
-	master Z
-	master-in-other Z
+	main Z
+	main-in-other Z
 	matching-branch Z
 	EOF
 '
 
 test_expect_success 'git switch - for -c with --no-guess, complete local branches only' '
 	test_completion "git switch --no-guess -c " <<-\EOF
-	master Z
+	main Z
 	matching-branch Z
 	EOF
 '
 
 test_expect_success 'git switch - for -C with --no-guess, complete local branches only' '
 	test_completion "git switch --no-guess -C " <<-\EOF
-	master Z
+	main Z
 	matching-branch Z
 	EOF
 '
 
 test_expect_success 'git switch - for -c with --no-track, complete local branches only' '
 	test_completion "git switch --no-track -c " <<-\EOF
-	master Z
+	main Z
 	matching-branch Z
 	EOF
 '
 
 test_expect_success 'git switch - for -C with --no-track, complete local branches only' '
 	test_completion "git switch --no-track -C " <<-\EOF
-	master Z
+	main Z
 	matching-branch Z
 	EOF
 '
@@ -1669,8 +1670,8 @@ test_expect_success 'git switch - for -C with --no-track, complete local branche
 test_expect_success 'git checkout - for -b, complete local branches and unique remote branches' '
 	test_completion "git checkout -b " <<-\EOF
 	branch-in-other Z
-	master Z
-	master-in-other Z
+	main Z
+	main-in-other Z
 	matching-branch Z
 	EOF
 '
@@ -1678,36 +1679,36 @@ test_expect_success 'git checkout - for -b, complete local branches and unique r
 test_expect_success 'git checkout - for -B, complete local branches and unique remote branches' '
 	test_completion "git checkout -B " <<-\EOF
 	branch-in-other Z
-	master Z
-	master-in-other Z
+	main Z
+	main-in-other Z
 	matching-branch Z
 	EOF
 '
 
 test_expect_success 'git checkout - for -b with --no-guess, complete local branches only' '
 	test_completion "git checkout --no-guess -b " <<-\EOF
-	master Z
+	main Z
 	matching-branch Z
 	EOF
 '
 
 test_expect_success 'git checkout - for -B with --no-guess, complete local branches only' '
 	test_completion "git checkout --no-guess -B " <<-\EOF
-	master Z
+	main Z
 	matching-branch Z
 	EOF
 '
 
 test_expect_success 'git checkout - for -b with --no-track, complete local branches only' '
 	test_completion "git checkout --no-track -b " <<-\EOF
-	master Z
+	main Z
 	matching-branch Z
 	EOF
 '
 
 test_expect_success 'git checkout - for -B with --no-track, complete local branches only' '
 	test_completion "git checkout --no-track -B " <<-\EOF
-	master Z
+	main Z
 	matching-branch Z
 	EOF
 '
@@ -1715,14 +1716,14 @@ test_expect_success 'git checkout - for -B with --no-track, complete local branc
 test_expect_success 'git switch - with --orphan completes local branch names and unique remote branch names' '
 	test_completion "git switch --orphan " <<-\EOF
 	branch-in-other Z
-	master Z
-	master-in-other Z
+	main Z
+	main-in-other Z
 	matching-branch Z
 	EOF
 '
 
 test_expect_success 'git switch - --orphan with branch already provided completes nothing else' '
-	test_completion "git switch --orphan master " <<-\EOF
+	test_completion "git switch --orphan main " <<-\EOF
 
 	EOF
 '
@@ -1730,20 +1731,20 @@ test_expect_success 'git switch - --orphan with branch already provided complete
 test_expect_success 'git checkout - with --orphan completes local branch names and unique remote branch names' '
 	test_completion "git checkout --orphan " <<-\EOF
 	branch-in-other Z
-	master Z
-	master-in-other Z
+	main Z
+	main-in-other Z
 	matching-branch Z
 	EOF
 '
 
 test_expect_success 'git checkout - --orphan with branch already provided completes local refs for a start-point' '
-	test_completion "git checkout --orphan master " <<-\EOF
+	test_completion "git checkout --orphan main " <<-\EOF
 	HEAD Z
-	master Z
+	main Z
 	matching-branch Z
 	matching-tag Z
 	other/branch-in-other Z
-	other/master-in-other Z
+	other/main-in-other Z
 	EOF
 '
 
@@ -2067,7 +2068,7 @@ test_expect_success 'setup for integration tests' '
 
 test_expect_success 'checkout completes ref names' '
 	test_completion "git checkout m" <<-\EOF
-	master Z
+	main Z
 	mybranch Z
 	mytag Z
 	EOF
@@ -2081,7 +2082,7 @@ test_expect_success 'git -C <path> checkout uses the right repo' '
 
 test_expect_success 'show completes all refs' '
 	test_completion "git show m" <<-\EOF
-	master Z
+	main Z
 	mybranch Z
 	mytag Z
 	EOF
@@ -2118,7 +2119,7 @@ test_expect_success PERL 'send-email' '
 	--cover-from-description=Z
 	--cover-letter Z
 	EOF
-	test_completion "git send-email ma" "master "
+	test_completion "git send-email ma" "main "
 '
 
 test_expect_success 'complete files' '
@@ -2198,7 +2199,7 @@ test_expect_success 'complete files' '
 test_expect_success "simple alias" '
 	test_config alias.co checkout &&
 	test_completion "git co m" <<-\EOF
-	master Z
+	main Z
 	mybranch Z
 	mytag Z
 	EOF
@@ -2208,7 +2209,7 @@ test_expect_success "recursive alias" '
 	test_config alias.co checkout &&
 	test_config alias.cod "co --detached" &&
 	test_completion "git cod m" <<-\EOF
-	master Z
+	main Z
 	mybranch Z
 	mytag Z
 	EOF
@@ -2217,7 +2218,7 @@ test_expect_success "recursive alias" '
 test_expect_success "completion uses <cmd> completion for alias: !sh -c 'git <cmd> ...'" '
 	test_config alias.co "!sh -c '"'"'git checkout ...'"'"'" &&
 	test_completion "git co m" <<-\EOF
-	master Z
+	main Z
 	mybranch Z
 	mytag Z
 	EOF
@@ -2226,7 +2227,7 @@ test_expect_success "completion uses <cmd> completion for alias: !sh -c 'git <cm
 test_expect_success 'completion uses <cmd> completion for alias: !f () { VAR=val git <cmd> ... }' '
 	test_config alias.co "!f () { VAR=val git checkout ... ; } f" &&
 	test_completion "git co m" <<-\EOF
-	master Z
+	main Z
 	mybranch Z
 	mytag Z
 	EOF
@@ -2235,7 +2236,7 @@ test_expect_success 'completion uses <cmd> completion for alias: !f () { VAR=val
 test_expect_success 'completion used <cmd> completion for alias: !f() { : git <cmd> ; ... }' '
 	test_config alias.co "!f() { : git checkout ; if ... } f" &&
 	test_completion "git co m" <<-\EOF
-	master Z
+	main Z
 	mybranch Z
 	mytag Z
 	EOF
@@ -2266,7 +2267,7 @@ for flag in -d --delete
 do
 	test_expect_success "__git_complete_remote_or_refspec - push $flag other" '
 		sed -e "s/Z$//" >expected <<-EOF &&
-		master-in-other Z
+		main-in-other Z
 		EOF
 		(
 			words=(git push '$flag' other ma) &&
@@ -2279,7 +2280,7 @@ do
 
 	test_expect_failure "__git_complete_remote_or_refspec - push other $flag" '
 		sed -e "s/Z$//" >expected <<-EOF &&
-		master-in-other Z
+		main-in-other Z
 		EOF
 		(
 			words=(git push other '$flag' ma) &&
-- 
gitgitgadget

