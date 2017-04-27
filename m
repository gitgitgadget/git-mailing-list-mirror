Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F49F1FC3E
	for <e@80x24.org>; Thu, 27 Apr 2017 03:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938229AbdD0DZJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 23:25:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:40966 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934492AbdD0DZH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 23:25:07 -0400
Received: (qmail 13742 invoked by uid 109); 27 Apr 2017 03:25:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Apr 2017 03:25:06 +0000
Received: (qmail 29038 invoked by uid 111); 27 Apr 2017 03:25:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 26 Apr 2017 23:25:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Apr 2017 23:25:04 -0400
Date:   Wed, 26 Apr 2017 23:25:04 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/3] fix memory leak in git-am
Message-ID: <20170427032503.rgz3bnctnxdn3hin@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was noticed by Coverity. The leak isn't new, but I think was
"re-found" by Coverity because some nearby code did an unrelated
s/sha1/oid/ change, throwing off its heuristics.

I also checked whether this was in Dscho's big pack of Coverity fixups
from earlier today, and it's not.

The first one is the actual fix. The second one is pure cleanup, but I
think worth doing. The final one is arguably just churn, and maybe
people even like the end result less. I'm OK to drop it.

  [1/3]: am: fix commit buffer leak in get_commit_info()
  [2/3]: am: simplify allocations in get_commit_info()
  [3/3]: am: shorten ident_split variable name in get_commit_info()

 builtin/am.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

-Peff
