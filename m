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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242BAC433DB
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 17:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E60C365237
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 17:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhCIRL4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 12:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbhCIRLu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 12:11:50 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A72BC06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 09:11:50 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id m6so9916951pfk.1
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 09:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CJydoA9TEkJkIrsAAZaSRdFE0s9WLcfDJ2sG/qaX7uQ=;
        b=cMuqNztdA9d6U8oIAMxPoP+SZEDuNLTn8kCbo0sOA4aOayz8FCHtV1+pPGqyg1Om61
         N/Zbr3hQqx5GzhvFdbyhkj8/1TwpwjGao8amwSIk3uiMGYfhGgTuSqj1uHMd0dWqIj/0
         I4NMVaKM72Vd2h4TEDq7WhDvTyPwLrMonuUM+Nmj5+qAqmq50AwoIdLsHFz0NsHbTYdL
         /7YL4C2BGdeCzMCGo0IE0QEiNdNqiVU+QYiMk9REcFn1a08pvBqPwFqJ8hCnbVOv0DlV
         Exim1ahCYvD9RcFjVpapFP769v7BmG46ISl1nq3FIlUKXwhLzMPA6PcRAFCvX6PiiGGu
         OyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CJydoA9TEkJkIrsAAZaSRdFE0s9WLcfDJ2sG/qaX7uQ=;
        b=HYKQEJAB7ev/aZAedtwaGsfPBu8Kyr5XUxx/Wb6LAz6ckmOgQCxQmgQ8xMITP14fdp
         DxDaONFYPFapaTMu/phO+gSHeASJEfOwL0sNF14NNbLwWVqjFCJEser4Cg3Gv39XZes6
         NemOwyYl2KVBtLZgAWq19aKoewBm1oTG80av3d6RdVCRNLE/D66qIMCuJfrU9XY0iLRN
         yMREc7WlNWbPtNWVemO0Efy1XcVecBmj0xJFugN9wlksXepW2rfC63atat32n2wgmtQ0
         BisEms5Q4AhdU2Shp/dJxjtWPhUBampdoGIRjZiXrmHofpJm0s8RRX4XEKbSyZBfOzk9
         curQ==
X-Gm-Message-State: AOAM5327/1KbVkzhLD8EfVIDvfvHK2RuK74dlqvWKxSeK4XRTIqVryUX
        qsHWrETohLrW+UHBVXmi7NytWkT4EN4KDeF5Up8=
X-Google-Smtp-Source: ABdhPJwBhfIRMmu7PEjA6e6g1Gu0Z7NGinJzIqEkdGl5HCgiZnC3fgJDsqZdj1DA4tBKAuXjHSnfDbQs+oA9V98ehp4=
X-Received: by 2002:aa7:8001:0:b029:1ee:6e01:f54 with SMTP id
 j1-20020aa780010000b02901ee6e010f54mr26496026pfi.48.1615309909897; Tue, 09
 Mar 2021 09:11:49 -0800 (PST)
