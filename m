Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C172DC433DB
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 02:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BE18239D4
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 02:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730222AbhAOCjS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 21:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbhAOCjR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 21:39:17 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E154C0613CF
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 18:38:37 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id v126so10417769qkd.11
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 18:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bYQOlo1aGa9ukZ2Ztk0hXYRmlYsvOyq1Y9aMtKpvygg=;
        b=RettPfUMNWr6xWX6YUrzQJT2gbXHO3qwlP8eZBbupcCXYg3NUY1VlMKve5GSijtGTO
         8yvguMbxZo+kcRKsZTY8T+cUNnsMOyM/xkqbOC09RDs2rYCEYjvJ2hnLsZwQLnroZYK0
         xDOQcVX/eZbpnFE6Y8pn+Ka9Yjo0dF0Ke2s9/EzpsylOUKitdVh4P6FUs71If6JzcK9v
         1M0gISVMtGHVWXWRX4vSjrqtC++YP0yrmnArZHv8NMYf8W++UDxphQLDAcXn2IfS0tjw
         8VyaI1bUjh/zFrwDEbfpQR6/6YmdAJe/E2r0mcmqJi460V4VUnYxGTbx8JszXgcXsr0W
         WvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bYQOlo1aGa9ukZ2Ztk0hXYRmlYsvOyq1Y9aMtKpvygg=;
        b=DhVWw/+R3buL2iQcpfUOccD9DWCrrF0DT/LIVj/Bm/lTEYf/yoUoj6OdjNax8zwHQp
         CYKqC7SBguxat1aDdqMNnsZD6tfYTh++G5LKn1bnZi+UX9jXjEjd6AScTcTEGMXOA//P
         obVFwEDwXjrZfOnN5nVjgbYi4Kb5PeUhk63v1i8zJsnHNDSfNYWKCQ/ZRn83IaYcxVt1
         hERvzLEgPetaLvuNC9FG0b0NA31vT8TKqt2iHP6U08EDVTPgZciRNHpfEQPUn+X7WXVJ
         qS2q7wcOJOvoXIFtMRQR1WsA5fBtds01zfmW/4EZd4SKRwH1u+gVOS+WdDVYVif8LQx7
         Un0g==
X-Gm-Message-State: AOAM533UHoOWkM5AxzBuvT2qu9gu625GdwGZlROjqKF9lsxm/OgqJBwH
        4/TFCG98C6FKhHc0+Fzv/X0=
X-Google-Smtp-Source: ABdhPJw5VsgcVwxMbusbdH8xraRooYCC0P/HkWyMBDwqdlgKlTBF8XdHLr7EDUvEX1vgCnpp7f0vrQ==
X-Received: by 2002:a37:aa57:: with SMTP id t84mr10812597qke.348.1610678316855;
        Thu, 14 Jan 2021 18:38:36 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id a22sm4174525qkl.121.2021.01.14.18.38.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 18:38:36 -0800 (PST)
Subject: Re: [PATCH 01/22] mailmap doc: create a new "gitmailmap(5)" man page
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <20210105130359.21139-1-avarab@gmail.com>
 <20210112201806.13284-2-avarab@gmail.com>
 <a71860ee-6810-8766-b9c7-4c03ea7e6e01@gmail.com>
 <xmqqk0sfxpd4.fsf@gitster.c.googlers.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <6612514d-051a-1e58-7ea1-c00428882f2d@gmail.com>
Date:   Thu, 14 Jan 2021 21:38:35 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <xmqqk0sfxpd4.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

Le 2021-01-14 à 14:58, Junio C Hamano a écrit :
> Philippe Blain <levraiphilippeblain@gmail.com> writes:
> 
>>> +SYNOPSIS
>>> +--------
>>> +$GIT_WORK_DIR/.mailmap
>>
>> This should be GIT_WORK_TREE, gitmodules(5) is wrong as GIT_WORK_DIR
>> does not exists (my series at [1] fixes this).
> 
> Well spotted.
> 
> Can you make the suggestion into a follow-up patch to the
> series to be applied on top?
> 

I just sent [1] as a fixup! commit (is that what you meant?)
I was not sure...) I feel it is cleaner for that commit to use
the correct variable name from the start, hence the fixup.

Philippe.

[1] https://lore.kernel.org/git/87zh1b51xk.fsf@evledraar.gmail.com/T/#m9e8e8f5458db71153c2363acf4bff959df7d0f4c
