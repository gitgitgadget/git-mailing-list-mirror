Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 482B21FADE
	for <e@80x24.org>; Tue, 12 Sep 2017 15:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751424AbdILP3i (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Sep 2017 11:29:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:35692 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751404AbdILP3h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2017 11:29:37 -0400
Received: (qmail 21251 invoked by uid 109); 12 Sep 2017 15:29:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 12 Sep 2017 15:29:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5410 invoked by uid 111); 12 Sep 2017 15:30:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 12 Sep 2017 11:30:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Sep 2017 11:29:35 -0400
Date:   Tue, 12 Sep 2017 11:29:35 -0400
From:   Jeff King <peff@peff.net>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 10/10] add UNLEAK annotation for reducing leak false
 positives
Message-ID: <20170912152935.iqmj6jpkvgifaju2@sigill.intra.peff.net>
References: <20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net>
 <20170905130505.him3p4jhxp64r2vy@sigill.intra.peff.net>
 <1505223698.27800.30.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1505223698.27800.30.camel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 12, 2017 at 07:11:38PM +0530, Kaartic Sivaraam wrote:

> On Tue, 2017-09-05 at 09:05 -0400, Jeff King wrote:
> > This patch introduces an UNLEAK() macro that lets us do so.
> > To understand its design, let's first look at some of the
> > alternatives.
> > 
> 
> > This patch adds the UNLEAK() macro and enables it
> > automatically when Git is compiled with SANITIZE=leak.
> > It adds some UNLEAK() annotations to show off how the
> > feature works. On top of other recent leak fixes, these are
> > enough to get t0000 and t0001 to pass when compiled with
> > LSAN.
> 
> My nit of the day ;-)
> 
> The above paragraphs seems to going against the following guideline of
> Documentation/SubmittingPatches,
> 
>     Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
>     instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
>     to do frotz", as if you are giving orders to the codebase to change
>     its behavior.  Try to make sure your explanation can be understood

Like all good writing rules, I think it's important to know when to
break them. :)

Writing in the imperative is _most_ important in the subject. You're
likely to see a lot of subjects in a list, and it makes the list easier
to read if they all match. It also tends to be shorter, which is good
for subjects.

For short commit messages, I think the imperative also keeps things
tight and to the point: describe the problem and then say how to fix it.
The recent 0db3dc75f is a good example (which I picked by skimming
recent "git log" output). But saying "this patch" is IMHO not that big a
problem there, as long as it isn't done excessively.

When you the explanation is longer or more complicated, the imperative
can actually be a bit _too_ terse. In longer text it helps to guide
readers in the direction you want their thoughts to take. Having a
three-paragraph explanation of the problem or current state of things
and then jumping right into "Do this. Do that." lacks context. A marker
like "this patch" helps the reader know that you're switching gears to
talking about the solution.

I also think that "I" is useful in avoiding the passive voice.  It can
certainly be used gratuitously and make things less clear, but in most
cases I'd rather see something like "I tested performance under these
conditions" than "Performance was tested under these conditions". I also
often use the "academic we" here even when I worked on something myself.

-Peff
