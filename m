Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76AD51F89C
	for <e@80x24.org>; Tue, 17 Jan 2017 08:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750866AbdAQH7s (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 02:59:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:40040 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750846AbdAQH7q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 02:59:46 -0500
Received: (qmail 4879 invoked by uid 109); 17 Jan 2017 07:52:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Jan 2017 07:52:56 +0000
Received: (qmail 15136 invoked by uid 111); 17 Jan 2017 07:53:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Jan 2017 02:53:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Jan 2017 02:52:54 -0500
Date:   Tue, 17 Jan 2017 02:52:54 -0500
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jan 2017, #02; Sun, 15)
Message-ID: <20170117075254.h4nnnj2alricotcy@sigill.intra.peff.net>
References: <xmqqh94zbwlu.fsf@gitster.mtv.corp.google.com>
 <257b4175-9879-7814-5d8d-02050792574d@kdbg.org>
 <alpine.DEB.2.20.1701161251100.3469@virtualbox>
 <20170116160456.ltbb7ofe47xos7xo@sigill.intra.peff.net>
 <alpine.DEB.2.20.1701161746200.3469@virtualbox>
 <20170116220014.bwi5xi2br56lyqsw@sigill.intra.peff.net>
 <CA+P7+xqi8cXK8ZEdvy3U9jJ9wZwkGLYNR0j_xvvCJwq12B4G8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xqi8cXK8ZEdvy3U9jJ9wZwkGLYNR0j_xvvCJwq12B4G8g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 16, 2017 at 05:33:44PM -0800, Jacob Keller wrote:

> > I am certainly sympathetic to the idea that the "?" is ugly and
> > potentially confusing. But I think it's at least a step forward for this
> > particular example.
> 
> Would it be possible to convert the CR to a literal \r printing? Since
> it's pretty common to show these characters as slash-escaped? (Or is
> that too much of a Unix world thing?) I know I'd find \r less
> confusing than '?'

I discussed this in the original commit message.

Yes, it's possible, but it's a little tricky. We want to fprintf() the
whole thing as a unit (to increase the chances of it being done in an
atomic write()). We don't want to use a dynamic buffer, since we might
be called from a signal handler, or when malloc has failed, etc.

So I tried to stick to something that could reliably done in place. We
could probably get by with 2 static buffers and copy from one to the
other (if stack space is an issue, the current one is 4K, which is
probably excessively large anyway).

Mostly I just assumed that it was highly unlikely anybody would see this
escaping in the first place. So I tried to go with the simplest
solution.

-Peff
