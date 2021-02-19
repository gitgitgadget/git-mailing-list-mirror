Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772DDC433DB
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 17:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A46A64E54
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 17:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhBSRPQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 12:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhBSRPO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 12:15:14 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73912C061574
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 09:14:34 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id q10so11153535edt.7
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 09:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wn1JNO0igOYSfv3g9NJjl67n9v4mov9/xQaJw1sS/H0=;
        b=XJmOcmC8to/phe04sown3Lq2n97cISgANOBpZAEeiVWlUAAf42/maQQOm0nugmg8Ku
         sKDb6640CGDSsVd1z1WDxftsHpFgtfSVWqssBB8XvFvlAuMncjcxyc7QFkMBdtX7z/WI
         kYugmZREdbyS5XwFAOpsc9Fp7VDwUV2EbaPYKlU/DuZUsZ4crRRiRZUJPv763B7jN8kW
         usXHQoUdWcmSOg/Ph2/8/hb7ZuK47OmlQtWRw05Hq8on6YVfFNrAOTyzTuKrWSVhXmYl
         vFyTDyLYWwPPT3w8J11uv8U7PCR8K+w0gAdleLELx0QDAILvEP/LJvm2M755A8WrcTD1
         EU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wn1JNO0igOYSfv3g9NJjl67n9v4mov9/xQaJw1sS/H0=;
        b=HEB4CjILsL7V0SisYdFqTsASrxRDZcrfj9qX22mRaGUGcUDzVRm6UFjaa0UIaH6FyC
         gvwUjg4Lhg8NtQ/r26yHp6C/yuKFVo2kzRzMVgHwC40ZMNKZA5HpM4QagAHpI1gc3Rfw
         etXeQ6MKumm5UinauLZP51/kKylMfUNFFfdo8XVFFL3xlS1dZx/Yw1vEpABJuTqIH71w
         dFoJ+EP1aBO47yzl6AHCi1ihUke+S7t2N3Zhx6Nwzh1nVV10k2T4G2rf32ZMzPUkWbjj
         Dhq3YV20k5pCYOHuPeVxaLa8ynccTrTKpTOlBloW0hxPQ/TmyTEbjpDG7mhdA8o4WMxq
         ahdQ==
X-Gm-Message-State: AOAM533bnl+ZMV6uPYi6UrNEpYV0/11Ttbw5lQd7HtMOyQLjJDXK1E1d
        5aTrHaUSi+Vxn7qRf6BrAHz1ApDASYv446YD/iB9TlAN9WE=
X-Google-Smtp-Source: ABdhPJzpLra+CtuBkkZzaGCTz3+3D5WsaADIBq25pQNOZcA0JjPp/veTu+12vd30tLVA5fWCJYca8SJxgjJHgD5L9ho=
X-Received: by 2002:aa7:da0c:: with SMTP id r12mr2051203eds.362.1613754873233;
 Fri, 19 Feb 2021 09:14:33 -0800 (PST)
MIME-Version: 1.0
References: <20352639-deaa-0e3f-c99e-9bde937d67f9@gmail.com>
 <CAP8UFD1VaOBWcf3RQTc6OdmkUZCOOOO0mubRoWAvao6uNtNkgQ@mail.gmail.com>
 <CAP8UFD3vDfrQnxSUcUoZHx3TqdxyrUeviT2zfjCcZHF-t-uK9A@mail.gmail.com> <CA+ARAtrSM3VT-j8n-c26r5eKpyfKjon=Du6H9-WfwNW2ve38XQ@mail.gmail.com>
In-Reply-To: <CA+ARAtrSM3VT-j8n-c26r5eKpyfKjon=Du6H9-WfwNW2ve38XQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 19 Feb 2021 18:14:22 +0100
Message-ID: <CAP8UFD19RbsreLPd0eOBrwnpc0OAs8ODcLSE_d1Z+tqTd1USoQ@mail.gmail.com>
Subject: Re: Git in GSoC 2021 ?
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 19, 2021 at 5:30 PM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> On Fri, Feb 19, 2021 at 8:26 PM Christian Couder
> <christian.couder@gmail.com> wrote:

> > So I just filled up the forms to apply. The information I used is in:
> >
> > https://git.github.io/SoC-2021-Org-Application/
> >
> > I also registered myself as an org admin. The only issue left is that
> > we need another org admin, so I invited Peff and Kaartic. (You should
> > have received an email.) I hope at least one of you will accept,
> > otherwise please tell us soon.
>
> Thanks for the opportunity! I just accepted the invite.

Great! Thanks! It looks like Peff also accepted the invite, so we are
all set now.
