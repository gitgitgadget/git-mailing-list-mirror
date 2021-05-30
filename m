Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C91BC47089
	for <git@archiver.kernel.org>; Sun, 30 May 2021 10:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E1A960FDA
	for <git@archiver.kernel.org>; Sun, 30 May 2021 10:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhE3KSW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 06:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhE3KSV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 06:18:21 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAB3C061574
        for <git@vger.kernel.org>; Sun, 30 May 2021 03:16:41 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id n4so7774080wrw.3
        for <git@vger.kernel.org>; Sun, 30 May 2021 03:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CHkU3Ux8d9dkjuW78bTL8CnhZiR8IAfb7kHoaIvOwb8=;
        b=BaNQPQEYmgMQpVGgvCT8CO+0aw8zyB3bzL58ij0XoqsM4IcNpoJqiVsdtg2RI4+dHX
         9gSxd97YV1d5KikJoN0kwsqiY7uv1Sot4qn4Gp/ExBQ6N0ELIuqUgCn/SKzKjo/Yz7zk
         ZzrJ9K3Vkdi9lBPxxqaK+0MkxFdD6UH1D93EXgrZg5SEJubC5Dod6I68JPa3o8/HK1AY
         g3kkHvcMViCGG0jp6zXEaZtgUnE0EjzAU9IoVTGzO4Y+5TLPuYeOJxYHSPQyhaPOtzmv
         ftTem6URXVvYt7TvFf35lGK5TfmJr6G8odgDgTnzYxedrn7bheMLN6bAhQdCXSA5b+IF
         H4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=CHkU3Ux8d9dkjuW78bTL8CnhZiR8IAfb7kHoaIvOwb8=;
        b=QzhcttQdD9dEzUkhuuLJKZNwEmM8xC64UlX3Fn3npSr174ZlP/W2g9TGbcGCUvBso0
         60hMHM5iTM3qjMzjTfg2zjsLE7sg9+x9Qm8GUj45cUCsSDOPGq6m7TDtXgqZyL9iWFS8
         JrcMA3TYVBt0AOBSiYSyp23A1P19TeVhbLv10adgpTRWyXXsBeXsVAGpS4tZyTRCoZ+m
         fWHElArqvm/NLnzBOpLpggrmrVaIwyg+36GT8ZfYvjhpxHIw2C1eUd+DWX7fH7MDS1NV
         KfbQPYN782H8NtX9uNmEU+6BkI2h28AmeaEl7cwDq+rJNUlAZsFm5B0h6MAdKUtV4VrY
         IEqA==
X-Gm-Message-State: AOAM531TSyrpwm7DN1rWkp6E5IuBUPdHIIWHHmGpNhMArqNxUiB0Gxwf
        bftvgwwukoodbmGCxWlUpN0=
X-Google-Smtp-Source: ABdhPJyYc7S/OwRElufrlpeprJ7z8iWZqO0yJnqwoLtSQrTaOIjHHShjkhNiLN29UVmorTvqqFTISA==
X-Received: by 2002:a5d:6b43:: with SMTP id x3mr17129132wrw.263.1622369800320;
        Sun, 30 May 2021 03:16:40 -0700 (PDT)
Received: from [192.168.1.240] (11.22.198.146.dyn.plus.net. [146.198.22.11])
        by smtp.gmail.com with ESMTPSA id n13sm14275955wrg.75.2021.05.30.03.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 May 2021 03:16:39 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 3/4] maintenance: `git maintenance run` learned
 `--scheduler=<scheduler>`
To:     =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
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
References: <20210520221359.75615-1-lenaic@lhuard.fr>
 <20210524071538.46862-4-lenaic@lhuard.fr>
 <ce0e096d-cd82-800a-9ef5-5bcc4b25046d@gmail.com>
 <2953592.SyOBHIlnlS@coruscant.lhuard.fr>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <295e8a2c-913f-ec53-0865-d3153c54b9cc@gmail.com>
Date:   Sun, 30 May 2021 11:16:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <2953592.SyOBHIlnlS@coruscant.lhuard.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Lénaïc

On 30/05/2021 07:39, Lénaïc Huard wrote:
> Hello Phillip,
> 
> I’m working on the next iteration of this patch, but I would have a question
> about one comment of the review.
> 
> Le lundi 24 mai 2021, 12:12:10 CEST Phillip Wood a écrit :
>>> -static int maintenance_start(void)
>>> +static const char *const builtin_maintenance_start_usage[] = {
>>> +	N_("git maintenance start [--scheduler=<scheduler>]"), NULL
>>> +};
>>
>> I'm not sure what the { } and NULL are doing here, it should just be
>> assigning a string. You could put it inside maintenance_start() and just
>> call the variable "usage"
> 
> I did this because `parse_options(…, usage, …)` expects a NULL-terminated
> array of strings and not a single string.

Oh sorry I got confused by the definition of builtin_maintenance_usage 
which is just a string but cmd_maintenance() uses usage() rather than 
parse_options() which has a different api.

> While I agree that this variable doesn’t need to be global as it is used only
> from inside a single function, I followed the pattern that I saw elsewhere.
> 
> For ex. `builting_gc_usage` or `builtin_maintenance_run_usage` in `builtin/
> gc.c`.
> 
> In fact, we’re even told to do so in `Documentation/technical/api-parse-
> options.txt` which says:
> 
>      . define a NULL-terminated
>        `static const char * const builtin_foo_usage[]` array
>        containing alternative usage strings
> 
> In the files that I looked at, the command usage was always defined as a global
> long-named variable even if it was used in a single function.

Yeah, I'm not sure why that convention has built up. If there is a 
single command in a file then defining the usage string at the top of 
the file arguably acts as some form of documentation but when there is 
more than one command in a file I'm not so sure. Anyway feel free to 
leave it as it is.

>>> +static int maintenance_start(int argc, const char **argv, const char
>>> *prefix)>
>>>    {
>>>
>>> +	struct maintenance_start_opts opts;
>>> +	struct option builtin_maintenance_start_options[] = {
>>
>> As this variable is local to the function you could call it something
>> shorter like options.
> 
> I agree.
> I also followed the pattern that I saw elsewhere.
> For ex., still in `builtin/gc.c`, there are `builtin_gc_options` and
> `builtin_maintenance_run_options` which are local variables, but still defined
> with an explicit and unique long name.
> 
> So, I’m wondering if I should follow the existing pattern or if I should
> shorten the name of the local variable.
> I thought the existing convention could be useful when grepping for option or
> usage of a command in the code ?

It's up to you, personally I'd lean towards a shorter name defined in 
the function where it is used but if you're following a existing pattern 
then that should be fine too and would mean that you don't need to spend 
time changing what you've got already.

Best Wishes

Phillip
