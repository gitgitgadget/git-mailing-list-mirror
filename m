Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B97AC07E9E
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3122D613AB
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhGEMfv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbhGEMfu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 08:35:50 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0DAC06175F
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 05:33:12 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id s17so20658993oij.0
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 05:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JfTUuV5jJT6i1tmtxrZIocTKxMUFp9EVp7mzLHla8Yk=;
        b=Y29TaTiIUKNExoUyL2xYZ33DauFTIF4UcZ3miMQmJ6c3HDXad2+698f143x4cm5Bho
         GA0Y7iNr8ZoVmRtw+M+MtzAD06Q0Mhi2/FPi3rt5s2gha1E/TURQ8ucmEl96JIUJFpsR
         RdBSl3xdMoV7yDoYQDvL+MYo7x9vV/gYiD4prIboy/b71apW3nc9cgK0GQaMQKHIP7wc
         o9oz8h1Jv7p60vVvIykOHzs7tdskKvKPwzEMYHLltkcQoqdMBQSY0imBFatQHq4apqu0
         z4PrIY+vZZ3Dv9bcGpyjxa+hMZkNaguCDsjaG8q8K1TSGOtO+atxFm4qHreDLECeW6f6
         bEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JfTUuV5jJT6i1tmtxrZIocTKxMUFp9EVp7mzLHla8Yk=;
        b=piZZynyqXjx0hpnGMTtaRX9z+mdebU8xT+ZW1vByJpMb4pRbAMGxceIRCTwNKCfB4r
         cqBwB0zeEgtvfoN0ardYuyydS1nbvSuQzueNgbDgIG0yKwXXG1qoNfNwuMEPZ0TZEyVb
         e2vCxEwLffJpVUL6GhleqTLHn6U0Lrs0tifwu5tKAAS3xkgZ50Do9WOdwRdpGuRkxQvo
         bpdnQO2328Ld2byLEs+Y1j4/L8Wu+xejjvGNspQQsEnvXC1hG8Keu4AW+BMBi4uQAD5X
         sGAts8ae2zDomSquPhEVhmv0j0FiViqMmYG9qNPXNqQxoacmHhr+rcgKR1beUotm26EC
         gRCw==
X-Gm-Message-State: AOAM530GVsav8ARGZ/+gB7E7IJnGuFFmZMIZxXQodP3PREk5QlPJJdhF
        AlV1vRmnErB70CPH5G/H44wi8J+HxssMXw==
X-Google-Smtp-Source: ABdhPJxqZ0MOjMGXUj9Qp7+W+A//3d9LiMyYA7kHt9CDBzUitT25dlOlHEWQuUg7Pbq/jT+i0X4+hA==
X-Received: by 2002:aca:d755:: with SMTP id o82mr9938561oig.178.1625488391579;
        Mon, 05 Jul 2021 05:33:11 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id v62sm2620922oig.10.2021.07.05.05.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 05:33:11 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 35/35] !fixup FUTURE: pull: enable ff-only mode by default
Date:   Mon,  5 Jul 2021 07:32:09 -0500
Message-Id: <20210705123209.1808663-36-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
In-Reply-To: <20210705123209.1808663-1-felipe.contreras@gmail.com>
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix all the tests.

TODO: some of these should probably not even use `git pull .` but
`git merge` instead.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t4013-diff-various.sh       |  2 +-
 t/t5520-pull.sh               | 16 ++++++++--------
 t/t5521-pull-options.sh       |  4 ++--
 t/t5524-pull-msg.sh           |  4 ++--
 t/t5553-set-upstream.sh       | 14 +++++++-------
 t/t5604-clone-reference.sh    |  4 ++--
 t/t6402-merge-rename.sh       | 16 ++++++++--------
 t/t6409-merge-subtree.sh      |  6 +++---
 t/t6417-merge-ours-theirs.sh  | 10 +++++-----
 t/t7603-merge-reduce-heads.sh |  2 +-
 10 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 7fadc985cc..48ae585e1a 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -65,7 +65,7 @@ test_expect_success setup '
 	export GIT_AUTHOR_DATE GIT_COMMITTER_DATE &&
 
 	git checkout master &&
-	git pull -s ours . side &&
+	git pull --merge -s ours . side &&
 
 	GIT_AUTHOR_DATE="2006-06-26 00:05:00 +0000" &&
 	GIT_COMMITTER_DATE="2006-06-26 00:05:00 +0000" &&
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index dea3ea8c37..ad4fe1998e 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -226,7 +226,7 @@ test_expect_success 'fail if the index has unresolved entries' '
 	test_commit modified2 file &&
 	git ls-files -u >unmerged &&
 	test_must_be_empty unmerged &&
