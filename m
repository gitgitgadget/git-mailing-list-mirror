Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9A8C433DB
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 21:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1156365244
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 21:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbhCIVBS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 16:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbhCIVBB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 16:01:01 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16623C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 13:01:01 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id 75so10962713otn.4
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 13:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rWl1dMNNQKd/W97zcem7S14ZfVJwgwci4uLYCfPPOIc=;
        b=aOchupRAQvP/Ei7Mb8UqVXAfGbLP0w0CrlIKXcDup+K5d7ypJSqx/tgqZl/r9CjTpb
         eUXu6Uu0iYN5xYpYq09O989vfT9JrZXyo8P3/qYZYJOFiY30Zce+An09K6QRsLq8Cr0U
         7Ctu/xTPlCmt2Y4S/69YINyzokrbUpuitBWQJ5GByalzGLovHOS2vjoTCsNsrjpNceHz
         v1NGaxk5H6hUfTf/MtBRaJxAxGZshCKd1WTii6gNAnf+5QrBpV5SVzXiYss7nvHlIMKA
         8rE581WJd/VpHWbc6aVATR/yo7ui1vwayhFNwoundih4VWhTrbL84/axn3I8GnSPRa0Y
         jWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rWl1dMNNQKd/W97zcem7S14ZfVJwgwci4uLYCfPPOIc=;
        b=QAu5WgFJ0TE0EIeiaam8T5cyZhEJlDAcoCpYPMDX3k42g/c1+OT5T7NKOTb5BDOJ4G
         Q4zN3GuGucOjbcmxONDpT9yYWHVLW922obmhHec8jEHmt9BDo8P8z4iKAhesAnLldjDx
         5Yf+jj8YMw2jZxyeOsjDWGAkeLR3Ns0snrPnxg+TYDbYHwKW8+LT7Wt1slbpu4Ac69kl
         jgoHFR5n6z2ksdPBkDUjansbcH7GqaqJ+ymHa/FLFi6NGPHtii1AOClxb0K4VGAsTW/L
         lD/grbI7fYEUxxOpagREKpsmohQnpDHfLqcoTqXWbJ49TD6B/u7diJmrmvHY8l6+EpZu
         KtZw==
X-Gm-Message-State: AOAM533OR7omtnZmxNH7ddkhh+lvwTgdRIRx14pXDPWh0nKHjBliQ+XP
        +pRTmdsHFzdjqnlqAT4ZflI=
X-Google-Smtp-Source: ABdhPJxK+AP7uqYK0mAPx33FctqYaOYOZlov6Ovfqf34nczXXVYQWEmc5rlfl7S1mLwmUAdrJrihSw==
X-Received: by 2002:a9d:66c9:: with SMTP id t9mr30512otm.111.1615323660474;
        Tue, 09 Mar 2021 13:01:00 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:88a7:dd04:71df:86ee? ([2600:1700:e72:80a0:88a7:dd04:71df:86ee])
        by smtp.gmail.com with ESMTPSA id y11sm3137978oov.9.2021.03.09.13.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 13:01:00 -0800 (PST)
Subject: Re: [PATCH 07/20] test-read-cache: print cache entries with --table
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
 <3d92df7a0cf9655dd34895f106cfac26ea44ad94.1614111270.git.gitgitgadget@gmail.com>
 <CABPp-BGspVmXFNpAoF-8wcb4eyjyivM4Cpcy4wRfjL6kMxcu6Q@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <27f113c8-313e-6812-0646-5073891df448@gmail.com>
Date:   Tue, 9 Mar 2021 16:00:57 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BGspVmXFNpAoF-8wcb4eyjyivM4Cpcy4wRfjL6kMxcu6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/25/2021 2:02 AM, Elijah Newren wrote:
> On Tue, Feb 23, 2021 at 12:14 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> This table is helpful for discovering data in the index to ensure it is
>> being written correctly, especially as we build and test the
>> sparse-index. This table includes an output format similar to 'git
>> ls-tree', but should not be compared to that directly. The biggest
>> reasons are that 'git ls-tree' includes a tree entry for every
>> subdirectory, even those that would not appear as a sparse directory in
>> a sparse-index. Further, 'git ls-tree' does not use a trailing directory
>> separator for its tree rows.
>>
>> This does not print the stat() information for the blobs. That could be
>> added in a future change with another option. The tests that are added
>> in the next few changes care only about the object types and IDs.
>>
>> To make the option parsing slightly more robust, wrap the string
>> comparisons in a loop adapted from test-dir-iterator.c.
>>
>> Care must be taken with the final check for the 'cnt' variable. We
>> continue the expectation that the numerical value is the final argument.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>  t/helper/test-read-cache.c | 50 ++++++++++++++++++++++++++++++--------
>>  1 file changed, 40 insertions(+), 10 deletions(-)
>>
>> diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
>> index 244977a29bdf..e4c3492f7d3e 100644
>> --- a/t/helper/test-read-cache.c
>> +++ b/t/helper/test-read-cache.c
>> @@ -2,35 +2,65 @@
>>  #include "cache.h"
>>  #include "config.h"
>>
>> +static void print_cache_entry(struct cache_entry *ce)
>> +{
>> +       printf("%06o ", ce->ce_mode & 0777777);
> 
> This constant is curious.  I think it's because you want to strip off
> the special in-memory bits of the ce_mode where git stores extra data,
> which would be everything beyond the first 16 bits (as noted in a
> comment near the beginning of cache.h).  But here you keep the first
> 18 bits.  Is CE_UPDATE and CE_REMOVE just 0 in the cases you've viewed
> so this works (but you really should use 0177777 or 0xFFFF), or am I
> off in my guess of what you're trying to do and you do want to see
> those two flags?

You're right, 0177777 is what I want. I'm focusing only on the
file permissions bits that are reported by ls-tree.

> It also seems surprising to me that this constant isn't already
> defined somewhere in cache.h or as some variant of S_IFMT, though I'm
> not finding it.

I'm not, either.

>> +
>> +       if (S_ISSPARSEDIR(ce->ce_mode))
>> +               printf("tree ");
>> +       else if (S_ISGITLINK(ce->ce_mode))
>> +               printf("commit ");
>> +       else
>> +               printf("blob ");
> 
> Perhaps make use of the tree_type, commit_type, and blob_type global constants?

Today I Learned...

>> +
>> +       printf("%s\t%s\n",
>> +              oid_to_hex(&ce->oid),
>> +              ce->name);
>> +}
>> +
>> +static void print_cache(struct index_state *cache)
>> +{
>> +       int i;
>> +       for (i = 0; i < the_index.cache_nr; i++)
>> +               print_cache_entry(the_index.cache[i]);
> 
> Why are you passing cache as a parameter, then ignoring it and using the_index?

Good catch!

Thanks,
-Stolee
