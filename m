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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E90C433E0
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 18:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8847B65237
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 18:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhCISy1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 13:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhCISyF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 13:54:05 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0511BC06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 10:54:04 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id u6so8752276oic.2
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 10:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hkr5Ff0c7QVOPeBNzmUQ5bvG31H7xKdadOr+kZcvnw4=;
        b=YJx6fXFvHvtZHDnW7xPU77wHCVeSRBKCqm6y4RR+zvLKsF/+M/8+zTmj4WnIJ07gI4
         hNKdiAeR8EP5Usz+Tp0PPG9kPWniLvJwxtwPfHhN4LL911r4SPYRrCYZQIEpxOKnptIS
         wr0Tz/90V1gtb1+CNU66rFKQemFHWQWcKrOSXu6Hf9jFtUjzcQE92hWHa8uc3jiEzNHB
         LLxN6qznGePxswqbfwghTnzYbd/BGaxn5r4twyC9vjd6lSwZzOGpuJSzZWjuMjaylhNL
         rtlojrMf/ONUoKwaE7ZTf7jhkCbDdRAOCBL0HJzWMbZcalJaYbS5i4NXbHU1VqIqf/iw
         Alpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hkr5Ff0c7QVOPeBNzmUQ5bvG31H7xKdadOr+kZcvnw4=;
        b=mG10JYJWr7Y9S4jxm+ETKMnl+AMNkBtW+2OQP/eiDHz4s1B86CO+2qCfFZ9XF1ur7a
         PffDmngHYX8iBQd6YT98xDaDjYd82IfBKTIkQw8fkCx/5AamCVKkrRFCBPHGizW3zYqz
         jx+d7RdBZsM6B64MTf1gaDLGWnEidwEhPX1gppOzUNCvFGgB4GCyNX4FAv9Ys0OBUSXk
         CAXdTpyRmbQ5GdVCgTCjx6fzhie5lanTQF5bB/z+L5S7GT/nWDxOMtr7ba/H/lnxGx6L
         p8HBt9V5R1tD8q9hVygydMd6pN/iGcz6YIq8PHQ+L2751QHkQzehLNO6ej0+uoTY3xBn
         bm6g==
X-Gm-Message-State: AOAM53288yoeipcbNgOfYtH0sVJN212Cv8y21I8mkwPzJ3epu/vHIo/6
        PNdWNBoxBcIGdk+5khetYUDJSIjbGF1y+oqX270=
X-Google-Smtp-Source: ABdhPJwjHM74if0svv/nG/Okm+gV5T7ww9ZZnaKpiHScFyrWMLoEdYiBMxcsMgABAP9sPXK/5dhQwONlCO8lXG8Er3A=
X-Received: by 2002:a05:6808:a8a:: with SMTP id q10mr3843542oij.167.1615316044119;
 Tue, 09 Mar 2021 10:54:04 -0800 (PST)
MIME-Version: 1.0
References: <20210308022138.28166-1-avarab@gmail.com> <20210308150650.18626-29-avarab@gmail.com>
In-Reply-To: <20210308150650.18626-29-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 9 Mar 2021 10:53:53 -0800
Message-ID: <CABPp-BFrVCZF-tWUXqJckbEvNPxjFxtTE3_uUpkLv_ARTb2X6g@mail.gmail.com>
Subject: Re: [PATCH 28/30] tree-walk.h API users: rename "struct name_entry"'s
 "mode" to "raw_mode"
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
> Now that most of the users of the "mode" variable have been moved to
> use "object_type" instead let's rename it to "raw_mode" in preparation
> for a revert of 7146e66f086 (tree-walk: finally switch over tree
> descriptors to contain a pre-parsed entry, 2014-02-06).
>
> This will allow API users who care about the actual mode bits in tree
> objects to get access to them, such as fsck, the merge algorithm etc.

If you're going to feed the raw mode bits through to the merge
algorithm, then the merge algorithm logic needs to change in several
places to accommodate have raw modes instead of canonicalized modes.
I'm also curious what the other places are.  For example, will the
diff machinery show a diff now for files whose raw_mode differs even
if the canonicalized mode does not?  This would be a behavioral
change, but I'm getting ahead of myself since I should probably wait
until the subsequent patches to see what you did.

