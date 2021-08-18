Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86486C4338F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 10:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 601956103A
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 10:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbhHRKjw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 06:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhHRKjt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 06:39:49 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA78C061764
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 03:39:14 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id bb10so547688vkb.9
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 03:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c05c2VA2MudYLrhVOMigv+VG9dbR4PYlYP6fL1Dj/YM=;
        b=rgdSnb/j0A+vO6m5/4qP5cqI5I48XNnx9tXw1SwtSl9EYIyoUWbvPEIbPh9lqszjL9
         j7Vdm6x5QjbxWNQQo36P1b4dpj94I7mpXhTnQBl1YjQIDiPeITgM6GMG0oJj4tsRpgWj
         DoCkGMyAHYft4f8QDVx6YcpzwTS6XwUGdQE8mNBAAcg/pATGqnb76MzLB4+WsBBasr+p
         S+pwAm4/+V3teamhunpdYO1e9YJiHEUIqeCNxCz8KDXb0iuRC2kzP4yd2qgM2IwdBA22
         sc5kTWTVv8QyDai+mu3flDxN+2MiMEMsISgxNRDYp3cXuSQqVF87/VkGrw8pCrWQQxKm
         Hjxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c05c2VA2MudYLrhVOMigv+VG9dbR4PYlYP6fL1Dj/YM=;
        b=hyXEtDSZJZlNl7Zx2nnR62VzPk/F96lg9OCdzZL5NPSEHWng+GMMWyVh2CKGkpKvX8
         Hm5X3+jAbwMQwHYmiIqLhrQlu3x88EwKlZg5NcyYxOVT2q0rdBHuey37auPVCJOY2of8
         NkpRUlwfznYwYp9/jDFScn3NENrFz/pV5zJsHb1FD+1BjdzlJ9r9zvP0dYawIzKAZkZP
         9OMs5SHq7L7g/AxAPklkZ2t4H0sT2TnDytFWufS0nSYlErPfljgg5buv8sZGxeCS9KVd
         i+SrH2qK8Ipd7DzFUcs8GM98G3HOF4bfsgxPeryloT9igf4mS/Iyogq87zo4RNB2drrH
         FY/w==
X-Gm-Message-State: AOAM533otL8P7ZWXE/sPREtdiROn1v82/6VaHXqaYm+pMttrN6WC2bhz
        frWa8PIzFjh3s6yh7ovHV9qyQz6/62Kl3THqLbrmcg==
X-Google-Smtp-Source: ABdhPJzxsrb6wRS7m/gJ0cxeNsQ/j7DwNTJuEAm2VztBDbwYR9lkTkG5sfnAvfqQLWRdgo3ZD5OGrDUFjqCIV+Lwcig=
X-Received: by 2002:a1f:a2d1:: with SMTP id l200mr6235705vke.1.1629283153495;
 Wed, 18 Aug 2021 03:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
 <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com> <d92338467d66fcfedd57f209c97a798e9920d1e5.1629207607.git.gitgitgadget@gmail.com>
 <e1959ed9-beed-f110-c9a8-da8ed352dcda@iee.email>
In-Reply-To: <e1959ed9-beed-f110-c9a8-da8ed352dcda@iee.email>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 18 Aug 2021 12:39:01 +0200
Message-ID: <CAFQ2z_P1EnNYPxiTZ8GeTTVsJaa0S0vz5M4kqu7Kf3yGbUt0kQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/25] Provide zlib's uncompress2 from compat/zlib-compat.c
To:     philipoakley@iee.email
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 18, 2021 at 12:14 PM Philip Oakley <philipoakley@iee.email> wro=
te:
>
> On 17/08/2021 14:39, Han-Wen Nienhuys via GitGitGadget wrote:
> > From: Han-Wen Nienhuys <hanwen@google.com>
> >
> > This will be needed for reading reflog blocks in reftable.
>
> How large might the reftable become? In particular will it exceed the
> 32bit Long limit on Windows?

A reftable file is organized as a sequence of blocks. Each block has
max size 2^24, and the zlib compression is done per-block. So zlib
should not introduce a new 4G limit. The intra-file offsets for the
blocks themselves are encoded either as varint (index values) or as
uint64 (file footer), so reftable files beyond 4G should be no
problem.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
