Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A13C6379D
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F00E20825
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdrzfjV2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbgKLWoR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 17:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbgKLWoQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 17:44:16 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C376FC0617A6
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:44:15 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a65so6860817wme.1
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1eaLaF6X+SXuvbfHWDRmfhW7o1Tcm2Ebch1kxQPdNVI=;
        b=RdrzfjV2bvh8VJGrWdNYcxMno3IrTTowTo8kZt3gVHZFgw5i1X2mfm6QrSSwlrV/mI
         iUdDdMCqSezQkcpY4E44nVTYZO+boZT/aphOYJnb0iiVg3EjdBE1wpyeQ9oGJSWyZ+9Y
         5R2f46psLP7uw062OwYPAvz19XWaXyLBZS5BwmiRrfdukztLWLBWltFDBpabXmUykt0m
         9y+jvDf1S/eAXV92xzpEtv88zH4/W4dhvwNb0CnBiCqardDWDgeFbzlB1TuQFZYqRL8Y
         KTSFaLXbIsfYfX4WrTX9aqc8QMsceb5dxNbnyWYZ5elAV5fqD7WSklVt9Hgxrs2Y/N9Q
         wyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1eaLaF6X+SXuvbfHWDRmfhW7o1Tcm2Ebch1kxQPdNVI=;
        b=qqJcCOMun0NBuwu7u+dV/v0kKtWLlaJ3pOfQZ/TmdANALL/VZ5klA4qbg1AZ1lYPcv
         20eSpCgqEsvtbgFrzgdLXBX/P+cY9rPWS39ArID3sglz+NQP8hSv0FtiUlhz7Uc12v6c
         2oDqJbIxMAiNJy3adyDXwtYO2kt0LvVGAx5JZqp/byxDRxkgJ1sMX639ChV2gLuqfoGa
         xpK8ryw1Dte8lI0pyyRkIETpgk1Vv2/TBoG1WHe4+ixH4GYAvLgXr7G7q59wD3vO7T1i
         sDHztHJ1zJFYTfDc2hZGJhL4+RStarySWPOMy9Xg1LWBm+BM2PUqLWbd6RiO/2uw0Ykp
         zhAw==
X-Gm-Message-State: AOAM5322h4L6ygabL2zWoigLCt/D9EgHSkVtZ/TvwUODbOi4iBkuJIVA
        O97p6JyBGpNheAQ6lzu70gPwRbu437g=
X-Google-Smtp-Source: ABdhPJzO+bGwD0yvOXAhLAp/PJknfS2NyY3WDuR4r8c2PAWVIoMX7RfC3nNSlJCrJp4V8JhG89D1fw==
X-Received: by 2002:a1c:3803:: with SMTP id f3mr88990wma.14.1605221053557;
        Thu, 12 Nov 2020 14:44:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o197sm7861191wme.17.2020.11.12.14.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 14:44:13 -0800 (PST)
Message-Id: <af24b6d69de0241e16bbc074b7eba55c1e478ace.1605221039.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.git.1605221038.gitgitgadget@gmail.com>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Nov 2020 22:43:46 +0000
Subject: [PATCH 16/28] t5[6-9]*: adjust the references to the default branch
 name "main"
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

This trick was performed via

	$ (cd t &&
	   sed -i -e 's/master/main/g' -e 's/MASTER/MAIN/g' \
		-e 's/Master/Main/g' -- t5[6-9]*.sh)

This allows us to define `GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main`
for those tests.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5601-clone.sh                    |  4 +-
 t/t5604-clone-reference.sh          | 12 +++---
 t/t5605-clone-local.sh              | 10 ++---
 t/t5606-clone-options.sh            |  8 ++--
 t/t5607-clone-bundle.sh             | 14 +++----
 t/t5608-clone-2gb.sh                |  2 +-
 t/t5609-clone-branch.sh             |  6 +--
 t/t5610-clone-detached.sh           |  4 +-
 t/t5611-clone-config.sh             | 16 ++++----
 t/t5612-clone-refspec.sh            | 42 ++++++++++-----------
 t/t5614-clone-submodules-shallow.sh |  2 +-
 t/t5616-partial-clone.sh            | 50 ++++++++++++-------------
 t/t5617-clone-submodules-remote.sh  |  6 +--
 t/t5700-protocol-v1.sh              | 16 ++++----
 t/t5701-git-serve.sh                | 16 ++++----
 t/t5702-protocol-v2.sh              | 50 ++++++++++++-------------
 t/t5703-upload-pack-ref-in-want.sh  | 58 ++++++++++++++---------------
 t/t5801-remote-helpers.sh           | 24 ++++++------
 t/test-lib.sh                       |  2 +-
 19 files changed, 171 insertions(+), 171 deletions(-)

diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 7df3c5373a..f5058be718 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -217,7 +217,7 @@ test_expect_success 'clone respects global branch.autosetuprebase' '
 		rm -fr dst &&
 		git clone src dst &&
 		cd dst &&
-		actual="z$(git config branch.master.rebase)" &&
+		actual="z$(git config branch.main.rebase)" &&
 		test ztrue = $actual
 	)
 '
