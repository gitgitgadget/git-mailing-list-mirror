Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8C6C433F5
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 04:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52B7E6023B
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 04:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhKFEXg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 00:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhKFEXf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 00:23:35 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309A6C061570
        for <git@vger.kernel.org>; Fri,  5 Nov 2021 21:20:55 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id x15so8567311edv.1
        for <git@vger.kernel.org>; Fri, 05 Nov 2021 21:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=mIeMetqq7NOrpBzREDHnz0T3C6rlo4L0Q9qi7nF367Y=;
        b=fNW9gqaj54SjGZmYOTYIq2XZt8FSH2xbllZPXEvOu6imyuXzaW4Q3fV+am0UkNBJQh
         x7ofNABaSGoWQDkv1VzRtxlkSVjUOlhIcLP2G+I+Oihu1SdU/G/J3eSwOBGcZfHkEWRX
         2noRtQ+K7J8Fd9QFZ0e+d6MMVHrJmrJW5bk6OagxhbZwtTNVQBiyN3mdFifGii9wp6SP
         NX5fvhJenyfpoZ1qwDHbuvDPRhXH4QNw+Kiamue1jCNdgf+qqYJXL1rmWxe6lUqwnrvH
         IprgJKd7b8B32MQkS9Y4O2GV3LeW3t3lmOsrol5orczKNdwStVGu8FZoKGbWT2ZEoHe5
         5dsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=mIeMetqq7NOrpBzREDHnz0T3C6rlo4L0Q9qi7nF367Y=;
        b=ChrfdkXDZ5KgDmoIWFF2d4D65K94D+vwdHX8B1+sbbP7WAqdxALi1Sib/OroSaxes3
         dUhis4kacmRyHez/B8R5QgrmVLZLy7KX3zrVGH2fXEYAfaRIi3s5FGMMeE8orViOW/+T
         bjj6d63kRbsHTxZvl5NO19e2M4lRi3tJqA5zpPb7o8EjwMLEdAsviSVSthBuFfADEJfx
         jo+N+sEF0M4wD+M2pi0c0QNqG6ESOre5WnwGT7Xzrr1LxqekR1TbdwnV8+zZlzSB/sJJ
         0WLMpcXTYZ7XKqbuwiMIpdNSA+OhSzjVxO52RADejVqupxPOCoLZ8cunIObV+lD5B9+P
         fXVQ==
X-Gm-Message-State: AOAM531npdYBU0y5u9SXul58t9zume5zBIoHVJiE+sMjpLuajtbAZC+5
        zg5fb/4wNq5hToFmKEUln80=
X-Google-Smtp-Source: ABdhPJws/FaiJvFv8s1j7Msaaf/0wjp3gzHL6dwNmKNbT2mHJ1IdPEoH2x7+Bz3mbuDrOyYS7a4lLw==
X-Received: by 2002:aa7:ccc1:: with SMTP id y1mr85569308edt.177.1636172453667;
        Fri, 05 Nov 2021 21:20:53 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id he17sm1530955ejc.110.2021.11.05.21.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 21:20:53 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mjDCG-000ZRp-Rt;
        Sat, 06 Nov 2021 05:20:52 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: move some test-tools to 'unstable plumbing' built-ins (was: [PATCH]
 test_bitmap_hashes(): handle repository without bitmaps)
Date:   Sat, 06 Nov 2021 05:08:25 +0100
References: <YYTy6+DG5guzJIO7@coredump.intra.peff.net>
 <xmqq35oaxwnz.fsf@gitster.g> <YYWBz6rjF+I+JkO3@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <YYWBz6rjF+I+JkO3@nand.local>
Message-ID: <211106.86fss9hq3f.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 05 2021, Taylor Blau wrote:

> On Fri, Nov 05, 2021 at 11:52:16AM -0700, Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:
>>
>> > If prepare_bitmap_git() returns NULL (one easy-to-trigger cause being
>> > that the repository does not have bitmaps at all), then we'll segfault
>> > accessing bitmap_git->hashes:
>> >
>> >   $ t/helper/test-tool bitmap dump-hashes
>> >   Segmentation fault
>> >
>> > We should treat this the same as a repository with bitmaps but no
>> > name-hashes, and quietly produce an empty output. The later call to
>> > free_bitmap_index() in the cleanup label is OK, as it treats a NULL
>> > pointer as a noop.
>> >
>> > This isn't a big deal in practice, as this function is intended for and
>> > used only by test-tool. It's probably worth fixing to avoid confusion,
>> > but not worth adding coverage for this to the test suite.
>> >
>> > Signed-off-by: Jeff King <peff@peff.net>
>> > ---
>> > This is new in the v2.34.0 cycle, but it's so low impact it doesn't
>> > matter much if we ship with the bug. OTOH, it's pretty low-risk since it
>> > is only run by the test suite.
>>
>> ;-)
>
> Yes, this looks obviously correct to me. Thanks for spotting and fixing
> this, Peff.
>
> I'd be happy to see it in the 2.34 cycle, too, but I agree that it would
> be OK if it didn't make the cut (and certainly if it makes it easier for
> Junio to handle the rest of the release cycle, then I'm in favor of
> leaving it out).
>
>> I wonder how you found it.  Diagnosing a repository that did not
>> seem healthy?  What I am getting at is if we want a new option to
>> make a plumbing command, other than the test-tool, that calls this
>> function, as the latter is usually not deployed in the field.
>
> I would not be surprised if this was discovered via Coverity, or by
> manual inspection. Peff and I have been merging a slew of releases from
> your tree into GitHub's fork and so have been reading code in the more
> recently changed areas.
>
> On the test-tool vs. plumbing thing: I think there are some compelling
> reasons in either direction. There's no *good* home for these in our
> current set of plumbing tools. E.g., the closest example we have is `git
> rev-list --test-bitmap <rev>`, which is kind of ugly. When we needed
> these new inspection tools for some of the newer bitmap-related tests,
> adding them via the test-helper suite was a conscious choice to not
> build on the ugliness of `--test-bitmap`.
>
> But on occasion these test-tool things are useful to have "in the
> field", as you say. It's rare enough that I usually just clone a copy of
> our fork as needed and build it when I do find myself reaching for
> test-helpers.

As part of the proposed integration for "scalar" I added a category to
the command-list.txt called "optionalcontrib", which we'll list on its
own in "man git" as (paraphrasing) super-duper-experimental.

I really don't see why we shouldn't do so very lightly with some of
these remotely-useful test-tool tools.

It's pretty much the same amount of work to create a new built-in as a
new test-tool, and as long as we make it clear in our documentation that
these aren't in the same "plumbing" category I don't see why we
shouldn't add those quite freely.

We can even make installing them be optional, as some distributors might
prefer that, which the scalar patch at [1] also does. So all the
boilerplate is there for someone who'd like to run with this idea.

It seems to me that we've ended up with the current status quo of not
adding "new plumbing" because we'll need to support it forever out of
some self-imposed constraint that we couldn't add new categories to the
"git" manual page.

But if we just prominently list them as being unstable helpers aimed at
git experts, and note the same thing prominently in their manual page
(trivially done via an include) everyone should be on the same page
about their stability, and we'll be able to use stuff like "test-tool
pkt-line" "in the field".

1. https://lore.kernel.org/git/patch-1.1-86fb8d56307-20211028T185016Z-avarab@gmail.com/
