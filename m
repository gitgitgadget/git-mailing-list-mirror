Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED59C71155
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 16:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1EF9221F8
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 16:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAvIoaRa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgKQQM4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 11:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbgKQQMz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 11:12:55 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4683CC061A48
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 08:12:53 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id k2so23788960wrx.2
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 08:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dguxSD8G5R6EitYwthirs0RCHQXW5kYreCnLQ5nQYgA=;
        b=RAvIoaRao+lWjb6ThsX7Rr+GnjBsD2xVLsDLXAWQRT1JrVxqGJIZQ9/PKiaKbfWJCR
         +kVjnxL1lMmS8LsRKdPZ20y+/uEMOYlxXVwrqHw1pd0bQElQGLhMpM9VZIKyC1foMy0I
         Evx/mFT4I1kf1QYUg7/NsJTIw4FBilawLzanPneiHQT6LFlsyq6zIGI/WltCUQbTVHk3
         ylKwxU0is6GfXZADkvFHPtqCRnxwPqGQlY1A3U1YqqujIWsL4XAmuNSWTZ/qP5P1H2aC
         1XFyy0VmGRLOa11GnUYlb7QiqWJacJ6Fz48n/YBx/ACXAFyz1u3TLy5rOdsmh0QJJdLM
         aYbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dguxSD8G5R6EitYwthirs0RCHQXW5kYreCnLQ5nQYgA=;
        b=TGwCBWjByGUH7LrRf8h5WAe3j67lCk8sTWHDI40AyewJIUjAf3aEhC8rejAbzj46Hg
         V8qyyVYcDodVyZPMaZ0lSvpbJ6itSb7D3Ys/IP/2fPqwkRBGk362MMSkxUyeYlJtCYv6
         ANo/xcIRMtmNjkvueSzduNxxSm1Lwv1RxwHYt2f4RonZskKx6Ab3/z42E7s2cDdhAYhT
         BCI1fbjHywlruLnlaLk2w3mklmdKrrAtU6lmhBgwVbyu+n25sR1aUzpYjuB7RMO6CItg
         rGYCUV0wDNab6Hgx3upCgWOOoqcSM/7JdeJVJnnNeWQiLf6ZP3fTeVXJCPNRNCtGuFhC
         d67g==
X-Gm-Message-State: AOAM530cODzjr8YGb+lGxofgfbT6MdvlOxJpAmEeqNlpjlkWpn97ogre
        GiQlINGVP/AOt+94EPb5Li5LU1brFUg=
X-Google-Smtp-Source: ABdhPJwmlkdVENkf2cZclA4Q/yzpmivb7w7sMSGf4RACHRBL7pZIVDKlV11A4WWt+Jg1bBNvlkeFYw==
X-Received: by 2002:adf:dcc3:: with SMTP id x3mr265790wrm.81.1605629571273;
        Tue, 17 Nov 2020 08:12:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l13sm29393204wrm.24.2020.11.17.08.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 08:12:50 -0800 (PST)
Message-Id: <57e90d459aec36fc4726215b2fd75d2ab048c72a.1605629549.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
        <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Nov 2020 16:12:23 +0000
Subject: [PATCH v2 23/27] t9[0-4]*: adjust the references to the default
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
 t/t9001-send-email.sh                  | 28 ++++-----
 t/t9100-git-svn-basic.sh               |  2 +-
 t/t9145-git-svn-master-branch.sh       |  6 +-
 t/t9151-svn-mergeinfo.sh               |  2 +-
 t/t9155-git-svn-fetch-deleted-tag.sh   |  2 +-
 t/t9156-git-svn-fetch-deleted-tag-2.sh |  6 +-
 t/t9163-git-svn-reset-clears-caches.sh |  2 +-
 t/t9169-git-svn-dcommit-crlf.sh        |  2 +-
 t/t9300-fast-import.sh                 | 82 ++++++++++++------------
 t/t9301-fast-import-notes.sh           | 14 ++---
 t/t9302-fast-import-unpack-limit.sh    | 16 ++---
 t/t9350-fast-export.sh                 | 86 +++++++++++++-------------
 t/t9351-fast-export-anonymize.sh       |  4 +-
 t/t9400-git-cvsserver-server.sh        | 32 +++++-----
 t/t9401-git-cvsserver-crlf.sh          | 16 ++---
 t/t9402-git-cvsserver-refs.sh          |  8 +--
 t/test-lib.sh                          |  2 +-
 17 files changed, 155 insertions(+), 155 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index a08f72596a..579360d2f1 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1168,10 +1168,10 @@ test_expect_success $PREREQ '--compose-encoding adds correct MIME for subject' '
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
 
