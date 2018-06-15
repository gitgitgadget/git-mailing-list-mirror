Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93A341F403
	for <e@80x24.org>; Fri, 15 Jun 2018 06:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755711AbeFOGAX (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 02:00:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:45456 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755687AbeFOGAW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 02:00:22 -0400
Received: (qmail 23483 invoked by uid 109); 15 Jun 2018 06:00:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Jun 2018 06:00:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19271 invoked by uid 111); 15 Jun 2018 06:00:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 15 Jun 2018 02:00:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jun 2018 02:00:20 -0400
Date:   Fri, 15 Jun 2018 02:00:20 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] t/lib-httpd: sort log based on timestamp to
 avoid occasional failure
Message-ID: <20180615060020.GA8367@sigill.intra.peff.net>
References: <20180614123107.11608-1-szeder.dev@gmail.com>
 <20180614123107.11608-5-szeder.dev@gmail.com>
 <20180614175325.GA14935@sigill.intra.peff.net>
 <xmqqefh94420.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqefh94420.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 14, 2018 at 11:27:03AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >>     Another alternative is to simply accept that these tests are racy, and
> >>     that the resulting test failures are rare enough that it isn't worth
> >>     the complexity of the workaround, but adding a comment to the affected
> >>     tests warning about the raciness is sufficient.  (But I wrote this
> >>     when I first saw and tracked down this failure; since then I observed
> >>     it four more times... :)
> >
> > It's definitely bugged me. I'd be happy to see some solution. I've been
> > close to suggesting that reading apache logs is simply not robust, and
> > we should focus our tests on the git-visible state changes (e.g., seeing
> > successful requests, updated refs, etc).
> 
> Hmph, that certainly is "checking only the things that matter",
> which is desirable.

The existing tests that look at the apache logs are very white-box, and
come from Shawn's original smart-http series. I suspect it was as much
about sanity-checking the implementation then as it was about protecting
against regressions.

So it's possible that these tests have simply outlived their usefulness.

OTOH, they might catch non-functional problems, like if we started
sending redundant requests. But then, they are not very comprehensive,
as they only cover a few basic situations (so for example, for a while
we were sending extra auth-related requests, but I don't think these
tests detected that).

-Peff
