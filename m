Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43FC81F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 16:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438123AbeKWC50 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 21:57:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:48652 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730352AbeKWC50 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 21:57:26 -0500
Received: (qmail 23376 invoked by uid 109); 22 Nov 2018 16:17:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Nov 2018 16:17:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23337 invoked by uid 111); 22 Nov 2018 16:16:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 22 Nov 2018 11:16:47 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Nov 2018 11:17:22 -0500
Date:   Thu, 22 Nov 2018 11:17:22 -0500
From:   Jeff King <peff@peff.net>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     max@max630.net, git@vger.kernel.org
Subject: Re: [PATCH] t5562: skip if NO_CURL is enabled
Message-ID: <20181122161722.GC28192@sigill.intra.peff.net>
References: <20181119101535.16538-1-carenas@gmail.com>
 <20181119184018.GA5348@jessie.local>
 <CAPUEsphLMBpxtJakAhQmdKf04H9X4m-8sBSHNFE_eAngn-44Ow@mail.gmail.com>
 <20181120091107.GA30542@sigill.intra.peff.net>
 <CAPUEsphaYBXp4V2FYqoB8-A2dyqppH=hSAaoQXGk4NMwXznCiA@mail.gmail.com>
 <20181121224929.GD5348@jessie.local>
 <CAPUEspjeiT=Odc7ENd0Qjeg=8w-+Qh9uGjL+BQXihiK1G1vkjA@mail.gmail.com>
 <20181122063714.GE5348@jessie.local>
 <CAPUEsph7z3nHjJ=idq5v0RPPjWwmGGMsbmPoyUChxUitBPeEBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPUEsph7z3nHjJ=idq5v0RPPjWwmGGMsbmPoyUChxUitBPeEBQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 22, 2018 at 02:17:01AM -0800, Carlo Arenas wrote:

> Peff, could you elaborate on your "load testing" setup? which could
> give us any hints
> on what to look for?, FWIW I hadn't been able to reproduce the problem anywhere
> else (and not for a lack of trying)

The script I use is at:

  https://github.com/peff/git/blob/meta/stress

which you invoke like "/path/to/stress t5562" from the top-level of a
git.git checkout.  It basically just runs a loop of twice as many
simultaneous invocations of the test script as you have CPUs, and waits
for one to fail. The load created by all of the runs tends to flush out
timing effects after a while.

It fails for me on t5562 within 30 seconds or so (but note that in this
particular case it sometimes takes a while to produce the final output
because invoke-with-content-length misses the expected SIGCLD and sleeps
the full 60 seconds).

You'll probably need to tweak the variables at the top of the script for
your system.

> PS. upstreaming the PERL_PATH fix is likely to be good to do soonish
> as I presume at least all BSD might be affected, let me know if you
> would rather me do that instead as I suspect we might be deadlocked
> otherwise ;)

Yeah, the $PERL_PATH thing is totally orthogonal, and should graduate
separately.

-Peff
