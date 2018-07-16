Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF91B1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 21:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbeGPWGx (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 18:06:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38502 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbeGPWGx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 18:06:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id v14-v6so3566380wro.5
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 14:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BBEEIIQhwaV598WwIjZqPkDAEY0TQfrDYlvdqeR/DZo=;
        b=DEq0Sk0a03IIFOHWWa5iJOgrqFACNlo/HzTcom/KPbtF8TCmeFqgeePWQnuYjGQB2Z
         /BkMmGDOGnXpm686Qnqaoz55v77dXNMwrE5rv0f19umkc6hTY+joyo45DrU6tXMnaYnJ
         mBUUETVD652J5IcKgnJBeInGdYvcOWAKHuYmocZ/MnHkout3Cc1R8t1CYod6T4jjabqZ
         82rHLnDwKwGzz7VF3ohbgEmaEVfRG/4HDjQy5w47ta4rSUrei4jZdjLjapvvyj3W49Q7
         FgLV1UcZgdfqoimVE1bQ1SPKT+KxDbkSPpCUN62i9T+iHkGwp1Rlf7n19L9/hJEwxywJ
         i70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=BBEEIIQhwaV598WwIjZqPkDAEY0TQfrDYlvdqeR/DZo=;
        b=N1ogd6tZ1Pt04YHNV6tOyFMeJQnipikyT1pXirWgFdSVog7zcSEjbQKSOyRemUj5+7
         14kAGb61g7t6rahYb3JUWtrYb9/v95imCiDGRbmDjl1jmv+b+p+77UEY5WLk8n5Q2GLz
         WBzbiK6WP2i3AhPvQqJe5VkZuf1No2l4bQKWjg1IJxvAiM7T4qov8JcBRRrwhyw6zEoi
         y34uyEZSfPmOi1M4wp1UEBUxd5OtL5jYayuxu/dLn1x5bXNWe6MAfkqk6S3B0qjkPKka
         TZ0MF+TytR7lPPOgenMzbWZvr0Kg2mTUzN0SMLyDJVYN9+id4ITFzqL8odlitVD4RUoJ
         XkBg==
X-Gm-Message-State: AOUpUlGob/B+rzO1L8r1TmBxJIzHJVq1oDYIiXKMd5cnbIp7H99gWUPW
        Cy0IJ4nvOYG00XdobXCmu9c=
X-Google-Smtp-Source: AAOMgpctUk1zLWpogzhjweJs5uyClxj0JoxRioGsrLzWVEr+iZ+vfng5DZVNWYvgZS3ZhFvr2H8hvQ==
X-Received: by 2002:a5d:4cc5:: with SMTP id c5-v6mr13994898wrt.210.1531777053918;
        Mon, 16 Jul 2018 14:37:33 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id i125-v6sm20382378wmd.11.2018.07.16.14.37.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 14:37:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 11/25] t7400: fix broken "submodule add/reconfigure --force" test
References: <20180702002405.3042-1-sunshine@sunshineco.com>
        <20180702002405.3042-12-sunshine@sunshineco.com>
        <nycvar.QRO.7.76.6.1807161641140.71@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.1807161749410.71@tvgsbejvaqbjf.bet>
        <CAPig+cRFeNt9FVDGnbGcp8Bvfh0ohay+p+tLhfx=EFvJg=Q1Sg@mail.gmail.com>
Date:   Mon, 16 Jul 2018 14:37:32 -0700
In-Reply-To: <CAPig+cRFeNt9FVDGnbGcp8Bvfh0ohay+p+tLhfx=EFvJg=Q1Sg@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 16 Jul 2018 14:50:23 -0400")
Message-ID: <xmqq7elusvz7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Jul 16, 2018 at 11:51 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> On Mon, 16 Jul 2018, Johannes Schindelin wrote:
>> > > -           git submodule add --force bogus-url submod &&
>> > > +           git submodule add --force /bogus-url submod &&
>> >
>> > This breaks on Windows because of the absolute Unix-y path having to be
>> > translated to a Windows path:
>> >
>> >       https://git-for-windows.visualstudio.com/git/git%20Team/_build/results?buildId=12365&view=logs
>> >
>> > I could imagine that using "$(pwd)/bogus-url" (which will generate a
>> > Windows-y absolute path on Windows) would work, though.
>>
>> Yes, this works indeed, see the patch below. Could you please squash it in
>> if you send another iteration of your patch series? Junio, could you
>> please add this as a SQUASH??? commit so that `pu` is fixed on Windows?
>
> Thanks for reporting and diagnosing. I wondered briefly if we could
> get by with simply "./bogus-url" instead of having to use $(pwd),
> however, "./bogus-url" gets normalized internally into an absolute
> path, so $(pwd) is needed anyhow to make the test '"$bogus_url" =
> "$(git config ...)"' check work.
>
> So, this SQUASH looks like the correct way forward. Hopefully, Junio
> can just squash it so I don't have to flood the list again with this
> long series.

The topic already has another dependent topic so rerolling or
squashing would be a bit cumbersome.  I'll see what I could do but
it may not be until tomorrow's pushout.
