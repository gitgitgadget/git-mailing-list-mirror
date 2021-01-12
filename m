Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC7CC433E0
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 08:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54ED2208E4
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 08:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405640AbhALI6l (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 03:58:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:53088 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727916AbhALI6l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 03:58:41 -0500
Received: (qmail 6339 invoked by uid 109); 12 Jan 2021 08:58:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Jan 2021 08:58:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10955 invoked by uid 111); 12 Jan 2021 08:58:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Jan 2021 03:58:02 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Jan 2021 03:57:59 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH 07/20] show_objects_for_type(): convert to new revindex
 API
Message-ID: <X/1klwe44go+A+Xi@coredump.intra.peff.net>
References: <cover.1610129796.git.me@ttaylorr.com>
 <bc67bb462ae0c87b34e46568d54b170a8aec870b.1610129796.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bc67bb462ae0c87b34e46568d54b170a8aec870b.1610129796.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 08, 2021 at 01:17:09PM -0500, Taylor Blau wrote:

> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index d6861ddd4d..80c57bde73 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -711,21 +711,22 @@ static void show_objects_for_type(
>  
>  		for (offset = 0; offset < BITS_IN_EWORD; ++offset) {
>  			struct object_id oid;
> -			struct revindex_entry *entry;
> -			uint32_t hash = 0;
> +			uint32_t hash = 0, n;
> +			off_t ofs;

A minor nit, but "n" isn't very descriptive. It's not in scope for very
long, so that's not too bad, but there are two positions at work in this
function: the pos/offset bit position, and the index position. Maybe
"index_pos" would be better than "n" to keep the two clear?

-Peff
