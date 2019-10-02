Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90F4F1F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 15:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfJBPlc (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 11:41:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:38030 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727451AbfJBPlc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 11:41:32 -0400
Received: (qmail 24891 invoked by uid 109); 2 Oct 2019 15:41:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 02 Oct 2019 15:41:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22716 invoked by uid 111); 2 Oct 2019 15:44:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Oct 2019 11:44:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 2 Oct 2019 11:41:31 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] Makefile: emulate compile in $(HCO) target better
Message-ID: <20191002154131.GB6116@sigill.intra.peff.net>
References: <cover.1569263631.git.liu.denton@gmail.com>
 <cover.1569398897.git.liu.denton@gmail.com>
 <14def72319521d7380fb6a8ec570d014c0f5361b.1569398897.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <14def72319521d7380fb6a8ec570d014c0f5361b.1569398897.git.liu.denton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 25, 2019 at 01:21:01AM -0700, Denton Liu wrote:

> Fix these problems by emulating the compile process better, including
> test compiling dummy *.hcc C sources generated from the *.h files and
> passing $(ALL_CFLAGS) into the compiler for the $(HCO) target so that
> these custom flags can be used.
> 
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> 
> Peff, thanks for the suggestion! I modified it a little bit so that we
> wouldn't have to keep regenerating the *.hcc files unnecessarily.

What you have here looks good. I doubt it matters too much compared to
the cost of the compiler, but having them in their own rule makes it
easier to follow, I think.

> I also considered piping into the compiler's stdin directly which I know
> works for GCC (and _probably_ Clang) but I opted against it because I'm
> not sure it's portable for other compilers. Maybe it's alright for this
> to be less portable since it's a developer target?

Yeah, I'd worry slightly about portability. But it would be nice to
avoid generating more cruft. And I agree that most people running this
would be developers. Maybe it would make sense to float a separate patch
on top (that would make it easy to revert if somebody runs into a
problem).

Thanks for working on this (and the whole series looks good, including
the commit message changes you made regarding the bitmap code).

-Peff
