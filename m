Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5840C432BE
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 13:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A04AB60FE6
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 13:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236825AbhHRN3m (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 09:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237716AbhHRN3f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 09:29:35 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F79FC0611BE
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 06:28:46 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id d11so2749335ioo.9
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 06:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JJLGVB3HBsWmVLonGOjZUhY+XcgRzK856a91lZgOP9E=;
        b=KaBuxGBKuE2KQbeHUDv4p7Ll/Jz0fziMPqbG4O+963q4LEO3ErGWqSkwG85r8fADwz
         sRfrKx2lfIKZTN476Se7Gx0nRRoG3P9njx24Hf+2L4mYfqDievamu6j5tLvSTyzGZUgn
         8vAkPqwhfxGqHUxHZijFMNqNJZRnckmNjcRFXJO6tEU+s9D/XytuskopCt4ZDtmr24sG
         Eoi6p+bt4v8T1Ukdtd9hOBNKaEoAwwNwN29cz9XHipPWQ0VQaPBVH5BJpmFdY4uYe9h7
         J5BU/uwRxdqXD6Q3CBujHfLGFjdnIJS9ula6TFahuz+DkcI3+ZQs/7JfZ1+JKMDNUcqK
         +grg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JJLGVB3HBsWmVLonGOjZUhY+XcgRzK856a91lZgOP9E=;
        b=hT1d2r6GsejlzJLGeJMOnNlndzKmQS1aUeHzywRqAjnC2j590+v7ghI5qVRHefO+vH
         cRvyPLSO3cpK0MTcepi8ejdTdiQX3aMmUpvUYkw+HBSqL+XjggjHmp/NL7Z6f3S1g4Kq
         A9COm28mxPvK2j9aPycjd1X1Fv9ne9fqhsnWUSJFNBxiIQhA2P5uaWU7eaojVEkQuW6h
         FoFjqS7nI66BxlVJsiwycF4M5ElbRyu/5wzuxI3G1/um+Lm5RTQ8MTA1Vrp4QZjoU2ME
         WnMLAi3CNQNXHPOEsa3TvhtUR9WhQfS9JVZztPlTFlOO02PNI0NSCYJcgOUJ4992YEXj
         oE3w==
X-Gm-Message-State: AOAM533cxSV4K8O4hYPLcgBTpZCQ6AVv7j7WFYyaxsV1coJTI0QoCAoz
        tpkgIppJg2zASYB95dT97/M=
X-Google-Smtp-Source: ABdhPJwGq53Swgf2AZmFCsgkA8XdWcSV+Be/QrCrJSVMF3C4k45XBYfgC+5TCbLRSzLbgdfgtGFIeQ==
X-Received: by 2002:a6b:f416:: with SMTP id i22mr7028405iog.162.1629293325557;
        Wed, 18 Aug 2021 06:28:45 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:581d:96e0:cdbb:9c3d? ([2600:1700:e72:80a0:581d:96e0:cdbb:9c3d])
        by smtp.gmail.com with ESMTPSA id z16sm2913126ile.72.2021.08.18.06.28.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 06:28:45 -0700 (PDT)
Subject: Re: [PATCH v5 0/3] add support for systemd timers on Linux
To:     =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20210524071538.46862-1-lenaic@lhuard.fr>
 <20210608134000.663398-1-lenaic@lhuard.fr>
 <8eb18679-f6d5-b97e-f417-3747bb8309c3@gmail.com>
 <1931213.f5cRXtTDAC@coruscant.lhuard.fr>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <64e595d5-3492-2d3a-eef9-bc6ae881db1c@gmail.com>
Date:   Wed, 18 Aug 2021 09:28:43 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1931213.f5cRXtTDAC@coruscant.lhuard.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/18/2021 1:56 AM, Lénaïc Huard wrote:
> Le mardi 17 août 2021, 19:22:05 CEST Derrick Stolee a écrit :
>> None of that is important if you plan to submit a v6 that responds to the
>> remaining feedback (summarized in [1]).
>>
>> I'll hold off for a couple days to give you a chance to read and respond.
...
> Hello,
> 
> Sorry for the silence. I just happened to be in holiday for the past few weeks 
> and did not have access to my mails.
> I can catch up the discussions I missed and try to address the remaining 
> concerns in a new re-roll.

Perfect! Welcome back!

-Stolee
