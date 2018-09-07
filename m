Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2347D1F404
	for <e@80x24.org>; Fri,  7 Sep 2018 17:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbeIGV5o (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 17:57:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:42838 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726161AbeIGV5n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 17:57:43 -0400
Received: (qmail 16806 invoked by uid 109); 7 Sep 2018 17:15:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Sep 2018 17:15:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15301 invoked by uid 111); 7 Sep 2018 17:16:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 07 Sep 2018 13:16:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Sep 2018 13:15:49 -0400
Date:   Fri, 7 Sep 2018 13:15:49 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] commit-graph write: add progress output
Message-ID: <20180907171548.GA11708@sigill.intra.peff.net>
References: <20180904202729.13900-1-avarab@gmail.com>
 <20180904202729.13900-2-avarab@gmail.com>
 <xmqqin3k7w8b.fsf@gitster-ct.c.googlers.com>
 <c6960252-c095-fb2b-e0bc-b1e6bb261614@gmail.com>
 <87ftylqr4z.fsf@evledraar.gmail.com>
 <87efe5qqks.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87efe5qqks.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 07, 2018 at 05:23:31PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Hrm, no. I spoke too soon because I was conflating "commit-graph write"
> v.s. "gc". For "gc" we're now with this change just e.g. spending 6
> seconds on 2015-04-03-1M-git displaying nothing, because we're looping
> through the commits and finding that we have no new work.
> 
> So I'm on the fence about this, but leaning towards just taking my
> initial approch. I.e. it sucks if you're e.g. testing different "git gc"
> options that we're churning in the background doing nothing, just
> because we're trying to report how many *new* things we added to the
> graph.
> 
> After all, the main point IMNSHO is not to show some diagnostic output
> of exactly how much work we're doing, that I have 200 new commits with
> generation numbers or whatever is just useless trivia, but rather to not
> leave the user thinking the command is hanging.

I think there's some precedent for your view of things, too. For
example, "writing objects" counts _all_ of the objects, even though many
of them are just copying bytes straight from disk, and some are actually
generating a delta and/or zlib-deflating content.

So it's not the most precise measurement we could give, but it shows
there's activity, and the "average" movement over many objects tends to
be reasonably smooth.

> So I think I'll just do what I was doing to begin with and change the
> message to "Refreshing commit graph generation numbers" or something to
> indicate that it's a find/verify/compute operation, not just a compute
> operation.

So basically yes, I agree with this. :)

-Peff
