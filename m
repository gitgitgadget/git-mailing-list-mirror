Return-Path: <SRS0=euRE=EN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2594C2D0A3
	for <git@archiver.kernel.org>; Sat,  7 Nov 2020 01:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DCE420704
	for <git@archiver.kernel.org>; Sat,  7 Nov 2020 01:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Alb9Ddtq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgKGBNB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 20:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbgKGBNB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Nov 2020 20:13:01 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0757C0613CF
        for <git@vger.kernel.org>; Fri,  6 Nov 2020 17:13:00 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id k18so2909025wmj.5
        for <git@vger.kernel.org>; Fri, 06 Nov 2020 17:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=78mvTPwkn+B3J2F5A07nez1KnjIhl5HKAe1rNrFwh+Y=;
        b=Alb9DdtqL/BokNX4tvKeilQkZYL0fSv8IlKVSqYf69ybm1lmGewbH9VJrqNVkalh6Y
         yE8TfxYo/EwN4g8F4h+oZ5CfKymXa8hU+yZzYPalUKc99DDpLx44yTB2+VRxAwZqbFnX
         ouI8bI1IPAuorvjkG+RoIfElEm2lCmPtbP/rFh3lB/pNGjcSY2C7jJl+QnMnf+SBrcZj
         aXws0Wnh3zLNEEFW85spdMuUYn25IrR7Y0c6+JlYj9ERyVEM+mXgmhmwPGMIxJLFpJPd
         lcgIm+zyWaQcBcO8nQAy5hOLdPXDuJtzw+qZUGTNLRFiatVwCyZKKK6spqR4cB4u9a4D
         wMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=78mvTPwkn+B3J2F5A07nez1KnjIhl5HKAe1rNrFwh+Y=;
        b=UQICLn3Bu9u9DW6jfDQ2Z9y3PiUodEWd3J7OaR2BkUmwyzpPXGb7nXw2gMBiLI6+8S
         zrwp1zk3ZafkpZWkbK/Tbl7jLVKBoz8IxPfOjGvZnAHlWYLvE8v+JceOc08B/ra5T6Ab
         DC6rKuOBEhDU4BxLFKwuE/UkZk+h+FHQKsUOmsJ3Qwn82K4Xy5ZAM3x1gQ8kkyEgcQlT
         2vAldVY/T8zlzbsRhb+VfXoro3O/paqa+4QfbzLPSFgtUOP0nvsUl0pfZ+k0nZhKr0on
         D4zNofTLzDQ8fFaA6wf9xa5nztgA7mfMQeV9nJuh8pITTqFMScnyJhbE28JibsN6iaiC
         FpLw==
X-Gm-Message-State: AOAM5338dheLs1Qq7PWfZ4x9VSXWZOrfx6jgSgC5Bn7D18V+QWsqQM8x
        40HOBpbJwr3z/MX4k3nRM4/0ggZ9dd8=
X-Google-Smtp-Source: ABdhPJxLh4Ql4Clr9ujTGGFj3yE9dIGTbCKGz1yZ5NLtjit4PHrV1qk/4961yof1uCwnm0eF8SbVsA==
X-Received: by 2002:a1c:6a0d:: with SMTP id f13mr2252184wmc.172.1604711579176;
        Fri, 06 Nov 2020 17:12:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z2sm4471930wmf.45.2020.11.06.17.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 17:12:58 -0800 (PST)
Message-Id: <pull.780.git.1604711577662.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 07 Nov 2020 01:12:57 +0000
Subject: [PATCH] tests: consolidate the `file_size` function into
 `test-lib-functions.sh`
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

In 8de7eeb54b6 (compression: unify pack.compression configuration
parsing, 2016-11-15), we introduced identical copies of the `file_size`
helper into three test scripts, with the plan to eventually consolidate
them into a single copy.

