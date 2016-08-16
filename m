Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A4191F859
	for <e@80x24.org>; Tue, 16 Aug 2016 18:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752193AbcHPSfh (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 14:35:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:56444 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751936AbcHPSfh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 14:35:37 -0400
Received: (qmail 24679 invoked by uid 109); 16 Aug 2016 18:28:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Aug 2016 18:28:55 +0000
Received: (qmail 29334 invoked by uid 111); 16 Aug 2016 18:28:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Aug 2016 14:28:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Aug 2016 14:28:52 -0400
Date:	Tue, 16 Aug 2016 14:28:52 -0400
From:	Jeff King <peff@peff.net>
To:	Josh Triplett <josh@joshtriplett.org>
Cc:	git@vger.kernel.org
Subject: Re: upload-pack/ls-remote: showing non-HEAD symbolic refs?
Message-ID: <20160816182852.inyqzplee5m3wzt6@sigill.intra.peff.net>
References: <20160816161838.klvjhhoxsftvkfmd@x>
 <20160816163145.mjc726til2daxl3d@sigill.intra.peff.net>
 <20160816173444.rpqlpsz2ognvlufy@x>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160816173444.rpqlpsz2ognvlufy@x>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 16, 2016 at 10:34:44AM -0700, Josh Triplett wrote:

> > Sadly you cannot use a capability to fix that, because all of this
> > happens before the client agrees to any capabilities (you can find
> > discussion of a "v2" protocol on the list which solves this, but it's
> > sort of languishing in the design phase).
> 
> As a potential 1.1 version, which could work in a backward-compatible
> way with existing servers and no additional round-trip: what if, in the
> smart HTTP protocol, the client advertised client capabilities with an
> additional HTTP header (e.g.  "Git-Client-Caps: symrefs othershiny
> featurenames"?  git-http-backend could then pass those capabilities to
> git-upload-pack (--client-caps='...'), which could take them into
> account in the initial response?
> 
> That wouldn't work as a single-pass approach for SSH, since the client
> can't know if the server's upload-pack supports --client-caps, but it
> would work for the smart HTTP protocol.

You can dig up the discussion on the list under the name "protocol v2",
but basically yes, that approach has been considered. It's a little
gross just because it leaves other protocols behind http (and it is not
necessarily a good idea to push people into http, because it has some
fundamental drawbacks over the other protocols because of its
half-duplex nature).

> > That should Just Work over the existing http protocol without requiring
> > an extra request.
> 
> It'd require one extra request for git ls-remote, which normally doesn't
> need the second round-trip, but that still seems reasonable.

Good point. I don't think there's an easy way around that short of v2 or
v1.1 that you mention above. I agree it's probably reasonable, though.

-Peff
