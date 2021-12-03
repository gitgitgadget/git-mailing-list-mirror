Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916C8C433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 05:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349202AbhLCFOl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 00:14:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:42686 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236867AbhLCFOk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 00:14:40 -0500
Received: (qmail 21978 invoked by uid 109); 3 Dec 2021 05:11:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 Dec 2021 05:11:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28781 invoked by uid 111); 3 Dec 2021 05:11:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Dec 2021 00:11:18 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 3 Dec 2021 00:11:15 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: [PATCH 1/3] xdiff: drop CMP_ENV macro from xhistogram
Message-ID: <Yamm8xoakNHjEx0E@coredump.intra.peff.net>
References: <Yammtm+pIkMu43zZ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yammtm+pIkMu43zZ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This macro has been unused since 43ca7530df (xdiff/xhistogram: rely on
xdl_trim_ends(), 2011-08-01). The function that called it went away
there, and its use in the CMP() macro was inlined. It probably should
have been deleted then, but nobody noticed.

Signed-off-by: Jeff King <peff@peff.net>
---
This one isn't strictly enabled by Phillip's new patches, but it cleans
up an unused caller of cmp_recs() so we don't have to worry about it in
the next patch.

 xdiff/xhistogram.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
index 6c1c88a69a..399cc236d7 100644
--- a/xdiff/xhistogram.c
+++ b/xdiff/xhistogram.c
@@ -95,9 +95,6 @@ static int cmp_recs(xpparam_t const *xpp,
 
 }
 
-#define CMP_ENV(xpp, env, s1, l1, s2, l2) \
-	(cmp_recs(xpp, REC(env, s1, l1), REC(env, s2, l2)))
-
 #define CMP(i, s1, l1, s2, l2) \
 	(cmp_recs(i->xpp, REC(i->env, s1, l1), REC(i->env, s2, l2)))
 
-- 
2.34.1.436.g8c445b282e

