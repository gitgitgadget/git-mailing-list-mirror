Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA54EC2D0D3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85300206EC
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="usd7PhPr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfLUTuN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 14:50:13 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41984 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727145AbfLUTuL (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 21 Dec 2019 14:50:11 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 61739607F5;
        Sat, 21 Dec 2019 19:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1576957808;
        bh=P9eMuEzSN5aqV0nMquA7z2VnEGmwNgMNakTVEl4JSCI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=usd7PhPrpyghNZdSOkb/sLZMxkqMGIBhZW16AV9WJaB4UF0s0dfnhe6wPw4A12+PF
         eBBUKftOZf7h4Wv1p5hB4fNxthmdBh0EAyvC8jR6ju0uIxYiHKDH/fSxzrXFhsEh7Y
         eNgH0MusFuTnBCYP6ezaIybyP9YIiuyYUcODW0+d44aR0EmhKHgpZWU49I/77EVJZi
         dhcVdJ6Yk1Q2VYrQMmECuhqbHkORlPVKz0+/82QubAZJhYQYsOiHQLhpeTAh4UlWim
         urshsAGQI/VmFOSKQXtarDj3ZM8xSJFi/HC4FPwtGrC5FuTDgrvOo+ZYvINrFFDwu2
         xo/BM7NSoi03U/4TWu0XO8cjVOdTAObtOfRgnUVSyT/0A/+8+WCpWmCRNSbTTHFNCE
         Vkq/8w9WyHPeB4SOiMpsEuv8JqG1FW79GxE/OPtsY7SUZH/hXs5FJP1xfLVlhEegOK
         /6LkgJBmBznT0NmqdT7A28+JaTxZA8StmvNTMiV4lzLEP7jYtTB
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 07/20] t4300: abstract away SHA-1-specific constants
Date:   Sat, 21 Dec 2019 19:49:23 +0000
Message-Id: <20191221194936.1346664-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.24.1.658.g99f4b37f93
In-Reply-To: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
References: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it computes values for object IDs instead of
using hard-coded hashes.  Move the heredocs later in the tests so we can
take advantage of computed values.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4300-merge-tree.sh | 188 +++++++++++++++++++++---------------------
 1 file changed, 94 insertions(+), 94 deletions(-)

diff --git a/t/t4300-merge-tree.sh b/t/t4300-merge-tree.sh
index d87cc7d9ef..e59601e5fe 100755
--- a/t/t4300-merge-tree.sh
+++ b/t/t4300-merge-tree.sh
@@ -11,16 +11,16 @@ test_expect_success setup '
 '
 
 test_expect_success 'file add A, !B' '
-	cat >expected <<\EXPECTED &&
+	git reset --hard initial &&
+	test_commit "add-a-not-b" "ONE" "AAA" &&
+	git merge-tree initial initial add-a-not-b >actual &&
+	cat >expected <<EXPECTED &&
 added in remote
-  their  100644 43d5a8ed6ef6c00ff775008633f95787d088285d ONE
+  their  100644 $(git rev-parse HEAD:ONE) ONE
 @@ -0,0 +1 @@
 +AAA
 EXPECTED
 
-	git reset --hard initial &&
-	test_commit "add-a-not-b" "ONE" "AAA" &&
-	git merge-tree initial initial add-a-not-b >actual &&
 	test_cmp expected actual
 '
 
@@ -41,10 +41,15 @@ test_expect_success 'file add A, B (same)' '
 '
 
 test_expect_success 'file add A, B (different)' '
-	cat >expected <<\EXPECTED &&
+	git reset --hard initial &&
+	test_commit "add-a-b-diff-A" "ONE" "AAA" &&
+	git reset --hard initial &&
+	test_commit "add-a-b-diff-B" "ONE" "BBB" &&
+	git merge-tree initial add-a-b-diff-A add-a-b-diff-B >actual &&
+	cat >expected <<EXPECTED &&
 added in both
-  our    100644 43d5a8ed6ef6c00ff775008633f95787d088285d ONE
-  their  100644 ba629238ca89489f2b350e196ca445e09d8bb834 ONE
+  our    100644 $(git rev-parse add-a-b-diff-A:ONE) ONE
+  their  100644 $(git rev-parse add-a-b-diff-B:ONE) ONE
 @@ -1 +1,5 @@
 +<<<<<<< .our
  AAA
@@ -53,11 +58,6 @@ added in both
 +>>>>>>> .their
 EXPECTED
 
