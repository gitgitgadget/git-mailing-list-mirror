Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EE041F404
	for <e@80x24.org>; Thu, 23 Aug 2018 19:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbeHWXQO (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 19:16:14 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:41261 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeHWXQO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 19:16:14 -0400
Received: by mail-qk0-f193.google.com with SMTP id h138-v6so4422598qke.8
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 12:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Mp5xESWl7PRzuI6ixVXlVqygcTTC8mExFOA5v0cKHEM=;
        b=BVuBABYKXU/Pb0r212VHr+bdt4tsU4P6SWckQ6pgwaKjF+ch/L2ADwEw+/Bk0T8Jej
         IeuXnUySOECNpxAj8YzDjW0Yukh5WOglBLVmuqXDeTPrIBUgpZF87ZaezDJp9p13HNy9
         smGIHFIYK4D+nIBMgHO5IFX+8B87cjvUK6g5o6iGU06pwXwHt3osgm/Y1f16o5Tr+6g1
         Po8dok4ILzhfS82pCzoafEvfo2iC1ruN2wXMZxRkGOioZnzIipOBhmvxy1ZrXNTpLVEE
         +wo0g0tkwitFnM7kCRxJAfgICAs5xJ7roIUl+Rc50QDND3r5weQyzmyg90qVyZBL//EP
         tmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Mp5xESWl7PRzuI6ixVXlVqygcTTC8mExFOA5v0cKHEM=;
        b=Znx5zZErbjp9sQr79UpbQCAiY7Rq/uOALkgXsTCfhJAhFSa07+TlS+GjGWiTcjqIGz
         F8jnoZWaU1f10M6mGokJdJk71JCPLvJBLJZLXRTecf+7oEmIEixcM1+SZDlwfk9bnyAa
         jykIBRCsiVhaS7OXx+iLx8nyouQrjDr3CBrCMSPnCtKsndateJMBlw16mZJiKiCy5xPO
         NpqRsGn/y6k4QDzmQi5uQsKqnXt+VjJvTgjUPppq+Pylk4Smo+J8WQXlgnQAaQw19z4T
         +WGRbiS3WBCRLP0TaZAw9ASpq0aypaMWKGDbGyHtjDtq2jb/GQw74EtTRhb8yU+gmuKO
         p41Q==
X-Gm-Message-State: AOUpUlGxa3TURyIzVi27pp6JFyNdR1A4NhTFhB7JJukCpYnFzaxGAxoU
        BTyN/I54kfuSDDt08iwMPrs=
X-Google-Smtp-Source: ANB0VdYxCEf5xAoMyEk+48Yfpg1S/E+fxGMfq5JWySXpniSXf+/ZtT7lfdoOZuJo45rY4mvTlH9WEQ==
X-Received: by 2002:a37:1968:: with SMTP id k101-v6mr28563289qkh.270.1535053500842;
        Thu, 23 Aug 2018 12:45:00 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id d16-v6sm3660983qtd.7.2018.08.23.12.44.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 12:44:59 -0700 (PDT)
Subject: Re: [PATCH v1] read-cache: speed up index load through
 parallelization
To:     Stefan Beller <sbeller@google.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <CAGZ79kbXfPPvcQ1rnUdiOqWs5wC2qccGCnf8DvCVnp8QV126MA@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <12b29bbf-4565-fe0e-97d4-19da2b4ddf5e@gmail.com>
Date:   Thu, 23 Aug 2018 15:44:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGZ79kbXfPPvcQ1rnUdiOqWs5wC2qccGCnf8DvCVnp8QV126MA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/23/2018 1:31 PM, Stefan Beller wrote:
> On Thu, Aug 23, 2018 at 8:45 AM Ben Peart <Ben.Peart@microsoft.com> wrote:
>>
>> This patch helps address the CPU cost of loading the index by creating
>> multiple threads to divide the work of loading and converting the cache
>> entries across all available CPU cores.
>>
>> It accomplishes this by having the primary thread loop across the index file
>> tracking the offset and (for V4 indexes) expanding the name. It creates a
>> thread to process each block of entries as it comes to them. Once the
>> threads are complete and the cache entries are loaded, the rest of the
>> extensions can be loaded and processed normally on the primary thread.
>>
>> Performance impact:
>>
>> read cache .git/index times on a synthetic repo with:
>>
>> 100,000 entries
>> FALSE       TRUE        Savings     %Savings
>> 0.014798767 0.009580433 0.005218333 35.26%
>>
>> 1,000,000 entries
>> FALSE       TRUE        Savings     %Savings
>> 0.240896533 0.1751243   0.065772233 27.30%
>>
>> read cache .git/index times on an actual repo with:
>>
>> ~3M entries
>> FALSE       TRUE        Savings     %Savings
>> 0.59898098  0.4513169   0.14766408  24.65%
>>
>> Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
>> ---
>>
>> Notes:
>>      Base Ref: master
>>      Web-Diff: https://github.com/benpeart/git/commit/67a700419b
>>      Checkout: git fetch https://github.com/benpeart/git read-index-multithread-v1 && git checkout 67a700419b
>>
>>   Documentation/config.txt |   8 ++
>>   config.c                 |  13 +++
>>   config.h                 |   1 +
>>   read-cache.c             | 218 ++++++++++++++++++++++++++++++++++-----
>>   4 files changed, 216 insertions(+), 24 deletions(-)
>>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index 1c42364988..3344685cc4 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -899,6 +899,14 @@ relatively high IO latencies.  When enabled, Git will do the
>>   index comparison to the filesystem data in parallel, allowing
>>   overlapping IO's.  Defaults to true.
>>
>> +core.fastIndex::
>> +       Enable parallel index loading
>> ++
>> +This can speed up operations like 'git diff' and 'git status' especially
>> +when the index is very large.  When enabled, Git will do the index
>> +loading from the on disk format to the in-memory format in parallel.
>> +Defaults to true.
> 
> "fast" is a non-descriptive word as we try to be fast in any operation?
> Maybe core.parallelIndexReading as that just describes what it
> turns on/off, without second guessing its effects?
> (Are there still computers with just a single CPU, where this would not
> make it faster? ;-))
> 

