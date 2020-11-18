Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE851C63798
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B3D3246BB
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEsecU3j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbgKRXpR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 18:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbgKRXpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 18:45:16 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F74FC0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:45:15 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id w24so4766582wmi.0
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5A671Pr3OfyKRJbCqjqoOWO+3X1evLywvHcLxaiXTMM=;
        b=fEsecU3jr20Rypvs46T9ep8gFW2PtSN5qLXbd1FzJoJMRg0jYYbjQpNTU9eh2Hgrn3
         hF6BFsQEjzvjj9rSmoS7O8rt/QZKYkfUc7+bKLWOm889PM3EJwjtMqT9UNa5AKJA4Pxc
         Je3uxGY2JtwvR4E7wRLM/4uEjN9cloQvY40S6OX6pHsu2DiwBbANvkRfPWfLZNRsQlc1
         z41ot9IVCbTchItBSnDFnuSf8odcSdqSYWwylTt4HMZ2elUK9MjYBRbo6GZ5idbZKq7U
         UV2+TcRK9SQsyfN+V8M/J4Y0Qwhk/NbqXt3tZdXK8V92kWDyT0pPpwDYPzKjkhwU/AR0
         prSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5A671Pr3OfyKRJbCqjqoOWO+3X1evLywvHcLxaiXTMM=;
        b=EapyUdlDvy+F7Jg9r9UvP9HDVGRk55GWLkpjpFcAFkzOXAZbP1AcLMWD+28H5ycCct
         tZ0uOVJ6WK9QEbDTc7MObCiquYTzZO/M8vRaYseJqxT7npgqT8/KRgD60hiMqxHppSEr
         Er8WwFWjyo37iLgedZox6Sc9Xj94bHgcQ+tH3JHBS36lFAtZtasTswMZIj+xEEUbhTua
         m2dmw+uhm6VO9Ndv8cVovd9pNc/xfaUglXYV1xmH8n0szJs4t+9wraAKzO4+ko8b0cDZ
         jL+yKwjAat1A+z8hXp+Qephu0mtDjsekHbFxNmigS+mVyikI2OC6HcqwbiE6oCgdplE6
         m8yA==
X-Gm-Message-State: AOAM530BT/J8ulVt2XMykFj3bvy35+XE29zHXQZTq2PPT/zkhfV0pxnK
        f4QTz/nBxmpyWuZk0n8oWe1nr4JkUgg=
X-Google-Smtp-Source: ABdhPJxT9lcQWlXYi+HyGV33AiVhXE3JvQENvvMaM6U+3DUYzi2bh/9idW3Mn3eABdib82rfr02wsA==
X-Received: by 2002:a7b:c14f:: with SMTP id z15mr1570396wmi.174.1605743113159;
        Wed, 18 Nov 2020 15:45:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b14sm34141194wrq.47.2020.11.18.15.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 15:45:12 -0800 (PST)
Message-Id: <3e81bc89a2301998375294077b5b581659e17ba0.1605743088.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.v3.git.1605743086.gitgitgadget@gmail.com>
References: <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
        <pull.762.v3.git.1605743086.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Nov 2020 23:44:42 +0000
Subject: [PATCH v3 24/28] t9[0-4]*: adjust the references to the default
 branch name "main"
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
		-e 's/Master/Main/g' -- t9[0-4]*.sh)

This allows us to define `GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main`
for those tests.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t9001-send-email.sh                  | 30 ++++-----
 t/t9100-git-svn-basic.sh               |  4 +-
 t/t9145-git-svn-master-branch.sh       |  8 +--
 t/t9151-svn-mergeinfo.sh               |  4 +-
 t/t9155-git-svn-fetch-deleted-tag.sh   |  4 +-
 t/t9156-git-svn-fetch-deleted-tag-2.sh |  8 +--
 t/t9163-git-svn-reset-clears-caches.sh |  4 +-
 t/t9169-git-svn-dcommit-crlf.sh        |  4 +-
 t/t9300-fast-import.sh                 | 84 ++++++++++++------------
 t/t9301-fast-import-notes.sh           | 16 ++---
 t/t9302-fast-import-unpack-limit.sh    | 16 ++---
 t/t9350-fast-export.sh                 | 88 +++++++++++++-------------
 t/t9351-fast-export-anonymize.sh       |  6 +-
 t/t9400-git-cvsserver-server.sh        | 34 +++++-----
 t/t9401-git-cvsserver-crlf.sh          | 18 +++---
 t/t9402-git-cvsserver-refs.sh          | 10 +--
 16 files changed, 169 insertions(+), 169 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 3d160d939e..4eee9c3dcb 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 test_description='git send-email'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -1171,10 +1171,10 @@ test_expect_success $PREREQ '--compose-encoding adds correct MIME for subject' '
 '
 
 test_expect_success $PREREQ 'detects ambiguous reference/file conflict' '
-	echo master >master &&
-	git add master &&
-	git commit -m"add master" &&
-	test_must_fail git send-email --dry-run master 2>errors &&
+	echo main >main &&
+	git add main &&
+	git commit -m"add main" &&
+	test_must_fail git send-email --dry-run main 2>errors &&
 	grep disambiguate errors
 '
 
@@ -1188,7 +1188,7 @@ test_expect_success $PREREQ 'feed two files' '
 		outdir/000?-*.patch 2>errors >out &&
 	grep "^Subject: " out >subjects &&
 	test "z$(sed -n -e 1p subjects)" = "zSubject: [PATCH 1/2] Second." &&
-	test "z$(sed -n -e 2p subjects)" = "zSubject: [PATCH 2/2] add master"
+	test "z$(sed -n -e 2p subjects)" = "zSubject: [PATCH 2/2] add main"
 '
 
 test_expect_success $PREREQ 'in-reply-to but no threading' '
@@ -2040,7 +2040,7 @@ test_expect_success $PREREQ 'setup expected-list' '
 	--cc="Cc2 <cc2@example.com>" \
 	--bcc="bcc1@example.com" \
 	--bcc="bcc2@example.com" \
-	0001-add-master.patch | replace_variable_fields \
+	0001-add-main.patch | replace_variable_fields \
 	>expected-list
 '
 
@@ -2052,7 +2052,7 @@ test_expect_success $PREREQ 'use email list in --cc --to and --bcc' '
 	--to="to3@example.com" \
 	--cc="Cc 1 <cc1@example.com>, Cc2 <cc2@example.com>" \
 	--bcc="bcc1@example.com, bcc2@example.com" \
-	0001-add-master.patch | replace_variable_fields \
+	0001-add-main.patch | replace_variable_fields \
 	>actual-list &&
 	test_cmp expected-list actual-list
 '
@@ -2068,7 +2068,7 @@ test_expect_success $PREREQ 'aliases work with email list' '
 	--to="To 1 <to1@example.com>, to2, to3@example.com" \
 	--cc="cc1, Cc2 <cc2@example.com>" \
 	--bcc="bcc1@example.com, bcc2@example.com" \
