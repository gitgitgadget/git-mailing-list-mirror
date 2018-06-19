Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25CE31F597
	for <e@80x24.org>; Tue, 19 Jun 2018 18:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966772AbeFSSF2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 14:05:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:48728 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S966551AbeFSSF1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 14:05:27 -0400
Received: (qmail 2596 invoked by uid 109); 19 Jun 2018 18:05:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 19 Jun 2018 18:05:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15424 invoked by uid 111); 19 Jun 2018 18:05:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 19 Jun 2018 14:05:44 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jun 2018 14:05:25 -0400
Date:   Tue, 19 Jun 2018 14:05:25 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        avarab@gmail.com
Subject: Re: [PATCH 0/7] grep.c: teach --column to 'git-grep(1)'
Message-ID: <20180619180525.GA28203@sigill.intra.peff.net>
References: <cover.1529365072.git.me@ttaylorr.com>
 <20180619163506.GB22034@sigill.intra.peff.net>
 <5282e3bb-bf7a-ab3a-98dc-d29ff1c37468@web.de>
 <20180619174846.GA27820@sigill.intra.peff.net>
 <xmqqo9g6vet5.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo9g6vet5.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 19, 2018 at 10:58:30AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Although there are interesting cases around inversion. For example:
> >
> >   git grep --not \( --not -e a --and --not -e b \)
> >
> > is equivalent to:
> >
> >   git grep -e a --or -e b
> >
> > Do people care if we actually hunt down the exact column where we
> > _didn't_ match "b" in the first case?  The two are equivalent, but I
> > have to wonder if somebody writing the first one really cares.
> 
> I may be misunderstanding the question, but I personally would feel
> that "git grep --not <ANYTHING>" is OK to say "the entire line is at
> fault that it did not satisify the criteria to match <ANYTHING>".
> I.e., I'd be happy if --column marked the first column as the
> beginning of the match, or --color painted the entire line in the
> output of the former.

Even if it's a double-inversion? The reason we carry both `col` and
`icol` is that it allows:

  git grep --not --not --not --not -e a

to still say "we found 'a' here". That's a dumb thing to ask for, but it
is true in the end that we show lines with "a" (and will colorize them
as such).

-Peff
