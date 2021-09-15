Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94F1C433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 07:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CED7060F25
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 07:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhIOHgk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 03:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbhIOHgh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 03:36:37 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117C9C061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 00:35:19 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id f18so1869410vsp.2
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 00:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x9UDlRtqvQ0kFS7AbFOCxQIe7uVxCM0tjQorEKX7GeM=;
        b=RDa7CekcEeEodrTRlrC9eSltH/NuGhUd1rK9bY7I7kxr1B96flAN3yBlNXXGqvsmgP
         zs0bMunuj2ZssANAXQdHyhUHKtHCkJfSZYOGXZn5deMRDLgUKWif4a1hcA4jUCGXut9b
         ooqe15DUu9VuciHGcMqX1QaZO8WW3snTPGVzYYiim1eOCf2B7Y/NiSEplw6Tzh7NaXVP
         OF3343dha0hfcZOSjFqiNoJZ/UgvjcEAeUR7DTUWC3tWb6hUsDhpxM3q58qURQ1BVqEm
         sOEG5QFF2c2RCAO02KHbtWnWtd9Gj3M6XyUZX55pmOh1E4QDut3jZQltcKnrGdb59dhZ
         lBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x9UDlRtqvQ0kFS7AbFOCxQIe7uVxCM0tjQorEKX7GeM=;
        b=aJm4wT1VgwJySdV/RykjOuUKALLjHobgr22/pvpaHqkYy+yxB/KaQrdCiYGvhM4cN6
         0OkeP1/GUZVrzcIOjCUxrFjJ38wUmXlYGBTPJViVKUNaOB0LLdiaxG6Rnm3M2DXq2Tid
         SsKdaGZC+/t8nkczLivrOOn/uZ8j+YJlEdaHp5Z6A9OL2MoEyyd+14pqc4UOYKqbxQY2
         ez3qv5lAiUQZoeuCT69oovTRZz/nMPJDr56pNZWpDyIOd7GkNC3ENL2sALcrknhTy1BH
         AN/Jols5qyPeoeK4eHOGEKMi1roTyy5vL+qO+D3xUUfkEpVpeSGrcUXlfI1qfPS7c0xK
         /yhw==
X-Gm-Message-State: AOAM533eipJ2eBqwimcFsVhvHFwPID0pas9jvcQjGT82eozok1FScsrT
        QDBPoFgZYfEo5IN0/QQ9vxeGfiWAQsFsHP8meo0K5g==
X-Google-Smtp-Source: ABdhPJyYfB8/eipofrK0CBa8gUcfcS61vEWFyPIsvRS3SUf5vmqmsUAym3Q9eBPZydD5KG1CtE3UHpcm858/fkkYI+E=
X-Received: by 2002:a05:6102:322f:: with SMTP id x15mr2232049vsf.32.1631691318095;
 Wed, 15 Sep 2021 00:35:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAFQ2z_PKKZJY1kC1QJo8Zwq_yNh5QNGc3S5bq1jBfSfK3vQwRQ@mail.gmail.com>
 <20210826222439.3915402-1-jonathantanmy@google.com> <YUElL3RI0VTnjE5C@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <YUElL3RI0VTnjE5C@chooglen-macbookpro.roam.corp.google.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 15 Sep 2021 09:35:06 +0200
Message-ID: <CAFQ2z_ML_g6DTiG92srq8UCCu_D8bi6z1mP_znt24TJagVfi2g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] refs: make _advance() check struct repo, not flag
To:     Glen Choo <chooglen@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 15, 2021 at 12:41 AM Glen Choo <chooglen@google.com> wrote:
> In the current state of affairs, the files ref store and the packed ref
> store seem to behave as a single logical ref database. An example of
> this (that I care about in particular) is in refs/files-backend.c where
> the files backend validates oids using the_repository's odb.
> refs/packed-backend.c doesn't do any such validation, and presumably
> just relies on the correctness of refs/files-backend.c. I assume that
> this also explains why some functions in refs_be_packed are stubs.

The loose/packed storage is implemented in terms of files backend (the
public entry point) that defers to a packed backend in some cases. The
latter is implemented as a ref backend, but for no good reason.

> The answer to whether or not a ref store should refer to a certain
> object store seems unresolved because a ref store is trying to do two
> separate things. Perhaps it is reasonable to associate a ref database
> with an object store (so that it can validate its refs), but we would
> prefer to dissociate the physical ref storage layer from the object
> store. (I'm paraphrasing Johnathan Nieder here, this isn't an original
> thought).
>
> Perhaps this is a question we want to resolve when considering reftable
> and other ref databases.

Work on reftable shows that there are more egregious breaks of
abstraction boundaries. For example, there are still parts of the code
that equate

  (file under .git/ =3D=3D ref)

you can find a good part of them if you run GIT_TEST_REFTABLE=3D1 with
the reftable support switched on. Another place where API contracts
are unclear is resolving symrefs: on first sight, you'd think that a
ref backend should just provide storage for a refname =3D> {symref,
commit SHA-1, tag + commit SHA-1} mapping. However, in some places it
is currently necessary for the ref backend to resolve symrefs. You can
find these places by grepping for refs_resolve_ref_unsafe() in the
files backend.

I think Jonathan is right, but I also think that teasing apart the ref
backend and the ODB is premature until the ref backend itself is a
strongly enforced abstraction boundary.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
