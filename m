Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02A9220282
	for <e@80x24.org>; Thu, 15 Jun 2017 05:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750861AbdFOFmM (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 01:42:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:40417 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750784AbdFOFmM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 01:42:12 -0400
Received: (qmail 24970 invoked by uid 109); 15 Jun 2017 05:42:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jun 2017 05:42:11 +0000
Received: (qmail 19637 invoked by uid 111); 15 Jun 2017 05:42:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jun 2017 01:42:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Jun 2017 01:42:09 -0400
Date:   Thu, 15 Jun 2017 01:42:09 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: rs/strbuf-addftime-zZ, was Re: What's cooking in git.git (Jun
 2017, #04; Tue, 13)
Message-ID: <20170615054209.yfucmiq3pghxu76j@sigill.intra.peff.net>
References: <xmqqshj34ldr.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1706141245520.171564@virtualbox>
 <20170614111043.xlfsgclbyrqektb3@sigill.intra.peff.net>
 <e9260c40-c49f-d7f6-70c2-a28c1b3104a2@web.de>
 <alpine.DEB.2.21.1.1706142303510.171564@virtualbox>
 <f80aa20c-dd7e-41e6-f35f-5c633c169732@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f80aa20c-dd7e-41e6-f35f-5c633c169732@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 15, 2017 at 01:03:29AM +0200, René Scharfe wrote:

> Am 14.06.2017 um 23:04 schrieb Johannes Schindelin:
> > On Wed, 14 Jun 2017, René Scharfe wrote:
> > 
> >> Does someone actually expect %z to show time zone names instead of
> >> offsets on Windows?
> > 
> > Not me ;-)
> > 
> > I cannot speak for anyone else, as I lack that information, though.
> 
> Before the patch %z would always expand to +0000 on Linux and to the
> name of the local time zone on Windows, no matter which offset was
> actually given.  So it was broken in either case (even though it got
> at least some aspects right by accident for some commits).  Based on
> that I'd think handling %z internally should be OK.

I agree.

> But there's more.  strftime on Windows doesn't support common POSIX-
> defined tokens like %F (%Y-%m-%d) and %T (%H:%M:%S). We could handle
> them as well.  Do we want that?  At least we'd have to update the
> added test that uses them..
> 
> Here's the full list of tokens in POSIX [1], but not supported by
> Windows [2]: %C, %D, %F, %G, %R, %T, %V, %e, %g, %h, %n, %r, %t, %u
> plus the modifiers %E and %O.

I don't have a real opinion on that. The point of adding strftime was
always to give the user access to whatever their system supports. In
particular "%c" which we cannot emulate ourselves.

If people want support for those other things on platforms that don't
have it, I have no real objection. But I also don't know that it's worth
spending time on if nobody is asking for it.

-Peff
