Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17E251F404
	for <e@80x24.org>; Tue,  9 Jan 2018 07:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933386AbeAIHUr (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 02:20:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:38260 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933076AbeAIHUq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 02:20:46 -0500
Received: (qmail 4479 invoked by uid 109); 9 Jan 2018 07:20:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 09 Jan 2018 07:20:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2388 invoked by uid 111); 9 Jan 2018 07:21:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 09 Jan 2018 02:21:19 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Jan 2018 02:20:44 -0500
Date:   Tue, 9 Jan 2018 02:20:44 -0500
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Ben Peart <peartben@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 0/4] Add --no-ahead-behind to status
Message-ID: <20180109072044.GD32257@sigill.intra.peff.net>
References: <20180108154822.54829-1-git@jeffhostetler.com>
 <7b759564-5544-8845-0594-e8342a0b4ba5@gmail.com>
 <8affe37c-d937-d7e0-fe06-cf7c8db173fa@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8affe37c-d937-d7e0-fe06-cf7c8db173fa@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 08, 2018 at 03:04:20PM -0500, Jeff Hostetler wrote:

> > I was thinking about something similar to the logic we use today
> > about whether to start reporting progress on other long commands.
> > That would mean you could still get the ahead/behind values if you
> > aren't that far behind but would only get "different" if that
> > calculation gets too expensive (which implies the actual value isn't
> > going to be all that helpful anyway).
> 
> After a off-line conversation with the others I'm going to look into
> a version that is limited to n commits rather than be completely on or
> off.  I think if you are for example less than 100 a/b then those numbers
> have value; if you are past n, then they have much less value.
> 
> I'd rather do it by a fixed limit than by time to ensure that output
> is predictable on graph shape and not on system load.

I like this direction a lot. I had hoped we could say "100+ commits
ahead", but I don't think we can do so accurately without generation
numbers. E.g., the case I mentioned at the bottom of this mail:

  https://public-inbox.org/git/20171224143318.GC23648@sigill.intra.peff.net/

I haven't thought too hard on it, but I suspect with generation numbers
you could bound it and at least say "100+ ahead" or "100+ behind". But I
don't think you can approximate both ahead and behind together without
finding the actual merge base.

But even still, finding small answers quickly and accurately and punting
to "really far, I didn't bother to compute it" on the big ones would be
an improvement over always punting.

-Peff
