Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A3DC1FF40
	for <e@80x24.org>; Mon,  5 Dec 2016 07:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751378AbcLEHOe (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 02:14:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:51574 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750928AbcLEHOd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 02:14:33 -0500
Received: (qmail 32464 invoked by uid 109); 5 Dec 2016 07:14:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Dec 2016 07:14:32 +0000
Received: (qmail 2204 invoked by uid 111); 5 Dec 2016 07:15:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Dec 2016 02:15:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Dec 2016 02:14:31 -0500
Date:   Mon, 5 Dec 2016 02:14:31 -0500
From:   Jeff King <peff@peff.net>
To:     "Kyle J. McKay" <mackyle@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Git v2.11.0 breaks max depth nested alternates
Message-ID: <20161205071431.cf3oy7nceyb7hggw@sigill.intra.peff.net>
References: <fe33de5b5f0b3da68b249cc4a49a6d7@3c843fe6ba8f3c586a21345a2783aa0>
 <20161204045554.advzvylytdmt2bh2@sigill.intra.peff.net>
 <E3C2AF2A-FE07-4C94-B549-3BDAF9B3DB5D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <E3C2AF2A-FE07-4C94-B549-3BDAF9B3DB5D@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 04, 2016 at 01:37:00AM -0800, Kyle J. McKay wrote:

> On Dec 3, 2016, at 20:55, Jeff King wrote:
> 
> > So I do think this is worth dealing with, but I'm also curious why
> > you're hitting the depth-5 limit. I'm guessing it has to do with hosting
> > a hierarchy of related repos. But is your system then always in danger
> > of busting the 5-limit if people create too deep a repository hierarchy?
> 
> No we check for the limit.  Anything at the limit gets broken by the
> quarantine change though.

OK. So the limit is an issue for your system, but one that you're able
to deal gracefully with (and the quarantine change makes that a lot
harder). I buy that line of reasoning.

> The patch is a step on that road.  It doesn't go that far but all it would
> take is connecting the introduced variable to a config item.  But you still
> need to bump it by 1 during quarantine operations.  Such support would even
> allow alternates to be disallowed (except during quarantine).  I wonder if
> there's an opportunity for further pack operation optimizations in such a
> case (you know there are no alternates because they're not allowed)?

I doubt it. We look at the list of alternates early on, and in most
cases there aren't any. So any optimization there can be done already at
that point.

The only optimization I know if in that area is 56dfeb626 (pack-objects:
compute local/ignore_pack_keep early, 2016-07-29), which works already.

> All true.  And I had similar thoughts.  Perhaps we should add your comments
> to the patch description?  There seems to be a trend towards having longer
> patch descriptions these days... ;)

Feel free to pick out anything that's useful and add it in verbatim or
rephrased, whichever is more convenient.

> You took the words right out of my mouth...   I guess I need to work on
> doing a better job of dumping my stream-of-thoughts that go into a patch
> into the emails to the list.

It's a lot easier when you're the reviewer, because you don't start
reading through the commit-message with a full understanding of the
problem yet. :)

> Most all of your comments could be dumped into the patch description as-is
> to pimp it out some.  I have no objection to that, even adding an
> "Additional-analysis-by:" (or similar) credit line too.  :)

Sure. I don't really need credit, or even just "reviewed-by" is fine.
Talking and generating a shared understanding of the problem is part of
the review process.

-Peff
