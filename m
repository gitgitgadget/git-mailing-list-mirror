Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC096C4708E
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 01:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbiLFBny (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 20:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbiLFBnw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 20:43:52 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0153212D33
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 17:43:51 -0800 (PST)
Received: (qmail 11319 invoked by uid 109); 6 Dec 2022 01:43:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 06 Dec 2022 01:43:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16078 invoked by uid 111); 6 Dec 2022 01:43:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 05 Dec 2022 20:43:52 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 5 Dec 2022 20:43:50 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-compat-util.h: introduce CALLOC(x)
Message-ID: <Y46eVnYrcOGAbUhi@coredump.intra.peff.net>
References: <6694c52b38674859eb0390c7f62da1209a8d8ec3.1670266373.git.me@ttaylorr.com>
 <a8e33b1e-1056-5f75-55b5-65c0bceef3ca@web.de>
 <Y45yaYV3xFB/xR2G@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y45yaYV3xFB/xR2G@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 05, 2022 at 05:36:25PM -0500, Taylor Blau wrote:

> On Mon, Dec 05, 2022 at 10:01:11PM +0100, René Scharfe wrote:
> > This rule would turn this code:
> >
> > 	struct foo *bar = xcalloc(1, sizeof(*bar));
> > 	int i;
> >
> > ... into:
> >
> > 	struct foo *bar;
> > 	CALLOC(bar);
> > 	int i;
> >
> > ... which violates the coding guideline to not mix declarations and
> > statements (-Wdeclaration-after-statement).
> 
> Yeah, I was wondering about this myself when I wrote this part of the
> Coccinelle patch.
> 
> Is there an intelligent way to tell it to put the first statement after
> all declarations? I couldn't find anything after a quick scan of the
> documentation nor our own patches.

It feels like generating the code as above is not the end of the world.
The most valuable thing that coccinelle is doing here is _finding_ the
location, and telling you "it's supposed to be like this". It is great
when the "this" post-image is perfect and doesn't need further tweaking.

But if the compiler then reminds you "hey, you need to go a bit further
manually", that doesn't seem so bad. In other words, I would be happy to
follow that work flow if I introduced a bare xcalloc(). My only worry is
that somebody less experienced with the project (or with C) would get
confused.

-Peff
