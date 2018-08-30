Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9337A1F404
	for <e@80x24.org>; Thu, 30 Aug 2018 19:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbeH3XYC (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 19:24:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:34438 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727200AbeH3XYB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 19:24:01 -0400
Received: (qmail 7156 invoked by uid 109); 30 Aug 2018 19:20:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Aug 2018 19:20:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30535 invoked by uid 111); 30 Aug 2018 19:20:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 30 Aug 2018 15:20:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Aug 2018 15:20:19 -0400
Date:   Thu, 30 Aug 2018 15:20:19 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Gabriel Holodak <gthepiper@gmail.com>, git <git@vger.kernel.org>
Subject: Re: Possible bug: identical lines added/removed in git diff
Message-ID: <20180830192019.GB19685@sigill.intra.peff.net>
References: <CAE6=WB_4_PhjfQpubFcYkNKejfDr22s-y0nPQKw5Yd4GVaN4Yw@mail.gmail.com>
 <CAGZ79kZ1BVTLnNYSs+NjEO1T1-PySSdZzVU-0ZfivjT_pfvviQ@mail.gmail.com>
 <CAE6=WB_t7zG3jtELiMfggqxjvD4jJyJ02pNPmV3fey=3nSejuA@mail.gmail.com>
 <20180830025457.GA665@sigill.intra.peff.net>
 <CAGZ79kZNVw4-q9KYAi9G3axb7-Ggpc2EAK8ZxAZoPEnZvEL-DQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZNVw4-q9KYAi9G3axb7-Ggpc2EAK8ZxAZoPEnZvEL-DQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 30, 2018 at 12:16:22PM -0700, Stefan Beller wrote:

> On Wed, Aug 29, 2018 at 7:54 PM Jeff King <peff@peff.net> wrote:
> >
> > On Wed, Aug 29, 2018 at 10:10:25PM -0400, Gabriel Holodak wrote:
> >
> > > > Could you cut down to a real minimal reproduction, i.e. just these 20
> > > > lines or so?
> > >
> > > I'm working on getting down to a minimal reproduction, a few lines at
> > > a time. One thing that seems strange: as I've removed lines, there are
> > > a bunch of lines that don't matter. Then I'll find some lines that, if
> > > removed, completely fix the issue. But the ordering for these
> > > apparently important lines doesn't matter. They just have to be
> > > somewhere in the file to cause the duplicated diffs.
> > >
> > > I'll upload again when I've figured out all the unimportant lines to remove.
> >
> > Yeah, I reproduced based on your initial post, but noticed that when I
> > cut it down the problem went away.
> 
> Oh, I had to look further down than I did initially. Now I can reproduce it
> from the initial data as well.
> 
> Note that it goes away with --minimal.

That's interesting. I did wonder if this was in fact a bug, or simply
that Myers does not promise to find the absolute minimal diff. I'm
_still_ not sure, especially because the minimization is so obvious in
this case (literally the first "-" and the first "+" line of a
contiguous hunk are identical).

> I have a patch cooking (which was sent out as
> https://public-inbox.org/git/20180810221857.87399-1-sbeller@google.com/)
> 
> and one of the weaknesses in that patch is the lack of explanation on
> when the heuristic is applied as I have not fully understood it yet.

I'm not sure I understand it either. But at least knowing that --minimal
changes the output gives a lead for investigation (I don't really have
time to dig into it in the next few days, though).

-Peff
