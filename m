Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94635205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 17:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933265AbdABRLP (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 12:11:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:34309 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933278AbdABRKq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 12:10:46 -0500
Received: (qmail 20867 invoked by uid 109); 2 Jan 2017 17:10:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Jan 2017 17:10:46 +0000
Received: (qmail 18223 invoked by uid 111); 2 Jan 2017 17:11:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Jan 2017 12:11:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Jan 2017 12:10:44 -0500
Date:   Mon, 2 Jan 2017 12:10:44 -0500
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        David Turner <novalis@novalis.org>
Subject: Re: [PATCH v3 20/23] try_remove_empty_parents(): don't trash
 argument contents
Message-ID: <20170102171043.ebfeaaylf4waq6co@sigill.intra.peff.net>
References: <cover.1483153436.git.mhagger@alum.mit.edu>
 <6164af2d1f9eeb5bd339b3913e8046c1ea0b02be.1483153436.git.mhagger@alum.mit.edu>
 <20161231064053.prvlw6x6qprzkmw7@sigill.intra.peff.net>
 <9215973c-8db1-8f5a-2dc7-3a0137dd5c62@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9215973c-8db1-8f5a-2dc7-3a0137dd5c62@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 02, 2017 at 05:27:59PM +0100, Michael Haggerty wrote:

> > or something. But I doubt the single allocation is breaking the bank,
> > and it has the nice side effect that callers can pass in a const string
> > (I didn't check yet whether that enables further cleanups).
> 
> The last patch in the series passes ref_update::refname to this
> function, which is `const char *`. With your suggested change, either
> that member would have to be made non-const, or it would have to be cast
> to const at the `try_remove_empty_parents()` callsite.
> 
> Making the member non-const would be easy, though it loses a tiny bit of
> documentation and safety against misuse. Also, scribbling even
> temporarily over that member would mean that this code is not
> thread-safe (though it seems unlikely that we would ever bother making
> it multithreaded).
> 
> I think I prefer the current version because it loosens the coupling
> between this function and its callers. But I don't mind either way if
> somebody feels strongly about it.

OK, let's take what you have here, then.

> As an aside, I wonder whether we would be discussing this at all if we
> had stack-allocated strbufs that could be used without allocating heap
> memory in the usual case.

I'm not sure. We still pay the memcpy(), though I don't know how
substantial that is compared to an allocation. For these small strings,
probably not very.

-Peff
