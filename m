Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2025DC433E0
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 21:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDEE622CAF
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 21:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbhAWVPU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 16:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbhAWVPT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 16:15:19 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95291C061786
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 13:14:38 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id d18so1038921oic.3
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 13:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pI4WGS53LhHwgcSNCvCTZ2xSTDyZUR8LtGyzGCQsqDw=;
        b=C++nmuHYM5hkyXET+UaNwpjTEM4hUPST9QcjMroCFGAK2uxBiLuSPbYDIfoTDKhVUB
         koWFit8q6looBjkYvL3KAa+EKER96WeBrX7wr6QseAhOZDcKVPRJmjdGYX1vbMhB3Nay
         Jf5w4kfmrDl5OVQFoR6pmVgU+nweGMgC+ZNQaM/WiGg8INfwe/D5i9+G+TP7n212aP1u
         zxZudCMBrQWMudNteXX3hukVDkfKFKRQFREDuenrs3TDNl8WNIgS/n7AyOYdyIMBLm5w
         DtAMqPULwNNOtFuq3m5S17e/S32Kp9YAMsORLeQnd8ASwiWoVgE9zn+q3hlP//4XJX5G
         VAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pI4WGS53LhHwgcSNCvCTZ2xSTDyZUR8LtGyzGCQsqDw=;
        b=oXG2a+HMRUWjZ6A4/fTV/VFoLkkiHusFBWGXT27KrBYAAeeUgOSGHpv56xlMRqJamg
         yIWusMycI7mD30XSvzs43L/ejpqucKB+JDqq13ZAnJujRIUKblfXEQl9sYA+OUtTJwdf
         14r7mI+GUC+TMo6421LOFHh8nH133xMblvKcyQtDiPm2Xsd9aBe4i+kyQkg+S8bFH9UE
         0ORNp7UybLU4PgaFMith76Lz3UXZ+DLWa9yaO5R7oqeOKJiMOu6Ilas3JvrJGxM+wsJ0
         7hafguAyDXmVx5fEA/T1qkyaGPykoMAbkp/cnR5XJNAzzKx6L04jIk/GP0Z6Is56CaRK
         GhxQ==
X-Gm-Message-State: AOAM530aa5Y3X7Cl2gXTzUWF15cOPADYVwrdB6LxhttWgcAVQ5B2Usp4
        /h0a5GUhgP8qpPoV9Qb9Jk0=
X-Google-Smtp-Source: ABdhPJxPYD2DNibkvGmqvqbc7DTFUZjYAS3fyIwy18j3A4wMWoetdps35R4fNmL1HokhUhLhje2dEw==
X-Received: by 2002:aca:b5d6:: with SMTP id e205mr6989132oif.15.1611436477845;
        Sat, 23 Jan 2021 13:14:37 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:98e8:103:e6ee:9536? ([2600:1700:e72:80a0:98e8:103:e6ee:9536])
        by smtp.gmail.com with UTF8SMTPSA id r8sm2551090oth.20.2021.01.23.13.14.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Jan 2021 13:14:37 -0800 (PST)
Subject: Re: [PATCH v3 2/9] cache-tree: simplify verify_cache() prototype
To:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.839.v2.git.1611320639.gitgitgadget@gmail.com>
 <pull.839.v3.git.1611431899.gitgitgadget@gmail.com>
 <1b8b56800948339c0e0387555698bdfdc80a19ad.1611431900.git.gitgitgadget@gmail.com>
 <CABPp-BEsoWs5ZEhS0KTHankzc8eUdmpn0uoF7t1ZtN8b2gwvBA@mail.gmail.com>
 <xmqqy2gj2wc0.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <51dc4a80-1bea-a028-ccd1-ccae968a82a3@gmail.com>
Date:   Sat, 23 Jan 2021 16:14:36 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <xmqqy2gj2wc0.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/23/2021 4:10 PM, Junio C Hamano wrote:
> Elijah Newren <newren@gmail.com> writes:
> 
>>> -       for (i = 0; i < entries - 1; i++) {
>>> +       for (i = 0; i + 1 < istate->cache_nr; i++) {
>>>                 /* path/file always comes after path because of the way
>>>                  * the cache is sorted.  Also path can appear only once,
>>>                  * which means conflicting one would immediately follow.
>>>                  */
>>> -               const struct cache_entry *this_ce = cache[i];
>>> -               const struct cache_entry *next_ce = cache[i + 1];
>>> +               const struct cache_entry *this_ce = istate->cache[i];
>>> +               const struct cache_entry *next_ce = istate->cache[i + 1];
>>
>> Makes sense.  Thanks for explaining the i + 1 < istate->cache_nr bit
>> in the commit message; made it easier to read through quickly.  I'm
>> curious if it deserves a comment in the code too, since it does feel
>> slightly unusual.
> 
> I think this is entirely my fault.
> 
> It probably reads more natural to start from 1 and interate through
> to the end of the array, comparing the current one with the previous
> entry, i.e.
> 
> 	for (i = 1; i < istate->cache_nr; i++) {
>         	prev = cache[i - 1];
> 		this = cache[i];
>                 compare(prev, this);

This would be another natural way to make the loop extremely clear.

It's a bigger diff, changing the names of 'this' and 'next', but
perhaps worthwhile.

Thanks,
-Stolee

