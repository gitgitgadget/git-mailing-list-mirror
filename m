Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE799C63798
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40CCD20825
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcYvwFsL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgKLWoP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 17:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbgKLWoO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 17:44:14 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1439CC0613D4
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:44:14 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id a3so6827986wmb.5
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mc3KlzA/PkD4/laD5xP/+phbsIxjP1dBWsm0StIYMpI=;
        b=RcYvwFsLSNs5tcMycYfvA6Mhr8mpa1TyGEIssCgbKyUwDuuYMmhwemIHlMSo5Z9eO0
         SSh5Hw5xXVbDuByJgY5vJngBpXfujmR8yGiBUxIq5B72eShMih2e62XLEUbR8tX1eIK2
         UK3U3L2cwf+O2Iwjkm32jfogk3smhkIIKPVeoRtFXB2w5lBf8/hZuIasAOQkeVq5d1II
         ccwhlYfEuE04xyauSPrdPtLiT68j3Qsi1uB4FliKEi/SeYcZ6ic5/c36e4u7NWj9vA1Y
         hogcr0mJbu5723Me8T3m+yNnSTsIpBwiBqg2lxXmpOss6nVZkjqtmJh0KX7wlTfsgK8G
         QU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mc3KlzA/PkD4/laD5xP/+phbsIxjP1dBWsm0StIYMpI=;
        b=CfjJHzFNL8lfa8cANwmONpguFwYsS9xIaXO42jPuVJ+6+/Pwrc+bgij4bTNVtG6gpg
         mtbZnnESWy9PJYHLlQqHRoFHgx0y5R5N2JCvhsZN6TMK33Sp16DsIm3l+SgqcMNA1B/X
         fnr1AOfBcl6YpCnL/OFj9z4mLH7Mh/rOh+N5AV11n5BbX4SW/sd2veT+6ojFex9Ar/wE
         hNN1kLum8qWvN+I37E52vRq0t7cg6dDUblUGuFBFiPvob+ZKoNx8oQpde4UZVYG+9jFi
         v65NtFKQa727RO6MF15ca0WaKt1+rAIQHX4hrtlinTBP2YwXnuQO93b1nzQXcK2FSEKQ
         dm/A==
X-Gm-Message-State: AOAM5327NK1Way0JjFRKymEfVZ97UgrGnk0/uzeykuWqLrwAlympovAK
        F58gYkjWDoNx85bIMcSJOBTG83CTVlI=
X-Google-Smtp-Source: ABdhPJzC8oF/JKkEBRClNARH3OGoCAdBZj4SUZd+k1fpK0+KGDKOhQHWV79XV9TF3oZVfLwT6TxTng==
X-Received: by 2002:a1c:bd0b:: with SMTP id n11mr42346wmf.111.1605221051202;
        Thu, 12 Nov 2020 14:44:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x2sm2448319wru.44.2020.11.12.14.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 14:44:10 -0800 (PST)
Message-Id: <727de6fdf5f2eb0765d26c18a7960c5770a51a1d.1605221039.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.git.1605221038.gitgitgadget@gmail.com>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Nov 2020 22:43:43 +0000
Subject: [PATCH 13/28] t551*: adjust the references to the default branch name
 "main"
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
		-e 's/Master/Main/g' -- t551*.sh)

This allows us to define `GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main`
for those tests.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5510-fetch.sh             | 158 +++++------
 t/t5511-refspec.sh           |  12 +-
 t/t5512-ls-remote.sh         |  26 +-
 t/t5514-fetch-multiple.sh    |  30 +--
 t/t5516-fetch-push.sh        | 500 +++++++++++++++++------------------
 t/t5517-push-mirror.sh       | 124 ++++-----
 t/t5518-fetch-exit-status.sh |   6 +-
 t/t5519-push-alternates.sh   |  12 +-
 t/test-lib.sh                |   2 +-
 9 files changed, 435 insertions(+), 435 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 5d673358f9..206e3be695 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -37,19 +37,19 @@ test_expect_success "clone and setup child repos" '
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
@@ -65,7 +65,7 @@ test_expect_success "fetch test" '
 	git fetch &&
 	git rev-parse --verify refs/heads/one &&
 	mine=$(git rev-parse refs/heads/one) &&
