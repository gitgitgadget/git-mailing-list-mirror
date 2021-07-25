Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EDCC4338F
	for <git@archiver.kernel.org>; Sun, 25 Jul 2021 12:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F04C960E90
	for <git@archiver.kernel.org>; Sun, 25 Jul 2021 12:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhGYMGV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Jul 2021 08:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhGYMGT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jul 2021 08:06:19 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6772DC061757
        for <git@vger.kernel.org>; Sun, 25 Jul 2021 05:46:48 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id f11so8342045ioj.3
        for <git@vger.kernel.org>; Sun, 25 Jul 2021 05:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SZDMAbQr/a/6tHiqGOlRMEUks48VQcu73CBNI4XAbp8=;
        b=ZEayw0WeVAQxvD9KVy0GaDFRcm9I2fvzv4EgRTx4ZUnekru8qEHZFTj/oMq6kt79Fv
         6kCfQcT8OsXsqtampUmHus1xKEFqo4gOhdY7y0YDnUBiOmELVE2NF4l7ePz5/KY/aE6j
         Z8MWoHH6HPl/WzrZvKg+fiYlMsyepNI8hDQBuRFE2PQNhiqc1vtyLT5GJioWgK4sT5dL
         vAOC4MHPteOJqGTpWSO2jadO64UIbqSj1c72NJU+6ZY6psedB0iBhPO2wCOxLyPcCrnJ
         93edt5IPhVskYR5SjaYfXLoH8LS9XYP+MhOAkIocQzJBk4l8G5fsl/bvD7D6vC8hr8Zc
         z7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SZDMAbQr/a/6tHiqGOlRMEUks48VQcu73CBNI4XAbp8=;
        b=hRjr5vKJm925A7uGO49g+zD9O3aQbG7Oux+jIDjNkDrVqTqI7noYnbhZIzrmdwOr/X
         AaQw4b+uLnh1fQSRI+lYGyDo/0XaYJcHUIv2t1viUavkQljk33YXdmvEeUYqf4h5/wOU
         FL8Cetrshzh0XMD4EayAXdH/0W8w6lRyxFU53pvjfYOnIlfL5OZQiKZNIEwbJ+2ntYzT
         bfYHgor7pM3mYFd+fTmepJCO/XQdvHsC+mI61hPCNrEs54eEIzPPlMsWBeAO4eranioe
         fBPEVi+U6KyZZTi9Ix1nSIfMMuIiZGphO/D3oh40/EspycOuLYrq6q81l4fLUzZp5NyG
         tZAg==
X-Gm-Message-State: AOAM531Fhcjv/xTX7sLAOlqvsXLAQaM9ZqWjvmCdvlNNUKrT+3P1WDgL
        ZkbVwMcUZHtwFEaHV7MfL4KGrAhClgwi6H3v2VQ=
X-Google-Smtp-Source: ABdhPJwssd/KJvre4PcrvO5lyeS40W+eJskyKjsQ+YQ0Hp18+PIkagzhdO+SBcFsw7qwgS4oRlTaS9FU9ANM7+jwUvE=
X-Received: by 2002:a05:6638:24c3:: with SMTP id y3mr12066734jat.10.1627217207160;
 Sun, 25 Jul 2021 05:46:47 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1000.git.1626939557.gitgitgadget@gmail.com>
 <pull.1000.v2.git.1627031043.gitgitgadget@gmail.com> <eafb79bad62f13fc8fd70ba1dce3e8fbab870e52.1627031043.git.gitgitgadget@gmail.com>
 <xmqqh7glouiw.fsf@gitster.g> <CAOLTT8SggCXkajPG3om+6zhM_K8fyAb2qTBDj40JJa1pszshzg@mail.gmail.com>
 <xmqqy29vk3sp.fsf@gitster.g>
In-Reply-To: <xmqqy29vk3sp.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 25 Jul 2021 20:47:16 +0800
Message-ID: <CAOLTT8Sm=qs0K84C=yJOL7Ct5GUeHYe=ODXiGpwCSx11vgEnwA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] [GSOC] ref-filter: add %(raw) atom
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=8825=E6=97=
=A5=E5=91=A8=E6=97=A5 =E4=B8=8A=E5=8D=881:41=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> >> It may make sense to
> >>
> >>  * Turn atom_value.s_size field into ssize_t instead of size_t
> >>
> >
> > Will the conversion of size_t and ssize_t break -Wsign-conversion?
> > Although there is a lot of code in Git that has broken it, but I am not
> > sure if it is wise to use ssize_t here.
> >
> >>  * Rewrite (v->s_size !=3D -1) comparison to (v->s_size < 0)
> >>
> >
> > For size_t, this scheme is wrong.
> >
> >>
> >> Optionally we could introduce #define ATOM_SIZE_UNSPECIFIED (-1) and
> >> use it to initialize .s_size in ATOM_VALUE_INIT, but if we are just
> >> going to test "is it negative, then it is not given", then it probably
> >> is not needed.
> >>
> >
> > It seems that this is the only method left. Although I think
> > ATOM_SIZE_UNSPECIFIED
> > is not very useful becasue we already have ATOM_VALUE_INIT.
>
> Sorry, but I think you misread what I wrote.
>
> These three were not offered as "you can do one of these three, pick
> one you like" choices.  I meant to say "I think it makes sense to do
> all these three things, but the last one is optional, doing only the
> first two may be good enough".  As the second one requires that the
> first is done, of course, doing only the second one would not make
> sense.
>

OK. I know it now, I will do all of them.

> Also, you seem to have missed the distinction between _INIT and
> _UNSPECIFIED.  You can initialize something to (1) a reasonable
> default value, or (2) unusable value that you can detect at runtime
> and notice that it was not set.  If you called something to
> FOO_INIT, your readers cannot tell which one it is, but if you call
> it FOO_UNSPECIFIED, it is clear it is the latter case.
>

Thanks for clarification, I understand the difference between them now.

> In many places, we do use ssize_t for "normally this is size, but we
> can express exception cases (like errors) by storing negative value"
> in our codebase (grep for it), and I think the member in question is
> prime candidate for such use.
>

Yeah, as abspath.c:137, `ssize_t len` used to distinguish situations
if an error is
returned from strbuf_readlink().

           ssize_t len;
           ...
           len =3D strbuf_readlink(&symlink, resolved->buf,
                                             st.st_size);
           if (len < 0) {
                               if (flags & REALPATH_DIE_ON_ERROR)
                                       die_errno("Invalid symlink '%s'",
                                                 resolved->buf);
                               else
                                       goto error_out;
                       }
           ...

Or just read() and write(), they return is ssize_t too,
which can return -1 and set errno when an exception occurs.

Thanks.
--
ZheNing Hu
