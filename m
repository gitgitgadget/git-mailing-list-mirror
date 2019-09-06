Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E1421F461
	for <e@80x24.org>; Fri,  6 Sep 2019 07:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732267AbfIFHNW (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 03:13:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:41776 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726115AbfIFHNW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Sep 2019 03:13:22 -0400
Received: (qmail 15116 invoked by uid 109); 6 Sep 2019 07:13:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Sep 2019 07:13:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2245 invoked by uid 111); 6 Sep 2019 07:15:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 06 Sep 2019 03:15:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 6 Sep 2019 03:13:21 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Sperling <stsp@stsp.name>
Subject: Re: [PATCH 1/2] tag: factor out get_tagged_oid()
Message-ID: <20190906071320.GA14343@sigill.intra.peff.net>
References: <1385c954-d9ef-7ef6-6185-0dad885531ec@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1385c954-d9ef-7ef6-6185-0dad885531ec@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 05, 2019 at 09:55:55PM +0200, René Scharfe wrote:

> Add a function for accessing the ID of the object referenced by a tag
> safely, i.e. without causing a segfault when encountering a broken tag
> where ->tagged is NULL.

This approach seems to pretty reasonable. As somebody who's been
thinking about this, I'd be curious to hear your thoughts on:

  https://public-inbox.org/git/20190906065606.GC5122@sigill.intra.peff.net/

which _in theory_ means tag->tagged would never be NULL (we'd catch it
at the parsing stage and consider that an error). But we'd still
potentially want to protect ourselves as you do here for code paths
which don't necessarily check the parse result.

-Peff
