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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC182C433DB
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 18:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BDF36523A
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 18:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhCISRd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 13:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbhCISRU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 13:17:20 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093DAC06175F
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 10:17:20 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id o22so6217713oic.3
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 10:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MSmQQnPywuBTLFYyassV4Uc3lS6t94HRZFP5Msnqwq4=;
        b=Zc5E+c21akw5FXOSzKkLOqN8Wl9U62U6ZwkqrVck+c/qH05z3c1D+UJ2DvwhhlD8qp
         Vy49OTkiuF7TFp/qlnHDWbT6d77PLlhHjcSCrBZ+Ohel/e/cmaQtET5tT4sblgO2Yzx5
         rLW0UeYEnBusOmZVFr0VTy/gGe75/+Wb/IcniFad+zyoMhi7MYZe+qZm4btoPlquVDAh
         QUryUqXX4YqDQlitWyV+Ol1yXvRca6Yh0XS9B5qpWJBrlI31Xi91tF7YEl9tYuTlfSiP
         tfNxjNUjGHToQ+P1oLR7LaCzdWAnkbgfmslbEig+xWYG5Rg4upQy4cCkSjRx3rJ+jaBv
         eUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MSmQQnPywuBTLFYyassV4Uc3lS6t94HRZFP5Msnqwq4=;
        b=glcA2Afckp82RwlTDyVNV7pMyLpJcp2c5gZWPPNcbswtB5GA9GX6zggFAbI6ExsdqY
         qHE6Oeap1TyOo7Y1UtYBK2orvronQD43POZ9x7Z0lPMypaS+j37wKsOZb7AQBttLWqAP
         xR4JSbtV2C2TxEZJ9AuqZwE6g10kvCuuV2HDQqtflY58L77BllOvg842+gYE12lzG3Ne
         jQM73ldrGEldrysW/cFKiiZANS49nIgqD34x+Rq6P9cFL45f7Jfa0n90VuOcaoK7MmDx
         CtCNRbV2eYjZtwLQEAX4327zuH3IWdskL1lhdyFBT8SXkyUsNm8OdWW9PAHC2bqb1DMI
         9SDg==
X-Gm-Message-State: AOAM531ZXy82iap2me2Qbbe8c95YXHTdR/hOU5v4EZGayD/DBM5SAZl+
        JlHICrNbKgenO/OU6A/UKaBQznKBBf3LuZBgxGs=
X-Google-Smtp-Source: ABdhPJzRLEChL5+XfNRD7xwIyH3S/WHJgzDUqr4RcKvbj1/sRJ37aUbXlGVSFA273LkVcBUBC5CJv/WmePVe1w4Wlpo=
X-Received: by 2002:a05:6808:a8a:: with SMTP id q10mr3734839oij.167.1615313839313;
 Tue, 09 Mar 2021 10:17:19 -0800 (PST)
MIME-Version: 1.0
References: <20210308022138.28166-1-avarab@gmail.com> <20210308150650.18626-24-avarab@gmail.com>
In-Reply-To: <20210308150650.18626-24-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 9 Mar 2021 10:17:08 -0800
Message-ID: <CABPp-BF6pNbnVoYi3+iO=RRPskg1w6V=iJbKFiDYJxWM7ZFAwA@mail.gmail.com>
Subject: Re: [PATCH 23/30] tree-walk.h API: add a get_tree_entry_path() function
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
> Add a get_tree_entry_path() variant in addition to
> get_tree_entry_path_{mode,type,all}(). This is for those callers that
> need neither the mode nor "enum object_type" parameters filled for
> them.
>
> There's callers here which doesn't need the "struct object_id" filled
> either, and provides a throwaway variable for us.

I think I understood this sentence, but perhaps we could reword it?
Something like:

There are callers here which don't need the "struct object_id" filled;
forcing callers to pass one just requires they create a throwaway
variable.

>
> See the following commits for the introduction of such code that's
> being modified here:
>
>  - shift_tree(): 68faf68938e (A new merge stragety 'subtree'.,
>     2007-02-15) for the shift_tree()

What a lovely commit.  I especially appreciate this gem:

"Heuristics galore!  That's the git way ;-)."

