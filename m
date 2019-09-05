Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F0BD1F461
	for <e@80x24.org>; Thu,  5 Sep 2019 06:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730778AbfIEGPV (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 02:15:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:40078 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725921AbfIEGPU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 02:15:20 -0400
Received: (qmail 24545 invoked by uid 109); 5 Sep 2019 06:08:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Sep 2019 06:08:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24243 invoked by uid 111); 5 Sep 2019 06:10:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Sep 2019 02:10:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 5 Sep 2019 02:08:39 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Garima Singh <garimasigit@gmail.com>, stolee@gmail.com,
        git@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] commit-graph.c: handle corrupt commit trees
Message-ID: <20190905060838.GB21450@sigill.intra.peff.net>
References: <cover.1567563244.git.me@ttaylorr.com>
 <c5ba4eaa-f995-5f2e-4f0f-a8f59ba65fd3@gmail.com>
 <20190904212121.GB20904@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190904212121.GB20904@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 04, 2019 at 05:21:21PM -0400, Taylor Blau wrote:

> > I like the idea of completely bailing if the commit can't be parsed too.
> > Only question: Is there a reason you chose to die() instead of BUG() like
> > the other two places in that function? What is the criteria of choosing one
> > over the other?
> 
> I did not call 'BUG' here because 'BUG' is traditionally used to
> indicate an internal bug, e.g., an unexpected state or some such. On the
> other side of that coin, 'BUG' is _not_ used to indicate repository
> corruption, since that is not an issue in the Git codebase, rather in
> the user's repository.
> 
> Though, to be honest, I've never seen that rule written out explicitly
> (maybe if it were to be written somewhere, it could be stored in
> Documentation/CodingGuidelines?). I think that this is some good
> #leftoverbits material.

That rule matches my understanding. A BUG() should be about asserting
invariants or catching should-not-happen cases, etc. Any time a BUG()
triggers, that is truly a bug in Git, no matter what input got thrown at
it, what syscalls failed, etc, and is worth fixing (even if the only
sensible thing is to die()).

As a side note, we've generally treated segfaults the same way. It
doesn't matter if the files on disk or the program input is garbage, we
should say so and abort the operation cleanly.

-Peff
