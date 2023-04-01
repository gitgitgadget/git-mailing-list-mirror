Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73119C6FD1D
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 21:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjDAVOR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 17:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjDAVOQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 17:14:16 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3694125566
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 14:14:12 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id j7so30996593ybg.4
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 14:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680383651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Twg4wEaYdbwDW/JKh7fEJt6Z2DI0cJNSbPdNfCCRQpo=;
        b=SwIlPnvlLFuox63/p/XWgyQ0vI3RcBLrrQRKXzYWcrfZKxgfCIXqhc2j+V5/fjvCDQ
         qZpuF36QJPyc3KN3XfShVjMZIqZiCbZpG2Nb/xaiO3HqDp6A4KRxp8dEsKybWgK8neF4
         QU4mS5bns1CXtF/7H+YODam7NtRq+hGEhDLeEhYOYU6o5lvCMc+fcnC6nUsqiSZn4kzX
         W6Ji6PMXbEE2JirR5yS7hHb4FNXc2c+cRQHvpztaVZeD6R/NFSI8pgLSr+DWsq3xrH0R
         R/mv7UJhVfK1EZQnrRzFd7uPYCCK+psrA+x5k3mNypmHnT5QoCLMvHs+94jwlWKDzLb8
         AArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680383651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Twg4wEaYdbwDW/JKh7fEJt6Z2DI0cJNSbPdNfCCRQpo=;
        b=AfKcd2wSwSAbxLuj14jcG4H9N/7c3f8ATxe06XWjiGD4qykF+W/q71dUCaZdQWtdrS
         haYnx7PJzdTtBUZvpTtX4Mg9xgC9bKv59s67vREbh+BSvlx17PUKDdUD0+zl81k2Ubm4
         yH93nPyjvYLGRSdgPqe3SQekUAZE9RC1kbiRtD2SyIy89TtQ5X5RQg6aaWP9Zefckg6S
         VLw0gZ4qyf9PKqdnW7iwuznWHcCJGAM+/GD2N8SRBfkTGdCSB9qk0WEFh0mxIK24/1KK
         Ullatlcb5HZvPnL2HK0Mqxzdy4BQTHUQJ8of7P5oFmmVxqHHeMTFZFgNL8xJtEj1Ji2h
         mAiQ==
X-Gm-Message-State: AAQBX9fSra5b3IUnHf2HCTLlcDvLpJxwiKCMWpWlHKcR+5/KcKFCK+QD
        Scoc/iqcJJjb8nT02HwfAC8OmtfI5fsb0yuufDaMJu5RKMA=
X-Google-Smtp-Source: AKy350YRC5HvzOYRZNpSZuWo5rGifdbp1PRVB9AS8HIqMBe83imtQHCEWlyMruTd/iO2/wUpFe8Wv+9Bs+FwVVN39dY=
X-Received: by 2002:a05:6902:1586:b0:b69:fab9:de39 with SMTP id
 k6-20020a056902158600b00b69fab9de39mr16629283ybu.2.1680383651339; Sat, 01 Apr
 2023 14:14:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8UFD3adabbwdvaCmEXW9fQ88s6Zniim42vR3cT7VMobxFoQg@mail.gmail.com>
 <58a6b697-b403-308a-dd71-6179ec128661@web.de>
In-Reply-To: <58a6b697-b403-308a-dd71-6179ec128661@web.de>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 1 Apr 2023 23:13:59 +0200
Message-ID: <CAP8UFD3SiJaze3oLPH_WJrO8o+3+9vC1Zm7zUonUxARGu+Xr4g@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git Rev News edition 97
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     git <git@vger.kernel.org>, lwn@lwn.net,
        Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>,
        Bruno Brito <bruno@git-tower.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 1, 2023 at 5:24=E2=80=AFPM Ren=C3=A9 Scharfe <l.s.r@web.de> wro=
te:
>
> Am 01.04.23 um 17:00 schrieb Christian Couder:

> > The 97th edition of Git Rev News is now published:
> >
> >   https://git.github.io/rev_news/2023/03/29/edition-97/
>
> I get 404 File not found.  https://git.github.io/rev_news/2023/03/31/edit=
ion-97/ works.

Yeah, right! Thanks for correcting the mistake!
