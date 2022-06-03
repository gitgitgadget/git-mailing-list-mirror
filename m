Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C81C43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 11:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242808AbiFCLPt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 07:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242116AbiFCLPg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 07:15:36 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149633C481
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 04:15:34 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id p10so9966918wrg.12
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 04:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cJqkjexwNzfVsVthgMgQghaTp0864lPorwG3hKAcsVQ=;
        b=aUuaq5Dba0b0Yg5Hqn3HkAh3nuB5CgCaP3rHjUUpaR11wTruBozLK4Pyrcd20/L0CE
         5hVLwkJ4F46WFdf/7ipRMBxfGRoixAKXlDiQtYGluc1dY7B+LydpN886oyqPl3CfxezD
         2owqkXpY7djj21UzfMczPq2W2/aZctFJdb+oYYTJCitSuqimYfh0bqQ31bjKViPzbPNo
         aLHG7AccZhGpb0aWtx53R3iAZILCWUZB0n6bMtlncJo5KNASlWknZqWW2MfwkicSn0o9
         TtG/vGpZwrHO8o9wdp4VNO86APVPbzdzsdvKjomQe3oksD++7JB6S/+KD5/pjkfuu9iW
         m8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cJqkjexwNzfVsVthgMgQghaTp0864lPorwG3hKAcsVQ=;
        b=lyWSBx/WAWUrrTM6WzMjKA21G6fhIcDPYPRTl/yYfr99AMfY6JdOLiQHh4ASTFajUH
         EmKJaoIuAMyDYvzQGW0kArFgYTuWOsN6ZEVA5S4eqz16qqz1NXZfGlpHvak5WJBBORS/
         2Q/Qfq3LADr7NxL8Tra7erAs+Ix0WkHSF5W65vtIF/l9Su9L3QFiCCkcevkwodB4fY6d
         ZAcqgyDiIBCkjBv80d5xb7Owaqviq1mwgdLgiyBS29S+xXM+IJeciDcwOKxFnp9pKyBp
         Q194+UZHZRAoTqTidX1uHk1eWZG/4CxECs/FXcFVkCQ8xDqu1aKpjvF3IcJecUdPRCj4
         gwlQ==
X-Gm-Message-State: AOAM533ZUgi/zuKvos2Wl7Yiq/ZUKvTE1JDllm+VpK3igwSFrjon/CHq
        Nx2Ucvb/BCswlgca9u5hB54zeRSQjhRXjw==
X-Google-Smtp-Source: ABdhPJyhrNmUMSpMnYpvkmQK+qqRdqaYims08kn7vtgcXbmas9OVeOqYgfsg474eLiS65dFf1DtdYQ==
X-Received: by 2002:adf:dd02:0:b0:215:99d0:8031 with SMTP id a2-20020adfdd02000000b0021599d08031mr181173wrm.675.1654254932224;
        Fri, 03 Jun 2022 04:15:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h24-20020adfa4d8000000b0020d0a57af5esm7184357wrb.79.2022.06.03.04.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 04:15:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/7] tests: don't assume a .git/info for .git/info/grafts
Date:   Fri,  3 Jun 2022 13:15:05 +0200
Message-Id: <patch-v2-3.7-967762b4670-20220603T110506Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1119.g5a713b43bd4
In-Reply-To: <cover-v2-0.7-00000000000-20220603T110506Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com> <cover-v2-0.7-00000000000-20220603T110506Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change those tests that assumed that a .git/info directory would be
created for them when writing .git/info/grafts to explicitly create
the directory.

Do this using the new "TEST_CREATE_REPO_NO_TEMPLATE" facility, and use
"mkdir" instead of "mkdir -p" to assert that we don't have the
.git/info already. An exception to this is the "with grafts" test in
"t6001-rev-list-graft.sh". There we're modifying our ".git" state in a
for-loop, in lieu of refactoring that more extensively let's use
"mkdir -p" there.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/annotate-tests.sh          | 3 ++-
 t/t2400-worktree-add.sh      | 4 ++++
 t/t5318-commit-graph.sh      | 3 ++-
 t/t6001-rev-list-graft.sh    | 1 +
 t/t6101-rev-parse-parents.sh | 2 ++
 t/t8001-annotate.sh          | 1 +
 t/t8002-blame.sh             | 1 +
 t/t8012-blame-colors.sh      | 1 +
 8 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index cc01d891504..f1b9a6ce4da 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -153,7 +153,7 @@ test_expect_success 'blame evil merge' '
 
 test_expect_success 'blame huge graft' '
 	test_when_finished "git checkout branch2" &&
-	test_when_finished "rm -f .git/info/grafts" &&
+	test_when_finished "rm -rf .git/info" &&
 	graft= &&
 	for i in 0 1 2
 	do
