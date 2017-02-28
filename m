Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0253201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 20:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751334AbdB1UJj (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 15:09:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:35894 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751055AbdB1UJj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 15:09:39 -0500
Received: (qmail 19040 invoked by uid 109); 28 Feb 2017 20:01:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 20:01:47 +0000
Received: (qmail 29572 invoked by uid 111); 28 Feb 2017 20:01:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 15:01:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Feb 2017 15:01:45 -0500
Date:   Tue, 28 Feb 2017 15:01:45 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/6] Use time_t
Message-ID: <20170228200145.ymbqmxwrbbrwagks@sigill.intra.peff.net>
References: <cover.1488231002.git.johannes.schindelin@gmx.de>
 <20170228142802.hu5esthnqdsgc2po@sigill.intra.peff.net>
 <xmqqvarukz0g.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqvarukz0g.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 28, 2017 at 09:26:23AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I do not just agree, but I think the move to a signed timestamp is a big
> > improvement. Git's object format is happy to represent times before
> > 1970, but the code is not. I know this has been a pain for people who
> > import ancient histories into Git.
> >
> > It looks from the discussion like the sanest path forward is our own
> > signed-64bit timestamp_t. That's unfortunate compared to using the
> > standard time_t, but hopefully it would reduce the number of knobs (like
> > TIME_T_IS_INT64) in the long run.
> 
> Keeping it unsigned is safer in the short-term.  There are some
> places that uses 0 as "impossible time" (e.g. somebody tried to
> parse a string as time and returns a failure) and these places need
> to be found and be replaced with probably the most negative value
> that timestamp_t cn represent.  Another possible special value we
> may use is for "expiring everything" but I think we tend to just use
> the timestamp of the present time for that purpose and not UONG_MAX,
> so we should be OK there.

Yeah. I think I was the one who invented the "0 is impossible"
convention. We can certainly stick with it for now (it's awkward if you
really do have an entry on Jan 1 1970, but other than that it's an OK
marker). I agree that the most negatively value is probably a saner
choice, but we can switch to it after the dust settles.

> But we need to cross the bridge to signed timestamp sometime, and I
> do not see any reason why that somtime should not be now.

Yep.

-Peff
