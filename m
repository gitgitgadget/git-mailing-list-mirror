Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 339412027C
	for <e@80x24.org>; Tue, 30 May 2017 21:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750841AbdE3VFf (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 17:05:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:60234 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750811AbdE3VFe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 17:05:34 -0400
Received: (qmail 14652 invoked by uid 109); 30 May 2017 21:05:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 May 2017 21:05:32 +0000
Received: (qmail 30727 invoked by uid 111); 30 May 2017 21:06:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 May 2017 17:06:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 May 2017 17:05:30 -0400
Date:   Tue, 30 May 2017 17:05:30 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Zero King <l2dy@macports.org>
Subject: Re: [PATCH 6.5?/8] version: move --build-options to a test helper
Message-ID: <20170530210530.o5gbz2k24wxrfner@sigill.intra.peff.net>
References: <20170530051742.3j3yn3ipfmyrrteu@sigill.intra.peff.net>
 <20170530204553.25968-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170530204553.25968-1-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 30, 2017 at 08:45:53PM +0000, Ævar Arnfjörð Bjarmason wrote:

> On Tue, May 30, 2017 at 7:17 AM, Jeff King <peff@peff.net> wrote:
> > The "git version" command didn't traditionally accept any
> > options, and in fact ignores any you give it. When we added
> > simple option parsing for "--build-options" in 6b9c38e14, we
> > didn't improve this; we just loop over the arguments and
> > pick out the one we recognize.
> >
> > Instead, let's move to a real parsing loop, complain about
> > nonsense options, and recognize conventions like "-h".
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > I assume nobody was running "git version --foobar" and expecting it to
> > work. I guess we could also complain about "git version foobar" (no
> > dashes), but this patch doesn't. Mainly I wanted the auto-generated
> > options list.
> 
> Looks good to me. I started hacking this up the other day, but then
> thought "wait a minute, isn't this just a test helper?" and wrote this
> which I've rebased on top of your change.
> 
> I may be missing something here but isn't this a much straightforward
> way to accomplish this, or is this used by some external program
> outside of git.git that's going to rely on --build-options output?

My intent in putting it into the actual git binary was that it could
also be useful for collecting build-time knobs from users (who may be
using a binary package). Like:

  http://public-inbox.org/git/20160712035719.GA30281@sigill.intra.peff.net/

We haven't filled in that NEEDSWORK yet, but I'd rather see us go in
that direction than remove the option entirely.

-Peff
