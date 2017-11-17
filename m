Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B77D9202AF
	for <e@80x24.org>; Fri, 17 Nov 2017 22:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936737AbdKQWQe (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Nov 2017 17:16:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:33000 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S936734AbdKQWQd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Nov 2017 17:16:33 -0500
Received: (qmail 9485 invoked by uid 109); 17 Nov 2017 22:16:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 17 Nov 2017 22:16:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28951 invoked by uid 111); 17 Nov 2017 22:16:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Fri, 17 Nov 2017 17:16:47 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Nov 2017 17:16:31 -0500
Date:   Fri, 17 Nov 2017 17:16:31 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     gennady.kupava@gmail.com, git <git@vger.kernel.org>,
        Gennady Kupava <gkupava@bloomberg.net>
Subject: Re: [PATCH] Reduce performance penalty for turned off traces
Message-ID: <20171117221631.x2xqeeqmf5xob3yv@sigill.intra.peff.net>
References: <20171111192858.27255-1-gennady.kupava@gmail.com>
 <20171112141737.nmnsygm4wrhtkqwb@sigill.intra.peff.net>
 <CAGZ79kb4Eo0AC4Z42_ks5_+Pcy4DrDCufNb=5J=g8L6pMnHd7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kb4Eo0AC4Z42_ks5_+Pcy4DrDCufNb=5J=g8L6pMnHd7A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 15, 2017 at 11:14:20AM -0800, Stefan Beller wrote:

> > I did manually disable HAVE_VARIADIC_MACROS and confirmed that the
> > result builds and passes the test suite (though I suspect that GIT_TRACE
> > is not well exercised by the suite).
> 
> GIT_TRACE is exercised in the test suite (though I am not sure if it counts
> as well-exercised) in t7406-submodule-update.sh for example, which uses
> GIT_TRACE to obtain information about thread parallelism used by Git, as
> that is not observable otherwise, if we assume that performance tests in the
> standard test suite are not feasible.

Hmm, yeah, that might cover it. What I'm worried about is that we missed
some case where NULL needed to become &trace_default_key. But I did look
for that in my review of the patch and didn't notice any spots. And the
coverage in t7406 should help.

> > After your patch, the GIT_TRACE=1 time remains the same but GIT_TRACE=0
> > drops to 1ms.
> 
> So does that mean we can use a lot more tracing now?

Yep, that's the intent.

-Peff
