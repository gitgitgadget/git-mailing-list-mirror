Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA548C433DB
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 21:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A882922C9E
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 21:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394409AbhARVFO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 16:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394447AbhARVE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 16:04:56 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAFCC061573
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 13:04:16 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id h1so8149173qvy.12
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 13:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=egP24vHGHcJOlMFHwb4UImUzK28fLWQX0tI+rYsrZTo=;
        b=cWdVnOyOqu/gI1j4e31JB80Sr7VoTVwCdfSF4P3e7yixabZkLhzFcrNb+TYxOVwHZ5
         IUMl2SrhkcHJ7ArRL1MVJoFxnwR4MqLCDUvfi+rggECk5mrZkLY12xrmff9EJ5Xb6e/Q
         2V3pbRDM6IxwM/klM5vHE6VH5M8GJJhYlW6M9oJSeGfFahIQjfdZ9GqLvc84mJz/Drpg
         vKTazOf4o7PV3CTntplktctizlEvGB6TH4+c1hxuBupzWuJclAXoLUlvlq+3jNqkllJx
         9GkA+a0Gp3P704KFaP7HZz2q5agy+yuGFNUPnIXKlE2X0ZtjnurgPxHt2m5FHjrbkCax
         6t2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=egP24vHGHcJOlMFHwb4UImUzK28fLWQX0tI+rYsrZTo=;
        b=tyUzv3pDduc9fFjlBRf/WY0VjfcFlLrDZqklbRz4mkUQYCyiCL39QpLeRsEtVkpyHs
         eT4nXsj92DD9ihpZozOuwmCn9nYzxr6erIo5aLnJvDg4KrGyIp5GxwJhKWf7PoG7vIvo
         WaRLbPDB0CQ9L3JpjJy6YoIHnEhdmOMJl60OB5OqYUurPhDsNy15k4GYsMJCBLCHzB3a
         7y2VwEiWZbWONP3+tbPj3hAyXKEGhh1lqJciYR3nXbdge4o5Q67rhsZRxk84cotzgZAg
         jL/cK1CuwwAB/uGWr5Gk/rhSpD4HYmdEK0SfUttIigh8ivzY4TKP72lYsNwthkpOIHlf
         Gb6g==
X-Gm-Message-State: AOAM530/PuyyS+USUptNjuQSvnMjnybN1rkw4MjO6M3uxg80CE70PiuO
        uYsMOoL9/DOofhLVVbe+rHY=
X-Google-Smtp-Source: ABdhPJzGqShJswB6XE88IJ2Wq8GiED/pt2GuMd91hzMjfmcdwWK7CxWGJUdwCvoTM6zaZxOudSCYMg==
X-Received: by 2002:a0c:8304:: with SMTP id j4mr1280838qva.18.1611003855681;
        Mon, 18 Jan 2021 13:04:15 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:1583:40fe:1fef:8885? ([2600:1700:e72:80a0:1583:40fe:1fef:8885])
        by smtp.gmail.com with UTF8SMTPSA id f134sm11488615qke.85.2021.01.18.13.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 13:04:15 -0800 (PST)
Subject: Re: [PATCH v6 00/11] [GSoC] Implement Corrected Commit Date
To:     Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Taylor Blau <me@ttaylor.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <pull.676.v5.git.1609154168.gitgitgadget@gmail.com>
 <pull.676.v6.git.1610820679.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2437ba7c-f9d9-34bd-5e08-eff96cadcf91@gmail.com>
Date:   Mon, 18 Jan 2021 16:04:14 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <pull.676.v6.git.1610820679.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/16/2021 1:11 PM, Abhishek Kumar via GitGitGadget wrote:
> This patch series implements the corrected commit date offsets as generation
> number v2, along with other pre-requisites.
...
> Changes in version 6:
> 
>  * Fixed typos in commit message for "commit-graph: implement corrected
>    commit date".
>  * Removed an unnecessary else-block in "commit-graph: implement corrected
>    commit date".
>  * Validate mixed generation chain correctly while writing in "commit-graph:
>    use generation v2 only if the entire chain does".
>  * Die if the GDAT chunk indicates data has overflown but there are is no
>    generation data overflow chunk.

I checked the range-diff and looked once more through the patch
series. This version is good to go by my standards.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>

Thanks, Abhishek!

