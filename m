Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAB1C07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 19:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32444613C5
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 19:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhGITXi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 15:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhGITXh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 15:23:37 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F8FC0613DD
        for <git@vger.kernel.org>; Fri,  9 Jul 2021 12:20:52 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id i11so1159452qvv.12
        for <git@vger.kernel.org>; Fri, 09 Jul 2021 12:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=taoPs+ga68l3YwNIPerydtbCfWNW3rhsC9zqpT1kJOs=;
        b=d7ouiP0CSvaHh0TLtumgLgubXT8/mQS2nUD/OdiSivAjc8ie7+MEOlss6wt2dAz2up
         fFFVBnw+IJgnZ4LOB7BfuYXUyA+z0HhdPmjjO7SNDjQlhs2xEKymHbEk5a1yYn5InR6n
         6oyd8QuDF65a3wH9ZuzQi2eibchC9+T5h41rAqA9alZfS5LyltLjx751JI/Ury9kXvms
         eJpOM3/+jCEboYArJK0Hc5U+/6uEvZBpDch9vsOrYE1LnG3uP53Tt4Ha4XhVCwi8xuln
         u4kAemavMLHUpYALiXZtzmOW0Ci3n9zf6I6BPBohY701Sgh6PayUbdtg505yuWuG3kOL
         R4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=taoPs+ga68l3YwNIPerydtbCfWNW3rhsC9zqpT1kJOs=;
        b=X891vXn6cvDURVSxvV2QjBlh3SLYU5tp+0SJrSVbvr5L7QNzf7biKnG/CTI/ApwIt+
         NemMdzO7svbMduRpZUx3AjsgKMqFo+P+a4s3ewHiNgyVlzYvzfE5hY2uoBIVBVOJUqpp
         UyrItCydXcCUS43TsGpuwWeYHJdTcpDiDVBjKZj2QmSPa2OIOe4qew7K4i4KlAkJZavY
         EgwiOSGur+fb4kyTnEB2Ft5T9U9lJOKffCUUH7XYJXNks1B3uStOgbEiCeIlBRkXkfMA
         0xEeD7C59sd9snQZfmf/rPnV7WTuzuAu9EbcQZ8YHh6rhBxzPeCZPo7/T7njKgwDtrzZ
         2s9g==
X-Gm-Message-State: AOAM5328Rt+whH8BG0CNshN4JClX0WaTVvgu7OZPCzj15by+wiSoJMHF
        idFKqJZp+tizJl3AwRcGJsWzug+IhfY=
X-Google-Smtp-Source: ABdhPJygNSAFAjjm/2esu11c5m5jGCEIIsaTwXRrJBXYYkQLJ5cIeRKZMReT3s+T+9/Jj6JfvJEg4Q==
X-Received: by 2002:a0c:9ada:: with SMTP id k26mr6618848qvf.16.1625858451616;
        Fri, 09 Jul 2021 12:20:51 -0700 (PDT)
Received: from [192.168.1.243] (pool-74-96-77-217.washdc.fios.verizon.net. [74.96.77.217])
        by smtp.gmail.com with ESMTPSA id o10sm2450399qtv.62.2021.07.09.12.20.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 12:20:51 -0700 (PDT)
Subject: Re: Troubles redirecting git output
To:     Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org
References: <57ebeb1d-f467-6cbd-5ad9-a55cf04dde34@gmail.com>
 <87f4a68e-3a74-eddf-c4ad-e6674d9f7994@xiplink.com>
From:   Baptiste Chocot <baptiste.chocot@gmail.com>
Message-ID: <356c442a-5b21-39ed-ca58-dc9c67727089@gmail.com>
Date:   Fri, 9 Jul 2021 15:20:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87f4a68e-3a74-eddf-c4ad-e6674d9f7994@xiplink.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Marc,

Thanks for your help... :facepalm: I look like a noob but at least I've 
learnt something useful.

Have a good day!

On 7/9/21 9:40 AM, Marc Branchaud wrote:
> On 2021-07-09 7:59 a.m., Baptiste Chocot wrote:
>> Hello guys, hope you're doing great.
>>
>> I'm reaching out today because I cannot find a fix for my issue. I'm 
>> using git 2.25.1 from the debian repo. I'm having difficulties to 
>> redirect git stderr, here is an example:
>>
>> ---
>> $ git init
>> Initialized empty lol/.git/
>> $ git branch >&2 2>/dev/null
>
> Try swapping the two redirections:
>     git branch 2>/dev/null >&2
>
> I believe that standard shell behaviour is to apply a redirection 
> immediately when it appears while parsing the command.  I believe that 
> although the man pages say "redirect" internally the code just 
> *replaces* the old file descriptor, e.g. basically something 
> equivalent to
>     stdout = 2
>
> So when you say
>
>     git branch >&2 2>/dev/null
>
> The shell sees
>
> ">&2" -- The shell redirects stdout to file descriptor 2.
>
> "2>/dev/null" -- The shell opens /dev/null (as descriptor 3) and 
> *replaces* descriptor 2 with the new descriptor.  But at this point, 
> stdout is still being sent to the original descriptor 2.
>
> When I redirect, I'm in the habit of setting stdout first, then set 
> stderr to stdout. The numerical ordering helps me avoid this mistake:
>     git branch >/dev/null 2>&1
>
>         M.
>
>
>> fatal: your current branch 'master' does not have any commits yet
>> ---
>>
>> Is this an expected behavior? I find it weird not to be able to 
>> silent git. Are you aware of a workaround? I've been browsing a bit 
>> but did not find an answer yet.
>>
>> Thanks for your time!
>>
>> Baptiste
>>