-	test_must_fail git pull . second &&
+	test_must_fail git pull --merge . second &&
 	git ls-files -u >unmerged &&
 	test_file_not_empty unmerged &&
 	cp file expected &&
@@ -409,37 +409,37 @@ test_expect_success 'pull --rebase --no-autostash & rebase.autostash unset' '
 
 test_expect_success 'pull succeeds with dirty working directory and merge.autostash set' '
 	test_config merge.autostash true &&
-	test_pull_autostash 2
+	test_pull_autostash 2 --merge
 '
 
 test_expect_success 'pull --autostash & merge.autostash=true' '
 	test_config merge.autostash true &&
-	test_pull_autostash 2 --autostash
+	test_pull_autostash 2 --merge --autostash
 '
 
 test_expect_success 'pull --autostash & merge.autostash=false' '
 	test_config merge.autostash false &&
-	test_pull_autostash 2 --autostash
+	test_pull_autostash 2 --merge --autostash
 '
 
 test_expect_success 'pull --autostash & merge.autostash unset' '
 	test_unconfig merge.autostash &&
-	test_pull_autostash 2 --autostash
+	test_pull_autostash 2 --merge --autostash
 '
 
 test_expect_success 'pull --no-autostash & merge.autostash=true' '
 	test_config merge.autostash true &&
-	test_pull_autostash_fail --no-autostash
+	test_pull_autostash_fail --merge --no-autostash
 '
 
 test_expect_success 'pull --no-autostash & merge.autostash=false' '
 	test_config merge.autostash false &&
-	test_pull_autostash_fail --no-autostash
+	test_pull_autostash_fail --merge --no-autostash
 '
 
 test_expect_success 'pull --no-autostash & merge.autostash unset' '
 	test_unconfig merge.autostash &&
-	test_pull_autostash_fail --no-autostash
+	test_pull_autostash_fail --merge --no-autostash
 '
 
 test_expect_success 'pull.rebase' '
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index 63a688bdbf..361800a6f4 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -113,7 +113,7 @@ test_expect_success 'git pull --force' '
 	git pull two &&
 	test_commit A &&
 	git branch -f origin &&
-	git pull --all --force
+	git pull --all --force --merge
 	)
 '
 
@@ -179,7 +179,7 @@ test_expect_success 'git pull --allow-unrelated-histories' '
 	(
 		cd dst &&
 		test_must_fail git pull ../src side &&
-		git pull --allow-unrelated-histories ../src side
+		git pull --allow-unrelated-histories --merge ../src side
 	)
 '
 
