Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A563C433DF
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 15:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD75222B4E
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 15:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRNTcPb2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgHZPQH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbgHZPPr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 11:15:47 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD0AC061756
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 08:15:46 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id d26so3408794ejr.1
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 08:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OLuGM8IxpullwccPcwUdHi1DRgc50fBBmdkkXi5VJ4U=;
        b=aRNTcPb2bMW5M1nZtlJJ2Bik2w6Uss0Xf41H8ocZ8/lH0pKWCeHj3sfsCO0fHREaJS
         EzY68Z1BNtQdnhMg/ASPSR3toruP1Rd7yQyTaEV0DNxHtdbpmbKvl6g+FVacoPRJYAUF
         /UI7Ttl5FpUX9sPMV0m8JpQpTjMMMLXh1z6698g2eB9Jk4sjJz2akbzN/ETJ5YwIwtoT
         OirFXwuRF8+Ky6rxdpI+EI/k16U0o3KTaLaQagwkK+kBXE1LKyo0+cmrhf727ikJcQXq
         TIWSjnGVOn+jS1mYWhxWWUicfrF/akHe6G+XjmWwZjr+YHpT1mG9Tg7Ss8IT5tDdjToD
         p2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OLuGM8IxpullwccPcwUdHi1DRgc50fBBmdkkXi5VJ4U=;
        b=QFd+1DBfDBSE8RsoaO7YC7kdim9CH2pEeN5pD38/UyHnYGUsoHynaf2nWzJxQBkFEz
         SuT6E75zhajizORma2Dqro5V46M1POIfrNLgmwBjaKyBHppi2T7rjeLjUObwjCfxhqQA
         MjD+FRkGVH4phrA/QuHFBeI9r9JQbeVbehUn/5CJoREUW1QL6cK8WvL4nrm3iOD5ma8D
         r70nPERS6cQP+9Z/t1cINLVUDsdxV5NXuhNXMhA22swI78z2jOwQhn3Mq4Iut89JBmgL
         kiJ2j+ah7olCsPmkSiORqeMt7U+k7LdsDE18PzP0QrJhEj7qS7Zj/srpzO3j5WLqRAPm
         n7jA==
X-Gm-Message-State: AOAM532RvahaJnYU73rdauqNvFzMcycLV8F5oeKDta4tJhIkQMe0uBlX
        SzRvZs2HKN3okCc7LRCeg18=
X-Google-Smtp-Source: ABdhPJzMnRyfGr/WhV+3GnUcZY+t3d2Epb9k84ZXGRlpo35bSN5FYN6ShRZeMuKOdtC6+29rhmBYdA==
X-Received: by 2002:a17:906:af51:: with SMTP id ly17mr14418102ejb.193.1598454945531;
        Wed, 26 Aug 2020 08:15:45 -0700 (PDT)
Received: from [10.13.3.14] ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id d5sm2321368edk.25.2020.08.26.08.15.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Aug 2020 08:15:45 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH v3 0/8] Maintenance II: prefetch, loose-objects,
 incremental-repack tasks
From:   Son Luong Ngoc <sluongng@gmail.com>
In-Reply-To: <pull.696.v3.git.1598380599.gitgitgadget@gmail.com>
Date:   Wed, 26 Aug 2020 17:15:41 +0200
Cc:     git <git@vger.kernel.org>, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, Jeff King <peff@peff.net>,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <56C4015E-B431-4B16-8E05-5919BFA71E80@gmail.com>
References: <pull.696.v2.git.1597760730.gitgitgadget@gmail.com>
 <pull.696.v3.git.1598380599.gitgitgadget@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Derrick,

> On Aug 25, 2020, at 20:36, Derrick Stolee via GitGitGadget =
<gitgitgadget@gmail.com> wrote:
>=20

...

>=20
> Updates since v2
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> * Dropped "fetch: optionally allow disabling FETCH_HEAD update"
>=20
>=20
> * A lot of fallout from the change in the option parsing in v3 of
>   Maintenance II.
>=20
>=20
> * Dropped the "verify, and delete and rewrite on failure" logic from =
the
>   incremental-repack task. This might be added again later after it =
can be
>   tested more thoroughly.

Perhaps I missed some conversations related to this change but
why was this verify-rewrite strategy dropped?

Was the problem such strategy were created to solve is now no longer a =
concern?

I feel like it would be much better to add it in and then remove it =
using a separated commit?
That way we can follow the reasoning behind these decisions via commit =
message.

>=20

...

>=20
> --=20
> gitgitgadget

Thanks,
Son Luong.=
