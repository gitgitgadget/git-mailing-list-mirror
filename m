Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F44F1F404
	for <e@80x24.org>; Sat, 25 Aug 2018 08:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbeHYME4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Aug 2018 08:04:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:55826 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726412AbeHYMEz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Aug 2018 08:04:55 -0400
Received: (qmail 6020 invoked by uid 109); 25 Aug 2018 08:26:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 25 Aug 2018 08:26:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2620 invoked by uid 111); 25 Aug 2018 08:26:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 25 Aug 2018 04:26:50 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 25 Aug 2018 04:26:42 -0400
Date:   Sat, 25 Aug 2018 04:26:42 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Paul Smith <paul@mad-scientist.net>, git@vger.kernel.org,
        Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
Message-ID: <20180825082641.GC1672@sigill.intra.peff.net>
References: <814549a01074e89a4b26cb0cf13e4dddeb3a040a.camel@mad-scientist.net>
 <20180822152306.GC32630@sigill.intra.peff.net>
 <20180823012343.GB92374@aiede.svl.corp.google.com>
 <20180823021618.GA12052@sigill.intra.peff.net>
 <20180823034707.GD535143@genre.crustytoothpaste.net>
 <20180823050418.GB318@sigill.intra.peff.net>
 <f854aba0-6d28-7f2b-aad2-858983c4af36@gmail.com>
 <20180823185317.GA12534@sigill.intra.peff.net>
 <4b0168ee-4826-1f14-fc83-04c4cec18687@gmail.com>
 <719d5e65-553c-47a1-0b79-41c9af356f3a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <719d5e65-553c-47a1-0b79-41c9af356f3a@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 24, 2018 at 12:45:10PM -0400, Derrick Stolee wrote:

> Here are the numbers for Linux:
> 
> |      | v2.18.0  | v2.19.0-rc0 | HEAD   |
> |------|----------|-------------|--------|
> |      | 86.5     | 70.739      | 57.266 |
> |      | 60.582   | 101.928     | 56.641 |
> |      | 58.964   | 60.139      | 60.258 |
> |      | 59.47    | 61.141      | 58.213 |
> |      | 62.554   | 60.73       | 84.54  |
> |      | 59.139   | 85.424      | 57.745 |
> |      | 58.487   | 59.31       | 59.979 |
> |      | 58.653   | 69.845      | 60.181 |
> |      | 58.085   | 102.777     | 61.455 |
> |      | 58.304   | 60.459      | 62.551 |
> | Max  | 86.5     | 102.777     | 84.54  |
> | Min  | 58.085   | 59.31       | 56.641 |
> | Avg* | 59.51913 | 71.30063    | 59.706 |
> | Med  | 59.0515  | 65.493      | 60.08  |

Thanks. The median ones are the most interesting, I think (and show a
very satisfying recovery from my patch).

I'm surprised at the variance, especially in your v2.19 runs. It makes
me distrust the mean (and implies to me we could do better by throwing
away outliers based on value, not just the single high/low; or just
using the median also solves that).

The variance in the v2.18 column is what I'd expect based on past
experience (slow cold cache to start, then a few percent change
run-to-run).

-Peff
