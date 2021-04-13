Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A28C433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 11:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A5AC613AB
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 11:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244126AbhDML7O (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 07:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240873AbhDML7N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 07:59:13 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A59C061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 04:58:54 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id a62so3571578vki.0
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 04:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fpdyIn/t3HqD0B6pk8yS03S2iIOsXtC3IzpZBDup1pU=;
        b=QkOQplIx7Cqx4ZOw7TwpXULT44PmUggdO5ODY1yDRekbQdEQL1A+8dy8rtPiOS0hTm
         ez0w+cMg48lhoOnGVkyW8qf3YG8CNRIj7D/+TtvyIwqWcNJTjVseBD0tuLk6WwYP3b8z
         yrQ6obN1xM1BHjXmlw3Qx5ZwvZo/PtKKCN45pSEI8Ci+sqTljjLd/HSm6FdVxOC27W2b
         kwDZGq79uzS/zd1wljjUozzMJtwaYCpKGhDbZddEMn+J9b00S/iHNyTp0VsIiWQlUCbP
         /zaFiWOphhoIJXfn2ASEZYgLCarGfHZM1mweGFKFGItwrCrML0aRHmSmIICbEFP0O1eC
         xtkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fpdyIn/t3HqD0B6pk8yS03S2iIOsXtC3IzpZBDup1pU=;
        b=CnsnB0RACndcu/6+MsdtQFSDCKs2plSTMaUS6i7DVHQJjXHBcBItKZpKXnpt1jM5iX
         DYSsJJCss0UDz/yNkhCxsAp82AIhKerx5Mu2NMz6hdkr5x5OOsk+abz+z7eJKGk7xIMI
         0Jn4M16UzAt1ztpMAYdMkCVOYUw8Ty6Fw0LmPjBOoKegEojov7+3bUGYPhyewmkC12ex
         MPE2NghZIx64RlDAcE+jloqOml/XraBysjBN9VH8OsMeZRJoK0YDPSlxjidM4qaDSbtD
         xMdpBSijIa3oyehtdxcPU3jb+KtaQCqOt+UggDyd9z/sXRmrKSkac3tMH5c92yx9kRDU
         ozDQ==
X-Gm-Message-State: AOAM531pS8jzBWk09htgP/h2VPEIK/jZBnu+W08XJB5PgZWqkvS8cpAw
        wZX3Rt/xFpaKmGlGgd0QAMkfJZOExGi5yYyPR+Oxag==
X-Google-Smtp-Source: ABdhPJymzwX/g9IFUF6lW1c1gcPzXIYVdwkMtnnk6AmYzz4XS9+oTpMTZgiOnVJslWFtkl8V2K9RKl9i+Wbe/lvkBaU=
X-Received: by 2002:ac5:c185:: with SMTP id z5mr10811821vkb.19.1618315133221;
 Tue, 13 Apr 2021 04:58:53 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1002.git.git.1618255954484.gitgitgadget@gmail.com> <xmqq4kgbb2ic.fsf@gitster.g>
In-Reply-To: <xmqq4kgbb2ic.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 13 Apr 2021 13:58:42 +0200
Message-ID: <CAFQ2z_MnZOfo4Bt6SsRJnL+F70r9wr_jYSf2KGvcvyX-8PfVRQ@mail.gmail.com>
Subject: Re: [PATCH] refs: print errno for read_raw_ref if GIT_TRACE_REFS is set
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 12, 2021 at 11:45 PM Junio C Hamano <gitster@pobox.com> wrote:
> > @@ -251,7 +252,9 @@ static int debug_read_raw_ref(struct ref_store *ref=
_store, const char *refname,
> >               trace_printf_key(&trace_refs, "read_raw_ref: %s: %s (=3D>=
 %s) type %x: %d\n",
> >                       refname, oid_to_hex(oid), referent->buf, *type, r=
es);
> >       } else {
> > -             trace_printf_key(&trace_refs, "read_raw_ref: %s: %d\n", r=
efname, res);
> > +             trace_printf_key(&trace_refs,
> > +                              "read_raw_ref: %s: %d (errno %d)\n", ref=
name,
> > +                              res, errno);
> >       }
>
> OK.  Between trace_printf_key() and the return of the call to
> read_raw_ref() method of the ref backend is only an "if (res =3D=3D 0)"
> condition and I do not see anything that might clobber errno.

I don't want to bet on that. Let me send a second round.

> I do wonder if we want strerror(errno) instead of the number, but I
> can go either way (it's just a trace output).

For tracing, it would be most useful if we got the actual symbol (eg.
ENOENT). Is there a way to get at that?


--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
