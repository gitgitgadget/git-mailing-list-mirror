Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FD2C433E0
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 13:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B0FD22D50
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 13:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbhAVNdD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 08:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbhAVNcu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 08:32:50 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D539C061797
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 05:32:10 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id r12so7635570ejb.9
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 05:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xz2zD/HxcGCl1aGygDOJpzZ/Q/20bYXMpyemfijwUnU=;
        b=WcQ15y+x1idroPtEallnpcNO4WN0cyUS2aCKidQwPoEE1Kn/80E2RD24b6w8zB1zOw
         7rhq23u1McD8P8V4WANTxmq4hAU7SjRPIwkPIGTab2EHxr9RFMJOPWF0VbMNEp1IbemG
         24etsUu8E2ZjxcUHPCTlAWwbP4MnrO83WL/WXzXjzHVWaDsoNdQbvCvlaQf/HAamaZEK
         8DtuxxQmGfC8Zf9tDvGTlRH2yIEtisy8+KvpXN9cMNY6yBqK9vPxfSdBZeN22kR0Sr0F
         3O4z8VE98ptCrdf68AWf/8aq13VMDVl6FkUlnu43b3bou39qAh93HS1do4FQB3skqQRm
         LjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xz2zD/HxcGCl1aGygDOJpzZ/Q/20bYXMpyemfijwUnU=;
        b=sfOsd64mj8GbfnL6+H5t/71e4EcxXqAkYRzV30hCtJ5bxdo3aRk/lM1069iWchErU2
         8RfRH1LBZn67gjWjAAwuH06+rRaeHK9vmc2e9/51wTqAcoyRvOy11o8XXRW7cgb83Kh4
         aU+3BGwOa/bg/Zk1fLQf2RqVAekk1qv4es0vm/MlqJXyKzIsY+oenkhmBpY8uEL7L6Mc
         lAeHUBNIisWnPwDE4+eNucoeMdC71jNpDeDXUkd22Jn8llWJ8qc2YTCl3gKFVMm44Fpx
         v+8KiskLhkIURcNDKvz7qIgUQLrmT3K8TV4b5pPBOlvw9XyAA6goi+rULeOr1IQYGh8u
         y1Jw==
X-Gm-Message-State: AOAM532aBccmffF8sMHE2bVy3DYUWGHfkTnsixUp3OvrDZEd0N9h33H4
        GQ3NblZDWj7caQcn5cNtQQNRzDHWJY3j/R+OpzuARrjfaLjwJA==
X-Google-Smtp-Source: ABdhPJziEfT4CERwTJaI4NIBj0if10gVfED0Di/qcbXztkzC5pE1vUfshhRD8mTPIeUAmaPmre8x/CZ0A8gmjnNRu80=
X-Received: by 2002:a17:906:86cf:: with SMTP id j15mr3031372ejy.216.1611322328939;
 Fri, 22 Jan 2021 05:32:08 -0800 (PST)
MIME-Version: 1.0
References: <CAK8LAYVZKjbMEDWTyvQv2eY+qR0qw1=mn=c4KCZvit7gsqTibA@mail.gmail.com>
In-Reply-To: <CAK8LAYVZKjbMEDWTyvQv2eY+qR0qw1=mn=c4KCZvit7gsqTibA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 22 Jan 2021 14:31:57 +0100
Message-ID: <CAP8UFD0fZBdZ6qwDP9_yW7VAfskTKPC7HVSpK4rD=bORuECpJA@mail.gmail.com>
Subject: Re: Can git change?
To:     "Patricia B. C." <pati.camsky@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Jan 22, 2021 at 2:05 PM Patricia B. C. <pati.camsky@gmail.com> wrote:
>
> Hello!
> My name is Patricia and I work as a software engineer in Brazil. I
> also teach sometimes at Le Wagon, a programming school.
> I brought the discussion about changing our repositories' branch to
> main instead of master. The response of one of the owners was that
> "Git has not changed it, so we will not change". So here I was,
> wondering if maybe Git would hear me out :)
> Do you have any thoughts on it?

There have been a lot of discussions about this topic. You can find
some pointers to them (though maybe not the most recent ones) in the
article "The history of `master` in Git" in:

https://git.github.io/rev_news/2020/07/29/edition-65/

There has been also an official statement by the Conservancy and the
Git PLC (Project Leadership Committee):

https://sfconservancy.org/news/2020/jun/23/gitbranchname/

Best,
Christian.
