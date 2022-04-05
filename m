Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998E1C433F5
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 05:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiDEFWn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 01:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiDEFWd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 01:22:33 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1313E4E
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 22:20:35 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id p8so11053836pfh.8
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 22:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LEzrA526wMAVL92ftTFjSs9PlHH1W0+6z9Sujm2u0ro=;
        b=k98loBDMBAnX5hxBym81pxXOpRc1+10stP7ce4F0XgxcQWrN94BK9InWoK/m2O/ZHR
         kBW2OrN92hJCuN0+nUGzvWvd1wwN3BJN4+aXohaqUlxcBPwWh0vRn57BbxD0qGnT6PeH
         2efY3AxS9iDgx0jmz0vuGfZKd7TVyO7xWnuLZ3P0sX+bUzBt5IhO7GeBoBUx8ceQTTPD
         CTdhex9ozzTRTmiYuMQKekeaNicT+8G5YxT1jGBMAn8h4YcYAO93rtevZZqt+yraDBzj
         Vmwd4L3iQQVDIWSxpaHES9snV+rBZReUwDhTYqbytgjPHQrIXcXlUsS90WHnsBU3aIw7
         hAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LEzrA526wMAVL92ftTFjSs9PlHH1W0+6z9Sujm2u0ro=;
        b=X3bDXxifxFzIEvyml49xZNcHLQycsl19cDW3PEJmCpi3IlxOnUpbGZ8djs/ViyZYYi
         GuOL5W1LEgxGO4h16XrFfmjH9Zkg+BYGWRN+P2pw5+4gBB5KQPcckitoFu55Qyrven0e
         MZN0D1azevGuw/xU/lCp7Yn9sVqoHqfxGBE4BJcOg4jq6Z/jqktYXgTqB9tqOxRZeSwZ
         xpHZcrSbCmgkEyfTVUVI+jt1kTObU+4uSp0SvZDNtwbIk4dA9x+/uV4crI6OIeuQKjdR
         b8ADCmiLn+tGtNT4tsjdFbnt7OzKvlV6kfvQUjN549+v7PVDYigomUxJf4IEB0UFfYLU
         y3Iw==
X-Gm-Message-State: AOAM531zGGCxC6uvpRluYXv7x9tzVdDLp5mrsrHyFuN9ohqxYLjorLIC
        MzMydE93W13P/6GXq90zTdI=
X-Google-Smtp-Source: ABdhPJzUZCvWdjGkyFbajKO/jUek+abbMHUyhNrtai7srQqK+WDPODXrpHEJ99xb2mHgZRGnIKDE4w==
X-Received: by 2002:a65:6e9a:0:b0:382:1804:35c8 with SMTP id bm26-20020a656e9a000000b00382180435c8mr1466421pgb.584.1649136035373;
        Mon, 04 Apr 2022 22:20:35 -0700 (PDT)
Received: from neerajsi-x1.localdomain (c-24-56-226-231.customer.broadstripe.net. [24.56.226.231])
        by smtp.gmail.com with ESMTPSA id g3-20020a17090a708300b001c7e8ae7637sm808859pjk.8.2022.04.04.22.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 22:20:34 -0700 (PDT)
From:   nksingh85@gmail.com
X-Google-Original-From: neerajsi@microsoft.com
To:     gitgitgadget@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, bagasdotme@gmail.com,
        git@vger.kernel.org, jeffhost@microsoft.com,
        neerajsi@microsoft.com, nksingh85@gmail.com, ps@pks.im,
        worldhello.net@gmail.com
Subject: [PATCH v6 10/12] core.fsyncmethod: tests for batch mode
Date:   Mon,  4 Apr 2022 22:20:16 -0700
Message-Id: <20220405052018.11247-11-neerajsi@microsoft.com>
X-Mailer: git-send-email 2.34.1.78.g86e39b8f8d
In-Reply-To: <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
References: <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

Add test cases to exercise batch mode for:
 * 'git add'
 * 'git stash'
 * 'git update-index'
 * 'git unpack-objects'

These tests ensure that the added data winds up in the object database.

