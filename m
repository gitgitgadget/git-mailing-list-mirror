Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EC5D1F462
	for <e@80x24.org>; Wed, 12 Jun 2019 16:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502121AbfFLQeS (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 12:34:18 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:20260 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440336AbfFLQeP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 12:34:15 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 45PCBC20K0z5tl9;
        Wed, 12 Jun 2019 18:34:11 +0200 (CEST)
Received: from dx.site (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id F3CDF20A5;
        Wed, 12 Jun 2019 18:34:10 +0200 (CEST)
From:   Johannes Sixt <j6t@kdbg.org>
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, gitster@pobox.com,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 1/4] t7610-mergetool: do not place pipelines headed by `yes` in subshells
Date:   Wed, 12 Jun 2019 18:33:45 +0200
Message-Id: <75c812bd4838f6f35b6f42b97ae396ebb28d8b95.1560356675.git.j6t@kdbg.org>
X-Mailer: git-send-email 2.21.0.285.gc38d92e052
In-Reply-To: <cover.1560356675.git.j6t@kdbg.org>
References: <cover.1560356675.git.j6t@kdbg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Subshells for pipelines are not required. This can save a number of
processes (if the shell does not optimize it away anyway).

The patch was generated with the command

   sed -i 's/( *\(yes.*[^ ]\) *) *\&\&/\1 \&\&/' t7610-mergetool.sh

with a manual fixup of the case having no && at the end.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t7610-mergetool.sh | 170 +++++++++++++++++++++----------------------
 1 file changed, 85 insertions(+), 85 deletions(-)

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 5b61c10a9c..b67440882b 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -131,13 +131,13 @@ test_expect_success 'custom mergetool' '
 	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
 	test_must_fail git merge master &&
-	( yes "" | git mergetool both ) &&
-	( yes "" | git mergetool file1 file1 ) &&
-	( yes "" | git mergetool file2 "spaced name" ) &&
-	( yes "" | git mergetool subdir/file3 ) &&
-	( yes "d" | git mergetool file11 ) &&
-	( yes "d" | git mergetool file12 ) &&
-	( yes "l" | git mergetool submod ) &&
+	yes "" | git mergetool both &&
+	yes "" | git mergetool file1 file1 &&
+	yes "" | git mergetool file2 "spaced name" &&
+	yes "" | git mergetool subdir/file3 &&
+	yes "d" | git mergetool file11 &&
+	yes "d" | git mergetool file12 &&
+	yes "l" | git mergetool submod &&
 	test "$(cat file1)" = "master updated" &&
 	test "$(cat file2)" = "master new" &&
 	test "$(cat subdir/file3)" = "master new sub" &&
@@ -153,13 +153,13 @@ test_expect_success 'gui mergetool' '
 	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
 	test_must_fail git merge master &&
-	( yes "" | git mergetool --gui both ) &&
-	( yes "" | git mergetool -g file1 file1 ) &&
-	( yes "" | git mergetool --gui file2 "spaced name" ) &&
-	( yes "" | git mergetool --gui subdir/file3 ) &&
-	( yes "d" | git mergetool --gui file11 ) &&
-	( yes "d" | git mergetool --gui file12 ) &&
-	( yes "l" | git mergetool --gui submod ) &&
+	yes "" | git mergetool --gui both &&
+	yes "" | git mergetool -g file1 file1 &&
+	yes "" | git mergetool --gui file2 "spaced name" &&
+	yes "" | git mergetool --gui subdir/file3 &&
+	yes "d" | git mergetool --gui file11 &&
+	yes "d" | git mergetool --gui file12 &&
+	yes "l" | git mergetool --gui submod &&
 	test "$(cat file1)" = "gui master updated" &&
 	test "$(cat file2)" = "gui master new" &&
 	test "$(cat subdir/file3)" = "gui master new sub" &&
@@ -172,13 +172,13 @@ test_expect_success 'gui mergetool without merge.guitool set falls back to merge
 	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
 	test_must_fail git merge master &&
-	( yes "" | git mergetool --gui both ) &&
-	( yes "" | git mergetool -g file1 file1 ) &&
-	( yes "" | git mergetool --gui file2 "spaced name" ) &&
-	( yes "" | git mergetool --gui subdir/file3 ) &&
-	( yes "d" | git mergetool --gui file11 ) &&
-	( yes "d" | git mergetool --gui file12 ) &&
-	( yes "l" | git mergetool --gui submod ) &&
+	yes "" | git mergetool --gui both &&
+	yes "" | git mergetool -g file1 file1 &&
+	yes "" | git mergetool --gui file2 "spaced name" &&
+	yes "" | git mergetool --gui subdir/file3 &&
+	yes "d" | git mergetool --gui file11 &&
+	yes "d" | git mergetool --gui file12 &&
+	yes "l" | git mergetool --gui submod &&
 	test "$(cat file1)" = "master updated" &&
 	test "$(cat file2)" = "master new" &&
 	test "$(cat subdir/file3)" = "master new sub" &&
@@ -195,14 +195,14 @@ test_expect_success 'mergetool crlf' '
 	test_config core.autocrlf true &&
 	git checkout -b test$test_count branch1 &&
 	test_must_fail git merge master &&
-	( yes "" | git mergetool file1 ) &&
-	( yes "" | git mergetool file2 ) &&
-	( yes "" | git mergetool "spaced name" ) &&
-	( yes "" | git mergetool both ) &&
-	( yes "" | git mergetool subdir/file3 ) &&
-	( yes "d" | git mergetool file11 ) &&
-	( yes "d" | git mergetool file12 ) &&
-	( yes "r" | git mergetool submod ) &&
+	yes "" | git mergetool file1 &&
+	yes "" | git mergetool file2 &&
+	yes "" | git mergetool "spaced name" &&
+	yes "" | git mergetool both &&
+	yes "" | git mergetool subdir/file3 &&
+	yes "d" | git mergetool file11 &&
+	yes "d" | git mergetool file12 &&
+	yes "r" | git mergetool submod &&
 	test "$(printf x | cat file1 -)" = "$(printf "master updated\r\nx")" &&
 	test "$(printf x | cat file2 -)" = "$(printf "master new\r\nx")" &&
 	test "$(printf x | cat subdir/file3 -)" = "$(printf "master new sub\r\nx")" &&
@@ -218,7 +218,7 @@ test_expect_success 'mergetool in subdir' '
 	(
 		cd subdir &&
 		test_must_fail git merge master &&
-		( yes "" | git mergetool file3 ) &&
+		yes "" | git mergetool file3 &&
 		test "$(cat file3)" = "master new sub"
 	)
 '
@@ -230,13 +230,13 @@ test_expect_success 'mergetool on file in parent dir' '
 	(
 		cd subdir &&
 		test_must_fail git merge master &&
-		( yes "" | git mergetool file3 ) &&
-		( yes "" | git mergetool ../file1 ) &&
-		( yes "" | git mergetool ../file2 ../spaced\ name ) &&
-		( yes "" | git mergetool ../both ) &&
-		( yes "d" | git mergetool ../file11 ) &&
-		( yes "d" | git mergetool ../file12 ) &&
-		( yes "l" | git mergetool ../submod ) &&
+		yes "" | git mergetool file3 &&
+		yes "" | git mergetool ../file1 &&
+		yes "" | git mergetool ../file2 ../spaced\ name &&
+		yes "" | git mergetool ../both &&
+		yes "d" | git mergetool ../file11 &&
+		yes "d" | git mergetool ../file12 &&
+		yes "l" | git mergetool ../submod &&
 		test "$(cat ../file1)" = "master updated" &&
 		test "$(cat ../file2)" = "master new" &&
 		test "$(cat ../submod/bar)" = "branch1 submodule" &&
@@ -250,9 +250,9 @@ test_expect_success 'mergetool skips autoresolved' '
 	git submodule update -N &&
 	test_must_fail git merge master &&
 	test -n "$(git ls-files -u)" &&
-	( yes "d" | git mergetool file11 ) &&
-	( yes "d" | git mergetool file12 ) &&
-	( yes "l" | git mergetool submod ) &&
+	yes "d" | git mergetool file11 &&
+	yes "d" | git mergetool file12 &&
+	yes "l" | git mergetool submod &&
 	output="$(git mergetool --no-prompt)" &&
 	test "$output" = "No files need merging"
 '
@@ -264,8 +264,8 @@ test_expect_success 'mergetool merges all from subdir (rerere disabled)' '
 	(
 		cd subdir &&
 		test_must_fail git merge master &&
-		( yes "r" | git mergetool ../submod ) &&
-		( yes "d" "d" | git mergetool --no-prompt ) &&
+		yes "r" | git mergetool ../submod &&
+		yes "d" "d" | git mergetool --no-prompt &&
 		test "$(cat ../file1)" = "master updated" &&
 		test "$(cat ../file2)" = "master new" &&
 		test "$(cat file3)" = "master new sub" &&
@@ -283,8 +283,8 @@ test_expect_success 'mergetool merges all from subdir (rerere enabled)' '
 	(
 		cd subdir &&
 		test_must_fail git merge master &&
-		( yes "r" | git mergetool ../submod ) &&
-		( yes "d" "d" | git mergetool --no-prompt ) &&
+		yes "r" | git mergetool ../submod &&
+		yes "d" "d" | git mergetool --no-prompt &&
 		test "$(cat ../file1)" = "master updated" &&
 		test "$(cat ../file2)" = "master new" &&
 		test "$(cat file3)" = "master new sub" &&
@@ -301,8 +301,8 @@ test_expect_success 'mergetool skips resolved paths when rerere is active' '
 	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
 	test_must_fail git merge master &&
-	( yes "l" | git mergetool --no-prompt submod ) &&
-	( yes "d" "d" | git mergetool --no-prompt ) &&
+	yes "l" | git mergetool --no-prompt submod &&
+	yes "d" "d" | git mergetool --no-prompt &&
 	git submodule update -N &&
 	output="$(yes "n" | git mergetool --no-prompt)" &&
 	test "$output" = "No files need merging"
@@ -343,7 +343,7 @@ test_expect_success 'mergetool takes partial path' '
 	git submodule update -N &&
 	test_must_fail git merge master &&
 
-	( yes "" | git mergetool subdir ) &&
+	yes "" | git mergetool subdir &&
 
 	test "$(cat subdir/file3)" = "master new sub"
 '
@@ -410,10 +410,10 @@ test_expect_success 'deleted vs modified submodule' '
 	git checkout -b test$test_count.a test$test_count &&
 	test_must_fail git merge master &&
 	test -n "$(git ls-files -u)" &&
-	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 ) &&
-	( yes "" | git mergetool both ) &&
-	( yes "d" | git mergetool file11 file12 ) &&
-	( yes "r" | git mergetool submod ) &&
+	yes "" | git mergetool file1 file2 spaced\ name subdir/file3 &&
+	yes "" | git mergetool both &&
+	yes "d" | git mergetool file11 file12 &&
+	yes "r" | git mergetool submod &&
 	rmdir submod && mv submod-movedaside submod &&
 	test "$(cat submod/bar)" = "branch1 submodule" &&
 	git submodule update -N &&
@@ -427,10 +427,10 @@ test_expect_success 'deleted vs modified submodule' '
 	git submodule update -N &&
 	test_must_fail git merge master &&
 	test -n "$(git ls-files -u)" &&
-	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 ) &&
-	( yes "" | git mergetool both ) &&
-	( yes "d" | git mergetool file11 file12 ) &&
-	( yes "l" | git mergetool submod ) &&
+	yes "" | git mergetool file1 file2 spaced\ name subdir/file3 &&
+	yes "" | git mergetool both &&
+	yes "d" | git mergetool file11 file12 &&
+	yes "l" | git mergetool submod &&
 	test ! -e submod &&
 	output="$(git mergetool --no-prompt)" &&
 	test "$output" = "No files need merging" &&
@@ -441,10 +441,10 @@ test_expect_success 'deleted vs modified submodule' '
 	git submodule update -N &&
 	test_must_fail git merge test$test_count &&
 	test -n "$(git ls-files -u)" &&
-	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 ) &&
-	( yes "" | git mergetool both ) &&
-	( yes "d" | git mergetool file11 file12 ) &&
-	( yes "r" | git mergetool submod ) &&
+	yes "" | git mergetool file1 file2 spaced\ name subdir/file3 &&
+	yes "" | git mergetool both &&
+	yes "d" | git mergetool file11 file12 &&
+	yes "r" | git mergetool submod &&
 	test ! -e submod &&
 	test -d submod.orig &&
 	git submodule update -N &&
@@ -457,10 +457,10 @@ test_expect_success 'deleted vs modified submodule' '
 	git submodule update -N &&
 	test_must_fail git merge test$test_count &&
 	test -n "$(git ls-files -u)" &&
-	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 ) &&
-	( yes "" | git mergetool both ) &&
-	( yes "d" | git mergetool file11 file12 ) &&
-	( yes "l" | git mergetool submod ) &&
+	yes "" | git mergetool file1 file2 spaced\ name subdir/file3 &&
+	yes "" | git mergetool both &&
+	yes "d" | git mergetool file11 file12 &&
+	yes "l" | git mergetool submod &&
 	test "$(cat submod/bar)" = "master submodule" &&
 	git submodule update -N &&
 	test "$(cat submod/bar)" = "master submodule" &&
