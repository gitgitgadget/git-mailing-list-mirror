Return-Path: <SRS0=LMRs=AT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4948CC433E0
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 04:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 253DD20774
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 04:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgGHEnt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 00:43:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:51988 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgGHEnt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 00:43:49 -0400
Received: (qmail 26581 invoked by uid 109); 8 Jul 2020 04:43:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Jul 2020 04:43:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1379 invoked by uid 111); 8 Jul 2020 04:43:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Jul 2020 00:43:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 8 Jul 2020 00:43:47 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 0/2] Add support for %(contents:size) in ref-filter
Message-ID: <20200708044347.GB2303891@coredump.intra.peff.net>
References: <20200702140845.24945-1-chriscool@tuxfamily.org>
 <20200707050247.GA105016@coredump.intra.peff.net>
 <CAP8UFD0gUK4TGUA7JZ_V7hFe4LSDAP7DfPyz4gqy1RjLXJPF2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD0gUK4TGUA7JZ_V7hFe4LSDAP7DfPyz4gqy1RjLXJPF2w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 07, 2020 at 08:19:06AM +0200, Christian Couder wrote:

> > I'm still not sure why %(objectsize) isn't sufficient here. Is there
> > some use case that's served by %(contents:size) that it wouldn't work
> > for? Or are we just trying to make it more discoverable when you're
> > looking at the contents already?
> 
> %(objectsize) is the size of the whole commit or tag object, while
> %(contents:size) is the size of the complete message (the whole commit
> message or tag message, including trailers and signatures).

Ah, right, that makes sense.

I'd probably use "git log --no-walk --format=%B" or similar for this,
but there is nothing wrong with using for-each-ref (and it is better if
you really do care about properties of the refs themselves, and not just
the commit they point to).

I do think in the long run it might be nice to have a generic
placeholder for "expand this thing and give me the number of bytes", so
we could do:

  %(sizeof:%(contents))

or even:

  %(sizeof:%(authorname) <%(authoremail)>)

but that is definitely outside the scope. If we end up eventually with
a generic mechanism and have to support contents:size forever for
compatibility, I don't think it is that big a problem.

-Peff
