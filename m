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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9D7C8300E
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D094F246E0
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgN1mC2c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbgKRXpa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 18:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbgKRXpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 18:45:09 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EFDC061A04
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:45:08 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id 23so5122537wmg.1
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=G9wWtXjKqL7mC4cb3gbG/D6+pku/cMM6TRf9v0CZcds=;
        b=SgN1mC2ca2uiqZR/R4H3cjjZDJcL1Gee3FuXZEnGdU1+BE+REhMJ7v00IrMT2Z7Y7Y
         KAp828RjhSrr8ZeCvIZmvrO5/ZVVy4aK81LYxLNtgjRjax+S4hZZdq1g8AefMZDMoL2/
         kCUcUsMwL378SnEaY/GoX6zT7srTIK8NtgVztn6afc8PCTo1a5BGLpD4Ly0AiQcbru/Z
         1HbqMyl95ROJQyGrBFxNtDB/fcPIIFDER4J2trJ6CZ9H3WlDUedzioMSA9+hvU+s9YPV
         yTBXmUcjZxz+kvlg22biLTI8Z9v3sPj9Ij0IaKYABA7KaoFEJ9NRF1cwJykU3JAUu9v4
         dYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=G9wWtXjKqL7mC4cb3gbG/D6+pku/cMM6TRf9v0CZcds=;
        b=byO8troFDjYulWjnW6reEB5nqfOCBzogrOROLjkcW8eEmcNv9PfY1xMPFg48RihpTc
         RURm/LjU42QAAMGV2057c+29jGwoStlmYngllB57atOUtz1B+eG6k8lbLQqMoW5KhTk6
         3eb67WsswkokqaPj/qW3fNQ2RachkJoPMTrk7NOT/fIJL2+EdlSUYdbPrm0bBeDaEI4e
         L5qgtt48iRMQN7qNIBwYmJI/A/X4CzLoJexkzaKXrWfX+hD0I3IJUYHq9nPw7vvtSbld
         9JkaT9v13jnLjInzFhBKb7DNTH5husYRgJpsGw7lhwYAYWmZGaNNIWf0Skrbeo8ZgfeD
         A1/Q==
X-Gm-Message-State: AOAM533GSC45+kP0oWaw746cF4QqEEz7vo4hyvKXMVFxbt1DcTROQNXS
        Wt3Y795aokNjrpdGwrRErX/F2I5Xc0E=
X-Google-Smtp-Source: ABdhPJxaUzKTja0Hsch1SHWL0xMghlPE99c9ynO1MXWHQW2sHlgj0+/WFCYhtktrZpji1/tAefFRrA==
X-Received: by 2002:a1c:66d5:: with SMTP id a204mr1410678wmc.184.1605743106541;
        Wed, 18 Nov 2020 15:45:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d63sm6434996wmd.12.2020.11.18.15.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 15:45:06 -0800 (PST)
Message-Id: <b2fda752613499a3a61955333cfa2e7f254fd908.1605743087.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.v3.git.1605743086.gitgitgadget@gmail.com>
References: <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
        <pull.762.v3.git.1605743086.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Nov 2020 23:44:35 +0000
Subject: [PATCH v3 17/28] t5[6-9]*: adjust the references to the default
 branch name "main"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This trick was performed via

	$ (cd t &&
	   sed -i -e 's/master/main/g' -e 's/MASTER/MAIN/g' \
		-e 's/Master/Main/g' -- t5[6-9]*.sh)

This allows us to define `GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main`
for those tests.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5601-clone.sh                    |  6 +--
 t/t5604-clone-reference.sh          | 14 +++----
 t/t5605-clone-local.sh              | 12 +++---
 t/t5606-clone-options.sh            | 10 ++---
 t/t5607-clone-bundle.sh             | 16 ++++----
 t/t5608-clone-2gb.sh                |  2 +-
 t/t5609-clone-branch.sh             |  8 ++--
 t/t5610-clone-detached.sh           |  6 +--
 t/t5611-clone-config.sh             | 18 ++++-----
 t/t5612-clone-refspec.sh            | 44 ++++++++++-----------
 t/t5614-clone-submodules-shallow.sh |  2 +-
 t/t5616-partial-clone.sh            | 52 ++++++++++++-------------
 t/t5617-clone-submodules-remote.sh  |  8 ++--
 t/t5700-protocol-v1.sh              | 18 ++++-----
 t/t5701-git-serve.sh                | 18 ++++-----
 t/t5702-protocol-v2.sh              | 52 ++++++++++++-------------
 t/t5703-upload-pack-ref-in-want.sh  | 60 ++++++++++++++---------------
 t/t5801-remote-helpers.sh           | 26 ++++++-------
 18 files changed, 186 insertions(+), 186 deletions(-)

diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index e01c5fe02d..664c913866 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -2,7 +2,7 @@
 
 test_description=clone
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -220,7 +220,7 @@ test_expect_success 'clone respects global branch.autosetuprebase' '
 		rm -fr dst &&
 		git clone src dst &&
 		cd dst &&
-		actual="z$(git config branch.master.rebase)" &&
+		actual="z$(git config branch.main.rebase)" &&
 		test ztrue = $actual
 	)
 '
@@ -594,7 +594,7 @@ test_expect_success 'clone from a repository with two identical branches' '
 
 	(
 		cd src &&
-		git checkout -b another master
+		git checkout -b another main
 	) &&
 	git clone src target-11 &&
 	test "z$( cd target-11 && git symbolic-ref HEAD )" = zrefs/heads/another
diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
index 20fbb1e9a3..5d682706ae 100755
--- a/t/t5604-clone-reference.sh
+++ b/t/t5604-clone-reference.sh
@@ -4,7 +4,7 @@
 #
 
 test_description='test clone --reference'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -52,7 +52,7 @@ test_expect_success 'existence of info/alternates' '
 '
 
 test_expect_success 'pulling from reference' '
-	git -C C pull ../B master
+	git -C C pull ../B main
 '
 
 test_expect_success 'that reference gets used' '
@@ -73,7 +73,7 @@ test_expect_success 'existence of info/alternates' '
 '
 
 test_expect_success 'pulling from reference' '
-	git -C D pull ../B master
+	git -C D pull ../B main
 '
 
 test_expect_success 'that reference gets used' '
@@ -139,11 +139,11 @@ test_expect_success 'prepare branched repository' '
 	git clone A J &&
 	(
 		cd J &&
-		git checkout -b other master^ &&
+		git checkout -b other main^ &&
 		echo other >otherfile &&
 		git add otherfile &&
 		git commit -m other &&
-		git checkout master
+		git checkout main
 	)
 '
 
@@ -155,9 +155,9 @@ test_expect_success 'fetch with incomplete alternates' '
 		git remote add J "file://$base_dir/J" &&
 		GIT_TRACE_PACKET=$U.K git fetch J
 	) &&
-	master_object=$(cd A && git for-each-ref --format="%(objectname)" refs/heads/master) &&
+	main_object=$(cd A && git for-each-ref --format="%(objectname)" refs/heads/main) &&
 	test -s "$U.K" &&
-	! grep " want $master_object" "$U.K" &&
+	! grep " want $main_object" "$U.K" &&
 	tag_object=$(cd A && git for-each-ref --format="%(objectname)" refs/tags/HEAD) &&
 	! grep " want $tag_object" "$U.K"
 '
diff --git a/t/t5605-clone-local.sh b/t/t5605-clone-local.sh
index 94028044b0..7d63365f93 100755
--- a/t/t5605-clone-local.sh
+++ b/t/t5605-clone-local.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 test_description='test local clone'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -18,7 +18,7 @@ test_expect_success 'preparing origin repository' '
 	test "$(cd a.git && git config --bool core.bare)" = true &&
 	test "$(cd x && git config --bool core.bare)" = true &&
 	git bundle create b1.bundle --all &&
