Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F307C43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 02:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E17B3206B8
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 02:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pRGYEEgD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389809AbgDCC4o (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 22:56:44 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:34371 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731842AbgDCC4o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 22:56:44 -0400
Received: by mail-yb1-f195.google.com with SMTP id l84so3418780ybb.1
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 19:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6Garbrr+fu13lF0JewZxHcW9vwnzip6g5oEFOEn7VSw=;
        b=pRGYEEgDMbp74L1FXVdH+Vd/A89oxshh89qag6pGjY3wbVpzVmtZFQd8ZfnH+/SiQQ
         KIPFnJcu4KL/qJRB+f0znqCRtCuFd1+xXLdgvRo71WXhar12WYh2JWyW63VMJAJToy5M
         B1t84QXiBpV4zV/4uTnnB53uRuHkvaMPEr058uBHgSEx6eSWO/Ffkk+AfqCJX6w6IDV/
         R++1N21dn5LOVaehTuAZMqw5yg6Cp2lv8EWa0pVTl0fx9v/F10GLktuIzQs9YWl+i140
         BeQ44o3/t6nHBe6a3FWfE/UyrFIfpcUx7FwV9wuGPqAyPYQqsOUpYGLCQfufQXHuYj5w
         F4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6Garbrr+fu13lF0JewZxHcW9vwnzip6g5oEFOEn7VSw=;
        b=nar2pPfau59zkJZwBoL0xpIOFjso3nPSdm4GTs14x2dY4SofiKKQdPAaXG8bl2Qkxw
         WnqOsooE8Oc2VZsIChCZSYzsfEYKS9Ly0usjDU/hY59sah+frschPG1hzh3PEHjfGS5F
         DKdZZ6yfsO2Cux/8OnyiJrpg/Rpvbczh7OvK16MzqmTMaNP9nJVc1/5/iwaW/CX0Th9S
         sZhDcUyiVHKzYxADCKvys5548YfqWFdsHItWq562PrqnV51/uGUn+TOmsZpHEVma0lyR
         AM3m+fHvulyg4MElMQT+nhbcgQ7cZ7UVsBYZCjOUs9T+6cYX+C7VbHfrsBwKlCVCz9XL
         89rw==
X-Gm-Message-State: AGi0PuYL7Pg3zft1Y+MWoP/PCuScGUsxifM7UHPrHgD+guK2BXyZb3E+
        6OYXpznrgq7PsGpZOi0MVd+n4RMPBhAx+LRsps8=
X-Google-Smtp-Source: APiQypK514Jjt5Q0z1rcUfZumCi6AnSKkLpYQqR88XoluslAH0n98gjFbTb6h8LhKFQnUjqZd/cycsZBYbP9Bwdn3NA=
X-Received: by 2002:a25:870a:: with SMTP id a10mr11170464ybl.279.1585882601430;
 Thu, 02 Apr 2020 19:56:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200402084251.85840-1-zhiyou.jx@alibaba-inc.com> <CAPig+cTp3AhYXX_cjU48yLyMHBF1fOgwHw2ZC5rGWvYFE_bmQw@mail.gmail.com>
In-Reply-To: <CAPig+cTp3AhYXX_cjU48yLyMHBF1fOgwHw2ZC5rGWvYFE_bmQw@mail.gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Fri, 3 Apr 2020 10:56:30 +0800
Message-ID: <CANYiYbE0DwRNpfGpX-dsiCF0i5avWYqqNLqOsGRAUJcgceUA4w@mail.gmail.com>
Subject: Re: [PATCH] git-submodule.sh: setup uninitialized variables
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        xuejiang <xuejiang@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> =E4=BA=8E2020=E5=B9=B44=E6=9C=882=
=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=8811:11=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On Thu, Apr 2, 2020 at 4:43 AM Jiang Xin <worldhello.net@gmail.com> wrote=
:
> > We have an environment variable `jobs=3D16` defined in our CI system, a=
nd
> > this environment makes our build job failed with the following message:
> >
> >     error: pathspec '16' did not match any file(s) known to git
> >
> > The pathspect '16' for Git command is from the environment variable
> > "jobs".
>
> s/pathspect/pathspec/

Thanks, Eric.  I find Junio has already fixed the typo in his feature branc=
h:

* https://github.com/gitster/git/commits/lx/submodule-clear-variables
