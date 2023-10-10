Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6E8CD8CB3
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 19:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343921AbjJJTWc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 15:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbjJJTWU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 15:22:20 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662E9EB
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 12:22:16 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9b29186e20aso1028999966b.2
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 12:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696965735; x=1697570535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4WPn5Jv4oxhM6GkjZbwC9ImD8aDmB/X+qe7S5ZVNR0=;
        b=DE/peF1kkZy83tpteoGwg1YBWJYADTyJgGlOt4CkAE/hvvzJfZat1NVtUhY2RR/kcN
         yG5fjBnpWtj2/xaSrtsTnVF9+69qMT0auu+8S7zyW9E1hZZVsLEfWR2iYu1P7njPFDby
         bJ+yU6T15h6Dh0xbUTAESisUsk1BzyOySM4v5/LJp5xQTCc+sizsfghdS/0UoulIeunV
         oAJ/AJq+0o8QGl1ImycN0iauS6jBsjOnTNed4eNw6BXZMWt6m5YHIVmCNwrS6+210O7d
         Wd9DS+qJbiSciI4ZktbHud37ZNgIq6/1xXl7KUqnebybCHi+flTtzO6RrCJ4NEL9joEA
         CTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696965735; x=1697570535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F4WPn5Jv4oxhM6GkjZbwC9ImD8aDmB/X+qe7S5ZVNR0=;
        b=uSGFMhXQt23NQKqeQ8sSyedLY0QGtLpVfWXY0ojpSiogTYJm+xCwzhhIo5TmKkEDS2
         oLWhKjZMnst8mludMF1JN515fy5uGNSH5GB1T18jM5Jel+FX10wabds/unqDZpQM6onC
         +Q5UJC9pJwV//4Nuvdtio1eIF1kEQCTyMFab6cdrs3VYemUj0nKSDwaV8ghZDj5IQvxT
         ouGQJQ3oRuR7YuSSkprtCezUiyXlhj6MtCSKOvFnm2sLeCAKAD82odZsGZSq8+UZ//3w
         2tRnWRduKQL0h6zNw8g4YM0aWXtBbUjir9iFZqTaGVrcMEIEfGTR1eH3Ir4VjLjoyHcW
         VDbA==
X-Gm-Message-State: AOJu0YxK/fETnJP7ZyRkWSGrwfOj7g/Y0sl/AAuYzgBnXklR8K9OcoMh
        1FH5MLcyIeZ1wps+wVicoJ65Sndb0oiAzxXM3o8=
X-Google-Smtp-Source: AGHT+IG4xrl0mTY2g8C2CvQBCrsNcb/KHjr/n1RTNqdEfmbPDTi19gLdJsv2I8//dM9cJPRJinHyogvGNXo5HUgnB/M=
X-Received: by 2002:a17:906:8452:b0:9b2:a7c9:fcfe with SMTP id
 e18-20020a170906845200b009b2a7c9fcfemr14815201ejy.36.1696965734430; Tue, 10
 Oct 2023 12:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <20231009011546.509-1-naomi.ibeh69@gmail.com> <xmqqlecbzl5e.fsf@gitster.g>
 <CACS=G2yUGGJwD05KOFZK+AV3TSNDvDEfC=pFRsLwKX_-dgt+gA@mail.gmail.com>
In-Reply-To: <CACS=G2yUGGJwD05KOFZK+AV3TSNDvDEfC=pFRsLwKX_-dgt+gA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 10 Oct 2023 21:22:01 +0200
Message-ID: <CAP8UFD3R1bDcbE8V9xbVhoEv9JuVLLXBErp9c=CJVvTuBvyykA@mail.gmail.com>
Subject: Re: [PATCH 1/1] [OUTREACHY] Fixed add.c file to conform to guidelines
 when using die() listed in issue #635
To:     Naomi Ibe <naomi.ibeh69@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 10, 2023 at 5:20=E2=80=AFPM Naomi Ibe <naomi.ibeh69@gmail.com> =
wrote:
>
> Thank you very much! I'd definitely make those changes on my next patch.
> Should I begin work on version 2 or should I still wait for additional
> input on the version 1?

I think you can work on version 2. Also please reply inline instead of
top-posting (see https://en.wikipedia.org/wiki/Posting_style).