-	git reset --hard initial &&
-	test_commit "add-a-b-diff-A" "ONE" "AAA" &&
-	git reset --hard initial &&
-	test_commit "add-a-b-diff-B" "ONE" "BBB" &&
-	git merge-tree initial add-a-b-diff-A add-a-b-diff-B >actual &&
 	test_cmp expected actual
 '
 
@@ -69,18 +69,18 @@ test_expect_success 'file change A, !B' '
 '
 
 test_expect_success 'file change !A, B' '
-	cat >expected <<\EXPECTED &&
+	git reset --hard initial &&
+	test_commit "change-not-a-b" "initial-file" "BBB" &&
+	git merge-tree initial initial change-not-a-b >actual &&
+	cat >expected <<EXPECTED &&
 merged
-  result 100644 ba629238ca89489f2b350e196ca445e09d8bb834 initial-file
-  our    100644 e79c5e8f964493290a409888d5413a737e8e5dd5 initial-file
+  result 100644 $(git rev-parse change-a-not-b:initial-file) initial-file
+  our    100644 $(git rev-parse initial:initial-file       ) initial-file
 @@ -1 +1 @@
 -initial
 +BBB
 EXPECTED
 
-	git reset --hard initial &&
-	test_commit "change-not-a-b" "initial-file" "BBB" &&
-	git merge-tree initial initial change-not-a-b >actual &&
 	test_cmp expected actual
 '
 
@@ -94,11 +94,16 @@ test_expect_success 'file change A, B (same)' '
 '
 
 test_expect_success 'file change A, B (different)' '
-	cat >expected <<\EXPECTED &&
+	git reset --hard initial &&
+	test_commit "change-a-b-diff-A" "initial-file" "AAA" &&
+	git reset --hard initial &&
+	test_commit "change-a-b-diff-B" "initial-file" "BBB" &&
+	git merge-tree initial change-a-b-diff-A change-a-b-diff-B >actual &&
+	cat >expected <<EXPECTED &&
 changed in both
-  base   100644 e79c5e8f964493290a409888d5413a737e8e5dd5 initial-file
-  our    100644 43d5a8ed6ef6c00ff775008633f95787d088285d initial-file
-  their  100644 ba629238ca89489f2b350e196ca445e09d8bb834 initial-file
+  base   100644 $(git rev-parse initial:initial-file          ) initial-file
+  our    100644 $(git rev-parse change-a-b-diff-A:initial-file) initial-file
+  their  100644 $(git rev-parse change-a-b-diff-B:initial-file) initial-file
 @@ -1 +1,5 @@
 +<<<<<<< .our
  AAA
@@ -107,34 +112,10 @@ changed in both
 +>>>>>>> .their
 EXPECTED
 
-	git reset --hard initial &&
-	test_commit "change-a-b-diff-A" "initial-file" "AAA" &&
-	git reset --hard initial &&
-	test_commit "change-a-b-diff-B" "initial-file" "BBB" &&
-	git merge-tree initial change-a-b-diff-A change-a-b-diff-B >actual &&
 	test_cmp expected actual
 '
 
 test_expect_success 'file change A, B (mixed)' '
-	cat >expected <<\EXPECTED &&
-changed in both
-  base   100644 f4f1f998c7776568c4ff38f516d77fef9399b5a7 ONE
-  our    100644 af14c2c3475337c73759d561ef70b59e5c731176 ONE
-  their  100644 372d761493f524d44d59bd24700c3bdf914c973c ONE
-@@ -7,7 +7,11 @@
- AAA
- AAA
- AAA
-+<<<<<<< .our
- BBB
-+=======
-+CCC
-+>>>>>>> .their
- AAA
- AAA
- AAA
-EXPECTED
-
 	git reset --hard initial &&
 	test_commit "change-a-b-mix-base" "ONE" "
 AAA
@@ -159,6 +140,26 @@ AAA" &&
 		"$(sed -e "1{s/AAA/BBB/;}" -e "10{s/AAA/CCC/;}" <ONE)" &&
 	git merge-tree change-a-b-mix-base change-a-b-mix-A change-a-b-mix-B \
 		>actual &&
