Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B50E220281
	for <e@80x24.org>; Wed,  1 Nov 2017 07:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754169AbdKAHOb (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 03:14:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:42104 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754152AbdKAHOa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 03:14:30 -0400
Received: (qmail 29831 invoked by uid 109); 1 Nov 2017 07:14:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 Nov 2017 07:14:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8286 invoked by uid 111); 1 Nov 2017 07:14:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 Nov 2017 03:14:33 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Nov 2017 03:14:22 -0400
Date:   Wed, 1 Nov 2017 03:14:22 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: On the nature of cover letters [WAS Re: [PATCH 0/6] Create
 Git/Packet.pm]
Message-ID: <20171101071422.c2k4plhntlgpdnbk@sigill.intra.peff.net>
References: <CAGZ79kbHwXpWXhUkokA9=XGN9D1YZevO_8MhbOztMXpkkHMFbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kbHwXpWXhUkokA9=XGN9D1YZevO_8MhbOztMXpkkHMFbg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 30, 2017 at 11:29:37AM -0700, Stefan Beller wrote:

> > I can live with fancily-formatted cover letters. BUT. I would say if
> > your cover letter is getting quite long, you might consider whether some
> > of its content ought to be going elsewhere (either into commit messages
> > themselves, or into a design document or other place inside the repo).
> 
> I am of the opinion that in an ideal workflow the cover letter would be
> part of the merge commit message. It may even be editorialized or
> annotated by the maintainer performing the merge, but not necessarily so.
> 
> Currently I rarely pay attention to merges, because they are not exciting
> (in a good way). I mostly know the texts that Junio puts into the merge
> message[1] from the cooking email, and otherwise there is not much
> information added there.

Yes, I'd agree that for some topics it would be nice for the merge
message to give any "big picture" details that wouldn't have made sense
inside a single commit message.

> However looking at *what* Junio puts there, is "why is this worthwhile
> to merge from the *projects* point of view?", whereas the cover letter
> most of the time talks about "Why the *contributor* wants this merged".
> Often these are subtly different, so it would be nice to have these
> two competing views around.

Yes, there's really no reason we couldn't have both (e.g., Junio's
maintainer synopsis followed by a marker, and then the original author's
cover letter).

The workflow within git is a little awkward, though. You'd want to pick
up the cover letter information via "git am" when the branch is applied.
But it doesn't go into a commit message until the merge. So where is it
stored in the meantime? You'd need a branch->msg key/value store of some
kind.

Junio's workflow now actually uses the "pu" merges as the storage
location while a topic is working its way up. But there's a period
between "am" and running the integration cycle where it would need to go
somewhere else.

One other consideration is that the cover letter may get updated between
rounds (e.g., because you changed patches in response to review, or even
to discuss alternatives that came up and were rejected). That places a
burden on the maintainer to update the prospective merge-message.

So it may make more sense just to cross-reference those merges with the
topics that spawned them on the mailing list. I.e., instead of copying
the cover letter contents, just record the message-id (and update it
whenever a new iteration of a topic is picked up via "git am"). That
lets you get the cover letter information _and_ see any discussion
or review around the patch. (But it has the same "where does this
message-id go until the merge-commit is created" question).

> > I actually have the opposite opinion. I find it annoying to have to wade
> > through the same unchanged content for each round just to find the
> > little snippet of "here's what's changed".
> 
> Would you be happier if the "What changed?" goes first[2]?

Yes, I think that would help. And marking the start of "old" information
clearly so that the reader knows when they can stop looking.

But then links do that pretty well, too (it's easy to choose whether to
follow them or not).

-Peff
