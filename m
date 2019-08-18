Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D492F1F461
	for <e@80x24.org>; Sun, 18 Aug 2019 19:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfHRTU4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 15:20:56 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57800 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726950AbfHRTUz (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Aug 2019 15:20:55 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AAB906073E;
        Sun, 18 Aug 2019 19:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566156054;
        bh=NfGVmjmYZCcknXWiSqjUlgvMi2dLT412qPnU3gYEWcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=cMni/1Z+sLsIJS8vvYI0pQXPFmnY32FEv/0QPH3VEOrgLR5OuPggESTh6VLVvxI0h
         0d/pIYB1CJYXnbVS43qw0ovybAQ8lE1vhDpiqGZ0PwmcX36fvtfmKHC4qhCMbN5eEK
         ys4L7aZRJROXllX3q8DNW2zxUL0k8LnREiJilFsOvGsOZLKdM5qiIGwwv1K432/m1g
         XUIgGi5YCheiG4PmHy2Rnvv5wjxK4uCmyyspjjh79c3De1/X0pu/UiuH8aHUcoemqS
         XHyReDTdLb4ylnyysYy6dOS4sfTlj3F6aAXa7O4HN1xe6U+tHdMuufY+fkPo2R2HZz
         uBR4vTSZrbVi47BeaHOSkEliAffj4NaPyytAMUm/XeGsN2XL11EKDBcvsuqx3X9yng
         IwK42E3hMV7mZy8Sasumti0ecCYHNRZl2x7wm8qAhl1pDEwjf6ZyYQRPD9dSLbBRhe
         xCh2L9gfvn2TaAjWqOn3y0CyfmIfpQCN+Q8bYSzpuumlHnXGBBM
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 06/14] t3404: abstract away SHA-1-specific constants
Date:   Sun, 18 Aug 2019 19:16:38 +0000
Message-Id: <20190818191646.868106-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.rc1.170.gbd704faa3e
In-Reply-To: <20190818191646.868106-1-sandals@crustytoothpaste.net>
References: <20190818191646.868106-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it computes variables for object IDs instead of
using hard-coded hashes.  Add a use of $EMPTY_TREE instead of a
hard-coded value.  Remove a comment about hard-coded hashes which is no
longer applicable.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t3404-rebase-interactive.sh | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 461dd539ff..87ee69f78e 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -29,9 +29,6 @@ Initial setup:
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
-# WARNING: Modifications to the initial repository can change the SHA ID used
-# in the expect2 file for the 'stop on conflicting pick' test.
-
 test_expect_success 'setup' '
 	test_commit A file1 &&
 	test_commit B file1 &&
@@ -233,25 +230,28 @@ test_expect_success 'exchange two commits' '
 	set_fake_editor &&
 	FAKE_LINES="2 1" git rebase -i HEAD~2 &&
 	test H = $(git cat-file commit HEAD^ | sed -ne \$p) &&
-	test G = $(git cat-file commit HEAD | sed -ne \$p)
+	test G = $(git cat-file commit HEAD | sed -ne \$p) &&
+	blob1=$(git rev-parse --short HEAD^:file1) &&
+	blob2=$(git rev-parse --short HEAD:file1) &&
+	commit=$(git rev-parse --short HEAD)
 '
 
 test_expect_success 'stop on conflicting pick' '
-	cat >expect <<-\EOF &&
+	cat >expect <<-EOF &&
 	diff --git a/file1 b/file1
-	index f70f10e..fd79235 100644
+	index $blob1..$blob2 100644
 	--- a/file1
 	+++ b/file1
 	@@ -1 +1 @@
 	-A
 	+G
 	EOF
-	cat >expect2 <<-\EOF &&
+	cat >expect2 <<-EOF &&
 	<<<<<<< HEAD
 	D
 	=======
 	G
-	>>>>>>> 5d18e54... G
+	>>>>>>> $commit... G
 	EOF
 	git tag new-branch1 &&
 	set_fake_editor &&
@@ -1003,7 +1003,7 @@ test_expect_success 'rebase -i --root temporary sentinel commit' '
 	git checkout B &&
 	set_fake_editor &&
 	test_must_fail env FAKE_LINES="2" git rebase -i --root &&
-	git cat-file commit HEAD | grep "^tree 4b825dc642cb" &&
+	git cat-file commit HEAD | grep "^tree $EMPTY_TREE" &&
 	git rebase --abort
 '
 
@@ -1161,7 +1161,7 @@ test_expect_success 'rebase -i error on commits with \ in message' '
 	test_expect_code 1 grep  "	emp" error
 '
 
-test_expect_success 'short SHA-1 setup' '
+test_expect_success SHA1 'short SHA-1 setup' '
 	test_when_finished "git checkout master" &&
 	git checkout --orphan collide &&
 	git rm -rf . &&
@@ -1173,7 +1173,7 @@ test_expect_success 'short SHA-1 setup' '
 	)
 '
 
-test_expect_success 'short SHA-1 collide' '
+test_expect_success SHA1 'short SHA-1 collide' '
 	test_when_finished "reset_rebase && git checkout master" &&
 	git checkout collide &&
 	(