@@ -481,10 +481,10 @@ test_expect_success 'file vs modified submodule' '
 	git checkout -b test$test_count.a branch1 &&
 	test_must_fail git merge master &&
 	test -n "$(git ls-files -u)" &&
-	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 ) &&
-	( yes "" | git mergetool both ) &&
-	( yes "d" | git mergetool file11 file12 ) &&
-	( yes "r" | git mergetool submod ) &&
+	yes "" | git mergetool file1 file2 spaced\ name subdir/file3 &&
+	yes "" | git mergetool both &&
+	yes "d" | git mergetool file11 file12 &&
+	yes "r" | git mergetool submod &&
 	rmdir submod && mv submod-movedaside submod &&
 	test "$(cat submod/bar)" = "branch1 submodule" &&
 	git submodule update -N &&
@@ -497,10 +497,10 @@ test_expect_success 'file vs modified submodule' '
 	git checkout -b test$test_count.b test$test_count &&
 	test_must_fail git merge master &&
 	test -n "$(git ls-files -u)" &&
-	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 ) &&
-	( yes "" | git mergetool both ) &&
-	( yes "d" | git mergetool file11 file12 ) &&
-	( yes "l" | git mergetool submod ) &&
+	yes "" | git mergetool file1 file2 spaced\ name subdir/file3 &&
+	yes "" | git mergetool both &&
+	yes "d" | git mergetool file11 file12 &&
+	yes "l" | git mergetool submod &&
 	git submodule update -N &&
 	test "$(cat submod)" = "not a submodule" &&
 	output="$(git mergetool --no-prompt)" &&
