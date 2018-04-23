Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04C411F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932652AbeDWXlQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:41:16 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60662 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932781AbeDWXko (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Apr 2018 19:40:44 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2CAEA60B12;
        Mon, 23 Apr 2018 23:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524526843;
        bh=pyqlJQGFubPK6DP1fI76k21mYRCGGBBxFmy+DWtPp+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=iljgGxdiI2pyKcURUZqtfiPMWG7U+cp5AbSJuQuPUUcyof9UyTfRGX6d0q5rRfGuW
         zQoX0Mc8+4S7W+1J5PqC6lkKCiFPEvIqJm0sx+QatStoQRd0mvDsOt28qn4QE14tmp
         Q0iPzRmh45+WuddB9cstWWmJklOxefE3a1WWPsi9U3UZe7n3jxa653Vpey5O3sjNVN
         pIWkKNe2d6lmWw2DvIF1VqTeZWG1iYWZEc3jzAS2ym4PpYeeBnpzJIFBLWCFeW+jrv
         O/lTapD7hc+SQAgkP5yWedglRlprgF/HkiugTxncF5H4JhFseXCDwr6BAXxBhk9MIV
         EvPkWF7+LgdLbBsa4q9prOn0NrCMT7LzmE2UBiFB1rIZwTwxJiB7JHn9Q03/iPlqDr
         vplEhkH05N21jRVHg5CTtIk/Wc9AhtViN2Jn06V05Hc/WdOWXE1XXM6FhpDtQLOJQd
         5WjFGg7UBbKssi07cSrNVl/uDh/BqEN0yA65ygX/fd3Jzgi6JQr
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 35/41] cache-tree: use is_empty_tree_oid
Date:   Mon, 23 Apr 2018 23:39:45 +0000
Message-Id: <20180423233951.276447-36-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180423233951.276447-1-sandals@crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When comparing an object ID against that of the empty tree, use the
is_empty_tree_oid function to ensure that we abstract over the hash
algorithm properly.  In addition, this is more readable than a plain
oidcmp.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 cache-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cache-tree.c b/cache-tree.c
index 8c7e1258a4..25663825b5 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -385,7 +385,7 @@ static int update_one(struct cache_tree *it,
 		/*
 		 * "sub" can be an empty tree if all subentries are i-t-a.
 		 */
-		if (contains_ita && !oidcmp(oid, &empty_tree_oid))
+		if (contains_ita && is_empty_tree_oid(oid))
 			continue;
 
 		strbuf_grow(&buffer, entlen + 100);
