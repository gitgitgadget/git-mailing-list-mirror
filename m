Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90BB2211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 05:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbeLEFqj (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 00:46:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:59386 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726695AbeLEFqj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 00:46:39 -0500
Received: (qmail 453 invoked by uid 109); 5 Dec 2018 05:46:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Dec 2018 05:46:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28165 invoked by uid 111); 5 Dec 2018 05:46:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 05 Dec 2018 00:46:07 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Dec 2018 00:46:37 -0500
Date:   Wed, 5 Dec 2018 00:46:37 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] test-lib: add the '--stress' option to run a
 test repeatedly under load
Message-ID: <20181205054637.GF12284@sigill.intra.peff.net>
References: <20181204163457.15717-1-szeder.dev@gmail.com>
 <20181204163457.15717-4-szeder.dev@gmail.com>
 <87o9a1z0j5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o9a1z0j5.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 04, 2018 at 06:04:14PM +0100, Ævar Arnfjörð Bjarmason wrote:

> 
> On Tue, Dec 04 2018, SZEDER Gábor wrote:
> 
> > The number of parallel invocations is determined by, in order of
> > precedence: the number specified as '--stress=<N>', or the value of
> > the GIT_TEST_STRESS_LOAD environment variable, or twice the number of
> > available processors in '/proc/cpuinfo', or 8.
> 
> With this series we have at least 3 ways to get this number. First
> online_cpus() in the C code, then Peff's recent `getconf
> _NPROCESSORS_ONLN` in doc-diff, and now this /proc/cpuinfo parsing.

To be fair, I only added the "getconf" thing because somebody complained
that I was parsing /proc/cpuinfo, and suggested it instead. ;)

I don't think it's especially portable, but it should work on Linux and
modern BSD/macOS, which may be enough (unlike doc-diff, I'd be a little
more inclined to ask somebody on a random platform to stress test if
they're hitting a bug).

> Perhaps it makes sense to split online_cpus() into a helper to use from
> the shellscripts instead?

I think somebody proposed that in a recent thread for other reasons,
too. I'd be OK with that, but probably just using getconf is reasonable
in the meantime.

-Peff
