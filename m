Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0871BC433DB
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 07:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B627664F69
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 07:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhCPHEl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 03:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhCPHEN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 03:04:13 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E51C06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 00:04:12 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 101-20020a9d04ee0000b02901b506659320so6349062otm.7
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 00:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VILn2ETRgBB+NPPMoNDwS7f8ti+0DxYo5EyiLJT22LU=;
        b=ZA/s4lMOXUaGsQZRVq8dzqeGYt66yCcdcnbb8Yb4ewfZp/NvRnCt3MVI4RwbVFfWjK
         AbGCMnKezmCxYMp0VtTACxKAfuYmL/OgrYkzAqf1yomN13m7lf37IKLunZVLxDi76D5I
         838PiS+fVV8x84N5xm3q7c8EGz/uJyFXR/8dcptV2RZJKs431THmssvreIaWxlMzZPEP
         0mHPHCxrZXP1DFxrAdodLYzYcz3pjdMchje2kupjT0OchxT97RqPvk2mvaDoz+oEC56J
         nyye1NabiSmrDUzbD21xaZ/Rx2YFVEATO89rJGl1+7eD0/yDzGE5GvF2FdPdea26BGmY
         phTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VILn2ETRgBB+NPPMoNDwS7f8ti+0DxYo5EyiLJT22LU=;
        b=WkPT37rnVMq0ha+B6JefvMw7vfa8Xy8sWEAliJMejwNCS7AZonR4J9OhV0wQRPSjRL
         zZv868A+9kbGWw+/TPsRi+fpCkDV7ZzyKPvc+4S5d9aopQwpeAMVnDBlpEraTrC0CYKl
         AEMofbnuJHHMtN3c1J0gNZL3CNp33Z/BHj9YIjYP+txMugCp31RQ3igwwO4EuLyJX+YI
         xI1wTBpz2UeTk4u62huyWBvuekx2PdCM5wwSmvf5q/l2wZguOkqUHt/v9wDLL1O1bnAR
         bfj2qUhGkwN5lZbVA4XaljtSuhSR3D6OUrNQU691js5nwE2Nto5n40QhKLH1Hwl41N9p
         x5iA==
X-Gm-Message-State: AOAM532wYi7jE/qjRLbE4yp/Gq1IONPUdjNiV8JumXE9op1Am1XrUkJT
        zd2TMYcy7eQjkmey1V5FtrxLKI0/OSXj1K5YXPI=
X-Google-Smtp-Source: ABdhPJzwt17nrNNU4oOneWx/Fs1+2ZxfH8D7dmgcSZSOoJBkgtIp93JR0/W4iQFrNqWJGtvBGxtCgB8hlKFnP7V+6Rc=
X-Received: by 2002:a9d:8d5:: with SMTP id 79mr2451558otf.345.1615878251954;
 Tue, 16 Mar 2021 00:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210308150650.18626-1-avarab@gmail.com> <20210316021312.13927-1-avarab@gmail.com>
In-Reply-To: <20210316021312.13927-1-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 16 Mar 2021 00:04:00 -0700
Message-ID: <CABPp-BHnz-_633UZycnaD1Mj9vrhSJ4RA6yUr4F7dvZwyOJBiA@mail.gmail.com>
Subject: Re: [PATCH v2 00/29] tree-walk: mostly replace "mode" with "enum object_type"
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
> A v2 of the big tree-walk.[ch] refactoring series, goals etc. at the
> v1 at:
> https://lore.kernel.org/git/20210308150650.18626-1-avarab@gmail.com/
>
> It is based on my just-re-rolled v3 read_tree_recursive() series:
> https://lore.kernel.org/git/20210315234344.28427-1-avarab@gmail.com/
>
> This version should address all the feedback on v1 for patces 1-27/30,
> thanks to Elijah for very valuable comments on v1.
>
> It's mostly small nits here and there, except:
>
>  - I found that the change I'd made to update-index.c was buggy at the
>    point it was introduced in the series, the object_type would be
>    uninitialized. There were/are no tests for that, but I've moved
>    things around so we don't have that bug anymore.
>
>  - Elijah had a comment on whether we needed oid_object_info() in
>    blame.c. As it turns out we don't need a "is blob?" check at all
>    there. There's a new 28/29 to refactor that small part of blame.c,
>    along with a test.
>
> What this re-roll *does not* include is the final 28-30/30 part of v1
> to s/mode/raw_mode/g and move canonical_mode() out of tree-walk.h.
>
> So a follow-up series will still be needed to fix the fsck.c check for
> bad modes, but I wanted to split that tricker change off from this
> rather big initial refactoring.

