Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DAEC77B7F
	for <git@archiver.kernel.org>; Tue, 16 May 2023 04:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjEPE1I (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 00:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjEPE1H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 00:27:07 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FC83C1D
        for <git@vger.kernel.org>; Mon, 15 May 2023 21:27:05 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f2510b2b98so11618800e87.3
        for <git@vger.kernel.org>; Mon, 15 May 2023 21:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684211224; x=1686803224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTBT3VcKLO/P4o2s7x3Udl2bEzbQvPICtWHpYp0b5I0=;
        b=m4pPItBOdtw0uiXUbYkLzaH4jdYs4SUkdJzbpb5HYPk5lZnDAsHgA5paKMhGBCYcdA
         hCxJHHTVRHWakawrszbvjfhdD5QJWBTsZulp8LCG6NpGnsqEgEvDuli9YOJSA9eRt4eM
         TQTHQj4x0eUop2hCjGckEXznG+HmX0KgbkrgCZ4LF+kKAC+zmeQrJRL5LFYxb/3dqAH1
         rGRmsnsbfPNMTEz6cPKTqytd9HOXFJ/ZPrzCLAKkHSCSpHAvMH+rVeuupXOQFT/XE/uu
         pSwHyu9JE5YgENDrF4sM/B9dG9KWziH1keuiQ2BbJ1wBIbryEc7OFwuBLdtkHuoN2vfF
         NKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684211224; x=1686803224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iTBT3VcKLO/P4o2s7x3Udl2bEzbQvPICtWHpYp0b5I0=;
        b=OtaalsvvGKwyQr9Gq80ctShCOBLKARHz2TxZ8xVhhc+4oi2YLly3dAVfrKkAJUeEX+
         BG9NMAL9ssyKIDm1bOf+zf1OAf27X83TKVe3O62IFhmPHU/tW7p6WqTrYbnjV51ITUCL
         XOnCBzGaS4bAXgbHq+Fwu8m375PySJidCfYkgkRHykFaEjCq58XRZ73GIzgDi/O7FSrr
         lDSeK8HrELl0VlwM0p0v3HSInstnPoOf/E+Pxlj/osPxYeRNSK26veYCJQplzIbdk3e6
         DTvR/vW8+db+VG0pR0/Tk6Qo273RS/Sq2D46xielLKmqdKbofhDYPMRBZ6NnZobuD7dH
         /PIA==
X-Gm-Message-State: AC+VfDwwtdpoqXcwRjZQjs8uAzy1xhLZWkzj8nlMCU4SK432ZaXSt3mn
        n1WGlfyzDu+2WoDftAnzhdQOhlRPPIifDfEdWaY=
X-Google-Smtp-Source: ACHHUZ5UkUy6dI6U0NoWDgASah+Ey8PrSh7DLHPDTy78Tfz6AqIYfC4mOdgYFYMpBH1EMayXiSJ/FOydcFPFkSbgwbQ=
X-Received: by 2002:ac2:4e63:0:b0:4f0:1a32:ca23 with SMTP id
 y3-20020ac24e63000000b004f01a32ca23mr6750991lfs.40.1684211223843; Mon, 15 May
 2023 21:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230407072415.1360068-1-christian.couder@gmail.com>
 <20230509175347.1714141-1-christian.couder@gmail.com> <20230509175347.1714141-16-christian.couder@gmail.com>
In-Reply-To: <20230509175347.1714141-16-christian.couder@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 15 May 2023 21:26:51 -0700
Message-ID: <CABPp-BEoBimdtHQkU=fanOH8LvUsZZxwG0Og7Y8q4bX3io5D-w@mail.gmail.com>
Subject: Re: [PATCH v2 15/15] replay: stop assuming replayed branches do not diverge
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 9, 2023 at 10:54=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> From: Elijah Newren <newren@gmail.com>
>
> The replay command is able to replay multiple branches but when some of
> them are based on other replayed branches, their commit should be
> replayed onto already replayed commits.
>
> For this purpose, let's store the replayed commit and its original
> commit in a key value store, so that we can easily find and reused a

s/resued/reuse/


> replayed commit instead of the original one.
>
> Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
