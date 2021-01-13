Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189F2C433E0
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 13:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE96D23432
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 13:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbhAMNSh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 08:18:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:54680 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbhAMNSg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 08:18:36 -0500
Received: (qmail 22432 invoked by uid 109); 13 Jan 2021 13:17:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 13 Jan 2021 13:17:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29774 invoked by uid 111); 13 Jan 2021 13:17:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 Jan 2021 08:17:55 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 13 Jan 2021 08:17:55 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        jrnieder@gmail.com
Subject: Re: [PATCH 01/20] pack-revindex: introduce a new API
Message-ID: <X/7zA3KjlNnS2HhJ@coredump.intra.peff.net>
References: <cover.1610129796.git.me@ttaylorr.com>
 <fa6b8309088fd04410ca7276c5cf14db0fb82fb2.1610129796.git.me@ttaylorr.com>
 <xmqqa6tdz2fo.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa6tdz2fo.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 13, 2021 at 12:06:03AM -0800, Junio C Hamano wrote:

> > +int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos)
> > +{
> > +	int ret;
> [...]
> > +	*pos = ret;
> 
> The untold assumption is that uint32_t can fit the maximum returned
> value from find_revindex_position() and "signed int" can also big
> enough.  I guess it is OK to be limited to up-to 2 billion objects
> on 32-bit systems.

Thanks for pointing this out. I recalled there being an "int" problem
somewhere in the revindex code, but I didn't notice it on my
read-through. This bug already exists (the problem is actually in the
find_revindex_position() interface), and is fixed when we inline that
into offset_to_pack_pos() in patch 18.

It might be worth mentioning the fix there.

-Peff
