Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CBFC433FE
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 19:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352739AbhLATlw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 14:41:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:41320 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352813AbhLATlf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 14:41:35 -0500
Received: (qmail 17362 invoked by uid 109); 1 Dec 2021 19:38:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Dec 2021 19:38:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9753 invoked by uid 111); 1 Dec 2021 19:38:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Dec 2021 14:38:09 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Dec 2021 14:38:08 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] test-lib.sh: have all tests pass under "-x", remove
 BASH_XTRACEFD
Message-ID: <YafPIOD2bmeYrPR2@coredump.intra.peff.net>
References: <pull.1085.git.1638193666.gitgitgadget@gmail.com>
 <patch-1.1-9f735bd0d49-20211129T200950Z-avarab@gmail.com>
 <YaaS4Idhdyo2wZ9q@coredump.intra.peff.net>
 <20211130224435.GA1991@szeder.dev>
 <211201.868rx4beer.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211201.868rx4beer.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 01, 2021 at 03:06:44PM +0100, Ævar Arnfjörð Bjarmason wrote:

> I don't really mind keeping BASH_XTRACEFD if it's doing something
> useful, but I feel like I'm missing something here. Is it really doing
> something useful?
> 
> AFAICT the ony case where it mattered was t1510-repo-setup.sh, which
> with my upthread
> <patch-1.1-9f735bd0d49-20211129T200950Z-avarab@gmail.com> now works with
> -x, at the trivial cost of skipping a small bi of the test with -x.
> 
> I suppose we could move this BASH_XTRACEFD to tht file in particular if
> anyone feel strongly about the trivial loss of tracing that entails. I
> figured just skipping it under "-x" and adding a "say" to that effect
> was a better trade-off.
> 
> For the rest of the test suite BASH_XTRACEFD effectively didn't matter,
> since all our tests had to work under --verbose-log -x anyway under
> dash.
> 
> Am I just wrong about this line of thinking, or is it purely that you
> two would like to keep BASH_XTRACEFD in case some hypothetical future
> caller wants to make use of "test_untraceable=UnfortunatelyYes" again?

I don't know that I'd call it purely hypothetical. It was the state for
many years in the past. And there has to be per-test hackery to keep it
that way. So I wouldn't call XTRACEFD a workaround at all; in my mind it
was the solution.

Now if people want to do that per-test hackery _also_, because it keeps
"-x" more useful for folks who can't or won't use bash, I have no
problem with that. What I was hoping to avoid was making it a
hard requirement, because now it's one more subtle thing for test
writers to have to remember and deal with.

But maybe that ship is sailed. If we are running with "-x" and dash in
CI, then they're going to see confusing failures there regardless.

-Peff
