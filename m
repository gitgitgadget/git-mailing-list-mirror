Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3E771F859
	for <e@80x24.org>; Wed,  7 Sep 2016 18:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758049AbcIGStP (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 14:49:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:39522 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1756632AbcIGStP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 14:49:15 -0400
Received: (qmail 17145 invoked by uid 109); 7 Sep 2016 18:49:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 07 Sep 2016 18:49:14 +0000
Received: (qmail 6571 invoked by uid 111); 7 Sep 2016 18:49:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 07 Sep 2016 14:49:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Sep 2016 14:49:11 -0400
Date:   Wed, 7 Sep 2016 14:49:11 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [RFC/PATCH 0/2] more patch-id speedups
Message-ID: <20160907184911.sqwukfasnjjkr5gz@sigill.intra.peff.net>
References: <20160907075346.z6wtmqnfc6bsunjb@sigill.intra.peff.net>
 <alpine.DEB.2.20.1609071453240.129229@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1609071453240.129229@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 07, 2016 at 03:06:36PM +0200, Johannes Schindelin wrote:

> > This is marked as "RFC" because I don't feel entirely confident that I'm
> > not missing some clever need for these options. But in both cases my gut
> > feeling is that they are simply unintended effects that nobody ever
> > noticed, because it would be very rare that they would affect the
> > output. And that if they _did_ affect the output, they would probably be
> > doing the wrong thing.
> 
> Given that the patch ID is *wrong* for merge commits (it only looks at the
> first parent, so each "-s ours" merge will have the same patch ID!), I
> would say that we can get away with re-defining the patch ID of merge
> commits.
> 
> The only case where it might change things that I can think of would be a
> `git rebase --preserve-merges`: it would probably have worked *by chance*
> before (or not, in case of "-s ours" merges), and now it would try to pick
> the merge commits even if rebased versions were already merged upstream.
> 
> If I read the --preserve-merges code correctly, that would result in the
> merge commit's parents to be 'rewritten' to HEAD. And as both parents
> would be rewritten to HEAD, they would be condensed into a single new
> parent, resulting in a cherry-pick that fails (because it tries to
> cherry-pick a merge commit without any -n option).
> 
> Of course, what we could do is to introduce a modifier, e.g.
> --cherry-pick=first-parent, that would trigger the old behavior and would
> be asked-for in the --preserve-merges mode.
> 
> But quite frankly, personally I would not worry about it *that* much. As
> you pointed out, the patch ID for merge commits is incorrect to begin
> with, and we may just redeclare all merge commits to be incomparable to
> one another when it comes to patch IDs.
> 
> In short: I would be fine with the change of behavior.

Thanks for this explanation; it matches what I was thinking, but you
went through it in a lot more detail.

So it sounds like this is the right thing, but as you pointed out, the
implementation is just silly. I'll see if I can come up with a working
v2.

-Peff
