Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF436C433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 03:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8391764E6B
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 03:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbhBXDU7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 22:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbhBXDU5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 22:20:57 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF9CC061574
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 19:20:17 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id f33so825888otf.11
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 19:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TOe7V5bIoEJqFZPw7QmxkwVWMO+9+r6Jbbv0a4QiPvk=;
        b=VPYd08anCRTymPJbs9DGcLCjOOHnEM3ltKHGqWnkXhn7EKGRAcCnyQWoqnj7T1pNey
         PAEJLgScrWUGokSpwb7t5tagPhyygWrnzhyXtzXSPtHSqP6BLFKwX+JPpiJUdfwClsXb
         CPNjkdZ6CSk9OqV9ImWlJDjRv27Fyn+WgkaekitsHX5lgGeq7stlipezN8Iuy0QAehON
         wEyYiV9SxzpdGjY+TJN0Uc9yrOxY98lC9y/JEDjgRkuuRVCt4aGxCOOIfGneFmQjwASA
         v4PxMzv4eYTfrqIk+zYogshZLlP3m+7xbGPz8REM3tvGSZsJsa+/xYLhHEbCG5I0KoQq
         OtgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TOe7V5bIoEJqFZPw7QmxkwVWMO+9+r6Jbbv0a4QiPvk=;
        b=AlgxqpiGpoBKXsV5wzp1AEL8+LfDnpqNnO0B+SThlF3+x2k+obuN2ylSNsT89HtSDo
         vMokr/Z08prZw9OTadflPvmG9ipEUXYDwFxctAxKJ0mTAnoW+n6BWJjOlJZeOzcn/Gyk
         50BkOK0hjPls0K7eyLL3vWHp3wN1sV1zgrjdKJTX49WCM0OQMh+V8zI4HIijG9qiy/u4
         POVEGj9O5SnOXFiqmJdN+hNjSjPWiXrn0whXVkbaRg+1TJq29AZYmkOT6KTFYep5x/8+
         QVXClm5E+irJKF/UNKClcPGlScG5zPDhlfsHuCWmSRSJMSCSlbtUU9bbDG5fw6rTG9hT
         j3sg==
X-Gm-Message-State: AOAM531RoFjgzG1tj/yhjqEThgO4SYXwrzapSZXkHb/CKokNS4yy292W
        R+AL5Sm19gPDgk8hoNALYhUcu94cx4XF+gJCWrm521BBFP0Xmw==
X-Google-Smtp-Source: ABdhPJxU9qZjRrkc/oCPR+lXjUq21tXmPsnZpnGL8rI7RwnVmIFYt+U8O6ameKrqlm3IXH1j4Q1ebqVWesOqTrQEy/U=
X-Received: by 2002:a9d:7459:: with SMTP id p25mr11138364otk.316.1614136816964;
 Tue, 23 Feb 2021 19:20:16 -0800 (PST)
MIME-Version: 1.0
References: <pull.883.git.1614111270.gitgitgadget@gmail.com> <2b83989fbcd3d464a3172eeb7cfea2e06e4f3785.1614111270.git.gitgitgadget@gmail.com>
In-Reply-To: <2b83989fbcd3d464a3172eeb7cfea2e06e4f3785.1614111270.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 23 Feb 2021 19:20:05 -0800
Message-ID: <CABPp-BENXoDXqF1=wNsPvSVBrpJhJfcEhgDtPmCuf13un9ovXw@mail.gmail.com>
Subject: Re: [PATCH 05/20] sparse-index: implement ensure_full_index()
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 23, 2021 at 12:14 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> We will mark an in-memory index_state as having sparse directory entries
> with the sparse_index bit. These currently cannot exist, but we will add
> a mechanism for collapsing a full index to a sparse one in a later
> change. That will happen at write time, so we must first allow parsing
> the format before writing it.
>
> Commands or methods that require a full index in order to operate can
> call ensure_full_index() to expand that index in-memory. This requires
> parsing trees using that index's repository.
>
> Sparse directory entries have a specific 'ce_mode' value. The macro
> S_ISSPARSEDIR(ce->ce_mode) can check if a cache_entry 'ce' has this type.
> This ce_mode is not possible with the existing index formats, so we don't
> also verify all properties of a sparse-directory entry, which are:
>
>  1. ce->ce_mode == 0040000
>  2. ce->flags & CE_SKIP_WORKTREE is true
>  3. ce->name[ce->namelen - 1] == '/' (ends in dir separator)
>  4. ce->oid references a tree object.
>
> These are all semi-enforced in ensure_full_index() to some extent. Any
> deviation will cause a warning at minimum or a failure in the worst
> case.

Thanks for spelling these all out; looks good.

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  cache.h        |  7 +++-
>  read-cache.c   |  9 +++++
>  sparse-index.c | 95 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 109 insertions(+), 2 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index d92814961405..1336c8d7435e 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -204,6 +204,8 @@ struct cache_entry {
>  #error "CE_EXTENDED_FLAGS out of range"
>  #endif
>
> +#define S_ISSPARSEDIR(m) ((m) == S_IFDIR)

Much nicer, thanks.  :-)