> But most users will not want to have such potentially un-sanitized, so
> let's indicate that by giving the variable a more scary name.
>
> I am not renaming the variables being assigned to, i.e. it's now going
> to be "int mode =3D entry.raw_mode", not "int raw_mode =3D [...]". This i=
s
> because we're going to be getting a sanitized "mode" via
> "canon_mode()" in many of these functions soon, so renaming the local
> variable back and forth will result in needless churn.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/merge-tree.c |  8 ++++----
>  match-trees.c        |  4 ++--
>  merge-ort.c          | 12 ++++++------
>  notes.c              |  2 +-
>  tree-diff.c          | 22 +++++++++++-----------
>  tree-walk.c          |  2 +-
>  tree-walk.h          |  6 +++---
>  tree.c               |  2 +-
>  unpack-trees.c       |  6 +++---
>  9 files changed, 32 insertions(+), 32 deletions(-)
>
> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> index eec5b906561..b4e736e4b72 100644
> --- a/builtin/merge-tree.c
> +++ b/builtin/merge-tree.c
> @@ -160,7 +160,7 @@ static int same_entry(struct name_entry *a, struct na=
me_entry *b)
>         return  !is_null_oid(&a->oid) &&
>                 !is_null_oid(&b->oid) &&
>                 oideq(&a->oid, &b->oid) &&
> -               a->mode =3D=3D b->mode;
> +               a->raw_mode =3D=3D b->raw_mode;

This looks like a case that probably should operate on canonicalized modes.

