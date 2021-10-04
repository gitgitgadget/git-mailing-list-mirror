Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03258C433FE
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 13:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB0E361184
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 13:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238674AbhJDN4w (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 09:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239036AbhJDN4a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 09:56:30 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00310C06127C
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 06:46:26 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id q201so3933306pgq.12
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 06:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bDhXoWeYAwJrKfErPb+bqcZ5EzQGLSmbrZ4uUqHTuc4=;
        b=M5BNZFLI2POqHaTUDEi8fXLI4luH49An5VX8PX7muZWXHkrii8apUla0r5yt5kQ/Pa
         dgaWuSVU0Eyr9JzwQyky5zzUP+jE2ogd6kfgDCzuFjh6HGu+bin5U3M7GELzg081ciKN
         kYsaZFzcZkXWQhJUvIoR6tjBgTBkaC0XWSQFL3eqhs0NooXz5yxYkWsq/I2axIxQ/aCc
         6owbRg5FHEHd6f+Nxs314jRVC+tXUvWGAXbbWB6lbSxB7w3ZYD83USKk0/MCu2jrbM1L
         qd8WNY6DFA8DJMqYcw7OSnpAYYQvve/XkN5YmlEZ2wk6YtnNkCp1ROwTTZZgDqXtAw6L
         xaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bDhXoWeYAwJrKfErPb+bqcZ5EzQGLSmbrZ4uUqHTuc4=;
        b=rWHcHcMFDxQ9DwNjyz5/rZGgfjNNBQflUfAW1SizOwNhNiAR3Ei1xcLnFAuPH9Rn19
         6xCq9pYi5x6XOpAHgFnc0dLaI2gG9EUvK8ylxSyG6DwGENOgi1nvD4uDZEFIp1wIi2aA
         GJV32PWIFE6r1pXRqlidQXQZespozB0cFbOI4vQ/wVkK1zW4y5Cnnawvdh+a7fU9GNr1
         6xnGwaSUPck3udlZOgOhbnCQ4GuXzbMdcFSUD/mC/JjzVVD5to+1V32ZzXAi3i7hTd3v
         sB64AAMQRZdJ+yjZdcbFLZ/Ebn5W+GgZ2pK6vlixcrsV2aXQtjjW8tvKepPsxjWKgkIu
         vsPw==
X-Gm-Message-State: AOAM5304EWFizWXnR4snUAPZpn/IZBABcLbn2EA14M8Bg1ikh9H3kCQ/
        wHHz6Rw2sTJ3DX7Vpa31BRqW0+fhqdCRBLzR1kk=
X-Google-Smtp-Source: ABdhPJzIFv8wo85BZBHvmRFsKpAbjjTu/f+/M78gANyPjolCvcdxcn+fqtTdiD+JJbZHLK7ObVv2rIuXWyShp4QqQ0A=
X-Received: by 2002:a63:2d46:: with SMTP id t67mr10810857pgt.15.1633355186453;
 Mon, 04 Oct 2021 06:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover-00.10-00000000000-20211004T002226Z-avarab@gmail.com> <patch-03.10-aaad6fce194-20211004T002226Z-avarab@gmail.com>
In-Reply-To: <patch-03.10-aaad6fce194-20211004T002226Z-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 4 Oct 2021 06:45:00 -0700
Message-ID: <CABPp-BH053q8AkM+L0GNgeBq0MvN8vTpjnL9GM5HyYx+xuMitw@mail.gmail.com>
Subject: Re: [PATCH 03/10] unpack-trees.[ch]: embed "dir" in "struct unpack_trees_options"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 3, 2021 at 5:46 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> Change the "struct dir" in "struct unpack_trees_options" away from a
> pointer to being embedded in the struct itself, this mean that we can
> initialize it with our new UNPACK_TREES_OPTIONS_INIT macro.
>
> As it turned out nothing actually needed to provide its own "struct
> dir" to this API, there's another patch to "hide" the struct instead,
> see the discussion at [1], but I think just allocating it on the stack
> along with the rest makes more sense.
>
> This fixes a memory leak in "builtin/checkout.c" that's been there
> since the clear_unpack_trees_porcelain() function was added in
> 1c41d2805e4 (unpack_trees_options: free messages when done,
> 2018-05-21), i.e. we still had a memory leak from allocating the "dir"
> member here. That "dir" member had in turn been with us ever since
> 782c2d65c24 (Build in checkout, 2008-02-07).
>
> This fixes that memory leak, and allows us to remove the boilerplate
> dir_clear() elsewhere in favor of just using
> clear_unpack_trees_porcelain().
>
> 1. https://lore.kernel.org/git/87ilyjviiy.fsf@evledraar.gmail.com/
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/checkout.c  |  5 ++---
>  builtin/read-tree.c | 11 ++++-------
>  merge-ort.c         |  7 ++-----
>  merge.c             |  7 ++-----
>  unpack-trees.c      | 10 ++++------
>  unpack-trees.h      |  4 +++-
>  6 files changed, 17 insertions(+), 27 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index fea4533dbec..d4b88affba7 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -745,9 +745,8 @@ static int merge_working_tree(const struct checkout_o=
pts *opts,
>                                        &new_branch_info->commit->object.o=
id :
>                                        &new_branch_info->oid, NULL);
>                 if (opts->overwrite_ignore) {
> -                       topts.dir =3D xcalloc(1, sizeof(*topts.dir));
> -                       topts.dir->flags |=3D DIR_SHOW_IGNORED;
> -                       setup_standard_excludes(topts.dir);
> +                       topts.dir.flags |=3D DIR_SHOW_IGNORED;
> +                       setup_standard_excludes(&topts.dir);
>                 }
>                 tree =3D parse_tree_indirect(old_branch_info->commit ?
>                                            &old_branch_info->commit->obje=
ct.oid :
> diff --git a/builtin/read-tree.c b/builtin/read-tree.c
> index 847182fdad6..06f3b97ac05 100644
> --- a/builtin/read-tree.c
> +++ b/builtin/read-tree.c
> @@ -53,20 +53,17 @@ static int index_output_cb(const struct option *opt, =
const char *arg,
>  static int exclude_per_directory_cb(const struct option *opt, const char=
 *arg,
>                                     int unset)
>  {
> -       struct dir_struct *dir;
>         struct unpack_trees_options *opts;
>
>         BUG_ON_OPT_NEG(unset);
>
>         opts =3D (struct unpack_trees_options *)opt->value;
>
> -       if (opts->dir)
> +       if (opts->dir.exclude_per_dir)
>                 die("more than one --exclude-per-directory given.");
>
> -       dir =3D xcalloc(1, sizeof(*opts->dir));
> -       dir->flags |=3D DIR_SHOW_IGNORED;
> -       dir->exclude_per_dir =3D arg;
> -       opts->dir =3D dir;
> +       opts->dir.flags |=3D DIR_SHOW_IGNORED;
> +       opts->dir.exclude_per_dir =3D arg;
>         /* We do not need to nor want to do read-directory
>          * here; we are merely interested in reusing the
>          * per directory ignore stack mechanism.
> @@ -208,7 +205,7 @@ int cmd_read_tree(int argc, const char **argv, const =
char *cmd_prefix)
>         if ((opts.update || opts.index_only) && !opts.merge)
>                 die("%s is meaningless without -m, --reset, or --prefix",
>                     opts.update ? "-u" : "-i");
> -       if ((opts.dir && !opts.update))
> +       if ((opts.dir.exclude_per_dir && !opts.update))
>                 die("--exclude-per-directory is meaningless unless -u");
>         if (opts.merge && !opts.index_only)
>                 setup_work_tree();
> diff --git a/merge-ort.c b/merge-ort.c
> index 75d2b8e4b99..e526b78b88d 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -4045,9 +4045,8 @@ static int checkout(struct merge_options *opt,
>         unpack_opts.verbose_update =3D (opt->verbosity > 2);
>         unpack_opts.fn =3D twoway_merge;
>         if (1/* FIXME: opts->overwrite_ignore*/) {
> -               CALLOC_ARRAY(unpack_opts.dir, 1);
> -               unpack_opts.dir->flags |=3D DIR_SHOW_IGNORED;
> -               setup_standard_excludes(unpack_opts.dir);
> +               unpack_opts.dir.flags |=3D DIR_SHOW_IGNORED;
> +               setup_standard_excludes(&unpack_opts.dir);
>         }
>         parse_tree(prev);
>         init_tree_desc(&trees[0], prev->buffer, prev->size);
> @@ -4056,8 +4055,6 @@ static int checkout(struct merge_options *opt,
>
>         ret =3D unpack_trees(2, trees, &unpack_opts);
>         clear_unpack_trees_porcelain(&unpack_opts);
> -       dir_clear(unpack_opts.dir);
> -       FREE_AND_NULL(unpack_opts.dir);
>         return ret;
>  }
>
> diff --git a/merge.c b/merge.c
> index 086f04b0f97..9cb32990dd9 100644
> --- a/merge.c
> +++ b/merge.c
> @@ -53,7 +53,6 @@ int checkout_fast_forward(struct repository *r,
>         struct unpack_trees_options opts =3D UNPACK_TREES_OPTIONS_INIT;
>         struct tree_desc t[MAX_UNPACK_TREES];
>         int i, nr_trees =3D 0;
> -       struct dir_struct dir =3D DIR_INIT;
>         struct lock_file lock_file =3D LOCK_INIT;
>
>         refresh_index(r->index, REFRESH_QUIET, NULL, NULL, NULL);
> @@ -80,9 +79,8 @@ int checkout_fast_forward(struct repository *r,
>         }
>
>         if (overwrite_ignore) {
> -               dir.flags |=3D DIR_SHOW_IGNORED;
> -               setup_standard_excludes(&dir);
> -               opts.dir =3D &dir;
> +               opts.dir.flags |=3D DIR_SHOW_IGNORED;
> +               setup_standard_excludes(&opts.dir);
>         }
>
>         opts.head_idx =3D 1;
> @@ -100,7 +98,6 @@ int checkout_fast_forward(struct repository *r,
>                 clear_unpack_trees_porcelain(&opts);
>                 return -1;
>         }
> -       dir_clear(&dir);
>         clear_unpack_trees_porcelain(&opts);
>
>         if (write_locked_index(r->index, &lock_file, COMMIT_LOCK))
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 393c1f35a5d..94767d3f96f 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -196,6 +196,7 @@ void unpack_trees_options_init(struct unpack_trees_op=
tions *o)
>  void clear_unpack_trees_porcelain(struct unpack_trees_options *opts)
>  {
>         strvec_clear(&opts->msgs_to_free);
> +       dir_clear(&opts->dir);
>         memset(opts->msgs, 0, sizeof(opts->msgs));
>  }
>
> @@ -2085,7 +2086,7 @@ static int verify_clean_subdirectory(const struct c=
ache_entry *ce,
>          */
>         int namelen;
>         int i;
> -       struct dir_struct d;
> +       struct dir_struct d =3D DIR_INIT;
>         char *pathbuf;
>         int cnt =3D 0;
>
> @@ -2136,9 +2137,7 @@ static int verify_clean_subdirectory(const struct c=
ache_entry *ce,
>          */
>         pathbuf =3D xstrfmt("%.*s/", namelen, ce->name);
>
> -       memset(&d, 0, sizeof(d));
> -       if (o->dir)
> -               d.exclude_per_dir =3D o->dir->exclude_per_dir;
> +       d.exclude_per_dir =3D o->dir.exclude_per_dir;
>         i =3D read_directory(&d, o->src_index, pathbuf, namelen+1, NULL);
>         if (i)
>                 return add_rejected_path(o, ERROR_NOT_UPTODATE_DIR, ce->n=
ame);
> @@ -2179,8 +2178,7 @@ static int check_ok_to_remove(const char *name, int=
 len, int dtype,
>         if (ignore_case && icase_exists(o, name, len, st))
>                 return 0;
>
> -       if (o->dir &&
> -           is_excluded(o->dir, o->src_index, name, &dtype))
> +       if (is_excluded(&o->dir, o->src_index, name, &dtype))
>                 /*
>                  * ce->name is explicitly excluded, so it is Ok to
>                  * overwrite it.
> diff --git a/unpack-trees.h b/unpack-trees.h
> index 892b65ea623..40c4841748d 100644
> --- a/unpack-trees.h
> +++ b/unpack-trees.h
> @@ -5,6 +5,7 @@
>  #include "strvec.h"
>  #include "string-list.h"
>  #include "tree-walk.h"
> +#include "dir.h"
>
>  #define MAX_UNPACK_TREES MAX_TRAVERSE_TREES
>
> @@ -66,7 +67,7 @@ struct unpack_trees_options {
>                      dry_run;
>         const char *prefix;
>         int cache_bottom;
> -       struct dir_struct *dir;
> +       struct dir_struct dir;
>         struct pathspec *pathspec;
>         merge_fn_t fn;
>         const char *msgs[NB_UNPACK_TREES_WARNING_TYPES];
> @@ -93,6 +94,7 @@ struct unpack_trees_options {
>
>  #define UNPACK_TREES_OPTIONS_INIT { \
>         .msgs_to_free =3D STRVEC_INIT, \
> +       .dir =3D DIR_INIT, \
>  }
>  void unpack_trees_options_init(struct unpack_trees_options *o);
>
> --
> 2.33.0.1404.g83021034c5d

This patch is going to conflict HEAVILY with
en/removing-untracked-fixes, which Junio already said he'd merge to
next.

You should rebase your patches on that series.
