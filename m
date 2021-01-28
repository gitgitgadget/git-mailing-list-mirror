Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC800C433E0
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 21:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91A4060235
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 21:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbhA1Vwg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 16:52:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:42474 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229757AbhA1Vwb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 16:52:31 -0500
Received: (qmail 17820 invoked by uid 109); 28 Jan 2021 21:51:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 Jan 2021 21:51:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2290 invoked by uid 111); 28 Jan 2021 21:51:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Jan 2021 16:51:44 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 Jan 2021 16:51:43 -0500
From:   Jeff King <peff@peff.net>
To:     Jacob Vosmaer <jacob@gitlab.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v4] upload-pack.c: fix filter spec quoting bug
Message-ID: <YBMx7yuBit8TecYp@coredump.intra.peff.net>
References: <YBCFBivBLgqEAUr1@coredump.intra.peff.net>
 <20210128160453.79169-1-jacob@gitlab.com>
 <xmqqmtwsx4d9.fsf@gitster.c.googlers.com>
 <CADMWQoPgscKm2wVOo4uEqSSwgrZQTp7_eoMJpG=pdDmc1bJr=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADMWQoPgscKm2wVOo4uEqSSwgrZQTp7_eoMJpG=pdDmc1bJr=g@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 28, 2021 at 10:12:42PM +0100, Jacob Vosmaer wrote:

> Now that we're talking about the test, I was wondering about something else.
> 
> In my original patch, I purposely did not add a test. Why? Because
> --filter is just one option of several that upload-pack passes to
> pack-objects (think of --shallow-file and --include-tag, for
> instance). Why is --filter special? If the original quoting bug had
> not happened, would we be testing various permutations of clone
> options in combination with packObjectsHook?
> 
> As a reader looking at t5544, unless I know the backstory of the bug,
> I do not understand why --filter gets a test but those other things do
> not.

You're definitely not wrong that this is somewhat closing the barn door
after horse has left, and there may be other barns still to be fixed.

But usually we'll add a test that demonstrates the breakage, if only
because the fact that something so mundane and easy to trigger _wasn't_
caught by the existing test is pretty bad. So we should at least make
sure the combination is now covered, which your test does. And then over
time we build up a set of coverage.

Of course it is sometimes nice to be exhaustive, too. The organically
built-up set of tests is going to have holes if it's not done
systematically. But Git also isn't a black box; we know that the
implementation of this option was weirdly different.

I guess the argument you are making is that now that it's fixed, it
_isn't_ different, and we're unlikely to reintroduce the bug. I can buy
that, but I think we just do the "test the fixed bug" thing on
principle.

-Peff