-	git bundle create b2.bundle master &&
+	git bundle create b2.bundle main &&
 	mkdir dir &&
 	cp b1.bundle dir/b3 &&
 	cp b1.bundle b4
@@ -87,7 +87,7 @@ test_expect_success 'bundle clone with nonexistent HEAD' '
 	git clone b2.bundle b2 &&
 	(cd b2 &&
 	git fetch &&
-	test_must_fail git rev-parse --verify refs/heads/master)
+	test_must_fail git rev-parse --verify refs/heads/main)
 '
 
 test_expect_success 'clone empty repository' '
@@ -101,9 +101,9 @@ test_expect_success 'clone empty repository' '
 	 echo "content" >> foo &&
 	 git add foo &&
 	 git commit -m "Initial commit" &&
-	 git push origin master &&
-	 expected=$(git rev-parse master) &&
-	 actual=$(git --git-dir=../empty/.git rev-parse master) &&
+	 git push origin main &&
+	 expected=$(git rev-parse main) &&
+	 actual=$(git --git-dir=../empty/.git rev-parse main) &&
 	 test $actual = $expected)
 '
 
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index 3893a49e6d..5d6e63a841 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 test_description='basic clone options'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -18,7 +18,7 @@ test_expect_success 'setup' '
 test_expect_success 'clone -o' '
 
 	git clone -o foo parent clone-o &&
-	git -C clone-o rev-parse --verify refs/remotes/foo/master
+	git -C clone-o rev-parse --verify refs/remotes/foo/main
 
 '
 
@@ -48,7 +48,7 @@ test_expect_success 'disallows --bare with --separate-git-dir' '
 test_expect_success 'uses "origin" for default remote name' '
 
 	git clone parent clone-default-origin &&
-	git -C clone-default-origin rev-parse --verify refs/remotes/origin/master
+	git -C clone-default-origin rev-parse --verify refs/remotes/origin/main
 
 '
 
@@ -77,14 +77,14 @@ test_expect_success 'prefers config "clone.defaultRemoteName" over default' '
 
 	test_config_global clone.defaultRemoteName from_config &&
 	git clone parent clone-config-origin &&
-	git -C clone-config-origin rev-parse --verify refs/remotes/from_config/master
+	git -C clone-config-origin rev-parse --verify refs/remotes/from_config/main
 
 '
 
 test_expect_success 'prefers --origin over -c config' '
 
 	git clone -c clone.defaultRemoteName=inline --origin from_option parent clone-o-and-inline-config &&
-	git -C clone-o-and-inline-config rev-parse --verify refs/remotes/from_option/master
+	git -C clone-o-and-inline-config rev-parse --verify refs/remotes/from_option/main
 
 '
 
diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
index 6e2e4adbb4..5b39f4a288 100755
--- a/t/t5607-clone-bundle.sh
+++ b/t/t5607-clone-bundle.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 test_description='some bundle related tests'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -22,7 +22,7 @@ test_expect_success 'setup' '
 '
 
 test_expect_success '"verify" needs a worktree' '
-	git bundle create tip.bundle -1 master &&
+	git bundle create tip.bundle -1 main &&
 	nongit test_must_fail git bundle verify ../tip.bundle 2>err &&
 	test_i18ngrep "need a repository" err
 '
@@ -42,15 +42,15 @@ test_expect_success 'die if bundle file cannot be created' '
 '
 
 test_expect_failure 'bundle --stdin' '
-	echo master | git bundle create stdin-bundle.bdl --stdin &&
+	echo main | git bundle create stdin-bundle.bdl --stdin &&
 	git ls-remote stdin-bundle.bdl >output &&
-	grep master output
+	grep main output
 '
 
 test_expect_failure 'bundle --stdin <rev-list options>' '
-	echo master | git bundle create hybrid-bundle.bdl --stdin tag &&
+	echo main | git bundle create hybrid-bundle.bdl --stdin tag &&
 	git ls-remote hybrid-bundle.bdl >output &&
-	grep master output
+	grep main output
 '
 
 test_expect_success 'empty bundle file is rejected' '
@@ -86,14 +86,14 @@ test_expect_success 'prerequisites with an empty commit message' '
 
 test_expect_success 'failed bundle creation does not leave cruft' '
 	# This fails because the bundle would be empty.
-	test_must_fail git bundle create fail.bundle master..master &&
+	test_must_fail git bundle create fail.bundle main..main &&
 	test_path_is_missing fail.bundle.lock
 '
 
 test_expect_success 'fetch SHA-1 from bundle' '
 	test_create_repo foo &&
 	test_commit -C foo x &&
-	git -C foo bundle create tip.bundle -1 master &&
+	git -C foo bundle create tip.bundle -1 main &&
 	git -C foo rev-parse HEAD >hash &&
 
 	# Exercise to ensure that fetching a SHA-1 from a bundle works with no
diff --git a/t/t5608-clone-2gb.sh b/t/t5608-clone-2gb.sh
index 4c476d2fa1..87a8cd9f98 100755
--- a/t/t5608-clone-2gb.sh
+++ b/t/t5608-clone-2gb.sh
@@ -26,7 +26,7 @@ test_expect_success 'setup' '
 		i=$(($i+1)) ||
 		echo $? > exit-status
 	 done &&
-	 echo "commit refs/heads/master" &&
+	 echo "commit refs/heads/main" &&
 	 echo "author A U Thor <author@email.com> 123456789 +0000" &&
 	 echo "committer C O Mitter <committer@email.com> 123456789 +0000" &&
 	 echo "data 5" &&
diff --git a/t/t5609-clone-branch.sh b/t/t5609-clone-branch.sh
index e4d5124f89..f86a674a03 100755
--- a/t/t5609-clone-branch.sh
+++ b/t/t5609-clone-branch.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 test_description='clone --branch option'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -23,7 +23,7 @@ test_expect_success 'setup' '
 	 echo one >file && git add file && git commit -m one &&
 	 git checkout -b two &&
 	 echo two >file && git add file && git commit -m two &&
-	 git checkout master) &&
+	 git checkout main) &&
 	mkdir empty &&
 	(cd empty && git init)
 '
@@ -31,7 +31,7 @@ test_expect_success 'setup' '
 test_expect_success 'vanilla clone chooses HEAD' '
 	git clone parent clone &&
 	(cd clone &&
-	 check_HEAD master &&
+	 check_HEAD main &&
 	 check_file one
 	)
 '
@@ -56,7 +56,7 @@ test_expect_success 'clone -b sets up tracking' '
 
 test_expect_success 'clone -b does not munge remotes/origin/HEAD' '
 	(cd clone-two &&
-	 echo refs/remotes/origin/master >expect &&
+	 echo refs/remotes/origin/main >expect &&
 	 git symbolic-ref refs/remotes/origin/HEAD >actual &&
 	 test_cmp expect actual
 	)
diff --git a/t/t5610-clone-detached.sh b/t/t5610-clone-detached.sh
index ba63ba8f42..a7ec21eda5 100755
--- a/t/t5610-clone-detached.sh
+++ b/t/t5610-clone-detached.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 test_description='test cloning a repository with detached HEAD'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -23,7 +23,7 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'clone repo (detached HEAD points to branch)' '
-	git checkout master^0 &&
+	git checkout main^0 &&
 	git clone "file://$PWD" detached-branch
 '
 test_expect_success 'cloned HEAD matches' '
@@ -62,7 +62,7 @@ test_expect_success 'cloned HEAD is detached' '
 '
 
 test_expect_success 'clone repo (orphan detached HEAD)' '
