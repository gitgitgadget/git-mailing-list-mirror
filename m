Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B771C2B9F4
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 02:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F41A560BD3
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 02:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhFWCGx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 22:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhFWCGx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 22:06:53 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2B6C061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 19:04:35 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id z1so1161991ils.0
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 19:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=J9htVX8HZkq1cdFh+7q0kqAciu47he9EnzCX0YRs8hY=;
        b=qy7Ij1CPffR0ko62TAlf6nB8ZBUegNE/+X2+vo+PZYU2I3s2PBUtm9N6hf4F0qKJ7w
         k3LPXFBZ8ieipCwX07esoQpgV+NZxUtDcjxUjnRN1HELLbi9dhqHbVc7KJ4gNvQZYITo
         IN0ZrNl1s26pyQERY7/H3gOZh6kw/zo0JUY/trKUD7cP2tzCdANGH4jgFclPCvHIh2Rp
         tiVCL6KXcenDjoz75pYq7IF4U8n94kBKJlAQSCDIgbi4KrHhSQYsmTGqDRs7JH1dPcyL
         rEx/RiFHDH7+Ua1TiCMrpRizfVh1NG0BX3QtRqyYw0O18kyDDYPYgO2ioqwxfZtceb6S
         C9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=J9htVX8HZkq1cdFh+7q0kqAciu47he9EnzCX0YRs8hY=;
        b=K3jTzYF5BsGg4kYUMM0FW6qEJT36jmXZSfFFRbhNISb2Wz5Oo1oJJhYbPILT+MM5Ip
         MohX9qPGZolU7j+jjZ2y1k8howc5+OdWbyjr8mQcXp4ec20qpKSl8Xje1qnaNkBLgwn/
         8Tc+nKbTXH+iJpZLQNxCYeiKHq9TzrI1YgZTBuOPiYPUMEKTemMwM9/WS3nsFRD5i3oS
         YYxEncH2msvc5CreeViiY8YJ/zZ0w+nuyZhCPE/W2Y9Pa1paAZEDpa8CwhN7YqnJrduz
         iX/zfG6HXPxCJKXP6B4qzHdCcmWG5yCqtam7TWDGf7/LkCAg0hg/U+9ToPx6FfebIxQS
         2E8w==
X-Gm-Message-State: AOAM531dgR/1uo1Wx6ky/a4B2nR/NtxmAe7GW7Knq2ujrDAPp++TvEGV
        YVF00/AgqZ/s354/Nx+PV9HGyg==
X-Google-Smtp-Source: ABdhPJxfghAo76tiRSuyLPsjcEypbhFSAoHQ0C73q8r46caANnX891ChdgTRsYq5a0H7oeP9/xuqnw==
X-Received: by 2002:a05:6e02:c74:: with SMTP id f20mr1169524ilj.85.1624413875177;
        Tue, 22 Jun 2021 19:04:35 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:827b:778a:e73b:3ade])
        by smtp.gmail.com with ESMTPSA id l6sm8175010ilv.58.2021.06.22.19.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 19:04:34 -0700 (PDT)
Date:   Tue, 22 Jun 2021 22:04:33 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 0/7] progress: verify progress counters in the test suite
Message-ID: <YNKWsTsQgB2Ijxu7@nand.local>
References: <20210620200303.2328957-1-szeder.dev@gmail.com>
 <874kds3tdn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874kds3tdn.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 21, 2021 at 02:59:53AM +0200, Ævar Arnfjörð Bjarmason wrote:
>
> On Sun, Jun 20 2021, SZEDER Gábor wrote:
>
> > Splitting off from:
> >
> >   https://public-inbox.org/git/cover-0.2-0000000000-20210607T144206Z-avarab@gmail.com/T/#me5d3176914d4268fd9f2a96fc63f4e41beb26bd6
> >
> > On Tue, Jun 08, 2021 at 06:14:42PM +0200, René Scharfe wrote:
> >> I wonder (only in a semi-curious way, though) if we can detect
> >> off-by-one errors by adding an assertion to display_progress() that
> >> requires the first update to have the value 0, and in stop_progress()
> >> one that requires the previous display_progress() call to have a value
> >> equal to the total number of work items.  Not sure it'd be worth the
> >> hassle..
> >
> > I fixed and reported a number of bogus progress lines in the past, the
> > last one during v2.31.0-rc phase, so I've looked into whether progress
> > counters could be automatically validated in our tests, and came up
> > with these patches a few months ago.  It turned out that progress
> > counters can be checked easily and transparently in case of progress
> > lines that are shown in the tests, i.e. that are shown even when
> > stderr is not a terminal or are forced with '--progress'.  (In other
> > cases it's still fairly easy but not quite transparent, as I think we
> > need changes to the progress API; more on that later in a separate
> > series.)
>
> I've also been working on some progress.[ch] patches that are mostly
> finished, and I'm some 20 patches in at the moment. I wasn't sure about
> whether to send an alternate 20-patch "let's do this (mostly) instead?"
> series, hence this message.
>
> Much of what you're doing here becomes easier after that series,
> e.g. your global process struct in 2/7 is something I ended up
> implementing as part of a general feature to allow progress to be driven
> by either display_progress() *or* the signal handler itself.

It's difficult to know who should rebase onto who without seeing one
half of the patches. I couldn't find a link to them anywhere (even if
they are only available in your fork in a pre-polished state) despite
looking, but my apologies if they are available and I'm just missing
them.

In general, I think that these patches are clear and are helpful in
pinning down issues with the progress API (which I have made a hadnful
of times in the past), so I would be happy to see them picked up.

> I could also rebase on yours, but much of it would be rewriting the
> test-only code to be more generalized, perhaps it's easier if we start
> going for the more generalized solution first.

Again, without knowing the substance of your patches it's hard to
comment for sure, but I don't have a problem with a simple and direct
approach here.

> Perhaps we can just have it BUG() for now as you're doing and cross that
> bridge when we come to it. I just wonder if we can't catch potential
> bugs in a more gentle way somehow.

I think there are compelling reasons to feel that the new mode should
only be enabled during tests, as well as compelling reasons to feel that
it should be enabled all of the time.

One way to think about it is that we do not want users to have a BUG()
abort their program just because a progress meter went rogue. So in that
sense, it makes sense that we would only see that happen during tests,
so that those tests could tell us where the bug is, and we could fix it.

On the other hand, since we make sure that our tests pass at each patch,
there's no point in having a separate mode (and instead, remove the
conditionals on GIT_TEST_PROGRESS_CHECK), since successfully running the
tests tells us that there are no rogue progress meters that we exercise
in our (hopefully) complete set of tests.

I could go either way, I think both lines of reasoning are quite
reasonable. But, I think we are generally more lax about having the
whole ci/run-build-and-tests.sh script pass at every commit, and that it
seems we care more about having the tip of each series pass CI when
integrated into 'seen'.

So I don't think that hiding this new mode behind an environment
variable is giving us as much confidence as we'd like, because it
doesn't add anything in "make test".

To me, I think a reasonable direction to take would be to *always*
export GIT_TEST_PROGRESS_CHECK when running tests, not just in
ci/run-build-and-tests.sh. That means we'll catch incorrect uses of the
progress API during tests, without worrying that incomplete coverage
will cause user-visible breakage.

Thanks,
Taylor
