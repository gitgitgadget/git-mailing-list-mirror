Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 308AC208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 18:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbeHHUoN (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 16:44:13 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:43272 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeHHUoN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 16:44:13 -0400
Received: by mail-ua0-f193.google.com with SMTP id f4-v6so3417938uao.10
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 11:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wJE5cyw+s3/nm6xjObdYKV6kGZxJG9gmtdBrEnHgaOI=;
        b=L3q5iIpd8A+/4fXS04Qh6C21bG/2K4LmZvxzvpDIYuh5CTkIMediD/9Jv6L8LYPM+a
         5bpQmJErI8NR5E/DK3uQCxsXk1CjnvS5A7/pAVkPUprE38vZlWxM44HzVvXjtOTje5B4
         n/mtfy3X7/L2YyTSRdCCpxVHo8YWZNv5mDZy9N3lTMUhrbIbDLWnfDJv8EyPQEeTEaYY
         whkE8IbrD+2TrvaMkWIrWlpVMj2qHeIlCiORRuoTlaeYRQM/JNz5Xu/Ck/bTDjcasScH
         Ri+tjvdA4dJ3eN6otImIvG3SsehJ7G8FOeFQSkNL2uLuaNzRH4dKRsUqsnrCxl0By7V7
         CbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wJE5cyw+s3/nm6xjObdYKV6kGZxJG9gmtdBrEnHgaOI=;
        b=hPHW/3po/Spm/KkBOLFQxHI04EcfqmoqUr/LAH9Sr1bHGbc4M6zCU1be/cpVFpzagD
         jxUjmgL8xTlCduoChtmDOY3yGYY/qtLs4fXwm+Ao0S84PqWPCCu54QrEvmI/4dxICEiw
         sl/J2aFiX0xhnL550QyIpGuER4h2iHUcr41eCL12nbs/vvSIYe6ZmOyidFyrVuPX/uSa
         zv8GrCue4QStDtDkM+DS54wA6p7GxEpnHCIDIDcKTjPidWLpkxf51rfNWkZ9YjytliBJ
         CIUAItX0aI4O7MTo7dXXNQ+1fHGjVPrJE5aibpZW9SY46Mk5Zo2Tozjufu8y9a/3aotB
         YCmg==
X-Gm-Message-State: AOUpUlFAcglekeyOc0S6uvfa3e75b8q++dqVDdRe0EoaUd9nRvP0pNik
        LKcoQDil5KliNQQLoXjrZnTb+wXBvwbjiTxZo0U=
X-Google-Smtp-Source: AA+uWPyKxfhWiPigjAjoMMdMN4QLuR0RSfLBpkVRhYOXbbZD6CwafoeVFF7//eAYCAm1G9Wj41aSekoFbKu9Ldhqr3I=
X-Received: by 2002:a9f:3666:: with SMTP id s35-v6mr2943989uad.94.1533752597913;
 Wed, 08 Aug 2018 11:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180729103306.16403-1-pclouds@gmail.com> <20180804053723.4695-1-pclouds@gmail.com>
 <20180804053723.4695-3-pclouds@gmail.com>
In-Reply-To: <20180804053723.4695-3-pclouds@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 8 Aug 2018 11:23:05 -0700
Message-ID: <CABPp-BGcPV0RA624_1UOXYkvaNhW4yR2ifhV_MVFZQOgBb_Ydg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] unpack-trees: optimize walking same trees with cache-tree
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
> From: Duy Nguyen <pclouds@gmail.com>
>
> In order to merge one or many trees with the index, unpack-trees code
> walks multiple trees in parallel with the index and performs n-way
> merge. If we find out at start of a directory that all trees are the
> same (by comparing OID) and cache-tree happens to be available for
> that directory as well, we could avoid walking the trees because we
> already know what these trees contain: it's flattened in what's called
> "the index".

This is cool.

> The upside is of course a lot less I/O since we can potentially skip
> lots of trees (think subtrees). We also save CPU because we don't have
> to inflate and the apply deltas. The downside is of course more

s/and the apply/and apply the/

