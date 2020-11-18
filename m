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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A059C71156
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C04EB246BB
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNJ+2YK2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgKRXpT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 18:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbgKRXpP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 18:45:15 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA7AC061A49
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:45:13 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id s13so4741600wmh.4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=01vHHSTNhUKNhPEcLe8HUqyDmV/7rtFmcmpGkrVkksQ=;
        b=DNJ+2YK2l+xrvzR3mQf+Hx4sL5RrAkeALhSQLPqIVvSdjQUi9JFREsKpl121Iq7BAe
         1AdvI2L5R04dJfm7iyj+xS0upvnXXwRy7qk6mfvAhHPbDzjiPlqaQwT5USrwkDSJPYb7
         K0W1In4WixHUYeBksL8MYPhYWBhJ1cDBJyBCZoXZUkiEmGzLV7ke9lD/hgnhd+9RzdA9
         XK2zUx06XC8BhyyzxWTZSjZyNxd2hX+UKPmJRHjCHCbPK6SVrjqxjnb9NqzbDIF2V4aO
         GJJ+5ZrwVnu4BpdB2MpkDjVqgfmYxhMyuZTY3J36WLEjjmD/o4qATJvZ7X1lnjBiVV+d
         5eTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=01vHHSTNhUKNhPEcLe8HUqyDmV/7rtFmcmpGkrVkksQ=;
        b=aHQnwordB6qOEqK066HH5IqZF4eKVfnKZ/IE2DhrvZotQA2d3z1XYKD9eO8rJ1l59O
         cLvsckbkXEAvSvAU39Ys3ttcPu8X+pfXEbGtCPcppyvKa2Crs1vPEmyHQnTC51IrTcQj
         yCb9GON+tAExnv7MMA4PM3uBcauMJP+hmnYxhXkYAh/F/KwKS70Ma27wYusmwzqPWAnC
         t3Aw2oDiEzy0ryq5/gRMeEzxibczKsilGrRgZUNgI1rkt3JgBC3wFxMz8VvMLIZkCtXV
         QFPhj/gn0hGeRRQSAlhrTXL+I02epKaTVqWCIWnw0may+eL1gJwXBIgj3x+HWt0Yj0hI
         WFcA==
X-Gm-Message-State: AOAM530wChmBlWIG8AYww5l1kkdAWlI1OfwrDK96AoVZNAQmfjJTrnn+
        rKgvP8FoKQK021GwIkJCQFtP6iyyxQ4=
X-Google-Smtp-Source: ABdhPJxt5IHvVA46yAJ6c/ZvZdFKQ68lcpgWg3NMW0rdKAHn8Ks5runar6ThVZ5th3Ez0pxrEV2m9A==
X-Received: by 2002:a1c:e3c1:: with SMTP id a184mr1512838wmh.88.1605743112184;
        Wed, 18 Nov 2020 15:45:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s25sm6153181wmh.16.2020.11.18.15.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 15:45:11 -0800 (PST)
Message-Id: <e37bc3c792748968f884e93e3e77c27c8f71c95b.1605743088.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.v3.git.1605743086.gitgitgadget@gmail.com>
References: <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
        <pull.762.v3.git.1605743086.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Nov 2020 23:44:41 +0000
Subject: [PATCH v3 23/28] t8*: adjust the references to the default branch
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
		-e 's/Master/Main/g' -- t8*.sh annotate*.sh)

This allows us to define `GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main`
for those tests.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/annotate-tests.sh             |  8 ++++----
 t/t8001-annotate.sh             |  4 ++--
 t/t8002-blame.sh                |  2 +-
 t/t8003-blame-corner-cases.sh   |  6 +++---
 t/t8004-blame-with-conflicts.sh | 16 ++++++++--------
 t/t8012-blame-colors.sh         |  2 +-
 6 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index 3aee61d2cc..ee5d2d4cf8 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -95,7 +95,7 @@ test_expect_success 'blame 2 authors' '
 '
 
 test_expect_success 'setup B1 lines (branch1)' '
-	git checkout -b branch1 master &&
+	git checkout -b branch1 main &&
 	echo "3A slow green fox jumps into the" >>file &&
 	echo "well." >>file &&
 	GIT_AUTHOR_NAME="B1" GIT_AUTHOR_EMAIL="B1@test.git" \
@@ -107,7 +107,7 @@ test_expect_success 'blame 2 authors + 1 branch1 author' '
 '
 
 test_expect_success 'setup B2 lines (branch2)' '