@@ -1185,7 +1185,7 @@ test_expect_success $PREREQ 'feed two files' '
 		outdir/000?-*.patch 2>errors >out &&
 	grep "^Subject: " out >subjects &&
 	test "z$(sed -n -e 1p subjects)" = "zSubject: [PATCH 1/2] Second." &&
-	test "z$(sed -n -e 2p subjects)" = "zSubject: [PATCH 2/2] add master"
+	test "z$(sed -n -e 2p subjects)" = "zSubject: [PATCH 2/2] add main"
 '
 
 test_expect_success $PREREQ 'in-reply-to but no threading' '
@@ -2037,7 +2037,7 @@ test_expect_success $PREREQ 'setup expected-list' '
 	--cc="Cc2 <cc2@example.com>" \
 	--bcc="bcc1@example.com" \
 	--bcc="bcc2@example.com" \
-	0001-add-master.patch | replace_variable_fields \
+	0001-add-main.patch | replace_variable_fields \
 	>expected-list
 '
 
@@ -2049,7 +2049,7 @@ test_expect_success $PREREQ 'use email list in --cc --to and --bcc' '
 	--to="to3@example.com" \
 	--cc="Cc 1 <cc1@example.com>, Cc2 <cc2@example.com>" \
 	--bcc="bcc1@example.com, bcc2@example.com" \
-	0001-add-master.patch | replace_variable_fields \
+	0001-add-main.patch | replace_variable_fields \
 	>actual-list &&
 	test_cmp expected-list actual-list
 '
@@ -2065,7 +2065,7 @@ test_expect_success $PREREQ 'aliases work with email list' '
 	--to="To 1 <to1@example.com>, to2, to3@example.com" \
 	--cc="cc1, Cc2 <cc2@example.com>" \
 	--bcc="bcc1@example.com, bcc2@example.com" \
-	0001-add-master.patch | replace_variable_fields \
+	0001-add-main.patch | replace_variable_fields \
 	>actual-list &&
 	test_cmp expected-list actual-list
 '
@@ -2089,7 +2089,7 @@ test_expect_success $PREREQ 'leading and trailing whitespaces are removed' '
 	--cc="Cc2 <cc2@example.com>" \
 	--bcc="$BCC1" \
 	--bcc="bcc2@example.com" \
-	0001-add-master.patch | replace_variable_fields \
+	0001-add-main.patch | replace_variable_fields \
 	>actual-list &&
 	test_cmp expected-list actual-list
 '
@@ -2108,8 +2108,8 @@ test_expect_success $PREREQ 'invoke hook' '
 		false
 		;;
 	esac &&
-	test -f 0001-add-master.patch &&
-	grep "add master" "$1"
+	test -f 0001-add-main.patch &&
+	grep "add main" "$1"
 	EOF
 
 	mkdir subdir &&
@@ -2121,10 +2121,10 @@ test_expect_success $PREREQ 'invoke hook' '
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
@@ -2139,7 +2139,7 @@ test_expect_success $PREREQ 'test that send-email works outside a repo' '
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
 		--smtp-server="$(pwd)/fake.sendmail" \
-		"$(pwd)/0001-add-master.patch"
+		"$(pwd)/0001-add-main.patch"
 '
 
 test_expect_success $PREREQ 'test that sendmail config is rejected' '
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index e4bb22034e..7dbf4b8fa0 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -275,7 +275,7 @@ test_expect_success 'dcommit $rev does not clobber current branch' '
 	test refs/heads/my-bar = $(git symbolic-ref HEAD) &&
 	git log refs/remotes/bar | grep "change 1" &&
 	! git log refs/remotes/bar | grep "change 2" &&
-	git checkout master &&
+	git checkout main &&
 	git branch -D my-bar
 	'
 
diff --git a/t/t9145-git-svn-master-branch.sh b/t/t9145-git-svn-master-branch.sh
index 3bbf341f6a..c5acce010d 100755
--- a/t/t9145-git-svn-master-branch.sh
+++ b/t/t9145-git-svn-master-branch.sh
@@ -2,7 +2,7 @@
 #
 # Copyright (c) 2009 Eric Wong
 #
-test_description='git svn initial master branch is "trunk" if possible'
+test_description='git svn initial main branch is "trunk" if possible'
 . ./lib-git-svn.sh
 
 test_expect_success 'setup test repository' '
