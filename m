Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E18CC4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 22:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50A506109D
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 22:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238169AbhHLWTl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 18:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhHLWTk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 18:19:40 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2F6C061756
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 15:19:14 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id l22so4715332vsi.1
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 15:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sg2oCQI81n41hbkBmEvbAhzldCHIQdxcAYzz4+J26mw=;
        b=kQy/UpHazyqADHeXhkOhr/ULIm8Hdvlm54FFfFUT/BVQv3kbOJF94NERjEUdH2+Xsn
         BND9AW1nviwVDPW9/nU9jZcJ+TubsneNbvlpYuziCpzGv7fMcO3G+MqSyS/qXn9PhNbv
         xedKp4SKGN96AHVElF8x9OVJ+wvn4h2V0XIG/IDySeWh2G0i62qRbXmqzMuFKb4ePNH/
         2CZj3/HlOp13/e1reXcH8RDfJo/aW1JaSa2d27GMAbJmeDWXDeMlnA1cOXF8TbZc+Moe
         vkSMdAVPh3OIoAjFnmZoMej8YlYouziSb89ykMk5noQGTJuwKfmwSG+S+5otFOEWft+K
         hIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sg2oCQI81n41hbkBmEvbAhzldCHIQdxcAYzz4+J26mw=;
        b=WI08iVU7UrBrbRtMp1zToCaKu+EP+gvTrme4WFK3ycawSYEShSdSsXZTQ9anU2ft4F
         QK8w/bBOtm5efcPcxIZHAxWMWjlON8qNSPqm4sSYZ4s5gO5ehYKQUOKGRtkOgaAgdPYD
         ZCLUdQDWbvjnwjeVGShi1Jfot5xu5/WVhYcJAdTWXPA+jBCDG02rmprDp+xLh87BG1zW
         WFZrSIHwXd5B5r4nm3Lk9e81gvjeeE/kVHg6bAHPZsrHfIG2FvnQ+5LZIyUP2uc9u3Q0
         TLlIj46N84rD6KIqPdfpmZHnKziqi4d6pbN1T2k6TybAhNykMocTFGGTLIG+cy/nZyPT
         5aHA==
X-Gm-Message-State: AOAM530NHHe6ILguApi2dY6g+B0voTvo2pFGhukOrQ0uSSTLBvDCq8Cd
        e9qqAxctrQNuHDYgOlXr7b5WxPy6nbdDam81AyQ=
X-Google-Smtp-Source: ABdhPJxbOxdvxJrtNWH1te+tkJqo7vBWEw3PfOjxU4brEYZCCcrLe+lM43Mg4GIlMzif+E/lw2fB8BroN3n9QLwtUG8=
X-Received: by 2002:a67:fa0b:: with SMTP id i11mr5847398vsq.44.1628806753944;
 Thu, 12 Aug 2021 15:19:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210812065234.71399-1-carenas@gmail.com> <xmqq7dgq304m.fsf@gitster.g>
In-Reply-To: <xmqq7dgq304m.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 12 Aug 2021 15:19:02 -0700
Message-ID: <CAPUEspg3ci4VVEU+ktDZgZkhykKbs9-+JmiOx_2CmOwFoYdMMw@mail.gmail.com>
Subject: Re: [PATCH] ci: use upload-artifacts v1 for dockerized jobs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 12, 2021 at 12:59 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:
>
> > diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> > index 47876a4f02..9dd41a1742 100644
> > --- a/.github/workflows/main.yml
> > +++ b/.github/workflows/main.yml
> > @@ -258,7 +258,7 @@ jobs:
> >          - jobname: linux-musl
> >            image: alpine
> >          - jobname: Linux32
> > -          image: daald/ubuntu32:xenial
> > +          image: i386/ubuntu:xenial
>
> Intended or accidental?

yes!.

It was intended but more as an RFC, because I couldn't find an
explanation on what was the advantage of using this 5 year old
unofficial image when there was an equivalent official one that had
been updated just last month.

It was accidental, because I didn't realize I hadn't updated the log
message and it isn't needed to fix the regression which was the main
focus anyway.

>  At least it is not explained where this
> change comes from in the proposed log message.

The advantages of using an official image will be :

* more likely to be cached and therefore less likely to fail the job
* easier to move to a newer version (specially considering 16.04 is EOL)

Would it be better to drop or document it for v2?

Carlo