@@ -513,10 +513,10 @@ test_expect_success 'file vs modified submodule' '
 	git submodule update -N &&
 	test_must_fail git merge test$test_count &&
 	test -n "$(git ls-files -u)" &&
-	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 ) &&
-	( yes "" | git mergetool both ) &&
-	( yes "d" | git mergetool file11 file12 ) &&
-	( yes "r" | git mergetool submod ) &&
+	yes "" | git mergetool file1 file2 spaced\ name subdir/file3 &&
+	yes "" | git mergetool both &&
+	yes "d" | git mergetool file11 file12 &&
+	yes "r" | git mergetool submod &&
 	test -d submod.orig &&
 	git submodule update -N &&
 	test "$(cat submod)" = "not a submodule" &&
@@ -529,10 +529,10 @@ test_expect_success 'file vs modified submodule' '
 	git submodule update -N &&
 	test_must_fail git merge test$test_count &&
 	test -n "$(git ls-files -u)" &&
-	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 ) &&
-	( yes "" | git mergetool both ) &&
-	( yes "d" | git mergetool file11 file12 ) &&
-	( yes "l" | git mergetool submod ) &&
+	yes "" | git mergetool file1 file2 spaced\ name subdir/file3 &&
+	yes "" | git mergetool both &&
+	yes "d" | git mergetool file11 file12 &&
+	yes "l" | git mergetool submod &&
 	test "$(cat submod/bar)" = "master submodule" &&
 	git submodule update -N &&
 	test "$(cat submod/bar)" = "master submodule" &&
