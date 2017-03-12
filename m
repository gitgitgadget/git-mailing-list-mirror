Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 143E3202C1
	for <e@80x24.org>; Sun, 12 Mar 2017 12:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755734AbdCLMcR (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Mar 2017 08:32:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:42819 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755704AbdCLMcP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2017 08:32:15 -0400
Received: (qmail 29516 invoked by uid 109); 12 Mar 2017 12:32:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 12 Mar 2017 12:32:14 +0000
Received: (qmail 12319 invoked by uid 111); 12 Mar 2017 12:32:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 12 Mar 2017 08:32:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 12 Mar 2017 08:32:12 -0400
Date:   Sun, 12 Mar 2017 08:32:12 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC][PATCH] index-pack: add testcases found using AFL
Message-ID: <20170312123212.3rnqyx3dvi5yppk5@sigill.intra.peff.net>
References: <20170310151556.18490-1-vegard.nossum@oracle.com>
 <20170310190641.i7geazhrlmzzfna6@sigill.intra.peff.net>
 <CACBZZX5fGU9C-z94KbMAs_AegOSGtq8nbrkRe-NxBCHYsDswkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX5fGU9C-z94KbMAs_AegOSGtq8nbrkRe-NxBCHYsDswkA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 10, 2017 at 11:58:13PM +0100, Ævar Arnfjörð Bjarmason wrote:

> >> I observe the following coverage changes (for t5300 only):
> >>
> >>   path                  old%  new%    pp
> >>   ----------------------------------------
> >>   builtin/index-pack.c  74.3  76.6   2.3
> >>   pack-write.c          79.8  80.4    .6
> >>   patch-delta.c         67.4  81.4  14.0
> >>   usage.c               26.6  35.5   8.9
> >>   wrapper.c             42.0  46.1   4.1
> >>   zlib.c                58.7  64.1   5.4
> >
> > I'm not sure how I feel about this. More coverage is good, I guess, but
> > we don't have any idea what these packfiles are doing, or whether
> > index-pack is behaving sanely in the new lines. The most we can say is
> > that we tested more lines of code and that nothing segfaulted or
> > triggered something like ASAN.
> 
> Isn't the main value with these sorts of tests that they make up the
> difference in the current manually maintained coverage & some
> randomized coverage. So when you change the code in the future and the
> randomized coverage changes, we don't know if that's a good or a bad
> thing, but at least we're more likely to know that it changed, and at
> that point someone's likely to actually investigate the root cause,
> which'll turn some AFL blob testcase into an isolated testcase?

I think you may be more optimistic than me in people actually looking at
our coverage numbers. There is a "make coverage" target, but I don't
think its output is useful for anybody trying to make comparison
metrics.

One further devil's advocate:

If people really _do_ care about coverage, arguably the AFL tests are a
pollution of that concept. Because they are running the code, but doing
a very perfunctory job of testing it. IOW, our coverage of "code that
doesn't segfault or trigger ASAN" is improved, but our coverage of "code
that has been tested to be correct" is not (and since the tests are
lumped together, it's hard to get anything but one number).

So I dunno. I remain on the fence about the patch.

-Peff
