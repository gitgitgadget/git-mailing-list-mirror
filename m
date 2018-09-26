Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D93741F453
	for <e@80x24.org>; Wed, 26 Sep 2018 18:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbeI0AxL (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 20:53:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:60452 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726127AbeI0AxL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 20:53:11 -0400
Received: (qmail 18367 invoked by uid 109); 26 Sep 2018 18:38:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 26 Sep 2018 18:38:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20953 invoked by uid 111); 26 Sep 2018 18:38:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 26 Sep 2018 14:38:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Sep 2018 14:38:53 -0400
Date:   Wed, 26 Sep 2018 14:38:53 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        sbeller@google.com
Subject: Re: [PATCH v2 2/3] transport.c: introduce core.alternateRefsCommand
Message-ID: <20180926183853.GB30680@sigill.intra.peff.net>
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1537555544.git.me@ttaylorr.com>
 <9797f525517142b3494cfbd17a10dfeb3bf586e2.1537555544.git.me@ttaylorr.com>
 <20180922180231.GD432229@genre.crustytoothpaste.net>
 <20180922195258.GA20983@sigill.intra.peff.net>
 <20180926010935.GK4364@syl>
 <20180926033337.GC32064@sigill.intra.peff.net>
 <20180926133956.GA25697@syl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180926133956.GA25697@syl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 26, 2018 at 06:39:56AM -0700, Taylor Blau wrote:

> > A perl tangent if you're interested:
> [...]
> 
> To be clear, we ought to leave this function as:
> 
>   extract_haves () {
>     depacketize | perl -lne '/^(\S+) \.have/ and print $1'
>   }

Yes, I agree. You cannot do the "$@" there because it relies on
depacketize, which only handles stdin.

> Or are you suggesting that we change it to:
> 
>   extract_haves () {
>     perl -lne '/^(\S+) \.have/ and print $1'
>   }

No, sorry. I just used the ".have" snippet as filler text, but I see
that muddied my meaning considerably. This really was just a tangent for
the future. What you've written above is the best thing for this case.

> And call it as:
> 
>   printf "0000" | git receive-pack fork >actual &&
>   depacketize <actual >actual.packets
>   extract_haves <actual.packets >actual.haves &&
> 
> Frankly, (and I think that this is what you're getting at in your reply
> above), I think that the former (e.g., calling 'depacketize()' in
> 'extract_haves()') is cleaner. This approach leaves us with "actual" and
> "actual.haves", and obviates the need for another intermediary,
> "actual.packets".

Yeah. I have no problem with the three-liner you wrote above, but I do
not see any particular reason for it.

-Peff
