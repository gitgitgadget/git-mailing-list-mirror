Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE08C433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 19:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392097AbiDUTyj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 15:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241640AbiDUTyi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 15:54:38 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80E34BB8D
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 12:51:47 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r13so12149156ejd.5
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 12:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=TwZlFLaf3xZIP+n/bogFq+ewUaOFoO8P9sXsgCSdWLc=;
        b=GJxDA7OASC5hql1Mp8SJnLl549Z3JgF3E0hn1r/tlmRReL4uRHz3sCxkndn2zhGB2v
         KstwoTr0RHUk21Ik/euQrsinKUEWd7sUVv+aUbB6dxJML8SbQ3iyyN073dSoHj9+4r25
         iojOFFh0NoLgXBHbDBfRFb98y6DoTNMNcNf7f0J2b3XhsUkmJ7o0skZg/bvZ6C/pCJh5
         6fCzovcUFpo6midQeA971Sj+P/vySxnbM3rhWeI3t0WeB3J/vWJtntOjaqarpa9HEWVy
         4YrSFj8OWGKC8FZ09D07GgYPTQGu9fBzCgOss32X5/y5gdb3EikbW48+lmkT7hKemz/k
         Sqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=TwZlFLaf3xZIP+n/bogFq+ewUaOFoO8P9sXsgCSdWLc=;
        b=hrAp/dlkXU4ML5koVCKzFzP1SEIVqNHoYwIWr0qw+otLpH6NUSA0+IbCLNB1X26chc
         CVGgdk93YB1oiZ0kx26TixaBdjC5uDVA1PKnM8gMQRT1YbIKAE9KBC1tGVti2CKSItAL
         z1ARsHqxd3Q8yS0blfy8kRr62Lg8zLgAJH5CRJoTcZGs+GNWlNJGEAc13/pG4fSLyuu9
         NNrXp+zbC/9EPcA6y8QiOHmhRX92JH3MZbKFcflsMnET4lJqGVa3VudhUwCElRb3SM4q
         gCA0foOuKf/rQagQn6E/9JZU5F2GU+P8SlH0Fnph8MlbMCnx/AYDKUi6ktNH64keXbU2
         WRhw==
X-Gm-Message-State: AOAM533CwJS9Bw0OJznq93jMaEjkJirZrJ7TaQV9F137vIOffE9FoUQH
        gH8hGCfMUdA+/ZLv7+Upfh4=
X-Google-Smtp-Source: ABdhPJy6/dcBqW/XEij+ybBgnNmL9c4h6f0Y0T3aTmxKRLpkBlEBWiLLWqAYZq0m1LHLW+8xlb1/NQ==
X-Received: by 2002:a17:906:99c1:b0:6db:f0cf:e38c with SMTP id s1-20020a17090699c100b006dbf0cfe38cmr988768ejn.692.1650570706357;
        Thu, 21 Apr 2022 12:51:46 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p17-20020a17090635d100b006efcc06218dsm10787ejb.18.2022.04.21.12.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 12:51:45 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nhcq9-008BAg-49;
        Thu, 21 Apr 2022 21:51:45 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 30/31] CI: have osx-gcc use gcc, not clang
Date:   Thu, 21 Apr 2022 21:24:12 +0200
References: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
        <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
        <patch-v4-30.31-94abb826627-20220418T132809Z-avarab@gmail.com>
        <55271bbe-7b6e-7c92-7337-2439a2f5be26@talktalk.net>
        <xmqqh76orx3v.fsf@gitster.g>
        <52382f7c-5b6a-63b6-2eb2-26c12f31f529@gmail.com>
        <xmqqr15rpp9b.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqr15rpp9b.fsf@gitster.g>
Message-ID: <220421.8635i66wq6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 20 2022, Junio C Hamano wrote:

> Phillip Wood <phillip.wood123@gmail.com> writes:
>
>> ... There is a complication though in that Dscho's series
>> adds github markup to the build output and this series separates the
>> build from the tests which means that is not necessary. I think it
>> should be easy enough to change Dscho's series so it only uses github
>> markup for the tests which is the main improvement and just wait for
>> the build and tests to be separated in this series (ideally they'd be
>> a short easy to review series that did just that).
>
> OK, Dscho, =C3=86var, does that sound like a workable plan?  See a reroll
> of Dscho's series (which Phillip considers "should be easy enough")
> first, get it solid enough and merge down to 'next', and then see
> the refactoring by =C3=86var on top, hopefully with a minumum churn that
> makes it impossible for people to review?

First. I see you re-queued a the v2 of Johannes's patches. I had some
outstanding fixes for my series [2] + the derived version of his on top
[3] which I thought I'd submit regardless.

To reply a bit to the thread at large, quoting Phillip:

On Wed, Apr 20 2022, Phillip Wood wrote:

> It would certainly be nice to get Dscho's updates merged sooner rather
> than later as I think they represent a more significant improvement
> for CI users. There is a complication though in that Dscho's series
> adds github markup to the build output and this series separates the
> build from the tests which means that is not necessary. I think it
> should be easy enough to change Dscho's series so it only uses github
> markup for the tests which is the main improvement and just wait for
> the build and tests to be separated in this series (ideally they'd be
> a short easy to review series that did just that).

Phillip: I'd be very happy to see a version of my [2] rebased on [2] (or
[3]), rather than the other way around. I'm fairly sure that if you
attempt to do so you won't find it to be all that easy.

If you do and come up with some version which Johannes is OK with I'd be
very happy with it. Without that I don't see how I wouldn't be in the
same rut of wanting to improve other parts of the CI and that being
brought up as a perceived blocker, without a suggested way forward (per
[4]).

But as to a way forward. Even though my series is larger I still think a
much better way forward is to do it first.

There's been some bugs here & there (all of which I believe are
resolved), but I don't think anyone's spotted anything that's
fundamentally wrong with that needs to be addressed in some open-ended
way.

Whereas Johannes's v2 changes some UX things arguably for the better,
but also introduces severe performance regressions in the UX. See [5]
and [6]. I was routinely seeing e.g. ~5s loading times go to ~20s.

Now, I'm not sure (I haven't re-done the measurements), but I have a
hunch that basing it on top of my series made it much better.

That's because in Johannes's the GitHub folding JS needs to fold the
equivalent of make+make test+his GitHub markup. If it's based my series
the the "make" steps are in their own "step", which it looks as though
the GitHub UX needs to do less work to fold/unfold.

1. https://lore.kernel.org/git/pull.1117.v2.git.1646130289.gitgitgadget@gma=
il.com/
2. https://lore.kernel.org/git/cover-v5-00.29-00000000000-20220421T181526Z-=
avarab@gmail.com/
3. https://lore.kernel.org/git/RFC-cover-v5-00.10-00000000000-20220421T1830=
01Z-avarab@gmail.com/
4. https://lore.kernel.org/git/220421.86fsm66zmz.gmgdl@evledraar.gmail.com/
5. https://lore.kernel.org/git/220220.86bkz1d7hm.gmgdl@evledraar.gmail.com/
6. https://lore.kernel.org/git/220222.86tucr6kz5.gmgdl@evledraar.gmail.com/
