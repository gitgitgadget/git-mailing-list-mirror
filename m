Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E575201B0
	for <e@80x24.org>; Sat, 25 Feb 2017 21:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbdBYV63 (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 16:58:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:34213 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752055AbdBYV62 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 16:58:28 -0500
Received: (qmail 9308 invoked by uid 109); 25 Feb 2017 21:51:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 25 Feb 2017 21:51:47 +0000
Received: (qmail 8524 invoked by uid 111); 25 Feb 2017 21:51:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 25 Feb 2017 16:51:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 25 Feb 2017 16:51:44 -0500
Date:   Sat, 25 Feb 2017 16:51:44 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] commit: don't check for space twice when looking for
 header
Message-ID: <20170225215144.hb7huqmv3seaoaqf@sigill.intra.peff.net>
References: <23989e76-24ba-90a4-91a9-9f66bfccb7c9@web.de>
 <b1d5c882-38b8-dd2d-2e5f-aafb8dfada81@web.de>
 <20170225201522.uan52fwey6zjosym@sigill.intra.peff.net>
 <6462e74c-1ee7-7ed0-0695-9889df803943@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6462e74c-1ee7-7ed0-0695-9889df803943@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 25, 2017 at 10:39:29PM +0100, René Scharfe wrote:

> > > +		(len == 8 && !memcmp(field, "encoding", 8)));
> > 
> > Unrelated, but this could probably be spelled with a macro and strlen()
> > to avoid the magic numbers. It would probably be measurably slower for a
> > compiler which doesn't pre-compute strlen() on a string literal, though.
> 
> sizeof(string_constant) - 1 might be a better choice here than strlen().

Yeah. If you use a macro, that works. If it's an inline function you'd
need strlen(). That's a tradeoff we've already made in skip_prefix_mem()
and strip_suffix(), but it's not like we expect this list to grow much,
so it may not be worth fussing with.

-Peff
