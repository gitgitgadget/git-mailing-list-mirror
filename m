Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35F2E202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 05:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751795AbdIVF3T (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 01:29:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:46654 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751637AbdIVF3T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 01:29:19 -0400
Received: (qmail 31353 invoked by uid 109); 22 Sep 2017 05:29:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Sep 2017 05:29:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1399 invoked by uid 111); 22 Sep 2017 05:29:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Sep 2017 01:29:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Sep 2017 01:29:16 -0400
Date:   Fri, 22 Sep 2017 01:29:16 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH 2/4] commit-slab.h: avoid -Wsign-compare warnings
Message-ID: <20170922052916.fiafkbykroenq65n@sigill.intra.peff.net>
References: <f120046a-f0b3-6199-a2fc-65a5fd37c0a3@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f120046a-f0b3-6199-a2fc-65a5fd37c0a3@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 21, 2017 at 05:47:36PM +0100, Ramsay Jones wrote:

> diff --git a/commit-slab.h b/commit-slab.h
> index 333d81e37..dcaab8ca0 100644
> --- a/commit-slab.h
> +++ b/commit-slab.h
> @@ -78,7 +78,7 @@ static MAYBE_UNUSED void init_ ##slabname(struct slabname *s)		\
>  									\
>  static MAYBE_UNUSED void clear_ ##slabname(struct slabname *s)		\
>  {									\
> -	int i;								\
> +	unsigned int i;							\
>  	for (i = 0; i < s->slab_count; i++)				\
>  		free(s->slab[i]);					\
>  	s->slab_count = 0;						\
> @@ -89,13 +89,13 @@ static MAYBE_UNUSED elemtype *slabname## _at_peek(struct slabname *s,	\
>  						  const struct commit *c, \
>  						  int add_if_missing)   \
>  {									\
> -	int nth_slab, nth_slot;						\
> +	unsigned int nth_slab, nth_slot;				\

I have a feeling that in the long run these should all be size_t, but
it's probably pretty unlikely to overflow in practice. At any rate, the
slab index itself is an unsigned, so it probably makes sense to match
that for now.

-Peff
