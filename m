Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC36C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 20:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 451C561CA0
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 20:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhGFUtf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 16:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhGFUtf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 16:49:35 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD7BC061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 13:46:55 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id x22-20020a9d6d960000b0290474a76f8bd4so93732otp.5
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 13:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=BQjOiHK0JxAMVduyeaxNlLGZYXhOtpJ9btT3mjIqTuA=;
        b=Ec8DbupSnkAdH5OQtwebUXUuGaM4bHUDTjanIv/7KKPPM1JZQD7Xd/wcl5sWFdmFvZ
         CC8G1YlmOR0ugdhVPlMkkBhDI+NOzbZhU95ua/uRiTtUJzkBXXnyoeMtX2+RCngKDEh5
         Rjst+O5Iq/DYRSMZlcdx7rYgWfDS8UOJMFN2sebWS8UGKs53PiKJKTYNBFdaGn/mldVG
         Sw7VT1U66oS2MCUW+yhxC2ngoxnwheiu4QslBACkCmt3nxheuOJB0qx0PLbiIaOS0tje
         T8qllseddoRvVMBebLOR2T1v5DhrE3DG1P7GgYG02gqmr23POG5YGl2OWoN1WQrVBMVO
         iJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=BQjOiHK0JxAMVduyeaxNlLGZYXhOtpJ9btT3mjIqTuA=;
        b=LHwxs/DSYngHsn+O/2mJSGs7tjb6bmSoGVRgAOXzZ6snb5uRuIb8C+/WWM0lavWeu7
         kkepobesNh+GRXvzBib3beynl4QtwhC2Yq0PbjQWW+N7sczPyNYD32UN8x5zovtZ/8hy
         TJQOa2Aym00iVvTyZTuycWm/Ild95e/zJHLjGVCsv293wbi44uFLdC0PjrfSiyXPlZuc
         +rPcJWHfuFkjkYyAufjXyQsnIDpeyXBgPXlt8yz8qjwafPAhVgcKjzIOFQCdNMpkC42L
         2r5ZBikq820DBJHoP9Y/fJG/e/S10mYRKk8Bn03gvT1X++tlkNIDKl+EcB6iW8JzFMio
         QKbw==
X-Gm-Message-State: AOAM5332/ykf6V01FS3qkWnv9IeD+pHWxfSh0lDPDvcRIY7pG7RAL8MP
        D8adQzzHCbE1corFiWoWZ6I=
X-Google-Smtp-Source: ABdhPJwKz31/BWQUF21aCOqWigOfRkTDYJ+c/Hzqb2IoEb4k/sjXrFKmQqQzb9ys66tL9GRvOoSUXA==
X-Received: by 2002:a05:6830:10d:: with SMTP id i13mr16640994otp.66.1625604414558;
        Tue, 06 Jul 2021 13:46:54 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id z34sm1148636ota.10.2021.07.06.13.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 13:46:54 -0700 (PDT)
Date:   Tue, 06 Jul 2021 15:46:52 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Alex Henrie <alexhenrie24@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60e4c13ce851f_1c428120869@natae.notmuch>
In-Reply-To: <875yxn5hh2.fsf@evledraar.gmail.com>
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
 <20210705123209.1808663-11-felipe.contreras@gmail.com>
 <875yxn5hh2.fsf@evledraar.gmail.com>
Subject: Re: [RFC PATCH 10/35] update: add --ff option
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> =

> On Mon, Jul 05 2021, Felipe Contreras wrote:
> =

> >  --------
> >  linkgit:git-fetch[1], linkgit:git-fast-forward[1],
> > diff --git a/builtin/update.c b/builtin/update.c
> > index 1a69896aa8..34681fe21a 100644
> > --- a/builtin/update.c
> > +++ b/builtin/update.c
> > @@ -7,12 +7,22 @@
> >  #include "run-command.h"
> >  #include "dir.h"
> >  =

> > +enum update_mode_type {
> > +	UPDATE_MODE_FAST_FORWARD =3D 0
> > +};
> =

> Nit: If the value isn't important let's leave it out,

Yes, in one instantiation of the series it did matter, but not in the
current one. I'll drop it.

> also if you add a trailing comma the subsequent commit where you add
> another value is less churny. C supports that just fine.

I know, and I actually prefer that style, but I've seen the comma
dropped in many instances in the current code base. I was just following
the current style.

But if you prefer it as well I'll add it.

-- =

Felipe Contreras=
