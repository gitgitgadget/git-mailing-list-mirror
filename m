Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D66FD1F954
	for <e@80x24.org>; Thu, 23 Aug 2018 16:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbeHWTpP (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 15:45:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:53424 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726118AbeHWTpP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 15:45:15 -0400
Received: (qmail 14022 invoked by uid 109); 23 Aug 2018 16:14:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 23 Aug 2018 16:14:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12457 invoked by uid 111); 23 Aug 2018 16:14:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 23 Aug 2018 12:14:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Aug 2018 12:14:51 -0400
Date:   Thu, 23 Aug 2018 12:14:51 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Paul Smith <paul@mad-scientist.net>, git@vger.kernel.org,
        Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
Message-ID: <20180823161451.GB29579@sigill.intra.peff.net>
References: <20180821212923.GB24431@sigill.intra.peff.net>
 <20180822004815.GA535143@genre.crustytoothpaste.net>
 <20180822030344.GA14684@sigill.intra.peff.net>
 <814549a01074e89a4b26cb0cf13e4dddeb3a040a.camel@mad-scientist.net>
 <20180822152306.GC32630@sigill.intra.peff.net>
 <20180823012343.GB92374@aiede.svl.corp.google.com>
 <20180823021618.GA12052@sigill.intra.peff.net>
 <20180823034707.GD535143@genre.crustytoothpaste.net>
 <20180823050418.GB318@sigill.intra.peff.net>
 <f854aba0-6d28-7f2b-aad2-858983c4af36@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f854aba0-6d28-7f2b-aad2-858983c4af36@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 23, 2018 at 06:26:58AM -0400, Derrick Stolee wrote:

> Around the time that my proposed approaches were getting vetoed for
> alignment issues, I figured I was out of my depth here. I reached out to
> Daniel Lemire (of EWAH bitmap fame) on Twitter [1]. His blog is full of
> posts of word-based approaches to different problems, so I thought he might
> know something off the top of his head that would be applicable. His
> conclusion (after looking only a short time) was to take a 'hasheq' approach
> [2] like Peff suggested [3]. Since that requires auditing all callers of
> hashcmp to see if hasheq is appropriate, it is not a good solution for 2.19
> but (in my opinion) should be evaluated as part of the 2.20 cycle.

I think that audit isn't actually too bad (but definitely not something
we should do for v2.19). The cocci patch I showed earlier hits most of
them. It misses the negated ones (e.g., "if (oidcmp(...))"). I'm not
sure if there's a way to ask coccinelle only for oidcmp()
used in a boolean context.

Just skimming the grep output, it's basically every call except the ones
we use for binary search.

-Peff
