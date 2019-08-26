Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E6101F4B7
	for <e@80x24.org>; Mon, 26 Aug 2019 01:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbfHZBoK (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 21:44:10 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58294 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728856AbfHZBoJ (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Aug 2019 21:44:09 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:60b7:b124:ccfa:d51])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B39406075D;
        Mon, 26 Aug 2019 01:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566783847;
        bh=NfGVmjmYZCcknXWiSqjUlgvMi2dLT412qPnU3gYEWcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=q+pw/DqnkmDLtQDru7h/vFqkqkJfKdKMUU3ATXbZ+WgYKtyQFTS15GbO+Q2lBFFSH
         Jo9s6sCL4m6sqc9CUhDwviyAqRya6U7FUtKEI4zX1DUsp2ZjugwUvqyOmHvBO2UPGp
         R7Au4Y5D+BCj80myZrxuk8qqDcYDBBGXoQ5G+5c1Gg2k8BrJS7umU5AhfMTgknwatJ
         HgJLxkPFGSkWZM0xdT0cbUBFQOhvJPSRSSkXJEpfuwKZTgKjpHEcwrT8ePRRBPKKOp
         w8j6mRgEjm03BAXygkZpW2nFszKAU2+sTxzpSWqsK4IvEK1XLujG0w9LQLKP1qehC4
         OZtiU+b3Pf7OdeFxaCXPNi/LgrgmI78wAsFrF5b4mfzfeA1O8w4c1b7OIyHQtENEw1
         Ha+MEPKqrIC9HU78izm06meALNaBuPovD/IXfLKjcmfYN+sCjtWIT13h2sB9H5AAJt
         NHRBHfBUSNy+3/aTFgs6WMNAUt2QanXDmQiWCd9bHHYf917pXCw
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 06/14] t3404: abstract away SHA-1-specific constants
Date:   Mon, 26 Aug 2019 01:43:36 +0000
Message-Id: <20190826014344.16008-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c
In-Reply-To: <20190826014344.16008-1-sandals@crustytoothpaste.net>
References: <20190818191646.868106-1-sandals@crustytoothpaste.net>
 <20190826014344.16008-1-sandals@crustytoothpaste.net>
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
