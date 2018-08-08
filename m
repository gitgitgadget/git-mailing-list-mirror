Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26B231F405
	for <e@80x24.org>; Wed,  8 Aug 2018 18:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbeHHVHf (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 17:07:35 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:44880 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728242AbeHHVHf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 17:07:35 -0400
Received: by mail-ua0-f193.google.com with SMTP id k25-v6so3485211uao.11
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 11:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WqJf6aBwSuOnvWYnx7plOgcoIWM8wtt7Gf1ub5m+PRM=;
        b=ULGEPoFQElsDFFGPBY9v2SmuyR9H8sV8kXC/OTouaFrForLH5SsAkC/Z2xzIx7y74L
         IiTmgEs/DPAICttggPJZ3/el9jeKPG+6a1T591p8B/hv5swDMoaRUx6MoEbuo6xfERWF
         leNDissmeogvSjLoTbXVZ9+Orn7uXYaybW1uFNBDrBjKLBNj1WRb/3XC/3tjEwIp3Ep0
         /rU8m/SAn+u42YuC41fa+KwJeKmSmEvhYrbic0WTaiLO1/CMmuckLr1b9Va/guQG20oK
         laGwe7cXRbVtKjmQ5zzYxRVDkMLW7A+zofx6Pbi/D/f45fdgjteAqJ2f2UtrkUbUpYkp
         B6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WqJf6aBwSuOnvWYnx7plOgcoIWM8wtt7Gf1ub5m+PRM=;
        b=JjrmRD3o93x6ozhD1hvvcIoRm26Ykp+vciAPlUHRbuBwQh+U8m4GxJ+IR1rfmCD0CA
         rGKoKK0SPynoP2FDjd+MNCyNG6KHwieJ5MHnW6e+gBxuneD+3pkenbDWlQg2LnQfolhO
         RHgFb0zxCwDKG4+c2ltbn7xqiVHuDU0b9Ai0JfjhY7gQgoBczoacG3JKskJSYDXANxWh
         8rDtqh+2Ao643EzSwcHFmZhMmZUXROIFILu42N+c1QOhYnOKOc6hEvU23d0LA1KQvvCR
         V0ywCXmSSWP3u5l6UyyXKuy3ipAE+cjNRvXFmFkmoJtFiYf2fQ6FI6INOE9K1gqLvHHJ
         2CAw==
X-Gm-Message-State: AOUpUlEl7pNr9cRw1swdfM9l9mJDQe6l65lJDyCVM7pQMgX6mPOdE2ua
        Io9/uH5pqh2+3GRr/VkMvqQJirXmrVPzLp8pIUg=
X-Google-Smtp-Source: AA+uWPy4+x717np/qynY9N0vpiisQ8xK0Exfxv/3Mr+88MJbyE7+yA03NtF/h55z1ypRwnUU5oi/1SO9gdwHem+isqg=
X-Received: by 2002:ab0:12e2:: with SMTP id o34-v6mr2849154uac.154.1533753996030;
 Wed, 08 Aug 2018 11:46:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180727154241.GA21288@duynguyen.home> <20180729103306.16403-1-pclouds@gmail.com>
 <20180729103306.16403-5-pclouds@gmail.com>
In-Reply-To: <20180729103306.16403-5-pclouds@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 8 Aug 2018 11:46:24 -0700
Message-ID: <CABPp-BGF+GZjm-DiveLjFOESKwPz2F0Y7X4_kXyem2xFo2odUw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] unpack-trees: cheaper index update when walking by cache-tree
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

