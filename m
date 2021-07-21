Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B352EC636CA
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 11:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91EEB61019
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 11:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238323AbhGUKon (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 06:44:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:53022 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237528AbhGUJii (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 05:38:38 -0400
Received: (qmail 1997 invoked by uid 109); 21 Jul 2021 10:18:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 21 Jul 2021 10:18:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2920 invoked by uid 111); 21 Jul 2021 10:18:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Jul 2021 06:18:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 21 Jul 2021 06:18:46 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 05/24] Documentation: describe MIDX-based bitmaps
Message-ID: <YPf0hivipY6o5Y3B@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <64a260e0c6a116b7c6fa6fea2b9fd96bf416cb18.1624314293.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <64a260e0c6a116b7c6fa6fea2b9fd96bf416cb18.1624314293.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 21, 2021 at 06:25:10PM -0400, Taylor Blau wrote:

> +An object is uniquely described by its bit position within a bitmap:
> +
> +	- If the bitmap belongs to a packfile, the __n__th bit corresponds to
> +	the __n__th object in pack order. For a function `offset` which maps
> +	objects to their byte offset within a pack, pack order is defined as
> +	follows:
> +
> +		o1 <= o2 <==> offset(o1) <= offset(o2)
> +
> +	- If the bitmap belongs to a MIDX, the __n__th bit corresponds to the
> +	__n__th object in MIDX order. With an additional function `pack` which
> +	maps objects to the pack they were selected from by the MIDX, MIDX order
> +	is defined as follows:
> +
> +		o1 <= o2 <==> pack(o1) <= pack(o2) /\ offset(o1) <= offset(o2)
> +
> +	The ordering between packs is done lexicographically by the pack name,
> +	with the exception of the preferred pack, which sorts ahead of all other
> +	packs.

This doesn't render well as asciidoc (the final paragraph is taken as
more of the code block). But that is a problem through the whole file. I
think we should ignore it for now, and worry about asciidoc-ifying the
whole thing later, if we choose to.

> +	The ordering between packs is done lexicographically by the pack name,
> +	with the exception of the preferred pack, which sorts ahead of all other
> +	packs.

Hmm, I'm not sure if this "lexicographically" part is true. Really we're
building on the midx .rev format here. And that says "defined by the
MIDX's pack list" (though I can't offhand remember if that is
lexicographic, or if it is in the reverse-mtime order).

At any rate, should we just be referencing the rev documentation?

> [...]

The rest of the changes to the document seemed quite sensible to me.

-Peff
