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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7483C433DB
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 19:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94AD665296
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 19:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhCHTTT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 14:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbhCHTTD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 14:19:03 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63127C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 11:19:03 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id t83so2184529oih.12
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 11:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KRsOt/yz9OmJ/EmItPkFhf582MREJEYbrsMMGMCdR9M=;
        b=bl2MEmf3CVc0ix6B/F0Kkj/vGxZNj50zTwQqzNbQ581msLfEVxjX83PdjBkWOMc8E3
         cTT7gWmTncBp06yuxNmn+3arszeQzIh81ZBf/6MiKbQqG2dwMK3zDq3nEJdJ8PiTSzo9
         OqvoEaQU/d/Rn74niqjH5L2OEkUOWcau9gMgjmw2LDGm2zrksF/O76wUmY+f/1bVklNc
         2sPBAAwh3cczxj1/9TH0Beb9Wni8Q9Z5x7b6GEg3rfvqmUxa31Bk39R3t3ASUAwJBGq5
         QO5P4BnIC0C/rwbTxlQHHrGwtKrlXvv17o+HH4xRqH90fLjmdwoG8UHfS/mkzbcfCtAm
         VGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KRsOt/yz9OmJ/EmItPkFhf582MREJEYbrsMMGMCdR9M=;
        b=tY7ZCS+vkeElbdiG6N6s51rBzijGUH4P6ijPNFfrJn7XzwU4K2Ei1Zz1xgbUEE4rmb
         uyuk5lnSfcGscfe0g1nRpiG9/84h9qAV7ILriUhvrxBXiaWTv64F89Sdc0dDLbyKSWll
         cLvFHoloP31j+p+sB1ivH1l+RNa8ZF51o9aBuxudxHgXg511shnUbfM3SpoYgNhG3Elw
         GJKjedlAaF3Jsl1bpG0s6XsdKhzzDSiM15v1tkOertYyrclbV7RiwrZQSgrJwn/uC1Af
         B66FWokd5if/b/fwt1FoXC/AYRb/UpAjrXYdG5Rr0IqJkC0g2eKOIE9xs9cRhVe8ODoc
         Riiw==
X-Gm-Message-State: AOAM531RcXAHc5sEkfqita/N9XyUQeNEglIqGFJvh2DcpgCqnbrTQMV3
        Ylg3+sf6rH6P/kWwHJemA9oZazRwsJYVWp41faM=
X-Google-Smtp-Source: ABdhPJzOoRgXdEUO3qPuMa7LsXS1z7up4VxM/PeGcjY3ge1YpZho5xawowYak8x6g/J5miznLGf/a5sFEpVBnrAyt40=
X-Received: by 2002:aca:b489:: with SMTP id d131mr271365oif.39.1615231142528;
 Mon, 08 Mar 2021 11:19:02 -0800 (PST)
MIME-Version: 1.0
References: <20210306193458.20633-1-avarab@gmail.com> <20210308022138.28166-1-avarab@gmail.com>
In-Reply-To: <20210308022138.28166-1-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 8 Mar 2021 11:18:51 -0800
Message-ID: <CABPp-BEfEQZzymkTGVTJ7cHjaPfXNeek+ikm5C0YYD2YYjpsFw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Move the read_tree() function to its only user
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 7, 2021 at 6:22 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> v1 of this series over-removed code supporting the "ls-files
> --with-tree=3D*" parameter. In v2 there's no change to its behavior,
> just refactoring away of read_tree() from the tree.c API and the
> cleanup of read_tree_recursive(). Thanks to Elijah for spotting that.
>
> I've added a test at the start of this series that would have caught
> that regression in v1 (and more).
>
> 1. https://lore.kernel.org/git/CABPp-BF982muRS4GO=3DzYegvetQyrPMwaEM3uEBv=
cbPRP=3DkrfmQ@mail.gmail.com/

This addresses my concerns with v1; so:

Reviewed-by: Elijah Newren <newren@gmail.com>

