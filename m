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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79C8C43381
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 20:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD12D65259
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 20:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhCIUYW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 15:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbhCIUX7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 15:23:59 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403F8C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 12:23:53 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id f3so16362974oiw.13
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 12:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BVLG+7aq8EEnUahdUu1c8TF0LB2a6zyFxdaHdtsIIkk=;
        b=KAJ4/5NgXX63hGvW234RkhUNk3s4w7xngSKpdh1keV/w4+ZDaHwk0t2LJAxKPLzITk
         eIWeN1kVZx3JbA9U1nOqVPi+fju5MDwTUO+OGiM26cTBw+4jvOMZhgr8VgASVZy6FwON
         F7rc1l5ogz4Ez2V3OnYP84oNlcFz+21vaKftnlpvzRdNM/rbPuOL7BuwHQABKEu340+W
         q9U1rV2AwHeZzq625U083mpdDh4CFRWH52aZ3n+z45flsB04klcboZCia3ptCVw/fmBA
         QvLtBXkgnZ2gVvDZCAraqaiRMJ53VmQyPNzeqDsyV2q72JXPk4M2QRliuBjDQ/XR3reE
         Ouag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BVLG+7aq8EEnUahdUu1c8TF0LB2a6zyFxdaHdtsIIkk=;
        b=nERvP1d3lERT17bMyEbKo+VedYbeTYGUt7tgAUZTvfxKttvUHmfgoh5bne8w2DxVdE
         huH+sXbhss9m2Vs7w8w9Xo9FK8wg1zcNEnq3L/LpCuYihnqPCQYW6Xgprxc0cQAH0lvj
         qfjwR5tPhS8cVCF3HSRmIogyyHX7OS6lHSH8rd06FzAtJGr7Ig8nx57Tozc1Kw4GZ838
         4cGV6VxoT35tRcA7b1S5/cSJhzo/x0OLPZPzN68Yct3LxxqORFmMuW+TslTZaVllCRwh
         G6sLAaNcToo5AMP+NVHBERHopG2K51Z7ujLCk9SVJpOgHE3EnD2kvxecL6Z/d4I27Bv4
         hOvg==
X-Gm-Message-State: AOAM533Epy6c0leRPaYmlWi/0sblR41AAPvnL1kbyzE8BLa0qy/M6EKl
        eyZAe/szUY5CwEtnmAeFXh1k/JqI8ro6lUPepEU=
X-Google-Smtp-Source: ABdhPJz038s92iwvTq+EhLaoS7+BIyR1f/pyJDTJADxLXOGAVpUfL41b2k9eECzZWoAReGBARkQ/L53B0ctMZLubKq8=
X-Received: by 2002:a05:6808:a8a:: with SMTP id q10mr4090061oij.167.1615321431806;
 Tue, 09 Mar 2021 12:23:51 -0800 (PST)
MIME-Version: 1.0
References: <20210308022138.28166-1-avarab@gmail.com> <20210308150650.18626-31-avarab@gmail.com>
In-Reply-To: <20210308150650.18626-31-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 9 Mar 2021 12:23:40 -0800
Message-ID: <CABPp-BEPkukGz32rrro1hzMvSQzX4v7U17CAcV-G2NS6v0u55g@mail.gmail.com>
Subject: Re: [PATCH 30/30] tree-walk.h API: move canon_mode() back out of decode_tree_entry()
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
> Move the canon_mode() call back out of decode_tree_entry(), and
> instead make it the responsibility of its callers to canonicalize the
> tree modes we get.
>
> This effectively reverts 7146e66f086 (tree-walk: finally switch over
> tree descriptors to contain a pre-parsed entry, 2014-02-06), with the
> recent of most callers away from "mode" (now "raw_mode") towards "enum
> object_id" in recent commit the motivation for that commit effectively
> doesn't exist anymore.
>
> I.e. I'm not adding the canon_mode() call back to
> tree_entry_extract(), instead it's now become sane to move this
> responsibility to those callers that still care about the "raw_mode".
>
> That change was meant as a pure optimization change, but it actually
> introduced a subtle bug. We were left without any low-level API to get
> non-standard mode bits out of trees. Having non-standard modes isn't
> the norm, and fsck should warn about it.
>
> Except after 7146e66f086 it couldn't anymore, since the modes
> fsck_tree() got would be pre-sanitized for it. I believe that fsck
> issue is per-se a serious bug, the "bad mode" was a default warning,
> not an error.
>
> This change makes that fsck check work again, why aren't there any
> test changes for fsck here? Because we didn't have a test for that
> fsck feature in the first place, which is why the regression in
> 7146e66f086 snuck by us. A follow-up commit will add such a test.
>
> It is possible that this commit is introducing some subtle regression
> that I've missed.

