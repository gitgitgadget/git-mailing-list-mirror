Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB196C433E0
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 13:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9359E64E0B
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 13:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhBHNgM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 08:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhBHNgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 08:36:09 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD80C061786
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 05:35:29 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id v19so2135739qvl.7
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 05:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=q8nsdt5gzZnG9irBY6q+x0FebJPSuiKeWFUZEyc9MZU=;
        b=XzjzR8P+eV2vY7zyZLMklxlyKE9g11IpY4KvtsMQeCSvhoWk+e7nvNtr4MvRaxkCXV
         j/qKFTT9LFnsfebECgRr3L3S4fypJDvfDr6j2qQiRZ/Ir/YjUa2r30FvHTHimhEK7W+Q
         2lHlRByZzu/rEWeKyLqgfLsEjZ42tVaMmljtta45G96Mhmce0buxHBj7yJsc8/nmGpul
         3k9w9vM7oPRcsjZQU2XH+xlCSxCxAW7ol5PVw5mrfNmwZ+XKtOBdcP7hgagtinbRv5q0
         87icLPGupMtrPgSrE+X7IanvxnqbxSClCfdcKIedVG9jT0NWae4QS5jbTpVfzN0K9RuB
         tE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=q8nsdt5gzZnG9irBY6q+x0FebJPSuiKeWFUZEyc9MZU=;
        b=ZJhAOxZRIZ/HgYqU7/CYBbkfDHjXfEPdLy6rIpJXhGK7jySupAj01W7i4wm4RUQKy9
         anjv8wniNQDVMnUUs/RkLfucHsEy2IXxwm9d7FvJRC1hJIHi25iFgcfND27zCa1m6l1X
         AenjCsPE3Dc+BppKNoeiZtwHPJJHyo9Q/uxpX4U4F+FOn/X5BE4k9A2VkD1N2GZMaIP+
         KyOGKBfgLR/Xc3dGy/aSGwqAT0VMkUDKqpz7A4Jbl1/KRA2uSk34jNNZw5NZUc52GPlR
         ZZhFly2zj+4Qo1ZvY+Lv+JhM0AH3eEivYjV0H56M7GinXZf2dsU/EUMPFw5Qku9gEShh
         gRRw==
X-Gm-Message-State: AOAM532R9ODoizT/lsjjy9pHJcYglK0ivJ54/23EI4EVSvnG/k6Ok3Vg
        QCkSbCa7bBRiOHPxw6cEADQ=
X-Google-Smtp-Source: ABdhPJxCYddga2mGgPBVGELb2R3SSLg+zu/+mgBNmufbURKyVuTwg6qnCL0VKsJ0eAIMHtlp3KXrXQ==
X-Received: by 2002:a0c:ca0f:: with SMTP id c15mr16037772qvk.61.1612791328495;
        Mon, 08 Feb 2021 05:35:28 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:b91a:dd2f:a591:6ed1? ([2600:1700:e72:80a0:b91a:dd2f:a591:6ed1])
        by smtp.gmail.com with UTF8SMTPSA id q6sm16328490qkd.41.2021.02.08.05.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 05:35:28 -0800 (PST)
Message-ID: <f860ef94-567a-371d-7834-8f2221cdf7df@gmail.com>
Date:   Mon, 8 Feb 2021 08:35:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH v3 12/17] chunk-format: create read chunk API
Content-Language: en-US
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        l.s.r@web.de, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
 <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
 <366eb2afee839feccdfd2244b231d2ad718c76d4.1612535453.git.gitgitgadget@gmail.com>
 <20210207202042.GC1015009@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20210207202042.GC1015009@szeder.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/7/2021 3:20 PM, SZEDER Gábor wrote:
> On Fri, Feb 05, 2021 at 02:30:47PM +0000, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> Add the capability to read the table of contents, then pair the chunks
>> with necessary logic using read_chunk_fn pointers. Callers will be added
>> in future changes, but the typical outline will be:
>>
>>  1. initialize a 'struct chunkfile' with init_chunkfile(NULL).
>>  2. call read_table_of_contents().
> 
> A reader should call read_table_of_contents(), noted.
> 
>>  3. for each chunk to parse,
>>     a. call pair_chunk() to assign a pointer with the chunk position, or
>>     b. call read_chunk() to run a callback on the chunk start and size.
>>  4. call free_chunkfile() to clear the 'struct chunkfile' data.
> 
> How could a user of this API learn about all chunks present in the
> chunkfile, including unrecognized chunks?

That could certainly be added (when needed) without modifying the data
structures.

>> +/*
>> + * Initialize a 'struct chunkfile' for writing _or_ reading a file
>> + * with the chunk format.
>> + *
>> + * If writing a file, supply a non-NULL 'struct hashfile *' that will
>> + * be used to write.
>> + *
>> + * If reading a file, then supply the memory-mapped data to the
>> + * pair_chunk() or read_chunk() methods, as appropriate.
> 
> And call read_table_of_contents() in between.

Yes, you are right.
 
Thanks,
-Stolee
