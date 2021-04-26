Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AD8C43461
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 17:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 810F561007
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 17:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237567AbhDZRsX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 13:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237537AbhDZRsU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 13:48:20 -0400
Received: from mav.lukeshu.com (mav.lukeshu.com [IPv6:2001:19f0:5c00:8069:5400:ff:fe26:6a86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C579C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 10:47:38 -0700 (PDT)
Received: from lukeshu-dw-thinkpad (unknown [IPv6:2601:281:8200:26:4e34:88ff:fe48:5521])
        by mav.lukeshu.com (Postfix) with ESMTPSA id 2907A80591;
        Mon, 26 Apr 2021 13:47:37 -0400 (EDT)
From:   Luke Shumaker <lukeshu@lukeshu.com>
To:     git@vger.kernel.org
Cc:     Avery Pennarun <apenwarr@gmail.com>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Danny Lin <danny0838@gmail.com>,
        "David A . Greene" <greened@obbligato.org>,
        David Aguilar <davvid@gmail.com>,
        Jakub Suder <jakub.suder@gmail.com>,
        James Denholm <nod.helm@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Roger L Strain <roger.strain@swri.org>,
        Techlive Zheng <techlivezheng@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Luke Shumaker <lukeshu@datawire.io>
Subject: [PATCH v2 02/30] subtree: t7900: update for having the default branch name be 'main'
Date:   Mon, 26 Apr 2021 11:44:57 -0600
Message-Id: <20210426174525.3937858-3-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210426174525.3937858-1-lukeshu@lukeshu.com>
References: <20210423194230.1388945-1-lukeshu@lukeshu.com>
 <20210426174525.3937858-1-lukeshu@lukeshu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luke Shumaker <lukeshu@datawire.io>

Most of the tests had been converted to support
`GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main`, but `contrib/subtree/t/`
hadn't.

Convert it.  Most of the mentions of 'master' can just be replaced with
'HEAD'.

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
---
 contrib/subtree/t/t7900-subtree.sh | 117 +++++++++++++++--------------
 1 file changed, 59 insertions(+), 58 deletions(-)

diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 57ff4b25c1..4b982e6c2e 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -103,7 +103,7 @@ test_expect_success 'no merge from non-existent subtree' '
 	test_create_commit "$subtree_test_count/sub proj" sub1 &&
 	(
 		cd "$subtree_test_count" &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		test_must_fail git subtree merge --prefix="sub dir" FETCH_HEAD
 	)
 '
@@ -116,8 +116,8 @@ test_expect_success 'no pull from non-existent subtree' '
 	test_create_commit "$subtree_test_count/sub proj" sub1 &&
 	(
 		cd "$subtree_test_count" &&
-		git fetch ./"sub proj" master &&
-		test_must_fail git subtree pull --prefix="sub dir" ./"sub proj" master
+		git fetch ./"sub proj" HEAD &&
+		test_must_fail git subtree pull --prefix="sub dir" ./"sub proj" HEAD
 	)'
 
 next_test
@@ -128,7 +128,7 @@ test_expect_success 'add subproj as subtree into sub dir/ with --prefix' '
 	test_create_commit "$subtree_test_count/sub proj" sub1 &&
 	(
 		cd "$subtree_test_count" &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD &&
 		check_equal "$(last_commit_message)" "Add '\''sub dir/'\'' from commit '\''$(git rev-parse FETCH_HEAD)'\''"
 	)
@@ -142,7 +142,7 @@ test_expect_success 'add subproj as subtree into sub dir/ with --prefix and --me
 	test_create_commit "$subtree_test_count/sub proj" sub1 &&
 	(
 		cd "$subtree_test_count" &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" --message="Added subproject" FETCH_HEAD &&
 		check_equal "$(last_commit_message)" "Added subproject"
 	)
@@ -156,7 +156,7 @@ test_expect_success 'add subproj as subtree into sub dir/ with --prefix as -P an
 	test_create_commit "$subtree_test_count/sub proj" sub1 &&
 	(
 		cd "$subtree_test_count" &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		git subtree add -P "sub dir" -m "Added subproject" FETCH_HEAD &&
 		check_equal "$(last_commit_message)" "Added subproject"
 	)
@@ -170,7 +170,7 @@ test_expect_success 'add subproj as subtree into sub dir/ with --squash and --pr
 	test_create_commit "$subtree_test_count/sub proj" sub1 &&
 	(
 		cd "$subtree_test_count" &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" --message="Added subproject with squash" --squash FETCH_HEAD &&
 		check_equal "$(last_commit_message)" "Added subproject with squash"
 	)
@@ -188,13 +188,13 @@ test_expect_success 'merge new subproj history into sub dir/ with --prefix' '
 	test_create_commit "$subtree_test_count/sub proj" sub1 &&
 	(
 		cd "$subtree_test_count" &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD
 	) &&
 	test_create_commit "$subtree_test_count/sub proj" sub2 &&
 	(
 		cd "$subtree_test_count" &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
 		check_equal "$(last_commit_message)" "Merge commit '\''$(git rev-parse FETCH_HEAD)'\''"
 	)
@@ -208,13 +208,13 @@ test_expect_success 'merge new subproj history into sub dir/ with --prefix and -
 	test_create_commit "$subtree_test_count/sub proj" sub1 &&
 	(
 		cd "$subtree_test_count" &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD
 	) &&
 	test_create_commit "$subtree_test_count/sub proj" sub2 &&
 	(
 		cd "$subtree_test_count" &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" --message="Merged changes from subproject" FETCH_HEAD &&
 		check_equal "$(last_commit_message)" "Merged changes from subproject"
 	)
@@ -228,13 +228,13 @@ test_expect_success 'merge new subproj history into sub dir/ with --squash and -
 	test_create_commit "$subtree_test_count/sub proj" sub1 &&
 	(
 		cd "$subtree_test_count" &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD
 	) &&
 	test_create_commit "$subtree_test_count/sub proj" sub2 &&
 	(
 		cd "$subtree_test_count" &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" --message="Merged changes from subproject using squash" --squash FETCH_HEAD &&
 		check_equal "$(last_commit_message)" "Merged changes from subproject using squash"
 	)
@@ -248,7 +248,7 @@ test_expect_success 'merge the added subproj again, should do nothing' '
 	test_create_commit "$subtree_test_count/sub proj" sub1 &&
 	(
 		cd "$subtree_test_count" &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD &&
 		# this shouldn not actually do anything, since FETCH_HEAD
 		# is already a parent
@@ -265,13 +265,13 @@ test_expect_success 'merge new subproj history into subdir/ with a slash appende
 	test_create_commit "$test_count/subproj" sub1 &&
 	(
 		cd "$test_count" &&
-		git fetch ./subproj master &&
+		git fetch ./subproj HEAD &&
 		git subtree add --prefix=subdir/ FETCH_HEAD
 	) &&
 	test_create_commit "$test_count/subproj" sub2 &&
 	(
 		cd "$test_count" &&
-		git fetch ./subproj master &&
+		git fetch ./subproj HEAD &&
 		git subtree merge --prefix=subdir/ FETCH_HEAD &&
 		check_equal "$(last_commit_message)" "Merge commit '\''$(git rev-parse FETCH_HEAD)'\''"
 	)
@@ -289,7 +289,7 @@ test_expect_success 'split requires option --prefix' '
 	test_create_commit "$subtree_test_count/sub proj" sub1 &&
 	(
 		cd "$subtree_test_count" &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD &&
 		echo "You must provide the --prefix option." > expected &&
 		test_must_fail git subtree split > actual 2>&1 &&
@@ -309,7 +309,7 @@ test_expect_success 'split requires path given by option --prefix must exist' '
 	test_create_commit "$subtree_test_count/sub proj" sub1 &&
 	(
 		cd "$subtree_test_count" &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD &&
 		echo "'\''non-existent-directory'\'' does not exist; use '\''git subtree add'\''" > expected &&
 		test_must_fail git subtree split --prefix=non-existent-directory > actual 2>&1 &&
@@ -329,7 +329,7 @@ test_expect_success 'split sub dir/ with --rejoin' '
 	test_create_commit "$subtree_test_count/sub proj" sub1 &&
 	(
 		cd "$subtree_test_count" &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD
 	) &&
 	test_create_commit "$subtree_test_count" "sub dir"/main-sub1 &&
@@ -338,7 +338,7 @@ test_expect_success 'split sub dir/ with --rejoin' '
 	test_create_commit "$subtree_test_count" "sub dir"/main-sub2 &&
 	(
 		cd "$subtree_test_count" &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
 		split_hash=$(git subtree split --prefix="sub dir" --annotate="*") &&
 		git subtree split --prefix="sub dir" --annotate="*" --rejoin &&
@@ -370,7 +370,7 @@ test_expect_success 'split sub dir/ with --rejoin and --message' '
 	test_create_commit "$subtree_test_count/sub proj" sub1 &&
 	(
 		cd "$subtree_test_count" &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD
 	) &&
 	test_create_commit "$subtree_test_count" "sub dir"/main-sub1 &&
@@ -379,7 +379,7 @@ test_expect_success 'split sub dir/ with --rejoin and --message' '
 	test_create_commit "$subtree_test_count" "sub dir"/main-sub2 &&
 	(
 		cd "$subtree_test_count" &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
 		git subtree split --prefix="sub dir" --message="Split & rejoin" --annotate="*" --rejoin &&
 		check_equal "$(last_commit_message)" "Split & rejoin"
@@ -394,7 +394,7 @@ test_expect_success 'split "sub dir"/ with --branch' '
 	test_create_commit "$subtree_test_count/sub proj" sub1 &&
 	(
 		cd "$subtree_test_count" &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD
 	) &&
 	test_create_commit "$subtree_test_count" "sub dir"/main-sub1 &&
@@ -403,7 +403,7 @@ test_expect_success 'split "sub dir"/ with --branch' '
 	test_create_commit "$subtree_test_count" "sub dir"/main-sub2 &&
 	(
 		cd "$subtree_test_count" &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
 		split_hash=$(git subtree split --prefix="sub dir" --annotate="*") &&
 		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br &&
@@ -419,7 +419,7 @@ test_expect_success 'check hash of split' '
 	test_create_commit "$subtree_test_count/sub proj" sub1 &&
 	(
 		cd "$subtree_test_count" &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD
 	) &&
 	test_create_commit "$subtree_test_count" "sub dir"/main-sub1 &&
@@ -428,7 +428,7 @@ test_expect_success 'check hash of split' '
 	test_create_commit "$subtree_test_count" "sub dir"/main-sub2 &&
 	(
 		cd "$subtree_test_count" &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
 		split_hash=$(git subtree split --prefix="sub dir" --annotate="*") &&
 		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br &&
@@ -451,7 +451,7 @@ test_expect_success 'split "sub dir"/ with --branch for an existing branch' '
 	test_create_commit "$subtree_test_count/sub proj" sub1 &&
 	(
 		cd "$subtree_test_count" &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		git branch subproj-br FETCH_HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD
 	) &&
@@ -461,7 +461,7 @@ test_expect_success 'split "sub dir"/ with --branch for an existing branch' '
 	test_create_commit "$subtree_test_count" "sub dir"/main-sub2 &&
 	(
 		cd "$subtree_test_count" &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
 		split_hash=$(git subtree split --prefix="sub dir" --annotate="*") &&
 		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br &&
@@ -478,7 +478,7 @@ test_expect_success 'split "sub dir"/ with --branch for an incompatible branch'
 	(
 		cd "$subtree_test_count" &&
 		git branch init HEAD &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD
 	) &&
 	test_create_commit "$subtree_test_count" "sub dir"/main-sub1 &&
@@ -487,7 +487,7 @@ test_expect_success 'split "sub dir"/ with --branch for an incompatible branch'
 	test_create_commit "$subtree_test_count" "sub dir"/main-sub2 &&
 	(
 		cd "$subtree_test_count" &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
 		test_must_fail git subtree split --prefix="sub dir" --branch init
 	)
@@ -505,7 +505,7 @@ test_expect_success 'make sure exactly the right set of files ends up in the sub
 	test_create_commit "$subtree_test_count/sub proj" sub1 &&
 	(
 		cd "$subtree_test_count" &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD
 	) &&
 	test_create_commit "$subtree_test_count" "sub dir"/main-sub1 &&
@@ -514,7 +514,7 @@ test_expect_success 'make sure exactly the right set of files ends up in the sub
 	test_create_commit "$subtree_test_count" "sub dir"/main-sub2 &&
 	(
 		cd "$subtree_test_count" &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
 		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br --rejoin
 	) &&
@@ -555,7 +555,7 @@ test_expect_success 'make sure the subproj *only* contains commits that affect t
 	test_create_commit "$subtree_test_count/sub proj" sub1 &&
 	(
 		cd "$subtree_test_count" &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD
 	) &&
 	test_create_commit "$subtree_test_count" "sub dir"/main-sub1 &&
@@ -564,7 +564,7 @@ test_expect_success 'make sure the subproj *only* contains commits that affect t
 	test_create_commit "$subtree_test_count" "sub dir"/main-sub2 &&
 	(
 		cd "$subtree_test_count" &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
 		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br --rejoin
 	) &&
@@ -606,7 +606,7 @@ test_expect_success 'make sure exactly the right set of files ends up in the mai
 	test_create_commit "$subtree_test_count/sub proj" sub1 &&
 	(
 		cd "$subtree_test_count" &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD
 	) &&
 	test_create_commit "$subtree_test_count" "sub dir"/main-sub1 &&
@@ -615,7 +615,7 @@ test_expect_success 'make sure exactly the right set of files ends up in the mai
 	test_create_commit "$subtree_test_count" "sub dir"/main-sub2 &&
 	(
 		cd "$subtree_test_count" &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
 		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br --rejoin
 	) &&
@@ -643,7 +643,7 @@ test_expect_success 'make sure exactly the right set of files ends up in the mai
 	) &&
 	(
 		cd "$subtree_test_count" &&
-		git subtree pull --prefix="sub dir" ./"sub proj" master &&
+		git subtree pull --prefix="sub dir" ./"sub proj" HEAD &&
 
 		test_write_lines main1 main2 >chkm &&
 		test_write_lines main-sub1 main-sub2 main-sub3 main-sub4 >chkms &&
@@ -666,7 +666,7 @@ test_expect_success 'make sure each filename changed exactly once in the entire
 	(
 		cd "$subtree_test_count" &&
 		git config log.date relative &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD
 	) &&
 	test_create_commit "$subtree_test_count" "sub dir"/main-sub1 &&
@@ -675,7 +675,7 @@ test_expect_success 'make sure each filename changed exactly once in the entire
 	test_create_commit "$subtree_test_count" "sub dir"/main-sub2 &&
 	(
 		cd "$subtree_test_count" &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
 		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br --rejoin
 	) &&
@@ -703,7 +703,7 @@ test_expect_success 'make sure each filename changed exactly once in the entire
 	) &&
 	(
 		cd "$subtree_test_count" &&
-		git subtree pull --prefix="sub dir" ./"sub proj" master &&
+		git subtree pull --prefix="sub dir" ./"sub proj" HEAD &&
 
 		test_write_lines main1 main2 >chkm &&
 		test_write_lines sub1 sub2 sub3 sub4 >chks &&
@@ -731,7 +731,7 @@ test_expect_success 'make sure the --rejoin commits never make it into subproj'
 	test_create_commit "$subtree_test_count/sub proj" sub1 &&
 	(
 		cd "$subtree_test_count" &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD
 	) &&
 	test_create_commit "$subtree_test_count" "sub dir"/main-sub1 &&
@@ -740,7 +740,7 @@ test_expect_success 'make sure the --rejoin commits never make it into subproj'
 	test_create_commit "$subtree_test_count" "sub dir"/main-sub2 &&
 	(
 		cd "$subtree_test_count" &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
 		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br --rejoin
 	) &&
@@ -768,7 +768,7 @@ test_expect_success 'make sure the --rejoin commits never make it into subproj'
 	) &&
 	(
 		cd "$subtree_test_count" &&
-		git subtree pull --prefix="sub dir" ./"sub proj" master &&
+		git subtree pull --prefix="sub dir" ./"sub proj" HEAD &&
 		check_equal "$(git log --pretty=format:"%s" HEAD^2 | grep -i split)" ""
 	)
 '
@@ -781,7 +781,7 @@ test_expect_success 'make sure no "git subtree" tagged commits make it into subp
 	test_create_commit "$subtree_test_count/sub proj" sub1 &&
 	(
 		cd "$subtree_test_count" &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD
 	) &&
 	test_create_commit "$subtree_test_count" "sub dir"/main-sub1 &&
@@ -790,7 +790,7 @@ test_expect_success 'make sure no "git subtree" tagged commits make it into subp
 	test_create_commit "$subtree_test_count" "sub dir"/main-sub2 &&
 	(
 		cd "$subtree_test_count" &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
 		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br --rejoin
 	) &&
@@ -818,7 +818,7 @@ test_expect_success 'make sure no "git subtree" tagged commits make it into subp
 	) &&
 	(
 		cd "$subtree_test_count" &&
-		git subtree pull --prefix="sub dir" ./"sub proj" master &&
+		git subtree pull --prefix="sub dir" ./"sub proj" HEAD &&
 
 		# They are meaningless to subproj since one side of the merge refers to the mainline
 		check_equal "$(git log --pretty=format:"%s%n%b" HEAD^2 | grep "git-subtree.*:")" ""
@@ -837,13 +837,13 @@ test_expect_success 'make sure "git subtree split" find the correct parent' '
 	test_create_commit "$subtree_test_count/sub proj" sub1 &&
 	(
 		cd "$subtree_test_count" &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD
 	) &&
 	test_create_commit "$subtree_test_count/sub proj" sub2 &&
 	(
 		cd "$subtree_test_count" &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		git branch subproj-ref FETCH_HEAD &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD
 	) &&
@@ -853,7 +853,7 @@ test_expect_success 'make sure "git subtree split" find the correct parent' '
 		git subtree split --prefix="sub dir" --branch subproj-br &&
 
 		# at this point, the new commit parent should be subproj-ref, if it is
-		# not, something went wrong (the "newparent" of "master~" commit should
+		# not, something went wrong (the "newparent" of "HEAD~" commit should
 		# have been sub2, but it was not, because its cache was not set to
 		# itself)
 		check_equal "$(git log --pretty=format:%P -1 subproj-br)" "$(git rev-parse subproj-ref)"
@@ -868,13 +868,13 @@ test_expect_success 'split a new subtree without --onto option' '
 	test_create_commit "$subtree_test_count/sub proj" sub1 &&
 	(
 		cd "$subtree_test_count" &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD
 	) &&
 	test_create_commit "$subtree_test_count/sub proj" sub2 &&
 	(
 		cd "$subtree_test_count" &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD
 	) &&
 	test_create_commit "$subtree_test_count" "sub dir"/main-sub1 &&
@@ -903,14 +903,14 @@ test_expect_success 'verify one file change per commit' '
 	test_create_commit "$subtree_test_count/sub proj" sub1 &&
 	(
 		cd "$subtree_test_count" &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		git branch sub1 FETCH_HEAD &&
 		git subtree add --prefix="sub dir" sub1
 	) &&
 	test_create_commit "$subtree_test_count/sub proj" sub2 &&
 	(
 		cd "$subtree_test_count" &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD
 	) &&
 	test_create_commit "$subtree_test_count" "sub dir"/main-sub1 &&
@@ -947,7 +947,7 @@ test_expect_success 'push split to subproj' '
 	test_create_commit "$subtree_test_count/sub proj" sub1 &&
 	(
 		cd "$subtree_test_count" &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD
 	) &&
 	test_create_commit "$subtree_test_count" "sub dir"/main-sub1 &&
@@ -958,7 +958,7 @@ test_expect_success 'push split to subproj' '
 		cd $subtree_test_count/"sub proj" &&
                 git branch sub-branch-1 &&
                 cd .. &&
-		git fetch ./"sub proj" master &&
+		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD
 	) &&
 	test_create_commit "$subtree_test_count" "sub dir"/main-sub3 &&
@@ -994,6 +994,7 @@ test_expect_success 'push split to subproj' '
 next_test
 test_expect_success 'subtree descendant check' '
 	subtree_test_create_repo "$subtree_test_count" &&
+	defaultBranch=$(sed "s,ref: refs/heads/,," "$subtree_test_count/.git/HEAD") &&
 	test_create_commit "$subtree_test_count" folder_subtree/a &&
 	(
 		cd "$subtree_test_count" &&
@@ -1010,7 +1011,7 @@ test_expect_success 'subtree descendant check' '
 	(
 		cd "$subtree_test_count" &&
 		git cherry-pick $cherry &&
-		git checkout master &&
+		git checkout $defaultBranch &&
 		git merge -m "merge should be kept on subtree" branch &&
 		git branch no_subtree_work_branch
 	) &&
@@ -1022,10 +1023,10 @@ test_expect_success 'subtree descendant check' '
 	test_create_commit "$subtree_test_count" not_a_subtree_change &&
 	(
 		cd "$subtree_test_count" &&
-		git checkout master &&
+		git checkout $defaultBranch &&
 		git merge -m "merge should be skipped on subtree" no_subtree_work_branch &&
 
-		git subtree split --prefix folder_subtree/ --branch subtree_tip master &&
+		git subtree split --prefix folder_subtree/ --branch subtree_tip $defaultBranch &&
 		git subtree split --prefix folder_subtree/ --branch subtree_branch branch &&
 		check_equal $(git rev-list --count subtree_tip..subtree_branch) 0
 	)
-- 
2.31.1

