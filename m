Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F740201A8
	for <e@80x24.org>; Mon, 20 Feb 2017 00:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbdBTArX (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Feb 2017 19:47:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:58537 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751930AbdBTArX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Feb 2017 19:47:23 -0500
Received: (qmail 8999 invoked by uid 109); 20 Feb 2017 00:46:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Feb 2017 00:46:51 +0000
Received: (qmail 23760 invoked by uid 111); 20 Feb 2017 00:46:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 19 Feb 2017 19:46:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 19 Feb 2017 19:46:48 -0500
Date:   Sun, 19 Feb 2017 19:46:48 -0500
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC PATCH] show decorations at the end of the line
Message-ID: <20170220004648.c2zz6bm2hylvep6x@sigill.intra.peff.net>
References: <alpine.LFD.2.20.1702110943460.31350@i7.lan>
 <CA+55aFw2S14a4_4YK0b6PNK4TH_AUo_+2JN+PTyBTufNeB5t6A@mail.gmail.com>
 <xmqq1sv2fq6m.fsf@gitster.mtv.corp.google.com>
 <CA+55aFy-vvOBu5Y4KDeteUyK-7U7yTa1HoqHo+hME1=8bq7Xhw@mail.gmail.com>
 <xmqq7f4tdcua.fsf@gitster.mtv.corp.google.com>
 <xmqqr330779h.fsf@gitster.mtv.corp.google.com>
 <20170215002901.gtzegvhyy7d6cvrb@sigill.intra.peff.net>
 <xmqqefywnk5a.fsf@gitster.mtv.corp.google.com>
 <CA+55aFw3ZRtgsLGW-TFqpq-3uCw55L42p7cF=Q-73qM_VPuYsQ@mail.gmail.com>
 <CA+P7+xqtPwzt3J6O05TP=E_hh-ko97adn+__Zmc0DNSDqEnEHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xqtPwzt3J6O05TP=E_hh-ko97adn+__Zmc0DNSDqEnEHw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 19, 2017 at 03:03:21PM -0800, Jacob Keller wrote:

> >> I just got bitten by a fallout.  I have
> >>
> >>     $ git recent --help
> >>     `git recent' is aliased to `log --oneline --branches --no-merges \
> >>          --source --since=3.weeks'
> >>
> >> but now the branch names are shown at the end, which defeats the
> >> whole point of the alias.
> >
> > Yes, your situation actually wants those decorations as primary
> > things, so having them at the end is indeed pointless.
> >
> > So I think we should just discard that patch of mine.
> >
> >                  Linus
> 
> I would think that in general putting them at the end makes more
> sense, but we should have the ability to use them in format specifiers
> so that users are free to customize it exactly how they want. That is,
> I agree with the reasoning presented in the original patch, but think
> Junio's case can be solved by strengthening the custom formats.

I think there are two potential patches:

  1. Add a custom-format placeholder for the --source value.
     This is an obvious improvement that doesn't hurt anyone.

  2. Switch --decorate to the end by default, but _not_ --source.

     This use case _could_ be served already by using a custom format
     with "%d". So it's really just a matter of having better-looking
     default.

     It might hurt somebody's script, but for the reasons discussed
     earlier in the thread, people are unlikely to be parsing it (it's
     more likely somebody would just complain because they think the
     decoration-first behavior is prettier).

-Peff
