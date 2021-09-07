Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA94C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 05:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8D63604AC
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 05:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhIGF3y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 01:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbhIGF3w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 01:29:52 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22B9C061575
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 22:28:45 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id q3so11197301iot.3
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 22:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DRBs4CSasFpmvUrCLu581fM5jBPUMcpT6i0LLxqsf48=;
        b=E4mHAg9LIjznKhNCUOEZamGedm1sQpjiKSIYNJAn0DVgn/1Gucdydigtdmj5NPdOpW
         gvY+CNZixuyLUlYNL8YCjDCail6jm05rRSkw0eygLxJGzNtFCMNcoP6+RyvgOw/Lg+L+
         AzKzZKwOWBK4ZHEqxrusLsqsZsbADEr3GRvfhfV50YnIu4lrEoZAqFBorikyj+wKpgXP
         Bc9hzXPTdi3RV8WaRKxl5rM3ijhBBGRgG9bM3N8q8fRwoJlHjHp+UsHp7ZmizpjLfOL2
         4/FaQhP+FeNPL2ItAiS+kmH34z388hXyljQYX2qUZj/Jh3vwbqaOZUB7CTmSgZaD62ie
         7rbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DRBs4CSasFpmvUrCLu581fM5jBPUMcpT6i0LLxqsf48=;
        b=fVZEtV6XsWx5d5HuQjt2m4nPuienuvpCqYTVXM10dACUu2fWt1kgY4YoPMDMmD3BP5
         awW4UgbYBzGCTznq4wIUeYqaYtaR5Qq5Gj0lFcJIeBLOOSSjuvs3jLsKwsyGDmjbZajw
         48jRVkRXx7AYvXLHSOTuASPJzS5kC4qQksDanOqjJMxrhPxrV8eP3TGrLpchEXRSQ9gk
         it5LF1YabbtwihPFeRI2IUDaEhn7E0faprOs3a3jkxnmkyA4iC9NhOXDUlmmOHudWPdt
         CurUL0FjZQTf23FW6zWhMh7Uqvy90NklBF413n60nDr2AS3E+JGh7ZenYJspOef7uIK0
         Evaw==
X-Gm-Message-State: AOAM531A5pdtTjCqPlQomTWXuXuixA4WT9VNutArATX51BZWIoPnTSYa
        GfNOESpHXtcjRwTZEZw3sbaLe2TMm63brIMHCHVz/xGR0S8xH7Hqrn8=
X-Google-Smtp-Source: ABdhPJx4OmK3z9BGB6XnXJ+Fqn0uejWJXUXMsh4mpsOBnjPe24zNHr3OX6YU0tM9QSGz1RjLJ27zS2E0XkKLKFzr8dc=
X-Received: by 2002:a05:6602:2cc5:: with SMTP id j5mr12456178iow.156.1630992525291;
 Mon, 06 Sep 2021 22:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <YTNpQ7Od1U/5i0R7@coredump.intra.peff.net> <YTNpeH+jO0zQgAVT@coredump.intra.peff.net>
 <CAOLTT8Tka0nxHb3G9yb-fs8ue7RaPCUVSKi5PM+GY+rMjFRnog@mail.gmail.com> <YTTARcEvpXWSDfYW@coredump.intra.peff.net>
In-Reply-To: <YTTARcEvpXWSDfYW@coredump.intra.peff.net>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 7 Sep 2021 13:28:33 +0800
Message-ID: <CAOLTT8QbdNBSY95bCa+UNJBqsJEEHbnaKfZLzvN2Qzd-Np8Lqg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ref-filter: hacky "streaming" mode
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> =E4=BA=8E2021=E5=B9=B49=E6=9C=885=E6=97=A5=E5=91=
=A8=E6=97=A5 =E4=B8=8B=E5=8D=889:04=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Sep 05, 2021 at 04:20:02PM +0800, ZheNing Hu wrote:
>
> > But here is a terrible fact: we did not use ref_array_sort() for sortin=
g here.
> > So in fact, for_each_fullref_in() does the sorting work () for us by
> > default sort (%(refname)),
> > This may be due to the file system or some implementation of ref_iterat=
or.
> > But this limit the application of this optimization when we use other
> > atoms to sort.
>
> Right. This technique does not help at all if you use --sort. I do think
> it's reasonable to rely on the sorted output of the for_each_ref()
> functions; other parts of Git likely do as well, so I think we'd try
> pretty hard to maintain that (and no, it's not a filesystem thing; we do
> make sure to sort it ourselves; see the calls to sort_ref_dir()).
>
> > > +       /*
> > > +        * the %(symref) placeholder is broken with pretty_print_ref(=
),
> > > +        * which our streaming code uses. I suspect this is a sign of=
 breakage
> > > +        * in other callers like verify_tag(), which should be fixed.=
 But for
> > > +        * now just disable streaming.
> > > +        *
> > > +        * Note that this implies we've parsed the format already wit=
h
> > > +        * verify_ref_format().
> > > +        */
> > > +       if (need_symref)
> > > +               return;
> > > +
> >
> > I haven=E2=80=99t taken a closer look at why pretty_print_ref() does no=
t
> > support %(symref),
> > we can skip it first.
>
> I think it's just because pretty_print_ref() does not take a "flag"
> parameter for the caller. So it never sees that REF_ISSYMREF is set.
>

yeah, pretty_print_ref() does not set the flag, this is a defect of
pretty_print_ref(), maybe we need to find a way to set this flag.
I also deliberately avoided %(symref) when refactoring git cat-file --batch=
,
perhaps the improvements here can also be applied to git cat-file --batch

> There aren't many callers of that function, so I think nobody ever
> really noticed. But you can see the bug like this:
>
>   git init repo
>   cd repo
>
>   git commit --allow-empty -m foo
>   git tag -s -m bar annotated &&
>   git symbolic-ref refs/tags/symref refs/tags/annotated
>
>   # this is ok; ref-filter handles the flags
>   git tag --list --format=3D'list: %(refname) %(symref)'
>
>   # not ok; we do not tell the formatter about the flags, so it does
>   # not notice that "symref" is a symref
>   git tag --verify --format=3D'verify: %(refname) %(symref)' annotated sy=
mref
>
> I notice that the --verify output also shows the short refname, which
> makes me wonder if %(symref) would have other bugs there (because it
> has to re-resolve the ref to come up with the symref destination).
>

This may be easy to fix:

diff --git a/builtin/tag.c b/builtin/tag.c
index 452558ec95..4be5d36366 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -152,11 +152,11 @@ static int verify_tag(const char *name, const char *r=
ef,
        if (format->format)
                flags =3D GPG_VERIFY_OMIT_STATUS;

-       if (gpg_verify_tag(oid, name, flags))
+       if (gpg_verify_tag(oid, ref, flags))
                return -1;

        if (format->format)
-               pretty_print_ref(name, oid, format);
+               pretty_print_ref(ref, oid, format);

        return 0;
 }

> > Unfortunately, this optimization may not be helpful for git cat-file --=
batch,
> > see [1], batch_object_write() directly constructs a ref_array_item and =
call
> > format_ref_array_item() to grab data, It does not use ref_array. So it =
also
> > does not have this malloc() | free() overhead.
>
> Right. It would only be helped by the "quick" formats in the second
> patch (and by skipping the malloc/free of the individual
> ref_array_items).
>

Yes, your test is indeed worth thinking about: how to avoid
intermediate data to reduce overhead.

> -Peff

Thanks.
--
ZheNing Hu
