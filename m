Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F3BC388F7
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4E4B20825
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcLWDc72"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbgKLWoX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 17:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbgKLWoV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 17:44:21 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C16C0613D4
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:44:21 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id a3so6828125wmb.5
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=d665QlM/ioo7nm3IqPfh22/ohr6c3R8bW+95bR8w9WA=;
        b=dcLWDc72m2JlSsR1udDk760DNAJcRMwze0Uq0fpJiFOnYOLwBIDFEQu1tm2atug0DT
         3tMhZNIsfJoEXtD1zOnM0GsK6N9oThEpeKTj2Mw93nl9dcPLd+v291expmRfto2uTdcS
         5M8yfPweDoXv2/X+ISdvvsRDLxZG1RWAszvmV73tj+ZLhiO3SxfU6EZtRG/LsgA7Yy0K
         mHE8+aoYG4bzw/0f+qGs3J5XofKnO2lpUHlp3D2I31g6zAXtba5w67xawQNEWHuz5QVY
         VZA806NCvW07H1DE/4Yx6OsH35Xsd7MPgOlJ4FxhhzLtvmViKudjmOgL6Y866HCYZ9uy
         Ap7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=d665QlM/ioo7nm3IqPfh22/ohr6c3R8bW+95bR8w9WA=;
        b=Nh4GSsCawuuEIj3EkwbCZjW5jkneGWDlcKmaEZhfWcPgFLB9/jfEyUCZGR8dZ3N9Bl
         I7Cd/zlzZxLYJ7IAATtoLxI9zhgzo1i4NbK4BKE8zUoBGn77jgsLpEu3P0gT7eKfAios
         ych8c/Urf9Cb1J2gsM1iuRdijhHsG3dUmhQD9QGVJbQ9MrJXG7GziOzcrqoElubL3x/u
         s/Ec53Kuu0JWoNIpTp8/nBBpMPbSOauISNvhM3BXTMt2T6mnspXUKcNcgYmEMmW3cFtn
         xoC4O8nq4oR19UlrERZEjutya/cCHxQus8ai7GgKkhP2Yu/4gXTwFGfW3d/lhbTqgQDY
         Fq2g==
X-Gm-Message-State: AOAM532c0SJt6UUgLNUUh6amMeFC8xeH1oRf/3YKl/che6yCwf2XviK5
        /jtxZloUNrUETBPAxQKQG+y3UvTJVqQ=
X-Google-Smtp-Source: ABdhPJxH92ORnH3mwdXQH1S39v1wPiAxkJ1fGdboDtGKVhB1wtsZCT9kH5+BYHMgFahTayQQAw+wgw==
X-Received: by 2002:a1c:56c4:: with SMTP id k187mr77234wmb.92.1605221059782;
        Thu, 12 Nov 2020 14:44:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t13sm8901263wru.67.2020.11.12.14.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 14:44:19 -0800 (PST)
Message-Id: <2367a322c8405a752984d1e150bd25c61259a459.1605221039.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.git.1605221038.gitgitgadget@gmail.com>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Nov 2020 22:43:54 +0000
Subject: [PATCH 24/28] t9[5-7]*: adjust the references to the default branch
 name "main"
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

This trick was performed via

	$ (cd t &&
	   sed -i -e 's/master/main/g' -e 's/MASTER/MAIN/g' \
		-e 's/Master/Main/g' -- t9[5-7]*.sh lib-cvs.sh)

This allows us to define `GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main`
for those tests.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/lib-cvs.sh                              |  2 +-
 t/t9500-gitweb-standalone-no-errors.sh    | 20 ++++++++++----------
 t/t9501-gitweb-standalone-http-status.sh  | 14 +++++++-------
 t/t9502-gitweb-standalone-parse-output.sh | 16 ++++++++--------
 t/t9600-cvsimport.sh                      |  2 +-
 t/t9601-cvsimport-vendor-branch.sh        | 16 ++++++++--------
 t/t9602-cvsimport-branches-tags.sh        |  4 ++--
 t/t9603-cvsimport-patchsets.sh            |  8 ++++----
 t/test-lib.sh                             |  2 +-
 9 files changed, 42 insertions(+), 42 deletions(-)

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
index b484e3e250..452470ff3b 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -327,7 +327,7 @@ test_expect_success \
 	 echo "Branch" >>b &&
 	 git add b &&
 	 git commit -a -m "On branch" &&