>
>  - tree_has_path(): 96e7ffbdc31 (merge-recursive: check for directory
>    level conflicts, 2018-04-19)
>
>  - init_notes(): fd53c9eb445 (Speed up git notes lookup, 2009-10-09)
>
>  - diagnose_invalid_oid_path(): 009fee4774d (Detailed diagnosis when
>    parsing an object name fails., 2009-12-07)
>
> Those could potentially be refactored too, but I've got to stop at
> some point, and right now I'm focusing downstream code that depends on
> "mode" (or "enum object_type").
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  match-trees.c     |  4 +---
>  merge-recursive.c |  6 ++----
>  notes.c           |  3 +--
>  object-name.c     |  3 +--
>  tree-walk.c       | 11 +++++++++++
>  tree-walk.h       |  3 +++
>  6 files changed, 19 insertions(+), 11 deletions(-)
>
> diff --git a/match-trees.c b/match-trees.c
> index ce3f811ec04..60a17b92d70 100644
> --- a/match-trees.c
> +++ b/match-trees.c
> @@ -288,12 +288,10 @@ void shift_tree(struct repository *r,
>
>         if (add_score < del_score) {
>                 /* We need to pick a subtree of two */
> -               unsigned short mode;
> -
>                 if (!*del_prefix)
>                         return;
>
> -               if (get_tree_entry_mode(r, hash2, del_prefix, shifted, &m=
ode))
> +               if (get_tree_entry_path(r, hash2, del_prefix, shifted))
>                         die("cannot find path %s in tree %s",
>                             del_prefix, oid_to_hex(hash2));
>                 return;
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 0e891360e7e..b26d9d418f9 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1884,11 +1884,9 @@ static int tree_has_path(struct repository *r, str=
uct tree *tree,
>                          const char *path)
>  {
>         struct object_id hashy;
> -       unsigned short mode_o;
> -
> -       return !get_tree_entry_mode(r,
> +       return !get_tree_entry_path(r,
>                                     &tree->object.oid, path,
> -                                   &hashy, &mode_o);
> +                                   &hashy);

Poor Hashimoto has lost half his name and is now stuck with the
nickname of Hashy...  ;-)

(The mode was just a temporary and the name "mode_o" had no real
meaning; it was there just because I mis-remembered Quasimodo's name
at the time as Hashimodo and found "hashy mode_o" slightly amusing.)

>  }
>
>  /*
> diff --git a/notes.c b/notes.c
> index ef138606146..aa46cb2b09e 100644
> --- a/notes.c
> +++ b/notes.c
> @@ -994,7 +994,6 @@ void init_notes(struct notes_tree *t, const char *not=
es_ref,
>                 combine_notes_fn combine_notes, int flags)
>  {
>         struct object_id oid, object_oid;
> -       unsigned short mode;
>         struct leaf_node root_tree;
>
>         if (!t)
> @@ -1021,7 +1020,7 @@ void init_notes(struct notes_tree *t, const char *n=
otes_ref,
>                 return;
>         if (flags & NOTES_INIT_WRITABLE && read_ref(notes_ref, &object_oi=
d))
>                 die("Cannot use notes ref %s", notes_ref);
> -       if (get_tree_entry_mode(the_repository, &object_oid, "", &oid, &m=
ode))
> +       if (get_tree_entry_path(the_repository, &object_oid, "", &oid))
>                 die("Failed to read notes tree referenced by %s (%s)",
>                     notes_ref, oid_to_hex(&object_oid));
>
> diff --git a/object-name.c b/object-name.c
> index 7e3b2d6d739..9ff5f83c1ff 100644
> --- a/object-name.c
> +++ b/object-name.c
> @@ -1693,7 +1693,6 @@ static void diagnose_invalid_oid_path(struct reposi=
tory *r,
>                                       int object_name_len)
>  {
>         struct object_id oid;
> -       unsigned short mode;
>
>         if (!prefix)
>                 prefix =3D "";
> @@ -1704,7 +1703,7 @@ static void diagnose_invalid_oid_path(struct reposi=
tory *r,
>         if (is_missing_file_error(errno)) {
>                 char *fullname =3D xstrfmt("%s%s", prefix, filename);
>
> -               if (!get_tree_entry_mode(r, tree_oid, fullname, &oid, &mo=
de)) {
> +               if (!get_tree_entry_path(r, tree_oid, fullname, &oid)) {
>                         die(_("path '%s' exists, but not '%s'\n"
>                             "hint: Did you mean '%.*s:%s' aka '%.*s:./%s'=
?"),
>                             fullname,
> diff --git a/tree-walk.c b/tree-walk.c
> index 0ad3d80593e..83737634770 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -632,6 +632,17 @@ int get_tree_entry_all(struct repository *r,
>         return retval;
>  }
>
> +int get_tree_entry_path(struct repository *r,
> +                       const struct object_id *tree_oid,
> +                       const char *name,
> +                       struct object_id *oid)
> +{
> +       unsigned short mode;
> +       enum object_type object_type;
> +       return get_tree_entry_all(r, tree_oid, name, oid,
> +                                 &mode, &object_type);
> +}
> +
>  int get_tree_entry_mode(struct repository *r,
>                         const struct object_id *tree_oid,
>                         const char *name,
> diff --git a/tree-walk.h b/tree-walk.h
> index 5db38fcb575..1bfa839b275 100644
> --- a/tree-walk.h
> +++ b/tree-walk.h
> @@ -175,10 +175,13 @@ struct traverse_info {
>   * "struct name_entry" you'd like. You always need to pointer to an
>   * appropriate variable to fill in (NULL won't do!):
>   *
> + * get_tree_entry_path(): <no extra argument, just get the common 'path'=
>
>   * get_tree_entry_mode(): unsigned int mode
>   * get_tree_entry_type(): enum object_type
>   * get_tree_entry_all(): unsigned int mode, enum object_type
>   */
> +int get_tree_entry_path(struct repository *, const struct object_id *, c=
onst char *,
> +                       struct object_id *);
>  int get_tree_entry_mode(struct repository *, const struct object_id *, c=
onst char *,
>                         struct object_id *,
>                         unsigned short *);
> --
> 2.31.0.rc0.126.g04f22c5b82
