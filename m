Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA76C433DB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 09:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E404222DFB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 09:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392655AbhALJ2o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 04:28:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:53140 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391143AbhALJ2o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 04:28:44 -0500
Received: (qmail 7115 invoked by uid 109); 12 Jan 2021 09:28:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Jan 2021 09:28:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11250 invoked by uid 111); 12 Jan 2021 09:28:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Jan 2021 04:28:05 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Jan 2021 04:28:03 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        jrnieder@gmail.com
Subject: Re: [PATCH 16/20] builtin/gc.c: guess the size of the revindex
Message-ID: <X/1roycRbYPjnI3l@coredump.intra.peff.net>
References: <cover.1610129796.git.me@ttaylorr.com>
 <7c17db7a7df8b524f13969efd1cb5e6e95de5a2d.1610129796.git.me@ttaylorr.com>
 <87cd1b2c-7a28-da77-4ae4-99ffbbdfda72@gmail.com>
 <X/x7mrcwfxGO8xH7@nand.local>
 <13c28eca-81d5-10c9-c92c-162547416014@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <13c28eca-81d5-10c9-c92c-162547416014@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 11, 2021 at 12:09:27PM -0500, Derrick Stolee wrote:

> > The reason I didn't pursue it here was that we haven't yet loaded the
> > reverse index by this point. So, you'd want a function that at least
> > stats the '*.rev' file (and either does or doesn't parse it [1]), or
> > aborts early to indicate otherwise.
> 
> In this patch, I would expect it to use sizeof(struct revindex_entry).
> Later, the method would know if a .rev file exists and do the right
> thing instead. (Also, should mmap'd data count towards this estimate?)

Yeah, I think if we care about memory pressure, then the mmap would
count anyway. I agree that letting the revindex code decide which to use
would be the most accurate thing, but given that this whole chunk of
code is an estimate (that does not even seem to take into account the
memory used for the delta search!), I don't think it's worth trying to
get to accurate.

-Peff
