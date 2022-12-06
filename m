Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D212C352A1
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 13:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbiLFNJR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 08:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiLFNIt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 08:08:49 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26E02D1C4
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 05:07:02 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id q83so3322063oif.7
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 05:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhA/YXD3w7WrRiyyVHjIT3ZHV+LQ5LRFLmX+c8KOY5g=;
        b=XZ8AEgMPR4LsWAps+hp7gvbqfIEbRTiTbTFGkso3X37dbhCiiJhvIaXJ5a3DdVqsd8
         uBHPyhKeKI9hYtKsygPSsChlDzeik8WizE3JkYL/uW3HE9tf1QH2yd+RLfu9XkcIJMA0
         GSxLM12RQy6Z7LmCa5GxIKYmBaJkeT8wWuj9BhAV4eTPkenBAcc6+XzMLXfsbfBzgBq/
         znXWK8eajfRPLdDHEIYjRzcvlQQ+fdmZZSH51GDURd4/66MPpcoKtfa0vnjf20cquVnN
         H8tTWqZiz0jS+naNXm0h4Cr0J/7BL1NtJ4NUP/n/xfWpK10D759Qr1q9fIPJSe0Ugjtb
         P9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mhA/YXD3w7WrRiyyVHjIT3ZHV+LQ5LRFLmX+c8KOY5g=;
        b=L0B+pgbu83q51iS8dM3wRCkENFXgtsxSCZe6sBtx2KCUPwY+7PMJJyMAnvLcaaKssY
         jSyjalxAZmdGlb3JwQRjxHvcK/pwVGw6JvJsw7H5kGBV1jaCRwc67D3MTajgu+CQzGTl
         6Xeyj86gvzaF/ysRTlm3BSAViC12R0XZHbS9P57UlCKErkXHbpEYg9acNf05wZ6z97Fg
         bLrSe9oa7sifzxoN8dJcCY2RSIE4+Z9LXHYuFOqqFxa0yw+3AX+nRRQXaMA+XYZN7fiM
         UgbkOVnVQbx2a07ikv/zaWPbo+51Py2x36O3aLXlcyhwTsheezLlfOKI2JV8RJ2UR8n0
         apmA==
X-Gm-Message-State: ANoB5pnRyciX9Ge4j4BliA6qgApU+Ch8Dc5IgRqz+IgC00qCM2fHgqew
        lvhbYvY3Jn64uCDt2TL01cWoxzDltuz8zyIhr5cBrQzqXQw=
X-Google-Smtp-Source: AA0mqf7p1hd3rZdLmoPW7sBQ52CbBwnnNv2EqNNnvWq1zO/99i4OTjfHTKH7Dvby92lIHINa7T5n1rC/A0DFnq74un4=
X-Received: by 2002:a05:6808:8c9:b0:35a:cf84:d837 with SMTP id
 k9-20020a05680808c900b0035acf84d837mr41185789oij.270.1670332021955; Tue, 06
 Dec 2022 05:07:01 -0800 (PST)
MIME-Version: 1.0
References: <20221206103736.53909-1-karthik.188@gmail.com> <20221206103736.53909-3-karthik.188@gmail.com>
 <221206.861qpcdarb.gmgdl@evledraar.gmail.com>
In-Reply-To: <221206.861qpcdarb.gmgdl@evledraar.gmail.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Tue, 6 Dec 2022 14:06:36 +0100
Message-ID: <CAOLa=ZSOhtgmY-j3rj+=qANKOfTH8H+1YpwM63uTKUT04vsM-Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] attr: add flag `-r|--revisions` to work with revisions
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, toon@iotcl.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello =C3=86var,

> >
> > diff --git a/attr.c b/attr.c
> > index 42ad6de8c7..42b67a401f 100644
> > --- a/attr.c
> > +++ b/attr.c
> > @@ -11,8 +11,12 @@
> >  #include "exec-cmd.h"
> >  #include "attr.h"
> >  #include "dir.h"
> > +#include "git-compat-util.h"
>
> As a rule in this project we include either cache.h at the top, or
> git-compat-util.h, and the former includes the latter.
>
> This file already has cache.h at the top, so it won't need this.
>

Right, will remove.

> > +     if (buf =3D=3D NULL)
>
> if (!buf)

Makes sense.

>
> > +             more =3D (*ep =3D=3D '\n');
>
> Nit: parens not needed.
>

I rather let this be, since it's existing code that I just move.

> > +     struct object_id oid;
> > +     unsigned long sz;
> > +     enum object_type type;
> > +     void *buf;
> > +     struct strbuf sb;
> > +
> > +     if (object_name =3D=3D NULL)
>
> Ditto !object_name test.
>

Will change.

> > +             return NULL;
> > +
> > +     strbuf_init(&sb, strlen(path) + 1 + strlen(object_name));
> > +     strbuf_addstr(&sb, object_name);
> > +     strbuf_addstr(&sb, ":");
> > +     strbuf_addstr(&sb, path);
>
> Is this really performance sensitive so we need to pre-size this, or
> would a simpler:
>
>         struct strbuf sb =3D STRBUF_INIT;
>         strbuf_addf(&sb, "%s:%s", path, object_name);
>
> Do?
>

This is much simpler and should do, will change.

> > +     } else if (object_name !=3D NULL) {
>
> else if (object_name)

Will change.

>
> >  void git_check_attr(struct index_state *istate,
> > -                 const char *path, struct attr_check *check);
> > +                                     const char *path, struct attr_che=
ck *check,
> > +                                     const char *object_name);
>
> This (and possibly other places) seem funnily indented..
>

I think it's due to tab-indent being set to a default 4, I fixed it in
the other files, forgot to
check the header. Will fix it.

> >       if (collect_all) {
> > -             git_all_attrs(&the_index, full_path, check);
> > +             git_all_attrs(&the_index, full_path, check, object_name);
> >       } else {
> > -             git_check_attr(&the_index, full_path, check);
> > +             git_check_attr(&the_index, full_path, check, object_name)=
;
> >       }
>
> Earlier you do a get_oid(), shouldn't that be a
> repo_get_oid(istate->repo, ...) to be future-proof? I.e. use the repo of
> the passed-in index.
>
> I think it'll always be "the_repository" for now, but for an API it
> makes sense to hardcode that assumption in fewer places.
>

I will make this change, I didn't know about repo_get_oid() before.

> > +test_expect_success 'bare repository: with --revision' '
> > +     (
> > +             cd bare.git &&
> > +             (
> > +                     echo "f test=3Df" &&
> > +                     echo "a/i test=3Da/i"
>
> You don't need a subshell just to echo a string. You can use {}-braces,
> but in this case just:
>
>     printf "%s\n", "f test=3Df" "a/i test=3Da/i" | git hash-object .... &=
&
>
>

While I agree with what you're saying, the whole test file does it
this way (echo in a subshell),
wouldn't it be better to stay consistent?

> > +             ) | git hash-object -w --stdin > id &&
> > +             git update-index --add --cacheinfo 100644 $(cat id) .gita=
ttributes &&
>
> Split the "cat" into a varible, otherwise its failure will be hidden.
>

Done.

> > +             git write-tree > id &&
>
> We use ">id" style for redirection, not "> id".
>
> > +             git commit-tree $(cat id) -m "random commit message" > id=
 &&
>
> Ditto..

Will make this change too.

Thanks for the review. Will wait a day or two before sending in the
next version.

--=20
- Karthik