@@ -13,12 +13,12 @@ test_expect_success 'setup test repository' '
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
index 4f6c06ecb2..e2f63823f1 100755
--- a/t/t9151-svn-mergeinfo.sh
+++ b/t/t9151-svn-mergeinfo.sh
@@ -50,7 +50,7 @@ test_expect_success 'merging two branches in one commit is detected correctly' '
 	'
 
 test_expect_failure 'everything got merged in the end' '
-	unmerged=$(git rev-list --all --not master) &&
+	unmerged=$(git rev-list --all --not main) &&
 	[ -z "$unmerged" ]
 	'
 
diff --git a/t/t9155-git-svn-fetch-deleted-tag.sh b/t/t9155-git-svn-fetch-deleted-tag.sh
index 184336f346..891c209238 100755
--- a/t/t9155-git-svn-fetch-deleted-tag.sh
+++ b/t/t9155-git-svn-fetch-deleted-tag.sh
@@ -36,7 +36,7 @@ test_expect_success 'fetch deleted tags from same revision with checksum error'
 	git svn fetch &&
 
 	git diff --exit-code origin/mybranch:trunk/subdir/file origin/tags/mytag:file &&
-	git diff --exit-code master:subdir/file origin/tags/mytag^:file
+	git diff --exit-code main:subdir/file origin/tags/mytag^:file
 '
 
 test_done
diff --git a/t/t9156-git-svn-fetch-deleted-tag-2.sh b/t/t9156-git-svn-fetch-deleted-tag-2.sh
index 7a6e33ba3c..0b91063edb 100755
--- a/t/t9156-git-svn-fetch-deleted-tag-2.sh
+++ b/t/t9156-git-svn-fetch-deleted-tag-2.sh
@@ -36,9 +36,9 @@ test_expect_success 'fetch deleted tags from same revision with no checksum erro
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
index d6245cee08..0da856338f 100755
--- a/t/t9163-git-svn-reset-clears-caches.sh
+++ b/t/t9163-git-svn-reset-clears-caches.sh
@@ -59,7 +59,7 @@ test_expect_success 'fetch to merge-base (a)' '
 test_expect_success 'rebase looses SVN merge (m)' '
 	git svn rebase &&
 	git svn fetch &&
-	test 1 = $(git cat-file -p master|grep parent|wc -l)
+	test 1 = $(git cat-file -p main|grep parent|wc -l)
 '
 
 # git svn fetch creates correct history with merge commit
diff --git a/t/t9169-git-svn-dcommit-crlf.sh b/t/t9169-git-svn-dcommit-crlf.sh
index 54b1f61a2a..5016896ae6 100755
--- a/t/t9169-git-svn-dcommit-crlf.sh
+++ b/t/t9169-git-svn-dcommit-crlf.sh
@@ -14,7 +14,7 @@ test_expect_success 'setup commit repository' '
 		p=$(git rev-parse HEAD) &&
 		t=$(git write-tree) &&
 		cmt=$(git commit-tree -p $p $t <cmt) &&
-		git update-ref refs/heads/master $cmt &&
+		git update-ref refs/heads/main $cmt &&
 		git cat-file commit HEAD | tail -n4 >out &&
 		test_cmp cmt out &&
 		git svn dcommit &&
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 308c1ef42c..e66f438e64 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -62,7 +62,7 @@ test_expect_success 'A: create pack from stdin' '
 	mark :4
 	data $file4_len
 	$file4_data
-	commit refs/heads/master
+	commit refs/heads/main
 	mark :5
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 	data <<COMMIT
@@ -117,7 +117,7 @@ test_expect_success 'A: create pack from stdin' '
 
 	INPUT_END
 	git fast-import --export-marks=marks.out <input &&
-	git whatchanged master
+	git whatchanged main
 '
 
 test_expect_success 'A: verify pack' '
@@ -131,7 +131,7 @@ test_expect_success 'A: verify commit' '
 
 	initial
 	EOF
-	git cat-file commit master | sed 1d >actual &&
+	git cat-file commit main | sed 1d >actual &&
 	test_cmp expect actual
 '
 
@@ -141,31 +141,31 @@ test_expect_success 'A: verify tree' '
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
 
@@ -177,7 +177,7 @@ test_expect_success 'A: verify tag/series-A' '
 
 test_expect_success 'A: verify tag/series-A-blob' '
 	cat >expect <<-EOF &&
-	object $(git rev-parse refs/heads/master:file3)
+	object $(git rev-parse refs/heads/main:file3)
 	type blob
 	tag series-A-blob
 