-	0001-add-master.patch | replace_variable_fields \
+	0001-add-main.patch | replace_variable_fields \
 	>actual-list &&
 	test_cmp expected-list actual-list
 '
@@ -2092,7 +2092,7 @@ test_expect_success $PREREQ 'leading and trailing whitespaces are removed' '
 	--cc="Cc2 <cc2@example.com>" \
 	--bcc="$BCC1" \
 	--bcc="bcc2@example.com" \
-	0001-add-master.patch | replace_variable_fields \
+	0001-add-main.patch | replace_variable_fields \
 	>actual-list &&
 	test_cmp expected-list actual-list
 '
@@ -2111,8 +2111,8 @@ test_expect_success $PREREQ 'invoke hook' '
 		false
 		;;
 	esac &&
-	test -f 0001-add-master.patch &&
-	grep "add master" "$1"
+	test -f 0001-add-main.patch &&
+	grep "add main" "$1"
 	EOF
 
 	mkdir subdir &&
@@ -2124,10 +2124,10 @@ test_expect_success $PREREQ 'invoke hook' '
 			--from="Example <nobody@example.com>" \
 			--to=nobody@example.com \
 			--smtp-server="$(pwd)/../fake.sendmail" \
-			../0001-add-master.patch &&
+			../0001-add-main.patch &&
 
 		# Verify error message when a patch is rejected by the hook
-		sed -e "s/add master/x/" ../0001-add-master.patch >../another.patch &&
+		sed -e "s/add main/x/" ../0001-add-main.patch >../another.patch &&
 		test_must_fail git send-email \
 			--from="Example <nobody@example.com>" \
 			--to=nobody@example.com \
@@ -2142,7 +2142,7 @@ test_expect_success $PREREQ 'test that send-email works outside a repo' '
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
 		--smtp-server="$(pwd)/fake.sendmail" \
-		"$(pwd)/0001-add-master.patch"
+		"$(pwd)/0001-add-main.patch"
 '
 
 test_expect_success $PREREQ 'test that sendmail config is rejected' '
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 9a6f2c38f1..1d3fdcc997 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -6,7 +6,7 @@
 test_description='git svn basic tests'
 GIT_SVN_LC_ALL=${LC_ALL:-$LANG}
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./lib-git-svn.sh
@@ -278,7 +278,7 @@ test_expect_success 'dcommit $rev does not clobber current branch' '
 	test refs/heads/my-bar = $(git symbolic-ref HEAD) &&
 	git log refs/remotes/bar | grep "change 1" &&
 	! git log refs/remotes/bar | grep "change 2" &&
-	git checkout master &&
+	git checkout main &&
 	git branch -D my-bar
 	'
 
diff --git a/t/t9145-git-svn-master-branch.sh b/t/t9145-git-svn-master-branch.sh
index 053571ca5c..f863e437f7 100755
--- a/t/t9145-git-svn-master-branch.sh
+++ b/t/t9145-git-svn-master-branch.sh
@@ -2,8 +2,8 @@
 #
 # Copyright (c) 2009 Eric Wong
 #
-test_description='git svn initial master branch is "trunk" if possible'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+test_description='git svn initial main branch is "trunk" if possible'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./lib-git-svn.sh
@@ -16,12 +16,12 @@ test_expect_success 'setup test repository' '
 	svn_cmd import -m b/b i "$svnrepo/branches/b"
 '
 
-test_expect_success 'git svn clone --stdlayout sets up trunk as master' '
+test_expect_success 'git svn clone --stdlayout sets up trunk as main' '
 	git svn clone -s "$svnrepo" g &&
 	(
 		cd g &&
 		test x$(git rev-parse --verify refs/remotes/origin/trunk^0) = \
-		     x$(git rev-parse --verify refs/heads/master^0)
+		     x$(git rev-parse --verify refs/heads/main^0)
 	)
 '
 
diff --git a/t/t9151-svn-mergeinfo.sh b/t/t9151-svn-mergeinfo.sh
index 9188c761de..696ace2462 100755
--- a/t/t9151-svn-mergeinfo.sh
+++ b/t/t9151-svn-mergeinfo.sh
@@ -5,7 +5,7 @@
 
 test_description='git-svn svn mergeinfo properties'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./lib-git-svn.sh
@@ -53,7 +53,7 @@ test_expect_success 'merging two branches in one commit is detected correctly' '
 	'
 
 test_expect_failure 'everything got merged in the end' '
-	unmerged=$(git rev-list --all --not master) &&
+	unmerged=$(git rev-list --all --not main) &&
 	[ -z "$unmerged" ]
 	'
 
diff --git a/t/t9155-git-svn-fetch-deleted-tag.sh b/t/t9155-git-svn-fetch-deleted-tag.sh
index 9d6cc40add..3258374c13 100755
--- a/t/t9155-git-svn-fetch-deleted-tag.sh
+++ b/t/t9155-git-svn-fetch-deleted-tag.sh
@@ -2,7 +2,7 @@
 
 test_description='git svn fetch deleted tag'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./lib-git-svn.sh
@@ -39,7 +39,7 @@ test_expect_success 'fetch deleted tags from same revision with checksum error'
 	git svn fetch &&
 
 	git diff --exit-code origin/mybranch:trunk/subdir/file origin/tags/mytag:file &&
-	git diff --exit-code master:subdir/file origin/tags/mytag^:file
+	git diff --exit-code main:subdir/file origin/tags/mytag^:file
 '
 
 test_done
diff --git a/t/t9156-git-svn-fetch-deleted-tag-2.sh b/t/t9156-git-svn-fetch-deleted-tag-2.sh
index ba78bfb676..2b75c403e3 100755
--- a/t/t9156-git-svn-fetch-deleted-tag-2.sh
+++ b/t/t9156-git-svn-fetch-deleted-tag-2.sh
@@ -2,7 +2,7 @@
 
 test_description='git svn fetch deleted tag 2'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./lib-git-svn.sh
@@ -39,9 +39,9 @@ test_expect_success 'fetch deleted tags from same revision with no checksum erro
 	cd git_project &&
 	git svn fetch &&
 
-	git diff --exit-code master:subdir3/file origin/tags/mytag:file &&
-	git diff --exit-code master:subdir2/file origin/tags/mytag^:file &&
-	git diff --exit-code master:subdir1/file origin/tags/mytag^^:file
+	git diff --exit-code main:subdir3/file origin/tags/mytag:file &&
+	git diff --exit-code main:subdir2/file origin/tags/mytag^:file &&
+	git diff --exit-code main:subdir1/file origin/tags/mytag^^:file
 '
 
 test_done
diff --git a/t/t9163-git-svn-reset-clears-caches.sh b/t/t9163-git-svn-reset-clears-caches.sh
index e48faf92af..978eb62ff4 100755
--- a/t/t9163-git-svn-reset-clears-caches.sh
+++ b/t/t9163-git-svn-reset-clears-caches.sh
@@ -4,7 +4,7 @@
 #
 
 test_description='git svn reset clears memoized caches'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./lib-git-svn.sh
