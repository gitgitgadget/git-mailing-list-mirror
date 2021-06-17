Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3015DC2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 04:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01AE46105A
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 04:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhFQENY convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 17 Jun 2021 00:13:24 -0400
Received: from mail-ej1-f45.google.com ([209.85.218.45]:37862 "EHLO
        mail-ej1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhFQENX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 00:13:23 -0400
Received: by mail-ej1-f45.google.com with SMTP id ji1so1224230ejc.4
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 21:11:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+w/ENR97ELJQEdDOdoM+6B9/TBOIr0mKyO7EO4Sosjw=;
        b=KFKOjmQJr00ed3Jl/Gw8QlwLTMGbqdZU5W869P5dDDNkIkIDirfRu5aserdx2Ygzhg
         S03ivybrF3qRwrPRh64kcI9dnaNQ2INlo3B7UZ6IDJbq54EJGHn6mwMIANFCb2pzgRTx
         HiZhT5oCFBvF5prQ+Wj+G2J9OzxuIm1y8dL74OFs0VIHo5moV//OIQAlV4F0a1cb+4Wy
         Yw5rTGiC8KO3sp5hvPi9IYzTNV8Ihao6bkeXUG/st1KCkqNEr8QWikyudaG5edmoGlLG
         2eexgKA8QoSx7pJHmT1peWe6B/gnr+CO6NdIhteh3ZKvDbZJLTMS35SdnsBBIkO++AQV
         4ODg==
X-Gm-Message-State: AOAM5331AXsVuzfHwcgPpcEHKG34YZLEQ5kGQBT+029fT5v8wH4GBksF
        23B/BQDrNKkcZFYor0ICIDuitMW46Bou543Msy8=
X-Google-Smtp-Source: ABdhPJwOsJ7DIis1Y6a7PmkWPV1g25/Sdp1g3QBfjdKyv8tVJBYkm04GwvggRnApRC2x3ZYqOy6GnYbq4F/mpiu56Dg=
X-Received: by 2002:a17:907:1c13:: with SMTP id nc19mr3026066ejc.168.1623903075411;
 Wed, 16 Jun 2021 21:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210608134000.663398-1-lenaic@lhuard.fr> <20210612165043.165579-1-lenaic@lhuard.fr>
 <20210612165043.165579-3-lenaic@lhuard.fr> <CAPig+cSLi7aN=6ahrHwy4fO-7JMBN3pmzfpWe5ZXOcC9j4+e+g@mail.gmail.com>
 <5c4366e4-a891-0a3a-2534-af48ab0097c2@gmail.com>
In-Reply-To: <5c4366e4-a891-0a3a-2534-af48ab0097c2@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 17 Jun 2021 00:11:04 -0400
Message-ID: <CAPig+cSCWHh9eKs2Wj3N8OBJ5LzQk=4sCEu6=s0aR76nmo8H5g@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] maintenance: `git maintenance run` learned `--scheduler=<scheduler>`
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 16, 2021 at 8:48 PM Derrick Stolee <stolee@gmail.com> wrote:
> On 6/14/2021 12:36 AM, Eric Sunshine wrote:
> > On Sat, Jun 12, 2021 at 12:51 PM Lénaïc Huard <lenaic@lhuard.fr> wrote:
> > The above description is somewhat redundant. Another way to write it
> > without the redundancy might be:
> >
> >     Specify the scheduler -- in combination with subcommand `start` --
>
> I think this change to the start is not contributing to the drop
> in redundancy, but _does_ break from the pattern of previous
> options. These start with "When combined with the `X` subcommand"
> to clarify when they can be used.
>
> I'm not against improving that pattern. I'm just saying that we
> should do it across the whole file if we do it at all.

Indeed, it's not a big deal. As mentioned in my review, all my
comments were subjective, and none of them should prevent this from
being accepted as-is if everyone is happy with it.

> >     for running the hourly, daily and weekly invocations of `git
> >     maintenance run`. Possible values for `<scheduler>` are `auto`,
> >     `crontab` (POSIX), `launchctl` (macOS), and `schtasks` (Windows).
> >     When `auto` is specified, the appropriate platform-specific
> >     scheduler is used. Default is `auto`.
>
> I find this to be a good way to reorganize the paragraph to be
> very clear. How do you propose adding `systemd-timer` in the next
> patch? Is it simply adding "`systemd-timer (Linux)`" or do we
> need to be more careful using "(when available)"? Unlike the others,
> the availability of that option is not as cut-and-dry.

It should be easy enough. For instance:

    Possible values for `<scheduler>` are `auto`, `crontab` (POSIX),
    `systemd-timer` (Linux), `launchctl` (macOS), and `schtasks`
    (Windows). When `auto` is specified, the appropriate platform-
    specific scheduler is used; on Linux, `systemd-timer` is used if
    available, otherwise `crontab`. Default is `auto`.

But this sort of minor rewrite can always be done later.

> > I don't see `auto` being tested anywhere. Do we want such a test? (It
> > seems like it should be doable, though perhaps the complexity is too
> > high -- I haven't thought it through fully.)
>
> Unfortunately, `auto` seems to live in a world where we need to
> actually run commands such as crontab and systemctl to determine
> if they are available, but that happens only when
> GIT_TEST_MAINT_SCHEDULER is unset. But, we don't want to actually
> edit the timing information for the test runner, so some other
> abstraction needs to be inserted at the proper layer.
>
> It's worth a shot, but I expect it to be challenging to get right.

I imagine that it can be mocked up with GIT_TEST_MAINT_SCHEDULER in
some fashion, but it's not worth holding up this series or expecting a
re-roll for that one little question which popped out of my brain.

As I mentioned in my review, my comments were subjective, and I think
the series is in a state in which it can be accepted as-is without
additional re-rolls[1] if everyone is happy with it.

[1]: Except for the one question I asked about is_crontab_available();
I don't understand that one bit of logic, thus can't tell if the
behavior makes sense or not.
