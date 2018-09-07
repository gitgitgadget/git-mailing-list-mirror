Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B38C01F404
	for <e@80x24.org>; Fri,  7 Sep 2018 18:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeIGXOJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 19:14:09 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:38271 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbeIGXOI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 19:14:08 -0400
Received: by mail-qt0-f194.google.com with SMTP id x7-v6so17232034qtk.5
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 11:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LI/Kw6HMaAs3JNuVeKuxZt54R57gBZXhh//fr8iO5/I=;
        b=VwzFGGBNszfB0OAqY5cfgOpvDUj8L53MaXg5koBPaNYuIh4pBR5ytwZP8A+w40QxGn
         uA2RgpFsU2CahOh7idz6lKi558FWA1U3MXLJUDSmc7D/BbidbXLz4HbdjtO5pKEwbPnb
         I/ZUgd0jM5f/w4SkPskmH+i5x4zVFAGUd/rRBSKroaLjQVv4w27Tvtso05zNmZLvAxxx
         SsbCZTj574NrSQr80GnXCKY0u/tmqEDBw8uGIAbfODXRap7sK5KIlATI7qZ5OWd8kkiY
         DiSDmY+di/vFz3beFoshJ6B4ZIqV3dmEwqknzKXFbD2dn7Z7PPlDqsnbewHqCtEZmnlI
         KRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LI/Kw6HMaAs3JNuVeKuxZt54R57gBZXhh//fr8iO5/I=;
        b=IsTVq6MTE+/pwqrfsq/WUG3vVCX+IpW/SYWZ1iTwdX+I2C/HUsXqxKmE7Nfg58H1Rt
         2HgIqQLsXdjhtFlo2joMhBQrl4cwhSwSqNwyDNI5u8cjdrGXrxOlWmn9u3NCqx/VyVkZ
         aSODixg1hroKiL+lR61L+nHCSlVIuRKLc3Nr5+3auG6BCiF7KazNIx3sn8ufNSCYbdBX
         kcGreo3kouk/aRKMwnzkkFCIP8R0wj9Zqw7J6/CIgK+z8a/l4raZ6Xo84AC4+HIoWvFs
         c3/KpJgjs8QTUQFTIGBbuXROm+R6xHuiwOFxZJjuMiQk9yQbGm4rmITD28CI17z7bpSS
         JA3A==
X-Gm-Message-State: APzg51AIFqvULbOEM2mL/f7J0JgXg/YKKmOnwLfGJTADjrcrKXzaxfrX
        YbCAoKjme/tIZbt7merTeK8=
X-Google-Smtp-Source: ANB0VdbaNfzTumuIjesajIuktKHbp9bPUGjbXxzOjJkFXmKw47yDhS7Og13foDhlxceeebU4/NUZkw==
X-Received: by 2002:ac8:11b:: with SMTP id e27-v6mr6761336qtg.221.1536345116990;
        Fri, 07 Sep 2018 11:31:56 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id e29-v6sm6052492qte.47.2018.09.07.11.31.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 11:31:56 -0700 (PDT)
Subject: Re: [PATCH v3 0/4] read-cache: speed up index load through
 parallelization
To:     Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180906210227.54368-1-benpeart@microsoft.com>
 <xmqq5zzhxlxm.fsf@gitster-ct.c.googlers.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <6ef05d29-b303-0282-7ca7-6e51efded005@gmail.com>
Date:   Fri, 7 Sep 2018 14:31:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqq5zzhxlxm.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/7/2018 1:21 PM, Junio C Hamano wrote:
> Ben Peart <benpeart@microsoft.com> writes:
> 
>> On further investigation with the previous patch, I noticed that my test
>> repos didn't contain the cache tree extension in their index. After doing a
>> commit to ensure they existed, I realized that in some instances, the time
>> to load the cache tree exceeded the time to load all the cache entries in
>> parallel.  Because the thread to read the cache tree was started last (due
>> to having to parse through all the cache entries first) we weren't always
>> getting optimal performance.
>>
>> To better optimize for this case, I decided to write the EOIE extension
>> as suggested by Junio [1] in response to my earlier multithreading patch
>> series [2].  This enables me to spin up the thread to load the extensions
>> earlier as it no longer has to parse through all the cache entries first.
> 
> Hmph. I kinda liked the simplicity of the previous one, but if we
> need to start reading the extension sections sooner by eliminating
> the overhead to scan the cache entries, perhaps we should bite the
> bullet now.
> 

I preferred the simplicity as well but when I was profiling the code and 
found out that loading the extensions was most often the last thread to 
complete, I took this intermediate step to speed things up.

>> The big changes in this iteration are:
>>
>> - add the EOIE extension
>> - update the index extension worker thread to start first
> 
> I guess I'd need to see the actual patch to find this out, but once
> we rely on a new extension, then we could omit scanning the main
> index even to partition the work among workers (i.e. like the topic
> long ago, you can have list of pointers into the main index to help
> partitioning, plus reset the prefix compression used in v4).  I
> think you didn't get that far in this round, which is good.  If the
> gain with EOIE alone (and starting the worker for the extension
> section early) is large enough without such a pre-computed work
> partition table, the simplicity of this round may give us a good
> stopping point.
> 

Agreed.  I didn't go that far in this series as it doesn't appear to be 
necessary.  We could always add that later if it turned out to be worth 
the additional complexity.

>> This patch conflicts with Duy's patch to remove the double memory copy and
>> pass in the previous ce instead.  The two will need to be merged/reconciled
>> once they settle down a bit.
> 
> Thanks.  I have a feeling that 67922abb ("read-cache.c: optimize
> reading index format v4", 2018-09-02) is already 'next'-worthy
> and ready to be built on, but I'd prefer to hear from Duy to double
> check.
> 

I'll take a closer look at what this will entail. It gets more 
complicated as we don't actually have a previous expanded cache entry 
when starting each thread.  I'll see how complex it makes the code and 
how much additional performance it gives.
