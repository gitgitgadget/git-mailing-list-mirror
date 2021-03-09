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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C40CC433DB
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 17:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE8C865228
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 17:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbhCIR43 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 12:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbhCIR4L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 12:56:11 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1258C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 09:56:11 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id f8so8632511otp.8
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 09:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F7t9JdfkN/FicPA4M+kO+U4A2EVyZevC7hTKZMX3TkU=;
        b=H9stsEycv3NKVmaXa54krW5+wWYUX8mJJXiQH2F0HDX0bFcLiGZLMUIRpxKtK62/YJ
         4WVN701waGtheDO0USFPEvtc0OR1fJaK1UHieZSY7k6X02cqmhaHiaFca8VfZrUoDp/P
         9O+195KjaYkRJ9gY9JGHlHX57+lqwZsTOnpY0jvUNf0vATwwJTq+LSq7tFwMcqCxwazg
         KsqmOdW37rBYzhQg3eSR8uh4oPJrBg0erZ58n6onANVFe6yGxSgiN7b0LZSaAtIxDz+N
         tKsVJU+ZMwAu+Gec+4iqu+vRpgQCwVcsuldF0JJLPCQNqdcBRU4sW+Vi+Y/AmnpHYbwW
         SJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F7t9JdfkN/FicPA4M+kO+U4A2EVyZevC7hTKZMX3TkU=;
        b=FlR6D0a3AiMtxLyrQqw+pBYuy1CjLn0ZtMEpJSj9x6Gl56O8A/bCfXRyMELegmgIef
         wF5p31cElBMxQ2y8ICrodPUUZ7hcDJkmc7MrYW4LgJBHhF6N0dwMR4DDkbsXfInG3q2Z
         2BZI9X//Um/uCKUsPG8i8kiLbVJZEx6Lw90gUKbczu41QvlUyw5Fq3uSLxL172pQQz0h
         nFyN/DIjgF5sQWp8ej8MEHykxnmpizIlGXadTzIH/6yVTX7ikxYIu0Rrg1M/fJ84gLRD
         O9/QQVCvfqH95jKjP37XOknOegtAp4ZwYHd5l14GQEO/bzyQcRIOgAmegHk+AMrUh2dH
         bV9Q==
X-Gm-Message-State: AOAM533RCt4ueTo8boGTHY7nicyu3DNl71XVPlP5A3JbSimyXU1wDkc1
        GsMDXeNihl0WUNOo2FzqN3wf9DYyV+FunPybLAASitzar5o=
X-Google-Smtp-Source: ABdhPJwZhq4EH/IFfrzktv59xum5Tm91BDZmX6+WHPyIb5sSFDC726B4XQ21oKGS5XgnoHIRJyt4Tw1RvQz6yAbFzNI=
X-Received: by 2002:a9d:8d5:: with SMTP id 79mr24804156otf.345.1615312571048;
 Tue, 09 Mar 2021 09:56:11 -0800 (PST)
MIME-Version: 1.0
References: <20210308022138.28166-1-avarab@gmail.com> <20210308150650.18626-23-avarab@gmail.com>
In-Reply-To: <20210308150650.18626-23-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 9 Mar 2021 09:56:00 -0800
Message-ID: <CABPp-BExOo7b3OEMrCmCjAzrxf2iaSP-s75Ay6ZheTjmA5bWxQ@mail.gmail.com>
Subject: Re: [PATCH 22/30] tree-walk.h API: Add get_tree_entry_type()
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
> Add a get_tree_entry_type() helper function to compliment the existing
> get_tree_entry(). Move those users of get_tree_entry_type() who didn't
> care about the mode specifically, but just want to know whether the
> tree entry is one of OBJ_{BLOB,COMMIT,TREE} over to it.

