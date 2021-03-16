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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD42C433E0
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 05:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66783651B9
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 05:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhCPFuC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 01:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbhCPFtd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 01:49:33 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD13FC06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 22:49:33 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id m21-20020a9d7ad50000b02901b83efc84a0so6280925otn.10
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 22:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QH6jo5uUWSAC+iPPBiwnM0y+GQ028lKWxn8ewNfDT6w=;
        b=lbjiuRJ6StTNwHAeI9orb2HxisCcAcgXXO4PRzCgrUyp0gdE6uGK1iwoelHC/7jPQc
         M/aPwaHc5pdzI2UZtzXEO5P/i9+oZS+ua4BzjB2bbvJlFQdmABNQvYLztollvkBOZVSl
         LS/0hDz60z1k7wbX+w69y06JRSNA/Q1ii150zRu4DXNq5oWU3T11QR1th94fZ/Eklke/
         6kVa22YAvRQzT8SKDhJZdp6LUB6qjO6Igamui8Y0nVVIZl5nv7vXanYS8zw5sLW6kviN
         TIvvjeROG6HXCKHHosGNJEaZTVoRKGdYz6wljyrq3f/JMAqLiVtnmQpiHQUTIT1lQ95x
         po5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QH6jo5uUWSAC+iPPBiwnM0y+GQ028lKWxn8ewNfDT6w=;
        b=pG8prvhwsPvKaPaiOvRTZ2dKbJrs5ATVp0ev+H4kGQR+gM4an7wbOvuBL6g3ZoDLrH
         9s9JZ7V+q+aHSwSNJOWfHvt7dbqNUtIOyPPco+Bl3JOA1GSAohc4J+8y8B7JNY8vccpL
         lj77qUkl4L0oACz/RUK/QxGAhrb4ngatBuObc9mEch//OdyExLiKKKfcmWHUO5w6mFF6
         1tr8bFfWO35Kb1p8Wl9z+ogDXu+uneNIJWy/B5XdrR/8x5of1ck7RejuVhtbB0ckhAD2
         SMkqtQZjcCijgL4l6QlHU7Hpf8czzM+5KOvxVrtbYSJsq0yLVnPdH0aSwERV3jqmv10g
         8KBA==
X-Gm-Message-State: AOAM533ZlAL+V6Kqo0DsZmIbXHkJAr60qqya/6BNuXiiJnYo95N9ve9b
        vME0SeqCQHflLSdENJbUd//M+/SOyuAdvpKiyYs=
X-Google-Smtp-Source: ABdhPJx29U4Qu7znC1CvloftlWTP5dF9XFrr7/BHPHctyiWb3LZJHSZEG4EP7Tlk8hmgnKuxpd1/xpXx43Z2IGqxyUI=
X-Received: by 2002:a9d:8d5:: with SMTP id 79mr2195285otf.345.1615873773071;
 Mon, 15 Mar 2021 22:49:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210308150650.18626-1-avarab@gmail.com> <20210316021312.13927-7-avarab@gmail.com>
In-Reply-To: <20210316021312.13927-7-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 15 Mar 2021 22:49:22 -0700
Message-ID: <CABPp-BGE+e1er6qFuG90j9+eVG34O8TN=imX=jtcb+jbQjN1QQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/29] cache.h: have base_name_compare() take "is
 tree?", not "mode"
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

On Mon, Mar 15, 2021 at 7:13 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
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

Um...these last two hunks have not changed since the last round.  They
introduce a nasty bug, as mentioned in my review last time and
highlighted in my response on the cover letter.  They need to be
fixed, and more testcases verifying their correct operation should be
added.

This is the kind of thing that makes me really scared about these
refactorings; it's too easy to introduce changes that will write
semi-broken objects in the wild, which we will then have to deal with
for the rest of forever.

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
> index ae0c0bef5c2..e38b1e1688c 100644
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
> +int base_name_compare(const char *name1, int len1, int istree1, const ch=
ar *name2, int len2, int istree2);
> +int df_name_compare(const char *name1, int len1, int istree1, const char=
 *name2, int len2, int istree2);
