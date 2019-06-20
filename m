Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C10CB1F462
	for <e@80x24.org>; Thu, 20 Jun 2019 07:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730690AbfFTHlk (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 03:41:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:45454 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726732AbfFTHlk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 03:41:40 -0400
Received: (qmail 16723 invoked by uid 109); 20 Jun 2019 07:41:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Jun 2019 07:41:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12990 invoked by uid 111); 20 Jun 2019 07:42:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 20 Jun 2019 03:42:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jun 2019 03:41:38 -0400
Date:   Thu, 20 Jun 2019 03:41:38 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 14/17] khash: drop sha1-specific map types
Message-ID: <20190620074138.GN3713@sigill.intra.peff.net>
References: <20190620073952.GA1539@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190620073952.GA1539@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All of the callers of khash_sha1 and khash_sha1_pos have been removed,
in favor of using maps that use "struct object_id" as their keys. Let's
drop these now-obsolete types.

Signed-off-by: Jeff King <peff@peff.net>
---
 khash.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/khash.h b/khash.h
index ae9f78347f..cb2cd3d7e4 100644
--- a/khash.h
+++ b/khash.h
@@ -324,14 +324,6 @@ static const double __ac_HASH_UPPER = 0.77;
 		code;												\
 	} }
 
-#define __kh_oid_cmp(a, b) (hashcmp(a, b) == 0)
-
-KHASH_INIT(sha1, const unsigned char *, void *, 1, sha1hash, __kh_oid_cmp)
-typedef kh_sha1_t khash_sha1;
-
-KHASH_INIT(sha1_pos, const unsigned char *, int, 1, sha1hash, __kh_oid_cmp)
-typedef kh_sha1_pos_t khash_sha1_pos;
-
 static inline unsigned int oid_hash(struct object_id oid)
 {
 	return sha1hash(oid.hash);
-- 
2.22.0.732.g5402924b4b

