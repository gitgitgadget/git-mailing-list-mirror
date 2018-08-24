Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E47F91F404
	for <e@80x24.org>; Fri, 24 Aug 2018 17:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbeHXVEe (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 17:04:34 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:43389 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeHXVEe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 17:04:34 -0400
Received: by mail-qt0-f195.google.com with SMTP id r3-v6so6182662qte.10
        for <git@vger.kernel.org>; Fri, 24 Aug 2018 10:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6ebQUN/2h7+u0iSBdzFEcv6w5iXHg2EekdEneMjEQS8=;
        b=fylHYENIKRLU89M43RIpTRnZq7rKhqMzkJI3r6+X2atDLf6ACv4WjwJvWZZheTjFyf
         qP0euA5HJRP0lydzHwc99rj9cyp1j0zcai0V0YWqr9DCsR6uj708KHjIfbrmJ7of5jEY
         pLNs5PhkSDOY2fw3hBjvOVpEr2BNcoTAxVYtG+FkJsl/QUVZFYewV0pFkPh1FqiA3jm5
         Q/DLPoeHJNL5iK5mo73IBnKaC6gG90OlX2sBvbrmNyjXVPZtWlURWaq8qu8+ODOh/JVn
         icV3/DcuU07EPucizYENG/Uivy/5F6b8F9OtqFI0Ru1vf2Jcx8BEHSLQZsIJ5hVQbDAD
         Kzzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6ebQUN/2h7+u0iSBdzFEcv6w5iXHg2EekdEneMjEQS8=;
        b=LGKv/fJqCbfZYMvrBHMYflc3ugb0Ijt5pJrMOdaoXmVfuaz1U4odl/StQz5FGbD2ff
         8B37Fha6fCuqZ6fUoZn9gHjzqtKLb3Pab7dUg4PcySvRKm65tbqaUfNVd8YhShLXFQXH
         7ITVDkbEvlf0GwYAiQ1tEL4/BHBF2P2wzMOQIb77TnycJ45KEq6yPdMwF2i6wRBHo1Yi
         2uaX6War3IR+WpE7hd5QqmkjiS86gNnXsqAHmsOqC+pdej7snNGH7BGh1qYG4uPcdVI1
         laNUDFcyOWxJoWDJUGA1SySjsB3jWywbWICedJl/lzcm7ATWewIbWEVMRjF396jJaO7K
         409Q==
X-Gm-Message-State: APzg51CMwluQJmmt8otPKFwH6XxroxRxKEb1CO8RblZQtN1lgFr/FU8r
        dA56Ye7A1+GYhF2qA0IgUkDxGfTp
X-Google-Smtp-Source: ANB0Vdba1Y+x09GiB6kmFJ3Rcn+CyHaVFXHc0bkYJFJbzXcorLIyVTNHHr5DrbuDnaWH1b7eI0oVXg==
X-Received: by 2002:aed:3da4:: with SMTP id i33-v6mr2821303qtf.328.1535131738039;
        Fri, 24 Aug 2018 10:28:58 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id s41-v6sm5342020qta.88.2018.08.24.10.28.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 10:28:57 -0700 (PDT)
Subject: Re: [PATCH v1] read-cache: speed up index load through
 parallelization
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <xmqqin41hs8x.fsf@gitster-ct.c.googlers.com>
 <4c70ea50-5b43-8696-3c46-cf3d658a0ef8@gmail.com>
 <CACsJy8CUPGUhR3girstdqD6YVxOQ6_xE+gacT98KXgqOSPz0dw@mail.gmail.com>
 <20180824155734.GA6170@duynguyen.home>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <3e82ee23-6a04-6714-4d51-68bb2ef4a123@gmail.com>
Date:   Fri, 24 Aug 2018 13:28:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180824155734.GA6170@duynguyen.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/24/2018 11:57 AM, Duy Nguyen wrote:
> On Fri, Aug 24, 2018 at 05:37:20PM +0200, Duy Nguyen wrote:
>> Since we're cutting corners to speed things up, could you try
>> something like this?
>>
>> I notice that reading v4 is significantly slower than v2 and
>> apparently strlen() (at least from glibc) is much cleverer and at
>> least gives me a few percentage time saving.
>>
>> diff --git a/read-cache.c b/read-cache.c
>> index 7b1354d759..d10cccaed0 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -1755,8 +1755,7 @@ static unsigned long expand_name_field(struct
>> strbuf *name, const char *cp_)
>>          if (name->len < len)
>>                  die("malformed name field in the index");
>>          strbuf_remove(name, name->len - len, len);
>> -       for (ep = cp; *ep; ep++)
>> -               ; /* find the end */
>> +       ep = cp + strlen(cp);
>>          strbuf_add(name, cp, ep - cp);
>>          return (const char *)ep + 1 - cp_;
>>   }
> 
> No try this instead. It's half way back to v2 numbers for me (tested
> with "test-tool read-cache 100" on webkit.git). For the record, v4 is
> about 30% slower than v2 in my tests.
> 

Thanks Duy, this helped on my system as well.

Interestingly, simply reading the cache tree extension in read_one() now 
takes about double the CPU on the primary thread as does 
load_cache_entries().

Hmm, that gives me an idea.  I could kick off another thread to load 
that extension in parallel and cut off another ~160 ms.  I'll add that 
to my list of future patches to investigate...

> We could probably do better too. Instead of preparing the string in a
> separate buffer (previous_name_buf), we could just assemble it directly
> to the newly allocated "ce".
> 
> -- 8< --
> diff --git a/read-cache.c b/read-cache.c
> index 7b1354d759..237f60a76c 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1754,9 +1754,8 @@ static unsigned long expand_name_field(struct strbuf *name, const char *cp_)
>   
>   	if (name->len < len)
>   		die("malformed name field in the index");
> -	strbuf_remove(name, name->len - len, len);
> -	for (ep = cp; *ep; ep++)
> -		; /* find the end */
> +	strbuf_setlen(name, name->len - len);
> +	ep = cp + strlen(cp);
>   	strbuf_add(name, cp, ep - cp);
>   	return (const char *)ep + 1 - cp_;
>   }
> -- 8< --
> 
