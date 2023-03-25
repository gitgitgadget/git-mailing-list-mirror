Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F24C6FD1C
	for <git@archiver.kernel.org>; Sat, 25 Mar 2023 05:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjCYFV4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Mar 2023 01:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCYFVz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2023 01:21:55 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F5514EBB
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 22:21:53 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-17ec8963db8so3864528fac.8
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 22:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679721712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BcWf9T5sREJVt8GjV742/9YMcMnd+inlcKX+pt5b3Pk=;
        b=gpitr1CqJsOUdU+G3Rilyeyikji+dfD1aPGhfxp7pv1DbcrxeSBKeDmhWka01RVW4V
         aTnQr7wUT/Ek62r7Tb5/5bCkvY5lGYrGyP5563o4oF4/Mdc4Sn6/TRHQ5UWU4hTPFbxi
         XiQcUe08McBM0CwBRQSOssUxdcA0AetVsgY52ndFDOicHe72ntTZRosOO60E1F2Nq0Ah
         hXpydn1klhpuufTWD/+HYbRiLIa1v+sc5N4DLD3agr5OKaDw9G9Wav/UbE0U/4kByBN+
         IIcK1ZAX2/7YavKNaUzXVdrKkJHMmtjvts9nM/cXOAlzVxYZ3tLh4mcbtum1B9haErAj
         SzfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679721712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BcWf9T5sREJVt8GjV742/9YMcMnd+inlcKX+pt5b3Pk=;
        b=EiNJSzGn8RTTRaSlUz0KfNTHgnlGR4AZWQEeu72GXe1a6fWX8i6BqTk3nZaEmbYFMv
         sNAQ50jrEIm1GCvILH4Rkzr5fo2wII6X22fcsvFFMqajKBddgqXL2V+t9FYSWKdvR65Q
         1banZj0o3hlI6AgoHPNq4QSjrAwdycGHZ5+7JiiGs+OFZWtEYtWEGA0qqI+lFrViGOa1
         5tY2nziyNvPLgKgCVnXOO25lOYegCf3u337+19shNeVGy6Oh7AI6o2J8gErTJFFLPiPb
         m8LRkDuu/H51UiYQvJBtUHZcY8KR6uh25hDIcIupxqiSI8ZhLZEYJSZRKfMQZ876lJ1i
         u5tA==
X-Gm-Message-State: AO0yUKW2FVAKvIwCTcL2BvG7fzb6AuryWUFDKJ2cjpgyWB7MJKzgAKgS
        pwLR6oqbgIuMLsluokIP5vtleX3JXTNd/1IXpTM=
X-Google-Smtp-Source: AK7set9LBI2Umrs71fQYPgb+wTRjBwDLZDkJ9JQuwVROrgvNVgSoGapymRmHTP1crXLBsCX6O1gu5WdIRQO5KJcTjyM=
X-Received: by 2002:a05:6871:4983:b0:17e:e3b2:6d99 with SMTP id
 tx3-20020a056871498300b0017ee3b26d99mr1120311oab.9.1679721712197; Fri, 24 Mar
 2023 22:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230312210456.92364-1-alexhenrie24@gmail.com>
 <20230320055955.461138-1-alexhenrie24@gmail.com> <20230320055955.461138-4-alexhenrie24@gmail.com>
 <f062165f-2e59-67b5-ebff-b029c29dd4d6@dunelm.org.uk>
In-Reply-To: <f062165f-2e59-67b5-ebff-b029c29dd4d6@dunelm.org.uk>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Fri, 24 Mar 2023 23:21:15 -0600
Message-ID: <CAMMLpeR+_A6+agb4K9oYanqa1DHX3pDWnZSXjuw7Vubz3jdF+w@mail.gmail.com>
Subject: Re: [PATCH v8 3/3] rebase: add a config option for --rebase-merges
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, sorganov@gmail.com,
        chooglen@google.com, calvinwan@google.com,
        jonathantanmy@google.com, felipe.contreras@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 22, 2023 at 10:54=E2=80=AFAM Phillip Wood <phillip.wood123@gmai=
l.com> wrote:

> Hurray! Thanks for re-rolling.

Thanks for making sure that we got the UI right!

> On 20/03/2023 05:59, Alex Henrie wrote:

> > +     if (!strcmp(var, "rebase.rebasemerges")) {
> > +             opts->config_rebase_merges =3D git_parse_maybe_bool(value=
);
> > +             if (opts->config_rebase_merges < 0) {
> > +                     opts->config_rebase_merges =3D 1;
> > +                     parse_rebase_merges_value(opts, value);
> > +             } else
> > +                     opts->rebase_cousins =3D 0;
>
> The "else" clause should have braces because the "if" cause requires
> them (see Documentation/CodingGuidelines). I don't think it is worth
> re-rolling just for this though.

Thanks for pointing out that documentation. I'm going to make a v9
anyway, and I'll add the braces then. By the way, actions speak louder
than words: While writing the patch, I found several examples of the
braces being omitted in cases like this in other places in rebase.c,
so I assumed that that was the preferred style here. If you want to
encourage people to follow the CodingGuidelines document, the best way
would be to clean up the existing code to conform to it.

-Alex