Let's do that, and adjust the function name to adhere to the `test_*`
naming convention.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    tests: consolidate the file_size function into test-lib-functions.sh
    
    My ulterior motive with this patch is not even to address that old
    concern, but to avoid having to exclude the code comments from the
    upcoming master -> main rename (because those code comments talk about
    git/git's main branch, which is called master).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-780%2Fdscho%2Ffile_size-test-function-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-780/dscho/file_size-test-function-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/780

 t/t0021-conversion.sh               | 36 +++++++++++++----------------
 t/t1050-large.sh                    |  8 +------
 t/t5315-pack-objects-compression.sh |  8 +------
 t/t9303-fast-import-compression.sh  | 10 ++------
 t/test-lib-functions.sh             |  4 ++++
 5 files changed, 24 insertions(+), 42 deletions(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 4bfffa9c31..f6deaf498b 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -23,10 +23,6 @@ generate_random_characters () {
 		perl -pe "s/./chr((ord($&) % 26) + ord('a'))/sge" >"$TEST_ROOT/$NAME"
 }
 
-file_size () {
-	test-tool path-utils file-size "$1"
-}
-
 filter_git () {
 	rm -f *.log &&
 	git "$@"
@@ -361,9 +357,9 @@ test_expect_success PERL 'required process filter should filter data' '
 		cp "$TEST_ROOT/test3 '\''sq'\'',\$x=.o" "testsubdir/test3 '\''sq'\'',\$x=.r" &&
 		>test4-empty.r &&
 
-		S=$(file_size test.r) &&
-		S2=$(file_size test2.r) &&
-		S3=$(file_size "testsubdir/test3 '\''sq'\'',\$x=.r") &&
+		S=$(test_file_size test.r) &&
+		S2=$(test_file_size test2.r) &&
+		S3=$(test_file_size "testsubdir/test3 '\''sq'\'',\$x=.r") &&
 		M=$(git hash-object test.r) &&
 		M2=$(git hash-object test2.r) &&
 		M3=$(git hash-object "testsubdir/test3 '\''sq'\'',\$x=.r") &&
@@ -432,9 +428,9 @@ test_expect_success PERL 'required process filter should filter data for various
 	(
 		cd repo &&
 
-		S=$(file_size test.r) &&
-		S2=$(file_size test2.r) &&
-		S3=$(file_size "testsubdir/test3 '\''sq'\'',\$x=.r") &&
+		S=$(test_file_size test.r) &&
+		S2=$(test_file_size test2.r) &&
+		S3=$(test_file_size "testsubdir/test3 '\''sq'\'',\$x=.r") &&
 		M=$(git hash-object test.r) &&
 		M2=$(git hash-object test2.r) &&
 		M3=$(git hash-object "testsubdir/test3 '\''sq'\'',\$x=.r") &&
@@ -549,7 +545,7 @@ test_expect_success PERL 'required process filter takes precedence' '
 
 		echo "*.r filter=protocol" >.gitattributes &&
 		cp "$TEST_ROOT/test.o" test.r &&
-		S=$(file_size test.r) &&
+		S=$(test_file_size test.r) &&
 
 		# Check that the process filter is invoked here
 		filter_git add . &&
@@ -573,7 +569,7 @@ test_expect_success PERL 'required process filter should be used only for "clean
 
 		echo "*.r filter=protocol" >.gitattributes &&
 		cp "$TEST_ROOT/test.o" test.r &&
-		S=$(file_size test.r) &&
+		S=$(test_file_size test.r) &&
 
 		filter_git add . &&
 		cat >expected.log <<-EOF &&
@@ -697,9 +693,9 @@ test_expect_success PERL 'process filter should restart after unexpected write f
 		echo "this is going to fail" >smudge-write-fail.o &&
 		cp smudge-write-fail.o smudge-write-fail.r &&
 
-		S=$(file_size test.r) &&
-		S2=$(file_size test2.r) &&
-		SF=$(file_size smudge-write-fail.r) &&
+		S=$(test_file_size test.r) &&
+		S2=$(test_file_size test2.r) &&
+		SF=$(test_file_size smudge-write-fail.r) &&
 		M=$(git hash-object test.r) &&
 		M2=$(git hash-object test2.r) &&
 		MF=$(git hash-object smudge-write-fail.r) &&
@@ -752,9 +748,9 @@ test_expect_success PERL 'process filter should not be restarted if it signals a
 		echo "this will cause an error" >error.o &&
 		cp error.o error.r &&
 
-		S=$(file_size test.r) &&
-		S2=$(file_size test2.r) &&
-		SE=$(file_size error.r) &&
+		S=$(test_file_size test.r) &&
+		S2=$(test_file_size test2.r) &&
+		SE=$(test_file_size error.r) &&
 		M=$(git hash-object test.r) &&
 		M2=$(git hash-object test2.r) &&
 		ME=$(git hash-object error.r) &&
@@ -797,7 +793,7 @@ test_expect_success PERL 'process filter abort stops processing of all further f
 
 		M="blob=$(git hash-object abort.r)" &&
 		rm -f debug.log &&
-		SA=$(file_size abort.r) &&
+		SA=$(test_file_size abort.r) &&
 
 		git add . &&
 		rm -f *.r &&
@@ -859,7 +855,7 @@ test_expect_success PERL 'delayed checkout in process filter' '
 		git commit -m "test commit"
 	) &&
 
-	S=$(file_size "$TEST_ROOT/test.o") &&
+	S=$(test_file_size "$TEST_ROOT/test.o") &&
 	PM="ref=refs/heads/master treeish=$(git -C repo rev-parse --verify master) " &&
 	M="${PM}blob=$(git -C repo rev-parse --verify master:test.a)" &&
 	cat >a.exp <<-EOF &&
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index 61e89a8071..4bab6a513c 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -5,12 +5,6 @@ test_description='adding and checking out large blobs'
 
 . ./test-lib.sh
 
-# This should be moved to test-lib.sh together with the
-# copy in t0021 after both topics have graduated to 'master'.
-file_size () {
-	test-tool path-utils file-size "$1"
-}
-
 test_expect_success setup '
 	# clone does not allow us to pass core.bigfilethreshold to
 	# new repos, so set core.bigfilethreshold globally
@@ -29,7 +23,7 @@ do
 	test_expect_success "add with $config" '
 		test_when_finished "rm -f .git/objects/pack/pack-*.* .git/index" &&
 		git $config add large1 &&
-		sz=$(file_size .git/objects/pack/pack-*.pack) &&
+		sz=$(test_file_size .git/objects/pack/pack-*.pack) &&
 		case "$expect" in
 		small) test "$sz" -le 100000 ;;
 		large) test "$sz" -ge 100000 ;;
diff --git a/t/t5315-pack-objects-compression.sh b/t/t5315-pack-objects-compression.sh
index df970d7584..8bacd96275 100755
--- a/t/t5315-pack-objects-compression.sh
+++ b/t/t5315-pack-objects-compression.sh
@@ -4,12 +4,6 @@ test_description='pack-object compression configuration'
 
 . ./test-lib.sh
 
-# This should be moved to test-lib.sh together with the
-# copy in t0021 after both topics have graduated to 'master'.
-file_size () {
-	test-tool path-utils file-size "$1"
-}
-
 test_expect_success setup '
 	printf "%2000000s" X |
 	git hash-object -w --stdin >object-name &&
@@ -24,7 +18,7 @@ do
 	test_expect_success "pack-objects with $config" '
 		test_when_finished "rm -f pack-*.*" &&
 		git $config pack-objects pack <object-name &&
-		sz=$(file_size pack-*.pack) &&
+		sz=$(test_file_size pack-*.pack) &&
 		case "$expect" in
 		small) test "$sz" -le 100000 ;;
 		large) test "$sz" -ge 100000 ;;
