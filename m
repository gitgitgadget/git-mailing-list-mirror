Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA7DC43217
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 14:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbiLAOMP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 09:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiLAOMN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 09:12:13 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4C2A7AAE
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 06:12:11 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id j196so2196369ybj.2
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 06:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0CH4VFRMnSQnX3NDzIxmYdnPcB7/tikOiAyR7xzJes=;
        b=js+4MyWDjLYIem+l7lZIDhB1sQGv8dP0ZX4AawV9Oy5uPF8TBvTUlzSJPWCsQ39PJx
         91+7Q1QaN293FrDUIcu2+L+53R3WyhJKWSMkgClbUrKbbLQKhY0GoXaqv85dyOOzgCHy
         J8OPcNkKOnBnFRXz3H3OQqYnD3zfzd7qqvcJeu7inPn99OSN47v6gpdahdvum9qZF0Wt
         /ocmvl+CFfRJkatb22D1gCk+a6Lk9MSo5R05xE/r8dAdyIxHch9OOzsroicVO0OWh32c
         S67t7KNzBK4jxe0ayajW4MeJ9mx/+pzk5MJ43i4Tq2D+ys1Z2dT97ppo1ygRKsQ8Gevq
         GivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0CH4VFRMnSQnX3NDzIxmYdnPcB7/tikOiAyR7xzJes=;
        b=JKrcAdBTZr54ySwGat/WdroHTbwH1IDhyYO6Vc5sVNGm/ton1RpCQP60b+NXJVWrP3
         60RyjcTe4gJE4ETNPKtix660+Rm7NpnyTXpJBK/SjoBl4rn77GDAqn6a7Shnf1yp6cAS
         FVlTifqlykmwiW1FAz63Jn736jFVN6KIU44oJWZ2KC+4wKOIaOTL5l6K81VpoiItRy1U
         n8axtTiwPVoDPfsi83qYCRf/gipjmEGAlXUBgdLzn71GlejmIC++W2WP/mHbspiF73UW
         FgRREQS7nrf+K+mc4FWrVCZjPchEJ9Svw4k4opzxotvg+9bcWB056MQrR4iEAKVoLVhc
         vO6A==
X-Gm-Message-State: ANoB5pnahXFrdpvLQ5bq9xzaT1SDQJ6gRxJFXzeWC6pBYc++HUHlGlUa
        QTRn3PUfvj2+iAKOhq13RQLVyPBGAwJbOBYWCsE=
X-Google-Smtp-Source: AA0mqf4yd8Qc9Fgs2mLSg5YW+K6kez0FxwydnDANSSvZTIuSO0lDyefJBYuiUeZcDm7zJ1OcBqKUVtnIjFQ/k3xwpaY=
X-Received: by 2002:a25:8b85:0:b0:6dd:a4b9:442b with SMTP id
 j5-20020a258b85000000b006dda4b9442bmr64507500ybl.410.1669903930565; Thu, 01
 Dec 2022 06:12:10 -0800 (PST)
MIME-Version: 1.0
References: <0620b4a6-b80a-d8a0-5a35-857b9fe0c986@web.de> <19be5afa-63e8-5f11-c5f4-6f391677e4c4@web.de>
In-Reply-To: <19be5afa-63e8-5f11-c5f4-6f391677e4c4@web.de>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 1 Dec 2022 22:11:59 +0800
Message-ID: <CAOLTT8SpF=i6Lwc28SWSDf2uOqoxLpMHiVS5GefwYcCHigL2NQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] diff: factor out add_diff_options()
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ren=C3=A9 Scharfe <l.s.r@web.de> =E4=BA=8E2022=E5=B9=B412=E6=9C=881=E6=97=
=A5=E5=91=A8=E5=9B=9B 02:13=E5=86=99=E9=81=93=EF=BC=9A
>
> Add a function for appending the parseopts member of struct diff_options
> to a struct option array.  Use it in two sites instead of accessing the
> parseopts member directly.  Decoupling callers from diff internals like
> that allows us to change the latter.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  builtin/range-diff.c | 2 +-
>  diff-no-index.c      | 3 +--
>  diff.c               | 6 ++++++
>  diff.h               | 1 +
>  4 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/range-diff.c b/builtin/range-diff.c
> index e2a74efb42..aecfae12d3 100644
> --- a/builtin/range-diff.c
> +++ b/builtin/range-diff.c
> @@ -47,7 +47,7 @@ int cmd_range_diff(int argc, const char **argv, const c=
har *prefix)
>
>         repo_diff_setup(the_repository, &diffopt);
>
> -       options =3D parse_options_concat(range_diff_options, diffopt.pars=
eopts);
> +       options =3D add_diff_options(range_diff_options, &diffopt);
>         argc =3D parse_options(argc, argv, prefix, options,
>                              builtin_range_diff_usage, PARSE_OPT_KEEP_DAS=
HDASH);
>
> diff --git a/diff-no-index.c b/diff-no-index.c
> index 18edbdf4b5..05fafd0019 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -255,8 +255,7 @@ int diff_no_index(struct rev_info *revs,
>         };
>         struct option *options;
>
> -       options =3D parse_options_concat(no_index_options,
> -                                      revs->diffopt.parseopts);
> +       options =3D add_diff_options(no_index_options, &revs->diffopt);
>         argc =3D parse_options(argc, argv, revs->prefix, options,
>                              diff_no_index_usage, 0);
>         if (argc !=3D 2) {
> diff --git a/diff.c b/diff.c
> index 1054a4b732..e01129f0ea 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -5693,6 +5693,12 @@ static void prep_parse_options(struct diff_options=
 *options)
>         memcpy(options->parseopts, parseopts, sizeof(parseopts));
>  }
>
> +struct option *add_diff_options(const struct option *parseopts,
> +                               struct diff_options *options)
> +{
> +       return parse_options_concat(parseopts, options->parseopts);
> +}
> +

This idea is very good. I am implementing `--scope` for git diff
recently [1], but I
don=E2=80=99t want this option to be directly inherited by commands such as=
 git log,
git format-patch, etc. It would be best if the option can be added
dynamically...
This patch looks like it can be used to do just that! :)

>  int diff_opt_parse(struct diff_options *options,
>                    const char **av, int ac, const char *prefix)
>  {
> diff --git a/diff.h b/diff.h
> index fd33caeb25..c20a1ad76d 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -539,6 +539,7 @@ int git_diff_ui_config(const char *var, const char *v=
alue, void *cb);
>  #define diff_setup(diffopts) repo_diff_setup(the_repository, diffopts)
>  #endif
>  void repo_diff_setup(struct repository *, struct diff_options *);
> +struct option *add_diff_options(const struct option *, struct diff_optio=
ns *);
>  int diff_opt_parse(struct diff_options *, const char **, int, const char=
 *);
>  void diff_setup_done(struct diff_options *);
>  int git_config_rename(const char *var, const char *value);
> --
> 2.38.1

Thanks!

[1]: https://lore.kernel.org/git/pull.1398.v3.git.1669723221.gitgitgadget@g=
mail.com/
