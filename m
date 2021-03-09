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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77443C433DB
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 18:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 445A365062
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 18:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhCISbA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 13:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbhCISak (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 13:30:40 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58AFC06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 10:30:40 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id 75so10524906otn.4
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 10:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8Qkv6vYCrc0mYmJfEAHQdfwAvi2OLOnye3J+ga+VN8I=;
        b=NcMVlTe7jBA1iTPv3RfT1sppwrZrVbZIIQCDDBeGjYujFnegVz4Pp3TbwhCJiuunPJ
         Q3e80tUJC2AapUsaX8TisRi1XOaZl2M+AlcCZCeSGFYjPVZo/20Xm5sytUl6sypowxDu
         xmYMpEO72svC5BimbN/T2GHLyuT+CghSDvXwSsHFVIgoK+DwHmdGDZR3r6PUOQ9VakMD
         l7MAz7oMsu+lK5tbsNFOl3C0lBuN2EO7e5kWwi1l5lERKcN7rbdI1M/S/8Uwrmvzz9Q1
         GH9QZ+eDdy+LI/mq8DfFEOrKiYGU3hdZpX3T2vMOEG+YilWXMNJINhOMbjcdn0EmAeGM
         s9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8Qkv6vYCrc0mYmJfEAHQdfwAvi2OLOnye3J+ga+VN8I=;
        b=XclUxHQlH4UY7klGsQxlOUsTQPrDwl4sPi+Vgl+5j27wAjaobn7aYDDMy38PTFw5/z
         VxrIqEKqdHat/0A1apH9O/jgKYPka8k62oJyza+ERNoqC8RkjyFyEsd5K+ZULri/Wjl2
         a+43Qyo5AlR7ORb29G/IRhcR7os9/5msKsfnan8pUQhBRSnlKC/hHXw2GC3iJ9oXfNZg
         U8hDT11ZDQQMe6M1Cm0dII98CkSgr84sC4Djf5en10ienD6XL+7dA0Xr5XsYoliP9eJU
         6yj69fN2jvEZHQbWZMGo4aGm4LTrwYvxnxeaeeEKjBmzrZ1ECqHaakETryNQEEI9SKRO
         ktVQ==
X-Gm-Message-State: AOAM530FNG+MzQxZyqww4S/Js9XK2DC1HLlRQh27OEGk7Nz+0DbLVBI7
        G1vQ1MABsl5PdaRcKbNTdiYWnorA38XZSNeL39mdr3zgdIA=
X-Google-Smtp-Source: ABdhPJzrAqN/q+ujUVASBnscQ+XeXy9FJhqP04SqNF7Ssa2R4WDl98fLJ7Jifh3E/uu2SYgJDILQuCLhejx8Vb30E5Y=
X-Received: by 2002:a9d:8ae:: with SMTP id 43mr6217525otf.162.1615314640095;
 Tue, 09 Mar 2021 10:30:40 -0800 (PST)
MIME-Version: 1.0
References: <20210308022138.28166-1-avarab@gmail.com> <20210308150650.18626-27-avarab@gmail.com>
In-Reply-To: <20210308150650.18626-27-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 9 Mar 2021 10:30:29 -0800
Message-ID: <CABPp-BFDzfy-NOkLFJq-8h7L81jEYo7hava_2wUr2L-h1q4YKQ@mail.gmail.com>
Subject: Re: [PATCH 26/30] tree-walk.h API: add a tree_entry_extract_all() function
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
> Add a tree_entry_extract_all() sibling function to the existing
> tree_entry_extract_mode().
>
> Having the OBJ_{BLOB,TREE,COMMIT} when you have the "mode" is strictly
> speaking redundant, but hopefully makes it easier to read the
> code. We'll now see which parts of the code are checking the types,
> v.s. those that care about the mode specifically.
>
> Only the first use of tree_entry_extract_mode() in emit_path() is
> converted here, the other branch will use a new
> get_tree_entry_mode_type() introduced in a subsequent commit.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/update-index.c |  6 ++++--
>  tree-diff.c            |  5 +++--
>  tree-walk.c            |  3 ++-
>  tree-walk.h            | 12 ++++++++++++
>  4 files changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index 070510d6a88..b489a876392 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -599,16 +599,18 @@ static struct cache_entry *read_one_ent(const char =
*which,
>                                         struct object_id *ent, const char=
 *path,
>                                         int namelen, int stage)
>  {
> +       enum object_type object_type;
>         unsigned short mode;
>         struct object_id oid;
>         struct cache_entry *ce;
>
> -       if (get_tree_entry_mode(the_repository, ent, path, &oid, &mode)) =
{
> +       if (get_tree_entry_all(the_repository, ent, path, &oid,
> +                              &mode, &object_type)) {
>                 if (which)
>                         error("%s: not in %s branch.", path, which);
>                 return NULL;
>         }
> -       if (mode =3D=3D S_IFDIR) {
> +       if (object_type =3D=3D OBJ_TREE) {
>                 if (which)
>                         error("%s: not a blob in %s branch.", path, which=
);
>                 return NULL;
> diff --git a/tree-diff.c b/tree-diff.c
> index b37348b7908..b25095c1164 100644
> --- a/tree-diff.c
> +++ b/tree-diff.c
> @@ -195,10 +195,11 @@ static struct combine_diff_path *emit_path(struct c=
ombine_diff_path *p,
>         assert(t || tp);
>
>         if (t) {
> +               enum object_type object_type;
>                 /* path present in resulting tree */
> -               oid =3D tree_entry_extract_mode(t, &path, &mode);
> +               oid =3D tree_entry_extract_all(t, &path, &mode, &object_t=
ype);
>                 pathlen =3D tree_entry_len(&t->entry);
> -               isdir =3D S_ISDIR(mode);
> +               isdir =3D object_type =3D=3D OBJ_TREE;

Not worth a reroll, but parenthesis around the right-hand side would
make it a bit faster to parse and understand.

>         } else {
>                 /*
>                  * a path was removed - take path from imin parent. Also =
take
> diff --git a/tree-walk.c b/tree-walk.c
> index e613f273767..12e0ed4e250 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -570,7 +570,8 @@ static int find_tree_entry(struct repository *r, stru=
ct tree_desc *t,
>                 struct object_id oid;
>                 int entrylen, cmp;
>
> -               oidcpy(&oid, tree_entry_extract_mode(t, &entry, mode));
> +               oidcpy(&oid, tree_entry_extract_all(t, &entry, mode, obje=
ct_type));
> +
>                 entrylen =3D tree_entry_len(&t->entry);
>                 update_tree_entry(t);
>                 if (entrylen > namelen)
> diff --git a/tree-walk.h b/tree-walk.h
> index 892e77eda23..06ad40ab2f1 100644
> --- a/tree-walk.h
> +++ b/tree-walk.h
> @@ -47,6 +47,7 @@ struct tree_desc {
>   * appropriate variable to fill in (NULL won't do!):
>   *
>   * tree_entry_extract_mode(): const char *path, unsigned int mode
> + * tree_entry_extract_all(): const char *path, unsigned int mode, enum o=
bject_type
>   */
>  static inline const struct object_id *tree_entry_extract_mode(struct tre=
e_desc *desc,
>                                                               const char =
**pathp,
> @@ -57,6 +58,17 @@ static inline const struct object_id *tree_entry_extra=
ct_mode(struct tree_desc *
>         return &desc->entry.oid;
>  }
>
> +static inline const struct object_id *tree_entry_extract_all(struct tree=
_desc *desc,
> +                                                            const char *=
*pathp,
> +                                                            unsigned sho=
rt *modep,
> +                                                            enum object_=
type *object_typep)
> +{
> +       *pathp =3D desc->entry.path;
> +       *modep =3D desc->entry.mode;
> +       *object_typep =3D desc->entry.object_type;
> +       return &desc->entry.oid;
> +}
> +
>  /**
>   * Calculate the length of a tree entry's pathname. This utilizes the
>   * memory structure of a tree entry to avoid the overhead of using a
> --
> 2.31.0.rc0.126.g04f22c5b82
>
