Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900C4C433DB
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 16:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D07E6522A
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 16:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhCIQ5O (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 11:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhCIQ5L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 11:57:11 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CDAC06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 08:57:10 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id g4so9174724pgj.0
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 08:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BkrL4L5G/8bnKy5DMlvTjJcaRoTEwQssaMMsYOi8CHI=;
        b=DJsFibwoxcWrdBNLKquqcbTo/H0Xc6drT2Mx0uuHDqGqAgdG/MYvhDppwBYHUamFk6
         bugfbg6nOmyAn6/sEvmKuXGidFKjO6fUPv9ZVBxCcFT7t01ANjzMgvOeaIP/W1A6QWqH
         h4QhiKlSHzm45drzbeBzqqbAY2SuijdwN9jgcHb7KpxgeK0Qh3LrKdy6gw0OsvcgkCfs
         EBH4cKd8DlcKlOQmCZOvqX3ouW0Biy8mKjBbnWj944vKN9pYzgVhaU4uM4ZSwRciDv9r
         CVgeBqeusJoQ0/aNDDZW93OO8J/4tJhbL8PkwwFRa5fO5Um1j3tWJ7tt8z5ErsHXFYsc
         4wzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BkrL4L5G/8bnKy5DMlvTjJcaRoTEwQssaMMsYOi8CHI=;
        b=Z+qJ1Tg7b91+6MiXWCw3EuTPc33zb1Wf9L3jXn2c393O8A1rGDV9oMe+zRJeSn8oLq
         rKhHmlefU/+MR+PgdFRBYsUATXxxY09LiLJRvlJeQLahXyn6GqV9rJob/mDp8t/ZaAYu
         RRK9X8BtcUM5ZrV++mfceWKCiTh6a8ZxrrsL91UuvZK3dC0fMeLG/3Q7a5tM3Ct5Ozvv
         e6FMrD6Z/4fB7Us7J5WTcCRNbSSP22cYRefg4xhS+qTX7SrofXtzU9arPJDr/hhbndgs
         hrYgTazyYfLqECdiG1CIE2vQpywHAPAr1oF6NAyIaZO879oT/HiWETAxdfkn2RaKy3d6
         wjxA==
X-Gm-Message-State: AOAM530tnfDzAD+SdVCkdu1yOroASwurrBMC/54opFp9KTP/XdVUiR83
        VEc/xDC+qyucTPCh5p2Xg/1DYZKqZfVXlyhMkVtlWFeII6A=
X-Google-Smtp-Source: ABdhPJzlyp3Qt+Nhh9SI1Zp7uffZWmLeJU3YTzDgZSUvI3KwB12XXu/qJfNAtTc0WneyHH79YNc4pNIvRAi1DxSv7rg=
X-Received: by 2002:a63:1350:: with SMTP id 16mr25645682pgt.85.1615309030142;
 Tue, 09 Mar 2021 08:57:10 -0800 (PST)
MIME-Version: 1.0
References: <20210308022138.28166-1-avarab@gmail.com> <20210308150650.18626-7-avarab@gmail.com>
In-Reply-To: <20210308150650.18626-7-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 9 Mar 2021 08:56:59 -0800
Message-ID: <CABPp-BEZfG_pNNTWsnxEa1xG+kgpQfpXj=KHBkCBAMikrXj-aA@mail.gmail.com>
Subject: Re: [PATCH 06/30] cache.h: have base_name_compare() take "is tree?",
 not "mode"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 8, 2021 at 7:07 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> Change the base_name_compare() API and the related df_name_compare()
> function to take a boolean argument indicating whether the entry is a
> tree or not, instead of having them call S_ISDIR(mode) on their own.
>
> This makes use of the new "object_type" field in the "name_entry".
>
> The API being modified here was originally added way back in
> 958ba6c96eb (Introduce "base_name_compare()" helper function,
> 2005-05-20).
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/fast-import.c |  8 ++++----
>  builtin/mktree.c      |  4 ++--
>  cache.h               |  4 ++--
>  combine-diff.c        |  8 +++++---
>  match-trees.c         |  6 ++++--
>  merge-ort.c           |  4 ++--
>  merge-recursive.c     |  6 +++---
>  read-cache.c          | 16 ++++++++--------
>  tree-diff.c           |  7 +++++--
>  unpack-trees.c        | 15 ++++++++-------
>  10 files changed, 43 insertions(+), 35 deletions(-)
>
> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index dd4d09ceceb..ce4613c1595 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -1288,8 +1288,8 @@ static int tecmp0 (const void *_a, const void *_b)
>         struct tree_entry *a =3D *((struct tree_entry**)_a);
>         struct tree_entry *b =3D *((struct tree_entry**)_b);
>         return base_name_compare(
> -               a->name->str_dat, a->name->str_len, a->versions[0].mode,
> -               b->name->str_dat, b->name->str_len, b->versions[0].mode);
> +               a->name->str_dat, a->name->str_len, 1,
> +               b->name->str_dat, b->name->str_len, 1);
>  }
>
>  static int tecmp1 (const void *_a, const void *_b)
> @@ -1297,8 +1297,8 @@ static int tecmp1 (const void *_a, const void *_b)
>         struct tree_entry *a =3D *((struct tree_entry**)_a);
>         struct tree_entry *b =3D *((struct tree_entry**)_b);
>         return base_name_compare(
> -               a->name->str_dat, a->name->str_len, a->versions[1].mode,
> -               b->name->str_dat, b->name->str_len, b->versions[1].mode);
> +               a->name->str_dat, a->name->str_len, 1,
> +               b->name->str_dat, b->name->str_len, 1);
>  }

