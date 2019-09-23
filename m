Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 641D81F463
	for <e@80x24.org>; Mon, 23 Sep 2019 09:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405796AbfIWJao (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 05:30:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33411 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405705AbfIWJao (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 05:30:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id b9so13131517wrs.0
        for <git@vger.kernel.org>; Mon, 23 Sep 2019 02:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q8G5sGEpQXzjcHkHBevJhk5ao2Z1EH9iTa/jz8SQGtI=;
        b=Wx+ywSCASsH9GeFjN+LC2yI6gm/CLhAGIhM9Ko09hbys8oN/1I+JgfmdFwV+76wRHk
         DLynyhXKQyDWaTRV/nMT3xVs6trkaJ93qNcyTb4/Pnb9Osi4r1NjSZ/wt7WZ0p1bzx2V
         Xx83khPDttbd1CyfSqxq1g1X6mbgUvk0NURzrYB/7pDwNvbrODFjELUo5IXF0tJMyiYK
         bNcmdCuZ8Vtgy8sp260pOrhehUBfarA3IbTcigxLXoCa+z2c4zU1ViwI3ah0oYCIm4rG
         RH3uOWg3SDUgRUXM4OLlcVZFoFAGqTZ8QjTQAMCAmVB54SamoTS3VbJvMCM1aQs9irdd
         qn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=q8G5sGEpQXzjcHkHBevJhk5ao2Z1EH9iTa/jz8SQGtI=;
        b=YO3Vxt/iS7WiCvkoDll2QYv+NJVScqGG8cKdjGoSlNQmNQhp/vrYwzH2Ac7JNKuoCB
         vjHveS/XOi3JF345lXIjUv76TfMsZGfL8//QQI1ycR0g9f7ooYD7xKJDy3MfNyFBAYe9
         wcuk+iJOGG/8TfbgfYInJJe70T+72xx9zfwHZNJlUzPVHMniuUHwZzsGO0cGZe3iGiv9
         TSWX1bCpwzAkWe0thnIKWKd/3a87Dzg58BUUaJK8NYqpV/VxN6MgGRe/ieuz1EQrwk94
         HFaXr5EDDgMVz98gJjyv7z9tMGGILmjL5XHl4Wd2nTc0f+DKItoxQB88ePZ5t1mtD70C
         86XQ==
X-Gm-Message-State: APjAAAVbNV+v0FE5odCF35RJAVB0ujAyb4rxWMFjKsKV6rlheGY/a/UN
        1Pvi+s6Gclj/7P+TQNEhzn31XZXl
X-Google-Smtp-Source: APXvYqyQjY8bTYQ7HMDCpvB8AmvCLMuCzjitmYIyKZyNiiqCs/eUuKxoPBv68h6dTO7ZqfcBW0dMbA==
X-Received: by 2002:adf:ab0b:: with SMTP id q11mr20765433wrc.336.1569231042105;
        Mon, 23 Sep 2019 02:30:42 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-10-31.as13285.net. [92.22.10.31])
        by smtp.gmail.com with ESMTPSA id t6sm16303925wmf.8.2019.09.23.02.30.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 02:30:41 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] name-rev: avoid cutoff timestamp underflow
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Cc:     phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
References: <20190922180143.25026-1-szeder.dev@gmail.com>
 <5692e751-ae5b-e1c8-e5f7-79f0b43e20c0@gmail.com>
 <20190922195312.GC10866@szeder.dev>
 <8e7617ef-85d0-df3f-4418-5a2502b8e726@kdbg.org>
 <20190923083723.GD10866@szeder.dev>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <9c89a930-cf55-6d11-e801-cfcbb2a8a6fa@gmail.com>
Date:   Mon, 23 Sep 2019 10:30:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190923083723.GD10866@szeder.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/09/2019 09:37, SZEDER Gábor wrote:
> On Sun, Sep 22, 2019 at 11:01:26PM +0200, Johannes Sixt wrote:
>> Am 22.09.19 um 21:53 schrieb SZEDER Gábor:
>>> On Sun, Sep 22, 2019 at 07:57:36PM +0100, Phillip Wood wrote:
>>>> On 22/09/2019 19:01, SZEDER Gábor wrote:
>>>>> +/*
>>>>> + * One day.  See the 'name a rev close to epoch' test in t6120 when
>>>>> + * changing this value
>>>>> + */
>>>>> +#define CUTOFF_DATE_SLOP 86400
>>>>>   typedef struct rev_name {
>>>>>   	const char *tip_name;
>>>>> @@ -481,8 +485,13 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
>>>>>   		add_object_array(object, *argv, &revs);
>>>>>   	}
>>>>> -	if (cutoff)
>>>>> -		cutoff = cutoff - CUTOFF_DATE_SLOP;
>>>>> +	if (cutoff) {
>>>>> +		/* check for undeflow */
>>>>> +		if (cutoff - CUTOFF_DATE_SLOP < cutoff)
>>>>
>>>> Nice catch but wouldn't this be clearer as
>>>>    if (cutoff > CUTOFF_DATE_SLOP) ?
>>>
>>> It would only be clearer now, with an unsigned 'timestamp_t'.  I
>>> tried to future-proof for a signed 'timestamp_t' and a cutoff date
>>> before the UNIX epoch.
>>
>> Huh? For signed cutoff and positive CUTOFF_DATE_SLOP,
>> cutoff - CUTOFF_DATE_SLOP < cutoff is ALWAYS true. Signed interger
>> underflow is undefined behavior and signed integer arithmetic does not
>> wrap around!
>>
>> IOW, the new condition makes only sense today, because cutoff is an
>> unsigned type, but breaks down should we switch to a signed type.
> 
> Yeah, that's what I meant with worrying about signed underflow in the
> commit message.  As long as the cutoff is at least a day later than
> the minimum value of our future signed 'timestamp_t', the condition
> does the right thing.  And considering that oldest time a signed 64
> bit timestamp can represent far exceeds the age of the universe, and
> the oldest value of even a signed 32 bit timestamp is almost half the
> age of the Earth, I wasn't too worried.


It's still going to trip up static analysers though isn't it? Also it 
will confuse readers who have to reason that it does not overflow in 
practice as we (probably?) never use very negative values

Best Wishes

Phillip

>> You need this on top:
>>
>> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
>> index a4d8d312ab..2d83c2b172 100644
>> --- a/builtin/name-rev.c
>> +++ b/builtin/name-rev.c
>> @@ -487,10 +487,10 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
>>   
>>   	if (cutoff) {
>>   		/* check for undeflow */
>> -		if (cutoff - CUTOFF_DATE_SLOP < cutoff)
>> +		if (cutoff > TIME_MIN + CUTOFF_DATE_SLOP)
>>   			cutoff = cutoff - CUTOFF_DATE_SLOP;
>>   		else
>> -			cutoff = 0;
>> +			cutoff = TIME_MIN;
>>   	}
>>   	for_each_ref(name_ref, &data);
>>   
>> diff --git a/git-compat-util.h b/git-compat-util.h
>> index c68c61d07c..1bdc21a069 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -344,6 +344,7 @@ typedef uintmax_t timestamp_t;
>>   #define PRItime PRIuMAX
>>   #define parse_timestamp strtoumax
>>   #define TIME_MAX UINTMAX_MAX
>> +#define TIME_MIN 0
>>   
>>   #ifndef PATH_SEP
>>   #define PATH_SEP ':'