-	git checkout master^0 &&
+	git checkout main^0 &&
 	echo four >file &&
 	git commit -a -m four &&
 	git clone "file://$PWD" detached-orphan
diff --git a/t/t5611-clone-config.sh b/t/t5611-clone-config.sh
index be4ae10c82..9f555b87ec 100755
--- a/t/t5611-clone-config.sh
+++ b/t/t5611-clone-config.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 test_description='tests for git clone -c key=value'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -50,16 +50,16 @@ test_expect_success 'clone -c config is available during clone' '
 
 test_expect_success 'clone -c remote.origin.fetch=<refspec> works' '
 	rm -rf child &&
-	git update-ref refs/grab/it refs/heads/master &&
-	git update-ref refs/leave/out refs/heads/master &&
+	git update-ref refs/grab/it refs/heads/main &&
+	git update-ref refs/leave/out refs/heads/main &&
 	git clone -c "remote.origin.fetch=+refs/grab/*:refs/grab/*" . child &&
 	git -C child for-each-ref --format="%(refname)" >actual &&
 
 	cat >expect <<-\EOF &&
 	refs/grab/it
-	refs/heads/master
+	refs/heads/main
 	refs/remotes/origin/HEAD
-	refs/remotes/origin/master
+	refs/remotes/origin/main
 	EOF
 	test_cmp expect actual
 '
@@ -71,9 +71,9 @@ test_expect_success 'git -c remote.origin.fetch=<refspec> clone works' '
 
 	cat >expect <<-\EOF &&
 	refs/grab/it
-	refs/heads/master
+	refs/heads/main
 	refs/remotes/origin/HEAD
-	refs/remotes/origin/master
+	refs/remotes/origin/main
 	EOF
 	test_cmp expect actual
 '
@@ -88,9 +88,9 @@ test_expect_success 'clone -c remote.<remote>.fetch=<refspec> --origin=<name>' '
 
 	cat >expect <<-\EOF &&
 	refs/grab/it
-	refs/heads/master
+	refs/heads/main
 	refs/remotes/upstream/HEAD
-	refs/remotes/upstream/master
+	refs/remotes/upstream/main
 	EOF
 	test_cmp expect actual
 '
diff --git a/t/t5612-clone-refspec.sh b/t/t5612-clone-refspec.sh
index 9e37f7fef7..6a6af7449c 100755
--- a/t/t5612-clone-refspec.sh
+++ b/t/t5612-clone-refspec.sh
@@ -1,13 +1,13 @@
 #!/bin/sh
 
 test_description='test refspec written by clone-command'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-	# Make two branches, "master" and "side"
+	# Make two branches, "main" and "side"
 	echo one >file &&
 	git add file &&
 	git commit -m one &&
@@ -19,7 +19,7 @@ test_expect_success 'setup' '
 	git checkout -b side &&
 	echo four >file &&
 	git commit -a -m four &&
-	git checkout master &&
+	git checkout main &&
 	git tag five &&
 
 	# default clone
@@ -28,18 +28,18 @@ test_expect_success 'setup' '
 	# default clone --no-tags
 	git clone --no-tags . dir_all_no_tags &&
 
-	# default --single that follows HEAD=master
-	git clone --single-branch . dir_master &&
+	# default --single that follows HEAD=main
+	git clone --single-branch . dir_main &&
 
-	# default --single that follows HEAD=master with no tags
-	git clone --single-branch --no-tags . dir_master_no_tags &&
+	# default --single that follows HEAD=main with no tags
+	git clone --single-branch --no-tags . dir_main_no_tags &&
 
 	# default --single that follows HEAD=side
 	git checkout side &&
 	git clone --single-branch . dir_side &&
 
 	# explicit --single that follows side
-	git checkout master &&
+	git checkout main &&
 	git clone --single-branch --branch side . dir_side2 &&
 
 	# default --single with --mirror
@@ -58,11 +58,11 @@ test_expect_success 'setup' '
 	# explicit --single with tag and --no-tags
 	git clone --single-branch --no-tags --branch two . dir_tag_no_tags &&
 
-	# advance both "master" and "side" branches
+	# advance both "main" and "side" branches
 	git checkout side &&
 	echo five >file &&
 	git commit -a -m five &&
-	git checkout master &&
+	git checkout main &&
 	echo six >file &&
 	git commit -a -m six &&
 
@@ -78,7 +78,7 @@ test_expect_success 'by default all branches will be kept updated' '
 		sed -e "/HEAD$/d" \
 		    -e "s|/remotes/origin/|/heads/|" refs >../actual
 	) &&
-	# follow both master and side
+	# follow both main and side
 	git for-each-ref refs/heads >expect &&
 	test_cmp expect actual
 '
@@ -103,20 +103,20 @@ test_expect_success 'clone with --no-tags' '
 	test_must_be_empty actual
 '
 
-test_expect_success '--single-branch while HEAD pointing at master' '
+test_expect_success '--single-branch while HEAD pointing at main' '
 	(
-		cd dir_master &&
+		cd dir_main &&
 		git fetch --force &&
 		git for-each-ref refs/remotes/origin >refs &&
 		sed -e "/HEAD$/d" \
 		    -e "s|/remotes/origin/|/heads/|" refs >../actual
 	) &&
-	# only follow master
-	git for-each-ref refs/heads/master >expect &&
+	# only follow main
+	git for-each-ref refs/heads/main >expect &&
 	# get & check latest tags
 	test_cmp expect actual &&
 	(
-		cd dir_master &&
+		cd dir_main &&
 		git fetch --tags --force &&
 		git for-each-ref refs/tags >../actual
 	) &&
@@ -125,20 +125,20 @@ test_expect_success '--single-branch while HEAD pointing at master' '
 	test_line_count = 2 actual
 '
 
-test_expect_success '--single-branch while HEAD pointing at master and --no-tags' '
+test_expect_success '--single-branch while HEAD pointing at main and --no-tags' '
 	(
-		cd dir_master_no_tags &&
+		cd dir_main_no_tags &&
 		git fetch &&
 		git for-each-ref refs/remotes/origin >refs &&
 		sed -e "/HEAD$/d" \
 		    -e "s|/remotes/origin/|/heads/|" refs >../actual
 	) &&
-	# only follow master
-	git for-each-ref refs/heads/master >expect &&
+	# only follow main
+	git for-each-ref refs/heads/main >expect &&
 	test_cmp expect actual &&
 	# get tags (noop)
 	(
-		cd dir_master_no_tags &&
+		cd dir_main_no_tags &&
 		git fetch &&
 		git for-each-ref refs/tags >../actual
 	) &&
@@ -146,7 +146,7 @@ test_expect_success '--single-branch while HEAD pointing at master and --no-tags
 	test_line_count = 0 actual &&
 	# get tags with --tags overrides tagOpt
 	(
-		cd dir_master_no_tags &&
+		cd dir_main_no_tags &&
 		git fetch --tags &&
 		git for-each-ref refs/tags >../actual
 	) &&
diff --git a/t/t5614-clone-submodules-shallow.sh b/t/t5614-clone-submodules-shallow.sh
index e4e6ea4d52..5504b519c7 100755
--- a/t/t5614-clone-submodules-shallow.sh
+++ b/t/t5614-clone-submodules-shallow.sh
@@ -7,7 +7,7 @@ test_description='Test shallow cloning of repos with submodules'
 pwd=$(pwd)
 
 test_expect_success 'setup' '
-	git checkout -b master &&
+	git checkout -b main &&
 	test_commit commit1 &&
 	test_commit commit2 &&
 	mkdir sub &&
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index b2c3ed4088..8e726f1515 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -2,7 +2,7 @@
 
 test_description='git partial clone'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -54,14 +54,14 @@ test_expect_success 'verify that .promisor file contains refs fetched' '
 	test_line_count = 1 promisorlist &&
 	git -C srv.bare rev-parse --verify HEAD >headhash &&
 	grep "$(cat headhash) HEAD" $(cat promisorlist) &&