I'm sure there are at least a few, and I suspect many more.  This is a
super scary change to me, even if it's only about corner cases that
should only exist in repositories that had objects created with super
old (or new and broken) git clients.

> We are now propagating the "raw_mode" outside of everything downstream
> of decode_tree_entry(), which is everything we have that decodes
> trees. It's our most low-level tree decoding API.
>
> As shown here we rely parsing out a "raw" (and possibly something fsck
> would complain about) mode as-is, but when we run merge, add something
> new to the index, create an archive etc. we don't want to propagate
> that bad mode when we create new data. We want to canon_mode() it.
>
> I'm also pretty sure that we don't have good enough test coverage for
> those scenarios. We barely have tests for these bad mode bits at
> all (not even one for fsck). We definitely are not testing all
> merge/index/archive etc. interactions.
>
> Still, I think this change is worth it overall, because:
>
>  1. We must have a way to get at these raw modes in some way, even if
>     just for fsck. There's also other things that care, see e.g. the
>     FIXME comment in 62fdec17a11 (merge-ort: flesh out implementation of
>     handle_content_merge(), 2021-01-01)
>
>  2. #1 is not a justification for this change, I could have e.g. just
>     added the ability to pass some "want_raw" flag into
>     decode_tree_entry() for use in fsck. But I think with the migration
>     of most tree iteration towards "enum object_type" it's become worth
>     it.

This seems like the safer route.  Then we can slowly convert callers
over to using the want_raw as we audit them and add appropriate tests.

>  3. Yes our test coverage sucks, but before 7146e66f086 we were also
>     spreading what's now the "raw_mode" all over the place. That commit
>     was first released with Git v2.0.0 in mid-2014. A while ago for sure,
>     but most of this code existed in something approximating its current
>     form then. This isn't new territory.

That's very helpful to know, actually.  That does lower my worry some.
But the fact that it was released as part of v2.0.0, a new major
release, suggests we knew there were potential breaking changes.  And
code has been built on top of those assumptions for quite a few years,
so we might again break things by reverting back, and having it be
part of a non-major release is worrisome without appropriate tests and
audits of the relevant code paths.

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  archive.c              |  2 +-
>  builtin/checkout.c     |  1 +
>  builtin/ls-files.c     |  2 +-
>  builtin/merge-tree.c   |  6 +++---
>  builtin/update-index.c |  1 +
>  merge-ort.c            | 13 ++++++++++++-
>  notes.c                |  1 +
>  tree-walk.c            |  1 -
>  unpack-trees.c         |  4 +++-

No tests...oh boy.  You did mention this in the commit message, but
I'm still having a hard time getting past making a very low level
change like this without either tests or bumping the major version
number of git.

