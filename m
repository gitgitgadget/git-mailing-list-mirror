Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E111201A9
	for <e@80x24.org>; Tue, 21 Feb 2017 22:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752752AbdBUWYz (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 17:24:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:59506 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752298AbdBUWYy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 17:24:54 -0500
Received: (qmail 5376 invoked by uid 109); 21 Feb 2017 22:24:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Feb 2017 22:24:53 +0000
Received: (qmail 16200 invoked by uid 111); 21 Feb 2017 22:24:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Feb 2017 17:24:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Feb 2017 17:24:51 -0500
Date:   Tue, 21 Feb 2017 17:24:51 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC PATCH] show decorations at the end of the line
Message-ID: <20170221222451.kiuyrp3raufhvkte@sigill.intra.peff.net>
References: <20170215002901.gtzegvhyy7d6cvrb@sigill.intra.peff.net>
 <xmqqefywnk5a.fsf@gitster.mtv.corp.google.com>
 <CA+55aFw3ZRtgsLGW-TFqpq-3uCw55L42p7cF=Q-73qM_VPuYsQ@mail.gmail.com>
 <CA+P7+xqtPwzt3J6O05TP=E_hh-ko97adn+__Zmc0DNSDqEnEHw@mail.gmail.com>
 <20170220004648.c2zz6bm2hylvep6x@sigill.intra.peff.net>
 <CA+55aFwdUxCvmi28T3yn1K4rqn2bZmJBdTRr7tSbMa-g5izHbw@mail.gmail.com>
 <xmqqpoibfgo3.fsf@gitster.mtv.corp.google.com>
 <CA+55aFwT2HUBzZO8Gpt9tHoJtdRxv9oe3TDoSH5jcEOixRNBXg@mail.gmail.com>
 <20170221210808.3ryri33ve7w7csdp@sigill.intra.peff.net>
 <xmqq8tozfc7a.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8tozfc7a.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 21, 2017 at 01:47:37PM -0800, Junio C Hamano wrote:

> > So the best I could come up with is:
> >
> >   git config pretty.twoline '%C(auto)%h %s%C(auto)%+d'
> >   git log --format=twoline
> > [...]
>
> Yeah, I had a similar thought to use something around "%n%-d", but
> 
>  $ git log --format='%h%n%-d%C(auto) %s %C(auto)'
> 
> is not it.
> 
> I guess we could pile on another hack to make the sign between % and
> the format specifier cumulative and then "%n%-+d" may do what we
> want, but we need a true %(if)...%(then)...%(else)...%(end) support
> if we really want to do this thing properly.

Yeah, I'd rather not pile up more hacks. The for-each-ref placeholders
are more verbose, but I think the end result is a lot easier to read and
maintain, and the terseness doesn't matter if you're sticking it behind
an alias or config option.

(Don't get me wrong; I think the %(if) ones are pretty ugly, too, but
the next step beyond that is embedding some kind of templating or
scripting language, and that just seems like overkill).

-Peff
