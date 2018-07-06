Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAA981F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 20:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933738AbeGFUdm (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 16:33:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:50756 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932884AbeGFUdl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 16:33:41 -0400
Received: (qmail 14641 invoked by uid 109); 6 Jul 2018 20:33:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Jul 2018 20:33:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28693 invoked by uid 111); 6 Jul 2018 20:33:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 06 Jul 2018 16:33:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Jul 2018 16:33:39 -0400
Date:   Fri, 6 Jul 2018 16:33:39 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        avarab@gmail.com
Subject: Re: [PATCH v3 0/2] grep.c: teach --only-matching to 'git-grep(1)'
Message-ID: <20180706203339.GB4648@sigill.intra.peff.net>
References: <cover.1529961706.git.me@ttaylorr.com>
 <cover.1530654455.git.me@ttaylorr.com>
 <20180705142110.GA10192@sigill.intra.peff.net>
 <20180705143401.GA87330@syl.attlocal.net>
 <xmqqlgaokyy5.fsf@gitster-ct.c.googlers.com>
 <20180706201522.GA657@syl.attlocal.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180706201522.GA657@syl.attlocal.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 06, 2018 at 03:15:22PM -0500, Taylor Blau wrote:

> On Fri, Jul 06, 2018 at 11:21:06AM -0700, Junio C Hamano wrote:
> > Taylor Blau <me@ttaylorr.com> writes:
> >
> > > I think that this might be clear enough on its own, especially since
> > > this is the same as BSD grep on my machine. I think that part_s_ of a
> > > line indicates that behavior, but perhaps not. On GNU grep, this is:
> > >
> > >   Print only the matched (non-empty) parts of a matching line, with each
> > >   such part on a separate output line.
> >
> > Interesting.  I wonder what "git grep -o '^'" would do ;-)
> 
> That invocation prints nothing, but on BSD grep it prints quite a few
> blank lines :-).
> 
> I'm hesitant on sending a patch per the hunk of your reply below because
> of this. Should we mirror BSD grep's behavior exactly here? I suppose
> that we could somehow, but it seems like we might be doing too much to
> support what appears to me to be an odd use-case.

IMHO the GNU behavior (omitting non-empty matches) makes more sense. And
it's also what your patch already does. ;)

Although amusingly "git grep -o ^" will still print a ton of "Binary
file ... matches". That _also_ matches what GNU grep does. I'm not sure
if there's a saner behavior (it really has nothing to do with the funny
empty match; any binary file with -o cannot show the normal text line).

> > In any case, I find that the GNU phrasing is the most clear among
> > the ones I've seen in this thread so far.
> 
> OK. I'm happy to re-send that patch with the GNU phrasing depending on
> what others think (and the above). I'll let this cook and collect some
> thoughts over the weekend.

FWIW, I like the GNU phrasing. I thought the "non-empty" part was not
all that interesting, but after hearing that BSD behaves differently, it
is probably worth mentioning.

I think the actual behavior of your patch matches GNU grep, and does not
need changing.

-Peff
