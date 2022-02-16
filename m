Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88442C433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 16:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236688AbiBPQvO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 11:51:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234383AbiBPQvN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 11:51:13 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B4B290593
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 08:51:00 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id hw13so601260ejc.9
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 08:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WXzsTah1bU0rf3E2rNx6WXEojUeZiGgaQx8+istGixQ=;
        b=LigkXUV4Yx+x5hAU5uuhiO08k8PfuhqITlL1rPx/7gC+/eIMpMC8Ws+p9ppSMWxkTj
         eizVldZrKDmAL7/geq3Dt+xuC/iW8fMuIF1qmJP6XmMsrlcQHteaMRUV63VQTsghiRJ2
         Fc6I0VE1jX6oVnsCRvodtupvqN39HcEUEl+avL4OTAGfiyJgDoh8GzUNum9aA/s3Ox6o
         JtrjygOcehkzRwoEPCEcUBO5gKc8pplUfEtx75M1nUnhSqesqvXS7Sa2nk+fc3UivsYq
         qmBu5vibP1gRe1KUigslz+CszrbVUskRgwQNFYxqoFKP+6UnvaUgm0HLF6cPpsGcYbZO
         XzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WXzsTah1bU0rf3E2rNx6WXEojUeZiGgaQx8+istGixQ=;
        b=C2HkxMkGZ5SQWByMdoUE/vCtOWu9oA9chpKsjsLTVnwOYuJMvcyhJv4aX4GlcfCGJc
         UrP9cUZJ0icwEyOmYnSVlwT6cmtkOxoTYWE845LqW6lQlY8cK4GV48HmMOsTyMQeytTH
         Ni2qtg9AJ3b32cgXrWNCKClPAjbcqt8qPiD1v4A+QgeUms+dYkYOb/ySEJ3cNxPIVfcq
         cQb9Quklefb6gN02XqDqC7W0WTTKLAFfIrWWnzfJc8cGBeBBt2Ug8u+oXNkonMLYA1qt
         pSB6as1ZZ6jeZ94qyHpv9vqgDK+eh9YipNeiWjfCp4g1PzIsicfHL2sFKIP/sYPlARDi
         rJEw==
X-Gm-Message-State: AOAM533gbns0dJ1504VIi7A78DRd1vU+eeY6cDqYDLCXSYZT1UcXo9hT
        E1gLyPtYOms5apiKVgLhv+LarqmE5vtwFmngSTFdzhOTmXs=
X-Google-Smtp-Source: ABdhPJxlJtqzE4Ng58Y8wsuUQdQoArhkPRO8eZrpyMXwGeTQ+SL9aFOJoGoWJQyL3U0eThaAwQqY52mnIBn45GZt3Sg=
X-Received: by 2002:a17:906:a855:b0:6cd:ba20:39c5 with SMTP id
 dx21-20020a170906a85500b006cdba2039c5mr2987842ejb.100.1645030259138; Wed, 16
 Feb 2022 08:50:59 -0800 (PST)
