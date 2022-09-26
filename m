Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE9EC32771
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 16:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiIZQrv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 12:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiIZQrb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 12:47:31 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC2D147CE6
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 08:39:13 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 129so5468853pgc.5
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 08:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=dGQga51Mj2SJztaVeYCdpC19hx9ls7obOqXs7awT7uc=;
        b=DNR2ddE55I72shxAPV8h1b/1bCeaeeoCat/YOhye5j2S3UGNR1WN/9178OAz45yYOS
         2E3eKw00ZG1vrkgDrgSTeSdtmXIYba/q8pDB5P8S16w6fYnJHX8dUwfUWxrM4JyWU+rG
         MennC7J29M8IteylU3L5t5SMOn6ppjWcsUFaFv1IGK1Iiv0U70vF8utcCyJbsSntRwVj
         vAgpgyQnKqzFGOtuW+OktXfq+tUKKNFNXhdXQWy1FalxB2xoJdR53J5Q4GIfneKqEOOV
         KJWo9YUib1kCIxRIJM9vKiEJU6XntIncyjbgs4fmmIHNorgf1O1EkMHjCMQSuSiSGdA3
         l9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=dGQga51Mj2SJztaVeYCdpC19hx9ls7obOqXs7awT7uc=;
        b=Z5324+Pwkgow9i2tnEo526kyxtuU5tJIHNxWCtu8N9Ip/7WFHkwNPHyxbJdgSrQH49
         VFC010mbT7AlJ3IhyUel4da9KV79cLHUg0QeyQun8pksy0Lo7JgdANZKDDkLujYxIti4
         T3yHj5FPu3J4nlnvDxPZZjiMHu8yXPDsb3uTuNAEqspt6BvQsTPF1V+CdrYTEYw34WKT
         7i7w1AnSYuqnmU8ywlLB1187DYAznjrK0JCqOtms7aMuZjZLLE03tSz8Lvn0NQOEgPVb
         8BGf9qUx/Q1pNx9hWthJiu7wELDfm13xHG3ik0JTB0zYv8Bb9akzu3HrVxxEwm9KjPdq
         As4Q==
X-Gm-Message-State: ACrzQf3o3fT41YPVco5nNhTWoX0t7DYXyXrk6pPhjBnPFy+zk2qb+b+1
        L5yOlnV5GAkS/rO5Tb3HzuFm
X-Google-Smtp-Source: AMsMyM4PY1ajxCLVM6YdDiz8aRRxKP9ZVNF51lb1BET0cxkNo0XLm3RyGIGCq6V4E3TGVVJXkMdkqA==
X-Received: by 2002:a63:81c3:0:b0:43c:e1de:eea7 with SMTP id t186-20020a6381c3000000b0043ce1deeea7mr1135042pgd.103.1664206752686;
        Mon, 26 Sep 2022 08:39:12 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id c37-20020a631c65000000b0043949b480a8sm10759004pgm.29.2022.09.26.08.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 08:39:12 -0700 (PDT)
Message-ID: <e5954e90-6b5c-46a6-0842-b3d7d1e06b33@github.com>
Date:   Mon, 26 Sep 2022 08:39:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH] read-cache: avoid misaligned reads in index v4
Content-Language: en-US
To:     Jeff King <peff@peff.net>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com, gitster@pobox.com
References: <pull.1366.git.1663962236069.gitgitgadget@gmail.com>
 <Yy4nkEnhuzt2iH+R@coredump.intra.peff.net>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <Yy4nkEnhuzt2iH+R@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Fri, Sep 23, 2022 at 07:43:55PM +0000, Victoria Dye via GitGitGadget wrote:
>> @@ -1883,7 +1883,7 @@ static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
>>  	size_t len;
>>  	const char *name;
>>  	const unsigned hashsz = the_hash_algo->rawsz;
>> -	const uint16_t *flagsp = (const uint16_t *)(ondisk->data + hashsz);
>> +	const char *flagsp = ondisk + offsetof(struct ondisk_cache_entry, data) + hashsz;
> 
> Now we use the "const char *" pointer instead of the cast to the
> ondisk_cache_entry struct, which is good, and is what fixes the
> alignment question.
> 
> But we also convert flagsp from being a uint16_t into a byte pointer.
> I'm not sure if that's strictly necessary from an alignment perspective,
> as we'd dereference it only via get_be16(), which handles alignment and
> type conversion itself.
> 
> I'd imagine the standard probably says that even forming such a pointer
> is illegal, so in that sense, it probably is undefined behavior. But I
> think it's one of those things that's OK in practice.

