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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38EAC433DB
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 03:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71A76206B5
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 03:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbhA0D70 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 22:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbhA0DHI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 22:07:08 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C37C0613D6
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 19:05:23 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id z36so191257ooi.6
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 19:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R7Az/XnysazeDYt6KRmf6hexOne3gsj6MFEfCpJq1/8=;
        b=QhWVACgWAKY6kOZVxhImHmdyT4vnJAi+x8V8teniCaJBK3zGFA5r2xfkwxZyK5Qh9F
         +OZWrrwskaD83+i+13eHBNT/yZrKJb69su/xRKGlngr9ybWg/CeLVHxPnf5vNeNDZt3P
         gdrvWTXmOBppcZXjwR7gN6/ovcUCWPkLDvOlyHkbjV9Hc/ea7xiM8DDNuYPOkryYbWuk
         Yjg8vzMQWqTSaqFqLjiYEk+x0x3xGajAx7gYZZfyIxPGXeFX0Kz32W/BeaW9f59vCDFe
         4+uVdUpUyepzpneFrag6R4+44e4hXcxTzU0W9C6exaQNO6U7gPA4fs0eQ5iOa5BvkMs5
         omRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R7Az/XnysazeDYt6KRmf6hexOne3gsj6MFEfCpJq1/8=;
        b=kC9/5ZfSRFCIW6gTRK0GFibXzBuqIzLqtktvLWd6LhULrPy2KvCoj5EHBHRIt9OTY+
         ca68tzqqWdAr5i9UOTD42L+PfhSxKVKeRnbxeHcQyrpLD1c7jLWIaX/rEoNmjvTklKNO
         +LYW2vcog/CiUsCHTasUBdmQvUBUifyqcHmhTFAzJLXv+pZlb3YaZv6Wb/RgBB1eGpI3
         h4pPPGnwp3hjVTSzyVx9ZE8CKxEl/mInCWQAvz2J1zi+ssmN5I2wQf1xemPAejlgQ51y
         j0huW8GRnPSYB/pq/Sq64LWYJ3fopOGgUKi6uUyrkTKwduRuatmgYLOU/YcWQ7bRBeD/
         8KuQ==
X-Gm-Message-State: AOAM533/XQDvG0TekszpTOpBXIYtzoiK6DAZfY1Hm+ZMTbj08gaXE/gW
        Kjrrj0W8Wy7+3po2093/Z/d4b4FszR0kIcS6y34=
X-Google-Smtp-Source: ABdhPJxUvDmQHddsUhpCAMaRxSepxgjrEhM6DLBcFOFnT1ddnjstTuIdVX650/YTqGg1OJQoHCX/z0fAN0XoHQbLy2E=
X-Received: by 2002:a4a:decb:: with SMTP id w11mr6115011oou.32.1611716722066;
 Tue, 26 Jan 2021 19:05:22 -0800 (PST)
MIME-Version: 1.0
References: <pull.847.git.1611596533.gitgitgadget@gmail.com> <ebbe8569dcc16f2ae235c4167be0e72a53982982.1611596534.git.gitgitgadget@gmail.com>
In-Reply-To: <ebbe8569dcc16f2ae235c4167be0e72a53982982.1611596534.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 26 Jan 2021 19:05:10 -0800
Message-ID: <CABPp-BE3tLmfwyncbdTKZUgLYH_8M9zMjH=+LJG4bdGcbYDPMg@mail.gmail.com>
Subject: Re: [PATCH 02/27] sparse-index: implement ensure_full_index()
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 25, 2021 at 9:42 AM Derrick Stolee via GitGitGadget
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
> S_ISSPARSEDIR(ce) can check if a cache_entry 'ce' has this type. This
> ce_mode is not possible with the existing index formats, so we don't
> also verify all properties of a sparse-directory entry, which are:
>
>  1. ce->ce_mode == 01000755

This is a weird number.  What's the reason for choosing it?  It looks
deceptively close to 0100755, normal executable files, but has the
extra 0, meaning that ce->ce_mode & S_IFMT is 0, suggesting it has no
file type.

Since it's a directory, why not use S_IFDIR (040000)?

