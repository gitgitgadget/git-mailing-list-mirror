Return-Path: <SRS0=1Io1=D7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84092C2D0A3
	for <git@archiver.kernel.org>; Sat, 24 Oct 2020 07:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4055520936
	for <git@archiver.kernel.org>; Sat, 24 Oct 2020 07:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t2l69jbo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759902AbgJXHll (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 03:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759899AbgJXHlk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 03:41:40 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86C6C0613CE
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 00:41:39 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id ce10so5535613ejc.5
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 00:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UvC2c5YuWlBf9igPR4E3REGoy1TEHkHMmQlqj4YbamM=;
        b=t2l69jboYv4G9uYjU2RZ235xNtc3xO5OVJ8zv43MyIZj0eMeir5hB+4EsJZ+eerQ+s
         UaHb+ooC6KUD8+KYY0ltOkgHw9aOK98MYZpYZZGmWGZ02H45QJV+t0P6EgMbHKWbU2J6
         ybDrNKj/u4OmKLWScfwdEtAPlP2rY+2TSuUYelewQV+4aLXosPNTrf4LoMFDCh9BZudD
         HVpubCMaoLOUJf8WGmJKEXdP+kAsePabRE0tPvWC+DysCpeEIy/GJvUBaF6LEsltwDsD
         N0qtXBWVyCdaK7cNf8u5mwH2Ha2zYOZbBz6/zXcaONXEFJTOUMBqn8KbpP0Ej7khTN7i
         2VBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UvC2c5YuWlBf9igPR4E3REGoy1TEHkHMmQlqj4YbamM=;
        b=Uoo1Ay8yLeJGaoCRcPwtt5Qma55e16s0BZcdq8/mCxww5h6xDAFhPpjk7KDKji5/Zo
         7rJQcx20upZHHZP1s6GdobaBARw96vxX/BSeCO1NyRwbJthDV3jcqw20z5QC5chodCcG
         /VPqiasbIIhpJn6owq8q3gZ5JRsoGzHw0oob1I76HSJuDfshqoX+a9MIsS9mHFtIf6zW
         RxguoUn/Ro36sbS352A/ziNmhEl4/BEDp9apVk9xGdu+stGioY1EbwIuua5ApGVCVt2L
         f6P4v+8YXLuXtn53gAPylAiB/7GbL68DFU8csAe0ei+jRuyWnxC1MjZvejgpbgjSRdQf
         ep4w==
X-Gm-Message-State: AOAM533F/OrJ+carAJsqfUBrQzvtwrhRwRDuat4CdbHUN4vy/3zJ4mpf
        bIhP8pEc0dH6VWPdc/Vi7z3A0AJbPhakBNimeXs=
X-Google-Smtp-Source: ABdhPJzjUipHniPGps7QSpJ0tTQGf3QLgrZjQilNaRmBDyBdjyl+WBour/WN66q6w22VkkJCp+qXJzaoO7VKolKcYHo=
X-Received: by 2002:a17:906:c20f:: with SMTP id d15mr5645410ejz.341.1603525298669;
 Sat, 24 Oct 2020 00:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <20201022103806.26680-1-szeder.dev@gmail.com> <xmqqv9f2mb61.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqv9f2mb61.fsf@gitster.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 24 Oct 2020 09:41:27 +0200
Message-ID: <CAP8UFD30NZREjE+_WHKyAhkHAi1TjHQo7iXd9xkvHj9stjT=9A@mail.gmail.com>
Subject: Re: [PATCH] bisect: loosen halfway() check for a large number of commits
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 22, 2020 at 8:20 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>
> > However, when we have thousands of commits it's not all that important
> > to find the _exact_ halfway point, a few commits more or less doesn't
> > make any real difference for the bisection.
>
> Cute idea.

I like the idea too.

> > So I ran some tests to see how often that happens: picked random good
> > and bad starting revisions at least 50k commits apart and a random
> > first bad commit in between in git.git, and used 'git bisect run git
> > merge-base --is-ancestor HEAD $first_bad_commit' to check the number
> > of necessary bisection steps.  After repeating all this 1000 times
> > both with and without this patch I found that:
> >
> >   - 146 cases needed one more bisection step than before, 149 cases
> >     needed one less step, while in the remaining 705 cases the number
> >     of steps didn't change.  So the number of bisection steps does
> >     indeed change in a non-negligible number of cases, but it seems
> >     that the average number of steps doesn't change in the long run.
>
> It somehow is a bit surprising that there are cases that need fewer
> steps, but I guess that is how rounding-error cuts both ways?

When there are 50k commits span between the initial good and bad, I
don't expect to see any statistically significant result by trying it
1k times only. My guess is that you might start seeing something
significant only when the number of tries is a multiple of the span
between the initial good and bad.

There is some cost on average even if it's small (and gets smaller
when the span increases) of not using the best halfway commit, so the
overall gain depends on how long it takes (and possibly how much it
costs) to run the test script (or maybe to manually test).
Unfortunately without any hint from the user or without recording how
long the test script lasts (which doesn't cover manual testing) we
cannot know this cost of testing which could change a lot between use
cases.

> Mildly (only because such a bisection session over a long span is
> rarer) excited to see this RFC completed ;-)

In projects like the Linux kernel where there are around 10k commits
between 2 feature releases, such bisections over a long span might
actually happen quite often.
