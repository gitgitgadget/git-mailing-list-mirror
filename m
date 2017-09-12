Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11B501FADE
	for <e@80x24.org>; Tue, 12 Sep 2017 15:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751441AbdILPFo (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Sep 2017 11:05:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:35640 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751404AbdILPFo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2017 11:05:44 -0400
Received: (qmail 20045 invoked by uid 109); 12 Sep 2017 15:05:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 12 Sep 2017 15:05:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5039 invoked by uid 111); 12 Sep 2017 15:06:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 12 Sep 2017 11:06:18 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Sep 2017 11:05:42 -0400
Date:   Tue, 12 Sep 2017 11:05:42 -0400
From:   Jeff King <peff@peff.net>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 10/10] add UNLEAK annotation for reducing leak false
 positives
Message-ID: <20170912150541.fkgnxddv6z223h3d@sigill.intra.peff.net>
References: <20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net>
 <20170905130505.him3p4jhxp64r2vy@sigill.intra.peff.net>
 <CAGZ79kYmZJ8k2=SVrx9vpEXoKhRBGwu8J=fS=cYiCLdKf+nDGA@mail.gmail.com>
 <1505226892.27800.37.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1505226892.27800.37.camel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 12, 2017 at 08:04:52PM +0530, Kaartic Sivaraam wrote:

> > On Tue, 2017-09-05 at 15:05 -0700, Stefan Beller wrote:
> > 
> > After having a sneak peak at the implementation
> > it is O(1) in runtime for each added element, and the
> > space complexity is O(well).
> > 
> 
> Incidentally I was reading about "complexity of algorithms" and there
> was the following paragraph in the book,
> 
> 
>     Unfortunately, as Knuth observed, big-O notation is often used by careless writers and
>     speakers as if it had the same meaning as big-Theta notation. Keep this in mind when you see
>     big-O notation used. The recent trend has been to use big-Theta notation whenever both upper
>     and lower bounds on the size of a function are needed.
> 
> So, if my interpretation is correct the above usage of O(1) and O(well)
> should have been Θ(1) and Θ(well).

But theta-well isn't a pun. :P

It is true that prepending to a linked list is also Θ(1), but I'm not
sure if it's carelessness that causes many programmers to use big-O.
It's that what we care about is worst-case performance. So knowing that
we have a lower bound isn't usually that interesting. What we want to
know is whether it will blow up in our face as "n" gets large.

Plus typing non-ascii characters is annoying. :)

If you want to talk about sloppy analysis, the two most common problems
I see are:

  1. People talk about big-O complexity without discussing constants.
     For reasonable values of "n", the constants often matter (they're
     not wrong about big-O, but they are wrong about what will run fast
     in practice).

  2. Glossing over things like amortized costs. Hash tables aren't
     really O(1) because they eventually fill up and get collisions. You
     have to talk about load factor, resizing, etc.

I'm sure I'm guilty of doing those things sometimes, too.

-Peff