@@ -591,7 +591,7 @@ test_expect_success 'clone from a repository with two identical branches' '
 
 	(
 		cd src &&
-		git checkout -b another master
+		git checkout -b another main
 	) &&
 	git clone src target-11 &&
 	test "z$( cd target-11 && git symbolic-ref HEAD )" = zrefs/heads/another
diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
index 2f7be23044..db86a84af9 100755
--- a/t/t5604-clone-reference.sh
+++ b/t/t5604-clone-reference.sh
@@ -49,7 +49,7 @@ test_expect_success 'existence of info/alternates' '
 '
 
 test_expect_success 'pulling from reference' '
-	git -C C pull ../B master
+	git -C C pull ../B main
 '
 
 test_expect_success 'that reference gets used' '
@@ -70,7 +70,7 @@ test_expect_success 'existence of info/alternates' '
 '
 
 test_expect_success 'pulling from reference' '
-	git -C D pull ../B master
+	git -C D pull ../B main
 '
 
 test_expect_success 'that reference gets used' '
@@ -136,11 +136,11 @@ test_expect_success 'prepare branched repository' '
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
 
@@ -152,9 +152,9 @@ test_expect_success 'fetch with incomplete alternates' '
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
index af23419ebf..a7756e9622 100755
--- a/t/t5605-clone-local.sh
+++ b/t/t5605-clone-local.sh
@@ -15,7 +15,7 @@ test_expect_success 'preparing origin repository' '
 	test "$(cd a.git && git config --bool core.bare)" = true &&
 	test "$(cd x && git config --bool core.bare)" = true &&
 	git bundle create b1.bundle --all &&
-	git bundle create b2.bundle master &&
+	git bundle create b2.bundle main &&
 	mkdir dir &&
 	cp b1.bundle dir/b3 &&
 	cp b1.bundle b4
@@ -84,7 +84,7 @@ test_expect_success 'bundle clone with nonexistent HEAD' '
 	git clone b2.bundle b2 &&
 	(cd b2 &&
 	git fetch &&
-	test_must_fail git rev-parse --verify refs/heads/master)
+	test_must_fail git rev-parse --verify refs/heads/main)
 '
 
 test_expect_success 'clone empty repository' '
@@ -98,9 +98,9 @@ test_expect_success 'clone empty repository' '
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
index 7f082fb23b..80caff9266 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -15,7 +15,7 @@ test_expect_success 'setup' '
 test_expect_success 'clone -o' '
 
 	git clone -o foo parent clone-o &&
-	git -C clone-o rev-parse --verify refs/remotes/foo/master
+	git -C clone-o rev-parse --verify refs/remotes/foo/main
 
 '
 
@@ -45,7 +45,7 @@ test_expect_success 'disallows --bare with --separate-git-dir' '
 test_expect_success 'uses "origin" for default remote name' '
 
 	git clone parent clone-default-origin &&
-	git -C clone-default-origin rev-parse --verify refs/remotes/origin/master
+	git -C clone-default-origin rev-parse --verify refs/remotes/origin/main
 
 '
 
@@ -74,14 +74,14 @@ test_expect_success 'prefers config "clone.defaultRemoteName" over default' '
 
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
index 26985f4b44..4f2db37981 100755
--- a/t/t5607-clone-bundle.sh
+++ b/t/t5607-clone-bundle.sh
@@ -19,7 +19,7 @@ test_expect_success 'setup' '
 '
 
 test_expect_success '"verify" needs a worktree' '
-	git bundle create tip.bundle -1 master &&
+	git bundle create tip.bundle -1 main &&
 	nongit test_must_fail git bundle verify ../tip.bundle 2>err &&
 	test_i18ngrep "need a repository" err
 '
@@ -39,15 +39,15 @@ test_expect_success 'die if bundle file cannot be created' '
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
@@ -83,14 +83,14 @@ test_expect_success 'prerequisites with an empty commit message' '
 
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
index 6e7a7be052..2652dbe4e4 100755
--- a/t/t5609-clone-branch.sh
+++ b/t/t5609-clone-branch.sh
@@ -20,7 +20,7 @@ test_expect_success 'setup' '
 	 echo one >file && git add file && git commit -m one &&
 	 git checkout -b two &&
 	 echo two >file && git add file && git commit -m two &&
-	 git checkout master) &&
+	 git checkout main) &&
 	mkdir empty &&
 	(cd empty && git init)
 '
@@ -28,7 +28,7 @@ test_expect_success 'setup' '
 test_expect_success 'vanilla clone chooses HEAD' '
 	git clone parent clone &&
 	(cd clone &&
-	 check_HEAD master &&
+	 check_HEAD main &&
 	 check_file one
 	)
 '
@@ -53,7 +53,7 @@ test_expect_success 'clone -b sets up tracking' '
 
 test_expect_success 'clone -b does not munge remotes/origin/HEAD' '
 	(cd clone-two &&
-	 echo refs/remotes/origin/master >expect &&
+	 echo refs/remotes/origin/main >expect &&
 	 git symbolic-ref refs/remotes/origin/HEAD >actual &&
 	 test_cmp expect actual
 	)
diff --git a/t/t5610-clone-detached.sh b/t/t5610-clone-detached.sh
index 8b0d607df1..985f0d7303 100755
--- a/t/t5610-clone-detached.sh
+++ b/t/t5610-clone-detached.sh
@@ -20,7 +20,7 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'clone repo (detached HEAD points to branch)' '
-	git checkout master^0 &&
+	git checkout main^0 &&
 	git clone "file://$PWD" detached-branch
 '
 test_expect_success 'cloned HEAD matches' '
