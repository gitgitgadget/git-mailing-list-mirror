Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B5CC433DF
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 20:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67086206D7
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 20:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgG2UKS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 16:10:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:41468 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgG2UKS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 16:10:18 -0400
Received: (qmail 8780 invoked by uid 109); 29 Jul 2020 20:10:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 Jul 2020 20:10:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7784 invoked by uid 111); 29 Jul 2020 20:10:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Jul 2020 16:10:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 29 Jul 2020 16:10:17 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: [PATCH v2 1/7] log: drop "--cc implies -m" logic
Message-ID: <20200729201017.GA2989342@coredump.intra.peff.net>
References: <20200729201002.GA2989059@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200729201002.GA2989059@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was added by 82dee4160c (log: show merge commit when --cc is given,
2015-08-20), which explains why we need it. But that commit failed to
notice that setup_revisions() already does the same thing, since
cd2bdc5309 (Common option parsing for "git log --diff" and friends,
2006-04-14).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/log.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index d104d5c688..281d2ae8eb 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -731,10 +731,6 @@ static void log_setup_revisions_tweak(struct rev_info *rev,
 	/* Turn --cc/-c into -p --cc/-c when -p was not given */
 	if (!rev->diffopt.output_format && rev->combine_merges)
 		rev->diffopt.output_format = DIFF_FORMAT_PATCH;
-
-	/* Turn -m on when --cc/-c was given */
-	if (rev->combine_merges)
-		rev->ignore_merges = 0;
 }
 
 int cmd_log(int argc, const char **argv, const char *prefix)
-- 
2.28.0.465.gd2839157e3