>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (6):
>   ls-files tests: add meaningful --with-tree tests
>   tree.c API: move read_tree() into builtin/ls-files.c
>   ls-files: don't needlessly pass around stage variable
>   ls-files: refactor away read_tree()
>   tree.h API: remove support for starting at prefix !=3D ""
>   tree.h API: remove "stage" parameter from read_tree_recursive()
>
>  archive.c                     |  13 +++--
>  builtin/checkout.c            |   4 +-
>  builtin/log.c                 |   6 +-
>  builtin/ls-files.c            |  76 ++++++++++++++++++++++++-
>  builtin/ls-tree.c             |   4 +-
>  merge-recursive.c             |   4 +-
>  t/t3060-ls-files-with-tree.sh |  41 ++++++++++++++
>  tree.c                        | 101 ++--------------------------------
>  tree.h                        |  10 +---
>  9 files changed, 139 insertions(+), 120 deletions(-)
>
> Range-diff:
> -:  ----------- > 1:  6416da0dee2 ls-files tests: add meaningful --with-t=
ree tests
> 1:  020534164d3 ! 2:  765001b44cd tree.c API: move read_tree() into built=
in/ls-files.c
>     @@ tree.c: int cmp_cache_name_compare(const void *a_, const void *b_)
>
>       ## tree.h ##
>      @@ tree.h: int read_tree_recursive(struct repository *r,
>     +                   const char *base, int baselen,
>                         int stage, const struct pathspec *pathspec,
>                         read_tree_fn_t fn, void *context);
>     -
>     +-
>      -int read_tree(struct repository *r, struct tree *tree,
>      -        int stage, struct pathspec *pathspec,
>      -        struct index_state *istate);
> 2:  6aa6ba2fbb5 =3D 3:  a71ffba7d04 ls-files: don't needlessly pass aroun=
d stage variable
> 3:  4f27e5d2970 ! 4:  e78d1810b89 ls-files: remove cache juggling + sorti=
ng
>     @@ Metadata
>      Author: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>
>       ## Commit message ##
>     -    ls-files: remove cache juggling + sorting
>     +    ls-files: refactor away read_tree()
>
>     -    Remove the "ce_stage(ce) =3D=3D 1" and "Sort the cache entry" co=
de from
>     -    read_tree(), which allows us to remove the function entirely and=
 move
