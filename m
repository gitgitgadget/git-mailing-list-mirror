Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374BAC4320A
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 20:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FAD26109E
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 20:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbhHSUL7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 16:11:59 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:41876 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbhHSUL7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 16:11:59 -0400
Received: by mail-ed1-f52.google.com with SMTP id n12so10560748edx.8
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 13:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QytasVQY535f0OheaGmyTbNZM2DlZ4/ii9r6yB9NtoY=;
        b=eI2ZcRpuHneN8jKgVsoVlNOGAt+lcurYbQYOhFZ2PCi6lm/Ag3BiW0thirZ8L71b7R
         8Nf5Bh17U0o8AVYG6qhQwJDoWlVgbsKhTz+xuaTsArsLayytZiS6P+EroZOgDQkDsfdm
         taCZLf8XYSKEsDc5rKDw5GWIuot8unEhMH9OMK9r8qlW1cMNKXhF4/7jfr0N/E80Wm+M
         4+ROfiDHkz0JVnFaEBFz39YHwpWYpkgmmLD9btes0nB4QdF0ahd1eCb8A6+8kHuVzjlu
         HAaYhmppG0/RMJswY2fm7UAi67pdyKM1yE9JUVVWgEqcF9WMt/lJWyjaPxyLYogKa/Lc
         QJig==
X-Gm-Message-State: AOAM533UAINZSx7p0RXPiAQepy9ZV+2x3USMvww6OtBGCsgjohT2GOBw
        Wpk7+nW5wXmseZPrFUsZZ3dZtLPTd96CS8JY8i00zk2OKdE=
X-Google-Smtp-Source: ABdhPJydt4gcjZXY9T6WheUR5zO33M+K1JEaxW0cFikeYYczdwECqktS5Nt3AjUUfZWTmcWfme7RxSjgKw7eoalZtNw=
X-Received: by 2002:a50:ef11:: with SMTP id m17mr18080896eds.233.1629403881630;
 Thu, 19 Aug 2021 13:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1022.git.1629393395.gitgitgadget@gmail.com>
 <CAPig+cT2FfaYBbsRMy7vxXkvsxn4BcFTn4bGJjgvJKznXg1OYg@mail.gmail.com> <CABPp-BFKEoHTgdSnUO86zSPYR0mLHv-vUB+Z-SoTtYQbUY4H=Q@mail.gmail.com>
In-Reply-To: <CABPp-BFKEoHTgdSnUO86zSPYR0mLHv-vUB+Z-SoTtYQbUY4H=Q@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 19 Aug 2021 16:11:10 -0400
Message-ID: <CAPig+cRk-BB79+pO83A6Qov9W75_91gzaHY4Le1MYKDUWagugg@mail.gmail.com>
Subject: Re: [PATCH 0/2] test-lib-functions.sh: keep user's HOME, TERM and
 SHELL for 'test_pause' and 'debug'
To:     Elijah Newren <newren@gmail.com>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 19, 2021 at 4:03 PM Elijah Newren <newren@gmail.com> wrote:
> On Thu, Aug 19, 2021 at 11:10 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > I also find the test_pause() user-experience suboptimal and appreciate
> > the idea of improving it. However, this approach seems fatally flawed.
> > In particular, setting HOME to the user's real home directory could
> > lead to undesirable results. When I'm using test_pause() to debug a
> > problem with a test, I'm not just inspecting the test state, but I
> > quite often interact with the state using the same Git commands as the
> > test itself would use. Hence, it is very common for me to pause the
> > test just before the suspect commands and then run those commands
> > manually (instead of allowing the test script to do so). In such a
> > scenario, HOME must be pointing at the test's home directory, not at
> > my real home directory.
>
> I agree, but I worry that it's not just HOME.  I'd think the point of
> test_pause is to let you interact with the repository state while
> getting the same results that the test framework would, and I think
> some tests could be affected by TERM and SHELL too (e.g. perhaps the
> recent issues with COLUMNS).  Granted, I suspect far fewer tests would
> be affected by those, but I'm not sure I like the idea of inability to
> reproduce the same issues.

Oh, indeed. I didn't mean to imply that HOME is the only problematic
one; they all are since, as you say, they can impact correctness and
reproducibility of the tests themselves. I called out HOME specially
because of the potential danger involved with pointing it at the
user's real home directory since it could very well lead to clobbering
of precious files and other settings belonging to the user.
