Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 890DD1F461
	for <e@80x24.org>; Thu, 16 May 2019 05:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfEPFIi (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 01:08:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:59064 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725975AbfEPFIi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 01:08:38 -0400
Received: (qmail 5337 invoked by uid 109); 16 May 2019 05:08:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 16 May 2019 05:08:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27463 invoked by uid 111); 16 May 2019 05:09:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 16 May 2019 01:09:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 May 2019 01:08:35 -0400
Date:   Thu, 16 May 2019 01:08:35 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 6/7] config: allow configuration of multiple hook
 error behavior
Message-ID: <20190516050835.GA7723@sigill.intra.peff.net>
References: <20190514002332.121089-1-sandals@crustytoothpaste.net>
 <20190514002332.121089-8-sandals@crustytoothpaste.net>
 <CACsJy8BN32Jm62MQPLsRwKST8DDNZ7NxnJbsqBO3PJ0K2qU-Ng@mail.gmail.com>
 <20190515231017.GM7458@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190515231017.GM7458@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 15, 2019 at 11:10:17PM +0000, brian m. carlson wrote:

> > An alternative name is onError, probably more often used for event
> > callbacks. But I don't know, maybe errorBehavior is actually better.
> 
> I'm going to use "errorStrategy", since we already have
> submodule.alternateErrorStrategy.

That sounds good (and I don't care too much about the name as long as it
it is in the per-hook subsection like this).

> > should we fall back to hook.errorBehavior? That allows people to set
> > global policy, then customize just a small set of weird hooks.
> 
> Sure, that sounds good.

I like this, too.

> > maybe stop-on-first-error (or if you go with the "onError" name, I
> > think "stop" is enough). I know "stop on/after first hook" does not
> > really make any sense when you think about it. Maybe stop-on-first is
> > sufficient.
> > 
> > I was going to suggest strcasecmp. But core.whitespace (also has
> > multiple-word-values) already sets a precedent on strcmp. I think
> > we're good. Or mostly good, I don't know, we still accept False, false
> > and FALSE.
> 
> I think with errorStrategy, "stop" is fine. Simpler is better.
> 
> I literally picked what Peff had suggested in his email (mostly because
> I'm terrible at naming things), and I don't get the impression he spent
> a great deal of time analyzing the ins and outs of the names before
> sending. I could be wrong, though.

No, I didn't. :) I think "stop" is good. If the others are
report-any-error and report-any-success, then the matching name for this
could be report-first-error.

> > > +               else if (!strcmp(value, "report-any-error"))
> > 
> > I couldn't guess based on this name alone, whether we continue or stop
> > after the reporting part. The 7/7 document makes it clear though. So
> > all good.
> 
> I'm open to hearing better suggestions if anyone has any.

Maybe report-all-errors would indicate that it was going to run all of
the hooks. I dunno. I think the documentation you wrote is plenty clear
with the current name.

-Peff
