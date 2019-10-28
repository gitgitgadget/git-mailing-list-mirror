Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7592F1F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 00:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbfJ1A7g (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Oct 2019 20:59:36 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54312 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729059AbfJ1A7f (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 27 Oct 2019 20:59:35 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7097862066;
        Mon, 28 Oct 2019 00:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1572224374;
        bh=WhbKam2qFQN1TEw0wBrO+ZCqEwFoU4BDYAvufHMb/vM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=byyc5k3/VxWQZOHR80eUd2VrayA2uiS+nXfQm3Ye7cIvdBbDAb6ATNWEnK4YCwA0Z
         E3iBNL6yV9ZwdnArt/z0bvsoWW/JqVfAOc+yX9ObEPOlCBVv9DgvBuWN+x6Y5vW7xc
         gxtre3oj9gaHUGm/Th5Z+RrYLAMR9t41FVqxdptoD0EfMElmfg+mfIcSjjiAlCG1Q8
         F6ib3PFqKI8HkMf6cH9zMUgQx+xS4lZw+4SZhJAHsvhSKJMxqpe8SWlp+rkTTPcARU
         rgkgxa8ok+hwcm3R3hxDGHcW9z9CkJbNCz5GgsdgFULRp0BKfnB7L+o4Ah3Q4IEpDv
         yLCEMJc5/jP6uX9OP4putao1IdpIMpLlNdVCooFMFUXfERqUWo/vmuTNFt6T/isVNI
         ex2/gPcIp+0JYSSDMPR959GYTVtQuiBoxJw6EaR9sDzUOeMjzrv59VTpYzMLejl0tt
         /lVnrLuA1IeWNPjz9F6SK3TbsjJ/IRxvDsCcAKkUNE3Es1mQ0fw
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 11/15] t4038: abstract away SHA-1 specific constants
Date:   Mon, 28 Oct 2019 00:59:03 +0000
Message-Id: <20191028005907.24985-12-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665
In-Reply-To: <20191028005907.24985-1-sandals@crustytoothpaste.net>
References: <20191028005907.24985-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Compute several object IDs that exist in expected output, since we don't
care about the specific object IDs, only that the format of the output
is syntactically correct.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4038-diff-combined.sh | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
index b9d876efa2..b5a56895e8 100755
--- a/t/t4038-diff-combined.sh
+++ b/t/t4038-diff-combined.sh
@@ -440,11 +440,13 @@ test_expect_success 'setup for --combined-all-paths' '
 	git branch side2c &&
 	git checkout side1c &&
 	test_seq 1 10 >filename-side1c &&
+	side1cf=$(git hash-object filename-side1c) &&
 	git add filename-side1c &&
 	git commit -m with &&
 	git checkout side2c &&
 	test_seq 1 9 >filename-side2c &&
 	echo ten >>filename-side2c &&
+	side2cf=$(git hash-object filename-side2c) &&
 	git add filename-side2c &&
 	git commit -m iam &&
 	git checkout -b mergery side1c &&
@@ -452,13 +454,14 @@ test_expect_success 'setup for --combined-all-paths' '
 	git rm filename-side1c &&
 	echo eleven >>filename-side2c &&
 	git mv filename-side2c filename-merged &&
+	mergedf=$(git hash-object filename-merged) &&
 	git add filename-merged &&
 	git commit
 '
 
 test_expect_success '--combined-all-paths and --raw' '
-	cat <<-\EOF >expect &&
-	::100644 100644 100644 f00c965d8307308469e537302baa73048488f162 088bd5d92c2a8e0203ca8e7e4c2a5c692f6ae3f7 333b9c62519f285e1854830ade0fe1ef1d40ee1b RR	filename-side1c	filename-side2c	filename-merged
+	cat <<-EOF >expect &&
+	::100644 100644 100644 $side1cf $side2cf $mergedf RR	filename-side1c	filename-side2c	filename-merged
 	EOF
 	git diff-tree -c -M --raw --combined-all-paths HEAD >actual.tmp &&
 	sed 1d <actual.tmp >actual &&
@@ -482,11 +485,13 @@ test_expect_success FUNNYNAMES 'setup for --combined-all-paths with funny names'
 	git checkout side1d &&
 	test_seq 1 10 >"$(printf "file\twith\ttabs")" &&
 	git add file* &&
+	side1df=$(git hash-object *tabs) &&
 	git commit -m with &&
 	git checkout side2d &&
 	test_seq 1 9 >"$(printf "i\tam\ttabbed")" &&
 	echo ten >>"$(printf "i\tam\ttabbed")" &&
 	git add *tabbed &&
+	side2df=$(git hash-object *tabbed) &&
 	git commit -m iam &&
 	git checkout -b funny-names-mergery side1d &&
 	git merge --no-commit side2d &&
@@ -494,12 +499,14 @@ test_expect_success FUNNYNAMES 'setup for --combined-all-paths with funny names'
 	echo eleven >>"$(printf "i\tam\ttabbed")" &&
 	git mv "$(printf "i\tam\ttabbed")" "$(printf "fickle\tnaming")" &&
 	git add fickle* &&
-	git commit
+	headf=$(git hash-object fickle*) &&
+	git commit &&
+	head=$(git rev-parse HEAD)
 '
 
 test_expect_success FUNNYNAMES '--combined-all-paths and --raw and funny names' '
-	cat <<-\EOF >expect &&
-	::100644 100644 100644 f00c965d8307308469e537302baa73048488f162 088bd5d92c2a8e0203ca8e7e4c2a5c692f6ae3f7 333b9c62519f285e1854830ade0fe1ef1d40ee1b RR	"file\twith\ttabs"	"i\tam\ttabbed"	"fickle\tnaming"
+	cat <<-EOF >expect &&
+	::100644 100644 100644 $side1df $side2df $headf RR	"file\twith\ttabs"	"i\tam\ttabbed"	"fickle\tnaming"
 	EOF
 	git diff-tree -c -M --raw --combined-all-paths HEAD >actual.tmp &&
 	sed 1d <actual.tmp >actual &&
@@ -507,7 +514,7 @@ test_expect_success FUNNYNAMES '--combined-all-paths and --raw and funny names'
 '
 
 test_expect_success FUNNYNAMES '--combined-all-paths and --raw -and -z and funny names' '
-	printf "aaf8087c3cbd4db8e185a2d074cf27c53cfb75d7\0::100644 100644 100644 f00c965d8307308469e537302baa73048488f162 088bd5d92c2a8e0203ca8e7e4c2a5c692f6ae3f7 333b9c62519f285e1854830ade0fe1ef1d40ee1b RR\0file\twith\ttabs\0i\tam\ttabbed\0fickle\tnaming\0" >expect &&
+	printf "$head\0::100644 100644 100644 $side1df $side2df $headf RR\0file\twith\ttabs\0i\tam\ttabbed\0fickle\tnaming\0" >expect &&
 	git diff-tree -c -M --raw --combined-all-paths -z HEAD >actual &&
 	test_cmp expect actual
 '