@@ -193,13 +193,13 @@ test_expect_success 'A: verify tag deletion is successful' '
 
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
@@ -217,7 +217,7 @@ test_expect_success 'A: tag blob by sha1' '
 	new_blob=$(echo testing | git hash-object --stdin) &&
 	cat >input <<-INPUT_END &&
 	tag series-A-blob-2
-	from $(git rev-parse refs/heads/master:file3)
+	from $(git rev-parse refs/heads/main:file3)
 	data <<EOF
 	Tag blob by sha1.
 	EOF
@@ -243,7 +243,7 @@ test_expect_success 'A: tag blob by sha1' '
 	INPUT_END
 
 	cat >expect <<-EOF &&
-	object $(git rev-parse refs/heads/master:file3)
+	object $(git rev-parse refs/heads/main:file3)
 	type blob
 	tag series-A-blob-2
 
@@ -284,13 +284,13 @@ test_expect_success 'A: verify pack' '
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
 
@@ -364,7 +364,7 @@ test_expect_success 'B: fail on invalid blob sha1' '
 	corrupt
 	COMMIT
 
-	from refs/heads/master
+	from refs/heads/main
 	M 755 $(echo $ZERO_OID | sed -e "s/0$/1/") zero1
 
 	INPUT_END
@@ -381,7 +381,7 @@ test_expect_success 'B: accept branch name "TEMP_TAG"' '
 	tag base
 	COMMIT
 
-	from refs/heads/master
+	from refs/heads/main
 
 	INPUT_END
 
@@ -390,7 +390,7 @@ test_expect_success 'B: accept branch name "TEMP_TAG"' '
 		git prune" &&
 	git fast-import <input &&
 	test -f .git/TEMP_TAG &&
-	test $(git rev-parse master) = $(git rev-parse TEMP_TAG^)
+	test $(git rev-parse main) = $(git rev-parse TEMP_TAG^)
 '
 
 test_expect_success 'B: accept empty committer' '
@@ -528,8 +528,8 @@ test_expect_success 'B: fail on invalid committer (5)' '
 
 test_expect_success 'C: incremental import create pack from stdin' '
 	newf=$(echo hi newf | git hash-object -w --stdin) &&
-	oldf=$(git rev-parse --verify master:file2) &&
-	thrf=$(git rev-parse --verify master:file3) &&
+	oldf=$(git rev-parse --verify main:file2) &&
+	thrf=$(git rev-parse --verify main:file3) &&
 	test_tick &&
 	cat >input <<-INPUT_END &&
 	commit refs/heads/branch
@@ -538,7 +538,7 @@ test_expect_success 'C: incremental import create pack from stdin' '
 	second
 	COMMIT
 
-	from refs/heads/master
+	from refs/heads/main
 	M 644 $oldf file2/oldf
 	M 755 $newf file2/newf
 	D file3
@@ -560,7 +560,7 @@ test_expect_success 'C: validate reuse existing blob' '
 
 test_expect_success 'C: verify commit' '
 	cat >expect <<-EOF &&
-	parent $(git rev-parse --verify master^0)
+	parent $(git rev-parse --verify main^0)
 	author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
@@ -578,7 +578,7 @@ test_expect_success 'C: validate rename result' '
 	:100644 100644 $oldf $oldf R100	file2	file2/oldf
 	:100644 000000 $thrf $zero D	file3
 	EOF
-	git diff-tree -M -r master branch >actual &&
+	git diff-tree -M -r main branch >actual &&
 	compare_diff_raw expect actual
 '
 
@@ -1698,7 +1698,7 @@ test_expect_success 'P: superproject & submodule mix' '
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 	data 8
 	initial
-	from refs/heads/master
+	from refs/heads/main
 	M 100644 :3 .gitmodules
 	M 160000 :2 sub
 
@@ -1733,8 +1733,8 @@ test_expect_success 'P: superproject & submodule mix' '
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
@@ -1758,7 +1758,7 @@ test_expect_success 'P: verbatim SHA gitlinks' '
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 	data 8
 	initial
-	from refs/heads/master
+	from refs/heads/main
 	M 100644 :1 .gitmodules
 	M 160000 $SUBPREV sub
 
@@ -3429,8 +3429,8 @@ mark :1
 data 4
 foo
 
-reset refs/heads/master
-commit refs/heads/master
+reset refs/heads/main
+commit refs/heads/main
 mark :2
 author Full Name <user@company.tld> 1000000000 +0100
 committer Full Name <user@company.tld> 1000000000 +0100
@@ -3444,7 +3444,7 @@ data 8
 foo
 bar
 
-commit refs/heads/master
+commit refs/heads/main
 mark :4
 author Full Name <user@company.tld> 1000000001 +0100
 committer Full Name <user@company.tld> 1000000001 +0100