@@ -587,7 +587,7 @@ test_expect_success 'submodule in subdirectory' '
 	test_must_fail git merge test$test_count.a &&
 	(
 		cd subdir &&
-		( yes "l" | git mergetool subdir_module )
+		yes "l" | git mergetool subdir_module
 	) &&
 	test "$(cat subdir/subdir_module/file15)" = "test$test_count.b" &&
 	git submodule update -N &&
@@ -596,7 +596,7 @@ test_expect_success 'submodule in subdirectory' '
 	git submodule update -N &&
 
 	test_must_fail git merge test$test_count.a &&
-	( yes "r" | git mergetool subdir/subdir_module ) &&
+	yes "r" | git mergetool subdir/subdir_module &&
 	test "$(cat subdir/subdir_module/file15)" = "test$test_count.b" &&
 	git submodule update -N &&
 	test "$(cat subdir/subdir_module/file15)" = "test$test_count.a" &&
@@ -615,7 +615,7 @@ test_expect_success 'directory vs modified submodule' '
 
 	test_must_fail git merge master &&
 	test -n "$(git ls-files -u)" &&
-	( yes "l" | git mergetool submod ) &&
+	yes "l" | git mergetool submod &&
 	test "$(cat submod/file16)" = "not a submodule" &&
 	rm -rf submod.orig &&
 
