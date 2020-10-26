Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58D5C4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 17:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72C53206D4
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 17:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jo5LRL2m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1787110AbgJZRC6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 13:02:58 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:42453 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1775563AbgJZRBu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 13:01:50 -0400
Received: by mail-wr1-f45.google.com with SMTP id j7so13457915wrt.9
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 10:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IbldBUddQMWoaIEhgGq+1MyKNKDj1MRvtrCVJEMMQOo=;
        b=jo5LRL2mCB8bvNi3jzPAWewCzF0GROKgHsb3NOv9sdTeO5NsOtPnsyH6K9c9vr0W0B
         VhGS50H4UbSX9OLNf7CI8jH66f1Ms2jXbs1jZCjZiUHUn4g1FY9wB/dQBAwUiGVescJF
         ptJzpwkPITGIVesE03ZiHm1d5J8Z2iUHlitOq3jlvHpx4eNV/a3kp4GBooJAEdTknxD4
         djzy+WaPJtaBNZzLB3aRFPQzAraPOy9EOehJsFYS2gCigC8sNnRYupd+5ThYHKSQTTa8
         PYHAXf/Rt4aFjcb15qpeoJKHd1lP8ZInoNPIqL0HBfXjTk4j8I4wumFgJigHNt5dGrvr
         LBGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IbldBUddQMWoaIEhgGq+1MyKNKDj1MRvtrCVJEMMQOo=;
        b=lviaQzxXXn883sJb7ATA6r+6bYREPk7mHfsDQDFLlhb/2Yw5tiGbidwZjBmCoDSPGQ
         aAlb7qg4lcMdsOp0HFrkTndGbjc28Lra+8D/dgbf0vgej3VfpC3fgyMenWAOPlbv5ycm
         neu+d8sJRPNbilycu9obwKe4WbH7EhB2wBJCSFYZ3V2XoF6H2yqkGOAXJ71gfnz9Mw8S
         ZECbJG58URewCKvT7lTJQufoig3fxROtu6n66nUH4+laGOeyqV85viuVwUCDPqJoK8nl
         AKamrpURWxt1tvWr0qXYSGoOmEDOSfTUPlFzuFyoclOHfNEz2YBMmrYkb20r+Do3J6lE
         b5LA==
X-Gm-Message-State: AOAM533sg4irzwJKYCQPmdBdWiwxwtmGdjIXep9G7QVaeB3lO+OKPaoI
        nisN5X6MqVUSws/YAJWYPCzh1OBL8io=
X-Google-Smtp-Source: ABdhPJy4iImEgQ4k+F24BzOsR4GlpKG5uf9CvJECA7RwA9vqvn4EXHnMqFn0fhyv5SqTkcfvFRpagg==
X-Received: by 2002:adf:fe81:: with SMTP id l1mr18779275wrr.11.1603731706781;
        Mon, 26 Oct 2020 10:01:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n62sm23544842wmb.10.2020.10.26.10.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 10:01:46 -0700 (PDT)
Message-Id: <f5d32952629e58074032e5c736b7f0405d935f5d.1603731704.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.769.v2.git.1603731704.gitgitgadget@gmail.com>
References: <pull.769.git.1603468885.gitgitgadget@gmail.com>
        <pull.769.v2.git.1603731704.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Oct 2020 17:01:36 +0000
Subject: [PATCH v2 1/9] t/: new helper for tests that pass with ort but fail
 with recursive
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

There are a number of tests that the "recursive" backend does not handle
correctly but which the redesign in "ort" will.  Add a new helper in
lib-merge.sh for selecting a different test expectation based on the
setting of GIT_TEST_MERGE_ALGORITHM, and use it in various testcases to
document which ones we expect to fail under recursive but pass under
ort.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/lib-merge.sh                         | 13 +++++++++++++
 t/t6416-recursive-corner-cases.sh      | 11 ++++++-----
 t/t6422-merge-rename-corner-cases.sh   |  7 ++++---
 t/t6423-merge-rename-directories.sh    | 13 +++++++------
 t/t6426-merge-skip-unneeded-updates.sh |  3 ++-
 t/t6430-merge-recursive.sh             |  3 ++-
 6 files changed, 34 insertions(+), 16 deletions(-)
 create mode 100644 t/lib-merge.sh