@@ -62,7 +62,7 @@ test_expect_success 'fetch to merge-base (a)' '
 test_expect_success 'rebase looses SVN merge (m)' '
 	git svn rebase &&
 	git svn fetch &&
-	test 1 = $(git cat-file -p master|grep parent|wc -l)
+	test 1 = $(git cat-file -p main|grep parent|wc -l)
 '
 
 # git svn fetch creates correct history with merge commit
diff --git a/t/t9169-git-svn-dcommit-crlf.sh b/t/t9169-git-svn-dcommit-crlf.sh
index 47ae51c54f..7080b5d24f 100755
--- a/t/t9169-git-svn-dcommit-crlf.sh
+++ b/t/t9169-git-svn-dcommit-crlf.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 test_description='git svn dcommit CRLF'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./lib-git-svn.sh
@@ -17,7 +17,7 @@ test_expect_success 'setup commit repository' '
 		p=$(git rev-parse HEAD) &&
 		t=$(git write-tree) &&
 		cmt=$(git commit-tree -p $p $t <cmt) &&
-		git update-ref refs/heads/master $cmt &&
+		git update-ref refs/heads/main $cmt &&
 		git cat-file commit HEAD | tail -n4 >out &&
 		test_cmp cmt out &&
 		git svn dcommit &&
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 404a42999e..3d17e932a0 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -4,7 +4,7 @@
 #
 
 test_description='test git fast-import utility'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -65,7 +65,7 @@ test_expect_success 'A: create pack from stdin' '
 	mark :4
 	data $file4_len
 	$file4_data
-	commit refs/heads/master
+	commit refs/heads/main
 	mark :5
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 	data <<COMMIT
@@ -120,7 +120,7 @@ test_expect_success 'A: create pack from stdin' '
 
 	INPUT_END
 	git fast-import --export-marks=marks.out <input &&
-	git whatchanged master
+	git whatchanged main
 '
 
 test_expect_success 'A: verify pack' '
@@ -134,7 +134,7 @@ test_expect_success 'A: verify commit' '
 
 	initial
 	EOF
-	git cat-file commit master | sed 1d >actual &&
+	git cat-file commit main | sed 1d >actual &&
 	test_cmp expect actual
 '
 
@@ -144,31 +144,31 @@ test_expect_success 'A: verify tree' '
 	100644 blob file3
 	100755 blob file4
 	EOF
-	git cat-file -p master^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
+	git cat-file -p main^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'A: verify file2' '
 	echo "$file2_data" >expect &&
-	git cat-file blob master:file2 >actual &&
+	git cat-file blob main:file2 >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'A: verify file3' '
 	echo "$file3_data" >expect &&
-	git cat-file blob master:file3 >actual &&
+	git cat-file blob main:file3 >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'A: verify file4' '
 	printf "$file4_data" >expect &&
-	git cat-file blob master:file4 >actual &&
+	git cat-file blob main:file4 >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'A: verify tag/series-A' '
 	cat >expect <<-EOF &&
-	object $(git rev-parse refs/heads/master)
+	object $(git rev-parse refs/heads/main)
 	type commit
 	tag series-A
 
@@ -180,7 +180,7 @@ test_expect_success 'A: verify tag/series-A' '
 
 test_expect_success 'A: verify tag/series-A-blob' '
 	cat >expect <<-EOF &&
-	object $(git rev-parse refs/heads/master:file3)
+	object $(git rev-parse refs/heads/main:file3)
 	type blob
 	tag series-A-blob
 
@@ -196,13 +196,13 @@ test_expect_success 'A: verify tag deletion is successful' '
 
 test_expect_success 'A: verify marks output' '
 	cat >expect <<-EOF &&
-	:2 $(git rev-parse --verify master:file2)
-	:3 $(git rev-parse --verify master:file3)
-	:4 $(git rev-parse --verify master:file4)
-	:5 $(git rev-parse --verify master^0)
+	:2 $(git rev-parse --verify main:file2)
+	:3 $(git rev-parse --verify main:file3)
+	:4 $(git rev-parse --verify main:file4)
+	:5 $(git rev-parse --verify main^0)
 	:6 $(git cat-file tag nested | grep object | cut -d" " -f 2)
 	:7 $(git rev-parse --verify nested)
-	:8 $(git rev-parse --verify master^0)
+	:8 $(git rev-parse --verify main^0)
 	EOF
 	test_cmp expect marks.out
 '
@@ -220,7 +220,7 @@ test_expect_success 'A: tag blob by sha1' '
 	new_blob=$(echo testing | git hash-object --stdin) &&
 	cat >input <<-INPUT_END &&
 	tag series-A-blob-2
-	from $(git rev-parse refs/heads/master:file3)
+	from $(git rev-parse refs/heads/main:file3)
 	data <<EOF
 	Tag blob by sha1.
 	EOF
@@ -246,7 +246,7 @@ test_expect_success 'A: tag blob by sha1' '
 	INPUT_END
 
 	cat >expect <<-EOF &&
-	object $(git rev-parse refs/heads/master:file3)
+	object $(git rev-parse refs/heads/main:file3)
 	type blob
 	tag series-A-blob-2
 
@@ -287,13 +287,13 @@ test_expect_success 'A: verify pack' '
 '
 
 test_expect_success 'A: verify diff' '
-	copy=$(git rev-parse --verify master:file2) &&
+	copy=$(git rev-parse --verify main:file2) &&
 	cat >expect <<-EOF &&
 	:000000 100755 $ZERO_OID $copy A	copy-of-file2
 	EOF
-	git diff-tree -M -r master verify--import-marks >actual &&
+	git diff-tree -M -r main verify--import-marks >actual &&
 	compare_diff_raw expect actual &&
-	test $(git rev-parse --verify master:file2) \
+	test $(git rev-parse --verify main:file2) \
 	    = $(git rev-parse --verify verify--import-marks:copy-of-file2)
 '
 
@@ -367,7 +367,7 @@ test_expect_success 'B: fail on invalid blob sha1' '
 	corrupt
 	COMMIT
 
-	from refs/heads/master
+	from refs/heads/main
 	M 755 $(echo $ZERO_OID | sed -e "s/0$/1/") zero1
 
 	INPUT_END
@@ -384,7 +384,7 @@ test_expect_success 'B: accept branch name "TEMP_TAG"' '
 	tag base
 	COMMIT
 
-	from refs/heads/master
+	from refs/heads/main
 
 	INPUT_END
 
@@ -393,7 +393,7 @@ test_expect_success 'B: accept branch name "TEMP_TAG"' '
 		git prune" &&
 	git fast-import <input &&
 	test -f .git/TEMP_TAG &&
-	test $(git rev-parse master) = $(git rev-parse TEMP_TAG^)
+	test $(git rev-parse main) = $(git rev-parse TEMP_TAG^)
 '
 
 test_expect_success 'B: accept empty committer' '
