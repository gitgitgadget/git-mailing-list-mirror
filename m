Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FA1C35669
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 00:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A43AC2072C
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 00:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3NKgGVn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgBVAhc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Feb 2020 19:37:32 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:44856 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgBVAhc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Feb 2020 19:37:32 -0500
Received: by mail-yw1-f65.google.com with SMTP id t141so2038259ywc.11
        for <git@vger.kernel.org>; Fri, 21 Feb 2020 16:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ki6LFB9RzBcRWJ3hp7JOITMkoyFQQiZORLKpwujkHec=;
        b=U3NKgGVnPmSXjhufT5+aUsFYmlRDq7dwYga6FXrnrt9BfxTE8AG00E3NTTOLJJ+GWE
         t98/O5LJTPO2r39Uhjn7BShQ1LeaOLD0hFsdq1taE8bSqTfl0yd3rFb1quMAeckc0M+4
         S+2Tu5VBVuPKsi+ZSW8buG2nWsE4EyS3A2RjJ0Dvk4vl7R11Ee+ssI7735407NqL3n4l
         5dEh/YQkEpimmMihN350gx0Bn7YSyLfQK6KnNP9bEp/FZdNdY6C3zEP4/ykReKPvbKJN
         BfwcOOQhtmOgp1JjNgvZIkWHSg/jm7iHA3WLvxpnmLsQtRhWPPHRhpWdHd/NjR5wT6c0
         Nq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ki6LFB9RzBcRWJ3hp7JOITMkoyFQQiZORLKpwujkHec=;
        b=KpMoea1v3b1Iu6nzwSuxbUy4DK30Fo7rPryGppqpBTJlFp233zMBkZZIO6cyQKp3AS
         GHXyinOqSd0MAUIiEW/Mu6/k9CVq+JctViq8W4hd2CeDBrixQ/JU9MnJGPmzOLDUVIWV
         kfWy8EogA9svhpx0uaeOhitabLluFSv6NVcagkXVVXhaG1g70ar7R4p/gV57TEEw1IGU
         XTGLa9YbNVdYuwaIT6kTUbMIvoLT5jzXBWULi62sgVccIp0imCDKplT1D7tS96UW3vu8
         M5Nt50a2K76OCL4QglzFNTsMSbs7pgkPxC5OVfGUECYl0oLH8ru/z9DzsIudb+vrfiWp
         YsQA==
X-Gm-Message-State: APjAAAXtRITH02AKQBM2bxvthOLR6An3MYBu0TtXqxwS/wfQ/pH7KRaw
        SX3fK2gK9UzOJdsRCadmSg8=
X-Google-Smtp-Source: APXvYqxzIfvoyqq/+Fvw5taPm7I4RdDwdER1VZ1t4pMB/DraoZ+oJQQk5oxkqroW1ilhX23j6Bxpwg==
X-Received: by 2002:a81:b143:: with SMTP id p64mr34510805ywh.78.1582331851524;
        Fri, 21 Feb 2020 16:37:31 -0800 (PST)
Received: from ?IPv6:2600:1700:b00:7980:25f3:c564:ed3b:ab96? ([2600:1700:b00:7980:25f3:c564:ed3b:ab96])
        by smtp.gmail.com with ESMTPSA id j72sm2062767ywj.60.2020.02.21.16.37.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 16:37:31 -0800 (PST)
Subject: Re: [PATCH v2 03/11] diff: halt tree-diff early after max_changes
To:     Jakub Narebski <jnareb@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
 <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
 <a698c04a78cf2988fb822e0aa532989f925e0a9e.1580943390.git.gitgitgadget@gmail.com>
 <86h7zqqdze.fsf@gmail.com>
From:   Garima Singh <garimasigit@gmail.com>
Message-ID: <189827fa-7fab-5064-7baa-f856b149559b@gmail.com>
Date:   Fri, 21 Feb 2020 19:37:30 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <86h7zqqdze.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 2/16/2020 7:00 PM, Jakub Narebski wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> Use this max_changes option in the bloom filter calculations. This
>> reduces the time taken to compute the filters for the Linux kernel
>> repo from 2m50s to 2m35s. On a large internal repository with ~500
>> commits that perform tree-wide changes, the time reduced from
>> 6m15s to 3m48s.
> 
> I wonder if there is some large open-source project with many commits
> performing tree-wide changes, that is with many commits with more than
> 512 changed files with respect to the first parent.
> 
> Maybe https://github.com/whosonfirst-data/whosonfirst-data-venue-us-ny
> from "Top Ten Worst Repositories to host on GitHub - Git Merge 2017"
> could be a good repository to test ;-)
> 

Thanks for the suggestion! I will see if any of these repos gives us a 
good test bed and add the perf improvement numbers in the appropriate
commit messages in v3. 

Cheers! 
Garima Singh
