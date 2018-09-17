Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2B861F404
	for <e@80x24.org>; Mon, 17 Sep 2018 16:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbeIQVy3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 17:54:29 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40529 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbeIQVy3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 17:54:29 -0400
Received: by mail-qk1-f193.google.com with SMTP id c126-v6so9307950qkd.7
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 09:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ykZUuqjeJbvDh4+FNWrpe4IYRtE9j0Ug4AL/6WYQBDw=;
        b=RarYaNlSHP4qU5U12Vm4Tg+FG4tL6aKPKgm8dt7KOrqxOpI8f6fYiDPiu1ZzTjRAHS
         xKnTUR2mU0ZwfLlm2iYOjCc9CIwwFKX3/isPe0T/olOiQopI5o0HP8A6t99GZBDc+4em
         Xx01cYxkA45xJ35tbfj3n+6iRM9UrEh6rHARAHu8/mU0qkhBAxhavaWnotM5QTtY6pZy
         jDgzTgFnV1pyQUyYqqVcsld+Dn33JR1RCnymIdvJ9xVdbh2SiFJblmpHYFSvy9icg0bg
         DffyZbWORBxjxonGMEaxYrZxn65phVig+qTZYutTZtzAwx8TGVB8c8pFBA2DhXQ+AqFi
         Oxtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ykZUuqjeJbvDh4+FNWrpe4IYRtE9j0Ug4AL/6WYQBDw=;
        b=RDxS1+GTu9VVqLthHHWodiZScf/312oYHrnk0wy9t91Sjq1TV67UfFcrik6oy77Oul
         HbWWZwU6G1Gk4RGM0VNhK8cD5/MfhHnONakGtwBlB4kt9FDGW6dPbmtV2QzERYAeNZCm
         GO0qKEmE3eeRTwHXBHKQTZeTqQR/PjvRj+AcT8sLgQG90DiHrtJhtcEmfwrX5ZjrAfd7
         cRGzS+qojL/OqFIcbZiGWoveVyAUcXVJwXkvkhgC0doV+gaBn48OVVG2pDC5x1xkEJ7f
         Z694P3S7RPudL5AXIqS84pj6tnLlZ94Tmzyhb1AMmugwuyc9eYTLxOFZKMzlXz2DDrhK
         knDw==
X-Gm-Message-State: APzg51BSas/0dGsFSSNW6TyYAzwedZyb7y5BkNBQC1qoTxBTmmE14yHE
        SgBWz5MDj4+B09socfQZ0Zw=
X-Google-Smtp-Source: ANB0Vda3weXWsxLTrPYX86Sn5pQuHf3rp40JPKolRdG0yuj3wFVFWI1tDd8LIWh9OURkBRnDP8yl0Q==
X-Received: by 2002:a37:9cd4:: with SMTP id f203-v6mr17342639qke.357.1537201582987;
        Mon, 17 Sep 2018 09:26:22 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id r187-v6sm8689687qke.24.2018.09.17.09.26.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 09:26:22 -0700 (PDT)
Subject: Re: [PATCH v5 2/5] read-cache: load cache extensions on a worker
 thread
To:     Duy Nguyen <pclouds@gmail.com>, Ben Peart <benpeart@microsoft.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180912161832.55324-1-benpeart@microsoft.com>
 <20180912161832.55324-3-benpeart@microsoft.com>
 <CACsJy8ATsS6S5zib2FqJf1stPcGwSTO1qYBSz514Xu2GfJ4Apw@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <78f62979-18a7-2fc1-6f26-c4f84e19424f@gmail.com>
Date:   Mon, 17 Sep 2018 12:26:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8ATsS6S5zib2FqJf1stPcGwSTO1qYBSz514Xu2GfJ4Apw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/15/2018 6:22 AM, Duy Nguyen wrote:
>> +index.threads::
>> +       Specifies the number of threads to spawn when loading the index.
>> +       This is meant to reduce index load time on multiprocessor machines.
>> +       Specifying 0 or 'true' will cause Git to auto-detect the number of
>> +       CPU's and set the number of threads accordingly. Defaults to 'true'.
> 
> I'd rather this variable defaults to 0. Spawning threads have
> associated cost and most projects out there are small enough that this
> multi threading could just add more cost than gain. It only makes
> sense to enable this on huge repos.
> 
> Wait there's no way to disable this parallel reading? Does not sound
> right. And  if ordinary numbers mean the number of threads then 0
> should mean no threading. Auto detection could have a new keyword,
> like 'auto'.
> 

