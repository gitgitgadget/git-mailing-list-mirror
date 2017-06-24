Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CE34207D2
	for <e@80x24.org>; Sat, 24 Jun 2017 01:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754336AbdFXBKV (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 21:10:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:51466 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754126AbdFXBKV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 21:10:21 -0400
Received: (qmail 32597 invoked by uid 109); 24 Jun 2017 01:10:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 24 Jun 2017 01:10:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20480 invoked by uid 111); 24 Jun 2017 01:10:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Jun 2017 21:10:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Jun 2017 21:10:18 -0400
Date:   Fri, 23 Jun 2017 21:10:18 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: --color-moved feedback, was Re: [PATCH v2 19/29] packed-backend:
 new module for handling packed references
Message-ID: <20170624011018.lvw3rm6x6or7wt4s@sigill.intra.peff.net>
References: <20170623201020.24zus6tsnf2i62d3@sigill.intra.peff.net>
 <CAGZ79kbKB0hWOHCWsa0k1z=QXeRC2Ab1sSOeQ7pApB7+o6mdFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kbKB0hWOHCWsa0k1z=QXeRC2Ab1sSOeQ7pApB7+o6mdFw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 23, 2017 at 01:23:52PM -0700, Stefan Beller wrote:

> > In the end, I just did --color-moved=plain,  ...
> > "yep, this is all a giant moved chunk, so I don't have to look carefully
> > at it".
> 
> This is dangerous, as "plain" does not care about permutations.
> See the 7f5af90798 (diff.c: color moved lines differently, 2017-06-19)
> for details. You would want at least "zebra", which would show you
> permutations.

Ah, I see. I think what I'd really want is some way of correlating two
particular hunks. That's hard to do with color, though. I guess that's
the "you would need a ton of colors" discussion I saw going on before?

It would depend on how many hunks there are, and how close together they
are. For instance, your 6cd5757c8 seems like a good candidate, but I
have to admit with --color-moved=zebra I have no idea what's going on.
Some things are definitely colored, but I'm not sure what corresponds to
what.

> > That feels more dangerous to me, just because the heuristics seem to
> > find a lot of "moves" of repeated code. Imagine a simple patch like
> > "switch return 0 to return -1". If the code you're touching went away,
> > there's a very good chance that another "return 0" popped up somewhere
> > else in the code base. A conflict is what you want there; silently
> > changing some other site would be not only wrong, but quite subtle and
> > hard to find.
> 
> I agree, that is the danger, but the scale of danger is the size of the moved
> chunk. A file is usually a very large chunk, such that it is obviously a good
> idea to fix that. Maybe we'd introduce a threshold, that the fix must not be in
> range of the block boundaries of say 3 lines.
> (Then the moved block must be at least 7 lines of code such that a one liner
> fix in the middle would kick in)

Yes, I'd agree it's really a continuum from "one line" to "whole file".
I think right now the --color-moved stuff is too close to the former to
be safe, but pushing it farther towards the middle would remedy that.

-Peff