>  int name_compare(const char *name1, size_t len1, const char *name2, size=
_t len2);
>  int cache_name_stage_compare(const char *name1, int len1, int stage1, co=
nst char *name2, int len2, int stage2);
>
> diff --git a/combine-diff.c b/combine-diff.c
> index 9228aebc16b..ad7058a6f5d 100644
> --- a/combine-diff.c
> +++ b/combine-diff.c
> @@ -16,11 +16,13 @@
>  static int compare_paths(const struct combine_diff_path *one,
>                           const struct diff_filespec *two)
>  {
> -       if (!S_ISDIR(one->mode) && !S_ISDIR(two->mode))
> +       int istree_one =3D S_ISDIR(one->mode);
> +       int istree_two =3D S_ISDIR(two->mode);
> +       if (!istree_one && !istree_two)
>                 return strcmp(one->path, two->path);
>
> -       return base_name_compare(one->path, strlen(one->path), one->mode,
> -                                two->path, strlen(two->path), two->mode)=
;
> +       return base_name_compare(one->path, strlen(one->path), istree_one=
,
> +                                two->path, strlen(two->path), istree_two=
);
>  }
>
>  static int filename_changed(char status)
> diff --git a/match-trees.c b/match-trees.c
> index 1011357ad0c..a28c19a62a5 100644
> --- a/match-trees.c
> +++ b/match-trees.c
> @@ -67,8 +67,10 @@ static void *fill_tree_desc_strict(struct tree_desc *d=
esc,
>  static int base_name_entries_compare(const struct name_entry *a,
>                                      const struct name_entry *b)
>  {
> -       return base_name_compare(a->path, tree_entry_len(a), a->mode,
> -                                b->path, tree_entry_len(b), b->mode);
> +       int istree_a =3D (a->object_type =3D=3D OBJ_TREE);
> +       int istree_b =3D (b->object_type =3D=3D OBJ_TREE);
> +       return base_name_compare(a->path, tree_entry_len(a), istree_a,
> +                                b->path, tree_entry_len(b), istree_b);
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
> index 3d9207455b3..1c9b08695a3 100644
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
> index 1e9a50c6c73..4257fbd8a08 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -462,8 +462,8 @@ int ie_modified(struct index_state *istate,
>         return 0;
>  }
>
> -int base_name_compare(const char *name1, int len1, int mode1,
> -                     const char *name2, int len2, int mode2)
> +int base_name_compare(const char *name1, int len1, int istree1,
> +                     const char *name2, int len2, int istree2)
>  {
>         unsigned char c1, c2;
>         int len =3D len1 < len2 ? len1 : len2;
> @@ -474,9 +474,9 @@ int base_name_compare(const char *name1, int len1, in=
t mode1,
>                 return cmp;
>         c1 =3D name1[len];
>         c2 =3D name2[len];
> -       if (!c1 && S_ISDIR(mode1))
> +       if (!c1 && istree1)
>                 c1 =3D '/';
> -       if (!c2 && S_ISDIR(mode2))
> +       if (!c2 && istree2)
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
> +int df_name_compare(const char *name1, int len1, int istree1,
> +                   const char *name2, int len2, int istree2)
>  {
>         int len =3D len1 < len2 ? len1 : len2, cmp;
>         unsigned char c1, c2;
> @@ -504,10 +504,10 @@ int df_name_compare(const char *name1, int len1, in=
t mode1,
>         if (len1 =3D=3D len2)
>                 return 0;
>         c1 =3D name1[len];
> -       if (!c1 && S_ISDIR(mode1))
> +       if (!c1 && istree1)
>                 c1 =3D '/';
>         c2 =3D name2[len];
> -       if (!c2 && S_ISDIR(mode2))
> +       if (!c2 && istree2)
>                 c2 =3D '/';
>         if (c1 =3D=3D '/' && !c2)
>                 return 0;
> diff --git a/tree-diff.c b/tree-diff.c
> index 7cebbb327e2..6ec180331fb 100644
> --- a/tree-diff.c
> +++ b/tree-diff.c
> @@ -50,6 +50,7 @@ static int tree_entry_pathcmp(struct tree_desc *t1, str=
uct tree_desc *t2)
>  {
>         struct name_entry *e1, *e2;
>         int cmp;
> +       int istree_e1, istree_e2;
>
>         /* empty descriptors sort after valid tree entries */
>         if (!t1->size)
> @@ -58,9 +59,11 @@ static int tree_entry_pathcmp(struct tree_desc *t1, st=
ruct tree_desc *t2)
>                 return -1;
>
>         e1 =3D &t1->entry;
> +       istree_e1 =3D (e1->object_type =3D=3D OBJ_TREE);
>         e2 =3D &t2->entry;
> -       cmp =3D base_name_compare(e1->path, tree_entry_len(e1), e1->mode,
> -                               e2->path, tree_entry_len(e2), e2->mode);
> +       istree_e2 =3D (e2->object_type =3D=3D OBJ_TREE);
> +       cmp =3D base_name_compare(e1->path, tree_entry_len(e1), istree_e1=
,
> +                               e2->path, tree_entry_len(e2), istree_e2);
>         return cmp;
>  }
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index eb8fcda31ba..d9d573df986 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -925,7 +925,7 @@ static int traverse_trees_recursive(int n, unsigned l=
ong dirmask,
>  static int do_compare_entry_piecewise(const struct cache_entry *ce,
>                                       const struct traverse_info *info,
>                                       const char *name, size_t namelen,
> -                                     unsigned mode)
> +                                     unsigned istree)
>  {
>         int pathlen, ce_len;
>         const char *ce_name;
> @@ -933,7 +933,7 @@ static int do_compare_entry_piecewise(const struct ca=
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
> @@ -947,13 +947,13 @@ static int do_compare_entry_piecewise(const struct =
cache_entry *ce,
>         ce_len -=3D pathlen;
>         ce_name =3D ce->name + pathlen;
>
> -       return df_name_compare(ce_name, ce_len, S_IFREG, name, namelen, m=
ode);
> +       return df_name_compare(ce_name, ce_len, 0, name, namelen, istree)=
;
>  }
>
>  static int do_compare_entry(const struct cache_entry *ce,
>                             const struct traverse_info *info,
>                             const char *name, size_t namelen,
> -                           unsigned mode)
> +                           unsigned istree)
>  {
>         int pathlen, ce_len;
>         const char *ce_name;
> @@ -965,7 +965,7 @@ static int do_compare_entry(const struct cache_entry =
*ce,
>          * it is quicker to use the precomputed version.
>          */
>         if (!info->traverse_path)
> -               return do_compare_entry_piecewise(ce, info, name, namelen=
, mode);
> +               return do_compare_entry_piecewise(ce, info, name, namelen=
, istree);
>
>         cmp =3D strncmp(ce->name, info->traverse_path, info->pathlen);
>         if (cmp)
> @@ -980,12 +980,13 @@ static int do_compare_entry(const struct cache_entr=
y *ce,
>         ce_len -=3D pathlen;
>         ce_name =3D ce->name + pathlen;
>
> -       return df_name_compare(ce_name, ce_len, S_IFREG, name, namelen, m=
ode);
> +       return df_name_compare(ce_name, ce_len, 0, name, namelen, istree)=
;
>  }
>
>  static int compare_entry(const struct cache_entry *ce, const struct trav=
erse_info *info, const struct name_entry *n)
>  {
> -       int cmp =3D do_compare_entry(ce, info, n->path, n->pathlen, n->mo=
de);
> +       int istree =3D (n->object_type =3D=3D OBJ_TREE);
> +       int cmp =3D do_compare_entry(ce, info, n->path, n->pathlen, istre=
e);
>         if (cmp)
>                 return cmp;
>
> --
> 2.31.0.rc2.211.g1d0b8788b3

The isdir -> istree updates are nice; thanks.
