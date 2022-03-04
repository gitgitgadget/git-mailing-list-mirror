Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB18FC433FE
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 00:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237477AbiCDA7A (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 19:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237462AbiCDA65 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 19:58:57 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0907DEA20
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 16:58:09 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id y3-20020a1709029b8300b0014c8bcb70a1so3794194plp.3
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 16:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UtiFQDHyGZ99aHGiC9oJyVT0l3UY3UzqhzzOESuQXws=;
        b=RZhXrscyuLHDHKEyNDZ0oA9s9/G8jK4UNZrcM61NF/7UzTgxybDlMrAMDt8z0KRdwh
         6zX1c/1hJ8xB1Qie17fcnwUSeMmC6572PciYVCPE3Xr79Vb2P9LwtQ9Vz0HzhCvsP79Q
         QpILb65ArP/NXxorfg0SZe9jATT7Ubo4VqQF0YgXqn7CLQDXd/06S7iCoczjlaivlRXs
         sPT75H/Sl1iQN0AeYS3oxWor3fjTjCG5mjTsu4QZBj2torpOAprlVE15zSQFfSmk4L6g
         qYKlclUF4usWjopW0BBSke9V5LDlGdmCm/EbisLkgbFoV5h+E7Fk3Z5agOAGyxmbpVW2
         RRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UtiFQDHyGZ99aHGiC9oJyVT0l3UY3UzqhzzOESuQXws=;
        b=Emyy+p1kaojMKA4JLHNsK+VnCRZflN/5vkwpYWjGJ100LK0CMdO+MvMAp7RoO44y7f
         l0q9hGbc+5soL3xxzHVNnC9BaLnEyUHQQnJOH8yCbIfwH776aYg5ANcEfKxMukM+4CuE
         pPl1tTURvr/U+Pc/Mv8uKsY6a3uEnHLD/uDC1gXehD6JtE3oUH1ipslUmbDGDsaDLJyz
         afRbXZRaKy31LKmqfC93ONteFD15hKhCuR6KB3yj2ah8ibUmRLXGAhQ6xFZWP3bWhmjk
         ZaFlCaTCqB6c0EdrCdpTxl0iyjN1PBAczvDxo9zQwJ5eZVo6L+11QUsuCp4Q0Oj7Qb08
         9ddg==
X-Gm-Message-State: AOAM532BacmnJ1JjiW69F49XholmBXdQe74earLKv3T1YesdKciOMMZZ
        fuLwQGvPE/SdpMwScggr90pcrGrNRzpgvCsmNK3wXByuJgdEpeGr14Y1Pqdw40A0L2AxZi4pQg4
        Mor2TgpMEo5YdJ8hOe1J6N+CZOprQdFn5I8wBLhyfWSfjdPzcRAQTi7+vOGzeOys=
X-Google-Smtp-Source: ABdhPJxTegZysOoNs3OQ82ov5RifdZzpXEA+3T0aG4v2oUjWihXEtGnXFz7DkmZDKgtFI/qC7aD3V0Cw3hcdcA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:aa7:820b:0:b0:4f1:2d08:5e90 with SMTP id
 k11-20020aa7820b000000b004f12d085e90mr34820993pfi.31.1646355489349; Thu, 03
 Mar 2022 16:58:09 -0800 (PST)
Date:   Thu,  3 Mar 2022 16:57:49 -0800
In-Reply-To: <20220304005757.70107-1-chooglen@google.com>
Message-Id: <20220304005757.70107-3-chooglen@google.com>
Mime-Version: 1.0
References: <20220224100842.95827-1-chooglen@google.com> <20220304005757.70107-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v4 02/10] t5526: stop asserting on stderr literally
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the previous commit message, we noted that not all of the "git fetch"
stderr is relevant to the tests. Most of the test setup lines are
dedicated to these details of the stderr:

1. which repos (super/sub/deep) are involved in the fetch
2. the head of the remote-tracking branch before the fetch (i.e. $head1)
3. the head of the remote-tracking branch after the fetch (i.e. $head2)

1. and 3. are relevant because they tell us that the expected commit is
fetched by the expected repo, but 2. is completely irrelevant.

Stop asserting on $head1 by replacing it with a dummy value in the
actual and expected output. Do this by introducing test
helpers (check_*()) that make it easier to construct the expected
output, and use sed to munge the actual output.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 t/t5526-fetch-submodules.sh | 119 +++++++++++++++++-------------------
 1 file changed, 57 insertions(+), 62 deletions(-)

diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index dff7a4b90b..6b24d37b2b 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -10,6 +10,32 @@ export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
 
 pwd=$(pwd)
 
+check_sub () {
+	NEW_HEAD=$1 &&
+	cat >$pwd/expect.err.sub <<-EOF
+	Fetching submodule submodule
+	From $pwd/submodule
+	   OLD_HEAD..$NEW_HEAD  sub        -> origin/sub
+	EOF
+}
+
+check_deep () {
+	NEW_HEAD=$1 &&
+	cat >$pwd/expect.err.deep <<-EOF
+	Fetching submodule submodule/subdir/deepsubmodule
+	From $pwd/deepsubmodule
+	   OLD_HEAD..$NEW_HEAD  deep       -> origin/deep
+	EOF
+}
+
+check_super () {
+	NEW_HEAD=$1 &&
+	cat >$pwd/expect.err.super <<-EOF
+	From $pwd/.
+	   OLD_HEAD..$NEW_HEAD  super      -> origin/super
+	EOF
+}
+
 # For each submodule in the test setup, this creates a commit and writes
 # a file that contains the expected err if that new commit were fetched.
 # These output files get concatenated in the right order by