diff --git a/t/lib-merge.sh b/t/lib-merge.sh
new file mode 100644
index 0000000000..8734ebfc17
--- /dev/null
+++ b/t/lib-merge.sh
@@ -0,0 +1,13 @@
+# Helper functions used by merge tests.
+
+test_expect_merge_algorithm () {
+	status_for_recursive=$1 status_for_ort=$2
+	shift 2
+
+	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+	then
+		test_expect_${status_for_ort} "$@"
+	else
+		test_expect_${status_for_recursive} "$@"
+	fi
+}
diff --git a/t/t6416-recursive-corner-cases.sh b/t/t6416-recursive-corner-cases.sh
index fd98989b14..8b3a4fc843 100755
--- a/t/t6416-recursive-corner-cases.sh
+++ b/t/t6416-recursive-corner-cases.sh
@@ -3,6 +3,7 @@
 test_description='recursive merge corner cases involving criss-cross merges'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-merge.sh
 
 #
 #  L1  L2
@@ -1069,7 +1070,7 @@ test_expect_success 'setup symlink modify/modify' '
 	)
 '
 
-test_expect_failure 'check symlink modify/modify' '
+test_expect_merge_algorithm failure success 'check symlink modify/modify' '
 	(
 		cd symlink-modify-modify &&
 
@@ -1135,7 +1136,7 @@ test_expect_success 'setup symlink add/add' '
 	)
 '
 
-test_expect_failure 'check symlink add/add' '
+test_expect_merge_algorithm failure success 'check symlink add/add' '
 	(
 		cd symlink-add-add &&
 
@@ -1223,7 +1224,7 @@ test_expect_success 'setup submodule modify/modify' '
 	)
 '
 
-test_expect_failure 'check submodule modify/modify' '
+test_expect_merge_algorithm failure success 'check submodule modify/modify' '
 	(
 		cd submodule-modify-modify &&
 
@@ -1311,7 +1312,7 @@ test_expect_success 'setup submodule add/add' '
 	)
 '
 
-test_expect_failure 'check submodule add/add' '
+test_expect_merge_algorithm failure success 'check submodule add/add' '
 	(
 		cd submodule-add-add &&
 
@@ -1386,7 +1387,7 @@ test_expect_success 'setup conflicting entry types (submodule vs symlink)' '
 	)
 '
 
