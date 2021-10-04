Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4AFC433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 13:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D6C061244
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 13:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235712AbhJDN45 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 09:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238683AbhJDN4l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 09:56:41 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76B1C0617AB
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 06:46:36 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id j15so11138721plh.7
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 06:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rR5Isto0N10kRglfx4AVUFFQIEdTvUVqLBunlqyvNGE=;
        b=YrJyiRXmDYipuUvrdMZNAk59bCmlokZ3Kbh45sNqLOsZw/a+23s3jNrd3YDIOKdybT
         JZTibBCtQQT7toUwSUC5LrL+czhD14vWjHZ3HB1fpKRtLZrX8DUhQ3odBm0zyPpHRz3h
         LSpTDZR8a1mnph6++ybT3/auJDQ0SHcli+TweUf7g8G1OOH5v+eEUOGVMAu3spddQFMt
         iCxtk1uRPSvgfhOzAVj8/c3ifYKozPFqx0n/KzgxKSHuSO8jcR0xUjoTlE50A1R2QMh6
         RisF8zfYVltPYcstjP0jXF1T4f2+N7oJFLRvVMMMWtHWBKZ+8ZgdMYC/UH9heozkr2Ys
         8fug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rR5Isto0N10kRglfx4AVUFFQIEdTvUVqLBunlqyvNGE=;
        b=XY9cZB2AddTdrtmx5m5kDo5P+ExxyUKCj1MpHN/+LoiRuXMaPjW0WGTTwaFaipQDoA
         IgwfeACHQgCy2MHOsorFYa8RL6VuwzEbrL0vqm9jXpaWOM+2nIOJ6YylM09UCiH/WFeu
         UVLYss/DIOUVIN+F/B2KxlHYbN3sNMXRFbBp52vtf7cA5thK76KWJKJazyFZ0IjYjUIM
         hmE3RRQG56dbrnzEOe1dzhDpV1oqwCfLJJNrmIKMHfn9uLm3nIMMFA2rDcHr3gYBsczn
         NUzksdGM7+tRtdgyw0ZBSZdTSFcsfkuk/G8y7lTVPvoY7pg86w8sYhuwGgyl0MG+ALV8
         HL4A==
X-Gm-Message-State: AOAM530HnvVkWTJ9yuOYXJ1wLo8QyOdfNipB0eiRNEe2T14eTUai+D3E
        VvtSfT3Kj2oWBNWw/CjHkMxDu1+buqV0L/FfbiQ=
X-Google-Smtp-Source: ABdhPJxfJjLMzRXGZnBNJw/RvMLnXV/YZgZQ2Li3WtNuMPrEKmAXqHuu5Bi3XuB2Svh1enjZhTgZ0I1YJpxs7lOhSIA=
X-Received: by 2002:a17:90b:1642:: with SMTP id il2mr37284309pjb.133.1633355196346;
 Mon, 04 Oct 2021 06:46:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover-00.10-00000000000-20211004T002226Z-avarab@gmail.com> <patch-02.10-050399cbfbf-20211004T002226Z-avarab@gmail.com>
In-Reply-To: <patch-02.10-050399cbfbf-20211004T002226Z-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 4 Oct 2021 06:45:00 -0700
Message-ID: <CABPp-BFYxWXZQXvDSrM1Y1ZaQ1d2TENQDvx1cyawvrDO1OvExA@mail.gmail.com>
Subject: Re: [PATCH 02/10] merge-recursive.c: call a new unpack_trees_options_init()
 function
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 3, 2021 at 5:46 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> In the preceding commit we introduced a new UNPACK_TREES_OPTIONS_INIT
> macro, but "merge-recursive.c" could not be converted to it since
> it (re-)initializes a "struct unpack_trees_options" on the heap.
>
> In order to convert use the macro as the source of truth for
> initialization we need to not only convert the initialization in
> unpack_trees_start(), but also call the new
> unpack_trees_options_init() just after the CALLOC_ARRAY() in
> merge_start().

Um...why?

> When we call merge_trees() we'll call merge_start() followed by
> merge_trees_internal(), and it will call unpack_trees_start() before
> it does much of anything. So it's covered by an initialization in
> unpack_trees_start().
>
> But when merge_recursive() is called it will call merge_start()
> followed by merge_recursive_internal(), which won't call
> unpack_trees_start() until its own call call to
> merge_trees_internal(), but in the meantime it might end up using that
> calloc'd "struct unpack_trees_options".

