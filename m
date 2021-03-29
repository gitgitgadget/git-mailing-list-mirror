Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68934C433C1
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 06:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37CA361964
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 06:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhC2GB1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 02:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhC2GBW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 02:01:22 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8E4C061574
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 23:01:22 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id f17so3879893plr.0
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 23:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=vKmhxF1Sk7c1eTLFpR9j1q4UcrQFbKD0Hdl7ZqhBnjE=;
        b=QgSug645EJP6Fals9XlKrcvxSNi57WkdLuKANQERtuLo4IoF5f02kl7eNZrD+jhZmB
         YCb6Urif9G44rMet/U0z3eYei1U31SfQtFBrRUU89ACkb/oMk6rxdygZU1N62yrNUht1
         x0iev53rJrA05ijW6mcC7m1RE3ptw0uahsqyhAYGjWHAt54udGmOdt9KxjXqGygOaMXp
         lUwB92/FHid5ok7ltworYqAgbKGqF3TvfhydNV0RD1qnkBb4L7PWY4GrMyRW0tbIWulk
         BzTCULVdufvFA3PJ/gynHMfuyWf8r4L2f3OTU2swetWiIDtZjUE7pUgWd6zsNJEOqSW7
         tZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=vKmhxF1Sk7c1eTLFpR9j1q4UcrQFbKD0Hdl7ZqhBnjE=;
        b=Be4NSGy2kIE4CrhOvDWHULcVMsP/hc7mIJe6DKEJK8TOTDISPI3CtPINjNS6W8/VzR
         /BWKEbH6EcCGKp0ECn9MZys/vivEQrH0o/gnacG1gDxXXVOc6JzsxPnooXdG77l1R4jm
         0Fwz+AajgOFg0Sc2sHD468P+uTVrxXcJjhjsvRYQZCqFygbZFkYCafB+6foFGNCEj7KJ
         hReuPB+7BO4tV5Kz6NHDjrbLHuaARbX12lJewtbQddH5s3DyRBRTo/zVotsY4gzFGgd/
         jzfQOGZG1BvlMtuZVubStMfOrmZKqvKaRDO+3piJuCOVFcE+VNbIOMfTpRLJ4ZDYXcQG
         kq/w==
X-Gm-Message-State: AOAM533Cn1zzuwSSMoen8jkSMjPbzLfkFhJIV+wT0Wd2ABTqN03SCqsk
        yluqIjGowgXh2G1oONAH4HRq7IjuETS/GpD0
X-Google-Smtp-Source: ABdhPJydQygSKceX7LdxKQCPsKUDp4rUHFE92mO935Z68xRZnatzhmBBjEONZrbAxOpTJ5UC8vDOMw==
X-Received: by 2002:a17:90a:f010:: with SMTP id bt16mr25108154pjb.116.1616997681062;
        Sun, 28 Mar 2021 23:01:21 -0700 (PDT)
Received: from [192.168.10.22] ([103.77.186.50])
        by smtp.gmail.com with ESMTPSA id x186sm15781156pfc.65.2021.03.28.23.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Mar 2021 23:01:20 -0700 (PDT)
Subject: Re: [PATCH v2] Documentation: updated documentation for git commit
 --date
To:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org
References: <pull.918.git.1616926790227.gitgitgadget@gmail.com>
 <pull.918.v2.git.1616936099778.gitgitgadget@gmail.com>
 <6a9d24a9-6942-97fc-550f-6b9b61264a78@gmail.com>
From:   Chinmoy Chakraborty <chinmoy12c@gmail.com>
Message-ID: <98c196c4-31ff-4df1-9215-77d115771583@gmail.com>
Date:   Mon, 29 Mar 2021 11:32:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <6a9d24a9-6942-97fc-550f-6b9b61264a78@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 3/29/21 10:55 AM, Bagas Sanjaya wrote:
> Is date format parsing specific to git commit? If so, then
> why not date-formats.txt be merged to `DATE FORMATS` section
> of git-commit documentation?
It is already included below the `COMMIT INFORMATION` section.

> Also, what commit this `--date`
> option first appeared before you write this documentation?

I guess it was introduced in commit 
a8aca418d6484400d6804e22717bd49ca06c28e9.

>
>> +`tea`::
>> +    Change commit time to 17:00(tea time). If the current
>> +    time is less than 17:00, the time will be set to 17:00
>> +    on the previous day, else it will be set to 17:00 on
>> +    the same day.
> How useful is this argument?
>
I think initially it was suggested as a joke, but actually implemented

to demonstrate the ability for users to include their own custom

time/date periods.

See : 
https://github.com/git/git/commit/a8aca418d6484400d6804e22717bd49ca06c28e9

