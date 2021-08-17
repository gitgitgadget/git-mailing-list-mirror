Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BACC432BE
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 15:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2069761053
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 15:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbhHQPQT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 11:16:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:50086 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbhHQPQT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 11:16:19 -0400
Received: (qmail 945 invoked by uid 109); 17 Aug 2021 15:15:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 17 Aug 2021 15:15:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27593 invoked by uid 111); 17 Aug 2021 15:15:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 17 Aug 2021 11:15:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 17 Aug 2021 11:15:44 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ci: add job for gcc-4.8 to GitHub Actions
Message-ID: <YRvSoGodEJB26twE@coredump.intra.peff.net>
References: <20210816045750.36499-1-carenas@gmail.com>
 <444e7410-c9c9-1b90-da5f-d6862a35c1fc@gmail.com>
 <YRqP7J7Gu0VmB6q2@coredump.intra.peff.net>
 <20210817111512.GA2257957@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210817111512.GA2257957@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 17, 2021 at 01:15:12PM +0200, SZEDER Gábor wrote:

> > Try fb9d7431cf (travis-ci: build with GCC 4.8 as well, 2019-07-18).
> > (found with "git log -Sgcc-4.8 ci"). The gist of it is to find variable
> > declarations in for-loops.
> > 
> > IMHO it may be more trouble than it's worth. If we can't find a compiler
> > that complains on this construct, then maybe it is not a construct worth
> > worrying too much about.
> 
> I for one like for loop initial declarations, because they allow us to
> limit the scope of the loop variable to the loop, and would love to
> see it used in more places (well, wherever possible, actually, but
> that'd be a lot of churn).  So I would prefer to just drop this job
> sooner rather than later, update CodingGuidelines, and, if deemed
> necessary, launch a weather balloon.

Yeah, I think it would be nice to use that, too, if it works everywhere.
The last discussion of this was from 2017, where peple likewise seemed
in favor:

  https://lore.kernel.org/git/xmqqlgnrq9qi.fsf@gitster.mtv.corp.google.com/

There was even a weather balloon patch:

  https://lore.kernel.org/git/20170719181956.15845-1-sbeller@google.com/

but it got hung up on somebody using gcc 4.8. ;)

It looks like the default flavor bumped to gnu90 in gcc 5. That came out
in 2015, but the last 4.x release was in August 2016. Which is getting
old-ish, but still well within the realm of what people may be using an
on older distro (e.g., RHEL7, which is still supported).

For gcc, at least, this is trivially fixable with a `-std` flag (though
it may be tricky to make it work out-of-the-box through the Makefile). I
don't think we'll know if there problems with other compilers until we
do the weather balloon.

-Peff
