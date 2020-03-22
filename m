Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19A9C4332D
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 06:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B53CC20753
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 06:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgCVGtl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 02:49:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:46852 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725881AbgCVGtl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 02:49:41 -0400
Received: (qmail 24448 invoked by uid 109); 22 Mar 2020 06:49:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 22 Mar 2020 06:49:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30075 invoked by uid 111); 22 Mar 2020 06:59:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 22 Mar 2020 02:59:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 22 Mar 2020 02:49:40 -0400
From:   Jeff King <peff@peff.net>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] test-lib: allow short options to be stacked
Message-ID: <20200322064940.GA599744@coredump.intra.peff.net>
References: <48c28683412e3e0803d4c7189a6d66daddcdc580.1584759277.git.matheus.bernardino@usp.br>
 <20200321062611.GA1441446@coredump.intra.peff.net>
 <CAHd-oW4cGEwyge+BPRGiOsmMxr5ne9Ufk-BOM4EgG_i6qTxxMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHd-oW4cGEwyge+BPRGiOsmMxr5ne9Ufk-BOM4EgG_i6qTxxMg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 21, 2020 at 03:50:55PM -0300, Matheus Tavares Bernardino wrote:

> > which seems reasonable. But:
> >
> >   ./t1234-foo.sh -rr 5 6
> >
> > would get garbled.
> 
> ... we could prohibit using more than one "short option with
> arguments" in the same bundle. This would not only solve the problem
> for "-rr 5 6"[1] but also for the scenario of future new options. And
> it's quite simple to implement, we just have to check whether
> $store_arg_to is set before setting it to another value. I'll try that
> for v2.

Yeah, I'd be perfectly happy with that. This bundling is a new format
that did not exist before, so we are not taking away anything you could
previously do. As long as we don't produce a wrong or confusing result
(and instead say "don't do that; we don't support it", anybody else is
free to come along later and make it work. :)

> [1]: Someone that used '-rr 5 6' might have wanted the script to run
> *both* tests 5 and 6. But I don't think we need to support that now,
> since '-r 5 -r 6' doesn't do that as well (instead, the last value
> overrides all previous ones).

Heh, that's what I assumed "-r 5 -r 6" would do, but I guess it goes to
show that I do not use that option very much. :)

-Peff
