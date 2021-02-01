Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9F3C433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 16:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37E7064E8D
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 16:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhBAQcJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 11:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbhBAQby (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 11:31:54 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A036AC061573
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 08:31:12 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id d5so1433270otc.1
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 08:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=73mNe9LXaGC//leaPtP9kLUepAM76JKLwmXymkng0Ac=;
        b=ZzoOUm+MKmRxVjGBrA70DEmpBiijsTRGUQmc0U+bwaDTrq59r5RHsK/WcU+yEt9K7w
         g5nIOnNLXAHpsaTewBGcF58XGtx3zJv/7gtXmB60B7gjVwVzUuAwgPYKwPChkgVvNdhU
         3yF8OCqjODELruDbcZfAO6sE+lL+w3Pf3+ESeg3PEva87fS8pNIZIEMpsldVrxN9ZuPF
         m+V8UW2NxxmRlZW2cJclJu63ZHUuecWAn9uiFwnOwM7iVM0VM6Kpd6h/yWfdvFR0NqEL
         1zu9qoEL+rdUBtw6YQJpr/3UwVAL3zAZpXHYl+1ihxj8WresOfZuEF1Ci/QPsP139PKU
         y9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=73mNe9LXaGC//leaPtP9kLUepAM76JKLwmXymkng0Ac=;
        b=ILJR2/IP8N5QwbOPUuZVZ8BB7UYRey/0mCFgpm6epPXAQBD3j3Dg3wr/5qe8hYovmE
         4jOz2Gn+raMXCTSwGGhQb29XkurFVI7LxjxuvE841WOZviYbWnt+DJQPssp7I9GrvOht
         KvOBqcH3F7Ig1+UtxrW2ppu7OQwtqo87AxNIQuY+lVauq7v/cMjDeJUc6p/oebkODDSv
         qmU8Ci5N9L8OR788jc26FWLc0babh4R8v4PMLwfOLzY2rM2zYeOrMz1jAe+m/3GEUtlh
         9zGed2kWZT2yIngU0qCN20AGlL4h3LYJ8aSBiwS3XXplmN+wV8PljpGXCKK06zKd/mvm
         garw==
X-Gm-Message-State: AOAM533hvCVamxMlyGaBUp+t2+EviJ5rftT0nLJaRnXhwSz6WZlsGjOL
        ovLU19Cvfr4GemATANsZEwc=
X-Google-Smtp-Source: ABdhPJzlZncTBhPKOrQBnQmfZ3yGFGJBJVBUd+ksBTWoQTg+AzQ4TrEGGNfMzFJP1vjYw+p5owHYRA==
X-Received: by 2002:a05:6830:12c7:: with SMTP id a7mr12898689otq.103.1612197071980;
        Mon, 01 Feb 2021 08:31:11 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:8497:2090:4038:7fd1? ([2600:1700:e72:80a0:8497:2090:4038:7fd1])
        by smtp.gmail.com with UTF8SMTPSA id w5sm4072588ote.29.2021.02.01.08.31.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 08:31:11 -0800 (PST)
Message-ID: <5236b427-d10c-acaf-e8c4-97011bc68c49@gmail.com>
Date:   Mon, 1 Feb 2021 11:31:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH v2 2/5] commit-reach: use one walk in remove_redundant()
Content-Language: en-US
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe=2e?= <l.s.r@web.de>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, me@ttaylorr.com,
        peff@peff.net, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.852.git.1611851095.gitgitgadget@gmail.com>
 <pull.852.v2.git.1612183647.gitgitgadget@gmail.com>
 <2f80ae5fcb00d9d5c1b0502af45921cb20ebdf94.1612183647.git.gitgitgadget@gmail.com>
 <419ddcca-8534-8dc5-bcd8-1e244414bcf1@web.de>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <419ddcca-8534-8dc5-bcd8-1e244414bcf1@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/1/2021 11:12 AM, René Scharfe. wrote:
> Am 01.02.21 um 13:47 schrieb Derrick Stolee via GitGitGadget:
>> @@ -210,12 +204,110 @@ static int remove_redundant(struct repository *r, struct commit **array, int cnt
>>  	for (i = filled = 0; i < cnt; i++)
>>  		if (!redundant[i])
>>  			array[filled++] = work[i];
>> +	for (j = filled, i = 0; i < cnt; i++)
>> +		if (redundant[i])
>> +			array[j++] = work[i];
> 
> This puts the loop back in that you removed in the previous commit.
> Intentionally?

Not intentional. Thanks for noticing.

>> +	/* rearrange array */
>> +	for (i = count_non_stale = 0; i < cnt; i++) {
>> +		if (!(array[i]->object.flags & STALE))
> 
> Here I would have added another condition, count_non_stale != i, to
> avoid self-assignment (array[x] = array[x]).  The code works without
> it, though.  Not sure if there is a performance benefit to be had --> branch vs. pointer copy.  Probably not worth it..

You are correct, but I'm going to go on the side of not worth it.

>> +			array[count_non_stale++] = array[i];
>> +	}
>> +
>> +	/* clear marks */
>> +	for (i = 0; i < walk_start_nr; i++)
>> +		clear_commit_marks(walk_start[i], STALE);
> 
> You can replace this loop with a call to clear_commit_marks_many().

Right! Earlier I was using a 'struct commit_list *' which would not
work, but this 'struct commit ** walk_start' does work. Thanks.

-Stolee
