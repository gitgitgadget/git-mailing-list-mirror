Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486FAC433DF
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 18:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F0D02078B
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 18:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqaGpEzj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgGISUY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 14:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgGISUX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 14:20:23 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC873C08C5CE
        for <git@vger.kernel.org>; Thu,  9 Jul 2020 11:20:23 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id g13so2395538qtv.8
        for <git@vger.kernel.org>; Thu, 09 Jul 2020 11:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0jmQ2jWuuBDoJ+ceTV9/i0gYF9hAEyP3i9qfdhP2OCY=;
        b=NqaGpEzj833savKDWL7obNjPyuHM6srosF+kfgtg6ZnS0nb2Snn4MF3xhu7nHyu0nG
         rGEIHuH+shbk6immajivC1BaIY7cBtP31rS58mnV83dHt3YgDkpq6AQ87IliOuvUxODa
         +ussiWqnR5xHFIb6AfOh9UPWww7ieUwdIk7niT0rBRPY9RaJauHbAVPUt14V0TC5b8bZ
         xInlOuxHc/j4VRwj44AVStwt7xOx8yjhz0Gco+wrMVsqixbqJ/rIot0BFDMvPALbC1RE
         eRRV82mPjwKbOKPhy6vXmz7WFUOTEipjfWZ+Vm0xmqse6v8YMcrcxZF3mTGx1lXZW5WS
         Ucdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0jmQ2jWuuBDoJ+ceTV9/i0gYF9hAEyP3i9qfdhP2OCY=;
        b=cVFJCw68TIFXZHGEtVJ0Sdrwj4yMdTxCEwSCzH9i8hdBwXZP2e5dg7neDfmVMoAXY5
         3smgQHZLMuBkvW3OpzbEve46ypOYcUfJu7SV8wnRdien59KMhDzkZZGfhSSKc/NmQXYK
         HW15SMQsI6OZRKgsjHabTZITv0tVpowcHX1/bPYeoxK6OX/n7miDIi8T9hlTV52cRY5O
         iPcANLzVCC6UMWu1Cp98ELh/KFOaD7joXC5onucyToCJ6Rha94s9FsDgW1HmJF/rruFG
         4NFwLN0VGY9cAt48orgIQ3v698jtNOOMw0lSXtfAJb6kCd1Xb6awCuudkpCawZHLhc/h
         GA4Q==
X-Gm-Message-State: AOAM531U2rnRf/ugWarOV3BAvUjrG6ZKMGRFoueTh6D+8zaFqqo3x03+
        h5YBePHmnNEm6M2bdJxvLYyax+IlWlfe+w==
X-Google-Smtp-Source: ABdhPJzXMsPL42sXvpARdi6g0qEkrWDi53tghiuARuRV07ybc5pnFgi72pZfwDickNptXl92JcY0Lg==
X-Received: by 2002:ac8:1c2d:: with SMTP id a42mr68034416qtk.301.1594318822445;
        Thu, 09 Jul 2020 11:20:22 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id q28sm4912251qtk.13.2020.07.09.11.20.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 11:20:21 -0700 (PDT)
Subject: Re: [PATCH] commit-graph: fix "Writing out commit graph" progress
 counter
From:   Derrick Stolee <stolee@gmail.com>
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>,
        jonathantanmy@google.com,
        Garima Singh <garima.singh@microsoft.com>, git@vger.kernel.org
References: <ff6b96aad1e2317d3ed36c2c8b419905dea84a83.1586192395.git.gitgitgadget@gmail.com>
 <20200709170003.3020-1-szeder.dev@gmail.com>
 <1b683731-776b-0058-5744-094091c7db4d@gmail.com>
Message-ID: <3484f1fa-3231-f457-9951-a3aa0a3f7c7d@gmail.com>
Date:   Thu, 9 Jul 2020 14:20:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <1b683731-776b-0058-5744-094091c7db4d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/9/2020 2:01 PM, Derrick Stolee wrote:
> Junio: head's up that this will conflict with the final patch
> in ds/maintenance. I'll remove my edits to these methods in
> my v2 to make that merge a bit easier.
Or, I'm getting confused, because I changed start_progress()
calls in midx.c, not commit-graph.c. Please ignore my scattered
brain.

Thanks,
-Stolee
