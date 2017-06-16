Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91B201FA7B
	for <e@80x24.org>; Fri, 16 Jun 2017 12:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753167AbdFPMTC (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 08:19:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:41484 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752993AbdFPMTC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 08:19:02 -0400
Received: (qmail 15802 invoked by uid 109); 16 Jun 2017 12:19:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Jun 2017 12:19:01 +0000
Received: (qmail 4435 invoked by uid 111); 16 Jun 2017 12:19:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Jun 2017 08:19:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Jun 2017 08:18:59 -0400
Date:   Fri, 16 Jun 2017 08:18:59 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Ulrich Mueller <ulm@gentoo.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] date: use localtime() for "-local" time formats
Message-ID: <20170616121859.oas4v2ddleflufus@sigill.intra.peff.net>
References: <20170615134958.mzmdmhonjsnconu2@sigill.intra.peff.net>
 <20170615135216.2jfsrjpicku6zxv3@sigill.intra.peff.net>
 <b79d1c3d-e43e-a82b-2d33-2283cb0aa5ef@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b79d1c3d-e43e-a82b-2d33-2283cb0aa5ef@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 15, 2017 at 06:12:31PM +0200, René Scharfe wrote:

> Am 15.06.2017 um 15:52 schrieb Jeff King:
> > But for the special case of the "-local" formats, we can
> > just skip the adjustment and use localtime() instead of
> > gmtime(). This makes --date=format-local:%Z work correctly,
> > showing the local timezone instead of an empty string.
> 
> Documentation/rev-list-options.txt should be updated to mention that %Z
> is passed to strftime in the local case, no?

I wasn't sure if we wanted to get into that. Your documentation update
(with an empty string) says only that they are "handled internally".
While it is true that we aren't handling %Z internally anymore, the
point is that we try to do something sane which may or may not match
what your system strftime() does. And that continues to be the case
after my patch.

So unless we are going to give the full breakdown of when %Z is empty
and when it is not, I prefer to leave it unspecified.

> > I don't have a Windows system to test this on, but from the output Dscho
> > provided earlier, I believe this should pass.
> 
> The first patch applies with some fuzz on master of Git for Windows, the
> second one applies cleanly.  A "typedef unsigned long timestamp_t;" is
> required to compile it; such a fixup won't be needed for long, I guess.
> t0006 succeeds.

Thanks for checking.

-Peff