@@ -59,7 +59,7 @@ test_expect_success 'cloned HEAD is detached' '
 '
 
 test_expect_success 'clone repo (orphan detached HEAD)' '
-	git checkout master^0 &&
+	git checkout main^0 &&
 	echo four >file &&
 	git commit -a -m four &&
 	git clone "file://$PWD" detached-orphan
diff --git a/t/t5611-clone-config.sh b/t/t5611-clone-config.sh
index 8e0fd39823..6e10ac9a9f 100755
--- a/t/t5611-clone-config.sh
+++ b/t/t5611-clone-config.sh
@@ -47,16 +47,16 @@ test_expect_success 'clone -c config is available during clone' '
 
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
@@ -68,9 +68,9 @@ test_expect_success 'git -c remote.origin.fetch=<refspec> clone works' '
 
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
@@ -85,9 +85,9 @@ test_expect_success 'clone -c remote.<remote>.fetch=<refspec> --origin=<name>' '
 
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
index e3b436d8ae..c045aba0fd 100755
--- a/t/t5612-clone-refspec.sh
+++ b/t/t5612-clone-refspec.sh
@@ -4,7 +4,7 @@ test_description='test refspec written by clone-command'
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-	# Make two branches, "master" and "side"
+	# Make two branches, "main" and "side"
 	echo one >file &&
 	git add file &&
 	git commit -m one &&
@@ -16,7 +16,7 @@ test_expect_success 'setup' '
 	git checkout -b side &&
 	echo four >file &&
 	git commit -a -m four &&
-	git checkout master &&
+	git checkout main &&
 	git tag five &&
 
 	# default clone
@@ -25,18 +25,18 @@ test_expect_success 'setup' '
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
@@ -55,11 +55,11 @@ test_expect_success 'setup' '
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
 
@@ -75,7 +75,7 @@ test_expect_success 'by default all branches will be kept updated' '
 		sed -e "/HEAD$/d" \
 		    -e "s|/remotes/origin/|/heads/|" refs >../actual
 	) &&
-	# follow both master and side
+	# follow both main and side
 	git for-each-ref refs/heads >expect &&
 	test_cmp expect actual
 '
@@ -100,20 +100,20 @@ test_expect_success 'clone with --no-tags' '
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
@@ -122,20 +122,20 @@ test_expect_success '--single-branch while HEAD pointing at master' '
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
@@ -143,7 +143,7 @@ test_expect_success '--single-branch while HEAD pointing at master and --no-tags
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
index f4d49d8335..273c0183e2 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -51,14 +51,14 @@ test_expect_success 'verify that .promisor file contains refs fetched' '
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
@@ -73,8 +73,8 @@ test_expect_success 'push new commits to server' '
 		git -C src add file.1.txt
 		git -C src commit -m "mod $x"
 	done &&
-	git -C src blame master -- file.1.txt >expect.blame &&
-	git -C src push -u srv master
+	git -C src blame main -- file.1.txt >expect.blame &&
+	git -C src push -u srv main
 '
 
 # (partial) fetch in the partial clone repo from the promisor remote.
@@ -83,26 +83,26 @@ test_expect_success 'push new commits to server' '
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
 
@@ -115,7 +115,7 @@ test_expect_success 'push new commits to server for file.2.txt' '
 		git -C src add file.2.txt
 		git -C src commit -m "mod $x"
 	done &&
-	git -C src push -u srv master
+	git -C src push -u srv main
 '
 
 # Do FULL fetch by disabling inherited filter-spec using --no-filter.
@@ -123,7 +123,7 @@ test_expect_success 'push new commits to server for file.2.txt' '
 test_expect_success 'override inherited filter-spec using --no-filter' '
 	git -C pc1 fetch --no-filter origin &&
 	git -C pc1 rev-list --quiet --objects --missing=print \
-		master..origin/master >observed &&
+		main..origin/main >observed &&
 	test_line_count = 0 observed
 '
 
@@ -136,7 +136,7 @@ test_expect_success 'push new commits to server for file.3.txt' '
 		git -C src add file.3.txt
 		git -C src commit -m "mod $x"
 	done &&
-	git -C src push -u srv master
+	git -C src push -u srv main
 '
 
 # Do a partial fetch and then try to manually fetch the missing objects.
@@ -146,7 +146,7 @@ test_expect_success 'manual prefetch of missing objects' '
 	git -C pc1 fetch --filter=blob:none origin &&
 
 	git -C pc1 rev-list --quiet --objects --missing=print \
-		 master..origin/master >revs &&
+		 main..origin/main >revs &&
 	awk -f print_1.awk revs |
 	sed "s/?//" |
 	sort >observed.oids &&
@@ -155,7 +155,7 @@ test_expect_success 'manual prefetch of missing objects' '
 	git -C pc1 fetch-pack --stdin "file://$(pwd)/srv.bare" <observed.oids &&
 
 	git -C pc1 rev-list --quiet --objects --missing=print \
-		master..origin/master >revs &&
+		main..origin/main >revs &&
 	awk -f print_1.awk revs |
 	sed "s/?//" |
 	sort >observed.oids &&