> fragile code since the logic in some functions are now duplicated
> elsewhere.
>
> "checkout -" with this patch on gcc.git:
>
>     baseline      new
>   --------------------------------------------------------------------
>     0.018239226   0.019365414 s: read cache .git/index
>     0.052541655   0.049605548 s: preload index
>     0.001537598   0.001571695 s: refresh index
>     0.168167768   0.049677212 s: unpack trees
>     0.002897186   0.002845256 s: update worktree after a merge
>     0.131661745   0.136597522 s: repair cache-tree
>     0.075389117   0.075422517 s: write index, changed mask =3D 2a
>     0.111702023   0.032813253 s: unpack trees
>     0.000023245   0.000022002 s: update worktree after a merge
>     0.111793866   0.032933140 s: diff-index
>     0.587933288   0.398924370 s: git command: /home/pclouds/w/git/git
>
> Another measurement from Ben's running "git checkout" with over 500k
> trees (on the whole series):
>
>     baseline        new
>   ----------------------------------------------------------------------
>     0.535510167     0.556558733     s: read cache .git/index
>     0.3057373       0.3147105       s: initialize name hash
>     0.0184082       0.023558433     s: preload index
>     0.086910967     0.089085967     s: refresh index
>     7.889590767     2.191554433     s: unpack trees
>     0.120760833     0.131941267     s: update worktree after a merge
>     2.2583504       2.572663167     s: repair cache-tree
>     0.8916137       0.959495233     s: write index, changed mask =3D 28
>     3.405199233     0.2710663       s: unpack trees
>     0.000999667     0.0021554       s: update worktree after a merge
>     3.4063306       0.273318333     s: diff-index
>     16.9524923      9.462943133     s: git command: git.exe checkout
>
> This command calls unpack_trees() twice, the first time on 2way merge
> and the second 1way merge. In both times, "unpack trees" time is
> reduced to one third. Overall time reduction is not that impressive of
> course because index operations take a big chunk. And there's that
> repair cache-tree line.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  unpack-trees.c | 117 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 117 insertions(+)
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index a32ddee159..ba3d2e947e 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -644,6 +644,102 @@ static inline int are_same_oid(struct name_entry *n=
ame_j, struct name_entry *nam
>         return name_j->oid && name_k->oid && !oidcmp(name_j->oid, name_k-=
>oid);
>  }
>
> +static int all_trees_same_as_cache_tree(int n, unsigned long dirmask,
> +                                       struct name_entry *names,
> +                                       struct traverse_info *info)
> +{
> +       struct unpack_trees_options *o =3D info->data;
> +       int i;
> +
> +       if (!o->merge || dirmask !=3D ((1 << n) - 1))
> +               return 0;
> +
> +       for (i =3D 1; i < n; i++)
> +               if (!are_same_oid(names, names + i))
> +                       return 0;
> +
> +       return cache_tree_matches_traversal(o->src_index->cache_tree, nam=
es, info);
> +}

I was curious whether this could also be extended in the case of a
merge; as long as HEAD and MERGE have the same tree, even if the base
commit doesn't match, we can still just use the tree from HEAD which
should be in the current index/cache_tree.  However, it'd be a
somewhat odd history for HEAD and MERGE to match on some significantly
sized tree when the base commit doesn't also match.

