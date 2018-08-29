Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4A771F404
	for <e@80x24.org>; Wed, 29 Aug 2018 21:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbeH3BeN (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 21:34:13 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:46830 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbeH3BeM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 21:34:12 -0400
Received: by mail-qk0-f194.google.com with SMTP id j7-v6so4405636qkd.13
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 14:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S4XYIF9DUIKTr7JD7+g0MpM4CzPwdSN/9bDZlaTsOZ0=;
        b=kDyzDfw/57EVqJ4zwJEF0NaoXcqnVvVtRJZWVxFlqsmlQnZKHN2Hxk+QyJsc2jUrOx
         FMbpDZYCLb9EhOxNeIsYD2aXyI+07hhf9TQaC5wx6R0+bNHJVyN7CxWd+J37CjNolMFV
         TFq2eQJOFT0UHAqRcSz8ujNa64HesTyUDwCusaUe3crjZ7XKXfjEwTaxw0onLUsmfI5G
         VkVTYlc4P5rh16kIdEAV6lBB+e9iWec8QSayB+WCx0agipMRZYBQJbEBevL3ACIoCZEg
         yyAud4WgzNWzb/6SJa4M5NDvWDzuaHVHeI/WsgzDh0giMoL4ku96CFKw7g2TAN2KCThn
         mW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S4XYIF9DUIKTr7JD7+g0MpM4CzPwdSN/9bDZlaTsOZ0=;
        b=XXqsonJROSKP062AHAslRQk+WX5Zs0/LnyCdd5LehMrALZ2mZzVkDQylGGhDREp3ZX
         9qkn8MfL0/pafHJKj6djfyZB9fJ8RxCJWexoxB5/txj7vg+COndz6sqE/utSwiIOJwzm
         AV0zZZNC46U1oTFE9ewCJWjrdM89k4tJchJkUxwKATu43aVUZDBQTHPnL0Fojdaw+ZD6
         vxzxwIM0jkhjAc7FZaiw8WVkmhsJGcQax6J+3nORTchPEp7MLtec2nqsnkI9xCUsMIZ8
         ukD2QB6V0+ueewtJ+sqLSJwCj3RcLGXHqPzTplLfWT7iwV7g5HRjPaBAaimEYyV5cD6W
         uJQA==
X-Gm-Message-State: APzg51CrhRL1/fEl8e7m+SbzTiIQXDbmQyJZX13whbZzOgxnqKxtdys/
        m0OHwzSpVuzsv9luDQ1dEsU=
X-Google-Smtp-Source: ANB0VdZEbnwCOWY1J0fkDu/2+wa5TpnCL+th9sm5kwNXS73dYc7/UBusXwulj1Pe03xvT8tzLvxMTQ==
X-Received: by 2002:a37:a38b:: with SMTP id m133-v6mr8408453qke.356.1535578523971;
        Wed, 29 Aug 2018 14:35:23 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id p18-v6sm3553793qtp.3.2018.08.29.14.35.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 14:35:22 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] read-cache: speed up index load through
 parallelization
To:     Junio C Hamano <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "pclouds@gmail.com" <pclouds@gmail.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180829152500.46640-1-benpeart@microsoft.com>
 <20180829152500.46640-2-benpeart@microsoft.com>
 <xmqq5zztccy7.fsf@gitster-ct.c.googlers.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <f1a703e8-27b9-3f9e-9bde-a7b74659b4b3@gmail.com>
Date:   Wed, 29 Aug 2018 17:35:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqq5zztccy7.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/29/2018 1:14 PM, Junio C Hamano wrote:
> Ben Peart <Ben.Peart@microsoft.com> writes:
> 
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index 1c42364988..79f8296d9c 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -2391,6 +2391,12 @@ imap::
>>   	The configuration variables in the 'imap' section are described
>>   	in linkgit:git-imap-send[1].
>>   

> Adding something like
> 
> 	You can disable multi-threaded code by setting this variable
> 	to 'false' (or 1).
> 
> may reduce the risk of a similar "Huh?" reaction by other readers.
> 

Will do

>> +struct load_cache_entries_thread_data
>> +{
>> +	pthread_t pthread;
>> +	struct index_state *istate;
>> +	struct mem_pool *ce_mem_pool;
>> +	int offset, nr;
>> +	void *mmap;
>> +	unsigned long start_offset;
>> +	struct strbuf previous_name_buf;
>> +	struct strbuf *previous_name;
>> +	unsigned long consumed;	/* return # of bytes in index file processed */
>> +};
> 
> We saw that Duy's "let's not use strbuf to remember the previous
> name but instead use the previous ce" approach gave us a nice
> performance boost; I wonder if we can build on that idea here?
> 
> One possible approach might be to create one ce per "block" in the
> pre-scanning thread and use that ce as the "previous one" in the
> per-thread data before spawning a worker.
> 

Yes, I believe this can be done.  I was planning to wait until both 
patches settled down a bit before adapting it to threads.  It's a little 
trickier because the previous ce doesn't yet exist but I believe one can 
be fabricated enough to make the optimization work.

>> +static unsigned long load_cache_entries(struct index_state *istate,
>> +			void *mmap, size_t mmap_size, unsigned long src_offset)
>> +{
>> +	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
>> +	struct load_cache_entries_thread_data *data;
>> +	int nr_threads, cpus, ce_per_thread;
>> +	unsigned long consumed;
>> +	int i, thread;
>> +
>> +	nr_threads = git_config_get_index_threads();
>> +	if (!nr_threads) {
>> +		cpus = online_cpus();
>> +		nr_threads = istate->cache_nr / THREAD_COST;
> 
> Here, nr_threads could become 0 with a small index, but any value
> below 2 makes us call load_all_cache_entries() by the main thread
> (and the value of nr_thread is not used anyore), it is fine.  Of
> course, forced test will set it to 2 so there is no problem, either.
> 
> OK.
> 
>> +	/* a little sanity checking */
>> +	if (istate->name_hash_initialized)
>> +		die("the name hash isn't thread safe");
> 
> If it is a programming error to call into this codepath without
> initializing the name_hash, which I think is the case, this is
> better done with BUG("").
> 

Will do

> The remainder of the patch looked good.  Thanks.
> 