>  9 files changed, 23 insertions(+), 8 deletions(-)
>
> diff --git a/archive.c b/archive.c
> index 5b85aae8106..8083f15f3ba 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -236,7 +236,7 @@ static int queue_or_write_archive_entry(const struct =
object_id *oid,
>                                         void *context)
>  {
>         struct archiver_context *c =3D context;
> -       unsigned mode =3D raw_mode;
> +       unsigned mode =3D canon_mode(raw_mode);
>
>         while (c->bottom &&
>                !(base->len >=3D c->bottom->len &&
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index d4adfdb5046..7f25b955616 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -132,6 +132,7 @@ static int update_some(const struct object_id *oid, s=
truct strbuf *base,
>         memcpy(ce->name + base->len, pathname, len - base->len);
>         ce->ce_flags =3D create_ce_flags(0) | CE_UPDATE;
>         ce->ce_namelen =3D len;
> +       mode =3D canon_mode(mode);
>         ce->ce_mode =3D create_ce_mode(mode);
>
>         /*
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index 391e6a9f141..926523d77a7 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -429,7 +429,7 @@ static int read_one_entry_opt(struct index_state *ist=
ate,
>  {
>         int len;
>         struct cache_entry *ce;
> -       unsigned mode =3D raw_mode;
> +       unsigned mode =3D canon_mode(raw_mode);
>
>         if (S_ISDIR(mode))
>                 return READ_TREE_RECURSIVE;
> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> index b4e736e4b72..f8733a86eb7 100644
> --- a/builtin/merge-tree.c
> +++ b/builtin/merge-tree.c
> @@ -197,9 +197,9 @@ static void resolve(const struct traverse_info *info,=
 struct name_entry *ours, s
>                 return;
>
>         path =3D traverse_path(info, result);
> -       orig_mode =3D ours->raw_mode;
> +       orig_mode =3D canon_mode(ours->raw_mode);
>         orig =3D create_entry(2, orig_mode, &ours->oid, path);
> -       final_mode =3D result->raw_mode;
> +       final_mode =3D canon_mode(result->raw_mode);
>         final =3D create_entry(0, final_mode, &result->oid, path);
>
>         final->link =3D orig;
> @@ -252,7 +252,7 @@ static struct merge_list *link_entry(unsigned stage, =
const struct traverse_info
>                 path =3D entry->path;
>         else
>                 path =3D traverse_path(info, n);
> -       link_mode =3D n->raw_mode;
> +       link_mode =3D canon_mode(n->raw_mode);
>         link =3D create_entry(stage, link_mode, &n->oid, path);
>
>         link->link =3D entry;
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index b489a876392..1996fdd97af 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -621,6 +621,7 @@ static struct cache_entry *read_one_ent(const char *w=
hich,
>         memcpy(ce->name, path, namelen);
>         ce->ce_flags =3D create_ce_flags(stage);
>         ce->ce_namelen =3D namelen;
> +       mode =3D canon_mode(mode);
>         ce->ce_mode =3D create_ce_mode(mode);
>         return ce;
>  }
> diff --git a/merge-ort.c b/merge-ort.c
> index ea20bbe2af3..d1e8a2823e0 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -502,7 +502,7 @@ static void setup_path_info(struct merge_options *opt=
,
>         mi->basename_offset =3D current_dir_name_len;
>         mi->clean =3D !!resolved;
>         if (resolved) {
> -               mi->result.mode =3D merged_version->raw_mode;
> +               mi->result.mode =3D canon_mode(merged_version->raw_mode);

canon_mode() will change a mode of 0 into S_IFGITLINK, so this is
wrong.  It's wrong in a way that probably doesn't matter, since
is_null will be true and that is checked in preference to mode =3D=3D 0
elsewhere, but the code should still be more careful.

>                 oidcpy(&mi->result.oid, &merged_version->oid);
>                 mi->is_null =3D !!is_null;
>         } else {
> @@ -512,6 +512,16 @@ static void setup_path_info(struct merge_options *op=
t,
>                 ASSIGN_AND_VERIFY_CI(ci, mi);
>                 for (i =3D MERGE_BASE; i <=3D MERGE_SIDE2; i++) {
>                         ci->pathnames[i] =3D fullpath;
> +                       /*
> +                        * We must not use canon_mode() here. Will
> +                        * fail on an the is_null assertion in
> +                        * 6a02dd90c99 (merge-ort: add a preliminary
> +                        * simple process_entries() implementation,
> +                        * 2020-12-13) when combined with the tests in
> +                        * "[PATCH 00/11] Complete merge-ort
> +                        * implementation...almost" (see
> +                        * https://lore.kernel.org/git/pull.973.git.git.1=
614905738.gitgitgadget@gmail.com/)
> +                        */
>                         ci->stages[i].mode =3D names[i].raw_mode;

I suspect the mapping of 0 to S_IFGITLINK might be the culprit here;
we're just lucky an assertion happened to catch this one.  (And
unlucky that nothing caught the one above.)

If you added a special check for that case and used canon_mode()
otherwise, I still think it'd be problematic, because the *only* value
of using raw_mode in the first place was that one special corner case
FIXME comment in handle_content_merge() -- that FIXME could only be
handled by allowing a wider range of modes, and if you canon_mode()
here, then handle_content_merge() only gets canonicalized modes.  At
that point, we might as well ask for special API from traverse_trees()
to just canonicalize for us (which, actually, sounds enticing).

>                         oidcpy(&ci->stages[i].oid, &names[i].oid);
>                 }
> @@ -546,6 +556,7 @@ static void add_pair(struct merge_options *opt,
>         int names_idx =3D is_add ? side : 0;
>         const struct object_id *oid =3D &names[names_idx].oid;
>         unsigned int mode =3D names[names_idx].raw_mode;
> +       mode =3D canon_mode(mode);

This is unnecessary; diffcore-rename.c only cares whether S_ISREG(mode).


Given that these are the only changes you made to merge-ort.c, and
this is the last patch in the series, my earlier comments and worries
about merge-ort from a few patches ago all look like justified
concerns and make me pretty sure you've introduced some regressions
relating to those.  (Namely, the fact that things comparing modes now
have to worry not about equality, but equality under
canonicalization.)

>         one =3D alloc_filespec(pathname);
>         two =3D alloc_filespec(pathname);
> diff --git a/notes.c b/notes.c
> index 2817325651a..78b1b38d36b 100644
> --- a/notes.c
> +++ b/notes.c
> @@ -479,6 +479,7 @@ static void load_subtree(struct notes_tree *t, struct=
 leaf_node *subtree,
>                         const char *q =3D oid_to_hex(&subtree->key_oid);
>                         size_t i;
>                         unsigned int mode =3D entry.raw_mode;
> +                       mode =3D canon_mode(mode);
>                         for (i =3D 0; i < prefix_len; i++) {
>                                 strbuf_addch(&non_note_path, *q++);
>                                 strbuf_addch(&non_note_path, *q++);
> diff --git a/tree-walk.c b/tree-walk.c
> index 099a9b3bd77..3175430d049 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -47,7 +47,6 @@ static int decode_tree_entry(struct tree_desc *desc, co=
nst char *buf, unsigned l
>
>         /* Initialize the descriptor entry */
>         desc->entry.path =3D path;
> -       mode =3D canon_mode(mode);
>         desc->entry.raw_mode =3D mode;
>         desc->entry.object_type =3D object_type(mode);
>         desc->entry.pathlen =3D len - 1;
> diff --git a/unpack-trees.c b/unpack-trees.c
> index dcdf8130745..2fb346714b3 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -868,6 +868,7 @@ static int traverse_trees_recursive(int n, unsigned l=
ong dirmask,
>         newinfo.name =3D p->path;
>         newinfo.namelen =3D p->pathlen;
>         newinfo.mode =3D p->raw_mode;
> +       newinfo.mode =3D canon_mode(newinfo.mode);
>         newinfo.pathlen =3D st_add3(newinfo.pathlen, tree_entry_len(p), 1=
);
>         newinfo.df_conflicts |=3D df_conflicts;
>
> @@ -1020,7 +1021,8 @@ static struct cache_entry *create_ce_entry(const st=
ruct traverse_info *info,
>                 is_transient ?
>                 make_empty_transient_cache_entry(len) :
>                 make_empty_cache_entry(istate, len);
> -       unsigned int mode =3D n->raw_mode;
> +       unsigned int mode =3D canon_mode(n->raw_mode);
> +       mode =3D canon_mode(mode);

It looks like nearly everything in unpack_trees() goes through
create_ce_entry() so perhaps just these two hunks are good enough to
make sure unpack-trees.c and all its callers are dealing with
canonicalized modes.

Except now merge-recursive.c is some weird hybrid were some of its
modes come from unpack-trees (canonicalized), some come diff_tree_oid
(non-canonicalized as far as I can tell above) and various calls to
get_tree_entry_* (also non-canonicalized).  I suspect there are
various bugs there, similar in nature to the ones in merge-ort but
much harder to stamp out given the facts that merge-recursive gets
modes from many more places, and the fact that merge-recursive tends
to do many more comparisons due to checking for each type of
combination of conflicts and having special code for each one
resulting in combinatorial increasing number of nearly-duplicated
codepaths.  merge-recursive is probably a caller that really needs a
way to request that all calls it makes (directly or indirectly) to any
tree walking just return canonicalized modes.

>
>         ce->ce_mode =3D create_ce_mode(mode);
>         ce->ce_flags =3D create_ce_flags(stage);
> --

The fact that there are no canon_mode() calls in the diff machinery
makes me wonder if we've changed the behavior for diff/log whenever
there is an object with old modes around.  Perhaps that's a desired
change, but it seems like it should certainly be tested and
documented.  What about all callers of the diff machinery, though?
Are they prepared for such diffs?  One simple example is that
fast-export uses the revision walking and diff machinery, and without
canonicalized modes anymore, it would just print the raw modes.
fast-import sanely won't accept raw modes; it only wants canonical
modes.  So with this change, people may no longer be able to
round-trip fast-export output through fast-import on their existing
repositories.

I also don't like the fact that there is no canonicalization of modes
before writing objects to the git object store.  I believe mktree,
merge-ort, notes (unless your one change to that file is enough but
I'm suspect that it is) are all affected.  match-trees appears to be
affected, but is only called by merge-ort and merge-recursive to
create a temporary merge-base, though the "temporary" tree object will
continue to live in the git object store and could be accessed by
users.  cache-tree.c also writes trees out, but only using ce_mode
which looks like it is everywhere set by calls to e.g.
create_ce_mode(...).  fast-import also writes direct tree objects, but
it doesn't get its modes from reading tree objects, and sanitizes the
inputs it does get.  So, perhaps most tree writers are still sane, but
I'm certain merge-ort would need updates and I suspect mktree and
notes do too.  I think match-trees ought to be updated just for
cleanliness.  And I may have missed other places that directly write
trees out.

I'm worried there's a number of other regressions lurking; those are
just ones I thought about in areas of the code I'm more familiar with.
