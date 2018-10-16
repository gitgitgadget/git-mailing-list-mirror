Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC2321F453
	for <e@80x24.org>; Tue, 16 Oct 2018 12:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbeJPUcA (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 16:32:00 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37185 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeJPUcA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 16:32:00 -0400
Received: by mail-qk1-f195.google.com with SMTP id x8-v6so13976629qka.4
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 05:41:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rYHWMtzLpDvPvEQLgBJXxq5t5MP0hl6QtlRtQjNxrxI=;
        b=V+dHkQwSamaNp9lxqs/bdJ5kKCbEtQOWAqCF6jD5vI5pOt+FZFEoQBQrJsP7WSXTcz
         Y/11u6aAoz/EAipOiuSL6YBLRtYdaIn+N4WEJJGqGlwT6FGHGsR0YVFNtLpx9AFmO097
         hzHxFsYMQm1ShCooHD30HQSevQknaeDgTeJVV1uk/5VWc76oH4cHI6+Jal/AjByJTGzl
         +b8wEpMGiqbNouf0QzdpFNrOeo5bL6MtlXwQhfvHXf/hLn8xRGVk4eUObyf5NvpUm73Y
         swja8ZVZh89UnpICIFLkj3hnakpAzJWDZaSu+loVSmah0J/zqghvH9hNUJcQSG7v+nYN
         tkbQ==
X-Gm-Message-State: ABuFfoisXHymPcOhEqCu3Dhhs+9x7A//GUcUbMf3BfxjlWZJXYYgkvLv
        ZblibC1XkWBMY/pjUR/a4RwwFCjw/58eQUxllaE=
X-Google-Smtp-Source: ACcGV63Lq6brGoLH4CY1OwmHqB3q0YcDhk8R71hE68WmqCdsn+5pa5xAd/IJoxL3YE6roxRzSWqIGCkgJNoofhMAHEM=
X-Received: by 2002:a37:8fc7:: with SMTP id r190-v6mr20132566qkd.36.1539693701671;
 Tue, 16 Oct 2018 05:41:41 -0700 (PDT)
MIME-Version: 1.0
References: <pull.45.git.gitgitgadget@gmail.com> <11025b1639785577924b2020fb20d076308e9c69.1539596822.git.gitgitgadget@gmail.com>
 <CAPig+cRbOOrC5_jCnR2ohMZWoYXfNqvWtj3m_JTpudJhV1mQng@mail.gmail.com> <nycvar.QRO.7.76.6.1810161436480.4546@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1810161436480.4546@tvgsbejvaqbjf.bet>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 16 Oct 2018 08:41:30 -0400
Message-ID: <CAPig+cTvKicLKZO38AcVzXJJhZ1CajOhiADotRJ0V7EJXBicUA@mail.gmail.com>
Subject: Re: [PATCH 2/3] getpwuid(mingw): provide a better default for the
 user name
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     gitgitgadget@gmail.com, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 16, 2018 at 8:38 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Mon, 15 Oct 2018, Eric Sunshine wrote:
> > On Mon, Oct 15, 2018 at 5:47 AM Johannes Schindelin via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> > > +       len = ARRAY_SIZE(wbuffer);
> > > +       if (GetUserNameExW(type, wbuffer, &len)) {
> > > +               char *converted = xmalloc((len *= 3));
>
> Oh wow. I *just* realized this. It is an off-by-one: the `xmalloc()` call
> needs to receive `len + 1` to accommodate for the trailing NUL. Will fix,
> too.

Or, xmallocz() (note the "z") which gives you overflow-checking of the
+1 for free.
