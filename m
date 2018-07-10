Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE40F1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 03:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933292AbeGJD4m (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 23:56:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:53098 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932939AbeGJD4h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 23:56:37 -0400
Received: (qmail 20854 invoked by uid 109); 10 Jul 2018 03:56:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Jul 2018 03:56:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19432 invoked by uid 111); 10 Jul 2018 03:56:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 09 Jul 2018 23:56:39 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Jul 2018 23:56:35 -0400
Date:   Mon, 9 Jul 2018 23:56:35 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Paul Smith <paul@mad-scientist.net>,
        Daniel Jacques <dnj@google.com>, git@vger.kernel.org
Subject: Re: Git 2.18: RUNTIME_PREFIX... is it working?
Message-ID: <20180710035635.GA13459@sigill.intra.peff.net>
References: <97803ec8dae0a73bae301a37377b7b4a78f77e99.camel@mad-scientist.net>
 <nycvar.QRO.7.76.6.1807041312150.75@tvgsbejvaqbjf.bet>
 <986185d30a0f09b4e2a9832d324a265cd3da7354.camel@mad-scientist.net>
 <nycvar.QRO.7.76.6.1807061059260.75@tvgsbejvaqbjf.bet>
 <CAD1RUU-4a_jV_JjozjXOR4bi+_7rFW_AjmHbbrw6NHJ77=oGkw@mail.gmail.com>
 <bf0d4f33701ec694917f2e710c3fb097085c8d69.camel@mad-scientist.net>
 <nycvar.QRO.7.76.6.1807082346140.75@tvgsbejvaqbjf.bet>
 <20180709195822.GA9000@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180709195822.GA9000@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 09, 2018 at 03:58:22PM -0400, Jeff King wrote:

> On Sun, Jul 08, 2018 at 11:52:22PM +0200, Johannes Schindelin wrote:
> 
> > Now, if you care to have a look at Dan's (and my) patches to implement
> > RUNTIME_PREFIX so that it looks for a directory *relative to the Git
> > binary*, you will see that it is far from portable. In fact, it is very
> > definitely not portable, and needs specific support for *every single
> > supported Operating System*. And while we covered a lot, we did not cover
> > all of them.
> > 
> > So unfortunately, it is impossible to make it the default, I am afraid.
> 
> Would it be reasonable to make RUNTIME_PREFIX the default on systems
> where we _do_ have that support? AFAIK there is no downside to having it
> enabled (minus a few syscalls to find the prefix, I suppose, but I
> assume that's negligible).

Brainstorming a little more on "what could be the possible downsides".

If I understand correctly, the Linux implementation requires reading
from /proc. So an executable that only did RUNTIME_PREFIX (with no
fallback to static paths) would be unhappy inside a chroot or other
container that didn't mount /proc.

-Peff
