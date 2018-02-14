Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0655B1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 18:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161610AbeBNSG7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 13:06:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:52272 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1161585AbeBNSG7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 13:06:59 -0500
Received: (qmail 29284 invoked by uid 109); 14 Feb 2018 18:06:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 14 Feb 2018 18:06:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31013 invoked by uid 111); 14 Feb 2018 18:07:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 14 Feb 2018 13:07:43 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Feb 2018 13:06:57 -0500
Date:   Wed, 14 Feb 2018 13:06:57 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/6] test-hashmap: use xsnprintf rather than snprintf
Message-ID: <20180214180656.GC9919@sigill.intra.peff.net>
References: <20180214180322.GA9190@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180214180322.GA9190@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In general, using a bare snprintf can truncate the resulting
buffer, leading to confusing results. In this case we know
that our buffer is sized large enough to accommodate our
loop, so there's no bug. However, we should use xsnprintf()
to document (and check) that assumption, and to model good
practice to people reading the code.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/helper/test-hashmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
index 2100877c2b..28b913fbd6 100644
--- a/t/helper/test-hashmap.c
+++ b/t/helper/test-hashmap.c
@@ -87,7 +87,7 @@ static void perf_hashmap(unsigned int method, unsigned int rounds)
 	ALLOC_ARRAY(entries, TEST_SIZE);
 	ALLOC_ARRAY(hashes, TEST_SIZE);
 	for (i = 0; i < TEST_SIZE; i++) {
-		snprintf(buf, sizeof(buf), "%i", i);
+		xsnprintf(buf, sizeof(buf), "%i", i);
 		entries[i] = alloc_test_entry(0, buf, strlen(buf), "", 0);
 		hashes[i] = hash(method, i, entries[i]->key);
 	}
-- 
2.16.1.464.gc4bae515b7

