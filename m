Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860E3C433F5
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 16:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66F4161130
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 16:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238846AbhJFQOl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 12:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbhJFQOk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 12:14:40 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FEFC061746
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 09:12:48 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id f9so12107111edx.4
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 09:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mQQ2jtjMV+PEmS7hVos7XeNx3k1cXpGZW+akxPn1r6M=;
        b=mW5DqcFoOesCWt+LwzXcwpm3I+1XhQSP0MQn14qgkwyCo8MzQ2pOO1Sp7sapkSs3hf
         8UqSi+srgbvGNUateWLITlGqcp1mfIvxpztHhQTWFrLm9laY6f02HTj3e3Hd0jr6A2/1
         thjSYlC5YSgc1Ny8q7/jr8BQrXfUQAxM6nNigdC5WuvY0qPGNWTPoDwwAqUUTZ5tTEr9
         jgJo9ogxlTd/i3ek6a7MMzbVLeDIKRC6AP8IWIY7oh+TKKM9fXEUEByEK4MU28JQyzP6
         085sVv6WABfZWImKHpySxhJc70R5ysbZlDGczY7r3uSY+XLSDQdUfa9makXqpupoPysf
         hhwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mQQ2jtjMV+PEmS7hVos7XeNx3k1cXpGZW+akxPn1r6M=;
        b=LwlrTfSfmR9kNF3fHmKJ5FsPGvBkMKBU/OOEEiJrLnjWBMtWNOM+NtLsSfthhg+9kH
         ddWcVh8uaNk8RwbntIdn0AAXquI895pRcpwiZbEo7Qj28o/mDMPWcKxs+O/lFe1XEplg
         RNofAsqmewc4RK+JhPr3cKLGE6SboqMlEfeOYp9aVZf1koerNNxV4OXGltGUymoNzqRL
         fesFaEaHA13L8tc4t5z6OWplTOStzQNFz/IgNsGR2a59lNRAu0V0zHYPMFZ31Gq4pSra
         66w5sFUbTEcypv8Vj2lrK29X0VzErbqwZdeF7q9Qpxg4cKmMUjx9ridGjP/GNw1FBTf8
         Hzlw==
X-Gm-Message-State: AOAM531TDbhJepwNaHDNXFkKyAxNTHK6JLBbdL1ZBSdI2igudu1B7h02
        LibuOeU7Y1jq7NzGLBtiHyfFQPUoq85sTX2qzkY=
X-Google-Smtp-Source: ABdhPJxq9DcXGSQAPpeGMgJopXgCm57SRM0FjTGqh4x7XDhg7wH9cXiOwvMctYV3iTUPkvVGW/SiG6Mqr82dYJxjjEQ=
X-Received: by 2002:a17:906:8cd:: with SMTP id o13mr32169597eje.341.1633536766695;
 Wed, 06 Oct 2021 09:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover-0.2-00000000000-20211006T093405Z-avarab@gmail.com> <patch-2.2-21f9da06b46-20211006T093405Z-avarab@gmail.com>
In-Reply-To: <patch-2.2-21f9da06b46-20211006T093405Z-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 6 Oct 2021 09:12:35 -0700
Message-ID: <CABPp-BGrGgjUgK1c+0NezY6t2M0yNMb25XHnwaTyXH9ZeAXKcA@mail.gmail.com>
Subject: Re: [PATCH 2/2] built-ins & lib: plug memory leaks with unpack_trees_options_release()
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

On Wed, Oct 6, 2021 at 2:41 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> Plug memory leaks in various built-ins and the "diff-lib.c" and
> "sequencer.c" libraries that were missing
> unpack_trees_options_release() calls.

Since you've rebased these changes, unpack_trees_options_release()
doesn't exist.  You correctly refer to it below as
clear_unpack_trees_porcelain().

However, I'm not sure about most of these changes.
clear_unpack_trees_porcelain() currently only cleans up memory
allocated by setup_unpack_trees_porcelain().  Your other series
renamed the cleanup function and added a dir_clear() to it, but since
my series moved the dir_clear() into unpack_trees(), we don't have
that other bit of cleanup to do.  So, I don't think there's a leak,
unless setup_unpack_trees_porcelain() has been called.

Granted, it is safe to call clear_unpack_trees_porcelain() even if
setup_unpack_trees_porcelain() isn't called, but does it make sense?
The names suggest they are a pair, so if we want to add these (which
may be nice to prevent future additions to unpack_trees_options from
causing leaks), then we may want to rename
clear_unpack_trees_porcelain() at the same time.

I'll comment more below...

> In the case of "git archive" we'll need to memset() the "struct
> unpack_trees_options" first, to avoid having to call
> clear_unpack_trees_porcelain() twice within the
> "!args->worktree_attributes" branch.