MIME-Version: 1.0
References: <cover-0.2-00000000000-20220216T105250Z-avarab@gmail.com> <patch-1.2-1c6c7f0f52f-20220216T105250Z-avarab@gmail.com>
In-Reply-To: <patch-1.2-1c6c7f0f52f-20220216T105250Z-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 16 Feb 2022 08:50:47 -0800
Message-ID: <CABPp-BHYR8a9YyPGGrUhjMbzPws286FeHjyNcOmgk=8XnwOiVg@mail.gmail.com>
Subject: Re: [PATCH 1/2] diff.[ch]: have diff_free() call clear_pathspec(opts.pathspec)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 16, 2022 at 7:34 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> Have the diff_free() function call clear_pathspec(). Since the
> diff_flush() function calls this all its callers can be simplified to
> rely on it instead.
>
> When I added the diff_free() function in e900d494dcf (diff: add an API
> for deferred freeing, 2021-02-11) I simply missed this, or wasn't
> interested in it. Let's consolidate this now. This means that any
> future callers (and I've got revision.c in mind) that embed a "struct
> diff_options" can simply call diff_free() instead of needing know that
> it has an embedded pathspec.
>
> This does fix a bunch of leaks, but I can't mark any test here as
> passing under the SANITIZE=3Dleak testing mode because in
> 886e1084d78 (builtin/: add UNLEAKs, 2017-10-01) an UNLEAK(rev) was
> added, which plasters over the memory
> leak. E.g. "t4011-diff-symlink.sh" would report fewer leaks with this
> fix, but because of the UNLEAK() reports none.
>
> I'll eventually loop around to removing that UNLEAK(rev) annotation as
> I'll fix deeper issues with the revisions API leaking. This is one
> small step on the way there, a new freeing function in revisions.c
> will want to call this diff_free().
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  add-interactive.c | 6 +++---
>  blame.c           | 3 ---
>  builtin/reset.c   | 1 -
>  diff.c            | 1 +
>  notes-merge.c     | 2 --
>  5 files changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/add-interactive.c b/add-interactive.c
> index 6498ae196f1..e1ab39cce30 100644
> --- a/add-interactive.c
> +++ b/add-interactive.c
> @@ -797,14 +797,14 @@ static int run_revert(struct add_i_state *s, const =
struct pathspec *ps,
>         diffopt.flags.override_submodule_config =3D 1;
>         diffopt.repo =3D s->r;
>
> -       if (do_diff_cache(&oid, &diffopt))
> +       if (do_diff_cache(&oid, &diffopt)) {
> +               diff_free(&diffopt);
>                 res =3D -1;
> -       else {
> +       } else {
>                 diffcore_std(&diffopt);
>                 diff_flush(&diffopt);
>         }
>         free(paths);
> -       clear_pathspec(&diffopt.pathspec);
>
>         if (!res && write_locked_index(s->r->index, &index_lock,
>                                        COMMIT_LOCK) < 0)
> diff --git a/blame.c b/blame.c
> index 206c295660f..401990726e7 100644
> --- a/blame.c
> +++ b/blame.c
> @@ -1403,7 +1403,6 @@ static struct blame_origin *find_origin(struct repo=
sitory *r,
>                 }
>         }
>         diff_flush(&diff_opts);
> -       clear_pathspec(&diff_opts.pathspec);
>         return porigin;
>  }
>
> @@ -1447,7 +1446,6 @@ static struct blame_origin *find_rename(struct repo=
sitory *r,
>                 }
>         }
>         diff_flush(&diff_opts);
> -       clear_pathspec(&diff_opts.pathspec);
>         return porigin;
>  }
>
> @@ -2328,7 +2326,6 @@ static void find_copy_in_parent(struct blame_scoreb=
oard *sb,
>         } while (unblamed);
>         target->suspects =3D reverse_blame(leftover, NULL);
>         diff_flush(&diff_opts);
> -       clear_pathspec(&diff_opts.pathspec);
>  }
>
>  /*
> diff --git a/builtin/reset.c b/builtin/reset.c
> index b97745ee94e..24968dd6282 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -274,7 +274,6 @@ static int read_from_tree(const struct pathspec *path=
spec,
>                 return 1;
>         diffcore_std(&opt);
>         diff_flush(&opt);
> -       clear_pathspec(&opt.pathspec);
>
>         return 0;
>  }
> diff --git a/diff.c b/diff.c
> index c862771a589..0aef3db6e10 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -6345,6 +6345,7 @@ void diff_free(struct diff_options *options)
>
>         diff_free_file(options);
>         diff_free_ignore_regex(options);
> +       clear_pathspec(&options->pathspec);
>  }
>
>  void diff_flush(struct diff_options *options)
> diff --git a/notes-merge.c b/notes-merge.c
> index b4a3a903e86..7ba40cfb080 100644
> --- a/notes-merge.c
> +++ b/notes-merge.c
> @@ -175,7 +175,6 @@ static struct notes_merge_pair *diff_tree_remote(stru=
ct notes_merge_options *o,
>                        oid_to_hex(&mp->remote));
>         }
>         diff_flush(&opt);
> -       clear_pathspec(&opt.pathspec);
>
>         *num_changes =3D len;
>         return changes;
> @@ -261,7 +260,6 @@ static void diff_tree_local(struct notes_merge_option=
s *o,
>                        oid_to_hex(&mp->local));
>         }
>         diff_flush(&opt);
> -       clear_pathspec(&opt.pathspec);
>  }
>
>  static void check_notes_merge_worktree(struct notes_merge_options *o)
> --
> 2.35.1.1028.g2d2d4be19de

I have occasionally found it surprising that we have places where
callers are responsible for free'ing a single piece of some struct
despite the fact that we have a function for free'ing memory
associated with that struct.  Thanks for getting rid of another one of
these.
