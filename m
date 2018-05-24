Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D87111F51C
	for <e@80x24.org>; Thu, 24 May 2018 07:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754890AbeEXHEy (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 03:04:54 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:46533 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751755AbeEXHEu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 03:04:50 -0400
Received: by mail-ot0-f196.google.com with SMTP id t1-v6so680244ott.13
        for <git@vger.kernel.org>; Thu, 24 May 2018 00:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IUgbLeWYeRYfLImfZvd0wWmACJn7uf4XRgyt7DDkNLI=;
        b=I9QVPGUOQ/x+xKBTRjj+kHVaKftl7+Gx25OVSVkv+EurFWODUHXg9oTyIOfwBBWFLK
         gQ5F8JhJICd0MtEv2SQezyNhlDVbZd2CyPW78150okt1XgI1FrvZSDKKZq3D1EBqg9WV
         +PIe8PxnUV74xWWXRjr+faCzdIn/Jdxg0iT6V1FYHfEofJ6h5AwCcGqtGfMUsaxWwiTR
         JeiSg6lA1r8axvFQHPqlkinuW5cxiOlMAT+RTxbMgyTpD0YmupiXFZlSrpkRO4ORyVoh
         fdt32GBNg7ClXYgEtJq+2E7PxO1ldMd8HxM++fXbbs+aNNGfsqtDhUIreOi/C6J1lrXS
         9rvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IUgbLeWYeRYfLImfZvd0wWmACJn7uf4XRgyt7DDkNLI=;
        b=gtqiS65zcHjutmKfk+pRiI80QogfnwRnj9aO4jPdMbSAGmdxbDqMzKL60SaHG1XhbL
         YBJ6kyu7WIGEtgHfJVZCHCf2h7P5TxTprRo0mVdBfM7oDSWRTJg2M2FuenV5H+N6HUTE
         +3To0ZBqnkIBqdTC3tVyOotBi3QkCG1INp/YEx3Yf0JR8dR7jG12tTVJsE1VYzCVOLVf
         TxepdPJ9SkCfpGQVfQaKea7ar8qqMdh/MQslTEaDzG5kOKCVg6M/gSBX4SnjUXCaZuaQ
         rXnfLXfu5Yc6eKTU+PeQsiev/fbotAD4y8pW0Zti48fAQ/8XlourSQJqIpki2XQVWBNI
         Lk3A==
X-Gm-Message-State: ALKqPwdUZeEfOnAJscwSgE5N6zUEvzUS/njiZUDQOJGYv8swvI7LRqC/
        Glhxt9xLTkNLUyQYo5dKbTUnYg==
X-Google-Smtp-Source: AB8JxZobVKghv/JqfbLly5BRstAVUVHKLxsIACEhuVhtaX6HdayTW95gOTQd1VmMuJrePVRUiu7Wyg==
X-Received: by 2002:a9d:38b2:: with SMTP id p47-v6mr3516195otc.213.1527145488179;
        Thu, 24 May 2018 00:04:48 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id q75-v6sm12076244ota.69.2018.05.24.00.04.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 May 2018 00:04:47 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH 1/5] t6036, t6042: use test_create_repo to keep tests independent
Date:   Thu, 24 May 2018 00:04:35 -0700
Message-Id: <20180524070439.6367-2-newren@gmail.com>
X-Mailer: git-send-email 2.17.0.1.gda85003413
In-Reply-To: <20180524070439.6367-1-newren@gmail.com>
References: <20180524070439.6367-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These tests used pretty strong measures to get a clean slate:
        git rm -rf . &&
        git clean -fdqx &&
        rm -rf .git &&
        git init &&
It's easier, safer (what if a previous test has a bug and accidentally
changes into a directory outside the test path?), and allows re-inspecting
test setup later if we instead just use test_create_repo to put different
tests into separate sub-repositories.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
Best viewed with `git diff -w`...

 t/t6036-recursive-corner-cases.sh    | 854 ++++++++++++++------------
 t/t6042-merge-rename-corner-cases.sh | 887 ++++++++++++++-------------
 2 files changed, 926 insertions(+), 815 deletions(-)

diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index 18aa88b5c0..cfe6a99771 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -21,51 +21,60 @@ get_clean_checkout () {
 #
 
 test_expect_success 'setup basic criss-cross + rename with no modifications' '
-	ten="0 1 2 3 4 5 6 7 8 9" &&
-	for i in $ten
-	do
-		echo line $i in a sample file
-	done >one &&
-	for i in $ten
-	do
-		echo line $i in another sample file
-	done >two &&
-	git add one two &&
-	test_tick && git commit -m initial &&
-
-	git branch L1 &&
-	git checkout -b R1 &&
-	git mv one three &&
-	test_tick && git commit -m R1 &&
-
-	git checkout L1 &&
-	git mv two three &&
-	test_tick && git commit -m L1 &&
-
-	git checkout L1^0 &&
-	test_tick && git merge -s ours R1 &&
-	git tag L2 &&
-
-	git checkout R1^0 &&
-	test_tick && git merge -s ours L1 &&
-	git tag R2
+	test_create_repo basic-rename &&
+	(
+		cd basic-rename &&
+
+		ten="0 1 2 3 4 5 6 7 8 9" &&
+		for i in $ten
+		do
+			echo line $i in a sample file
+		done >one &&
+		for i in $ten
+		do
+			echo line $i in another sample file
+		done >two &&
+		git add one two &&
+		test_tick && git commit -m initial &&
+
+		git branch L1 &&
+		git checkout -b R1 &&
+		git mv one three &&
+		test_tick && git commit -m R1 &&
+
+		git checkout L1 &&
+		git mv two three &&
+		test_tick && git commit -m L1 &&
+
+		git checkout L1^0 &&
+		test_tick && git merge -s ours R1 &&
+		git tag L2 &&
+
+		git checkout R1^0 &&
+		test_tick && git merge -s ours L1 &&
+		git tag R2
+	)
 '
 
 test_expect_success 'merge simple rename+criss-cross with no modifications' '
-	git reset --hard &&
-	git checkout L2^0 &&
+	(
+		cd basic-rename &&
+
+		git reset --hard &&
+		git checkout L2^0 &&
 
-	test_must_fail git merge -s recursive R2^0 &&
+		test_must_fail git merge -s recursive R2^0 &&
 
-	test 2 = $(git ls-files -s | wc -l) &&
-	test 2 = $(git ls-files -u | wc -l) &&
-	test 2 = $(git ls-files -o | wc -l) &&
+		test 2 = $(git ls-files -s | wc -l) &&
+		test 2 = $(git ls-files -u | wc -l) &&
+		test 2 = $(git ls-files -o | wc -l) &&
 
-	test $(git rev-parse :2:three) = $(git rev-parse L2:three) &&
-	test $(git rev-parse :3:three) = $(git rev-parse R2:three) &&
+		test $(git rev-parse :2:three) = $(git rev-parse L2:three) &&
+		test $(git rev-parse :3:three) = $(git rev-parse R2:three) &&
 
-	test $(git rev-parse L2:three) = $(git hash-object three~HEAD) &&
-	test $(git rev-parse R2:three) = $(git hash-object three~R2^0)
+		test $(git rev-parse L2:three) = $(git hash-object three~HEAD) &&
+		test $(git rev-parse R2:three) = $(git hash-object three~R2^0)
+	)
 '
 
 #
@@ -81,58 +90,61 @@ test_expect_success 'merge simple rename+criss-cross with no modifications' '
 #
 
 test_expect_success 'setup criss-cross + rename merges with basic modification' '
-	git rm -rf . &&
-	git clean -fdqx &&
-	rm -rf .git &&
-	git init &&
-
-	ten="0 1 2 3 4 5 6 7 8 9" &&
-	for i in $ten
-	do
-		echo line $i in a sample file
-	done >one &&
-	for i in $ten
-	do
-		echo line $i in another sample file
-	done >two &&
-	git add one two &&
-	test_tick && git commit -m initial &&
-
-	git branch L1 &&
-	git checkout -b R1 &&
-	git mv one three &&
-	echo more >>two &&
-	git add two &&
-	test_tick && git commit -m R1 &&
-
-	git checkout L1 &&
-	git mv two three &&
-	test_tick && git commit -m L1 &&
-
-	git checkout L1^0 &&
-	test_tick && git merge -s ours R1 &&
-	git tag L2 &&
-
-	git checkout R1^0 &&
-	test_tick && git merge -s ours L1 &&
-	git tag R2
+	test_create_repo rename-modify &&
+	(
+		cd rename-modify &&
+
+		ten="0 1 2 3 4 5 6 7 8 9" &&
+		for i in $ten
+		do
+			echo line $i in a sample file
+		done >one &&
+		for i in $ten
+		do
+			echo line $i in another sample file
+		done >two &&
+		git add one two &&
+		test_tick && git commit -m initial &&
+
+		git branch L1 &&
+		git checkout -b R1 &&
+		git mv one three &&
+		echo more >>two &&
+		git add two &&
+		test_tick && git commit -m R1 &&
+
+		git checkout L1 &&
+		git mv two three &&
+		test_tick && git commit -m L1 &&
+
+		git checkout L1^0 &&
+		test_tick && git merge -s ours R1 &&
+		git tag L2 &&
+
+		git checkout R1^0 &&
+		test_tick && git merge -s ours L1 &&
+		git tag R2
+	)
 '
 
 test_expect_success 'merge criss-cross + rename merges with basic modification' '
-	git reset --hard &&
-	git checkout L2^0 &&
+	(
+		cd rename-modify &&
+
+		git checkout L2^0 &&
 
-	test_must_fail git merge -s recursive R2^0 &&
+		test_must_fail git merge -s recursive R2^0 &&
 
-	test 2 = $(git ls-files -s | wc -l) &&
-	test 2 = $(git ls-files -u | wc -l) &&
-	test 2 = $(git ls-files -o | wc -l) &&
+		test 2 = $(git ls-files -s | wc -l) &&
+		test 2 = $(git ls-files -u | wc -l) &&
+		test 2 = $(git ls-files -o | wc -l) &&
 
-	test $(git rev-parse :2:three) = $(git rev-parse L2:three) &&
-	test $(git rev-parse :3:three) = $(git rev-parse R2:three) &&
+		test $(git rev-parse :2:three) = $(git rev-parse L2:three) &&
+		test $(git rev-parse :3:three) = $(git rev-parse R2:three) &&
 
-	test $(git rev-parse L2:three) = $(git hash-object three~HEAD) &&
-	test $(git rev-parse R2:three) = $(git hash-object three~R2^0)
+		test $(git rev-parse L2:three) = $(git hash-object three~HEAD) &&
+		test $(git rev-parse R2:three) = $(git hash-object three~R2^0)
+	)
 '
 
 #
@@ -156,64 +168,67 @@ test_expect_success 'merge criss-cross + rename merges with basic modification'
 #
 
 test_expect_success 'setup differently handled merges of rename/add conflict' '
-	git rm -rf . &&
-	git clean -fdqx &&
-	rm -rf .git &&
-	git init &&
-
-	printf "0\n1\n2\n3\n4\n5\n6\n7\n8\n9\n" >a &&
-	git add a &&
-	test_tick && git commit -m A &&
-
-	git branch B &&
-	git checkout -b C &&
-	echo 10 >>a &&
-	echo "other content" >>new_a &&
-	git add a new_a &&
-	test_tick && git commit -m C &&
-
-	git checkout B &&
-	git mv a new_a &&
-	test_tick && git commit -m B &&
-
-	git checkout B^0 &&
-	test_must_fail git merge C &&
-	git clean -f &&
-	test_tick && git commit -m D &&
-	git tag D &&
-
-	git checkout C^0 &&
-	test_must_fail git merge B &&
-	rm new_a~HEAD new_a &&
-	printf "Incorrectly merged content" >>new_a &&
-	git add -u &&
-	test_tick && git commit -m E &&
-	git tag E
+	test_create_repo rename-add &&
+	(
+		cd rename-add &&
+
+		printf "0\n1\n2\n3\n4\n5\n6\n7\n8\n9\n" >a &&
+		git add a &&
+		test_tick && git commit -m A &&
+
+		git branch B &&
+		git checkout -b C &&
+		echo 10 >>a &&
+		echo "other content" >>new_a &&
+		git add a new_a &&
+		test_tick && git commit -m C &&
+
+		git checkout B &&
+		git mv a new_a &&
+		test_tick && git commit -m B &&
+
+		git checkout B^0 &&
+		test_must_fail git merge C &&
+		git clean -f &&
+		test_tick && git commit -m D &&
+		git tag D &&
+
+		git checkout C^0 &&
+		test_must_fail git merge B &&
+		rm new_a~HEAD new_a &&
+		printf "Incorrectly merged content" >>new_a &&
+		git add -u &&
+		test_tick && git commit -m E &&
+		git tag E
+	)
 '
 
 test_expect_success 'git detects differently handled merges conflict' '
-	git reset --hard &&
-	git checkout D^0 &&
-
-	test_must_fail git merge -s recursive E^0 &&
-
-	test 3 = $(git ls-files -s | wc -l) &&
-	test 3 = $(git ls-files -u | wc -l) &&
-	test 0 = $(git ls-files -o | wc -l) &&
-
-	test $(git rev-parse :2:new_a) = $(git rev-parse D:new_a) &&
-	test $(git rev-parse :3:new_a) = $(git rev-parse E:new_a) &&
-
-	git cat-file -p B:new_a >>merged &&
-	git cat-file -p C:new_a >>merge-me &&
-	>empty &&
-	test_must_fail git merge-file \
-		-L "Temporary merge branch 2" \
-		-L "" \
-		-L "Temporary merge branch 1" \
-		merged empty merge-me &&
-	sed -e "s/^\([<=>]\)/\1\1\1/" merged >merged-internal &&
-	test $(git rev-parse :1:new_a) = $(git hash-object merged-internal)
+	(
+		cd rename-add &&
+
+		git checkout D^0 &&
+
+		test_must_fail git merge -s recursive E^0 &&
+
+		test 3 = $(git ls-files -s | wc -l) &&
+		test 3 = $(git ls-files -u | wc -l) &&
+		test 0 = $(git ls-files -o | wc -l) &&
+
+		test $(git rev-parse :2:new_a) = $(git rev-parse D:new_a) &&
+		test $(git rev-parse :3:new_a) = $(git rev-parse E:new_a) &&
+
+		git cat-file -p B:new_a >>merged &&
+		git cat-file -p C:new_a >>merge-me &&
+		>empty &&
+		test_must_fail git merge-file \
+			-L "Temporary merge branch 2" \
+			-L "" \
+			-L "Temporary merge branch 1" \
+			merged empty merge-me &&
+		sed -e "s/^\([<=>]\)/\1\1\1/" merged >merged-internal &&
+		test $(git rev-parse :1:new_a) = $(git hash-object merged-internal)
+	)
 '
 
 #
@@ -236,67 +251,75 @@ test_expect_success 'git detects differently handled merges conflict' '
 # Merging commits D & E should result in modify/delete conflict.
 
 test_expect_success 'setup criss-cross + modify/delete resolved differently' '
-	git rm -rf . &&
-	git clean -fdqx &&
-	rm -rf .git &&
-	git init &&
-
-	echo A >file &&
-	git add file &&
-	test_tick &&
-	git commit -m A &&
-
-	git branch B &&
-	git checkout -b C &&
-	git rm file &&
-	test_tick &&
-	git commit -m C &&
-
-	git checkout B &&
-	echo B >file &&
-	git add file &&
-	test_tick &&
-	git commit -m B &&
-
-	git checkout B^0 &&
-	test_must_fail git merge C &&
-	echo B >file &&
-	git add file &&
-	test_tick &&
-	git commit -m D &&
-	git tag D &&
-
-	git checkout C^0 &&
-	test_must_fail git merge B &&
-	git rm file &&
-	test_tick &&
-	git commit -m E &&
-	git tag E
+	test_create_repo modify-delete &&
+	(
+		cd modify-delete &&
+
+		echo A >file &&
+		git add file &&
+		test_tick &&
+		git commit -m A &&
+
+		git branch B &&
+		git checkout -b C &&
+		git rm file &&
+		test_tick &&
+		git commit -m C &&
+
+		git checkout B &&
+		echo B >file &&
+		git add file &&
+		test_tick &&
+		git commit -m B &&
+
+		git checkout B^0 &&
+		test_must_fail git merge C &&
+		echo B >file &&
+		git add file &&
+		test_tick &&
+		git commit -m D &&
+		git tag D &&
+
+		git checkout C^0 &&
+		test_must_fail git merge B &&
+		git rm file &&
+		test_tick &&
+		git commit -m E &&
+		git tag E
+	)
 '
 
 test_expect_success 'git detects conflict merging criss-cross+modify/delete' '
-	git checkout D^0 &&
+	(
+		cd modify-delete &&
+
+		git checkout D^0 &&
 
-	test_must_fail git merge -s recursive E^0 &&
+		test_must_fail git merge -s recursive E^0 &&
 
-	test 2 -eq $(git ls-files -s | wc -l) &&
-	test 2 -eq $(git ls-files -u | wc -l) &&
+		test 2 -eq $(git ls-files -s | wc -l) &&
+		test 2 -eq $(git ls-files -u | wc -l) &&
 
-	test $(git rev-parse :1:file) = $(git rev-parse master:file) &&
-	test $(git rev-parse :2:file) = $(git rev-parse B:file)
+		test $(git rev-parse :1:file) = $(git rev-parse master:file) &&
+		test $(git rev-parse :2:file) = $(git rev-parse B:file)
+	)
 '
 
 test_expect_success 'git detects conflict merging criss-cross+modify/delete, reverse direction' '
-	git reset --hard &&
-	git checkout E^0 &&
+	(
+		cd modify-delete &&
+
+		git reset --hard &&
+		git checkout E^0 &&
 
-	test_must_fail git merge -s recursive D^0 &&
+		test_must_fail git merge -s recursive D^0 &&
 
-	test 2 -eq $(git ls-files -s | wc -l) &&
-	test 2 -eq $(git ls-files -u | wc -l) &&
+		test 2 -eq $(git ls-files -s | wc -l) &&
+		test 2 -eq $(git ls-files -u | wc -l) &&
 
-	test $(git rev-parse :1:file) = $(git rev-parse master:file) &&
-	test $(git rev-parse :3:file) = $(git rev-parse B:file)
+		test $(git rev-parse :1:file) = $(git rev-parse master:file) &&
+		test $(git rev-parse :3:file) = $(git rev-parse B:file)
+	)
 '
 
 #
@@ -336,120 +359,136 @@ test_expect_success 'git detects conflict merging criss-cross+modify/delete, rev
 #
 
 test_expect_success 'setup differently handled merges of directory/file conflict' '
-	git rm -rf . &&
-	git clean -fdqx &&
-	rm -rf .git &&
-	git init &&
-
-	>ignore-me &&
-	git add ignore-me &&
-	test_tick &&
-	git commit -m A &&
-	git tag A &&
-
-	git branch B &&
-	git checkout -b C &&
-	mkdir a &&
-	echo 10 >a/file &&
-	git add a/file &&
-	test_tick &&
-	git commit -m C &&
-
-	git checkout B &&
-	echo 5 >a &&
-	git add a &&
-	test_tick &&
-	git commit -m B &&
-
-	git checkout B^0 &&
-	test_must_fail git merge C &&
-	git clean -f &&
-	rm -rf a/ &&
-	echo 5 >a &&
-	git add a &&
-	test_tick &&
-	git commit -m D &&
-	git tag D &&
-
-	git checkout C^0 &&
-	test_must_fail git merge B &&
-	git clean -f &&
-	git rm --cached a &&
-	echo 10 >a/file &&
-	git add a/file &&
-	test_tick &&
-	git commit -m E1 &&
-	git tag E1 &&
-
-	git checkout C^0 &&
-	test_must_fail git merge B &&
-	git clean -f &&
-	git rm --cached a &&
-	printf "10\n11\n" >a/file &&
-	git add a/file &&
-	test_tick &&
-	git commit -m E2 &&
-	git tag E2
+	test_create_repo directory-file &&
+	(
+		cd directory-file &&
+
+		>ignore-me &&
+		git add ignore-me &&
+		test_tick &&
+		git commit -m A &&
+		git tag A &&
+
+		git branch B &&
+		git checkout -b C &&
+		mkdir a &&
+		echo 10 >a/file &&
+		git add a/file &&
+		test_tick &&
+		git commit -m C &&
+
+		git checkout B &&
+		echo 5 >a &&
+		git add a &&
+		test_tick &&
+		git commit -m B &&
+
+		git checkout B^0 &&
+		test_must_fail git merge C &&
+		git clean -f &&
+		rm -rf a/ &&
+		echo 5 >a &&
+		git add a &&
+		test_tick &&
+		git commit -m D &&
+		git tag D &&
+
+		git checkout C^0 &&
+		test_must_fail git merge B &&
+		git clean -f &&
+		git rm --cached a &&
+		echo 10 >a/file &&
+		git add a/file &&
+		test_tick &&
+		git commit -m E1 &&
+		git tag E1 &&
+
+		git checkout C^0 &&
+		test_must_fail git merge B &&
+		git clean -f &&
+		git rm --cached a &&
+		printf "10\n11\n" >a/file &&
+		git add a/file &&
+		test_tick &&
+		git commit -m E2 &&
+		git tag E2
+	)
 '
 
 test_expect_success 'merge of D & E1 fails but has appropriate contents' '
-	get_clean_checkout D^0 &&
+	(
+		cd directory-file &&
 
-	test_must_fail git merge -s recursive E1^0 &&
+		get_clean_checkout D^0 &&
 
-	test 2 -eq $(git ls-files -s | wc -l) &&
-	test 1 -eq $(git ls-files -u | wc -l) &&
-	test 0 -eq $(git ls-files -o | wc -l) &&
+		test_must_fail git merge -s recursive E1^0 &&
 
-	test $(git rev-parse :0:ignore-me) = $(git rev-parse A:ignore-me) &&
-	test $(git rev-parse :2:a) = $(git rev-parse B:a)
+		test 2 -eq $(git ls-files -s | wc -l) &&
+		test 1 -eq $(git ls-files -u | wc -l) &&
+		test 0 -eq $(git ls-files -o | wc -l) &&
+
+		test $(git rev-parse :0:ignore-me) = $(git rev-parse A:ignore-me) &&
+		test $(git rev-parse :2:a) = $(git rev-parse B:a)
+	)
 '
 
 test_expect_success 'merge of E1 & D fails but has appropriate contents' '
-	get_clean_checkout E1^0 &&
+	(
+		cd directory-file &&
+
+		get_clean_checkout E1^0 &&
 
-	test_must_fail git merge -s recursive D^0 &&
+		test_must_fail git merge -s recursive D^0 &&
 
-	test 2 -eq $(git ls-files -s | wc -l) &&
-	test 1 -eq $(git ls-files -u | wc -l) &&
-	test 0 -eq $(git ls-files -o | wc -l) &&
+		test 2 -eq $(git ls-files -s | wc -l) &&
+		test 1 -eq $(git ls-files -u | wc -l) &&
+		test 0 -eq $(git ls-files -o | wc -l) &&
 
-	test $(git rev-parse :0:ignore-me) = $(git rev-parse A:ignore-me) &&
-	test $(git rev-parse :3:a) = $(git rev-parse B:a)
+		test $(git rev-parse :0:ignore-me) = $(git rev-parse A:ignore-me) &&
+		test $(git rev-parse :3:a) = $(git rev-parse B:a)
+	)
 '
 
 test_expect_success 'merge of D & E2 fails but has appropriate contents' '
-	get_clean_checkout D^0 &&
+	(
+		cd directory-file &&
+
+		get_clean_checkout D^0 &&
 
-	test_must_fail git merge -s recursive E2^0 &&
+		test_must_fail git merge -s recursive E2^0 &&
 
-	test 4 -eq $(git ls-files -s | wc -l) &&
-	test 3 -eq $(git ls-files -u | wc -l) &&
-	test 1 -eq $(git ls-files -o | wc -l) &&
+		test 4 -eq $(git ls-files -s | wc -l) &&
+		test 3 -eq $(git ls-files -u | wc -l) &&
+		test 1 -eq $(git ls-files -o | wc -l) &&
 
-	test $(git rev-parse :2:a) = $(git rev-parse B:a) &&
-	test $(git rev-parse :3:a/file) = $(git rev-parse E2:a/file) &&
-	test $(git rev-parse :1:a/file) = $(git rev-parse C:a/file) &&
-	test $(git rev-parse :0:ignore-me) = $(git rev-parse A:ignore-me) &&
+		test $(git rev-parse :2:a) = $(git rev-parse B:a) &&
+		test $(git rev-parse :3:a/file) = $(git rev-parse E2:a/file) &&
+		test $(git rev-parse :1:a/file) = $(git rev-parse C:a/file) &&
+		test $(git rev-parse :0:ignore-me) = $(git rev-parse A:ignore-me) &&
 
-	test -f a~HEAD
+		test -f a~HEAD
+	)
 '
 
 test_expect_success 'merge of E2 & D fails but has appropriate contents' '
-	get_clean_checkout E2^0 &&
+	(
+		cd directory-file &&
 
-	test_must_fail git merge -s recursive D^0 &&
+		get_clean_checkout E2^0 &&
 
-	test 4 -eq $(git ls-files -s | wc -l) &&
-	test 3 -eq $(git ls-files -u | wc -l) &&
-	test 1 -eq $(git ls-files -o | wc -l) &&
+		test_must_fail git merge -s recursive D^0 &&
 
-	test $(git rev-parse :3:a) = $(git rev-parse B:a) &&
-	test $(git rev-parse :2:a/file) = $(git rev-parse E2:a/file) &&
-	test $(git rev-parse :1:a/file) = $(git rev-parse C:a/file) &&
-	test $(git rev-parse :0:ignore-me) = $(git rev-parse A:ignore-me) &&
+		test 4 -eq $(git ls-files -s | wc -l) &&
+		test 3 -eq $(git ls-files -u | wc -l) &&
+		test 1 -eq $(git ls-files -o | wc -l) &&
 
-	test -f a~D^0
+		test $(git rev-parse :3:a) = $(git rev-parse B:a) &&
+		test $(git rev-parse :2:a/file) = $(git rev-parse E2:a/file) &&
+		test $(git rev-parse :1:a/file) = $(git rev-parse C:a/file) &&
+		test $(git rev-parse :0:ignore-me) = $(git rev-parse A:ignore-me) &&
+
+		test -f a~D^0
+	)
 '
 
 #
@@ -492,52 +531,55 @@ test_expect_success 'merge of E2 & D fails but has appropriate contents' '
 # but that may cancel out at the final merge stage".
 
 test_expect_success 'setup rename/rename(1to2)/modify followed by what looks like rename/rename(2to1)/modify' '
-	git reset --hard &&
-	git rm -rf . &&
-	git clean -fdqx &&
-	rm -rf .git &&
-	git init &&
-
-	printf "1\n2\n3\n4\n5\n6\n" >a &&
-	git add a &&
-	git commit -m A &&
-	git tag A &&
-
-	git checkout -b B A &&
-	git mv a b &&
-	echo 7 >>b &&
-	git add -u &&
-	git commit -m B &&
-
-	git checkout -b C A &&
-	git mv a c &&
-	git commit -m C &&
-
-	git checkout -q B^0 &&
-	git merge --no-commit -s ours C^0 &&
-	git mv b newname &&
-	git commit -m "Merge commit C^0 into HEAD" &&
-	git tag D &&
-
-	git checkout -q C^0 &&
-	git merge --no-commit -s ours B^0 &&
-	git mv c newname &&
-	printf "7\n8\n" >>newname &&
-	git add -u &&
-	git commit -m "Merge commit B^0 into HEAD" &&
-	git tag E
+	test_create_repo rename-squared-squared &&
+	(
+		cd rename-squared-squared &&
+
+		printf "1\n2\n3\n4\n5\n6\n" >a &&
+		git add a &&
+		git commit -m A &&
+		git tag A &&
+
+		git checkout -b B A &&
+		git mv a b &&
+		echo 7 >>b &&
+		git add -u &&
+		git commit -m B &&
+
+		git checkout -b C A &&
+		git mv a c &&
+		git commit -m C &&
+
+		git checkout -q B^0 &&
+		git merge --no-commit -s ours C^0 &&
+		git mv b newname &&
+		git commit -m "Merge commit C^0 into HEAD" &&
+		git tag D &&
+
+		git checkout -q C^0 &&
+		git merge --no-commit -s ours B^0 &&
+		git mv c newname &&
+		printf "7\n8\n" >>newname &&
+		git add -u &&
+		git commit -m "Merge commit B^0 into HEAD" &&
+		git tag E
+	)
 '
 
 test_expect_success 'handle rename/rename(1to2)/modify followed by what looks like rename/rename(2to1)/modify' '
-	git checkout D^0 &&
+	(
+		cd rename-squared-squared &&
 
-	git merge -s recursive E^0 &&
+		git checkout D^0 &&
 
-	test 1 -eq $(git ls-files -s | wc -l) &&
-	test 0 -eq $(git ls-files -u | wc -l) &&
-	test 0 -eq $(git ls-files -o | wc -l) &&
+		git merge -s recursive E^0 &&
 
-	test $(git rev-parse HEAD:newname) = $(git rev-parse E:newname)
+		test 1 -eq $(git ls-files -s | wc -l) &&
+		test 0 -eq $(git ls-files -u | wc -l) &&
+		test 0 -eq $(git ls-files -o | wc -l) &&
+
+		test $(git rev-parse HEAD:newname) = $(git rev-parse E:newname)
+	)
 '
 
 #
@@ -562,59 +604,63 @@ test_expect_success 'handle rename/rename(1to2)/modify followed by what looks li
 # renaming carefully (both in the virtual merge base and later), and getting
 # content merge handled.
 
-test_expect_success 'setup criss-cross + rename/rename/add + modify/modify' '
-	git rm -rf . &&
-	git clean -fdqx &&
-	rm -rf .git &&
-	git init &&
-
-	printf "lots\nof\nwords\nand\ncontent\n" >a &&
-	git add a &&
-	git commit -m A &&
-	git tag A &&
-
-	git checkout -b B A &&
-	git mv a b &&
-	git commit -m B &&
-
-	git checkout -b C A &&
-	git mv a c &&
-	printf "2\n3\n4\n5\n6\n7\n" >a &&
-	git add a &&
-	git commit -m C &&
-
-	git checkout B^0 &&
-	git merge --no-commit -s ours C^0 &&
-	git checkout C -- a c &&
-	mv a old_a &&
-	echo 1 >a &&
-	cat old_a >>a &&
-	rm old_a &&
-	git add -u &&
-	git commit -m "Merge commit C^0 into HEAD" &&
-	git tag D &&
-
-	git checkout C^0 &&
-	git merge --no-commit -s ours B^0 &&
-	git checkout B -- b &&
-	echo 8 >>a &&
-	git add -u &&
-	git commit -m "Merge commit B^0 into HEAD" &&
-	git tag E
+test_expect_success 'setup criss-cross + rename/rename/add-source + modify/modify' '
+	test_create_repo rename-rename-add-source &&
+	(
+		cd rename-rename-add-source &&
+
+		printf "lots\nof\nwords\nand\ncontent\n" >a &&
+		git add a &&
+		git commit -m A &&
+		git tag A &&
+
+		git checkout -b B A &&
+		git mv a b &&
+		git commit -m B &&
+
+		git checkout -b C A &&
+		git mv a c &&
+		printf "2\n3\n4\n5\n6\n7\n" >a &&
+		git add a &&
+		git commit -m C &&
+
+		git checkout B^0 &&
+		git merge --no-commit -s ours C^0 &&
+		git checkout C -- a c &&
+		mv a old_a &&
+		echo 1 >a &&
+		cat old_a >>a &&
+		rm old_a &&
+		git add -u &&
+		git commit -m "Merge commit C^0 into HEAD" &&
+		git tag D &&
+
+		git checkout C^0 &&
+		git merge --no-commit -s ours B^0 &&
+		git checkout B -- b &&
+		echo 8 >>a &&
+		git add -u &&
+		git commit -m "Merge commit B^0 into HEAD" &&
+		git tag E
+	)
 '
 
 test_expect_failure 'detect rename/rename/add-source for virtual merge-base' '
-	git checkout D^0 &&
+	(
+		cd rename-rename-add-source &&
+
+		git checkout D^0 &&
 
-	git merge -s recursive E^0 &&
+		git merge -s recursive E^0 &&
 
-	test 3 -eq $(git ls-files -s | wc -l) &&
-	test 0 -eq $(git ls-files -u | wc -l) &&
-	test 0 -eq $(git ls-files -o | wc -l) &&
+		test 3 -eq $(git ls-files -s | wc -l) &&
+		test 0 -eq $(git ls-files -u | wc -l) &&
+		test 0 -eq $(git ls-files -o | wc -l) &&
 
-	test $(git rev-parse HEAD:b) = $(git rev-parse A:a) &&
-	test $(git rev-parse HEAD:c) = $(git rev-parse A:a) &&
-	test "$(cat a)" = "$(printf "1\n2\n3\n4\n5\n6\n7\n8\n")"
+		test $(git rev-parse HEAD:b) = $(git rev-parse A:a) &&
+		test $(git rev-parse HEAD:c) = $(git rev-parse A:a) &&
+		test "$(cat a)" = "$(printf "1\n2\n3\n4\n5\n6\n7\n8\n")"
+	)
 '
 
 #
@@ -638,52 +684,56 @@ test_expect_failure 'detect rename/rename/add-source for virtual merge-base' '
 # base of B & C needs to not delete B:c for that to work, though...
 
 test_expect_success 'setup criss-cross+rename/rename/add-dest + simple modify' '
-	git rm -rf . &&
-	git clean -fdqx &&
-	rm -rf .git &&
-	git init &&
-
-	>a &&
-	git add a &&
-	git commit -m A &&
-	git tag A &&
-
-	git checkout -b B A &&
-	git mv a b &&
-	printf "1\n2\n3\n4\n5\n6\n7\n" >c &&
-	git add c &&
-	git commit -m B &&
-
-	git checkout -b C A &&
-	git mv a c &&
-	git commit -m C &&
-
-	git checkout B^0 &&
-	git merge --no-commit -s ours C^0 &&
-	git mv b a &&
-	git commit -m "D is like B but renames b back to a" &&
-	git tag D &&
-
-	git checkout B^0 &&
-	git merge --no-commit -s ours C^0 &&
-	git mv b a &&
-	echo 8 >>c &&
-	git add c &&
-	git commit -m "E like D but has mod in c" &&
-	git tag E
+	test_create_repo rename-rename-add-dest &&
+	(
+		cd rename-rename-add-dest &&
+
+		>a &&
+		git add a &&
+		git commit -m A &&
+		git tag A &&
+
+		git checkout -b B A &&
+		git mv a b &&
+		printf "1\n2\n3\n4\n5\n6\n7\n" >c &&
+		git add c &&
+		git commit -m B &&
+
+		git checkout -b C A &&
+		git mv a c &&
+		git commit -m C &&
+
+		git checkout B^0 &&
+		git merge --no-commit -s ours C^0 &&
+		git mv b a &&
+		git commit -m "D is like B but renames b back to a" &&
+		git tag D &&
+
+		git checkout B^0 &&
+		git merge --no-commit -s ours C^0 &&
+		git mv b a &&
+		echo 8 >>c &&
+		git add c &&
+		git commit -m "E like D but has mod in c" &&
+		git tag E
+	)
 '
 
 test_expect_success 'virtual merge base handles rename/rename(1to2)/add-dest' '
-	git checkout D^0 &&
+	(
+		cd rename-rename-add-dest &&
+
+		git checkout D^0 &&
 
-	git merge -s recursive E^0 &&
+		git merge -s recursive E^0 &&
 
-	test 2 -eq $(git ls-files -s | wc -l) &&
-	test 0 -eq $(git ls-files -u | wc -l) &&
-	test 0 -eq $(git ls-files -o | wc -l) &&
+		test 2 -eq $(git ls-files -s | wc -l) &&
+		test 0 -eq $(git ls-files -u | wc -l) &&
+		test 0 -eq $(git ls-files -o | wc -l) &&
 
-	test $(git rev-parse HEAD:a) = $(git rev-parse A:a) &&
-	test $(git rev-parse HEAD:c) = $(git rev-parse E:c)
+		test $(git rev-parse HEAD:a) = $(git rev-parse A:a) &&
+		test $(git rev-parse HEAD:c) = $(git rev-parse E:c)
+	)
 '
 
 test_done
diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
index 411550d2b6..bec0192c3b 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -6,31 +6,40 @@ test_description="recursive merge corner cases w/ renames but not criss-crosses"
 . ./test-lib.sh
 
 test_expect_success 'setup rename/delete + untracked file' '
-	echo "A pretty inscription" >ring &&
-	git add ring &&
-	test_tick &&
-	git commit -m beginning &&
-
-	git branch people &&
-	git checkout -b rename-the-ring &&
-	git mv ring one-ring-to-rule-them-all &&
-	test_tick &&
-	git commit -m fullname &&
-
-	git checkout people &&
-	git rm ring &&
-	echo gollum >owner &&
-	git add owner &&
-	test_tick &&
-	git commit -m track-people-instead-of-objects &&
-	echo "Myyy PRECIOUSSS" >ring
+	test_create_repo rename-delete-untracked &&
+	(
+		cd rename-delete-untracked &&
+
+		echo "A pretty inscription" >ring &&
+		git add ring &&
+		test_tick &&
+		git commit -m beginning &&
+
+		git branch people &&
+		git checkout -b rename-the-ring &&
+		git mv ring one-ring-to-rule-them-all &&
+		test_tick &&
+		git commit -m fullname &&
+
+		git checkout people &&
+		git rm ring &&
+		echo gollum >owner &&
+		git add owner &&
+		test_tick &&
+		git commit -m track-people-instead-of-objects &&
+		echo "Myyy PRECIOUSSS" >ring
+	)
 '
 
 test_expect_success "Does git preserve Gollum's precious artifact?" '
-	test_must_fail git merge -s recursive rename-the-ring &&
+	(
+		cd rename-delete-untracked &&
 
-	# Make sure git did not delete an untracked file
-	test -f ring
+		test_must_fail git merge -s recursive rename-the-ring &&
+
+		# Make sure git did not delete an untracked file
+		test -f ring
+	)
 '
 
 # Testcase setup for rename/modify/add-source:
@@ -41,96 +50,116 @@ test_expect_success "Does git preserve Gollum's precious artifact?" '
 # We should be able to merge B & C cleanly
 
 test_expect_success 'setup rename/modify/add-source conflict' '
-	git rm -rf . &&
-	git clean -fdqx &&
-	rm -rf .git &&
-	git init &&
-
-	printf "1\n2\n3\n4\n5\n6\n7\n" >a &&
-	git add a &&
-	git commit -m A &&
-	git tag A &&
-
-	git checkout -b B A &&
-	echo 8 >>a &&
-	git add a &&
-	git commit -m B &&
-
-	git checkout -b C A &&
-	git mv a b &&
-	echo something completely different >a &&
-	git add a &&
-	git commit -m C
+	test_create_repo rename-modify-add-source &&
+	(
+		cd rename-modify-add-source &&
+
+		printf "1\n2\n3\n4\n5\n6\n7\n" >a &&
+		git add a &&
+		git commit -m A &&
+		git tag A &&
+
+		git checkout -b B A &&
+		echo 8 >>a &&
+		git add a &&
+		git commit -m B &&
+
+		git checkout -b C A &&
+		git mv a b &&
+		echo something completely different >a &&
+		git add a &&
+		git commit -m C
+	)
 '
 
 test_expect_failure 'rename/modify/add-source conflict resolvable' '
-	git checkout B^0 &&
+	(
+		cd rename-modify-add-source &&
+
+		git checkout B^0 &&
 
-	git merge -s recursive C^0 &&
+		git merge -s recursive C^0 &&
 
-	test $(git rev-parse B:a) = $(git rev-parse b) &&
-	test $(git rev-parse C:a) = $(git rev-parse a)
+		test $(git rev-parse B:a) = $(git rev-parse b) &&
+		test $(git rev-parse C:a) = $(git rev-parse a)
+	)
 '
 
 test_expect_success 'setup resolvable conflict missed if rename missed' '
-	git rm -rf . &&
-	git clean -fdqx &&
-	rm -rf .git &&
-	git init &&
-
-	printf "1\n2\n3\n4\n5\n" >a &&
-	echo foo >b &&
-	git add a b &&
-	git commit -m A &&
-	git tag A &&
-
-	git checkout -b B A &&
-	git mv a c &&
-	echo "Completely different content" >a &&
-	git add a &&
-	git commit -m B &&
-
-	git checkout -b C A &&
-	echo 6 >>a &&
-	git add a &&
-	git commit -m C
+	test_create_repo break-detection-1 &&
+	(
+		cd break-detection-1 &&
+
+		printf "1\n2\n3\n4\n5\n" >a &&
+		echo foo >b &&
+		git add a b &&
+		git commit -m A &&
+		git tag A &&
+
+		git checkout -b B A &&
+		git mv a c &&
+		echo "Completely different content" >a &&
+		git add a &&
+		git commit -m B &&
+
+		git checkout -b C A &&
+		echo 6 >>a &&
+		git add a &&
+		git commit -m C
+	)
 '
 
 test_expect_failure 'conflict caused if rename not detected' '
-	git checkout -q C^0 &&
-	git merge -s recursive B^0 &&
+	(
+		cd break-detection-1 &&
+
+		git checkout -q C^0 &&
+		git merge -s recursive B^0 &&
 
-	test 3 -eq $(git ls-files -s | wc -l) &&
-	test 0 -eq $(git ls-files -u | wc -l) &&
-	test 0 -eq $(git ls-files -o | wc -l) &&
+		test 3 -eq $(git ls-files -s | wc -l) &&
+		test 0 -eq $(git ls-files -u | wc -l) &&
+		test 0 -eq $(git ls-files -o | wc -l) &&
 
-	test_line_count = 6 c &&
-	test $(git rev-parse HEAD:a) = $(git rev-parse B:a) &&
-	test $(git rev-parse HEAD:b) = $(git rev-parse A:b)
+		test_line_count = 6 c &&
+		test $(git rev-parse HEAD:a) = $(git rev-parse B:a) &&
+		test $(git rev-parse HEAD:b) = $(git rev-parse A:b)
+	)
 '
 
 test_expect_success 'setup conflict resolved wrong if rename missed' '
-	git reset --hard &&
-	git clean -f &&
-
-	git checkout -b D A &&
-	echo 7 >>a &&
-	git add a &&
-	git mv a c &&
-	echo "Completely different content" >a &&
-	git add a &&
-	git commit -m D &&
-
-	git checkout -b E A &&
-	git rm a &&
-	echo "Completely different content" >>a &&
-	git add a &&
-	git commit -m E
+	test_create_repo break-detection-2 &&
+	(
+		cd break-detection-2 &&
+
+		printf "1\n2\n3\n4\n5\n" >a &&
+		echo foo >b &&
+		git add a b &&
+		git commit -m A &&
+		git tag A &&
+
+		git checkout -b D A &&
+		echo 7 >>a &&
+		git add a &&
+		git mv a c &&
+		echo "Completely different content" >a &&
+		git add a &&
+		git commit -m D &&
+
+		git checkout -b E A &&
+		git rm a &&
+		echo "Completely different content" >>a &&
+		git add a &&
+		git commit -m E
+	)
 '
 
 test_expect_failure 'missed conflict if rename not detected' '
-	git checkout -q E^0 &&
-	test_must_fail git merge -s recursive D^0
+	(
+		cd break-detection-2 &&
+
+		git checkout -q E^0 &&
+		test_must_fail git merge -s recursive D^0
+	)
 '
 
 # Tests for undetected rename/add-source causing a file to erroneously be
@@ -145,198 +174,210 @@ test_expect_failure 'missed conflict if rename not detected' '
 #   Commit C: rename a->b, add unrelated a
 
 test_expect_success 'setup undetected rename/add-source causes data loss' '
-	git rm -rf . &&
-	git clean -fdqx &&
-	rm -rf .git &&
-	git init &&
-
-	printf "1\n2\n3\n4\n5\n" >a &&
-	git add a &&
-	git commit -m A &&
-	git tag A &&
-
-	git checkout -b B A &&
-	git mv a b &&
-	git commit -m B &&
-
-	git checkout -b C A &&
-	git mv a b &&
-	echo foobar >a &&
-	git add a &&
-	git commit -m C
+	test_create_repo break-detection-3 &&
+	(
+		cd break-detection-3 &&
+
+		printf "1\n2\n3\n4\n5\n" >a &&
+		git add a &&
+		git commit -m A &&
+		git tag A &&
+
+		git checkout -b B A &&
+		git mv a b &&
+		git commit -m B &&
+
+		git checkout -b C A &&
+		git mv a b &&
+		echo foobar >a &&
+		git add a &&
+		git commit -m C
+	)
 '
 
 test_expect_failure 'detect rename/add-source and preserve all data' '
-	git checkout B^0 &&
+	(
+		cd break-detection-3 &&
+
+		git checkout B^0 &&
 
-	git merge -s recursive C^0 &&
+		git merge -s recursive C^0 &&
 
-	test 2 -eq $(git ls-files -s | wc -l) &&
-	test 2 -eq $(git ls-files -u | wc -l) &&
-	test 0 -eq $(git ls-files -o | wc -l) &&
+		test 2 -eq $(git ls-files -s | wc -l) &&
+		test 2 -eq $(git ls-files -u | wc -l) &&
+		test 0 -eq $(git ls-files -o | wc -l) &&
 
-	test -f a &&
-	test -f b &&
+		test -f a &&
+		test -f b &&
 
-	test $(git rev-parse HEAD:b) = $(git rev-parse A:a) &&
-	test $(git rev-parse HEAD:a) = $(git rev-parse C:a)
+		test $(git rev-parse HEAD:b) = $(git rev-parse A:a) &&
+		test $(git rev-parse HEAD:a) = $(git rev-parse C:a)
+	)
 '
 
 test_expect_failure 'detect rename/add-source and preserve all data, merge other way' '
-	git checkout C^0 &&
+	(
+		cd break-detection-3 &&
 
-	git merge -s recursive B^0 &&
+		git checkout C^0 &&
 
-	test 2 -eq $(git ls-files -s | wc -l) &&
-	test 2 -eq $(git ls-files -u | wc -l) &&
-	test 0 -eq $(git ls-files -o | wc -l) &&
+		git merge -s recursive B^0 &&
 
-	test -f a &&
-	test -f b &&
+		test 2 -eq $(git ls-files -s | wc -l) &&
+		test 2 -eq $(git ls-files -u | wc -l) &&
+		test 0 -eq $(git ls-files -o | wc -l) &&
 
-	test $(git rev-parse HEAD:b) = $(git rev-parse A:a) &&
-	test $(git rev-parse HEAD:a) = $(git rev-parse C:a)
+		test -f a &&
+		test -f b &&
+
+		test $(git rev-parse HEAD:b) = $(git rev-parse A:a) &&
+		test $(git rev-parse HEAD:a) = $(git rev-parse C:a)
+	)
 '
 
 test_expect_success 'setup content merge + rename/directory conflict' '
-	git rm -rf . &&
-	git clean -fdqx &&
-	rm -rf .git &&
-	git init &&
-
-	printf "1\n2\n3\n4\n5\n6\n" >file &&
-	git add file &&
-	test_tick &&
-	git commit -m base &&
-	git tag base &&
-
-	git checkout -b right &&
-	echo 7 >>file &&
-	mkdir newfile &&
-	echo junk >newfile/realfile &&
-	git add file newfile/realfile &&
-	test_tick &&
-	git commit -m right &&
-
-	git checkout -b left-conflict base &&
-	echo 8 >>file &&
-	git add file &&
-	git mv file newfile &&
-	test_tick &&
-	git commit -m left &&
-
-	git checkout -b left-clean base &&
-	echo 0 >newfile &&
-	cat file >>newfile &&
-	git add newfile &&
-	git rm file &&
-	test_tick &&
-	git commit -m left
+	test_create_repo rename-directory-1 &&
+	(
+		cd rename-directory-1 &&
+
+		printf "1\n2\n3\n4\n5\n6\n" >file &&
+		git add file &&
+		test_tick &&
+		git commit -m base &&
+		git tag base &&
+
+		git checkout -b right &&
+		echo 7 >>file &&
+		mkdir newfile &&
+		echo junk >newfile/realfile &&
+		git add file newfile/realfile &&
+		test_tick &&
+		git commit -m right &&
+
+		git checkout -b left-conflict base &&
+		echo 8 >>file &&
+		git add file &&
+		git mv file newfile &&
+		test_tick &&
+		git commit -m left &&
+
+		git checkout -b left-clean base &&
+		echo 0 >newfile &&
+		cat file >>newfile &&
+		git add newfile &&
+		git rm file &&
+		test_tick &&
+		git commit -m left
+	)
 '
 
 test_expect_success 'rename/directory conflict + clean content merge' '
-	git reset --hard &&
-	git reset --hard &&
-	git clean -fdqx &&
+	(
+		cd rename-directory-1 &&
 
-	git checkout left-clean^0 &&
+		git checkout left-clean^0 &&
 
-	test_must_fail git merge -s recursive right^0 &&
+		test_must_fail git merge -s recursive right^0 &&
 
-	test 2 -eq $(git ls-files -s | wc -l) &&
-	test 1 -eq $(git ls-files -u | wc -l) &&
-	test 1 -eq $(git ls-files -o | wc -l) &&
+		test 2 -eq $(git ls-files -s | wc -l) &&
+		test 1 -eq $(git ls-files -u | wc -l) &&
+		test 1 -eq $(git ls-files -o | wc -l) &&
 
-	echo 0 >expect &&
-	git cat-file -p base:file >>expect &&
-	echo 7 >>expect &&
-	test_cmp expect newfile~HEAD &&
+		echo 0 >expect &&
+		git cat-file -p base:file >>expect &&
+		echo 7 >>expect &&
+		test_cmp expect newfile~HEAD &&
 
-	test $(git rev-parse :2:newfile) = $(git hash-object expect) &&
+		test $(git rev-parse :2:newfile) = $(git hash-object expect) &&
 
-	test -f newfile/realfile &&
-	test -f newfile~HEAD
+		test -f newfile/realfile &&
+		test -f newfile~HEAD
+	)
 '
 
 test_expect_success 'rename/directory conflict + content merge conflict' '
-	git reset --hard &&
-	git reset --hard &&
-	git clean -fdqx &&
-
-	git checkout left-conflict^0 &&
-
-	test_must_fail git merge -s recursive right^0 &&
-
-	test 4 -eq $(git ls-files -s | wc -l) &&
-	test 3 -eq $(git ls-files -u | wc -l) &&
-	test 1 -eq $(git ls-files -o | wc -l) &&
-
-	git cat-file -p left-conflict:newfile >left &&
-	git cat-file -p base:file    >base &&
-	git cat-file -p right:file   >right &&
-	test_must_fail git merge-file \
-		-L "HEAD:newfile" \
-		-L "" \
-		-L "right^0:file" \
-		left base right &&
-	test_cmp left newfile~HEAD &&
-
-	test $(git rev-parse :1:newfile) = $(git rev-parse base:file) &&
-	test $(git rev-parse :2:newfile) = $(git rev-parse left-conflict:newfile) &&
-	test $(git rev-parse :3:newfile) = $(git rev-parse right:file) &&
-
-	test -f newfile/realfile &&
-	test -f newfile~HEAD
+	(
+		cd rename-directory-1 &&
+
+		git reset --hard &&
+		git reset --hard &&
+		git clean -fdqx &&
+
+		git checkout left-conflict^0 &&
+
+		test_must_fail git merge -s recursive right^0 &&
+
+		test 4 -eq $(git ls-files -s | wc -l) &&
+		test 3 -eq $(git ls-files -u | wc -l) &&
+		test 1 -eq $(git ls-files -o | wc -l) &&
+
+		git cat-file -p left-conflict:newfile >left &&
+		git cat-file -p base:file    >base &&
+		git cat-file -p right:file   >right &&
+		test_must_fail git merge-file \
+			-L "HEAD:newfile" \
+			-L "" \
+			-L "right^0:file" \
+			left base right &&
+		test_cmp left newfile~HEAD &&
+
+		test $(git rev-parse :1:newfile) = $(git rev-parse base:file) &&
+		test $(git rev-parse :2:newfile) = $(git rev-parse left-conflict:newfile) &&
+		test $(git rev-parse :3:newfile) = $(git rev-parse right:file) &&
+
+		test -f newfile/realfile &&
+		test -f newfile~HEAD
+	)
 '
 
 test_expect_success 'setup content merge + rename/directory conflict w/ disappearing dir' '
-	git reset --hard &&
-	git rm -rf . &&
-	git clean -fdqx &&
-	rm -rf .git &&
-	git init &&
-
-	mkdir sub &&
-	printf "1\n2\n3\n4\n5\n6\n" >sub/file &&
-	git add sub/file &&
-	test_tick &&
-	git commit -m base &&
-	git tag base &&
-
-	git checkout -b right &&
-	echo 7 >>sub/file &&
-	git add sub/file &&
-	test_tick &&
-	git commit -m right &&
-
-	git checkout -b left base &&
-	echo 0 >newfile &&
-	cat sub/file >>newfile &&
-	git rm sub/file &&
-	mv newfile sub &&
-	git add sub &&
-	test_tick &&
-	git commit -m left
+	test_create_repo rename-directory-2 &&
+	(
+		cd rename-directory-2 &&
+
+		mkdir sub &&
+		printf "1\n2\n3\n4\n5\n6\n" >sub/file &&
+		git add sub/file &&
+		test_tick &&
+		git commit -m base &&
+		git tag base &&
+
+		git checkout -b right &&
+		echo 7 >>sub/file &&
+		git add sub/file &&
+		test_tick &&
+		git commit -m right &&
+
+		git checkout -b left base &&
+		echo 0 >newfile &&
+		cat sub/file >>newfile &&
+		git rm sub/file &&
+		mv newfile sub &&
+		git add sub &&
+		test_tick &&
+		git commit -m left
+	)
 '
 
 test_expect_success 'disappearing dir in rename/directory conflict handled' '
-	git reset --hard &&
-	git clean -fdqx &&
+	(
+		cd rename-directory-2 &&
 
-	git checkout left^0 &&
+		git checkout left^0 &&
 
-	git merge -s recursive right^0 &&
+		git merge -s recursive right^0 &&
 
-	test 1 -eq $(git ls-files -s | wc -l) &&
-	test 0 -eq $(git ls-files -u | wc -l) &&
-	test 0 -eq $(git ls-files -o | wc -l) &&
+		test 1 -eq $(git ls-files -s | wc -l) &&
+		test 0 -eq $(git ls-files -u | wc -l) &&
+		test 0 -eq $(git ls-files -o | wc -l) &&
 
-	echo 0 >expect &&
-	git cat-file -p base:sub/file >>expect &&
-	echo 7 >>expect &&
-	test_cmp expect sub &&
+		echo 0 >expect &&
+		git cat-file -p base:sub/file >>expect &&
+		echo 7 >>expect &&
+		test_cmp expect sub &&
 
-	test -f sub
+		test -f sub
+	)
 '
 
 # Test for all kinds of things that can go wrong with rename/rename (2to1):
@@ -352,48 +393,52 @@ test_expect_success 'disappearing dir in rename/directory conflict handled' '
 #   * Nothing else should be present.  Is anything?
 
 test_expect_success 'setup rename/rename (2to1) + modify/modify' '
-	git rm -rf . &&
-	git clean -fdqx &&
-	rm -rf .git &&
-	git init &&
-
-	printf "1\n2\n3\n4\n5\n" >a &&
-	printf "5\n4\n3\n2\n1\n" >b &&
-	git add a b &&
-	git commit -m A &&
-	git tag A &&
-
-	git checkout -b B A &&
-	git mv a c &&
-	echo 0 >>b &&
-	git add b &&
-	git commit -m B &&
-
-	git checkout -b C A &&
-	git mv b c &&
-	echo 6 >>a &&
-	git add a &&
-	git commit -m C
+	test_create_repo rename-rename-2to1 &&
+	(
+		cd rename-rename-2to1 &&
+
+		printf "1\n2\n3\n4\n5\n" >a &&
+		printf "5\n4\n3\n2\n1\n" >b &&
+		git add a b &&
+		git commit -m A &&
+		git tag A &&
+
+		git checkout -b B A &&
+		git mv a c &&
+		echo 0 >>b &&
+		git add b &&
+		git commit -m B &&
+
+		git checkout -b C A &&
+		git mv b c &&
+		echo 6 >>a &&
+		git add a &&
+		git commit -m C
+	)
 '
 
 test_expect_success 'handle rename/rename (2to1) conflict correctly' '
-	git checkout B^0 &&
+	(
+		cd rename-rename-2to1 &&
+
+		git checkout B^0 &&
 
-	test_must_fail git merge -s recursive C^0 >out &&
-	test_i18ngrep "CONFLICT (rename/rename)" out &&
+		test_must_fail git merge -s recursive C^0 >out &&
+		test_i18ngrep "CONFLICT (rename/rename)" out &&
 
-	test 2 -eq $(git ls-files -s | wc -l) &&
-	test 2 -eq $(git ls-files -u | wc -l) &&
-	test 2 -eq $(git ls-files -u c | wc -l) &&
-	test 3 -eq $(git ls-files -o | wc -l) &&
+		test 2 -eq $(git ls-files -s | wc -l) &&
+		test 2 -eq $(git ls-files -u | wc -l) &&
+		test 2 -eq $(git ls-files -u c | wc -l) &&
+		test 3 -eq $(git ls-files -o | wc -l) &&
 
-	test ! -f a &&
-	test ! -f b &&
-	test -f c~HEAD &&
-	test -f c~C^0 &&
+		test ! -f a &&
+		test ! -f b &&
+		test -f c~HEAD &&
+		test -f c~C^0 &&
 
-	test $(git hash-object c~HEAD) = $(git rev-parse C:a) &&
-	test $(git hash-object c~C^0) = $(git rev-parse B:b)
+		test $(git hash-object c~HEAD) = $(git rev-parse C:a) &&
+		test $(git hash-object c~C^0) = $(git rev-parse B:b)
+	)
 '
 
 # Testcase setup for simple rename/rename (1to2) conflict:
@@ -401,44 +446,48 @@ test_expect_success 'handle rename/rename (2to1) conflict correctly' '
 #   Commit B: rename a->b
 #   Commit C: rename a->c
 test_expect_success 'setup simple rename/rename (1to2) conflict' '
-	git rm -rf . &&
-	git clean -fdqx &&
-	rm -rf .git &&
-	git init &&
-
-	echo stuff >a &&
-	git add a &&
-	test_tick &&
-	git commit -m A &&
-	git tag A &&
-
-	git checkout -b B A &&
-	git mv a b &&
-	test_tick &&
-	git commit -m B &&
-
-	git checkout -b C A &&
-	git mv a c &&
-	test_tick &&
-	git commit -m C
+	test_create_repo rename-rename-1to2 &&
+	(
+		cd rename-rename-1to2 &&
+
+		echo stuff >a &&
+		git add a &&
+		test_tick &&
+		git commit -m A &&
+		git tag A &&
+
+		git checkout -b B A &&
+		git mv a b &&
+		test_tick &&
+		git commit -m B &&
+
+		git checkout -b C A &&
+		git mv a c &&
+		test_tick &&
+		git commit -m C
+	)
 '
 
 test_expect_success 'merge has correct working tree contents' '
-	git checkout C^0 &&
+	(
+		cd rename-rename-1to2 &&
+
+		git checkout C^0 &&
 
-	test_must_fail git merge -s recursive B^0 &&
+		test_must_fail git merge -s recursive B^0 &&
 
-	test 3 -eq $(git ls-files -s | wc -l) &&
-	test 3 -eq $(git ls-files -u | wc -l) &&
-	test 0 -eq $(git ls-files -o | wc -l) &&
+		test 3 -eq $(git ls-files -s | wc -l) &&
+		test 3 -eq $(git ls-files -u | wc -l) &&
+		test 0 -eq $(git ls-files -o | wc -l) &&
 
-	test $(git rev-parse :1:a) = $(git rev-parse A:a) &&
-	test $(git rev-parse :3:b) = $(git rev-parse A:a) &&
-	test $(git rev-parse :2:c) = $(git rev-parse A:a) &&
+		test $(git rev-parse :1:a) = $(git rev-parse A:a) &&
+		test $(git rev-parse :3:b) = $(git rev-parse A:a) &&
+		test $(git rev-parse :2:c) = $(git rev-parse A:a) &&
 
-	test ! -f a &&
-	test $(git hash-object b) = $(git rev-parse A:a) &&
-	test $(git hash-object c) = $(git rev-parse A:a)
+		test ! -f a &&
+		test $(git hash-object b) = $(git rev-parse A:a) &&
+		test $(git hash-object c) = $(git rev-parse A:a)
+	)
 '
 
 # Testcase setup for rename/rename(1to2)/add-source conflict:
@@ -449,130 +498,142 @@ test_expect_success 'merge has correct working tree contents' '
 # Merging of B & C should NOT be clean; there's a rename/rename conflict
 
 test_expect_success 'setup rename/rename(1to2)/add-source conflict' '
-	git rm -rf . &&
-	git clean -fdqx &&
-	rm -rf .git &&
-	git init &&
-
-	printf "1\n2\n3\n4\n5\n6\n7\n" >a &&
-	git add a &&
-	git commit -m A &&
-	git tag A &&
-
-	git checkout -b B A &&
-	git mv a b &&
-	git commit -m B &&
-
-	git checkout -b C A &&
-	git mv a c &&
-	echo something completely different >a &&
-	git add a &&
-	git commit -m C
+	test_create_repo rename-rename-1to2-add-source-1 &&
+	(
+		cd rename-rename-1to2-add-source-1 &&
+
+		printf "1\n2\n3\n4\n5\n6\n7\n" >a &&
+		git add a &&
+		git commit -m A &&
+		git tag A &&
+
+		git checkout -b B A &&
+		git mv a b &&
+		git commit -m B &&
+
+		git checkout -b C A &&
+		git mv a c &&
+		echo something completely different >a &&
+		git add a &&
+		git commit -m C
+	)
 '
 
 test_expect_failure 'detect conflict with rename/rename(1to2)/add-source merge' '
-	git checkout B^0 &&
+	(
+		cd rename-rename-1to2-add-source-1 &&
 
-	test_must_fail git merge -s recursive C^0 &&
+		git checkout B^0 &&
 
-	test 4 -eq $(git ls-files -s | wc -l) &&
-	test 0 -eq $(git ls-files -o | wc -l) &&
+		test_must_fail git merge -s recursive C^0 &&
 
-	test $(git rev-parse 3:a) = $(git rev-parse C:a) &&
-	test $(git rev-parse 1:a) = $(git rev-parse A:a) &&
-	test $(git rev-parse 2:b) = $(git rev-parse B:b) &&
-	test $(git rev-parse 3:c) = $(git rev-parse C:c) &&
+		test 4 -eq $(git ls-files -s | wc -l) &&
+		test 0 -eq $(git ls-files -o | wc -l) &&
 
-	test -f a &&
-	test -f b &&
-	test -f c
+		test $(git rev-parse 3:a) = $(git rev-parse C:a) &&
+		test $(git rev-parse 1:a) = $(git rev-parse A:a) &&
+		test $(git rev-parse 2:b) = $(git rev-parse B:b) &&
+		test $(git rev-parse 3:c) = $(git rev-parse C:c) &&
+
+		test -f a &&
+		test -f b &&
+		test -f c
+	)
 '
 
 test_expect_success 'setup rename/rename(1to2)/add-source resolvable conflict' '
-	git rm -rf . &&
-	git clean -fdqx &&
-	rm -rf .git &&
-	git init &&
-
-	>a &&
-	git add a &&
-	test_tick &&
-	git commit -m base &&
-	git tag A &&
-
-	git checkout -b B A &&
-	git mv a b &&
-	test_tick &&
-	git commit -m one &&
-
-	git checkout -b C A &&
-	git mv a b &&
-	echo important-info >a &&
-	git add a &&
-	test_tick &&
-	git commit -m two
+	test_create_repo rename-rename-1to2-add-source-2 &&
+	(
+		cd rename-rename-1to2-add-source-2 &&
+
+		>a &&
+		git add a &&
+		test_tick &&
+		git commit -m base &&
+		git tag A &&
+
+		git checkout -b B A &&
+		git mv a b &&
+		test_tick &&
+		git commit -m one &&
+
+		git checkout -b C A &&
+		git mv a b &&
+		echo important-info >a &&
+		git add a &&
+		test_tick &&
+		git commit -m two
+	)
 '
 
 test_expect_failure 'rename/rename/add-source still tracks new a file' '
-	git checkout C^0 &&
-	git merge -s recursive B^0 &&
+	(
+		cd rename-rename-1to2-add-source-2 &&
+
+		git checkout C^0 &&
+		git merge -s recursive B^0 &&
 
-	test 2 -eq $(git ls-files -s | wc -l) &&
-	test 0 -eq $(git ls-files -o | wc -l) &&
+		test 2 -eq $(git ls-files -s | wc -l) &&
+		test 0 -eq $(git ls-files -o | wc -l) &&
 
-	test $(git rev-parse HEAD:a) = $(git rev-parse C:a) &&
-	test $(git rev-parse HEAD:b) = $(git rev-parse A:a)
+		test $(git rev-parse HEAD:a) = $(git rev-parse C:a) &&
+		test $(git rev-parse HEAD:b) = $(git rev-parse A:a)
+	)
 '
 
 test_expect_success 'setup rename/rename(1to2)/add-dest conflict' '
-	git rm -rf . &&
-	git clean -fdqx &&
-	rm -rf .git &&
-	git init &&
-
-	echo stuff >a &&
-	git add a &&
-	test_tick &&
-	git commit -m base &&
-	git tag A &&
-
-	git checkout -b B A &&
-	git mv a b &&
-	echo precious-data >c &&
-	git add c &&
-	test_tick &&
-	git commit -m one &&
-
-	git checkout -b C A &&
-	git mv a c &&
-	echo important-info >b &&
-	git add b &&
-	test_tick &&
-	git commit -m two
+	test_create_repo rename-rename-1to2-add-dest &&
+	(
+		cd rename-rename-1to2-add-dest &&
+
+		echo stuff >a &&
+		git add a &&
+		test_tick &&
+		git commit -m base &&
+		git tag A &&
+
+		git checkout -b B A &&
+		git mv a b &&
+		echo precious-data >c &&
+		git add c &&
+		test_tick &&
+		git commit -m one &&
+
+		git checkout -b C A &&
+		git mv a c &&
+		echo important-info >b &&
+		git add b &&
+		test_tick &&
+		git commit -m two
+	)
 '
 
 test_expect_success 'rename/rename/add-dest merge still knows about conflicting file versions' '
-	git checkout C^0 &&
-	test_must_fail git merge -s recursive B^0 &&
-
-	test 5 -eq $(git ls-files -s | wc -l) &&
-	test 2 -eq $(git ls-files -u b | wc -l) &&
-	test 2 -eq $(git ls-files -u c | wc -l) &&
-	test 4 -eq $(git ls-files -o | wc -l) &&
-
-	test $(git rev-parse :1:a) = $(git rev-parse A:a) &&
-	test $(git rev-parse :2:b) = $(git rev-parse C:b) &&
-	test $(git rev-parse :3:b) = $(git rev-parse B:b) &&
-	test $(git rev-parse :2:c) = $(git rev-parse C:c) &&
-	test $(git rev-parse :3:c) = $(git rev-parse B:c) &&
-
-	test $(git hash-object c~HEAD) = $(git rev-parse C:c) &&
-	test $(git hash-object c~B\^0) = $(git rev-parse B:c) &&
-	test $(git hash-object b~HEAD) = $(git rev-parse C:b) &&
-	test $(git hash-object b~B\^0) = $(git rev-parse B:b) &&
-
-	test ! -f b &&
-	test ! -f c
+	(
+		cd rename-rename-1to2-add-dest &&
+
+		git checkout C^0 &&
+		test_must_fail git merge -s recursive B^0 &&
+
+		test 5 -eq $(git ls-files -s | wc -l) &&
+		test 2 -eq $(git ls-files -u b | wc -l) &&
+		test 2 -eq $(git ls-files -u c | wc -l) &&
+		test 4 -eq $(git ls-files -o | wc -l) &&
+
+		test $(git rev-parse :1:a) = $(git rev-parse A:a) &&
+		test $(git rev-parse :2:b) = $(git rev-parse C:b) &&
+		test $(git rev-parse :3:b) = $(git rev-parse B:b) &&
+		test $(git rev-parse :2:c) = $(git rev-parse C:c) &&
+		test $(git rev-parse :3:c) = $(git rev-parse B:c) &&
+
+		test $(git hash-object c~HEAD) = $(git rev-parse C:c) &&
+		test $(git hash-object c~B\^0) = $(git rev-parse B:c) &&
+		test $(git hash-object b~HEAD) = $(git rev-parse C:b) &&
+		test $(git hash-object b~B\^0) = $(git rev-parse B:b) &&
+
+		test ! -f b &&
+		test ! -f c
+	)
 '
 
 test_done
-- 
2.17.0.1.gda85003413

