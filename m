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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509DBC83008
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E8C1246BC
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlEEbk76"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbgKRXpS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 18:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbgKRXpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 18:45:16 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1103C0613D6
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:45:15 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id s13so4741820wmh.4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RPUtW2AnYszfI7c/DwueJO74QcVocn0b+/JLY9g8430=;
        b=nlEEbk769FyNbnSS7nHUKf7VQzlHefTfsX39mpFb6wX4286B8ZUaipxDtI3Io/zfVp
         x70WVvf4aNEFU+0p/py59ec+blU+Yve+hJ8MmW0lCahmngN9x9ux5+LN3x/BAedIFT+M
         5xo99Fm9FygTaa5wgeIpxp87lLPmRURwpoGZNhnY12BIRtKUBUSosLSDcJL4hBf21F2e
         ok9vtS04lnyv+2LsRL4t9yn4AnO5cpCPf7dMJaURJJc7Hfk8UCOcQKMHi8wEsWM72+U5
         WHAkM/z2HJbkIzt2OOjfWlPgzsuR56vQSmHxDZtg30BM7NIL0fPN/btHFdzSZO12v/eD
         PLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RPUtW2AnYszfI7c/DwueJO74QcVocn0b+/JLY9g8430=;
        b=F2JjfTOpJOxqkzAnFxqNS3Ejg5KZvlIKlKuMAG7XgavnlFCVcp2JAa4MaYEJEV7yU8
         QthyIW4AOFSZx+BanA7vNo6eOEV3FVzxbNpnT3yoy8MaxpwMca4bx2M1opN57F+igrI9
         ia4flN/naKpDrCSr8mkVoj4YKaDd6r1X84JOovRcBfeetcFKYFM9xuJrke/vK18QTLKP
         wMx/3dqPjLH7T8RdCRh09wQSiSeEtGvYoFRxsdKzfTt5vTfoX/1Y+O60GmCw+vzm0UVA
         sL8qPE/RKpuCda03Ed0H59p6xNta9YF2yAKcf6UmNDVshgS9syAE6n8guDlMDEZuzEPU
         ShqA==
X-Gm-Message-State: AOAM530C8iO/2XglSBFecBUOOIjVFBS0bOsp6nqDex4CDhItJPxiinAr
        OV0bRj1Zkb0CV5wPOAzmK7swwjI9+fU=
X-Google-Smtp-Source: ABdhPJzyn1xh91mNLOVv7j7Kn3b+urAC7wqUPjKu05w8VQrdB/4lkwqo+YdIhkBlPG3FmP9d6RTHwg==
X-Received: by 2002:a7b:c92a:: with SMTP id h10mr1517823wml.138.1605743114050;
        Wed, 18 Nov 2020 15:45:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s25sm6153337wmh.16.2020.11.18.15.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 15:45:13 -0800 (PST)
Message-Id: <cda06e253d1c26e25d600b0eb2837e0840b32928.1605743088.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.v3.git.1605743086.gitgitgadget@gmail.com>
References: <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
        <pull.762.v3.git.1605743086.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Nov 2020 23:44:43 +0000
Subject: [PATCH v3 25/28] t9[5-7]*: adjust the references to the default
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
		-e 's/Master/Main/g' -- t9[5-7]*.sh lib-cvs.sh)

This allows us to define `GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main`
for those tests.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/lib-cvs.sh                              |  2 +-
 t/t9500-gitweb-standalone-no-errors.sh    | 22 +++++++++++-----------
 t/t9501-gitweb-standalone-http-status.sh  | 16 ++++++++--------
 t/t9502-gitweb-standalone-parse-output.sh | 18 +++++++++---------
 t/t9600-cvsimport.sh                      |  4 ++--
 t/t9601-cvsimport-vendor-branch.sh        | 18 +++++++++---------
 t/t9602-cvsimport-branches-tags.sh        |  6 +++---
 t/t9603-cvsimport-patchsets.sh            | 10 +++++-----
 8 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/t/lib-cvs.sh b/t/lib-cvs.sh
