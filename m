Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA7FC433FE
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 12:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 769156108F
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 12:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237644AbhIOM2s (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 08:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237525AbhIOM2r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 08:28:47 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F63C061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 05:27:28 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id n17so1892683vsr.10
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 05:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+wwFPKS6P+1H66Oq6PMYUuI8rurPmvrbkcKlCx7oiR0=;
        b=ODQhTtom8YWEu4QtJCjD/iyfnoWHgMdn0S8Mw2cb12bANqdi9SMZCFI1GkqFNDqAxA
         Oze8B2C1kkQwI3Tx657py0FuzQl/Yy0iTMExDECw9Kw7a/bpUdP2q0leck3FMxEwg1l6
         xHvj4PJKmiKicpV+sKgnoZaluzl6ZnPa131zPI5tDC0R11oZ5KWNJB5Ectv+x9p5qC/k
         TU4MY6wn9/gDuGfAYJseQgOcda8JEIREP99lojtooVnUnvtXbjzANmySlijnL3GS76UX
         pz0y4Af5TnoJTZ3MB7UUN2XBnALEr6twnMvT+aQONlHY2a06G8U9DyI7hdutxxIdqQSH
         Ksrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+wwFPKS6P+1H66Oq6PMYUuI8rurPmvrbkcKlCx7oiR0=;
        b=746dJ7hIZphpQufp1RHAzW0yP6XUt5ro+l+jvANl8etzdv4M6tepXhvBkrpzXHag86
         eIuIigXLFJg38vwazQhb1JGBX1PbWhjqaeOjiGxL/qaOnu5LOZRJvwLG0NiWPnMwjcpv
         1RZ+Q90yTUnp4HuSmjP2V546oVxePD7jzWmnIiQKE4lM3xoG6ZxVHtdZYnoIbL9ydha7
         kJ48S+M/imdNkBIe3X36Nkq0ZtL48wcaoESxa4gu75kfaGiapb8k4mMrGsmgmdgfP/3v
         Kj1jcdWM4ksL3lj+sD5whG9RYOAPxcrW0JcJjX/SX6ZqQFjP1DTn/WvTpwVRQ+Lnwuiu
         ZKlw==
X-Gm-Message-State: AOAM530AFFIkUsMdLwVLikdrF5R/0DQ3/cHcd0h2NqUZe12skRcT+tbh
        wE3DSz6WwEkxT+DKPcw+MplGa4WCMSQYcDrBANYGnM8XSU/ZrIKtvXc=
X-Google-Smtp-Source: ABdhPJwVGqf1QyFsDAuAQh0RZ7muDj8xwitzHmFanfCRgpj2J6YHCh7Kg3u9peIVsgOTBUotJRWPry5KcnfwCK2GgIA=
X-Received: by 2002:a05:6102:116f:: with SMTP id k15mr2961768vsg.43.1631708847256;
 Wed, 15 Sep 2021 05:27:27 -0700 (PDT)
MIME-Version: 1.0
References: <YTNpQ7Od1U/5i0R7@coredump.intra.peff.net> <YTNpeH+jO0zQgAVT@coredump.intra.peff.net>
 <CAOLTT8Tka0nxHb3G9yb-fs8ue7RaPCUVSKi5PM+GY+rMjFRnog@mail.gmail.com>
 <YTTARcEvpXWSDfYW@coredump.intra.peff.net> <CAOLTT8QbdNBSY95bCa+UNJBqsJEEHbnaKfZLzvN2Qzd-Np8Lqg@mail.gmail.com>
 <YTeo/dCFfpAIfo3K@coredump.intra.peff.net> <CAOLTT8Ru-Zhmo5j=jNjWexrahT0qAO5zEMW09XT00-TCca-SkA@mail.gmail.com>
 <YTtrF8C0mmT6kBJT@coredump.intra.peff.net>
In-Reply-To: <YTtrF8C0mmT6kBJT@coredump.intra.peff.net>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 15 Sep 2021 20:27:15 +0800
Message-ID: <CAOLTT8RPzutEQxbr9cu=ze7rgPKvG6Ghu4b2Bi47eStY1TqGzQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ref-filter: hacky "streaming" mode
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> =E4=BA=8E2021=E5=B9=B49=E6=9C=8810=E6=97=A5=E5=91=
=A8=E4=BA=94 =E4=B8=8B=E5=8D=8810:26=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Sep 09, 2021 at 10:45:15PM +0800, ZheNing Hu wrote:
>
> > @@ -2735,6 +2723,7 @@ void pretty_print_ref(const char *name, const
> > struct object_id *oid,
> >
> >         ref_item =3D new_ref_array_item(name, oid);
> >         ref_item->kind =3D ref_kind_from_refname(name);
> > +       read_ref_full(name, 0, NULL, &ref_item->flag);
> >         if (format_ref_array_item(ref_item, format, &output, &err))
> >                 die("%s", err.buf);
> >         fwrite(output.buf, 1, output.len, stdout);
>
> IMHO this is the wrong place to do it, since the caller may already have
> the flags (and looking up the ref again is a non-trivial cost).
>

Well, but not doing this means that we have to pass the flag from the
pretty_print_ref() call stack.

> The caller in builtin/tag.c should switch to using read_ref_full() and
> pass in the flags.
>

Agree.

> The caller in builtin/verify-tag.c _probably_ should resolve the ref in
> the same way and pass in that full refname and flags. I do worry that
> this may be a compatibility problem, but the current behavior seems so
> broken to me.
>

Yeah.

> > >   - I suspect people may be relying on the current behavior. The
> > >     original was added to be able to compare the internal tagname to =
the
> > >     refname. I.e., that:
> > >
> > >       git tag -v --format=3D'%(refname) %(tag)' foo
> > >
> > >     would show "foo foo". Now that _should_ be "%(refname:strip=3D2)"=
, I
> > >     think, but we'd probably be breaking scripts. OTOH, it really fee=
ls
> > >     like _not_ handing over a real, fully-qualified refname to the
> > >     ref-filter code will mean other things are broken (e.g.,
> > >     ATOM_UPSTREAM is assuming we have a fully-qualified ref).
> > >
> >
> > This is indeed a sad thing: A bug becomes a feature.
> >
> > >     I think a backwards-compatible way of fixing it would be to have
> > >     this call hand over the full refname to the ref-filter code, but
> > >     tell it that %(refname) should default to strip=3D2. And then any=
body
> > >     who wants the full name can use %(refname:strip=3D0).
> > >
> >
> > Doesn't this make things more complicated? Those callers of git for-eac=
h-ref,
> > wouldn't our changes like this destroy them?
>
> My proposal was that we'd have a specific flag in ref-filter to say
> "default refname:strip to this value". And then _only_ "tag --verify"
> would set that (to "2"), leaving for-each-ref, etc unaffected.
>

Indeed this may be a feasible solution. I will try to do this first.

> So yes, it's complicated. And it must be explained to the user that
> "%(refname)" behaves slightly differently with "git tag --verify", but
> that is unavoidable if we do not want to break scripts (it _already_
> behaves slightly differently, and we just never told anyone).
>
> The other option is to declare the current behavior a bug and fix it. I
> am quite tempted by that route, given the inconsistency with other
> formatters, including even "git tag --list --format=3D%(refname)"!

I don't know, I think both fix methods are okay.

>
> -Peff

Thanks.
--
ZheNing Hu
