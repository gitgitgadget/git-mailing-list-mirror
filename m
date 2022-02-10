Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E0CC433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 16:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244820AbiBJQua (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 11:50:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244375AbiBJQu3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 11:50:29 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1470EE
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 08:50:30 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id f23so11592004lfe.5
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 08:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uJYdbHYPDjepJzqG36Um6x2rafqjfYmPNxDl6fpVIAs=;
        b=ILgQDMTcLbtpURsbKrdLBcUloD+lGt0SYM+0FldDKpWWjsJUK+whsN87agqCDkAswZ
         TQOyL+3/au2g1xQ4OLyTMUWIZrPgM/ygf/OLYsu/q4GRbTh5rwtl12cY4iKguoxZH9vr
         3LkSjCOIOu83ibGZcSsIUmlfnClE/OKr+zsQsE+A9dztyh5h9vVBqyQEvlMyXGYfiC24
         sXi9irHpR3qmkq2TV/Cwo0nG1TA8S9ihrOiHjsqxSygTLi681boNoiJFcCGcKTEHhWDJ
         pbP8GK5eMsR4JOJCHXW+VNzDp/24sTV8mmFabIRL0/ePEalZXF/DMl3MnQ3gKRJo7K6c
         BWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uJYdbHYPDjepJzqG36Um6x2rafqjfYmPNxDl6fpVIAs=;
        b=4E6uSzxezwVrVHBW0GdAXSWLUceLk8qKt0lutG1Dcy+coYjQYxNxFCkJa6I+zv0JZh
         xSWJMlUIhWz2VrBuVOjoftWKZpDw63oHY9tRwoZ0ZzAXmhk3vjjbYfdCUOlXAFhh9Xaf
         qq3i0THqlAc178s4u2HlroJzGMZvH7s4+4I8xwLPQOeLgY3FfjTq4MBpwJhDJAowuOZG
         X9ULMchpukhXGLx2Fqzq1U801XM07qri4bmKnrSCNnEeYxZDPIOrVCxstWBC96MiSpNr
         AyaCpxIPVaMQG0yeDEiuif9Q8l20F34aV728mq8UM6S/m9FdxCGRmXFKCUwCgbN5nc1p
         PH+Q==
X-Gm-Message-State: AOAM533dSzRKInv+ZFOQv6aJRgxQVbA2WuNyCxVpRHoYb/iap1YEqB60
        5m55kz0iOdlXaFqyjlGZYkGBsrer/ilGITM2X37h7EFP
X-Google-Smtp-Source: ABdhPJx8d7+m9gSuO7UMhbTP80D5OovZp5L2JnBCjQWHT2G5qJpaGIroFiVjKJN5y4Z4/Ztp0AM9XBZCv71seu3Ob9Q=
X-Received: by 2002:a05:6512:3ca8:: with SMTP id h40mr5741486lfv.213.1644511829083;
 Thu, 10 Feb 2022 08:50:29 -0800 (PST)
MIME-Version: 1.0
References: <20220209162350.169971-1-alexhenrie24@gmail.com>
 <20220209162350.169971-3-alexhenrie24@gmail.com> <xmqqzgmz7v6k.fsf@gitster.g>
In-Reply-To: <xmqqzgmz7v6k.fsf@gitster.g>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Thu, 10 Feb 2022 09:50:16 -0700
Message-ID: <CAMMLpeRf=BV3y2AF7AssOw3tOFn-hawsyhFaxLhCrz28kbq+NA@mail.gmail.com>
Subject: Re: [PATCH 3/3] gitk: set log.graph=false when running `git log`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>, paulus@ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 9, 2022 at 11:26 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> This may handle "gitk", but what about thousands other scripts
> people have developed around "git log", I have to wonder.

That's true, but every new preference carries that risk, and there's
not much we can do about it. Users who set log.graph=true will just
have to accept that it won't be compatible with every tool in the
wild.

-Alex
