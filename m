Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9AE01F404
	for <e@80x24.org>; Wed, 29 Aug 2018 05:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbeH2JU1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 05:20:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:60178 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725882AbeH2JU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 05:20:27 -0400
Received: (qmail 15731 invoked by uid 109); 29 Aug 2018 05:25:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 29 Aug 2018 05:25:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10254 invoked by uid 111); 29 Aug 2018 05:25:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 29 Aug 2018 01:25:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Aug 2018 01:25:19 -0400
Date:   Wed, 29 Aug 2018 01:25:19 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] submodule: munge paths to submodule git directories
Message-ID: <20180829052519.GA17253@sigill.intra.peff.net>
References: <20180807230637.247200-1-bmwill@google.com>
 <20180808223323.79989-1-bmwill@google.com>
 <20180808223323.79989-3-bmwill@google.com>
 <20180809212602.GA11342@sigill.intra.peff.net>
 <20180814180406.GA86804@google.com>
 <CAGZ79kaLXcTeeM9AKvXi7X8WMd+vcyCM5n-Nz2igHkGJdXbSfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kaLXcTeeM9AKvXi7X8WMd+vcyCM5n-Nz2igHkGJdXbSfg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 28, 2018 at 02:35:25PM -0700, Stefan Beller wrote:

> 3) (optional) instead of putting it all in modules/, use another
>    directory gitmodules/ for example. this will make sure we can tell
>    if a repository has been converted or is stuck with a setup of a
>    current git.

I actually kind of like that idea, as it makes the interaction between
old and new names much simpler to reason about.

And since old code won't know about the new names anyway, there's in
theory no downside. In practice, of course, the encoding may often be a
noop, and lazy scripts would continue to work most of the time if you
didn't change out the prefix directory. I'm not sure if that is an
argument for the scheme (because it will suss out broken scripts more
consistently) or against it (because 99% of the time those old scripts
would just happen to work).

> > This is exactly the reason why I wanted to get some opinions on what the
> > best thing to do here would be.  I _think_ the best thing would probably
> > be to write a specific routine to do the conversion, and it wouldn't
> > even have to be all that complex.  Basically I'm just interested in
> > converting '/' characters so that things no longer behave like
> > nested directories.
> 
> Yeah, then let's just convert '/' with as little overhead as possible.

Do you care about case-folding issues (e.g., submodules "FOO" and "foo"
colliding)?

I'm OK if the answer is "no", but if you do want to deal with it, the
time is probably now.

-Peff
