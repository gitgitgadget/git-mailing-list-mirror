Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A12FF1F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932702AbeDWXmJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:42:09 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60532 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932635AbeDWXkS (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Apr 2018 19:40:18 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3B53E60B36;
        Mon, 23 Apr 2018 23:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524526816;
        bh=qe53ZDwYRHRoITKi4Aoqbd+KWqcGHFysM2yqOOY3EmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=NKC3WQUJegOHnMjYhQMFXoVNsi6o1c9DdPOjUmtlZ5WW8FKoLgajUd36K04+0h3ow
         fgRZcYeeYvkemi1Ywq+uUqgc4N7DpP9bgjjupnEvf4Z8TVVLXIkJlHVC5H+KewIYTc
         AN7YnYMwT5nIq9aQKHIQSORAlVT+fvMUGhBddb+DDD+QanswVsHyHzh6PzhvTs0vLf
         symg+47xm7PvH8ira50T/HwlvIDf+udoA0Hs11LBICUEh+3l7F9a6c1SRjycyTRUNP
         M9Y7/3Rtx4UT9y6OCzZ6GphrpJIFUU2jXk9lwVFbpUvi0i3RcBsiBCIdqGheT1o9/i
         JqCdUZIZ7XxSR4SKCsFJhJZ9bkQuZKdDY46ml2KPcdlFbC4pM2B31gZH/pf1dgnhc4
         5A5zjSgAEiNcQ6iaG1kubs/H6dh4h1nz9q9O1o9re2SrkWilHWZkklz1CxDaCG8myL
         rcmyHOB3G8Z1kKWHI5yapzbMIY1BFyZv5Sa/b8/CXAZRCUSa/wv
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 11/41] tree-walk: avoid hard-coded 20 constant
Date:   Mon, 23 Apr 2018 23:39:21 +0000
Message-Id: <20180423233951.276447-12-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180423233951.276447-1-sandals@crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
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
 
