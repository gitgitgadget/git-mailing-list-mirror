Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8A3A1F4BD
	for <e@80x24.org>; Sat,  5 Oct 2019 21:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbfJEVMY (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Oct 2019 17:12:24 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36342 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726118AbfJEVMW (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 5 Oct 2019 17:12:22 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D4E3B61C64;
        Sat,  5 Oct 2019 21:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1570309942;
        bh=na4mlvcxbHZ7355PqSw5f5f4BecqYOhtOH90JBEPPyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=SNxVTcRV0e9IFfzyB16Y23u1pE9VTFirOmLzIpPWi5g2Pu4ugcsYvWJ5jvuZIbrrg
         NkRCbD6U1YECegaE+xQU6+/8J7XYpgX09FKv1bcCFnCpzapE8vxibsleeODlNN7ppr
         57Gy4MI8TNXHyzfuxfKyDeqym3qnMlPSmmNZdAGsq5EJFRGmh34Rmzi0C05h8qsf7l
         MhHkvb/oYirecWSaypiGQgl+/1u9/JWGApyv+mM4EVA7PGJj9PfAh5Nax2PatLOW2P
         QMm8cEzBBGa6fKT0KNEjYFbEHmEyMK6RUCpaWGSaUQxu52xoQK0V27xWRuMuGmymyo
         7zpeS+TdIOw2g4STAnzgp8MH3HtCVaO68drX5T42j1n1nSehZ1p1SyvUR2w6UYbI8L
         yIDqC2FrqgRWFsSQ+8V0JEs5vkwynq1HK1koo+QrHMcXMsPY7gYGKan1qais1yRrc3
         nXxSAHzi6AkpOrihT6+i1MwZG0XC+DEF8lf18GKKJu6u6MAjmxV
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 12/15] t4039: abstract away SHA-1-specific constants
Date:   Sat,  5 Oct 2019 21:12:06 +0000
Message-Id: <20191005211209.18237-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb
In-Reply-To: <20191005211209.18237-1-sandals@crustytoothpaste.net>
References: <20191005211209.18237-1-sandals@crustytoothpaste.net>
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
