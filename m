Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26A451F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 10:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbeKTVN7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 16:13:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:45530 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726569AbeKTVN7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 16:13:59 -0500
Received: (qmail 23939 invoked by uid 109); 20 Nov 2018 10:45:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 20 Nov 2018 10:45:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27537 invoked by uid 111); 20 Nov 2018 10:44:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 20 Nov 2018 05:44:52 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Nov 2018 05:45:28 -0500
Date:   Tue, 20 Nov 2018 05:45:28 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] tests: send "bug in the test script" errors to the
 script's stderr
Message-ID: <20181120104528.GA26263@sigill.intra.peff.net>
References: <20181119131326.2435-1-szeder.dev@gmail.com>
 <20181119194432.GA7330@sigill.intra.peff.net>
 <20181119233404.GW30222@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181119233404.GW30222@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 20, 2018 at 12:34:04AM +0100, SZEDER Gábor wrote:

> > I do notice that many of the existing "FATAL:" errors use descriptor 5,
> > which goes to stdout. I'm not sure if those should actually be going to
> > stderr (or if there's some TAP significance to those lines).
> 
> I chose to send these messages to standard error, because they are,
> well, errors.  TAP only cares about stdout, but by aborting the test
> script in BUG(), error() or die() we are already violating TAP anyway,
> so I don't think it matters whether we send "bug in test script" or
> "FATAL" errors to stdout or stderr.

Yeah, I agree it probably doesn't matter. I was mostly suggesting to
make the existing ">&5" into ">&7" for consistency. But I don't think
that needs to block your patch.

> BTW, TAP understands "Bail out!" as bail out from the _entire_ test
> suite, but that's not what we want here, I'd think.
> 
> https://testanything.org/tap-specification.html#bail-out

Yes, I added the only existing "Bail out!" to test-lib.sh. :)

I agree that's not what we want here. I actually think the current
behavior (to exit non-zero) does what we want. A TAP harness will
realize that's an error, but not block other scripts.

-Peff