Yep, per the C standard §6.3.2.3 #7 [1]:

  A pointer to an object or incomplete type may be converted to a pointer to
  a different object or incomplete type. If the resulting pointer is not
  correctly aligned for the pointed-to type, the behavior is undefined.

To your point, it is probably fine in practice, but I'd lean towards
sticking with a 'char *' to play it safe.

[1] https://www.open-std.org/JTC1/SC22/WG14/www/docs/n1256.pdf

>> @@ -1935,20 +1935,24 @@ static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
>>  
>>  	ce = mem_pool__ce_alloc(ce_mem_pool, len);
>>  
>> -	ce->ce_stat_data.sd_ctime.sec = get_be32(&ondisk->ctime.sec);
>> [...]
>> +	ce->ce_stat_data.sd_ctime.sec = get_be32(ondisk + offsetof(struct ondisk_cache_entry, ctime)
>> +							+ offsetof(struct cache_time, sec));
> 
> I had figured we'd be able to drop ondisk_cache_entry entirely. But here
> you're using it essentially as a template for a set of constants
> retrieved via offsetof().
> 
> That's OK from an alignment perspective. It does mean we'd be in trouble
> if a compiler ever decided to introduce padding into the struct. That's
> probably unlikely. We don't use __attribute__((packed)) because it's not
> portable, and our existing uses have generally been OK, because our
> data structures are organized around 8-byte alignment. We might have
> problems on a theoretical 128-bit processor or something.

In addition to portability, using '__attribute__((packed))' could hurt
performance (and, in a large index, that might have a noticeable effect).

As for dropping 'ondisk_cache_entry()', I didn't want to drop it only from
the "read" operation (and use something like the "parse left-to-right"
strategy below) while leaving it in "write." And, as you mentioned later,
changing 'ce_write_entry()' is a lot more invasive than what's already in
this patch and possibly out-of-scope.

> Another strategy is to just parse left-to-right, advancing the byte
> pointer. Like:
> 
>   ce->ce_state_data.sd_ctime.sec = get_be32(ondisk);
>   ondisk += sizeof(uint32_t);
>   ce->ce_state_data.sd_mtime.sec = get_be32(ondisk);
>   ondisk += sizeof(uint32_t);
>   ...etc...
> 
> You can even stick that in a helper function that does the get_b32() and
> advances, so you know they're always done in sync. See pack-bitmap.c's
> read_be32(), etc. IMHO this produces a nice result because the reading
> code itself becomes the source of truth for the format.
> 

...

> One final note, though:
> 
>> +	ce->ce_stat_data.sd_mtime.sec = get_be32(ondisk + offsetof(struct ondisk_cache_entry, mtime)
>> +							+ offsetof(struct cache_time, sec));
> 
> Here (and elsewhere), you can assume that the offsetof() "sec" in
> cache_time is 0, for two reasons:
> 
>   - I didn't look up chapter and verse, but I'm pretty sure the standard
>     does guarantee that the first field of a struct is at the beginning.
> 
>   - If there's any padding, this whole scheme is hosed anyway, because
>     it means sizeof(cache_time) is bigger than we expect, which messes
>     up the offsetof() the entry after us (in this case sd_dev).
> 
> So this can just be:
> 
>   ce->ce_stat_data.sd_mtime.sec = get_be32(ondisk + offsetof(struct ondisk_cache_entry, mtime));
> 
> which is mercifully shorter.
> 
> Assuming we dismiss the rest of what I said as not worth it for a
> minimal fix, I do think that simplification is worth rolling a v2.

That makes sense from a technical perspective, but I included the starting
entry offset for readability reasons. It might be confusing to someone
unfamiliar with C struct memory alignment to see every other 'get_be32'
refer to the exact entry it's reading via the 'offsetof()', but have that
information absent only for a few entries. And, the double 'offsetof()'
would still be used by the 'mtime.nsec'/'ctime.nsec' fields anyway.

In any case, if this patch is intended to be a short-lived change on the way
to a more complete refactor and/or I'm being overzealous on the readability,
I'd be happy to change it. :) 

Thanks!

> 
> -Peff
> 
> PS BTW, I mentioned earlier "can we just get rid of ondisk_cache_entry".
>    We also use it for the writing side, of course. That doesn't have
>    alignment issues, but it does have the same "I hope there's never any
>    padding" question. In an ideal world, it would be using the
>    equivalent put_be32(), but again, that's getting out of the "minimal
>    fix" territory.

