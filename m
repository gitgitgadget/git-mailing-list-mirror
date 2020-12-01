Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF05C64E7B
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 21:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FCB520705
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 21:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgLAVRE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 16:17:04 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43095 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbgLAVRE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 16:17:04 -0500
Received: by mail-ed1-f68.google.com with SMTP id q16so5549056edv.10
        for <git@vger.kernel.org>; Tue, 01 Dec 2020 13:16:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6icCiUWI8VlQ7cPVMd9MFaI4tymzeu89LVDbeyshUtI=;
        b=Ka1AVqE7qmeH46NPpePhfBjcQTSY6AsvfUHcGiYlO0DdphNO5gozbqlUkIiw6mhY85
         pF7Ti090tw1Qdk3LeDIBqWJfAtWHy/dIwhapkoNUY/IgrBgYS7yKE6tpe2H9pKJ9Tf8y
         6FiuT7mGMuttDnbj0uW0RiR64hFEr6v1qS2CeFx2HZiMQJ2GkuVKibuS5V/W4T9UuWH8
         DK4mWbCTsdUFDhf+jBLw/4P6rb5S7Z6LyYllIp/gNwH8IwU2QxWGNz1Fr/Gwi8tqIXQ9
         i+xvLDmSt9k7X6geyT8jT4Da3JO/UoUvYphut73cSC3A9eDzr2OAeDx2K+T9Osdslu77
         LPIA==
X-Gm-Message-State: AOAM532hM52+9wDTAB6V+E5p6g+ysuAAM5jme47vgnSpZ7wz3vlHlmjH
        AHmhb1K804FkrYa1cCiSC8UUGNM75RRrSpLu2N6MMaMIOVE=
X-Google-Smtp-Source: ABdhPJwTb4LZ1QE89SqvyRIsGCAvIfNeFB16DBZuVY15NY/g/NbcARnilx4wmzbMY77Pp8QLdbPaO//CBRQ9YF8jDZk=
X-Received: by 2002:a50:a689:: with SMTP id e9mr4984504edc.233.1606857382709;
 Tue, 01 Dec 2020 13:16:22 -0800 (PST)
MIME-Version: 1.0
References: <X8aMt2LEiCLkdV9/@nand.local> <20201201211138.33850-1-gitster@pobox.com>
 <20201201211138.33850-2-gitster@pobox.com>
In-Reply-To: <20201201211138.33850-2-gitster@pobox.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 1 Dec 2020 16:16:11 -0500
Message-ID: <CAPig+cROG5+khWvBWbWgVhNuDyWkCQYBXwte5VeazuCCXMAA_g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] banned.h: mark ctime_r() and asctime_r() as banned.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 1, 2020 at 4:12 PM Junio C Hamano <gitster@pobox.com> wrote:
> The ctime_r() and asctime_r() functions are reentrant, but have
> no check that the buffer we pass in is long enough (the manpage says it
> "should have room for at least 26 bytes"). Since this is such an
> easy-to-get-wrong interface, and since we have the much safer stftime()
> as well as its more conveinent strbuf_addftime() wrapper, let's ban both
> of those.

This still needs a s/conveinent/convenient/ mentioned earlier[1].

[1]: https://lore.kernel.org/git/CAPig+cT=gMEuKkbJefT9yxWWB5VC1fj6T+ofjn_saEEeEeU_MA@mail.gmail.com/
