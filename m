Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9342BC433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 14:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238406AbhLUOYe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 09:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238465AbhLUOYb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 09:24:31 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03DEC061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 06:24:30 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id u1so5231086vkn.10
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 06:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iQnSoTPgwaP49GnKquCdHSxg7yFvIPgwK1NPBubdxBQ=;
        b=g6IAvOLYDFUZY8+pmIWmbL+PEs6MQ9ncaZ4NmhoKSX4Fm2PIGNs9YFb/KuNzEDS2Og
         csA3GzLz0xob/vRKH5yuzPrqI83zy/VLdhUwW6HedX2vxhzOKG/tXsdlFlF6NFRaHMIp
         bMyq/EmBD4xNzy2TOb+GAXJEYUspf42JUys9PAaCtnHSdVA57MQUuRvaB3fy9/6UL9bb
         tf3zZWYJlIj36itv1ioPVjBFwVU9oSKtYCTM3XAhsNPQ2jFRTWDQXDNzJ2GnLNTMzqGC
         wBSrbQ0tdJXkD+Ic+K92xlqTqKXO0XbM3SK74BZTJzVYqi5DkDfxlJIbdRmV/z0heTvL
         PoPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iQnSoTPgwaP49GnKquCdHSxg7yFvIPgwK1NPBubdxBQ=;
        b=j0cFjBM1N1vH0zLwr0aImKExkL/YIcyvrsz70Tn0vl0WOHnuMtaWS/M1pKaealpk8v
         WQT0x8+rEfzR+/d8K+BnRrvBs/J3bE3Wb60dWuy1Ksy0tB50iM7t7dORcCG9T0IVk6mP
         70kFmhugXrnX8cUl3H7pTpIFR3g2LcRvV2uuJ4LKMMmO03CjXu83LI091t4775glvSv+
         eeOhro4dKXNwqcLFB1ppWZjZ73Et7bRhL7MXEc+hXmLJVJlPOnV1Lzf3Mj12scQFrS6O
         SInFm8R4GnUz1G28eCGeCkr0uddHq8ND6NaJM5EcgDs+xo132ViuRYBVNScHn3GWSdB8
         4bHQ==
X-Gm-Message-State: AOAM533sPoRqIfgX9jvxMhbv876ScwgudCB8muJsPwjqzSmjORZtIHv4
        qJBuEUrMleynKm13H0nuAq4iNg1u9isdKIMUKIM1DA==
X-Google-Smtp-Source: ABdhPJxEv0MiqQGk+1Tpml4317P2LrMJ8KMIMynaEV0kqFPk+99K9L1k2Sk+g90601fl28EPwQV8F6nt3H88YSr2Mf4=
X-Received: by 2002:a1f:a188:: with SMTP id k130mr1343283vke.10.1640096669620;
 Tue, 21 Dec 2021 06:24:29 -0800 (PST)
MIME-Version: 1.0
References: <cover-00.12-00000000000-20211130T213319Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20211216T134028Z-avarab@gmail.com>
In-Reply-To: <cover-v2-0.9-00000000000-20211216T134028Z-avarab@gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 21 Dec 2021 15:24:18 +0100
Message-ID: <CAFQ2z_McOfm545Xd8hF7YDgzyOjDmcGxpWZ6pQ-yaKAEWMMbgg@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] reftable prep: have builtin/reflog.c handle "--verbose"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 16, 2021 at 2:45 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> This series refactors various small bits of builtin/reflog.c
> (e.g. using a "struct string_list" now), and finally makes it handle
> the "--verbose" output, instead of telling the files backend to emit
> that same verbose output.
>
> This means that when we start to integrate "reftable" the new backend
> won't need to implement verbose reflog output, it will just work.
>
> This is a sort-of v2[1]. I ejected the changes at the end to add
> better --progress output to "git reflog". Those fixes are worthwhile,
> but hopefully this smaller & easier to review series can be queued up
> first, we can do those UX improvements later.

Thanks for sending this.

I looked over all patches separately. Overall, the series looks good to me.

> int a one-line terany instead.

ternary.

> "don't do negative comparison on enum values"

I would describe it as "use switch over enum values", as this doesn't
involve negative numbers.

> collected.reflogs.strdup_strings =3D 1;

This puzzled me. Why isn't the init done as _DUP ? Warrants a comment
at the least.

>  .. goto expire
> ..
>    return 0;
> expire:

(personal opinion) this is going overboard with gotos and labels. Either

  if ( .. ) {
    expire =3D 1;
    goto done;
  }
done:
  if (expire) {  print stuff }
  return expire

Or wrap the existing function (without changes) in a callback that
does the print for you.

your call.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