@@ -3461,8 +3461,8 @@ mark :1
 data 4
 foo
 
-reset refs/heads/master
-commit refs/heads/master
+reset refs/heads/main
+commit refs/heads/main
 mark :2
 author Full Name <user@company.tld> 2000000000 +0100
 committer Full Name <user@company.tld> 2000000000 +0100
@@ -3477,7 +3477,7 @@ data 73
 	path = sub1
 	url = https://void.example.com/main.git
 
-commit refs/heads/master
+commit refs/heads/main
 mark :4
 author Full Name <user@company.tld> 2000000001 +0100
 committer Full Name <user@company.tld> 2000000001 +0100
@@ -3493,7 +3493,7 @@ data 8
 foo
 bar
 
-commit refs/heads/master
+commit refs/heads/main
 mark :6
 author Full Name <user@company.tld> 2000000002 +0100
 committer Full Name <user@company.tld> 2000000002 +0100
@@ -3511,8 +3511,8 @@ Y_INPUT_END
 
 test_expect_success 'Y: setup' '
 	test_oid_cache <<-EOF
-	Ymaster sha1:9afed2f9161ddf416c0a1863b8b0725b00070504
-	Ymaster sha256:c0a1010da1df187b2e287654793df01b464bd6f8e3f17fc1481a7dadf84caee3
+	Ymain sha1:9afed2f9161ddf416c0a1863b8b0725b00070504
+	Ymain sha256:c0a1010da1df187b2e287654793df01b464bd6f8e3f17fc1481a7dadf84caee3
 	EOF
 '
 
@@ -3524,7 +3524,7 @@ test_expect_success 'Y: rewrite submodules' '
 		git -C sub2 fast-import --export-marks=../sub2-marks <../Y-sub-input &&
 		git fast-import --rewrite-submodules-from=sub:../Y-marks \
 			--rewrite-submodules-to=sub:sub2-marks <../Y-main-input &&
-		test "$(git rev-parse master)" = "$(test_oid Ymaster)"
+		test "$(git rev-parse main)" = "$(test_oid Ymain)"
 	)
 '
 
diff --git a/t/t9301-fast-import-notes.sh b/t/t9301-fast-import-notes.sh
index 14c1baa739..ea6efbd387 100755
--- a/t/t9301-fast-import-notes.sh
+++ b/t/t9301-fast-import-notes.sh
@@ -9,7 +9,7 @@ test_description='test git fast-import of notes objects'
 
 test_tick
 cat >input <<INPUT_END
-commit refs/heads/master
+commit refs/heads/main
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
 first commit
@@ -30,7 +30,7 @@ data <<EOF
 file baz/xyzzy in first commit
 EOF
 
-commit refs/heads/master
+commit refs/heads/main
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
 second commit
@@ -46,7 +46,7 @@ data <<EOF
 file baz/xyzzy in second commit
 EOF
 
-commit refs/heads/master
+commit refs/heads/main
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
 third commit
@@ -57,7 +57,7 @@ data <<EOF
 file foo in third commit
 EOF
 
-commit refs/heads/master
+commit refs/heads/main
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
 fourth commit
@@ -70,13 +70,13 @@ EOF
 
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
index 1372842559..0715eefd52 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -31,13 +31,13 @@ test_expect_success 'setup' '
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
@@ -46,7 +46,7 @@ test_expect_success 'fast-export | fast-import' '
 	git fast-export --all >actual &&
 	(cd new &&
 	 git fast-import &&
-	 test $MASTER = $(git rev-parse --verify refs/heads/master) &&
+	 test $MAIN = $(git rev-parse --verify refs/heads/main) &&
 	 test $REIN = $(git rev-parse --verify refs/tags/rein) &&
 	 test $WER = $(git rev-parse --verify refs/heads/wer) &&
 	 test $MUSS = $(git rev-parse --verify refs/tags/muss)) <actual
@@ -80,35 +80,35 @@ test_expect_success 'fast-export --mark-tags ^muss^{commit} muss' '
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
@@ -116,8 +116,8 @@ test_expect_success 'fast-export --show-original-ids' '
 
 test_expect_success 'fast-export --show-original-ids | git fast-import' '
 
-	git fast-export --show-original-ids master muss | git fast-import --quiet &&
-	test $MASTER = $(git rev-parse --verify refs/heads/master) &&
+	git fast-export --show-original-ids main muss | git fast-import --quiet &&
+	test $MAIN = $(git rev-parse --verify refs/heads/main) &&
 	test $MUSS = $(git rev-parse --verify refs/tags/muss)
 '
 