You've treated all files as directories, and in doing so broken the
sorting order of paths like the following
    foo
    foo.txt
foo needs to sort after foo.txt if it's a directory, and before
foo.txt if it's a file; that's the whole reason base_name_compare()
wants to know is_tree-ness.

It looks like we have a whole in our regression test coverage, since
they didn't catch this breakage.  (git will accept and work with trees
in the wrong sort-order, but it can create confusing diffs and
whatnot.)

>  static void mktree(struct tree_content *t, int v, struct strbuf *b)
> diff --git a/builtin/mktree.c b/builtin/mktree.c
> index 891991b00d6..2c1973229ac 100644
> --- a/builtin/mktree.c
> +++ b/builtin/mktree.c
> @@ -37,8 +37,8 @@ static int ent_compare(const void *a_, const void *b_)
>  {
>         struct treeent *a =3D *(struct treeent **)a_;
>         struct treeent *b =3D *(struct treeent **)b_;
> -       return base_name_compare(a->name, a->len, a->mode,
> -                                b->name, b->len, b->mode);
> +       return base_name_compare(a->name, a->len, S_ISDIR(a->mode),
> +                                b->name, b->len, S_ISDIR(b->mode));
>  }
>
>  static void write_tree(struct object_id *oid)
> diff --git a/cache.h b/cache.h
> index e513f0ee5b4..49994dae916 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1506,8 +1506,8 @@ int repo_interpret_branch_name(struct repository *r=
,
>
>  int validate_headref(const char *ref);
>
> -int base_name_compare(const char *name1, int len1, int mode1, const char=
 *name2, int len2, int mode2);
> -int df_name_compare(const char *name1, int len1, int mode1, const char *=
name2, int len2, int mode2);
> +int base_name_compare(const char *name1, int len1, int isdir1, const cha=
r *name2, int len2, int isdir2);
> +int df_name_compare(const char *name1, int len1, int isdir1, const char =
*name2, int len2, int isdir2);

A very minor nit/question:

Do we want to call this isdir or istree?  I know we use S_ISDIR() but
that's because it's a pre-existing macro pre-dating git.  As you
mentioned in your commit message, we want to know whether the object
in question is a git "tree", so I'm inclined to go with istree.

But, I'm probably bikeshedding here.

>  int name_compare(const char *name1, size_t len1, const char *name2, size=
_t len2);
>  int cache_name_stage_compare(const char *name1, int len1, int stage1, co=
nst char *name2, int len2, int stage2);
>
> diff --git a/combine-diff.c b/combine-diff.c
> index 9228aebc16b..64d7aaf1710 100644
> --- a/combine-diff.c
> +++ b/combine-diff.c
> @@ -16,11 +16,13 @@
>  static int compare_paths(const struct combine_diff_path *one,
>                           const struct diff_filespec *two)
>  {
> -       if (!S_ISDIR(one->mode) && !S_ISDIR(two->mode))
> +       int isdir_one =3D S_ISDIR(one->mode);
> +       int isdir_two =3D S_ISDIR(two->mode);
> +       if (!isdir_one && !isdir_two)
>                 return strcmp(one->path, two->path);
>
> -       return base_name_compare(one->path, strlen(one->path), one->mode,
> -                                two->path, strlen(two->path), two->mode)=
;
> +       return base_name_compare(one->path, strlen(one->path), isdir_one,
> +                                two->path, strlen(two->path), isdir_two)=
;
>  }
>
>  static int filename_changed(char status)
> diff --git a/match-trees.c b/match-trees.c
> index 1011357ad0c..4d124a0fd1b 100644
> --- a/match-trees.c
> +++ b/match-trees.c
> @@ -67,8 +67,10 @@ static void *fill_tree_desc_strict(struct tree_desc *d=
esc,
>  static int base_name_entries_compare(const struct name_entry *a,
>                                      const struct name_entry *b)
>  {
> -       return base_name_compare(a->path, tree_entry_len(a), a->mode,
> -                                b->path, tree_entry_len(b), b->mode);
> +       int isdira =3D a->object_type =3D=3D OBJ_TREE;
> +       int isdirb =3D b->object_type =3D=3D OBJ_TREE;
> +       return base_name_compare(a->path, tree_entry_len(a), isdira,
> +                                b->path, tree_entry_len(b), isdirb);
>  }
>
>  /*
> diff --git a/merge-ort.c b/merge-ort.c
> index 603d30c5217..4075d13aaab 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -2390,8 +2390,8 @@ static int tree_entry_order(const void *a_, const v=
oid *b_)
>
>         const struct merged_info *ami =3D a->util;
>         const struct merged_info *bmi =3D b->util;
> -       return base_name_compare(a->string, strlen(a->string), ami->resul=
t.mode,
> -                                b->string, strlen(b->string), bmi->resul=
t.mode);
> +       return base_name_compare(a->string, strlen(a->string), S_ISDIR(am=
i->result.mode),
> +                                b->string, strlen(b->string), S_ISDIR(bm=
i->result.mode));
>  }
>
>  static void write_tree(struct object_id *result_oid,
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 1593f374495..0baa6b5ca56 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -554,12 +554,12 @@ static int string_list_df_name_compare(const char *=
one, const char *two)
>          *
>          * To achieve this, we sort with df_name_compare and provide
>          * the mode S_IFDIR so that D/F conflicts will sort correctly.
> -        * We use the mode S_IFDIR for everything else for simplicity,
> +        * We say we have a directory for everything else for simplicity,
>          * since in other cases any changes in their order due to
>          * sorting cause no problems for us.
>          */
> -       int cmp =3D df_name_compare(one, onelen, S_IFDIR,
> -                                 two, twolen, S_IFDIR);
> +       int cmp =3D df_name_compare(one, onelen, 1, two, twolen, 1);
> +
>         /*
>          * Now that 'foo' and 'foo/bar' compare equal, we have to make su=
re
>          * that 'foo' comes before 'foo/bar'.
> diff --git a/read-cache.c b/read-cache.c
> index 1e9a50c6c73..edfce1f0cb8 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -462,8 +462,8 @@ int ie_modified(struct index_state *istate,
>         return 0;
>  }
>
> -int base_name_compare(const char *name1, int len1, int mode1,
> -                     const char *name2, int len2, int mode2)
> +int base_name_compare(const char *name1, int len1, int isdir1,
> +                     const char *name2, int len2, int isdir2)
>  {
>         unsigned char c1, c2;
>         int len =3D len1 < len2 ? len1 : len2;
> @@ -474,9 +474,9 @@ int base_name_compare(const char *name1, int len1, in=
t mode1,
>                 return cmp;
>         c1 =3D name1[len];
>         c2 =3D name2[len];
> -       if (!c1 && S_ISDIR(mode1))
> +       if (!c1 && isdir1)
>                 c1 =3D '/';
> -       if (!c2 && S_ISDIR(mode2))
> +       if (!c2 && isdir2)
>                 c2 =3D '/';
>         return (c1 < c2) ? -1 : (c1 > c2) ? 1 : 0;
>  }
> @@ -491,8 +491,8 @@ int base_name_compare(const char *name1, int len1, in=
t mode1,
>   * This is used by routines that want to traverse the git namespace
>   * but then handle conflicting entries together when possible.
>   */
> -int df_name_compare(const char *name1, int len1, int mode1,
> -                   const char *name2, int len2, int mode2)
> +int df_name_compare(const char *name1, int len1, int isdir1,
> +                   const char *name2, int len2, int isdir2)
>  {
>         int len =3D len1 < len2 ? len1 : len2, cmp;
>         unsigned char c1, c2;
> @@ -504,10 +504,10 @@ int df_name_compare(const char *name1, int len1, in=
t mode1,
>         if (len1 =3D=3D len2)
>                 return 0;
>         c1 =3D name1[len];
> -       if (!c1 && S_ISDIR(mode1))
> +       if (!c1 && isdir1)
>                 c1 =3D '/';
>         c2 =3D name2[len];
> -       if (!c2 && S_ISDIR(mode2))
> +       if (!c2 && isdir2)
>                 c2 =3D '/';
>         if (c1 =3D=3D '/' && !c2)
>                 return 0;
> diff --git a/tree-diff.c b/tree-diff.c
> index 7cebbb327e2..f133834597c 100644
> --- a/tree-diff.c
> +++ b/tree-diff.c
> @@ -50,6 +50,7 @@ static int tree_entry_pathcmp(struct tree_desc *t1, str=
uct tree_desc *t2)
>  {
>         struct name_entry *e1, *e2;
>         int cmp;
> +       int e1_is_tree, e2_is_tree;
>
>         /* empty descriptors sort after valid tree entries */
>         if (!t1->size)
> @@ -58,9 +59,11 @@ static int tree_entry_pathcmp(struct tree_desc *t1, st=
ruct tree_desc *t2)
>                 return -1;
>
>         e1 =3D &t1->entry;
> +       e1_is_tree =3D e1->object_type =3D=3D OBJ_TREE;

This would read slightly clearer with parenthesis around the right hand sid=
e.

>         e2 =3D &t2->entry;
> -       cmp =3D base_name_compare(e1->path, tree_entry_len(e1), e1->mode,
> -                               e2->path, tree_entry_len(e2), e2->mode);
> +       e2_is_tree =3D e2->object_type =3D=3D OBJ_TREE;

Same.

> +       cmp =3D base_name_compare(e1->path, tree_entry_len(e1), e1_is_tre=
e,
> +                               e2->path, tree_entry_len(e2), e2_is_tree)=
;
>         return cmp;
>  }
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index f5f668f532d..802f7771d75 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -922,7 +922,7 @@ static int traverse_trees_recursive(int n, unsigned l=
ong dirmask,
>  static int do_compare_entry_piecewise(const struct cache_entry *ce,
>                                       const struct traverse_info *info,
>                                       const char *name, size_t namelen,
> -                                     unsigned mode)
> +                                     unsigned is_tree)

isdir elsewhere and is_tree here?  ;-)

>  {
>         int pathlen, ce_len;
>         const char *ce_name;
> @@ -930,7 +930,7 @@ static int do_compare_entry_piecewise(const struct ca=
che_entry *ce,
>         if (info->prev) {
>                 int cmp =3D do_compare_entry_piecewise(ce, info->prev,
>                                                      info->name, info->na=
melen,
> -                                                    info->mode);
> +                                                    S_ISDIR(info->mode))=
;
>                 if (cmp)
>                         return cmp;
>         }
> @@ -944,13 +944,13 @@ static int do_compare_entry_piecewise(const struct =
cache_entry *ce,
>         ce_len -=3D pathlen;
>         ce_name =3D ce->name + pathlen;
>
> -       return df_name_compare(ce_name, ce_len, S_IFREG, name, namelen, m=
ode);
> +       return df_name_compare(ce_name, ce_len, 0, name, namelen, is_tree=
);
>  }
>
>  static int do_compare_entry(const struct cache_entry *ce,
>                             const struct traverse_info *info,
>                             const char *name, size_t namelen,
> -                           unsigned mode)
> +                           unsigned is_tree)
>  {
>         int pathlen, ce_len;
>         const char *ce_name;
> @@ -962,7 +962,7 @@ static int do_compare_entry(const struct cache_entry =
*ce,
>          * it is quicker to use the precomputed version.
>          */
>         if (!info->traverse_path)
> -               return do_compare_entry_piecewise(ce, info, name, namelen=
, mode);
> +               return do_compare_entry_piecewise(ce, info, name, namelen=
, is_tree);
>
>         cmp =3D strncmp(ce->name, info->traverse_path, info->pathlen);
>         if (cmp)
> @@ -977,12 +977,13 @@ static int do_compare_entry(const struct cache_entr=
y *ce,
>         ce_len -=3D pathlen;
>         ce_name =3D ce->name + pathlen;
>
> -       return df_name_compare(ce_name, ce_len, S_IFREG, name, namelen, m=
ode);
> +       return df_name_compare(ce_name, ce_len, 0, name, namelen, is_tree=
);
>  }
>
>  static int compare_entry(const struct cache_entry *ce, const struct trav=
erse_info *info, const struct name_entry *n)
>  {
> -       int cmp =3D do_compare_entry(ce, info, n->path, n->pathlen, n->mo=
de);
> +       int is_tree =3D n->object_type =3D=3D OBJ_TREE;

Another place where parentheses would speed my reading comprehension
just slightly.


> +       int cmp =3D do_compare_entry(ce, info, n->path, n->pathlen, is_tr=
ee);
>         if (cmp)
>                 return cmp;
>
> --
> 2.31.0.rc0.126.g04f22c5b82