Nothing in merge-recursive.c usings unpack_opts before
unpack_trees_start() or after unpack_trees_finish().  If anyone
attempts to use it elsewhere, that would itself be a bug.  So, I'd
replace the above three paragraphs with:

"Change the initialization of opt->priv_unpack_opts from using memset
to 0, with unpack_trees_options_init()."

or something like that, and then drop your change to merge_start().

> This was OK before, as setup_unpack_trees_porcelain() would call
> strvec_init(), and our "struct dir_struct" in turn is OK with being
> NULL'd. Let's convert the former to macro initialization, we'll deal
> with the latter in a subsequent commit.

This is quite confusing; it's really hard to understand how this
relates to the rest of the commit message.  I have to read the code to
see what you're doing, and then write my own commit message in my head
because the wording in this paragraph still doesn't parse.

I'd make the change strvec_init/STRVEC_INIT changes be a separate
patch.  I suspect it'll be easier to write the commit message for it
as a standalone commit as well.

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  merge-recursive.c | 3 ++-
>  unpack-trees.c    | 8 ++++++--
>  unpack-trees.h    | 5 ++++-
>  3 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index e594d4c3fa1..d24a4903f1d 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -405,7 +405,7 @@ static int unpack_trees_start(struct merge_options *o=
pt,
>         struct tree_desc t[3];
>         struct index_state tmp_index =3D { NULL };
>
> -       memset(&opt->priv->unpack_opts, 0, sizeof(opt->priv->unpack_opts)=
);
> +       unpack_trees_options_init(&opt->priv->unpack_opts);
>         if (opt->priv->call_depth)
>                 opt->priv->unpack_opts.index_only =3D 1;
>         else
> @@ -3704,6 +3704,7 @@ static int merge_start(struct merge_options *opt, s=
truct tree *head)
>
>         CALLOC_ARRAY(opt->priv, 1);
>         string_list_init_dup(&opt->priv->df_conflict_file_set);
> +       unpack_trees_options_init(&opt->priv->unpack_opts);

Drop this hunk.


>         return 0;
>  }
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 8ea0a542da8..393c1f35a5d 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -108,8 +108,6 @@ void setup_unpack_trees_porcelain(struct unpack_trees=
_options *opts,
>         const char **msgs =3D opts->msgs;
>         const char *msg;
>
> -       strvec_init(&opts->msgs_to_free);
> -
>         if (!strcmp(cmd, "checkout"))
>                 msg =3D advice_enabled(ADVICE_COMMIT_BEFORE_MERGE)
>                       ? _("Your local changes to the following files woul=
d be overwritten by checkout:\n%%s"
> @@ -189,6 +187,12 @@ void setup_unpack_trees_porcelain(struct unpack_tree=
s_options *opts,
>                 opts->unpack_rejects[i].strdup_strings =3D 1;
>  }
>
> +void unpack_trees_options_init(struct unpack_trees_options *o)
> +{
> +       struct unpack_trees_options blank =3D UNPACK_TREES_OPTIONS_INIT;
> +       memcpy(o, &blank, sizeof(*o));
> +}
> +
>  void clear_unpack_trees_porcelain(struct unpack_trees_options *opts)
>  {
>         strvec_clear(&opts->msgs_to_free);
> diff --git a/unpack-trees.h b/unpack-trees.h
> index ecf256cbcea..892b65ea623 100644
> --- a/unpack-trees.h
> +++ b/unpack-trees.h
> @@ -91,7 +91,10 @@ struct unpack_trees_options {
>         struct checkout_metadata meta;
>  };
>
> -#define UNPACK_TREES_OPTIONS_INIT { 0 }
> +#define UNPACK_TREES_OPTIONS_INIT { \
> +       .msgs_to_free =3D STRVEC_INIT, \
> +}
> +void unpack_trees_options_init(struct unpack_trees_options *o);
>
>  int unpack_trees(unsigned n, struct tree_desc *t,
>                  struct unpack_trees_options *options);
> --
> 2.33.0.1404.g83021034c5d
>
