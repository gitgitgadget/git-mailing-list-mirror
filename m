Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB5DC433EF
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 17:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244087AbiAXRMc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241310AbiAXRM2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 12:12:28 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3064DC06173D
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 09:12:28 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id n10so42177778edv.2
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 09:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rEOxaEO/6XAc6kBNInPSRoUYKR88qoQk5oY7Wxv8vp8=;
        b=YFi5Djtmcqydxnu3id9HHkbvuoUw7NPNkxrHOGS32IP+ES6BjmcFDrBhGdtjQ/nF0K
         xuCMi7urVJETor3kfRFbYtVB1895+gRE9Xg9j5p0DZvDBecQwdu5Y1wNWIfErdNGB9Bm
         dyFPa69aunWFVY+f/ubAy2zriDpgn97kUkYxCuCDiWx9mc0Q5DIp2dWC4FvVGwTcBg1i
         fJwsqS3uRo4KIcZVlOKsFf7c86BXKMZI1YyuEvKVB+Ef5bCj1c8MjdKamG9w3bsXXhjO
         nHoePxIZ0iVq28eqIkJdU5T6H8bErVCQhhJRaZtJ/09wgJhK42oEYAcSUHBIot8TKq2s
         4CBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rEOxaEO/6XAc6kBNInPSRoUYKR88qoQk5oY7Wxv8vp8=;
        b=NUES0wB76c+xASGNuasz72qlQNp/DIVQkJaGceHBdi43eXjPF+fnsaJq0cPwBMOdz8
         JtK1ohR7ejBqL7WgtsuQeJ65t5iCaLtx/e3rf8qh3H3sY3PxThBYemcfY+63+zm1f1US
         sVo1/OgbRHHvQoXPxAOtH0P2agQQ1rbnywkDfT2t8Pt2wcpTLlHf+bjr+CYGjsOP5EMl
         YRGBQBVzL1z0MgMXFhqCTa1NTkuvml8C62x0AhsEnXaxMU8oQMncbOjGcNCsVr/sYU92
         TjwqILp71YyvmRHBRkN/Jl/sAP+VaLqXLzVAyddEYyvzJUyGjOZA2BlL3ZbijNloM0vs
         7AlA==
X-Gm-Message-State: AOAM532OWEGWQHTwKrjXGH/PD0YHU6ICVzEWTG2EBWeJ5PSq9XDGZK1n
        GdclKZvFbpWuqq8GvwOsoHIbf3Bc3xxFggZiHi0=
X-Google-Smtp-Source: ABdhPJyZdf+5GlpxWnAZ9bqKV6YahhutkI5YHJZGduh6Kwoe09ND13apEHkLHBB1eT0+q4xb76OnQA5e3wEKsfSkUrI=
X-Received: by 2002:a05:6402:26cc:: with SMTP id x12mr6972120edd.153.1643044346575;
 Mon, 24 Jan 2022 09:12:26 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
 <05bd17686e1404c81542b6bbf69dcd3decb83c5b.1642888562.git.gitgitgadget@gmail.com>
 <220124.86h79tihjm.gmgdl@evledraar.gmail.com>
In-Reply-To: <220124.86h79tihjm.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 24 Jan 2022 09:12:15 -0800
Message-ID: <CABPp-BE+4rZNP-5mT2MNOWR6y6BgEG6mt1r_qcrZtarom6aGsw@mail.gmail.com>
Subject: Re: [PATCH 04/12] merge-tree: implement real merges
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 24, 2022 at 1:55 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Sat, Jan 22 2022, Elijah Newren via GitGitGadget wrote:
>
> > +     /*
> > +      * TODO: Support subtree and other -X options?
> > +     if (use_strategies_nr =3D=3D 1 &&
> > +         !strcmp(use_strategies[0]->name, "subtree"))
> > +             opt.subtree_shift =3D "";
> > +     for (x =3D 0; x < xopts_nr; x++)
> > +             if (parse_merge_opt(&opt, xopts[x]))
>
> Better omitted WIP code in a non-RFC series?

It's RFC: https://lore.kernel.org/git/pull.1122.git.1642888562.gitgitgadget=
@gmail.com/

But yeah, I should drop it.  Previous rounds of this RFC submission
got me feedback that the other commented-out code bit I used to have
was something folks wanted in the initial version of the series so I
uncommented and cleaned it up.  The fact that no one has commented on
this part suggests these options don't need to be supported from the
start.

> > +                     die(_("Unknown strategy option: -X%s"), xopts[x])=
;
>
> As a general issue with this series, die(), BUG() etc. messages should
> start with a non-capital letter.

Right, thanks for the reminder.  I'll go through and try to fix up.

> > +     printf("%s\n", oid_to_hex(&result.tree->object.oid));
>
> And for both this...
>
> > +             printf(_("Conflicts!\n"));
>
> ... and this we can just use puts(). For the former it's just less code,
> but for the latter translators also don't need to see the always-there
> \n in the translated message.

Makes sense.

> > +# This test is ort-specific
> > +test "${GIT_TEST_MERGE_ALGORITHM:-ort}" =3D ort || {
>
> Is this ${} trickery really needed? We're not testing with "set -u". So j=
ust:
>
>         if test "$GIT_..." !=3D "ort"
>         then
>                 ...
>         fi

Ah, that would be simpler; thanks.

> > +test_expect_success 'Barf on too many arguments' '
> > +     test_expect_code 129 git merge-tree --write-tree side1 side2 side=
3 2>expect &&
> > +
> > +     grep "^usage: git merge-tree" expect
> > +'
>
> Nit: In most other tests these usage assertions are at the top of the
> test, and for those we also make do with just testing the 129 exit code,
> which is probably enough here too...

I see a fair number of counterexamples searching for 129 in the test
suite, and I've been bitten enough times seeing tests expect an error
but get a different kind of error than the commit message stated they
were expecting that I prefer the extra check beyond the error code.
Anyway, I'll leave this piece as-is.