diff --git a/t/t5524-pull-msg.sh b/t/t5524-pull-msg.sh
index c278adaa5a..2f8a20de18 100755
--- a/t/t5524-pull-msg.sh
+++ b/t/t5524-pull-msg.sh
@@ -28,7 +28,7 @@ test_expect_success setup '
 test_expect_success pull '
 (
 	cd cloned &&
-	git pull --log &&
+	git pull --log --merge &&
 	git log -2 &&
 	git cat-file commit HEAD >result &&
 	grep Dollar result
@@ -41,7 +41,7 @@ test_expect_success '--log=1 limits shortlog length' '
 	git reset --hard HEAD^ &&
 	test "$(cat afile)" = original &&
 	test "$(cat bfile)" = added &&
-	git pull --log=1 &&
+	git pull --log=1 --merge &&
 	git log -3 &&
 	git cat-file commit HEAD >result &&
 	grep Dollar result &&
diff --git a/t/t5553-set-upstream.sh b/t/t5553-set-upstream.sh
index b1d614ce18..dabbea76d3 100755
--- a/t/t5553-set-upstream.sh
+++ b/t/t5553-set-upstream.sh
@@ -108,27 +108,27 @@ test_expect_success 'setup commit on main and other pull' '
 
 test_expect_success 'pull --set-upstream upstream main sets branch main but not other' '
 	clear_config main other &&
-	git pull --set-upstream upstream main &&
+	git pull --merge --set-upstream upstream main &&
 	check_config main upstream refs/heads/main &&
 	check_config_missing other
 '
 
 test_expect_success 'pull --set-upstream main:other2 does not set the branch other2' '
 	clear_config other2 &&
-	git pull --set-upstream upstream main:other2 &&
+	git pull --merge --set-upstream upstream main:other2 &&
 	check_config_missing other2
 '
 
 test_expect_success 'pull --set-upstream upstream other sets branch main' '
 	clear_config main other &&
-	git pull --set-upstream upstream other &&
+	git pull --merge --set-upstream upstream other &&
 	check_config main upstream refs/heads/other &&
 	check_config_missing other
 '
 
 test_expect_success 'pull --set-upstream upstream tag does not set the tag' '
 	clear_config three &&
-	git pull --tags --set-upstream upstream three &&
+	git pull --merge --tags --set-upstream upstream three &&
 	check_config_missing three
 '
 
@@ -144,16 +144,16 @@ test_expect_success 'pull --set-upstream http://nosuchdomain.example.com fails w
 
 test_expect_success 'pull --set-upstream upstream HEAD sets branch HEAD' '
 	clear_config main other &&
-	git pull --set-upstream upstream HEAD &&
+	git pull --merge --set-upstream upstream HEAD &&
 	check_config main upstream HEAD &&
 	git checkout other &&
-	git pull --set-upstream upstream HEAD &&
+	git pull --merge --set-upstream upstream HEAD &&
 	check_config other upstream HEAD
 '
 
 test_expect_success 'pull --set-upstream upstream with more than one branch does nothing' '
 	clear_config main three &&
-	git pull --set-upstream upstream main three &&
+	git pull --merge --set-upstream upstream main three &&
 	check_config_missing main &&
 	check_config_missing three
 '
diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
index e845d621f6..1c9b121814 100755
--- a/t/t5604-clone-reference.sh
+++ b/t/t5604-clone-reference.sh
@@ -87,7 +87,7 @@ test_expect_success 'updating origin' '
 '
 
 test_expect_success 'pulling changes from origin' '
-	git -C C pull origin
+	git -C C pull --merge origin
 '
 
 # the 2 local objects are commit and tree from the merge
@@ -96,7 +96,7 @@ test_expect_success 'that alternate to origin gets used' '
 '
 
 test_expect_success 'pulling changes from origin' '
-	git -C D pull origin
+	git -C D pull --merge origin
 '
 
 # the 5 local objects are expected; file3 blob, commit in A to add it
diff --git a/t/t6402-merge-rename.sh b/t/t6402-merge-rename.sh
index 425dad97d5..833b799e25 100755
--- a/t/t6402-merge-rename.sh
+++ b/t/t6402-merge-rename.sh
@@ -103,7 +103,7 @@ test_expect_success 'setup' '
 test_expect_success 'pull renaming branch into unrenaming one' \
 '
 	git show-branch &&
-	test_expect_code 1 git pull . white &&
+	test_expect_code 1 git pull --merge . white &&
 	git ls-files -s &&
 	git ls-files -u B >b.stages &&
 	test_line_count = 3 b.stages &&
@@ -121,7 +121,7 @@ test_expect_success 'pull renaming branch into another renaming one' \
 	rm -f B &&
 	git reset --hard &&
 	git checkout red &&
-	test_expect_code 1 git pull . white &&
+	test_expect_code 1 git pull --merge . white &&
 	git ls-files -u B >b.stages &&
 	test_line_count = 3 b.stages &&
 	git ls-files -s N >n.stages &&
@@ -137,7 +137,7 @@ test_expect_success 'pull unrenaming branch into renaming one' \
 '
 	git reset --hard &&
 	git show-branch &&
-	test_expect_code 1 git pull . main &&
+	test_expect_code 1 git pull --merge . main &&
 	git ls-files -u B >b.stages &&
 	test_line_count = 3 b.stages &&
 	git ls-files -s N >n.stages &&
@@ -153,7 +153,7 @@ test_expect_success 'pull conflicting renames' \
 '
 	git reset --hard &&
 	git show-branch &&
-	test_expect_code 1 git pull . blue &&
+	test_expect_code 1 git pull --merge . blue &&
 	git ls-files -u A >a.stages &&
 	test_line_count = 1 a.stages &&
 	git ls-files -u B >b.stages &&
@@ -173,7 +173,7 @@ test_expect_success 'interference with untracked working tree file' '
 	git reset --hard &&
 	git show-branch &&
 	echo >A this file should not matter &&
-	test_expect_code 1 git pull . white &&
+	test_expect_code 1 git pull --merge . white &&
 	test_path_is_file A
 '
 
@@ -183,7 +183,7 @@ test_expect_success 'interference with untracked working tree file' '
 	git show-branch &&
 	rm -f A &&
 	echo >A this file should not matter &&
-	test_expect_code 1 git pull . red &&
+	test_expect_code 1 git pull --merge . red &&
 	test_path_is_file A
 '
 
@@ -193,7 +193,7 @@ test_expect_success 'interference with untracked working tree file' '
 	git checkout -f main &&
 	git tag -f anchor &&
 	git show-branch &&
-	git pull . yellow &&
+	git pull --merge . yellow &&
 	test_path_is_missing M &&
 	git reset --hard anchor
 '
@@ -232,7 +232,7 @@ test_expect_success 'interference with untracked working tree file' '
 	git tag -f anchor &&
 	git show-branch &&
 	echo >M this file should not matter &&
-	git pull . main &&
+	git pull --merge . main &&
 	test_path_is_file M &&
 	! {
 		git ls-files -s |
diff --git a/t/t6409-merge-subtree.sh b/t/t6409-merge-subtree.sh
index d406b2343c..e1011f6325 100755
--- a/t/t6409-merge-subtree.sh
+++ b/t/t6409-merge-subtree.sh
@@ -100,7 +100,7 @@ test_expect_success 'merge update' '
 	git checkout -b topic_2 &&
 	git commit -m "update git-gui" &&
 	cd ../git &&
-	git pull -s subtree gui topic_2 &&
+	git pull --merge -s subtree gui topic_2 &&
 	git ls-files -s >actual &&
 	(
 		echo "100644 $o3 0	git-gui/git-gui.sh" &&
@@ -129,7 +129,7 @@ test_expect_success 'initial ambiguous subtree' '
 test_expect_success 'merge using explicit' '
 	cd ../git &&
 	git reset --hard topic_2 &&
-	git pull -Xsubtree=git-gui gui topic_2 &&
+	git pull --merge -Xsubtree=git-gui gui topic_2 &&
 	git ls-files -s >actual &&
 	(
 		echo "100644 $o3 0	git-gui/git-gui.sh" &&
@@ -142,7 +142,7 @@ test_expect_success 'merge using explicit' '
 test_expect_success 'merge2 using explicit' '
 	cd ../git &&
 	git reset --hard topic_2 &&
-	git pull -Xsubtree=git-gui2 gui topic_2 &&
+	git pull --merge -Xsubtree=git-gui2 gui topic_2 &&
 	git ls-files -s >actual &&
 	(
 		echo "100644 $o1 0	git-gui/git-gui.sh" &&
diff --git a/t/t6417-merge-ours-theirs.sh b/t/t6417-merge-ours-theirs.sh
index ac9aee9a66..06cebb2974 100755
--- a/t/t6417-merge-ours-theirs.sh
+++ b/t/t6417-merge-ours-theirs.sh
@@ -69,11 +69,11 @@ test_expect_success 'binary file with -Xours/-Xtheirs' '
 '
 
 test_expect_success 'pull passes -X to underlying merge' '
-	git reset --hard main && git pull -s recursive -Xours . side &&
-	git reset --hard main && git pull -s recursive -X ours . side &&
-	git reset --hard main && git pull -s recursive -Xtheirs . side &&
-	git reset --hard main && git pull -s recursive -X theirs . side &&
-	git reset --hard main && test_must_fail git pull -s recursive -X bork . side
+	git reset --hard main && git pull --merge -s recursive -Xours . side &&
+	git reset --hard main && git pull --merge -s recursive -X ours . side &&
+	git reset --hard main && git pull --merge -s recursive -Xtheirs . side &&
+	git reset --hard main && git pull --merge -s recursive -X theirs . side &&
+	git reset --hard main && test_must_fail git pull --merge -s recursive -X bork . side
 '
 
 test_expect_success SYMLINKS 'symlink with -Xours/-Xtheirs' '
diff --git a/t/t7603-merge-reduce-heads.sh b/t/t7603-merge-reduce-heads.sh
index 98948955ae..566b1c1a2a 100755
--- a/t/t7603-merge-reduce-heads.sh
+++ b/t/t7603-merge-reduce-heads.sh
@@ -68,7 +68,7 @@ test_expect_success 'merge c1 with c2, c3, c4, c5' '
 
 test_expect_success 'pull c2, c3, c4, c5 into c1' '
 	git reset --hard c1 &&
-	git pull . c2 c3 c4 c5 &&
+	git pull --merge . c2 c3 c4 c5 &&
 	test "$(git rev-parse c1)" != "$(git rev-parse HEAD)" &&
 	test "$(git rev-parse c1)" = "$(git rev-parse HEAD^1)" &&
 	test "$(git rev-parse c2)" = "$(git rev-parse HEAD^2)" &&
-- 
2.32.0.36.g70aac2b1aa

