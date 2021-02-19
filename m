Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D2AC433E0
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 14:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3532964EB8
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 14:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhBSO5q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 09:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbhBSO5m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 09:57:42 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3035DC061574
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 06:57:00 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id gg8so2533928ejb.13
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 06:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QK4s7nXsw26br7Dnp8K2iVoWZSADn3X5jogc3dXIldI=;
        b=WEYAAU3FfRrl1EF2cSeBTfcLHpb+D0YHYTKKndyOImfapWak563LNnxPJVXmuquyth
         24DaoVyasba2siEeXtItmKTqz8QNFedEnC+ySCJU1RUMjwqJzcnw/vLYFvSUCbKIvuhQ
         vtaagLXfvMF4A2zL7WQKSQP0sZOUP+oMEdpH2wiLnQRbLofVeWta0LLHqkZc8yJfXXj+
         8Y6/gMTM/L/Wnk60gEgG/OMV8PHmaWRQYEFzzNZPV2FYAdNnPbXFFyIW/vsD769UV9Ua
         OMcTsY7S0aTYbHRylPGuWXxqqe/A1aDQIpwyspE3iggp5u1ucujSYkcyRhiz11uSRNdV
         ZgCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QK4s7nXsw26br7Dnp8K2iVoWZSADn3X5jogc3dXIldI=;
        b=dAIaMDQTefXI8KW6pBflDoaS/AopOIeqgJgM5JM/sc3mUqiHFm6AfdnHacVjlzykLu
         cHssXNZJE5SamEbq0Vb3fcXBwEzG3RHqiUCYA5HAv424Q3tvrLhoAXSRZRLUhrq3ljd1
         7DpafuzcjeBJDc7l4t+Dl/54gZqXkSDuNKvWzqGgITrKgu+Sm6QmwgDE8nlk+jbMC1Y6
         5mPySWMleyKFe4r9iTKA+n27mTu31H+CyFDbIjS3o4X4ANMCNcJO0TP2CbSNpfPfryFi
         zhyDYZ9BReDjhldtHkzcfY577Uzl89x4uXDwjnL2G+jXWOb5HDw2QkKHhN3xHZdjExZ/
         RUXA==
X-Gm-Message-State: AOAM533ybaa9bKzhlI2p+41Yk/SrkX7CV+d/ROkq0ZIyvPxB6SAH6cGC
        WRbziCY+hFNKOdQk7wiMQ5BxpVr+F7qMJi914/8=
X-Google-Smtp-Source: ABdhPJyQUBCxYvaX+pVOz+yZ3UAQLLpvHkzL06/imfn0jUEpLd0YG65YX7biMYAtkm8MKU9AGT8xT2hIgfqY50Ss0P4=
X-Received: by 2002:a17:906:4b12:: with SMTP id y18mr9114034eju.216.1613746618920;
 Fri, 19 Feb 2021 06:56:58 -0800 (PST)
MIME-Version: 1.0
References: <20352639-deaa-0e3f-c99e-9bde937d67f9@gmail.com> <CAP8UFD1VaOBWcf3RQTc6OdmkUZCOOOO0mubRoWAvao6uNtNkgQ@mail.gmail.com>
In-Reply-To: <CAP8UFD1VaOBWcf3RQTc6OdmkUZCOOOO0mubRoWAvao6uNtNkgQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 19 Feb 2021 15:56:47 +0100
Message-ID: <CAP8UFD3vDfrQnxSUcUoZHx3TqdxyrUeviT2zfjCcZHF-t-uK9A@mail.gmail.com>
Subject: Re: Git in GSoC 2021 ?
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kaartic, Peff and everyone,

On Fri, Feb 19, 2021 at 12:52 AM Christian Couder
<christian.couder@gmail.com> wrote:
> On Tue, Feb 16, 2021 at 7:12 PM Kaartic Sivaraam
> <kaartic.sivaraam@gmail.com> wrote:
>
> > So, I was curious to know if we've already applied to participate
> > in GSoC 2021 (or) if we're planning to participate?
>
> I don't think we have applied yet, but I would be ok to apply. I think
> I will do it soon unless people objects.

So I just filled up the forms to apply. The information I used is in:

https://git.github.io/SoC-2021-Org-Application/

I also registered myself as an org admin. The only issue left is that
we need another org admin, so I invited Peff and Kaartic. (You should
have received an email.) I hope at least one of you will accept,
otherwise please tell us soon.

If someone also wants to be an org admin, please say so. It doesn't
require much work if any.

Best,
Christian.
