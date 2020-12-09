Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D28C1B0E3
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 14:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BC3823B42
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 14:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732769AbgLIOBy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 09:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728158AbgLIOBw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 09:01:52 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7E3C0617A6
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 06:00:36 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id ga15so2270129ejb.4
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 06:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KJF27kfsVPs3AoQa5X2YVTTc89cReHrm7rbn6s1n9fw=;
        b=TcYe+Tsmw3R5fjw0lnN/eQ+0YjB5rcZRM1YVTOTz15LSip4XtXY2guxZNaq7MFmFcu
         WoRiUa4pVQVwh9lQw4pKNQY4Y7W8Exh5CZTgc7BluiSquAI5Zfja25c6vr1FFG0O6vaA
         sYA6fr3TicC8Ed16Rb74Vzf2wmAg4lylVO2hMI7TFDzYVq+wz+zFtwQu1uA3iRrURurY
         +FXaiKW3MBEGgshxfjTBZL3mHyUMhsE2dFrxv6U0VCfgmDiHYoNErd0E1vK+P+84Vs8t
         dXnX/ZT7BNtOAPpOFAfA+4vWHT1/hhQdi2GhbS2hchRbW2waQIrD/AYKJlHTjNo1Gn4Q
         5/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KJF27kfsVPs3AoQa5X2YVTTc89cReHrm7rbn6s1n9fw=;
        b=MEzrOGPdcXe4NFrKdiYeL/nKJkADUf/EYKO9xKgTQH6gAf5UydIZ/jf1TPujJeX25D
         FC9ZdESRA+hOJ3o2NQmC1/GJDlppUN3WVgKEI69qJu53MH6yklFJ0dGEOSxBsgFO314h
         PFg/dYkCbMtUNxaoUkvqmiNCeEhy6It58fmCuoJd5MsdfkQfGVju/+PHaNhO0k1rbao5
         vioMQs74ZQSCiBjejn0nO9QCUvgBBJfYRr98KCjAlgtGRe/JmYTNLtRwK6tfVpsc08SL
         wYIC7mrOnCXFZ5xqL+hvkErrk+PYNaBdzN/K/Z2kHpnZ5Xav3YYyOSq+MJjcgVScnw13
         dZag==
X-Gm-Message-State: AOAM530YzM55j89Mg2uWSfxO7Yi2lnMTulTU5axSDD3DR6VSPiCw2QVf
        j3KAyHC0R/XFOaQ0sFrCgIdR6vc15Tl5PtzdDkiX+AfMeZRvtRe1
X-Google-Smtp-Source: ABdhPJzKuIxLqPdYPISVLfynO1p91ds9Fx+7QTjYkGD0XgtOj+JK61jIFNGsTszClD3tzKOMyXSErKV/ilTb91W5y6w=
X-Received: by 2002:a17:906:4d17:: with SMTP id r23mr2288300eju.87.1607522434943;
 Wed, 09 Dec 2020 06:00:34 -0800 (PST)
MIME-Version: 1.0
References: <c0971d1b-3bc5-8004-09f8-7ce10fb3df26@nokia.com> <20201209105844.7019-1-peter.kaestle@nokia.com>
In-Reply-To: <20201209105844.7019-1-peter.kaestle@nokia.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Date:   Wed, 9 Dec 2020 09:00:23 -0500
Message-ID: <CADtb9Dy4BHckP9SMKLRJA7CRTA9Z_UmCiF4C8t0d3ARELfoszQ@mail.gmail.com>
Subject: Re: [PATCH v4] submodules: fix of regression on fetching of non-init subsub-repo
To:     Peter Kaestle <peter.kaestle@nokia.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.us>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le mer. 9 d=C3=A9c. 2020, =C3=A0 05 h 58, Peter Kaestle
<peter.kaestle@nokia.com> a =C3=A9crit :
>
> ---8<---
>

Reviewed-by: Philippe Blain <levraiphilippeblain@gmail.com>

Thanks again for working on this.

Philippe.
P.S. I wouldn't call anything you wrote in v3 "stupid mistakes" :) we
all have a lot on our minds
- especially these days!