@@ -168,6 +168,7 @@ test_expect_success 'blame huge graft' '
 			graft="$graft$commit " || return 1
 		done
 	done &&
+	mkdir .git/info &&
 	printf "%s " $graft >.git/info/grafts &&
 	check_count -h 00 01 1 10 1
 '
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 2f564d533d0..f3242fef6b6 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -5,6 +5,7 @@ test_description='test git worktree add'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_CREATE_REPO_NO_TEMPLATE=1
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
@@ -229,6 +230,7 @@ test_expect_success 'checkout with grafts' '
 	SHA1=$(git rev-parse HEAD) &&
 	test_commit def &&
 	test_commit xyz &&
+	mkdir .git/info &&
 	echo "$(git rev-parse HEAD) $SHA1" >.git/info/grafts &&
 	cat >expected <<-\EOF &&
 	xyz
@@ -559,6 +561,8 @@ test_expect_success 'git worktree --no-guess-remote option overrides config' '
 '
 
 post_checkout_hook () {
+	test_when_finished "rm -rf .git/hooks" &&
+	mkdir .git/hooks &&
 	test_hook -C "$1" post-checkout <<-\EOF
 	{
 		echo $*
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index fbf0d64578c..be0b5641ffc 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -361,13 +361,14 @@ test_expect_success 'replace-objects invalidates commit-graph' '
 test_expect_success 'commit grafts invalidate commit-graph' '
 	cd "$TRASH_DIRECTORY" &&
 	test_when_finished rm -rf graft &&
-	git clone full graft &&
+	git clone --template= full graft &&
 	(
 		cd graft &&
 		git commit-graph write --reachable &&
 		test_path_is_file .git/objects/info/commit-graph &&
 		H1=$(git rev-parse --verify HEAD~1) &&
 		H3=$(git rev-parse --verify HEAD~3) &&
+		mkdir .git/info &&
 		echo "$H1 $H3" >.git/info/grafts &&
 		git -c core.commitGraph=false log >expect &&
 		git -c core.commitGraph=true log >actual &&
diff --git a/t/t6001-rev-list-graft.sh b/t/t6001-rev-list-graft.sh
index 7294147334a..16635ecc33e 100755
--- a/t/t6001-rev-list-graft.sh
+++ b/t/t6001-rev-list-graft.sh
@@ -99,6 +99,7 @@ do
 	"
 
 	test_expect_success 'with grafts' "
+		mkdir -p .git/info &&
 		echo '$B0 $A2' >.git/info/grafts &&
 		check $type $B2 -- $B2 $B1 $B0 $A2 $A1 $A0
 	"
diff --git a/t/t6101-rev-parse-parents.sh b/t/t6101-rev-parse-parents.sh
index c571fa51797..5f55ab98d35 100755
--- a/t/t6101-rev-parse-parents.sh
+++ b/t/t6101-rev-parse-parents.sh
@@ -8,6 +8,7 @@ test_description='Test git rev-parse with different parent options'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_CREATE_REPO_NO_TEMPLATE=1
 . ./test-lib.sh
 
 test_cmp_rev_output () {
@@ -25,6 +26,7 @@ test_expect_success 'setup' '
 	git merge -m next --allow-unrelated-histories start2 &&
 	test_commit final &&
 
+	mkdir .git/info &&
 	test_seq 40 |
 	while read i
 	do
diff --git a/t/t8001-annotate.sh b/t/t8001-annotate.sh
index a536a621b24..d7167f55397 100755
--- a/t/t8001-annotate.sh
+++ b/t/t8001-annotate.sh
@@ -4,6 +4,7 @@ test_description='git annotate'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_CREATE_REPO_NO_TEMPLATE=1
 . ./test-lib.sh
 
 PROG='git annotate'
diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
index ee4fdd8f18d..0147de304b4 100755
--- a/t/t8002-blame.sh
+++ b/t/t8002-blame.sh
@@ -4,6 +4,7 @@ test_description='git blame'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_CREATE_REPO_NO_TEMPLATE=1
 . ./test-lib.sh
 
 PROG='git blame -c'
diff --git a/t/t8012-blame-colors.sh b/t/t8012-blame-colors.sh
index 90c75dbb283..c3a5f6d01ff 100755
--- a/t/t8012-blame-colors.sh
+++ b/t/t8012-blame-colors.sh
@@ -4,6 +4,7 @@ test_description='colored git blame'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_CREATE_REPO_NO_TEMPLATE=1
 . ./test-lib.sh
 
 PROG='git blame -c'
-- 
2.36.1.1119.g5a713b43bd4