-	grep "$(cat headhash) refs/heads/master" $(cat promisorlist)
+	grep "$(cat headhash) refs/heads/main" $(cat promisorlist)
 '
 
-# checkout master to force dynamic object fetch of blobs at HEAD.
+# checkout main to force dynamic object fetch of blobs at HEAD.
 test_expect_success 'verify checkout with dynamic object fetch' '
 	git -C pc1 rev-list --quiet --objects --missing=print HEAD >observed &&
 	test_line_count = 4 observed &&
-	git -C pc1 checkout master &&
+	git -C pc1 checkout main &&
 	git -C pc1 rev-list --quiet --objects --missing=print HEAD >observed &&
 	test_line_count = 0 observed
 '
@@ -76,8 +76,8 @@ test_expect_success 'push new commits to server' '
 		git -C src add file.1.txt
 		git -C src commit -m "mod $x"
 	done &&
-	git -C src blame master -- file.1.txt >expect.blame &&
-	git -C src push -u srv master
+	git -C src blame main -- file.1.txt >expect.blame &&
+	git -C src push -u srv main
 '
 
 # (partial) fetch in the partial clone repo from the promisor remote.
@@ -86,26 +86,26 @@ test_expect_success 'push new commits to server' '
 test_expect_success 'partial fetch inherits filter settings' '
 	git -C pc1 fetch origin &&
 	git -C pc1 rev-list --quiet --objects --missing=print \
-		master..origin/master >observed &&
+		main..origin/main >observed &&
 	test_line_count = 5 observed
 '
 
 # force dynamic object fetch using diff.
-# we should only get 1 new blob (for the file in origin/master).
+# we should only get 1 new blob (for the file in origin/main).
 test_expect_success 'verify diff causes dynamic object fetch' '
-	git -C pc1 diff master..origin/master -- file.1.txt &&
+	git -C pc1 diff main..origin/main -- file.1.txt &&
 	git -C pc1 rev-list --quiet --objects --missing=print \
-		 master..origin/master >observed &&
+		 main..origin/main >observed &&
 	test_line_count = 4 observed
 '
 
 # force full dynamic object fetch of the file's history using blame.
 # we should get the intermediate blobs for the file.
 test_expect_success 'verify blame causes dynamic object fetch' '
-	git -C pc1 blame origin/master -- file.1.txt >observed.blame &&
+	git -C pc1 blame origin/main -- file.1.txt >observed.blame &&
 	test_cmp expect.blame observed.blame &&
 	git -C pc1 rev-list --quiet --objects --missing=print \
-		master..origin/master >observed &&
+		main..origin/main >observed &&
 	test_line_count = 0 observed
 '
 
@@ -118,7 +118,7 @@ test_expect_success 'push new commits to server for file.2.txt' '
 		git -C src add file.2.txt
 		git -C src commit -m "mod $x"
 	done &&
-	git -C src push -u srv master
+	git -C src push -u srv main
 '
 
 # Do FULL fetch by disabling inherited filter-spec using --no-filter.
@@ -126,7 +126,7 @@ test_expect_success 'push new commits to server for file.2.txt' '
 test_expect_success 'override inherited filter-spec using --no-filter' '
 	git -C pc1 fetch --no-filter origin &&
 	git -C pc1 rev-list --quiet --objects --missing=print \
-		master..origin/master >observed &&
+		main..origin/main >observed &&
 	test_line_count = 0 observed
 '
 
@@ -139,7 +139,7 @@ test_expect_success 'push new commits to server for file.3.txt' '
 		git -C src add file.3.txt
 		git -C src commit -m "mod $x"
 	done &&
-	git -C src push -u srv master
+	git -C src push -u srv main
 '
 
 # Do a partial fetch and then try to manually fetch the missing objects.
@@ -149,7 +149,7 @@ test_expect_success 'manual prefetch of missing objects' '
 	git -C pc1 fetch --filter=blob:none origin &&
 
 	git -C pc1 rev-list --quiet --objects --missing=print \
-		 master..origin/master >revs &&
+		 main..origin/main >revs &&
 	awk -f print_1.awk revs |
 	sed "s/?//" |
 	sort >observed.oids &&
@@ -158,7 +158,7 @@ test_expect_success 'manual prefetch of missing objects' '
 	git -C pc1 fetch-pack --stdin "file://$(pwd)/srv.bare" <observed.oids &&
 
 	git -C pc1 rev-list --quiet --objects --missing=print \
-		master..origin/master >revs &&
+		main..origin/main >revs &&
 	awk -f print_1.awk revs |
 	sed "s/?//" |
 	sort >observed.oids &&
@@ -199,7 +199,7 @@ test_expect_success 'use fsck before and after manually fetching a missing subtr
 	echo "in dir" >src/dir/file.txt &&
 	git -C src add dir/file.txt &&
 	git -C src commit -m "file in dir" &&
-	git -C src push -u srv master &&
+	git -C src push -u srv main &&
 	SUBTREE=$(git -C src rev-parse HEAD:dir) &&
 
 	rm -rf dst &&
@@ -207,7 +207,7 @@ test_expect_success 'use fsck before and after manually fetching a missing subtr
 	git -C dst fsck &&
 
 	# Make sure we only have commits, and all trees and blobs are missing.
-	git -C dst rev-list --missing=allow-any --objects master \
+	git -C dst rev-list --missing=allow-any --objects main \
 		>fetched_objects &&
 	awk -f print_1.awk fetched_objects |
 	xargs -n1 git -C dst cat-file -t >fetched_types &&
@@ -224,7 +224,7 @@ test_expect_success 'use fsck before and after manually fetching a missing subtr
 	git -C dst fsck &&
 
 	# Auto-fetch all remaining trees and blobs with --missing=error
-	git -C dst rev-list --missing=error --objects master >fetched_objects &&
+	git -C dst rev-list --missing=error --objects main >fetched_objects &&
 	test_line_count = 70 fetched_objects &&
 
 	awk -f print_1.awk fetched_objects |
@@ -334,7 +334,7 @@ test_expect_success 'setup src repo for sparse filter' '
 test_expect_success 'partial clone with sparse filter succeeds' '
 	rm -rf dst.git &&
 	git clone --no-local --bare \
