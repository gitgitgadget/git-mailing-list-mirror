Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D58E20988
	for <e@80x24.org>; Sat, 15 Oct 2016 17:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753626AbcJORl5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Oct 2016 13:41:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:57905 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753073AbcJORlz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Oct 2016 13:41:55 -0400
Received: (qmail 2670 invoked by uid 109); 15 Oct 2016 17:41:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 15 Oct 2016 17:41:54 +0000
Received: (qmail 18265 invoked by uid 111); 15 Oct 2016 17:42:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 15 Oct 2016 13:42:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 15 Oct 2016 13:41:52 -0400
Date:   Sat, 15 Oct 2016 13:41:52 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10 13/14] convert: add filter.<driver>.process option
Message-ID: <20161015174152.i22texcvnm6jl7ef@sigill.intra.peff.net>
References: <20161008112530.15506-1-larsxschneider@gmail.com>
 <20161008112530.15506-14-larsxschneider@gmail.com>
 <e09a63ee-dad2-a8fb-e47f-0559d9507e1c@gmail.com>
 <03278DA5-34B8-42F1-B52E-A42A3BCD5FB8@gmail.com>
 <37c12539-3edd-e04b-6e09-e977a854661c@gmail.com>
 <3732E902-2FE9-4C99-B27D-69B9A3FF8639@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3732E902-2FE9-4C99-B27D-69B9A3FF8639@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 15, 2016 at 07:45:48AM -0700, Lars Schneider wrote:

> >> I have to agree that "capability=<capability>" might read a
> >> little bit nicer. However, Peff suggested "<capability>=true" 
> >> as his preference and this is absolutely OK with me.
> > 
> > From what I remember it was Peff stating that he thinks "<foo>=true"
> > is easier for parsing (it is, but we still need to support the harder
> > way parsing anyway), and offered that "<foo>" is good enough (if less
> > consistent).

I don't mind that much if you want to do it the other way. You are the
one writing the parsing/use code.

> > Also, with "capability=<foo>" we can be more self descriptive,
> > for example "supported-command=<foo>"; though "capability" is good
> > enough for me.
> > 
> > For example
> > 
> > packet:          git> wants=clean
> > packet:          git> wants=smudge
> > packet:          git> wants=size
> > packet:          git> 0000
> > packet:          git< supports=clean
> > packet:          git< supports=smudge
> > packet:          git< 0000
> > 
> > Though coming up with good names is hard; and as I said "capability"
> > is good enough; OTOH with "smudge=true" etc. we don't need to come
> > up with good name at all... though I wonder if it is a good thing `\_o,_/
> 
> How about this (I borrowed these terms from contract negotiation)?
> 
> packet:          git> offers=clean
> packet:          git> offers=smudge
> packet:          git> offers=size
> packet:          git> 0000
> packet:          git< accepts=clean
> packet:          git< accepts=smudge
> packet:          git< 0000
> 
> @Peff: Would that be OK for you?

Is it always an offers/accepts relationship? Can the response say "you
did not ask about <foo>, but just so you know I support it"?

I cannot think offhand of an example, but at the same time, if you leave
the terms as generic as possible, you do not end up later with words
that do not make sense. It is trading off one problem now (vagueness of
the protocol terms) for a potential one later (words that have a
specific meaning, but one that is not accurate).

I don't have a strong preference, though.

-Peff