On Sun, Jul 29, 2018 at 3:36 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
>
> With the new cache-tree, we could mostly avoid I/O (due to odb access)
> the code mostly becomes a loop of "check this, check that, add the
> entry to the index". We could skip a couple checks in this giant loop
> to go faster:
>
> - We know here that we're copying entries from the source index to the
>   result one. All paths in the source index must have been validated
>   at load time already (and we're not taking strange paths from tree
>   objects) which means we can skip verify_path() without compromise.
>
> - We also know that D/F conflicts can't happen for all these entries
>   (since cache-tree and all the trees are the same) so we can skip
>   that as well.
>
> This gives rather nice speedups for "unpack trees" rows where "unpack
> trees" time is now cut in half compared to when
> traverse_by_cache_tree() is added, or 1/7 of the original "unpack
> trees" time.
>
>    baseline      cache-tree    this patch
>  --------------------------------------------------------------------
>    0.018239226   0.019365414   0.020519621 s: read cache .git/index
>    0.052541655   0.049605548   0.048814384 s: preload index
>    0.001537598   0.001571695   0.001575382 s: refresh index
>    0.168167768   0.049677212   0.024719308 s: unpack trees
>    0.002897186   0.002845256   0.002805555 s: update worktree after a mer=
ge
>    0.131661745   0.136597522   0.134891617 s: repair cache-tree
>    0.075389117   0.075422517   0.074832291 s: write index, changed mask =
=3D 2a
>    0.111702023   0.032813253   0.008616479 s: unpack trees
>    0.000023245   0.000022002   0.000026630 s: update worktree after a mer=
ge
>    0.111793866   0.032933140   0.008714071 s: diff-index
>    0.587933288   0.398924370   0.380452871 s: git command: /home/pclouds/=
w/git/git
>
> Total saving of this new patch looks even less impressive, now that
> time spent in unpacking trees is so small. Which is why the next
> attempt should be on that "repair cache-tree" line.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  cache.h        |  1 +
>  read-cache.c   |  3 ++-
>  unpack-trees.c | 27 +++++++++++++++++++++++++++
>  unpack-trees.h |  1 +
>  4 files changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/cache.h b/cache.h
> index 8b447652a7..e6f7ee4b64 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -673,6 +673,7 @@ extern int index_name_pos(const struct index_state *,=
 const char *name, int name
>  #define ADD_CACHE_JUST_APPEND 8                /* Append only; tree.c::r=
ead_tree() */
>  #define ADD_CACHE_NEW_ONLY 16          /* Do not replace existing ones *=
/
>  #define ADD_CACHE_KEEP_CACHE_TREE 32   /* Do not invalidate cache-tree *=
/
> +#define ADD_CACHE_SKIP_VERIFY_PATH 64  /* Do not verify path */
>  extern int add_index_entry(struct index_state *, struct cache_entry *ce,=
 int option);
>  extern void rename_index_entry_at(struct index_state *, int pos, const c=
har *new_name);
>
> diff --git a/read-cache.c b/read-cache.c
> index e865254bea..b0b5df5de7 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1170,6 +1170,7 @@ static int add_index_entry_with_check(struct index_=
state *istate, struct cache_e
>         int ok_to_add =3D option & ADD_CACHE_OK_TO_ADD;
>         int ok_to_replace =3D option & ADD_CACHE_OK_TO_REPLACE;
>         int skip_df_check =3D option & ADD_CACHE_SKIP_DFCHECK;
> +       int skip_verify_path =3D option & ADD_CACHE_SKIP_VERIFY_PATH;
>         int new_only =3D option & ADD_CACHE_NEW_ONLY;
>
>         if (!(option & ADD_CACHE_KEEP_CACHE_TREE))
> @@ -1210,7 +1211,7 @@ static int add_index_entry_with_check(struct index_=
state *istate, struct cache_e
>
>         if (!ok_to_add)
>                 return -1;
> -       if (!verify_path(ce->name, ce->ce_mode))
> +       if (!skip_verify_path && !verify_path(ce->name, ce->ce_mode))
>                 return error("Invalid path '%s'", ce->name);
>
>         if (!skip_df_check &&
> diff --git a/unpack-trees.c b/unpack-trees.c
> index c33ebaf001..dc62afd968 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -201,6 +201,7 @@ static int do_add_entry(struct unpack_trees_options *=
o, struct cache_entry *ce,
>
>         ce->ce_flags =3D (ce->ce_flags & ~clear) | set;
>         return add_index_entry(&o->result, ce,
> +                              o->extra_add_index_flags |
>                                ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPL=
ACE);
>  }
>
> @@ -701,6 +702,24 @@ static int traverse_by_cache_tree(int pos, int nr_en=
tries, int nr_names,
>         if (!o->merge)
>                 BUG("We need cache-tree to do this optimization");
>
> +       /*
> +        * Try to keep add_index_entry() as fast as possible since
> +        * we're going to do a lot of them.
> +        *
> +        * Skipping verify_path() should totally be safe because these
> +        * paths are from the source index, which must have been
> +        * verified.
> +        *
> +        * Skipping D/F and cache-tree validation checks is trickier
> +        * because it assumes what n-merge code would do when all
> +        * trees and the index are the same. We probably could just
> +        * optimize those code instead (e.g. we don't invalidate that
> +        * many cache-tree, but the searching for them is very
> +        * expensive).
> +        */
> +       o->extra_add_index_flags =3D ADD_CACHE_SKIP_DFCHECK;
> +       o->extra_add_index_flags |=3D ADD_CACHE_SKIP_VERIFY_PATH;
> +

In sum of this whole patch, you notice that the Nway_merge functions
are still a bit of a bottleneck, but you know you have a special case
where you want them to put an entry in the index that matches what is
already there, so you try to set some extra flags to short-circuit
part of their logic and get to what you know is the correct result.

This seems a little scary to me.  I think it's probably safe as long
as o->fn is one of {oneway_merge, twoway_merge, threeway_merge,
bind_merge} (the cases you have in mind and which the current code
uses), but the caller isn't limited to those.  Right now in
diff-lib.c, there's a caller that has their own function, oneway_diff.
More could be added in the future.

If we're going to go this route, I think we should first check that
o->fn is one of those known safe functions.  And if we're going that
route, the comments I bring up on patch 2 about possibly avoiding
call_unpack_fn() altogether might even obviate this patch while
speeding things up more.

>         /*
>          * Do what unpack_callback() and unpack_nondirectories() normally
>          * do. But we walk all paths recursively in just one loop instead=
.
> @@ -742,6 +761,7 @@ static int traverse_by_cache_tree(int pos, int nr_ent=
ries, int nr_names,
>
>                 mark_ce_used(src[0], o);
>         }
> +       o->extra_add_index_flags =3D 0;
>         free(tree_ce);
>         if (o->debug_unpack)
>                 printf("Unpacked %d entries from %s to %s using cache-tre=
e\n",
> @@ -1561,6 +1581,13 @@ int unpack_trees(unsigned len, struct tree_desc *t=
, struct unpack_trees_options
>                 if (!ret) {
>                         if (!o->result.cache_tree)
>                                 o->result.cache_tree =3D cache_tree();
> +                       /*
> +                        * TODO: Walk o.src_index->cache_tree, quickly ch=
eck
> +                        * if o->result.cache has the exact same content =
for
> +                        * any valid cache-tree in o.src_index, then we c=
an
> +                        * just copy the cache-tree over instead of hashi=
ng a
> +                        * new tree object.
> +                        */

Interesting.  I really don't know how cache_tree works...but if we
avoided calling call_unpack_fn, and thus left the original index entry
in place instead of replacing it with an equal one, would that as a
side effect speed up the cache_tree_valid/cache_tree_update calls for
us?  Or is there still work here?

>                         if (!cache_tree_fully_valid(o->result.cache_tree)=
)
>                                 cache_tree_update(&o->result,
>                                                   WRITE_TREE_SILENT |
> diff --git a/unpack-trees.h b/unpack-trees.h
> index c2b434c606..94e1b14078 100644
> --- a/unpack-trees.h
> +++ b/unpack-trees.h
> @@ -80,6 +80,7 @@ struct unpack_trees_options {
>         struct index_state result;
>
>         struct exclude_list *el; /* for internal use */
> +       unsigned int extra_add_index_flags;
>  };
>
>  extern int unpack_trees(unsigned n, struct tree_desc *t,
> --
> 2.18.0.656.gda699b98b3
