Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132F3C5517A
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 16:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 978B721D47
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 16:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d79G2PE3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751207AbgJWQBa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 12:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374473AbgJWQBa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 12:01:30 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A09C0613CE
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 09:01:28 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id v5so2065667wmh.1
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 09:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+4pzEOn6w6jQ6sdQrGNEWI8FMsBnpvBysrp79Vdxqw8=;
        b=d79G2PE3p+ObjE9ltWnkGkWiTtbCiLDzxqsFYuyGZjq5rQ+yn/+FWGidlc2d/kpTHm
         3ePFjwCx2o4a82ACXsy3+z6Xp2rs4ORiB3ZJpI8pYkS+t+NS5sms0UJPXpdwu7hDWU0D
         H4NEvGesUfEUA0Z5474TDZxlZUbXUPeBgIeiFbvCfBSTHobtGjthgmUGVKzz5qwk8PJf
         Pp97AzEUwq8qElbBHPTYjQgW59ZJcPPriK+jv2A3S6B7+0CcpP1vsbMPIiSFyVn+/ndj
         iHN5o6p0KTivo0LtGTSGfDqf/VZ0usd51o5xR5kHna70GwCk6YlGyjYezCLzKma0pzZ6
         0KzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+4pzEOn6w6jQ6sdQrGNEWI8FMsBnpvBysrp79Vdxqw8=;
        b=k9u2hlOJw5vJVPk2+HjyRHQtoYsUP6Kcm0rudb0kC5D1hPZJ1SfOFWvcI1knR4PyE/
         kjsFioCtPW/md2g7zwLMhib8I7qMQM/3eK9gBW1aZdj9NqCQcGdO3KEM/DCM9+mpnZbC
         kL3wO6FurFrqrQXtnMoUTAAd3Ieupmfz7aUElq5++LdiaemJs3WNqaFtQIAFR18KtvxF
         4C4UpSApHmx0LE8Kdv8U3h6phlTR7WXRqdLciOE/9f/xB6K0YnZ91rZEJ3KOF1HGwtUQ
         3rDT91HkuDMa1cnnK2oI7YS9nGODcjohkkoqbbVq/KmhpchDefC2aNkZXIwMDXArOEp5
         oxDA==
X-Gm-Message-State: AOAM5328MzAu1oxaTT4jc4yv3Ef8sM3HYWayEQFxEYSrWdgOgEMUUo4U
        Vpe9OEyZ/0Vgr9gu1iFSrBXjY6FaLgI=
X-Google-Smtp-Source: ABdhPJyK9Wdk7vazK2U4YjNOh2BWK462vJie4a7lRTszKgnibOMaV0SiBbmbjc8D9CtF4fdcq2lUrQ==
X-Received: by 2002:a1c:9a93:: with SMTP id c141mr3242089wme.168.1603468887084;
        Fri, 23 Oct 2020 09:01:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s2sm4526114wmf.45.2020.10.23.09.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 09:01:26 -0700 (PDT)
Message-Id: <a8d4825a323d5c1e7b2dc1edc8621c51c030ae1e.1603468885.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.769.git.1603468885.gitgitgadget@gmail.com>
References: <pull.769.git.1603468885.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Oct 2020 16:01:16 +0000
Subject: [PATCH 1/9] t/: new helper for tests that pass with ort but fail with
 recursive
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
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
 t/lib-merge.sh                         | 15 +++++++++++++++
 t/t6416-recursive-corner-cases.sh      | 11 ++++++-----
 t/t6422-merge-rename-corner-cases.sh   |  7 ++++---
 t/t6423-merge-rename-directories.sh    | 13 +++++++------
 t/t6426-merge-skip-unneeded-updates.sh |  3 ++-
 t/t6430-merge-recursive.sh             |  3 ++-
 6 files changed, 36 insertions(+), 16 deletions(-)
 create mode 100644 t/lib-merge.sh

diff --git a/t/lib-merge.sh b/t/lib-merge.sh
new file mode 100644
index 0000000000..fac2bc5919
--- /dev/null
+++ b/t/lib-merge.sh
@@ -0,0 +1,15 @@
+# Helper functions used by merge tests.
+
+test_expect_merge_algorithm () {
+	status_for_recursive=$1
+	shift
+	status_for_ort=$1
+	shift
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

