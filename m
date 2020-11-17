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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E120C2D0E4
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 16:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9E9224655
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 16:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vd4H6Rdj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbgKQQM4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 11:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbgKQQMz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 11:12:55 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C26EC061A49
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 08:12:53 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id h2so3803777wmm.0
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 08:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ikbcixqQJqZDPoU8tWFoU/b97Yy1hwf0Ymi32Psb8Fg=;
        b=vd4H6Rdj0RM0vbcsJ3iCNHt1FefjcWjL3/p6qNhFRhruBXu4kBBAbGSmL1++I89nDw
         qsLRwRQe5MQulovJfbODs2O+jTqZeEPGMzgs12l5td208qDlBp3Lm8edBWi8TgFLsDxl
         Js0d4Af8/dpHDlSSI0guZlUe8cpivSma9JHAlZ4d3nf69tk7Cn0JnQ4cMqj9nGLdHe2e
         0126mgTI3Mapei7Xz4qyDocvxxmOVvaaIoSrWqefQ4qEJcaL2iWeLV4XFcpcNA/gehoN
         u4uH5dwT+TZb9DJrG70JiFQQKGFGm43E2AsGSa+1CTIXHujAmLSr72braaEy8ha1EgPb
         yu8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ikbcixqQJqZDPoU8tWFoU/b97Yy1hwf0Ymi32Psb8Fg=;
        b=Fo41MTAc1ltn2z4pB70QkN0ksLrpNl9jeFL5NE2Lds9W+AajhZhx/7a37xwqkikirR
         +ouPmyaAo5C+CMAQ03tbQvUYrRR8bczKO9a+6E464YcBqD53/4MhZBb+nmfOW4MfodAn
         I1Kp+vsAXvvvwaqnP52AgzJM6NmHmPVjtOB2KetFB9DxmyIncka+qBSTGQjexiTZqAW5
         qGc4pmQdf6GbIJo3YUPv1PJlnxI6VgPmzPRoJhIrbY/TTKvsqXMQJRIPytbk/6cpRuK3
         sGMvpr9z2w9O+v7AiTip1Pg0Y3e8FtHYMS1wSGd64zNqIB8kxfGjFoOEz9JQXUj26p9M
         XxJQ==
X-Gm-Message-State: AOAM5324u7rbJgygydG17tgVjqTE2+0KdbcMi//9hB6z7HPjeza4R1xb
        koUA/MHwkEigrXUqdZISCGGT9Y6rv5E=
X-Google-Smtp-Source: ABdhPJwzi7fWlsQvPW2qJMXz6NrO6bmA38afE5oDdO+74V1csDY1zo3ZhmcXgqNwuPt31sTwiYBaCw==
X-Received: by 2002:a1c:7fd7:: with SMTP id a206mr387204wmd.135.1605629572049;
        Tue, 17 Nov 2020 08:12:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k81sm159657wma.2.2020.11.17.08.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 08:12:51 -0800 (PST)
Message-Id: <f9e01de17fc4cd3004c0669d103f8d6a261cf0de.1605629549.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
        <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Nov 2020 16:12:24 +0000
Subject: [PATCH v2 24/27] t9[5-7]*: adjust the references to the default
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
index faad473555..58267802f9 100644
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