@@ -531,8 +531,8 @@ test_expect_success 'B: fail on invalid committer (5)' '
 
 test_expect_success 'C: incremental import create pack from stdin' '
 	newf=$(echo hi newf | git hash-object -w --stdin) &&
-	oldf=$(git rev-parse --verify master:file2) &&
-	thrf=$(git rev-parse --verify master:file3) &&
+	oldf=$(git rev-parse --verify main:file2) &&
+	thrf=$(git rev-parse --verify main:file3) &&
 	test_tick &&
 	cat >input <<-INPUT_END &&
 	commit refs/heads/branch
@@ -541,7 +541,7 @@ test_expect_success 'C: incremental import create pack from stdin' '
 	second
 	COMMIT
 
-	from refs/heads/master
+	from refs/heads/main
 	M 644 $oldf file2/oldf
 	M 755 $newf file2/newf
 	D file3
@@ -563,7 +563,7 @@ test_expect_success 'C: validate reuse existing blob' '
 
 test_expect_success 'C: verify commit' '
 	cat >expect <<-EOF &&
-	parent $(git rev-parse --verify master^0)
+	parent $(git rev-parse --verify main^0)
 	author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
@@ -581,7 +581,7 @@ test_expect_success 'C: validate rename result' '
 	:100644 100644 $oldf $oldf R100	file2	file2/oldf
 	:100644 000000 $thrf $zero D	file3
 	EOF
-	git diff-tree -M -r master branch >actual &&
+	git diff-tree -M -r main branch >actual &&
 	compare_diff_raw expect actual
 '
 
@@ -1701,7 +1701,7 @@ test_expect_success 'P: superproject & submodule mix' '
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 	data 8
 	initial
-	from refs/heads/master
+	from refs/heads/main
 	M 100644 :3 .gitmodules
 	M 160000 :2 sub
 
@@ -1736,8 +1736,8 @@ test_expect_success 'P: superproject & submodule mix' '
 	(
 		cd sub &&
 		git init &&
-		git fetch --update-head-ok .. refs/heads/sub:refs/heads/master &&
-		git checkout master
+		git fetch --update-head-ok .. refs/heads/sub:refs/heads/main &&
+		git checkout main
 	) &&
 	git submodule init &&
 	git submodule update
@@ -1761,7 +1761,7 @@ test_expect_success 'P: verbatim SHA gitlinks' '
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 	data 8
 	initial
-	from refs/heads/master
+	from refs/heads/main
 	M 100644 :1 .gitmodules
 	M 160000 $SUBPREV sub
 
@@ -3432,8 +3432,8 @@ mark :1
 data 4
 foo
 
-reset refs/heads/master
-commit refs/heads/master
+reset refs/heads/main
+commit refs/heads/main
 mark :2
 author Full Name <user@company.tld> 1000000000 +0100
 committer Full Name <user@company.tld> 1000000000 +0100
@@ -3447,7 +3447,7 @@ data 8
 foo
 bar
 
-commit refs/heads/master
+commit refs/heads/main
 mark :4
 author Full Name <user@company.tld> 1000000001 +0100
 committer Full Name <user@company.tld> 1000000001 +0100
@@ -3464,8 +3464,8 @@ mark :1
 data 4
 foo
 
-reset refs/heads/master
-commit refs/heads/master
+reset refs/heads/main
+commit refs/heads/main
 mark :2
 author Full Name <user@company.tld> 2000000000 +0100
 committer Full Name <user@company.tld> 2000000000 +0100
@@ -3480,7 +3480,7 @@ data 73
 	path = sub1
 	url = https://void.example.com/main.git
 
-commit refs/heads/master
+commit refs/heads/main
 mark :4
 author Full Name <user@company.tld> 2000000001 +0100
 committer Full Name <user@company.tld> 2000000001 +0100
@@ -3496,7 +3496,7 @@ data 8
 foo
 bar
 
-commit refs/heads/master
+commit refs/heads/main
 mark :6
 author Full Name <user@company.tld> 2000000002 +0100
 committer Full Name <user@company.tld> 2000000002 +0100
@@ -3514,8 +3514,8 @@ Y_INPUT_END
 
 test_expect_success 'Y: setup' '
 	test_oid_cache <<-EOF
-	Ymaster sha1:9afed2f9161ddf416c0a1863b8b0725b00070504
-	Ymaster sha256:c0a1010da1df187b2e287654793df01b464bd6f8e3f17fc1481a7dadf84caee3
+	Ymain sha1:9afed2f9161ddf416c0a1863b8b0725b00070504
+	Ymain sha256:c0a1010da1df187b2e287654793df01b464bd6f8e3f17fc1481a7dadf84caee3
 	EOF
 '
 
@@ -3527,7 +3527,7 @@ test_expect_success 'Y: rewrite submodules' '
 		git -C sub2 fast-import --export-marks=../sub2-marks <../Y-sub-input &&
 		git fast-import --rewrite-submodules-from=sub:../Y-marks \
 			--rewrite-submodules-to=sub:sub2-marks <../Y-main-input &&
-		test "$(git rev-parse master)" = "$(test_oid Ymaster)"
+		test "$(git rev-parse main)" = "$(test_oid Ymain)"
 	)
 '
 
diff --git a/t/t9301-fast-import-notes.sh b/t/t9301-fast-import-notes.sh
index 0c5bfbde0e..1ae4d7c0d3 100755
--- a/t/t9301-fast-import-notes.sh
+++ b/t/t9301-fast-import-notes.sh
@@ -4,7 +4,7 @@
 #
 
 test_description='test git fast-import of notes objects'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -12,7 +12,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 test_tick
 cat >input <<INPUT_END
-commit refs/heads/master
+commit refs/heads/main
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
 first commit
@@ -33,7 +33,7 @@ data <<EOF
 file baz/xyzzy in first commit
 EOF
 
-commit refs/heads/master
+commit refs/heads/main
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
 second commit
@@ -49,7 +49,7 @@ data <<EOF
 file baz/xyzzy in second commit
 EOF
 
-commit refs/heads/master
+commit refs/heads/main
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
 third commit
@@ -60,7 +60,7 @@ data <<EOF
 file foo in third commit
 EOF
 
-commit refs/heads/master
+commit refs/heads/main
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
 fourth commit
@@ -73,13 +73,13 @@ EOF
 
 INPUT_END
 
-test_expect_success 'set up master branch' '
+test_expect_success 'set up main branch' '
 
 	git fast-import <input &&
-	git whatchanged master
+	git whatchanged main
 '
 
-commit4=$(git rev-parse refs/heads/master)
+commit4=$(git rev-parse refs/heads/main)
 commit3=$(git rev-parse "$commit4^")
 commit2=$(git rev-parse "$commit4~2")
 commit1=$(git rev-parse "$commit4~3")
