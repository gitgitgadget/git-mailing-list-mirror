Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB30D1F516
	for <e@80x24.org>; Tue, 26 Jun 2018 07:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752775AbeFZHbs (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 03:31:48 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36256 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752467AbeFZHbS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 03:31:18 -0400
Received: by mail-it0-f67.google.com with SMTP id j135-v6so876275itj.1
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 00:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RM8sFQQ9iLJf3xvfqbn0v+qFV81+iKgCoGlZCeZ8TW0=;
        b=MRn0SIv5Tg9OtBmf+BoUqxjsoh+EnOOvqBsBUwkwSnMQwEpCatzHM6MhrO/J5zMyan
         Oyd2l/wc1a1FOh/S9SEJQEzZRb/ArtWcY0XhmugOsUdi2oy8yynUERGia5syDBQZFz75
         kcxfHrIjLb4xQxUF+en68k/fjRGnusLeekZ07VINZt2yKAzZY053urko1jEn6G3OW6Tc
         i15ExspzTaoXyoEm/tum2IhCPzYHeSZ/5HmOAfVOEf+iwN5d6qpXCBCogw1Z9yqS+nph
         MgOhBrsM8tKU4y7NUWWl4agciyy5jlajXRplMuHKPwuanQ3effP40Gt4R2+phVaQ8O+B
         GqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=RM8sFQQ9iLJf3xvfqbn0v+qFV81+iKgCoGlZCeZ8TW0=;
        b=DCc+T6YSYX5BuxVpo6qLZzngAV9zPXRsSBMFnjANYPrw9FfRB5PfzsDr3hqasfg9c0
         ysXyS/7Z+pxMDlvodO2PKhSB+kvnGlJ5xsyqz+8UA7sYIRds30S+xZ+mGi8qT+a8L8jm
         byi3Par1YJC5Gmzp1A9kVnOoM/8yXLMTrfWWbNcGYFelUaLzA40tWxxzW/WJrAHWaVW6
         4EIJi9hrZO7deFXk8xSIvgj23lKP5TwtEF8BplDDtraGdsw0zARxHHaGwt76QPi/Kj1V
         jdaRWmG0JS8j4uCQoWydJlpgrvnX2rXsNJD5A8x96oGnaCZLaso7Hf1n/a7AbonzgV25
         ViQA==
X-Gm-Message-State: APt69E2NIDq2GX9AUI54dzrjQFpZDkNLdbWtt5eVAHcvD2kJT5y85VSA
        cDoKSmhY7cIqMJRKd0jIDZbbmA==
X-Google-Smtp-Source: AAOMgpdaphbMxPdJH0zTl+YLLyD7Zija5b04iVZfqq/A/GZ2jD06euJlTbv/UJJ1IfOvKxgpL0HoAQ==
X-Received: by 2002:a02:6348:: with SMTP id j69-v6mr300067jac.45.1529998276096;
        Tue, 26 Jun 2018 00:31:16 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id k20-v6sm471361iok.9.2018.06.26.00.31.15
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 26 Jun 2018 00:31:15 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 26/29] t7000-t7999: fix broken &&-chains in subshells
Date:   Tue, 26 Jun 2018 03:29:58 -0400
Message-Id: <20180626073001.6555-27-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.419.gfe4b301394
In-Reply-To: <20180626073001.6555-1-sunshine@sunshineco.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t7001-mv.sh                  |  2 +-
 t/t7201-co.sh                  | 40 +++++++++++++-------------
 t/t7400-submodule-basic.sh     |  2 +-
 t/t7406-submodule-update.sh    |  4 +--
 t/t7408-submodule-reference.sh |  2 +-
 t/t7501-commit.sh              | 52 +++++++++++++++++-----------------
 t/t7506-status-submodule.sh    | 10 +++----
 7 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index cc3fd2baf2..9e59e5a5dd 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -509,7 +509,7 @@ test_expect_success 'moving nested submodules' '
 		touch nested_level1 &&
 		git init &&
 		git add . &&
