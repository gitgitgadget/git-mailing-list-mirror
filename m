Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76156C433DB
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 06:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B572619BC
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 06:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhCWG3o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 02:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhCWG3R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 02:29:17 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7933EC061574
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 23:29:17 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id f73-20020a9d03cf0000b02901b4d889bce0so18426228otf.12
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 23:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FgODyTYDy1ZBbilmGC1faNQ4ney+MXvomiGxWol1RUQ=;
        b=suDlHJmyngprnuc5EW/pRufCsnJ4PBgAyzcjWQbCrB5fRn/50ciw7/TYCsVcookinV
         ReNOPAujXrG3/ngyWqNa5s9Tr5StcDNtCYsvIEZI7GY8hRiJvBvKNLinnQxZ2avGWOKu
         ub/5Oz6qLtr2YlO/04GTR4dS3ahhHybU6Ink5OsYj+B/530hw05FjIUiSIB+7gcXqThi
         iIqN2CtHafzPwhPEmArEy02PXr/QM3OV846vld5rEJw1fI4RacLGczyLOuKSWzmlA2Xj
         dXr8RPsPKxL2qdJgdOP9YL6pbuEN9AfosT0uT2R2/hpQirMT7t1YY9q8c27Ssmu0yo6Z
         KXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FgODyTYDy1ZBbilmGC1faNQ4ney+MXvomiGxWol1RUQ=;
        b=lY2w+VSLblBHDO0BVTKtTaPqMGx40vDvj8LKQvkMbhBG9i1PCiNVMaKUwLCmvPVrnA
         5RIK+KnZOy7B9v/9A3gCb5/Vs0L3yxwxfSnHISfgGsobwyncFL3epQ/a4pS0anZiaktC
         0WfKySQ/FHLDSnyYyL1cyYwSbT0uInlBh4h14DDIHQNmC1s/aikR6WIvfKugF8F0xs2+
         /MUr/NB8dfNAODBxHqvR8l0e2BgEB6FD5lrhTl/Hbr0GwWnG0hx0QVBs1iXvcTzp/Z4C
         Xwrege8cNSJIr6IjtA+akL9Ug+RLm1ptqvO/4L8eBV35zsZ0sTNXbfU7vX3DQhG33Mk7
         rd0Q==
X-Gm-Message-State: AOAM530hnqdpMfeK8TOVKZURxztH2UEeF3tCBzRV8/pWaosyUvESZfHk
        1Xd/6Y0ikp1zgYwl5/uiyxOT3Lu0AuWr5uJlCBQ=
X-Google-Smtp-Source: ABdhPJxU0M3ODrMgqCAF83/p8RrAAVE7oxZjxe9wZ/E892nJf9LaVOJZl3sWrzB0KxFk9gFM9MoPIYRuzb8sh/X/oC4=
X-Received: by 2002:a9d:6ad6:: with SMTP id m22mr3020268otq.160.1616480956812;
 Mon, 22 Mar 2021 23:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <pull.901.v12.git.1616247681211.gitgitgadget@gmail.com>
 <pull.901.v13.git.1616387093662.gitgitgadget@gmail.com> <CAP8UFD0rtX0m+fGcvGFtsFFKZ2LVyxHx8dptYFvM9kWnbxEwFA@mail.gmail.com>
 <CAOLTT8Ty5kabU6ivX946=FDWJ4SEXBzPinq2aG5t7Rp9jCCEPA@mail.gmail.com> <CAP8UFD275WiHC2sUJjsnLd1yonfMO-SVda=BZ6mMkgDxGs959g@mail.gmail.com>
In-Reply-To: <CAP8UFD275WiHC2sUJjsnLd1yonfMO-SVda=BZ6mMkgDxGs959g@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 23 Mar 2021 14:29:01 +0800
Message-ID: <CAOLTT8S09oTZYjDArMNhQSLAaHtikrw=H4Z8WHF9GvWukQytaQ@mail.gmail.com>
Subject: Re: [PATCH v13] [GSOC] commit: add --trailer option
To:     Christian Couder <christian.couder@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=
=8823=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=885:55=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Mon, Mar 22, 2021 at 11:23 AM ZheNing Hu <adlternative@gmail.com> wrot=
e:
>
> > 2.
> > `git interpret-trailers --in-place`  seem like work on git top-dir,
> > If I am in a sub-dir `b` and I want to change a file such as `d.c`,
> > then I must use `git interpret-trailers --in-place b/d.c` to add some
> > trailers.
>
> What happens without --in-place? Are the input files read correctly?

It's still wrong.
the git die() in `read_input_file` of "trailer.c".

>
> > I think the original intention of `--in-place` is to modify a file simi=
lar to
> > "$COMMIT_MSG_FILE", so make it run at top-dir, but this is not reflecte=
d
> > in the git documentation. This at least confuses people who use this
> > option for the first time. Is it worth modifying? Or is there something
> > wrong with the design of `--in-place`?
>
> I haven't checked but there is perhaps a bug in
> create_in_place_tempfile() in "trailer.c".

I haven't check finished. But I think it may do something like `chdir()`.

Thanks.