+
+	cat >expected <<EXPECTED &&
+changed in both
+  base   100644 $(git rev-parse change-a-b-mix-base:ONE) ONE
+  our    100644 $(git rev-parse change-a-b-mix-A:ONE   ) ONE
+  their  100644 $(git rev-parse change-a-b-mix-B:ONE   ) ONE
+@@ -7,7 +7,11 @@
+ AAA
+ AAA
+ AAA
++<<<<<<< .our
+ BBB
++=======
++CCC
++>>>>>>> .their
+ AAA
+ AAA
+ AAA
+EXPECTED
+
 	test_cmp expected actual
 '
 
@@ -173,20 +174,20 @@ test_expect_success 'file remove A, !B' '
 '
 
 test_expect_success 'file remove !A, B' '
-	cat >expected <<\EXPECTED &&
-removed in remote
-  base   100644 43d5a8ed6ef6c00ff775008633f95787d088285d ONE
-  our    100644 43d5a8ed6ef6c00ff775008633f95787d088285d ONE
-@@ -1 +0,0 @@
--AAA
-EXPECTED
-
 	git reset --hard initial &&
 	test_commit "rm-not-a-b-base" "ONE" "AAA" &&
 	git rm ONE &&
 	git commit -m "rm-not-a-b" &&
 	git tag "rm-not-a-b" &&
 	git merge-tree rm-a-not-b-base rm-a-not-b-base rm-a-not-b >actual &&
+	cat >expected <<EXPECTED &&
+removed in remote
+  base   100644 $(git rev-parse rm-a-not-b-base:ONE) ONE
+  our    100644 $(git rev-parse rm-a-not-b-base:ONE) ONE
+@@ -1 +0,0 @@
+-AAA
+EXPECTED
+
 	test_cmp expected actual
 '
 
@@ -201,14 +202,6 @@ test_expect_success 'file remove A, B (same)' '
 '
 
 test_expect_success 'file change A, remove B' '
-	cat >expected <<\EXPECTED &&
-removed in remote
-  base   100644 43d5a8ed6ef6c00ff775008633f95787d088285d ONE
-  our    100644 ba629238ca89489f2b350e196ca445e09d8bb834 ONE
-@@ -1 +0,0 @@
--BBB
-EXPECTED
-
 	git reset --hard initial &&
 	test_commit "change-a-rm-b-base" "ONE" "AAA" &&
 	test_commit "change-a-rm-b-A" "ONE" "BBB" &&
@@ -218,16 +211,18 @@ EXPECTED
 	git tag "change-a-rm-b-B" &&
 	git merge-tree change-a-rm-b-base change-a-rm-b-A change-a-rm-b-B \
 		>actual &&
+	cat >expected <<EXPECTED &&
+removed in remote
+  base   100644 $(git rev-parse change-a-rm-b-base:ONE) ONE
+  our    100644 $(git rev-parse change-a-rm-b-A:ONE   ) ONE
+@@ -1 +0,0 @@
+-BBB
+EXPECTED
+
 	test_cmp expected actual
 '
 
 test_expect_success 'file remove A, change B' '
-	cat >expected <<\EXPECTED &&
-removed in local
-  base   100644 43d5a8ed6ef6c00ff775008633f95787d088285d ONE
-  their  100644 ba629238ca89489f2b350e196ca445e09d8bb834 ONE
-EXPECTED
-
 	git reset --hard initial &&
 	test_commit "rm-a-change-b-base" "ONE" "AAA" &&
 
@@ -238,6 +233,11 @@ EXPECTED
 	test_commit "rm-a-change-b-B" "ONE" "BBB" &&
 	git merge-tree rm-a-change-b-base rm-a-change-b-A rm-a-change-b-B \
 		>actual &&
+	cat >expected <<EXPECTED &&
+removed in local
+  base   100644 $(git rev-parse rm-a-change-b-base:ONE) ONE
+  their  100644 $(git rev-parse rm-a-change-b-B:ONE   ) ONE
+EXPECTED
 	test_cmp expected actual
 '
 
@@ -250,10 +250,17 @@ test_expect_success 'tree add A, B (same)' '
 '
 
 test_expect_success 'tree add A, B (different)' '
-	cat >expect <<-\EOF &&
+	git reset --hard initial &&
+	mkdir sub &&
+	test_commit "add sub/file" "sub/file" "AAA" add-tree-a-b-A &&
+	git reset --hard initial &&
+	mkdir sub &&
+	test_commit "add sub/file" "sub/file" "BBB" add-tree-a-b-B &&
+	git merge-tree initial add-tree-a-b-A add-tree-a-b-B >actual &&
+	cat >expect <<-EOF &&
 	added in both
