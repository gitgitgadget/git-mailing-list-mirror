Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB3CC43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 00:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F32620721
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 00:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijTf8feK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732994AbgDBAGw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 20:06:52 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39487 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732385AbgDBAGw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 20:06:52 -0400
Received: by mail-qt1-f194.google.com with SMTP id f20so1879006qtq.6
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 17:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8jE/uYNrR+7HEIP6ov6RPVoqirboZYKynUvumHxgdUs=;
        b=ijTf8feKjAYmDSfP+6nzrDi7YsQQkbqpT/OTmtFKxg2lKvyNtJtdoYudvN8BhQvgyy
         nUBCbaq0yOSHHvbQ2qVORbstDBzYoW8JuErCI2CzaEfgUnfeAbeLrJm2NyResrbTR1L0
         +Lx6X17yKgtXUFEws3WgDxALTac5PF8bdkx4E/Zz5sO0JfW0DrQLxRnBqgWksOV1GdvJ
         DIJXaVlHwEE0c9LpHkmDPyqX6HPrDBKZ2Yty89cPAsxz93oHKQ99HtQnN0KFUkIZSY5q
         xbSko7LVNQ7bkmHo3Z1plVVUIgiwXQt6okXOWQlvgS6588W5AfDQodbA9kC9fVATFiMF
         JLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8jE/uYNrR+7HEIP6ov6RPVoqirboZYKynUvumHxgdUs=;
        b=YznnjXgsvaALLpNKSj8wSDvL+Gpu46UCbYzljUOu7K+YmVsF+ZYw5tSH57SLYt9czL
         zxtexogXvrDyW9UgahE6ahlO7M5jeK04+8tsm2eUhDLULduoS9On86sSag0LBW1uLKIN
         yElBPgiydZd1eMB4xi1CsMLkIsymxY0dkb+mtCDpVjyE56WZsbv6DXZwu3EDmQbdqvwo
         H//PMwuwJB8Ec16bv1OFrFJxW/4xpuehLC3QpBVcay7OnkjQBddE0uE71ijPxoME+7r6
         rvXSJU8U8JSB11HeiYhx7ErfD2L5A3h5w/0OcCR3bijN9Q5S4zmHgkuXMPR0uNCjudXY
         N8Rw==
X-Gm-Message-State: AGi0PuYpKbnDw4YHk1p0C3gszGB0eq+OJTJxuVUaM3n1UnJbvPwdky+y
        x5vlPWo3AFknWT4oqH3oDCE=
X-Google-Smtp-Source: APiQypJgcuN2Fd3XkrhwlhDTvh87m2eBzvkxpGZR8xmVAv3pM9Xt1NttrpHt9QJo7E2V953w6bwHwQ==
X-Received: by 2002:ac8:6707:: with SMTP id e7mr382075qtp.126.1585786010687;
        Wed, 01 Apr 2020 17:06:50 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id 124sm2528817qkl.31.2020.04.01.17.06.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 17:06:49 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] t5319: replace 'touch -m' with 'test-tool chmtime'
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.596.git.1585764695643.gitgitgadget@gmail.com>
 <pull.596.v2.git.1585774844.gitgitgadget@gmail.com>
 <24e26ecda632421e4c1a61ebabf6ea78301685b1.1585774844.git.gitgitgadget@gmail.com>
 <xmqq369m6g9u.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8e6b1f75-534a-ad79-544b-126ea61b2058@gmail.com>
Date:   Wed, 1 Apr 2020 20:06:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <xmqq369m6g9u.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/1/2020 5:35 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> The use of 'touch -m' to modify a file's mtime is slightly less
>> portable than using our own 'test-tool chmtime'.
> 
> Portability aside, the relative form would also be resistant against
> skews between filesystem time and wallclock time and is preferrable
> when we can use it.
> 
>> The important
>> thing is that these pack-files are ordered in a special way to
>> ensure the multi-pack-index selects some as the "newer" pack-files
>> when resolving duplicate objects.
> 
> This note is very much appreciated.
> 
>>  		rm -rf .git/objects/pack &&
>>  		mv .git/objects/pack-backup .git/objects/pack &&
>> -		touch -m -t 201901010000 .git/objects/pack/pack-D* &&
>> -		touch -m -t 201901010001 .git/objects/pack/pack-C* &&
>> -		touch -m -t 201901010002 .git/objects/pack/pack-B* &&
>> -		touch -m -t 201901010003 .git/objects/pack/pack-A* &&
>> +		test-tool chmtime =-5 .git/objects/pack/pack-D* &&
>> +		test-tool chmtime =-4 .git/objects/pack/pack-C* &&
>> +		test-tool chmtime =-3 .git/objects/pack/pack-B* &&
>> +		test-tool chmtime =-2 .git/objects/pack/pack-A* &&
> 
> The original wants D to be the oldest and A to be the newest, and
> the updated would want the same ordering.
> 
> When created, we know A gets created before B which gets created
> before C and so on, in the "setup expire tests" part.  If each step
> takes too much time (e.g. the VM is heavily loaded), wouldn't the
> adjustment above become insufficient?
> 
> In other words, would we want to flip the order these packs get
> created in the "setup" part, in addition to the use of chmtime
> (which reads the existing file timestamp using stat(2) and then
> updates the file timestamp relative to the original timestamp)
> we see here?
> 
> Also, in the best case (i.e. original timestamp of A/B/C/D are the
> same), the above seems to assume that the filesystem has at least 1
> second file timestamp granularity.  Do we want to make them at least
> 2 seconds apart, or am I worried too much about ancient filesystems
> that no longer metter?

The old test relied on one-second granularity, so that hasn't changed.
I could easily space it out a bit more without issue.

Your concern about the original timestamps getting skewed shouldn't
be an issue because "test-tool chmtime =-<seconds>" subtracts the
<seconds> from the current system time, not the file's mtime. This
is subtle: without the "=" it would modify it from the file's mtime.

Since we are assigning the offset values in the proper order (D to A)
there isn't an issue if time ticks forward between these steps.

Thanks,
-Stolee
