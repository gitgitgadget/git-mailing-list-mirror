Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C5AC433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 08:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238552AbiBYIjO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 03:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238545AbiBYIjM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 03:39:12 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD75F24FB9E
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 00:38:39 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id r13so9400557ejd.5
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 00:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QTWktVJ8gRbD+IaprEnFUDPIfHqDBs4ZcwvWig1ZmEs=;
        b=XDg2Ei5oiHYOp/JsahZq1Q82jYo574Lod+Ekux3QWOIllW5+HHTZ8CAthNmclgpv1o
         CAU28hc02oLyEZotJaJcj7p9wTxyMZoWJA6QIg6u61d0DgIxaY5KqSG+xFEoRIqGqGiE
         MzDu7Rl/2NeSgrjD+CGpNJxWfotVUS2XTrOXM0k2/B6tokWAew1yR+9nTP6JyA7fKve/
         SCRhH688r93D0wcxSIXPkVFRV/E25+gaL6TXn2SUOKsgNzJtjP7Y+6SNCILG5Q058+OX
         8qFei9+VIuVyTNL73aYePssKpDLSsRl8NzRqix2m2bJP8KSuv6EnWyZ7A95cp0P3/bYB
         Kbdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QTWktVJ8gRbD+IaprEnFUDPIfHqDBs4ZcwvWig1ZmEs=;
        b=k7j4+7ndYw88jAnXFDoUpH+5R29k6i/etuvtbRMDsDyAR92KadL1d+L7TcGsLrWWN4
         50G8Cie4qxKCYptS0rtERtFTyW7VL5tB2JV8UIy0fJCG2alIzlp1sVzwHgTbUOxynuKa
         mwX20TMvg371fjTAPFFpjisj0LN0qBonn+Qnu+0DhrAFT9pPAyEb+M6RL/aZUO1wzoqp
         +qysDzZJxRVRL1b6WqlDFKyinaUrGByELWVjeAlV+DzEPMVXaJOU6ZlrTE30/cdULo8d
         Et3JmhFwuFpphynfuRg4cuRRq43WRlkkU3Yzt9r91qs7pBMGBKrV/g5cO8DGf+1P8QMn
         VlKw==
X-Gm-Message-State: AOAM532gVeJilgT1YmATcrQviHjzVwRsboMRasYyYBc3OUa+Z8BcuESJ
        SZqnUKtIsyTG6+nuW4Y48FdYgpcFcLb/yZZQU0x5TPihfFmVdA==
X-Google-Smtp-Source: ABdhPJzjisj70Vc55S7+dg71YHSTxF2mqOn20jCLpGrNXRRovRqPfNEx4njj720al34hZVXyZeOpFLvVW/Q/5DbmSB8=
X-Received: by 2002:a17:906:3a18:b0:6cd:ba45:995f with SMTP id
 z24-20020a1709063a1800b006cdba45995fmr5464402eje.328.1645778318330; Fri, 25
 Feb 2022 00:38:38 -0800 (PST)
MIME-Version: 1.0
References: <pull.1157.git.1645640717.gitgitgadget@gmail.com>
 <pull.1157.v2.git.1645742073.gitgitgadget@gmail.com> <4f05fa70209768fb20284bd4018a1364567cad5a.1645742073.git.gitgitgadget@gmail.com>
