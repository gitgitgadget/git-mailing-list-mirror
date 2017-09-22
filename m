Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36B7D202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 15:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752276AbdIVPzU (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 11:55:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:46932 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752078AbdIVPzT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 11:55:19 -0400
Received: (qmail 24933 invoked by uid 109); 22 Sep 2017 15:55:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Sep 2017 15:55:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4147 invoked by uid 111); 22 Sep 2017 15:55:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Sep 2017 11:55:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Sep 2017 11:55:17 -0400
Date:   Fri, 22 Sep 2017 11:55:17 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH 2/4] commit-slab.h: avoid -Wsign-compare warnings
Message-ID: <20170922155516.wcvpp37usb34ed3i@sigill.intra.peff.net>
References: <f120046a-f0b3-6199-a2fc-65a5fd37c0a3@ramsayjones.plus.com>
 <20170922052916.fiafkbykroenq65n@sigill.intra.peff.net>
 <5c82e442-9d3a-d748-248d-3ea55a91f777@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5c82e442-9d3a-d748-248d-3ea55a91f777@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 22, 2017 at 04:46:48PM +0100, Ramsay Jones wrote:

> >> -	int nth_slab, nth_slot;						\
> >> +	unsigned int nth_slab, nth_slot;				\
> > 
> > I have a feeling that in the long run these should all be size_t, but
> > it's probably pretty unlikely to overflow in practice. At any rate, the
> > slab index itself is an unsigned, so it probably makes sense to match
> > that for now.
> 
> Yes, I briefly considered that, but I didn't want to think about
> possible effects of the increased size of 'struct slabname'. I suspect
> that it is very unlikely to cause an issue, but I had similar concerns
> with the 'ALLOC_GROW' patch, were it would have been more likely to
> cause memory pressure issues (to e.g. s/int/size_t/). I decided that it
> could be addressed separately, with a patch on top, if necessary.

I _think_ we'd be OK in all of those cases because these size_t's tend
to be once-per-big-list, not once-per-list-item. But I agree that it
would need looking into closely, and definitely should be addressed
separately.

Thanks.

-Peff
