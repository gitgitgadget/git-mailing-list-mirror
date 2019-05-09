Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6C571F45F
	for <e@80x24.org>; Thu,  9 May 2019 21:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfEIVbS (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 17:31:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:53702 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726219AbfEIVbS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 17:31:18 -0400
Received: (qmail 10091 invoked by uid 109); 9 May 2019 21:31:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 May 2019 21:31:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6542 invoked by uid 111); 9 May 2019 21:31:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 09 May 2019 17:31:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 May 2019 17:31:16 -0400
Date:   Thu, 9 May 2019 17:31:16 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 09/14] pack-objects: drop unused rev_info parameters
Message-ID: <20190509213116.GI15837@sigill.intra.peff.net>
References: <20190509212558.GA15438@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190509212558.GA15438@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When collecting the list of objects to pack in get_object_list(), we
pass our rev_info struct around to some functions that don't need it.
This is due to 03a9683d22 (Simplify is_kept_pack(), 2009-02-28), where
the kept-pack handling was moved out of the revision machinery.

Let's drop these unused parameters.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/pack-objects.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index d7743f110b..fea757fea2 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2899,7 +2899,7 @@ static int ofscmp(const void *a_, const void *b_)
 		return oidcmp(&a->object->oid, &b->object->oid);
 }
 
-static void add_objects_in_unpacked_packs(struct rev_info *revs)
+static void add_objects_in_unpacked_packs(void)
 {
 	struct packed_git *p;
 	struct in_pack in_pack;
@@ -3011,7 +3011,7 @@ static int loosened_object_can_be_discarded(const struct object_id *oid,
 	return 1;
 }
 
-static void loosen_unused_packed_objects(struct rev_info *revs)
+static void loosen_unused_packed_objects(void)
 {
 	struct packed_git *p;
 	uint32_t i;
@@ -3158,11 +3158,11 @@ static void get_object_list(int ac, const char **av)
 	}
 
 	if (keep_unreachable)
-		add_objects_in_unpacked_packs(&revs);
+		add_objects_in_unpacked_packs();
 	if (pack_loose_unreachable)
 		add_unreachable_loose_objects();
 	if (unpack_unreachable)
-		loosen_unused_packed_objects(&revs);
+		loosen_unused_packed_objects();
 
 	oid_array_clear(&recent_objects);
 }
-- 
2.21.0.1382.g4c6032d436