You added not one but two new functions (get_tree_entry_all() is the
other); should probably call out both in the commit message.

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  archive.c     |  8 ++++----
>  blame.c       |  8 ++++----
>  match-trees.c | 10 +++++-----
>  tree-walk.c   | 47 ++++++++++++++++++++++++++++++++++++-----------
>  tree-walk.h   | 15 +++++++++++++--
>  5 files changed, 62 insertions(+), 26 deletions(-)
>
> diff --git a/archive.c b/archive.c
> index 95fa759e1fb..bc8f1c7546f 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -479,14 +479,14 @@ static void parse_treeish_arg(const char **argv,
>
>         if (prefix) {
>                 struct object_id tree_oid;
> -               unsigned short mode;
> +               enum object_type object_type;
>                 int err;
>
> -               err =3D get_tree_entry_mode(ar_args->repo,
> +               err =3D get_tree_entry_type(ar_args->repo,
>                                           &tree->object.oid,
>                                           prefix, &tree_oid,
> -                                         &mode);
> -               if (err || !S_ISDIR(mode))
> +                                         &object_type);
> +               if (err || object_type !=3D OBJ_TREE)
>                         die(_("current working directory is untracked"));
>
>                 tree =3D parse_tree_indirect(&tree_oid);
> diff --git a/blame.c b/blame.c
> index 9e0543e13d4..4944582dc3c 100644
> --- a/blame.c
> +++ b/blame.c
> @@ -101,11 +101,11 @@ static void verify_working_tree_path(struct reposit=
ory *r,
>         for (parents =3D work_tree->parents; parents; parents =3D parents=
->next) {
>                 const struct object_id *commit_oid =3D &parents->item->ob=
ject.oid;
>                 struct object_id blob_oid;
> -               unsigned short mode;
> -               int ret =3D get_tree_entry_mode(r, commit_oid, path, &blo=
b_oid,
> -                                             &mode);
> +               enum object_type object_type;
> +               int ret =3D get_tree_entry_type(r, commit_oid, path, &blo=
b_oid,
> +                                             &object_type);
>
> -               if (!ret && oid_object_info(r, &blob_oid, NULL) =3D=3D OB=
J_BLOB)
> +               if (!ret && object_type =3D=3D OBJ_BLOB)

Testing my understanding -- does this mean that even before your patch
that the oid_object_info() call wasn't needed?  In particular, we
could have replaced it with something like (!S_ISGITLNK(mode) &&
(S_ISREG(mode) || S_ISLNK(mode)))?

>                         return;
>         }
>
> diff --git a/match-trees.c b/match-trees.c
> index 4f02768c01e..ce3f811ec04 100644
> --- a/match-trees.c
> +++ b/match-trees.c
> @@ -317,17 +317,17 @@ void shift_tree_by(struct repository *r,
>                    const char *shift_prefix)
>  {
>         struct object_id sub1, sub2;
> -       unsigned short tmp;
> +       enum object_type tmp;
>         unsigned candidate =3D 0;
>
>         /* Can hash2 be a tree at shift_prefix in tree hash1? */
> -       if (!get_tree_entry_mode(r, hash1, shift_prefix, &sub1, &tmp) &&
> -           S_ISDIR(tmp))
> +       if (!get_tree_entry_type(r, hash1, shift_prefix, &sub1, &tmp) &&
> +           tmp =3D=3D OBJ_TREE)
>                 candidate |=3D 1;
>
>         /* Can hash1 be a tree at shift_prefix in tree hash2? */
> -       if (!get_tree_entry_mode(r, hash2, shift_prefix, &sub2, &tmp) &&
> -           S_ISDIR(tmp))
> +       if (!get_tree_entry_type(r, hash2, shift_prefix, &sub2, &tmp) &&
> +           tmp =3D=3D OBJ_TREE)
>                 candidate |=3D 2;
>
>         if (candidate =3D=3D 3) {
> diff --git a/tree-walk.c b/tree-walk.c
> index 7819ff3e0ec..0ad3d80593e 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -561,7 +561,8 @@ struct dir_state {
>
>  static int find_tree_entry(struct repository *r, struct tree_desc *t,
>                            const char *name, struct object_id *result,
> -                          unsigned short *mode)
> +                          unsigned short *mode,
> +                          enum object_type *object_type)
>  {
>         int namelen =3D strlen(name);
>         while (t->size) {
> @@ -585,23 +586,24 @@ static int find_tree_entry(struct repository *r, st=
ruct tree_desc *t,
>                 }
>                 if (name[entrylen] !=3D '/')
>                         continue;
> -               if (!S_ISDIR(*mode))
> +               if (*object_type !=3D OBJ_TREE)
>                         break;
>                 if (++entrylen =3D=3D namelen) {
>                         oidcpy(result, &oid);
>                         return 0;
>                 }
> -               return get_tree_entry_mode(r, &oid, name + entrylen, resu=
lt,
> -                                          mode);
> +               return get_tree_entry_all(r, &oid, name + entrylen, resul=
t,
> +                                         mode, object_type);
>         }
>         return -1;
>  }
>
> -int get_tree_entry_mode(struct repository *r,
> -                       const struct object_id *tree_oid,
> -                       const char *name,
> -                       struct object_id *oid,
> -                       unsigned short *mode)
> +int get_tree_entry_all(struct repository *r,
> +                      const struct object_id *tree_oid,
> +                      const char *name,
> +                      struct object_id *oid,
> +                      unsigned short *mode,
> +                      enum object_type *object_type)
>  {
>         int retval;
>         void *tree;
> @@ -624,12 +626,34 @@ int get_tree_entry_mode(struct repository *r,
>                 struct tree_desc t;
>                 init_tree_desc(&t, tree, size);
>                 retval =3D find_tree_entry(r, &t, name, oid,
> -                                        mode);
> +                                        mode, object_type);
>         }
>         free(tree);
>         return retval;
>  }
>
> +int get_tree_entry_mode(struct repository *r,
> +                       const struct object_id *tree_oid,
> +                       const char *name,
> +                       struct object_id *oid,
> +                       unsigned short *mode)
> +{
> +       enum object_type object_type;
> +       return get_tree_entry_all(r, tree_oid, name, oid,
> +                                 mode, &object_type);
> +}
> +
> +int get_tree_entry_type(struct repository *r,
> +                       const struct object_id *tree_oid,
> +                       const char *name,
> +                       struct object_id *oid,
> +                       enum object_type *object_type)
> +{
> +       unsigned short mode;
> +       return get_tree_entry_all(r, tree_oid, name, oid,
> +                                 &mode, object_type);
> +}
> +
>  /*
>   * This is Linux's built-in max for the number of symlinks to follow.
>   * That limit, of course, does not affect git, but it's a reasonable
> @@ -674,6 +698,7 @@ enum get_oid_result get_tree_entry_follow_symlinks(st=
ruct repository *r,
>                 int find_result;
>                 char *first_slash;
>                 char *remainder =3D NULL;
> +               enum object_type object_type;
>
>                 if (!t.buffer) {
>                         void *tree;
> @@ -751,7 +776,7 @@ enum get_oid_result get_tree_entry_follow_symlinks(st=
ruct repository *r,
>                 /* Look up the first (or only) path component in the tree=
. */
>                 find_result =3D find_tree_entry(r, &t, namebuf.buf,
>                                               &current_tree_oid,
> -                                             mode);
> +                                             mode, &object_type);
>                 if (find_result) {
>                         goto done;
>                 }
> diff --git a/tree-walk.h b/tree-walk.h
> index eb9b9de6ccc..5db38fcb575 100644
> --- a/tree-walk.h
> +++ b/tree-walk.h
> @@ -171,12 +171,23 @@ struct traverse_info {
>   * Find an entry in a tree given a pathname and the sha1 of a tree to
>   * search. Returns 0 if the entry is found and -1 otherwise.
>   *
> - * The third and fourth parameters are set to the entry's sha1 and
> - * mode respectively.
> + * There are variants of this function depending on what fields in the
> + * "struct name_entry" you'd like. You always need to pointer to an

s/to pointer to an/a pointer to an/ ?

> + * appropriate variable to fill in (NULL won't do!):
> + *
> + * get_tree_entry_mode(): unsigned int mode
> + * get_tree_entry_type(): enum object_type
> + * get_tree_entry_all(): unsigned int mode, enum object_type
>   */
>  int get_tree_entry_mode(struct repository *, const struct object_id *, c=
onst char *,
>                         struct object_id *,
>                         unsigned short *);
> +int get_tree_entry_type(struct repository *, const struct object_id *, c=
onst char *,
> +                       struct object_id *,
> +                       enum object_type *);
> +int get_tree_entry_all(struct repository *, const struct object_id *, co=
nst char *,
> +                      struct object_id *,
> +                      unsigned short *, enum object_type *);
>
>  /**
>   * Generate the full pathname of a tree entry based from the root of the
> --
> 2.31.0.rc0.126.g04f22c5b82
>
