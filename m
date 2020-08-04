Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CFBC433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 00:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E71F42076C
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 00:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgHDAhX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 20:37:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:47142 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbgHDAhX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 20:37:23 -0400
Received: (qmail 30774 invoked by uid 109); 4 Aug 2020 00:37:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Aug 2020 00:37:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6772 invoked by uid 111); 4 Aug 2020 00:37:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Aug 2020 20:37:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Aug 2020 20:37:22 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, chriscool@tuxfamily.org, gitster@pobox.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v4 0/3] upload-pack: custom allowed object filters
Message-ID: <20200804003722.GA2726931@coredump.intra.peff.net>
References: <cover.1595468657.git.me@ttaylorr.com>
 <cover.1596476928.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1596476928.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 03, 2020 at 02:00:04PM -0400, Taylor Blau wrote:

> Here's what I anticipate to be the final reroll of my series to teach
> the new 'uploadpackfilter' configuration section, which allows for more
> fine-grained control over which object filters upload-pack is willing to
> serve.

Thanks, this version looks good to me.

> Two changes from last time:
> 
>   - I adopted Peff's suggestion in beginning in [1], but appropriately
>     split it over the existing patch structure.

The adaptation looks good. The send_err_and_die() helper could possibly
be used for some of the packet_writer_error() callers, too.  Somebody
could convert them on top if they want, but I'm not sure it's even worth
it. IMHO the correct long-term direction is to convert those die() calls
into silent exits and let the ERR packet speak for itself. But we
shouldn't do that until the client side is more robust against
pipe-death races.

>   - I dropped the old patch 3/4, since it really should have never been
>     there in the first place, and just made the refactoring more noisy
>     than necessary.

Yeah, I think folding it in to the first patch as you did makes the
series simpler to follow.

-Peff
