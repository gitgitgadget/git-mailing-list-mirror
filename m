Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2171FC433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 09:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbiCIJ6t (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 04:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbiCIJ6s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 04:58:48 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EA43C73D
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 01:57:49 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id b8so1851503pjb.4
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 01:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=coup.net.nz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DxZ0DKgnl1j/ESzDWzhAfdGetmmgwHD70xVZJ0L6FCI=;
        b=Pcs23x7HkWCFt5YrBwIK7rBt5WrBgsLFEBl6X2naG8oD/ozFcrjA8CKaVh62PbbCaZ
         E6MfADeGwcf1Rej32UxLkPv0lyshx9pxa5Agv4dxtIVqhWYDYfrNxB+K/UtXQvwcPgpB
         3PEJld5bfX3BcdJzXngJ36w5vyT4XNeHFFDPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DxZ0DKgnl1j/ESzDWzhAfdGetmmgwHD70xVZJ0L6FCI=;
        b=Le0D8gfezXG5tV8nnHMXP4jR65F+AD1BQuTsi3plFuAb1wvIZWg6MoZhn/U36CoWkJ
         l+bNEvauaUQp2JZZQoVLHtc5vSfRP97tXPOfVDnECgrDDuqIsks55i5DyWwfrs+SZATN
         /Ql5KbP1KuG+y6UI6JVJmzN9rVpo8Ofk39+ojIMy+EySfYpYZKCpz3Vlh/To3D+oN0z3
         wEHOhenpSDCu1U3g5A8IBkjW3414nH6d1wxKvLFcT5FmM9q0F3IosdH3Q59wYaEgKpVs
         +QzoTtFOOseETKWvJETJq2m+zhQH910VWSpRJ5D3c1Ysj+OhQj6vYgvc2umdeQ8yHhuk
         NLsA==
X-Gm-Message-State: AOAM530Ef0loSvpPyw1L74gNJ8sbIZQ1MIhVyXw41i82LHw4qchDeM78
        bXNFpqU2K59LNP6cns3ZeE9cSb0DbxBj1GI/ojrU19cAivjNrQ==
X-Google-Smtp-Source: ABdhPJyEUQ2NXOlEWRm/GDMVFbgmIciF+gix5y3Jzz5tFMTwBKhnBGFvH+bZGJJxFPRhWxxE4/KhegkocSDDIpzUI48=
X-Received: by 2002:a17:902:f68f:b0:151:fbf5:db45 with SMTP id
 l15-20020a170902f68f00b00151fbf5db45mr9117219plg.60.1646819868511; Wed, 09
 Mar 2022 01:57:48 -0800 (PST)
MIME-Version: 1.0
References: <pull.1138.v3.git.1646406274.gitgitgadget@gmail.com> <20220309002729.3581315-1-calvinwan@google.com>
In-Reply-To: <20220309002729.3581315-1-calvinwan@google.com>
From:   Robert Coup <robert@coup.net.nz>
Date:   Wed, 9 Mar 2022 09:57:37 +0000
Message-ID: <CACf-nVeEBDQse0coA7QpQmQ92y9kDwXoTmayD8_NY2OHNZ5v+g@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] fetch: add repair: full refetch without
 negotiation (was: "refiltering")
To:     Calvin Wan <calvinwan@google.com>
Cc:     Robert Coup via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Calvin,

On Wed, 9 Mar 2022 at 00:27, Calvin Wan <calvinwan@google.com> wrote:
>
> This is my first time sending a review to the list, so forgive me for any
> mistakes I make or conventions missed. Feedback about my review would be =
well
> appreciated!

I'm as new as you to contributing to Git :-)

> Overall I think your patch is well written and the implementation accompl=
ishes
> what you describe in your cover letter,

Thanks! I think if you're completely content you can add your
Reviewed-By as described at
https://git-scm.com/docs/SubmittingPatches#commit-trailers

> I would like to discuss another
> possible design I thought of. Currently, the user has to know to run =E2=
=80=98--refetch=E2=80=99
> after changing the partial clone filter configuration in order to fetch t=
he
> commits that match the new filter. Ideally I believe this behavior should=
 be
> default so therefore instead of adding an option, if git knew what filter=
 was
> last used in the fetch, it could automatically =E2=80=98refetch=E2=80=99 =
everything if there is
> a change between the last used filter and the default filter.

So, if you do a partial clone using `git clone --filter=3D...` then the
filter is saved into the config at `remote.<name>.partialclonefilter`
and is re-used by default for subsequent fetches from that remote. But
there's nothing to stop `git fetch --filter=3D...` being run multiple
times with different filters to carefully setup a repository for a
particular use case, or any notion that there has to be "one" filter
in place for a remote.

Running `git fetch --filter=3D...` doesn't update the remote's partial
clone filter in the config, and IMO it shouldn't for the above reason.

I think having `git config remote.<name>.partialclonefilter
<new-filter>` print out something to the user along the lines of "Your
change to/removal of the filter won't fetch in additional objects
associated with existing commits, you can do this with `fetch
--refetch <remote>`" could be helpful, but after a very quick look I
can't see  anything like that at the moment for other config settings
(ie. no plumbing in place to easily reuse), and I'm not motivated to
add such plumbing.

Cheers,

Rob :)