Splitting those trickier bits off makes sense.

This series looks really good and addresses most of my feedback from
v1.  There were two commit message wording comments in patches 21 and
27 leftover from the previous round, and a nasty bug introduced in
patch 6 still left from the previous round.

I also had a question on the new testcase in patch 28.

Other than that, though, the series looks good to me.

>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (29):
>   diff.c: remove redundant canon_mode() call
>   notes & match-trees: use name_entry's "pathlen" member
>   cache.h: add a comment to object_type()
>   tree-walk.h: add object_type member to name_entry
>   tree-walk.c: migrate to using new "object_type" field when possible
>   cache.h: have base_name_compare() take "is tree?", not "mode"
>   tree-walk.h users: switch object_type(...) to new .object_type
>   tree.h: format argument lists of read_tree_recursive() users
>   tree.h users: format argument lists in archive.c
>   archive: get rid of 'stage' parameter
>   tree.h API: make read_tree_fn_t take an "enum object_type"
>   tree-walk.h users: migrate "p->mode &&" pattern
>   tree-walk.h users: refactor chained "mode" if/else into switch
>   tree-walk.h users: migrate miscellaneous "mode" to "object_type"
>   merge-tree tests: test for the mode comparison in same_entry()
>   merge-ort: correct reference to test in 62fdec17a11
>   fsck.c: switch on "object_type" in fsck_walk_tree()
>   tree-walk.h users: use temporary variable(s) for "mode"
>   tree-walk.h API: formatting changes for subsequent commit
>   tree-walk.h API: rename get_tree_entry() to get_tree_entry_mode()
>   tree-walk.h API users: use "tmp" for mode in shift_tree_by()
>   tree-walk.h API: add get_tree_entry_type()
>   tree-walk.h API: document and format tree_entry_extract()
>   tree-entry.h API: rename tree_entry_extract() to
>     tree_entry_extract_mode()
>   tree-walk.h API: add a tree_entry_extract_all() function
>   tree-walk.h API: add get_tree_entry_all()
>   tree-walk.h API: add a get_tree_entry_path() function
>   blame: emit a better error on 'git blame directory'
>   tree-walk.h API: add a tree_entry_extract_type() function
>
>  archive.c                       | 50 +++++++++---------
>  blame.c                         |  9 ++--
>  builtin/checkout.c              |  6 ++-
>  builtin/fast-import.c           |  8 +--
>  builtin/grep.c                  |  6 +--
>  builtin/log.c                   |  7 +--
>  builtin/ls-files.c              |  6 ++-
>  builtin/ls-tree.c               | 14 +++---
>  builtin/merge-tree.c            | 30 +++++++----
>  builtin/mktree.c                |  4 +-
>  builtin/pack-objects.c          |  6 +--
>  builtin/reflog.c                |  3 +-
>  builtin/rm.c                    |  2 +-
>  builtin/update-index.c          |  6 ++-
>  cache-tree.c                    |  2 +-
>  cache.h                         | 11 ++--
>  combine-diff.c                  |  8 +--
>  delta-islands.c                 |  2 +-
>  diff.c                          |  2 +-
>  fsck.c                          | 23 ++++-----
>  http-push.c                     |  6 ++-
>  line-log.c                      |  2 +-
>  list-objects.c                  | 20 +++++---
>  match-trees.c                   | 52 +++++++++----------
>  merge-ort.c                     | 13 ++---
>  merge-recursive.c               | 33 ++++++------
>  notes.c                         | 14 +++---
>  object-name.c                   |  7 ++-
>  pack-bitmap-write.c             |  8 +--
>  read-cache.c                    | 16 +++---
>  revision.c                      | 12 +++--
>  t/t4300-merge-tree.sh           | 44 ++++++++++++++++
>  t/t8004-blame-with-conflicts.sh | 20 ++++++++
>  tree-diff.c                     | 30 +++++++----
>  tree-walk.c                     | 89 ++++++++++++++++++++++++---------
>  tree-walk.h                     | 63 ++++++++++++++++++++---
>  tree.c                          | 19 ++++---
>  tree.h                          |  5 +-
>  unpack-trees.c                  | 24 +++++----
>  walker.c                        | 22 ++++----
>  40 files changed, 460 insertions(+), 244 deletions(-)
>
> Range-diff:
>  1:  e5df57c3440 =3D  1:  f9bbc30f69f diff.c: remove redundant canon_mode=
() call
>  2:  8c2500bbf35 =3D  2:  187fc2c3e64 notes & match-trees: use name_entry=
's "pathlen" member
>  3:  3d98e0c132f !  3:  311637c5583 cache.h: add a comment to object_type=
()
>     @@ Commit message
>          cache.h: add a comment to object_type()
>
>          Add a comment to the object_type() function to explain what it
>     -    returns, and whet the "mode" is in the "else" case.
>     +    returns, and what the "mode" is in the "else" case.
>
>          The object_type() function dates back to 4d1012c3709 (Fix rev-li=
st
>          when showing objects involving submodules, 2007-11-11). It's not
>  4:  ce5808b317c =3D  4:  fecfe3d462c tree-walk.h: add object_type member=
 to name_entry
