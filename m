Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C08EC1FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 22:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751427AbdBMWiY (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 17:38:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:54575 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751350AbdBMWiW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 17:38:22 -0500
Received: (qmail 12064 invoked by uid 109); 13 Feb 2017 22:38:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Feb 2017 22:38:22 +0000
Received: (qmail 29080 invoked by uid 111); 13 Feb 2017 22:38:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Feb 2017 17:38:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Feb 2017 17:38:19 -0500
Date:   Mon, 13 Feb 2017 17:38:19 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC PATCH] show decorations at the end of the line
Message-ID: <20170213223819.gr3wndswieu4bbvn@sigill.intra.peff.net>
References: <alpine.LFD.2.20.1702110943460.31350@i7.lan>
 <CA+55aFw2S14a4_4YK0b6PNK4TH_AUo_+2JN+PTyBTufNeB5t6A@mail.gmail.com>
 <xmqq1sv2fq6m.fsf@gitster.mtv.corp.google.com>
 <CA+55aFy-vvOBu5Y4KDeteUyK-7U7yTa1HoqHo+hME1=8bq7Xhw@mail.gmail.com>
 <xmqq7f4tdcua.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7f4tdcua.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 13, 2017 at 01:01:49PM -0800, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > And if you actually want decorations, and you're parsing them, you are
> > *not* going to script it with "--oneline --decorations", because the
> > end result is basically impossible to parse already (because it's
> > ambiguous - think about parentheses in the commit message).
> 
> OK.  So let's wait to hear from others if they like the "obviously"
> improved output.  Even though I find the decorations indispensable
> in my "git log" output, I personally do not have much preference
> either way, as my screen is often wide enough ;-)

I have a slight preference for the new output (decorations at the end)
versus the original, but I could go either way.

I don't think the scripting compatibility concerns are an issue, for all
the reasons given in the thread.

There is one related option, --source, which also puts its data between
the hash and the subject in --oneline. In theory that should be treated
similarly, though:

  1. It's already really ugly, as it does not even get the parentheses
     and coloring.

  2. It's perhaps more likely to get scripted, as it really is parseable
     in the current state.

I'm not sure if a better path forward would be to just extend the idea
of "decorator" to possibly include more than just ref-tips. On the other
hand, if you really want to get fancy with formatting, we already have a
complete formatting language. Perhaps it should learn a placeholder for
the "--source" data.

Similarly, I've often wanted a "contained in this tags/branches"
annotation for each commit. It's not too expensive to compute if you
topo-sort the set of commits and just paint down as you traverse.

Anyway, I think none of that needs to block changes to --decorate
output. Just thinking out loud.

-Peff