-		git commit -m "nested level 1"
+		git commit -m "nested level 1" &&
 		git submodule add ../sub_nested_nested &&
 		git commit -m "add nested level 2"
 	) &&
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 8d8a63a24b..94cb039a03 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -528,10 +528,10 @@ test_expect_success 'checkout with --merge' '
 	cat sample >filf &&
 	git checkout -m -- fild file filf &&
 	(
-		echo "<<<<<<< ours"
-		echo ourside
-		echo "======="
-		echo theirside
+		echo "<<<<<<< ours" &&
+		echo ourside &&
+		echo "=======" &&
+		echo theirside &&
 		echo ">>>>>>> theirs"
 	) >merged &&
 	test_cmp expect fild &&
@@ -549,12 +549,12 @@ test_expect_success 'checkout with --merge, in diff3 -m style' '
 	cat sample >filf &&
 	git checkout -m -- fild file filf &&
 	(
-		echo "<<<<<<< ours"
-		echo ourside
-		echo "||||||| base"
-		echo original
-		echo "======="
-		echo theirside
+		echo "<<<<<<< ours" &&
+		echo ourside &&
+		echo "||||||| base" &&
+		echo original &&
+		echo "=======" &&
+		echo theirside &&
 		echo ">>>>>>> theirs"
 	) >merged &&
 	test_cmp expect fild &&
@@ -572,10 +572,10 @@ test_expect_success 'checkout --conflict=merge, overriding config' '
 	cat sample >filf &&
 	git checkout --conflict=merge -- fild file filf &&
 	(
-		echo "<<<<<<< ours"
-		echo ourside
-		echo "======="
-		echo theirside
+		echo "<<<<<<< ours" &&
+		echo ourside &&
+		echo "=======" &&
+		echo theirside &&
 		echo ">>>>>>> theirs"
 	) >merged &&
 	test_cmp expect fild &&
@@ -593,12 +593,12 @@ test_expect_success 'checkout --conflict=diff3' '
 	cat sample >filf &&
 	git checkout --conflict=diff3 -- fild file filf &&
 	(
-		echo "<<<<<<< ours"
-		echo ourside
-		echo "||||||| base"
-		echo original
-		echo "======="
-		echo theirside
+		echo "<<<<<<< ours" &&
+		echo ourside &&
+		echo "||||||| base" &&
+		echo original &&
+		echo "=======" &&
+		echo theirside &&
 		echo ">>>>>>> theirs"
 	) >merged &&
 	test_cmp expect fild &&
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 401adaed32..76cf522a08 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -818,7 +818,7 @@ test_expect_success '../bar/a/b/c works with relative local path - ../foo/bar.gi
 		cp pristine-.git-config .git/config &&
 		cp pristine-.gitmodules .gitmodules &&
 		mkdir -p a/b/c &&
-		(cd a/b/c; git init) &&
+		(cd a/b/c && git init) &&
 		git config remote.origin.url ../foo/bar.git &&
 		git submodule add ../bar/a/b/c ./a/b/c &&
 		git submodule init &&
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 9e0d31700e..b141145fc2 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -865,9 +865,9 @@ test_expect_success 'submodule update places git-dir in superprojects git-dir re
 	 (cd submodule/subsubmodule &&
 	  git log > ../../expected
 	 ) &&
-	 (cd .git/modules/submodule/modules/subsubmodule
+	 (cd .git/modules/submodule/modules/subsubmodule &&
 	  git log > ../../../../../actual
-	 )
+	 ) &&
 	 test_cmp actual expected
 	)
 '
diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.sh
index 08d9add05e..34ac28c056 100755
--- a/t/t7408-submodule-reference.sh
+++ b/t/t7408-submodule-reference.sh
@@ -148,7 +148,7 @@ test_expect_success 'preparing second superproject with a nested submodule plus
 		cd supersuper &&
 		echo "I am super super." >file &&
 		git add file &&