@@ -17,27 +43,21 @@ pwd=$(pwd)
 add_upstream_commit() {
 	(
 		cd submodule &&
-		head1=$(git rev-parse --short HEAD) &&
 		echo new >> subfile &&
 		test_tick &&
 		git add subfile &&
 		git commit -m new subfile &&
-		head2=$(git rev-parse --short HEAD) &&
-		echo "Fetching submodule submodule" > ../expect.err.sub &&
-		echo "From $pwd/submodule" >> ../expect.err.sub &&
-		echo "   $head1..$head2  sub        -> origin/sub" >> ../expect.err.sub
+		new_head=$(git rev-parse --short HEAD) &&
+		check_sub $new_head
 	) &&
 	(
 		cd deepsubmodule &&
-		head1=$(git rev-parse --short HEAD) &&
 		echo new >> deepsubfile &&
 		test_tick &&
 		git add deepsubfile &&
 		git commit -m new deepsubfile &&
-		head2=$(git rev-parse --short HEAD) &&
-		echo "Fetching submodule submodule/subdir/deepsubmodule" > ../expect.err.deep
-		echo "From $pwd/deepsubmodule" >> ../expect.err.deep &&
-		echo "   $head1..$head2  deep       -> origin/deep" >> ../expect.err.deep
+		new_head=$(git rev-parse --short HEAD) &&
+		check_deep $new_head
 	)
 }
 
