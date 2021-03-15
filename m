Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF879C433E6
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 11:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4C3664E81
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 11:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhCOLdD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 07:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhCOLcq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 07:32:46 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37737C061574
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 04:32:46 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id f73-20020a9d03cf0000b02901b4d889bce0so4937319otf.12
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 04:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4ytkhs4iSx2hVSBYLC8QzW1uvkOMEhcN4HT0z4Oi8eE=;
        b=QMchMTPF6XAbiyDtqYyIlT3JOeGBeWg6jP3NIJjz3i9g7MNBu/sAoevwWK5qJ12vBv
         jz4LWhfrU6gZEgOglebH2ZOswe/F9KcJpVBpfA73RO/gfDc3LhWGBePpAj6SUDyzN0G4
         XUiVxAd5GKtqjsO+E191LbrDRfUFoDgL74h2L96miawl0y0D5rTo+tWbTbNshp68Muv8
         kj14qbW3ske+DZAv0ebrnZ5YSXQZQC7liot9zhm06iGyqSJBWiBpJXIvKbIHM8/AThKW
         v40gY9ZfsWPKA85D3G3sg1jbk7xF2ZkiJQHnXZ88MxyIYjvaFuke5Jw2Mb3PJPQgP4wU
         ea3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4ytkhs4iSx2hVSBYLC8QzW1uvkOMEhcN4HT0z4Oi8eE=;
        b=bmXVUqbzd/PQkR0hJWkDfvRq1viERIPp6l5+6tPTLy1Rs4X4IeDIRoEEIVB6RX1TOw
         j5hD0YYLc1LEBQx6RX7hvAG6yeZjRWdw5/qhlFOtQv4aO3YzkknwsNX3f2Ha4oFNPpZN
         /rh2ySrDb+nofBLFCs5xyaB2fk2LIq87YWcjfk0idPTWzysDaeFiCT8m5DIQHS/NaA+R
         xJs8Icy+P2xAG6UbiIaJponhRk6ABCM2ELF4viQiS7gff6sqcYs5arZzxWJek6Fx8OIn
         ZMIandgQI5WmxhFflGHULLT3G2b0uXcFmmYAbxS8+nANGcF6LQOSlX/slW48bEyllCWq
         szrw==
X-Gm-Message-State: AOAM53322p0l5qDUupB+7OWOuhiAG1ifQyoacrbEzLE0iy4YyoBuMmHA
        HQAHBh1UVz1UACQpGBcVcliqMuzHihEN43PHXzs=
X-Google-Smtp-Source: ABdhPJxsWBlVPZKGpxPnCzHOH7zIUcSPDQAdi+0eZntCRTYMU05ulp6GkQxeZKiSCsVteufSxcz9v5pg4S3JizGrw+g=
X-Received: by 2002:a9d:6ad6:: with SMTP id m22mr6157705otq.160.1615807965662;
 Mon, 15 Mar 2021 04:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <pull.901.v6.git.1615790151073.gitgitgadget@gmail.com>
 <pull.901.v7.git.1615799304883.gitgitgadget@gmail.com> <CAP8UFD2CNAW4o8BF8NLA0pwWzNmBwZJAP7L5SGSib+LcVbSLBA@mail.gmail.com>
In-Reply-To: <CAP8UFD2CNAW4o8BF8NLA0pwWzNmBwZJAP7L5SGSib+LcVbSLBA@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 15 Mar 2021 19:32:34 +0800
Message-ID: <CAOLTT8QTxnykacdDaMjZMkEqTHPSrPz6HH-bSgbECo5tUgf5Gg@mail.gmail.com>
Subject: Re: [PATCH v7] [GSOC] commit: add --trailer option
To:     Christian Couder <christian.couder@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=
=8815=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=886:14=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Mon, Mar 15, 2021 at 10:08 AM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>
> >       + if (trailer_args.nr) {
> >      -+         static struct child_process run_trailer =3D CHILD_PROCE=
SS_INIT;
> >      ++         struct child_process run_trailer =3D CHILD_PROCESS_INIT=
;
> >       +
> >       +         strvec_pushl(&run_trailer.args, "interpret-trailers",
> >       +                      "--in-place", "--where=3Dend", git_path_co=
mmit_editmsg(), NULL);
>
> Actually I don't think "--where=3Dend" should be used here. "end" is the
> default for the "trailer.where" config variable, so by default if
> nothing has been configured, it will work as if "--where=3Dend" was
> passed above.
>
> If a user has configured "trailer.where" or trailer.<token>.where,
> then this should be respected. And users should be able to override
> such config variable using for example:
>
> git -c trailer.where=3Dstart commit --trailer "Signed-off-by:C O Mitter
> <committer@example.com>"

Thanks for reminding, generally speaking, we will put the trailer at the
end of the commit messages.Take trailers in start, this should be
something I haven't considered.

I notice another question:
if we commit this again with same trailer (even same email or same commiter=
)
`--trailer` will not work again, because in `interpret_trailers`,
"if-exists" default
set to "addIfDifferentNeighbor", I addvice enforce use "if-exists=3D"add".

Thanks.
