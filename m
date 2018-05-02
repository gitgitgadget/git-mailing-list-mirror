Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D9E221847
	for <e@80x24.org>; Wed,  2 May 2018 00:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753415AbeEBA0e (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 20:26:34 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37682 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751925AbeEBA0c (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 May 2018 20:26:32 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 80C1B60B12;
        Wed,  2 May 2018 00:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525220791;
        bh=qe53ZDwYRHRoITKi4Aoqbd+KWqcGHFysM2yqOOY3EmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=O0GVOL3He2ujZJjElIs8CwthZGsqab/zBuDKwttFqFa3ZSM4tHZT9xeP/1f8z7Pxe
         w2NWlQ8JdAHsIY8zkoDGW+jaiE6EJrEIsdXFhu17NA/VA1gOYqMbUKNsI8nhNRc7Sd
         4tu05yPiw2RyLbEuq7amaitUCuFNpRUXGsuyXb/u9VNWniPrQ3E9p/R3iMTLUvSFFX
         BPKDg1W5xlwQFtLoRHXE1zM5dvJkm6s23Zeu87036uX2B2JJIgUNfhpbG4/df5OFvq
         lRawIRNhfHYjub4XY1S3s9PWuhou/au6Fn8tbiEX7OF+ZwyiizC3VdcHhaMyJkWBFA
         tDICE7DRsCBtYkESWQ3IXKj6+LkqCIao6tmYRq8txIFr+BYoObjZwe/0GW/6CXYjyR
         wphD7YbuLp990qtp0P2sPDTqv8i+2KplNQKAINqa5YsazNQ6hA3QXaLGnd1D3xm772
         VrsX+MTOHIVEeR77uT7gZ2a0Xir67n1VjTjxHIs+MlG+HHBGiLt
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 11/42] tree-walk: avoid hard-coded 20 constant
Date:   Wed,  2 May 2018 00:25:39 +0000
Message-Id: <20180502002610.915892-12-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180502002610.915892-1-sandals@crustytoothpaste.net>
References: <20180502002610.915892-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the_hash_algo to look up the length of our current hash instead of
hard-coding the value 20.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 tree-walk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tree-walk.c b/tree-walk.c
index e11b3063af..27797c5406 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -105,7 +105,7 @@ static void entry_extract(struct tree_desc *t, struct name_entry *a)
 static int update_tree_entry_internal(struct tree_desc *desc, struct strbuf *err)
 {
 	const void *buf = desc->buffer;
-	const unsigned char *end = desc->entry.oid->hash + 20;
+	const unsigned char *end = desc->entry.oid->hash + the_hash_algo->rawsz;
 	unsigned long size = desc->size;
 	unsigned long len = end - (const unsigned char *)buf;
 