@@ -200,7 +200,7 @@ test_expect_success 'encoding preserved if reencoding fails' '
 
 test_expect_success 'import/export-marks' '
 
-	git checkout -b marks master &&
+	git checkout -b marks main &&
 	git fast-export --export-marks=tmp-marks HEAD &&
 	test -s tmp-marks &&
 	test_line_count = 3 tmp-marks &&
@@ -265,7 +265,7 @@ test_expect_success 'signed-tags=warn-strip' '
 
 test_expect_success 'setup submodule' '
 
-	git checkout -f master &&
+	git checkout -f main &&
 	mkdir sub &&
 	(
 		cd sub &&
@@ -290,17 +290,17 @@ test_expect_success 'setup submodule' '
 
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
@@ -352,7 +352,7 @@ test_expect_success 'fast-export -C -C | fast-import' '
 
 '
 
-test_expect_success 'fast-export | fast-import when master is tagged' '
+test_expect_success 'fast-export | fast-import when main is tagged' '
 
 	git tag -m msg last &&
 	git fast-export -C -C --signed-tags=strip --all > output &&
@@ -467,8 +467,8 @@ mark :2
 data 3
 hi
 
-reset refs/heads/master
-commit refs/heads/master
+reset refs/heads/main
+commit refs/heads/main
 mark :3
 author A U Thor <author@example.com> 1112912713 -0700
 committer C O Mitter <committer@example.com> 1112912713 -0700
@@ -482,7 +482,7 @@ EOF
 test_expect_failure 'no exact-ref revisions included' '
 	(
 		cd limit-by-paths &&
-		git fast-export master~2..master~1 > output &&
+		git fast-export main~2..main~1 > output &&
 		test_cmp expected output
 	)
 '
@@ -524,7 +524,7 @@ test_expect_success 'full-tree re-shows unmodified files'        '
 '
 
 test_expect_success 'set-up a few more tags for tag export tests' '
-	git checkout -f master &&
+	git checkout -f main &&
 	HEAD_TREE=$(git show -s --pretty=raw HEAD | grep tree | sed "s/tree //") &&
 	git tag    tree_tag        -m "tagging a tree" $HEAD_TREE &&
 	git tag -a tree_tag-obj    -m "tagging a tree" $HEAD_TREE &&
@@ -549,7 +549,7 @@ test_expect_success 'tag-obj_tag'     'git fast-export tag-obj_tag'
 test_expect_success 'tag-obj_tag-obj' 'git fast-export tag-obj_tag-obj'
 
 test_expect_success 'handling tags of blobs' '
-	git tag -a -m "Tag of a blob" blobtag $(git rev-parse master:file) &&
+	git tag -a -m "Tag of a blob" blobtag $(git rev-parse main:file) &&
 	git fast-export blobtag >actual &&
 	cat >expect <<-EOF &&
 	blob
@@ -592,10 +592,10 @@ test_expect_success 'directory becomes symlink'        '
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
@@ -643,7 +643,7 @@ mark :13
 data 5
 bump
 
-commit refs/heads/master
+commit refs/heads/main
 mark :14
 author A U Thor <author@example.com> 1112912773 -0700
 committer C O Mitter <committer@example.com> 1112912773 -0700
@@ -657,18 +657,18 @@ EOF
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
@@ -676,14 +676,14 @@ EOF
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
@@ -736,13 +736,13 @@ test_expect_success 'merge commit gets exported with --import-marks' '
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
index 5ac2c3b5ee..c07175db47 100755
--- a/t/t9351-fast-export-anonymize.sh
+++ b/t/t9351-fast-export-anonymize.sh
@@ -51,7 +51,7 @@ test_expect_success 'stream retains other as refname' '
 '
 
 test_expect_success 'stream omits other refnames' '
-	! grep master stream &&
+	! grep main stream &&
 	! grep mytag stream
 '
 
@@ -85,7 +85,7 @@ test_expect_success 'repo has original shape and timestamps' '
 	shape () {
 		git log --format="%m %ct" --left-right --boundary "$@"
 	} &&
-	(cd .. && shape master...other) >expect &&
+	(cd .. && shape main...other) >expect &&
 	shape $main_branch...$other_branch >actual &&
 	test_cmp expect actual
 '
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 4a46f31c41..9aa49c6906 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -45,7 +45,7 @@ test_expect_success 'setup' '
   touch secondrootfile &&
   git add secondrootfile &&
   git commit -m "second root") &&
