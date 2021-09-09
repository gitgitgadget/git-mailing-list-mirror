Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB5EC433FE
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 14:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 043B7611C2
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 14:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243688AbhIIOtx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 10:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346332AbhIIOta (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 10:49:30 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBBBC0613BB
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 07:45:27 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id p14so1766326vsm.2
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 07:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TGs9yL5xxSeVTDkTYKlr2ElK2pNxwhFm1CjZAQpBLSQ=;
        b=VGxVX5H8AV6xDV1oAgx4L2/eEwqgL/2Kg51UUopbwoYekLJPq8MymuR48A421Pz1wd
         Tv4RasgDr84FCkBRt8MhZheki08NIVVofOmvuXKe3dL8bHiQ3DfQiVWb9xSwB6k9V1ts
         wC8n3AKG/PQ9rHdz4yRqEOJVu7XnXKJNhagsJ39O2v7nhE0ytwlPyKrOe2vW9tXDbemg
         okrb3/sBtq/oWnY1iiDQHvFOxji3sNLFjhs1FiASlVAyAzT0ecGkUsn+YSAjnAKr52S/
         pzCK/Eza8wNwAIozcjk41CjFqrx0t7tjUC4O7AvEKHyXZebr+LbbC9FWw5+Qfhz3FQp7
         3Ppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TGs9yL5xxSeVTDkTYKlr2ElK2pNxwhFm1CjZAQpBLSQ=;
        b=SSdBnsao5NDcAtQVNBtgNWsqu0Hd/RwHdDpRzvYdZIVDWgwJ/n3O9QF6BfU8xnuIMI
         JKRg6//Q7I3Kk0s0hFM1jcCzTIWOwKNafrXLYPVvwIgCI5582DrMkDxV+J/a/ZA30D78
         jxQS5qDY/iSTdQ9g8SeHguUiOUoPzxsniRqc356t4RhoBfE9SDvUjangb60o5BpF2yOW
         x9EnyFruwWPI2zB5jXvlt1YPsXuGl3Kd6bE4s6lRJvEIKZqwKhmJxtcTsuYIwRnbduUE
         XK6Jg0pbOQfPwBUuZfZqP3Mykaa+xv7JVLnhU2YwKg57zc20B6IEiiM1ygiEVp+TArJx
         wkvA==
X-Gm-Message-State: AOAM530w9/Y8lyHFQXp6EAnuKRG23q96n14ZeD++WBEOPaQFEV1H50DY
        S+7ZdbV0uAsLVkZVF75SigOXlw58lzNHJflN3xHsZfXdAvKiWIrQpao=
X-Google-Smtp-Source: ABdhPJxXVQwV8Vg/ti11LzJpbMt6CanK/rrY1ixrfbhY8UGytHwbWPxQxMgPnBwhAgcAwFQ+l5E5oJHGsxkNcvKoJKM=
X-Received: by 2002:a05:6102:116f:: with SMTP id k15mr1858020vsg.43.1631198727058;
 Thu, 09 Sep 2021 07:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <YTNpQ7Od1U/5i0R7@coredump.intra.peff.net> <YTNpeH+jO0zQgAVT@coredump.intra.peff.net>
 <CAOLTT8Tka0nxHb3G9yb-fs8ue7RaPCUVSKi5PM+GY+rMjFRnog@mail.gmail.com>
 <YTTARcEvpXWSDfYW@coredump.intra.peff.net> <CAOLTT8QbdNBSY95bCa+UNJBqsJEEHbnaKfZLzvN2Qzd-Np8Lqg@mail.gmail.com>
 <YTeo/dCFfpAIfo3K@coredump.intra.peff.net>
In-Reply-To: <YTeo/dCFfpAIfo3K@coredump.intra.peff.net>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 9 Sep 2021 22:45:15 +0800
Message-ID: <CAOLTT8Ru-Zhmo5j=jNjWexrahT0qAO5zEMW09XT00-TCca-SkA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ref-filter: hacky "streaming" mode
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> =E4=BA=8E2021=E5=B9=B49=E6=9C=888=E6=97=A5=E5=91=
=A8=E4=B8=89 =E4=B8=8A=E5=8D=882:01=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Sep 07, 2021 at 01:28:33PM +0800, ZheNing Hu wrote:
>
> > > I think it's just because pretty_print_ref() does not take a "flag"
> > > parameter for the caller. So it never sees that REF_ISSYMREF is set.
> > >
> >
> > yeah, pretty_print_ref() does not set the flag, this is a defect of
> > pretty_print_ref(), maybe we need to find a way to set this flag.
>
> In general, I think it could take a flag parameter from its caller. But
> its caller comes indirectly from for_each_tag_name(), which isn't a
> regular ref-iterator. It would probably need to switch to using
> read_ref_full() to get the flags.
>

Yeah, I think using read_ref_full() with verify_tag() changes can
solve this BUG:

$ git.fix tag --verify --format=3D'verify: %(refname) %(symref)' annotated =
symref
verify: refs/tags/annotated
verify: refs/tags/symref refs/tags/annotated

diff --git a/ref-filter.c b/ref-filter.c
index 1efa3aadc8..71b1d7da4f 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2613,18 +2613,6 @@ void ref_filter_maybe_stream(struct ref_filter *filt=
er,
        if (filter->reachable_from || filter->unreachable_from)
                return;

-       /*
-        * the %(symref) placeholder is broken with pretty_print_ref(),
-        * which our streaming code uses. I suspect this is a sign of break=
age
-        * in other callers like verify_tag(), which should be fixed. But f=
or
-        * now just disable streaming.
-        *
-        * Note that this implies we've parsed the format already with
-        * verify_ref_format().
-        */
-       if (need_symref)
-               return;
-
        /* OK to stream */
        filter->streaming_format =3D format;
 }
@@ -2735,6 +2723,7 @@ void pretty_print_ref(const char *name, const
struct object_id *oid,

        ref_item =3D new_ref_array_item(name, oid);
        ref_item->kind =3D ref_kind_from_refname(name);
+       read_ref_full(name, 0, NULL, &ref_item->flag);
        if (format_ref_array_item(ref_item, format, &output, &err))
                die("%s", err.buf);
        fwrite(output.buf, 1, output.len, stdout);

> > > I notice that the --verify output also shows the short refname, which
> > > makes me wonder if %(symref) would have other bugs there (because it
> > > has to re-resolve the ref to come up with the symref destination).
> > >
> >
> > This may be easy to fix:
> >
> > diff --git a/builtin/tag.c b/builtin/tag.c
> > index 452558ec95..4be5d36366 100644
> > --- a/builtin/tag.c
> > +++ b/builtin/tag.c
> > @@ -152,11 +152,11 @@ static int verify_tag(const char *name, const cha=
r *ref,
> >         if (format->format)
> >                 flags =3D GPG_VERIFY_OMIT_STATUS;
> >
> > -       if (gpg_verify_tag(oid, name, flags))
> > +       if (gpg_verify_tag(oid, ref, flags))
> >                 return -1;
> >
> >         if (format->format)
> > -               pretty_print_ref(name, oid, format);
> > +               pretty_print_ref(ref, oid, format);
> >
> >         return 0;
> >  }
>
> Yeah, I think that would work, although:
>
>   - there's another caller in cmd_verify_tag() which seems to just pass
>     whatever was on the command line. It doesn't even resolve the ref
>     itself!
>

We can modify get_oid() --> read_ref_full() in cmd_verify_tag()...
Yes, the inconsistency between cmd_verify_tag() and verify_tag() makes
me feel very strange.

>   - I suspect people may be relying on the current behavior. The
>     original was added to be able to compare the internal tagname to the
>     refname. I.e., that:
>
>       git tag -v --format=3D'%(refname) %(tag)' foo
>
>     would show "foo foo". Now that _should_ be "%(refname:strip=3D2)", I
>     think, but we'd probably be breaking scripts. OTOH, it really feels
>     like _not_ handing over a real, fully-qualified refname to the
>     ref-filter code will mean other things are broken (e.g.,
>     ATOM_UPSTREAM is assuming we have a fully-qualified ref).
>

This is indeed a sad thing: A bug becomes a feature.

>     I think a backwards-compatible way of fixing it would be to have
>     this call hand over the full refname to the ref-filter code, but
>     tell it that %(refname) should default to strip=3D2. And then anybody
>     who wants the full name can use %(refname:strip=3D0).
>

Doesn't this make things more complicated? Those callers of git for-each-re=
f,
wouldn't our changes like this destroy them?


>     It makes the behavior confusing and quirky, but we can't avoid that
>     without breaking compatibility.
>

Eh, I think we may need other solutions.

> -Peff

Thanks.
--
ZheNing Hu
