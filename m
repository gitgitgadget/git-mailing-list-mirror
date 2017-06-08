Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6C5C1F8CF
	for <e@80x24.org>; Thu,  8 Jun 2017 07:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751545AbdFHHFk (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 03:05:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:36359 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751450AbdFHHFk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 03:05:40 -0400
Received: (qmail 27297 invoked by uid 109); 8 Jun 2017 07:05:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Jun 2017 07:05:39 +0000
Received: (qmail 9876 invoked by uid 111); 8 Jun 2017 07:05:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Jun 2017 03:05:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Jun 2017 03:05:37 -0400
Date:   Thu, 8 Jun 2017 03:05:37 -0400
From:   Jeff King <peff@peff.net>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] fast-import: Increase the default pack depth to 50
Message-ID: <20170608070537.zgrcxhl57u4akzvq@sigill.intra.peff.net>
References: <20170608053436.9121-1-mh@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170608053436.9121-1-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 08, 2017 at 02:34:36PM +0900, Mike Hommey wrote:

> In 618e613a70, 10 years ago, the default for pack depth used for
> git-pack-objects and git-repack was changed from 10 to 50, while
> leaving fast-import's default to 10.
> 
> There doesn't seem to be a reason besides oversight for the change not
> having happened in fast-import as well.
> 
> Interestingly, fast-import uses pack.depth when it's set, and the
> git-config manual says the default for pack.depth is 50. While the
> git-fast-import manual does say the default depth is 10, the
> inconsistency is also confusing.

Makes sense. If anything, fast-import would want to allow a deeper depth
than normal, since (IIRC) its delta chains are always completely linear.
Whereas in a real pack, if we decide not to make a delta off the 50th
item in a chain, we usually find the 48th or 49th, and end up with a
bushier graph.

It probably doesn't matter that much, though, as you'd really want to
`repack -f` afterwards if you care about getting good deltas. And one
base object every 50 versions is probably fine for keeping the initial
pack manageable.

> ---
>  Documentation/git-fast-import.txt | 2 +-
>  fast-import.c                     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Patch itself looks obviously correct.

-Peff