diff --git a/t/t9302-fast-import-unpack-limit.sh b/t/t9302-fast-import-unpack-limit.sh
index bb1c39cfcc..f519e4f1bf 100755
--- a/t/t9302-fast-import-unpack-limit.sh
+++ b/t/t9302-fast-import-unpack-limit.sh
@@ -5,7 +5,7 @@ test_description='test git fast-import unpack limit'
 test_expect_success 'create loose objects on import' '
 	test_tick &&
 	cat >input <<-INPUT_END &&
-	commit refs/heads/master
+	commit refs/heads/main
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 	data <<COMMIT
 	initial
@@ -23,12 +23,12 @@ test_expect_success 'create loose objects on import' '
 test_expect_success 'bigger packs are preserved' '
 	test_tick &&
 	cat >input <<-INPUT_END &&
-	commit refs/heads/master
+	commit refs/heads/main
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 	data <<COMMIT
 	incremental should create a pack
 	COMMIT
-	from refs/heads/master^0
+	from refs/heads/main^0
 
 	commit refs/heads/branch
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
@@ -48,7 +48,7 @@ test_expect_success 'bigger packs are preserved' '
 test_expect_success 'lookups after checkpoint works' '
 	hello_id=$(echo hello | git hash-object --stdin -t blob) &&
 	id="$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE" &&
-	before=$(git rev-parse refs/heads/master^0) &&
+	before=$(git rev-parse refs/heads/main^0) &&
 	(
 		cat <<-INPUT_END &&
 		blob
@@ -56,13 +56,13 @@ test_expect_success 'lookups after checkpoint works' '
 		data 6
 		hello
 
-		commit refs/heads/master
+		commit refs/heads/main
 		mark :2
 		committer $id
 		data <<COMMIT
 		checkpoint after this
 		COMMIT
-		from refs/heads/master^0
+		from refs/heads/main^0
 		M 100644 :1 hello
 
 		# pre-checkpoint
@@ -86,10 +86,10 @@ test_expect_success 'lookups after checkpoint works' '
 				n=$(($n + 1))
 			fi &&
 			sleep 1 &&
-			from=$(git rev-parse refs/heads/master^0)
+			from=$(git rev-parse refs/heads/main^0)
 		done &&
 		cat <<-INPUT_END &&
-		commit refs/heads/master
+		commit refs/heads/main
 		committer $id
 		data <<COMMIT
 		make sure from "unpacked sha1 reference" works, too
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 6c8830ece5..409b48e244 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -4,7 +4,7 @@
 #
 
 test_description='git fast-export'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -34,13 +34,13 @@ test_expect_success 'setup' '
 	git commit -m sitzt file2 &&
 	test_tick &&
 	git tag -a -m valentin muss &&
-	git merge -s ours master
+	git merge -s ours main
 
 '
 
 test_expect_success 'fast-export | fast-import' '
 
-	MASTER=$(git rev-parse --verify master) &&
+	MAIN=$(git rev-parse --verify main) &&
 	REIN=$(git rev-parse --verify rein) &&
 	WER=$(git rev-parse --verify wer) &&
 	MUSS=$(git rev-parse --verify muss) &&
@@ -49,7 +49,7 @@ test_expect_success 'fast-export | fast-import' '
 	git fast-export --all >actual &&
 	(cd new &&
 	 git fast-import &&
-	 test $MASTER = $(git rev-parse --verify refs/heads/master) &&
+	 test $MAIN = $(git rev-parse --verify refs/heads/main) &&
 	 test $REIN = $(git rev-parse --verify refs/tags/rein) &&
 	 test $WER = $(git rev-parse --verify refs/heads/wer) &&
 	 test $MUSS = $(git rev-parse --verify refs/tags/muss)) <actual
@@ -83,35 +83,35 @@ test_expect_success 'fast-export --mark-tags ^muss^{commit} muss' '
 	test_cmp expected actual
 '
 
-test_expect_success 'fast-export master~2..master' '
+test_expect_success 'fast-export main~2..main' '
 
-	git fast-export master~2..master >actual &&
-	sed "s/master/partial/" actual |
+	git fast-export main~2..main >actual &&
+	sed "s/main/partial/" actual |
 		(cd new &&
 		 git fast-import &&
-		 test $MASTER != $(git rev-parse --verify refs/heads/partial) &&
-		 git diff --exit-code master partial &&
-		 git diff --exit-code master^ partial^ &&
+		 test $MAIN != $(git rev-parse --verify refs/heads/partial) &&
+		 git diff --exit-code main partial &&
+		 git diff --exit-code main^ partial^ &&
 		 test_must_fail git rev-parse partial~2)
 
 '
 
-test_expect_success 'fast-export --reference-excluded-parents master~2..master' '
+test_expect_success 'fast-export --reference-excluded-parents main~2..main' '
 
-	git fast-export --reference-excluded-parents master~2..master >actual &&
-	grep commit.refs/heads/master actual >commit-count &&
+	git fast-export --reference-excluded-parents main~2..main >actual &&
+	grep commit.refs/heads/main actual >commit-count &&
 	test_line_count = 2 commit-count &&
-	sed "s/master/rewrite/" actual |
+	sed "s/main/rewrite/" actual |
 		(cd new &&
 		 git fast-import &&
-		 test $MASTER = $(git rev-parse --verify refs/heads/rewrite))
+		 test $MAIN = $(git rev-parse --verify refs/heads/rewrite))
 '
 
 test_expect_success 'fast-export --show-original-ids' '
 
-	git fast-export --show-original-ids master >output &&
+	git fast-export --show-original-ids main >output &&
 	grep ^original-oid output| sed -e s/^original-oid.// | sort >actual &&
-	git rev-list --objects master muss >objects-and-names &&
+	git rev-list --objects main muss >objects-and-names &&
 	awk "{print \$1}" objects-and-names | sort >commits-trees-blobs &&
 	comm -23 actual commits-trees-blobs >unfound &&
 	test_must_be_empty unfound
@@ -119,8 +119,8 @@ test_expect_success 'fast-export --show-original-ids' '
 
 test_expect_success 'fast-export --show-original-ids | git fast-import' '
 
-	git fast-export --show-original-ids master muss | git fast-import --quiet &&
-	test $MASTER = $(git rev-parse --verify refs/heads/master) &&
+	git fast-export --show-original-ids main muss | git fast-import --quiet &&
+	test $MAIN = $(git rev-parse --verify refs/heads/main) &&
 	test $MUSS = $(git rev-parse --verify refs/tags/muss)
 '
 
@@ -203,7 +203,7 @@ test_expect_success 'encoding preserved if reencoding fails' '
 
 test_expect_success 'import/export-marks' '
 
-	git checkout -b marks master &&
+	git checkout -b marks main &&
 	git fast-export --export-marks=tmp-marks HEAD &&
 	test -s tmp-marks &&
 	test_line_count = 3 tmp-marks &&
@@ -268,7 +268,7 @@ test_expect_success 'signed-tags=warn-strip' '
 
 test_expect_success 'setup submodule' '
 