-	 git checkout master &&
+	 git checkout main &&
 	 git merge b &&
 	 git tag merge_commit'
 
@@ -364,7 +364,7 @@ test_expect_success \
 	 echo "Changed and have mode changed" >07-change-mode-change &&
 	 test_chmod +x 07-change-mode-change &&
 	 git commit -a -m "Large commit" &&
-	 git checkout master'
+	 git checkout main'
 
 test_expect_success \
 	'commit(1): large commit' \
@@ -402,7 +402,7 @@ test_expect_success 'side-by-side: merge commit' '
 
 test_expect_success \
 	'tags: list of different types of tags' \
-	'git checkout master &&
+	'git checkout main &&
 	 git tag -a -m "Tag commit object" tag-commit HEAD &&
 	 git tag -a -m "" tag-commit-nomessage HEAD &&
 	 git tag -a -m "Tag tag object" tag-tag tag-commit &&
@@ -443,7 +443,7 @@ test_expect_success \
 
 test_expect_success \
 	'logs: history (implicit HEAD, deleted file)' \
-	'git checkout master &&
+	'git checkout main &&
 	 echo "to be deleted" >deleted_file &&
 	 git add deleted_file &&
 	 git commit -m "Add file to be deleted" &&
@@ -463,11 +463,11 @@ test_expect_success \
 
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
@@ -479,16 +479,16 @@ test_expect_success \
 
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
@@ -801,7 +801,7 @@ test_expect_success \
 		git checkout orphan_branch ||
 		git checkout --orphan orphan_branch
 	 } &&
-	 test_when_finished "git checkout master" &&
+	 test_when_finished "git checkout main" &&
 	 gitweb_run "p=.git;a=summary"'
 
 test_done
diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-standalone-http-status.sh
index 2a0ffed870..16f98ab54e 100755
--- a/t/t9501-gitweb-standalone-http-status.sh
+++ b/t/t9501-gitweb-standalone-http-status.sh
@@ -85,7 +85,7 @@ test_debug 'cat gitweb.headers'
 # snapshot hash ids
 
 test_expect_success 'snapshots: good tree-ish id' '
-	gitweb_run "p=.git;a=snapshot;h=master;sf=tgz" &&
+	gitweb_run "p=.git;a=snapshot;h=main;sf=tgz" &&
 	grep "Status: 200 OK" gitweb.output
 '
 test_debug 'cat gitweb.headers'
@@ -123,7 +123,7 @@ test_debug 'cat gitweb.output'
 # modification times (Last-Modified and If-Modified-Since)
 
 test_expect_success DATE_PARSER 'modification: feed last-modified' '
-	gitweb_run "p=.git;a=atom;h=master" &&
+	gitweb_run "p=.git;a=atom;h=main" &&
 	grep "Status: 200 OK" gitweb.headers &&
 	grep "Last-modified: Thu, 7 Apr 2005 22:14:13 +0000" gitweb.headers
 '
@@ -133,7 +133,7 @@ test_expect_success DATE_PARSER 'modification: feed if-modified-since (modified)
 	HTTP_IF_MODIFIED_SINCE="Wed, 6 Apr 2005 22:14:13 +0000" &&
 	export HTTP_IF_MODIFIED_SINCE &&
 	test_when_finished "unset HTTP_IF_MODIFIED_SINCE" &&
-	gitweb_run "p=.git;a=atom;h=master" &&
+	gitweb_run "p=.git;a=atom;h=main" &&
 	grep "Status: 200 OK" gitweb.headers
 '
 test_debug 'cat gitweb.headers'
