Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13372C433B4
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 22:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4E0F61279
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 22:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbhDGWWz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 18:22:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:43880 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229488AbhDGWWy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 18:22:54 -0400
Received: (qmail 18451 invoked by uid 109); 7 Apr 2021 22:22:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 07 Apr 2021 22:22:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25006 invoked by uid 111); 7 Apr 2021 22:22:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 07 Apr 2021 18:22:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 7 Apr 2021 18:22:43 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org
Subject: Re: There should have be git gc --repack-arguments
Message-ID: <YG4ws7PiKKKjPUff@coredump.intra.peff.net>
References: <b35a68a1-e693-5502-7a28-a1dd8222d3a0@gmail.com>
 <YG4J7vtTRVpGGLoo@coredump.intra.peff.net>
 <xmqq8s5tzv4f.fsf@gitster.g>
 <YG4mImcQyTC1/S8X@coredump.intra.peff.net>
 <xmqqa6q9yc8c.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa6q9yc8c.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 07, 2021 at 03:13:39PM -0700, Junio C Hamano wrote:

> >> > You can also set pack.packSizeLimit for the latter, though I do not
> >> > recommend it. It will not help with memory usage (neither while
> >> > repacking nor for later commands).
> >> 
> >> In other words, passing --max-pack-size, whether it is done with a
> >> new --repack-arguments option or it is done with the existing
> >> pack.packSizeLimit configuration, would make things worse.
> >
> > Right. I wish we didn't have --max-pack-size at all. I do not think it
> > is ever a good idea, and it complicates the packing code quite a bit.
> 
> I suspect that the original motivation was sneaker-netting on
> multiple floppy disks ;-)

That had always been my impression, too. But when I looked in the
archive while writing my earlier reply, most of the discussion near
--max-pack-size had to do with the early index limitations.

If you are sneaker-netting, you are probably better off to just split
the pack at byte boundaries with an external tool anyway, for two
reasons:

  - our max-pack-size is just a guideline. It only splits at object
    boundaries so if you have an object bigger than the max, we'll
    exceed it.

  - dedicated splitting tools often have useful extra features, like
    k-of-n error correction.

Besides, if you are sneaker netting you'd want to use a bundle, and I
don't think bundles support max-pack-size. :)

Anyway, all off-topic but an interesting diversion.

-Peff
