Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3E8C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 16:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237661AbiHBQ04 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 12:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiHBQ0q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 12:26:46 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE9337F9D
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 09:26:44 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id x10so13229508plb.3
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 09:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=S2nUhkx+ZMmh0LDzeFw0LUf0HCdPqP8jKoggRv43gzo=;
        b=UdEGUG9uXVVw5kgWTXcl7qxGVO7kKN9uYw7sDmOhY0ZP0rKeqFOF54K5Ly8y62c2tZ
         fJQsG4tAmF9MrkvRJvhfBv0vB2nn4nNQRX30LLYsjcTWVxr404TPsZsQ58Ryz0bWYD99
         2YIaHiDDb5rqXzDMXeMskCAyvyo9oFyoxzdIlk1NI4E4+TM5tjPIJ9b9AQUo38z5fSYQ
         onkkG4rOBliv4gmCRaEu5zGhDZSv4bQp1GRwPC7d1RJIqCyc1H6R1EMQ9WbNPJwXkZjC
         I6B9g9/Ye4LTXsC0KA5bjFfSqPJokWE8NcnUvc/NRB8lk02Y89uQrHUimCLYhmnoVfjU
         xDgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=S2nUhkx+ZMmh0LDzeFw0LUf0HCdPqP8jKoggRv43gzo=;
        b=Y1iRrPoFwSJgUK9+RW7BbYwt5+Levyh9Cjy4QlBKjrevRk8t7XKApRECmHvSVhl9Wp
         LxE9+wFzHDkukso6Wpectdm20xgKzNnLGoY4nLbbTynkCLyu/IOq8qXvpb5VxncwG2WR
         /1nuQQLJRu9qQXL1ukx+owzPp84xkonHscpde9UFMjNPksw86p0Vjnom++8cMwriAbV2
         GyCvpI/f4mK9dXH9kQFhR6nJvt2OGKvu1M/KhAi9yteW0yBGDxah8Qi+hsS/Z7CbpHoz
         NdZV4W5uVPzJJseYbXGvMsfrycAfJqMk6wwEVB+OYnYhsnby+kcIIhv6LSGTT0n3rBoQ
         5pMg==
X-Gm-Message-State: ACgBeo0Ot7sEzYbmSMahBK9+iOVtPQdZ4rfe2/+uXpcVvlpgSwFUhQvk
        jmTuZWFxkOFABinQ8Y6sZKrL
X-Google-Smtp-Source: AA6agR6BBKauINqs3qhiN2zDZXzsTHjyNoiAzsPHv5qFl91LyHgUQ808V+D36CINe1WaeOon+hQCGA==
X-Received: by 2002:a17:90b:3b49:b0:1f4:df09:d671 with SMTP id ot9-20020a17090b3b4900b001f4df09d671mr256593pjb.129.1659457604086;
        Tue, 02 Aug 2022 09:26:44 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id kk15-20020a17090b4a0f00b001f51903e03fsm2651050pjb.32.2022.08.02.09.26.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 09:26:43 -0700 (PDT)
Message-ID: <9fdac51b-ff8c-9564-d349-a71e42708479@github.com>
Date:   Tue, 2 Aug 2022 09:26:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH 3/7] builtin/bugreport.c: avoid size_t overflow
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
 <e8abfdfa892f5670ed411ed6daef26a4ffa1bfe6.1659388498.git.gitgitgadget@gmail.com>
 <220802.86ilnbgzr8.gmgdl@evledraar.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <220802.86ilnbgzr8.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Aug 01 2022, Victoria Dye via GitGitGadget wrote:
> 
>> From: Victoria Dye <vdye@github.com>
>>
>> Avoid size_t overflow when reporting the available disk space in
>> 'get_disk_info' by casting the block size and available block count to
>> 'uint64_t' before multiplying them. Without this change, 'st_mult' would
>> (correctly) report size_t overflow on 32-bit systems at or exceeding 2^32
>> bytes of available space.
>>
>> Signed-off-by: Victoria Dye <vdye@github.com>
>> ---
>>  builtin/bugreport.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/builtin/bugreport.c b/builtin/bugreport.c
>> index 35b1fc48bf1..720889a37ad 100644
>> --- a/builtin/bugreport.c
>> +++ b/builtin/bugreport.c
>> @@ -258,7 +258,7 @@ static int get_disk_info(struct strbuf *out)
>>  	}
>>  
>>  	strbuf_addf(out, "Available space on '%s': ", buf.buf);
>> -	strbuf_humanise_bytes(out, st_mult(stat.f_bsize, stat.f_bavail));
>> +	strbuf_humanise_bytes(out, (uint64_t)stat.f_bsize * (uint64_t)stat.f_bavail);
> 
> Doesn't this remove the overflow guard on 64 bit systems to support
> those 32 bit systems?
> 

It does, but the total disk space available on a system should be able to
fit into a 64-bit integer. I considered adding an explicit
'unsigned_mult_overflows', but decided against it because it's almost
certainly overkill for such an implausible edge case.

> I also don't tthink it's correct that this would "correctly
> report...". Before this we were simply assuming that "size_t" and
> "unsigned long" & "fsblkcnt_t" would all yield the same thing.
> 

The point I was making is that, if your 'size_t' is 32 bits, but you have
more than ~4GB of disk space available on your system, the result of the
multiplication will overflow 'size_t'. So, 'st_mult' failing because it
detects an overflow is "correct", rather than e.g. a false positive.

> But I don't think per [1] and [2] that POSIX is giving us any guarantees
> in that regard, even on 32 bit systems, but perhaps it's a reasonable
> assumption in practice.
> 
> 1. https://pubs.opengroup.org/onlinepubs/009695399/basedefs/sys/statvfs.h.html
> 2. https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/sys_types.h.html

