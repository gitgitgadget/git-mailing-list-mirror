Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F4D821847
	for <e@80x24.org>; Wed,  2 May 2018 00:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753682AbeEBA2J (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 20:28:09 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37732 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753435AbeEBA0l (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 May 2018 20:26:41 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5562260B3A;
        Wed,  2 May 2018 00:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525220799;
        bh=VsUX46KiJyh5qzryPMHq1G7jioKc79El1V5RRGJSFHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=OAjwpAzDdKj1csG+Jv45Coq3bMRrolBFToi58x8NX51EJTKUNMo/CMsdjNpQwgGHv
         RXGrSEMXRfglX3a5o0SF9TjRXlFr+XXW5WEqPB7LptBoHdMTVsXeSNgu/CHi1cFcYR
         3AEMvACIwGNNfmAXcPLmcZbkdkzTx+DINdLOlCVeoXe38eIQGubmls8BFySu6vnRpI
         ZCnrJTp7Zh+D1JW6mYSjr2Vx41AjmbUWj/0Fbu1RmNzi+HouBKAaE0YZwvyPOAhdd2
         Bzh8Aq/C5WDQWcVgWSXnmZcqAmQUdoY/qJyhkeIFxFSFQ4CywjILwEBIvmu/cz90pm
         JIO5VBy6Aru16wXaL+ADqq79y5QOlVhuCQDP9Rdl5yz3d82I+BaSiptTGkdJSLTUKY
         RlE1EZR6wWHuL5wgSEvimyg8VshHmZ66qEVr3GwdV2GtZ9LT3JCeNVtgvg+TMdgnh8
         xzGAb359HuqmSTNqYW1oieIDyKf7wXHH6I16v8lrzjKs9L/keJt
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 19/42] commit: convert uses of get_sha1_hex to get_oid_hex
Date:   Wed,  2 May 2018 00:25:47 +0000
Message-Id: <20180502002610.915892-20-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180502002610.915892-1-sandals@crustytoothpaste.net>
References: <20180502002610.915892-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 commit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/commit.c b/commit.c
index ca474a7c11..9617f85caa 100644
--- a/commit.c
+++ b/commit.c
@@ -331,7 +331,7 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
 	if (tail <= bufptr + tree_entry_len + 1 || memcmp(bufptr, "tree ", 5) ||
 			bufptr[tree_entry_len] != '\n')
 		return error("bogus commit object %s", oid_to_hex(&item->object.oid));
-	if (get_sha1_hex(bufptr + 5, parent.hash) < 0)
+	if (get_oid_hex(bufptr + 5, &parent) < 0)
 		return error("bad tree pointer in commit %s",
 			     oid_to_hex(&item->object.oid));
 	item->tree = lookup_tree(&parent);
@@ -343,7 +343,7 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
 		struct commit *new_parent;
 
 		if (tail <= bufptr + parent_entry_len + 1 ||
-		    get_sha1_hex(bufptr + 7, parent.hash) ||
+		    get_oid_hex(bufptr + 7, &parent) ||
 		    bufptr[parent_entry_len] != '\n')
 			return error("bad parents in commit %s", oid_to_hex(&item->object.oid));
 		bufptr += parent_entry_len + 1;
