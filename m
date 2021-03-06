Return-Path: <SRS0=58cf=IE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58180C433DB
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 21:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21E8564FC1
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 21:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbhCFVhS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 16:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbhCFVhP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 16:37:15 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE04C06175F
        for <git@vger.kernel.org>; Sat,  6 Mar 2021 13:37:15 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id h10so5508468otm.1
        for <git@vger.kernel.org>; Sat, 06 Mar 2021 13:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6jnMgxMDhuNObaqRqHDg5yzssy3tPaB6a6/ljQlpX50=;
        b=UBcX/tyOOiIh4iyevCM5AO34CDici1KOKN7uBDh1upMPEPV2v3rer3h6VOTlnOnxga
         QP8v7EgAko4GP+lqeekOU3em/HENLeVloB9chY3tmQPZ+5MejZF+6xPY7N4Szz+FlWDZ
         hooYY+WEO1DAAMzEJ7GgJ9UoicI+PNcOOGZvk2K5NqqyaLeZ7pIyMnWe+9oEpFZKGiiX
         nwDoeybs8sIpP2nZ7OurVk9ZUL7TEzZ4tohuLdU11TlqZc56jp8JacD24nuF8HOg4zN4
         PFp9WUEsEMePbItSyGIoIuwOh4hlzx5L5KYjx+PHP9HWkT66TePulJdNX9y91os4dzr5
         x6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6jnMgxMDhuNObaqRqHDg5yzssy3tPaB6a6/ljQlpX50=;
        b=oGeRzl9NSWl8X0QFoOKdMLzGK5S656aAcejcT5qsa6fbi+lU2djzPPVrD9qx1YBQnc
         V/AP5kT07KUntzvP1bzEa5KPHqBrnG097RpbQs0WS6xLGH3cswIwb9/Xm8YKhyTD8cJO
         s7fcdSagHUJK7jlpYJ5YKD5QUq7wITGmeSU3XwtF/P2VWhrh/dHvzAWAr8NVP4bIAtRT
         zpyP/IlGWUJ1KRrcPDUn99JDn6P0D/s0D9dt/abJolNaObqJHXUPqr+cAtDp8uXccz06
         ZtF4pZHFZG8TAm2cxZeU2q8W+ah0Q8sK5LGLprUlqJ/7+fq8cc/AG/14JfBweI1DO1zb
         AlHQ==
X-Gm-Message-State: AOAM5302+bL3H4WAEB+ydPrV1U/3USY5SzLEi0cujm1DJTAB6SDeMNQ8
        X5dGKCXKzbCnFQ6GAiqsmpvEJ8OWQRngt57xRJY=
X-Google-Smtp-Source: ABdhPJxiDk5lvAfiqC0Tm573kfkXt0aO6DwBHrrsbO2eYgdvby4K4VmLZWfIIQ6ZcXmNS++Kiigtq+2wjLPi1nX18zk=
X-Received: by 2002:a9d:8d5:: with SMTP id 79mr13588153otf.345.1615066634484;
 Sat, 06 Mar 2021 13:37:14 -0800 (PST)
MIME-Version: 1.0
References: <1240014568-3675-1-git-send-email-pclouds@gmail.com> <20210306193458.20633-4-avarab@gmail.com>
In-Reply-To: <20210306193458.20633-4-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 6 Mar 2021 13:37:03 -0800
Message-ID: <CABPp-BF982muRS4GO=zYegvetQyrPMwaEM3uEBvcbPRP=krfmQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] ls-files: remove cache juggling + sorting
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 6, 2021 at 11:35 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> Remove the "ce_stage(ce) =3D=3D 1" and "Sort the cache entry" code from
> read_tree(), which allows us to remove the function entirely and move
> over to read_tree_recursive().

Removing ce_stage(ce) =3D=3D 1 and the use of read_one_entry() as the
read_tree_fn_t, keeping read_one_entry_quick() as read_tree_fn_t in
all cases.

This basically means you are assuming there are no entries with
ce_stage(ce) =3D=3D 1 to start with; what if the user calls `ls-files
--with-tree` when in the middle of a merge conflict?  Will those
entries be duplicated and/or overwritten?

> I don't think the "Sort the cached entry" code was needed here, see
> af3785dc5a7 (Optimize "diff --cached" performance., 2007-08-09) for
> the use-case it was intended for. The only user of this code is
> "ls-files --with-tree", which isn't the sort of use-case that needs to
> care about "ce_stage(ce) !=3D 0" or sorting tree entries.

Could you spell this out more?  I don't understand.  The initial index
might be something like (using the syntax of filename, stage):
    file   0
    random   0
    some   0
and after read_tree_recursive() reading into stage 1, wouldn't it be
something like
    file   0
    random   0
    some   0
    file   1
    some   1
    strange   1