In-Reply-To: <4f05fa70209768fb20284bd4018a1364567cad5a.1645742073.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 25 Feb 2022 00:38:26 -0800
Message-ID: <CABPp-BHx8gFh717bovO6wCo0RA058=YjNtHhRme+Rxh8GOnxbQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] read-tree: narrow scope of index expansion for '--prefix'
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 24, 2022 at 2:34 PM Victoria Dye via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Victoria Dye <vdye@github.com>
>
> When 'git read-tree' is provided with a prefix, expand the index only if the
> prefix is equivalent to a sparse directory or contained within one. If the
> index is not expanded in these cases, 'ce_in_traverse_path' will indicate
> that the relevant sparse directory is not in the prefix/traverse path,
> skipping past it and not unpacking the appropriate tree(s).
>
> If the prefix is in-cone, its sparse subdirectories (if any) will be
> traversed correctly without index expansion.
>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  builtin/read-tree.c                      |  3 +--
>  t/t1092-sparse-checkout-compatibility.sh |  8 ++++++-
>  unpack-trees.c                           | 30 ++++++++++++++++++++++++
>  3 files changed, 38 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/read-tree.c b/builtin/read-tree.c
> index c2fdbc2657f..a7b7f822281 100644
> --- a/builtin/read-tree.c
> +++ b/builtin/read-tree.c
> @@ -213,8 +213,7 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
>         if (opts.merge && !opts.index_only)
>                 setup_work_tree();
>
> -       /* TODO: audit sparse index behavior in unpack_trees */
> -       if (opts.skip_sparse_checkout || opts.prefix)
> +       if (opts.skip_sparse_checkout)
>                 ensure_full_index(&the_index);
>
>         if (opts.merge) {
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index ae44451a0a9..a404be0a10f 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -1415,7 +1415,13 @@ test_expect_success 'sparse index is not expanded: read-tree' '
>         do
>                 ensure_not_expanded read-tree -mu $MERGE_TREES &&
>                 ensure_not_expanded reset --hard HEAD || return 1
> -       done
> +       done &&
> +
> +       rm -rf sparse-index/deep/deeper2 &&
> +       ensure_not_expanded add . &&
> +       ensure_not_expanded commit -m "test" &&
> +
> +       ensure_not_expanded read-tree --prefix=deep/deeper2 -u deepest
>  '
>
>  test_expect_success 'ls-files' '
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 360844bda3a..dba122a02bb 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1739,6 +1739,36 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>                 setup_standard_excludes(o->dir);
>         }
>
> +       /*
> +        * If the prefix is equal to or contained within a sparse directory, the
> +        * index needs to be expanded to traverse with the specified prefix.
> +        */
> +       if (o->prefix && o->src_index->sparse_index) {
> +               int prefix_len = strlen(o->prefix);
> +
> +               while (prefix_len > 0 && o->prefix[prefix_len - 1] == '/')
> +                       prefix_len--;
> +
> +               if (prefix_len > 0) {

Is this condition check necessary?  If we want some safety check here,
could it instead be something like

   if (prefix_len <= 0)
       BUG("Broken prefix passed to unpack_trees");

and then dedent the following code?  (Or are callers allowed to not
sanitize their input before passing to unpack_trees(), meaning that we
should use a die() rather than a BUG()?)

To test this idea, near the top of unpack_trees(), I added:
    if (o->prefix)
        assert(*o->prefix && *o->prefix != '/');
and reran all tests.  They all ran without hitting that assertion.  FWIW.

> +                       struct strbuf ce_prefix = STRBUF_INIT;
> +                       strbuf_grow(&ce_prefix, prefix_len + 1);
> +                       strbuf_add(&ce_prefix, o->prefix, prefix_len);
> +                       strbuf_addch(&ce_prefix, '/');
> +
> +                       /*
> +                        * If the prefix is not inside the sparse cone, then the
> +                        * index is explicitly expanded if it is found as a sparse
> +                        * directory, or implicitly expanded (by 'index_name_pos')
> +                        * if the path is inside a sparse directory.
> +                        */
> +                       if (!path_in_cone_mode_sparse_checkout(ce_prefix.buf, o->src_index) &&
> +                           index_name_pos(o->src_index, ce_prefix.buf, ce_prefix.len) >= 0)

style nit: Can you rewrap both the comments and the code at 80 characters?

It took me a bit of playing and testing to understand these two lines.
The comment helps, but it's still a bit dense to unpack; somehow I
didn't understand that the comment was referring to index_name_pos()'s
call to ensure_full_index().  Once I understood that, it all looks
good.


> +                               ensure_full_index(o->src_index);
> +
> +                       strbuf_release(&ce_prefix);
> +               }
> +       }
> +
>         if (!core_apply_sparse_checkout || !o->update)
>                 o->skip_sparse_checkout = 1;
>         if (!o->skip_sparse_checkout && !o->pl) {
> --
> gitgitgadget