How about core.parallelReadIndex?  Slightly shorter and matches the 
function names better.

> 
>> +int git_config_get_fast_index(void)
>> +{
>> +       int val;
>> +
>> +       if (!git_config_get_maybe_bool("core.fastindex", &val))
>> +               return val;
>> +
>> +       if (getenv("GIT_FASTINDEX_TEST"))
>> +               return 1;
> 
> We look at this env value just before calling this function,
> can be write it to only look at the evn variable once?
> 

Sure, I didn't like the fact that it was called twice but didn't get 
around to cleaning it up.

>> +++ b/config.h
>> @@ -250,6 +250,7 @@ extern int git_config_get_untracked_cache(void);
>>   extern int git_config_get_split_index(void);
>>   extern int git_config_get_max_percent_split_change(void);
>>   extern int git_config_get_fsmonitor(void);
>> +extern int git_config_get_fast_index(void);
> 
> Oh. nd/no-extern did not cover config.h
> 
> 
>>
>> +#ifndef min
>> +#define min(a,b) (((a) < (b)) ? (a) : (b))
>> +#endif
> 
> We do not have a minimum function in the tree,
> except for xdiff/xmacros.h:29: XDL_MIN.
> I wonder what the rationale is for not having a MIN()
> definition, I think we discussed that on the list a couple
> times but the rationale escaped me.
> 
> If we introduce a min/max macro, can we put it somewhere
> more prominent? (I would find it useful elsewhere)
>

I'll avoid that particular rabbit hole and just remove the min macro 
definition.  ;-)

>> +/*
>> +* Mostly randomly chosen maximum thread counts: we
>> +* cap the parallelism to online_cpus() threads, and we want
>> +* to have at least 7500 cache entries per thread for it to
>> +* be worth starting a thread.
>> +*/
>> +#define THREAD_COST            (7500)
> 
> This reads very similar to preload-index.c THREAD_COST
> 
>> +       /* loop through index entries starting a thread for every thread_nr entries */
>> +       consumed = thread = 0;
>> +       for (i = 0; ; i++) {
>> +               struct ondisk_cache_entry *ondisk;
>> +               const char *name;
>> +               unsigned int flags;
>> +
>> +               /* we've reached the begining of a block of cache entries, kick off a thread to process them */
> 
> beginning
> 

Thanks

> Thanks,
> Stefan
> 
