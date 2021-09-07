Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8EDC433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 05:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C69761101
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 05:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237062AbhIGFoT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 01:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbhIGFoN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 01:44:13 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C142C061575
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 22:43:08 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id i13so8851517ilm.4
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 22:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5Jh+r6Sp34BwUA6neGg0cmGkBKXiFwGnEvmouqbh/0A=;
        b=iqoigPgzfCreYAQwRtyaZL4Qhd6ZFB8TlS2OxtrtShGjQSq28eMUfVSRTtkVDlPYZz
         y0sW4utGPT09NQe5wJPn0yGS5yJSH6/NOjzxTS2uvlSTFsFWU4wxFWTag+80uZLfjW+M
         7hSzBNM7ISaOFUzMAVhHxsByX9s/z+wWokNN/eWPRl3AjU/jz9I/6pS0yYxv45RCezQ2
         SCddKubukF7YfLObS2tc9LUfUX58IfndYuYNoSFOBI1upxVNX+0wVZ+R3uDth7CiVu53
         CyiHtJ4IsqIP0FkdQzJnXZBuWJp/a5JbmCeYQ8SpohZ5ijKhfIzctdewaxTTZAlGOn4T
         Xkpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5Jh+r6Sp34BwUA6neGg0cmGkBKXiFwGnEvmouqbh/0A=;
        b=JDzgpGHCnNYYF+ILDk/wYs1NukqRF/q5qFoZOneE+ghIAjEgEZeZZFBLVrmpDeHMKe
         SOzfSlrL3ctCLHBkJEOFMiUJOi7JiWDSiE0WD7vNuYwNX5vyXjTL9mfgsjW/iQ1mXnRB
         /ZFMrA5Fnw1UHdwZcFY+UY/AoVWwsLDVlkxr6Ejw/kdCwAJVaYXep32QbKr7eheAGops
         UO6HKEvnLaV1LUudmnzIZabJ/MxcL1ovV5hnLzcPwZCNtwfcNtiNErqCCt+dQc9RTgGJ
         9V8BmEFaAWe2NrmabkIHHy7P1O46NAe4740j9DmIst060odn9se7qDqJ9RSRGmmEOmA1
         TK6g==
X-Gm-Message-State: AOAM530sN2i1nHD+r2+c/U5SU2i25gwUFfjGPx7OxYsAfPemXYXFsN+/
        U295jeEgoZ2Ubos+SXF/aL9R3P+PneGodqUS5JI=
X-Google-Smtp-Source: ABdhPJw6mdNGzLbyK3ogSSpecHja3oYpPk95YmW+CsHW8YGutXDRTVEiXeznMh+VELwPqsBsVT/x9W+UrDfeSqx6Pxg=
X-Received: by 2002:a92:d752:: with SMTP id e18mr11265957ilq.254.1630993387498;
 Mon, 06 Sep 2021 22:43:07 -0700 (PDT)
MIME-Version: 1.0
References: <YTNpQ7Od1U/5i0R7@coredump.intra.peff.net> <YTNpeH+jO0zQgAVT@coredump.intra.peff.net>
 <CAOLTT8Tka0nxHb3G9yb-fs8ue7RaPCUVSKi5PM+GY+rMjFRnog@mail.gmail.com> <YTTC2IUO1ZmTOEoR@coredump.intra.peff.net>
In-Reply-To: <YTTC2IUO1ZmTOEoR@coredump.intra.peff.net>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 7 Sep 2021 13:42:56 +0800
Message-ID: <CAOLTT8QzNt8dv5-Q4nV9XU9Tq7KZVSjaYcM3T4F=F=xZ9A3UUA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ref-filter: hacky "streaming" mode
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> =E4=BA=8E2021=E5=B9=B49=E6=9C=885=E6=97=A5=E5=91=
=A8=E6=97=A5 =E4=B8=8B=E5=8D=889:15=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Sep 05, 2021 at 04:20:02PM +0800, ZheNing Hu wrote:
>
> > > +       if (ref_cbdata->filter->streaming_format) {
> > > +               pretty_print_ref(refname, oid, ref_cbdata->filter->st=
reaming_format);
> >
> > So we directly use pretty_print_ref() in streaming mode, OK.
> >
> > > +       } else {
> > > +               /*
> > > +                * We do not open the object yet; sort may only need =
refname
> > > +                * to do its job and the resulting list may yet to be=
 pruned
> > > +                * by maxcount logic.
> > > +                */
> > > +               ref =3D ref_array_push(ref_cbdata->array, refname, oi=
d);
> > > +               ref->commit =3D commit;
> > > +               ref->flag =3D flag;
> > > +               ref->kind =3D kind;
> > > +       }
> > >
> > >         return 0;
> > >  }
> >
> > Therefore, in streaming mode, there is no need to push ref to
> > ref_array, which can
> > reduce the overhead of malloc(), free(), which makes sense.
>
> By the way, one thing I wondered here: how much of the benefit is from
> avoiding the ref_array, and how much is from skipping the sort entirely.
>
> It turns out that most of it is from the latter. If I do this:
>
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index 89cb6307d4..037d5db814 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -78,7 +78,11 @@ int cmd_for_each_ref(int argc, const char **argv, cons=
t char *prefix)
>         filter.name_patterns =3D argv;
>         filter.match_as_path =3D 1;
>         filter_refs(&array, &filter, FILTER_REFS_ALL | FILTER_REFS_INCLUD=
E_BROKEN);
> -       ref_array_sort(sorting, &array);
> +       /*
> +        * we should skip this only when we are using the default refname
> +        * sorting, but as an experimental hack, we'll just comment it ou=
t.
> +        */
> +       // ref_array_sort(sorting, &array);
>
>         if (!maxcount || array.nr < maxcount)
>                 maxcount =3D array.nr;
>
> then the timings I get are:
>
>   Benchmark #1: ./git.old for-each-ref --format=3D'%(objectname) %(refnam=
e)'
>     Time (mean =C2=B1 =CF=83):     341.4 ms =C2=B1   7.4 ms    [User: 299=
.8 ms, System: 41.6 ms]
>     Range (min =E2=80=A6 max):   333.5 ms =E2=80=A6 355.1 ms    10 runs
>
>   Benchmark #2: ./git.new for-each-ref --format=3D'%(objectname) %(refnam=
e)'
>     Time (mean =C2=B1 =CF=83):     249.1 ms =C2=B1   5.7 ms    [User: 211=
.8 ms, System: 37.2 ms]
>     Range (min =E2=80=A6 max):   245.9 ms =E2=80=A6 267.0 ms    12 runs
>
>   Summary
>     './git.new for-each-ref --format=3D'%(objectname) %(refname)'' ran
>       1.37 =C2=B1 0.04 times faster than './git.old for-each-ref --format=
=3D'%(objectname) %(refname)''
>
> So of the 1.5x improvement that the original patch showed, 1.37x is from
> skipping the sort of the already-sorted data. I suspect that has less to
> do with sorting at all, and more to do with the fact that even just
> formatting "%(refname)" for each entry takes a non-trivial amount of
> time.
>

Yes, I think this overhead may come from get_ref_atom_value() instead
of QSORT_S().

> -Peff

Thanks.
--
ZheNing
