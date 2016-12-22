Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4770D1FF40
	for <e@80x24.org>; Thu, 22 Dec 2016 03:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757562AbcLVD72 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Dec 2016 22:59:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:59563 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753379AbcLVD71 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2016 22:59:27 -0500
Received: (qmail 19638 invoked by uid 109); 22 Dec 2016 03:59:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Dec 2016 03:59:27 +0000
Received: (qmail 17262 invoked by uid 111); 22 Dec 2016 04:00:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Dec 2016 23:00:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Dec 2016 22:59:23 -0500
Date:   Wed, 21 Dec 2016 22:59:23 -0500
From:   Jeff King <peff@peff.net>
To:     "Kyle J. McKay" <mackyle@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] mailinfo.c: move side-effects outside of assert
Message-ID: <20161222035923.chgdv7pcbzevihhm@sigill.intra.peff.net>
References: <900a55073f78a9f19daca67e468d334@3c843fe6ba8f3c586a21345a2783aa0>
 <20161219200259.nqqyvk6c72bcoaui@sigill.intra.peff.net>
 <A916CED6-C49D-41D8-A7EE-A5FEDA641F4A@gmail.com>
 <alpine.DEB.2.20.1612201511480.54750@virtualbox>
 <20161220164526.qnwnmr7cvyycmw6a@sigill.intra.peff.net>
 <222ACFD4-ED9A-4B94-8BDD-3C70648A684B@gmail.com>
 <20161221155539.aykcmkuzqvq733ri@sigill.intra.peff.net>
 <F5001DF2-20C2-4757-997F-9D40BD48E1D9@gmail.com>
 <99C4A905-D66B-4609-9E55-06F9BC301C74@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <99C4A905-D66B-4609-9E55-06F9BC301C74@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 21, 2016 at 07:53:15PM -0800, Kyle J. McKay wrote:

> It seems to me what you are saying is that Git's "assert" calls are
> DIAGNOSTIC and therefore belong in a release build -- well, except for the
> nedmalloc "assert" calls which do not.

Yes, I think that is a good way of thinking about it (modulo that I
really can't say one way or the other about nedmalloc's uses).

There _are_ some DEBUG-type things in Git that are protected by #ifdefs
that default to "off" (grep for DIFF_DEBUG, for instance). I'm actually
of the opinion that debugging code like that should be in all builds and
triggerable at run-time, provided it carries no significant performance
penalty when the run-time switch is not enabled. But I do agree that's a
totally separate question than from your DEBUG/DIAGNOSTIC distinction.

-Peff
