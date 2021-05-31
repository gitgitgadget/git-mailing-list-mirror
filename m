Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83FFC4708F
	for <git@archiver.kernel.org>; Mon, 31 May 2021 07:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88BBB61278
	for <git@archiver.kernel.org>; Mon, 31 May 2021 07:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhEaHvc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 03:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbhEaHvR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 03:51:17 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D422C061574
        for <git@vger.kernel.org>; Mon, 31 May 2021 00:49:37 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id v12so4790140plo.10
        for <git@vger.kernel.org>; Mon, 31 May 2021 00:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j3cSWTA5kc/+OxmMdDFhmdAtYy5wcYhVkr28wFHbYcI=;
        b=Z0UVvVk2bBJKUVMVJJEXMYRJyXBhyvSKdCZOYWx8YR+kgEifTqQc8BS4AfzQ57VDQ1
         X1yjm4rvitfSkZGuxBMck18vIKpYc2/Cit87jZnqQVYu1Ip4X6fXygVvRKLqKsluJavx
         RLndVle9S7FjIcwdX2/VypZf14amZOhrp+zxrmB1sfbnWQOY7B79ld9Z3eb+ws+7wSq7
         fAG3jT1ZQOxaqKXjx49LbQoLalZ1v8igeoVD+vq+Ql8KFnRWwEA41hIwWuUzjJBQWvsx
         RK3/56Fuz89VYMZXshy8j48BGI6naF+eqG9I0bFioYjXovEsQK9Jc9TbyqELc6Krt2hH
         /ojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j3cSWTA5kc/+OxmMdDFhmdAtYy5wcYhVkr28wFHbYcI=;
        b=VrXPpkWf51jvFJ54WCHDJSjtDZY79QATgUQsSUKlMHrT5vdEjJ1jRJ+fi8YPaRAS6i
         aKr/zAjvOnP+3jR/RK80ECN0yRX9WKeq2/7jEwdcrI7fWi/sQl0tBkId7Nm+f3/ya43U
         UsgDfdDEPWNpNdXy61Dy6KbCOitcxYTpvu1xzDB6weOdNQdjc6mjXXCwGy+JZoM7OU/m
         nsne7oZZaZeL4CSt7BbKr8aqzh2S+gfDDGXSMG7RxaqcKJ9THijdlHSmOgvvN4xrK6QU
         DmH6bOEuxYA+Uux3edgr1/D1HJzLSK+i55PY/SVWPro+8VuPJ767utk13aq455SKnBeo
         Lctg==
X-Gm-Message-State: AOAM530M2exQ+/+o1/Gs0h/FGAUCDsZljKHxTVsK6dkvN5rUIrqRAfXm
        iePFe0cXEp4hi+mqbM+xzLOlO+9ZLKG2gGd5
X-Google-Smtp-Source: ABdhPJzQuNToz4AmtTBREcaQfSruCexvNvyccG0ktzyBmwRdq+CzacM8QOmHeHhnwglfYVnnAEvMxQ==
X-Received: by 2002:a17:903:31c3:b029:ed:6f74:49c7 with SMTP id v3-20020a17090331c3b02900ed6f7449c7mr19195897ple.12.1622447376635;
        Mon, 31 May 2021 00:49:36 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-67.three.co.id. [180.214.233.67])
        by smtp.gmail.com with ESMTPSA id n9sm10262383pfd.4.2021.05.31.00.49.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 00:49:35 -0700 (PDT)
Subject: Re: [PATCH] describe-doc:fix a obscure error description in the git
 log documentation
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Andy AO via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Derrick Stolee <stolee@gmail.com>, Andy AO <zen96285@gmail.com>
References: <pull.1030.git.git.1622440856607.gitgitgadget@gmail.com>
 <YLSGasYc4wVoOfYt@danh.dev>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <f34de283-d749-854a-0ed0-d4e244dc259b@gmail.com>
Date:   Mon, 31 May 2021 14:49:32 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YLSGasYc4wVoOfYt@danh.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Đoàn,

On 31/05/21 13.47, Đoàn Trần Công Danh wrote:
> On 2021-05-31 06:00:56+0000, Andy AO via GitGitGadget <gitgitgadget@gmail.com> wrote:
>> From: zen96285 <zen96285@gmail.com>
>>
>> The git log documentation says "The default option is 'short'." This is wrong. After testing, the default value of '--decorate' is 'auto', not 'short'.
>>
>> There is no difference between 'auto' and 'short' in terminal, but there is a significant difference in how they behave in the shell.The information generated by the 'short' can be saved in shell variables, while the 'auto' can't.
> 
> Please use your real name and wrap your commit message at 50
> characters for subject line and 72 characters for body.

I think the case here was Andy forwarded this patch from someone, which 
happened to be also himself. Maybe that From: line above can be removed, 
unless that he forwarded from other people (in which From: line must be 
preserved).

-- 
An old man doll... just what I always wanted! - Clara
