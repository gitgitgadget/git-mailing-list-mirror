Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3431A1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 02:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932875AbeGJCVs (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 22:21:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:53084 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932824AbeGJCVo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 22:21:44 -0400
Received: (qmail 17250 invoked by uid 109); 10 Jul 2018 02:21:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Jul 2018 02:21:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19071 invoked by uid 111); 10 Jul 2018 02:21:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 09 Jul 2018 22:21:44 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Jul 2018 22:21:41 -0400
Date:   Mon, 9 Jul 2018 22:21:41 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Paul Smith <paul@mad-scientist.net>,
        Daniel Jacques <dnj@google.com>, git@vger.kernel.org
Subject: Re: Git 2.18: RUNTIME_PREFIX... is it working?
Message-ID: <20180710022141.GC10248@sigill.intra.peff.net>
References: <97803ec8dae0a73bae301a37377b7b4a78f77e99.camel@mad-scientist.net>
 <nycvar.QRO.7.76.6.1807041312150.75@tvgsbejvaqbjf.bet>
 <986185d30a0f09b4e2a9832d324a265cd3da7354.camel@mad-scientist.net>
 <nycvar.QRO.7.76.6.1807061059260.75@tvgsbejvaqbjf.bet>
 <CAD1RUU-4a_jV_JjozjXOR4bi+_7rFW_AjmHbbrw6NHJ77=oGkw@mail.gmail.com>
 <bf0d4f33701ec694917f2e710c3fb097085c8d69.camel@mad-scientist.net>
 <nycvar.QRO.7.76.6.1807082346140.75@tvgsbejvaqbjf.bet>
 <20180709195822.GA9000@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1807092225120.75@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1807092225120.75@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 09, 2018 at 10:26:54PM +0200, Johannes Schindelin wrote:

> > Would it be reasonable to make RUNTIME_PREFIX the default on systems
> > where we _do_ have that support? AFAIK there is no downside to having it
> > enabled (minus a few syscalls to find the prefix, I suppose, but I
> > assume that's negligible).
> > 
> > I.e., a patch to config.mak.uname (and possibly better support for
> > _disabling_ it, though I think "make RUNTIME_PREFIX=" would probably
> > work).
> 
> The obvious downside is that we would be a lot more likely to break one
> side of the equation. At least right now, we have Git for Windows being a
> prime user of RUNTIME_PREFIX (so breakages should be caught relatively
> quickly), and macOS/Linux *not* being users of that feature (so breakages
> in the non-RUNTIME_PREFIX code paths should be caught even quicker). By
> turning on RUNTIME_PREFIX for the major platforms, the fringe platforms
> are even further out on their own.

That's true. On the other hand, we have a zillion compat features for
fringe platforms already, so there already is an expectation that people
on those platforms would need to occasionally report and fix
system-specific bugs. Perhaps thinking of it not as an feature to opt
into, but rather as a compat for "your system has not caught up to the
modern world by implementing RUNTIME_PREFIX" would encourage people on
those platforms to implement the necessary scaffolding.

I also have a gut feeling that it is much easier for static-path devs to
break RUNTIME_PREFIX folks, rather than the other way around, simply
because RUNTIME_PREFIX has a lot more moving parts. But I admit that's
just a feeling.

-Peff