-	his=$(cd ../one && git rev-parse refs/heads/master) &&
+	his=$(cd ../one && git rev-parse refs/heads/main) &&
 	test "z$mine" = "z$his"
 '
 
@@ -75,11 +75,11 @@ test_expect_success "fetch test for-merge" '
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
@@ -88,7 +88,7 @@ test_expect_success 'fetch --prune on its own works as expected' '
 	cd "$D" &&
 	git clone . prune &&
 	cd prune &&
-	git update-ref refs/remotes/origin/extrabranch master &&
+	git update-ref refs/remotes/origin/extrabranch main &&
 
 	git fetch --prune origin &&
 	test_must_fail git rev-parse origin/extrabranch
@@ -98,9 +98,9 @@ test_expect_success 'fetch --prune with a branch name keeps branches' '
 	cd "$D" &&
 	git clone . prune-branch &&
 	cd prune-branch &&
-	git update-ref refs/remotes/origin/extrabranch master &&
+	git update-ref refs/remotes/origin/extrabranch main &&
 
-	git fetch --prune origin master &&
+	git fetch --prune origin main &&
 	git rev-parse origin/extrabranch
 '
 
@@ -110,18 +110,18 @@ test_expect_success 'fetch --prune with a namespace keeps other namespaces' '
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
@@ -129,7 +129,7 @@ test_expect_success 'fetch --prune handles overlapping refspecs' '
 	git config --add remote.origin.fetch refs/heads/*:refs/remotes/origin/* &&
 
 	git fetch --prune origin &&
-	git rev-parse origin/master &&
+	git rev-parse origin/main &&
 	git rev-parse origin/pr/42
 '
 
@@ -137,13 +137,13 @@ test_expect_success 'fetch --prune --tags prunes branches but not tags' '
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
@@ -152,10 +152,10 @@ test_expect_success 'fetch --prune --tags with branch does not prune other thing
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
@@ -164,9 +164,9 @@ test_expect_success 'fetch --prune --tags with refspec prunes based on refspec'
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
@@ -177,20 +177,20 @@ test_expect_success 'fetch --prune --tags with refspec prunes based on refspec'
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
@@ -250,7 +250,7 @@ test_expect_success 'fetch uses remote ref names to describe new refs' '
 		test_i18ngrep "new tag.* -> descriptive-tag$" actual &&
 		test_i18ngrep "new ref.* -> crazy$" actual
 	) &&
-	git checkout master
+	git checkout main
 '
 
 test_expect_success 'fetch must not resolve short tag name' '
@@ -281,7 +281,7 @@ test_expect_success 'create bundle 1' '
 	cd "$D" &&
 	echo >file updated again by origin &&
 	git commit -a -m "tip" &&
-	git bundle create --version=3 bundle1 master^..master
+	git bundle create --version=3 bundle1 main^..main
 '
 
 test_expect_success 'header of bundle looks right' '
@@ -289,7 +289,7 @@ test_expect_success 'header of bundle looks right' '
 	# v3 git bundle
 	@object-format=$(test_oid algo)
 	-OID updated by origin
-	OID refs/heads/master
+	OID refs/heads/main
 
 	EOF
 	sed -e "s/$OID_REGEX/OID/g" -e "5q" "$D"/bundle1 >actual &&
@@ -298,13 +298,13 @@ test_expect_success 'header of bundle looks right' '
 
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
 
 
@@ -317,8 +317,8 @@ test_expect_success 'bundle 1 has only 3 files ' '
 
 test_expect_success 'unbundle 2' '
 	cd "$D/bundle" &&
-	git fetch ../bundle2 master:master &&
-	test "tip" = "$(git log -1 --pretty=oneline master | cut -d" " -f2)"
+	git fetch ../bundle2 main:main &&
+	test "tip" = "$(git log -1 --pretty=oneline main | cut -d" " -f2)"
 '
 
 test_expect_success 'bundle does not prerequisite objects' '
@@ -335,14 +335,14 @@ test_expect_success 'bundle does not prerequisite objects' '
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
@@ -362,8 +362,8 @@ test_expect_success 'fetch from GIT URL with a non-applying branch.<name>.merge
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
@@ -373,7 +373,7 @@ test_expect_success 'fetch from GIT URL with a non-applying branch.<name>.merge
 # URL supplied to fetch matches the url of the configured branch's remote, but
 # the merge spec does not match the branch the remote HEAD points to
 test_expect_success 'fetch from GIT URL with a non-applying branch.<name>.merge [3]' '
-	git config branch.master.merge "${one_ref}_not" &&
+	git config branch.main.merge "${one_ref}_not" &&
 	git update-ref -d FETCH_HEAD &&
 	git fetch one &&
 	test $one_head = "$(git rev-parse --verify FETCH_HEAD)" &&
@@ -389,9 +389,9 @@ test_expect_success 'quoting of a strangely named repo' '
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
@@ -399,10 +399,10 @@ test_expect_success 'bundle should record HEAD correctly' '
 
 '
 
-test_expect_success 'mark initial state of origin/master' '
+test_expect_success 'mark initial state of origin/main' '
 	(
 		cd three &&
-		git tag base-origin-master refs/remotes/origin/master
+		git tag base-origin-main refs/remotes/origin/main
 	)
 '
 
@@ -412,10 +412,10 @@ test_expect_success 'explicit fetch should update tracking' '
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
@@ -427,10 +427,10 @@ test_expect_success 'explicit pull should update tracking' '
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
@@ -449,13 +449,13 @@ test_expect_success 'explicit --refmap option overrides remote.*.fetch' '
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
 
@@ -464,10 +464,10 @@ test_expect_success 'explicitly empty --refmap option disables remote.*.fetch' '
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
@@ -479,10 +479,10 @@ test_expect_success 'configured fetch updates tracking' '
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
@@ -493,12 +493,12 @@ test_expect_success 'non-matching refspecs do not confuse tracking update' '
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
@@ -524,7 +524,7 @@ test_expect_success 'auto tag following fetches minimum' '
 			git tag -a -m $i excess-$i || exit 1
 		done
 	) &&
-	git checkout master &&
+	git checkout main &&
 	(
 		cd follow &&
 		git fetch
@@ -533,13 +533,13 @@ test_expect_success 'auto tag following fetches minimum' '
 
 test_expect_success 'refuse to fetch into the current branch' '
 
-	test_must_fail git fetch . side:master
+	test_must_fail git fetch . side:main
 
 '
 
 test_expect_success 'fetch into the current branch with --update-head-ok' '
 
-	git fetch --update-head-ok . side:master
+	git fetch --update-head-ok . side:main
 
 '
 
@@ -568,7 +568,7 @@ test_expect_success "should be able to fetch with duplicate refspecs" '
 	(
 		cd dups &&
 		git init &&
-		git config branch.master.remote three &&
+		git config branch.main.remote three &&
 		git config remote.three.url ../three/.git &&
 		git config remote.three.fetch +refs/heads/*:refs/remotes/origin/* &&
 		git config --add remote.three.fetch +refs/heads/*:refs/remotes/origin/* &&
@@ -877,11 +877,11 @@ test_expect_success 'all boundary commits are excluded' '
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
@@ -1017,7 +1017,7 @@ setup_negotiation_tip () {
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
index e98c3a0174..fb122fb7b8 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -118,7 +118,7 @@ test_expect_success 'use branch.<name>.remote if possible' '
 	echo "From $URL" >exp_err &&
 
 	git remote add other $URL &&
-	git config branch.master.remote other &&
+	git config branch.main.remote other &&
 
 	git ls-remote 2>actual_err >actual &&
 	test_cmp exp_err actual_err &&
@@ -129,9 +129,9 @@ test_expect_success 'confuses pattern as remote when no remote specified' '
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
@@ -144,7 +144,7 @@ test_expect_success 'confuses pattern as remote when no remote specified' '
 	# Do not expect "git ls-remote <pattern>" to work; ls-remote needs
 	# <remote> if you want to feed <pattern>, just like you cannot say
 	# fetch <branch>.
-	# We could just as easily have used "master"; the "*" emphasizes its
+	# We could just as easily have used "main"; the "*" emphasizes its
 	# role as a pattern.
 	test_must_fail git ls-remote "$does_not_exist" >actual 2>&1 &&
 	test_i18ncmp exp actual
@@ -217,14 +217,14 @@ test_expect_success 'protocol v2 supports hiderefs' '
 
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
@@ -238,7 +238,7 @@ test_expect_success 'ls-remote --symref' '
 test_expect_success 'ls-remote with filtered symref (refname)' '
 	rev=$(git rev-parse HEAD) &&
 	cat >expect <<-EOF &&
-	ref: refs/heads/master	HEAD
+	ref: refs/heads/main	HEAD
 	$rev	HEAD
 	EOF
 	# Protocol v2 supports sending symrefs for refs other than HEAD, so use
@@ -252,7 +252,7 @@ test_expect_failure 'ls-remote with filtered symref (--heads)' '
 	cat >expect <<-EOF &&
 	ref: refs/tags/mark	refs/heads/foo
 	$rev	refs/heads/foo
-	$rev	refs/heads/master
+	$rev	refs/heads/main
 	EOF
 	# Protocol v2 supports sending symrefs for refs other than HEAD, so use
 	# protocol v0 here.
@@ -263,7 +263,7 @@ test_expect_failure 'ls-remote with filtered symref (--heads)' '
 test_expect_success 'ls-remote --symref omits filtered-out matches' '
 	cat >expect <<-EOF &&
 	$rev	refs/heads/foo
-	$rev	refs/heads/master
+	$rev	refs/heads/main
 	EOF
 	# Protocol v2 supports sending symrefs for refs other than HEAD, so use
 	# protocol v0 here.
@@ -330,10 +330,10 @@ test_expect_success 'ls-remote --sort fails gracefully outside repository' '
 
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
index bd202ec6f3..1b0560f901 100755
--- a/t/t5514-fetch-multiple.sh
+++ b/t/t5514-fetch-multiple.sh
@@ -17,7 +17,7 @@ setup_repository () {
 	git add elif &&
 	test_tick &&
 	git commit -m "Second" &&
-	git checkout master
+	git checkout main
 	)
 }
 
@@ -32,16 +32,16 @@ test_expect_success setup '
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
 
@@ -70,15 +70,15 @@ test_expect_success 'git fetch --all should continue if a remote has errors' '
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
 
@@ -92,10 +92,10 @@ test_expect_success 'git fetch --multiple (but only one remote)' '
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
 
@@ -133,13 +133,13 @@ test_expect_success 'git fetch --all (skipFetchAll)' '
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
index d11382f769..522cee7aa6 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -120,13 +120,13 @@ test_expect_success setup '
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
 
@@ -134,9 +134,9 @@ test_expect_success 'fetch without wildcard' '
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
@@ -150,7 +150,7 @@ test_expect_success 'fetch with wildcard' '
 		git config remote.up.fetch "refs/heads/*:refs/remotes/origin/*" &&
 		git fetch up &&
 
-		echo "$the_commit commit	refs/remotes/origin/master" >expect &&
+		echo "$the_commit commit	refs/remotes/origin/main" >expect &&
 		git for-each-ref refs/remotes/origin >actual &&
 		test_cmp expect actual
 	)
@@ -166,7 +166,7 @@ test_expect_success 'fetch with insteadOf' '
 		git config remote.up.fetch "refs/heads/*:refs/remotes/origin/*" &&
 		git fetch up &&
 
-		echo "$the_commit commit	refs/remotes/origin/master" >expect &&
+		echo "$the_commit commit	refs/remotes/origin/main" >expect &&
 		git for-each-ref refs/remotes/origin >actual &&
 		test_cmp expect actual
 	)
@@ -182,7 +182,7 @@ test_expect_success 'fetch with pushInsteadOf (should not rewrite)' '
 		git config remote.up.fetch "refs/heads/*:refs/remotes/origin/*" &&
 		git fetch up &&
 
-		echo "$the_commit commit	refs/remotes/origin/master" >expect &&
+		echo "$the_commit commit	refs/remotes/origin/main" >expect &&
 		git for-each-ref refs/remotes/origin >actual &&
 		test_cmp expect actual
 	)
@@ -191,10 +191,10 @@ test_expect_success 'fetch with pushInsteadOf (should not rewrite)' '
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
@@ -206,7 +206,7 @@ test_expect_success 'push with wildcard' '
 	git push testrepo "refs/heads/*:refs/remotes/origin/*" &&
 	(
 		cd testrepo &&
-		echo "$the_commit commit	refs/remotes/origin/master" >expect &&
+		echo "$the_commit commit	refs/remotes/origin/main" >expect &&
 		git for-each-ref refs/remotes/origin >actual &&
 		test_cmp expect actual
 	)
@@ -216,10 +216,10 @@ test_expect_success 'push with insteadOf' '
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
@@ -229,10 +229,10 @@ test_expect_success 'push with pushInsteadOf' '
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
@@ -244,10 +244,10 @@ test_expect_success 'push with pushInsteadOf and explicit pushurl (pushInsteadOf
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
@@ -255,101 +255,101 @@ test_expect_success 'push with pushInsteadOf and explicit pushurl (pushInsteadOf
 
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
@@ -357,7 +357,7 @@ test_expect_success 'push with ambiguity' '
 test_expect_success 'push with colon-less refspec (1)' '
 
 	mk_test testrepo heads/frotz tags/frotz &&
-	git branch -f frotz master &&
+	git branch -f frotz main &&
 	git push testrepo frotz &&
 	check_push_result testrepo $the_commit heads/frotz &&
 	check_push_result testrepo $the_first_commit tags/frotz
@@ -385,7 +385,7 @@ test_expect_success 'push with colon-less refspec (3)' '
 	then
 		git tag -d frotz
 	fi &&
-	git branch -f frotz master &&
+	git branch -f frotz main &&
 	git push testrepo frotz &&
 	check_push_result testrepo $the_commit heads/frotz &&
 	test 1 = $( cd testrepo && git show-ref | wc -l )
@@ -408,7 +408,7 @@ test_expect_success 'push with colon-less refspec (4)' '
 test_expect_success 'push head with non-existent, incomplete dest' '
 
 	mk_test testrepo &&
-	git push testrepo master:branch &&
+	git push testrepo main:branch &&
 	check_push_result testrepo $the_commit heads/branch
 
 '
@@ -425,42 +425,42 @@ test_expect_success 'push tag with non-existent, incomplete dest' '
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
@@ -477,7 +477,7 @@ test_expect_success 'push with +HEAD' '
 test_expect_success 'push HEAD with non-existent, incomplete dest' '
 
 	mk_test testrepo &&
-	git checkout master &&
+	git checkout main &&
 	git push testrepo HEAD:branch &&
 	check_push_result testrepo $the_commit heads/branch
 
@@ -486,7 +486,7 @@ test_expect_success 'push HEAD with non-existent, incomplete dest' '
 test_expect_success 'push with config remote.*.push = HEAD' '
 
 	mk_test testrepo heads/local &&
-	git checkout master &&
+	git checkout main &&
 	git branch -f local $the_commit &&
 	(
 		cd testrepo &&
@@ -495,166 +495,166 @@ test_expect_success 'push with config remote.*.push = HEAD' '
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
 
@@ -666,25 +666,25 @@ test_expect_success 'pushing valid refs triggers post-receive and post-update ho
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
@@ -695,28 +695,28 @@ test_expect_success 'deleting dangling ref triggers hooks with correct args' '
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
@@ -727,7 +727,7 @@ test_expect_success 'deletion of a non-existent ref is not fed to post-receive a
 '
 
 test_expect_success 'deletion of a non-existent ref alone does trigger post-receive and post-update hooks' '
-	mk_test_with_hooks testrepo heads/master &&
+	mk_test_with_hooks testrepo heads/main &&
 	git push testrepo :refs/heads/nonexistent &&
 	(
 		cd testrepo/.git &&
@@ -747,40 +747,40 @@ test_expect_success 'deletion of a non-existent ref alone does trigger post-rece
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
@@ -793,15 +793,15 @@ test_expect_success 'mixed ref updates, deletes, invalid deletes trigger hooks w
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
@@ -809,56 +809,56 @@ test_expect_success 'allow deleting a tag using --delete' '
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
 
@@ -874,7 +874,7 @@ test_expect_success 'fetch with branches' '
 		git for-each-ref refs/heads >actual &&
 		test_cmp expect actual
 	) &&
-	git checkout master
+	git checkout main
 '
 
 test_expect_success 'fetch with branches containing #' '
@@ -887,7 +887,7 @@ test_expect_success 'fetch with branches containing #' '
 		git for-each-ref refs/heads >actual &&
 		test_cmp expect actual
 	) &&
-	git checkout master
+	git checkout main
 '
 
 test_expect_success 'push with branches' '
@@ -897,7 +897,7 @@ test_expect_success 'push with branches' '
 	git push branch1 &&
 	(
 		cd testrepo &&
-		echo "$the_first_commit commit	refs/heads/master" >expect &&
+		echo "$the_first_commit commit	refs/heads/main" >expect &&
 		git for-each-ref refs/heads >actual &&
 		test_cmp expect actual
 	)
@@ -913,11 +913,11 @@ test_expect_success 'push with branches containing #' '
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
@@ -939,7 +939,7 @@ test_expect_success 'push into aliased refs (consistent)' '
 '
 
 test_expect_success 'push into aliased refs (inconsistent)' '
-	mk_test testrepo heads/master &&
+	mk_test testrepo heads/main &&
 	mk_child testrepo child1 &&
 	mk_child testrepo child2 &&
 	(
@@ -970,7 +970,7 @@ test_force_push_tag () {
 	tag_args=$2
 
 	test_expect_success "force pushing required to update $tag_type_description" "
-		mk_test testrepo heads/master &&
+		mk_test testrepo heads/main &&
 		mk_child testrepo child1 &&
 		mk_child testrepo child2 &&
 		(
@@ -1016,7 +1016,7 @@ test_force_fetch_tag () {
 	tag_args=$2
 
 	test_expect_success "fetch will not clobber an existing $tag_type_description without --force" "
-		mk_test testrepo heads/master &&
+		mk_test testrepo heads/main &&
 		mk_child testrepo child1 &&
 		mk_child testrepo child2 &&
 		(
@@ -1039,12 +1039,12 @@ test_force_fetch_tag "annotated tag" "-f -a -m'tag message'"
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
@@ -1053,52 +1053,52 @@ test_expect_success 'push --porcelain' '
 
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
@@ -1106,18 +1106,18 @@ test_expect_success 'push --prune refspec' '
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
@@ -1131,8 +1131,8 @@ do
 done
 
 test_expect_success 'fetch exact SHA1' '
-	mk_test testrepo heads/master hidden/one &&
-	git push testrepo master:refs/hidden/one &&
+	mk_test testrepo heads/main hidden/one &&
+	git push testrepo main:refs/hidden/one &&
 	(
 		cd testrepo &&
 		git config transfer.hiderefs refs/hidden
@@ -1163,7 +1163,7 @@ test_expect_success 'fetch exact SHA1' '
 			git config uploadpack.allowtipsha1inwant true
 		) &&
 
-		git fetch -v ../testrepo $the_commit:refs/heads/copy master:refs/heads/extra &&
+		git fetch -v ../testrepo $the_commit:refs/heads/copy main:refs/heads/extra &&
 		cat >expect <<-EOF &&
 		$the_commit
 		$the_first_commit
@@ -1177,8 +1177,8 @@ test_expect_success 'fetch exact SHA1' '
 '
 
 test_expect_success 'fetch exact SHA1 in protocol v2' '
-	mk_test testrepo heads/master hidden/one &&
-	git push testrepo master:refs/hidden/one &&
+	mk_test testrepo heads/main hidden/one &&
+	git push testrepo main:refs/hidden/one &&
 	git -C testrepo config transfer.hiderefs refs/hidden &&
 	check_push_result testrepo $the_commit hidden/one &&
 
@@ -1260,17 +1260,17 @@ do
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
@@ -1278,8 +1278,8 @@ test_expect_success 'fetch follows tags by default' '
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
@@ -1298,74 +1298,74 @@ test_expect_success 'peeled advertisements are not considered ref tips' '
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
@@ -1373,20 +1373,20 @@ test_expect_success 'with no remote.$name.push, upstream mapping is used' '
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
@@ -1396,20 +1396,20 @@ test_expect_success 'push does not follow tags by default' '
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
@@ -1427,12 +1427,12 @@ EOF
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
@@ -1455,12 +1455,12 @@ test_expect_success 'push into bare respects core.logallrefupdates' '
 
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
@@ -1475,20 +1475,20 @@ test_expect_success 'fetch into bare respects core.logallrefupdates' '
 
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
@@ -1497,7 +1497,7 @@ test_expect_success 'receive.denyCurrentBranch = updateInstead' '
 	test_commit third path2 &&
 
 	# Try pushing into a repository with pristine working tree
-	git push testrepo master &&
+	git push testrepo main &&
 	(
 		cd testrepo &&
 		git update-index -q --refresh &&
@@ -1514,7 +1514,7 @@ test_expect_success 'receive.denyCurrentBranch = updateInstead' '
 		test $(git -C .. rev-parse HEAD^) = $(git rev-parse HEAD) &&
 		test-tool chmtime +100 path1
 	) &&
-	git push testrepo master &&
+	git push testrepo main &&
 	(
 		cd testrepo &&
 		git update-index -q --refresh &&
@@ -1534,7 +1534,7 @@ test_expect_success 'receive.denyCurrentBranch = updateInstead' '
 		cd testrepo &&
 		echo changed >path1
 	) &&
-	test_must_fail git push testrepo master &&
+	test_must_fail git push testrepo main &&
 	(
 		cd testrepo &&
 		test $(git -C .. rev-parse HEAD^) = $(git rev-parse HEAD) &&
@@ -1548,7 +1548,7 @@ test_expect_success 'receive.denyCurrentBranch = updateInstead' '
 		echo changed >path1 &&
 		git add path1
 	) &&
-	test_must_fail git push testrepo master &&
+	test_must_fail git push testrepo main &&
 	(
 		cd testrepo &&
 		test $(git -C .. rev-parse HEAD^) = $(git rev-parse HEAD) &&
@@ -1565,7 +1565,7 @@ test_expect_success 'receive.denyCurrentBranch = updateInstead' '
 		git reset --hard &&
 		echo changed >path3
 	) &&
-	test_must_fail git push testrepo master &&
+	test_must_fail git push testrepo main &&
 	(
 		cd testrepo &&
 		test $(git -C .. rev-parse HEAD^^) = $(git rev-parse HEAD) &&
@@ -1581,7 +1581,7 @@ test_expect_success 'receive.denyCurrentBranch = updateInstead' '
 		echo fifth >path3 &&
 		git add path3
 	) &&
-	test_must_fail git push testrepo master &&
+	test_must_fail git push testrepo main &&
 	(
 		cd testrepo &&
 		test $(git -C .. rev-parse HEAD^^) = $(git rev-parse HEAD) &&
@@ -1596,17 +1596,17 @@ test_expect_success 'receive.denyCurrentBranch = updateInstead' '
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
@@ -1616,7 +1616,7 @@ test_expect_success 'updateInstead with push-to-checkout hook' '
 	git init testrepo &&
 	(
 		cd testrepo &&
-		git pull .. master &&
+		git pull .. main &&
 		git reset --hard HEAD^^ &&
 		git tag initial &&
 		git config receive.denyCurrentBranch updateInstead &&
@@ -1634,7 +1634,7 @@ test_expect_success 'updateInstead with push-to-checkout hook' '
 	) &&
 
 	# Try pushing into a pristine
-	git push testrepo master &&
+	git push testrepo main &&
 	(
 		cd testrepo &&
 		git diff --quiet &&
@@ -1648,7 +1648,7 @@ test_expect_success 'updateInstead with push-to-checkout hook' '
 		git reset --hard initial &&
 		echo conflicting >path2
 	) &&
-	test_must_fail git push testrepo master &&
+	test_must_fail git push testrepo main &&
 	(
 		cd testrepo &&
 		test $(git rev-parse initial) = $(git rev-parse HEAD) &&
@@ -1664,7 +1664,7 @@ test_expect_success 'updateInstead with push-to-checkout hook' '
 		echo irrelevant >path5 &&
 		git add path5
 	) &&
-	git push testrepo master &&
+	git push testrepo main &&
 	(
 		cd testrepo &&
 		test "$(cat path1)" = unrelated &&
@@ -1704,7 +1704,7 @@ test_expect_success 'updateInstead with push-to-checkout hook' '
 		EOF
 	) &&
 
-	git push void master &&
+	git push void main &&
 	(
 		cd void &&
 		git diff --quiet &&
diff --git a/t/t5517-push-mirror.sh b/t/t5517-push-mirror.sh
index e4edd56404..a4b11495c6 100755
--- a/t/t5517-push-mirror.sh
+++ b/t/t5517-push-mirror.sh
@@ -15,16 +15,16 @@ invert () {
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
@@ -36,13 +36,13 @@ test_expect_success 'push mirror creates new branches' '
 
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
 
@@ -50,15 +50,15 @@ test_expect_success 'push mirror updates existing branches' '
 
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
 
@@ -66,7 +66,7 @@ test_expect_success 'push mirror force updates existing branches' '
 
 	mk_repo_pair &&
 	(
-		cd master &&
+		cd main &&
 		echo one >foo && git add foo && git commit -m one &&
 		git push --mirror up &&
 		echo two >foo && git add foo && git commit -m two &&
@@ -74,9 +74,9 @@ test_expect_success 'push mirror force updates existing branches' '
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
 
@@ -84,9 +84,9 @@ test_expect_success 'push mirror removes branches' '
 
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
@@ -102,21 +102,21 @@ test_expect_success 'push mirror adds, updates and removes branches together' '
 
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
@@ -130,14 +130,14 @@ test_expect_success 'push mirror creates new tags' '
 
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
 
@@ -145,17 +145,17 @@ test_expect_success 'push mirror updates existing tags' '
 
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
 
@@ -163,20 +163,20 @@ test_expect_success 'push mirror force updates existing tags' '
 
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
 
@@ -184,9 +184,9 @@ test_expect_success 'push mirror removes tags' '
 
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
@@ -202,23 +202,23 @@ test_expect_success 'push mirror adds, updates and removes tags together' '
 
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
@@ -230,10 +230,10 @@ test_expect_success 'remote.foo.mirror adds and removes branches' '
 
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
@@ -250,10 +250,10 @@ test_expect_success 'remote.foo.mirror=no has no effect' '
 
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
@@ -268,10 +268,10 @@ test_expect_success 'remote.foo.mirror=no has no effect' '
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
index c2060bb870..78ba5c290a 100755
--- a/t/t5518-fetch-exit-status.sh
+++ b/t/t5518-fetch-exit-status.sh
@@ -17,20 +17,20 @@ test_expect_success setup '
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
index 11fcd37700..1696eb5125 100755
--- a/t/t5519-push-alternates.sh
+++ b/t/t5519-push-alternates.sh
@@ -17,7 +17,7 @@ test_expect_success setup '
 		>file &&
 		git add . &&
 		git commit -m initial &&
-		git push ../alice-pub master
+		git push ../alice-pub main
 	) &&
 
 	# Project Bob is a fork of project Alice
@@ -31,7 +31,7 @@ test_expect_success setup '
 	git clone alice-pub bob-work &&
 	(
 		cd bob-work &&
-		git push ../bob-pub master
+		git push ../bob-pub main
 	)
 '
 
@@ -54,7 +54,7 @@ test_expect_success 'bob fetches from alice, works and pushes' '
 		# has at her public repository are available to it
 		# via its alternates.
 		cd bob-work &&
-		git pull ../alice-pub master &&
+		git pull ../alice-pub main &&
 		echo more bob >file &&
 		git commit -a -m third &&
 		git push ../bob-pub :
@@ -93,7 +93,7 @@ test_expect_success 'alice works and pushes again' '
 test_expect_success 'bob works and pushes' '
 	(
 		# This time Bob does not pull from Alice, and
-		# the master branch at her public repository points
+		# the main branch at her public repository points
 		# at a commit Bob does not know about.  This should
 		# not prevent the push by Bob from succeeding.
 		cd bob-work &&
@@ -122,11 +122,11 @@ test_expect_success 'alice works and pushes yet again' '
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
diff --git a/t/test-lib.sh b/t/test-lib.sh
index ca86f666e6..a12a1993d0 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -263,7 +263,7 @@ case "$TEST_NUMBER" in
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 	;;
-[0-4]*|5[0-4]*|550*)
+[0-4]*|5[0-4]*|55[01]*)
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 	;;
-- 
gitgitgadget

