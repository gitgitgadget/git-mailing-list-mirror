Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC479C433E7
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 18:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99E7F21D81
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 18:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387622AbgJNSOL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 14:14:11 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40647 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbgJNSOL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 14:14:11 -0400
Received: by mail-ed1-f67.google.com with SMTP id p13so410183edi.7
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 11:14:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b5bM4AGDInCZknmpSukKeC+rODdOMoP05S7rUBcW5ek=;
        b=dgC7qDrsdEsuv7Hb+AFRvc2F9plI+6MJirVddvTzT7byHZIfHxcMWVVXpOt4YlLsba
         d5rsJQ6S3XqzEQfVmpdK1ijpIBXphyEcXQPPrbjGTyOdlv2kyq1/IKJv2uLo2XzRL2Ud
         ZLFf+3s9znkZYRnndX/lqvXR8jZ2Fsb8Pqqje4beYem3EpqA9NUDG2ldqCrL4WWVuHGk
         ErOOvnP2zTWZkL7ZplKuewHznh176mLSCET5ovwpPowW4CiTgm6QJsKJv/+i9fAmRvrU
         hYmM/nuLLtq9gFWaqi1ae+bV2syFCs4XblJdZRvC7gNPFK1LaetSlEy1Rj6es7jeG9UY
         XH0A==
X-Gm-Message-State: AOAM5307LY39B05kUjwDo4szvsFyvLx8fIKNoFiQAvRdcylYe1FsFLKi
        meaq7NOvftU1rBfZNzIUoz9ZPytx8NHzI04SfZ0=
X-Google-Smtp-Source: ABdhPJw3o+uctu9YBGKkWVZHvAMcigEWjJQKfRwDDFgfXwJBE/Qz39TBA4A9leJ1lCjMV4Ewzvs40FceXUzCjGcySdA=
X-Received: by 2002:a50:dacf:: with SMTP id s15mr165430edj.71.1602699248547;
 Wed, 14 Oct 2020 11:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201013191729.2524700-1-smcallis@google.com> <xmqqblh5kggd.fsf@gitster.c.googlers.com>
 <CAM4o00es=6bksufcu7UvLfPxSS-9NndD2ALe74PRvQjBdHci5g@mail.gmail.com>
In-Reply-To: <CAM4o00es=6bksufcu7UvLfPxSS-9NndD2ALe74PRvQjBdHci5g@mail.gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Wed, 14 Oct 2020 11:13:57 -0700
Message-ID: <CAPc5daW4oqQHNJJH-jTJNaqiNJDLdtscfvNMpgQUOJhDf-Jj1Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] remote-curl: add testing for intelligent retry for HTTP
To:     Sean McAllister <smcallis@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Masaya Suzuki <masayasuzuki@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I modified it to use echo as the standard, it turns out apache handles
> properly terminating lines for you
> with CRLF.  As for the lone echo, a double CRLF signals the end of the response
> header and the start of the body.  Curl doesn't behave properly without it.

You misunderstood me.  I wasn't questioning the need for a blank line.
I found the inconsistency puzzling that all the previous ones (above)
were done with printf and the later one was done with echo.
