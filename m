Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5834D1F51C
	for <e@80x24.org>; Sat, 19 May 2018 01:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbeESBC0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 21:02:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:46138 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751816AbeESBCZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 21:02:25 -0400
Received: (qmail 6614 invoked by uid 109); 19 May 2018 01:02:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 19 May 2018 01:02:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15676 invoked by uid 111); 19 May 2018 01:02:31 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 18 May 2018 21:02:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 May 2018 18:02:21 -0700
Date:   Fri, 18 May 2018 18:02:21 -0700
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/3] unpack_trees_options: free messages when done
Message-ID: <20180519010220.GA16071@sigill.intra.peff.net>
References: <CAN0heSo80SjjGtC2x9s-TmNY0=W=YWTYxyjeuAQ3utEAEynXeA@mail.gmail.com>
 <cover.1526677881.git.martin.agren@gmail.com>
 <f4e7822ebe8fcab8243ae3931084e10f3b199788.1526677881.git.martin.agren@gmail.com>
 <20180518213333.GB21797@sigill.intra.peff.net>
 <CABPp-BFdKFNLHxqt-rbSVPx_cXVG3iyad42qYFbWvP9_2fW2gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BFdKFNLHxqt-rbSVPx_cXVG3iyad42qYFbWvP9_2fW2gQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 18, 2018 at 03:30:44PM -0700, Elijah Newren wrote:

> > would become:
> >
> >   msgs[ERROR_WOULD_OVERWRITE] = msgs[ERROR_NOUPTODATE_FILE] =
> >         string_list_appendf(&opts->msgs_to_free, msg, cmd, cmd)->string;
> >
> > I don't know if that's worth it or not (I suspect that there are other
> > places where appendf would be handy, but I didn't poke around).
> 
> The strdup_strings=1 immediately before calling string_list_clear()
> has been used in one other place in merge-recursive.c, and tripped up
> the reviewer requiring a big code comment to explain it. (See the very
> end of https://public-inbox.org/git/CABPp-BGh7QTTfu3kgH4KO5DrrXiQjtrNhx_uaQsB6fHXT+9hLQ@mail.gmail.com/
> ).  So there's already one other place in merge-recursive.c that might
> benefit from such a change.

Thanks. I knew I had seen such hackery before, but it's nice to have a
specific site that would benefit.

IMHO the "nodup" variant of string_list is quite often a sign that
things are more complicated than they need to be. Even in cases that are
truly pointing to existing strings, is the complication really worth
saving a few strdups? Perhaps sometimes, but I have a suspicion it's
mostly premature optimization.

> Maybe someone wants to tackle that as a separate patch series?  (Maybe
> we make it a micro-project for future GSoC'ers?)

Yeah, I'm fine with these patches if somebody wants to do it separately.
It would be a good micro-project, but I'd also be just as happy if
somebody did it before next year. :)

-Peff
