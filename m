Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5536C202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 19:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932077AbdCITJy (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 14:09:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:41481 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754822AbdCITJx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 14:09:53 -0500
Received: (qmail 14460 invoked by uid 109); 9 Mar 2017 19:09:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Mar 2017 19:09:52 +0000
Received: (qmail 609 invoked by uid 111); 9 Mar 2017 19:10:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Mar 2017 14:10:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Mar 2017 14:09:50 -0500
Date:   Thu, 9 Mar 2017 14:09:50 -0500
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org,
        gitster@pobox.com, markbt@efaref.net, benpeart@microsoft.com,
        jonathantanmy@google.com
Subject: Re: [PATCH 04/10] upload-pack: add partial (sparse) fetch
Message-ID: <20170309190950.om4wiyy3e4nawkgs@sigill.intra.peff.net>
References: <1488994685-37403-1-git-send-email-jeffhost@microsoft.com>
 <1488994685-37403-5-git-send-email-jeffhost@microsoft.com>
 <20170309074849.ktl5vqbzkiwwwbob@sigill.intra.peff.net>
 <ce170fec-846b-fc51-221d-c005b4a42b97@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ce170fec-846b-fc51-221d-c005b4a42b97@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 09, 2017 at 01:34:32PM -0500, Jeff Hostetler wrote:

> > > +  partial           =  PKT-LINE("partial-by-size" SP magnitude) /
> > > +		       PKT-LINE("partial-special)
> > > +
> > 
> > I probably would have added this as a capability coming back from the
> > client, since it only makes sense to send once (the same way we ask for
> > other features like include-tag or ofs-delta). I guess it's six of one,
> > half a dozen of the other, though.
> 
> True.  I wanted the size argument.  And later want to add
> a sparse-file.  It seemed like they better belonged in a
> PKT-LINE than in the capability header.

Yeah, at some point we will run out of room in the capabilities
response. :) If the sparse information might be arbitrarily long (e.g.,
a list of pathspecs) then it probably is better for it to get split into
its own pktline (or even a series of pktlines).

-Peff
