Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917ADC433DF
	for <git@archiver.kernel.org>; Mon, 18 May 2020 18:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72E2920643
	for <git@archiver.kernel.org>; Mon, 18 May 2020 18:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730820AbgERRvH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 13:51:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44392 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730804AbgERRvG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 13:51:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id 50so12850502wrc.11
        for <git@vger.kernel.org>; Mon, 18 May 2020 10:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zXj8h2aC7cxasjVTPt54lQrz/ZptE7qrapT07U4vNlA=;
        b=Dq9Dt1msVL4Tb/uk8jyYiEEuiEMwVAfVcoUyDYZoUQD0mopR9UkgsVMxmGbE4tq6Aj
         GUhthJjy9aiWzO2LrHmxeJUFLTST7w9JpwiQ6vBIx6D45bEHBir93p3DkuQ5/5vL8ViW
         3tS4NaPizujHz81YxMnx7FP/FZzk6VnjyE5si1/20oty0b3avTR1Wfo8Va5OQQsx7qqq
         P7WnHA2OxgDTG0wVWq8TuGYG6Fqvj35E8wY+UFTnkjjp1/SZme8NmJQk/A8wQXVObnD+
         O9naM+/wPsWl1vs6ms6Fuz2VqOydAdnLp7C1lUUMsKEXY9pyL/V/rZs3066LNCqw5z/c
         7cbw==
X-Gm-Message-State: AOAM531cEhh9tHySpHdXBg/mlfcDhkcyf3va7wveMW2jeAbn6TVUhAsg
        G5Gvp3f0PsHOjtK7Os5YpgLRKn79u5T39PxYRICNuU6F
X-Google-Smtp-Source: ABdhPJx7F6wpDAMQW7y17VLQ7Keo60bg3c7vphnnxxWI/9chLwEB/72XU0+hfShiFxnTvgzv16Wu2+TIyJ8MyFPUFtI=
X-Received: by 2002:adf:f786:: with SMTP id q6mr20720411wrp.120.1589824264012;
 Mon, 18 May 2020 10:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589393036.git.liu.denton@gmail.com> <cover.1589816718.git.liu.denton@gmail.com>
 <c2b9d033bb774d3bccb572802c3ae114cad8d830.1589816719.git.liu.denton@gmail.com>
 <20200518160425.GA42240@coredump.intra.peff.net>
In-Reply-To: <20200518160425.GA42240@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 18 May 2020 13:50:52 -0400
Message-ID: <CAPig+cQhZyyQ05B3xF1EkK0hpF8bXMbbPEJXGUdTkoZ5JaHO=Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] pkt-line: extern packet_length()
To:     Jeff King <peff@peff.net>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 18, 2020 at 12:04 PM Jeff King <peff@peff.net> wrote:
> On Mon, May 18, 2020 at 11:47:21AM -0400, Denton Liu wrote:
> > Change the function parameter from a `const char *` to
> > `const char linelen[4]`. Even though these two types behave identically
> > as function parameters, use the array notation to semantically indicate
> > exactly what this function is expecting as an argument.
>
> > +/*
> > + * Convert a four hex digit packet line length header into its numeric
> > + * representation. linelen should not be null-terminated.
>
> Minor nit, but it is perfectly fine if there is a NUL. Maybe "linelen
> does not need to be..."?

I had the exact same reaction when reading "...should not be
null-terminated", however, I'd prefer to drop mention of
NUL-termination altogether since talking about it merely confuses the
issue since it is quite clear both from the declaration (const
char[4]) and the documentation "four hex digits" that 'linelen' is
expected to contain exactly four hex digits and no NUL character(s).

By the way, I find the argument name "linelen" highly confusing; every
time I read it, I think it is an integral type, not a string or
character array. I'd very much prefer to see it renamed to "s" (or
something) or dropped altogether:

    int packet_length(const char[4]);
