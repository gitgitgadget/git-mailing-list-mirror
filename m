Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE1EC433ED
	for <git@archiver.kernel.org>; Fri,  7 May 2021 03:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADBA56101D
	for <git@archiver.kernel.org>; Fri,  7 May 2021 03:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhEGD1A (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 23:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbhEGD07 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 23:26:59 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B72C061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 20:26:00 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id m12so6173668pgr.9
        for <git@vger.kernel.org>; Thu, 06 May 2021 20:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=3OgscVqPxwyRzgTdbpuakUD/t3HBkecqpOg6lx4phmc=;
        b=VaMIw5/MSqNPqhajMaBQqHwYiRAoDUQPSV0tCz787kTwaHYb07hs7NeLxTF+MiWael
         4M1Lwmd5H2krhEsYD4M/XIeTCr5qBq/3OSIeCt2586ke+UmMlJgI62SfA8gW2ngSH9YQ
         v1TVCELpCn0QscpIG5+uh9P6s9AG3fpjixZGlw9+sll83+i9fc07OXdXhabUdFLH/23M
         74phLrlfsP8vQRZnVdzopr0IYjvLkUfIGdLk+94NXYF+HUEGmDh/GTr+obmi48zHfKrd
         fg53MrwjFBsEMkXfsttSZrcDLLYgcH9gizzkr8Xc+IyvMOS+2L1tyWE4ZKVpSPxO2CHd
         3HLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3OgscVqPxwyRzgTdbpuakUD/t3HBkecqpOg6lx4phmc=;
        b=nvvluc/kJhKeBBjjb9fxUTWU3zUme70Zvt/b4V1G2IxvtHvwEIfPLL4ob4D+8BzLSE
         dCuUmkrBIj1y3RkualLv9hlNMWmOy3aqjqyx2m/YmC+y72vbi0Jld3e0Ngg6cWc0kOu9
         62J+YZYH3BUuBzDCQF/feHKaA+WW2hUmeflpeM3iIgQfeGez+7wH07KLcqf/iqs43QmT
         FNgtzS9kk1J2RgrgCaRRVpDs0ePJX5iS5AchCIb4lrWLIxzDNN4yEueoV0r/i9Cbmyi9
         CBclghqOhgJEKiXKpykKmRhfhxohetKNeTUiVVfzUZyn/KmOYUWmi3oXdoUbqhkpDlNj
         lZDQ==
X-Gm-Message-State: AOAM533U6eL58AKrmYgq/QfwZkdFKuD1SuvQzGRRgzelLkqYeMnq4O2P
        xKrKfhOsZLUf7Sopu6a+GzF8mttCXAwPNQ==
X-Google-Smtp-Source: ABdhPJwsLGMrYS8klx5FFJkGN80QpO6PJNnDbqJ13GTREW4qkie1WCWxPBEt4oh8EX3g+AVx3zrbWw==
X-Received: by 2002:a65:6643:: with SMTP id z3mr7402992pgv.387.1620357959880;
        Thu, 06 May 2021 20:25:59 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-82.three.co.id. [180.214.233.82])
        by smtp.gmail.com with ESMTPSA id j7sm11302521pjw.4.2021.05.06.20.25.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 20:25:59 -0700 (PDT)
Subject: Re: [PATCH] tr2: log parent process name
To:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
References: <20210507002908.1495061-1-emilyshaffer@google.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <3bde96f5-2df6-4c4d-7e40-e938bbb31643@gmail.com>
Date:   Fri, 7 May 2021 10:25:56 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210507002908.1495061-1-emilyshaffer@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/05/21 07.29, Emily Shaffer wrote:
> It can be useful to tell who invoked Git - was it invoked manually by a
> user via CLI or script? By an IDE? Knowing where the Git invocation came
> from can help with debugging to isolate where the problem came from.
> 
> Unfortunately, there's no cross-platform reliable way to gather the name
> of the parent process. If procfs is present, we can use that; otherwise
> we will need to discover the name another way. However, the process ID
> should be sufficient regardless of platform.

What about on Windows?

> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
> We briefly discussed hiding this behind a config, internally. However, I
> wanted to include the parent name alongside the cmd_start event, which
> happens very early (maybe before config gathering?).
> 
> Maybe it's better to log the parent_name as its own event, since it
> shouldn't change over the lifetime of the process?
> 
> procfs is very non-portable, though - I think this won't even work on
> MacOS. So I'm curious if anybody has better suggestions for how to do
> this.

Maybe we can say that "currently the method of gathering parent process
name that Git uses only work on Linux".

-- 
An old man doll... just what I always wanted! - Clara