-	git checkout -f master &&
+	git checkout -f main &&
 	mkdir sub &&
 	(
 		cd sub &&
@@ -293,17 +293,17 @@ test_expect_success 'setup submodule' '
 
 test_expect_success 'submodule fast-export | fast-import' '
 
-	SUBENT1=$(git ls-tree master^ sub) &&
-	SUBENT2=$(git ls-tree master sub) &&
+	SUBENT1=$(git ls-tree main^ sub) &&
+	SUBENT2=$(git ls-tree main sub) &&
 	rm -rf new &&
 	mkdir new &&
 	git --git-dir=new/.git init &&
 	git fast-export --signed-tags=strip --all >actual &&
 	(cd new &&
 	 git fast-import &&
-	 test "$SUBENT1" = "$(git ls-tree refs/heads/master^ sub)" &&
-	 test "$SUBENT2" = "$(git ls-tree refs/heads/master sub)" &&
-	 git checkout master &&
+	 test "$SUBENT1" = "$(git ls-tree refs/heads/main^ sub)" &&
+	 test "$SUBENT2" = "$(git ls-tree refs/heads/main sub)" &&
+	 git checkout main &&
 	 git submodule init &&
 	 git submodule update &&
 	 cmp sub/file ../sub/file) <actual
@@ -355,7 +355,7 @@ test_expect_success 'fast-export -C -C | fast-import' '
 
 '
 
-test_expect_success 'fast-export | fast-import when master is tagged' '
+test_expect_success 'fast-export | fast-import when main is tagged' '
 
 	git tag -m msg last &&
 	git fast-export -C -C --signed-tags=strip --all > output &&
@@ -470,8 +470,8 @@ mark :2
 data 3
 hi
 
-reset refs/heads/master
-commit refs/heads/master
+reset refs/heads/main
+commit refs/heads/main
 mark :3
 author A U Thor <author@example.com> 1112912713 -0700
 committer C O Mitter <committer@example.com> 1112912713 -0700
@@ -485,7 +485,7 @@ EOF
 test_expect_failure 'no exact-ref revisions included' '
 	(
 		cd limit-by-paths &&
-		git fast-export master~2..master~1 > output &&
+		git fast-export main~2..main~1 > output &&
 		test_cmp expected output
 	)
 '
@@ -527,7 +527,7 @@ test_expect_success 'full-tree re-shows unmodified files'        '
 '
 
 test_expect_success 'set-up a few more tags for tag export tests' '
-	git checkout -f master &&
+	git checkout -f main &&
 	HEAD_TREE=$(git show -s --pretty=raw HEAD | grep tree | sed "s/tree //") &&
 	git tag    tree_tag        -m "tagging a tree" $HEAD_TREE &&
 	git tag -a tree_tag-obj    -m "tagging a tree" $HEAD_TREE &&
@@ -552,7 +552,7 @@ test_expect_success 'tag-obj_tag'     'git fast-export tag-obj_tag'
 test_expect_success 'tag-obj_tag-obj' 'git fast-export tag-obj_tag-obj'
 
 test_expect_success 'handling tags of blobs' '
-	git tag -a -m "Tag of a blob" blobtag $(git rev-parse master:file) &&
+	git tag -a -m "Tag of a blob" blobtag $(git rev-parse main:file) &&
 	git fast-export blobtag >actual &&
 	cat >expect <<-EOF &&
 	blob
@@ -595,10 +595,10 @@ test_expect_success 'directory becomes symlink'        '
 	) &&
 	(
 		cd dirtosymlink &&
-		git fast-export master -- foo |
+		git fast-export main -- foo |
 		(cd ../result && git fast-import --quiet)
 	) &&
-	(cd result && git show master:foo)
+	(cd result && git show main:foo)
 '
 
 test_expect_success 'fast-export quotes pathnames' '
@@ -646,7 +646,7 @@ mark :13
 data 5
 bump
 
-commit refs/heads/master
+commit refs/heads/main
 mark :14
 author A U Thor <author@example.com> 1112912773 -0700
 committer C O Mitter <committer@example.com> 1112912773 -0700
@@ -660,18 +660,18 @@ EOF
 test_expect_success 'avoid uninteresting refs' '
 	> tmp-marks &&
 	git fast-export --import-marks=tmp-marks \
-		--export-marks=tmp-marks master > /dev/null &&
+		--export-marks=tmp-marks main > /dev/null &&
 	git tag v1.0 &&
 	git branch uninteresting &&
 	echo bump > file &&
 	git commit -a -m bump &&
 	git fast-export --import-marks=tmp-marks \
-		--export-marks=tmp-marks ^uninteresting ^v1.0 master > actual &&
+		--export-marks=tmp-marks ^uninteresting ^v1.0 main > actual &&
 	test_cmp expected actual
 '
 
 cat > expected << EOF
-reset refs/heads/master
+reset refs/heads/main
 from :14
 
 EOF
@@ -679,14 +679,14 @@ EOF
 test_expect_success 'refs are updated even if no commits need to be exported' '
 	> tmp-marks &&
 	git fast-export --import-marks=tmp-marks \
-		--export-marks=tmp-marks master > /dev/null &&
+		--export-marks=tmp-marks main > /dev/null &&
 	git fast-export --import-marks=tmp-marks \
-		--export-marks=tmp-marks master > actual &&
+		--export-marks=tmp-marks main > actual &&
 	test_cmp expected actual
 '
 
 test_expect_success 'use refspec' '
-	git fast-export --refspec refs/heads/master:refs/heads/foobar master >actual2 &&
+	git fast-export --refspec refs/heads/main:refs/heads/foobar main >actual2 &&
 	grep "^commit " actual2 | sort | uniq >actual &&
 	echo "commit refs/heads/foobar" > expected &&
 	test_cmp expected actual
@@ -739,13 +739,13 @@ test_expect_success 'merge commit gets exported with --import-marks' '
 		test_commit initial &&
 		git checkout -b topic &&
 		test_commit on-topic &&
-		git checkout master &&
-		test_commit on-master &&
+		git checkout main &&
+		test_commit on-main &&
 		test_tick &&
 		git merge --no-ff -m Yeah topic &&
 
 		echo ":1 $(git rev-parse HEAD^^)" >marks &&
-		git fast-export --import-marks=marks master >out &&
+		git fast-export --import-marks=marks main >out &&
 		grep Yeah out
 	)
 '
diff --git a/t/t9351-fast-export-anonymize.sh b/t/t9351-fast-export-anonymize.sh
index 4130c8a837..1c6e6fcdaf 100755
--- a/t/t9351-fast-export-anonymize.sh
+++ b/t/t9351-fast-export-anonymize.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 test_description='basic tests for fast-export --anonymize'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -54,7 +54,7 @@ test_expect_success 'stream retains other as refname' '
 '
 
 test_expect_success 'stream omits other refnames' '