-		git commit -m B-super-super-initial
+		git commit -m B-super-super-initial &&
 		git submodule add "file://$base_dir/super" subwithsub &&
 		git commit -m B-super-super-added &&
 		git submodule update --init --recursive &&
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 589b6cea23..39b14b2bdb 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -411,8 +411,8 @@ test_expect_success 'sign off (1)' '
 	git commit -s -m "thank you" &&
 	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
 	(
-		echo thank you
-		echo
+		echo thank you &&
+		echo &&
 		git var GIT_COMMITTER_IDENT |
 		sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /"
 	) >expected &&
@@ -430,9 +430,9 @@ test_expect_success 'sign off (2)' '
 $existing" &&
 	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
 	(
-		echo thank you
-		echo
-		echo $existing
+		echo thank you &&
+		echo &&
+		echo $existing &&
 		git var GIT_COMMITTER_IDENT |
 		sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /"
 	) >expected &&
@@ -450,9 +450,9 @@ test_expect_success 'signoff gap' '
 $alt" &&
 	git cat-file commit HEAD | sed -e "1,/^\$/d" > actual &&
 	(
-		echo welcome
-		echo
-		echo $alt
+		echo welcome &&
+		echo &&
+		echo $alt &&
 		git var GIT_COMMITTER_IDENT |
 		sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /"
 	) >expected &&
@@ -470,11 +470,11 @@ We have now
 $alt" &&
 	git cat-file commit HEAD | sed -e "1,/^\$/d" > actual &&
 	(
-		echo welcome
-		echo
-		echo We have now
-		echo $alt
-		echo
+		echo welcome &&
+		echo &&
+		echo We have now &&
+		echo $alt &&
+		echo &&
 		git var GIT_COMMITTER_IDENT |
 		sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /"
 	) >expected &&
@@ -491,11 +491,11 @@ non-trailer line
 Myfooter: x" &&
 	git cat-file commit HEAD | sed -e "1,/^\$/d" > actual &&
 	(
-		echo subject
-		echo
-		echo non-trailer line
-		echo Myfooter: x
-		echo
+		echo subject &&
+		echo &&
+		echo non-trailer line &&
+		echo Myfooter: x &&
+		echo &&
 		echo "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
 	) >expected &&
 	test_cmp expected actual &&
@@ -508,10 +508,10 @@ non-trailer line
 Myfooter: x" &&
 	git cat-file commit HEAD | sed -e "1,/^\$/d" > actual &&
 	(
-		echo subject
-		echo
-		echo non-trailer line
-		echo Myfooter: x
+		echo subject &&
+		echo &&
+		echo non-trailer line &&
+		echo Myfooter: x &&
 		echo "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
 	) >expected &&
 	test_cmp expected actual
@@ -524,10 +524,10 @@ test_expect_success 'multiple -m' '
 	git commit -m "one" -m "two" -m "three" &&
 	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
 	(
-		echo one
-		echo
-		echo two
-		echo
+		echo one &&
+		echo &&
+		echo two &&
+		echo &&
 		echo three
 	) >expected &&
 	test_cmp expected actual
diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index b4b74dbe29..943708fb04 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -193,9 +193,9 @@ test_expect_success 'status with added and untracked file in modified submodule
 
 test_expect_success 'setup .git file for sub' '
 	(cd sub &&
-	 rm -f new-file
+	 rm -f new-file &&
 	 REAL="$(pwd)/../.real" &&
-	 mv .git "$REAL"
+	 mv .git "$REAL" &&
 	 echo "gitdir: $REAL" >.git) &&
 	 echo .real >>.gitignore &&
 	 git commit -m "added .real to .gitignore" .gitignore
@@ -209,12 +209,12 @@ test_expect_success 'status with added file in modified submodule with .git file
 
 test_expect_success 'status with a lot of untracked files in the submodule' '
 	(
-		cd sub
+		cd sub &&
 		i=0 &&
 		while test $i -lt 1024
 		do
-			>some-file-$i
-			i=$(( $i + 1 ))
+			>some-file-$i &&
+			i=$(( $i + 1 )) || exit 1
 		done
 	) &&
 	git status --porcelain sub 2>err.actual &&
-- 
2.18.0.419.gfe4b301394