index 9b2bcfb1b0..32b3473379 100644
--- a/t/lib-cvs.sh
+++ b/t/lib-cvs.sh
@@ -36,7 +36,7 @@ setup_cvs_test_repository () {
 test_cvs_co () {
 	# Usage: test_cvs_co BRANCH_NAME
 	rm -rf module-cvs-"$1"
-	if [ "$1" = "master" ]
+	if [ "$1" = "main" ]
 	then
 		$CVS co -P -d module-cvs-"$1" -A module
 	else
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index fa36bf5e83..ee8c6e30e6 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -10,7 +10,7 @@ commandline, and checks that it would not write any errors
 or warnings to log.'
 
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./gitweb-lib.sh
@@ -330,7 +330,7 @@ test_expect_success \
 	 echo "Branch" >>b &&
 	 git add b &&
 	 git commit -a -m "On branch" &&
-	 git checkout master &&
+	 git checkout main &&
 	 git merge b &&
 	 git tag merge_commit'
 
@@ -367,7 +367,7 @@ test_expect_success \
 	 echo "Changed and have mode changed" >07-change-mode-change &&
 	 test_chmod +x 07-change-mode-change &&
 	 git commit -a -m "Large commit" &&
-	 git checkout master'
+	 git checkout main'
 
 test_expect_success \
 	'commit(1): large commit' \
@@ -405,7 +405,7 @@ test_expect_success 'side-by-side: merge commit' '
 
 test_expect_success \
 	'tags: list of different types of tags' \
-	'git checkout master &&
+	'git checkout main &&
 	 git tag -a -m "Tag commit object" tag-commit HEAD &&
 	 git tag -a -m "" tag-commit-nomessage HEAD &&
 	 git tag -a -m "Tag tag object" tag-tag tag-commit &&
@@ -446,7 +446,7 @@ test_expect_success \
 
 test_expect_success \
 	'logs: history (implicit HEAD, deleted file)' \
-	'git checkout master &&
+	'git checkout main &&
 	 echo "to be deleted" >deleted_file &&
 	 git add deleted_file &&
 	 git commit -m "Add file to be deleted" &&
@@ -466,11 +466,11 @@ test_expect_success \
 
 test_expect_success \
 	'path_info: project/branch:file' \
-	'gitweb_run "" "/.git/master:file"'
+	'gitweb_run "" "/.git/main:file"'
 
 test_expect_success \
 	'path_info: project/branch:dir/' \
-	'gitweb_run "" "/.git/master:foo/"'
+	'gitweb_run "" "/.git/main:foo/"'
 
 test_expect_success \
 	'path_info: project/branch (non-existent)' \
@@ -482,16 +482,16 @@ test_expect_success \
 
 test_expect_success \
 	'path_info: project/branch:file (non-existent)' \
-	'gitweb_run "" "/.git/master:non-existent"'
+	'gitweb_run "" "/.git/main:non-existent"'
 
 test_expect_success \
 	'path_info: project/branch:dir/ (non-existent)' \
-	'gitweb_run "" "/.git/master:non-existent/"'
+	'gitweb_run "" "/.git/main:non-existent/"'
 
 
 test_expect_success \
 	'path_info: project/branch:/file' \
-	'gitweb_run "" "/.git/master:/file"'
+	'gitweb_run "" "/.git/main:/file"'
 
 test_expect_success \
 	'path_info: project/:/file (implicit HEAD)' \
@@ -804,7 +804,7 @@ test_expect_success \
 		git checkout orphan_branch ||
 		git checkout --orphan orphan_branch
 	 } &&
-	 test_when_finished "git checkout master" &&
+	 test_when_finished "git checkout main" &&
 	 gitweb_run "p=.git;a=summary"'
 
 test_done
diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-standalone-http-status.sh
index 6b0adf28d2..141610de54 100755
--- a/t/t9501-gitweb-standalone-http-status.sh
+++ b/t/t9501-gitweb-standalone-http-status.sh
@@ -10,7 +10,7 @@ commandline, and checks that it returns the expected HTTP status
 code and message.'
 
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./gitweb-lib.sh
@@ -88,7 +88,7 @@ test_debug 'cat gitweb.headers'
 # snapshot hash ids
 
 test_expect_success 'snapshots: good tree-ish id' '
-	gitweb_run "p=.git;a=snapshot;h=master;sf=tgz" &&
+	gitweb_run "p=.git;a=snapshot;h=main;sf=tgz" &&
 	grep "Status: 200 OK" gitweb.output
 '
 test_debug 'cat gitweb.headers'
@@ -126,7 +126,7 @@ test_debug 'cat gitweb.output'
 # modification times (Last-Modified and If-Modified-Since)
 
 test_expect_success DATE_PARSER 'modification: feed last-modified' '
-	gitweb_run "p=.git;a=atom;h=master" &&
+	gitweb_run "p=.git;a=atom;h=main" &&
 	grep "Status: 200 OK" gitweb.headers &&
 	grep "Last-modified: Thu, 7 Apr 2005 22:14:13 +0000" gitweb.headers
 '
@@ -136,7 +136,7 @@ test_expect_success DATE_PARSER 'modification: feed if-modified-since (modified)
 	HTTP_IF_MODIFIED_SINCE="Wed, 6 Apr 2005 22:14:13 +0000" &&
 	export HTTP_IF_MODIFIED_SINCE &&
 	test_when_finished "unset HTTP_IF_MODIFIED_SINCE" &&
-	gitweb_run "p=.git;a=atom;h=master" &&
+	gitweb_run "p=.git;a=atom;h=main" &&
 	grep "Status: 200 OK" gitweb.headers
 '
 test_debug 'cat gitweb.headers'
@@ -145,13 +145,13 @@ test_expect_success DATE_PARSER 'modification: feed if-modified-since (unmodifie
 	HTTP_IF_MODIFIED_SINCE="Thu, 7 Apr 2005 22:14:13 +0000" &&
 	export HTTP_IF_MODIFIED_SINCE &&
 	test_when_finished "unset HTTP_IF_MODIFIED_SINCE" &&
-	gitweb_run "p=.git;a=atom;h=master" &&
+	gitweb_run "p=.git;a=atom;h=main" &&
 	grep "Status: 304 Not Modified" gitweb.headers
 '
 test_debug 'cat gitweb.headers'
 
 test_expect_success DATE_PARSER 'modification: snapshot last-modified' '
-	gitweb_run "p=.git;a=snapshot;h=master;sf=tgz" &&
+	gitweb_run "p=.git;a=snapshot;h=main;sf=tgz" &&
 	grep "Status: 200 OK" gitweb.headers &&
 	grep "Last-modified: Thu, 7 Apr 2005 22:14:13 +0000" gitweb.headers
 '
@@ -161,7 +161,7 @@ test_expect_success DATE_PARSER 'modification: snapshot if-modified-since (modif
 	HTTP_IF_MODIFIED_SINCE="Wed, 6 Apr 2005 22:14:13 +0000" &&
 	export HTTP_IF_MODIFIED_SINCE &&
 	test_when_finished "unset HTTP_IF_MODIFIED_SINCE" &&
-	gitweb_run "p=.git;a=snapshot;h=master;sf=tgz" &&
+	gitweb_run "p=.git;a=snapshot;h=main;sf=tgz" &&
 	grep "Status: 200 OK" gitweb.headers
 '
 test_debug 'cat gitweb.headers'
@@ -170,7 +170,7 @@ test_expect_success DATE_PARSER 'modification: snapshot if-modified-since (unmod
 	HTTP_IF_MODIFIED_SINCE="Thu, 7 Apr 2005 22:14:13 +0000" &&
 	export HTTP_IF_MODIFIED_SINCE &&
 	test_when_finished "unset HTTP_IF_MODIFIED_SINCE" &&
-	gitweb_run "p=.git;a=snapshot;h=master;sf=tgz" &&
+	gitweb_run "p=.git;a=snapshot;h=main;sf=tgz" &&
 	grep "Status: 304 Not Modified" gitweb.headers
 '
 test_debug 'cat gitweb.headers'
diff --git a/t/t9502-gitweb-standalone-parse-output.sh b/t/t9502-gitweb-standalone-parse-output.sh
index 76d90eccd8..9cf7ab30a8 100755
--- a/t/t9502-gitweb-standalone-parse-output.sh
+++ b/t/t9502-gitweb-standalone-parse-output.sh
@@ -10,7 +10,7 @@ commandline, and checks that it produces the correct output, either
 in the HTTP header or the actual script output.'
 
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./gitweb-lib.sh
@@ -82,10 +82,10 @@ test_expect_success 'snapshot: HEAD' '
 '
 test_debug 'cat gitweb.headers && cat file_list'
 
-test_expect_success 'snapshot: short branch name (master)' '
-	gitweb_run "p=.git;a=snapshot;h=master;sf=tar" &&
-	ID=$(git rev-parse --verify --short=7 master) &&
-	check_snapshot ".git-master-$ID"
+test_expect_success 'snapshot: short branch name (main)' '
+	gitweb_run "p=.git;a=snapshot;h=main;sf=tar" &&
+	ID=$(git rev-parse --verify --short=7 main) &&
+	check_snapshot ".git-main-$ID"
 '
 test_debug 'cat gitweb.headers && cat file_list'
 
@@ -96,10 +96,10 @@ test_expect_success 'snapshot: short tag name (first)' '
 '
 test_debug 'cat gitweb.headers && cat file_list'
 
-test_expect_success 'snapshot: full branch name (refs/heads/master)' '
-	gitweb_run "p=.git;a=snapshot;h=refs/heads/master;sf=tar" &&
-	ID=$(git rev-parse --verify --short=7 master) &&
-	check_snapshot ".git-master-$ID"
+test_expect_success 'snapshot: full branch name (refs/heads/main)' '
+	gitweb_run "p=.git;a=snapshot;h=refs/heads/main;sf=tar" &&
+	ID=$(git rev-parse --verify --short=7 main) &&
+	check_snapshot ".git-main-$ID"
 '
 test_debug 'cat gitweb.headers && cat file_list'
 
diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
index 9257d664f2..5680849218 100755
--- a/t/t9600-cvsimport.sh
+++ b/t/t9600-cvsimport.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 test_description='git cvsimport basic tests'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./lib-cvs.sh
@@ -162,6 +162,6 @@ test_expect_success PERL 'no .git/cvs-revisions created by default' '
 
 '
 
-test_expect_success PERL 'test entire HEAD' 'test_cmp_branch_tree master'
+test_expect_success PERL 'test entire HEAD' 'test_cmp_branch_tree main'
 
 test_done
diff --git a/t/t9601-cvsimport-vendor-branch.sh b/t/t9601-cvsimport-vendor-branch.sh
index 700c2688d2..116cddba3a 100755
--- a/t/t9601-cvsimport-vendor-branch.sh
+++ b/t/t9601-cvsimport-vendor-branch.sh
@@ -32,7 +32,7 @@
 #       tag has been removed.
 
 test_description='git cvsimport handling of vendor branches'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./lib-cvs.sh
@@ -45,43 +45,43 @@ test_expect_success PERL 'import a module with a vendor branch' '
 
 '
 
-test_expect_success PERL 'check HEAD out of cvs repository' 'test_cvs_co master'
+test_expect_success PERL 'check HEAD out of cvs repository' 'test_cvs_co main'
 
-test_expect_success PERL 'check master out of git repository' 'test_git_co master'
+test_expect_success PERL 'check main out of git repository' 'test_git_co main'
 
 test_expect_success PERL 'check a file that was imported once' '
 
-	test_cmp_branch_file master imported-once.txt
+	test_cmp_branch_file main imported-once.txt
 
 '
 
 test_expect_failure PERL 'check a file that was imported twice' '
 
-	test_cmp_branch_file master imported-twice.txt
+	test_cmp_branch_file main imported-twice.txt
 
 '
 
 test_expect_success PERL 'check a file that was imported then modified on HEAD' '
 
-	test_cmp_branch_file master imported-modified.txt
+	test_cmp_branch_file main imported-modified.txt
 
 '
 
 test_expect_success PERL 'check a file that was imported, modified, then imported again' '
 
-	test_cmp_branch_file master imported-modified-imported.txt
+	test_cmp_branch_file main imported-modified-imported.txt
 
 '
 
 test_expect_success PERL 'check a file that was added to HEAD then imported' '
 
-	test_cmp_branch_file master added-imported.txt
+	test_cmp_branch_file main added-imported.txt
 
 '
 
 test_expect_success PERL 'a vendor branch whose tag has been removed' '
 
-	test_cmp_branch_file master imported-anonymously.txt
+	test_cmp_branch_file main imported-anonymously.txt
 
 '
 
diff --git a/t/t9602-cvsimport-branches-tags.sh b/t/t9602-cvsimport-branches-tags.sh
index 7b1fb36e67..e5266c9a87 100755
--- a/t/t9602-cvsimport-branches-tags.sh
+++ b/t/t9602-cvsimport-branches-tags.sh
@@ -4,7 +4,7 @@
 # t9602/README.
 
 test_description='git cvsimport handling of branches and tags'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./lib-cvs.sh
@@ -17,9 +17,9 @@ test_expect_success PERL 'import module' '
 
 '
 
-test_expect_success PERL 'test branch master' '
+test_expect_success PERL 'test branch main' '
 
-	test_cmp_branch_tree master
+	test_cmp_branch_tree main
 
 '
 
diff --git a/t/t9603-cvsimport-patchsets.sh b/t/t9603-cvsimport-patchsets.sh
index 87cd8c0c6b..0e9daa5768 100755
--- a/t/t9603-cvsimport-patchsets.sh
+++ b/t/t9603-cvsimport-patchsets.sh
@@ -12,7 +12,7 @@
 # bug.
 
 test_description='git cvsimport testing for correct patchset estimation'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./lib-cvs.sh
@@ -23,16 +23,16 @@ test_expect_failure PERL 'import with criss cross times on revisions' '
 	git cvsimport -p"-x" -C module-git module &&
 	(
 		cd module-git &&
-		git log --pretty=format:%s > ../actual-master &&
+		git log --pretty=format:%s > ../actual-main &&
 		git log A~2..A --pretty="format:%s %ad" -- > ../actual-A &&
-		echo "" >> ../actual-master &&
+		echo "" >> ../actual-main &&
 		echo "" >> ../actual-A
 	) &&
 	echo "Rev 4
 Rev 3
 Rev 2
-Rev 1" > expect-master &&
-	test_cmp expect-master actual-master &&
+Rev 1" > expect-main &&
+	test_cmp expect-main actual-main &&
 
 	echo "Rev 5 Branch A Wed Mar 11 19:09:10 2009 +0000
 Rev 4 Branch A Wed Mar 11 19:03:52 2009 +0000" > expect-A &&
-- 
gitgitgadget