-  git fetch secondroot master &&
+  git fetch secondroot main &&
   git merge --allow-unrelated-histories FETCH_HEAD &&
   git clone -q --bare "$WORKDIR/.git" "$SERVERDIR" >/dev/null 2>&1 &&
   GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled true &&
@@ -57,7 +57,7 @@ test_expect_success 'setup' '
 # note that cvs doesn't accept absolute pathnames
 # as argument to co -d
 test_expect_success 'basic checkout' \
-  'GIT_CONFIG="$git_config" cvs -Q co -d cvswork master &&
+  'GIT_CONFIG="$git_config" cvs -Q co -d cvswork main &&
    test "$(echo $(grep -v ^D cvswork/CVS/Entries|cut -d/ -f2,3,5 | head -n 1))" = "empty/1.1/" &&
    test "$(echo $(grep -v ^D cvswork/CVS/Entries|cut -d/ -f2,3,5 | sed -ne \$p))" = "secondrootfile/1.1/"'
 
@@ -226,7 +226,7 @@ GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled true || exit 1
 
 test_expect_success 'gitcvs.enabled = false' \
   'GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled false &&
-   if GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 master >cvs.log 2>&1
+   if GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 main >cvs.log 2>&1
    then
      echo unexpected cvs success
      false
@@ -240,14 +240,14 @@ rm -fr cvswork2
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
@@ -261,21 +261,21 @@ rm -fr cvswork2
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
@@ -457,7 +457,7 @@ cd "$WORKDIR"
 test_expect_success 'cvs update (module list supports packed refs)' '
     GIT_DIR="$SERVERDIR" git pack-refs --all &&
     GIT_CONFIG="$git_config" cvs -n up -d 2> out &&
-    grep "cvs update: New directory \`master'\''" < out
+    grep "cvs update: New directory \`main'\''" < out
 '
 
 #------------
@@ -499,8 +499,8 @@ test_expect_success 'cvs status (no subdirs in header)' '
 cd "$WORKDIR"
 test_expect_success 'cvs co -c (shows module database)' '
     GIT_CONFIG="$git_config" cvs co -c > out &&
-    grep "^master[	 ][ 	]*master$" <out &&
-    ! grep -v "^master[	 ][ 	]*master$" <out
+    grep "^main[	 ][ 	]*main$" <out &&
+    ! grep -v "^main[	 ][ 	]*main$" <out
 '
 
 #------------
@@ -526,7 +526,7 @@ test_expect_success 'cvs co -c (shows module database)' '
 
 sed -e 's/^x//' -e 's/SP$/ /' > "$WORKDIR/expect" <<EOF
 x
-xRCS file: $WORKDIR/gitcvs.git/master/merge,v
+xRCS file: $WORKDIR/gitcvs.git/main/merge,v
 xWorking file: merge
 xhead: 1.4
 xbranch:
diff --git a/t/t9401-git-cvsserver-crlf.sh b/t/t9401-git-cvsserver-crlf.sh
index c7a0dd84a4..8046a25b1f 100755
--- a/t/t9401-git-cvsserver-crlf.sh
+++ b/t/t9401-git-cvsserver-crlf.sh
@@ -105,14 +105,14 @@ test_expect_success 'setup' '
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
@@ -125,7 +125,7 @@ test_expect_success 'cvs co (allbinary)' '
 rm -rf cvswork cvs.log
 test_expect_success 'cvs co (use attributes/allbinary)' '
     GIT_DIR="$SERVERDIR" git config --bool gitcvs.usecrlfattr true &&
-    GIT_CONFIG="$git_config" cvs -Q co -d cvswork master >cvs.log 2>&1 &&
+    GIT_CONFIG="$git_config" cvs -Q co -d cvswork main >cvs.log 2>&1 &&
     marked_as cvswork textfile.c "" &&
     marked_as cvswork binfile.bin -kb &&
     marked_as cvswork .gitattributes -kb &&
@@ -138,7 +138,7 @@ test_expect_success 'cvs co (use attributes/allbinary)' '
 rm -rf cvswork
 test_expect_success 'cvs co (use attributes)' '
     GIT_DIR="$SERVERDIR" git config --bool gitcvs.allbinary false &&
-    GIT_CONFIG="$git_config" cvs -Q co -d cvswork master >cvs.log 2>&1 &&
+    GIT_CONFIG="$git_config" cvs -Q co -d cvswork main >cvs.log 2>&1 &&
     marked_as cvswork textfile.c "" &&
     marked_as cvswork binfile.bin -kb &&
     marked_as cvswork .gitattributes "" &&