> +
> +static int index_pos_by_traverse_info(struct name_entry *names,
> +                                     struct traverse_info *info)
> +{
> +       struct unpack_trees_options *o =3D info->data;
> +       int len =3D traverse_path_len(info, names);
> +       char *name =3D xmalloc(len + 1 /* slash */ + 1 /* NUL */);
> +       int pos;
> +
> +       make_traverse_path(name, info, names);
> +       name[len++] =3D '/';
> +       name[len] =3D '\0';
> +       pos =3D index_name_pos(o->src_index, name, len);
> +       if (pos >=3D 0)
> +               BUG("This is a directory and should not exist in index");
> +       pos =3D -pos - 1;
> +       if (!starts_with(o->src_index->cache[pos]->name, name) ||
> +           (pos > 0 && starts_with(o->src_index->cache[pos-1]->name, nam=
e)))
> +               BUG("pos must point at the first entry in this directory"=
);
> +       free(name);
> +       return pos;
> +}
> +
> +/*
> + * Fast path if we detect that all trees are the same as cache-tree at t=
his
> + * path. We'll walk these trees recursively using cache-tree/index inste=
ad of
> + * ODB since already know what these trees contain.
> + */
> +static int traverse_by_cache_tree(int pos, int nr_entries, int nr_names,
> +                                 struct name_entry *names,
> +                                 struct traverse_info *info)
> +{
> +       struct cache_entry *src[MAX_UNPACK_TREES + 1] =3D { NULL, };
> +       struct unpack_trees_options *o =3D info->data;
> +       int i, d;
> +
> +       if (!o->merge)
> +               BUG("We need cache-tree to do this optimization");
> +
> +       /*
> +        * Do what unpack_callback() and unpack_nondirectories() normally
> +        * do. But we walk all paths recursively in just one loop instead=
.
> +        *
> +        * D/F conflicts and staged entries are not a concern because

"staged entries"?  Do you mean "higher stage entries"?  I'm not sure
the correct terminology here, but the former makes me think of changes
the user has staged but not committed (i.e. stuff found at stage #0 in
the index, but which isn't found in any tree yet) vs. the latter which
I'd use to refer to entries at stages 1 or higher.

> +        * cache-tree would be invalidated and we would never get here
> +        * in the first place.
> +        */
> +       for (i =3D 0; i < nr_entries; i++) {
> +               struct cache_entry *tree_ce;
> +               int len, rc;
> +
> +               src[0] =3D o->src_index->cache[pos + i];
> +
> +               len =3D ce_namelen(src[0]);
> +               tree_ce =3D xcalloc(1, cache_entry_size(len));
> +
> +               tree_ce->ce_mode =3D src[0]->ce_mode;
> +               tree_ce->ce_flags =3D create_ce_flags(0);
> +               tree_ce->ce_namelen =3D len;
> +               oidcpy(&tree_ce->oid, &src[0]->oid);
> +               memcpy(tree_ce->name, src[0]->name, len + 1);

We do a bunch of work to setup tree_ce...

> +               for (d =3D 1; d <=3D nr_names; d++)
> +                       src[d] =3D tree_ce;

...then we make nr_names copies of tree_ce (so that *way_merge or
bind_merge or oneway_diff or whatever will have the expected number of
entries).

> +               rc =3D call_unpack_fn((const struct cache_entry * const *=
)src, o);

...then we call o->fn (via call_unpack_fn) to do various complicated
logic to figure out which tree_ce to use??  Isn't that just an
expensive way to recompute that what we currently have in the index is
what we want to keep there?

Granted, a caller of this may have set o->fn to something other than
{one,two,three}way_merge (or bind_merge), and that function might have
important side effects...but it just seems annoying to have to do so
much work when for most uses we already know the entry in the index is
the one we already want.  In fact, the only other thing in the
codebase that o->fn is now set to is oneway_diff, which I think is a
no-op when the two trees match.

Would be nice if we could avoid all this, at least in the common cases
where o->fn is a function known to not have side effects.  Or did I
not read those functions closely enough and they do have important
side effects?

> +               free(tree_ce);
> +               if (rc < 0)
> +                       return rc;
> +
> +               mark_ce_used(src[0], o);
> +       }
> +       if (o->debug_unpack)
> +               printf("Unpacked %d entries from %s to %s using cache-tre=
e\n",
> +                      nr_entries,
> +                      o->src_index->cache[pos]->name,
> +                      o->src_index->cache[pos + nr_entries - 1]->name);
> +       return 0;
> +}
> +
>  static int traverse_trees_recursive(int n, unsigned long dirmask,
>                                     unsigned long df_conflicts,
>                                     struct name_entry *names,
> @@ -655,6 +751,17 @@ static int traverse_trees_recursive(int n, unsigned =
long dirmask,
>         void *buf[MAX_UNPACK_TREES];
>         struct traverse_info newinfo;
>         struct name_entry *p;
> +       int nr_entries;
> +
> +       nr_entries =3D all_trees_same_as_cache_tree(n, dirmask, names, in=
fo);
> +       if (nr_entries > 0) {
> +               struct unpack_trees_options *o =3D info->data;
> +               int pos =3D index_pos_by_traverse_info(names, info);
> +
> +               if (!o->merge || df_conflicts)
> +                       BUG("Wrong condition to get here buddy");

heh.  :)

> +               return traverse_by_cache_tree(pos, nr_entries, n, names, =
info);
> +       }
>
>         p =3D names;
>         while (!p->mode)
> @@ -814,6 +921,11 @@ static struct cache_entry *create_ce_entry(const str=
uct traverse_info *info, con
>         return ce;
>  }
>
> +/*
> + * Note that traverse_by_cache_tree() duplicates some logic in this func=
tion
> + * without actually calling it. If you change the logic here you may nee=
d to
> + * check and change there as well.
> + */
>  static int unpack_nondirectories(int n, unsigned long mask,
>                                  unsigned long dirmask,
>                                  struct cache_entry **src,
> @@ -998,6 +1110,11 @@ static void debug_unpack_callback(int n,
>                 debug_name_entry(i, names + i);
>  }
>
> +/*
> + * Note that traverse_by_cache_tree() duplicates some logic in this func=
iton

s/funciton/function/

> + * without actually calling it. If you change the logic here you may nee=
d to
> + * check and change there as well.
> + */
>  static int unpack_callback(int n, unsigned long mask, unsigned long dirm=
ask, struct name_entry *names, struct traverse_info *info)
>  {
>         struct cache_entry *src[MAX_UNPACK_TREES + 1] =3D { NULL, };
> --
> 2.18.0.656.gda699b98b3
