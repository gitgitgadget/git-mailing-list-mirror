Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECACCC4320A
	for <git@archiver.kernel.org>; Sun, 22 Aug 2021 12:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6A9B6128A
	for <git@archiver.kernel.org>; Sun, 22 Aug 2021 12:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhHVMMP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Aug 2021 08:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbhHVMMN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Aug 2021 08:12:13 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44773C061575
        for <git@vger.kernel.org>; Sun, 22 Aug 2021 05:11:30 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id c17so13958443pgc.0
        for <git@vger.kernel.org>; Sun, 22 Aug 2021 05:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=qTJPoZfiOWan9YaHvTpI/LPXECdyYuqF9d7ntNtH5Pk=;
        b=MYMBdg7I014uNXwI2Fx+aqntJaWQsWpRu2ip8nCUqSdM9MBUc5JTGimvWjrD39D1KO
         xxBuRLftE2tzlno168QTjNXlAIB8SOJocMdqg72QKlIMduLfien0jsNH7YwMFSyiQXBs
         +jtC4WUn+79MOL58cwZs8//10i+NDZtFCBIfefVJCENkwDwse95gc5A+xswmtsrI7FY6
         ORCiv+VLFCWBYxa0IJlZ5sPveHP0DtboJEWsTXO2wLY7GN8uIkZ2NIkIRpAHWcQ+7d/J
         Su9VWcZ7qAuQIrNxbXxzY2MoCvck+EovV/o0syel3vcqrwtjatzvUaWXSwFZUkUNDwrc
         t5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qTJPoZfiOWan9YaHvTpI/LPXECdyYuqF9d7ntNtH5Pk=;
        b=bybCkQ3Fbd4d8/s1l+XlZf4K1eDsxgBuNEJOSrhGKcrwliwzcTiS1hyXMbuzyhX57C
         AMAH6y5KcE1meZurxg2onX9/C75eETJjgjfNU9pa8OKeN6tw/85j1k8TeodjnbIu8zwo
         N3BhQjvaPYijlfxX2hN42YtqMsMuOFUwVRe5KgMg4DT6da18YqCS0PScOY32jkPyafsv
         f62zIltDOdXbqUkLBoI/k4wtCb+GXGxB4fahDAWlQl1YZ984rsha1y/sMZJA9zINHqGK
         BLhCO7KbvZnKgxTHgiqPoBKbRKC2VXic407yCRcfMVDHsSWMMKKSLL/lClv93Z+my3lP
         hwsg==
X-Gm-Message-State: AOAM531H3KypCCPgPjFw79K1FEyS2v/PX6kvw3ePAvkYwl69XYsnYeBC
        r0xWvRZR1/JTx9lFCLf+8gvUMBVxq24=
X-Google-Smtp-Source: ABdhPJxV/m76HprRSxAlttGEoUrQzHNNT+O/0bT8QjiymMWqTPDdqtWp49vHjUfHrhJwZOBzT+9Msw==
X-Received: by 2002:a65:68cd:: with SMTP id k13mr27268023pgt.105.1629634289690;
        Sun, 22 Aug 2021 05:11:29 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-28.three.co.id. [180.214.233.28])
        by smtp.gmail.com with ESMTPSA id z2sm15030437pgz.43.2021.08.22.05.11.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 05:11:29 -0700 (PDT)
Subject: Re: [BUG] send-email propagates "In-Reply-To"
To:     =?UTF-8?Q?Marvin_H=c3=a4user?= <mhaeuser@posteo.de>,
        git@vger.kernel.org
References: <4db7759c-2123-533b-9f89-954c07f5832a@posteo.de>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <41f4f8da-e3ca-9b66-66f1-e319a0428a2e@gmail.com>
Date:   Sun, 22 Aug 2021 19:11:26 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <4db7759c-2123-533b-9f89-954c07f5832a@posteo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/08/21 16.24, Marvin Häuser wrote:
> I wrote a quick patch to adjust 2.1. to 3.1. [3]. I have no time right 
> now to review the submission guidelines (and thus did not submit the 
> patch "properly" yet), but I will try to get to that tonight or some 
> time next week. If in the mean time you could provide any feedback on 
> the behaviour or the patch, so that I can get things right the first 
> time, that would be great!
> 
> [3] 
> https://github.com/mhaeuser/git/commit/d87f49a02c0efa3084ae6c70bbf583b865744e43 
> 

Since you have your desired commits queued on your fork (and thus 
already use GitHub flow), you can open a PR targeting [1] and let 
GitGitGadget prepare and send corresponding patch to git@vger.kernel.org 
(this ML).

Or better learn to use `git format-patch` and `git send-email` - some 
projects (including Git and Linux kernel) prefers contributions to be 
submitted through mailing lists (email-style approach). Git for Windows 
have nice guide to submit patches email-style at [2].

[1]: https://github.com/gitgitgadget/git
[2]: 
https://github.com/git-for-windows/git/blob/main/CONTRIBUTING.md#submit-your-patch

-- 
An old man doll... just what I always wanted! - Clara
