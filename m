Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB40C56202
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 19:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 192EB208FE
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 19:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgKXTed convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 24 Nov 2020 14:34:33 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43808 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgKXTec (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 14:34:32 -0500
Received: by mail-ed1-f68.google.com with SMTP id q16so22112545edv.10
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 11:34:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=osae0WGtubmoiPDaGmzAXDI96EmtsgoBL1m/zYiwhQ4=;
        b=tEnxqUKq+cbWkKFHMw0oJNCswv1nspaRxKp6HQcNrYYE1jepYjxk1FRlG5dAaShUdd
         OG+Pz4aVozNdht9wjf1zmwNdbXqDibrlh3u5H+KBPqsoMqMMyQkDWX/ENChgkln/6Oge
         8YFXdwInIUWokKc8nepJokAv7wmbgz1ZgLn3kf06TnOyhjz/vMczDWx07mfsnH6S27A6
         WTgZaOYHRsNagUsIAX8aqSZvvo5eFm4QnPCRDf5bhIxY1gQMPF6g1RLk19OAmUleg8G2
         /mnPADxDi1w2KfQkzZ5fPfHId2YticGE9PBcG40ZJsyycoVW4iDF8SOcv7vGeJTlLLCe
         WyQg==
X-Gm-Message-State: AOAM532/GUaZXk4CVKU0kIsQFeKgW09D07QGafrruCmbNi8lgMYWSJlY
        sFk2GIGmzuXuJ4d+syXpTHRxY7AzW8pRXLxZG/S4NwYggUw=
X-Google-Smtp-Source: ABdhPJxfFwC8y//FtQ7LrBL4UG7jbcn7CrH9JNvXBZ18j+oNHASBNykFH1AdVQDMz7PhEY8RBDpMT/XnchBpdU74buo=
X-Received: by 2002:aa7:dc48:: with SMTP id g8mr23877edu.181.1606246470369;
 Tue, 24 Nov 2020 11:34:30 -0800 (PST)
MIME-Version: 1.0
References: <20201124164405.29327-1-rafaeloliveira.cs@gmail.com>
 <20201124164405.29327-2-rafaeloliveira.cs@gmail.com> <CAPig+cQ-iWVz2Q1PtvbV0hk_HHRFqAFjxAF2DZ6doh2RxpZJhw@mail.gmail.com>
 <20201124191407.GC8396@szeder.dev>
In-Reply-To: <20201124191407.GC8396@szeder.dev>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 24 Nov 2020 14:34:18 -0500
Message-ID: <CAPig+cTnz2rqs4PY0uTaOrySZDR9Jpi2fUL-x5SJzbceZhoY1A@mail.gmail.com>
Subject: Re: [PATCH 1/1] maintenance: fix a SEGFAULT when no repository
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 24, 2020 at 2:14 PM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> On Tue, Nov 24, 2020 at 12:24:57PM -0500, Eric Sunshine wrote:
> >     mv .git save.git &&
> >     test_when_finished "mv save.git .git" &&
> >     test_must_fail git maintenance run &&
> >     test_must_fail git maintenance start
>
> Our test library contains the 'nongit' helper function exactly for
> this purpose:
>
>     nongit test_must_fail git maintenance run &&
>     nongit test_must_fail git maintenance start

Perfect. I forgot about nongit(). Thanks.

I had intended on suggesting GIT_CEILING_DIRECTORIES in my response --
which is what nongit() employs -- but couldn't get it to work for some
reason, so I instead suggested moving .git/ aside temporarily.
