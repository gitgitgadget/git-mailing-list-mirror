Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 789241FF40
	for <e@80x24.org>; Sat, 25 Jun 2016 06:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbcFYGrR (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 02:47:17 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:50878 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751081AbcFYGrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 02:47:16 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 637881FF40;
	Sat, 25 Jun 2016 06:46:47 +0000 (UTC)
Date:	Sat, 25 Jun 2016 06:46:47 +0000
From:	Eric Wong <e@80x24.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: [PATCH] gc: fix off-by-one error with gc.autoPackLimit
Message-ID: <20160625064647.GA20659@dcvr.yhbt.net>
References: <20160625011450.GA14293@dcvr.yhbt.net>
 <20160625020620.GA31290@sigill.intra.peff.net>
 <20160625025300.GA29053@dcvr.yhbt.net>
 <xmqqa8i9eqwn.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa8i9eqwn.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This matches the documentation and allows gc.autoPackLimit=1
to maintain a single pack without attempting a repack on every
"git gc --auto" invocation.

Signed-off-by: Eric Wong <e@80x24.org>
---
 builtin/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index c583aad..332bcf7 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -177,7 +177,7 @@ static int too_many_packs(void)
 		 */
 		cnt++;
 	}
-	return gc_auto_pack_limit <= cnt;
+	return gc_auto_pack_limit < cnt;
 }
 
 static void add_repack_all_option(void)
-- 
EW
