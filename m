Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B419DC432BE
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 13:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A48E63283
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 13:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbhHPNAy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 09:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbhHPNAx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 09:00:53 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A0DC061764
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 06:00:21 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id y14so7505850uai.7
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 06:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iFi2KOnfOaS1/PD5DJDhzI6I40rrdGJppA+v986uy0A=;
        b=PiP99gE1Br+4T5g4388NdXcy9mUiw2CgiHunN7yhVmiVQBAcTTWTatCBo95vFe3xac
         knh+Tx4ntDj2wjDe67un5M3KTivQCGEu/kKpljGbRW8AQVpdeEKvLfzvLWz20ApkqMGz
         5/fuoS25Xb++4G7yoQ7gq0IjNB1p1FVlCXfEdIk1lAXX3BSmmNoYW3HQydSIWZV5sO4k
         ijSsLpPkw/P8Qk8kAsjhw371ekDlfwyvPEKvWM2WDMzWWTMqlkC5yKjg9umNr7UNLJgI
         RgzULQTenR0i3lgTOqJMkCTi/cT5b9dLXnBpwEz6UhJGHvBc1mV6zaF+EdbvwFTcn0lU
         v+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iFi2KOnfOaS1/PD5DJDhzI6I40rrdGJppA+v986uy0A=;
        b=NO0qkPqiIKLWimky4SWW4NdBCv/MO4jKgS4MllDQlp4WZJp3aWXxH23G1S/72dLAAb
         0aQqdY8DX3nXJKa+yr8XcQSQQuACy5osS6lcfvPZdI0GhMyUrFn9RMLtemeiR8fY4haq
         mR2BcP7jvuKEppDxjx46pRtMGhGVbLT3F9o3oO/Tu/ighs69zvEu+e4wIqdhJgwwxlmj
         s+MxehQRjUMR2Ayjz/Tgt1i8jsmFYRZliGyzzZ+pCxpN33OG9BB2yKIFxClc+ARZO6mK
         NpqJOnK8XuuoAZk6ZBy9PPs45PMUQx/uUq6ukY2RkwlWJ6X3xIaIDw2P+vEkYJD+LhGk
         aqbA==
X-Gm-Message-State: AOAM530dZSfaaAPmDsY8PMcPlxEDIX7fk/d3OkuNvJypMGzZUtRkcv12
        hG/4t+XcDZlGICJT6TYVUxsqFqFaV8OEL4pOSCUceg==
X-Google-Smtp-Source: ABdhPJyBMEgn2LIF1P7llegOw0p30KtTaqGmTjHXURnqVop2OoQLGTarYpkmVS3iPZwe5ZUBnVA9ArCM9Dma5aajbrM=
X-Received: by 2002:ab0:76d0:: with SMTP id w16mr8693534uaq.15.1629118820748;
 Mon, 16 Aug 2021 06:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover-0.7-00000000000-20210716T142032Z-avarab@gmail.com>
 <cover-0.7-00000000000-20210720T102644Z-avarab@gmail.com> <patch-4.7-c54fb99714a-20210720T102644Z-avarab@gmail.com>
In-Reply-To: <patch-4.7-c54fb99714a-20210720T102644Z-avarab@gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 16 Aug 2021 15:00:09 +0200
Message-ID: <CAFQ2z_M0LNmZn2xW_GWdwZOCi20xc9t3EnMzMzHP8ZcmWrW9EA@mail.gmail.com>
Subject: Re: [PATCH v9 4/7] refs: make errno output explicit for read_raw_ref_fn
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 20, 2021 at 12:33 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> --- a/refs/debug.c
> +++ b/refs/debug.c
> @@ -238,7 +238,7 @@ debug_ref_iterator_begin(struct ref_store *ref_store,=
 const char *prefix,
>
>  static int debug_read_raw_ref(struct ref_store *ref_store, const char *r=
efname,
>                               struct object_id *oid, struct strbuf *refer=
ent,
> -                             unsigned int *type)
> +                             unsigned int *type, int *failure_errno)

the code in debug.c needs some tweaking:

>  {
>         struct debug_ref_store *drefs =3D (struct debug_ref_store *)ref_s=
tore;
>         int res =3D 0;
> @@ -246,7 +246,7 @@ static int debug_read_raw_ref(struct ref_store *ref_s=
tore, const char *refname,
>         oidcpy(oid, null_oid());
>         errno =3D 0;

this line can go

>         res =3D drefs->refs->be->read_raw_ref(drefs->refs, refname, oid, =
referent,
> -                                           type);
> +                                           type, failure_errno);
>
>         if (res =3D=3D 0) {
>                 trace_printf_key(&trace_refs, "read_raw_ref: %s: %s (=3D>=
 %s) type %x: %d\n",

A bit below, failure_errno (rather than errno) should be printed.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
