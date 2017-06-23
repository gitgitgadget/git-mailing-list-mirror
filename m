Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E59C20282
	for <e@80x24.org>; Fri, 23 Jun 2017 20:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754869AbdFWUA1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 16:00:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:51180 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754781AbdFWUA0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 16:00:26 -0400
Received: (qmail 14943 invoked by uid 109); 23 Jun 2017 20:00:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 23 Jun 2017 20:00:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18667 invoked by uid 111); 23 Jun 2017 20:00:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Jun 2017 16:00:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Jun 2017 16:00:24 -0400
Date:   Fri, 23 Jun 2017 16:00:24 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 00/29] Create a reference backend for packed refs
Message-ID: <20170623200024.amgced62hue2iffj@sigill.intra.peff.net>
References: <cover.1498200513.git.mhagger@alum.mit.edu>
 <20170623190159.5ct2mgjcm6vuulz6@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170623190159.5ct2mgjcm6vuulz6@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 23, 2017 at 03:01:59PM -0400, Jeff King wrote:

> On Fri, Jun 23, 2017 at 09:01:18AM +0200, Michael Haggerty wrote:
> 
> > * Change patch 17 "packed_ref_store: support iteration" to always
> >   iterate over the packed refs using `DO_FOR_EACH_INCLUDE_BROKEN`.
> >   This switches off the check in the packed-ref iterator of whether a
> >   reference is broken. This is now checked only in
> >   `files_ref_iterator_advance()`, after the packed and loose
> >   references have been merged together. It also saves some work.
> 
> I'm curious why you prefer this solution to just removing the code
> entirely. Wouldn't it be an error to call the packed ref iterator
> without INCLUDE_BROKEN? The "entries may not be valid" thing is a
> property of the packed-refs concept itself, not a particular caller's
> view of it.

Speculating on my own question. I guess it would prepare us for a day
when a possible ref store is to use a packed-refs _without_ loose refs.
IOW, the property is defined on packed-refs today, but a possible future
direction would be to use it by itself. But maybe I'm just making things
up.

At any rate, I've read through the whole series and dropped a few
comments in there. Overall it looks good. If I had one complaint, it's
that the individual commits all look obviously correct but it is hard to
judge whether the bigger steps they are taking are the right thing. I
mostly have faith in you, as I know that your end goal is a good one,
and that you're very familiar with this code.  But just something I
noticed while reviewing.

-Peff
