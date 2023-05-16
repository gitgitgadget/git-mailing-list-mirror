Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1B6C7EE25
	for <git@archiver.kernel.org>; Tue, 16 May 2023 04:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjEPEZv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 00:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjEPEZr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 00:25:47 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D7249E3
        for <git@vger.kernel.org>; Mon, 15 May 2023 21:25:41 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2ac770a99e2so144892191fa.3
        for <git@vger.kernel.org>; Mon, 15 May 2023 21:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684211140; x=1686803140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uc3WQ5vOZhr7XfnoAQC4/8GVCoEzcojjc/1FaCwN9cw=;
        b=pUmG4KF6MoISTkhj2TggIXeTHo3+TQCodmK7Cvpwy1VAPzh2s6TpjhvCHSvuAuyK4F
         L3bUWGYkeoMHjjWZYT/tAQyxv8cSO/qZkz2+mRuAC2D7nkUghenBjyUvkeU9fZLp7LS/
         yWtpGjjrC9hAOZri3SD2gHxK2MJyaNstXEoCG3YKNY2tMpCwnDaibl8dX2iERK1j3vGe
         db/HK48wCQol16ZhmvUhIlTXb49T8Zcjci/ve1CLwjyGlTQzkbQ+db8X9u8wNX/UfjGW
         p04XwsZtKT+g81wbtcVhuGDDEqavDxtLzgq8l4uVqEL2g7FNSXysbsrQjMZCFz5rMJjX
         tZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684211140; x=1686803140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uc3WQ5vOZhr7XfnoAQC4/8GVCoEzcojjc/1FaCwN9cw=;
        b=kGKV9dNhzmcViVdH2SC6Q27BJZOEUPPU+fZPo0yUtcihCGQz27Wsp6HP3I6s9+gK1E
         sBaS/0ZU3JC1NtK2MB0wUl7G+5XrcytcQ4eevZ3HmWgnSvzlZ4KhxlHFiAP65kN/oKuT
         GBLy1ZAwscq7yP1GpgbPZPOnpwPITXN9YCyBsRUbkToHPT4y57KlVy17xPoyGlOUAmN7
         SxGjUSwJA1vQ13iNZl3/UG5NWSusw3yqIWKIg5zXfw09a6FO6gcocDLsIwTHwRkZRgQK
         Y01KS2lZLpE6TMJorF6bZUem6CEjr9NRQ9zRusrdVpyLaI8gtTG3BGXVF+RUSbDDKeLU
         bNyg==
X-Gm-Message-State: AC+VfDwphKdhlk7KNo6Bik7LFJLHtqo7dx1xyGC5RCBcGK2PeR/ULUdN
        egmScflj9uxG1N41ksaxzldqHIBnOL6sqn0W/KA=
X-Google-Smtp-Source: ACHHUZ4FvVFKswlBo96Cm4xINs6Dei5nHKQUucce5v9+MEGurEG/vKUWtDU7dnKmCjtU2VdIDk+J7NjEZ7ySXva1d/Q=
X-Received: by 2002:ac2:482b:0:b0:4ed:88fe:62e0 with SMTP id
 11-20020ac2482b000000b004ed88fe62e0mr5941409lft.68.1684211139740; Mon, 15 May
 2023 21:25:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230407072415.1360068-1-christian.couder@gmail.com>
 <20230509175347.1714141-1-christian.couder@gmail.com> <20230509175347.1714141-13-christian.couder@gmail.com>
In-Reply-To: <20230509175347.1714141-13-christian.couder@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 15 May 2023 21:25:27 -0700
Message-ID: <CABPp-BEcrS6DskLtYa25MNu8L_hn03bgGqpUPsfkq_k2TFV9bg@mail.gmail.com>
Subject: Re: [PATCH v2 12/15] replay: disallow revision specific options and pathspecs
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 9, 2023 at 10:54=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> A previous commit changed `git replay` to make it accept standard
> revision ranges using the setup_revisions() function. While this is good

s/is good/is a good/

> thing to make this command more standard and more flexible, it has the
> downside of enabling many revision related options accepted and eaten by
> setup_revisions().
[...]
> @@ -135,6 +135,20 @@ int cmd_replay(int argc, const char **argv, const ch=
ar *prefix)
>         argc =3D parse_options(argc, argv, prefix, replay_options, replay=
_usage,
>                              PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOW=
N_OPT);
>
> +       /*
> +        * TODO: For now, we reject any unknown or invalid option,
> +        * including revision related ones, like --not,
> +        * --first-parent, etc that would be allowed and eaten by
> +        * setup_revisions() below. In the future we should definitely
> +        * accept those that make sense and add related tests and doc
> +        * though.
> +        */
> +       for (i =3D 0; i < argc; i++)
> +               if (argv[i][0] =3D=3D '-') {
> +                       error(_("invalid option: %s"), argv[i]);
> +                       usage_with_options(replay_usage, replay_options);
> +               }
> +
>         if (!onto_name) {
>                 error(_("option --onto is mandatory"));
>                 usage_with_options(replay_usage, replay_options);
> @@ -150,6 +164,17 @@ int cmd_replay(int argc, const char **argv, const ch=
ar *prefix)
>                 goto cleanup;
>         }
>
> +       /*
> +        * TODO: For now, we reject any pathspec. (They are allowed
> +        * and eaten by setup_revisions() above.) In the future we
> +        * should definitely accept them and add related tests and doc
> +        * though.
> +        */

I like the previous TODO, but I think this one can just be left out.
While it might be possible to do something sensible with pathspecs at
least for linear history, it's not clear to me how it could generally
work with non-linear history.  And since replay has handling
non-linear history as a primary (eventual) goal, the "definitely" here
seems incorrect to me.

[...]

Rest looks good.
