Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8D08211B5
	for <e@80x24.org>; Tue, 22 Jan 2019 07:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfAVH2L (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 02:28:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:43610 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726423AbfAVH2L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 02:28:11 -0500
Received: (qmail 6567 invoked by uid 109); 22 Jan 2019 07:28:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 22 Jan 2019 07:28:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3580 invoked by uid 111); 22 Jan 2019 07:28:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 22 Jan 2019 02:28:14 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Jan 2019 02:28:09 -0500
Date:   Tue, 22 Jan 2019 02:28:09 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Patrick Hogg <phogg@novamoon.net>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2] pack-objects: Use packing_data lock instead of
 read_mutex
Message-ID: <20190122072809.GA28975@sigill.intra.peff.net>
References: <20190119154337.6556-1-phogg@novamoon.net>
 <CACsJy8AWCP+enBVVVga7jJZ-gxD=fxcushrk0D+xGSRAcZw_qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8AWCP+enBVVVga7jJZ-gxD=fxcushrk0D+xGSRAcZw_qg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 21, 2019 at 05:02:33PM +0700, Duy Nguyen wrote:

> > As I mentioned in the prior thread I think that it will be simpler
> > to simply use the existing lock in packing_data instead of moving
> > read_mutex. I can go back to simply moving read_mutex to the
> > packing_data struct if that that is preferable, though.
> 
> In early iterations of these changes, I think we hit high contention
> when sharing the mutex [1]. I don't know if we will hit the same
> performance problem again with this patch. It would be great if Elijah
> with his zillion core machine could test this out. Otherwise it may be
> just safer to keep the two mutexes separate.
> 
> [1] http://public-inbox.org/git/20180720052829.GA3852@sigill.intra.peff.net/

I haven't been following this thread closely, but I still have access to
a 40-core machine if you'd like me to time anything.

It sounds like _this_ patch is the more fine-grained one. Is the more
coarse-grained one already written?

-Peff
