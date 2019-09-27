Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 987271F463
	for <e@80x24.org>; Fri, 27 Sep 2019 02:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbfI0CuC (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 22:50:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:33596 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728270AbfI0CuC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 22:50:02 -0400
Received: (qmail 23833 invoked by uid 109); 27 Sep 2019 02:50:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 27 Sep 2019 02:50:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5950 invoked by uid 111); 27 Sep 2019 02:52:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Sep 2019 22:52:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Sep 2019 22:50:01 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, davvid@gmail.com
Subject: Re: [PATCH 3/3] wrapper: use a loop instead of repetitive statements
Message-ID: <20190927025000.GD23736@sigill.intra.peff.net>
References: <20190925020158.751492-1-alexhenrie24@gmail.com>
 <20190925020158.751492-4-alexhenrie24@gmail.com>
 <03e509db-942e-4538-4729-4e345df82a7e@gmail.com>
 <nycvar.QRO.7.76.6.1909262155020.15067@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1909262155020.15067@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 26, 2019 at 10:14:17PM +0200, Johannes Schindelin wrote:

> I mean, if there is _any_ performance-critical code path hitting this
> unrolled loop, we may want to keep it unrolled.

The loop in question is maybe a few dozen instructions, and then it
immediately makes an open() syscall, which is probably multiple orders
of magnitude more expensive. So I'd be very surprised if it was a
problem no matter what the generated code looks like.

But...

> However, I think that this patch should at least be accompanied by a
> commit message that suggests that some thought was put into it, and that
> concerns like mine were considered carefully.

...this I would definitely agree with.

-Peff
