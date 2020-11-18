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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F6CC64E7D
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 996E4246BC
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzVNtHjk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbgKRXpO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 18:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbgKRXpI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 18:45:08 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D736C0613D6
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:45:06 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id l1so4280971wrb.9
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uS9kCmOI0XaPvUizL2zklJBq7LHU0XsQUhgOeN40IV8=;
        b=RzVNtHjkyMC7rYXixHLz/8l862wNIfxMBTyAmXM2MEAT194Q+fvi+ZJUuxe7BSG3bz
         9dLb3mt8BM8NskRhXr9PhwX+HXa8IhryGDWbvrgBzXYUc1P9J+h4ZEyXTdi+xHGljtcx
         0ifYYvDrnhYB11GVBaxMylN83f48S7CDqwIQxHaWlXm3XEYdQqowsAP+dRZIRkRen2Ut
         xSVsSbHSvTaJgLn8mJhuhY0O6mROpDsDe0Q2dg9aVq0eU/RD93H3MWJYkhBuWTyClx42
         rJkr+9SdtGr3s+dO7YSGBpYx+8v1nMB+kqCjpOdQYWtmHecMWAefGg5rK9S6DAzRD3F8
         /iAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uS9kCmOI0XaPvUizL2zklJBq7LHU0XsQUhgOeN40IV8=;
        b=KVXkizqKu3dxAhZKBRveUQMQL/qjkctQQp9Aq1yDLP3iG0lou9jPL96Wf+ZbbWrWkc
         8naKBBkAC9A8XyBynTqk7yfGOkKb0vKrY4PqvPn9Zt3Sqrf9KgkfrIyLEvCafhANO+Ky
         cgyF8dTez91zO+mCgOH48k/6mBOmoEnPHYx/daMfjsB9uDMfA2NYRVtzlwbtVrE8VB+z
         tw6Eugl2atpKrvQ6nkkcONiduvQ03xCVbC6U8woqrBqZMdmmBm/bUxH/4JLOVQsHvJUm
         cw4w1DDd2pzCptRGdPrvYaD/Q93eI/xXWoXsIrS0/Y9XM4SPlGO1gIAYMlaZPXGaGjxR
         Owlg==
X-Gm-Message-State: AOAM531PlyTIm/I6Ovs8oqb/vD3Bd/YpEVYGbp6ETlSttKi0Cy56mk+Q
        QMdoGEp0yxeQlJl1P0nUbtY+rHrwrRo=
X-Google-Smtp-Source: ABdhPJziBJ1ceSq4smD0bKcj4kShv9fKTbAYVUNLtvAMvOzpsRNJ8vjov0TpwwTfF3tC15k733BWqQ==
X-Received: by 2002:a5d:42c9:: with SMTP id t9mr6917441wrr.13.1605743103620;
        Wed, 18 Nov 2020 15:45:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d15sm3381876wrx.93.2020.11.18.15.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 15:45:03 -0800 (PST)
Message-Id: <88b2c30cc879183e765309f404a795b190fee877.1605743087.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.v3.git.1605743086.gitgitgadget@gmail.com>
References: <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
        <pull.762.v3.git.1605743086.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Nov 2020 23:44:32 +0000
Subject: [PATCH v3 14/28] t551*: adjust the references to the default branch
 name "main"
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
		-e 's/Master/Main/g' -- t551*.sh)

This allows us to define `GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main`
for those tests.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5510-fetch.sh             | 160 +++++------
 t/t5511-refspec.sh           |  12 +-
 t/t5512-ls-remote.sh         |  28 +-
 t/t5514-fetch-multiple.sh    |  32 +--
 t/t5516-fetch-push.sh        | 502 +++++++++++++++++------------------
 t/t5517-push-mirror.sh       | 126 ++++-----
 t/t5518-fetch-exit-status.sh |   8 +-
 t/t5519-push-alternates.sh   |  14 +-
 8 files changed, 441 insertions(+), 441 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 4af490b6db..35d9a8c279 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -5,7 +5,7 @@ test_description='Per branch config variables affects "git fetch".
 
 '
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -40,19 +40,19 @@ test_expect_success "clone and setup child repos" '
 	git clone . two &&
 	(
 		cd two &&
-		git config branch.master.remote one &&
+		git config branch.main.remote one &&
 		git config remote.one.url ../one/.git/ &&
-		git config remote.one.fetch refs/heads/master:refs/heads/one
+		git config remote.one.fetch refs/heads/main:refs/heads/one
 	) &&
 	git clone . three &&
 	(
 		cd three &&
-		git config branch.master.remote two &&
-		git config branch.master.merge refs/heads/one &&
+		git config branch.main.remote two &&
+		git config branch.main.merge refs/heads/one &&
 		mkdir -p .git/remotes &&
 		{
 			echo "URL: ../two/.git/"
-			echo "Pull: refs/heads/master:refs/heads/two"
+			echo "Pull: refs/heads/main:refs/heads/two"
 			echo "Pull: refs/heads/one:refs/heads/one"
 		} >.git/remotes/two
 	) &&
@@ -68,7 +68,7 @@ test_expect_success "fetch test" '
 	git fetch &&
 	git rev-parse --verify refs/heads/one &&
 	mine=$(git rev-parse refs/heads/one) &&
-	his=$(cd ../one && git rev-parse refs/heads/master) &&
+	his=$(cd ../one && git rev-parse refs/heads/main) &&
 	test "z$mine" = "z$his"
 '
 
@@ -78,11 +78,11 @@ test_expect_success "fetch test for-merge" '
 	git fetch &&
 	git rev-parse --verify refs/heads/two &&
 	git rev-parse --verify refs/heads/one &&
-	master_in_two=$(cd ../two && git rev-parse master) &&
+	main_in_two=$(cd ../two && git rev-parse main) &&
 	one_in_two=$(cd ../two && git rev-parse one) &&
 	{
 		echo "$one_in_two	"
-		echo "$master_in_two	not-for-merge"
+		echo "$main_in_two	not-for-merge"
 	} >expected &&
 	cut -f -2 .git/FETCH_HEAD >actual &&
 	test_cmp expected actual'
@@ -91,7 +91,7 @@ test_expect_success 'fetch --prune on its own works as expected' '
 	cd "$D" &&
 	git clone . prune &&
 	cd prune &&
-	git update-ref refs/remotes/origin/extrabranch master &&
+	git update-ref refs/remotes/origin/extrabranch main &&
 
 	git fetch --prune origin &&
 	test_must_fail git rev-parse origin/extrabranch
@@ -101,9 +101,9 @@ test_expect_success 'fetch --prune with a branch name keeps branches' '
 	cd "$D" &&
 	git clone . prune-branch &&
 	cd prune-branch &&
-	git update-ref refs/remotes/origin/extrabranch master &&
+	git update-ref refs/remotes/origin/extrabranch main &&
 
-	git fetch --prune origin master &&
+	git fetch --prune origin main &&
 	git rev-parse origin/extrabranch
 '
 