@@ -623,7 +623,7 @@ test_expect_success 'directory vs modified submodule' '
 	test_must_fail git merge master &&
 	test -n "$(git ls-files -u)" &&
 	test ! -e submod.orig &&
-	( yes "r" | git mergetool submod ) &&
+	yes "r" | git mergetool submod &&
 	test -d submod.orig &&
 	test "$(cat submod.orig/file16)" = "not a submodule" &&
 	rm -r submod.orig &&
@@ -638,7 +638,7 @@ test_expect_success 'directory vs modified submodule' '
 	git submodule update -N &&
 	test_must_fail git merge test$test_count &&
 	test -n "$(git ls-files -u)" &&
-	( yes "l" | git mergetool submod ) &&
+	yes "l" | git mergetool submod &&
 	git submodule update -N &&
 	test "$(cat submod/bar)" = "master submodule" &&
 
@@ -647,7 +647,7 @@ test_expect_success 'directory vs modified submodule' '
 	test_must_fail git merge test$test_count &&
 	test -n "$(git ls-files -u)" &&
 	test ! -e submod.orig &&
-	( yes "r" | git mergetool submod ) &&
+	yes "r" | git mergetool submod &&
 	test "$(cat submod/file16)" = "not a submodule" &&
 
 	git reset --hard master &&
-- 
2.21.0.285.gc38d92e052

