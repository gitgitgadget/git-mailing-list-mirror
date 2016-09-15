Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45F17207DF
	for <e@80x24.org>; Thu, 15 Sep 2016 07:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933287AbcIOHS2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 03:18:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:43567 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754112AbcIOHS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 03:18:27 -0400
Received: (qmail 15732 invoked by uid 109); 15 Sep 2016 07:18:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Sep 2016 07:18:26 +0000
Received: (qmail 7229 invoked by uid 111); 15 Sep 2016 07:18:37 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Sep 2016 03:18:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Sep 2016 00:18:23 -0700
Date:   Thu, 15 Sep 2016 00:18:23 -0700
From:   Jeff King <peff@peff.net>
To:     Kevin Daudt <me@ikke.info>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC 0/1] mailinfo: de-quote quoted-pair in header fields
Message-ID: <20160915071822.dpfgg7yldtzar4b2@sigill.intra.peff.net>
References: <20160913234612.22806-2-me@ikke.info>
 <xmqqr38ns5wi.fsf@gitster.mtv.corp.google.com>
 <20160914050919.qhv2gxzjyj5ydpub@sigill.intra.peff.net>
 <xmqqmvjbrpp4.fsf@gitster.mtv.corp.google.com>
 <20160914160308.GB26893@ikke.info>
 <xmqqoa3qqsw9.fsf@gitster.mtv.corp.google.com>
 <20160914191759.5unwaq2eequ4pifr@sigill.intra.peff.net>
 <xmqqfup2qny9.fsf@gitster.mtv.corp.google.com>
 <20160914193819.ua5ubvbf5wz7tvuj@sigill.intra.peff.net>
 <20160915051533.GC26893@ikke.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160915051533.GC26893@ikke.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 15, 2016 at 07:15:33AM +0200, Kevin Daudt wrote:

> > > Another small thing I am not sure about is if the \ quoting can hide
> > > an embedded newline in the author name.  Would we end up turning
> > > 
> > > 	From: "Jeff \
> > >             King" <peff@peff.net>
> > > 
> > > or somesuch into
> > > 
> > > 	Author: Jeff
> > >         King
> > >         Email: peff@peff.net
> > > 
> > > ;-)
> > 
> > Heh, yeah. That is another reason to clean up and sanitize as much as
> > possible before stuffing it into another text format that will be
> > parsed.
> 
> A quoted string cannot contain newlines according to the RFC, so I think
> we don't need to care about that.

I wondered how we handled something like:

  From: =?UTF-8?q?J=0Aff=20King?= <peff@peff.net>

which sticks a newline into the middle of the buffer. We do decode it
that way, but eventually call cleanup_space() which converts a run of 1
or more isspace() characters into a single space (0x20). So you end up
with:

  Author: J ff King

which is probably reasonable.

> Makes sense, the current itteration of my patch already strips exterior
> quotes, no matter where they happen.
> 
> I will send a patch soon.

Great. Thanks for working on this.

-Peff