-	  our    100644 43d5a8ed6ef6c00ff775008633f95787d088285d sub/file
-	  their  100644 ba629238ca89489f2b350e196ca445e09d8bb834 sub/file
+	  our    100644 $(git rev-parse add-tree-a-b-A:sub/file) sub/file
+	  their  100644 $(git rev-parse add-tree-a-b-B:sub/file) sub/file
 	@@ -1 +1,5 @@
 	+<<<<<<< .our
 	 AAA
@@ -261,24 +268,10 @@ test_expect_success 'tree add A, B (different)' '
 	+BBB
 	+>>>>>>> .their
 	EOF
-	git reset --hard initial &&
-	mkdir sub &&
-	test_commit "add sub/file" "sub/file" "AAA" add-tree-a-b-A &&
-	git reset --hard initial &&
-	mkdir sub &&
-	test_commit "add sub/file" "sub/file" "BBB" add-tree-a-b-B &&
-	git merge-tree initial add-tree-a-b-A add-tree-a-b-B >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'tree unchanged A, removed B' '
-	cat >expect <<-\EOF &&
-	removed in remote
-	  base   100644 43d5a8ed6ef6c00ff775008633f95787d088285d sub/file
-	  our    100644 43d5a8ed6ef6c00ff775008633f95787d088285d sub/file
-	@@ -1 +0,0 @@
-	-AAA
-	EOF
 	git reset --hard initial &&
 	mkdir sub &&
 	test_commit "add sub/file" "sub/file" "AAA" tree-remove-b-initial &&
@@ -287,6 +280,13 @@ test_expect_success 'tree unchanged A, removed B' '
 	git commit -m "remove sub/file" &&
 	git tag tree-remove-b-B &&
 	git merge-tree tree-remove-b-initial tree-remove-b-initial tree-remove-b-B >actual &&
+	cat >expect <<-EOF &&
+	removed in remote
+	  base   100644 $(git rev-parse tree-remove-b-initial:sub/file) sub/file
+	  our    100644 $(git rev-parse tree-remove-b-initial:sub/file) sub/file
+	@@ -1 +0,0 @@
+	-AAA
+	EOF
 	test_cmp expect actual
 '
 
@@ -296,14 +296,14 @@ test_expect_success 'turn file to tree' '
 	mkdir initial-file &&
 	test_commit "turn-file-to-tree" "initial-file/ONE" "CCC" &&
 	git merge-tree initial initial turn-file-to-tree >actual &&
-	cat >expect <<-\EOF &&
+	cat >expect <<-EOF &&
 	added in remote
-	  their  100644 43aa4fdec31eb92e1fdc2f0ce6ea9ddb7c32bcf7 initial-file/ONE
+	  their  100644 $(git rev-parse turn-file-to-tree:initial-file/ONE) initial-file/ONE
 	@@ -0,0 +1 @@
 	+CCC
 	removed in remote
-	  base   100644 e79c5e8f964493290a409888d5413a737e8e5dd5 initial-file
-	  our    100644 e79c5e8f964493290a409888d5413a737e8e5dd5 initial-file
+	  base   100644 $(git rev-parse initial:initial-file) initial-file
+	  our    100644 $(git rev-parse initial:initial-file) initial-file
 	@@ -1 +0,0 @@
 	-initial
 	EOF
@@ -318,14 +318,14 @@ test_expect_success 'turn tree to file' '
 	rm -fr dir &&
 	test_commit "make-file" "dir" "CCC" &&
 	git merge-tree add-tree add-another-tree make-file >actual &&
-	cat >expect <<-\EOF &&
+	cat >expect <<-EOF &&
 	removed in remote
-	  base   100644 43d5a8ed6ef6c00ff775008633f95787d088285d dir/path
-	  our    100644 43d5a8ed6ef6c00ff775008633f95787d088285d dir/path
+	  base   100644 $(git rev-parse add-tree:dir/path) dir/path
+	  our    100644 $(git rev-parse add-tree:dir/path) dir/path
 	@@ -1 +0,0 @@
 	-AAA
 	added in remote
-	  their  100644 43aa4fdec31eb92e1fdc2f0ce6ea9ddb7c32bcf7 dir
+	  their  100644 $(git rev-parse make-file:dir) dir
 	@@ -0,0 +1 @@
 	+CCC
 	EOF