when the ordering should be
    file   0
    file   1
    random   0
    some   0
    some   1
    strange   1
?

I'm probably missing something here.

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/ls-files.c | 76 +++++++---------------------------------------
>  1 file changed, 11 insertions(+), 65 deletions(-)
>
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index 74d572a3e4a..f5239437809 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -12,7 +12,6 @@
>  #include "dir.h"
>  #include "builtin.h"
>  #include "tree.h"
> -#include "cache-tree.h"
>  #include "parse-options.h"
>  #include "resolve-undo.h"
>  #include "string-list.h"
> @@ -421,12 +420,15 @@ static int get_common_prefix_len(const char *common=
_prefix)
>         return common_prefix_len;
>  }
>
> -static int read_one_entry_opt(struct index_state *istate,
> -                             const struct object_id *oid,
> -                             const char *base, int baselen,
> -                             const char *pathname,
> -                             unsigned mode, int stage, int opt)
> +static int read_one_entry_quick(const struct object_id *oid,
> +                               struct strbuf *basebuf,
> +                               const char *pathname,
> +                               unsigned mode,
> +                               int stage, void *context)
>  {
> +       struct index_state *istate =3D context;
> +       const char *base =3D basebuf->buf;
> +       const int baselen =3D basebuf->len;
>         int len;
>         struct cache_entry *ce;
>
> @@ -442,64 +444,7 @@ static int read_one_entry_opt(struct index_state *is=
tate,
>         memcpy(ce->name, base, baselen);
>         memcpy(ce->name + baselen, pathname, len+1);
>         oidcpy(&ce->oid, oid);
> -       return add_index_entry(istate, ce, opt);
> -}
> -
> -static int read_one_entry(const struct object_id *oid, struct strbuf *ba=
se,
> -                         const char *pathname, unsigned mode, int stage,
> -                         void *context)
> -{
> -       struct index_state *istate =3D context;
> -       return read_one_entry_opt(istate, oid, base->buf, base->len, path=
name,
> -                                 mode, stage,
> -                                 ADD_CACHE_OK_TO_ADD|ADD_CACHE_SKIP_DFCH=
ECK);
> -}
> -
> -/*
> - * This is used when the caller knows there is no existing entries at
> - * the stage that will conflict with the entry being added.
> - */
> -static int read_one_entry_quick(const struct object_id *oid, struct strb=
uf *base,
> -                               const char *pathname, unsigned mode, int =
stage,
> -                               void *context)
> -{
> -       struct index_state *istate =3D context;
> -       return read_one_entry_opt(istate, oid, base->buf, base->len, path=
name,
> -                                 mode, stage,
> -                                 ADD_CACHE_JUST_APPEND);
> -}
> -
> -
> -static int read_tree(struct repository *r, struct tree *tree,
> -                    struct pathspec *match, struct index_state *istate)
> -{
> -       read_tree_fn_t fn =3D NULL;
> -       int i, err;
> -
> -
> -       /*
> -        * See if we have cache entry at the stage.  If so,
> -        * do it the original slow way, otherwise, append and then
> -        * sort at the end.
> -        */
> -       for (i =3D 0; !fn && i < istate->cache_nr; i++) {
> -               const struct cache_entry *ce =3D istate->cache[i];
> -               if (ce_stage(ce) =3D=3D 1)
> -                       fn =3D read_one_entry;
> -       }
> -
> -       if (!fn)
> -               fn =3D read_one_entry_quick;
> -       err =3D read_tree_recursive(r, tree, "", 0, 1, match, fn, istate)=
;
> -       if (fn =3D=3D read_one_entry || err)
> -               return err;
> -
> -       /*
> -        * Sort the cache entry -- we need to nuke the cache tree, though=
.
> -        */
> -       cache_tree_free(&istate->cache_tree);
> -       QSORT(istate->cache, istate->cache_nr, cmp_cache_name_compare);
> -       return 0;
> +       return add_index_entry(istate, ce, ADD_CACHE_JUST_APPEND);
>  }
>
>  /*
> @@ -540,7 +485,8 @@ void overlay_tree_on_index(struct index_state *istate=
,
>                                PATHSPEC_PREFER_CWD, prefix, matchbuf);
>         } else
>                 memset(&pathspec, 0, sizeof(pathspec));
> -       if (read_tree(the_repository, tree, &pathspec, istate))
> +       if (read_tree_recursive(the_repository, tree, "", 0, 1,
> +                               &pathspec, read_one_entry_quick, istate))
>                 die("unable to read tree entries %s", tree_name);
>
>         for (i =3D 0; i < istate->cache_nr; i++) {
> --
> 2.31.0.rc0.126.g04f22c5b82
