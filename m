Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841CCC47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 13:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B5D761153
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 13:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhFGNUz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 09:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbhFGNUy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 09:20:54 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6F3C061766
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 06:18:50 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id b25so18223701iot.5
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 06:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=//94fuNuiIF9KtAs6MIhETBaC/Xge+iMu2AsfFKcgxI=;
        b=rkdon1DGvXxBs8jhNInmzkj2IdaNKtmrVB56PLh7vPBVHSleD0BkADD4vQMBOLWUd2
         qKek51gXe3zJ7w1rCnI3vxbGOS7tgZGfm0qyQE/TeF6knDyYtGI/spIv5fmLTC1e8vTd
         vLPsbfZWWhtqw1GLWOoyP6gIvT5RAih56VYPt7XNmS2Sr13KYh9ViJJIXke1d1bVXcsA
         ULHNd20871Ncqlzrow/d3YlMb8YPrkOdmwWcuLzcI1GiUY6c+C2mUwvjZWTbg4fpcCiY
         vLYf8GzssF6rcrprNS7sBU/2tC/0oCnmdvQl+VTjzTV1z/KuVgWoWIlOPeDzyB4EhBxe
         NMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=//94fuNuiIF9KtAs6MIhETBaC/Xge+iMu2AsfFKcgxI=;
        b=Gk0gGlUIIK4BQ5v/pWG2yX6pg8vqPtLuJVSMtqIrItBSJubOArEju0ZzP+2TxUa3zZ
         XnXQNf+2Ydx1NEl/O9FTipbN7/uBIIiplqUDR6u7dkFTNwlPymqnp8yQpPA/Ofja1Gv8
         RX3VPMs+F0RXdZynuA0WPqgRkfg9lWh9vUjPJDiXV+b2fkLeHpZkzC3oPYgJG4r9n1A8
         DCMX0RPDe6ICQ0mJHRDfmtzer7A2kNdtj6qtPnEzCUjOutxUI02NqRehUSbBgiJCLM5i
         /FBjw2loSNKOomYMzOSe9tutrqvvytW9qCwueJgFlmNsgJEKKbxqcmS1YTyZG0rvRQwl
         8GQQ==
X-Gm-Message-State: AOAM531OhLLKEDz3iRTinYnjH1G1EX9bhdAHcG3QHIi7TxS4qH+0ajDq
        Gw2AWMYKnUEJWrcEF7RVB2EUUGShot+Vj5EwbpI=
X-Google-Smtp-Source: ABdhPJwB2xdPq7DmIJ2Y7PnSw95pE1cf95n/qcCZXW67pyN1dcL+eITY/uZ2EezvUpS0Aqz7mPxMgKvqGpYznSqNGWw=
X-Received: by 2002:a5e:8212:: with SMTP id l18mr4934727iom.68.1623071929639;
 Mon, 07 Jun 2021 06:18:49 -0700 (PDT)
MIME-Version: 1.0
References: <pull.972.git.1622884415.gitgitgadget@gmail.com>
 <ccdd18ad508824aa206a02c479229d0ede69522d.1622884415.git.gitgitgadget@gmail.com>
 <xmqq7dj6w7a6.fsf@gitster.g> <CAOLTT8S+5m+-XF-AcQi9t8njTvyDYzHt=BU+4OPcvTT27RP6dw@mail.gmail.com>
In-Reply-To: <CAOLTT8S+5m+-XF-AcQi9t8njTvyDYzHt=BU+4OPcvTT27RP6dw@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 7 Jun 2021 21:18:38 +0800
Message-ID: <CAOLTT8QE7pafPmhnz-6=5zuyjg9n1FNbu_k6bA80jE1e5vYCmQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] [GSOC] ref-filter: add %(rest) atom and --rest option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=887=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=889:02=E5=86=99=E9=81=93=EF=BC=9A
>
> Hope we can reach an agreement:
> delete `--rest` and add `--reject-atoms`. ;-)
>

I forget one thing: %(raw:textconv) and %(raw:filters) can use
the value of "--rest" as their <path>. But now if we want delete --rest,
they can not be used for "for-each-ref" family, Git will die with
"missing path for 'xxx'".

> Thanks.
> --
> ZheNing Hu