@@ -47,7 +67,7 @@ add_upstream_commit() {
 #
 # If a repo should not be fetched in the test, its corresponding
 # expect.err file should be rm-ed.
-verify_fetch_result() {
+verify_fetch_result () {
 	ACTUAL_ERR=$1 &&
 	rm -f expect.err.combined &&
 	if test -f expect.err.super
@@ -62,7 +82,8 @@ verify_fetch_result() {
 	then
 		cat expect.err.deep >>expect.err.combined
 	fi &&
-	test_cmp expect.err.combined $ACTUAL_ERR
+	sed -e 's/[0-9a-f][0-9a-f]*\.\./OLD_HEAD\.\./' "$ACTUAL_ERR" >actual.err.cmp &&
+	test_cmp expect.err.combined actual.err.cmp
 }
 
 test_expect_success setup '
@@ -274,12 +295,10 @@ test_expect_success "Recursion doesn't happen when no new commits are fetched in
 '
 
 test_expect_success "Recursion stops when no new submodule commits are fetched" '
-	head1=$(git rev-parse --short HEAD) &&
 	git add submodule &&
 	git commit -m "new submodule" &&
-	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.super &&
-	echo "   $head1..$head2  super      -> origin/super" >>expect.err.super &&
+	new_head=$(git rev-parse --short HEAD) &&
+	check_super $new_head &&
 	rm expect.err.deep &&
 	(
 		cd downstream &&
@@ -291,13 +310,11 @@ test_expect_success "Recursion stops when no new submodule commits are fetched"
 
 test_expect_success "Recursion doesn't happen when new superproject commits don't change any submodules" '
 	add_upstream_commit &&
-	head1=$(git rev-parse --short HEAD) &&
 	echo a > file &&
 	git add file &&
 	git commit -m "new file" &&
-	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.super &&
-	echo "   $head1..$head2  super      -> origin/super" >> expect.err.super &&
+	new_head=$(git rev-parse --short HEAD) &&
+	check_super $new_head &&
 	rm expect.err.sub &&
 	rm expect.err.deep &&
 	(
@@ -318,12 +335,10 @@ test_expect_success "Recursion picks up config in submodule" '
 		)
 	) &&
 	add_upstream_commit &&
-	head1=$(git rev-parse --short HEAD) &&
 	git add submodule &&
 	git commit -m "new submodule" &&
-	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.super &&
-	echo "   $head1..$head2  super      -> origin/super" >> expect.err.super &&
+	new_head=$(git rev-parse --short HEAD) &&
+	check_super $new_head &&
 	(
 		cd downstream &&
 		git fetch >../actual.out 2>../actual.err &&
@@ -345,20 +360,15 @@ test_expect_success "Recursion picks up all submodules when necessary" '
 			git fetch &&
 			git checkout -q FETCH_HEAD
 		) &&
-		head1=$(git rev-parse --short HEAD^) &&
 		git add subdir/deepsubmodule &&
 		git commit -m "new deepsubmodule" &&
-		head2=$(git rev-parse --short HEAD) &&
-		echo "Fetching submodule submodule" > ../expect.err.sub &&
-		echo "From $pwd/submodule" >> ../expect.err.sub &&
-		echo "   $head1..$head2  sub        -> origin/sub" >> ../expect.err.sub
+		new_head=$(git rev-parse --short HEAD) &&
+		check_sub $new_head
 	) &&
-	head1=$(git rev-parse --short HEAD) &&
 	git add submodule &&
 	git commit -m "new submodule" &&
-	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.super &&
-	echo "   $head1..$head2  super      -> origin/super" >> expect.err.super &&
+	new_head=$(git rev-parse --short HEAD) &&
+	check_super $new_head &&
 	(
 		cd downstream &&
 		git fetch >../actual.out 2>../actual.err
@@ -376,13 +386,10 @@ test_expect_success "'--recurse-submodules=on-demand' doesn't recurse when no ne
 			git fetch &&
 			git checkout -q FETCH_HEAD
 		) &&
-		head1=$(git rev-parse --short HEAD^) &&
 		git add subdir/deepsubmodule &&
 		git commit -m "new deepsubmodule" &&
-		head2=$(git rev-parse --short HEAD) &&
-		echo Fetching submodule submodule > ../expect.err.sub &&
-		echo "From $pwd/submodule" >> ../expect.err.sub &&
-		echo "   $head1..$head2  sub        -> origin/sub" >> ../expect.err.sub
+		new_head=$(git rev-parse --short HEAD) &&
+		check_sub $new_head
 	) &&
 	(
 		cd downstream &&
@@ -395,12 +402,10 @@ test_expect_success "'--recurse-submodules=on-demand' doesn't recurse when no ne
 '
 
 test_expect_success "'--recurse-submodules=on-demand' recurses as deep as necessary (and ignores config)" '
-	head1=$(git rev-parse --short HEAD) &&
 	git add submodule &&
 	git commit -m "new submodule" &&
-	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.super &&
-	echo "   $head1..$head2  super      -> origin/super" >>expect.err.super &&
+	new_head=$(git rev-parse --short HEAD) &&
+	check_super $new_head &&
 	(
 		cd downstream &&
 		git config fetch.recurseSubmodules false &&
@@ -421,13 +426,11 @@ test_expect_success "'--recurse-submodules=on-demand' recurses as deep as necess
 
 test_expect_success "'--recurse-submodules=on-demand' stops when no new submodule commits are found in the superproject (and ignores config)" '
 	add_upstream_commit &&
-	head1=$(git rev-parse --short HEAD) &&
 	echo a >> file &&
 	git add file &&
 	git commit -m "new file" &&
-	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.super &&
-	echo "   $head1..$head2  super      -> origin/super" >> expect.err.super &&
+	new_head=$(git rev-parse --short HEAD) &&
+	check_super $new_head &&
 	rm expect.err.sub &&
 	rm expect.err.deep &&
 	(
@@ -445,12 +448,10 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' overrides global config
 	) &&
 	add_upstream_commit &&
 	git config --global fetch.recurseSubmodules false &&
-	head1=$(git rev-parse --short HEAD) &&
 	git add submodule &&
 	git commit -m "new submodule" &&
-	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.super &&
-	echo "   $head1..$head2  super      -> origin/super" >>expect.err.super &&
+	new_head=$(git rev-parse --short HEAD) &&
+	check_super $new_head &&
 	rm expect.err.deep &&
 	(
 		cd downstream &&
@@ -473,12 +474,10 @@ test_expect_success "'submodule.<sub>.fetchRecurseSubmodules=on-demand' override
 	) &&
 	add_upstream_commit &&
 	git config fetch.recurseSubmodules false &&
-	head1=$(git rev-parse --short HEAD) &&
 	git add submodule &&
 	git commit -m "new submodule" &&
-	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.super &&
-	echo "   $head1..$head2  super      -> origin/super" >>expect.err.super &&
+	new_head=$(git rev-parse --short HEAD) &&
+	check_super $new_head &&
 	rm expect.err.deep &&
 	(
 		cd downstream &&
@@ -499,12 +498,10 @@ test_expect_success "don't fetch submodule when newly recorded commits are alrea
 		cd submodule &&
 		git checkout -q HEAD^^
 	) &&
-	head1=$(git rev-parse --short HEAD) &&
 	git add submodule &&
 	git commit -m "submodule rewound" &&
-	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.super &&
-	echo "   $head1..$head2  super      -> origin/super" >> expect.err.super &&
+	new_head=$(git rev-parse --short HEAD) &&
+	check_super $new_head &&
 	rm expect.err.sub &&
 	# This file does not exist, but rm -f for readability
 	rm -f expect.err.deep &&
@@ -526,13 +523,11 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' works also without .git
 		git fetch --recurse-submodules
 	) &&
 	add_upstream_commit &&
-	head1=$(git rev-parse --short HEAD) &&
 	git add submodule &&
 	git rm .gitmodules &&
 	git commit -m "new submodule without .gitmodules" &&
-	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." >expect.err.super &&
-	echo "   $head1..$head2  super      -> origin/super" >>expect.err.super &&
+	new_head=$(git rev-parse --short HEAD) &&
+	check_super $new_head &&
 	rm expect.err.deep &&
 	(
 		cd downstream &&
-- 
2.33.GIT

