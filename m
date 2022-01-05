Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91F8C433EF
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 23:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245359AbiAEXU2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 18:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245348AbiAEXUM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 18:20:12 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861D6C061245
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 15:20:11 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id bm14so2584652edb.5
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 15:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ldHSTAsg1YydF9oUiejUdBgm4/3BLIs6FSDDWVoy0vo=;
        b=qUqao/geHX1tht4msNifSEs5Glb2zkE7XM/QjtdYXZnQ4SegVl6XENLs0zLuKoDCt6
         44ACNhzBxkBmlVVJQpsQMTtJ+TZwDs5G9zTy5qzcBb480iT6Mboz5WFFutBZ45SQSWG0
         sSSlxGowE0T2FxbqrpJa+7vOBYNuSDhe0ynpyz18xQpVqurmONRQdholxgwN+RAA/biK
         VXyF2aSgr9qus6iu6J883j9U4EgOjFmZwRhndo9KeqBVqJKgwxJ03qbEjF8LKb+ZaUOf
         UBISoTeeb0Dc7dV7zlq4u7S05wC2VIx6rWD/WYYslUubLdS0+iqkPgk16yeJU3pg3pgA
         uSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ldHSTAsg1YydF9oUiejUdBgm4/3BLIs6FSDDWVoy0vo=;
        b=23eUSkDZPUStLNrz7KaeWNjdiv1NLqeuJA+Q1e/gH/HgC5RZO1unIs/Ocg9Nlcxuh3
         rGN+D+LF85mcoU9UdxmAmdakX6sqY3YlCgcCT79YGSxoqOrwGnO/G8dSYEwKwPPwVAfQ
         lViVOtI/0PwyFP6JkbiulxgR9XVlcQG+UAMhNU5+iHgc7vYTMaf826IYMQx0VNMRQeL+
         iTJW2rvfl8/osipW68EDrYglAoLpeX20SBrOMs0L4V23XA2qT+oTqgrwUvBNv/7ywFR8
         tROuyy+glvjI7t3kC202TssKpwDtztsAQVZJzATsnaoyBqKT4YZXP8f97c5k6Q9l846w
         bvDw==
X-Gm-Message-State: AOAM530TVSSOIGGfL4wZDV5mMZRVXf5qEk2k8Giz1F9D4VvJJ4nVOgq+
        6USOLy6vA/JSd3DFf4p45+iptzQU+dm+ZthPtoU=
X-Google-Smtp-Source: ABdhPJy6EbFG8gMy0hB8mHDStjqQW4oHKzUqzhtNoSavvEwn4X+Ouv4TxhdsRjgYocLFoVKtsh+3nCBl1ZpCQninx3k=
X-Received: by 2002:a17:907:3f1e:: with SMTP id hq30mr43658559ejc.613.1641424809527;
 Wed, 05 Jan 2022 15:20:09 -0800 (PST)
MIME-Version: 1.0
References: <29f0410e-6dfa-2e86-394d-b1fb735e7608@gmail.com> <xmqqsfu1g64s.fsf@gitster.g>
In-Reply-To: <xmqqsfu1g64s.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 5 Jan 2022 15:19:58 -0800
Message-ID: <CABPp-BH5woi6KY7OBpnsS-M2EmgLHii9zs8rSwrgcPFkOAvn_A@mail.gmail.com>
Subject: Re: Bug report - sparse-checkout ignores prefix when run in subdirectories
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lessley Dennington <lessleydennington@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 5, 2022 at 2:38 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Lessley Dennington <lessleydennington@gmail.com> writes:
>
> > Hello everyone! See the following bug report pertaining to sparse-checkout
> > when run outside top-level directories.
>
> In a bug report it is fine, but "outside top-level" usually means
> above the top-level of the working tree.  Here, I think you meant
> running in a subdirectory of the top-level.
>
> Perhaps something along this line?
>
>  builtin/sparse-checkout.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git c/builtin/sparse-checkout.c w/builtin/sparse-checkout.c
> index 45e838d8f8..4e5efbb85e 100644
> --- c/builtin/sparse-checkout.c
> +++ w/builtin/sparse-checkout.c
> @@ -753,6 +753,16 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
>         if (!core_sparse_checkout_cone && argc == 0) {
>                 argv = default_patterns;
>                 argc = default_patterns_nr;
> +       } else if (argc && prefix && *prefix) {
> +               /*
> +                * The args are not pathspecs, so unfortunately we
> +                * cannot imitate how cmd_add() uses parse_pathspec().
> +                */
> +               int i;
> +               int prefix_len = strlen(prefix);
> +
> +               for (i = 0; i < argc; i++)
> +                       argv[i] = prefix_path(prefix, prefix_len, argv[i]);
>         }

This looks good (sparse_checkout_add() needs a similar fix), at least
for cone mode.  There might be a small pickle here that I didn't think
about before.  --cone mode always uses directories, so we expect
people to provide directory names.  Because of that, I think it's fair
to expect the arguments passed to `set` or `add` to be paths relative
to the current working directory.  In contrast, for non-cone mode we
do not expect pathnames but gitignore-style globs.  And when we get
gitignore-style globs, we don't know if they were intended relative to
the current working directory or the toplevel, because we only have
one $GIT_DIR/info/sparse-checkout file versus many .gitignore files.
So, should "**.py" go directly into the sparse-checkout file as-is, or
be translated to "my/current/subdir/**.py" first?

Maybe translating is always fine, or maybe we want to throw an error
when: (not using cone mode and prefix is non-empty and any patterns
are provided).

Thoughts?

>
>         return modify_pattern_list(argc, argv, set_opts.use_stdin, REPLACE);
