Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54FBC4338F
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 16:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 933C461042
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 16:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbhHGQBF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Aug 2021 12:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbhHGQBE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Aug 2021 12:01:04 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB577C0613CF
        for <git@vger.kernel.org>; Sat,  7 Aug 2021 09:00:45 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id p38so24629054lfa.0
        for <git@vger.kernel.org>; Sat, 07 Aug 2021 09:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=If5dkLogGn3N9ayr5S0hWdDXKZAxH03KVEUtvZKyUSo=;
        b=kYBMetnPZEUhMRQNomT1+8UJJP2oXm2YsDFFrmz1vdpoPbIhC+qbpNWIycWRYlZ1ea
         D4pd+hS7OPQRaAxWCRsh2oBhrxCOKY3C8/2mK7kupuHJQpgzX26kcylQYJvx4uhT/rYK
         O/o1r8duqSx7izSE0Zf/SHbCIiEXeTVKXIL6tBpXMrhCYbl4eQXDJzZwGjArYhd2OEms
         RQCNnutys9ZAfl/wWEa8hk9C0b0wErh95Lgm7ZjygHOUoJyZ7RD4GRcm77p8dSaiYCIv
         oyITRhCF8WfsJt5BEGjaYBigGxldBaG/r5hE8xh5/3NSFmFoNIG1nYnyJnIIzWr1By5z
         hN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=If5dkLogGn3N9ayr5S0hWdDXKZAxH03KVEUtvZKyUSo=;
        b=Z1QuIdvK+3dYUDY1XqGmJoHWquCd4yEMLFR7ZO8Begxn5bYynRCahKPSKMLXsrIv81
         l1hNyk4jLyJ7QoIaJEZqTMV/bZRSxhJQBtE3coPRyVIVo5OROZIWN9bwd/z1IpzdGUHC
         2wDRcqEOY4/zotXUFN5s58UR1vpcf8aAxUgsSAJVS/LB4cmYhOG4fnMgQTdV7fkbs6kM
         eQfZklz/+ssBhL2k60uFn19M1FhrtEhg0FQHZd6LEdWvZJJvu5lhj/3HiuHb03Nk3dIo
         2HofuoOrQ1MVS3U3HKBPN/CiBXpgVl8aeHV04GkAGZJ7bIHXCOlQoKtP/g5nyvTWbatK
         5FVw==
X-Gm-Message-State: AOAM5312rn1mDhHPpvS8gvBQHOA8jik4Z9V07qF3z3k9pF57kJhTJf6v
        oqcjnmy11UqWXMUs6JiIXLrIUwvGL6f4Sf8AudM=
X-Google-Smtp-Source: ABdhPJz/JVXDa02ZoZ2kiPQRp2ZZe5IUeM8s6L8vZ9zheuczc2xwm29qXgi4hpSYbEKf0yfQZpEGe/jna11fUntc6Lc=
X-Received: by 2002:a05:6512:3912:: with SMTP id a18mr11124489lfu.367.1628352044166;
 Sat, 07 Aug 2021 09:00:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAMMLpeR8C_gjZ0CE8-nEo7syt=t0MwMGVKw8BL0k_BTpsk2D5Q@mail.gmail.com>
 <CAPUEspik6iGd2X5tOCwvo+FNmcoipy1KGvfgNJd2KLu9-XS7Yw@mail.gmail.com>
 <CAMMLpeRDLxRfskKV0+S2CHTNVTnFgfO1K_sGQy_v6DXrA5JGcQ@mail.gmail.com> <CAHCo6sqi0WmxxKMU=Nx=z_3PDx84YmUOa+ACRcBbM=R_nr4nrg@mail.gmail.com>
In-Reply-To: <CAHCo6sqi0WmxxKMU=Nx=z_3PDx84YmUOa+ACRcBbM=R_nr4nrg@mail.gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Sat, 7 Aug 2021 10:00:32 -0600
Message-ID: <CAMMLpeQmbT-YmK3RrhPwe1bs8KNkEztony0QtbzoSbgNYjH3zA@mail.gmail.com>
Subject: Re: Problems with Git's Spanish translation
To:     =?UTF-8?Q?Christopher_D=C3=ADaz_Riveros?= 
        <christopher.diaz.riv@gmail.com>
Cc:     Carlo Arenas <carenas@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        git-l10n@googlegroups.com, Jiang Xin <worldhello.net@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 7, 2021 at 6:17 AM Christopher D=C3=ADaz Riveros
<christopher.diaz.riv@gmail.com> wrote:
>
> Just as an fyi, as Carlo mentioned, the window for updates is the moment =
when I make some time to review patches (not currently a full time develope=
r nor translator)...

Nor am I, but I have some time to work on this. Please let me help by
trusting that I'm not going to totally screw it up.

> Some come through PRs and others directly through email, and sometimes, a=
s Carlo mentioned I have over 5k lines to review in a single commit, so I h=
ave to pick some of the most important changes and apply them directly in a=
nother commit,

5,000 lines might seem like a lot, but I didn't even attempt to
harmonize the terminology in the translation. For example, the
translation still uses a mix of "t=C3=BA" and "usted" (although some work
was done previously to try to standardize on "t=C3=BA"), and many terms
like "amend" and "bundle" are sometimes translated and sometimes left
in English.

> and those PRs are the easy ones because there are others which have over =
100 commits from development branches not even related to localization...

You can reduce the displayed diff on GitHub in an instant by
fast-forwarding <https://github.com/ChrisADR/git-po> to
<https://github.com/git-l10n/git-po>.

> Sometimes the commiter adds extra changes trying to fix "Spanish correctn=
ess" according to their country... Which makes the diffs bigger and harder =
to read... And those same correctness changes are then "fixed" in another c=
ommit by another person...

In my opinion, the "generic" Spanish translation (which is the only
Spanish translation we have at the moment) should avoid using words
that can have different meanings in different countries. If I've made
changes that seem to just change from one dialect to another, this is
why. And if you want me to drop any of the changes, just note them on
GitHub and I will. Right now I'm just trying to fix things that are
not controversial.

> That being said, thanks for taking the time to review and propose changes=
, I'll try to review and pick the most important ones for this release cand=
idate :)

You're welcome!

-Alex
