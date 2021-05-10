Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1640C433B4
	for <git@archiver.kernel.org>; Mon, 10 May 2021 20:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC4F461480
	for <git@archiver.kernel.org>; Mon, 10 May 2021 20:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbhEJUKZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 16:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhEJUKZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 16:10:25 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F28C061574
        for <git@vger.kernel.org>; Mon, 10 May 2021 13:09:20 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id o127so9866072wmo.4
        for <git@vger.kernel.org>; Mon, 10 May 2021 13:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RsuF+actRUHrYqwNdSUQlkfeqDqbTUFw9edAWbISJyQ=;
        b=Q1FiHB+KsJXhF+h5IS24dPBpAe0Q4R/DBT14HojR5poBDLY0OEE0RKmk/Avmqlyqk0
         rrVZ+R2vOtdZDMnn/mfTKx0o3IErki2AhwpZOyEaDD+e/cdwpLxKhQ67n+oDN60aSmyZ
         8aa+z7bY6SITZMjq6NaUM2RElJbO33KX6rh3iwsxS3/GJiUG+9sdfQ8d2mTjB5eLbCTi
         3U6W9rU2S4Mo2OBQ2N8vf5nhOntbiAFZrzVT//IS+TgN6gND3HTxzhp3ucSBurNcvsN7
         XbiH2qDQr08TNC7XPG8LegjfJJ5OCGDOcUJ9+AoOJz5mvNL1R4Fc++FQTwqLo813L4UF
         /ZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=RsuF+actRUHrYqwNdSUQlkfeqDqbTUFw9edAWbISJyQ=;
        b=XlXYWlGBWHSVv8UXa6tnwSgSZzxg1+MtO3UjiKYWBnrw4G/vhAzXgwK5kGR6sRztUu
         IcTIo3uV5NFeFbTeEA9/6ufU63rhuw17IJOKi52iGTSNOMuLS69v23SuU+/G5E3+ACEp
         FBeSuV00Kw/8rRdUI7p7I+79iND7K1EwP7s9WLii0RyrN3aHtONyR4znhicIIF4FhGv6
         U2w+y8zVJ84USiaOrcyg4ytQf2Gki83RBxK7rT2MXPe60QmgA/DPAlsm/3MP+f0nLzED
         j5S2QDZdZHDC+6kCY20/pvQZ1ym5K4jN3mwSDc06YOb6frg3RNRrBq3cfdQZ9kqx4SMx
         MxEA==
X-Gm-Message-State: AOAM531enI5zjfjkNOjRp0rQGcUmwRwQJMMK5iB/t2ya3DGPuVvr9lvM
        +T0e11djoVGX808EQlhpZ+w=
X-Google-Smtp-Source: ABdhPJwYmKE8LHFyXTFure0sa39Dncuv6eIZzqjXHwJuClu3v0OXrzuj1PuK50x3rWaoSv2OvyRm0A==
X-Received: by 2002:a05:600c:350a:: with SMTP id h10mr28818885wmq.119.1620677358666;
        Mon, 10 May 2021 13:09:18 -0700 (PDT)
Received: from [192.168.1.240] (88.22.198.146.dyn.plus.net. [146.198.22.88])
        by smtp.gmail.com with ESMTPSA id j13sm24528243wrw.93.2021.05.10.13.09.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 13:09:18 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/1] maintenance: use systemd timers on Linux
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20210501145220.2082670-1-lenaic@lhuard.fr>
 <20210509213217.449489-1-lenaic@lhuard.fr>
 <20210509213217.449489-2-lenaic@lhuard.fr>
 <3fd17223-8667-24be-2e65-f1970d411bdf@gmail.com>
 <CAPig+cRvs+d-Tv4WyuD967v5Pbfhmwj-ruwyBXhwcR=5chQAmQ@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <72be08d4-1b2d-f400-f99d-c348ae667bdb@gmail.com>
Date:   Mon, 10 May 2021 21:09:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cRvs+d-Tv4WyuD967v5Pbfhmwj-ruwyBXhwcR=5chQAmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric

On 10/05/2021 19:25, Eric Sunshine wrote:
> On Mon, May 10, 2021 at 2:04 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>> On 09/05/2021 22:32, Lénaïc Huard wrote:
>>> +static int systemd_timer_enable_unit(int enable,
>>> +                                  enum schedule_priority schedule,
>>> +                                  const char *cmd)
>>
>> The cmd argument is pointless, it will always be "systemctl" and you
>> have even hard coded that value into the error message below.
> 
> The reason that `cmd` is passed around everywhere is that the actual
> command can be overridden by GIT_TEST_MAINT_SCHEDULER which allows the
> test script to mock up a scheduler command rather than running the
> real scheduler command. I haven't read the new version of the patch
> closely yet, but after a quick scan, I'm pretty confident that this is
> still the case (despite the aggressive changes the patch makes to the
> areas around GIT_TEST_MAINT_SCHEDULER).

Thanks for pointing that out I'd somehow glossed over the 
GIT_TEST_MAINT_SCHEDULER code, I agree it looks like the patch takes 
care to keep it working.

It is outside the scope of this patch but a possibly nicer pattern would 
be to have a function get_command_name(const char *default) that checks 
GIT_TEST_MAINT_SCHEDULER and returns the command name from that or the 
default if it is not set. We would then call that function to get the 
command name when we want to run a command. That way all the extra 
complexity is localized around the command call (and consists of a 
single function call), the usual command name is visible in the function 
calling the command and we'd avoid littering all the function signatures 
with a argument that is only relevant for testing.

> As for hardcoding the command name in the error message, that seems
> perfectly fine since, under normal circumstances, it _will_ be that
> command (it's only different when testing).

I agree, thanks

Phillip
