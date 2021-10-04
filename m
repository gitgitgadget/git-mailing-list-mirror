Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6905C433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 13:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A67DE61184
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 13:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238806AbhJDN4g (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 09:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbhJDN40 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 09:56:26 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8211EC061749
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 06:45:31 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id y1so11116996plk.10
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 06:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x+WPl3Y6yN6Hoj6+Tgp2hFtxfBDy4L4kDMqbfKxelTU=;
        b=n8lvea0spEHT55nE2nNMoxO2c3Zfhz/Mcvrwo2Qlmhcbpso2JbuHudgO205QsJIyUn
         uOTWmKoCA9VVNcN6twbs74U+vJ66BF+N8qwaZTJMV1oYhHo2Ld6hz0jVhCiZdw0EiH7R
         7ONfeVfWnWhAqa2QUbd6Wo69mDg8ejQ6+djJ0hkczVaAHIiIDmv+f0us0QDAbMWuwhZv
         ywg5vsEikLjiprVpKwGyprnATGrB6Zt+XuWnAfQTvVBy9ICHscT/ASzQW3SACo2HsV9L
         7Y6jJUZUhyW8qoEj6kjnBIds7RkuSknDct3r0WBu2sEzg/h9xV38eilt5ZLGsGkg45de
         ZEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x+WPl3Y6yN6Hoj6+Tgp2hFtxfBDy4L4kDMqbfKxelTU=;
        b=8EwJNBB4B6UtQKG027g0t+4P4jWJHpIMKgeFbQk2GKNZnJRr4/6OVDykeZFp45GQ91
         /Fxui4fc4kEdfB1egVWb5n3LcUlzUCayWaqZ2qHV7/XtCeB1uNw+7FFxQz1axrPCtUHK
         856v8ImKlT6iZNTyoCMryFJMs18cM0y0YIzZkk9gxZHII20OpWHS3eGY285gbfZ0mAnv
         eqyj7Sn/dY1bUMwmitwiIZzTa7sSlErJuCFBLXp35ynbkKL1eMDgWPX83+wAdy7YFiya
         L2SjnITAuelE6VBGGN1+gH4/rK/mMyTJiTfBPLYfRwwRDZBPcVBWmKAudN6mpTABBaYM
         yxeA==
X-Gm-Message-State: AOAM5329TKDiwJqAUAPy+bg7ASjIVaxy9lvNx8XybMewez4/5+IF7C+j
        26xTL0IryfoWqW+GCHpeSvxVSFimz2QMCq2LZy0=
X-Google-Smtp-Source: ABdhPJx2PSHZmLjLXS3M14L3TLRm9Gl9fSJzTU6wvO3bv4hRnxDXyZLW8WFQZORRPd5gdgiVp8oUCHQ8U/gcZNLcjvU=
X-Received: by 2002:a17:902:7144:b0:13c:8d49:fc46 with SMTP id
 u4-20020a170902714400b0013c8d49fc46mr23000344plm.45.1633355130824; Mon, 04
 Oct 2021 06:45:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover-00.10-00000000000-20211004T002226Z-avarab@gmail.com> <patch-10.10-06ad6baf566-20211004T002226Z-avarab@gmail.com>
In-Reply-To: <patch-10.10-06ad6baf566-20211004T002226Z-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 4 Oct 2021 06:45:00 -0700
Message-ID: <CABPp-BFr7R_swdxswmoGRF3=uu0s8HgppfrnFEQ+NvS1oh+_og@mail.gmail.com>
Subject: Re: [PATCH 10/10] built-ins: plug memory leaks with unpack_trees_options_release()
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
> Plug memory leaks in various built-ins that were missing
> unpack_trees_options_release() calls. In an earlier commit these
> functions were all made to use the "UNPACK_TREES_OPTIONS_INIT" macro,
> now let's have the ones that didn't clean up their memory do so.

This commit message doesn't say anything about what was leaking.  You
should really bring up that it was the dir_clear() you added to
unpack_trees_options_release() earlier in the series that is important
here (or at least that's what I presume is the important fix).

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  archive.c           |  9 +++++++--
>  builtin/am.c        | 17 ++++++++++++-----
>  builtin/checkout.c  |  9 +++++++--
>  builtin/clone.c     |  1 +
>  builtin/commit.c    |  6 +++++-
>  builtin/merge.c     |  6 ++++--
>  builtin/read-tree.c | 14 ++++++++++----
>  builtin/reset.c     | 13 +++++++++----
>  builtin/stash.c     | 14 ++++++++++----
>  diff-lib.c          |  5 ++++-
>  10 files changed, 69 insertions(+), 25 deletions(-)
>
> diff --git a/archive.c b/archive.c
> index 210d7235c5a..003db7d355d 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -306,8 +306,10 @@ int write_archive_entries(struct archiver_args *args=
,
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
> @@ -346,8 +348,11 @@ int write_archive_entries(struct archiver_args *args=
,
>                 if (err)
>                         break;
>         }
> +
> +cleanup:
>         strbuf_release(&path_in_archive);
>         strbuf_release(&content);
> +       unpack_trees_options_release(&opts);
>
>         return err;
>  }
> diff --git a/builtin/am.c b/builtin/am.c
> index 82641ce68ec..4d4bb473c0f 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -1903,6 +1903,7 @@ static int fast_forward_to(struct tree *head, struc=
t tree *remote, int reset)
>         struct lock_file lock_file =3D LOCK_INIT;
>         struct unpack_trees_options opts =3D UNPACK_TREES_OPTIONS_INIT;
>         struct tree_desc t[2];
> +       int ret =3D 0;
>
>         if (parse_tree(head) || parse_tree(remote))
>                 return -1;
> @@ -1923,13 +1924,15 @@ static int fast_forward_to(struct tree *head, str=
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
> +       unpack_trees_options_release(&opts);
> +       return ret;
>  }
>
>  /**
> @@ -1941,6 +1944,7 @@ static int merge_tree(struct tree *tree)
>         struct lock_file lock_file =3D LOCK_INIT;
>         struct unpack_trees_options opts =3D UNPACK_TREES_OPTIONS_INIT;
>         struct tree_desc t[1];
> +       int ret =3D 0;
>
>         if (parse_tree(tree))
>                 return -1;
> @@ -1956,13 +1960,16 @@ static int merge_tree(struct tree *tree)
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
> +       unpack_trees_options_release(&opts);
> +       return ret;
>  }
>
>  /**
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 482d17676a0..fd76b504861 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -641,6 +641,7 @@ static int reset_tree(struct tree *tree, const struct=
 checkout_opts *o,
>  {
>         struct unpack_trees_options opts =3D UNPACK_TREES_OPTIONS_INIT;
>         struct tree_desc tree_desc;
> +       int ret;
>
>         opts.head_idx =3D -1;
>         opts.update =3D worktree;
> @@ -667,10 +668,14 @@ static int reset_tree(struct tree *tree, const stru=
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
> +       unpack_trees_options_release(&opts);
> +       return ret;
>  }
>
>  static void setup_branch_path(struct branch_info *branch)
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 0df820c5970..df3bb9a7884 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -697,6 +697,7 @@ static int checkout(int submodule_progress)
>         init_tree_desc(&t, tree->buffer, tree->size);
>         if (unpack_trees(1, &t, &opts) < 0)
>                 die(_("unable to checkout working tree"));
> +       unpack_trees_options_release(&opts);
>
>         free(head);
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 6cc7313bad8..84c79ecb5a5 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -305,6 +305,7 @@ static void create_base_index(const struct commit *cu=
rrent_head)
>         struct tree *tree;
>         struct unpack_trees_options opts =3D UNPACK_TREES_OPTIONS_INIT;
>         struct tree_desc t;
> +       int exit_early =3D 0;
>
>         if (!current_head) {
>                 discard_cache();
> @@ -324,7 +325,10 @@ static void create_base_index(const struct commit *c=
urrent_head)
>         parse_tree(tree);
>         init_tree_desc(&t, tree->buffer, tree->size);
>         if (unpack_trees(1, &t, &opts))
> -               exit(128); /* We've already reported the error, finish dy=
ing */
> +               exit_early =3D 1; /* We've already reported the error, fi=
nish dying */
> +       unpack_trees_options_release(&opts);
> +       if (exit_early)
> +               exit(128);
>  }
>
>  static void refresh_cache_or_die(int refresh_flags)
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 73290a07fcc..28089e2c5ed 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -671,6 +671,7 @@ static int read_tree_trivial(struct object_id *common=
, struct object_id *head,
>         struct tree *trees[MAX_UNPACK_TREES];
>         struct tree_desc t[MAX_UNPACK_TREES];
>         struct unpack_trees_options opts =3D UNPACK_TREES_OPTIONS_INIT;
> +       int ret =3D 0;
>
>         opts.head_idx =3D 2;
>         opts.src_index =3D &the_index;
> @@ -695,8 +696,9 @@ static int read_tree_trivial(struct object_id *common=
, struct object_id *head,
>                 init_tree_desc(t+i, trees[i]->buffer, trees[i]->size);
>         }
>         if (unpack_trees(nr_trees, t, &opts))
> -               return -1;
> -       return 0;
> +               ret =3D -1;
> +       unpack_trees_options_release(&opts);
> +       return ret;
>  }
>
>  static void write_tree_trivial(struct object_id *oid)
> diff --git a/builtin/read-tree.c b/builtin/read-tree.c
> index 06f3b97ac05..8f1b8a7e74c 100644
> --- a/builtin/read-tree.c
> +++ b/builtin/read-tree.c
> @@ -154,6 +154,7 @@ int cmd_read_tree(int argc, const char **argv, const =
char *cmd_prefix)
>                 OPT__QUIET(&opts.quiet, N_("suppress feedback messages"))=
,
>                 OPT_END()
>         };
> +       int ret =3D 0;
>
>         opts.head_idx =3D -1;
>         opts.src_index =3D &the_index;
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
> +       unpack_trees_options_release(&opts);
> +       return ret;
>  }
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 86c604b21e9..713d084c3eb 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -78,10 +78,14 @@ static int reset_index(const char *ref, const struct =
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
> @@ -103,6 +107,7 @@ static int reset_index(const char *ref, const struct =
object_id *oid, int reset_t
>         ret =3D 0;
>
>  out:
> +       unpack_trees_options_release(&opts);
>         for (i =3D 0; i < nr; i++)
>                 free((void *)desc[i].buffer);
>         return ret;
> diff --git a/builtin/stash.c b/builtin/stash.c
> index 1137e5fcbe8..be6ecb1ae11 100644
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
> @@ -258,13 +259,17 @@ static int reset_tree(struct object_id *i_tree, int=
 update, int reset)
>         opts.update =3D update;
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
> +       unpack_trees_options_release(&opts);
> +       return ret;
>  }
>
>  static int diff_tree_binary(struct strbuf *out, struct object_id *w_comm=
it)
> @@ -815,6 +820,7 @@ static void diff_include_untracked(const struct stash=
_info *info, struct diff_op
>
>         if (unpack_trees(ARRAY_SIZE(tree_desc), tree_desc, &unpack_tree_o=
pt))
>                 die(_("failed to unpack trees"));
> +       unpack_trees_options_release(&unpack_tree_opt);
>
>         do_diff_cache(&info->b_commit, diff_opt);
>  }
> diff --git a/diff-lib.c b/diff-lib.c
> index 8a08d9af4eb..2d8a90a51b2 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -527,6 +527,7 @@ static int diff_cache(struct rev_info *revs,
>         struct tree *tree;
>         struct tree_desc t;
>         struct unpack_trees_options opts =3D UNPACK_TREES_OPTIONS_INIT;
> +       int ret;
>
>         tree =3D parse_tree_indirect(tree_oid);
>         if (!tree)
> @@ -545,7 +546,9 @@ static int diff_cache(struct rev_info *revs,
>         opts.pathspec->recursive =3D 1;
>
>         init_tree_desc(&t, tree->buffer, tree->size);
> -       return unpack_trees(1, &t, &opts);
> +       ret =3D unpack_trees(1, &t, &opts);
> +       unpack_trees_options_release(&opts);
> +       return ret;
>  }
>
>  void diff_get_merge_base(const struct rev_info *revs, struct object_id *=
mb)
> --
> 2.33.0.1404.g83021034c5d

Looks good to me; thanks for catching and fixing these leaks.