@@ -196,7 +196,7 @@ test_expect_success 'use fsck before and after manually fetching a missing subtr
 	echo "in dir" >src/dir/file.txt &&
 	git -C src add dir/file.txt &&
 	git -C src commit -m "file in dir" &&
-	git -C src push -u srv master &&
+	git -C src push -u srv main &&
 	SUBTREE=$(git -C src rev-parse HEAD:dir) &&
 
 	rm -rf dst &&
@@ -204,7 +204,7 @@ test_expect_success 'use fsck before and after manually fetching a missing subtr
 	git -C dst fsck &&
 
 	# Make sure we only have commits, and all trees and blobs are missing.
-	git -C dst rev-list --missing=allow-any --objects master \
+	git -C dst rev-list --missing=allow-any --objects main \
 		>fetched_objects &&
 	awk -f print_1.awk fetched_objects |
 	xargs -n1 git -C dst cat-file -t >fetched_types &&
@@ -221,7 +221,7 @@ test_expect_success 'use fsck before and after manually fetching a missing subtr
 	git -C dst fsck &&
 
 	# Auto-fetch all remaining trees and blobs with --missing=error
-	git -C dst rev-list --missing=error --objects master >fetched_objects &&
+	git -C dst rev-list --missing=error --objects main >fetched_objects &&
 	test_line_count = 70 fetched_objects &&
 
 	awk -f print_1.awk fetched_objects |
@@ -331,7 +331,7 @@ test_expect_success 'setup src repo for sparse filter' '
 test_expect_success 'partial clone with sparse filter succeeds' '
 	rm -rf dst.git &&
 	git clone --no-local --bare \