@@ -142,13 +142,13 @@ test_expect_success DATE_PARSER 'modification: feed if-modified-since (unmodifie
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
@@ -158,7 +158,7 @@ test_expect_success DATE_PARSER 'modification: snapshot if-modified-since (modif
 	HTTP_IF_MODIFIED_SINCE="Wed, 6 Apr 2005 22:14:13 +0000" &&
 	export HTTP_IF_MODIFIED_SINCE &&
 	test_when_finished "unset HTTP_IF_MODIFIED_SINCE" &&
-	gitweb_run "p=.git;a=snapshot;h=master;sf=tgz" &&
+	gitweb_run "p=.git;a=snapshot;h=main;sf=tgz" &&
 	grep "Status: 200 OK" gitweb.headers
 '
 test_debug 'cat gitweb.headers'
@@ -167,7 +167,7 @@ test_expect_success DATE_PARSER 'modification: snapshot if-modified-since (unmod
 	HTTP_IF_MODIFIED_SINCE="Thu, 7 Apr 2005 22:14:13 +0000" &&
 	export HTTP_IF_MODIFIED_SINCE &&
 	test_when_finished "unset HTTP_IF_MODIFIED_SINCE" &&
-	gitweb_run "p=.git;a=snapshot;h=master;sf=tgz" &&
+	gitweb_run "p=.git;a=snapshot;h=main;sf=tgz" &&
 	grep "Status: 304 Not Modified" gitweb.headers
 '
 test_debug 'cat gitweb.headers'
diff --git a/t/t9502-gitweb-standalone-parse-output.sh b/t/t9502-gitweb-standalone-parse-output.sh
index e38cbc97d3..d0cfff9fdd 100755
--- a/t/t9502-gitweb-standalone-parse-output.sh
+++ b/t/t9502-gitweb-standalone-parse-output.sh
@@ -79,10 +79,10 @@ test_expect_success 'snapshot: HEAD' '
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
 
@@ -93,10 +93,10 @@ test_expect_success 'snapshot: short tag name (first)' '
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
index 251fdd66c4..0c8e02c2b3 100755
--- a/t/t9600-cvsimport.sh
+++ b/t/t9600-cvsimport.sh
@@ -159,6 +159,6 @@ test_expect_success PERL 'no .git/cvs-revisions created by default' '
 
 '
 
-test_expect_success PERL 'test entire HEAD' 'test_cmp_branch_tree master'
+test_expect_success PERL 'test entire HEAD' 'test_cmp_branch_tree main'
 
 test_done
diff --git a/t/t9601-cvsimport-vendor-branch.sh b/t/t9601-cvsimport-vendor-branch.sh
index 827d39f5bf..1e89f936e8 100755
--- a/t/t9601-cvsimport-vendor-branch.sh
+++ b/t/t9601-cvsimport-vendor-branch.sh
@@ -42,43 +42,43 @@ test_expect_success PERL 'import a module with a vendor branch' '
 
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
index e1db323f54..fa3c1ae133 100755
--- a/t/t9602-cvsimport-branches-tags.sh
+++ b/t/t9602-cvsimport-branches-tags.sh
@@ -14,9 +14,9 @@ test_expect_success PERL 'import module' '
 
 '
 
-test_expect_success PERL 'test branch master' '
+test_expect_success PERL 'test branch main' '
 
-	test_cmp_branch_tree master
+	test_cmp_branch_tree main
 
 '
 
diff --git a/t/t9603-cvsimport-patchsets.sh b/t/t9603-cvsimport-patchsets.sh
index e7a91611dc..19f38f78f2 100755
--- a/t/t9603-cvsimport-patchsets.sh
+++ b/t/t9603-cvsimport-patchsets.sh
@@ -20,16 +20,16 @@ test_expect_failure PERL 'import with criss cross times on revisions' '
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
diff --git a/t/test-lib.sh b/t/test-lib.sh
index a2b539aa30..803b9c2a58 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -263,7 +263,7 @@ case "$TEST_NUMBER" in
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 	;;
-[0-8]*|9[0-4]*)
+[0-8]*|9[0-7]*)
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 	;;
-- 
gitgitgadget

