Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29531E80A99
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 06:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjI0G0v (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 02:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjI0G0l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 02:26:41 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E05139
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 23:26:40 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c022ce8114so169403811fa.1
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 23:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695795998; x=1696400798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ke7mvUoh+lDcktci12xhRDuAAfU3tTZhkFTITU5Lv7A=;
        b=fLXeMtxci72qtUCWfcNRu1Xf/owykIUuNLOwLWmp58laE73X0DXa7g12V0AQ3sZLQk
         yp78qenrWXgrSEKO+MZygJSpEj0ApCb7Q6FF6Km/YaFoBMJAxmxJ/vBdH0RuQPoWyI0h
         E1xjwYJ/f+s3ZsfCiTRCWRROcS9ZE1ntiWLXw5L3y7Pv3i2a++373o/gvv0FhW6uhmLR
         Cr0y+FdYLXi/C+qOOBfVdmf9oHzCvKKFZ7PRPp8HVLhh3tfGg6FsnMa8ZAI5g+ZwVR5H
         l4AuISdAS5oo/MhQWQEUmFCjnDPdLZHdaDf6YELCxhqJy0+wiH4HwIYhQRFQhZXU6npn
         rKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695795998; x=1696400798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ke7mvUoh+lDcktci12xhRDuAAfU3tTZhkFTITU5Lv7A=;
        b=WoRkioP3T11hEkAntdTu67i0ivPEwVS/QBueB3PTpqcyzAO9+evzN6r5jWDXdSANM1
         qyufZsDtVqNdn7HBkdl4sdupM6qbvhrgJe0MbWgLcvSV+tVMsJ4HkGvAr/J7olGl+kev
         grq/bAJ9ALys3/NIEZLSOubycSF4AdT2iVHcXxJGSBp1eGv4a0giYLGtEd8p906Axd7I
         QSoUuG1v4x4QA5/eyvYkfcH+KNRrjetcTBhqC1wN5Cv+mtVjb57trOijXSrqZ0tsPcfX
         mlm15y0Hnr6HyzRYWbgvMVyWRcP0CSlZWO3omqCsFIQpzl7HfS6LL1UIr9um7kFW//nT
         qIhA==
X-Gm-Message-State: AOJu0YwkScp/x4xvyim9/UEyVe7txv3oEfsIasc4Rdja6Yv/uS52sQzO
        AhFiZ2JhrNQ/Z0B21yGeyqtBW2K/QYBQYxAX65c=
X-Google-Smtp-Source: AGHT+IG0r9yLsUeF6k1J8nnaELnXeywcuj2rkGQzEakJsIt59uqGtdWrg1APGPt2m67bSWSnyMgkYWwXm7jT8wVMSPg=
X-Received: by 2002:a05:6512:3d10:b0:503:38bc:e68c with SMTP id
 d16-20020a0565123d1000b0050338bce68cmr1047795lfv.47.1695795998134; Tue, 26
 Sep 2023 23:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8UFD1bsez-eMis5yH7Esds+LkhMnj0qTUMFPL1tRuDv2fiPw@mail.gmail.com>
 <ZRMJRVl16gBEElGZ@five231003>
In-Reply-To: <ZRMJRVl16gBEElGZ@five231003>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 27 Sep 2023 08:26:25 +0200
Message-ID: <CAP8UFD1g6Vmc7Kx7suSmnMJThM_m4gcaZ0V1f4w0c1M9DoO-Mw@mail.gmail.com>
Subject: Re: Projects for the next Outreachy round
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     git <git@vger.kernel.org>, Shuqi Liang <cheskaqiqi@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kousik,

On Tue, Sep 26, 2023 at 6:39=E2=80=AFPM Kousik Sanagavarapu
<five231003@gmail.com> wrote:
>
> Hi,
>
> On Tue, Sep 26, 2023 at 04:48:12PM +0200, Christian Couder wrote:
> > By the way, congrats to Shuqi and
> > Kousik for successfully completing their projects!
>
> Thanks.
>
> > So Shuqi and Kousik, please tell us if you would like to continue
> > working on your projects or if it's Ok if we propose them for
> > Outreachy.
>
> I would like to continue working on the project and hopefully complete
> the duplication of the remaining pretty formats into ref-fitler.

Ok, I will not propose the project for the upcoming Outreachy round then.

Thanks for your answer and for continuing to work on it,
Christian.