MIME-Version: 1.0
References: <20210308022138.28166-1-avarab@gmail.com> <20210308150650.18626-14-avarab@gmail.com>
In-Reply-To: <20210308150650.18626-14-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 9 Mar 2021 09:11:39 -0800
Message-ID: <CABPp-BEC+Hi+EXF_QK0-o9oqmMnVu3_mX-GN0m24vY_NgLSnVw@mail.gmail.com>
Subject: Re: [PATCH 13/30] tree-walk.h users: refactor chained "mode" if/else
 into switch
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
> Refactor a couple of "switch" statements that previously relied on
> "entry.mode" to switch on "entry.object_type" instead.
>
> This is more obvious, and allows us to explicitly handle all the OBJ_*
> cases, not just have a wildcard "else". That doesn't matter for the
> behavior of this code, but for its readability and maintainability.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  list-objects.c | 20 ++++++++++++++------
>  walker.c       | 22 +++++++++++++---------
>  2 files changed, 27 insertions(+), 15 deletions(-)
>
> diff --git a/list-objects.c b/list-objects.c
> index e19589baa04..37434ba89d3 100644
> --- a/list-objects.c
> +++ b/list-objects.c
> @@ -111,6 +111,9 @@ static void process_tree_contents(struct traversal_co=
ntext *ctx,
>         init_tree_desc(&desc, tree->buffer, tree->size);
>
>         while (tree_entry(&desc, &entry)) {
> +               struct tree *t;
> +               struct blob *b;
> +
>                 if (match !=3D all_entries_interesting) {
>                         match =3D tree_entry_interesting(ctx->revs->repo-=
>index,
>                                                        &entry, base, 0,
> @@ -121,8 +124,9 @@ static void process_tree_contents(struct traversal_co=
ntext *ctx,
>                                 continue;
>                 }
>
> -               if (S_ISDIR(entry.mode)) {
> -                       struct tree *t =3D lookup_tree(ctx->revs->repo, &=
entry.oid);
> +               switch (entry.object_type) {
> +               case OBJ_TREE:
> +                       t =3D lookup_tree(ctx->revs->repo, &entry.oid);
>                         if (!t) {
>                                 die(_("entry '%s' in tree %s has tree mod=
e, "
>                                       "but is not a tree"),
> @@ -130,12 +134,13 @@ static void process_tree_contents(struct traversal_=
context *ctx,
>                         }
>                         t->object.flags |=3D NOT_USER_GIVEN;
>                         process_tree(ctx, t, base, entry.path);
> -               }
> -               else if (S_ISGITLINK(entry.mode))
> +                       break;
> +               case OBJ_COMMIT:
>                         process_gitlink(ctx, entry.oid.hash,
>                                         base, entry.path);
> -               else {
> -                       struct blob *b =3D lookup_blob(ctx->revs->repo, &=
entry.oid);
> +                       break;
> +               case OBJ_BLOB:
> +                       b =3D lookup_blob(ctx->revs->repo, &entry.oid);
>                         if (!b) {
>                                 die(_("entry '%s' in tree %s has blob mod=
e, "
>                                       "but is not a blob"),
> @@ -143,6 +148,9 @@ static void process_tree_contents(struct traversal_co=
ntext *ctx,
>                         }
>                         b->object.flags |=3D NOT_USER_GIVEN;
>                         process_blob(ctx, b, base, entry.path);
> +                       break;
> +               default:
> +                       BUG("unreachable");
>                 }
>         }
>  }
> diff --git a/walker.c b/walker.c
> index 4984bf8b3d6..7ba757244e6 100644
> --- a/walker.c
> +++ b/walker.c
> @@ -45,21 +45,25 @@ static int process_tree(struct walker *walker, struct=
 tree *tree)
>         init_tree_desc(&desc, tree->buffer, tree->size);
>         while (tree_entry(&desc, &entry)) {
>                 struct object *obj =3D NULL;
> +               struct tree *tree;
> +               struct blob *blob;
>
> -               /* submodule commits are not stored in the superproject *=
/
> -               if (S_ISGITLINK(entry.mode))
> +               switch (entry.object_type) {
> +               case OBJ_COMMIT:
> +                       /* submodule commits are not stored in the superp=
roject */
>                         continue;
> -               if (S_ISDIR(entry.mode)) {
> -                       struct tree *tree =3D lookup_tree(the_repository,
> -                                                       &entry.oid);
> +               case OBJ_TREE:
> +                       tree =3D lookup_tree(the_repository, &entry.oid);
>                         if (tree)
>                                 obj =3D &tree->object;
> -               }
> -               else {
> -                       struct blob *blob =3D lookup_blob(the_repository,
> -                                                       &entry.oid);
> +                       break;
> +               case OBJ_BLOB:
> +                       blob =3D lookup_blob(the_repository, &entry.oid);
>                         if (blob)
>                                 obj =3D &blob->object;
> +                       break;
> +               default:
> +                       BUG("unreachable");
>                 }
>                 if (!obj || process(walker, obj))
>                         return -1;
> --
> 2.31.0.rc0.126.g04f22c5b82

This does make it nicer.  :-)
