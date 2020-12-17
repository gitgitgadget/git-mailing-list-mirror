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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0635AC1B0D8
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 01:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C94C322D74
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 01:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731344AbgLQBIg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 20:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729689AbgLQBIf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 20:08:35 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97464C061248
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 17:07:19 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d13so6664475wrc.13
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 17:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=x2Fw571SL4L0/p0ylM/z7EvkzH9jaB8fCyWY5KczG4U=;
        b=P6EzGFdhy+ktas/Zk1fMzgOKak6YnSza4MiVXz94stePpsLE5XpX0umlTn7/shtMNK
         +AhdPLVwz+bEsjBG7Gx3TL1QPfMcfs2ohq+W0jKMtkCncofWtwWh5WJm5zeHJDsbbxik
         c1KtYb1bC/An060Nua88Ai6XmKg5xRRhUmurGFz8rC8a/J+2FQ/rptR4jA/5nBlgV4w1
         ptbZmJ2HNjfjv0PPRImPDo8lmsvtrYWguG3c+6BlcytE4OFo/MHPl0R0bT/7wzHb2SGc
         9O2WHS1XirQIT7uftFMl9BTnJErjPHycrDyvy4176Ya5Mv02Zx79De5j0BOIpkjcTtJ8
         Zilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=x2Fw571SL4L0/p0ylM/z7EvkzH9jaB8fCyWY5KczG4U=;
        b=h9NEHneGhrbGB+Fxnue3bRqwkuz0RFPlBiRlsb2ucYc/hqfm0RS7615fGthgvdWRyO
         Lo/FYKStth13lVFGZpW3QMLTAN/QoEUCcOLVPRpKGjrO3f1wVDD2qzlzBYoVRZtfqGxz
         6Ep/I+y49eYi4zk2QXW+u4fzGmmZLtdb3gXgujpEFYP7qNa68HLFKhxlkc2TGQgYGUV3
         Oo4abZwoX4znJ1Lzowqe7LLaRH44PtD718y9A2qC1TzOZnkz8ThPjsETVLM68FgmE5mM
         U9UDAmbtjZ48rU/7ExYeBBWfcLVXeXize/+lI3g03iaGVg8ZE1paCi/zlw5s1mFb+ozJ
         eMMA==
X-Gm-Message-State: AOAM532w0vAwEMc1U6BXUWl9/F8nN7Yj/xafy/6iVnG4FcRUkgNMMUrA
        9i41xypvpSe5OpUOSHm/48lVUBzda6E=
X-Google-Smtp-Source: ABdhPJxvHgZGSawRZKZB593ys/eIsqLw6xqHba762hmzIQbcoqlGwzbaBKA9oWcHLjnGKsSOCEmkXA==
X-Received: by 2002:adf:97ce:: with SMTP id t14mr41110619wrb.368.1608167237810;
        Wed, 16 Dec 2020 17:07:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f77sm4145259wmf.42.2020.12.16.17.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 17:07:17 -0800 (PST)
Message-Id: <5ad7c105cf97322b2302ef24887926a5e8582929.1608167230.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.816.git.1608167230.gitgitgadget@gmail.com>
References: <pull.816.git.1608167230.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Dec 2020 01:07:06 +0000
Subject: [PATCH 07/11] t5510: use `main` as initial branch name
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
name, 2020-10-23), we prepared this test script for a time when the
default initial branch name would be `main`.

