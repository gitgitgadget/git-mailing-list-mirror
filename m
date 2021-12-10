Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBE9C433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 08:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238563AbhLJIl0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 03:41:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:48486 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238559AbhLJIlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 03:41:25 -0500
Received: (qmail 17838 invoked by uid 109); 10 Dec 2021 08:37:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Dec 2021 08:37:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28054 invoked by uid 111); 10 Dec 2021 08:37:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Dec 2021 03:37:52 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Dec 2021 03:37:49 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [RFC/PATCH] Makefile: add test-all target
Message-ID: <YbMR3ePaJHtYKReP@coredump.intra.peff.net>
References: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
 <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
 <CABPp-BGpe9Q5k22Yu8a=1xwu=pZYSeNQoqEgf+DN07cU4EB1ew@mail.gmail.com>
 <xmqq4k7nmksi.fsf@gitster.g>
 <211207.86ilw0matb.gmgdl@evledraar.gmail.com>
 <xmqqh7bi27o9.fsf@gitster.g>
 <xmqq8rwu278d.fsf_-_@gitster.g>
 <YbEpE7UI+ovnNQyj@coredump.intra.peff.net>
 <xmqqczm5u0d4.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqczm5u0d4.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 09, 2021 at 09:57:59AM -0800, Junio C Hamano wrote:

> > So I think this is as likely to cause somebody a headache due to a dumb
> > portability problem or random bitrot as it is to actually find a bug. I
> > guess test-extra wouldn't be run by default, but only via CI, so maybe
> > that limits the blast radius sufficiently.
> 
> Yeah, that is the exact thought I had when I did it.  Anybody who is
> not aware of test target other than 'test' will not be hurt, and we
> explicitly make the CI aware of 'test-all' to trigger it.  But as
> long as somebody bothered to write the tests, exercising them to
> reveal bitrot-bugs either in the tested contrib stuff or the tests
> themselves to be fixed or removed would be a good thing to do.

I'm don't have strong feelings on it either way. But if we think those
tests are worth running in CI, then...

> So I am tempted to do
> 
> test-extra: all
> 	$(MAKE) -C contrib/credential/netrc test
> 	$(MAKE) -C contrib/diff-highlight test
> 	: $(MAKE) -C contrib/mw-to-git test
> 	$(MAKE) -C contrib/subtree test

...we'd probably want to keep running mw-to-git tests, and teach one of
the CI environments to install the appropriate perl modules to avoid
skipping them.

-Peff