-test_expect_failure 'check conflicting entry types (submodule vs symlink)' '
+test_expect_merge_algorithm failure success 'check conflicting entry types (submodule vs symlink)' '
 	(
 		cd submodule-symlink-add-add &&
 
diff --git a/t/t6422-merge-rename-corner-cases.sh b/t/t6422-merge-rename-corner-cases.sh
index 3375eaf4e7..58729593ba 100755
--- a/t/t6422-merge-rename-corner-cases.sh
+++ b/t/t6422-merge-rename-corner-cases.sh
@@ -4,6 +4,7 @@ test_description="recursive merge corner cases w/ renames but not criss-crosses"
 # t6036 has corner cases that involve both criss-cross merges and renames
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-merge.sh
 
 test_setup_rename_delete_untracked () {
 	test_create_repo rename-delete-untracked &&
@@ -878,7 +879,7 @@ test_setup_rad () {
 	)
 }
 
-test_expect_failure 'rad-check: rename/add/delete conflict' '
+test_expect_merge_algorithm failure success 'rad-check: rename/add/delete conflict' '
 	test_setup_rad &&
 	(
 		cd rad &&
@@ -951,7 +952,7 @@ test_setup_rrdd () {
 	)
 }
 
-test_expect_failure 'rrdd-check: rename/rename(2to1)/delete/delete conflict' '
+test_expect_merge_algorithm failure success 'rrdd-check: rename/rename(2to1)/delete/delete conflict' '
 	test_setup_rrdd &&
 	(
 		cd rrdd &&
@@ -1040,7 +1041,7 @@ test_setup_mod6 () {
 	)
 }
 
-test_expect_failure 'mod6-check: chains of rename/rename(1to2) and rename/rename(2to1)' '
+test_expect_merge_algorithm failure success 'mod6-check: chains of rename/rename(1to2) and rename/rename(2to1)' '
 	test_setup_mod6 &&
 	(
 		cd mod6 &&
diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 06b46af765..807a424a52 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -26,6 +26,7 @@ test_description="recursive merge with directory renames"
 #                     files that might be renamed into each other's paths.)
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-merge.sh
 
 
 ###########################################################################
@@ -1339,7 +1340,7 @@ test_setup_6b1 () {
 	)
 }
 
-test_expect_failure '6b1: Same renames done on both sides, plus another rename' '
+test_expect_merge_algorithm failure success '6b1: Same renames done on both sides, plus another rename' '
 	test_setup_6b1 &&
 	(
 		cd 6b1 &&
@@ -1412,7 +1413,7 @@ test_setup_6b2 () {
 	)
 }
 
-test_expect_failure '6b2: Same rename done on both sides' '
+test_expect_merge_algorithm failure success '6b2: Same rename done on both sides' '
 	test_setup_6b2 &&
 	(
 		cd 6b2 &&
@@ -3471,7 +3472,7 @@ test_setup_10e () {
 	)
 }
 
-test_expect_failure '10e: Does git complain about untracked file that is not really in the way?' '
+test_expect_merge_algorithm failure success '10e: Does git complain about untracked file that is not really in the way?' '
 	test_setup_10e &&
 	(
 		cd 10e &&
@@ -4104,7 +4105,7 @@ test_setup_12b1 () {
 	)
 }
 
-test_expect_failure '12b1: Moving two directory hierarchies into each other' '
+test_expect_merge_algorithm failure success '12b1: Moving two directory hierarchies into each other' '
 	test_setup_12b1 &&
 	(
 		cd 12b1 &&
@@ -4272,7 +4273,7 @@ test_setup_12c1 () {
 	)
 }
 
-test_expect_failure '12c1: Moving one directory hierarchy into another w/ content merge' '
+test_expect_merge_algorithm failure success '12c1: Moving one directory hierarchy into another w/ content merge' '
 	test_setup_12c1 &&
 	(
 		cd 12c1 &&
@@ -4632,7 +4633,7 @@ test_setup_12f () {
 	)
 }
 
-test_expect_failure '12f: Trivial directory resolve, caching, all kinds of fun' '
+test_expect_merge_algorithm failure success '12f: Trivial directory resolve, caching, all kinds of fun' '
 	test_setup_12f &&
 	(
 		cd 12f &&
diff --git a/t/t6426-merge-skip-unneeded-updates.sh b/t/t6426-merge-skip-unneeded-updates.sh
index 699813671c..d7eeee4310 100755
--- a/t/t6426-merge-skip-unneeded-updates.sh
+++ b/t/t6426-merge-skip-unneeded-updates.sh
@@ -23,6 +23,7 @@ test_description="merge cases"
 #                     files that might be renamed into each other's paths.)
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-merge.sh
 
 
 ###########################################################################
@@ -666,7 +667,7 @@ test_setup_4a () {
 #   correct requires doing the merge in-memory first, then realizing that no
 #   updates to the file are necessary, and thus that we can just leave the path
 #   alone.
-test_expect_failure '4a: Change on A, change on B subset of A, dirty mods present' '
+test_expect_merge_algorithm failure success '4a: Change on A, change on B subset of A, dirty mods present' '
 	test_setup_4a &&
 	(
 		cd 4a &&
diff --git a/t/t6430-merge-recursive.sh b/t/t6430-merge-recursive.sh
index a328260d42..9c08e63af2 100755
--- a/t/t6430-merge-recursive.sh
+++ b/t/t6430-merge-recursive.sh
@@ -3,6 +3,7 @@
 test_description='merge-recursive backend test'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-merge.sh
 
 test_expect_success 'setup 1' '
 
@@ -641,7 +642,7 @@ test_expect_success 'merge-recursive copy vs. rename' '
 	test_cmp expected actual
 '
 
-test_expect_failure 'merge-recursive rename vs. rename/symlink' '
+test_expect_merge_algorithm failure success 'merge-recursive rename vs. rename/symlink' '
 
 	git checkout -f rename &&
 	git merge rename-ln &&
-- 
gitgitgadget