The index.threads setting is patterned after the pack.threads setting 
for consistency.  Specifying 1 (or 'false') will disable multithreading 
but I will call that out explicitly in the documentation to make it more 
obvious.

The THREAD_COST logic is designed to ensure small repos don't incur more 
cost than gain.  If you have data on that logic that shows it isn't 
working properly, I'm happy to change the logic as necessary.

>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -23,6 +23,10 @@
>>   #include "split-index.h"
>>   #include "utf8.h"
>>   #include "fsmonitor.h"
>> +#ifndef NO_PTHREADS
>> +#include <pthread.h>
>> +#include <thread-utils.h>
>> +#endif
> 
> I don't think you're supposed to include system header files after
> "cache.h". Including thread-utils.h should be enough (and it keeps the
> exception of inclduing pthread.h in just one place). Please use
> "pthread-utils.h" instead of <pthread-utils.h> which is usually for
> system header files. And include ptherad-utils.h unconditionally.
> 

Thanks, I'll fix that.

>>
>>   /* Mask for the name length in ce_flags in the on-disk index */
>>
>> @@ -1898,6 +1902,46 @@ static unsigned long read_eoie_extension(void *mmap_, size_t mmap_size);
>>   #endif
>>   static void write_eoie_extension(struct strbuf *sb, git_hash_ctx *eoie_context, unsigned long offset);
>>
>> +struct load_index_extensions
>> +{
>> +#ifndef NO_PTHREADS
>> +       pthread_t pthread;
>> +#endif
>> +       struct index_state *istate;
>> +       void *mmap;
>> +       size_t mmap_size;
>> +       unsigned long src_offset;
>> +};
>> +
>> +static void *load_index_extensions(void *_data)
>> +{
>> +       struct load_index_extensions *p = _data;
>> +       unsigned long src_offset = p->src_offset;
>> +
>> +       while (src_offset <= p->mmap_size - the_hash_algo->rawsz - 8) {
>> +               /* After an array of active_nr index entries,
>> +                * there can be arbitrary number of extended
>> +                * sections, each of which is prefixed with
>> +                * extension name (4-byte) and section length
>> +                * in 4-byte network byte order.
>> +                */
>> +               uint32_t extsize;
>> +               memcpy(&extsize, (char *)p->mmap + src_offset + 4, 4);
>> +               extsize = ntohl(extsize);
>> +               if (read_index_extension(p->istate,
>> +                       (const char *)p->mmap + src_offset,
>> +                       (char *)p->mmap + src_offset + 8,
>> +                       extsize) < 0) {
>> +                       munmap(p->mmap, p->mmap_size);
>> +                       die("index file corrupt");
> 
> _()
> 

You're feedback style can be a bit abrupt and terse.  I _think_ what you 
are trying to say here is that the "die" call should use the _() macro 
around the string.

This is an edit of the previous code that loaded index extensions and 
doesn't change the use of _(). I don't know the rules for when _() 
should be used and didn't have any luck finding where it was documented 
so left it unchanged.

FWIW, in this file alone there are 20 existing instances of die() or 
die_errorno() and only two that use the _() macro.  A quick grep through 
the source code shows thousands of die() calls the vast majority of 
which do not use the _() macro.  This appears to be an area that is 
unclear and inconsistent and could use some attention in a separate patch.


>> +       /* if we created a thread, join it otherwise load the extensions on the primary thread */
>> +#ifndef NO_PTHREADS
>> +       if (extension_offset && pthread_join(p.pthread, NULL))
>> +               die(_("unable to join load_index_extensions_thread"));
> 
> I guess the last _ is a typo and you wanted "unable to join
> load_index_extensions thread". Please use die_errno() instead.
> 

Why should this be die_errorno() here?  All other instances of 
pthread_join() failing in a fatal way use die(), not die_errorno().

>> +#endif
>> +       if (!extension_offset) {
>> +               p.src_offset = src_offset;
>> +               load_index_extensions(&p);
>>          }
>>          munmap(mmap, mmap_size);
>>          return istate->cache_nr;
>> --
>> 2.18.0.windows.1
>>
> 
> 
