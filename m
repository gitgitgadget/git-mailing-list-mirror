Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AB341F404
	for <e@80x24.org>; Tue, 28 Aug 2018 23:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbeH2Dsl (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 23:48:41 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36164 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbeH2Dsk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 23:48:40 -0400
Received: by mail-qt0-f196.google.com with SMTP id t5-v6so3854769qtn.3
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 16:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K83iijpc4J44lAQNSLYYEQAvdfPFcgViHXrnYNR4hLE=;
        b=jdgPczd9MS2tAWslW4uOG+OmGBuKgCIsGsHPTulBBk3da9fUOe6wwXQIVScpCE1vNz
         c3m6sIPIas0opnFtRUAmXhhbROOIskGMSflnYBfMYtuiHM2hUGBuJFf2O3wnUB/MZQKu
         mGEtGC8FxiiaoCltx2mEYpzKIq0TdM5v8rRT0GXGw9RXseYlJ3cwQe+2940IPMLQeT6Y
         zrswVlZhvKfdtwZNKPwT1Du/h6uy+WYVRUj8y/QomSj9HMJ5+gra8KRfNDgL5ajNPb5g
         7uSyt1xf5b9v3wH47aaYysVQh38SaVG4VxGkFT160W9v38LQWJr+X631uyJjWCG5tehM
         Zn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K83iijpc4J44lAQNSLYYEQAvdfPFcgViHXrnYNR4hLE=;
        b=a9fw6zcpM76DaSLi9QkwrQsRW8k1skhK/OJytycjtd9XQvn6ubS0/5V6flflaT9J11
         2m3NhAedgQ0F3RzQKfw6FiUaKyaHBQb44Rza74oCY64knVpVtwoyHLtCP4aTuGpv4GuN
         +7Yrt9R/5jZinWKn3EqHbiP+fVi7F/nMR1wyx9rsmbzLYlw9tNvbFPafRIdIifPstMvy
         6gwsuXnaZPrp+ZaN6o1Dyr3gQ7ySoMOVPxgLQt+qjzsZCv/kUZNWmb5l5+i73Qgrm0Un
         vBs4FO7qvjx/3WheCDtnm31D8stvXNfNt9a50ifYCq9yDczonfAa5D52PIEaOsxySLJ1
         +ImA==
X-Gm-Message-State: APzg51DWqbqmTGYtaSQh9OldHrKJ2qdgtttbPg+WoKEVeNTxfip0OpB5
        baEgRIHCY5pGB8mECn432UAsEt4d
X-Google-Smtp-Source: ANB0VdZ9wqt8ThM0QLFu789iVOO8ua0Sc8L6MupLQHs1CGEe8QZo+pdWP9eL1xq8iZtA446rWxalCw==
X-Received: by 2002:ac8:1e97:: with SMTP id c23-v6mr4186842qtm.181.1535500477102;
        Tue, 28 Aug 2018 16:54:37 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id k9-v6sm1621907qtk.2.2018.08.28.16.54.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 16:54:36 -0700 (PDT)
Subject: Re: [PATCH] read-cache.c: optimize reading index format v4
To:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
References: <20180824155734.GA6170@duynguyen.home>
 <20180825064458.28484-1-pclouds@gmail.com>
 <xmqqwosbiouc.fsf@gitster-ct.c.googlers.com>
 <CACsJy8B38QAW8qq-CctLJyJNaC329o6Rr1gs0kd=EkV+ARAaVw@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <b3898649-47ee-adcc-9e22-68b23ffde5d1@gmail.com>
Date:   Tue, 28 Aug 2018 19:54:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8B38QAW8qq-CctLJyJNaC329o6Rr1gs0kd=EkV+ARAaVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/28/2018 3:25 PM, Duy Nguyen wrote:
> On Mon, Aug 27, 2018 at 9:36 PM Junio C Hamano <gitster@pobox.com> wrote:
>>> PS. I notice that v4 does not pad to align entries at 4 byte boundary
>>> like v2/v3. This could cause a slight slow down on x86 and segfault on
>>> some other platforms.
>>
>> Care to elaborate?
>>
>> Long time ago, we used to mmap and read directly from the index file
>> contents, requiring either an unaligned read or padded entries.  But
>> that was eons ago and we first read and convert from on-disk using
>> get_be32() etc. to in-core structure, so I am not sure what you mean
>> by "segfault" here.
>>
> 
> My bad. I saw this line
> 
> #define get_be16(p) ntohs(*(unsigned short *)(p))
> 
> and jumped to conclusion without realizing that block is for safe
> unaligned access.
> 
>>> @@ -1898,7 +1884,8 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
>>>        struct cache_header *hdr;
>>>        void *mmap;
>>>        size_t mmap_size;
>>> -     struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
>>> +     const struct cache_entry *previous_ce = NULL;
>>> +     struct cache_entry *dummy_entry = NULL;
>>>
>>>        if (istate->initialized)
>>>                return istate->cache_nr;
>>> @@ -1936,11 +1923,10 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
>>>        istate->initialized = 1;
>>>
>>>        if (istate->version == 4) {
>>> -             previous_name = &previous_name_buf;
>>> +             previous_ce = dummy_entry = make_empty_transient_cache_entry(0);
>>
>> I do like the idea of passing the previous ce around to tell the
>> next one what the previous name was, but I would have preferred to
>> see this done a bit more cleanly without requiring us to support "a
>> dummy entry with name whose length is 0"; a real cache entry never
>> has zero-length name, and our code may want to enforce it as a
>> sanity check.
>>
>> I think we can just call create_from_disk() with NULL set to
>> previous_ce in the first round; of course, the logic to assign the
>> one we just created to previous_ce must check istate->version,
>> instead of "is previous_ce NULL?" (which is an indirect way to check
>> the same thing used in this patch).
> 
> Yeah I kinda hated dummy_entry too but the feeling wasn't strong
> enough to move towards the index->version check. I guess I'm going to
> do it now.
> 

I ran some perf tests using p0002-read-cache.sh to compare V4 
performance before and after this patch so I could get a feel for how 
much it helps.

100,000 files

Test                                  HEAD~1   HEAD
------------------------------------------------------------
read_cache/discard_cache 1000 times    14.12    10.75 -23.9%

1,000,000 files

Test                                  HEAD~1   HEAD
------------------------------------------------------------
read_cache/discard_cache 1000 times   202.81   170.33 -16.0%


This provides a nice speedup and IMO simplifies the code as well. 
Nicely done.
