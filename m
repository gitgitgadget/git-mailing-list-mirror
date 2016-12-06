Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3000D1FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 18:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752522AbcLFSKL (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 13:10:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:52563 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752096AbcLFSKK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 13:10:10 -0500
Received: (qmail 3627 invoked by uid 109); 6 Dec 2016 18:10:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Dec 2016 18:10:10 +0000
Received: (qmail 15505 invoked by uid 111); 6 Dec 2016 18:10:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Dec 2016 13:10:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Dec 2016 13:10:09 -0500
Date:   Tue, 6 Dec 2016 13:10:09 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com, bburky@bburky.com, jrnieder@gmail.com
Subject: Re: [PATCH v7 4/4] transport: add from_user parameter to
 is_transport_allowed
Message-ID: <20161206181008.yaz2md3343pukaov@sigill.intra.peff.net>
References: <1480621447-52399-1-git-send-email-bmwill@google.com>
 <1480623959-126129-1-git-send-email-bmwill@google.com>
 <1480623959-126129-5-git-send-email-bmwill@google.com>
 <20161201214004.3qujo5sfdn3y6c5u@sigill.intra.peff.net>
 <20161201230738.GJ54082@google.com>
 <xmqqh96n6x63.fsf@gitster.mtv.corp.google.com>
 <20161201235856.GL54082@google.com>
 <xmqqr35m3zx7.fsf@gitster.mtv.corp.google.com>
 <20161206135113.i7nlr45vg7uzgfcn@sigill.intra.peff.net>
 <xmqq60mx2bbi.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq60mx2bbi.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 06, 2016 at 09:53:53AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I don't know if that makes things any easier. I feel funny saying "no,
> > no, mine preempts yours because it is more maint-worthy", but I think
> > that order does make sense.
> >
> > I think it would be OK to put Brandon's on maint, too, though. It is a
> > refactor of an existing security feature to make it more featureful, but
> > the way it is implemented could not cause security regressions unless
> > you use the new feature (IOW, we still respect the whitelist environment
> > exactly as before).
> 
> I think I merged yours and then Brandon's on jch/pu branches in that
> order, and the conflict resolution should look OK.
> 
> I however forked yours on v2.11.0-rc1, which would need to be
> rebased to one of the earlier maintenance tracks, before we can
> merge it to 'next'.

Yeah, I built it on top of master.

It does depend on some of the http-walker changes Eric made a few months
ago. In particular, 17966c0a6 (http: avoid disconnecting on 404s for
loose objects, 2016-07-11) added some checks against the HTTP status
code, and my series modifies the checks (mostly so that ">= 400" becomes
">= 300").

Rebasing on maint-2.9 means omitting those changes. That preserves the
security properties, but means that the error handling is worse when we
see an illegal redirect. That may be OK, though.

Since the resolution is to omit the changes entirely from my series,
merging up to v2.11 wouldn't produce any conflicts. We'd need to have a
separate set of patches adding those changes back in.

-Peff