(GITLINK does use the weird 0160000 value, but it happens to be
S_IFLNK | S_IFDIR == 0120000 | 040000, which conveys "it's both a
directory and a symlink")

>  2. ce->flags & CE_SKIP_WORKTREE is true

Makes sense.

>  3. ce->name[ce->namelen - 1] == '/' (ends in dir separator)

Is there a particular reason for this?  I'm used to seeing names
without the trailing slash, both in the index and in tree objects.  I
don't know enough to be for or against this idea; just curious at this
point.

>  4. ce->oid references a tree object.

Makes sense...but doesn't that suggest we'd want to use ce->ce_mode = 040000?


Also, as a bit of a side comment: There have been other requests in
the past to support directory objects in the index.  The only use I
remember for them requested from others was to allow tracking empty
directories.  However, I've long wanted to introduce a new "blobtree"
object to git, so that a user can "git add" some big binary file, but
internally git splits the binary file up and stores it as multiple
blobs within git plus a new "blobtree" object that references all the
individual blobs with enough information about how to stitch all the
blobs together to get the original file.  I had a few different forms
of "blobtree" things that I was interested in.  I think brian once
suggested some similar idea.

> These are all semi-enforced in ensure_full_index() to some extent. Any
> deviation will cause a warning at minimum or a failure in the worst
> case.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  cache.h        | 11 +++++-
>  read-cache.c   |  9 +++++
>  sparse-index.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  sparse-index.h |  1 +
>  4 files changed, 113 insertions(+), 2 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index f9c7a603841..884046ca5b8 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -204,6 +204,10 @@ struct cache_entry {
>  #error "CE_EXTENDED_FLAGS out of range"
>  #endif
>
> +#define CE_MODE_SPARSE_DIRECTORY 01000755
> +#define SPARSE_DIR_MODE 0100

Another magic value.  Feels like the commit message should reference
this one and why it was picked.  Seems odd to me, and possibly
problematic to re-use file permission bits that might collide with
files recorded by really old versions of git.  Maybe that's not a
concern, though.

> +#define S_ISSPARSEDIR(m) ((m)->ce_mode == CE_MODE_SPARSE_DIRECTORY)

Should the special sauce apply to ce_flags rather than ce_mode?  Thus,
instead of an S_ISSPARSEDIR, perhaps have a ce_sparse_dir macro
(similar to ce_skip_worktree) based on a CE_SPARSE_DIR value (similar
to CE_SKIP_WORKTREE)?

Or, alternatively, do we need a single special state here?  Could we
check for a combination of ce_mode == 040000 && ce_skip_worktree(ce)?

> +
>  /* Forward structure decls */
>  struct pathspec;
>  struct child_process;
> @@ -249,6 +253,8 @@ static inline unsigned int create_ce_mode(unsigned int mode)
>  {
>         if (S_ISLNK(mode))
>                 return S_IFLNK;
> +       if (mode == SPARSE_DIR_MODE)
> +               return CE_MODE_SPARSE_DIRECTORY;
>         if (S_ISDIR(mode) || S_ISGITLINK(mode))
>                 return S_IFGITLINK;
>         return S_IFREG | ce_permissions(mode);
> @@ -319,7 +325,8 @@ struct index_state {
>                  drop_cache_tree : 1,
>                  updated_workdir : 1,
>                  updated_skipworktree : 1,
> -                fsmonitor_has_run_once : 1;
> +                fsmonitor_has_run_once : 1,
> +                sparse_index : 1;
>         struct hashmap name_hash;
>         struct hashmap dir_hash;
>         struct object_id oid;
> @@ -721,6 +728,8 @@ int read_index_from(struct index_state *, const char *path,
>                     const char *gitdir);
>  int is_index_unborn(struct index_state *);
>
> +void ensure_full_index(struct index_state *istate);
> +
>  /* For use with `write_locked_index()`. */
>  #define COMMIT_LOCK            (1 << 0)
>  #define SKIP_IF_UNCHANGED      (1 << 1)
> diff --git a/read-cache.c b/read-cache.c
> index ecf6f689940..1097ecbf132 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -101,6 +101,9 @@ static const char *alternate_index_output;
>
>  static void set_index_entry(struct index_state *istate, int nr, struct cache_entry *ce)
>  {
> +       if (S_ISSPARSEDIR(ce))
> +               istate->sparse_index = 1;
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
> index 82183ead563..1e70244dc13 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -1,8 +1,100 @@
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
> +               if (!S_ISSPARSEDIR(ce)) {
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
> +       istate->cache = full->cache;

Haven't you leaked the original istate->cache here?

> +       istate->cache_nr = full->cache_nr;
> +       istate->cache_alloc = full->cache_alloc;
> +
> +       free(full);
> +
> +       trace2_region_leave("index", "ensure_full_index", istate->repo);
>  }
> diff --git a/sparse-index.h b/sparse-index.h
> index 8dda92032e2..a2777dcac59 100644
> --- a/sparse-index.h
> +++ b/sparse-index.h
> @@ -3,5 +3,6 @@
>
>  struct index_state;
>  void ensure_full_index(struct index_state *istate);
> +int convert_to_sparse(struct index_state *istate);

Seems logically that you'd add one, but was this meant to be included
in a later patch?

>
>  #endif
> \ No newline at end of file
> --
> gitgitgadget
>
