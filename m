Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7CEC4361B
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 01:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84FEC22D74
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 01:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731570AbgLQBIh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 20:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728730AbgLQBIf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 20:08:35 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0BAC061285
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 17:07:18 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id a6so4010453wmc.2
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 17:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ce/+XLBF6gWeMEhbb4WeY+df//Iyc6K1tSN1HEo2i5k=;
        b=Bzhq0KgpyO+ZR66qmNP30HiMn+7m9kZjM3TGYeXzsugfQZQf18mLcoPkbaECklRymO
         leGi6TApPdSmYF7y3TVb+p9lkZ5CQc01rfV4auEF6Wn9l8Pb35XuKdIp8ERYxU5r9uc5
         L3elTYNQqdhcQNpCBAXZS7oeAzKzeeRoCeXyzht3XU2MnxknVimvqRWDMp1n0SLfe+D5
         RP4O4fjcZzBYE62gE1j6pZUuPFQPDMGOF/Fx33/G81VqKQaQTkNYBLUD6jkxMtfaE5oA
         TE2gKhteHPyGdFgoXf9zxemrFDDRAedXirNeMWYuldN0gc3dMSKYs5rn91/p2g9XoyG7
         n57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ce/+XLBF6gWeMEhbb4WeY+df//Iyc6K1tSN1HEo2i5k=;
        b=FZeLancmYrJqMCN5ocrGR1TnRabmORZTC4Hq2svyrgKxlHObEDNiQxCC+j5fuZRsPK
         yFUFeBmFHQmpDRUwozcgQWZp/g3/WIFI/F/3xMjtVh2N2viwvy1TyIlk3bL1cyFANnAk
         P+RzmZp7v8HXh+SZ1SgHr/4lbpKTFRDmoUhOIr/oWZWe9QQlvyi5zd3CBlcRGirI2Xu3
         xoda9XfGecVbhDqM8sxxLaF7yl5N+EwWMYaRcs23oq4ZtKUyjZ03OfUU8iHfu9BmLfwt
         brCVwWcgcX0XvHNvRy35F27kxV3SImWKU/VA1oZyJerSCro3yDIWOg2dJFOvSrvhE4gV
         Khdg==
X-Gm-Message-State: AOAM531bY5NpK9BZq8Cz8bSmm3COvKpje5cePw8j+kz7N3RdhpgGorzm
        HkkCiRgsa5B83oPssiSvJw8K2/+02KU=
X-Google-Smtp-Source: ABdhPJzdKbi6hicygN9ix2LKBGVYiLnct7k0Y+70scP68v5w901AQnvBGnjOrfXyzEefgLdG8AFZCA==
X-Received: by 2002:a7b:c40b:: with SMTP id k11mr5986841wmi.36.1608167237038;
        Wed, 16 Dec 2020 17:07:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i9sm5945322wrs.70.2020.12.16.17.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 17:07:16 -0800 (PST)
Message-Id: <34309526806256171215daf54b4e283eb3e7e0a7.1608167230.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.816.git.1608167230.gitgitgadget@gmail.com>
References: <pull.816.git.1608167230.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Dec 2020 01:07:05 +0000
Subject: [PATCH 06/11] t5505: finalize transitioning to using the branch name
 `main`
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

In 66713e84e71 (tests: prepare aligned mentions of the default branch
name, 2020-10-23), we started that transition, trying to prepare for a
time when `git init` would use that name for the initial branch.

