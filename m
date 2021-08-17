Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D59FC4320A
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 19:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3413610A6
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 19:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbhHQTnz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 15:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbhHQTnu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 15:43:50 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694D5C0617AE
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 12:43:16 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u16so13154493wrn.5
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 12:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5Ei7PL28YSqWzlNaOTnkuP1Kj+TqsldVAbExz1cuFE0=;
        b=RCUY0A5SdRUGMNwuXaKB8lzs12xG98sJmXUeM9g7PRtmudSFlbH0drf/alHfucMNoA
         PjMPTmXja/hczAxWIsBxL4b3dYQ1xej4k6sjb1807v4wn8yOu1+JCKwQKRD2SsCd0rIU
         jU2R+F5PcWL8WqsuuUW401Uq3tw1WcimndVj4UPNX+xg8gMYGwW20SfdAoWyMikhP2pd
         JWfbmOGXLEBHZxDT7xE5Zww3n0lPnuCPKW+phfqRDylUtrzVYotqOn1PFD2jzXQXleTF
         3sGWavs4XO1AYYsUvnRZ30PcuHF3hayIHRXtV5nMFFGe2tPF5t3gQ45n1/aM58aeaqH0
         KT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5Ei7PL28YSqWzlNaOTnkuP1Kj+TqsldVAbExz1cuFE0=;
        b=UjTqXXR0Pvc5thN2W1QlhNFjPB/P7XH5eGxyU3O0r83Cb/D5H3JwfuFO2qliH11Yza
         49jaUMkk5H1/U0qPeHqsXS1m/RX1SVy10ztMfrwkroiN6ciLNaP6oXL1QOQ3Qy35Kz/8
         H5Udci7BeH5RX3fFRjnYco0qBHXav1IMhxVT6SG5PQelMPZ/rFpbxqlihydOwKL+eoua
         kuL8CS37ZW41E8nHVgLxDwVwKcSHy0pWUUeiWeApN9HwMnABgRLtcb3qsieOJxCotUc9
         ICo4MpW1ESj8IgXIm5oonZNNYxFknZpyhhOE46S090iRSit9s88e6jCSvGmjDY6Fb7n3
         1jWQ==
X-Gm-Message-State: AOAM533+9bq3aE7vow0Iz3lt34SzVIVBIgkSFncF8964aLExE1gBR8YC
        jSyKhzAw2dFfZ0Tjh/ZNi8w=
X-Google-Smtp-Source: ABdhPJyIcADCYF79wKzkk3zytVYi+CZRnOJbALslAlbSphsegjw18RNeccOWnGybnVIy/20gH/+xFA==
X-Received: by 2002:adf:cd10:: with SMTP id w16mr6414320wrm.404.1629229395070;
        Tue, 17 Aug 2021 12:43:15 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id t8sm4054956wrx.27.2021.08.17.12.43.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 12:43:14 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 0/3] add support for systemd timers on Linux
To:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20210524071538.46862-1-lenaic@lhuard.fr>
 <20210608134000.663398-1-lenaic@lhuard.fr>
 <8eb18679-f6d5-b97e-f417-3747bb8309c3@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <86d8fede-5ae6-6c5c-05dd-91373cb9f4c3@gmail.com>
Date:   Tue, 17 Aug 2021 20:43:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <8eb18679-f6d5-b97e-f417-3747bb8309c3@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/08/2021 18:22, Derrick Stolee wrote:
> On 6/8/2021 9:39 AM, Lénaïc Huard wrote:
>> Hello,
>>
>> I’ve reworked this submission based on the valuable feedback I’ve received.
>> Thanks again for it!
> 
> Hi Lénaïc!
> 
> I'm replying to your series because it appears you did not see our discussion
> of this topic in the What's Cooking thread a couple weeks ago [1] and might
> miss the discussion that began today [2].
> 
> [1] https://lore.kernel.org/git/4aed0293-6a48-d370-3b72-496b7c631cb5@gmail.com/
> [2] https://lore.kernel.org/git/7a4b1238-5c3b-4c08-0e9d-511f857f9c38@gmail.com/
> 
> The proposal I give in [2] is that I can forward-fix the remaining comments
> OR re-submit the patches with a new patch and some edits to your current patches.
> (You would remain author of the patches you wrote.)
> 
> None of that is important if you plan to submit a v6 that responds to the
> remaining feedback (summarized in [1]).

I think you mean v8, v7[1] is what is in seen at the moment. There was a 
suggestion at the time that a v8 would not be needed[2]

Best Wishes

Phillip

[1] https://public-inbox.org/git/20210702142556.99864-1-lenaic@lhuard.fr/
[2] https://public-inbox.org/git/YO0O9JHtnYrk9qRm@coredump.intra.peff.net/

> I'll hold off for a couple days to give you a chance to read and respond.
> 
> Thanks,
> -Stolee
> 