-		  --filter=sparse:oid=master:only-one \
+		  --filter=sparse:oid=main:only-one \
 		  sparse-src dst.git &&
 	(
 		cd dst.git &&
@@ -347,11 +347,11 @@ test_expect_success 'partial clone with sparse filter succeeds' '
 test_expect_success 'partial clone with unresolvable sparse filter fails cleanly' '
 	rm -rf dst.git &&
 	test_must_fail git clone --no-local --bare \
-				 --filter=sparse:oid=master:no-such-name \
+				 --filter=sparse:oid=main:no-such-name \
 				 sparse-src dst.git 2>err &&
-	test_i18ngrep "unable to access sparse blob in .master:no-such-name" err &&
+	test_i18ngrep "unable to access sparse blob in .main:no-such-name" err &&
 	test_must_fail git clone --no-local --bare \
-				 --filter=sparse:oid=master \
+				 --filter=sparse:oid=main \
 				 sparse-src dst.git 2>err &&
 	test_i18ngrep "unable to parse sparse filter data in" err
 '
@@ -406,7 +406,7 @@ test_expect_success 'fetch lazy-fetches only to resolve deltas' '
 	# promisor remote other than for the big tree (because it needs to
 	# resolve the delta).
 	GIT_TRACE_PACKET="$(pwd)/trace" git -C client \
-		fetch "file://$(pwd)/server" master &&
+		fetch "file://$(pwd)/server" main &&
 
 	# Verify the assumption that the client needed to fetch the delta base
 	# to resolve the delta.
@@ -425,7 +425,7 @@ test_expect_success 'fetch lazy-fetches only to resolve deltas, protocol v2' '
 	# promisor remote other than for the big blob (because it needs to
 	# resolve the delta).
 	GIT_TRACE_PACKET="$(pwd)/trace" git -C client \
-		fetch "file://$(pwd)/server" master &&
+		fetch "file://$(pwd)/server" main &&
 
 	# Verify that protocol version 2 was used.
 	grep "fetch< version 2" trace &&
diff --git a/t/t5617-clone-submodules-remote.sh b/t/t5617-clone-submodules-remote.sh
index cba468fc53..e2dbb4eaba 100755
--- a/t/t5617-clone-submodules-remote.sh
+++ b/t/t5617-clone-submodules-remote.sh
@@ -2,7 +2,7 @@
 
 test_description='Test cloning repos with submodules using remote-tracking branches'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -10,7 +10,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 pwd=$(pwd)
 
 test_expect_success 'setup' '
-	git checkout -b master &&
+	git checkout -b main &&
 	test_commit commit1 &&
 	mkdir sub &&
 	(
@@ -42,7 +42,7 @@ test_expect_success 'clone with --remote-submodules' '
 	git clone --recurse-submodules --remote-submodules "file://$pwd/." super_clone &&
 	(
 		cd super_clone/sub &&
-		git diff --exit-code remotes/origin/master
+		git diff --exit-code remotes/origin/main
 	)
 '
 
@@ -60,7 +60,7 @@ test_expect_success 'clone with --single-branch' '
 	git clone --recurse-submodules --single-branch "file://$pwd/." super_clone &&
 	(
 		cd super_clone/sub &&
-		git rev-parse --verify origin/master &&
+		git rev-parse --verify origin/main &&
 		test_must_fail git rev-parse --verify origin/other
 	)
 '
diff --git a/t/t5700-protocol-v1.sh b/t/t5700-protocol-v1.sh
index 7f0056c1ed..468bd3e13e 100755
--- a/t/t5700-protocol-v1.sh
+++ b/t/t5700-protocol-v1.sh
@@ -8,7 +8,7 @@ TEST_NO_CREATE_REPO=1
 GIT_TEST_PROTOCOL_VERSION=0
 export GIT_TEST_PROTOCOL_VERSION
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -44,7 +44,7 @@ test_expect_success 'fetch with git:// using protocol v1' '
 	GIT_TRACE_PACKET=1 git -C daemon_child -c protocol.version=1 \
 		fetch 2>log &&
 
-	git -C daemon_child log -1 --format=%s origin/master >actual &&
+	git -C daemon_child log -1 --format=%s origin/main >actual &&
 	git -C "$daemon_parent" log -1 --format=%s >expect &&
 	test_cmp expect actual &&
 
@@ -72,7 +72,7 @@ test_expect_success 'push with git:// using protocol v1' '
 	test_commit -C daemon_child three &&
 
 	# Push to another branch, as the target repository has the
-	# master branch checked out and we cannot push into it.
+	# main branch checked out and we cannot push into it.
 	GIT_TRACE_PACKET=1 git -C daemon_child -c protocol.version=1 \
 		push origin HEAD:client_branch 2>log &&
 
@@ -113,7 +113,7 @@ test_expect_success 'fetch with file:// using protocol v1' '
 	GIT_TRACE_PACKET=1 git -C file_child -c protocol.version=1 \
 		fetch 2>log &&
 
-	git -C file_child log -1 --format=%s origin/master >actual &&
+	git -C file_child log -1 --format=%s origin/main >actual &&
 	git -C file_parent log -1 --format=%s >expect &&
 	test_cmp expect actual &&
 
@@ -137,7 +137,7 @@ test_expect_success 'push with file:// using protocol v1' '
 	test_commit -C file_child three &&
 
 	# Push to another branch, as the target repository has the
-	# master branch checked out and we cannot push into it.
+	# main branch checked out and we cannot push into it.
 	GIT_TRACE_PACKET=1 git -C file_child -c protocol.version=1 \
 		push origin HEAD:client_branch 2>log &&
 
@@ -191,7 +191,7 @@ test_expect_success 'fetch with ssh:// using protocol v1' '
 		fetch 2>log &&
 	expect_ssh git-upload-pack &&
 
-	git -C ssh_child log -1 --format=%s origin/master >actual &&
+	git -C ssh_child log -1 --format=%s origin/main >actual &&
 	git -C ssh_parent log -1 --format=%s >expect &&
 	test_cmp expect actual &&
 
@@ -216,7 +216,7 @@ test_expect_success 'push with ssh:// using protocol v1' '
 	test_commit -C ssh_child three &&
 
 	# Push to another branch, as the target repository has the
-	# master branch checked out and we cannot push into it.
+	# main branch checked out and we cannot push into it.
 	GIT_TRACE_PACKET=1 git -C ssh_child -c protocol.version=1 \
 		push origin HEAD:client_branch 2>log &&
 	expect_ssh git-receive-pack &&
@@ -260,7 +260,7 @@ test_expect_success 'fetch with http:// using protocol v1' '
 	GIT_TRACE_PACKET=1 git -C http_child -c protocol.version=1 \
 		fetch 2>log &&
 
-	git -C http_child log -1 --format=%s origin/master >actual &&
+	git -C http_child log -1 --format=%s origin/main >actual &&
 	git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" log -1 --format=%s >expect &&
 	test_cmp expect actual &&
 
@@ -284,7 +284,7 @@ test_expect_success 'push with http:// using protocol v1' '
 	test_commit -C http_child three &&
 
 	# Push to another branch, as the target repository has the
-	# master branch checked out and we cannot push into it.
+	# main branch checked out and we cannot push into it.
 	GIT_TRACE_PACKET=1 git -C http_child -c protocol.version=1 \
 		push origin HEAD:client_branch && #2>log &&
 
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index 66c47e61d8..d9143b4bd2 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -2,7 +2,7 @@
 
 test_description='test protocol v2 server commands'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -86,9 +86,9 @@ test_expect_success 'wrong object-format' '
 #
 test_expect_success 'setup some refs and tags' '
 	test_commit one &&
-	git branch dev master &&
+	git branch dev main &&
 	test_commit two &&
-	git symbolic-ref refs/heads/release refs/heads/master &&
+	git symbolic-ref refs/heads/release refs/heads/main &&
 	git tag -a -m "annotated tag" annotated-tag
 '
 
@@ -102,7 +102,7 @@ test_expect_success 'basics of ls-refs' '
 	cat >expect <<-EOF &&
 	$(git rev-parse HEAD) HEAD
 	$(git rev-parse refs/heads/dev) refs/heads/dev
-	$(git rev-parse refs/heads/master) refs/heads/master
+	$(git rev-parse refs/heads/main) refs/heads/main
 	$(git rev-parse refs/heads/release) refs/heads/release
 	$(git rev-parse refs/tags/annotated-tag) refs/tags/annotated-tag
 	$(git rev-parse refs/tags/one) refs/tags/one
@@ -120,13 +120,13 @@ test_expect_success 'basic ref-prefixes' '
 	command=ls-refs
 	object-format=$(test_oid algo)
 	0001
-	ref-prefix refs/heads/master
+	ref-prefix refs/heads/main
 	ref-prefix refs/tags/one
 	0000
 	EOF
 
 	cat >expect <<-EOF &&
-	$(git rev-parse refs/heads/master) refs/heads/master
+	$(git rev-parse refs/heads/main) refs/heads/main
 	$(git rev-parse refs/tags/one) refs/tags/one
 	0000
 	EOF
@@ -147,7 +147,7 @@ test_expect_success 'refs/heads prefix' '
 
 	cat >expect <<-EOF &&
 	$(git rev-parse refs/heads/dev) refs/heads/dev
-	$(git rev-parse refs/heads/master) refs/heads/master
+	$(git rev-parse refs/heads/main) refs/heads/main
 	$(git rev-parse refs/heads/release) refs/heads/release
 	0000
 	EOF
@@ -191,8 +191,8 @@ test_expect_success 'symrefs parameter' '
 
 	cat >expect <<-EOF &&
 	$(git rev-parse refs/heads/dev) refs/heads/dev
-	$(git rev-parse refs/heads/master) refs/heads/master
-	$(git rev-parse refs/heads/release) refs/heads/release symref-target:refs/heads/master
+	$(git rev-parse refs/heads/main) refs/heads/main
+	$(git rev-parse refs/heads/release) refs/heads/release symref-target:refs/heads/main
 	0000
 	EOF
 
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index f1f77fe089..3d994e0b1b 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -4,7 +4,7 @@ test_description='test git wire-protocol version 2'
 
 TEST_NO_CREATE_REPO=1
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -39,10 +39,10 @@ test_expect_success 'ref advertisement is filtered with ls-remote using protocol
 	test_when_finished "rm -f log" &&
 
 	GIT_TRACE_PACKET="$(pwd)/log" git -c protocol.version=2 \
-		ls-remote "$GIT_DAEMON_URL/parent" master >actual &&
+		ls-remote "$GIT_DAEMON_URL/parent" main >actual &&
 
 	cat >expect <<-EOF &&
-	$(git -C "$daemon_parent" rev-parse refs/heads/master)$(printf "\t")refs/heads/master
+	$(git -C "$daemon_parent" rev-parse refs/heads/main)$(printf "\t")refs/heads/main
 	EOF
 
 	test_cmp expect actual
@@ -72,7 +72,7 @@ test_expect_success 'fetch with git:// using protocol v2' '
 	GIT_TRACE_PACKET="$(pwd)/log" git -C daemon_child -c protocol.version=2 \
 		fetch &&
 
-	git -C daemon_child log -1 --format=%s origin/master >actual &&
+	git -C daemon_child log -1 --format=%s origin/main >actual &&
 	git -C "$daemon_parent" log -1 --format=%s >expect &&
 	test_cmp expect actual &&
 
@@ -121,7 +121,7 @@ test_expect_success 'push with git:// and a config of v2 does not request v2' '
 	test_commit -C daemon_child three &&
 
 	# Push to another branch, as the target repository has the
-	# master branch checked out and we cannot push into it.
+	# main branch checked out and we cannot push into it.
 	GIT_TRACE_PACKET="$(pwd)/log" git -C daemon_child -c protocol.version=2 \
 		push origin HEAD:client_branch &&
 
@@ -161,10 +161,10 @@ test_expect_success 'ref advertisement is filtered with ls-remote using protocol
 	test_when_finished "rm -f log" &&
 
 	GIT_TRACE_PACKET="$(pwd)/log" git -c protocol.version=2 \
-		ls-remote "file://$(pwd)/file_parent" master >actual &&
+		ls-remote "file://$(pwd)/file_parent" main >actual &&
 
 	cat >expect <<-EOF &&
-	$(git -C file_parent rev-parse refs/heads/master)$(printf "\t")refs/heads/master
+	$(git -C file_parent rev-parse refs/heads/main)$(printf "\t")refs/heads/main
 	EOF
 
 	test_cmp expect actual
@@ -174,10 +174,10 @@ test_expect_success 'server-options are sent when using ls-remote' '
 	test_when_finished "rm -f log" &&
 
 	GIT_TRACE_PACKET="$(pwd)/log" git -c protocol.version=2 \
-		ls-remote -o hello -o world "file://$(pwd)/file_parent" master >actual &&
+		ls-remote -o hello -o world "file://$(pwd)/file_parent" main >actual &&
 
 	cat >expect <<-EOF &&
-	$(git -C file_parent rev-parse refs/heads/master)$(printf "\t")refs/heads/master
+	$(git -C file_parent rev-parse refs/heads/main)$(printf "\t")refs/heads/main
 	EOF
 
 	test_cmp expect actual &&
@@ -187,7 +187,7 @@ test_expect_success 'server-options are sent when using ls-remote' '
 
 test_expect_success 'warn if using server-option with ls-remote with legacy protocol' '
 	test_must_fail env GIT_TEST_PROTOCOL_VERSION=0 git -c protocol.version=0 \
-		ls-remote -o hello -o world "file://$(pwd)/file_parent" master 2>err &&
+		ls-remote -o hello -o world "file://$(pwd)/file_parent" main 2>err &&
 
 	test_i18ngrep "see protocol.version in" err &&
 	test_i18ngrep "server options require protocol version 2 or later" err
@@ -220,7 +220,7 @@ test_expect_success 'fetch with file:// using protocol v2' '
 	GIT_TRACE_PACKET="$(pwd)/log" git -C file_child -c protocol.version=2 \
 		fetch origin &&
 
-	git -C file_child log -1 --format=%s origin/master >actual &&
+	git -C file_child log -1 --format=%s origin/main >actual &&
 	git -C file_parent log -1 --format=%s >expect &&
 	test_cmp expect actual &&
 
@@ -235,13 +235,13 @@ test_expect_success 'ref advertisement is filtered during fetch using protocol v
 	git -C file_parent branch unwanted-branch three &&
 
 	GIT_TRACE_PACKET="$(pwd)/log" git -C file_child -c protocol.version=2 \
-		fetch origin master &&
+		fetch origin main &&
 
-	git -C file_child log -1 --format=%s origin/master >actual &&
+	git -C file_child log -1 --format=%s origin/main >actual &&
 	git -C file_parent log -1 --format=%s >expect &&
 	test_cmp expect actual &&
 
-	grep "refs/heads/master" log &&
+	grep "refs/heads/main" log &&
 	! grep "refs/heads/unwanted-branch" log
 '
 
@@ -251,9 +251,9 @@ test_expect_success 'server-options are sent when fetching' '
 	test_commit -C file_parent four &&
 
 	GIT_TRACE_PACKET="$(pwd)/log" git -C file_child -c protocol.version=2 \
-		fetch -o hello -o world origin master &&
+		fetch -o hello -o world origin main &&
 
-	git -C file_child log -1 --format=%s origin/master >actual &&
+	git -C file_child log -1 --format=%s origin/main >actual &&
 	git -C file_parent log -1 --format=%s >expect &&
 	test_cmp expect actual &&
 
@@ -267,7 +267,7 @@ test_expect_success 'warn if using server-option with fetch with legacy protocol
 	git init temp_child &&
 
 	test_must_fail env GIT_TEST_PROTOCOL_VERSION=0 git -C temp_child -c protocol.version=0 \
-		fetch -o hello -o world "file://$(pwd)/file_parent" master 2>err &&
+		fetch -o hello -o world "file://$(pwd)/file_parent" main 2>err &&
 
 	test_i18ngrep "see protocol.version in" err &&
 	test_i18ngrep "server options require protocol version 2 or later" err
@@ -328,7 +328,7 @@ test_expect_success 'partial clone' '
 	grep "version 2" trace &&
 
 	# Ensure that the old version of the file is missing
-	git -C client rev-list --quiet --objects --missing=print master \
+	git -C client rev-list --quiet --objects --missing=print main \
 		>observed.oids &&
 	grep "$(git -C server rev-parse message1:a.txt)" observed.oids &&
 
@@ -353,7 +353,7 @@ test_expect_success 'partial fetch' '
 	SERVER="file://$(pwd)/server" &&
 
 	GIT_TRACE_PACKET="$(pwd)/trace" git -C client -c protocol.version=2 \
-		fetch --filter=blob:none "$SERVER" master:refs/heads/other &&
+		fetch --filter=blob:none "$SERVER" main:refs/heads/other &&
 	grep "version 2" trace &&
 
 	# Ensure that the old version of the file is missing
@@ -398,7 +398,7 @@ test_expect_success 'even with handcrafted request, filter does not work if not
 	command=fetch
 	object-format=$(test_oid algo)
 	0001
-	want $(git -C server rev-parse master)
+	want $(git -C server rev-parse main)
 	filter blob:none
 	0000
 	EOF
@@ -542,7 +542,7 @@ test_expect_success 'deepen-relative' '
 	test_commit -C server four &&
 
 	# Sanity check that only "three" is downloaded
-	git -C client log --pretty=tformat:%s master >actual &&
+	git -C client log --pretty=tformat:%s main >actual &&
 	echo three >expected &&
 	test_cmp expected actual &&
 
@@ -551,7 +551,7 @@ test_expect_success 'deepen-relative' '
 	# Ensure that protocol v2 is used
 	grep "fetch< version 2" trace &&
 
-	git -C client log --pretty=tformat:%s origin/master >actual &&
+	git -C client log --pretty=tformat:%s origin/main >actual &&
 	cat >expected <<-\EOF &&
 	four
 	three
@@ -673,7 +673,7 @@ test_expect_success 'fetch with http:// using protocol v2' '
 	GIT_TRACE_PACKET="$(pwd)/log" git -C http_child -c protocol.version=2 \
 		fetch &&
 
-	git -C http_child log -1 --format=%s origin/master >actual &&
+	git -C http_child log -1 --format=%s origin/main >actual &&
 	git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" log -1 --format=%s >expect &&
 	test_cmp expect actual &&
 
@@ -701,11 +701,11 @@ test_expect_success 'fetch from namespaced repo respects namespaces' '
 	test_commit -C "$HTTPD_DOCUMENT_ROOT_PATH/nsrepo" one &&
 	test_commit -C "$HTTPD_DOCUMENT_ROOT_PATH/nsrepo" two &&
 	git -C "$HTTPD_DOCUMENT_ROOT_PATH/nsrepo" \
-		update-ref refs/namespaces/ns/refs/heads/master one &&
+		update-ref refs/namespaces/ns/refs/heads/main one &&
 
 	GIT_TRACE_PACKET="$(pwd)/log" git -C http_child -c protocol.version=2 \
 		fetch "$HTTPD_URL/smart_namespace/nsrepo" \
-		refs/heads/master:refs/heads/theirs &&
+		refs/heads/main:refs/heads/theirs &&
 
 	# Server responded using protocol v2
 	grep "fetch< version 2" log &&
@@ -736,7 +736,7 @@ test_expect_success 'push with http:// and a config of v2 does not request v2' '
 	test_commit -C http_child three &&
 
 	# Push to another branch, as the target repository has the
-	# master branch checked out and we cannot push into it.
+	# main branch checked out and we cannot push into it.
 	GIT_TRACE_PACKET="$(pwd)/log" git -C http_child -c protocol.version=2 \
 		push origin HEAD:client_branch &&
 
diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index c3a52d478f..0f3e0bf15c 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -2,7 +2,7 @@
 
 test_description='upload-pack ref-in-want'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -41,7 +41,7 @@ write_command () {
 
 # c(o/foo) d(o/bar)
 #        \ /
-#         b   e(baz)  f(master)
+#         b   e(baz)  f(main)
 #          \__  |  __/
 #             \ | /
 #               a
@@ -54,7 +54,7 @@ test_expect_success 'setup repository' '
 	test_commit d &&
 	git checkout -b baz a &&
 	test_commit e &&
-	git checkout master &&
+	git checkout main &&
 	test_commit f
 '
 
@@ -91,7 +91,7 @@ test_expect_success 'invalid want-ref line' '
 test_expect_success 'basic want-ref' '
 	oid=$(git rev-parse f) &&
 	cat >expected_refs <<-EOF &&
-	$oid refs/heads/master
+	$oid refs/heads/main
 	EOF
 	git rev-parse f >expected_commits &&
 
@@ -100,7 +100,7 @@ test_expect_success 'basic want-ref' '
 	$(write_command fetch)
 	0001
 	no-progress
-	want-ref refs/heads/master
+	want-ref refs/heads/main
 	have $oid
 	done
 	0000
@@ -138,7 +138,7 @@ test_expect_success 'multiple want-ref lines' '
 test_expect_success 'mix want and want-ref' '
 	oid=$(git rev-parse f) &&
 	cat >expected_refs <<-EOF &&
-	$oid refs/heads/master
+	$oid refs/heads/main
 	EOF
 	git rev-parse e f >expected_commits &&
 
@@ -146,7 +146,7 @@ test_expect_success 'mix want and want-ref' '
 	$(write_command fetch)
 	0001
 	no-progress
-	want-ref refs/heads/master
+	want-ref refs/heads/main
 	want $(git rev-parse e)
 	have $(git rev-parse a)
 	done
@@ -185,7 +185,7 @@ LOCAL_PRISTINE="$(pwd)/local_pristine"
 # $REPO
 # c(o/foo) d(o/bar)
 #        \ /
-#         b   e(baz)  f(master)
+#         b   e(baz)  f(main)
 #          \__  |  __/
 #             \ | /
 #               a
@@ -196,7 +196,7 @@ LOCAL_PRISTINE="$(pwd)/local_pristine"
 #		.
 #		.
 #		|
-#		a(master)
+#		a(main)
 test_expect_success 'setup repos for fetching with ref-in-want tests' '
 	(
 		git init "$REPO" &&
@@ -212,7 +212,7 @@ test_expect_success 'setup repos for fetching with ref-in-want tests' '
 		test_commit_bulk --id=s 33 &&
 
 		# Add novel commits to upstream
-		git checkout master &&
+		git checkout main &&
 		cd "$REPO" &&
 		git checkout -b o/foo &&
 		test_commit b &&
@@ -221,7 +221,7 @@ test_expect_success 'setup repos for fetching with ref-in-want tests' '
 		test_commit d &&
 		git checkout -b baz a &&
 		test_commit e &&
-		git checkout master &&
+		git checkout main &&
 		test_commit f
 	) &&
 	git -C "$REPO" config uploadpack.allowRefInWant true &&
@@ -248,12 +248,12 @@ test_expect_success 'fetching multiple refs' '
 
 	rm -rf local &&
 	cp -r "$LOCAL_PRISTINE" local &&
-	GIT_TRACE_PACKET="$(pwd)/log" git -C local fetch origin master baz &&
+	GIT_TRACE_PACKET="$(pwd)/log" git -C local fetch origin main baz &&
 
-	git -C "$REPO" rev-parse "master" "baz" >expected &&
-	git -C local rev-parse refs/remotes/origin/master refs/remotes/origin/baz >actual &&
+	git -C "$REPO" rev-parse "main" "baz" >expected &&
+	git -C local rev-parse refs/remotes/origin/main refs/remotes/origin/baz >actual &&
 	test_cmp expected actual &&
-	grep "want-ref refs/heads/master" log &&
+	grep "want-ref refs/heads/main" log &&
 	grep "want-ref refs/heads/baz" log
 '
 
@@ -264,13 +264,13 @@ test_expect_success 'fetching ref and exact OID' '
 	cp -r "$LOCAL_PRISTINE" local &&
 	oid=$(git -C "$REPO" rev-parse b) &&
 	GIT_TRACE_PACKET="$(pwd)/log" git -C local fetch origin \
-		master "$oid":refs/heads/actual &&
+		main "$oid":refs/heads/actual &&
 
-	git -C "$REPO" rev-parse "master" "b" >expected &&
-	git -C local rev-parse refs/remotes/origin/master refs/heads/actual >actual &&
+	git -C "$REPO" rev-parse "main" "b" >expected &&
+	git -C local rev-parse refs/remotes/origin/main refs/heads/actual >actual &&
 	test_cmp expected actual &&
 	grep "want $oid" log &&
-	grep "want-ref refs/heads/master" log
+	grep "want-ref refs/heads/main" log
 '
 
 test_expect_success 'fetching with wildcard that does not match any refs' '
@@ -319,7 +319,7 @@ test_expect_success 'setup repos for change-while-negotiating test' '
 		test_commit_bulk --id=s 33 &&
 
 		# Add novel commits to upstream
-		git checkout master &&
+		git checkout main &&
 		cd "$REPO" &&
 		test_commit m2 &&
 		test_commit m3 &&
@@ -345,7 +345,7 @@ test_expect_success 'server is initially ahead - no ref in want' '
 	git -C "$REPO" config uploadpack.allowRefInWant false &&
 	rm -rf local &&
 	cp -r "$LOCAL_PRISTINE" local &&
-	inconsistency master $(test_oid numeric) &&
+	inconsistency main $(test_oid numeric) &&
 	test_must_fail git -C local fetch 2>err &&
 	test_i18ngrep "fatal: remote error: upload-pack: not our ref" err
 '
@@ -354,11 +354,11 @@ test_expect_success 'server is initially ahead - ref in want' '
 	git -C "$REPO" config uploadpack.allowRefInWant true &&
 	rm -rf local &&
 	cp -r "$LOCAL_PRISTINE" local &&
-	inconsistency master $(test_oid numeric) &&
+	inconsistency main $(test_oid numeric) &&
 	git -C local fetch &&
 
-	git -C "$REPO" rev-parse --verify master >expected &&
-	git -C local rev-parse --verify refs/remotes/origin/master >actual &&
+	git -C "$REPO" rev-parse --verify main >expected &&
+	git -C local rev-parse --verify refs/remotes/origin/main >actual &&
 	test_cmp expected actual
 '
 
@@ -366,11 +366,11 @@ test_expect_success 'server is initially behind - no ref in want' '
 	git -C "$REPO" config uploadpack.allowRefInWant false &&
 	rm -rf local &&
 	cp -r "$LOCAL_PRISTINE" local &&
-	inconsistency master "master^" &&
+	inconsistency main "main^" &&
 	git -C local fetch &&
 
-	git -C "$REPO" rev-parse --verify "master^" >expected &&
-	git -C local rev-parse --verify refs/remotes/origin/master >actual &&
+	git -C "$REPO" rev-parse --verify "main^" >expected &&
+	git -C local rev-parse --verify refs/remotes/origin/main >actual &&
 	test_cmp expected actual
 '
 
@@ -378,11 +378,11 @@ test_expect_success 'server is initially behind - ref in want' '
 	git -C "$REPO" config uploadpack.allowRefInWant true &&
 	rm -rf local &&
 	cp -r "$LOCAL_PRISTINE" local &&
-	inconsistency master "master^" &&
+	inconsistency main "main^" &&
 	git -C local fetch &&
 
-	git -C "$REPO" rev-parse --verify "master" >expected &&
-	git -C local rev-parse --verify refs/remotes/origin/master >actual &&
+	git -C "$REPO" rev-parse --verify "main" >expected &&
+	git -C local rev-parse --verify refs/remotes/origin/main >actual &&
 	test_cmp expected actual
 '
 
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 1ecefb57fe..d386076dbd 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -5,7 +5,7 @@
 
 test_description='Test remote-helper import and export commands'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -74,18 +74,18 @@ test_expect_success 'fetch multiple branches' '
 	(cd local &&
 	 git fetch
 	) &&
-	compare_refs server master local refs/remotes/origin/master &&
+	compare_refs server main local refs/remotes/origin/main &&
 	compare_refs server new local refs/remotes/origin/new
 '
 
 test_expect_success 'push when remote has extra refs' '
 	(cd local &&
-	 git reset --hard origin/master &&
+	 git reset --hard origin/main &&
 	 echo content >>file &&
 	 git commit -a -m six &&
 	 git push
 	) &&
-	compare_refs local master server master
+	compare_refs local main server main
 '
 
 test_expect_success 'push new branch by name' '
@@ -177,7 +177,7 @@ test_expect_failure 'pushing without marks' '
 
 test_expect_success 'push all with existing object' '
 	(cd local &&
-	git branch dup2 master &&
+	git branch dup2 main &&
 	git push origin --all
 	) &&
 	compare_refs local dup2 server dup2
@@ -185,7 +185,7 @@ test_expect_success 'push all with existing object' '
 
 test_expect_success 'push ref with existing object' '
 	(cd local &&
-	git branch dup master &&
+	git branch dup main &&
 	git push origin dup
 	) &&
 	compare_refs local dup server dup
@@ -193,7 +193,7 @@ test_expect_success 'push ref with existing object' '
 
 test_expect_success GPG 'push signed tag' '
 	(cd local &&
-	git checkout master &&
+	git checkout main &&
 	git tag -s -m signed-tag signed-tag &&
 	git push origin signed-tag
 	) &&
@@ -203,7 +203,7 @@ test_expect_success GPG 'push signed tag' '
 
 test_expect_success GPG 'push signed tag with signed-tags capability' '
 	(cd local &&
-	git checkout master &&
+	git checkout main &&
 	git tag -s -m signed-tag signed-tag-2 &&
 	GIT_REMOTE_TESTGIT_SIGNED_TAGS=1 git push origin signed-tag-2
 	) &&
@@ -212,7 +212,7 @@ test_expect_success GPG 'push signed tag with signed-tags capability' '
 
 test_expect_success 'push update refs' '
 	(cd local &&
-	git checkout -b update master &&
+	git checkout -b update main &&
 	echo update >>file &&
 	git commit -a -m update &&
 	git push origin update &&
@@ -263,7 +263,7 @@ test_expect_success 'proper failure checks for fetching' '
 test_expect_success 'proper failure checks for pushing' '
 	test_when_finished "rm -rf local/git.marks local/testgit.marks" &&
 	(cd local &&
-	git checkout -b crash master &&
+	git checkout -b crash main &&
 	echo crash >>file &&
 	git commit -a -m crash &&
 	test_must_fail env GIT_REMOTE_TESTGIT_FAILURE=1 git push --all &&
@@ -275,7 +275,7 @@ test_expect_success 'proper failure checks for pushing' '
 
 test_expect_success 'push messages' '
 	(cd local &&
-	git checkout -b new_branch master &&
+	git checkout -b new_branch main &&
 	echo new >>file &&
 	git commit -a -m new &&
 	git push origin new_branch &&
@@ -289,7 +289,7 @@ test_expect_success 'push messages' '
 
 test_expect_success 'fetch HEAD' '
 	(cd server &&
-	git checkout master &&
+	git checkout main &&
 	echo more >>file &&
 	git commit -a -m more
 	) &&
@@ -301,7 +301,7 @@ test_expect_success 'fetch HEAD' '
 
 test_expect_success 'fetch url' '
 	(cd server &&
-	git checkout master &&
+	git checkout main &&
 	echo more >>file &&
 	git commit -a -m more
 	) &&
-- 
gitgitgadget

