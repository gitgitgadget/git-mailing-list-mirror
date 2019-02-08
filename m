Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4F711F453
	for <e@80x24.org>; Fri,  8 Feb 2019 19:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfBHTLF (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 14:11:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:37916 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726852AbfBHTLF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 14:11:05 -0500
Received: (qmail 13962 invoked by uid 109); 8 Feb 2019 19:11:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Feb 2019 19:11:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26569 invoked by uid 111); 8 Feb 2019 19:11:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 08 Feb 2019 14:11:14 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Feb 2019 14:11:03 -0500
Date:   Fri, 8 Feb 2019 14:11:03 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib: make '--stress' more bisect-friendly
Message-ID: <20190208191103.GD27673@sigill.intra.peff.net>
References: <20190208115045.13256-1-szeder.dev@gmail.com>
 <20190208164732.GA23461@sigill.intra.peff.net>
 <20190208182319.GY10587@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190208182319.GY10587@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 08, 2019 at 07:23:19PM +0100, SZEDER Gábor wrote:

> > Picking an <N> is tough. Too low and you get a false negative, too high
> > and you can wait forever, especially if the script is long. But I don't
> > think there's any real way to auto-scale it, except by seeing a few of
> > the failing cases and watching how long they take.
> 
> So far I've chosen <N> like this: run the test script with --stress
> 3-5 times to trigger the failure, take the highest repetition count
> that was necessary for the failure, multiply it by 4-6 to get a round
> number, and that's a good ballpark for <N>.  And once bisect came up
> with the suspect commit, I double checked it by letting the test
> script run with --stress on its parent commit for at least 5-10x <N>
> repetitions.

Heh. That's exactly my process, too. :)

> Anyway, I doubt that auto-scaling <N> is worth the effort.

Yeah, especially because as a concept it exists outside of the script
itself (i.e., you have to checkout a failing version and then run the
script a bunch of times; that's not something that test-lib.sh should
even know about).

So let's go with this for now. It's already a much nicer tool than we
had yesterday, so we can take some time to get used to it.

-Peff
