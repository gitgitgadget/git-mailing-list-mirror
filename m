Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 642EF1F404
	for <e@80x24.org>; Fri,  7 Sep 2018 13:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbeIGSYp (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 14:24:45 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:46091 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728481AbeIGSYo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 14:24:44 -0400
Received: by mail-qt0-f193.google.com with SMTP id d4-v6so16188475qtn.13
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 06:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3ZtfOoXZUS44Q0I1ODB70jtenke+iu9V4kU+4g03ZJE=;
        b=B54XCQPGwSgypoqzPBcGoqwEt15yJG8FZlzahDy8wi3tGy3tG5UeAyJPPlG3IpKyYs
         gEPKvW6hxlJuXBKAcass9acLh+jUMB5t7pNZ38YL0U7F03vcGnVmKzcPvHeaa7aAmNwy
         2oBt1vJbZ/0ezWVZ9pG1VGRkqg76tYiMoiYjQqbYcKOzjXBpaWyL8w7nPcM2Ih3tfc1M
         2a4q4HHnueOcJm0+Wu/HQerTFx9lv9Z6HRP7QX/oG1t9XYoiqHwYUApC0tZktKaB3LKO
         kDaoxk84fBdlvWh8NTnRRI4EOzPlqbZK3JehvF0+bSMr0l27/mwbqyfd2vG82l1kXtKo
         Rb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3ZtfOoXZUS44Q0I1ODB70jtenke+iu9V4kU+4g03ZJE=;
        b=o1VCUCbNUk66XUvVhZLCFvKegCjig0fTYaAIjr/6GXB/j/iL1fMiRxw7m8+VAyA2AD
         xAK4V63il4bUZ9Jg4g44XPHGMqma5/Tselqh+w5T561ZcN3Vmn70s/Z209OTC7Kjk+2E
         zyZhm3vOMTqsaRWtMCBgSJtOCe4etwIuOG6BELbO5JkiFWwuA9khrDsHD/N23qjdrkYc
         81c/HWqiqxRr2OSSYwmGVUomMDprUdCKV3bPbFmGnWgvwwoA/fx8JAgFVkY7d6Qt+uOf
         /U0rq/Xs37DeuT592394jQVgRBnNsTDxyQFnxMeMHiaisdB5UbtXRtxBNAztcqwH94Lg
         hsUg==
X-Gm-Message-State: APzg51BIgcXor33tvM77MYMXCnFF3CSkbPXyL6DHH7nJPByVL3Lt30uR
        Yr+lC9REGF3Fxrw0EdjQu1g=
X-Google-Smtp-Source: ANB0Vdbuf37klH1rPc9+1FA/RHqi9ydb4ZQiFyRONIPf+bK3GBwCY7G2ju2Izi5quvHUCWnYeicEUQ==
X-Received: by 2002:ac8:198c:: with SMTP id u12-v6mr6170294qtj.86.1536327822332;
        Fri, 07 Sep 2018 06:43:42 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id 56-v6sm6032979qtw.31.2018.09.07.06.43.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 06:43:41 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] read-cache: speed up index load through
 parallelization
To:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Ben Peart <benpeart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180906210227.54368-1-benpeart@microsoft.com>
 <20180906210227.54368-5-benpeart@microsoft.com>
 <20180907041657.GA12835@tor.lan>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <18022c85-cf2d-026e-d643-2b872f3cfbe8@gmail.com>
Date:   Fri, 7 Sep 2018 09:43:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180907041657.GA12835@tor.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/7/2018 12:16 AM, Torsten Bögershausen wrote:
> 
>> diff --git a/read-cache.c b/read-cache.c
>> index fcc776aaf0..8537a55750 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -1941,20 +1941,212 @@ static void *load_index_extensions(void *_data)
>>   	return NULL;
>>   }
>>   
>> +/*
>> + * A helper function that will load the specified range of cache entries
>> + * from the memory mapped file and add them to the given index.
>> + */
>> +static unsigned long load_cache_entry_block(struct index_state *istate,
>> +			struct mem_pool *ce_mem_pool, int offset, int nr, void *mmap,
>> +			unsigned long start_offset, struct strbuf *previous_name)
>> +{
>> +	int i;
>> +	unsigned long src_offset = start_offset;
> 
> I read an unsigned long here:
> should that be a size_t instead ?
> 
> (And probably even everywhere else in this patch)
> 

It's a fair question.  The pre-patch code had a mix of unsigned long and 
size_t.  Both src_offset and consumed were unsigned long but mmap_size 
was a size_t.  I stuck with that pattern for consistency.

While it would be possible to convert everything to size_t as a step to 
enable index files >4 GB, I have a hard time believing that will be 
necessary for a very long time and would likely require more substantial 
changes to enable that to work.

>> +
>> +	for (i = offset; i < offset + nr; i++) {
>> +		struct ondisk_cache_entry *disk_ce;
>> +		struct cache_entry *ce;
>> +		unsigned long consumed;
>> +
>> +		disk_ce = (struct ondisk_cache_entry *)((char *)mmap + src_offset);
>> +		ce = create_from_disk(ce_mem_pool, disk_ce, &consumed, previous_name);
>> +		set_index_entry(istate, i, ce);
>> +
>> +		src_offset += consumed;
>> +	}
>> +	return src_offset - start_offset;
>> +}
>> +
>> +static unsigned long load_all_cache_entries(struct index_state *istate,
>> +			void *mmap, size_t mmap_size, unsigned long src_offset)
>> +{
>> +	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
>> +	unsigned long consumed;
>> +
>> +	if (istate->version == 4) {
>> +		previous_name = &previous_name_buf;
>> +		mem_pool_init(&istate->ce_mem_pool,
>> +				estimate_cache_size_from_compressed(istate->cache_nr));
>> +	} else {
>> +		previous_name = NULL;
>> +		mem_pool_init(&istate->ce_mem_pool,
>> +				estimate_cache_size(mmap_size, istate->cache_nr));
>> +	}
>> +
>> +	consumed = load_cache_entry_block(istate, istate->ce_mem_pool,
>> +					0, istate->cache_nr, mmap, src_offset, previous_name);
>> +	strbuf_release(&previous_name_buf);
>> +	return consumed;
>> +}
>> +
>> +#ifndef NO_PTHREADS
>> +