@@ -194,7 +194,7 @@ test_expect_success 'updating' '
 rm -rf cvswork
 test_expect_success 'cvs co (use attributes/guess)' '
     GIT_DIR="$SERVERDIR" git config gitcvs.allbinary guess &&
-    GIT_CONFIG="$git_config" cvs -Q co -d cvswork master >cvs.log 2>&1 &&
+    GIT_CONFIG="$git_config" cvs -Q co -d cvswork main >cvs.log 2>&1 &&
     marked_as cvswork textfile.c "" &&
     marked_as cvswork binfile.bin -kb &&
     marked_as cvswork .gitattributes "" &&
@@ -224,7 +224,7 @@ test_expect_success 'setup multi-line files' '
 rm -rf cvswork
 test_expect_success 'cvs co (guess)' '
     GIT_DIR="$SERVERDIR" git config --bool gitcvs.usecrlfattr false &&
-    GIT_CONFIG="$git_config" cvs -Q co -d cvswork master >cvs.log 2>&1 &&
+    GIT_CONFIG="$git_config" cvs -Q co -d cvswork main >cvs.log 2>&1 &&
     marked_as cvswork textfile.c "" &&
     marked_as cvswork binfile.bin -kb &&
     marked_as cvswork .gitattributes "" &&
@@ -239,7 +239,7 @@ test_expect_success 'cvs co (guess)' '
 '
 
 test_expect_success 'cvs co another copy (guess)' '
-    GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 master >cvs.log 2>&1 &&
+    GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 main >cvs.log 2>&1 &&
     marked_as cvswork2 textfile.c "" &&
     marked_as cvswork2 binfile.bin -kb &&
     marked_as cvswork2 .gitattributes "" &&
@@ -335,7 +335,7 @@ test_expect_success 'update subdir of other copy (guess)' '
 
 echo "starting update/merge" >> "${WORKDIR}/marked.log"
 test_expect_success 'update/merge full other copy (guess)' '
-    git pull gitcvs.git master &&
+    git pull gitcvs.git main &&
     sed "s/3/replaced_3/" < multilineTxt.c > ml.temp &&
     mv ml.temp multilineTxt.c &&
     git add multilineTxt.c &&
diff --git a/t/t9402-git-cvsserver-refs.sh b/t/t9402-git-cvsserver-refs.sh
index 6436c91a3c..3b30b02bd1 100755
--- a/t/t9402-git-cvsserver-refs.sh
+++ b/t/t9402-git-cvsserver-refs.sh
@@ -115,7 +115,7 @@ test_expect_success 'setup v1, b1' '
 
 rm -rf cvswork
 test_expect_success 'cvs co v1' '
-	cvs -f -Q co -r v1 -d cvswork master >cvs.log 2>&1 &&
+	cvs -f -Q co -r v1 -d cvswork main >cvs.log 2>&1 &&
 	check_start_tree cvswork &&
 	check_file cvswork textfile.c v1 &&
 	check_file cvswork t2 v1 &&
@@ -128,7 +128,7 @@ test_expect_success 'cvs co v1' '
 
 rm -rf cvswork
 test_expect_success 'cvs co b1' '
-	cvs -f co -r b1 -d cvswork master >cvs.log 2>&1 &&
+	cvs -f co -r b1 -d cvswork main >cvs.log 2>&1 &&
 	check_start_tree cvswork &&
 	check_file cvswork textfile.c v1 &&
 	check_file cvswork t2 v1 &&
@@ -140,7 +140,7 @@ test_expect_success 'cvs co b1' '
 '
 
 test_expect_success 'cvs co b1 [cvswork3]' '
-	cvs -f co -r b1 -d cvswork3 master >cvs.log 2>&1 &&
+	cvs -f co -r b1 -d cvswork3 main >cvs.log 2>&1 &&
 	check_start_tree cvswork3 &&
 	check_file cvswork3 textfile.c v1 &&
 	check_file cvswork3 t2 v1 &&
@@ -265,7 +265,7 @@ test_expect_success 'setup simple b2' '
 '
 
 test_expect_success 'cvs co b2 [into cvswork2]' '
-	cvs -f co -r b2 -d cvswork2 master >cvs.log 2>&1 &&
+	cvs -f co -r b2 -d cvswork2 main >cvs.log 2>&1 &&
 	check_start_tree cvswork &&
 	check_file cvswork textfile.c v1 &&
 	check_file cvswork t2 v1 &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index a63945569f..faad473555 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -263,7 +263,7 @@ case "$TEST_NUMBER" in
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 	;;
-[0-8]*)
+[0-8]*|9[0-4]*)
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 	;;
-- 
gitgitgadget

