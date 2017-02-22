Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B359201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 22:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933776AbdBVW0H (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 17:26:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:60241 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932492AbdBVWZS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 17:25:18 -0500
Received: (qmail 27333 invoked by uid 109); 22 Feb 2017 21:58:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Feb 2017 21:58:36 +0000
Received: (qmail 23589 invoked by uid 111); 22 Feb 2017 21:58:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Feb 2017 16:58:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Feb 2017 16:58:33 -0500
Date:   Wed, 22 Feb 2017 16:58:33 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <dturner@twosigma.com>, git@vger.kernel.org,
        sandals@crustytoothpaste.net,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] http(s): automatically try NTLM authentication first
Message-ID: <20170222215833.d7htyo32ptfse5l4@sigill.intra.peff.net>
References: <20170222173936.25016-1-dturner@twosigma.com>
 <xmqqpoiaasgj.fsf@gitster.mtv.corp.google.com>
 <20170222210636.k2ps3qhhpiyyv6cp@sigill.intra.peff.net>
 <xmqq4lzlc408.fsf@gitster.mtv.corp.google.com>
 <20170222213542.opunuepfmj557zyr@sigill.intra.peff.net>
 <xmqqwpchanxz.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwpchanxz.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 22, 2017 at 01:57:28PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Wed, Feb 22, 2017 at 01:25:11PM -0800, Junio C Hamano wrote:
> >> 
> >> Thanks for your thoughts.  I'd think that we should take this change
> >> and leave the optimization for later, then.  It's not like the
> >> change of the default is making the normal situation any worse, it
> >> seems.
> >
> > I'm not excited that it will start making known bogus-username requests
> > by default to servers which do not even support Negotiate. I guess that
> > is really the server-operators problem, but it feels pretty hacky.
> 
> I guess that's another valid concern.  The servers used to be able
> to say "Ah, this repository needs auth and this request does not, so
> reject it without asking the auth-db".  Now it must say "Ah, this
> repository needs auth and this request does have one, but it is
> empty so let's not even bother the auth-db" in order to reject a
> useless "empty-auth" request with the same efficiency.
> 
> After the first request without auth (that fails), do we learn
> anything useful from the server side (like "it knows Negotiate")
> that we can use to flip the "empty-auth" bit to give a better
> default to people from both worlds, I wonder...?

Yes, that's exactly what I was trying to say in my first message.

-Peff