-	! grep master stream &&
+	! grep main stream &&
 	! grep mytag stream
 '
 
@@ -88,7 +88,7 @@ test_expect_success 'repo has original shape and timestamps' '
 	shape () {
 		git log --format="%m %ct" --left-right --boundary "$@"
 	} &&
-	(cd .. && shape master...other) >expect &&
+	(cd .. && shape main...other) >expect &&
 	shape $main_branch...$other_branch >actual &&
 	test_cmp expect actual
 '
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 7d23e6ba94..2d29d486ee 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -8,7 +8,7 @@ test_description='git-cvsserver access
 tests read access to a git repository with the
 cvs CLI client via git-cvsserver server'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -48,7 +48,7 @@ test_expect_success 'setup' '
   touch secondrootfile &&
   git add secondrootfile &&
   git commit -m "second root") &&
-  git fetch secondroot master &&
+  git fetch secondroot main &&
   git merge --allow-unrelated-histories FETCH_HEAD &&
   git clone -q --bare "$WORKDIR/.git" "$SERVERDIR" >/dev/null 2>&1 &&
   GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled true &&
@@ -60,7 +60,7 @@ test_expect_success 'setup' '
 # note that cvs doesn't accept absolute pathnames
 # as argument to co -d
 test_expect_success 'basic checkout' \
-  'GIT_CONFIG="$git_config" cvs -Q co -d cvswork master &&
+  'GIT_CONFIG="$git_config" cvs -Q co -d cvswork main &&
    test "$(echo $(grep -v ^D cvswork/CVS/Entries|cut -d/ -f2,3,5 | head -n 1))" = "empty/1.1/" &&
    test "$(echo $(grep -v ^D cvswork/CVS/Entries|cut -d/ -f2,3,5 | sed -ne \$p))" = "secondrootfile/1.1/"'
 
@@ -229,7 +229,7 @@ GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled true || exit 1
 
 test_expect_success 'gitcvs.enabled = false' \
   'GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled false &&
-   if GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 master >cvs.log 2>&1
+   if GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 main >cvs.log 2>&1
    then
      echo unexpected cvs success
      false
@@ -243,14 +243,14 @@ rm -fr cvswork2
 test_expect_success 'gitcvs.ext.enabled = true' \
   'GIT_DIR="$SERVERDIR" git config --bool gitcvs.ext.enabled true &&
    GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled false &&
-   GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 master >cvs.log 2>&1 &&
+   GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 main >cvs.log 2>&1 &&
    test_cmp cvswork cvswork2'
 
 rm -fr cvswork2
 test_expect_success 'gitcvs.ext.enabled = false' \
   'GIT_DIR="$SERVERDIR" git config --bool gitcvs.ext.enabled false &&
    GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled true &&
-   if GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 master >cvs.log 2>&1
+   if GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 main >cvs.log 2>&1
    then
      echo unexpected cvs success
      false
@@ -264,21 +264,21 @@ rm -fr cvswork2
 test_expect_success 'gitcvs.dbname' \
   'GIT_DIR="$SERVERDIR" git config --bool gitcvs.ext.enabled true &&
    GIT_DIR="$SERVERDIR" git config gitcvs.dbname %Ggitcvs.%a.%m.sqlite &&
-   GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 master >cvs.log 2>&1 &&
+   GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 main >cvs.log 2>&1 &&
    test_cmp cvswork cvswork2 &&
-   test -f "$SERVERDIR/gitcvs.ext.master.sqlite" &&
-   cmp "$SERVERDIR/gitcvs.master.sqlite" "$SERVERDIR/gitcvs.ext.master.sqlite"'
+   test -f "$SERVERDIR/gitcvs.ext.main.sqlite" &&
+   cmp "$SERVERDIR/gitcvs.main.sqlite" "$SERVERDIR/gitcvs.ext.main.sqlite"'
 
 rm -fr cvswork2
 test_expect_success 'gitcvs.ext.dbname' \
   'GIT_DIR="$SERVERDIR" git config --bool gitcvs.ext.enabled true &&
    GIT_DIR="$SERVERDIR" git config gitcvs.ext.dbname %Ggitcvs1.%a.%m.sqlite &&
    GIT_DIR="$SERVERDIR" git config gitcvs.dbname %Ggitcvs2.%a.%m.sqlite &&
-   GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 master >cvs.log 2>&1 &&
+   GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 main >cvs.log 2>&1 &&
    test_cmp cvswork cvswork2 &&
-   test -f "$SERVERDIR/gitcvs1.ext.master.sqlite" &&
-   test ! -f "$SERVERDIR/gitcvs2.ext.master.sqlite" &&
-   cmp "$SERVERDIR/gitcvs.master.sqlite" "$SERVERDIR/gitcvs1.ext.master.sqlite"'
+   test -f "$SERVERDIR/gitcvs1.ext.main.sqlite" &&
+   test ! -f "$SERVERDIR/gitcvs2.ext.main.sqlite" &&
+   cmp "$SERVERDIR/gitcvs.main.sqlite" "$SERVERDIR/gitcvs1.ext.main.sqlite"'
 
 
 #------------
@@ -460,7 +460,7 @@ cd "$WORKDIR"
 test_expect_success 'cvs update (module list supports packed refs)' '
     GIT_DIR="$SERVERDIR" git pack-refs --all &&
     GIT_CONFIG="$git_config" cvs -n up -d 2> out &&
-    grep "cvs update: New directory \`master'\''" < out
+    grep "cvs update: New directory \`main'\''" < out
 '
 
 #------------
@@ -502,8 +502,8 @@ test_expect_success 'cvs status (no subdirs in header)' '
 cd "$WORKDIR"
 test_expect_success 'cvs co -c (shows module database)' '
     GIT_CONFIG="$git_config" cvs co -c > out &&
-    grep "^master[	 ][ 	]*master$" <out &&
-    ! grep -v "^master[	 ][ 	]*master$" <out
+    grep "^main[	 ][ 	]*main$" <out &&
+    ! grep -v "^main[	 ][ 	]*main$" <out
 '
 
 #------------
@@ -529,7 +529,7 @@ test_expect_success 'cvs co -c (shows module database)' '
 
 sed -e 's/^x//' -e 's/SP$/ /' > "$WORKDIR/expect" <<EOF
 x
-xRCS file: $WORKDIR/gitcvs.git/master/merge,v
+xRCS file: $WORKDIR/gitcvs.git/main/merge,v
 xWorking file: merge
 xhead: 1.4
 xbranch:
diff --git a/t/t9401-git-cvsserver-crlf.sh b/t/t9401-git-cvsserver-crlf.sh
index 0062341dbf..a34805acdc 100755
--- a/t/t9401-git-cvsserver-crlf.sh
+++ b/t/t9401-git-cvsserver-crlf.sh
@@ -9,7 +9,7 @@ test_description='git-cvsserver -kb modes
 tests -kb mode for binary files when accessing a git
 repository using cvs CLI client via git-cvsserver server'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -108,14 +108,14 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'cvs co (default crlf)' '
