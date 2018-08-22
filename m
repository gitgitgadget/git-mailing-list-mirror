Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA2D41F954
	for <e@80x24.org>; Wed, 22 Aug 2018 20:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbeHVX5c convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 22 Aug 2018 19:57:32 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:46563 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeHVX5b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 19:57:31 -0400
Received: by mail-qk0-f194.google.com with SMTP id j7-v6so2135683qkd.13
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 13:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ngm0vRFBliCvz2oiBMnz9HZ1Big036Kf52xTgyFfN14=;
        b=Y6KWux0ya90hmi49nLUGQaGzPxOpccKgu5afORO4ZGLMLnPJ3c+7VAFTB+felKTSL7
         B7oHjY2XqP6U3TfN54n41nJvUxthHjmo7yrpT3FOfP3ldVwz97NizEywtVwmAikBMBgJ
         IruB25S5AaSqsVIfYFvevd2h/o2rkyncyv6YCzKB9VkRcwSHMLQuF4brc5gVZ9jIdh6F
         tes9KyDHzHKd+WDwcZmEjr8RZxqK7nEOxBfQeEmP65GNnEChTRWKTM12aRm6wO60l2m6
         Uxuz+J96Fj+AgaEVyX5PW67O79fC2QlICsylYqe1LBsxMi+GJ6cqd34WVFT+FSHDyxuO
         xNpA==
X-Gm-Message-State: AOUpUlEr45BwRnkdiZrGrQwOEMq1SCHvBT5ldPl1wQxsuP73ZyyiJB6X
        7puBh/KNWiVc/mOdOD/O9zNOzAyjlkMw1otgaeQ=
X-Google-Smtp-Source: AA+uWPwbcTnXYlAzMlkglc7GaiiEkcZFRFUWTYW1Mh/9bQLC3eqk1HvBKXC/GWZvAIiCS/5DxU4VlBLeFW6dhhtzXcI=
X-Received: by 2002:a37:48e:: with SMTP id 136-v6mr25962667qke.26.1534969869257;
 Wed, 22 Aug 2018 13:31:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180727174811.27360-1-avarab@gmail.com> <20180822174820.12909-1-szeder.dev@gmail.com>
 <CAPig+cTQrBmgXQdwQpH7DO2AbraD3B4LiRHDx4Sf9rXg0d_eDA@mail.gmail.com> <CAM0VKjkVreBKQsvMZ=pEE0NN5gG0MM+XJ0MzCbw1rxi_pR+FXQ@mail.gmail.com>
In-Reply-To: <CAM0VKjkVreBKQsvMZ=pEE0NN5gG0MM+XJ0MzCbw1rxi_pR+FXQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 22 Aug 2018 16:30:57 -0400
Message-ID: <CAPig+cS-3OttVT094Hw=RsN5pRvbXq8yekM-zNDXtiKiuvOcjw@mail.gmail.com>
Subject: Re: [PATCH] t6018-rev-list-glob: fix 'empty stdin' test
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 22, 2018 at 2:59 PM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> On Wed, Aug 22, 2018 at 7:53 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > Can you say a word or two (here in the email thread) about how you're
> > finding these failures (across the various test fixes you've posted
> > recently)? Are you instrumenting the code in some fashion? Or, finding
> > them by visual inspection?
>
> Errors from system commands in our tests look like these:
>   grep: file3: No such file or directory
> i.e. lines starting with various system commands' or test scripts'
> names, followed by ': '.
>
> So I've modified t/Makefile to not remove the 'test-results' directory
> after a successful 'make test':
> And then scanned the results of a '--verbose-log -x' test run with:
>   grep -E [...]
> and then, for lack of something better to do ;), I started looking at
> the simpler looking errors.

Thanks for the explanation. That makes a lot of sense.