>  5:  18f26531acf =3D  5:  db961ab5e8d tree-walk.c: migrate to using new "=
object_type" field when possible
>  6:  55e2640b815 !  6:  df2fc76161d cache.h: have base_name_compare() tak=
e "is tree?", not "mode"
>     @@ cache.h: int repo_interpret_branch_name(struct repository *r,
>
>      -int base_name_compare(const char *name1, int len1, int mode1, const=
 char *name2, int len2, int mode2);
>      -int df_name_compare(const char *name1, int len1, int mode1, const c=
har *name2, int len2, int mode2);
>     -+int base_name_compare(const char *name1, int len1, int isdir1, cons=
t char *name2, int len2, int isdir2);
>     -+int df_name_compare(const char *name1, int len1, int isdir1, const =
char *name2, int len2, int isdir2);
>     ++int base_name_compare(const char *name1, int len1, int istree1, con=
st char *name2, int len2, int istree2);
>     ++int df_name_compare(const char *name1, int len1, int istree1, const=
 char *name2, int len2, int istree2);
>       int name_compare(const char *name1, size_t len1, const char *name2,=
 size_t len2);
>       int cache_name_stage_compare(const char *name1, int len1, int stage=
1, const char *name2, int len2, int stage2);
>
>     @@ combine-diff.c
>                           const struct diff_filespec *two)
>       {
>      -  if (!S_ISDIR(one->mode) && !S_ISDIR(two->mode))
>     -+  int isdir_one =3D S_ISDIR(one->mode);
>     -+  int isdir_two =3D S_ISDIR(two->mode);
>     -+  if (!isdir_one && !isdir_two)
>     ++  int istree_one =3D S_ISDIR(one->mode);
>     ++  int istree_two =3D S_ISDIR(two->mode);
>     ++  if (!istree_one && !istree_two)
>                 return strcmp(one->path, two->path);
>
>      -  return base_name_compare(one->path, strlen(one->path), one->mode,
>      -                           two->path, strlen(two->path), two->mode)=
;
>     -+  return base_name_compare(one->path, strlen(one->path), isdir_one,
>     -+                           two->path, strlen(two->path), isdir_two)=
;
>     ++  return base_name_compare(one->path, strlen(one->path), istree_one=
,
>     ++                           two->path, strlen(two->path), istree_two=
);
>       }
>
>       static int filename_changed(char status)
>     @@ match-trees.c: static void *fill_tree_desc_strict(struct tree_desc=
 *desc,
>       {
>      -  return base_name_compare(a->path, tree_entry_len(a), a->mode,
>      -                           b->path, tree_entry_len(b), b->mode);
>     -+  int isdira =3D a->object_type =3D=3D OBJ_TREE;
>     -+  int isdirb =3D b->object_type =3D=3D OBJ_TREE;
>     -+  return base_name_compare(a->path, tree_entry_len(a), isdira,
>     -+                           b->path, tree_entry_len(b), isdirb);
>     ++  int istree_a =3D (a->object_type =3D=3D OBJ_TREE);
>     ++  int istree_b =3D (b->object_type =3D=3D OBJ_TREE);
>     ++  return base_name_compare(a->path, tree_entry_len(a), istree_a,
>     ++                           b->path, tree_entry_len(b), istree_b);
>       }
>
>       /*
>     @@ read-cache.c: int ie_modified(struct index_state *istate,
>
>      -int base_name_compare(const char *name1, int len1, int mode1,
>      -                const char *name2, int len2, int mode2)
>     -+int base_name_compare(const char *name1, int len1, int isdir1,
>     -+                const char *name2, int len2, int isdir2)
>     ++int base_name_compare(const char *name1, int len1, int istree1,
>     ++                const char *name2, int len2, int istree2)
>       {
>         unsigned char c1, c2;
>         int len =3D len1 < len2 ? len1 : len2;
>     @@ read-cache.c: int base_name_compare(const char *name1, int len1, i=
nt mode1,
>         c1 =3D name1[len];
>         c2 =3D name2[len];
>      -  if (!c1 && S_ISDIR(mode1))
>     -+  if (!c1 && isdir1)
>     ++  if (!c1 && istree1)
>                 c1 =3D '/';
>      -  if (!c2 && S_ISDIR(mode2))
>     -+  if (!c2 && isdir2)
>     ++  if (!c2 && istree2)
>                 c2 =3D '/';
>         return (c1 < c2) ? -1 : (c1 > c2) ? 1 : 0;
>       }
>     @@ read-cache.c: int base_name_compare(const char *name1, int len1, i=
nt mode1,
>        */
>      -int df_name_compare(const char *name1, int len1, int mode1,
>      -              const char *name2, int len2, int mode2)
>     -+int df_name_compare(const char *name1, int len1, int isdir1,
>     -+              const char *name2, int len2, int isdir2)
>     ++int df_name_compare(const char *name1, int len1, int istree1,
>     ++              const char *name2, int len2, int istree2)
>       {
>         int len =3D len1 < len2 ? len1 : len2, cmp;
>         unsigned char c1, c2;
>     @@ read-cache.c: int df_name_compare(const char *name1, int len1, int=
 mode1,
>                 return 0;
>         c1 =3D name1[len];
>      -  if (!c1 && S_ISDIR(mode1))
>     -+  if (!c1 && isdir1)
>     ++  if (!c1 && istree1)
>                 c1 =3D '/';
>         c2 =3D name2[len];
>      -  if (!c2 && S_ISDIR(mode2))
>     -+  if (!c2 && isdir2)
>     ++  if (!c2 && istree2)
>                 c2 =3D '/';
>         if (c1 =3D=3D '/' && !c2)
>                 return 0;
>     @@ tree-diff.c: static int tree_entry_pathcmp(struct tree_desc *t1, s=
truct tree_des
>       {
>         struct name_entry *e1, *e2;
>         int cmp;
>     -+  int e1_is_tree, e2_is_tree;
>     ++  int istree_e1, istree_e2;
>
>         /* empty descriptors sort after valid tree entries */
>         if (!t1->size)
>     @@ tree-diff.c: static int tree_entry_pathcmp(struct tree_desc *t1, s=
truct tree_des
>                 return -1;
>
>         e1 =3D &t1->entry;
>     -+  e1_is_tree =3D e1->object_type =3D=3D OBJ_TREE;
>     ++  istree_e1 =3D (e1->object_type =3D=3D OBJ_TREE);
>         e2 =3D &t2->entry;
>      -  cmp =3D base_name_compare(e1->path, tree_entry_len(e1), e1->mode,
>      -                          e2->path, tree_entry_len(e2), e2->mode);
>     -+  e2_is_tree =3D e2->object_type =3D=3D OBJ_TREE;
>     -+  cmp =3D base_name_compare(e1->path, tree_entry_len(e1), e1_is_tre=
e,
>     -+                          e2->path, tree_entry_len(e2), e2_is_tree)=
;
>     ++  istree_e2 =3D (e2->object_type =3D=3D OBJ_TREE);
>     ++  cmp =3D base_name_compare(e1->path, tree_entry_len(e1), istree_e1=
,
>     ++                          e2->path, tree_entry_len(e2), istree_e2);
>         return cmp;
>       }
>
>     @@ unpack-trees.c: static int traverse_trees_recursive(int n, unsigne=
d long dirmask
>                                       const struct traverse_info *info,
>                                       const char *name, size_t namelen,
>      -                                unsigned mode)
>     -+                                unsigned is_tree)
>     ++                                unsigned istree)
>       {
>         int pathlen, ce_len;
>         const char *ce_name;
>     @@ unpack-trees.c: static int do_compare_entry_piecewise(const struct=
 cache_entry *
>         ce_name =3D ce->name + pathlen;
>
>      -  return df_name_compare(ce_name, ce_len, S_IFREG, name, namelen, m=
ode);
>     -+  return df_name_compare(ce_name, ce_len, 0, name, namelen, is_tree=
);
>     ++  return df_name_compare(ce_name, ce_len, 0, name, namelen, istree)=
;
>       }
>
>       static int do_compare_entry(const struct cache_entry *ce,
>                             const struct traverse_info *info,
>                             const char *name, size_t namelen,
>      -                      unsigned mode)
>     -+                      unsigned is_tree)
>     ++                      unsigned istree)
>       {
>         int pathlen, ce_len;
>         const char *ce_name;
>     @@ unpack-trees.c: static int do_compare_entry(const struct cache_ent=
ry *ce,
>          */
>         if (!info->traverse_path)
>      -          return do_compare_entry_piecewise(ce, info, name, namelen=
, mode);
>     -+          return do_compare_entry_piecewise(ce, info, name, namelen=
, is_tree);
>     ++          return do_compare_entry_piecewise(ce, info, name, namelen=
, istree);
>
>         cmp =3D strncmp(ce->name, info->traverse_path, info->pathlen);
>         if (cmp)
>     @@ unpack-trees.c: static int do_compare_entry(const struct cache_ent=
ry *ce,
>         ce_name =3D ce->name + pathlen;
>
>      -  return df_name_compare(ce_name, ce_len, S_IFREG, name, namelen, m=
ode);
>     -+  return df_name_compare(ce_name, ce_len, 0, name, namelen, is_tree=
);
>     ++  return df_name_compare(ce_name, ce_len, 0, name, namelen, istree)=
;
>       }
>
>       static int compare_entry(const struct cache_entry *ce, const struct=
 traverse_info *info, const struct name_entry *n)
>       {
>      -  int cmp =3D do_compare_entry(ce, info, n->path, n->pathlen, n->mo=
de);
>     -+  int is_tree =3D n->object_type =3D=3D OBJ_TREE;
>     -+  int cmp =3D do_compare_entry(ce, info, n->path, n->pathlen, is_tr=
ee);
>     ++  int istree =3D (n->object_type =3D=3D OBJ_TREE);
>     ++  int cmp =3D do_compare_entry(ce, info, n->path, n->pathlen, istre=
e);
>         if (cmp)
>                 return cmp;
>
>  7:  abc128f6cb9 =3D  7:  49d5da8c086 tree-walk.h users: switch object_ty=
pe(...) to new .object_type
>  8:  dcf13faf3cd !  8:  c9d209d496a tree.h: format argument lists of read=
_tree_recursive() users
>     @@ archive.c: static int check_attr_export_subst(const struct attr_ch=
eck *check)
>      -          void *context)
>      +                         int baselen, const char *filename,
>      +                         unsigned mode,
>     -+                         int stage, void *context)
>     ++                         int stage,
>     ++                         void *context)
>       {
>         static struct strbuf path =3D STRBUF_INIT;
>         struct archiver_context *c =3D context;
>     @@ tree.h: struct tree *parse_tree_indirect(const struct object_id *o=
id);
>      +                        unsigned int,
>      +                        void *);
>
>     - int read_tree_recursive(struct repository *r,
>     -                   struct tree *tree,
>     + int read_tree_at(struct repository *r,
>     +            struct tree *tree,
>  9:  b33fcf82349 !  9:  a6d2660fe14 tree.h users: format argument lists i=
n archive.c
>     @@ Commit message
>          Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gm=
ail.com>
>
>       ## archive.c ##
>     -@@ archive.c: static int check_attr_export_subst(const struct attr_c=
heck *check)
>     - static int write_archive_entry(const struct object_id *oid, const c=
har *base,
>     -                          int baselen, const char *filename,
>     -                          unsigned mode,
>     --                         int stage, void *context)
>     -+                         int stage,
>     -+                         void *context)
>     - {
>     -   static struct strbuf path =3D STRBUF_INIT;
>     -   struct archiver_context *c =3D context;
>      @@ archive.c: static int write_archive_entry(const struct object_id =
*oid, const char *base,
>       }
>
> 10:  6a20d3c058f =3D 10:  15f7f89acca archive: get rid of 'stage' paramet=
er
> 11:  a7f7444917c ! 11:  7a71404ea3f tree.h API: make read_tree_fn_t take =
an "enum object_type"
>     @@ merge-recursive.c: static int save_files_dirs(const struct object_=
id *oid,
>       static void get_files_dirs(struct merge_options *opt, struct tree *=
tree)
>
>       ## tree.c ##
>     -@@ tree.c: static int read_tree_1(struct repository *r,
>     +@@ tree.c: int read_tree_at(struct repository *r,
>         init_tree_desc(&desc, tree->buffer, tree->size);
>
>         while (tree_entry(&desc, &entry)) {
>     @@ tree.c: static int read_tree_1(struct repository *r,
>                 if (retval !=3D all_entries_interesting) {
>                         retval =3D tree_entry_interesting(r->index, &entr=
y,
>                                                         base, 0, pathspec=
);
>     -@@ tree.c: static int read_tree_1(struct repository *r,
>     +@@ tree.c: int read_tree_at(struct repository *r,
>                 }
>
>                 switch (fn(&entry.oid, base,
>     @@ tree.c: static int read_tree_1(struct repository *r,
>                 case 0:
>                         continue;
>                 case READ_TREE_RECURSIVE:
>     -@@ tree.c: static int read_tree_1(struct repository *r,
>     +@@ tree.c: int read_tree_at(struct repository *r,
>                         return -1;
>                 }
>
>     @@ tree.c: static int read_tree_1(struct repository *r,
>                         commit =3D lookup_commit(r, &entry.oid);
>                         if (!commit)
>                                 die("Commit %s in submodule path %s%s not=
 found",
>     -@@ tree.c: static int read_tree_1(struct repository *r,
>     +@@ tree.c: int read_tree_at(struct repository *r,
>                                     base->buf, entry.path);
>
>                         oidcpy(&oid, get_commit_tree_oid(commit));
>     @@ tree.h: int cmp_cache_name_compare(const void *a_, const void *b_)=
;
>      +                        enum object_type, unsigned int,
>                               void *);
>
>     - int read_tree_recursive(struct repository *r,
>     + int read_tree_at(struct repository *r,
> 12:  625c643513d ! 12:  64dc9364bae tree-walk.h users: migrate "p->mode &=
&" pattern
>     @@ Metadata
>       ## Commit message ##
>          tree-walk.h users: migrate "p->mode &&" pattern
>
>     -    Change code that dpends on "p->mode" either being a valid mode o=
r zero
>     -    to use a p->object_type comparison to "OBJ_NONE".
>     +    Change code that depends on "p->mode" either being a valid mode =
or
>     +    zero to use a p->object_type comparison to "OBJ_NONE".
>
>     -    The object_type() function in cache.h will not return OBJ_NONE, =
but in
>     -    this these API users are implicitly relying on the memzero() tha=
t
>     -    happens in setup_traverse_info().
>     +    The object_type() function in cache.h will not return OBJ_NONE, =
but
>     +    these API users are implicitly relying on the memzero() that hap=
pens
>     +    in setup_traverse_info().
>
>          Since OBJ_NONE is "0" we can also rely on that being zero'd out =
here,
>          along with the rest of the structure. I think this is slightly l=
ess
> 13:  37b28c7feff =3D 13:  93ed3edbbd5 tree-walk.h users: refactor chained=
 "mode" if/else into switch
> 14:  e0b8ec6e291 =3D 14:  7aa48aa34c3 tree-walk.h users: migrate miscella=
neous "mode" to "object_type"
> 15:  0cd162c43d7 =3D 15:  3ae81621dcf merge-tree tests: test for the mode=
 comparison in same_entry()
> 16:  f8ce666d4a7 =3D 16:  4249ad5c4de merge-ort: correct reference to tes=
t in 62fdec17a11
> 17:  4963902ba97 =3D 17:  e5e17505dde fsck.c: switch on "object_type" in =
fsck_walk_tree()
> 18:  d74e6778009 =3D 18:  3f0b884f1fd tree-walk.h users: use temporary va=
riable(s) for "mode"
> 19:  d39db486d4e =3D 19:  174167613bb tree-walk.h API: formatting changes=
 for subsequent commit
> 20:  69eb956b1ab =3D 20:  ec76db613f2 tree-walk.h API: rename get_tree_en=
try() to get_tree_entry_mode()
> 21:  cc56453e600 =3D 21:  11e34941729 tree-walk.h API users: use "tmp" fo=
r mode in shift_tree_by()
> 22:  ca9e3b3ad00 ! 22:  b31c106557f tree-walk.h API: Add get_tree_entry_t=
ype()
>     @@ Metadata
>      Author: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>
>       ## Commit message ##
>     -    tree-walk.h API: Add get_tree_entry_type()
>     +    tree-walk.h API: add get_tree_entry_type()
>
>          Add a get_tree_entry_type() helper function to compliment the ex=
isting
>     -    get_tree_entry(). Move those users of get_tree_entry_type() who =
didn't
>     -    care about the mode specifically, but just want to know whether =
the
>     -    tree entry is one of OBJ_{BLOB,COMMIT,TREE} over to it.
>     +    get_tree_entry(), and a static get_tree_entry_all() which it use=
s internally.
>     +
>     +    Move those users of get_tree_entry_type() who didn't care about =
the
>     +    mode specifically, but just want to know whether the tree entry =
is one
>     +    of OBJ_{BLOB,COMMIT,TREE} over to the new get_tree_entry_type().
>     +
>     +    The get_tree_entry_all() function itself will be made non-static=
 in a
>     +    subsequent commit. I'm leaving its argument list indented accord=
ingly
>     +    to reduce churn when I do so.
>
>          Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gm=
ail.com>
>
>     @@ archive.c: static void parse_treeish_arg(const char **argv,
>
>                 tree =3D parse_tree_indirect(&tree_oid);
>
>     - ## blame.c ##
>     -@@ blame.c: static void verify_working_tree_path(struct repository *=
r,
>     -   for (parents =3D work_tree->parents; parents; parents =3D parents=
->next) {
>     -           const struct object_id *commit_oid =3D &parents->item->ob=
ject.oid;
>     -           struct object_id blob_oid;
>     --          unsigned short mode;
>     --          int ret =3D get_tree_entry_mode(r, commit_oid, path, &blo=
b_oid,
>     --                                        &mode);
>     -+          enum object_type object_type;
>     -+          int ret =3D get_tree_entry_type(r, commit_oid, path, &blo=
b_oid,
>     -+                                        &object_type);
>     -
>     --          if (!ret && oid_object_info(r, &blob_oid, NULL) =3D=3D OB=
J_BLOB)
>     -+          if (!ret && object_type =3D=3D OBJ_BLOB)
>     -                   return;
>     -   }
>     -
>     -
>       ## match-trees.c ##
>      @@ match-trees.c: void shift_tree_by(struct repository *r,
>                    const char *shift_prefix)
>     @@ match-trees.c: void shift_tree_by(struct repository *r,
>
>       ## tree-walk.c ##
>      @@ tree-walk.c: struct dir_state {
>     +   struct object_id oid;
>     + };
>
>     ++static int get_tree_entry_all(struct repository *r,
>     ++                        const struct object_id *tree_oid,
>     ++                        const char *name,
>     ++                        struct object_id *oid,
>     ++                        unsigned short *mode,
>     ++                        enum object_type *object_type);
>     ++
>       static int find_tree_entry(struct repository *r, struct tree_desc *=
t,
>                            const char *name, struct object_id *result,
>      -                     unsigned short *mode)
>     @@ tree-walk.c: static int find_tree_entry(struct repository *r, stru=
ct tree_desc *
>      -                  const char *name,
>      -                  struct object_id *oid,
>      -                  unsigned short *mode)
>     -+int get_tree_entry_all(struct repository *r,
>     ++static int get_tree_entry_all(struct repository *r,
>      +                 const struct object_id *tree_oid,
>      +                 const char *name,
>      +                 struct object_id *oid,
>     @@ tree-walk.h: struct traverse_info {
>      - * The third and fourth parameters are set to the entry's sha1 and
>      - * mode respectively.
>      + * There are variants of this function depending on what fields in =
the
>     -+ * "struct name_entry" you'd like. You always need to pointer to an
>     ++ * "struct name_entry" you'd like. You always need a pointer to an
>      + * appropriate variable to fill in (NULL won't do!):
>      + *
>      + * get_tree_entry_mode(): unsigned int mode
>      + * get_tree_entry_type(): enum object_type
>     -+ * get_tree_entry_all(): unsigned int mode, enum object_type
>        */
>       int get_tree_entry_mode(struct repository *, const struct object_id=
 *, const char *,
>                         struct object_id *,
>     @@ tree-walk.h: struct traverse_info {
>      +int get_tree_entry_type(struct repository *, const struct object_id=
 *, const char *,
>      +                  struct object_id *,
>      +                  enum object_type *);
>     -+int get_tree_entry_all(struct repository *, const struct object_id =
*, const char *,
>     -+                 struct object_id *,
>     -+                 unsigned short *, enum object_type *);
>
>       /**
>        * Generate the full pathname of a tree entry based from the root o=
f the
> 24:  5986f494aa1 ! 23:  304d5d4d1af tree-walk.h API: document and format =
tree_entry_extract()
>     @@ tree-walk.h: struct tree_desc {
>      - * `pathp` and `modep` arguments are set to the entry's pathname an=
d mode
>      - * respectively.
>      + * `tree_desc's` `entry` member) and return the OID of the entry.
>     -+
>     ++ *
>      + * There are variants of this function depending on what fields in =
the
>     -+ * "struct name_entry" you'd like. You always need to pointer to an
>     ++ * "struct name_entry" you'd like. You always need a pointer to an
>      + * appropriate variable to fill in (NULL won't do!):
>      + *
>      + * tree_entry_extract_mode(): const char *path, unsigned int mode
> 25:  9b604a193b8 ! 24:  346453df356 tree-entry.h API: rename tree_entry_e=
xtract() to tree_entry_extract_mode()
>     @@ tree-diff.c: static struct combine_diff_path *emit_path(struct com=
bine_diff_path
>
>                 isdir =3D S_ISDIR(mode);
>
>     - ## tree-walk.c ##
>     -@@ tree-walk.c: static int find_tree_entry(struct repository *r, str=
uct tree_desc *t,
>     -           struct object_id oid;
>     -           int entrylen, cmp;
>     -
>     --          oidcpy(&oid, tree_entry_extract(t, &entry, mode));
>     -+          oidcpy(&oid, tree_entry_extract_mode(t, &entry, mode));
>     -           entrylen =3D tree_entry_len(&t->entry);
>     -           update_tree_entry(t);
>     -           if (entrylen > namelen)
>     -
>       ## tree-walk.h ##
>      @@ tree-walk.h: struct tree_desc {
>        *
> 26:  40878d04550 ! 25:  dd012b661e5 tree-walk.h API: add a tree_entry_ext=
ract_all() function
>     @@ Commit message
>
>          Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gm=
ail.com>
>
>     - ## builtin/update-index.c ##
>     -@@ builtin/update-index.c: static struct cache_entry *read_one_ent(c=
onst char *which,
>     -                                   struct object_id *ent, const char=
 *path,
>     -                                   int namelen, int stage)
>     - {
>     -+  enum object_type object_type;
>     -   unsigned short mode;
>     -   struct object_id oid;
>     -   struct cache_entry *ce;
>     -
>     --  if (get_tree_entry_mode(the_repository, ent, path, &oid, &mode)) =
{
>     -+  if (get_tree_entry_all(the_repository, ent, path, &oid,
>     -+                         &mode, &object_type)) {
>     -           if (which)
>     -                   error("%s: not in %s branch.", path, which);
>     -           return NULL;
>     -   }
>     --  if (mode =3D=3D S_IFDIR) {
>     -+  if (object_type =3D=3D OBJ_TREE) {
>     -           if (which)
>     -                   error("%s: not a blob in %s branch.", path, which=
);
>     -           return NULL;
>     -
>       ## tree-diff.c ##
>      @@ tree-diff.c: static struct combine_diff_path *emit_path(struct co=
mbine_diff_path *p,
>         assert(t || tp);
>     @@ tree-diff.c: static struct combine_diff_path *emit_path(struct com=
bine_diff_path
>      +          oid =3D tree_entry_extract_all(t, &path, &mode, &object_t=
ype);
>                 pathlen =3D tree_entry_len(&t->entry);
>      -          isdir =3D S_ISDIR(mode);
>     -+          isdir =3D object_type =3D=3D OBJ_TREE;
>     ++          isdir =3D (object_type =3D=3D OBJ_TREE);
>         } else {
>                 /*
>                  * a path was removed - take path from imin parent. Also =
take
>     @@ tree-walk.c: static int find_tree_entry(struct repository *r, stru=
ct tree_desc *
>                 struct object_id oid;
>                 int entrylen, cmp;
>
>     --          oidcpy(&oid, tree_entry_extract_mode(t, &entry, mode));
>     +-          oidcpy(&oid, tree_entry_extract(t, &entry, mode));
>      +          oidcpy(&oid, tree_entry_extract_all(t, &entry, mode, obje=
ct_type));
>     -+
>                 entrylen =3D tree_entry_len(&t->entry);
>                 update_tree_entry(t);
>                 if (entrylen > namelen)
>  -:  ----------- > 26:  b6ee8410e38 tree-walk.h API: add get_tree_entry_a=
ll()
> 23:  6b864e066d9 ! 27:  5c98afd9e7a tree-walk.h API: add a get_tree_entry=
_path() function
>     @@ tree-walk.c: int get_tree_entry_all(struct repository *r,
>
>       ## tree-walk.h ##
>      @@ tree-walk.h: struct traverse_info {
>     -  * "struct name_entry" you'd like. You always need to pointer to an
>     +  * "struct name_entry" you'd like. You always need a pointer to an
>        * appropriate variable to fill in (NULL won't do!):
>        *
>      + * get_tree_entry_path(): <no extra argument, just get the common '=
path'>
>  -:  ----------- > 28:  3e7e0f7eb85 blame: emit a better error on 'git bl=
ame directory'
> 27:  e4a6fae1ae0 =3D 29:  ac1ccf13570 tree-walk.h API: add a tree_entry_e=
xtract_type() function
> 28:  766b4460a95 <  -:  ----------- tree-walk.h API users: rename "struct=
 name_entry"'s "mode" to "raw_mode"
> 29:  4bdf94ae5c1 <  -:  ----------- tree.h API users: rename read_tree_fn=
_t's "mode" to "raw_mode"
> 30:  9d049fdbd00 <  -:  ----------- tree-walk.h API: move canon_mode() ba=
ck out of decode_tree_entry()
> --
> 2.31.0.rc2.211.g1d0b8788b3
>