-		  --filter=sparse:oid=master:only-one \
+		  --filter=sparse:oid=main:only-one \
 		  sparse-src dst.git &&
 	(
 		cd dst.git &&
@@ -344,11 +344,11 @@ test_expect_success 'partial clone with sparse filter succeeds' '
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
@@ -403,7 +403,7 @@ test_expect_success 'fetch lazy-fetches only to resolve deltas' '
 	# promisor remote other than for the big tree (because it needs to
 	# resolve the delta).
 	GIT_TRACE_PACKET="$(pwd)/trace" git -C client \
-		fetch "file://$(pwd)/server" master &&
+		fetch "file://$(pwd)/server" main &&
 
 	# Verify the assumption that the client needed to fetch the delta base
 	# to resolve the delta.
@@ -422,7 +422,7 @@ test_expect_success 'fetch lazy-fetches only to resolve deltas, protocol v2' '
 	# promisor remote other than for the big blob (because it needs to
 	# resolve the delta).
 	GIT_TRACE_PACKET="$(pwd)/trace" git -C client \
-		fetch "file://$(pwd)/server" master &&
+		fetch "file://$(pwd)/server" main &&
 
 	# Verify that protocol version 2 was used.
 	grep "fetch< version 2" trace &&
diff --git a/t/t5617-clone-submodules-remote.sh b/t/t5617-clone-submodules-remote.sh
index 1a041df10b..abab358119 100755
--- a/t/t5617-clone-submodules-remote.sh
+++ b/t/t5617-clone-submodules-remote.sh
@@ -7,7 +7,7 @@ test_description='Test cloning repos with submodules using remote-tracking branc
 pwd=$(pwd)
 
 test_expect_success 'setup' '
-	git checkout -b master &&
+	git checkout -b main &&
 	test_commit commit1 &&
 	mkdir sub &&
 	(
@@ -39,7 +39,7 @@ test_expect_success 'clone with --remote-submodules' '
 	git clone --recurse-submodules --remote-submodules "file://$pwd/." super_clone &&
 	(
 		cd super_clone/sub &&
-		git diff --exit-code remotes/origin/master
+		git diff --exit-code remotes/origin/main
 	)
 '
 
@@ -57,7 +57,7 @@ test_expect_success 'clone with --single-branch' '
 	git clone --recurse-submodules --single-branch "file://$pwd/." super_clone &&
 	(
 		cd super_clone/sub &&
-		git rev-parse --verify origin/master &&
+		git rev-parse --verify origin/main &&
 		test_must_fail git rev-parse --verify origin/other
 	)
 '
diff --git a/t/t5700-protocol-v1.sh b/t/t5700-protocol-v1.sh
index 022901b9eb..bfa7e3379a 100755
--- a/t/t5700-protocol-v1.sh
+++ b/t/t5700-protocol-v1.sh
@@ -41,7 +41,7 @@ test_expect_success 'fetch with git:// using protocol v1' '
 	GIT_TRACE_PACKET=1 git -C daemon_child -c protocol.version=1 \
 		fetch 2>log &&
 
-	git -C daemon_child log -1 --format=%s origin/master >actual &&
+	git -C daemon_child log -1 --format=%s origin/main >actual &&
 	git -C "$daemon_parent" log -1 --format=%s >expect &&
 	test_cmp expect actual &&
 
@@ -69,7 +69,7 @@ test_expect_success 'push with git:// using protocol v1' '
 	test_commit -C daemon_child three &&
 
 	# Push to another branch, as the target repository has the
-	# master branch checked out and we cannot push into it.
+	# main branch checked out and we cannot push into it.
 	GIT_TRACE_PACKET=1 git -C daemon_child -c protocol.version=1 \
 		push origin HEAD:client_branch 2>log &&
 
@@ -110,7 +110,7 @@ test_expect_success 'fetch with file:// using protocol v1' '
 	GIT_TRACE_PACKET=1 git -C file_child -c protocol.version=1 \
 		fetch 2>log &&
 
-	git -C file_child log -1 --format=%s origin/master >actual &&
+	git -C file_child log -1 --format=%s origin/main >actual &&
 	git -C file_parent log -1 --format=%s >expect &&
 	test_cmp expect actual &&
 
@@ -134,7 +134,7 @@ test_expect_success 'push with file:// using protocol v1' '
 	test_commit -C file_child three &&
 
 	# Push to another branch, as the target repository has the
-	# master branch checked out and we cannot push into it.
+	# main branch checked out and we cannot push into it.
 	GIT_TRACE_PACKET=1 git -C file_child -c protocol.version=1 \
 		push origin HEAD:client_branch 2>log &&
 
@@ -188,7 +188,7 @@ test_expect_success 'fetch with ssh:// using protocol v1' '
 		fetch 2>log &&
 	expect_ssh git-upload-pack &&
 
-	git -C ssh_child log -1 --format=%s origin/master >actual &&
+	git -C ssh_child log -1 --format=%s origin/main >actual &&
 	git -C ssh_parent log -1 --format=%s >expect &&
 	test_cmp expect actual &&
 
@@ -213,7 +213,7 @@ test_expect_success 'push with ssh:// using protocol v1' '
 	test_commit -C ssh_child three &&
 
 	# Push to another branch, as the target repository has the
-	# master branch checked out and we cannot push into it.
+	# main branch checked out and we cannot push into it.
 	GIT_TRACE_PACKET=1 git -C ssh_child -c protocol.version=1 \
 		push origin HEAD:client_branch 2>log &&
 	expect_ssh git-receive-pack &&
@@ -257,7 +257,7 @@ test_expect_success 'fetch with http:// using protocol v1' '
 	GIT_TRACE_PACKET=1 git -C http_child -c protocol.version=1 \
 		fetch 2>log &&
 
-	git -C http_child log -1 --format=%s origin/master >actual &&
+	git -C http_child log -1 --format=%s origin/main >actual &&
 	git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" log -1 --format=%s >expect &&
 	test_cmp expect actual &&
 
@@ -281,7 +281,7 @@ test_expect_success 'push with http:// using protocol v1' '
 	test_commit -C http_child three &&
 
 	# Push to another branch, as the target repository has the
-	# master branch checked out and we cannot push into it.
+	# main branch checked out and we cannot push into it.
 	GIT_TRACE_PACKET=1 git -C http_child -c protocol.version=1 \
 		push origin HEAD:client_branch && #2>log &&
 
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index a1f5fdc9fd..3a04a56c2c 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -83,9 +83,9 @@ test_expect_success 'wrong object-format' '
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
 
@@ -99,7 +99,7 @@ test_expect_success 'basics of ls-refs' '
 	cat >expect <<-EOF &&
 	$(git rev-parse HEAD) HEAD
 	$(git rev-parse refs/heads/dev) refs/heads/dev
-	$(git rev-parse refs/heads/master) refs/heads/master
+	$(git rev-parse refs/heads/main) refs/heads/main
 	$(git rev-parse refs/heads/release) refs/heads/release
 	$(git rev-parse refs/tags/annotated-tag) refs/tags/annotated-tag
 	$(git rev-parse refs/tags/one) refs/tags/one
@@ -117,13 +117,13 @@ test_expect_success 'basic ref-prefixes' '
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
@@ -144,7 +144,7 @@ test_expect_success 'refs/heads prefix' '
 
 	cat >expect <<-EOF &&
 	$(git rev-parse refs/heads/dev) refs/heads/dev
-	$(git rev-parse refs/heads/master) refs/heads/master
+	$(git rev-parse refs/heads/main) refs/heads/main
 	$(git rev-parse refs/heads/release) refs/heads/release
 	0000
 	EOF
@@ -188,8 +188,8 @@ test_expect_success 'symrefs parameter' '
 
 	cat >expect <<-EOF &&
 	$(git rev-parse refs/heads/dev) refs/heads/dev
-	$(git rev-parse refs/heads/master) refs/heads/master
-	$(git rev-parse refs/heads/release) refs/heads/release symref-target:refs/heads/master
+	$(git rev-parse refs/heads/main) refs/heads/main
+	$(git rev-parse refs/heads/release) refs/heads/release symref-target:refs/heads/main
 	0000
 	EOF
 
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 7d5b17909b..1aeb6b6dd7 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -36,10 +36,10 @@ test_expect_success 'ref advertisement is filtered with ls-remote using protocol
 	test_when_finished "rm -f log" &&
 
 	GIT_TRACE_PACKET="$(pwd)/log" git -c protocol.version=2 \
-		ls-remote "$GIT_DAEMON_URL/parent" master >actual &&
+		ls-remote "$GIT_DAEMON_URL/parent" main >actual &&
 
 	cat >expect <<-EOF &&
-	$(git -C "$daemon_parent" rev-parse refs/heads/master)$(printf "\t")refs/heads/master
+	$(git -C "$daemon_parent" rev-parse refs/heads/main)$(printf "\t")refs/heads/main
 	EOF
 
 	test_cmp expect actual
@@ -69,7 +69,7 @@ test_expect_success 'fetch with git:// using protocol v2' '
 	GIT_TRACE_PACKET="$(pwd)/log" git -C daemon_child -c protocol.version=2 \
 		fetch &&
 
-	git -C daemon_child log -1 --format=%s origin/master >actual &&
+	git -C daemon_child log -1 --format=%s origin/main >actual &&
 	git -C "$daemon_parent" log -1 --format=%s >expect &&
 	test_cmp expect actual &&
 
@@ -118,7 +118,7 @@ test_expect_success 'push with git:// and a config of v2 does not request v2' '
 	test_commit -C daemon_child three &&
 
 	# Push to another branch, as the target repository has the
-	# master branch checked out and we cannot push into it.
+	# main branch checked out and we cannot push into it.
 	GIT_TRACE_PACKET="$(pwd)/log" git -C daemon_child -c protocol.version=2 \
 		push origin HEAD:client_branch &&
 
@@ -158,10 +158,10 @@ test_expect_success 'ref advertisement is filtered with ls-remote using protocol
 	test_when_finished "rm -f log" &&
 
 	GIT_TRACE_PACKET="$(pwd)/log" git -c protocol.version=2 \
-		ls-remote "file://$(pwd)/file_parent" master >actual &&
+		ls-remote "file://$(pwd)/file_parent" main >actual &&
 
 	cat >expect <<-EOF &&
-	$(git -C file_parent rev-parse refs/heads/master)$(printf "\t")refs/heads/master
+	$(git -C file_parent rev-parse refs/heads/main)$(printf "\t")refs/heads/main
 	EOF
 
 	test_cmp expect actual
@@ -171,10 +171,10 @@ test_expect_success 'server-options are sent when using ls-remote' '
 	test_when_finished "rm -f log" &&
 
 	GIT_TRACE_PACKET="$(pwd)/log" git -c protocol.version=2 \
-		ls-remote -o hello -o world "file://$(pwd)/file_parent" master >actual &&
+		ls-remote -o hello -o world "file://$(pwd)/file_parent" main >actual &&
 
 	cat >expect <<-EOF &&
-	$(git -C file_parent rev-parse refs/heads/master)$(printf "\t")refs/heads/master
+	$(git -C file_parent rev-parse refs/heads/main)$(printf "\t")refs/heads/main
 	EOF
 
 	test_cmp expect actual &&
@@ -184,7 +184,7 @@ test_expect_success 'server-options are sent when using ls-remote' '
 
 test_expect_success 'warn if using server-option with ls-remote with legacy protocol' '
 	test_must_fail env GIT_TEST_PROTOCOL_VERSION=0 git -c protocol.version=0 \
-		ls-remote -o hello -o world "file://$(pwd)/file_parent" master 2>err &&
+		ls-remote -o hello -o world "file://$(pwd)/file_parent" main 2>err &&
 
 	test_i18ngrep "see protocol.version in" err &&
 	test_i18ngrep "server options require protocol version 2 or later" err
@@ -217,7 +217,7 @@ test_expect_success 'fetch with file:// using protocol v2' '
 	GIT_TRACE_PACKET="$(pwd)/log" git -C file_child -c protocol.version=2 \
 		fetch origin &&
 
-	git -C file_child log -1 --format=%s origin/master >actual &&
+	git -C file_child log -1 --format=%s origin/main >actual &&
 	git -C file_parent log -1 --format=%s >expect &&
 	test_cmp expect actual &&
 
@@ -232,13 +232,13 @@ test_expect_success 'ref advertisement is filtered during fetch using protocol v
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
 
@@ -248,9 +248,9 @@ test_expect_success 'server-options are sent when fetching' '
 	test_commit -C file_parent four &&
 
 	GIT_TRACE_PACKET="$(pwd)/log" git -C file_child -c protocol.version=2 \
-		fetch -o hello -o world origin master &&
+		fetch -o hello -o world origin main &&
 
-	git -C file_child log -1 --format=%s origin/master >actual &&
+	git -C file_child log -1 --format=%s origin/main >actual &&
 	git -C file_parent log -1 --format=%s >expect &&
 	test_cmp expect actual &&
 
@@ -264,7 +264,7 @@ test_expect_success 'warn if using server-option with fetch with legacy protocol
 	git init temp_child &&
 
 	test_must_fail env GIT_TEST_PROTOCOL_VERSION=0 git -C temp_child -c protocol.version=0 \
-		fetch -o hello -o world "file://$(pwd)/file_parent" master 2>err &&
+		fetch -o hello -o world "file://$(pwd)/file_parent" main 2>err &&
 
 	test_i18ngrep "see protocol.version in" err &&
 	test_i18ngrep "server options require protocol version 2 or later" err
@@ -325,7 +325,7 @@ test_expect_success 'partial clone' '
 	grep "version 2" trace &&
 
 	# Ensure that the old version of the file is missing
-	git -C client rev-list --quiet --objects --missing=print master \
+	git -C client rev-list --quiet --objects --missing=print main \
 		>observed.oids &&
 	grep "$(git -C server rev-parse message1:a.txt)" observed.oids &&
 
@@ -350,7 +350,7 @@ test_expect_success 'partial fetch' '
 	SERVER="file://$(pwd)/server" &&
 
 	GIT_TRACE_PACKET="$(pwd)/trace" git -C client -c protocol.version=2 \
-		fetch --filter=blob:none "$SERVER" master:refs/heads/other &&
+		fetch --filter=blob:none "$SERVER" main:refs/heads/other &&
 	grep "version 2" trace &&
 
 	# Ensure that the old version of the file is missing
@@ -395,7 +395,7 @@ test_expect_success 'even with handcrafted request, filter does not work if not
 	command=fetch
 	object-format=$(test_oid algo)
 	0001
-	want $(git -C server rev-parse master)
+	want $(git -C server rev-parse main)
 	filter blob:none
 	0000
 	EOF
@@ -539,7 +539,7 @@ test_expect_success 'deepen-relative' '
 	test_commit -C server four &&
 
 	# Sanity check that only "three" is downloaded
-	git -C client log --pretty=tformat:%s master >actual &&
+	git -C client log --pretty=tformat:%s main >actual &&
 	echo three >expected &&
 	test_cmp expected actual &&
 
@@ -548,7 +548,7 @@ test_expect_success 'deepen-relative' '
 	# Ensure that protocol v2 is used
 	grep "fetch< version 2" trace &&
 
-	git -C client log --pretty=tformat:%s origin/master >actual &&
+	git -C client log --pretty=tformat:%s origin/main >actual &&
 	cat >expected <<-\EOF &&
 	four
 	three
@@ -670,7 +670,7 @@ test_expect_success 'fetch with http:// using protocol v2' '
 	GIT_TRACE_PACKET="$(pwd)/log" git -C http_child -c protocol.version=2 \
 		fetch &&
 
-	git -C http_child log -1 --format=%s origin/master >actual &&
+	git -C http_child log -1 --format=%s origin/main >actual &&
 	git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" log -1 --format=%s >expect &&
 	test_cmp expect actual &&
 
@@ -698,11 +698,11 @@ test_expect_success 'fetch from namespaced repo respects namespaces' '
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
@@ -733,7 +733,7 @@ test_expect_success 'push with http:// and a config of v2 does not request v2' '
 	test_commit -C http_child three &&
 
 	# Push to another branch, as the target repository has the
-	# master branch checked out and we cannot push into it.
+	# main branch checked out and we cannot push into it.
 	GIT_TRACE_PACKET="$(pwd)/log" git -C http_child -c protocol.version=2 \
 		push origin HEAD:client_branch &&
 
diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index b46940b725..bbf03a8f66 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -38,7 +38,7 @@ write_command () {
 
 # c(o/foo) d(o/bar)
 #        \ /
-#         b   e(baz)  f(master)
+#         b   e(baz)  f(main)
 #          \__  |  __/
 #             \ | /
 #               a
@@ -51,7 +51,7 @@ test_expect_success 'setup repository' '
 	test_commit d &&
 	git checkout -b baz a &&
 	test_commit e &&
-	git checkout master &&
+	git checkout main &&
 	test_commit f
 '
 
@@ -88,7 +88,7 @@ test_expect_success 'invalid want-ref line' '
 test_expect_success 'basic want-ref' '
 	oid=$(git rev-parse f) &&
 	cat >expected_refs <<-EOF &&
-	$oid refs/heads/master
+	$oid refs/heads/main
 	EOF
 	git rev-parse f >expected_commits &&
 
@@ -97,7 +97,7 @@ test_expect_success 'basic want-ref' '
 	$(write_command fetch)
 	0001
 	no-progress
-	want-ref refs/heads/master
+	want-ref refs/heads/main
 	have $oid
 	done
 	0000
@@ -135,7 +135,7 @@ test_expect_success 'multiple want-ref lines' '
 test_expect_success 'mix want and want-ref' '
 	oid=$(git rev-parse f) &&
 	cat >expected_refs <<-EOF &&
-	$oid refs/heads/master
+	$oid refs/heads/main
 	EOF
 	git rev-parse e f >expected_commits &&
 
@@ -143,7 +143,7 @@ test_expect_success 'mix want and want-ref' '
 	$(write_command fetch)
 	0001
 	no-progress
-	want-ref refs/heads/master
+	want-ref refs/heads/main
 	want $(git rev-parse e)
 	have $(git rev-parse a)
 	done
@@ -182,7 +182,7 @@ LOCAL_PRISTINE="$(pwd)/local_pristine"
 # $REPO
 # c(o/foo) d(o/bar)
 #        \ /
-#         b   e(baz)  f(master)
+#         b   e(baz)  f(main)
 #          \__  |  __/
 #             \ | /
 #               a
@@ -193,7 +193,7 @@ LOCAL_PRISTINE="$(pwd)/local_pristine"
 #		.
 #		.
 #		|
-#		a(master)
+#		a(main)
 test_expect_success 'setup repos for fetching with ref-in-want tests' '
 	(
 		git init "$REPO" &&
@@ -209,7 +209,7 @@ test_expect_success 'setup repos for fetching with ref-in-want tests' '
 		test_commit_bulk --id=s 33 &&
 
 		# Add novel commits to upstream
-		git checkout master &&
+		git checkout main &&
 		cd "$REPO" &&
 		git checkout -b o/foo &&
 		test_commit b &&
@@ -218,7 +218,7 @@ test_expect_success 'setup repos for fetching with ref-in-want tests' '
 		test_commit d &&
 		git checkout -b baz a &&
 		test_commit e &&
-		git checkout master &&
+		git checkout main &&
 		test_commit f
 	) &&
 	git -C "$REPO" config uploadpack.allowRefInWant true &&
@@ -245,12 +245,12 @@ test_expect_success 'fetching multiple refs' '
 
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
 
@@ -261,13 +261,13 @@ test_expect_success 'fetching ref and exact OID' '
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
@@ -316,7 +316,7 @@ test_expect_success 'setup repos for change-while-negotiating test' '
 		test_commit_bulk --id=s 33 &&
 
 		# Add novel commits to upstream
-		git checkout master &&
+		git checkout main &&
 		cd "$REPO" &&
 		test_commit m2 &&
 		test_commit m3 &&
@@ -342,7 +342,7 @@ test_expect_success 'server is initially ahead - no ref in want' '
 	git -C "$REPO" config uploadpack.allowRefInWant false &&
 	rm -rf local &&
 	cp -r "$LOCAL_PRISTINE" local &&
-	inconsistency master $(test_oid numeric) &&
+	inconsistency main $(test_oid numeric) &&
 	test_must_fail git -C local fetch 2>err &&
 	test_i18ngrep "fatal: remote error: upload-pack: not our ref" err
 '
@@ -351,11 +351,11 @@ test_expect_success 'server is initially ahead - ref in want' '
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
 
@@ -363,11 +363,11 @@ test_expect_success 'server is initially behind - no ref in want' '
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
 
@@ -375,11 +375,11 @@ test_expect_success 'server is initially behind - ref in want' '
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
index 0f04b6cddb..306fe9e5e1 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -71,18 +71,18 @@ test_expect_success 'fetch multiple branches' '
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
@@ -174,7 +174,7 @@ test_expect_failure 'pushing without marks' '
 
 test_expect_success 'push all with existing object' '
 	(cd local &&
-	git branch dup2 master &&
+	git branch dup2 main &&
 	git push origin --all
 	) &&
 	compare_refs local dup2 server dup2
@@ -182,7 +182,7 @@ test_expect_success 'push all with existing object' '
 
 test_expect_success 'push ref with existing object' '
 	(cd local &&
-	git branch dup master &&
+	git branch dup main &&
 	git push origin dup
 	) &&
 	compare_refs local dup server dup
@@ -190,7 +190,7 @@ test_expect_success 'push ref with existing object' '
 
 test_expect_success GPG 'push signed tag' '
 	(cd local &&
-	git checkout master &&
+	git checkout main &&
 	git tag -s -m signed-tag signed-tag &&
 	git push origin signed-tag
 	) &&
@@ -200,7 +200,7 @@ test_expect_success GPG 'push signed tag' '
 
 test_expect_success GPG 'push signed tag with signed-tags capability' '
 	(cd local &&
-	git checkout master &&
+	git checkout main &&
 	git tag -s -m signed-tag signed-tag-2 &&
 	GIT_REMOTE_TESTGIT_SIGNED_TAGS=1 git push origin signed-tag-2
 	) &&
@@ -209,7 +209,7 @@ test_expect_success GPG 'push signed tag with signed-tags capability' '
 
 test_expect_success 'push update refs' '
 	(cd local &&
-	git checkout -b update master &&
+	git checkout -b update main &&
 	echo update >>file &&
 	git commit -a -m update &&
 	git push origin update &&
@@ -260,7 +260,7 @@ test_expect_success 'proper failure checks for fetching' '
 test_expect_success 'proper failure checks for pushing' '
 	test_when_finished "rm -rf local/git.marks local/testgit.marks" &&
 	(cd local &&
-	git checkout -b crash master &&
+	git checkout -b crash main &&
 	echo crash >>file &&
 	git commit -a -m crash &&
 	test_must_fail env GIT_REMOTE_TESTGIT_FAILURE=1 git push --all &&
@@ -272,7 +272,7 @@ test_expect_success 'proper failure checks for pushing' '
 
 test_expect_success 'push messages' '
 	(cd local &&
-	git checkout -b new_branch master &&
+	git checkout -b new_branch main &&
 	echo new >>file &&
 	git commit -a -m new &&
 	git push origin new_branch &&
@@ -286,7 +286,7 @@ test_expect_success 'push messages' '
 
 test_expect_success 'fetch HEAD' '
 	(cd server &&
-	git checkout master &&
+	git checkout main &&
 	echo more >>file &&
 	git commit -a -m more
 	) &&
@@ -298,7 +298,7 @@ test_expect_success 'fetch HEAD' '
 
 test_expect_success 'fetch url' '
 	(cd server &&
-	git checkout master &&
+	git checkout main &&
 	echo more >>file &&
 	git commit -a -m more
 	) &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index f919021063..a78ff1e57e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -263,7 +263,7 @@ case "$TEST_NUMBER" in
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 	;;
-[0-4]*|5[0-5]*)
+[0-5]*)
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 	;;
-- 
gitgitgadget

