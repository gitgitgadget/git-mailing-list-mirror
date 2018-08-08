Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE7E61F405
	for <e@80x24.org>; Wed,  8 Aug 2018 18:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbeHHUv1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 16:51:27 -0400
Received: from mail-ua0-f177.google.com ([209.85.217.177]:42748 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeHHUv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 16:51:27 -0400
Received: by mail-ua0-f177.google.com with SMTP id w7-v6so3438423uan.9
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 11:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eiWsp3RPewJqYW2hI1uI6B3rYhFlaK2d1yvkieWgtx8=;
        b=XkHC+uDtYXuQKno9CHDJVVGvMJ9G8YJFtGJpdbb8SI9FRbmQdCqQBeFs86yiBKxs2/
         z4NaNrGZkIrod7Wn1a+ZSVkM+cmc/Qa0L+kC/Zs47rpgB1jPtAZOvbVpZs5FNeYgmuLa
         vVhO575KWpE5btWIgd0C4qZ6cWzqbvdOeqZxUJBYEc6OWm5QnWE3hbxz0JqRwg65kSVf
         6fL3JrVpVMXdhbOH1U8aVTlqQST+xIB0HNX567bakmERh1G47RGYhSEuBa/Mi5Dt8Bss
         zcN62Wi/B3Swx7xLy19cPhdFhzkKkrh4yvuHU/2jtn50tXluyJwFizo1aoO2g3PJSsEd
         ORsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eiWsp3RPewJqYW2hI1uI6B3rYhFlaK2d1yvkieWgtx8=;
        b=jzNy3aupKDzfWtipKWWAVqX2MQFP24lcSxXO563IV6iPMkvF9elSLVj+Ad4ZhbYAiW
         ssMJZkE5Wo+HifwGWeGaizzZ6n8UXuxZdf09NYmf6cke88MJP7NeEyFhJEEb8ko5zNR8
         fqWhW2O6idP4v6VmF2tTaaSPdHo1GZ9LL1uiy01uUJaCJLTkN8NomhcDSopqCeYvYYp9
         gFQte/q+9VSUjt7p/oZMJ867DUI6kLb485V2gkzTTNGVVyWOuwGZI7RtUYT/8dnZWGmq
         h+U4NSa6LEAKutT3KZ5LDoI3MHTItmmxRh7xE6HsgzTCcIFuJ2jBkiDmmftv0pePQ73o
         HKzg==
X-Gm-Message-State: AOUpUlGo04Th8NybbNFfzBfEIXzW2HpaO/pqoS81caojDX8Q2k79wBQu
        2ZajCAMtqWbNlsxdYui8QxSTMeNWsP+oWREP0eE=
X-Google-Smtp-Source: AA+uWPwzwWBq/3rTvsbgEMpBDwVvtzfvrP9BHES21SMyjSaBpRB8nILnKk7ptkrAC9Nan6mLpzDIJ5WdqqWgVcEzC6E=
X-Received: by 2002:a1f:5c7:: with SMTP id 190-v6mr2614353vkf.47.1533753031702;
 Wed, 08 Aug 2018 11:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180729103306.16403-1-pclouds@gmail.com> <20180804053723.4695-1-pclouds@gmail.com>
 <20180804053723.4695-4-pclouds@gmail.com>
In-Reply-To: <20180804053723.4695-4-pclouds@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 8 Aug 2018 11:30:20 -0700
Message-ID: <CABPp-BF7kfeTc7rdg8QFMq0MkP+GOQK23KBPW=A6FrD0SymjZg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] unpack-trees: reduce malloc in cache-tree walk
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <peartben@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 3, 2018 at 10:39 PM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
>
> This is a micro optimization that probably only shines on repos with
> deep directory structure. Instead of allocating and freeing a new
> cache_entry in every iteration, we reuse the last one and only update
> the parts that are new each iteration.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  unpack-trees.c | 29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index ba3d2e947e..c8defc2015 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -694,6 +694,8 @@ static int traverse_by_cache_tree(int pos, int nr_ent=
ries, int nr_names,
>  {
>         struct cache_entry *src[MAX_UNPACK_TREES + 1] =3D { NULL, };
>         struct unpack_trees_options *o =3D info->data;
> +       struct cache_entry *tree_ce =3D NULL;
> +       int ce_len =3D 0;
>         int i, d;
>
>         if (!o->merge)
> @@ -708,30 +710,39 @@ static int traverse_by_cache_tree(int pos, int nr_e=
ntries, int nr_names,
>          * in the first place.
>          */
>         for (i =3D 0; i < nr_entries; i++) {
> -               struct cache_entry *tree_ce;
> -               int len, rc;
> +               int new_ce_len, len, rc;
>
>                 src[0] =3D o->src_index->cache[pos + i];
>
>                 len =3D ce_namelen(src[0]);
> -               tree_ce =3D xcalloc(1, cache_entry_size(len));
> +               new_ce_len =3D cache_entry_size(len);
> +
> +               if (new_ce_len > ce_len) {
> +                       new_ce_len <<=3D 1;
> +                       tree_ce =3D xrealloc(tree_ce, new_ce_len);
> +                       memset(tree_ce, 0, new_ce_len);
> +                       ce_len =3D new_ce_len;
> +
> +                       tree_ce->ce_flags =3D create_ce_flags(0);
> +
> +                       for (d =3D 1; d <=3D nr_names; d++)
> +                               src[d] =3D tree_ce;
> +               }
>
>                 tree_ce->ce_mode =3D src[0]->ce_mode;
> -               tree_ce->ce_flags =3D create_ce_flags(0);
>                 tree_ce->ce_namelen =3D len;
>                 oidcpy(&tree_ce->oid, &src[0]->oid);
>                 memcpy(tree_ce->name, src[0]->name, len + 1);
>
> -               for (d =3D 1; d <=3D nr_names; d++)
> -                       src[d] =3D tree_ce;
> -
>                 rc =3D call_unpack_fn((const struct cache_entry * const *=
)src, o);
> -               free(tree_ce);
> -               if (rc < 0)
> +               if (rc < 0) {
> +                       free(tree_ce);
>                         return rc;
> +               }
>
>                 mark_ce_used(src[0], o);
>         }
> +       free(tree_ce);
>         if (o->debug_unpack)
>                 printf("Unpacked %d entries from %s to %s using cache-tre=
e\n",
>                        nr_entries,
> --
> 2.18.0.656.gda699b98b3

Seems reasonable, when we really do have to invoke call_unpack_fn.
I'm still curious if there are reasons why we couldn't just skip that
call (at least when o->fn is one of {oneway_merge, twoway_merge,
threeway_merge, bind_merge}), but I already brought that up in my
comments on patch 2.
