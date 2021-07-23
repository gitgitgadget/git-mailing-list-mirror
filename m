Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69271C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 09:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BA1F60E8E
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 09:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhGWI77 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 04:59:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:55602 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230397AbhGWI75 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 04:59:57 -0400
Received: (qmail 10991 invoked by uid 109); 23 Jul 2021 09:40:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Jul 2021 09:40:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23789 invoked by uid 111); 23 Jul 2021 09:40:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Jul 2021 05:40:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Jul 2021 05:40:28 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 13/24] pack-bitmap: read multi-pack bitmaps
Message-ID: <YPqOjAkG7EZ6KXd6@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <7d44ba6299c06c956d5ac8ba01a0288d109c3cae.1624314293.git.me@ttaylorr.com>
 <YPgF4X2PeFvBuJXm@coredump.intra.peff.net>
 <YPinPFW50Mj8cVkP@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPinPFW50Mj8cVkP@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 21, 2021 at 07:01:16PM -0400, Taylor Blau wrote:

> On Wed, Jul 21, 2021 at 07:32:49AM -0400, Jeff King wrote:
> > On Mon, Jun 21, 2021 at 06:25:31PM -0400, Taylor Blau wrote:
> > > +	if (!is_pack_valid(packfile)) {
> > > +		close(fd);
> > > +		return -1;
> > > +	}
> > > +
> >
> > What's this extra is_pack_valid() doing? I wouldn't expect many changes
> > at all to this non-midx code path (aside from the "did we already load a
> > midx bitmap" in the earlier part of the hunk, which makes sense).
> 
> That looks like a mistake to me. I did a little digging and tried to
> remember if it could have ever been useful, but I think that it's just a
> stray change that has no value. Removed.

This turned out to be quite interesting. It _is_ a mistake to include it
in this series. But it turns out to be quite valuable on its own. :)

I just cleaned it up and sent it as its own separate patch:

  https://lore.kernel.org/git/YPqL%2FpZt6hNYN4hB@coredump.intra.peff.net/

So it's a happy accident that your series called attention to it. :)

-Peff
