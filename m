Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48A1C433EF
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 22:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245319AbiAFW5p (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 17:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245298AbiAFW5o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 17:57:44 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B428C061245
        for <git@vger.kernel.org>; Thu,  6 Jan 2022 14:57:44 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id d187-20020a1c1dc4000000b003474b4b7ebcso1323263wmd.5
        for <git@vger.kernel.org>; Thu, 06 Jan 2022 14:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=C4WFWYUXhFHIWe59R2bsmj934LlsbMsCpG9V47l11k4=;
        b=D1t9mIv46Lkd0dtNzBkNp3dhSmxrZTT/XiKoNyJ8iN6BDD1yxyo4wcScTzZnt8soOV
         n5oOjFkqg4PP//FUbuqHgnnCh4C6gHfrh2bd6SExwx/UsyVj5vhqWUETuyAAzzpLvr16
         rmLoPj/BiNT5NKBPS3PLJpeus5vMaZQL5T5koXMaUUeye0mJ5Wa90wIT2Xq7Jo3fsUYt
         eT7ic8hgATYi2YKXVfWQN6RmY+QGavwJCC2slSDYF8dAjLL7v7xYhuIoVdHbpRxwfoSY
         2DBShcqH6nu+UB3tC9A2GuIKzgbmSV8BRcwvJ9cvuNeIHw+rz2v1tM0ea1Js5IF3Q3Nl
         7ENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=C4WFWYUXhFHIWe59R2bsmj934LlsbMsCpG9V47l11k4=;
        b=VE6ZEXgqm+Q86lOV/+vUda+/Nw4ZH8P9dkf4oaS+bAaZORkUHhYTZ1Xr+t20to4XeY
         vUNdMaX6wdskn5MpH1k8J5uiUD/1OZ5VYpwv4PFYwDtyZqWmg9hGAkMZlU2fHohyORrB
         6XtZGXzaBeyA++d691Wz+0/1uDQY83IXRp20AVCwhv2v29T0ZhzHVMrow2fgcOOcQj4v
         ZU2VVCoiYcxJwWP0cXt1kRAmjECtjc8ihqzO2LmH501XUq08ur/BDeO2n6EO7SB+BkAK
         E6CRllnxCIuoFAYwCfEQy3yxvIij2Zzi8rDmdQW41ApQf09ZyT3o8ktxdNvKQNO50jO2
         ZYyQ==
X-Gm-Message-State: AOAM532Br3rtIv19aszRl9gtp9Wp17Opcfc1+lWOx4c4Y+m0i1G2RRyR
        Mj/NWeCJPThdeKir6Tah+9P+z6XJthTtrWIu
X-Google-Smtp-Source: ABdhPJws/jvgYm5vlrG+lUEIAoH7y8/t6DRMSfmpee5C6zIgdzfT6Ic4AGEdhLriVo1t6vSKxcAOHg==
X-Received: by 2002:a05:600c:4f94:: with SMTP id n20mr8719881wmq.64.1641509862706;
        Thu, 06 Jan 2022 14:57:42 -0800 (PST)
Received: from smtpclient.apple (global-5-143.nat-2.net.cam.ac.uk. [131.111.5.143])
        by smtp.gmail.com with ESMTPSA id o5sm2747208wmc.39.2022.01.06.14.57.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jan 2022 14:57:42 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] apply: Avoid ambiguous pointer provenance for CHERI/Arm's
 Morello
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <YddySiBCOOYYKDmC@nand.local>
Date:   Thu, 6 Jan 2022 22:57:42 +0000
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C2DD77CA-D1F1-45ED-912F-C4532EB2720C@jrtc27.com>
References: <20220105132310.6600-1-jrtc27@jrtc27.com>
 <YddySiBCOOYYKDmC@nand.local>
To:     Taylor Blau <me@ttaylorr.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

]On 6 Jan 2022, at 22:50, Taylor Blau <me@ttaylorr.com> wrote:
>=20
> On Wed, Jan 05, 2022 at 01:23:10PM +0000, Jessica Clarke wrote:
>> [...] In most cases this is clear, as normally at least one operand =
is
>> provably a plain integer, but if both operands are uintptr_t and have
>> no indication they're just plain integers then it is ambiguous, and
>> the current implementation will arbitrarily, but deterministically,
>> pick the left-hand side, due to empirical evidence that it is more
>> likely to be correct.
>=20
> Wouldn't a simpler, less invasive fix be to instead write the =
expression
> so that the left-hand operand is a pointer? IOW, shouldn't the =
following
> work (with no other changes):
>=20
>    ent->util =3D (void *)((uintptr_t)what | ent->util);
>=20
> ?
>=20
> (I dropped the explicit cast on the right-hand side, since ent->util =
is
> already a uintptr_t, and the left-hand side has an explicit cast, so
> there isn't any type promotion going on here).

That would still warn as it=E2=80=99s still ambiguous. It just happens =
that the
arbitrary choice picks the right side. Better to clean up the code to
remove the ambiguity and clarify it to the programmer.

Jess