This was slightly confusing, though the code is clear.  It suggested
to me that unpack_trees_options was being used uninitialized.  Perhaps
"...we'll need to move the memset() of struct unpack_trees_options
earlier to avoid..." ?

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  archive.c           | 11 ++++++++---
>  builtin/am.c        | 17 ++++++++++++-----
>  builtin/checkout.c  |  9 +++++++--
>  builtin/clone.c     |  1 +
>  builtin/commit.c    |  6 +++++-
>  builtin/merge.c     |  6 ++++--
>  builtin/read-tree.c | 14 ++++++++++----
>  builtin/reset.c     | 13 +++++++++----
>  builtin/stash.c     | 14 ++++++++++----
>  diff-lib.c          |  5 ++++-
>  sequencer.c         |  2 ++
>  11 files changed, 72 insertions(+), 26 deletions(-)
>
> diff --git a/archive.c b/archive.c
> index a3bbb091256..b0acc5a8b88 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -299,16 +299,18 @@ int write_archive_entries(struct archiver_args *arg=
s,
>         /*
>          * Setup index and instruct attr to read index only
>          */
> +       memset(&opts, 0, sizeof(opts));
>         if (!args->worktree_attributes) {
> -               memset(&opts, 0, sizeof(opts));
>                 opts.index_only =3D 1;
>                 opts.head_idx =3D -1;
>                 opts.src_index =3D args->repo->index;
>                 opts.dst_index =3D args->repo->index;
>                 opts.fn =3D oneway_merge;
>                 init_tree_desc(&t, args->tree->buffer, args->tree->size);
> -               if (unpack_trees(1, &t, &opts))
> -                       return -1;
> +               if (unpack_trees(1, &t, &opts)) {
> +                       err =3D -1;
> +                       goto cleanup;
> +               }
>                 git_attr_set_direction(GIT_ATTR_INDEX);
>         }
>
> @@ -347,8 +349,11 @@ int write_archive_entries(struct archiver_args *args=
,
>                 if (err)
>                         break;
>         }
> +
> +cleanup:
>         strbuf_release(&path_in_archive);
>         strbuf_release(&content);
> +       clear_unpack_trees_porcelain(&opts);
>
>         return err;
>  }
> diff --git a/builtin/am.c b/builtin/am.c
> index f296226e95f..0126ec2669b 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -1903,6 +1903,7 @@ static int fast_forward_to(struct tree *head, struc=
t tree *remote, int reset)
>         struct lock_file lock_file =3D LOCK_INIT;
>         struct unpack_trees_options opts;
>         struct tree_desc t[2];
> +       int ret =3D 0;
>
>         if (parse_tree(head) || parse_tree(remote))
>                 return -1;
> @@ -1925,13 +1926,15 @@ static int fast_forward_to(struct tree *head, str=
uct tree *remote, int reset)
>
>         if (unpack_trees(2, t, &opts)) {
>                 rollback_lock_file(&lock_file);
> -               return -1;
> +               ret =3D -1;
> +               goto cleanup;
>         }
>
>         if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
>                 die(_("unable to write new index file"));
> -
> -       return 0;
> +cleanup:
> +       clear_unpack_trees_porcelain(&opts);
> +       return ret;
>  }
>
>  /**
> @@ -1943,6 +1946,7 @@ static int merge_tree(struct tree *tree)
>         struct lock_file lock_file =3D LOCK_INIT;
>         struct unpack_trees_options opts;
>         struct tree_desc t[1];
> +       int ret =3D 0;
>
>         if (parse_tree(tree))
>                 return -1;
> @@ -1959,13 +1963,16 @@ static int merge_tree(struct tree *tree)
>
>         if (unpack_trees(1, t, &opts)) {
>                 rollback_lock_file(&lock_file);
> -               return -1;
> +               ret =3D -1;
> +               goto cleanup;
>         }
>
>         if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
>                 die(_("unable to write new index file"));
>
> -       return 0;
> +cleanup:
> +       clear_unpack_trees_porcelain(&opts);
> +       return ret;
>  }
>
>  /**
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index cbf73b8c9f6..7b74380528b 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -641,6 +641,7 @@ static int reset_tree(struct tree *tree, const struct=
 checkout_opts *o,
>  {
>         struct unpack_trees_options opts;
>         struct tree_desc tree_desc;
> +       int ret;
>
>         memset(&opts, 0, sizeof(opts));
>         opts.head_idx =3D -1;
> @@ -670,10 +671,14 @@ static int reset_tree(struct tree *tree, const stru=
ct checkout_opts *o,
>                  */
>                 /* fallthrough */
>         case 0:
> -               return 0;
> +               ret =3D 0;
> +               break;
>         default:
> -               return 128;
> +               ret =3D 128;
>         }
> +
> +       clear_unpack_trees_porcelain(&opts);
> +       return ret;
>  }
>
>  static void setup_branch_path(struct branch_info *branch)
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 559acf9e036..c489a9bda10 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -699,6 +699,7 @@ static int checkout(int submodule_progress)
>         init_tree_desc(&t, tree->buffer, tree->size);
>         if (unpack_trees(1, &t, &opts) < 0)
>                 die(_("unable to checkout working tree"));
> +       clear_unpack_trees_porcelain(&opts);
>
>         free(head);
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index e7320f66f95..55bb178289f 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -305,6 +305,7 @@ static void create_base_index(const struct commit *cu=
rrent_head)
>         struct tree *tree;
>         struct unpack_trees_options opts;
>         struct tree_desc t;
> +       int exit_early =3D 0;
>
>         if (!current_head) {
>                 discard_cache();
> @@ -325,7 +326,10 @@ static void create_base_index(const struct commit *c=
urrent_head)
>         parse_tree(tree);
>         init_tree_desc(&t, tree->buffer, tree->size);
>         if (unpack_trees(1, &t, &opts))
> -               exit(128); /* We've already reported the error, finish dy=
ing */
> +               exit_early =3D 1; /* We've already reported the error, fi=
nish dying */
> +       clear_unpack_trees_porcelain(&opts);
> +       if (exit_early)
> +               exit(128);
>  }
>
>  static void refresh_cache_or_die(int refresh_flags)
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 0ccd5e1ac83..b4bdba2faf6 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -671,6 +671,7 @@ static int read_tree_trivial(struct object_id *common=
, struct object_id *head,
>         struct tree *trees[MAX_UNPACK_TREES];
>         struct tree_desc t[MAX_UNPACK_TREES];
>         struct unpack_trees_options opts;
> +       int ret =3D 0;
>
>         memset(&opts, 0, sizeof(opts));
>         opts.head_idx =3D 2;
> @@ -697,8 +698,9 @@ static int read_tree_trivial(struct object_id *common=
, struct object_id *head,
>                 init_tree_desc(t+i, trees[i]->buffer, trees[i]->size);
>         }
>         if (unpack_trees(nr_trees, t, &opts))
> -               return -1;
> -       return 0;
> +               ret =3D -1;
> +       clear_unpack_trees_porcelain(&opts);
> +       return ret;
>  }
>
>  static void write_tree_trivial(struct object_id *oid)
> diff --git a/builtin/read-tree.c b/builtin/read-tree.c
> index 2109c4c9e5c..060daa3913f 100644
> --- a/builtin/read-tree.c
> +++ b/builtin/read-tree.c
> @@ -149,6 +149,7 @@ int cmd_read_tree(int argc, const char **argv, const =
char *cmd_prefix)
>                 OPT__QUIET(&opts.quiet, N_("suppress feedback messages"))=
,
>                 OPT_END()
>         };
> +       int ret =3D 0;
>
>         memset(&opts, 0, sizeof(opts));
>         opts.head_idx =3D -1;
> @@ -243,11 +244,13 @@ int cmd_read_tree(int argc, const char **argv, cons=
t char *cmd_prefix)
>                 parse_tree(tree);
>                 init_tree_desc(t+i, tree->buffer, tree->size);
>         }
> -       if (unpack_trees(nr_trees, t, &opts))
> -               return 128;
> +       if (unpack_trees(nr_trees, t, &opts)) {
> +               ret =3D 128;
> +               goto cleanup;
> +       }
>
>         if (opts.debug_unpack || opts.dry_run)
> -               return 0; /* do not write the index out */
> +               goto cleanup; /* do not write the index out */
>
>         /*
>          * When reading only one tree (either the most basic form,
> @@ -262,5 +265,8 @@ int cmd_read_tree(int argc, const char **argv, const =
char *cmd_prefix)
>
>         if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
>                 die("unable to write new index file");
> -       return 0;
> +
> +cleanup:
> +       clear_unpack_trees_porcelain(&opts);
> +       return ret;
>  }
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 73935953494..8fb9bee1a98 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -85,10 +85,14 @@ static int reset_index(const char *ref, const struct =
object_id *oid, int reset_t
>
>         if (reset_type =3D=3D KEEP) {
>                 struct object_id head_oid;
> -               if (get_oid("HEAD", &head_oid))
> -                       return error(_("You do not have a valid HEAD."));
> -               if (!fill_tree_descriptor(the_repository, desc + nr, &hea=
d_oid))
> -                       return error(_("Failed to find tree of HEAD."));
> +               if (get_oid("HEAD", &head_oid)) {
> +                       error(_("You do not have a valid HEAD."));
> +                       goto out;
> +               }
> +               if (!fill_tree_descriptor(the_repository, desc + nr, &hea=
d_oid)) {
> +                       error(_("Failed to find tree of HEAD."));
> +                       goto out;
> +               }
>                 nr++;
>                 opts.fn =3D twoway_merge;
>         }
> @@ -110,6 +114,7 @@ static int reset_index(const char *ref, const struct =
object_id *oid, int reset_t
>         ret =3D 0;
>
>  out:
> +       clear_unpack_trees_porcelain(&opts);
>         for (i =3D 0; i < nr; i++)
>                 free((void *)desc[i].buffer);
>         return ret;
> diff --git a/builtin/stash.c b/builtin/stash.c
> index cc93ace4223..6bde00393fe 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -237,6 +237,7 @@ static int reset_tree(struct object_id *i_tree, int u=
pdate, int reset)
>         struct tree_desc t[MAX_UNPACK_TREES];
>         struct tree *tree;
>         struct lock_file lock_file =3D LOCK_INIT;
> +       int ret =3D 0;
>
>         read_cache_preload(NULL);
>         if (refresh_cache(REFRESH_QUIET))
> @@ -262,13 +263,17 @@ static int reset_tree(struct object_id *i_tree, int=
 update, int reset)
>                 opts.preserve_ignored =3D 0; /* FIXME: !overwrite_ignore =
*/
>         opts.fn =3D oneway_merge;
>
> -       if (unpack_trees(nr_trees, t, &opts))
> -               return -1;
> +       if (unpack_trees(nr_trees, t, &opts)) {
> +               ret =3D -1;
> +               goto cleanup;
> +       }
>
>         if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
> -               return error(_("unable to write new index file"));
> +               ret =3D error(_("unable to write new index file"));
>
> -       return 0;
> +cleanup:
> +       clear_unpack_trees_porcelain(&opts);
> +       return ret;
>  }
>
>  static int diff_tree_binary(struct strbuf *out, struct object_id *w_comm=
it)
> @@ -833,6 +838,7 @@ static void diff_include_untracked(const struct stash=
_info *info, struct diff_op
>
>         if (unpack_trees(ARRAY_SIZE(tree_desc), tree_desc, &unpack_tree_o=
pt))
>                 die(_("failed to unpack trees"));
> +       clear_unpack_trees_porcelain(&unpack_tree_opt);
>
>         do_diff_cache(&info->b_commit, diff_opt);
>  }
> diff --git a/diff-lib.c b/diff-lib.c
> index ca085a03efc..ddfbcf22abf 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -527,6 +527,7 @@ static int diff_cache(struct rev_info *revs,
>         struct tree *tree;
>         struct tree_desc t;
>         struct unpack_trees_options opts;
> +       int ret;
>
>         tree =3D parse_tree_indirect(tree_oid);
>         if (!tree)
> @@ -546,7 +547,9 @@ static int diff_cache(struct rev_info *revs,
>         opts.pathspec->recursive =3D 1;
>
>         init_tree_desc(&t, tree->buffer, tree->size);
> -       return unpack_trees(1, &t, &opts);
> +       ret =3D unpack_trees(1, &t, &opts);
> +       clear_unpack_trees_porcelain(&opts);
> +       return ret;
>  }
>
>  void diff_get_merge_base(const struct rev_info *revs, struct object_id *=
mb)

I think none of the above are cases where
setup_unpack_trees_porcelain() were called, and thus aren't fixing
current leaks (but might be helping us prevent future leaks, as
discussed above)

> diff --git a/sequencer.c b/sequencer.c
> index 6872b7b00a4..74d478d67d3 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3720,6 +3720,7 @@ static int do_reset(struct repository *r,
>                 rollback_lock_file(&lock);
>                 free((void *)desc.buffer);
>                 strbuf_release(&ref_name);
> +               clear_unpack_trees_porcelain(&unpack_tree_opts);
>                 return -1;
>         }
>
> @@ -3736,6 +3737,7 @@ static int do_reset(struct repository *r,
>                                  NULL, 0, UPDATE_REFS_MSG_ON_ERR);
>
>         strbuf_release(&ref_name);
> +       clear_unpack_trees_porcelain(&unpack_tree_opts);
>         return ret;
>  }

This one is a leak fix, but I think it's incomplete.  I count four
return statements in do_reset(), after the
setup_unpack_trees_porcelain() call, but here you only add
clear_unpack_trees_porcelain() calls before two of them.  I think you
need to add calls for the other two as well.  Or restructure the
returns to use a "goto cleanup" or something like that.