>  }
>
>  static int both_empty(struct name_entry *a, struct name_entry *b)
> @@ -197,9 +197,9 @@ static void resolve(const struct traverse_info *info,=
 struct name_entry *ours, s
>                 return;
>
>         path =3D traverse_path(info, result);
> -       orig_mode =3D ours->mode;
> +       orig_mode =3D ours->raw_mode;
>         orig =3D create_entry(2, orig_mode, &ours->oid, path);
> -       final_mode =3D result->mode;
> +       final_mode =3D result->raw_mode;
>         final =3D create_entry(0, final_mode, &result->oid, path);
>
>         final->link =3D orig;
> @@ -252,7 +252,7 @@ static struct merge_list *link_entry(unsigned stage, =
const struct traverse_info
>                 path =3D entry->path;
>         else
>                 path =3D traverse_path(info, n);
> -       link_mode =3D n->mode;
> +       link_mode =3D n->raw_mode;
>         link =3D create_entry(stage, link_mode, &n->oid, path);
>
>         link->link =3D entry;
> diff --git a/match-trees.c b/match-trees.c
> index 0636f6e58e9..d45c76ffa79 100644
> --- a/match-trees.c
> +++ b/match-trees.c
> @@ -86,8 +86,8 @@ static int score_trees(const struct object_id *hash1, c=
onst struct object_id *ha
>
>         for (;;) {
>                 int cmp;
> -               unsigned int one_mode =3D one.entry.mode;
> -               unsigned int two_mode =3D two.entry.mode;
> +               unsigned int one_mode =3D one.entry.raw_mode;
> +               unsigned int two_mode =3D two.entry.raw_mode;
>
>                 if (one.size && two.size)
>                         cmp =3D base_name_entries_compare(&one.entry, &tw=
o.entry);
> diff --git a/merge-ort.c b/merge-ort.c
> index cad10436504..ea20bbe2af3 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -502,7 +502,7 @@ static void setup_path_info(struct merge_options *opt=
,
>         mi->basename_offset =3D current_dir_name_len;
>         mi->clean =3D !!resolved;
>         if (resolved) {
> -               mi->result.mode =3D merged_version->mode;
> +               mi->result.mode =3D merged_version->raw_mode;

This seems scary.

>                 oidcpy(&mi->result.oid, &merged_version->oid);
>                 mi->is_null =3D !!is_null;
>         } else {
> @@ -512,7 +512,7 @@ static void setup_path_info(struct merge_options *opt=
,
>                 ASSIGN_AND_VERIFY_CI(ci, mi);
>                 for (i =3D MERGE_BASE; i <=3D MERGE_SIDE2; i++) {
>                         ci->pathnames[i] =3D fullpath;
> -                       ci->stages[i].mode =3D names[i].mode;
> +                       ci->stages[i].mode =3D names[i].raw_mode;

likewise.

>                         oidcpy(&ci->stages[i].oid, &names[i].oid);
>                 }
>                 ci->filemask =3D filemask;
> @@ -545,7 +545,7 @@ static void add_pair(struct merge_options *opt,
>         struct rename_info *renames =3D &opt->priv->renames;
>         int names_idx =3D is_add ? side : 0;
>         const struct object_id *oid =3D &names[names_idx].oid;
> -       unsigned int mode =3D names[names_idx].mode;
> +       unsigned int mode =3D names[names_idx].raw_mode;
>
>         one =3D alloc_filespec(pathname);
>         two =3D alloc_filespec(pathname);
> @@ -616,13 +616,13 @@ static int collect_merge_info_callback(int n,
>         unsigned side1_null =3D !(mask & 2);
>         unsigned side2_null =3D !(mask & 4);
>         unsigned side1_matches_mbase =3D (!side1_null && !mbase_null &&
> -                                       names[0].mode =3D=3D names[1].mod=
e &&
> +                                       names[0].raw_mode =3D=3D names[1]=
.raw_mode &&
>                                         oideq(&names[0].oid, &names[1].oi=
d));
>         unsigned side2_matches_mbase =3D (!side2_null && !mbase_null &&
> -                                       names[0].mode =3D=3D names[2].mod=
e &&
> +                                       names[0].raw_mode =3D=3D names[2]=
.raw_mode &&
>                                         oideq(&names[0].oid, &names[2].oi=
d));
>         unsigned sides_match =3D (!side1_null && !side2_null &&
> -                               names[1].mode =3D=3D names[2].mode &&
> +                               names[1].raw_mode =3D=3D names[2].raw_mod=
e &&
>                                 oideq(&names[1].oid, &names[2].oid));

If these three really start operating on the raw_mode, then this logic
will be wrong.  100644 and 100666 should be considered "equal and
matching" for the purposes used here.

>         /*
> diff --git a/notes.c b/notes.c
> index aa46cb2b09e..2817325651a 100644
> --- a/notes.c
> +++ b/notes.c
> @@ -478,7 +478,7 @@ static void load_subtree(struct notes_tree *t, struct=
 leaf_node *subtree,
>                         struct strbuf non_note_path =3D STRBUF_INIT;
>                         const char *q =3D oid_to_hex(&subtree->key_oid);
>                         size_t i;
> -                       unsigned int mode =3D entry.mode;
> +                       unsigned int mode =3D entry.raw_mode;
>                         for (i =3D 0; i < prefix_len; i++) {
>                                 strbuf_addch(&non_note_path, *q++);
>                                 strbuf_addch(&non_note_path, *q++);
> diff --git a/tree-diff.c b/tree-diff.c
> index 10c92d39c42..df8301d806a 100644
> --- a/tree-diff.c
> +++ b/tree-diff.c
> @@ -232,7 +232,7 @@ static struct combine_diff_path *emit_path(struct com=
bine_diff_path *p,
>                          * tp[i] is valid, if present and if tp[i]=3D=3Dt=
p[imin] -
>                          * otherwise, we should ignore it.
>                          */
> -                       int tpi_valid =3D tp && !(tp[i].entry.mode & S_IF=
XMIN_NEQ);
> +                       int tpi_valid =3D tp && !(tp[i].entry.raw_mode & =
S_IFXMIN_NEQ);
>
>                         const struct object_id *oid_i;
>                         unsigned mode_i;
> @@ -245,7 +245,7 @@ static struct combine_diff_path *emit_path(struct com=
bine_diff_path *p,
>
>                         if (tpi_valid) {
>                                 oid_i =3D &tp[i].entry.oid;
> -                               mode_i =3D tp[i].entry.mode;
> +                               mode_i =3D tp[i].entry.raw_mode;

I don't know tree-diff enough but I'm wondering if it has similar
issues to merge-ort.

>                         }
>                         else {
>                                 oid_i =3D &null_oid;
> @@ -283,7 +283,7 @@ static struct combine_diff_path *emit_path(struct com=
bine_diff_path *p,
>                 FAST_ARRAY_ALLOC(parents_oid, nparent);
>                 for (i =3D 0; i < nparent; ++i) {
>                         /* same rule as in emitthis */
> -                       int tpi_valid =3D tp && !(tp[i].entry.mode & S_IF=
XMIN_NEQ);
> +                       int tpi_valid =3D tp && !(tp[i].entry.raw_mode & =
S_IFXMIN_NEQ);
>
>                         parents_oid[i] =3D tpi_valid ? &tp[i].entry.oid :=
 NULL;
>                 }
> @@ -404,7 +404,7 @@ static inline void update_tp_entries(struct tree_desc=
 *tp, int nparent)
>  {
>         int i;
>         for (i =3D 0; i < nparent; ++i)
> -               if (!(tp[i].entry.mode & S_IFXMIN_NEQ))
> +               if (!(tp[i].entry.raw_mode & S_IFXMIN_NEQ))
>                         update_tree_entry(&tp[i]);
>  }
>
> @@ -465,10 +465,10 @@ static struct combine_diff_path *ll_diff_tree_paths=
(
>                  * mark entries whether they =3Dp[imin] along the way
>                  */
>                 imin =3D 0;
> -               tp[0].entry.mode &=3D ~S_IFXMIN_NEQ;
> +               tp[0].entry.raw_mode &=3D ~S_IFXMIN_NEQ;
>
>                 for (i =3D 1; i < nparent; ++i) {
> -                       unsigned int mode =3D tp[i].entry.mode;
> +                       unsigned int mode =3D tp[i].entry.raw_mode;
>                         cmp =3D tree_entry_pathcmp(&tp[i], &tp[imin]);
>                         if (cmp < 0) {
>                                 imin =3D i;
> @@ -480,12 +480,12 @@ static struct combine_diff_path *ll_diff_tree_paths=
(
>                         else {
>                                 mode |=3D S_IFXMIN_NEQ;
>                         }
> -                       tp[i].entry.mode =3D mode;
> +                       tp[i].entry.raw_mode =3D mode;
>                 }
>
>                 /* fixup markings for entries before imin */
>                 for (i =3D 0; i < imin; ++i)
> -                       tp[i].entry.mode |=3D S_IFXMIN_NEQ;       /* pi >=
 p[imin] */
> +                       tp[i].entry.raw_mode |=3D S_IFXMIN_NEQ;   /* pi >=
 p[imin] */
>
>
>
> @@ -497,14 +497,14 @@ static struct combine_diff_path *ll_diff_tree_paths=
(
>                         /* are either pi > p[imin] or diff(t,pi) !=3D =C3=
=B8 ? */
>                         if (!opt->flags.find_copies_harder) {
>                                 for (i =3D 0; i < nparent; ++i) {
> -                                       unsigned int mode =3D tp[i].entry=
.mode;
> +                                       unsigned int mode =3D tp[i].entry=
.raw_mode;
>                                         /* p[i] > p[imin] */
>                                         if (mode & S_IFXMIN_NEQ)
>                                                 continue;
>
>                                         /* diff(t,pi) !=3D =C3=B8 */
>                                         if (!oideq(&t.entry.oid, &tp[i].e=
ntry.oid) ||
> -                                           (t.entry.mode !=3D mode))
> +                                           (t.entry.raw_mode !=3D mode))
>                                                 continue;
>
>                                         goto skip_emit_t_tp;
> @@ -536,7 +536,7 @@ static struct combine_diff_path *ll_diff_tree_paths(
>                         /* =E2=88=80i pi=3Dp[imin] -> D +=3D "-p[imin]" *=
/
>                         if (!opt->flags.find_copies_harder) {
>                                 for (i =3D 0; i < nparent; ++i)
> -                                       if (tp[i].entry.mode & S_IFXMIN_N=
EQ)
> +                                       if (tp[i].entry.raw_mode & S_IFXM=
IN_NEQ)
>                                                 goto skip_emit_tp;
>                         }
>
> diff --git a/tree-walk.c b/tree-walk.c
> index 12e0ed4e250..099a9b3bd77 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -48,7 +48,7 @@ static int decode_tree_entry(struct tree_desc *desc, co=
nst char *buf, unsigned l
>         /* Initialize the descriptor entry */
>         desc->entry.path =3D path;
>         mode =3D canon_mode(mode);
> -       desc->entry.mode =3D mode;
> +       desc->entry.raw_mode =3D mode;
>         desc->entry.object_type =3D object_type(mode);
>         desc->entry.pathlen =3D len - 1;
>         hashcpy(desc->entry.oid.hash, (const unsigned char *)path + len);
> diff --git a/tree-walk.h b/tree-walk.h
> index 1f69e57db4c..885ced74258 100644
> --- a/tree-walk.h
> +++ b/tree-walk.h
> @@ -16,7 +16,7 @@ struct name_entry {
>         struct object_id oid;
>         const char *path;
>         int pathlen;
> -       unsigned int mode;
> +       unsigned int raw_mode;
>         /* simple 'mode': Only OBJ_{BLOB,TREE,COMMIT} */
>         enum object_type object_type;
>  };
> @@ -55,7 +55,7 @@ static inline const struct object_id *tree_entry_extrac=
t_mode(struct tree_desc *
>                                                               unsigned sh=
ort *modep)
>  {
>         *pathp =3D desc->entry.path;
> -       *modep =3D desc->entry.mode;
> +       *modep =3D desc->entry.raw_mode;
>         return &desc->entry.oid;
>  }
>
> @@ -75,7 +75,7 @@ static inline const struct object_id *tree_entry_extrac=
t_all(struct tree_desc *d
>                                                              enum object_=
type *object_typep)
>  {
>         *pathp =3D desc->entry.path;
> -       *modep =3D desc->entry.mode;
> +       *modep =3D desc->entry.raw_mode;
>         *object_typep =3D desc->entry.object_type;
>         return &desc->entry.oid;
>  }
> diff --git a/tree.c b/tree.c
> index e4402fad69b..215d17e1295 100644
> --- a/tree.c
> +++ b/tree.c
> @@ -40,7 +40,7 @@ static int read_tree_1(struct repository *r,
>                 }
>
>                 switch (fn(&entry.oid, base,
> -                          entry.path, entry.object_type, entry.mode, con=
text)) {
> +                          entry.path, entry.object_type, entry.raw_mode,=
 context)) {
>                 case 0:
>                         continue;
>                 case READ_TREE_RECURSIVE:
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 9471c19de72..dcdf8130745 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -867,7 +867,7 @@ static int traverse_trees_recursive(int n, unsigned l=
ong dirmask,
>         newinfo.pathspec =3D info->pathspec;
>         newinfo.name =3D p->path;
>         newinfo.namelen =3D p->pathlen;
> -       newinfo.mode =3D p->mode;
> +       newinfo.mode =3D p->raw_mode;

Oh boy...unpack-trees too?

Well, all of my worries may be unfounded depending on what you do in
subsequent commits.

>         newinfo.pathlen =3D st_add3(newinfo.pathlen, tree_entry_len(p), 1=
);
>         newinfo.df_conflicts |=3D df_conflicts;
>
> @@ -1020,7 +1020,7 @@ static struct cache_entry *create_ce_entry(const st=
ruct traverse_info *info,
>                 is_transient ?
>                 make_empty_transient_cache_entry(len) :
>                 make_empty_cache_entry(istate, len);
> -       unsigned int mode =3D n->mode;
> +       unsigned int mode =3D n->raw_mode;
>
>         ce->ce_mode =3D create_ce_mode(mode);
>         ce->ce_flags =3D create_ce_flags(stage);
> @@ -1209,7 +1209,7 @@ static void debug_path(struct traverse_info *info)
>  static void debug_name_entry(int i, struct name_entry *n)
>  {
>         printf("ent#%d %06o %s\n", i,
> -              n->path ? n->mode : 0,
> +              n->path ? n->raw_mode : 0,
>                n->path ? n->path : "(missing)");
>  }
>
> --
> 2.31.0.rc0.126.g04f22c5b82
>