-	git checkout -b branch2 master &&
+	git checkout -b branch2 main &&
 	sed -e "s/2A quick brown/4A quick brown lazy dog/" <file >file.new &&
 	mv file.new file &&
 	GIT_AUTHOR_NAME="B2" GIT_AUTHOR_EMAIL="B2@test.git" \
@@ -131,11 +131,11 @@ test_expect_success 'blame --first-parent blames merge for branch1' '
 '
 
 test_expect_success 'blame ancestor' '
-	check_count -h master A 2 B 2
+	check_count -h main A 2 B 2
 '
 
 test_expect_success 'blame great-ancestor' '
-	check_count -h master^ A 2
+	check_count -h main^ A 2
 '
 
 test_expect_success 'setup evil merge' '
diff --git a/t/t8001-annotate.sh b/t/t8001-annotate.sh
index f661007c85..a536a621b2 100755
--- a/t/t8001-annotate.sh
+++ b/t/t8001-annotate.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 test_description='git annotate'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -10,7 +10,7 @@ PROG='git annotate'
 . "$TEST_DIRECTORY"/annotate-tests.sh
 
 test_expect_success 'annotate old revision' '
-	git annotate file master >actual &&
+	git annotate file main >actual &&
 	awk "{ print \$3; }" <actual >authors &&
 	test 2 = $(grep A <authors | wc -l) &&
 	test 2 = $(grep B <authors | wc -l)
diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
index 89a319d2c7..5bb302b1ba 100755
--- a/t/t8002-blame.sh
+++ b/t/t8002-blame.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 test_description='git blame'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
index 0613d889db..da80f815ce 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 test_description='git blame corner cases'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -164,13 +164,13 @@ test_expect_success 'blame wholesale copy and more in the index' '
 
 test_expect_success 'blame during cherry-pick with file rename conflict' '
 
-	test_when_finished "git reset --hard && git checkout master" &&
+	test_when_finished "git reset --hard && git checkout main" &&
 	git checkout HEAD~3 &&
 	echo MOUSE >> mouse &&
 	git mv mouse rodent &&
 	git add rodent &&
 	GIT_AUTHOR_NAME=Rodent git commit -m "rodent" &&
-	git checkout --detach master &&
+	git checkout --detach main &&
 	(git cherry-pick HEAD@{1} || test $? -eq 1) &&
 	git show HEAD@{1}:rodent > rodent &&
 	git add rodent &&
diff --git a/t/t8004-blame-with-conflicts.sh b/t/t8004-blame-with-conflicts.sh
index ffce1d1195..35414a5336 100755
--- a/t/t8004-blame-with-conflicts.sh
+++ b/t/t8004-blame-with-conflicts.sh
@@ -3,7 +3,7 @@
 # Based on a test case submitted by Björn Steinbrink.
 
 test_description='git blame on conflicted files'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -24,16 +24,16 @@ test_expect_success 'setup first case' '
 	git add file2 &&
 	git commit --author "U Gly <ug@localhost>" -m ugly &&
 
-	# Back to master and change something
-	git checkout master &&
+	# Back to main and change something
+	git checkout main &&
 	echo "
 
 bla" >> file1 &&
 	git commit --author "Old Line <ol@localhost>" -a -m file1.b &&
 
-	# Back to foo and merge master
+	# Back to foo and merge main
 	git checkout foo &&
-	if git merge master; then
+	if git merge main; then
 		echo needed conflict here
 		exit 1
 	else
@@ -47,8 +47,8 @@ Even more" > file2 &&
 	git rm file1 &&
 	git commit --author "M Result <mr@localhost>" -a -m merged &&
 
-	# Back to master and change file1 again
-	git checkout master &&
+	# Back to main and change file1 again
+	git checkout main &&
 	sed s/bla/foo/ <file1 >X &&
 	rm file1 &&
 	mv X file1 &&
@@ -56,7 +56,7 @@ Even more" > file2 &&
 
 	# Try to merge into foo again
 	git checkout foo &&
-	if git merge master; then
+	if git merge main; then
 		echo needed conflict here
 		exit 1
 	else
diff --git a/t/t8012-blame-colors.sh b/t/t8012-blame-colors.sh
index d55b3e22c9..90c75dbb28 100755
--- a/t/t8012-blame-colors.sh
+++ b/t/t8012-blame-colors.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 test_description='colored git blame'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
-- 
gitgitgadget

