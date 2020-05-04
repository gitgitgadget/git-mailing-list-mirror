Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB83C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 17:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90EA3206D9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 17:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfeRUIUp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730534AbgEDR4C (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 13:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729386AbgEDR4B (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 13:56:01 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DBDC061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 10:56:01 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id w29so267422qtv.3
        for <git@vger.kernel.org>; Mon, 04 May 2020 10:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bl7DmV0XoRmmG7jzqZ3M4xiGHunitfvAV25dn79ASxQ=;
        b=HfeRUIUpwq8ACC/ArnXzhCMx0GiVKZEBXJC6J8jR8bUbf+yodx96or0iMLclAvpBa0
         ej4ICUNMDjyUUPQ+Tznmg1QmdDpvDi1GYxQDEbxhW9sJXGTQFvLCSeeEz+1UF0p+wdsd
         RLjFKthmS7I5ICcXD1Mha4PvSIqfesJ8s/1Yxb2Sxat+D7CtDd5a3pxfgufmq5tpllxK
         6vjkGshvZFQgb8fP3UvXGN/TVjO0ITJGKe6i6+aH+zO9mISBUmc4x7kX4SKttbGT1UPW
         3huwosl1MGP62tzhEqfzuVV95IS9+2qox1AfdB88aTFnDmCTg7iqmyASeDxvinDTQme4
         7Lng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bl7DmV0XoRmmG7jzqZ3M4xiGHunitfvAV25dn79ASxQ=;
        b=VyLqVs2xpe8o8z8rLe9nEhR0itlRhpEHKFl4LAaiNtuAgM5bC0/qcxPADVHAr9xNSf
         t9oJvCKGXU+MEzAwK/0Vs+1IKC/PCql4V3lr647d2hM0Mmw001yvW0IZED1tVUOdJae1
         14D4YBhC/m8c9y0nSIx15itMRJW4NR1oeBZPd4rpbuPFnSbTLYExqI6wddc0G2YZOd6B
         B9u72HtHu8XXiaq216JsfQcq+/4lTAEThRtirtcPLx/aKjoUD+XADNg3MIgyiHY7Ll5j
         7eeaMawbT0SISw8HayF1IVHtjTZxKV0rt0bFnzTEwIKz6Z9UeWKtrP2pPHdvJaVzdrv3
         vbww==
X-Gm-Message-State: AGi0PuYowNVc8QqUB3rG+kHvM9AwM2PRYIX4oiNNZMYeYwf3tBs8FtAn
        ARyRjftCH1YM4j7DeOyU2BE=
X-Google-Smtp-Source: APiQypJlB8vNbqyHlCdbhiMsKcM00O6niuWIUtMq521MCVSCs11FpF/3hS6tcIFpu6QBPzcbhY8C+A==
X-Received: by 2002:ac8:1b97:: with SMTP id z23mr301234qtj.294.1588614960818;
        Mon, 04 May 2020 10:56:00 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id b42sm12073620qta.29.2020.05.04.10.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 10:56:00 -0700 (PDT)
Subject: Re: [PATCH 10/12] line-log: more responsive, incremental 'git log -L'
To:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, garimasigit@gmail.com,
        szeder.dev@gmail.com, jnareb@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.622.git.1588347029.gitgitgadget@gmail.com>
 <d9991d6158df6af0e62b8739591dd726d3479324.1588347029.git.gitgitgadget@gmail.com>
 <20200504175230.GB35579@syl.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4b7e5f51-9fdb-45ac-123e-2589087afa48@gmail.com>
Date:   Mon, 4 May 2020 13:55:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <20200504175230.GB35579@syl.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/4/2020 1:52 PM, Taylor Blau wrote:
> On Fri, May 01, 2020 at 03:30:27PM +0000, SZEDER Gábor via GitGitGadget wrote:

>> To be clear: this patch doesn't actually optimize the line-level log,
>> but merely moves most of the work from the preprocessing step to the
>> history travelsal, so the commits modifying the line range can be
> 
> s/travelsal/traversal

Thanks!

>> shown as soon as they are processed, and the traversal can be
>> terminated as soon as the given number of commits are shown.
>> Consequently, listing the full history of a line range, potentially
>> all the way to the root commit, will take the same time as before (but
>> at least the user might start reading the output earlier).
>> Furthermore, if the most recent commit modifying the line range is far
>> away from the starting revision, then that initial delay will still be
>> significant.
>>
>> Additional testing by Derrick Stolee: In the Linux kernel repository,
>> the MAINTAINERS file was changed ~3,500 times across the ~915,000
>> commits. In addition to that edit frequency, the file itself is quite
>> large (~18,700 lines). This means that a significant portion of the
>> computation is taken up by computing the patch-diff of the file. This
>> patch improves the time it takes to output the first result quite a
>> bit:
>>
>> Command: git log -L 100,200:MAINTAINERS -n 1 >/dev/null
>>  Before: 3.88 s
>>   After: 0.71 s
> 
> Are these 'real' times, or user/sys times?

True, this is a difference between my reporting and Szeder's. I only
report "real" time. 

Thanks,
-Stolee

