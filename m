Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FE4820966
	for <e@80x24.org>; Fri, 31 Mar 2017 01:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935037AbdCaBkI (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 21:40:08 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:59196 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934971AbdCaBkH (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Mar 2017 21:40:07 -0400
Received: from genre.crustytoothpaste.net (unknown [172.16.2.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 42251280AE;
        Fri, 31 Mar 2017 01:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1490924405;
        bh=UeFGT0fLVZ+xTbIBrs65peWY7O4nzaXhG337HIraDPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VSksVdsqJilFkx25n7nTlPvqFHnFeSSF5buMqkeHq4vOkO1bwFgMcO7hYGpdJbahk
         +J9FDGUdXnigrk94hOHT/z7wbu84uFOs5s300tJqz6E1rp+JVg2vTV51EWhjgBspK2
         JBvs/vyroMjjKorZ1G3IqZfbeQZIH221rVGWVpvfHzqIBrA7EBX9C3Hk5vTIL3L3rK
         RHEuVCIduDtuRNrU047iu+J27lDgHlVL2SSNRdKtm47msbrRhbOiUCYFPxY5SwfCBj
         gJHGaE6KW/ivFi2HtF4zmEtGv36CSvUlzC8OMMwgEtpfPCOv3WB+3bbVS+/+BPvMJC
         adFA2i/YvAQKGVi+/DABM5x2dXyeeobfbubLsQin7mgFbzFAsttLfq/+00gG36SqJC
         mJg4/Kmj9ojjIUnd6uSlGO9zNj7x38IBGkhkIVq788zp0BcFslkTYiLEGrHFvLfbp+
         XnpZvDlir09Jvp6M00kCGBWXjUVnrwVg5u58OyltcuwBZ1hZ7rZ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 01/20] Define new hash-size constants for allocating memory
Date:   Fri, 31 Mar 2017 01:39:42 +0000
Message-Id: <20170331014001.953484-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170331014001.953484-1-sandals@crustytoothpaste.net>
References: <20170331014001.953484-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since we will want to transition to a new hash at some point in the
future, and that hash may be larger in size than 160 bits, introduce two
constants that can be used for allocating a sufficient amount of memory.
They can be increased to reflect the largest supported hash size.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 cache.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index db4120c233..02b6c753a3 100644
--- a/cache.h
+++ b/cache.h
@@ -66,8 +66,12 @@ unsigned long git_deflate_bound(git_zstream *, unsigned long);
 #define GIT_SHA1_RAWSZ 20
 #define GIT_SHA1_HEXSZ (2 * GIT_SHA1_RAWSZ)
 
+/* The length in byte and in hex digits of the largest possible hash value. */
+#define GIT_MAX_RAWSZ GIT_SHA1_RAWSZ
+#define GIT_MAX_HEXSZ GIT_SHA1_HEXSZ
+
 struct object_id {
-	unsigned char hash[GIT_SHA1_RAWSZ];
+	unsigned char hash[GIT_MAX_RAWSZ];
 };
 
 #if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
