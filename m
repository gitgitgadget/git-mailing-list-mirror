Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78916C4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 20:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B5F960FC0
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 20:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236526AbhHLUBE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 16:01:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:45764 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230171AbhHLUBC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 16:01:02 -0400
Received: (qmail 24655 invoked by uid 109); 12 Aug 2021 20:00:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Aug 2021 20:00:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25178 invoked by uid 111); 12 Aug 2021 20:00:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Aug 2021 16:00:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 12 Aug 2021 16:00:36 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 14/24] pack-bitmap: write multi-pack bitmaps
Message-ID: <YRV95Bx3z6U06Qqd@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <a8cec2463d0993b1118abdd31cb6c9e88a32e0c4.1624314293.git.me@ttaylorr.com>
 <YPgObwXjt/tzAJvV@coredump.intra.peff.net>
 <YP77DiffrCrxunvg@nand.local>
 <YQA+PaWb7tweEKuk@coredump.intra.peff.net>
 <YQBtfRP0svLL6VDl@nand.local>
 <YQGZZTXjSuZkHJgm@coredump.intra.peff.net>
 <YQMCfnlr6BAXC/c0@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YQMCfnlr6BAXC/c0@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 29, 2021 at 03:33:18PM -0400, Taylor Blau wrote:

> > > It's only necessary now (at least for determining a preferred pack if
> > > the caller didn't specify one with `--preferred-pack`) because we care
> > > about reading the `num_objects` field, which the index must be loaded
> > > for.
> >
> > I guess I'm a little confused about "now" in your sentence. I understand
> > that it's not necessary before your series to have loaded all of the
> > index files ahead of time. But didn't we need to do so in v2 of your
> > series, which has the preferred-pack logic?
> >
> > If so, then was the v2 version buggy, since it only called
> > prepare_midx_pack() and not open_pack_index()? And then v3 is fixing
> > that? Or is something else opening the pack index for us?
> 
> In earlier versions of this series, I don't think we needed to have the
> indexes loaded by this point, since (before v3) we didn't care about
> ignoring the empty packs when finding a default preferred-pack.
> 
> But now we do, and so we need to call open_pack_index() ourselves.
> Confusingly, we only need to do that on packs that *are* included in the
> MIDX, since prepare_midx_pack() doesn't do it for us, but
> add_pack_to_midx() does.

Ah, that was the part I was missing: the default preferred-pack stuff is
only in v3. That makes sense.

-Peff