Even if that time has not arrived, we can complete the transition by
making the test script independent of the default branch name. This also
allows us to drop the `PREPARE_FOR_MAIN_BRANCH` prereq from four test
cases.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5505-remote.sh | 156 +++++++++++++++++++++++-----------------------
 1 file changed, 78 insertions(+), 78 deletions(-)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index eaa6e902204..ecadf02d64b 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -7,7 +7,7 @@ test_description='git remote porcelain-ish'
 setup_repository () {
 	mkdir "$1" && (
 	cd "$1" &&
-	git init &&
+	git init -b main &&
 	>file &&
 	git add file &&
 	test_tick &&
@@ -17,7 +17,7 @@ setup_repository () {
 	git add elif &&
 	test_tick &&
 	git commit -m "Second" &&
-	git checkout master
+	git checkout main
 	)
 }
 
@@ -60,8 +60,8 @@ test_expect_success C_LOCALE_OUTPUT 'remote information for the origin' '
 	(
 		cd test &&
 		tokens_match origin "$(git remote)" &&
-		check_remote_track origin master side &&
-		check_tracking_branch origin HEAD master side
+		check_remote_track origin main side &&
+		check_tracking_branch origin HEAD main side
 	)
 '
 
@@ -70,7 +70,7 @@ test_expect_success 'add another remote' '
 		cd test &&
 		git remote add -f second ../two &&
 		tokens_match "origin second" "$(git remote)" &&
-		check_tracking_branch second master side another &&
+		check_tracking_branch second main side another &&
 		git for-each-ref "--format=%(refname)" refs/remotes |
 		sed -e "/^refs\/remotes\/origin\//d" \
 		    -e "/^refs\/remotes\/second\//d" >actual &&
@@ -81,8 +81,8 @@ test_expect_success 'add another remote' '
 test_expect_success C_LOCALE_OUTPUT 'check remote-tracking' '
 	(
 		cd test &&
-		check_remote_track origin master side &&
-		check_remote_track second master side another
+		check_remote_track origin main side &&
+		check_remote_track second main side another
 	)
 '
 
@@ -99,7 +99,7 @@ test_expect_success 'remote forces tracking branches' '
 test_expect_success 'remove remote' '
 	(
 		cd test &&
-		git symbolic-ref refs/remotes/second/HEAD refs/remotes/second/master &&
+		git symbolic-ref refs/remotes/second/HEAD refs/remotes/second/main &&
 		git remote rm second
 	)
 '
@@ -108,7 +108,7 @@ test_expect_success C_LOCALE_OUTPUT 'remove remote' '
 	(
 		cd test &&
 		tokens_match origin "$(git remote)" &&
-		check_remote_track origin master side &&
+		check_remote_track origin main side &&
 		git for-each-ref "--format=%(refname)" refs/remotes |
 		sed -e "/^refs\/remotes\/origin\//d" >actual &&
 		test_must_be_empty actual
@@ -121,13 +121,13 @@ test_expect_success 'remove remote protects local branches' '
 		cat >expect1 <<-\EOF &&
 		Note: A branch outside the refs/remotes/ hierarchy was not removed;
 		to delete it, use:
-		  git branch -d master
+		  git branch -d main
 		EOF
 		cat >expect2 <<-\EOF &&
 		Note: Some branches outside the refs/remotes/ hierarchy were not removed;
 		to delete them, use:
 		  git branch -d foobranch
-		  git branch -d master
+		  git branch -d main
 		EOF
 		git tag footag &&
 		git config --add remote.oops.fetch "+refs/*:refs/*" &&
@@ -153,7 +153,7 @@ test_expect_success 'remove errors out early when deleting non-existent branch'
 
 test_expect_success 'remove remote with a branch without configured merge' '
 	test_when_finished "(
-		git -C test checkout master;
+		git -C test checkout main;
 		git -C test branch -D two;
 		git -C test config --remove-section remote.two;
 		git -C test config --remove-section branch.second;
@@ -163,9 +163,9 @@ test_expect_success 'remove remote with a branch without configured merge' '
 		cd test &&
 		git remote add two ../two &&
 		git fetch two &&
-		git checkout -b second two/master^0 &&
+		git checkout -b second two/main^0 &&
 		git config branch.second.remote two &&
-		git checkout master &&
+		git checkout main &&
 		git remote rm two
 	)
 '
@@ -211,7 +211,7 @@ cat >test/expect <<EOF
 * remote origin
   Fetch URL: $(pwd)/one
   Push  URL: $(pwd)/one
-  HEAD branch: master
+  HEAD branch: main
   Remote branches:
     main new (next fetch will store in remotes/origin)
     side tracked
@@ -221,32 +221,32 @@ cat >test/expect <<EOF
     octopus  merges with remote topic-a
                 and with remote topic-b
                 and with remote topic-c
-    rebase  rebases onto remote master
+    rebase  rebases onto remote main
   Local refs configured for 'git push':
     main pushes to main     (local out of date)
     main pushes to upstream (create)
 * remote two
   Fetch URL: ../two
   Push  URL: ../three
-  HEAD branch: master
+  HEAD branch: main
   Local refs configured for 'git push':
     ahead forces to main    (fast-forwardable)
     main  pushes to another (up to date)
 EOF
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'show' '
+test_expect_success 'show' '
 	(
 		cd test &&
-		git config --add remote.origin.fetch refs/heads/master:refs/heads/upstream &&
+		git config --add remote.origin.fetch refs/heads/main:refs/heads/upstream &&
 		git fetch &&
-		git checkout -b ahead origin/master &&
+		git checkout -b ahead origin/main &&
 		echo 1 >>file &&
 		test_tick &&
 		git commit -m update file &&
-		git checkout master &&
-		git branch --track octopus origin/master &&
-		git branch --track rebase origin/master &&
-		git branch -d -r origin/master &&
+		git checkout main &&
+		git branch --track octopus origin/main &&
+		git branch --track rebase origin/main &&
+		git branch -d -r origin/main &&
 		git config --add remote.two.url ../two &&
 		git config --add remote.two.pushurl ../three &&
 		git config branch.rebase.rebase true &&
@@ -258,10 +258,10 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH 'show' '
 			git commit -m update file
 		) &&
 		git config --add remote.origin.push : &&
-		git config --add remote.origin.push refs/heads/master:refs/heads/upstream &&
+		git config --add remote.origin.push refs/heads/main:refs/heads/upstream &&
 		git config --add remote.origin.push +refs/tags/lastbackup &&
-		git config --add remote.two.push +refs/heads/ahead:refs/heads/master &&
-		git config --add remote.two.push refs/heads/master:refs/heads/another &&
+		git config --add remote.two.push +refs/heads/ahead:refs/heads/main &&
+		git config --add remote.two.push refs/heads/main:refs/heads/another &&
 		git remote show origin two >output &&
 		git branch -d rebase octopus &&
 		test_i18ncmp expect output
@@ -274,7 +274,7 @@ cat >test/expect <<EOF
   Push  URL: $(pwd)/one
   HEAD branch: (not queried)
   Remote branches: (status not queried)
-    master
+    main
     side
   Local branches configured for 'git pull':
     ahead merges with remote main
@@ -285,7 +285,7 @@ cat >test/expect <<EOF
     refs/tags/lastbackup forces to refs/tags/lastbackup
 EOF
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'show -n' '
+test_expect_success 'show -n' '
 	mv one one.unreachable &&
 	(
 		cd test &&
@@ -322,18 +322,18 @@ test_expect_success 'set-head --auto' '
 	(
 		cd test &&
 		git remote set-head --auto origin &&
-		echo refs/remotes/origin/master >expect &&
+		echo refs/remotes/origin/main >expect &&
 		git symbolic-ref refs/remotes/origin/HEAD >output &&
 		test_cmp expect output
 	)
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'set-head --auto has no problem w/multiple HEADs' '
+test_expect_success 'set-head --auto has no problem w/multiple HEADs' '
 	(
 		cd test &&
 		git fetch two "refs/heads/*:refs/remotes/two/*" &&
 		git remote set-head --auto two >output 2>&1 &&
-		echo "two/HEAD set to master" >expect &&
+		echo "two/HEAD set to main" >expect &&
 		test_i18ncmp expect output
 	)
 '
@@ -347,7 +347,7 @@ test_expect_success 'set-head explicit' '
 		cd test &&
 		git remote set-head origin side2 &&
 		git symbolic-ref refs/remotes/origin/HEAD >output &&
-		git remote set-head origin master &&
+		git remote set-head origin main &&
 		test_cmp expect output
 	)
 '
@@ -394,7 +394,7 @@ test_expect_success 'add --mirror && prune' '
 
 test_expect_success 'add --mirror=fetch' '
 	mkdir mirror-fetch &&
-	git init mirror-fetch/parent &&
+	git init -b main mirror-fetch/parent &&
 	(
 		cd mirror-fetch/parent &&
 		test_commit one
@@ -410,7 +410,7 @@ test_expect_success 'fetch mirrors act as mirrors during fetch' '
 	(
 		cd mirror-fetch/parent &&
 		git branch new &&
-		git branch -m master renamed
+		git branch -m main renamed
 	) &&
 	(
 		cd mirror-fetch/child &&
@@ -424,7 +424,7 @@ test_expect_success 'fetch mirrors can prune' '
 	(
 		cd mirror-fetch/child &&
 		git remote prune parent &&
-		test_must_fail git rev-parse --verify refs/heads/master
+		test_must_fail git rev-parse --verify refs/heads/main
 	)
 '
 
@@ -465,7 +465,7 @@ test_expect_success 'fetch mirror respects specific branches' '
 test_expect_success 'add --mirror=push' '
 	mkdir mirror-push &&
 	git init --bare mirror-push/public &&
-	git init mirror-push/private &&
+	git init -b main mirror-push/private &&
 	(
 		cd mirror-push/private &&
 		test_commit one &&
@@ -477,14 +477,14 @@ test_expect_success 'push mirrors act as mirrors during push' '
 	(
 		cd mirror-push/private &&
 		git branch new &&
-		git branch -m master renamed &&
+		git branch -m main renamed &&
 		git push public
 	) &&
 	(
 		cd mirror-push/private &&
 		git rev-parse --verify refs/heads/new &&
 		git rev-parse --verify refs/heads/renamed &&
-		test_must_fail git rev-parse --verify refs/heads/master
+		test_must_fail git rev-parse --verify refs/heads/main
 	)
 '
 
@@ -610,10 +610,10 @@ test_expect_success 'reject --no-no-tags' '
 '
 
 cat >one/expect <<\EOF
-  apis/master
+  apis/main
   apis/side
   drosophila/another
-  drosophila/master
+  drosophila/main
   drosophila/side
 EOF
 
@@ -630,11 +630,11 @@ test_expect_success 'update' '
 
 cat >one/expect <<\EOF
   drosophila/another
-  drosophila/master
+  drosophila/main
   drosophila/side
-  manduca/master
+  manduca/main
   manduca/side
-  megaloprepus/master
+  megaloprepus/main
   megaloprepus/side
 EOF
 
@@ -673,11 +673,11 @@ test_expect_success 'update --prune' '
 '
 
 cat >one/expect <<-\EOF
-  apis/master
+  apis/main
   apis/side
-  manduca/master
+  manduca/main
   manduca/side
-  megaloprepus/master
+  megaloprepus/main
   megaloprepus/side
 EOF
 
@@ -697,7 +697,7 @@ test_expect_success 'update default' '
 
 cat >one/expect <<\EOF
   drosophila/another
-  drosophila/master
+  drosophila/main
   drosophila/side
 EOF
 
@@ -751,14 +751,14 @@ test_expect_success 'rename a remote' '
 	git clone one four &&
 	(
 		cd four &&
-		git config branch.master.pushRemote origin &&
+		git config branch.main.pushRemote origin &&
 		git remote rename origin upstream &&
 		test -z "$(git for-each-ref refs/remotes/origin)" &&
-		test "$(git symbolic-ref refs/remotes/upstream/HEAD)" = "refs/remotes/upstream/master" &&
-		test "$(git rev-parse upstream/master)" = "$(git rev-parse master)" &&
+		test "$(git symbolic-ref refs/remotes/upstream/HEAD)" = "refs/remotes/upstream/main" &&
+		test "$(git rev-parse upstream/main)" = "$(git rev-parse main)" &&
 		test "$(git config remote.upstream.fetch)" = "+refs/heads/*:refs/remotes/upstream/*" &&
-		test "$(git config branch.master.remote)" = "upstream" &&
-		test "$(git config branch.master.pushRemote)" = "upstream" &&
+		test "$(git config branch.main.remote)" = "upstream" &&
+		test "$(git config branch.main.pushRemote)" = "upstream" &&
 		test "$(git config --global remote.pushDefault)" = "origin"
 	)
 '
@@ -804,7 +804,7 @@ test_expect_success 'rename does not update a non-default fetch refspec' '
 		git config remote.origin.fetch +refs/heads/*:refs/heads/origin/* &&
 		git remote rename origin upstream &&
 		test "$(git config remote.upstream.fetch)" = "+refs/heads/*:refs/heads/origin/*" &&
-		git rev-parse -q origin/master
+		git rev-parse -q origin/main
 	)
 '
 
@@ -824,7 +824,7 @@ test_expect_success 'rename a remote with name prefix of other remote' '
 		cd four.three &&
 		git remote add o git://example.com/repo.git &&
 		git remote rename o upstream &&
-		test "$(git rev-parse origin/master)" = "$(git rev-parse master)"
+		test "$(git rev-parse origin/main)" = "$(git rev-parse main)"
 	)
 '
 
@@ -840,11 +840,11 @@ test_expect_success 'remove a remote' '
 	git clone one four.five &&
 	(
 		cd four.five &&
-		git config branch.master.pushRemote origin &&
+		git config branch.main.pushRemote origin &&
 		git remote remove origin &&
 		test -z "$(git for-each-ref refs/remotes/origin)" &&
-		test_must_fail git config branch.master.remote &&
-		test_must_fail git config branch.master.pushRemote &&
+		test_must_fail git config branch.main.remote &&
+		test_must_fail git config branch.main.pushRemote &&
 		test "$(git config --global remote.pushDefault)" = "origin"
 	)
 '
@@ -885,9 +885,9 @@ test_expect_success 'remove a remote removes repo remote.pushDefault but keeps g
 
 cat >remotes_origin <<EOF
 URL: $(pwd)/one
-Push: refs/heads/master:refs/heads/upstream
+Push: refs/heads/main:refs/heads/upstream
 Push: refs/heads/next:refs/heads/upstream2
-Pull: refs/heads/master:refs/heads/origin
+Pull: refs/heads/main:refs/heads/origin
 Pull: refs/heads/next:refs/heads/origin2
 EOF
 
@@ -903,11 +903,11 @@ test_expect_success 'migrate a remote from named file in $GIT_DIR/remotes' '
 		test_path_is_missing .git/remotes/origin &&
 		test "$(git config remote.origin.url)" = "$origin_url" &&
 		cat >push_expected <<-\EOF &&
-		refs/heads/master:refs/heads/upstream
+		refs/heads/main:refs/heads/upstream
 		refs/heads/next:refs/heads/upstream2
 		EOF
 		cat >fetch_expected <<-\EOF &&
-		refs/heads/master:refs/heads/origin
+		refs/heads/main:refs/heads/origin
 		refs/heads/next:refs/heads/origin2
 		EOF
 		git config --get-all remote.origin.push >push_actual &&
@@ -923,12 +923,12 @@ test_expect_success 'migrate a remote from named file in $GIT_DIR/branches' '
 	(
 		cd six &&
 		git remote rm origin &&
-		echo "$origin_url" >.git/branches/origin &&
+		echo "$origin_url#main" >.git/branches/origin &&
 		git remote rename origin origin &&
 		test_path_is_missing .git/branches/origin &&
 		test "$(git config remote.origin.url)" = "$origin_url" &&
-		test "$(git config remote.origin.fetch)" = "refs/heads/master:refs/heads/origin" &&
-		test "$(git config remote.origin.push)" = "HEAD:refs/heads/master"
+		test "$(git config remote.origin.fetch)" = "refs/heads/main:refs/heads/origin" &&
+		test "$(git config remote.origin.push)" = "HEAD:refs/heads/main"
 	)
 '
 
@@ -951,7 +951,7 @@ test_expect_success 'remote prune to cause a dangling symref' '
 	(
 		cd one &&
 		git checkout side2 &&
-		git branch -D master
+		git branch -D main
 	) &&
 	(
 		cd eight &&
@@ -994,22 +994,22 @@ test_expect_success 'remote set-branches' '
 	EOF
 	sort <<-\EOF >expect.replace &&
 	+refs/heads/maint:refs/remotes/scratch/maint
-	+refs/heads/master:refs/remotes/scratch/master
+	+refs/heads/main:refs/remotes/scratch/main
 	+refs/heads/next:refs/remotes/scratch/next
 	EOF
 	sort <<-\EOF >expect.add-two &&
 	+refs/heads/maint:refs/remotes/scratch/maint
-	+refs/heads/master:refs/remotes/scratch/master
+	+refs/heads/main:refs/remotes/scratch/main
 	+refs/heads/next:refs/remotes/scratch/next
 	+refs/heads/seen:refs/remotes/scratch/seen
 	+refs/heads/t/topic:refs/remotes/scratch/t/topic
 	EOF
 	sort <<-\EOF >expect.setup-ffonly &&
-	refs/heads/master:refs/remotes/scratch/master
+	refs/heads/main:refs/remotes/scratch/main
 	+refs/heads/next:refs/remotes/scratch/next
 	EOF
 	sort <<-\EOF >expect.respect-ffonly &&
-	refs/heads/master:refs/remotes/scratch/master
+	refs/heads/main:refs/remotes/scratch/main
 	+refs/heads/next:refs/remotes/scratch/next
 	+refs/heads/seen:refs/remotes/scratch/seen
 	EOF
@@ -1025,7 +1025,7 @@ test_expect_success 'remote set-branches' '
 		git config --get-all remote.scratch.fetch >config-result &&
 		sort <config-result >../actual.add &&
 
-		git remote set-branches scratch maint master next &&
+		git remote set-branches scratch maint main next &&
 		git config --get-all remote.scratch.fetch >config-result &&
 		sort <config-result >../actual.replace &&
 
@@ -1035,7 +1035,7 @@ test_expect_success 'remote set-branches' '
 
 		git config --unset-all remote.scratch.fetch &&
 		git config remote.scratch.fetch \
-			refs/heads/master:refs/remotes/scratch/master &&
+			refs/heads/main:refs/remotes/scratch/main &&
 		git config --add remote.scratch.fetch \
 			+refs/heads/next:refs/remotes/scratch/next &&
 		git config --get-all remote.scratch.fetch >config-result &&
@@ -1055,14 +1055,14 @@ test_expect_success 'remote set-branches' '
 
 test_expect_success 'remote set-branches with --mirror' '
 	echo "+refs/*:refs/*" >expect.initial &&
-	echo "+refs/heads/master:refs/heads/master" >expect.replace &&
+	echo "+refs/heads/main:refs/heads/main" >expect.replace &&
 	git clone --mirror .git/ setbranches-mirror &&
 	(
 		cd setbranches-mirror &&
 		git remote rename origin scratch &&
 		git config --get-all remote.scratch.fetch >../actual.initial &&
 
-		git remote set-branches scratch heads/master &&
+		git remote set-branches scratch heads/main &&
 		git config --get-all remote.scratch.fetch >../actual.replace
 	) &&
 	test_cmp expect.initial actual.initial &&
@@ -1308,7 +1308,7 @@ test_extra_arg () {
 test_extra_arg add nick url
 test_extra_arg rename origin newname
 test_extra_arg remove origin
-test_extra_arg set-head origin master
+test_extra_arg set-head origin main
 # set-branches takes any number of args
 test_extra_arg get-url origin newurl
 test_extra_arg set-url origin newurl oldurl
@@ -1325,7 +1325,7 @@ test_expect_success 'unqualified <dst> refspec DWIM and advice' '
 	test_when_finished "(cd test && git tag -d some-tag)" &&
 	(
 		cd test &&
-		git tag -a -m "Some tag" some-tag master &&
+		git tag -a -m "Some tag" some-tag main &&
 		exit_with=true &&
 		for type in commit tag tree blob
 		do
@@ -1348,10 +1348,10 @@ test_expect_success 'unqualified <dst> refspec DWIM and advice' '
 	)
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'refs/remotes/* <src> refspec and unqualified <dst> DWIM and advice' '
+test_expect_success 'refs/remotes/* <src> refspec and unqualified <dst> DWIM and advice' '
 	(
 		cd two &&
-		git tag -a -m "Some tag" my-tag master &&
+		git tag -a -m "Some tag" my-tag main &&
 		git update-ref refs/trees/my-head-tree HEAD^{tree} &&
 		git update-ref refs/blobs/my-file-blob HEAD:file
 	) &&
-- 
gitgitgadget

