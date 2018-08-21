Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 498F41F954
	for <e@80x24.org>; Tue, 21 Aug 2018 19:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbeHUXPh (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 19:15:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:50890 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726730AbeHUXPh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 19:15:37 -0400
Received: (qmail 8776 invoked by uid 109); 21 Aug 2018 19:54:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 21 Aug 2018 19:54:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26555 invoked by uid 111); 21 Aug 2018 19:54:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 21 Aug 2018 15:54:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Aug 2018 15:54:04 -0400
Date:   Tue, 21 Aug 2018 15:54:04 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/6] pack-bitmap: save "have" bitmap from walk
Message-ID: <20180821195403.GC859@sigill.intra.peff.net>
References: <20180821184140.GA24165@sigill.intra.peff.net>
 <20180821190701.GE30764@sigill.intra.peff.net>
 <7dadd117-e7f4-4d15-b907-043718022494@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7dadd117-e7f4-4d15-b907-043718022494@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 21, 2018 at 03:47:36PM -0400, Derrick Stolee wrote:

> On 8/21/2018 3:07 PM, Jeff King wrote:
> > When we do a bitmap walk, we save the result, which
> > represents (WANTs & ~HAVEs); i.e., every object we care
> > about visiting in our walk. However, we throw away the
> > haves bitmap, which can sometimes be useful, too. Save it
> > and provide an access function so code which has performed a
> > walk can query it.
> 
> This makes a lot of sense. Based on the amount of time the "Counting
> Objects" blog post [1] spent talking about delta bases, I would have assumed
> this "haves" bitmap was already part of it. But, I can also see how it could
> be dropped if you are focusing on performance for 'git clone'.

I think that blog post was written after we were already using this
patch. ;)

> > A few notes on the accessor interface:
> > 
> >   - the bitmap code calls these "haves" because it grew out
> >     of the want/have negotiation for fetches. But really,
> >     these are simply the objects that would be flagged
> >     UNINTERESTING in a regular traversal. Let's use that
> >     more universal nomenclature for the external module
> >     interface. We may want to change the internal naming
> >     inside the bitmap code, but that's outside the scope of
> >     this patch.
> 
> I saw the uninteresting-vs-haves name confusion in the patch below, but I
> agree with your logic here.
> 
> Sorry that I'm late to the party, but I was interested in the topic.

This has already missed the freeze for v2.19, so I think there is plenty
of time. More review would be welcome.

-Peff
