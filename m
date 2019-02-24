Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56D5D20248
	for <e@80x24.org>; Sun, 24 Feb 2019 09:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbfBXJps (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 04:45:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:55936 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728184AbfBXJps (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 04:45:48 -0500
Received: (qmail 26509 invoked by uid 109); 24 Feb 2019 09:45:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 24 Feb 2019 09:45:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9237 invoked by uid 111); 24 Feb 2019 09:46:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 24 Feb 2019 04:46:02 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Feb 2019 04:45:46 -0500
Date:   Sun, 24 Feb 2019 04:45:46 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sylvain Lacaze <sylvain@lacaze.me>, git@vger.kernel.org
Subject: Re: [PATCH] diff: reuse diff setup for --no-index case
Message-ID: <20190224094545.GA11538@sigill.intra.peff.net>
References: <CAH1FtBpcZJ8V4B=RJ0SfC+kehpmpaBGafDzXvi8i33rc++jOUw@mail.gmail.com>
 <20190213201118.GA13261@sigill.intra.peff.net>
 <xmqqo97e885l.fsf@gitster-ct.c.googlers.com>
 <20190216065755.GB27641@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190216065755.GB27641@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 16, 2019 at 01:57:56AM -0500, Jeff King wrote:

> On Thu, Feb 14, 2019 at 11:47:02AM -0800, Junio C Hamano wrote:
> 
> > > +	if (no_index)
> > > +		/* If this is a no-index diff, just run it and exit there. */
> > > +		diff_no_index(&rev, argc, argv);
> > > +
> > >  	if (nongit)
> > >  		die(_("Not a git repository"));
> > >  	argc = setup_revisions(argc, argv, &rev, NULL);
> > 
> > To summarize, I would suspect that two further improvements on this
> > patch are:
> > 
> >  (1) move "Otherwise" comment to the right place
> > 
> >  (2) make the two assignments that are irrelevant to "--no-index"
> >      after we jumped to diff_no_index().
> > 
> > The latter is optional, but may be good for code health by making
> > developers _think_ if an option is applicable to "--no-index" mode.
> > I dunno.
> 
> Yeah, I very much agree with (1). For (2), I intentionally left it as
> one mixed block, because I didn't want people to accidentally add new
> setup lines to the wrong block. But maybe with sufficient comments, it
> would be clear (and even make the code flow a bit more obvious).
> 
> Here's an attempt at that.  I did drop a few comments that seemed
> pointless to me, as they're just re-stating the lines they describe.

It looks like the original got merged to next. I think we at least need
to deal with the "Otherwise..." comment, but I think the layout I posted
in my followup is nicer overall. Was it a mistake to merge the first
one?

If so, do you want an incremental, or do you just want to drop it and
redo as part of the post-2.21 rewind?

-Peff