@@ -113,18 +113,18 @@ test_expect_success 'fetch --prune with a namespace keeps other namespaces' '
 	cd prune-namespace &&
 
 	git fetch --prune origin refs/heads/a/*:refs/remotes/origin/a/* &&
-	git rev-parse origin/master
+	git rev-parse origin/main
 '
 
 test_expect_success 'fetch --prune handles overlapping refspecs' '
 	cd "$D" &&
-	git update-ref refs/pull/42/head master &&
+	git update-ref refs/pull/42/head main &&
 	git clone . prune-overlapping &&
 	cd prune-overlapping &&
 	git config --add remote.origin.fetch refs/pull/*/head:refs/remotes/origin/pr/* &&
 
 	git fetch --prune origin &&
-	git rev-parse origin/master &&
+	git rev-parse origin/main &&
 	git rev-parse origin/pr/42 &&
 
 	git config --unset-all remote.origin.fetch &&
@@ -132,7 +132,7 @@ test_expect_success 'fetch --prune handles overlapping refspecs' '
 	git config --add remote.origin.fetch refs/heads/*:refs/remotes/origin/* &&
 
 	git fetch --prune origin &&
-	git rev-parse origin/master &&
+	git rev-parse origin/main &&
 	git rev-parse origin/pr/42
 '
 
@@ -140,13 +140,13 @@ test_expect_success 'fetch --prune --tags prunes branches but not tags' '
 	cd "$D" &&
 	git clone . prune-tags &&
 	cd prune-tags &&
-	git tag sometag master &&
+	git tag sometag main &&
 	# Create what looks like a remote-tracking branch from an earlier
 	# fetch that has since been deleted from the remote:
-	git update-ref refs/remotes/origin/fake-remote master &&
+	git update-ref refs/remotes/origin/fake-remote main &&
 
 	git fetch --prune --tags origin &&
-	git rev-parse origin/master &&
+	git rev-parse origin/main &&
 	test_must_fail git rev-parse origin/fake-remote &&
 	git rev-parse sometag
 '
@@ -155,10 +155,10 @@ test_expect_success 'fetch --prune --tags with branch does not prune other thing
 	cd "$D" &&
 	git clone . prune-tags-branch &&
 	cd prune-tags-branch &&
-	git tag sometag master &&
-	git update-ref refs/remotes/origin/extrabranch master &&
+	git tag sometag main &&
+	git update-ref refs/remotes/origin/extrabranch main &&
 
-	git fetch --prune --tags origin master &&
+	git fetch --prune --tags origin main &&
 	git rev-parse origin/extrabranch &&
 	git rev-parse sometag
 '
@@ -167,9 +167,9 @@ test_expect_success 'fetch --prune --tags with refspec prunes based on refspec'
 	cd "$D" &&
 	git clone . prune-tags-refspec &&
 	cd prune-tags-refspec &&
-	git tag sometag master &&
-	git update-ref refs/remotes/origin/foo/otherbranch master &&
-	git update-ref refs/remotes/origin/extrabranch master &&
+	git tag sometag main &&
+	git update-ref refs/remotes/origin/foo/otherbranch main &&
+	git update-ref refs/remotes/origin/extrabranch main &&
 
 	git fetch --prune --tags origin refs/heads/foo/*:refs/remotes/origin/foo/* &&
 	test_must_fail git rev-parse refs/remotes/origin/foo/otherbranch &&
@@ -180,20 +180,20 @@ test_expect_success 'fetch --prune --tags with refspec prunes based on refspec'
 test_expect_success '--refmap="" ignores configured refspec' '
 	cd "$TRASH_DIRECTORY" &&
 	git clone "$D" remote-refs &&
-	git -C remote-refs rev-parse remotes/origin/master >old &&
-	git -C remote-refs update-ref refs/remotes/origin/master master~1 &&
-	git -C remote-refs rev-parse remotes/origin/master >new &&
+	git -C remote-refs rev-parse remotes/origin/main >old &&
+	git -C remote-refs update-ref refs/remotes/origin/main main~1 &&
+	git -C remote-refs rev-parse remotes/origin/main >new &&
 	git -C remote-refs fetch --refmap= origin "+refs/heads/*:refs/hidden/origin/*" &&
-	git -C remote-refs rev-parse remotes/origin/master >actual &&
+	git -C remote-refs rev-parse remotes/origin/main >actual &&
 	test_cmp new actual &&
 	git -C remote-refs fetch origin &&
-	git -C remote-refs rev-parse remotes/origin/master >actual &&
+	git -C remote-refs rev-parse remotes/origin/main >actual &&
 	test_cmp old actual
 '
 
 test_expect_success '--refmap="" and --prune' '
-	git -C remote-refs update-ref refs/remotes/origin/foo/otherbranch master &&
-	git -C remote-refs update-ref refs/hidden/foo/otherbranch master &&
+	git -C remote-refs update-ref refs/remotes/origin/foo/otherbranch main &&
+	git -C remote-refs update-ref refs/hidden/foo/otherbranch main &&
 	git -C remote-refs fetch --prune --refmap="" origin +refs/heads/*:refs/hidden/* &&
 	git -C remote-refs rev-parse remotes/origin/foo/otherbranch &&
 	test_must_fail git -C remote-refs rev-parse refs/hidden/foo/otherbranch &&
@@ -253,7 +253,7 @@ test_expect_success 'fetch uses remote ref names to describe new refs' '
 		test_i18ngrep "new tag.* -> descriptive-tag$" actual &&
 		test_i18ngrep "new ref.* -> crazy$" actual
 	) &&
-	git checkout master
+	git checkout main
 '
 
 test_expect_success 'fetch must not resolve short tag name' '
@@ -284,7 +284,7 @@ test_expect_success 'create bundle 1' '
 	cd "$D" &&
 	echo >file updated again by origin &&
 	git commit -a -m "tip" &&
-	git bundle create --version=3 bundle1 master^..master
+	git bundle create --version=3 bundle1 main^..main
 '
 
 test_expect_success 'header of bundle looks right' '
@@ -292,7 +292,7 @@ test_expect_success 'header of bundle looks right' '
 	# v3 git bundle
 	@object-format=$(test_oid algo)
 	-OID updated by origin
-	OID refs/heads/master
+	OID refs/heads/main
 
 	EOF
 	sed -e "s/$OID_REGEX/OID/g" -e "5q" "$D"/bundle1 >actual &&
@@ -301,13 +301,13 @@ test_expect_success 'header of bundle looks right' '
 
 test_expect_success 'create bundle 2' '
 	cd "$D" &&
-	git bundle create bundle2 master~2..master
+	git bundle create bundle2 main~2..main
 '
 
 test_expect_success 'unbundle 1' '
 	cd "$D/bundle" &&
 	git checkout -b some-branch &&
-	test_must_fail git fetch "$D/bundle1" master:master
+	test_must_fail git fetch "$D/bundle1" main:main
 '
 
 
@@ -320,8 +320,8 @@ test_expect_success 'bundle 1 has only 3 files ' '
 
 test_expect_success 'unbundle 2' '
 	cd "$D/bundle" &&
-	git fetch ../bundle2 master:master &&
-	test "tip" = "$(git log -1 --pretty=oneline master | cut -d" " -f2)"
+	git fetch ../bundle2 main:main &&
+	test "tip" = "$(git log -1 --pretty=oneline main | cut -d" " -f2)"
 '
 
 test_expect_success 'bundle does not prerequisite objects' '
@@ -338,14 +338,14 @@ test_expect_success 'bundle does not prerequisite objects' '
 test_expect_success 'bundle should be able to create a full history' '
 
 	cd "$D" &&
-	git tag -a -m "1.0" v1.0 master &&
+	git tag -a -m "1.0" v1.0 main &&
 	git bundle create bundle4 v1.0
 
 '
 
 test_expect_success 'fetch with a non-applying branch.<name>.merge' '
-	git config branch.master.remote yeti &&
-	git config branch.master.merge refs/heads/bigfoot &&
+	git config branch.main.remote yeti &&
+	git config branch.main.merge refs/heads/bigfoot &&
 	git config remote.blub.url one &&
 	git config remote.blub.fetch "refs/heads/*:refs/remotes/one/*" &&
 	git fetch blub
@@ -365,8 +365,8 @@ test_expect_success 'fetch from GIT URL with a non-applying branch.<name>.merge
 # the merge spec matches the branch the remote HEAD points to
 test_expect_success 'fetch from GIT URL with a non-applying branch.<name>.merge [2]' '
 	one_ref=$(cd one && git symbolic-ref HEAD) &&
-	git config branch.master.remote blub &&
-	git config branch.master.merge "$one_ref" &&
+	git config branch.main.remote blub &&
+	git config branch.main.merge "$one_ref" &&
 	git update-ref -d FETCH_HEAD &&
 	git fetch one &&
 	test $one_head = "$(git rev-parse --verify FETCH_HEAD)" &&
@@ -376,7 +376,7 @@ test_expect_success 'fetch from GIT URL with a non-applying branch.<name>.merge
 # URL supplied to fetch matches the url of the configured branch's remote, but
 # the merge spec does not match the branch the remote HEAD points to
 test_expect_success 'fetch from GIT URL with a non-applying branch.<name>.merge [3]' '
-	git config branch.master.merge "${one_ref}_not" &&
+	git config branch.main.merge "${one_ref}_not" &&
 	git update-ref -d FETCH_HEAD &&
 	git fetch one &&
 	test $one_head = "$(git rev-parse --verify FETCH_HEAD)" &&
@@ -392,9 +392,9 @@ test_expect_success 'quoting of a strangely named repo' '
 test_expect_success 'bundle should record HEAD correctly' '
 
 	cd "$D" &&
-	git bundle create bundle5 HEAD master &&
+	git bundle create bundle5 HEAD main &&
 	git bundle list-heads bundle5 >actual &&
-	for h in HEAD refs/heads/master
+	for h in HEAD refs/heads/main
 	do
 		echo "$(git rev-parse --verify $h) $h"
 	done >expect &&
@@ -402,10 +402,10 @@ test_expect_success 'bundle should record HEAD correctly' '
 
 '
 
-test_expect_success 'mark initial state of origin/master' '
+test_expect_success 'mark initial state of origin/main' '
 	(
 		cd three &&
-		git tag base-origin-master refs/remotes/origin/master
+		git tag base-origin-main refs/remotes/origin/main
 	)
 '
 
@@ -415,10 +415,10 @@ test_expect_success 'explicit fetch should update tracking' '
 	git branch -f side &&
 	(
 		cd three &&
-		git update-ref refs/remotes/origin/master base-origin-master &&
-		o=$(git rev-parse --verify refs/remotes/origin/master) &&
-		git fetch origin master &&
-		n=$(git rev-parse --verify refs/remotes/origin/master) &&
+		git update-ref refs/remotes/origin/main base-origin-main &&
+		o=$(git rev-parse --verify refs/remotes/origin/main) &&
+		git fetch origin main &&
+		n=$(git rev-parse --verify refs/remotes/origin/main) &&
 		test "$o" != "$n" &&
 		test_must_fail git rev-parse --verify refs/remotes/origin/side
 	)
@@ -430,10 +430,10 @@ test_expect_success 'explicit pull should update tracking' '
 	git branch -f side &&
 	(
 		cd three &&
-		git update-ref refs/remotes/origin/master base-origin-master &&
-		o=$(git rev-parse --verify refs/remotes/origin/master) &&
-		git pull origin master &&
-		n=$(git rev-parse --verify refs/remotes/origin/master) &&
+		git update-ref refs/remotes/origin/main base-origin-main &&
+		o=$(git rev-parse --verify refs/remotes/origin/main) &&
+		git pull origin main &&
+		n=$(git rev-parse --verify refs/remotes/origin/main) &&
 		test "$o" != "$n" &&
 		test_must_fail git rev-parse --verify refs/remotes/origin/side
 	)
@@ -452,13 +452,13 @@ test_expect_success 'explicit --refmap option overrides remote.*.fetch' '
 	git branch -f side &&
 	(
 		cd three &&
-		git update-ref refs/remotes/origin/master base-origin-master &&
-		o=$(git rev-parse --verify refs/remotes/origin/master) &&
-		git fetch --refmap="refs/heads/*:refs/remotes/other/*" origin master &&
-		n=$(git rev-parse --verify refs/remotes/origin/master) &&
+		git update-ref refs/remotes/origin/main base-origin-main &&
+		o=$(git rev-parse --verify refs/remotes/origin/main) &&
+		git fetch --refmap="refs/heads/*:refs/remotes/other/*" origin main &&
+		n=$(git rev-parse --verify refs/remotes/origin/main) &&
 		test "$o" = "$n" &&
 		test_must_fail git rev-parse --verify refs/remotes/origin/side &&
-		git rev-parse --verify refs/remotes/other/master
+		git rev-parse --verify refs/remotes/other/main
 	)
 '
 
@@ -467,10 +467,10 @@ test_expect_success 'explicitly empty --refmap option disables remote.*.fetch' '
 	git branch -f side &&
 	(
 		cd three &&
-		git update-ref refs/remotes/origin/master base-origin-master &&
-		o=$(git rev-parse --verify refs/remotes/origin/master) &&
-		git fetch --refmap="" origin master &&
-		n=$(git rev-parse --verify refs/remotes/origin/master) &&
+		git update-ref refs/remotes/origin/main base-origin-main &&
+		o=$(git rev-parse --verify refs/remotes/origin/main) &&
+		git fetch --refmap="" origin main &&
+		n=$(git rev-parse --verify refs/remotes/origin/main) &&
 		test "$o" = "$n" &&
 		test_must_fail git rev-parse --verify refs/remotes/origin/side
 	)
@@ -482,10 +482,10 @@ test_expect_success 'configured fetch updates tracking' '
 	git branch -f side &&
 	(
 		cd three &&
-		git update-ref refs/remotes/origin/master base-origin-master &&
-		o=$(git rev-parse --verify refs/remotes/origin/master) &&
+		git update-ref refs/remotes/origin/main base-origin-main &&
+		o=$(git rev-parse --verify refs/remotes/origin/main) &&
 		git fetch origin &&
-		n=$(git rev-parse --verify refs/remotes/origin/master) &&
+		n=$(git rev-parse --verify refs/remotes/origin/main) &&
 		test "$o" != "$n" &&
 		git rev-parse --verify refs/remotes/origin/side
 	)
@@ -496,12 +496,12 @@ test_expect_success 'non-matching refspecs do not confuse tracking update' '
 	git update-ref refs/odd/location HEAD &&
 	(
 		cd three &&
-		git update-ref refs/remotes/origin/master base-origin-master &&
+		git update-ref refs/remotes/origin/main base-origin-main &&
 		git config --add remote.origin.fetch \
 			refs/odd/location:refs/remotes/origin/odd &&
-		o=$(git rev-parse --verify refs/remotes/origin/master) &&
-		git fetch origin master &&
-		n=$(git rev-parse --verify refs/remotes/origin/master) &&
+		o=$(git rev-parse --verify refs/remotes/origin/main) &&
+		git fetch origin main &&
+		n=$(git rev-parse --verify refs/remotes/origin/main) &&
 		test "$o" != "$n" &&
 		test_must_fail git rev-parse --verify refs/remotes/origin/odd
 	)
@@ -527,7 +527,7 @@ test_expect_success 'auto tag following fetches minimum' '
 			git tag -a -m $i excess-$i || exit 1
 		done
 	) &&
-	git checkout master &&
+	git checkout main &&
 	(
 		cd follow &&
 		git fetch
@@ -536,13 +536,13 @@ test_expect_success 'auto tag following fetches minimum' '
 
 test_expect_success 'refuse to fetch into the current branch' '
 
-	test_must_fail git fetch . side:master
+	test_must_fail git fetch . side:main
 
 '
 
 test_expect_success 'fetch into the current branch with --update-head-ok' '
 
-	git fetch --update-head-ok . side:master
+	git fetch --update-head-ok . side:main
 
 '
 
@@ -571,7 +571,7 @@ test_expect_success "should be able to fetch with duplicate refspecs" '
 	(
 		cd dups &&
 		git init &&
-		git config branch.master.remote three &&
+		git config branch.main.remote three &&
 		git config remote.three.url ../three/.git &&
 		git config remote.three.fetch +refs/heads/*:refs/remotes/origin/* &&
 		git config --add remote.three.fetch +refs/heads/*:refs/remotes/origin/* &&
@@ -880,11 +880,11 @@ test_expect_success 'all boundary commits are excluded' '
 	test_commit oneside &&
 	git checkout HEAD^ &&
 	test_commit otherside &&
-	git checkout master &&
+	git checkout main &&
 	test_tick &&
 	git merge otherside &&
 	ad=$(git log --no-walk --format=%ad HEAD) &&
-	git bundle create twoside-boundary.bdl master --since="$ad" &&
+	git bundle create twoside-boundary.bdl main --since="$ad" &&
 	convert_bundle_to_pack <twoside-boundary.bdl >twoside-boundary.pack &&
 	pack=$(git index-pack --fix-thin --stdin <twoside-boundary.pack) &&
 	test_bundle_object_count .git/objects/pack/pack-${pack##pack	}.pack 3
@@ -1020,7 +1020,7 @@ setup_negotiation_tip () {
 	fi &&
 
 	test_commit -C "$SERVER" beta_s &&
-	git -C "$SERVER" checkout master &&
+	git -C "$SERVER" checkout main &&
 	test_commit -C "$SERVER" alpha_s &&
 	git -C "$SERVER" tag -d alpha_1 alpha_2 beta_1 beta_2
 }
diff --git a/t/t5511-refspec.sh b/t/t5511-refspec.sh
index f541f30bc2..847a9d4c27 100755
--- a/t/t5511-refspec.sh
+++ b/t/t5511-refspec.sh
@@ -33,7 +33,7 @@ test_refspec fetch '::'						invalid
 test_refspec push 'refs/heads/*:refs/remotes/frotz/*'
 test_refspec push 'refs/heads/*:refs/remotes/frotz'		invalid
 test_refspec push 'refs/heads:refs/remotes/frotz/*'		invalid
-test_refspec push 'refs/heads/master:refs/remotes/frotz/xyzzy'
+test_refspec push 'refs/heads/main:refs/remotes/frotz/xyzzy'
 
 
 # These have invalid LHS, but we do not have a formal "valid sha-1
@@ -41,18 +41,18 @@ test_refspec push 'refs/heads/master:refs/remotes/frotz/xyzzy'
 # code.  They will be caught downstream anyway, but we may want to
 # have tighter check later...
 
-: test_refspec push 'refs/heads/master::refs/remotes/frotz/xyzzy'	invalid
+: test_refspec push 'refs/heads/main::refs/remotes/frotz/xyzzy'	invalid
 : test_refspec push 'refs/heads/maste :refs/remotes/frotz/xyzzy'	invalid
 
 test_refspec fetch 'refs/heads/*:refs/remotes/frotz/*'
 test_refspec fetch 'refs/heads/*:refs/remotes/frotz'		invalid
 test_refspec fetch 'refs/heads:refs/remotes/frotz/*'		invalid
-test_refspec fetch 'refs/heads/master:refs/remotes/frotz/xyzzy'
-test_refspec fetch 'refs/heads/master::refs/remotes/frotz/xyzzy'	invalid
+test_refspec fetch 'refs/heads/main:refs/remotes/frotz/xyzzy'
+test_refspec fetch 'refs/heads/main::refs/remotes/frotz/xyzzy'	invalid
 test_refspec fetch 'refs/heads/maste :refs/remotes/frotz/xyzzy'	invalid
 
-test_refspec push 'master~1:refs/remotes/frotz/backup'
-test_refspec fetch 'master~1:refs/remotes/frotz/backup'		invalid
+test_refspec push 'main~1:refs/remotes/frotz/backup'
+test_refspec fetch 'main~1:refs/remotes/frotz/backup'		invalid
 test_refspec push 'HEAD~4:refs/remotes/frotz/new'
 test_refspec fetch 'HEAD~4:refs/remotes/frotz/new'		invalid
 
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index a892807de2..4a568a2398 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -2,7 +2,7 @@
 
 test_description='git ls-remote'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -121,7 +121,7 @@ test_expect_success 'use branch.<name>.remote if possible' '
 	echo "From $URL" >exp_err &&
 
 	git remote add other $URL &&
-	git config branch.master.remote other &&
+	git config branch.main.remote other &&
 
 	git ls-remote 2>actual_err >actual &&
 	test_cmp exp_err actual_err &&
@@ -132,9 +132,9 @@ test_expect_success 'confuses pattern as remote when no remote specified' '
 	if test_have_prereq MINGW
 	then
 		# Windows does not like asterisks in pathname
-		does_not_exist=master
+		does_not_exist=main
 	else
-		does_not_exist="refs*master"
+		does_not_exist="refs*main"
 	fi &&
 	cat >exp <<-EOF &&
 	fatal: '\''$does_not_exist'\'' does not appear to be a git repository
@@ -147,7 +147,7 @@ test_expect_success 'confuses pattern as remote when no remote specified' '
 	# Do not expect "git ls-remote <pattern>" to work; ls-remote needs
 	# <remote> if you want to feed <pattern>, just like you cannot say
 	# fetch <branch>.
-	# We could just as easily have used "master"; the "*" emphasizes its
+	# We could just as easily have used "main"; the "*" emphasizes its
 	# role as a pattern.
 	test_must_fail git ls-remote "$does_not_exist" >actual 2>&1 &&
 	test_i18ncmp exp actual
@@ -220,14 +220,14 @@ test_expect_success 'protocol v2 supports hiderefs' '
 
 test_expect_success 'ls-remote --symref' '
 	git fetch origin &&
-	echo "ref: refs/heads/master	HEAD" >expect &&
+	echo "ref: refs/heads/main	HEAD" >expect &&
 	generate_references \
 		HEAD \
-		refs/heads/master >>expect &&
+		refs/heads/main >>expect &&
 	oid=$(git rev-parse HEAD) &&
 	echo "$oid	refs/remotes/origin/HEAD" >>expect &&
 	generate_references \
-		refs/remotes/origin/master \
+		refs/remotes/origin/main \
 		refs/tags/mark \
 		refs/tags/mark1.1 \
 		refs/tags/mark1.10 \
@@ -241,7 +241,7 @@ test_expect_success 'ls-remote --symref' '
 test_expect_success 'ls-remote with filtered symref (refname)' '
 	rev=$(git rev-parse HEAD) &&
 	cat >expect <<-EOF &&
-	ref: refs/heads/master	HEAD
+	ref: refs/heads/main	HEAD
 	$rev	HEAD
 	EOF
 	# Protocol v2 supports sending symrefs for refs other than HEAD, so use
@@ -255,7 +255,7 @@ test_expect_failure 'ls-remote with filtered symref (--heads)' '
 	cat >expect <<-EOF &&
 	ref: refs/tags/mark	refs/heads/foo
 	$rev	refs/heads/foo
-	$rev	refs/heads/master
+	$rev	refs/heads/main
 	EOF
 	# Protocol v2 supports sending symrefs for refs other than HEAD, so use
 	# protocol v0 here.
@@ -266,7 +266,7 @@ test_expect_failure 'ls-remote with filtered symref (--heads)' '
 test_expect_success 'ls-remote --symref omits filtered-out matches' '
 	cat >expect <<-EOF &&
 	$rev	refs/heads/foo
-	$rev	refs/heads/master
+	$rev	refs/heads/main
 	EOF
 	# Protocol v2 supports sending symrefs for refs other than HEAD, so use
 	# protocol v0 here.
@@ -333,10 +333,10 @@ test_expect_success 'ls-remote --sort fails gracefully outside repository' '
 
 test_expect_success 'ls-remote patterns work with all protocol versions' '
 	git for-each-ref --format="%(objectname)	%(refname)" \
-		refs/heads/master refs/remotes/origin/master >expect &&
-	git -c protocol.version=1 ls-remote . master >actual.v1 &&
+		refs/heads/main refs/remotes/origin/main >expect &&
+	git -c protocol.version=1 ls-remote . main >actual.v1 &&
 	test_cmp expect actual.v1 &&
-	git -c protocol.version=2 ls-remote . master >actual.v2 &&
+	git -c protocol.version=2 ls-remote . main >actual.v2 &&
 	test_cmp expect actual.v2
 '
 
diff --git a/t/t5514-fetch-multiple.sh b/t/t5514-fetch-multiple.sh
index f12a83f82b..511ba3bd45 100755
--- a/t/t5514-fetch-multiple.sh
+++ b/t/t5514-fetch-multiple.sh
@@ -2,7 +2,7 @@
 
 test_description='fetch --all works correctly'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -20,7 +20,7 @@ setup_repository () {
 	git add elif &&
 	test_tick &&
 	git commit -m "Second" &&
-	git checkout master
+	git checkout main
 	)
 }
 
@@ -35,16 +35,16 @@ test_expect_success setup '
 '
 
 cat > test/expect << EOF
-  one/master
+  one/main
   one/side
-  origin/HEAD -> origin/master
-  origin/master
+  origin/HEAD -> origin/main
+  origin/main
   origin/side
   three/another
-  three/master
+  three/main
   three/side
   two/another
-  two/master
+  two/main
   two/side
 EOF
 
@@ -73,15 +73,15 @@ test_expect_success 'git fetch --all should continue if a remote has errors' '
 test_expect_success 'git fetch --all does not allow non-option arguments' '
 	(cd test &&
 	 test_must_fail git fetch --all origin &&
-	 test_must_fail git fetch --all origin master)
+	 test_must_fail git fetch --all origin main)
 '
 
 cat > expect << EOF
-  origin/HEAD -> origin/master
-  origin/master
+  origin/HEAD -> origin/main
+  origin/main
   origin/side
   three/another
-  three/master
+  three/main
   three/side
 EOF
 
@@ -95,10 +95,10 @@ test_expect_success 'git fetch --multiple (but only one remote)' '
 '
 
 cat > expect << EOF
-  one/master
+  one/main
   one/side
   two/another
-  two/master
+  two/main
   two/side
 EOF
 
@@ -136,13 +136,13 @@ test_expect_success 'git fetch --all (skipFetchAll)' '
 '
 
 cat > expect << EOF
-  one/master
+  one/main
   one/side
   three/another
-  three/master
+  three/main
   three/side
   two/another
-  two/master
+  two/main
   two/side
 EOF
 
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 7003467523..b037439c49 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -14,7 +14,7 @@ This test checks the following functionality:
 * reflogs
 '
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -123,13 +123,13 @@ test_expect_success setup '
 	git add path1 &&
 	test_tick &&
 	git commit -a -m repo &&
-	the_first_commit=$(git show-ref -s --verify refs/heads/master) &&
+	the_first_commit=$(git show-ref -s --verify refs/heads/main) &&
 
 	>path2 &&
 	git add path2 &&
 	test_tick &&
 	git commit -a -m second &&
-	the_commit=$(git show-ref -s --verify refs/heads/master)
+	the_commit=$(git show-ref -s --verify refs/heads/main)
 
 '
 
@@ -137,9 +137,9 @@ test_expect_success 'fetch without wildcard' '
 	mk_empty testrepo &&
 	(
 		cd testrepo &&
-		git fetch .. refs/heads/master:refs/remotes/origin/master &&
+		git fetch .. refs/heads/main:refs/remotes/origin/main &&
 
-		echo "$the_commit commit	refs/remotes/origin/master" >expect &&
+		echo "$the_commit commit	refs/remotes/origin/main" >expect &&
 		git for-each-ref refs/remotes/origin >actual &&
 		test_cmp expect actual
 	)
@@ -153,7 +153,7 @@ test_expect_success 'fetch with wildcard' '
 		git config remote.up.fetch "refs/heads/*:refs/remotes/origin/*" &&
 		git fetch up &&
 
-		echo "$the_commit commit	refs/remotes/origin/master" >expect &&
+		echo "$the_commit commit	refs/remotes/origin/main" >expect &&
 		git for-each-ref refs/remotes/origin >actual &&
 		test_cmp expect actual
 	)
@@ -169,7 +169,7 @@ test_expect_success 'fetch with insteadOf' '
 		git config remote.up.fetch "refs/heads/*:refs/remotes/origin/*" &&
 		git fetch up &&
 
-		echo "$the_commit commit	refs/remotes/origin/master" >expect &&
+		echo "$the_commit commit	refs/remotes/origin/main" >expect &&
 		git for-each-ref refs/remotes/origin >actual &&
 		test_cmp expect actual
 	)
@@ -185,7 +185,7 @@ test_expect_success 'fetch with pushInsteadOf (should not rewrite)' '
 		git config remote.up.fetch "refs/heads/*:refs/remotes/origin/*" &&
 		git fetch up &&
 
-		echo "$the_commit commit	refs/remotes/origin/master" >expect &&
+		echo "$the_commit commit	refs/remotes/origin/main" >expect &&
 		git for-each-ref refs/remotes/origin >actual &&
 		test_cmp expect actual
 	)
@@ -194,10 +194,10 @@ test_expect_success 'fetch with pushInsteadOf (should not rewrite)' '
 test_expect_success 'push without wildcard' '
 	mk_empty testrepo &&
 
-	git push testrepo refs/heads/master:refs/remotes/origin/master &&
+	git push testrepo refs/heads/main:refs/remotes/origin/main &&
 	(
 		cd testrepo &&
-		echo "$the_commit commit	refs/remotes/origin/master" >expect &&
+		echo "$the_commit commit	refs/remotes/origin/main" >expect &&
 		git for-each-ref refs/remotes/origin >actual &&
 		test_cmp expect actual
 	)
@@ -209,7 +209,7 @@ test_expect_success 'push with wildcard' '
 	git push testrepo "refs/heads/*:refs/remotes/origin/*" &&
 	(
 		cd testrepo &&
-		echo "$the_commit commit	refs/remotes/origin/master" >expect &&
+		echo "$the_commit commit	refs/remotes/origin/main" >expect &&
 		git for-each-ref refs/remotes/origin >actual &&
 		test_cmp expect actual
 	)
@@ -219,10 +219,10 @@ test_expect_success 'push with insteadOf' '
 	mk_empty testrepo &&
 	TRASH="$(pwd)/" &&
 	test_config "url.$TRASH.insteadOf" trash/ &&
-	git push trash/testrepo refs/heads/master:refs/remotes/origin/master &&
+	git push trash/testrepo refs/heads/main:refs/remotes/origin/main &&
 	(
 		cd testrepo &&
-		echo "$the_commit commit	refs/remotes/origin/master" >expect &&
+		echo "$the_commit commit	refs/remotes/origin/main" >expect &&
 		git for-each-ref refs/remotes/origin >actual &&
 		test_cmp expect actual
 	)
@@ -232,10 +232,10 @@ test_expect_success 'push with pushInsteadOf' '
 	mk_empty testrepo &&
 	TRASH="$(pwd)/" &&
 	test_config "url.$TRASH.pushInsteadOf" trash/ &&
-	git push trash/testrepo refs/heads/master:refs/remotes/origin/master &&
+	git push trash/testrepo refs/heads/main:refs/remotes/origin/main &&
 	(
 		cd testrepo &&
-		echo "$the_commit commit	refs/remotes/origin/master" >expect &&
+		echo "$the_commit commit	refs/remotes/origin/main" >expect &&
 		git for-each-ref refs/remotes/origin >actual &&
 		test_cmp expect actual
 	)
@@ -247,10 +247,10 @@ test_expect_success 'push with pushInsteadOf and explicit pushurl (pushInsteadOf
 	test_config "url.trash3/.pushInsteadOf" trash/wrong &&
 	test_config remote.r.url trash/wrong &&
 	test_config remote.r.pushurl "testrepo/" &&
-	git push r refs/heads/master:refs/remotes/origin/master &&
+	git push r refs/heads/main:refs/remotes/origin/main &&
 	(
 		cd testrepo &&
-		echo "$the_commit commit	refs/remotes/origin/master" >expect &&
+		echo "$the_commit commit	refs/remotes/origin/main" >expect &&
 		git for-each-ref refs/remotes/origin >actual &&
 		test_cmp expect actual
 	)
@@ -258,101 +258,101 @@ test_expect_success 'push with pushInsteadOf and explicit pushurl (pushInsteadOf
 
 test_expect_success 'push with matching heads' '
 
-	mk_test testrepo heads/master &&
+	mk_test testrepo heads/main &&
 	git push testrepo : &&
-	check_push_result testrepo $the_commit heads/master
+	check_push_result testrepo $the_commit heads/main
 
 '
 
 test_expect_success 'push with matching heads on the command line' '
 
-	mk_test testrepo heads/master &&
+	mk_test testrepo heads/main &&
 	git push testrepo : &&
-	check_push_result testrepo $the_commit heads/master
+	check_push_result testrepo $the_commit heads/main
 
 '
 
 test_expect_success 'failed (non-fast-forward) push with matching heads' '
 
-	mk_test testrepo heads/master &&
+	mk_test testrepo heads/main &&
 	git push testrepo : &&
 	git commit --amend -massaged &&
 	test_must_fail git push testrepo &&
-	check_push_result testrepo $the_commit heads/master &&
+	check_push_result testrepo $the_commit heads/main &&
 	git reset --hard $the_commit
 
 '
 
 test_expect_success 'push --force with matching heads' '
 
-	mk_test testrepo heads/master &&
+	mk_test testrepo heads/main &&
 	git push testrepo : &&
 	git commit --amend -massaged &&
 	git push --force testrepo : &&
-	! check_push_result testrepo $the_commit heads/master &&
+	! check_push_result testrepo $the_commit heads/main &&
 	git reset --hard $the_commit
 
 '
 
 test_expect_success 'push with matching heads and forced update' '
 
-	mk_test testrepo heads/master &&
+	mk_test testrepo heads/main &&
 	git push testrepo : &&
 	git commit --amend -massaged &&
 	git push testrepo +: &&
-	! check_push_result testrepo $the_commit heads/master &&
+	! check_push_result testrepo $the_commit heads/main &&
 	git reset --hard $the_commit
 
 '
 
 test_expect_success 'push with no ambiguity (1)' '
 
-	mk_test testrepo heads/master &&
-	git push testrepo master:master &&
-	check_push_result testrepo $the_commit heads/master
+	mk_test testrepo heads/main &&
+	git push testrepo main:main &&
+	check_push_result testrepo $the_commit heads/main
 
 '
 
 test_expect_success 'push with no ambiguity (2)' '
 
-	mk_test testrepo remotes/origin/master &&
-	git push testrepo master:origin/master &&
-	check_push_result testrepo $the_commit remotes/origin/master
+	mk_test testrepo remotes/origin/main &&
+	git push testrepo main:origin/main &&
+	check_push_result testrepo $the_commit remotes/origin/main
 
 '
 
 test_expect_success 'push with colon-less refspec, no ambiguity' '
 
-	mk_test testrepo heads/master heads/t/master &&
-	git branch -f t/master master &&
-	git push testrepo master &&
-	check_push_result testrepo $the_commit heads/master &&
-	check_push_result testrepo $the_first_commit heads/t/master
+	mk_test testrepo heads/main heads/t/main &&
+	git branch -f t/main main &&
+	git push testrepo main &&
+	check_push_result testrepo $the_commit heads/main &&
+	check_push_result testrepo $the_first_commit heads/t/main
 
 '
 
 test_expect_success 'push with weak ambiguity (1)' '
 
-	mk_test testrepo heads/master remotes/origin/master &&
-	git push testrepo master:master &&
-	check_push_result testrepo $the_commit heads/master &&
-	check_push_result testrepo $the_first_commit remotes/origin/master
+	mk_test testrepo heads/main remotes/origin/main &&
+	git push testrepo main:main &&
+	check_push_result testrepo $the_commit heads/main &&
+	check_push_result testrepo $the_first_commit remotes/origin/main
 
 '
 
 test_expect_success 'push with weak ambiguity (2)' '
 
-	mk_test testrepo heads/master remotes/origin/master remotes/another/master &&
-	git push testrepo master:master &&
-	check_push_result testrepo $the_commit heads/master &&
-	check_push_result testrepo $the_first_commit remotes/origin/master remotes/another/master
+	mk_test testrepo heads/main remotes/origin/main remotes/another/main &&
+	git push testrepo main:main &&
+	check_push_result testrepo $the_commit heads/main &&
+	check_push_result testrepo $the_first_commit remotes/origin/main remotes/another/main
 
 '
 
 test_expect_success 'push with ambiguity' '
 
 	mk_test testrepo heads/frotz tags/frotz &&
-	test_must_fail git push testrepo master:frotz &&
+	test_must_fail git push testrepo main:frotz &&
 	check_push_result testrepo $the_first_commit heads/frotz tags/frotz
 
 '
@@ -360,7 +360,7 @@ test_expect_success 'push with ambiguity' '
 test_expect_success 'push with colon-less refspec (1)' '
 
 	mk_test testrepo heads/frotz tags/frotz &&
-	git branch -f frotz master &&
+	git branch -f frotz main &&
 	git push testrepo frotz &&
 	check_push_result testrepo $the_commit heads/frotz &&
 	check_push_result testrepo $the_first_commit tags/frotz
@@ -388,7 +388,7 @@ test_expect_success 'push with colon-less refspec (3)' '
 	then
 		git tag -d frotz
 	fi &&
-	git branch -f frotz master &&
+	git branch -f frotz main &&
 	git push testrepo frotz &&
 	check_push_result testrepo $the_commit heads/frotz &&
 	test 1 = $( cd testrepo && git show-ref | wc -l )
@@ -411,7 +411,7 @@ test_expect_success 'push with colon-less refspec (4)' '
 test_expect_success 'push head with non-existent, incomplete dest' '
 
 	mk_test testrepo &&
-	git push testrepo master:branch &&
+	git push testrepo main:branch &&
 	check_push_result testrepo $the_commit heads/branch
 
 '
@@ -428,42 +428,42 @@ test_expect_success 'push tag with non-existent, incomplete dest' '
 test_expect_success 'push sha1 with non-existent, incomplete dest' '
 
 	mk_test testrepo &&
-	test_must_fail git push testrepo $(git rev-parse master):foo
+	test_must_fail git push testrepo $(git rev-parse main):foo
 
 '
 
 test_expect_success 'push ref expression with non-existent, incomplete dest' '
 
 	mk_test testrepo &&
-	test_must_fail git push testrepo master^:branch
+	test_must_fail git push testrepo main^:branch
 
 '
 
 test_expect_success 'push with HEAD' '
 
-	mk_test testrepo heads/master &&
-	git checkout master &&
+	mk_test testrepo heads/main &&
+	git checkout main &&
 	git push testrepo HEAD &&
-	check_push_result testrepo $the_commit heads/master
+	check_push_result testrepo $the_commit heads/main
 
 '
 
 test_expect_success 'push with HEAD nonexisting at remote' '
 
-	mk_test testrepo heads/master &&
-	git checkout -b local master &&
+	mk_test testrepo heads/main &&
+	git checkout -b local main &&
 	git push testrepo HEAD &&
 	check_push_result testrepo $the_commit heads/local
 '
 
 test_expect_success 'push with +HEAD' '
 
-	mk_test testrepo heads/master &&
-	git checkout master &&
+	mk_test testrepo heads/main &&
+	git checkout main &&
 	git branch -D local &&
 	git checkout -b local &&
-	git push testrepo master local &&
-	check_push_result testrepo $the_commit heads/master &&
+	git push testrepo main local &&
+	check_push_result testrepo $the_commit heads/main &&
 	check_push_result testrepo $the_commit heads/local &&
 
 	# Without force rewinding should fail
@@ -480,7 +480,7 @@ test_expect_success 'push with +HEAD' '
 test_expect_success 'push HEAD with non-existent, incomplete dest' '
 
 	mk_test testrepo &&
-	git checkout master &&
+	git checkout main &&
 	git push testrepo HEAD:branch &&
 	check_push_result testrepo $the_commit heads/branch
 
@@ -489,7 +489,7 @@ test_expect_success 'push HEAD with non-existent, incomplete dest' '
 test_expect_success 'push with config remote.*.push = HEAD' '
 
 	mk_test testrepo heads/local &&
-	git checkout master &&
+	git checkout main &&
 	git branch -f local $the_commit &&
 	(
 		cd testrepo &&
@@ -498,166 +498,166 @@ test_expect_success 'push with config remote.*.push = HEAD' '
 	) &&
 	test_config remote.there.url testrepo &&
 	test_config remote.there.push HEAD &&
-	test_config branch.master.remote there &&
+	test_config branch.main.remote there &&
 	git push &&
-	check_push_result testrepo $the_commit heads/master &&
+	check_push_result testrepo $the_commit heads/main &&
 	check_push_result testrepo $the_first_commit heads/local
 '
 
 test_expect_success 'push with remote.pushdefault' '
-	mk_test up_repo heads/master &&
-	mk_test down_repo heads/master &&
+	mk_test up_repo heads/main &&
+	mk_test down_repo heads/main &&
 	test_config remote.up.url up_repo &&
 	test_config remote.down.url down_repo &&
-	test_config branch.master.remote up &&
+	test_config branch.main.remote up &&
 	test_config remote.pushdefault down &&
 	test_config push.default matching &&
 	git push &&
-	check_push_result up_repo $the_first_commit heads/master &&
-	check_push_result down_repo $the_commit heads/master
+	check_push_result up_repo $the_first_commit heads/main &&
+	check_push_result down_repo $the_commit heads/main
 '
 
 test_expect_success 'push with config remote.*.pushurl' '
 
-	mk_test testrepo heads/master &&
-	git checkout master &&
+	mk_test testrepo heads/main &&
+	git checkout main &&
 	test_config remote.there.url test2repo &&
 	test_config remote.there.pushurl testrepo &&
 	git push there : &&
-	check_push_result testrepo $the_commit heads/master
+	check_push_result testrepo $the_commit heads/main
 '
 
 test_expect_success 'push with config branch.*.pushremote' '
-	mk_test up_repo heads/master &&
-	mk_test side_repo heads/master &&
-	mk_test down_repo heads/master &&
+	mk_test up_repo heads/main &&
+	mk_test side_repo heads/main &&
+	mk_test down_repo heads/main &&
 	test_config remote.up.url up_repo &&
 	test_config remote.pushdefault side_repo &&
 	test_config remote.down.url down_repo &&
-	test_config branch.master.remote up &&
-	test_config branch.master.pushremote down &&
+	test_config branch.main.remote up &&
+	test_config branch.main.pushremote down &&
 	test_config push.default matching &&
 	git push &&
-	check_push_result up_repo $the_first_commit heads/master &&
-	check_push_result side_repo $the_first_commit heads/master &&
-	check_push_result down_repo $the_commit heads/master
+	check_push_result up_repo $the_first_commit heads/main &&
+	check_push_result side_repo $the_first_commit heads/main &&
+	check_push_result down_repo $the_commit heads/main
 '
 
 test_expect_success 'branch.*.pushremote config order is irrelevant' '
-	mk_test one_repo heads/master &&
-	mk_test two_repo heads/master &&
+	mk_test one_repo heads/main &&
+	mk_test two_repo heads/main &&
 	test_config remote.one.url one_repo &&
 	test_config remote.two.url two_repo &&
-	test_config branch.master.pushremote two_repo &&
+	test_config branch.main.pushremote two_repo &&
 	test_config remote.pushdefault one_repo &&
 	test_config push.default matching &&
 	git push &&
-	check_push_result one_repo $the_first_commit heads/master &&
-	check_push_result two_repo $the_commit heads/master
+	check_push_result one_repo $the_first_commit heads/main &&
+	check_push_result two_repo $the_commit heads/main
 '
 
 test_expect_success 'push with dry-run' '
 
-	mk_test testrepo heads/master &&
-	old_commit=$(git -C testrepo show-ref -s --verify refs/heads/master) &&
+	mk_test testrepo heads/main &&
+	old_commit=$(git -C testrepo show-ref -s --verify refs/heads/main) &&
 	git push --dry-run testrepo : &&
-	check_push_result testrepo $old_commit heads/master
+	check_push_result testrepo $old_commit heads/main
 '
 
 test_expect_success 'push updates local refs' '
 
-	mk_test testrepo heads/master &&
+	mk_test testrepo heads/main &&
 	mk_child testrepo child &&
 	(
 		cd child &&
-		git pull .. master &&
+		git pull .. main &&
 		git push &&
-		test $(git rev-parse master) = \
-			$(git rev-parse remotes/origin/master)
+		test $(git rev-parse main) = \
+			$(git rev-parse remotes/origin/main)
 	)
 
 '
 
 test_expect_success 'push updates up-to-date local refs' '
 
-	mk_test testrepo heads/master &&
+	mk_test testrepo heads/main &&
 	mk_child testrepo child1 &&
 	mk_child testrepo child2 &&
-	(cd child1 && git pull .. master && git push) &&
+	(cd child1 && git pull .. main && git push) &&
 	(
 		cd child2 &&
-		git pull ../child1 master &&
+		git pull ../child1 main &&
 		git push &&
-		test $(git rev-parse master) = \
-			$(git rev-parse remotes/origin/master)
+		test $(git rev-parse main) = \
+			$(git rev-parse remotes/origin/main)
 	)
 
 '
 
 test_expect_success 'push preserves up-to-date packed refs' '
 
-	mk_test testrepo heads/master &&
+	mk_test testrepo heads/main &&
 	mk_child testrepo child &&
 	(
 		cd child &&
 		git push &&
-		! test -f .git/refs/remotes/origin/master
+		! test -f .git/refs/remotes/origin/main
 	)
 
 '
 
 test_expect_success 'push does not update local refs on failure' '
 
-	mk_test testrepo heads/master &&
+	mk_test testrepo heads/main &&
 	mk_child testrepo child &&
 	mkdir testrepo/.git/hooks &&
 	echo "#!/no/frobnication/today" >testrepo/.git/hooks/pre-receive &&
 	chmod +x testrepo/.git/hooks/pre-receive &&
 	(
 		cd child &&
-		git pull .. master &&
+		git pull .. main &&
 		test_must_fail git push &&
-		test $(git rev-parse master) != \
-			$(git rev-parse remotes/origin/master)
+		test $(git rev-parse main) != \
+			$(git rev-parse remotes/origin/main)
 	)
 
 '
 
 test_expect_success 'allow deleting an invalid remote ref' '
 
-	mk_test testrepo heads/master &&
+	mk_test testrepo heads/main &&
 	rm -f testrepo/.git/objects/??/* &&
-	git push testrepo :refs/heads/master &&
-	(cd testrepo && test_must_fail git rev-parse --verify refs/heads/master)
+	git push testrepo :refs/heads/main &&
+	(cd testrepo && test_must_fail git rev-parse --verify refs/heads/main)
 
 '
 
 test_expect_success 'pushing valid refs triggers post-receive and post-update hooks' '
-	mk_test_with_hooks testrepo heads/master heads/next &&
-	orgmaster=$(cd testrepo && git show-ref -s --verify refs/heads/master) &&
-	newmaster=$(git show-ref -s --verify refs/heads/master) &&
+	mk_test_with_hooks testrepo heads/main heads/next &&
+	orgmain=$(cd testrepo && git show-ref -s --verify refs/heads/main) &&
+	newmain=$(git show-ref -s --verify refs/heads/main) &&
 	orgnext=$(cd testrepo && git show-ref -s --verify refs/heads/next) &&
 	newnext=$ZERO_OID &&
-	git push testrepo refs/heads/master:refs/heads/master :refs/heads/next &&
+	git push testrepo refs/heads/main:refs/heads/main :refs/heads/next &&
 	(
 		cd testrepo/.git &&
 		cat >pre-receive.expect <<-EOF &&
-		$orgmaster $newmaster refs/heads/master
+		$orgmain $newmain refs/heads/main
 		$orgnext $newnext refs/heads/next
 		EOF
 
 		cat >update.expect <<-EOF &&
-		refs/heads/master $orgmaster $newmaster
+		refs/heads/main $orgmain $newmain
 		refs/heads/next $orgnext $newnext
 		EOF
 
 		cat >post-receive.expect <<-EOF &&
-		$orgmaster $newmaster refs/heads/master
+		$orgmain $newmain refs/heads/main
 		$orgnext $newnext refs/heads/next
 		EOF
 
 		cat >post-update.expect <<-EOF &&
-		refs/heads/master
+		refs/heads/main
 		refs/heads/next
 		EOF
 
@@ -669,25 +669,25 @@ test_expect_success 'pushing valid refs triggers post-receive and post-update ho
 '
 
 test_expect_success 'deleting dangling ref triggers hooks with correct args' '
-	mk_test_with_hooks testrepo heads/master &&
+	mk_test_with_hooks testrepo heads/main &&
 	rm -f testrepo/.git/objects/??/* &&
-	git push testrepo :refs/heads/master &&
+	git push testrepo :refs/heads/main &&
 	(
 		cd testrepo/.git &&
 		cat >pre-receive.expect <<-EOF &&
-		$ZERO_OID $ZERO_OID refs/heads/master
+		$ZERO_OID $ZERO_OID refs/heads/main
 		EOF
 
 		cat >update.expect <<-EOF &&
-		refs/heads/master $ZERO_OID $ZERO_OID
+		refs/heads/main $ZERO_OID $ZERO_OID
 		EOF
 
 		cat >post-receive.expect <<-EOF &&
-		$ZERO_OID $ZERO_OID refs/heads/master
+		$ZERO_OID $ZERO_OID refs/heads/main
 		EOF
 
 		cat >post-update.expect <<-EOF &&
-		refs/heads/master
+		refs/heads/main
 		EOF
 
 		test_cmp pre-receive.expect pre-receive.actual &&
@@ -698,28 +698,28 @@ test_expect_success 'deleting dangling ref triggers hooks with correct args' '
 '
 
 test_expect_success 'deletion of a non-existent ref is not fed to post-receive and post-update hooks' '
-	mk_test_with_hooks testrepo heads/master &&
-	orgmaster=$(cd testrepo && git show-ref -s --verify refs/heads/master) &&
-	newmaster=$(git show-ref -s --verify refs/heads/master) &&
-	git push testrepo master :refs/heads/nonexistent &&
+	mk_test_with_hooks testrepo heads/main &&
+	orgmain=$(cd testrepo && git show-ref -s --verify refs/heads/main) &&
+	newmain=$(git show-ref -s --verify refs/heads/main) &&
+	git push testrepo main :refs/heads/nonexistent &&
 	(
 		cd testrepo/.git &&
 		cat >pre-receive.expect <<-EOF &&
-		$orgmaster $newmaster refs/heads/master
+		$orgmain $newmain refs/heads/main
 		$ZERO_OID $ZERO_OID refs/heads/nonexistent
 		EOF
 
 		cat >update.expect <<-EOF &&
-		refs/heads/master $orgmaster $newmaster
+		refs/heads/main $orgmain $newmain
 		refs/heads/nonexistent $ZERO_OID $ZERO_OID
 		EOF
 
 		cat >post-receive.expect <<-EOF &&
-		$orgmaster $newmaster refs/heads/master
+		$orgmain $newmain refs/heads/main
 		EOF
 
 		cat >post-update.expect <<-EOF &&
-		refs/heads/master
+		refs/heads/main
 		EOF
 
 		test_cmp pre-receive.expect pre-receive.actual &&
@@ -730,7 +730,7 @@ test_expect_success 'deletion of a non-existent ref is not fed to post-receive a
 '
 
 test_expect_success 'deletion of a non-existent ref alone does trigger post-receive and post-update hooks' '
-	mk_test_with_hooks testrepo heads/master &&
+	mk_test_with_hooks testrepo heads/main &&
 	git push testrepo :refs/heads/nonexistent &&
 	(
 		cd testrepo/.git &&
@@ -750,40 +750,40 @@ test_expect_success 'deletion of a non-existent ref alone does trigger post-rece
 '
 
 test_expect_success 'mixed ref updates, deletes, invalid deletes trigger hooks with correct input' '
-	mk_test_with_hooks testrepo heads/master heads/next heads/seen &&
-	orgmaster=$(cd testrepo && git show-ref -s --verify refs/heads/master) &&
-	newmaster=$(git show-ref -s --verify refs/heads/master) &&
+	mk_test_with_hooks testrepo heads/main heads/next heads/seen &&
+	orgmain=$(cd testrepo && git show-ref -s --verify refs/heads/main) &&
+	newmain=$(git show-ref -s --verify refs/heads/main) &&
 	orgnext=$(cd testrepo && git show-ref -s --verify refs/heads/next) &&
 	newnext=$ZERO_OID &&
 	orgseen=$(cd testrepo && git show-ref -s --verify refs/heads/seen) &&
-	newseen=$(git show-ref -s --verify refs/heads/master) &&
-	git push testrepo refs/heads/master:refs/heads/master \
-	    refs/heads/master:refs/heads/seen :refs/heads/next \
+	newseen=$(git show-ref -s --verify refs/heads/main) &&
+	git push testrepo refs/heads/main:refs/heads/main \
+	    refs/heads/main:refs/heads/seen :refs/heads/next \
 	    :refs/heads/nonexistent &&
 	(
 		cd testrepo/.git &&
 		cat >pre-receive.expect <<-EOF &&
-		$orgmaster $newmaster refs/heads/master
+		$orgmain $newmain refs/heads/main
 		$orgnext $newnext refs/heads/next
 		$orgseen $newseen refs/heads/seen
 		$ZERO_OID $ZERO_OID refs/heads/nonexistent
 		EOF
 
 		cat >update.expect <<-EOF &&
-		refs/heads/master $orgmaster $newmaster
+		refs/heads/main $orgmain $newmain
 		refs/heads/next $orgnext $newnext
 		refs/heads/seen $orgseen $newseen
 		refs/heads/nonexistent $ZERO_OID $ZERO_OID
 		EOF
 
 		cat >post-receive.expect <<-EOF &&
-		$orgmaster $newmaster refs/heads/master
+		$orgmain $newmain refs/heads/main
 		$orgnext $newnext refs/heads/next
 		$orgseen $newseen refs/heads/seen
 		EOF
 
 		cat >post-update.expect <<-EOF &&
-		refs/heads/master
+		refs/heads/main
 		refs/heads/next
 		refs/heads/seen
 		EOF
@@ -796,15 +796,15 @@ test_expect_success 'mixed ref updates, deletes, invalid deletes trigger hooks w
 '
 
 test_expect_success 'allow deleting a ref using --delete' '
-	mk_test testrepo heads/master &&
+	mk_test testrepo heads/main &&
 	(cd testrepo && git config receive.denyDeleteCurrent warn) &&
-	git push testrepo --delete master &&
-	(cd testrepo && test_must_fail git rev-parse --verify refs/heads/master)
+	git push testrepo --delete main &&
+	(cd testrepo && test_must_fail git rev-parse --verify refs/heads/main)
 '
 
 test_expect_success 'allow deleting a tag using --delete' '
-	mk_test testrepo heads/master &&
-	git tag -a -m dummy_message deltag heads/master &&
+	mk_test testrepo heads/main &&
+	git tag -a -m dummy_message deltag heads/main &&
 	git push testrepo --tags &&
 	(cd testrepo && git rev-parse --verify -q refs/tags/deltag) &&
 	git push testrepo --delete tag deltag &&
@@ -812,56 +812,56 @@ test_expect_success 'allow deleting a tag using --delete' '
 '
 
 test_expect_success 'push --delete without args aborts' '
-	mk_test testrepo heads/master &&
+	mk_test testrepo heads/main &&
 	test_must_fail git push testrepo --delete
 '
 
 test_expect_success 'push --delete refuses src:dest refspecs' '
-	mk_test testrepo heads/master &&
-	test_must_fail git push testrepo --delete master:foo
+	mk_test testrepo heads/main &&
+	test_must_fail git push testrepo --delete main:foo
 '
 
 test_expect_success 'warn on push to HEAD of non-bare repository' '
-	mk_test testrepo heads/master &&
+	mk_test testrepo heads/main &&
 	(
 		cd testrepo &&
-		git checkout master &&
+		git checkout main &&
 		git config receive.denyCurrentBranch warn
 	) &&
-	git push testrepo master 2>stderr &&
+	git push testrepo main 2>stderr &&
 	grep "warning: updating the current branch" stderr
 '
 
 test_expect_success 'deny push to HEAD of non-bare repository' '
-	mk_test testrepo heads/master &&
+	mk_test testrepo heads/main &&
 	(
 		cd testrepo &&
-		git checkout master &&
+		git checkout main &&
 		git config receive.denyCurrentBranch true
 	) &&
-	test_must_fail git push testrepo master
+	test_must_fail git push testrepo main
 '
 
 test_expect_success 'allow push to HEAD of bare repository (bare)' '
-	mk_test testrepo heads/master &&
+	mk_test testrepo heads/main &&
 	(
 		cd testrepo &&
-		git checkout master &&
+		git checkout main &&
 		git config receive.denyCurrentBranch true &&
 		git config core.bare true
 	) &&
-	git push testrepo master 2>stderr &&
+	git push testrepo main 2>stderr &&
 	! grep "warning: updating the current branch" stderr
 '
 
 test_expect_success 'allow push to HEAD of non-bare repository (config)' '
-	mk_test testrepo heads/master &&
+	mk_test testrepo heads/main &&
 	(
 		cd testrepo &&
-		git checkout master &&
+		git checkout main &&
 		git config receive.denyCurrentBranch false
 	) &&
-	git push testrepo master 2>stderr &&
+	git push testrepo main 2>stderr &&
 	! grep "warning: updating the current branch" stderr
 '
 
@@ -877,7 +877,7 @@ test_expect_success 'fetch with branches' '
 		git for-each-ref refs/heads >actual &&
 		test_cmp expect actual
 	) &&
-	git checkout master
+	git checkout main
 '
 
 test_expect_success 'fetch with branches containing #' '
@@ -890,7 +890,7 @@ test_expect_success 'fetch with branches containing #' '
 		git for-each-ref refs/heads >actual &&
 		test_cmp expect actual
 	) &&
-	git checkout master
+	git checkout main
 '
 
 test_expect_success 'push with branches' '
@@ -900,7 +900,7 @@ test_expect_success 'push with branches' '
 	git push branch1 &&
 	(
 		cd testrepo &&
-		echo "$the_first_commit commit	refs/heads/master" >expect &&
+		echo "$the_first_commit commit	refs/heads/main" >expect &&
 		git for-each-ref refs/heads >actual &&
 		test_cmp expect actual
 	)
@@ -916,11 +916,11 @@ test_expect_success 'push with branches containing #' '
 		git for-each-ref refs/heads >actual &&
 		test_cmp expect actual
 	) &&
-	git checkout master
+	git checkout main
 '
 
 test_expect_success 'push into aliased refs (consistent)' '
-	mk_test testrepo heads/master &&
+	mk_test testrepo heads/main &&
 	mk_child testrepo child1 &&
 	mk_child testrepo child2 &&
 	(
@@ -942,7 +942,7 @@ test_expect_success 'push into aliased refs (consistent)' '
 '
 
 test_expect_success 'push into aliased refs (inconsistent)' '
-	mk_test testrepo heads/master &&
+	mk_test testrepo heads/main &&
 	mk_child testrepo child1 &&
 	mk_child testrepo child2 &&
 	(
@@ -973,7 +973,7 @@ test_force_push_tag () {
 	tag_args=$2
 
 	test_expect_success "force pushing required to update $tag_type_description" "
-		mk_test testrepo heads/master &&
+		mk_test testrepo heads/main &&
 		mk_child testrepo child1 &&
 		mk_child testrepo child2 &&
 		(
@@ -1019,7 +1019,7 @@ test_force_fetch_tag () {
 	tag_args=$2
 
 	test_expect_success "fetch will not clobber an existing $tag_type_description without --force" "
-		mk_test testrepo heads/master &&
+		mk_test testrepo heads/main &&
 		mk_child testrepo child1 &&
 		mk_child testrepo child2 &&
 		(
@@ -1042,12 +1042,12 @@ test_force_fetch_tag "annotated tag" "-f -a -m'tag message'"
 test_expect_success 'push --porcelain' '
 	mk_empty testrepo &&
 	echo >.git/foo  "To testrepo" &&
-	echo >>.git/foo "*	refs/heads/master:refs/remotes/origin/master	[new reference]"  &&
+	echo >>.git/foo "*	refs/heads/main:refs/remotes/origin/main	[new reference]"  &&
 	echo >>.git/foo "Done" &&
-	git push >.git/bar --porcelain  testrepo refs/heads/master:refs/remotes/origin/master &&
+	git push >.git/bar --porcelain  testrepo refs/heads/main:refs/remotes/origin/main &&
 	(
 		cd testrepo &&
-		echo "$the_commit commit	refs/remotes/origin/master" >expect &&
+		echo "$the_commit commit	refs/remotes/origin/main" >expect &&
 		git for-each-ref refs/remotes/origin >actual &&
 		test_cmp expect actual
 	) &&
@@ -1056,52 +1056,52 @@ test_expect_success 'push --porcelain' '
 
 test_expect_success 'push --porcelain bad url' '
 	mk_empty testrepo &&
-	test_must_fail git push >.git/bar --porcelain asdfasdfasd refs/heads/master:refs/remotes/origin/master &&
+	test_must_fail git push >.git/bar --porcelain asdfasdfasd refs/heads/main:refs/remotes/origin/main &&
 	! grep -q Done .git/bar
 '
 
 test_expect_success 'push --porcelain rejected' '
 	mk_empty testrepo &&
-	git push testrepo refs/heads/master:refs/remotes/origin/master &&
+	git push testrepo refs/heads/main:refs/remotes/origin/main &&
 	(cd testrepo &&
-		git reset --hard origin/master^ &&
+		git reset --hard origin/main^ &&
 		git config receive.denyCurrentBranch true) &&
 
 	echo >.git/foo  "To testrepo"  &&
-	echo >>.git/foo "!	refs/heads/master:refs/heads/master	[remote rejected] (branch is currently checked out)" &&
+	echo >>.git/foo "!	refs/heads/main:refs/heads/main	[remote rejected] (branch is currently checked out)" &&
 	echo >>.git/foo "Done" &&
 
-	test_must_fail git push >.git/bar --porcelain  testrepo refs/heads/master:refs/heads/master &&
+	test_must_fail git push >.git/bar --porcelain  testrepo refs/heads/main:refs/heads/main &&
 	test_cmp .git/foo .git/bar
 '
 
 test_expect_success 'push --porcelain --dry-run rejected' '
 	mk_empty testrepo &&
-	git push testrepo refs/heads/master:refs/remotes/origin/master &&
+	git push testrepo refs/heads/main:refs/remotes/origin/main &&
 	(cd testrepo &&
-		git reset --hard origin/master &&
+		git reset --hard origin/main &&
 		git config receive.denyCurrentBranch true) &&
 
 	echo >.git/foo  "To testrepo"  &&
-	echo >>.git/foo "!	refs/heads/master^:refs/heads/master	[rejected] (non-fast-forward)" &&
+	echo >>.git/foo "!	refs/heads/main^:refs/heads/main	[rejected] (non-fast-forward)" &&
 	echo >>.git/foo "Done" &&
 
-	test_must_fail git push >.git/bar --porcelain  --dry-run testrepo refs/heads/master^:refs/heads/master &&
+	test_must_fail git push >.git/bar --porcelain  --dry-run testrepo refs/heads/main^:refs/heads/main &&
 	test_cmp .git/foo .git/bar
 '
 
 test_expect_success 'push --prune' '
-	mk_test testrepo heads/master heads/second heads/foo heads/bar &&
+	mk_test testrepo heads/main heads/second heads/foo heads/bar &&
 	git push --prune testrepo : &&
-	check_push_result testrepo $the_commit heads/master &&
+	check_push_result testrepo $the_commit heads/main &&
 	check_push_result testrepo $the_first_commit heads/second &&
 	! check_push_result testrepo $the_first_commit heads/foo heads/bar
 '
 
 test_expect_success 'push --prune refspec' '
-	mk_test testrepo tmp/master tmp/second tmp/foo tmp/bar &&
+	mk_test testrepo tmp/main tmp/second tmp/foo tmp/bar &&
 	git push --prune testrepo "refs/heads/*:refs/tmp/*" &&
-	check_push_result testrepo $the_commit tmp/master &&
+	check_push_result testrepo $the_commit tmp/main &&
 	check_push_result testrepo $the_first_commit tmp/second &&
 	! check_push_result testrepo $the_first_commit tmp/foo tmp/bar
 '
@@ -1109,18 +1109,18 @@ test_expect_success 'push --prune refspec' '
 for configsection in transfer receive
 do
 	test_expect_success "push to update a ref hidden by $configsection.hiderefs" '
-		mk_test testrepo heads/master hidden/one hidden/two hidden/three &&
+		mk_test testrepo heads/main hidden/one hidden/two hidden/three &&
 		(
 			cd testrepo &&
 			git config $configsection.hiderefs refs/hidden
 		) &&
 
 		# push to unhidden ref succeeds normally
-		git push testrepo master:refs/heads/master &&
-		check_push_result testrepo $the_commit heads/master &&
+		git push testrepo main:refs/heads/main &&
+		check_push_result testrepo $the_commit heads/main &&
 
 		# push to update a hidden ref should fail
-		test_must_fail git push testrepo master:refs/hidden/one &&
+		test_must_fail git push testrepo main:refs/hidden/one &&
 		check_push_result testrepo $the_first_commit hidden/one &&
 
 		# push to delete a hidden ref should fail
@@ -1134,8 +1134,8 @@ do
 done
 
 test_expect_success 'fetch exact SHA1' '
-	mk_test testrepo heads/master hidden/one &&
-	git push testrepo master:refs/hidden/one &&
+	mk_test testrepo heads/main hidden/one &&
+	git push testrepo main:refs/hidden/one &&
 	(
 		cd testrepo &&
 		git config transfer.hiderefs refs/hidden
@@ -1166,7 +1166,7 @@ test_expect_success 'fetch exact SHA1' '
 			git config uploadpack.allowtipsha1inwant true
 		) &&
 
-		git fetch -v ../testrepo $the_commit:refs/heads/copy master:refs/heads/extra &&
+		git fetch -v ../testrepo $the_commit:refs/heads/copy main:refs/heads/extra &&
 		cat >expect <<-EOF &&
 		$the_commit
 		$the_first_commit
@@ -1180,8 +1180,8 @@ test_expect_success 'fetch exact SHA1' '
 '
 
 test_expect_success 'fetch exact SHA1 in protocol v2' '
-	mk_test testrepo heads/master hidden/one &&
-	git push testrepo master:refs/hidden/one &&
+	mk_test testrepo heads/main hidden/one &&
+	git push testrepo main:refs/hidden/one &&
 	git -C testrepo config transfer.hiderefs refs/hidden &&
 	check_push_result testrepo $the_commit hidden/one &&
 
@@ -1263,17 +1263,17 @@ do
 done
 
 test_expect_success 'fetch follows tags by default' '
-	mk_test testrepo heads/master &&
+	mk_test testrepo heads/main &&
 	rm -fr src dst &&
 	git init src &&
 	(
 		cd src &&
-		git pull ../testrepo master &&
+		git pull ../testrepo main &&
 		git tag -m "annotated" tag &&
 		git for-each-ref >tmp1 &&
 		(
 			cat tmp1
-			sed -n "s|refs/heads/master$|refs/remotes/origin/master|p" tmp1
+			sed -n "s|refs/heads/main$|refs/remotes/origin/main|p" tmp1
 		) |
 		sort -k 3 >../expect
 	) &&
@@ -1281,8 +1281,8 @@ test_expect_success 'fetch follows tags by default' '
 	(
 		cd dst &&
 		git remote add origin ../src &&
-		git config branch.master.remote origin &&
-		git config branch.master.merge refs/heads/master &&
+		git config branch.main.remote origin &&
+		git config branch.main.merge refs/heads/main &&
 		git pull &&
 		git for-each-ref >../actual
 	) &&
@@ -1301,74 +1301,74 @@ test_expect_success 'peeled advertisements are not considered ref tips' '
 '
 
 test_expect_success 'pushing a specific ref applies remote.$name.push as refmap' '
-	mk_test testrepo heads/master &&
+	mk_test testrepo heads/main &&
 	rm -fr src dst &&
 	git init src &&
 	git init --bare dst &&
 	(
 		cd src &&
-		git pull ../testrepo master &&
+		git pull ../testrepo main &&
 		git branch next &&
 		git config remote.dst.url ../dst &&
 		git config remote.dst.push "+refs/heads/*:refs/remotes/src/*" &&
-		git push dst master &&
-		git show-ref refs/heads/master |
+		git push dst main &&
+		git show-ref refs/heads/main |
 		sed -e "s|refs/heads/|refs/remotes/src/|" >../dst/expect
 	) &&
 	(
 		cd dst &&
 		test_must_fail git show-ref refs/heads/next &&
-		test_must_fail git show-ref refs/heads/master &&
-		git show-ref refs/remotes/src/master >actual
+		test_must_fail git show-ref refs/heads/main &&
+		git show-ref refs/remotes/src/main >actual
 	) &&
 	test_cmp dst/expect dst/actual
 '
 
 test_expect_success 'with no remote.$name.push, it is not used as refmap' '
-	mk_test testrepo heads/master &&
+	mk_test testrepo heads/main &&
 	rm -fr src dst &&
 	git init src &&
 	git init --bare dst &&
 	(
 		cd src &&
-		git pull ../testrepo master &&
+		git pull ../testrepo main &&
 		git branch next &&
 		git config remote.dst.url ../dst &&
 		git config push.default matching &&
-		git push dst master &&
-		git show-ref refs/heads/master >../dst/expect
+		git push dst main &&
+		git show-ref refs/heads/main >../dst/expect
 	) &&
 	(
 		cd dst &&
 		test_must_fail git show-ref refs/heads/next &&
-		git show-ref refs/heads/master >actual
+		git show-ref refs/heads/main >actual
 	) &&
 	test_cmp dst/expect dst/actual
 '
 
 test_expect_success 'with no remote.$name.push, upstream mapping is used' '
-	mk_test testrepo heads/master &&
+	mk_test testrepo heads/main &&
 	rm -fr src dst &&
 	git init src &&
 	git init --bare dst &&
 	(
 		cd src &&
-		git pull ../testrepo master &&
+		git pull ../testrepo main &&
 		git branch next &&
 		git config remote.dst.url ../dst &&
 		git config remote.dst.fetch "+refs/heads/*:refs/remotes/dst/*" &&
 		git config push.default upstream &&
 
-		git config branch.master.merge refs/heads/trunk &&
-		git config branch.master.remote dst &&
+		git config branch.main.merge refs/heads/trunk &&
+		git config branch.main.remote dst &&
 
-		git push dst master &&
-		git show-ref refs/heads/master |
-		sed -e "s|refs/heads/master|refs/heads/trunk|" >../dst/expect
+		git push dst main &&
+		git show-ref refs/heads/main |
+		sed -e "s|refs/heads/main|refs/heads/trunk|" >../dst/expect
 	) &&
 	(
 		cd dst &&
-		test_must_fail git show-ref refs/heads/master &&
+		test_must_fail git show-ref refs/heads/main &&
 		test_must_fail git show-ref refs/heads/next &&
 		git show-ref refs/heads/trunk >actual
 	) &&
@@ -1376,20 +1376,20 @@ test_expect_success 'with no remote.$name.push, upstream mapping is used' '
 '
 
 test_expect_success 'push does not follow tags by default' '
-	mk_test testrepo heads/master &&
+	mk_test testrepo heads/main &&
 	rm -fr src dst &&
 	git init src &&
 	git init --bare dst &&
 	(
 		cd src &&
-		git pull ../testrepo master &&
+		git pull ../testrepo main &&
 		git tag -m "annotated" tag &&
 		git checkout -b another &&
 		git commit --allow-empty -m "future commit" &&
 		git tag -m "future" future &&
-		git checkout master &&
-		git for-each-ref refs/heads/master >../expect &&
-		git push ../dst master
+		git checkout main &&
+		git for-each-ref refs/heads/main >../expect &&
+		git push ../dst main
 	) &&
 	(
 		cd dst &&
@@ -1399,20 +1399,20 @@ test_expect_success 'push does not follow tags by default' '
 '
 
 test_expect_success 'push --follow-tags only pushes relevant tags' '
-	mk_test testrepo heads/master &&
+	mk_test testrepo heads/main &&
 	rm -fr src dst &&
 	git init src &&
 	git init --bare dst &&
 	(
 		cd src &&
-		git pull ../testrepo master &&
+		git pull ../testrepo main &&
 		git tag -m "annotated" tag &&
 		git checkout -b another &&
 		git commit --allow-empty -m "future commit" &&
 		git tag -m "future" future &&
-		git checkout master &&
-		git for-each-ref refs/heads/master refs/tags/tag >../expect &&
-		git push --follow-tags ../dst master
+		git checkout main &&
+		git for-each-ref refs/heads/main refs/tags/tag >../expect &&
+		git push --follow-tags ../dst main
 	) &&
 	(
 		cd dst &&
@@ -1430,12 +1430,12 @@ EOF
 	git commit -am initial &&
 	git init no-thin &&
 	git --git-dir=no-thin/.git config receive.unpacklimit 0 &&
-	git push no-thin/.git refs/heads/master:refs/heads/foo &&
+	git push no-thin/.git refs/heads/main:refs/heads/foo &&
 	echo modified >> path1 &&
 	git commit -am modified &&
 	git repack -adf &&
 	rcvpck="git receive-pack --reject-thin-pack-for-testing" &&
-	git push --no-thin --receive-pack="$rcvpck" no-thin/.git refs/heads/master:refs/heads/foo
+	git push --no-thin --receive-pack="$rcvpck" no-thin/.git refs/heads/main:refs/heads/foo
 '
 
 test_expect_success 'pushing a tag pushes the tagged object' '
@@ -1458,12 +1458,12 @@ test_expect_success 'push into bare respects core.logallrefupdates' '
 
 	# double push to test both with and without
 	# the actual pack transfer
-	git push dst.git master:one &&
+	git push dst.git main:one &&
 	echo "one@{0} push" >expect &&
 	git -C dst.git log -g --format="%gd %gs" one >actual &&
 	test_cmp expect actual &&
 
-	git push dst.git master:two &&
+	git push dst.git main:two &&
 	echo "two@{0} push" >expect &&
 	git -C dst.git log -g --format="%gd %gs" two >actual &&
 	test_cmp expect actual
@@ -1478,20 +1478,20 @@ test_expect_success 'fetch into bare respects core.logallrefupdates' '
 
 		# as above, we double-fetch to test both
 		# with and without pack transfer
-		git fetch .. master:one &&
-		echo "one@{0} fetch .. master:one: storing head" >expect &&
+		git fetch .. main:one &&
+		echo "one@{0} fetch .. main:one: storing head" >expect &&
 		git log -g --format="%gd %gs" one >actual &&
 		test_cmp expect actual &&
 
-		git fetch .. master:two &&
-		echo "two@{0} fetch .. master:two: storing head" >expect &&
+		git fetch .. main:two &&
+		echo "two@{0} fetch .. main:two: storing head" >expect &&
 		git log -g --format="%gd %gs" two >actual &&
 		test_cmp expect actual
 	)
 '
 
 test_expect_success 'receive.denyCurrentBranch = updateInstead' '
-	git push testrepo master &&
+	git push testrepo main &&
 	(
 		cd testrepo &&
 		git reset --hard &&
@@ -1500,7 +1500,7 @@ test_expect_success 'receive.denyCurrentBranch = updateInstead' '
 	test_commit third path2 &&
 
 	# Try pushing into a repository with pristine working tree
-	git push testrepo master &&
+	git push testrepo main &&
 	(
 		cd testrepo &&
 		git update-index -q --refresh &&
@@ -1517,7 +1517,7 @@ test_expect_success 'receive.denyCurrentBranch = updateInstead' '
 		test $(git -C .. rev-parse HEAD^) = $(git rev-parse HEAD) &&
 		test-tool chmtime +100 path1
 	) &&
-	git push testrepo master &&
+	git push testrepo main &&
 	(
 		cd testrepo &&
 		git update-index -q --refresh &&
@@ -1537,7 +1537,7 @@ test_expect_success 'receive.denyCurrentBranch = updateInstead' '
 		cd testrepo &&
 		echo changed >path1
 	) &&
-	test_must_fail git push testrepo master &&
+	test_must_fail git push testrepo main &&
 	(
 		cd testrepo &&
 		test $(git -C .. rev-parse HEAD^) = $(git rev-parse HEAD) &&
@@ -1551,7 +1551,7 @@ test_expect_success 'receive.denyCurrentBranch = updateInstead' '
 		echo changed >path1 &&
 		git add path1
 	) &&
-	test_must_fail git push testrepo master &&
+	test_must_fail git push testrepo main &&
 	(
 		cd testrepo &&
 		test $(git -C .. rev-parse HEAD^) = $(git rev-parse HEAD) &&
@@ -1568,7 +1568,7 @@ test_expect_success 'receive.denyCurrentBranch = updateInstead' '
 		git reset --hard &&
 		echo changed >path3
 	) &&
-	test_must_fail git push testrepo master &&
+	test_must_fail git push testrepo main &&
 	(
 		cd testrepo &&
 		test $(git -C .. rev-parse HEAD^^) = $(git rev-parse HEAD) &&
@@ -1584,7 +1584,7 @@ test_expect_success 'receive.denyCurrentBranch = updateInstead' '
 		echo fifth >path3 &&
 		git add path3
 	) &&
-	test_must_fail git push testrepo master &&
+	test_must_fail git push testrepo main &&
 	(
 		cd testrepo &&
 		test $(git -C .. rev-parse HEAD^^) = $(git rev-parse HEAD) &&
@@ -1599,17 +1599,17 @@ test_expect_success 'receive.denyCurrentBranch = updateInstead' '
 		cd void &&
 		git config receive.denyCurrentBranch updateInstead
 	) &&
-	git push void master &&
+	git push void main &&
 	(
 		cd void &&
-		test $(git -C .. rev-parse master) = $(git rev-parse HEAD) &&
+		test $(git -C .. rev-parse main) = $(git rev-parse HEAD) &&
 		git diff --quiet &&
 		git diff --cached --quiet
 	) &&
 
 	# (6) updateInstead intervened by fast-forward check
-	test_must_fail git push void master^:master &&
-	test $(git -C void rev-parse HEAD) = $(git rev-parse master) &&
+	test_must_fail git push void main^:main &&
+	test $(git -C void rev-parse HEAD) = $(git rev-parse main) &&
 	git -C void diff --quiet &&
 	git -C void diff --cached --quiet
 '
@@ -1619,7 +1619,7 @@ test_expect_success 'updateInstead with push-to-checkout hook' '
 	git init testrepo &&
 	(
 		cd testrepo &&
-		git pull .. master &&
+		git pull .. main &&
 		git reset --hard HEAD^^ &&
 		git tag initial &&
 		git config receive.denyCurrentBranch updateInstead &&
@@ -1637,7 +1637,7 @@ test_expect_success 'updateInstead with push-to-checkout hook' '
 	) &&
 
 	# Try pushing into a pristine
-	git push testrepo master &&
+	git push testrepo main &&
 	(
 		cd testrepo &&
 		git diff --quiet &&
@@ -1651,7 +1651,7 @@ test_expect_success 'updateInstead with push-to-checkout hook' '
 		git reset --hard initial &&
 		echo conflicting >path2
 	) &&
-	test_must_fail git push testrepo master &&
+	test_must_fail git push testrepo main &&
 	(
 		cd testrepo &&
 		test $(git rev-parse initial) = $(git rev-parse HEAD) &&
@@ -1667,7 +1667,7 @@ test_expect_success 'updateInstead with push-to-checkout hook' '
 		echo irrelevant >path5 &&
 		git add path5
 	) &&
-	git push testrepo master &&
+	git push testrepo main &&
 	(
 		cd testrepo &&
 		test "$(cat path1)" = unrelated &&
@@ -1707,7 +1707,7 @@ test_expect_success 'updateInstead with push-to-checkout hook' '
 		EOF
 	) &&
 
-	git push void master &&
+	git push void main &&
 	(
 		cd void &&
 		git diff --quiet &&
diff --git a/t/t5517-push-mirror.sh b/t/t5517-push-mirror.sh
index aa6405b452..a448e169bd 100755
--- a/t/t5517-push-mirror.sh
+++ b/t/t5517-push-mirror.sh
@@ -2,7 +2,7 @@
 
 test_description='pushing to a mirror repository'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -18,16 +18,16 @@ invert () {
 }
 
 mk_repo_pair () {
-	rm -rf master mirror &&
+	rm -rf main mirror &&
 	mkdir mirror &&
 	(
 		cd mirror &&
 		git init &&
 		git config receive.denyCurrentBranch warn
 	) &&
-	mkdir master &&
+	mkdir main &&
 	(
-		cd master &&
+		cd main &&
 		git init &&
 		git remote add $1 up ../mirror
 	)
@@ -39,13 +39,13 @@ test_expect_success 'push mirror creates new branches' '
 
 	mk_repo_pair &&
 	(
-		cd master &&
+		cd main &&
 		echo one >foo && git add foo && git commit -m one &&
 		git push --mirror up
 	) &&
-	master_master=$(cd master && git show-ref -s --verify refs/heads/master) &&
-	mirror_master=$(cd mirror && git show-ref -s --verify refs/heads/master) &&
-	test "$master_master" = "$mirror_master"
+	main_main=$(cd main && git show-ref -s --verify refs/heads/main) &&
+	mirror_main=$(cd mirror && git show-ref -s --verify refs/heads/main) &&
+	test "$main_main" = "$mirror_main"
 
 '
 
@@ -53,15 +53,15 @@ test_expect_success 'push mirror updates existing branches' '
 
 	mk_repo_pair &&
 	(
-		cd master &&
+		cd main &&
 		echo one >foo && git add foo && git commit -m one &&
 		git push --mirror up &&
 		echo two >foo && git add foo && git commit -m two &&
 		git push --mirror up
 	) &&
-	master_master=$(cd master && git show-ref -s --verify refs/heads/master) &&
-	mirror_master=$(cd mirror && git show-ref -s --verify refs/heads/master) &&
-	test "$master_master" = "$mirror_master"
+	main_main=$(cd main && git show-ref -s --verify refs/heads/main) &&
+	mirror_main=$(cd mirror && git show-ref -s --verify refs/heads/main) &&
+	test "$main_main" = "$mirror_main"
 
 '
 
@@ -69,7 +69,7 @@ test_expect_success 'push mirror force updates existing branches' '
 
 	mk_repo_pair &&
 	(
-		cd master &&
+		cd main &&
 		echo one >foo && git add foo && git commit -m one &&
 		git push --mirror up &&
 		echo two >foo && git add foo && git commit -m two &&
@@ -77,9 +77,9 @@ test_expect_success 'push mirror force updates existing branches' '
 		git reset --hard HEAD^ &&
 		git push --mirror up
 	) &&
-	master_master=$(cd master && git show-ref -s --verify refs/heads/master) &&
-	mirror_master=$(cd mirror && git show-ref -s --verify refs/heads/master) &&
-	test "$master_master" = "$mirror_master"
+	main_main=$(cd main && git show-ref -s --verify refs/heads/main) &&
+	mirror_main=$(cd mirror && git show-ref -s --verify refs/heads/main) &&
+	test "$main_main" = "$mirror_main"
 
 '
 
@@ -87,9 +87,9 @@ test_expect_success 'push mirror removes branches' '
 
 	mk_repo_pair &&
 	(
-		cd master &&
+		cd main &&
 		echo one >foo && git add foo && git commit -m one &&
-		git branch remove master &&
+		git branch remove main &&
 		git push --mirror up &&
 		git branch -D remove &&
 		git push --mirror up
@@ -105,21 +105,21 @@ test_expect_success 'push mirror adds, updates and removes branches together' '
 
 	mk_repo_pair &&
 	(
-		cd master &&
+		cd main &&
 		echo one >foo && git add foo && git commit -m one &&
-		git branch remove master &&
+		git branch remove main &&
 		git push --mirror up &&
 		git branch -D remove &&
-		git branch add master &&
+		git branch add main &&
 		echo two >foo && git add foo && git commit -m two &&
 		git push --mirror up
 	) &&
-	master_master=$(cd master && git show-ref -s --verify refs/heads/master) &&
-	master_add=$(cd master && git show-ref -s --verify refs/heads/add) &&
-	mirror_master=$(cd mirror && git show-ref -s --verify refs/heads/master) &&
+	main_main=$(cd main && git show-ref -s --verify refs/heads/main) &&
+	main_add=$(cd main && git show-ref -s --verify refs/heads/add) &&
+	mirror_main=$(cd mirror && git show-ref -s --verify refs/heads/main) &&
 	mirror_add=$(cd mirror && git show-ref -s --verify refs/heads/add) &&
-	test "$master_master" = "$mirror_master" &&
-	test "$master_add" = "$mirror_add" &&
+	test "$main_main" = "$mirror_main" &&
+	test "$main_add" = "$mirror_add" &&
 	(
 		cd mirror &&
 		invert git show-ref -s --verify refs/heads/remove
@@ -133,14 +133,14 @@ test_expect_success 'push mirror creates new tags' '
 
 	mk_repo_pair &&
 	(
-		cd master &&
+		cd main &&
 		echo one >foo && git add foo && git commit -m one &&
-		git tag -f tmaster master &&
+		git tag -f tmain main &&
 		git push --mirror up
 	) &&
-	master_master=$(cd master && git show-ref -s --verify refs/tags/tmaster) &&
-	mirror_master=$(cd mirror && git show-ref -s --verify refs/tags/tmaster) &&
-	test "$master_master" = "$mirror_master"
+	main_main=$(cd main && git show-ref -s --verify refs/tags/tmain) &&
+	mirror_main=$(cd mirror && git show-ref -s --verify refs/tags/tmain) &&
+	test "$main_main" = "$mirror_main"
 
 '
 
@@ -148,17 +148,17 @@ test_expect_success 'push mirror updates existing tags' '
 
 	mk_repo_pair &&
 	(
-		cd master &&
+		cd main &&
 		echo one >foo && git add foo && git commit -m one &&
-		git tag -f tmaster master &&
+		git tag -f tmain main &&
 		git push --mirror up &&
 		echo two >foo && git add foo && git commit -m two &&
-		git tag -f tmaster master &&
+		git tag -f tmain main &&
 		git push --mirror up
 	) &&
-	master_master=$(cd master && git show-ref -s --verify refs/tags/tmaster) &&
-	mirror_master=$(cd mirror && git show-ref -s --verify refs/tags/tmaster) &&
-	test "$master_master" = "$mirror_master"
+	main_main=$(cd main && git show-ref -s --verify refs/tags/tmain) &&
+	mirror_main=$(cd mirror && git show-ref -s --verify refs/tags/tmain) &&
+	test "$main_main" = "$mirror_main"
 
 '
 
@@ -166,20 +166,20 @@ test_expect_success 'push mirror force updates existing tags' '
 
 	mk_repo_pair &&
 	(
-		cd master &&
+		cd main &&
 		echo one >foo && git add foo && git commit -m one &&
-		git tag -f tmaster master &&
+		git tag -f tmain main &&
 		git push --mirror up &&
 		echo two >foo && git add foo && git commit -m two &&
-		git tag -f tmaster master &&
+		git tag -f tmain main &&
 		git push --mirror up &&
 		git reset --hard HEAD^ &&
-		git tag -f tmaster master &&
+		git tag -f tmain main &&
 		git push --mirror up
 	) &&
-	master_master=$(cd master && git show-ref -s --verify refs/tags/tmaster) &&
-	mirror_master=$(cd mirror && git show-ref -s --verify refs/tags/tmaster) &&
-	test "$master_master" = "$mirror_master"
+	main_main=$(cd main && git show-ref -s --verify refs/tags/tmain) &&
+	mirror_main=$(cd mirror && git show-ref -s --verify refs/tags/tmain) &&
+	test "$main_main" = "$mirror_main"
 
 '
 
@@ -187,9 +187,9 @@ test_expect_success 'push mirror removes tags' '
 
 	mk_repo_pair &&
 	(
-		cd master &&
+		cd main &&
 		echo one >foo && git add foo && git commit -m one &&
-		git tag -f tremove master &&
+		git tag -f tremove main &&
 		git push --mirror up &&
 		git tag -d tremove &&
 		git push --mirror up
@@ -205,23 +205,23 @@ test_expect_success 'push mirror adds, updates and removes tags together' '
 
 	mk_repo_pair &&
 	(
-		cd master &&
+		cd main &&
 		echo one >foo && git add foo && git commit -m one &&
-		git tag -f tmaster master &&
-		git tag -f tremove master &&
+		git tag -f tmain main &&
+		git tag -f tremove main &&
 		git push --mirror up &&
 		git tag -d tremove &&
-		git tag tadd master &&
+		git tag tadd main &&
 		echo two >foo && git add foo && git commit -m two &&
-		git tag -f tmaster master &&
+		git tag -f tmain main &&
 		git push --mirror up
 	) &&
-	master_master=$(cd master && git show-ref -s --verify refs/tags/tmaster) &&
-	master_add=$(cd master && git show-ref -s --verify refs/tags/tadd) &&
-	mirror_master=$(cd mirror && git show-ref -s --verify refs/tags/tmaster) &&
+	main_main=$(cd main && git show-ref -s --verify refs/tags/tmain) &&
+	main_add=$(cd main && git show-ref -s --verify refs/tags/tadd) &&
+	mirror_main=$(cd mirror && git show-ref -s --verify refs/tags/tmain) &&
 	mirror_add=$(cd mirror && git show-ref -s --verify refs/tags/tadd) &&
-	test "$master_master" = "$mirror_master" &&
-	test "$master_add" = "$mirror_add" &&
+	test "$main_main" = "$mirror_main" &&
+	test "$main_add" = "$mirror_add" &&
 	(
 		cd mirror &&
 		invert git show-ref -s --verify refs/tags/tremove
@@ -233,10 +233,10 @@ test_expect_success 'remote.foo.mirror adds and removes branches' '
 
 	mk_repo_pair --mirror &&
 	(
-		cd master &&
+		cd main &&
 		echo one >foo && git add foo && git commit -m one &&
-		git branch keep master &&
-		git branch remove master &&
+		git branch keep main &&
+		git branch remove main &&
 		git push up &&
 		git branch -D remove &&
 		git push up
@@ -253,10 +253,10 @@ test_expect_success 'remote.foo.mirror=no has no effect' '
 
 	mk_repo_pair &&
 	(
-		cd master &&
+		cd main &&
 		echo one >foo && git add foo && git commit -m one &&
 		git config --add remote.up.mirror no &&
-		git branch keep master &&
+		git branch keep main &&
 		git push --mirror up &&
 		git branch -D keep &&
 		git push up :
@@ -271,10 +271,10 @@ test_expect_success 'remote.foo.mirror=no has no effect' '
 test_expect_success 'push to mirrored repository with refspec fails' '
 	mk_repo_pair &&
 	(
-		cd master &&
+		cd main &&
 		echo one >foo && git add foo && git commit -m one &&
 		git config --add remote.up.mirror true &&
-		test_must_fail git push up master
+		test_must_fail git push up main
 	)
 '
 
diff --git a/t/t5518-fetch-exit-status.sh b/t/t5518-fetch-exit-status.sh
index a94d0744d0..5c4ac2556e 100755
--- a/t/t5518-fetch-exit-status.sh
+++ b/t/t5518-fetch-exit-status.sh
@@ -5,7 +5,7 @@
 
 test_description='fetch exit status test'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -20,20 +20,20 @@ test_expect_success setup '
 	echo side >file &&
 	git commit -a -m side &&
 
-	git checkout master &&
+	git checkout main &&
 	echo next >file &&
 	git commit -a -m next
 '
 
 test_expect_success 'non-fast-forward fetch' '
 
-	test_must_fail git fetch . master:side
+	test_must_fail git fetch . main:side
 
 '
 
 test_expect_success 'forced update' '
 
-	git fetch . +master:side
+	git fetch . +main:side
 
 '
 
diff --git a/t/t5519-push-alternates.sh b/t/t5519-push-alternates.sh
index 0f199d0ccb..20ba604dfd 100755
--- a/t/t5519-push-alternates.sh
+++ b/t/t5519-push-alternates.sh
@@ -2,7 +2,7 @@
 
 test_description='push to a repository that borrows from elsewhere'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -20,7 +20,7 @@ test_expect_success setup '
 		>file &&
 		git add . &&
 		git commit -m initial &&
-		git push ../alice-pub master
+		git push ../alice-pub main
 	) &&
 
 	# Project Bob is a fork of project Alice
@@ -34,7 +34,7 @@ test_expect_success setup '
 	git clone alice-pub bob-work &&
 	(
 		cd bob-work &&
-		git push ../bob-pub master
+		git push ../bob-pub main
 	)
 '
 
@@ -57,7 +57,7 @@ test_expect_success 'bob fetches from alice, works and pushes' '
 		# has at her public repository are available to it
 		# via its alternates.
 		cd bob-work &&
-		git pull ../alice-pub master &&
+		git pull ../alice-pub main &&
 		echo more bob >file &&
 		git commit -a -m third &&
 		git push ../bob-pub :
@@ -96,7 +96,7 @@ test_expect_success 'alice works and pushes again' '
 test_expect_success 'bob works and pushes' '
 	(
 		# This time Bob does not pull from Alice, and
-		# the master branch at her public repository points
+		# the main branch at her public repository points
 		# at a commit Bob does not know about.  This should
 		# not prevent the push by Bob from succeeding.
 		cd bob-work &&
@@ -125,11 +125,11 @@ test_expect_success 'alice works and pushes yet again' '
 test_expect_success 'bob works and pushes again' '
 	(
 		cd alice-pub &&
-		git cat-file commit master >../bob-work/commit
+		git cat-file commit main >../bob-work/commit
 	) &&
 	(
 		# This time Bob does not pull from Alice, and
-		# the master branch at her public repository points
+		# the main branch at her public repository points
 		# at a commit Bob does not fully know about, but
 		# he happens to have the commit object (but not the
 		# necessary tree) in his repository from Alice.
-- 
gitgitgadget

