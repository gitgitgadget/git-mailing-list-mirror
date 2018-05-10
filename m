Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28D011F406
	for <e@80x24.org>; Thu, 10 May 2018 16:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966601AbeEJQPi (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 12:15:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:35098 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S964881AbeEJQPf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 12:15:35 -0400
Received: (qmail 9616 invoked by uid 109); 10 May 2018 16:15:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 May 2018 16:15:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26138 invoked by uid 111); 10 May 2018 16:15:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 10 May 2018 12:15:39 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 May 2018 12:15:33 -0400
Date:   Thu, 10 May 2018 12:15:33 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4 6/6] get_short_oid: document & warn if we ignore the
 type selector
Message-ID: <20180510161532.GB10199@sigill.intra.peff.net>
References: <20180501184016.15061-10-avarab@gmail.com>
 <20180510124303.6020-7-avarab@gmail.com>
 <20180510160322.GC6462@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180510160322.GC6462@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 10, 2018 at 12:03:22PM -0400, Jeff King wrote:

> And finally, your 06fa example for me shows behavior that's either
> buggy, or I'm just confused. I get:
> 
>   $ git rev-parse 06fa^{blob}
>   error: short SHA1 06fa is ambiguous
>   hint: The candidates are:
>   hint:   06fa2b7c2b tag v2.1.4
>   hint:   06faa52353 commit 2005-10-18 - 2005-10-18 midnight
>   hint:   06fac427af blob
>   hint:   06faf6ba64 tree
> 
> (That 06fac blob comes Junio's refs/notes/amlog). Shouldn't the blob
> disambiguator show me just that object?

Ah, I see. No, "^{blob}" does not actually pass the blob disambiguator.
We only handle committish and treeish right now, and this iteration of
the series omits the function to fix that.

So I think the principle of this commit is sound without that patch, but
your example is not a good one anymore. :)

-Peff
