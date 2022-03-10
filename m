Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000A3C433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 01:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239084AbiCJBIl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 20:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiCJBIj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 20:08:39 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10063A199
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 17:07:39 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id k25-20020a056830151900b005b25d8588dbso3030147otp.4
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 17:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ak2LMAHGvkhm7CMqwCe2sqaF6XhIBdOazlECivtW/w=;
        b=CVsciXu2NWWHKNcIC1GWinolmp6BzL1IJ0DJcQic6S+M2TejsIgvf/xdvC8A4LAWft
         fAtyn8vFkbi+4+lJWVEBhmOsnJmvFv2Ypu9KlB4xTJ3U0c4qsBhoz6PNb0J93seWmX9K
         jsIHSYU2q411HJ8MHk0pVromsY9GpWRMc+aQWxvA0OHtvVvI5i0A8oD74mQvj8oTYktE
         iBBOgYeo7gfxLIroPDiMFd3BNmlj0RyNElgxrkoMFaIq+UmfgQeN6M6PKGVA62acd4zb
         pC2sZR1Q75+GteetpJgtWyAW0Z95xqBRK3vI0UlOD78MD/mEOV/6ddbsvgiOYtrpW/Jr
         ceAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ak2LMAHGvkhm7CMqwCe2sqaF6XhIBdOazlECivtW/w=;
        b=tLoaNe7YFcrLxVUxts+hKHXQG4ATc0EjqzcxA/ZS05+Iykx+jGzOdcDKrXvh+gkLEs
         FBXMB82VAy6MTBI1pWXnY4FgRnUzYrb93lhIdLImumdfrwKG7xWAG6Lt3JDP3NBaKOwD
         XsN/7Fc2lXgLqRQ4atLft2j1kUpyQcEsCakpyxrHFYk3OAwXODvT9uIB9TGtCE+CX4nI
         7Vvl0uGCrk2CoRQ819PaGukpuAEgpTgznv/vm1s2s4ZxCRp5G8NIuWTqu3pS7BRCaz46
         S6lM/3CRfv/1o9WdMIZiqbsyBBWKexhqc7gOGbNswVqex7wm+IMQFuUme3BTugO7p+YX
         joVg==
X-Gm-Message-State: AOAM5319wJqfr+Es7BTL12DPi22iL6jk6NjhzQApZ0wkVtcY0wDhbtsl
        zMdH6yeZlRxBokAl1241YqmdSOsvn/U+eHwma66IeA==
X-Google-Smtp-Source: ABdhPJxzwOR5TgQqVAza7ibALGeEO0U+eTMbGZCOw4fhQIDiYlNfXGKNS0fr+IZtBbibRxb3KA4GENe5M3h4nke0w9I=
X-Received: by 2002:a05:6830:1283:b0:5b2:71c0:9719 with SMTP id
 z3-20020a056830128300b005b271c09719mr1399856otp.42.1646874458199; Wed, 09 Mar
 2022 17:07:38 -0800 (PST)
MIME-Version: 1.0
References: <pull.1138.v3.git.1646406274.gitgitgadget@gmail.com>
 <20220309002729.3581315-1-calvinwan@google.com> <CACf-nVeEBDQse0coA7QpQmQ92y9kDwXoTmayD8_NY2OHNZ5v+g@mail.gmail.com>
 <xmqqzglylslh.fsf@gitster.g>
In-Reply-To: <xmqqzglylslh.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Wed, 9 Mar 2022 17:07:27 -0800
Message-ID: <CAFySSZCMq+6_8p-UVu_dzgcNSv3zqCN76WjD4XWKWB9TQ0y40g@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] fetch: add repair: full refetch without negotiation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Robert Coup <robert@coup.net.nz>,
        Robert Coup via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/9/2022 1:32 PM, Junio C Hamano wrote:

 > - we must maintain the "filter that is consistent with the contents
 >   of this repository", which this series does not do, but we should.

If this is possible/reasonably implementable then...

 > - the "--refetch" is unnecessary and redundant, as long as such a
 >  record is maintained; when a filter settings changes, we should
 >  do the equivalent of "--refetch" automatically.

... this is the logical conclusion that can be drawn.

> isn't "git fetch --filter" that does not update the configured
> filter (and does not do a refetch automatically) a bug that made the
> "refetch" necessary in the first place?

There are two cases to be considered here:
1. The user changes the filter config using "git config"
2. The user runs "git fetch --filter"

The first case is the use case advocated by Robert for "--refetch".
I originally suggested saving the last used filter into the config
and if the last used filter != the configured filter, then fetch
automatically "refetches" everything.

The second use case is the one Junio believes I am referring to,
however, whether to classify this as a bug or feature, I am
uncertain. Like above, I suggested saving this as the last used
filter to be used as a comparison to the configured filter.
Setting this filter as the configured filter can be a separate
discussion to be had because I can see pros/cons for it.

Ultimately the expectation is that if I run "git fetch" without --filter,
then I will fetch based on the config filter. And if I have previously
run "git fetch" with the same filter, whether through the config or
my own filter, then Git will only fetch the latest refs/objects.



On Wed, Mar 9, 2022 at 1:32 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Robert Coup <robert@coup.net.nz> writes:
>
> > So, if you do a partial clone using `git clone --filter=...` then the
> > filter is saved into the config at `remote.<name>.partialclonefilter`
> > and is re-used by default for subsequent fetches from that remote. But
> > there's nothing to stop `git fetch --filter=...` being run multiple
> > times with different filters to carefully setup a repository for a
> > particular use case, or any notion that there has to be "one" filter
> > in place for a remote.
>
> The way I read Calvin's suggestion was that you won't allow such a
> random series of "git fetch"es without updating the "this is the
> filter that is consistent with the contents of this repository"
> record, which will lead to inconsistencies.  I.e.
>
>  - we must maintain the "filter that is consistent with the contents
>    of this repository", which this series does not do, but we should.
>
>  - the "--refetch" is unnecessary and redundant, as long as such a
>    record is maintained; when a filter settings changes, we should
>    do the equivalent of "--refetch" automatically.
>
> IOW, ...
>
> > Running `git fetch --filter=...` doesn't update the remote's partial
> > clone filter in the config, and IMO it shouldn't for the above reason.
>
> ... isn't "git fetch --fitler" that does not update the configured
> filter (and does not do a refetch automatically) a bug that made the
> "refetch" necessary in the first place?
>
> Or perhaps I read Calvin incorrectly?
