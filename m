Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FD4720248
	for <e@80x24.org>; Mon, 15 Apr 2019 14:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfDOOup (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 10:50:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:58486 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726298AbfDOOuo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 10:50:44 -0400
Received: (qmail 21847 invoked by uid 109); 15 Apr 2019 14:50:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 15 Apr 2019 14:50:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2415 invoked by uid 111); 15 Apr 2019 14:51:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 15 Apr 2019 10:51:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Apr 2019 10:50:42 -0400
Date:   Mon, 15 Apr 2019 10:50:42 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 4/7] docs: exclude documentation for commands that have
 been excluded
Message-ID: <20190415145042.GA27540@sigill.intra.peff.net>
References: <pull.168.git.gitgitgadget@gmail.com>
 <31d8e43cbfaec36f662006a711b64bca47009e59.1555070430.git.gitgitgadget@gmail.com>
 <CAPig+cTiF-9+pXnx19y0PUs3Nwek7N2cEg2r2jAPzEXPTvpxpA@mail.gmail.com>
 <xmqqpnpoufp5.fsf@gitster-ct.c.googlers.com>
 <CAPig+cQ3drZ+iE=SkSXTdHVfTxLkPTi=VTJCMJn7LKLxcpC-pQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQ3drZ+iE=SkSXTdHVfTxLkPTi=VTJCMJn7LKLxcpC-pQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 15, 2019 at 12:16:51AM -0400, Eric Sunshine wrote:

> On Sun, Apr 14, 2019 at 11:10 PM Junio C Hamano <gitster@pobox.com> wrote:
> > Eric Sunshine <sunshine@sunshineco.com> writes:
> > >> +Documentation/GIT-EXCLUDED-PROGRAMS: Makefile config.mak.uname
> > >> +       $(QUIET_GEN)echo "EXCLUDED_PROGRAMS := $(EXCLUDED_PROGRAMS)" >$@
> > >
> > > Should this rule also have a dependency upon "config.mak.autogen"?
> >
> > That is probably a good point.
> >
> > > Perhaps like this:
> > >
> > > Documentation/GIT-EXCLUDED-PROGRAMS: Makefile $(wildcard config.mak*)
> >
> > I'd rather not let changes to "config.mak-", which I keep in my
> > working tree (untracked and disabled copy of config.mak, that can be
> > readily activated by renaming), be part of dependency rules.
> >
> > If we know 'autogen' is the only dependency that optionally can
> > exist, then depending explicitly on $(wildcard config.mak.autogen)
> > would be a better alternative.
> 
> When composing that email, I originally wrote $(wildcard
> config.mak.autogen) as the suggestion but changed it to the looser
> $(wildcard config.mak*) when I realized that the developer's own
> config.mak probably ought to be a dependency, as well. Taking your
> objection into consideration, we could mention both explicitly:
> 
>     Documentation/GIT-EXCLUDED-PROGRAMS: Makefile \
>         $(wildcard config.mak) $(wildcard config.mak.autogen)

What about command-line options that influence the outcome? It sounds
like this is the same problem we have in lots of other places (like say,
compiler flags being updated), that we solve by generating the proposed
file output unconditionally and comparing it to what's on disk.  E.g.,
see the way GIT-CFLAGS or GIT-BUILD-OPTIONS is generated.

-Peff
