Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7786A1F406
	for <e@80x24.org>; Wed, 16 May 2018 01:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbeEPB7B (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 21:59:01 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47504 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752535AbeEPB67 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 15 May 2018 21:58:59 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7CCAE60443;
        Wed, 16 May 2018 01:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526435938;
        bh=BORmHYPFuqumfjsX2p/cFhBXuKfD/RDRI40/vp9kBN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=TOTHPkwIZ+O44yrGNw2J3Vl4W8vegpWifDf8RKZDjMuazW2Dwq6oRoyQZEUDhsgcV
         tWvK4Vrh3GnLwYXiREzSNM0V5DCfF1IaBlkkJXSicp574gYwMSDXOTwj+M24lBuon5
         lued5uXRPbk/tZmJvPcII69MKV1LU9ll480CmPHLBQNFbJcvHKla8gA0SMX86Yvy/r
         y6V1uR1OJDy4dRs5+qDNZ+9oRfIeVmG1eSR6cKCLbxS/ZF/E4fewtFlTiSL/JL63OE
         sH3jfVDgtOrBUt0ZCZwjFAsabGsxKIkjn/Jr22y5J+susTifXewyil4Z9SAxj9u8Io
         whgYk46YtUFjeF+nPYpsvXD5Uyc76wfgLZIbdnC8NxERSElexP1IW9g+Vj5IwoJfzA
         NFUwn1RmokHJKSXc5+BEvnnbr6H8dsbivNM29j+evpfX+ngglDhjpVUp2o5KMuMJpy
         cloaUWI9mR4vmtQLLElxPRCUMyWspI/fsNe2yq4Uc4vQE15gTo4
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 21/28] t4029: abstract away SHA-1-specific constants
Date:   Wed, 16 May 2018 01:56:23 +0000
Message-Id: <20180516015630.661349-22-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180516015630.661349-1-sandals@crustytoothpaste.net>
References: <20180516015630.661349-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it computes variables for blobs instead of using
hard-coded hashes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4029-diff-trailing-space.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/t/t4029-diff-trailing-space.sh b/t/t4029-diff-trailing-space.sh
index f4e18cb8d3..32b6e9a4e7 100755
--- a/t/t4029-diff-trailing-space.sh
+++ b/t/t4029-diff-trailing-space.sh
@@ -6,7 +6,7 @@ test_description='diff honors config option, diff.suppressBlankEmpty'
 
 . ./test-lib.sh
 
-cat <<\EOF > exp ||
+cat <<\EOF >expected ||
 diff --git a/f b/f
 index 5f6a263..8cb8bae 100644
 --- a/f
@@ -20,9 +20,14 @@ exit 1
 
 test_expect_success "$test_description" '
 	printf "\nx\n" > f &&
+	before=$(git hash-object f) &&
+	before=$(git rev-parse --short $before) &&
 	git add f &&
 	git commit -q -m. f &&
 	printf "\ny\n" > f &&
+	after=$(git hash-object f) &&
+	after=$(git rev-parse --short $after) &&
+	sed -e "s/^index .*/index $before..$after 100644/" expected >exp &&
 	git config --bool diff.suppressBlankEmpty true &&
 	git diff f > actual &&
 	test_cmp exp actual &&