However, there is no need to wait for that: let's adjust the test script
to stop relying on a specific initial branch name by setting it
explicitly. This allows us to drop the `PREPARE_FOR_MAIN_BRANCH` prereq
from two test cases.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5510-fetch.sh | 168 ++++++++++++++++++++++++-----------------------
 1 file changed, 85 insertions(+), 83 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 5d673358f9b..2013051a64e 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -25,7 +25,9 @@ convert_bundle_to_pack () {
 test_expect_success setup '
 	echo >file original &&
 	git add file &&
-	git commit -a -m original'
+	git commit -a -m original &&
+	git branch -M main
+'
 
 test_expect_success "clone and setup child repos" '
 	git clone . one &&
@@ -37,19 +39,19 @@ test_expect_success "clone and setup child repos" '
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
@@ -65,7 +67,7 @@ test_expect_success "fetch test" '
 	git fetch &&
 	git rev-parse --verify refs/heads/one &&
 	mine=$(git rev-parse refs/heads/one) &&
-	his=$(cd ../one && git rev-parse refs/heads/master) &&
+	his=$(cd ../one && git rev-parse refs/heads/main) &&
 	test "z$mine" = "z$his"
 '
 
@@ -75,11 +77,11 @@ test_expect_success "fetch test for-merge" '
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
@@ -88,7 +90,7 @@ test_expect_success 'fetch --prune on its own works as expected' '
 	cd "$D" &&
 	git clone . prune &&
 	cd prune &&
-	git update-ref refs/remotes/origin/extrabranch master &&
+	git update-ref refs/remotes/origin/extrabranch main &&
 
 	git fetch --prune origin &&
 	test_must_fail git rev-parse origin/extrabranch
@@ -98,9 +100,9 @@ test_expect_success 'fetch --prune with a branch name keeps branches' '
 	cd "$D" &&
 	git clone . prune-branch &&
 	cd prune-branch &&
-	git update-ref refs/remotes/origin/extrabranch master &&
+	git update-ref refs/remotes/origin/extrabranch main &&
 
-	git fetch --prune origin master &&
+	git fetch --prune origin main &&
 	git rev-parse origin/extrabranch
 '
 
@@ -110,18 +112,18 @@ test_expect_success 'fetch --prune with a namespace keeps other namespaces' '
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
@@ -129,7 +131,7 @@ test_expect_success 'fetch --prune handles overlapping refspecs' '
 	git config --add remote.origin.fetch refs/heads/*:refs/remotes/origin/* &&
 
 	git fetch --prune origin &&
-	git rev-parse origin/master &&
+	git rev-parse origin/main &&
 	git rev-parse origin/pr/42
 '
 
@@ -137,13 +139,13 @@ test_expect_success 'fetch --prune --tags prunes branches but not tags' '
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
@@ -152,10 +154,10 @@ test_expect_success 'fetch --prune --tags with branch does not prune other thing
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
@@ -164,9 +166,9 @@ test_expect_success 'fetch --prune --tags with refspec prunes based on refspec'
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
@@ -177,20 +179,20 @@ test_expect_success 'fetch --prune --tags with refspec prunes based on refspec'
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
@@ -250,7 +252,7 @@ test_expect_success 'fetch uses remote ref names to describe new refs' '
 		test_i18ngrep "new tag.* -> descriptive-tag$" actual &&
 		test_i18ngrep "new ref.* -> crazy$" actual
 	) &&
-	git checkout master
+	git checkout main
 '
 
 test_expect_success 'fetch must not resolve short tag name' '
@@ -281,7 +283,7 @@ test_expect_success 'create bundle 1' '
 	cd "$D" &&
 	echo >file updated again by origin &&
 	git commit -a -m "tip" &&
-	git bundle create --version=3 bundle1 master^..master
+	git bundle create --version=3 bundle1 main^..main
 '
 
 test_expect_success 'header of bundle looks right' '
@@ -289,7 +291,7 @@ test_expect_success 'header of bundle looks right' '
 	# v3 git bundle
 	@object-format=$(test_oid algo)
 	-OID updated by origin
-	OID refs/heads/master
+	OID refs/heads/main
 
 	EOF
 	sed -e "s/$OID_REGEX/OID/g" -e "5q" "$D"/bundle1 >actual &&
@@ -298,13 +300,13 @@ test_expect_success 'header of bundle looks right' '
 
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
 
 
@@ -317,8 +319,8 @@ test_expect_success 'bundle 1 has only 3 files ' '
 
 test_expect_success 'unbundle 2' '
 	cd "$D/bundle" &&
-	git fetch ../bundle2 master:master &&
-	test "tip" = "$(git log -1 --pretty=oneline master | cut -d" " -f2)"
+	git fetch ../bundle2 main:main &&
+	test "tip" = "$(git log -1 --pretty=oneline main | cut -d" " -f2)"
 '
 
 test_expect_success 'bundle does not prerequisite objects' '
@@ -335,14 +337,14 @@ test_expect_success 'bundle does not prerequisite objects' '
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
@@ -362,8 +364,8 @@ test_expect_success 'fetch from GIT URL with a non-applying branch.<name>.merge
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
@@ -373,7 +375,7 @@ test_expect_success 'fetch from GIT URL with a non-applying branch.<name>.merge
 # URL supplied to fetch matches the url of the configured branch's remote, but
 # the merge spec does not match the branch the remote HEAD points to
 test_expect_success 'fetch from GIT URL with a non-applying branch.<name>.merge [3]' '
-	git config branch.master.merge "${one_ref}_not" &&
+	git config branch.main.merge "${one_ref}_not" &&
 	git update-ref -d FETCH_HEAD &&
 	git fetch one &&
 	test $one_head = "$(git rev-parse --verify FETCH_HEAD)" &&
@@ -389,9 +391,9 @@ test_expect_success 'quoting of a strangely named repo' '
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
@@ -399,10 +401,10 @@ test_expect_success 'bundle should record HEAD correctly' '
 
 '
 
-test_expect_success 'mark initial state of origin/master' '
+test_expect_success 'mark initial state of origin/main' '
 	(
 		cd three &&
-		git tag base-origin-master refs/remotes/origin/master
+		git tag base-origin-main refs/remotes/origin/main
 	)
 '
 
@@ -412,10 +414,10 @@ test_expect_success 'explicit fetch should update tracking' '
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
@@ -427,10 +429,10 @@ test_expect_success 'explicit pull should update tracking' '
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
@@ -449,13 +451,13 @@ test_expect_success 'explicit --refmap option overrides remote.*.fetch' '
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
 
@@ -464,10 +466,10 @@ test_expect_success 'explicitly empty --refmap option disables remote.*.fetch' '
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
@@ -479,10 +481,10 @@ test_expect_success 'configured fetch updates tracking' '
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
@@ -493,12 +495,12 @@ test_expect_success 'non-matching refspecs do not confuse tracking update' '
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
@@ -524,7 +526,7 @@ test_expect_success 'auto tag following fetches minimum' '
 			git tag -a -m $i excess-$i || exit 1
 		done
 	) &&
-	git checkout master &&
+	git checkout main &&
 	(
 		cd follow &&
 		git fetch
@@ -533,13 +535,13 @@ test_expect_success 'auto tag following fetches minimum' '
 
 test_expect_success 'refuse to fetch into the current branch' '
 
-	test_must_fail git fetch . side:master
+	test_must_fail git fetch . side:main
 
 '
 
 test_expect_success 'fetch into the current branch with --update-head-ok' '
 
-	git fetch --update-head-ok . side:master
+	git fetch --update-head-ok . side:main
 
 '
 
@@ -568,7 +570,7 @@ test_expect_success "should be able to fetch with duplicate refspecs" '
 	(
 		cd dups &&
 		git init &&
-		git config branch.master.remote three &&
+		git config branch.main.remote three &&
 		git config remote.three.url ../three/.git &&
 		git config remote.three.fetch +refs/heads/*:refs/remotes/origin/* &&
 		git config --add remote.three.fetch +refs/heads/*:refs/remotes/origin/* &&
@@ -877,11 +879,11 @@ test_expect_success 'all boundary commits are excluded' '
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
@@ -942,7 +944,7 @@ test_expect_success 'fetching with auto-gc does not lock up' '
 	)
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH,C_LOCALE_OUTPUT 'fetch aligned output' '
+test_expect_success C_LOCALE_OUTPUT 'fetch aligned output' '
 	git clone . full-output &&
 	test_commit looooooooooooong-tag &&
 	(
@@ -957,7 +959,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH,C_LOCALE_OUTPUT 'fetch aligned outpu
 	test_cmp expect actual
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH,C_LOCALE_OUTPUT 'fetch compact output' '
+test_expect_success C_LOCALE_OUTPUT 'fetch compact output' '
 	git clone . compact &&
 	test_commit extraaa &&
 	(
@@ -1001,7 +1003,7 @@ setup_negotiation_tip () {
 	USE_PROTOCOL_V2="$3"
 
 	rm -rf "$SERVER" client trace &&
-	git init "$SERVER" &&
+	git init -b main "$SERVER" &&
 	test_commit -C "$SERVER" alpha_1 &&
 	test_commit -C "$SERVER" alpha_2 &&
 	git -C "$SERVER" checkout --orphan beta &&
@@ -1017,7 +1019,7 @@ setup_negotiation_tip () {
 	fi &&
 
 	test_commit -C "$SERVER" beta_s &&
-	git -C "$SERVER" checkout master &&
+	git -C "$SERVER" checkout main &&
 	test_commit -C "$SERVER" alpha_s &&
 	git -C "$SERVER" tag -d alpha_1 alpha_2 beta_1 beta_2
 }
-- 
gitgitgadget

