Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2FAC8300A
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 16:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C06A24655
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 16:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiGGzSbu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbgKQQM7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 11:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbgKQQMw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 11:12:52 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF1AC061A04
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 08:12:51 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id w24so3760557wmi.0
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 08:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZSx9WaOV8Pj+GeE1SE6euqE0bTOkxQynTAQMrV328A4=;
        b=MiGGzSbuPztdGCDcWKAbr3Txa5ev6QSaGJGd/+ihvCtAsBl7fe5oTeJvyZd/15ZZNt
         kDhykG7QMjqkzMxA1jHAj5RHCzaAk6icctBCiPufGKoNVb92rSRsYm74Q8D7MdlkTOTF
         b5jdYF6hC3KubWtMc2GW9Kgi7TPRLFdZkn9HbRz4bsvn6xiQpUKv/DklamFeQ7wUBVlc
         JPUQgek3SKFnsxqI8FbULfHtz/12VC1RT7wW1IsvZu2Z3yCjC5V4siXwN2qDJfbjtzO9
         V2oVs/YKVsnkn3bzHlyjirbITUBC75+eok+FQsgAcYF2/dNA68GeoLW1AgbTNU8wq7SC
         IJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZSx9WaOV8Pj+GeE1SE6euqE0bTOkxQynTAQMrV328A4=;
        b=mJ3z6LXEjZX0HbzswPyWTijKwqgOcqC9eK9T51fix52ZE8PjJPpdyad6Vn7SnEB/Ck
         ZY3nou9gsFYn744ZYFbllbX3cqurcGBbleeTa942Rdya2lnN8EhRxKb1q9Sr2ClMcfaZ
         r37U5/5GGx1yT76kevKqCj6EUFXI3RTOn4Z6MAtU74boUKLmHQ0knlYsJqQV0pZK38+r
         JVktw2csmFW7o6XzZ6GkQ8EHTj5S3tH0RuTTV6JqGzVVuVgwPzz+iva57HXPbIbsC7lK
         l/qRCUptcgIcwLZN02vmuXurHRwIxyS7rLpyIlWXm0K+EVd6IE/DEnIyu4lVOW0jZtgT
         Mb8w==
X-Gm-Message-State: AOAM531WqCXHIBsKl4ggSSXlw+b9sTaBOX0E0UE5AjP+9fQNBfKl8Anq
        cn2cbWQweDiXdSCO1kqIKqlfpr7dX+g=
X-Google-Smtp-Source: ABdhPJzHbF4Tyg/X/6uHmJ40ZR1shOgS/j2MCEAq7Sl6pLaogCitApCnku2K7zwMcMlrWWlhUifK8Q==
X-Received: by 2002:a7b:cbcf:: with SMTP id n15mr399115wmi.156.1605629570423;
        Tue, 17 Nov 2020 08:12:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 60sm25602639wrs.69.2020.11.17.08.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 08:12:50 -0800 (PST)
Message-Id: <5cac0065c87e6acf1ed95ed5f24c1027048e7b6f.1605629549.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
        <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Nov 2020 16:12:22 +0000
Subject: [PATCH v2 22/27] t8*: adjust the references to the default branch
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
 t/t8001-annotate.sh             |  2 +-
 t/t8003-blame-corner-cases.sh   |  4 ++--
 t/t8004-blame-with-conflicts.sh | 14 +++++++-------
 t/test-lib.sh                   |  2 +-
 5 files changed, 15 insertions(+), 15 deletions(-)

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
index 72176e42c1..3687fc58d8 100755
--- a/t/t8001-annotate.sh
+++ b/t/t8001-annotate.sh
@@ -7,7 +7,7 @@ PROG='git annotate'
 . "$TEST_DIRECTORY"/annotate-tests.sh
 
 test_expect_success 'annotate old revision' '
-	git annotate file master >actual &&
+	git annotate file main >actual &&
 	awk "{ print \$3; }" <actual >authors &&
 	test 2 = $(grep A <authors | wc -l) &&
 	test 2 = $(grep B <authors | wc -l)
diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
index ba8013b002..2e499b4511 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -161,13 +161,13 @@ test_expect_success 'blame wholesale copy and more in the index' '
 
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
index 9c353ab222..b6c992ec45 100755
--- a/t/t8004-blame-with-conflicts.sh
+++ b/t/t8004-blame-with-conflicts.sh
@@ -21,16 +21,16 @@ test_expect_success 'setup first case' '
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
@@ -44,8 +44,8 @@ Even more" > file2 &&
 	git rm file1 &&
 	git commit --author "M Result <mr@localhost>" -a -m merged &&
 
-	# Back to master and change file1 again
-	git checkout master &&
+	# Back to main and change file1 again
+	git checkout main &&
 	sed s/bla/foo/ <file1 >X &&
 	rm file1 &&
 	mv X file1 &&
@@ -53,7 +53,7 @@ Even more" > file2 &&
 
 	# Try to merge into foo again
 	git checkout foo &&
-	if git merge master; then
+	if git merge main; then
 		echo needed conflict here
 		exit 1
 	else
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 6ce12ad6d8..a63945569f 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -263,7 +263,7 @@ case "$TEST_NUMBER" in
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 	;;
-[0-7]*)
+[0-8]*)
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 	;;
-- 
gitgitgadget

