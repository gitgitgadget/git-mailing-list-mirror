Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E3FC1F859
	for <e@80x24.org>; Fri, 19 Aug 2016 13:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754174AbcHSNrK (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 09:47:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:58100 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751442AbcHSNrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 09:47:09 -0400
Received: (qmail 30851 invoked by uid 109); 19 Aug 2016 13:47:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Aug 2016 13:47:08 +0000
Received: (qmail 25544 invoked by uid 111); 19 Aug 2016 13:47:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Aug 2016 09:47:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Aug 2016 09:47:06 -0400
Date:   Fri, 19 Aug 2016 09:47:06 -0400
From:   Jeff King <peff@peff.net>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     git@vger.kernel.org
Subject: Re: upload-pack/ls-remote: showing non-HEAD symbolic refs?
Message-ID: <20160819134706.t2ejriomp3z3xqly@sigill.intra.peff.net>
References: <20160816161838.klvjhhoxsftvkfmd@x>
 <20160816163145.mjc726til2daxl3d@sigill.intra.peff.net>
 <20160816173444.rpqlpsz2ognvlufy@x>
 <20160816182852.inyqzplee5m3wzt6@sigill.intra.peff.net>
 <20160816203150.GA16774@cloud>
 <20160816205426.dotqythoyn7zztma@sigill.intra.peff.net>
 <20160816211141.GA16922@cloud>
 <20160816211551.fjobjxcqvo2dfiry@sigill.intra.peff.net>
 <20160816222414.GA17195@cloud>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160816222414.GA17195@cloud>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 16, 2016 at 03:24:14PM -0700, Josh Triplett wrote:

> > But if we had a real full-duplex connection over https, I think there
> > would be no reason for git:// to continue existing (we'd probably keep
> > ssh as it's a useful protocol for authentication, though).
> 
> Agreed.
> 
> Using ALPN wouldn't actually end up using HTTPS; it would negotiate with
> the server and end up connected directly to a git program speaking an
> arbitrary protocol over TLS.  Many web servers already support ALPN to
> negotiate HTTP/2, so this seems plausible.

It sounds like that would lose one of the nice properties of
git-over-http, which is that it works through arbitrary proxies (for
some people on restricted networks, they are stuck going through a
company-wide proxy, and neither git:// nor ssh are options in the first
place).

Maybe the world is heading in the direction of supporting ALPN
everywhere, but I suspect we'll be dealing with older proxies for a
while.

> Another alternative would be to define a framing for a full-duplex
> git-upload-pack connection inside a single HTTP/2 connection; HTTP/2
> already effectively allows full-duplex asynchronous conversations.

This has some of the same problem as above, though I'd bet on HTTP/2
support becoming mainstream more quickly.

I'm not very well educated on HTTP/2, but my understanding is that it
_doesn't_ just provide a full-duplex asynchronous connection out of the
box. You get "server push", but that is not quite the same thing.

So I'm not sure if we can make something work on top of those building
blocks, and if we do, how well it would fare with standard components
like proxies in the middle.

-Peff
