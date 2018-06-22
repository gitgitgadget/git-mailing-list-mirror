Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96BE31F516
	for <e@80x24.org>; Fri, 22 Jun 2018 07:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751203AbeFVHWJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 03:22:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:51660 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751057AbeFVHWI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 03:22:08 -0400
Received: (qmail 31475 invoked by uid 109); 22 Jun 2018 07:22:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Jun 2018 07:22:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15625 invoked by uid 111); 22 Jun 2018 07:22:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 22 Jun 2018 03:22:26 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Jun 2018 03:22:07 -0400
Date:   Fri, 22 Jun 2018 03:22:06 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v2 0/7] grep.c: teach --column to 'git-grep(1)'
Message-ID: <20180622072206.GB21200@sigill.intra.peff.net>
References: <cover.1529365072.git.me@ttaylorr.com>
 <cover.1529524852.git.me@ttaylorr.com>
 <20180621115302.GB15293@sigill.intra.peff.net>
 <20180621214549.GA47197@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180621214549.GA47197@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 21, 2018 at 04:45:49PM -0500, Taylor Blau wrote:

> > but not this:
> >
> >   $ ./git grep --column -v --not -e scalable --and --not -e fast -- README.md
> >   README.md:13:Git - fast, scalable, distributed revision control system
> >   README.md:16:Git is a fast, scalable, distributed revision control system with an
> >
> > I wasn't sure where we landed in the discussion on "how much crazy stuff
> > to support". But AFAIK, the code in this iteration handles every crazy
> > case already except this one. If we're going to care about OR, maybe we
> > should just cover all cases.
> 
> Good catch. As I understand it, we need to short-circuit AND because an
> --invert or a --not above it in the expression tree would cause it to be
> turned into an OR by de Morgan's Law, and therefore be susceptible to
> the same reasoning that caused me to remove short-circuiting on OR.

Right, exactly.

> > Unfortunately %z isn't portable. You have to use:
> >
> >   xsnprintf(buf, sizeof(buf), "%"PRIuMAX, (uintmax_t)cno);
> 
> I see. Per your next note, I've changed this to "%"PRIuMAX (and the
> appropriate cast into uintmax_t), and will send another patch out in the
> future changing it _back_ to "%zu" and figure out how folks feel about
> it.

That sounds perfect. I think the time may be good for a "%zu"
weather-balloon, but it's best not to tangle it up with your other
changes.

-Peff
