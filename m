Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 990651F461
	for <e@80x24.org>; Thu, 20 Jun 2019 18:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfFTSaA (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 14:30:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:46286 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726579AbfFTSaA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 14:30:00 -0400
Received: (qmail 25161 invoked by uid 109); 20 Jun 2019 18:30:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Jun 2019 18:30:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17468 invoked by uid 111); 20 Jun 2019 18:30:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 20 Jun 2019 14:30:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jun 2019 14:29:58 -0400
Date:   Thu, 20 Jun 2019 14:29:58 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 12/17] delta-islands: convert island_marks khash to use
 oids
Message-ID: <20190620182957.GD18704@sigill.intra.peff.net>
References: <20190620074131.GL3713@sigill.intra.peff.net>
 <20190620173823.23374-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190620173823.23374-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 20, 2019 at 10:38:23AM -0700, Jonathan Tan wrote:

> > @@ -154,7 +154,7 @@ static struct island_bitmap *create_or_get_island_marks(struct object *obj)
> >  	khiter_t pos;
> >  	int hash_ret;
> >  
> > -	pos = kh_put_sha1(island_marks, obj->oid.hash, &hash_ret);
> > +	pos = kh_put_oid_map(island_marks, obj->oid, &hash_ret);
> 
> Thanks for doing this cleanup. The entire series (17 patches) look good
> to me. The only remotely surprising thing to me was that OIDs are passed
> by value on the stack, both for kh_get_oid_map() and kh_put_oid_map(),
> but I see that this is how things currently work (and anyway, changing
> this is beyond the scope of this patch set).

Thanks for reviewing. Yeah, the pass-by-value surprised me too, as it's
been a while since I've had to touch khash. I think it all cancels out
performance-wise because of the inlining, but it might be a fun thing to
experiment with.

-Peff
