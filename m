Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E305BC433EF
	for <git@archiver.kernel.org>; Fri,  6 May 2022 19:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390468AbiEFTTJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 15:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390793AbiEFTTF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 15:19:05 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB968B4A
        for <git@vger.kernel.org>; Fri,  6 May 2022 12:15:20 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id e144so4018811vke.9
        for <git@vger.kernel.org>; Fri, 06 May 2022 12:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p3pHlOLe55fnX7HfEseIHYyvYz3a4ZBxk6zGXNOcBTk=;
        b=Y0sMqoXpdb8B6DUB44oMFbi9XmIrPDXu+/42NnjP0oL0yT7xQbYEwN34xYoeHPrI7h
         IL3ygThp4X+/JHtRfm75rRjZIp+uOyBe+wL9x4avQMyMaY3CqZHmrZ4iPY0mMzOJwgBE
         zcHRSe3IJSa4Rt/PFAWc083y6jzYyYu8fJWrnfSiiGcQNlrZO0/nvWJdmwnePSSiC923
         wyraz157ZocVT8AeABgyAXpccRRFHetcauMc4YZFZRPHxAYmx5fkYDqm179qYTyxVBYe
         HbH0An8dzzbUttqJspRJSMUcj9kTRsotTgM+l+XyTy/Q7RujAuzcK5wqpN9Ik3F4saZ2
         GoXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p3pHlOLe55fnX7HfEseIHYyvYz3a4ZBxk6zGXNOcBTk=;
        b=LWP5vvKSpwbvGMMl774GPeSeECDmx3KYHeD2mayUw9jAijPNRMJrmoQRZwnnAe0pZ3
         oReVsWKzXk+unI7LY9HdXhEO52TrcwEsorelEkTrEfUOzp8dhvgA5ZLFgS2BggGSUyOl
         7gI8zS08f6CSFUKiJAH8XppCIzT6yRlAGNBOG1iU6QOW4JwmiPMrdq1GpMnmtIq+w4IZ
         +JP8q3vdUrqlUEyTHeWjbzp+OAHo8E0sA8ztvlXxrnglrvoJ1M+30y1hsCyNp6fkMxWH
         LPwjgUtxNVAuntv4FnkwU7LMz/VsftfXAy9ZvEnSJW2ZI+tESe5/vQowh5p9L/hWEE2J
         0fMg==
X-Gm-Message-State: AOAM533MnsGAl1jpBYrBqMfcOFAvy55KTFqpBRRURASJ22/65HieZFrq
        NhUfC2qYwIL7tZXc4mScBYz1hcfvsvdni7ahgWQ=
X-Google-Smtp-Source: ABdhPJygEgU9Qser0Z9vD/IhRVweF4ThjbMFcymmPh+auxTGhwfko3RFT0DB1LLmtpa/bQOXGAbe0mF0wXVGeiY1HXE=
X-Received: by 2002:a05:6122:d09:b0:351:f87b:b27a with SMTP id
 az9-20020a0561220d0900b00351f87bb27amr1708090vkb.23.1651864520070; Fri, 06
 May 2022 12:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220428105852.94449-1-carenas@gmail.com> <20220503065442.95699-1-carenas@gmail.com>
 <20220503065442.95699-3-carenas@gmail.com> <nycvar.QRO.7.76.6.2205051545370.355@tvgsbejvaqbjf.bet>
 <c9fc0fc6-c688-022d-9476-aaa87c66d295@gmail.com>
In-Reply-To: <c9fc0fc6-c688-022d-9476-aaa87c66d295@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 6 May 2022 12:15:06 -0700
Message-ID: <CAPUEspiMsvNhQF-RjW5eu3Xco9gU7TFt4w9dOOcF1PGM4Z+ceQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] git-compat-util: avoid failing dir ownership
 checks if running privileged
To:     phillip.wood@dunelm.org.uk
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, gitster@pobox.com, bagasdotme@gmail.com,
        Guy Maurel <guy.j@maurel.de>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 5, 2022 at 7:32 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> On 05/05/2022 15:01, Johannes Schindelin wrote:
> > [...]
> >> +
> >> +/*
> >> + * this helper function overrides a ROOT_UID with the one provided by
> >> + * an environment variable, do not use unless the original user is
> >> + * root
> >> + */
> >> +static inline void extract_id_from_env(const char *env, uid_t *id)
> >> +{
> >> +    const char *real_uid = getenv(env);
> >> +
> >> +    /* discard any empty values */
> >> +    if (real_uid && *real_uid) {
> >> +            char *endptr;
> >> +            unsigned long env_id;
> >> +            int saved_errno = errno;
> >> +
> >> +            errno = 0;
> >> +            env_id = strtoul(real_uid, &endptr, 10);
> >> +            if (!errno && !*endptr && env_id <= (uid_t)-1)
> >
> > We should not look at `errno` here unless the return value of `strtoul()`
> > indicates that there might have been an error (i.e. when it is
> > `ULONG_MAX`). >
> > Likewise, we need to either initialize `endptr` or only look at it when
> > `strtoul()` succeeded.
>
> I don't think we need to do either of those, and indeed the function you
> suggest below does not do them. The standard guarantees that endptr is
> always set and there is no harm in unconditionally checking errno.

I think the point dscho was trying to make is that while you are
correct that the standard guarantees those two things and
implementation might decide to not do them, we obviously support
systems that are not POSIX.

The irony is that my first confusing attempt to implement this did
that before by explicitly ignoring errno and instead relying in the
"expected overflow/underflow" values to detect the cases we care for
(which is valid UID numbers that are most likely to be uint32_t) and
which was the same thing we got from my original (but hated) atoi.

> > We could side-step all of this, of course, if we simply did this:
> >
> >       euid = getuid();
> >       if (euid == ROOT_UID)
> >               euid = git_env_ulong("SUDO_UID", euid);
>
> That's a nice suggestion, I didn't know that function existed. It means
> we would die() if we could not parse SUDO_UID which I think is
> reasonable (we'd also accept a units suffix an the uid)

which is also why we can't use it, any possibly bogus or suspicious
value we get from SUDO_UID MUST be ignored.

Carlo
