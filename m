Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59ED81F45F
	for <e@80x24.org>; Thu,  9 May 2019 21:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfEIVak (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 17:30:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:53690 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726219AbfEIVaj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 17:30:39 -0400
Received: (qmail 10074 invoked by uid 109); 9 May 2019 21:30:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 May 2019 21:30:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6509 invoked by uid 111); 9 May 2019 21:31:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 09 May 2019 17:31:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 May 2019 17:30:37 -0400
Date:   Thu, 9 May 2019 17:30:37 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 07/14] mktree: drop unused length parameter
Message-ID: <20190509213037.GG15837@sigill.intra.peff.net>
References: <20190509212558.GA15438@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190509212558.GA15438@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The mktree_line() function does not actually look at the "len" parameter
it is passed, and assumes the buffer it receives is NUL-terminated.
Since the caller always passes a strbuf, this will be true. Let's drop
the useless parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/mktree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/mktree.c b/builtin/mktree.c
index 94e82b8504..891991b00d 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -67,7 +67,7 @@ static const char *mktree_usage[] = {
 	NULL
 };
 
-static void mktree_line(char *buf, size_t len, int nul_term_line, int allow_missing)
+static void mktree_line(char *buf, int nul_term_line, int allow_missing)
 {
 	char *ptr, *ntr;
 	const char *p;
@@ -172,7 +172,7 @@ int cmd_mktree(int ac, const char **av, const char *prefix)
 					break;
 				die("input format error: (blank line only valid in batch mode)");
 			}
-			mktree_line(sb.buf, sb.len, nul_term_line, allow_missing);
+			mktree_line(sb.buf, nul_term_line, allow_missing);
 		}
 		if (is_batch_mode && got_eof && used < 1) {
 			/*
-- 
2.21.0.1382.g4c6032d436

