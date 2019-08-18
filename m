Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BC5E1F461
	for <e@80x24.org>; Sun, 18 Aug 2019 20:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfHRUF4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 16:05:56 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57988 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727219AbfHRUFo (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Aug 2019 16:05:44 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B57E460736;
        Sun, 18 Aug 2019 20:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566158743;
        bh=yVkNwXKVmBOGMgpOwth8StYIXrSjvFPScWO0MZalSoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=jn9r8IegN7kbWg3vasHli2678Ov05nqX3I4tOVHd9xc2HZgrPD5MVez0ytSNT2hI5
         G6p2bCPUOI3QoATwvIJOJ14BWCXMqR+66035XN/mPUHeB8B0WCdwz2pr12CDt2MR+f
         JJnqlSgZ06cdbju4SqhGbNXuJzaRfr9Dlf8R6twR6a/fTMnuxH3xQRB8sSQX1hkz1l
         nGOHYSbI9VaD50ZP/chNZEcHvjFbVkc44i8Yp62gaYVl3Ce5MKJbeTgCvfKsBqwUG3
         iz2cCJrCGhiOnBMB6GdKWHH2WN13rr5LIdlMPNkoJOD7C5P2DQABVlpiJA2oEkg9kO
         a2zdRMAxIWKvxMB8SI6oNzzIFraQTIxLwJ4sbAPHnJzBm7gf2/Ezyhm/dRhM3Rtpy7
         O/kI31QmlW/LaB9ZrpdIAsSGUSKrCpuBbUWwhImdN0jod9HmBxr1xyr4oD6A6bk/7y
         SEAuwJedb8uUZgX/My3tuo4xzDrVivmsDKa0GPxulcdpzJFlXmh
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 14/26] bisect: switch to using the_hash_algo
Date:   Sun, 18 Aug 2019 20:04:15 +0000
Message-Id: <20190818200427.870753-15-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.rc1.170.gbd704faa3e
In-Reply-To: <20190818200427.870753-1-sandals@crustytoothpaste.net>
References: <20190818200427.870753-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using GIT_SHA1_HEXSZ, use the_hash_algo so that the code is
hash size independent.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 bisect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bisect.c b/bisect.c
index e87ac29a51..e81c91d02c 100644
--- a/bisect.c
+++ b/bisect.c
@@ -707,7 +707,7 @@ static int bisect_checkout(const struct object_id *bisect_rev, int no_checkout)
 {
 	char bisect_rev_hex[GIT_MAX_HEXSZ + 1];
 
-	memcpy(bisect_rev_hex, oid_to_hex(bisect_rev), GIT_SHA1_HEXSZ + 1);
+	memcpy(bisect_rev_hex, oid_to_hex(bisect_rev), the_hash_algo->hexsz + 1);
 	update_ref(NULL, "BISECT_EXPECTED_REV", bisect_rev, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
 
 	argv_checkout[2] = bisect_rev_hex;