diff --git a/t/t9303-fast-import-compression.sh b/t/t9303-fast-import-compression.sh
index 5045f02a53..57d916524e 100755
--- a/t/t9303-fast-import-compression.sh
+++ b/t/t9303-fast-import-compression.sh
@@ -3,12 +3,6 @@
 test_description='compression setting of fast-import utility'
 . ./test-lib.sh
 
-# This should be moved to test-lib.sh together with the
-# copy in t0021 after both topics have graduated to 'master'.
-file_size () {
-	test-tool path-utils file-size "$1"
-}
-
 import_large () {
 	(
 		echo blob
@@ -24,7 +18,7 @@ do
 		test_when_finished "rm -f .git/objects/pack/pack-*.*" &&
 		test_when_finished "rm -rf .git/objects/??" &&
 		import_large -c fastimport.unpacklimit=0 $config &&
-		sz=$(file_size .git/objects/pack/pack-*.pack) &&
+		sz=$(test_file_size .git/objects/pack/pack-*.pack) &&
 		case "$expect" in
 		small) test "$sz" -le 100000 ;;
 		large) test "$sz" -ge 100000 ;;
@@ -47,7 +41,7 @@ do
 		test_when_finished "rm -f .git/objects/pack/pack-*.*" &&
 		test_when_finished "rm -rf .git/objects/??" &&
 		import_large -c fastimport.unpacklimit=9 $config &&
-		sz=$(file_size .git/objects/??/????*) &&
+		sz=$(test_file_size .git/objects/??/????*) &&
 		case "$expect" in
 		small) test "$sz" -le 100000 ;;
 		large) test "$sz" -ge 100000 ;;
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 4a35bde145..59bbf75e83 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -783,6 +783,10 @@ test_line_count () {
 	fi
 }
 
+test_file_size () {
+	test-tool path-utils file-size "$1"
+}
+
 # Returns success if a comma separated string of keywords ($1) contains a
 # given keyword ($2).
 # Examples:

base-commit: 7f7ebe054af6d831b999d6c2241b9227c4e4e08d
-- 
gitgitgadget