-    GIT_CONFIG="$git_config" cvs -Q co -d cvswork master >cvs.log 2>&1 &&
+    GIT_CONFIG="$git_config" cvs -Q co -d cvswork main >cvs.log 2>&1 &&
     test x"$(grep '/-k' cvswork/CVS/Entries cvswork/subdir/CVS/Entries)" = x""
 '
 
 rm -rf cvswork
 test_expect_success 'cvs co (allbinary)' '
     GIT_DIR="$SERVERDIR" git config --bool gitcvs.allbinary true &&
-    GIT_CONFIG="$git_config" cvs -Q co -d cvswork master >cvs.log 2>&1 &&
+    GIT_CONFIG="$git_config" cvs -Q co -d cvswork main >cvs.log 2>&1 &&
     marked_as cvswork textfile.c -kb &&
     marked_as cvswork binfile.bin -kb &&
     marked_as cvswork .gitattributes -kb &&
@@ -128,7 +128,7 @@ test_expect_success 'cvs co (allbinary)' '
 rm -rf cvswork cvs.log
 test_expect_success 'cvs co (use attributes/allbinary)' '
     GIT_DIR="$SERVERDIR" git config --bool gitcvs.usecrlfattr true &&
-    GIT_CONFIG="$git_config" cvs -Q co -d cvswork master >cvs.log 2>&1 &&
+    GIT_CONFIG="$git_config" cvs -Q co -d cvswork main >cvs.log 2>&1 &&
     marked_as cvswork textfile.c "" &&
     marked_as cvswork binfile.bin -kb &&
     marked_as cvswork .gitattributes -kb &&
@@ -141,7 +141,7 @@ test_expect_success 'cvs co (use attributes/allbinary)' '
 rm -rf cvswork
 test_expect_success 'cvs co (use attributes)' '
     GIT_DIR="$SERVERDIR" git config --bool gitcvs.allbinary false &&
-    GIT_CONFIG="$git_config" cvs -Q co -d cvswork master >cvs.log 2>&1 &&
+    GIT_CONFIG="$git_config" cvs -Q co -d cvswork main >cvs.log 2>&1 &&
     marked_as cvswork textfile.c "" &&
     marked_as cvswork binfile.bin -kb &&
     marked_as cvswork .gitattributes "" &&
@@ -197,7 +197,7 @@ test_expect_success 'updating' '
 rm -rf cvswork
 test_expect_success 'cvs co (use attributes/guess)' '
     GIT_DIR="$SERVERDIR" git config gitcvs.allbinary guess &&
-    GIT_CONFIG="$git_config" cvs -Q co -d cvswork master >cvs.log 2>&1 &&
+    GIT_CONFIG="$git_config" cvs -Q co -d cvswork main >cvs.log 2>&1 &&
     marked_as cvswork textfile.c "" &&
     marked_as cvswork binfile.bin -kb &&
     marked_as cvswork .gitattributes "" &&
@@ -227,7 +227,7 @@ test_expect_success 'setup multi-line files' '
 rm -rf cvswork
 test_expect_success 'cvs co (guess)' '
     GIT_DIR="$SERVERDIR" git config --bool gitcvs.usecrlfattr false &&
-    GIT_CONFIG="$git_config" cvs -Q co -d cvswork master >cvs.log 2>&1 &&
+    GIT_CONFIG="$git_config" cvs -Q co -d cvswork main >cvs.log 2>&1 &&
     marked_as cvswork textfile.c "" &&
     marked_as cvswork binfile.bin -kb &&
     marked_as cvswork .gitattributes "" &&
@@ -242,7 +242,7 @@ test_expect_success 'cvs co (guess)' '
 '
 
 test_expect_success 'cvs co another copy (guess)' '
-    GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 master >cvs.log 2>&1 &&
+    GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 main >cvs.log 2>&1 &&
     marked_as cvswork2 textfile.c "" &&
     marked_as cvswork2 binfile.bin -kb &&
     marked_as cvswork2 .gitattributes "" &&
@@ -338,7 +338,7 @@ test_expect_success 'update subdir of other copy (guess)' '
 
 echo "starting update/merge" >> "${WORKDIR}/marked.log"
 test_expect_success 'update/merge full other copy (guess)' '
-    git pull gitcvs.git master &&
+    git pull gitcvs.git main &&
     sed "s/3/replaced_3/" < multilineTxt.c > ml.temp &&
     mv ml.temp multilineTxt.c &&
     git add multilineTxt.c &&
diff --git a/t/t9402-git-cvsserver-refs.sh b/t/t9402-git-cvsserver-refs.sh
index 33b6db1648..2ee41f9443 100755
--- a/t/t9402-git-cvsserver-refs.sh
+++ b/t/t9402-git-cvsserver-refs.sh
@@ -5,7 +5,7 @@ test_description='git-cvsserver and git refspecs
 tests ability for git-cvsserver to switch between and compare
 tags, branches and other git refspecs'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -118,7 +118,7 @@ test_expect_success 'setup v1, b1' '
 
 rm -rf cvswork
 test_expect_success 'cvs co v1' '
-	cvs -f -Q co -r v1 -d cvswork master >cvs.log 2>&1 &&
+	cvs -f -Q co -r v1 -d cvswork main >cvs.log 2>&1 &&
 	check_start_tree cvswork &&
 	check_file cvswork textfile.c v1 &&
 	check_file cvswork t2 v1 &&
@@ -131,7 +131,7 @@ test_expect_success 'cvs co v1' '
 
 rm -rf cvswork
 test_expect_success 'cvs co b1' '
-	cvs -f co -r b1 -d cvswork master >cvs.log 2>&1 &&
+	cvs -f co -r b1 -d cvswork main >cvs.log 2>&1 &&
 	check_start_tree cvswork &&
 	check_file cvswork textfile.c v1 &&
 	check_file cvswork t2 v1 &&
@@ -143,7 +143,7 @@ test_expect_success 'cvs co b1' '
 '
 
 test_expect_success 'cvs co b1 [cvswork3]' '
-	cvs -f co -r b1 -d cvswork3 master >cvs.log 2>&1 &&
+	cvs -f co -r b1 -d cvswork3 main >cvs.log 2>&1 &&
 	check_start_tree cvswork3 &&
 	check_file cvswork3 textfile.c v1 &&
 	check_file cvswork3 t2 v1 &&
@@ -268,7 +268,7 @@ test_expect_success 'setup simple b2' '
 '
 
 test_expect_success 'cvs co b2 [into cvswork2]' '
-	cvs -f co -r b2 -d cvswork2 master >cvs.log 2>&1 &&
+	cvs -f co -r b2 -d cvswork2 main >cvs.log 2>&1 &&
 	check_start_tree cvswork &&
 	check_file cvswork textfile.c v1 &&
 	check_file cvswork t2 v1 &&
-- 
gitgitgadget

