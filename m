Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29ED01F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 00:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbfJ1A7i (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Oct 2019 20:59:38 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54320 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729001AbfJ1A7f (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 27 Oct 2019 20:59:35 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5765B61CAF;
        Mon, 28 Oct 2019 00:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1572224374;
        bh=na4mlvcxbHZ7355PqSw5f5f4BecqYOhtOH90JBEPPyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=BtGnHQkaX5u+TLOog3KJDyh2f5Mg2XTWq6nDmb0FalVRPyu6rgo+O79ZK2Ysu8Aos
         5YVCDjHXd0HxpfxXS+g6DwXnEVhqn6ypUbs+cLf8OwEUzHlfet3+aOrXtCt4WbmK48
         KiBmPHZczeLiPdxqL0c6b7WNAB7Un8IQ2SLNyYXZ10o3CmQYxn26QPgmEGRCFl9LrS
         iFkkrERnbwNEsmDDhtQB3e3/GtE0qmvhkK8z6Cr95/z/QbvAWlKsqav1lxKAIf3eSt
         KvbkVIJOnOlvkL+XuaetSCbwWrzYdOguFLpOW0Wq/jBf3LdNK8CJst+PX7/TW2UluY
         7y0whkxs2LqqusaR3oFEeVqUU21qSpIODlBomDIrCT8xDX8yprDbxcm873NVZkGXu2
         aiEVQVOrn0mXqUVGjGqLe0lQUkeB/3YPrJEhkXdDlwrJ0fvgSojyH2eFI3ct94ItGM
         xw9RK9HSUYYdjO+/yHVOAWlwJzOZWeaO1Cmrqru27l8YcRV9DQ6
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 12/15] t4039: abstract away SHA-1-specific constants
Date:   Mon, 28 Oct 2019 00:59:04 +0000
Message-Id: <20191028005907.24985-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665
In-Reply-To: <20191028005907.24985-1-sandals@crustytoothpaste.net>
References: <20191028005907.24985-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it computes variables for object IDs instead of
using hard-coded hashes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4039-diff-assume-unchanged.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t4039-diff-assume-unchanged.sh b/t/t4039-diff-assume-unchanged.sh
index 53ac44b0f0..0eb0314a8b 100755
--- a/t/t4039-diff-assume-unchanged.sh
+++ b/t/t4039-diff-assume-unchanged.sh
@@ -12,6 +12,7 @@ test_expect_success 'setup' '
 	git commit -m zero &&
 	echo one > one &&
 	echo two > two &&
+	blob=$(git hash-object one) &&
 	git add one two &&
 	git commit -m onetwo &&
 	git update-index --assume-unchanged one &&
@@ -20,7 +21,7 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'diff-index does not examine assume-unchanged entries' '
-	git diff-index HEAD^ -- one | grep -q 5626abf0f72e58d7a153368ba57db4c673c0e171
+	git diff-index HEAD^ -- one | grep -q $blob
 '
 
 test_expect_success 'diff-files does not examine assume-unchanged entries' '
