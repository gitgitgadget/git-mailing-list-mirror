Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51EB31F461
	for <e@80x24.org>; Sun, 25 Aug 2019 08:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfHYIGm (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 04:06:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:54788 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725792AbfHYIGm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 04:06:42 -0400
Received: (qmail 11314 invoked by uid 109); 25 Aug 2019 08:06:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 25 Aug 2019 08:06:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10091 invoked by uid 111); 25 Aug 2019 08:08:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 25 Aug 2019 04:08:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 25 Aug 2019 04:06:41 -0400
From:   Jeff King <peff@peff.net>
To:     Mike Hommey <mh@glandium.org>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: [PATCH 0/2] fast-import input string handling bugs
Message-ID: <20190825080640.GA31453@sigill.intra.peff.net>
References: <20190825041348.31835-1-mh@glandium.org>
 <20190825065747.GA23806@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190825065747.GA23806@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 25, 2019 at 02:57:48AM -0400, Jeff King wrote:

> And I think this is actually a real bug in the current code! We keep a
> pointer to the encoding string, which survives because of the history.
> But that history is bounded, and we could have an indefinite number of
> changed files in the middle. If I modify t9300 like this:

Here are two patches. The first fixes the existing bug with "encoding",
and the second uses the approach I suggested to fix the leak you
noticed.

The second one does carry a greater risk of regression than your patch,
but I think it's worth it for the fact that it makes any other bugs
(like the "encoding" one) more obvious.

  [1/2]: fast-import: duplicate parsed encoding string
  [2/2]: fast-import: duplicate into history rather than passing ownership

 fast-import.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

-Peff
