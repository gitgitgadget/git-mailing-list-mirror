Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CA3C47087
	for <git@archiver.kernel.org>; Fri, 28 May 2021 08:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29CB5613E3
	for <git@archiver.kernel.org>; Fri, 28 May 2021 08:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbhE1IxC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 04:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235559AbhE1IxC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 04:53:02 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F66C06174A
        for <git@vger.kernel.org>; Fri, 28 May 2021 01:51:26 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id j10so3943514edw.8
        for <git@vger.kernel.org>; Fri, 28 May 2021 01:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=estN8pS3/SQhZi3/6zOyi1Ks2zHFS3xKNBK61JmDiwU=;
        b=AXp8t79WQashUyCpLmYL69bCYAZ1WZ5yFpXZnfzDxD902+ova1P07Nk3jZ3t4jaQom
         X1dpo/A3Gdt2hAesZEJwhbf5hUQ0VLjyrdbm+eDoQYC49B6Jer3Ow/Li8yM+lE8nN6p3
         uSlElO1/y31wc755OzrjokVcfddYBcZQF0JDzTQhuSydKdDAbByvMgTy5Bj3gwt/WIIa
         f57Yr1ctLmgvYxIdNDKMOB9xJYu1IWYrwyolfSkKtaR2MLqrGCbLo4KcLi6HepUpiokl
         a6fmHl6kVEKi8JGaFKUd9lw1S52l1xBqDBc3PbN1eBj//I/zNKXmd/1N47d7SMpZbIRI
         Iv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=estN8pS3/SQhZi3/6zOyi1Ks2zHFS3xKNBK61JmDiwU=;
        b=pUeamU5tBZCCYPWiZ36Z+KEf9ObKhG+kHZHKuh7t57v2PRgsoU2FRYCx80hhyW8Jyf
         PvoJ2lGKa3iF7cpyu6IjtkPM1UHiJu8KW397PWcAqACw8ODT3MadbZMy9vuDxRKgyFBz
         A2oLPF6fnTWrUmrol7S94RlVjtCeR040wJTTYhuqmJpZ0rw6alOThD4cdUQj6elyuo5K
         +v0o6Q2JIciVnqi3p7YK2/bbeqIB3T8yYcQGh5ixwT/0AEOxk0wdAvlkbn6CX28SdZtL
         0PmaO7neLj9dG5RTlJJRJ2CthdAwW7tjwKkTZ1IyjDU28QUQbwtmnq2w4CTcr8kY0pNz
         i7TQ==
X-Gm-Message-State: AOAM533R3DGT257iBI0pSZwYaRbTNCVPuMQaXoOqy4APr8qTLPcgA+Op
        RtCAitx+ldQrLY4A035YmK2FfVsXfhs=
X-Google-Smtp-Source: ABdhPJxEJGJuY3emYxQcA/P+SROM8PxsCnp+YzOvnw8U7WRfMP69FpUl1kctbkusoc2D9u4gpshuvw==
X-Received: by 2002:a50:8fe6:: with SMTP id y93mr8651875edy.224.1622191884725;
        Fri, 28 May 2021 01:51:24 -0700 (PDT)
Received: from ?IPv6:2a02:8388:e002:8cf0:b0b8:f178:ae9f:6d19? (2a02-8388-e002-8cf0-b0b8-f178-ae9f-6d19.cable.dynamic.v6.surfer.at. [2a02:8388:e002:8cf0:b0b8:f178:ae9f:6d19])
        by smtp.googlemail.com with ESMTPSA id a97sm2371852edf.72.2021.05.28.01.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 May 2021 01:51:24 -0700 (PDT)
Subject: Re: git push doesn't use local branch name as default
From:   Mathias Kunter <mathiaskunter@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <3b9bc214-a30a-ba49-af96-7eeaf37b7bbd@gmail.com>
 <fcf30899-8e64-5417-f478-14d6aca72544@gmail.com>
 <CABPp-BEeqqGwN3=MbWCYnsyryBm3WoaX5GZyXTWy18UiYUT4zg@mail.gmail.com>
 <f9f38d42-2b93-0d3b-798b-4c6f44eb111d@gmail.com>
Message-ID: <287483ba-d682-6d04-23fa-22c33ab70376@gmail.com>
Date:   Fri, 28 May 2021 10:51:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <f9f38d42-2b93-0d3b-798b-4c6f44eb111d@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-AT
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Note that git itself also claims this should be working. If I do a "git 
push" on a branch without upstream, I will get:

> fatal: No configured push destination.
> Either specify the URL from the command-line or configure a remote repository using
> 
>     git remote add <name> <url>
> 
> and then push using the remote name
> 
>     git push <name>

However, the advised "git push <name>" command won't work on that branch 
with the default settings of Git. To make it work, `simple` pushing 
would have to use `current` behavior on a branch without upstream.

Please consider changing that. Thank you.

Cheers
Mathias Kunter


Am 28.05.21 um 09:44 schrieb Mathias Kunter:
>> you only get the "current" behavior when fetch_remote is non-NULL.
> 
> Well, then my suggestion actually is to also use the `current` behavior 
> when fetch_remote is NULL - i.e. change
> 
>> return (fetch_remote && fetch_remote != remote);
> 
> to
> 
>> return (!fetch_remote || fetch_remote != remote);
> 
> I'd argue that if `simple` pushing is used, then the expected behavior 
> of the command
> 
>> git push <remote_name>
> 
> on a branch without upstream would actually be to use the `current` 
> behavior instead of bailing out with an error.
> 
> 
> Am 28.05.21 um 09:00 schrieb Elijah Newren:
>> On Thu, May 27, 2021 at 11:39 PM Mathias Kunter 
>> <mathiaskunter@gmail.com> wrote:
>>>
>>> Felipe,
>>>
>>> thanks for your reply.
>>>
>>>> Sounds like you want to change the default to `push.default=current`.
>>>
>>> Yes, but shouldn't `simple` pushing also work? The documentation says
>>> about `push.default=simple`:
>>>
>>>> When pushing to a remote that is different from the remote you normally
>>>> pull from, work as `current`.
>>
>> Perhaps this wording should be clarified to read
>>
>> When you have a remote that you normally pull from but you are pushing
>> to a different remote then that one, then work as 'current'.
>>
>>> If there is no upstream, then there also is no "remote I normally pull
>>> from", and thus, according to the doc, `simple` should actually work
>>> like `current` in this case. Am I wrong here?
>>
>> The relevant code is
>>
>>      return (fetch_remote && fetch_remote != remote);
>>
>> so you only get the "current" behavior when fetch_remote is non-NULL.
>>
