Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EDFE1FC43
	for <e@80x24.org>; Fri,  6 Oct 2017 14:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751528AbdJFOlP (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 10:41:15 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:38455 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751487AbdJFOlP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 10:41:15 -0400
Received: by mail-qk0-f193.google.com with SMTP id 17so5074023qkq.5
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 07:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=vobG7ZP/XUAgvcfPEoHZgFvA7w8MUAQc/MvYcRGfoNs=;
        b=ETxWcG+0QMoKMIshmyAOuWAmA2MOuWM5CYO0OHTWbQQx2g+30IhNlTCQk+XImS0CHw
         ss+y6mdEDraNqf487rgMOry31W5cPGmOvbpqer63H6hXxuHJecjf8S1bS6nsUBG3p+fF
         T4hVChR+FRBIejP9qXg254ukHfAYD6lzhDGrnNv+J1PIrrElpHnoSol/ULgvUyaAbsK1
         BduZTZQzwa/U6HlTYvMqLrQsBzgEMiTXV07awrJ8DLYzoqbeVAfdqz3ryRe4/BvqJvpg
         43DrA7hnE3XEh06wj8GnieqJeNECxCLquk3zkaVA/j75Y3oQak0VK7zq5OaERF8J/46c
         Desw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=vobG7ZP/XUAgvcfPEoHZgFvA7w8MUAQc/MvYcRGfoNs=;
        b=CF9wMx9VwjSN+DIVNaTcXzwP4rZNlrFeGonRr+DLgNX84zKiAqLtoT8IdHGtLdX0o7
         sOsV/j3nP6dpJGH/N+49ZvacrzUHV8HfYxmso+JclB+XajP4wBuH4a+xIUrB0Z8zu4Yf
         v3OdzvgGmpxAohg08ZG8I7eWOAcRwLT+d5bBhD/k20LmHgNdft9DPi/umU4Iru0j1xi8
         lxchcfEXxbKJGjOvFLX/jDyQ8RuL5ob/c5o+2+livFxQZ1Ak5XLlCI1dtppkw7VM8e8c
         tiFPAPMlQ6X32DmsnWqsDddu5el0U5aDBO6cOQBL88OdrfbCYFaiEqLPDXIk3dhkU9f/
         25TA==
X-Gm-Message-State: AMCzsaUa6D+igaFvzBZnPvMKfIAjbTSOf8LUkq2hL04h3r1uMvhox+Kc
        kj0T7IkbwVnaCev1MfiZviE82Qsh
X-Google-Smtp-Source: AOwi7QCyE77C5s7Z2zAe7+ecg1MKsaK1N/mlZ2Q5DpRo+dzcw7biV28+NruwhDWobCf/TvJ56pf1cw==
X-Received: by 10.55.187.133 with SMTP id l127mr33425364qkf.94.1507300874159;
        Fri, 06 Oct 2017 07:41:14 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010::7cc])
        by smtp.gmail.com with ESMTPSA id h1sm1013848qkf.10.2017.10.06.07.41.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Oct 2017 07:41:13 -0700 (PDT)
Subject: Re: [PATCH] cleanup: fix possible overflow errors in binary search
To:     Jeff King <peff@peff.net>, Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
References: <20171005094418.irm6omly67bgyvo7@sigill.intra.peff.net>
 <20171006135231.239232-1-dstolee@microsoft.com>
 <20171006141820.6vd3qt6iosxcgebm@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <bd3c5fe2-ac6a-b978-163b-da07208b879c@gmail.com>
Date:   Fri, 6 Oct 2017 10:41:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20171006141820.6vd3qt6iosxcgebm@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/6/2017 10:18 AM, Jeff King wrote:
> On Fri, Oct 06, 2017 at 09:52:31AM -0400, Derrick Stolee wrote:
>
>> A common mistake when writing binary search is to allow possible
>> integer overflow by using the simple average:
>>
>> 	mid = (min + max) / 2;
>>
>> Instead, use the overflow-safe version:
>>
>> 	mid = min + (max - min) / 2;
> Great, thank you for picking this up!
>
>> The included changes were found using the following two greps:
>>
>> 	grep "/ 2;" *.c
>> 	grep "/ 2;" */*.c
>> 	grep "/2;" */*.c
> You can use[1]:
>
>    git grep '/ 2;' '*.c'
>
> to have Git expand the wildcard. That catches a few extra cases in
> compat/regex/*.c.  Even though it's imported code, it might be
> nice to cover those, too (since it's a possible bug, and also as a good
> example).
>
> [1] I'd actually write:
>
>        git grep '/ *2;' '*.c'
>
>      to do it all in one grep. :)

Thanks for the grep lesson! I knew there would be a simpler way to do 
what I wanted.

>> ---
>>   builtin/index-pack.c     | 4 ++--
>>   builtin/pack-objects.c   | 2 +-
>>   builtin/unpack-objects.c | 2 +-
>>   cache-tree.c             | 2 +-
>>   packfile.c               | 2 +-
>>   sha1-lookup.c            | 2 +-
>>   sha1_name.c              | 2 +-
>>   string-list.c            | 2 +-
>>   utf8.c                   | 2 +-
>>   xdiff/xpatience.c        | 2 +-
>>   10 files changed, 11 insertions(+), 11 deletions(-)
> These all look good to me (really the only way the conversion could be
> bad is if "min" was higher than "max", and each case is just inside a
> loop condition which makes sure that is not the case).
>
> -Peff
I thought this should be simple enough. When we are all happy with the 
idea of this cleanup, I'll re-roll with the missed examples.

Thanks,
-Stolee
