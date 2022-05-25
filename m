Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8178C433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 03:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242739AbiEYDsI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 23:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235282AbiEYDsH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 23:48:07 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0846D97A
        for <git@vger.kernel.org>; Tue, 24 May 2022 20:48:00 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id q21so18923363ejm.1
        for <git@vger.kernel.org>; Tue, 24 May 2022 20:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M/Ca29YhbeABDwLQKj5WpQbNG6+rc+fKAXAJf3QK4x8=;
        b=n3fx5itiidVdZByhs/EgmzNb6Cp2S+pHoMxNKQJID+g1xclnnSU/CdXPUHl2KIiMC+
         YaOvI79jvN19OMnMu8pipOIL75VKz+B5Ob2QlAPCKpcQcgb+ygB7649dj0gk1hWh4zLh
         jtJF+thWVpzlxRVFQPy5b83/JJPYXzFS0n4ULRp27xHmRD6EiQbOfjlaurDjhzQR8IhL
         PPpKg2h3PnTZ7TEeutlvEYgNyfDnU0Qkyxt9zmhWXEkFT7iitLA/+o/lCdqgW7pKwNQZ
         TACt56xMHuaIKLQZNSD/d0hXGru279DX72bQRE8pS6ukuQXJUs9B5k0WIOqh39rP7Ws2
         rygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M/Ca29YhbeABDwLQKj5WpQbNG6+rc+fKAXAJf3QK4x8=;
        b=vdYgyivZvYfImJsYSVOtjagMGVkwvACMyrawDQkLCtOPdVL45kyyfXeXw97QSd5SzM
         yr+/K9tBHleuBtvHbYG/S+DDtHJCWGh0Vt3XjqPmkTKtvmEavSoYg6yd/kAPba3l0tNP
         tuOi90ukkHcNGSNEeP9W4NNphrV0Od9c2mVuYzW6jPvJRwT7lcDdTye78ksVLnPErB3Z
         30sAllMj0rJfd4fJeco52gyw9LYuwjfra0ejVsYJd9C6lxjOBKL0UNTiTDXEcOAsf0fR
         Cx2NpGX8CmtJlMK17x+srW67z8+3ESPefsMJ1DjLImwnJbfIVzjz41MXfnUolRg/AM+T
         ZiCQ==
X-Gm-Message-State: AOAM531n/tDNzbbyhVDxqiv1/p7Sm/apcO+V2B1KJ2vep8BNO3rl+b6/
        zpjOVAbtJsbZbXJ+ijMYgJ6MAU1tP3qqNArwCow=
X-Google-Smtp-Source: ABdhPJxj3NDYOkYi/cl62lhUho5aNd/7VSi4h5RvVWJ/uFG0iIo8hCp3HzF7oUorGOqupjpDVuOJLu9oiBP3KtD2K+4=
X-Received: by 2002:a17:906:5783:b0:6fe:a263:f648 with SMTP id
 k3-20020a170906578300b006fea263f648mr22622605ejq.493.1653450479115; Tue, 24
 May 2022 20:47:59 -0700 (PDT)
MIME-Version: 1.0
References: <80eeba2b2a58af2a5497f398beb5c03447c41f61.1653003552.git.kevin@kevinlocke.name>
 <7c064f43ed426c9e3b54e1ae5313d6b9332a47cb.1653141169.git.kevin@kevinlocke.name>
 <1580ad10-43f6-bc73-901a-b65b1aea73ff@github.com> <YozlZ9DPrRLPBTBP@kevinlocke.name>
 <CABPp-BGZTDKorz+CFScfTfx47c+TuJaAD_Zyyo1Jj_tymYkVXQ@mail.gmail.com> <563606bd-551f-39b2-74f0-40547b7a0113@github.com>
In-Reply-To: <563606bd-551f-39b2-74f0-40547b7a0113@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 24 May 2022 20:47:47 -0700
Message-ID: <CABPp-BHCC2WkSTpnucZRSriYbhXyGQCGKKKuOFbLU-Odf_2UtA@mail.gmail.com>
Subject: Re: [PATCH v2] setup: don't die if realpath(3) fails on getcwd(3)
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Kevin Locke <kevin@kevinlocke.name>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 24, 2022 at 10:38 AM Derrick Stolee
<derrickstolee@github.com> wrote:
>
> On 5/24/2022 11:20 AM, Elijah Newren wrote:
> > On Tue, May 24, 2022 at 7:02 AM Kevin Locke <kevin@kevinlocke.name> wrote:
> >>
> >> On Mon, 2022-05-23 at 14:57 -0400, Derrick Stolee wrote:
> >>> On 5/21/22 9:53 AM, Kevin Locke wrote:
> >>>> +           free((char*)tmp_original_cwd);
> >>>
> >>> Hm. I'm never a fan of this casting, but it existed before. It's
> >>> because tmp_original_cwd is exposed globally in cache.h, which
> >>> is _really widely_. However, there are only two uses: setup.c,
> >>> which defines it, and common-main.c, which initializes it during
> >>> process startup.
> ...>> This approach seems reasonable to me, as does casting to free().  It's
> >> not clear to me which is preferable in this case.  How to balance the
> >> trade-offs between exposing const interfaces, limiting (internal)
> >> interfaces to headers, and avoiding casts might be worth discussing
> >> and documenting a matter of project coding style.  `grep -rF 'free(('`
> >> lists about 100 casts to free, suggesting the discussion may be
> >> worthwhile.  Introducing a free_const() macro could be another option
> >> to consider.
> >
> > I'd prefer either a free_const() as you suggest (though as a separate
> > patch from what you are submitting here), or leaving the code as-is.
> > free() could have been written to take a const void* instead of just
> > void*, since it's not going to modify what the pointer points at.  The
> > reason we call free() is because the variable isn't needed anymore,
> > and using a non-const value after freeing is just as wrong as using a
> > const one after freeing, so casting away the constness cannot really
> > cause any new problems.  So, I think the signature of free() is just
> > wrong: it should have taken a const void* all along.  Unfortunately,
> > the wrong type signature sadly makes people feel like they have to
> > choose between (a) dropping the added safety of const that the
> > compiler can enforce for you during the lifetime of the variable, or
> > (b) leaking memory you no longer need.  I think it's a bad choice and
> > you should just typecast when free'ing, but clearly others just don't
> > want to see any typecasts and are willing to dispense with const on
> > constant variables.
>
> I mostly agree with you: if free() didn't have the const, then the
> answer would be simple. We probably wouldn't also have the convention
> of "const pointers are for memory we don't own".
>
> Specifically with 'const char *' this can sometimes point to a
> compiled string literal, so I tend to be more careful than usual
> around these kinds of casts.

Ah, fair enough.


> I'm willing to concede this point as it is much messier than just
> the goals of this patch.

:-)
