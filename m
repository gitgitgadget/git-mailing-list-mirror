Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EB1C433FE
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 17:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237025AbiCQRqp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 13:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237015AbiCQRqm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 13:46:42 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0977DC12CC
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 10:45:26 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id o26so2349152uap.4
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 10:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iPCxLe8zwAQ5Rij+dYNRaFqoncKT787/GePhN6QnWxw=;
        b=b/uMcDWEP+e/+w8CG4XyxNUIxHUB30qBaGnI3ySrXgnqo2qKyOORGPLSrwOgz1OI4Q
         o3XvNghglgPRjywrIe2qfjUjvwixx3vyIpp3eZZLSdOF/W+TS8dUEOeo5T8DTVJpKvZ8
         kr2GWUOkiW8sxs7VwMfQiUwHbsUlK8bw+e4fucqilkxglhOIOLTB1Br+d3VzQ9LfVV8b
         +/cA1IEvjhLPNyubvJgctUfNiq7RBG0ljPHe4jUV8/3n18WGsodUb8nJocbrh5rx8Fg6
         WEuq4xSXmoxrKpZGY8syJ1dTLXNACAR5X6xkgAmNBLSS1HbONwPuboOo80PDJCcG7Rn/
         wY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iPCxLe8zwAQ5Rij+dYNRaFqoncKT787/GePhN6QnWxw=;
        b=tjwRs5w/Xuf7LASJhrf8OeZrMWIfLBVz7sKBDfPXD6rxSk2ys/noncwyn/P+K+AHNO
         xUAE9SZrOMiX0py1NeIgSafkk1SugqTsL6kwtu6J6OKuWxgIZXnnHE+geL2Jr7V5VIvL
         8EpO7N3z6Zan1FGVzTCYYrr+jS6+8DSds6edaUL0D+svp3T2LNt3Fk6D6IwYZVmfCcb/
         HxBIciOuDnaWtZ7Wr701bYrNGgfqc4rdLelql/XS/t8eRXqk1CEbjRwkgNazR+Gznqhd
         PeWwRUNiTR3EAIkbksGOjVqKxFxkM7Sye84KYt17K8Xk4IJjbZrSjYGpzbZrSCz8K0tK
         1yAQ==
X-Gm-Message-State: AOAM530ECOZbL8p8i8FhkrXJdM3b46NWdNyDIb3mA+yOgVwUqe639D0d
        4hPmb5kvGjFmVbyVfWh299w8b11VQ3Yr3yuKqBDxkA==
X-Google-Smtp-Source: ABdhPJy2KMl69BDvih6wqdALjowv2o++Wo7/64kfxiyjJc1EzVQ2IvyvqNckTAVXDDcgGicp2oVN2SJtLCm1SkPoJK0=
X-Received: by 2002:a9f:2b48:0:b0:351:a4ab:19de with SMTP id
 q8-20020a9f2b48000000b00351a4ab19demr2052117uaj.97.1647539125027; Thu, 17 Mar
 2022 10:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover-0.5-00000000000-20220317T171618Z-avarab@gmail.com>
In-Reply-To: <cover-0.5-00000000000-20220317T171618Z-avarab@gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 17 Mar 2022 18:45:13 +0100
Message-ID: <CAFQ2z_M7-D4ZCJbj8JituTbR3d7ocRHd=ObdZUnmE=WD7qW0cg@mail.gmail.com>
Subject: Re: [PATCH 0/5] refs: designated init & missing debug in ps/fetch-mirror-optim
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 17, 2022 at 6:27 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Aside: It seems that the GIT_TRACE_REFS facility has been broken since
> it was added, i.e. running the test site with e.g.:
>
>     GIT_TRACE_REFS=3D/tmp/log.txt make test

I wasn't aware that this is even possible. I've only used it with
GIT_TRACE_REFS=3D1

I looked over your patches and they LGTM.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