> +
>  /* Forward structure decls */
>  struct pathspec;
>  struct child_process;
> @@ -319,7 +321,8 @@ struct index_state {
>                  drop_cache_tree : 1,
>                  updated_workdir : 1,
>                  updated_skipworktree : 1,
> -                fsmonitor_has_run_once : 1;
> +                fsmonitor_has_run_once : 1,
> +                sparse_index : 1;
>         struct hashmap name_hash;
>         struct hashmap dir_hash;
>         struct object_id oid;
> @@ -722,6 +725,8 @@ int read_index_from(struct index_state *, const char *path,
>                     const char *gitdir);
>  int is_index_unborn(struct index_state *);
>
> +void ensure_full_index(struct index_state *istate);
> +
>  /* For use with `write_locked_index()`. */
>  #define COMMIT_LOCK            (1 << 0)
>  #define SKIP_IF_UNCHANGED      (1 << 1)
> diff --git a/read-cache.c b/read-cache.c
> index 29144cf879e7..97dbf2434f30 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -101,6 +101,9 @@ static const char *alternate_index_output;
>
>  static void set_index_entry(struct index_state *istate, int nr, struct cache_entry *ce)
>  {
> +       if (S_ISSPARSEDIR(ce->ce_mode))
> +               istate->sparse_index = 1;

A very minor question -- someone who sees "sparse_index" could
probably easily think either "index with missing entries, due to
having a SKIP_WORKTREE directory instead" or perhaps "index when using
the sparse-checkout feature, i.e. it has some SKIP_WORKTREE entries in
it".  From the code here, clearly the former is your intent.  I wonder
if it'd help to have a small comment near the declaration of
sparse_index to mention its intent.

> +
>         istate->cache[nr] = ce;
>         add_name_hash(istate, ce);
>  }
> @@ -2255,6 +2258,12 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
>         trace2_data_intmax("index", the_repository, "read/cache_nr",
>                            istate->cache_nr);
>
> +       if (!istate->repo)
> +               istate->repo = the_repository;
> +       prepare_repo_settings(istate->repo);
> +       if (istate->repo->settings.command_requires_full_index)
> +               ensure_full_index(istate);
> +
>         return istate->cache_nr;
>
>  unmap:
> diff --git a/sparse-index.c b/sparse-index.c
> index 82183ead563b..316cb949b74b 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -1,8 +1,101 @@
>  #include "cache.h"
>  #include "repository.h"
>  #include "sparse-index.h"
> +#include "tree.h"
> +#include "pathspec.h"
> +#include "trace2.h"
> +
> +static void set_index_entry(struct index_state *istate, int nr, struct cache_entry *ce)
> +{
> +       ALLOC_GROW(istate->cache, nr + 1, istate->cache_alloc);
> +
> +       istate->cache[nr] = ce;
> +       add_name_hash(istate, ce);
> +}
> +
> +static int add_path_to_index(const struct object_id *oid,
> +                               struct strbuf *base, const char *path,
> +                               unsigned int mode, int stage, void *context)
> +{
> +       struct index_state *istate = (struct index_state *)context;
> +       struct cache_entry *ce;
> +       size_t len = base->len;
> +
> +       if (S_ISDIR(mode))
> +               return READ_TREE_RECURSIVE;
> +
> +       strbuf_addstr(base, path);
> +
> +       ce = make_cache_entry(istate, mode, oid, base->buf, 0, 0);
> +       ce->ce_flags |= CE_SKIP_WORKTREE;
> +       set_index_entry(istate, istate->cache_nr++, ce);
> +
> +       strbuf_setlen(base, len);
> +       return 0;
> +}
>
>  void ensure_full_index(struct index_state *istate)
>  {
> -       /* intentionally left blank */
> +       int i;
> +       struct index_state *full;
> +
> +       if (!istate || !istate->sparse_index)
> +               return;
> +
> +       if (!istate->repo)
> +               istate->repo = the_repository;
> +
> +       trace2_region_enter("index", "ensure_full_index", istate->repo);
> +
> +       /* initialize basics of new index */
> +       full = xcalloc(1, sizeof(struct index_state));
> +       memcpy(full, istate, sizeof(struct index_state));
> +
> +       /* then change the necessary things */
> +       full->sparse_index = 0;
> +       full->cache_alloc = (3 * istate->cache_alloc) / 2;
> +       full->cache_nr = 0;
> +       ALLOC_ARRAY(full->cache, full->cache_alloc);
> +
> +       for (i = 0; i < istate->cache_nr; i++) {
> +               struct cache_entry *ce = istate->cache[i];
> +               struct tree *tree;
> +               struct pathspec ps;
> +
> +               if (!S_ISSPARSEDIR(ce->ce_mode)) {
> +                       set_index_entry(full, full->cache_nr++, ce);
> +                       continue;
> +               }
> +               if (!(ce->ce_flags & CE_SKIP_WORKTREE))
> +                       warning(_("index entry is a directory, but not sparse (%08x)"),
> +                               ce->ce_flags);
> +
> +               /* recursively walk into cd->name */
> +               tree = lookup_tree(istate->repo, &ce->oid);
> +
> +               memset(&ps, 0, sizeof(ps));
> +               ps.recursive = 1;
> +               ps.has_wildcard = 1;
> +               ps.max_depth = -1;
> +
> +               read_tree_recursive(istate->repo, tree,
> +                                   ce->name, strlen(ce->name),
> +                                   0, &ps,
> +                                   add_path_to_index, full);
> +
> +               /* free directory entries. full entries are re-used */
> +               discard_cache_entry(ce);
> +       }
> +
> +       /* Copy back into original index. */
> +       memcpy(&istate->name_hash, &full->name_hash, sizeof(full->name_hash));
> +       istate->sparse_index = 0;
> +       free(istate->cache);

Thanks for fixing that leak that from the RFC series.

> +       istate->cache = full->cache;
> +       istate->cache_nr = full->cache_nr;
> +       istate->cache_alloc = full->cache_alloc;
> +
> +       free(full);
> +
> +       trace2_region_leave("index", "ensure_full_index", istate->repo);
>  }
> --
> gitgitgadget

Looks good to me.