>     -    over to read_tree_recursive().
>     +    Refactor away the read_tree() function into its only user,
>     +    overlay_tree_on_index().
>
>     -    I don't think the "Sort the cached entry" code was needed here, =
see
>     -    af3785dc5a7 (Optimize "diff --cached" performance., 2007-08-09) =
for
>     -    the use-case it was intended for. The only user of this code is
>     -    "ls-files --with-tree", which isn't the sort of use-case that ne=
eds to
>     -    care about "ce_stage(ce) !=3D 0" or sorting tree entries.
>     +    First, change read_one_entry_opt() to use the strbuf parameter
>     +    read_tree_recursive() passes down in place. This finishes up a p=
artial
>     +    refactoring started in 6a0b0b6de99 (tree.c: update read_tree_rec=
ursive
>     +    callback to pass strbuf as base, 2014-11-30).
>     +
>     +    Moving the rest into overlay_tree_on_index() makes this index ju=
ggling
>     +    we're doing easier to read.
>
>          Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gm=
ail.com>
>
>       ## builtin/ls-files.c ##
>     -@@
>     - #include "dir.h"
>     - #include "builtin.h"
>     - #include "tree.h"
>     --#include "cache-tree.h"
>     - #include "parse-options.h"
>     - #include "resolve-undo.h"
>     - #include "string-list.h"
>      @@ builtin/ls-files.c: static int get_common_prefix_len(const char *=
common_prefix)
>     -   return common_prefix_len;
>     - }
>
>     --static int read_one_entry_opt(struct index_state *istate,
>     --                        const struct object_id *oid,
>     + static int read_one_entry_opt(struct index_state *istate,
>     +                         const struct object_id *oid,
>      -                        const char *base, int baselen,
>     --                        const char *pathname,
>     --                        unsigned mode, int stage, int opt)
>     -+static int read_one_entry_quick(const struct object_id *oid,
>     -+                          struct strbuf *basebuf,
>     -+                          const char *pathname,
>     -+                          unsigned mode,
>     -+                          int stage, void *context)
>     ++                        struct strbuf *base,
>     +                         const char *pathname,
>     +                         unsigned mode, int stage, int opt)
>       {
>     -+  struct index_state *istate =3D context;
>     -+  const char *base =3D basebuf->buf;
>     -+  const int baselen =3D basebuf->len;
>     -   int len;
>     -   struct cache_entry *ce;
>     -
>      @@ builtin/ls-files.c: static int read_one_entry_opt(struct index_st=
ate *istate,
>     -   memcpy(ce->name, base, baselen);
>     -   memcpy(ce->name + baselen, pathname, len+1);
>     +           return READ_TREE_RECURSIVE;
>     +
>     +   len =3D strlen(pathname);
>     +-  ce =3D make_empty_cache_entry(istate, baselen + len);
>     ++  ce =3D make_empty_cache_entry(istate, base->len + len);
>     +
>     +   ce->ce_mode =3D create_ce_mode(mode);
>     +   ce->ce_flags =3D create_ce_flags(stage);
>     +-  ce->ce_namelen =3D baselen + len;
>     +-  memcpy(ce->name, base, baselen);
>     +-  memcpy(ce->name + baselen, pathname, len+1);
>     ++  ce->ce_namelen =3D base->len + len;
>     ++  memcpy(ce->name, base->buf, base->len);
>     ++  memcpy(ce->name + base->len, pathname, len+1);
>         oidcpy(&ce->oid, oid);
>     --  return add_index_entry(istate, ce, opt);
>     --}
>     --
>     --static int read_one_entry(const struct object_id *oid, struct strbu=
f *base,
>     --                    const char *pathname, unsigned mode, int stage,
>     --                    void *context)
>     --{
>     --  struct index_state *istate =3D context;
>     +   return add_index_entry(istate, ce, opt);
>     + }
>     +@@ builtin/ls-files.c: static int read_one_entry(const struct object=
_id *oid, struct strbuf *base,
>     +                     void *context)
>     + {
>     +   struct index_state *istate =3D context;
>      -  return read_one_entry_opt(istate, oid, base->buf, base->len, path=
name,
>     --                            mode, stage,
>     --                            ADD_CACHE_OK_TO_ADD|ADD_CACHE_SKIP_DFCH=
ECK);
>     --}
>     --
>     --/*
>     -- * This is used when the caller knows there is no existing entries =
at
>     -- * the stage that will conflict with the entry being added.
>     -- */
>     --static int read_one_entry_quick(const struct object_id *oid, struct=
 strbuf *base,
>     --                          const char *pathname, unsigned mode, int =
stage,
>     --                          void *context)
>     --{
>     --  struct index_state *istate =3D context;
>     ++  return read_one_entry_opt(istate, oid, base, pathname,
>     +                             mode, stage,
>     +                             ADD_CACHE_OK_TO_ADD|ADD_CACHE_SKIP_DFCH=
ECK);
>     + }
>     +@@ builtin/ls-files.c: static int read_one_entry_quick(const struct =
object_id *oid, struct strbuf *base
>     +                           void *context)
>     + {
>     +   struct index_state *istate =3D context;
>      -  return read_one_entry_opt(istate, oid, base->buf, base->len, path=
name,
>     --                            mode, stage,
>     --                            ADD_CACHE_JUST_APPEND);
>     --}
>     --
>     ++  return read_one_entry_opt(istate, oid, base, pathname,
>     +                             mode, stage,
>     +                             ADD_CACHE_JUST_APPEND);
>     + }
>     +
>      -
>      -static int read_tree(struct repository *r, struct tree *tree,
>      -               struct pathspec *match, struct index_state *istate)
>     @@ builtin/ls-files.c: static int read_one_entry_opt(struct index_sta=
te *istate,
>      -  cache_tree_free(&istate->cache_tree);
>      -  QSORT(istate->cache, istate->cache_nr, cmp_cache_name_compare);
>      -  return 0;
>     -+  return add_index_entry(istate, ce, ADD_CACHE_JUST_APPEND);
>     - }
>     -
>     +-}
>     +-
>       /*
>     +  * Read the tree specified with --with-tree option
>     +  * (typically, HEAD) into stage #1 and then
>     +@@ builtin/ls-files.c: void overlay_tree_on_index(struct index_state=
 *istate,
>     +   struct pathspec pathspec;
>     +   struct cache_entry *last_stage0 =3D NULL;
>     +   int i;
>     ++  read_tree_fn_t fn =3D NULL;
>     ++  int err;
>     +
>     +   if (get_oid(tree_name, &oid))
>     +           die("tree-ish %s not found.", tree_name);
>      @@ builtin/ls-files.c: void overlay_tree_on_index(struct index_state=
 *istate,
>                                PATHSPEC_PREFER_CWD, prefix, matchbuf);
>         } else
>                 memset(&pathspec, 0, sizeof(pathspec));
>      -  if (read_tree(the_repository, tree, &pathspec, istate))
>     -+  if (read_tree_recursive(the_repository, tree, "", 0, 1,
>     -+                          &pathspec, read_one_entry_quick, istate))
>     ++
>     ++  /*
>     ++   * See if we have cache entry at the stage.  If so,
>     ++   * do it the original slow way, otherwise, append and then
>     ++   * sort at the end.
>     ++   */
>     ++  for (i =3D 0; !fn && i < istate->cache_nr; i++) {
>     ++          const struct cache_entry *ce =3D istate->cache[i];
>     ++          if (ce_stage(ce) =3D=3D 1)
>     ++                  fn =3D read_one_entry;
>     ++  }
>     ++
>     ++  if (!fn)
>     ++          fn =3D read_one_entry_quick;
>     ++  err =3D read_tree_recursive(the_repository, tree, "", 0, 1, &path=
spec, fn, istate);
>     ++  if (err)
>                 die("unable to read tree entries %s", tree_name);
>
>     ++  /*
>     ++   * Sort the cache entry -- we need to nuke the cache tree, though=
.
>     ++   */
>     ++  if (fn =3D=3D read_one_entry_quick) {
>     ++          cache_tree_free(&istate->cache_tree);
>     ++          QSORT(istate->cache, istate->cache_nr, cmp_cache_name_com=
pare);
>     ++  }
>     ++
>         for (i =3D 0; i < istate->cache_nr; i++) {
>     +           struct cache_entry *ce =3D istate->cache[i];
>     +           switch (ce_stage(ce)) {
> 4:  33810d3c10c < -:  ----------- merge-ort: move cmp_cache_name_compare(=
) from tree.c
> 5:  fb10246b85b < -:  ----------- ls-files: refactor read_one_entry_quick=
() to use a strbuf
> 6:  0c065615aec ! 5:  05eecdd7519 tree.h API: remove support for starting=
 at prefix !=3D ""
>     @@ Metadata
>       ## Commit message ##
>          tree.h API: remove support for starting at prefix !=3D ""
>
>     -    Every caller or the read_tree_recursive() function hardcoded a
>     +    Every caller of the read_tree_recursive() function hardcoded a
>          starting point of "" in the tree. So let's simply remove that
>          parameter.
>
>     -    It might be useful in the future to get this functionality back,
>     -    there's no reason we won't have a read_tree_recursive() use-case=
 that
>     -    would want to start in a subdirectory.
>     +    The last function to call read_tree_recursive() with a non-"" pa=
th was
>     +    read_tree_recursive() itself, but that was changed in
>     +    ffd31f661d5 (Reimplement read_tree_recursive() using
>     +    tree_entry_interesting(), 2011-03-25).
>
>     -    But if and when that happens we can just add something like a
>     -    read_tree_recursive_subdir() and have both read_tree_recursive()=
 and
>     -    that function be a thin wrapper for read_tree_1().
>     +    If in the future we need to support recursively reading trees wi=
thout
>     +    starting at the root we can easily add a read_tree_recursive_sub=
dir(),
>     +    and make that function a thin wrapper for read_tree_1().
>
>          In the meantime there's no reason to keep around what amounts to=
 dead
>     -    code just in case we need it in the future.
>     +    code, just in case we need it in the future.
>
>          Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gm=
ail.com>
>
>     @@ builtin/log.c: int cmd_show(int argc, const char **argv, const cha=
r *prefix)
>
>       ## builtin/ls-files.c ##
>      @@ builtin/ls-files.c: void overlay_tree_on_index(struct index_state=
 *istate,
>     -                          PATHSPEC_PREFER_CWD, prefix, matchbuf);
>     -   } else
>     -           memset(&pathspec, 0, sizeof(pathspec));
>     --  if (read_tree_recursive(the_repository, tree, "", 0, 1,
>     -+  if (read_tree_recursive(the_repository, tree, 1,
>     -                           &pathspec, read_one_entry_quick, istate))
>     +
>     +   if (!fn)
>     +           fn =3D read_one_entry_quick;
>     +-  err =3D read_tree_recursive(the_repository, tree, "", 0, 1, &path=
spec, fn, istate);
>     ++  err =3D read_tree_recursive(the_repository, tree, 1, &pathspec, f=
n, istate);
>     +   if (err)
>                 die("unable to read tree entries %s", tree_name);
>
>
>     @@ tree.h: typedef int (*read_tree_fn_t)(const struct object_id *, st=
ruct strbuf *,
>      -                  const char *base, int baselen,
>                         int stage, const struct pathspec *pathspec,
>                         read_tree_fn_t fn, void *context);
>     -
>     + #endif /* TREE_H */
> 7:  9685c7c5c50 ! 6:  fcecc82e1c8 tree.h API: remove "stage" parameter fr=
om read_tree_recursive()
>     @@ builtin/log.c: int cmd_show(int argc, const char **argv, const cha=
r *prefix)
>                         break;
>
>       ## builtin/ls-files.c ##
>     -@@ builtin/ls-files.c: static int read_one_entry_quick(const struct =
object_id *oid,
>     -                           struct strbuf *base,
>     -                           const char *pathname,
>     -                           unsigned mode,
>     --                          int stage, void *context)
>     -+                          void *context)
>     +@@ builtin/ls-files.c: static int read_one_entry_opt(struct index_st=
ate *istate,
>     +                         const struct object_id *oid,
>     +                         struct strbuf *base,
>     +                         const char *pathname,
>     +-                        unsigned mode, int stage, int opt)
>     ++                        unsigned mode, int opt)
>       {
>     -   struct index_state *istate =3D context;
>         int len;
>     -@@ builtin/ls-files.c: static int read_one_entry_quick(const struct =
object_id *oid,
>     +   struct cache_entry *ce;
>     +@@ builtin/ls-files.c: static int read_one_entry_opt(struct index_st=
ate *istate,
>         ce =3D make_empty_cache_entry(istate, base->len + len);
>
>         ce->ce_mode =3D create_ce_mode(mode);
>     @@ builtin/ls-files.c: static int read_one_entry_quick(const struct o=
bject_id *oid,
>         ce->ce_namelen =3D base->len + len;
>         memcpy(ce->name, base->buf, base->len);
>         memcpy(ce->name + base->len, pathname, len+1);
>     +@@ builtin/ls-files.c: static int read_one_entry_opt(struct index_st=
ate *istate,
>     + }
>     +
>     + static int read_one_entry(const struct object_id *oid, struct strbu=
f *base,
>     +-                    const char *pathname, unsigned mode, int stage,
>     ++                    const char *pathname, unsigned mode,
>     +                     void *context)
>     + {
>     +   struct index_state *istate =3D context;
>     +   return read_one_entry_opt(istate, oid, base, pathname,
>     +-                            mode, stage,
>     ++                            mode,
>     +                             ADD_CACHE_OK_TO_ADD|ADD_CACHE_SKIP_DFCH=
ECK);
>     + }
>     +
>     +@@ builtin/ls-files.c: static int read_one_entry(const struct object=
_id *oid, struct strbuf *base,
>     +  * the stage that will conflict with the entry being added.
>     +  */
>     + static int read_one_entry_quick(const struct object_id *oid, struct=
 strbuf *base,
>     +-                          const char *pathname, unsigned mode, int =
stage,
>     ++                          const char *pathname, unsigned mode,
>     +                           void *context)
>     + {
>     +   struct index_state *istate =3D context;
>     +   return read_one_entry_opt(istate, oid, base, pathname,
>     +-                            mode, stage,
>     ++                            mode,
>     +                             ADD_CACHE_JUST_APPEND);
>     + }
>     +
>      @@ builtin/ls-files.c: void overlay_tree_on_index(struct index_state=
 *istate,
>     -                          PATHSPEC_PREFER_CWD, prefix, matchbuf);
>     -   } else
>     -           memset(&pathspec, 0, sizeof(pathspec));
>     --  if (read_tree_recursive(the_repository, tree, 1,
>     -+  if (read_tree_recursive(the_repository, tree,
>     -                           &pathspec, read_one_entry_quick, istate))
>     +
>     +   if (!fn)
>     +           fn =3D read_one_entry_quick;
>     +-  err =3D read_tree_recursive(the_repository, tree, 1, &pathspec, f=
n, istate);
>     ++  err =3D read_tree_recursive(the_repository, tree, &pathspec, fn, =
istate);
>     +   if (err)
>                 die("unable to read tree entries %s", tree_name);
>
>
>     @@ tree.c: static int read_tree_1(struct repository *r,
>       }
>
>       ## tree.h ##
>     -@@ tree.h: void free_tree_buffer(struct tree *tree);
>     - struct tree *parse_tree_indirect(const struct object_id *oid);
>     +@@ tree.h: struct tree *parse_tree_indirect(const struct object_id *=
oid);
>     + int cmp_cache_name_compare(const void *a_, const void *b_);
>
>       #define READ_TREE_RECURSIVE 1
>      -typedef int (*read_tree_fn_t)(const struct object_id *, struct strb=
uf *, const char *, unsigned int, int, void *);
>     @@ tree.h: void free_tree_buffer(struct tree *tree);
>      -                  int stage, const struct pathspec *pathspec,
>      +                  const struct pathspec *pathspec,
>                         read_tree_fn_t fn, void *context);
>     -
>       #endif /* TREE_H */
> --
> 2.31.0.rc0.126.g04f22c5b82
>
