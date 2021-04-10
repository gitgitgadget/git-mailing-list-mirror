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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE74BC433B4
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 01:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF129610D1
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 01:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235215AbhDJBNP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 21:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235368AbhDJBNP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 21:13:15 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C273C061762
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 18:13:01 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id k18so2712123oik.1
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 18:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ucqFxQtkbnXYZrIDLvUKL0t6aiPdjfzxwn0Q7hs1GjE=;
        b=Z1E/W1ARWvCf9JfKMybDQB+uyjAmdgqkS94wPnKLvXapT7LFJu9oMNf8vtX4x6Uo7I
         1CNKMW3ChwKf4kgG8wS0OQHYnXbVMgS7XUo+BIwTYIw0yJ5WQ5P2TlyQyi5mEWamVuL1
         93LVC2QaSIcsqlCJmDBcBpkFwlNOoPj30mmhh5dVxHxj3X+cX2Bcl6PS367Idr83wXpz
         2XeQXIW3SKfAx9a/yIyGqS7358jh99TgfIrGaWrVXwVNO0Dd6/XV9yXEEChd4niMbCF0
         MjbwEHWAoEOauXNkYDt9J+syITnEZoTXL7OHv7k7Zyg+BZbzHBl9XkN/dXfZ18h7E2fm
         E4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ucqFxQtkbnXYZrIDLvUKL0t6aiPdjfzxwn0Q7hs1GjE=;
        b=QWfRCRoDDYn8ReHD/VNwTqFk0nXxECxD2gyvtG5+IMGcuzJIL1B0XoBajF4090Tk/h
         cMcvBhzFttC0+8eGaX5LhkIleCbV6ZSx0dGAul1l6ckW0udwdDaasHz/g5lToRi0hXb6
         szRbCC5K/yJU0hLhp8Y9YiLVqVmBeuB5hxyiY5oA0mszZfdWDFPHx3ijqhKLb9UMJqkN
         Qz/XmML99DvY/ICZSnLLQkcTwK3Kew3Qw1QIbIsDuOsluM+2c0PkfQY9XmHExB7qWDXw
         OhjRp1I007liO+tuCimm9v1hN4YVbJVBfv1AGWA7eBlFTTGggqg35Mu7iaRH5pFQGqyx
         rYHg==
X-Gm-Message-State: AOAM532gmWLf0l5cRoNbiA+lg9SzNu14ANgz86JPYbnntXH7dMMG+3/8
        KSL+i6hQhX/5qQ5dRnO8vc5CmusFNShBxQ==
X-Google-Smtp-Source: ABdhPJzZhXw4NgwMh1qFYcPczxN9qCHmyCV52nVZFT9kTlg6j6sLSc0Eyvm3YQyua71IXW2iVXIElQ==
X-Received: by 2002:a05:6808:7ca:: with SMTP id f10mr11877621oij.139.1618017180412;
        Fri, 09 Apr 2021 18:13:00 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:e556:d73b:6b67:5b9f? ([2600:1700:e72:80a0:e556:d73b:6b67:5b9f])
        by smtp.gmail.com with ESMTPSA id u7sm824754ooq.13.2021.04.09.18.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Apr 2021 18:13:00 -0700 (PDT)
Subject: Re: [PATCH] doc: update advice about other implementations' v4 index
 support
To:     Junio C Hamano <gitster@pobox.com>, scottworley@scottworley.com
Cc:     git@vger.kernel.org,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <20210409202206.29990-1-scottworley@scottworley.com>
 <xmqq1rbjm617.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6be901d0-1b7d-d4ef-388e-e7b2e4edbc7f@gmail.com>
Date:   Fri, 9 Apr 2021 21:12:59 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <xmqq1rbjm617.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/9/2021 6:45 PM, Junio C Hamano wrote:
> scottworley@scottworley.com writes:
> 
>> From: Scott Worley <scottworley@scottworley.com>
>>
>> Signed-off-by: Scott Worley <scottworley@scottworley.com>
>> ---
>>  Documentation/git-update-index.txt | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
>> index 2853f168d9..e8eca5dadf 100644
>> --- a/Documentation/git-update-index.txt
>> +++ b/Documentation/git-update-index.txt
>> @@ -166,9 +166,10 @@ you will need to handle the situation manually.
>>  +
>>  Version 4 performs a simple pathname compression that reduces index
>>  size by 30%-50% on large repositories, which results in faster load
>> -time. Version 4 is relatively young (first released in 1.8.0 in
>> -October 2012). Other Git implementations such as JGit and libgit2
>> -may not support it yet.
>> +time. Version 4 is relatively young (first released in git 1.8.0 in
>> +October 2012, supported in libgit2 0.24.4 from December 2016, go-git
>> +4.0.0 from January 2018, and jgit 5.9.0 from September 2020). Other
>> +Git implementations such as Dulwich may not support it yet.
> 
> Thanks for these dates.  Time flies---I didn't realize it has been
> almost 9 years---the feature was merged in May 2012, in v1.7.11
> (yes, I am hinting that the original lists a wrong date and we
> should correct it while at it).
> 
> I wonder if we should lose "relatively young" from the description
> here, though.
 
I was thinking the same thing. It has had extensions added such as
the End-of-index extension, but even that is approaching three years
ago.

Thanks,
-Stolee
