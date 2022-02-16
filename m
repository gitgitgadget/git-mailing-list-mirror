Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4B8C433FE
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 16:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236714AbiBPQwm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 11:52:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236709AbiBPQwk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 11:52:40 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D9994975
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 08:52:27 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id p15so630368ejc.7
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 08:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H4sD4A6PRyygZsdLr7/PUIshq+T47cnB7he7c/xOMSk=;
        b=RrxTK5/TK/MJhtwZesFkdB5EKS9g5Fy/tov+SVNm0fhEiylbm0lXfYP75he+ykl4vx
         WcikNr8gf/eFaT+EzW6SNmc0dnhzwZmJLlQiRmrehGKWn+ziW7pOA0matUQ8cyPvQOzk
         iUOiFCk3/yujOPiM8zSwDV2n8SXYhL2JSA/E4lfsIWcNba7hrdvmK/NAaqUobFVeefbg
         MveBGp2p2JAFonvSaNBe9bfCIzxQ4GdKh4Rj13K5eWBOXWl9Ic6o1ZcLVHsRSmOoDSl9
         opMHe7fvzc+BVprlP+Rn3jAsgW7G7pO4ujC4uRGXVqp7n7IobHv4JdM2hhUyx/gpbOHc
         9kpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H4sD4A6PRyygZsdLr7/PUIshq+T47cnB7he7c/xOMSk=;
        b=W2OxPAPzWv4QX98i0W4E+oGgCkq8R2ViCuNPUDlWSrvKK9ilX2+88HHcqALdst759g
         Vwc/KL0zmsA9NmdkHe/SLOr2tzcf5cUd4vwJ65t++zAYo5nsNnn63IiYnywCf5kmYsCX
         jmHN1xdPOaBiEtSBvvGognD1CuJRcER9c+N3e8HZ8sDdReyz4KeM/1HmAhGC3ftjVrFc
         0JJF1pHjt/K5JRqPCT/LLvhti1+6rI0G2RumOapQuywYa7PYO91Bwwez29XMmQymn6C8
         4j5gPKsbhIojHn01TRYrwUzUuqOd8F8sJn/PlZ1oyTdgnz5UCR60mly1onijgdd95iD6
         GhbQ==
X-Gm-Message-State: AOAM531n91H1hsuz5MKxRrxspqrSXzzrrh9vkanAmW+kO/3GsNSS/3XD
        f0/fbt9xhQAA6sBKYvpIJ6EC+/S0N+uczDbC/a1S4fe5/8g=
X-Google-Smtp-Source: ABdhPJwWzfrjmvQTCVH3EVTo4MFa8d3OX155JVPH/xxXXalv5vLaD5aQQ2mPHe9A2WldoAbTIIpwUZtb9omBwWwjsZc=
X-Received: by 2002:a17:906:a855:b0:6cd:ba20:39c5 with SMTP id
 dx21-20020a170906a85500b006cdba2039c5mr2992464ejb.100.1645030345941; Wed, 16
 Feb 2022 08:52:25 -0800 (PST)
MIME-Version: 1.0
References: <cover-0.2-00000000000-20220216T105250Z-avarab@gmail.com>
In-Reply-To: <cover-0.2-00000000000-20220216T105250Z-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 16 Feb 2022 08:52:14 -0800
Message-ID: <CABPp-BE6Zuo=L3zCHHee2T-WkbF7m+dRp9MzoB_JQuP0vns6eA@mail.gmail.com>
Subject: Re: [PATCH 0/2] diff_free(): free a bit more, fix leaks
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 16, 2022 at 7:56 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> A short and simple two-part series to fix some leaks in after
> diff_flush() and friends are called by making in diff_free() more
> useful.

Reviewed-by: Elijah Newren <newren@gmail.com>

> This series along with other small leak fixes I have outstanding
> on-list now is the last step I have before the big one of submitting a
> series to fix the "big one" across the test suite: the common leaks in
> the revisions API.

Wahoo!