In this change we introduce a new test helper lib-unique-files.sh. The
goal of this library is to create a tree of files that have different
oids from any other files that may have been created in the current test
repo. This helps us avoid missing validation of an object being added
due to it already being in the repo.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 t/lib-unique-files.sh  | 34 ++++++++++++++++++++++++++++++++++
 t/t3700-add.sh         | 28 ++++++++++++++++++++++++++++
 t/t3903-stash.sh       | 20 ++++++++++++++++++++
 t/t5300-pack-object.sh | 41 +++++++++++++++++++++++++++--------------
 4 files changed, 109 insertions(+), 14 deletions(-)
 create mode 100644 t/lib-unique-files.sh

diff --git a/t/lib-unique-files.sh b/t/lib-unique-files.sh
new file mode 100644
index 00000000000..a14080fe79b
--- /dev/null
+++ b/t/lib-unique-files.sh
@@ -0,0 +1,34 @@
+# Helper to create files with unique contents
+
+# Create multiple files with unique contents within this test run. Takes the
+# number of directories, the number of files in each directory, and the base
+# directory.
+#
+# test_create_unique_files 2 3 my_dir -- Creates 2 directories with 3 files
+#					 each in my_dir, all with contents
+#					 different from previous invocations
+#					 of this command in this run.
+
+test_create_unique_files () {
+	test "$#" -ne 3 && BUG "3 param"
+
+	local dirs="$1" &&
+	local files="$2" &&
+	local basedir="$3" &&
+	local counter="0" &&
+	local i &&
+	local j &&
+	test_tick &&
+	local basedata="$basedir$test_tick" &&
+	rm -rf "$basedir" &&
+	for i in $(test_seq $dirs)
+	do
+		local dir="$basedir/dir$i" &&
+		mkdir -p "$dir" &&
+		for j in $(test_seq $files)
+		do
+			counter=$((counter + 1)) &&
+			echo "$basedata.$counter">"$dir/file$j.txt"
+		done
+	done
+}
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index b1f90ba3250..8979c8a5f03 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -8,6 +8,8 @@ test_description='Test of git add, including the -- option.'
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
+. $TEST_DIRECTORY/lib-unique-files.sh
+
 # Test the file mode "$1" of the file "$2" in the index.
 test_mode_in_index () {
 	case "$(git ls-files -s "$2")" in
@@ -34,6 +36,32 @@ test_expect_success \
     'Test that "git add -- -q" works' \
     'touch -- -q && git add -- -q'
 
+BATCH_CONFIGURATION='-c core.fsync=loose-object -c core.fsyncmethod=batch'
+
+test_expect_success 'git add: core.fsyncmethod=batch' "
+	test_create_unique_files 2 4 files_base_dir1 &&
+	GIT_TEST_FSYNC=1 git $BATCH_CONFIGURATION add -- ./files_base_dir1/ &&
+	git ls-files --stage files_base_dir1/ |
+	test_parse_ls_files_stage_oids >added_files_oids &&
+
+	# We created 2 subdirs with 4 files each (8 files total) above
+	test_line_count = 8 added_files_oids &&
+	git cat-file --batch-check='%(objectname)' <added_files_oids >added_files_actual &&
+	test_cmp added_files_oids added_files_actual
+"
+
+test_expect_success 'git update-index: core.fsyncmethod=batch' "
+	test_create_unique_files 2 4 files_base_dir2 &&
+	find files_base_dir2 ! -type d -print | xargs git $BATCH_CONFIGURATION update-index --add -- &&
+	git ls-files --stage files_base_dir2 |
+	test_parse_ls_files_stage_oids >added_files2_oids &&
+
+	# We created 2 subdirs with 4 files each (8 files total) above
+	test_line_count = 8 added_files2_oids &&
+	git cat-file --batch-check='%(objectname)' <added_files2_oids >added_files2_actual &&
+	test_cmp added_files2_oids added_files2_actual
+"
+
 test_expect_success \
 	'git add: Test that executable bit is not used if core.filemode=0' \
 	'git config core.filemode 0 &&
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 4abbc8fccae..20e94881964 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -9,6 +9,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
+. $TEST_DIRECTORY/lib-unique-files.sh
 
 test_expect_success 'usage on cmd and subcommand invalid option' '
 	test_expect_code 129 git stash --invalid-option 2>usage &&
@@ -1410,6 +1411,25 @@ test_expect_success 'stash handles skip-worktree entries nicely' '
 	git rev-parse --verify refs/stash:A.t
 '
 
+
+BATCH_CONFIGURATION='-c core.fsync=loose-object -c core.fsyncmethod=batch'
+
+test_expect_success 'stash with core.fsyncmethod=batch' "
+	test_create_unique_files 2 4 files_base_dir &&
+	GIT_TEST_FSYNC=1 git $BATCH_CONFIGURATION stash push -u -- ./files_base_dir/ &&
+
+	# The files were untracked, so use the third parent,
+	# which contains the untracked files
+	git ls-tree -r stash^3 -- ./files_base_dir/ |
+	test_parse_ls_tree_oids >stashed_files_oids &&
+
+	# We created 2 dirs with 4 files each (8 files total) above
+	test_line_count = 8 stashed_files_oids &&
+	git cat-file --batch-check='%(objectname)' <stashed_files_oids >stashed_files_actual &&
+	test_cmp stashed_files_oids stashed_files_actual
+"
+
+
 test_expect_success 'git stash succeeds despite directory/file change' '
 	test_create_repo directory_file_switch_v1 &&
 	(
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index a11d61206ad..f8a0f309e2d 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -161,22 +161,27 @@ test_expect_success 'pack-objects with bogus arguments' '
 '
 
 check_unpack () {
+	local packname="$1" &&
+	local object_list="$2" &&
+	local git_config="$3" &&
 	test_when_finished "rm -rf git2" &&
-	git init --bare git2 &&
-	git -C git2 unpack-objects -n <"$1".pack &&
-	git -C git2 unpack-objects <"$1".pack &&
-	(cd .git && find objects -type f -print) |
-	while read path
-	do
-		cmp git2/$path .git/$path || {
-			echo $path differs.
-			return 1
-		}
-	done
+	git $git_config init --bare git2 &&
+	(
+		git $git_config -C git2 unpack-objects -n <"$packname".pack &&
+		git $git_config -C git2 unpack-objects <"$packname".pack &&
+		git $git_config -C git2 cat-file --batch-check="%(objectname)"
+	) <"$object_list" >current &&
+	cmp "$object_list" current
 }
 
 test_expect_success 'unpack without delta' '
-	check_unpack test-1-${packname_1}
+	check_unpack test-1-${packname_1} obj-list
+'
+
+BATCH_CONFIGURATION='-c core.fsync=loose-object -c core.fsyncmethod=batch'
+
+test_expect_success 'unpack without delta (core.fsyncmethod=batch)' '
+	check_unpack test-1-${packname_1} obj-list "$BATCH_CONFIGURATION"
 '
 
 test_expect_success 'pack with REF_DELTA' '
@@ -185,7 +190,11 @@ test_expect_success 'pack with REF_DELTA' '
 '
 
 test_expect_success 'unpack with REF_DELTA' '
-	check_unpack test-2-${packname_2}
+	check_unpack test-2-${packname_2} obj-list
+'
+
+test_expect_success 'unpack with REF_DELTA (core.fsyncmethod=batch)' '
+       check_unpack test-2-${packname_2} obj-list "$BATCH_CONFIGURATION"
 '
 
 test_expect_success 'pack with OFS_DELTA' '
@@ -195,7 +204,11 @@ test_expect_success 'pack with OFS_DELTA' '
 '
 
 test_expect_success 'unpack with OFS_DELTA' '
-	check_unpack test-3-${packname_3}
+	check_unpack test-3-${packname_3} obj-list
+'
+
+test_expect_success 'unpack with OFS_DELTA (core.fsyncmethod=batch)' '
+       check_unpack test-3-${packname_3} obj-list "$BATCH_CONFIGURATION"
 '
 
 test_expect_success 'compare delta flavors' '
-- 
2.34.1.78.g86e39b8f8d

