Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20F5E202AC
	for <e@80x24.org>; Sat,  8 Jul 2017 22:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751782AbdGHW3D (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Jul 2017 18:29:03 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35562 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751021AbdGHW3C (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jul 2017 18:29:02 -0400
Received: by mail-pg0-f51.google.com with SMTP id j186so32342544pge.2
        for <git@vger.kernel.org>; Sat, 08 Jul 2017 15:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=7fH7PduGNxtCIwRntPX62bZaeOU51PZIzKiL+tHcImI=;
        b=lpEs8C7kCcAvb568/TRNdB6sqFmVZhdJNEwrVdCWgG/flnMArQmukmd1y4zcAMpvBt
         YgRkzh/hO4677TNVcK6nx1tsBIgnqwbfrEOgrnfUpnOw6c4fHmuZ409wJGiUHZn/8Qzb
         mvwdXbcjdp2SvRyJ9uJw32Z764BrGVaR/o9lBUEHSIX5WdjhKdVxE+q9pJorzrnmyqfo
         DUR6JtE2GwIy81szfOfISNjOFbnBXlxs6jCX8pBecZexKx5Dex/+AQz6xGZGupMo9ELi
         43YDpBIrlFXGaDhB9PoL/8c4NM3mCzXciJKZu9hsLHMJmp5Qk3nP2o5Kc7bWCIJBUZI5
         uFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=7fH7PduGNxtCIwRntPX62bZaeOU51PZIzKiL+tHcImI=;
        b=YsPziq5NJ2NhSBI+AxPKHE2Z9ffMXMrCPIPWQAsefN+1flOoM0mUC9zky8shpoVcYT
         xHLy3+Hhvs+EOnakE02oQzjx79oaPjgwt1OuEoIEyzodwc8bAiF/17LnSGQiQ46NTNSS
         yuoyyLQhBlFkpPTMK8kielpWrH7nhQw590V5N3MO2kYwvDbBwJH4rNaqOC1KXjdWi3Hc
         Uc5DLGFpGafiPRIp1S8sF+xW8HPqPWnBTHJJwgcguiqiGfxQe6hjpo0Y65DYtV9iTHmz
         VAESeE8wq5M2xM3Bu6H3A1H2zAvx/m/ccSfYhX7h7CGRTn09QldLZ8KoTs4kJ01klEBR
         2bQQ==
X-Gm-Message-State: AIVw110dbwnVfVtzga8ACAJWduzlU7jep2sxBU/6SymD9H9YjpgnXSuF
        HEiGLKJQseD4Tg==
X-Received: by 10.98.21.9 with SMTP id 9mr38014070pfv.234.1499552942052;
        Sat, 08 Jul 2017 15:29:02 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:49f8:bc86:d515:b7dd])
        by smtp.gmail.com with ESMTPSA id s64sm16877859pfd.77.2017.07.08.15.29.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 08 Jul 2017 15:29:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] apply: use strcmp(3) for comparing strings in gitdiff_verify_name()
References: <d1bb978b-a7df-48a8-15c8-80730c77e11c@web.de>
        <d83d2395-e667-9e52-cc94-af5fbec6054c@ramsayjones.plus.com>
        <8bd7c4c6-c545-723b-ec4b-262abd8a7f5f@web.de>
Date:   Sat, 08 Jul 2017 15:29:00 -0700
In-Reply-To: <8bd7c4c6-c545-723b-ec4b-262abd8a7f5f@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 8 Jul 2017 13:52:11 +0200")
Message-ID: <xmqqo9sua7gz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Am 08.07.2017 um 13:08 schrieb Ramsay Jones:
>> On 08/07/17 09:58, René Scharfe wrote:
>>> Avoid running over the end of another -- a C string whose length we
>>> don't know -- by using strcmp(3) instead of memcmp(3) for comparing it
>>> with another C string.
>>
>> I had to read this twice, along with the patch text, before this
>> made any sense. ;-) The missing information being that 'another'
>> was the name of the string variable that we were potentially
>> 'running over the end of'.
>
> Yeah, sorry, encasing that unusual variable name in quotes would
> probably have helped.

What makes it even more confusing is that the variable with the
problematic name is referred to as "it" in the last part of the
description--- the second occurrence of 'another' is actually not
referring to that variable but yet another string that is being
compared with it ;-)

