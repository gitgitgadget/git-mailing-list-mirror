Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD95C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 15:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05E3C604D7
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 15:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbhHBP2J (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 11:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234751AbhHBP2J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 11:28:09 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7B8C06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 08:27:59 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id u25so24494516oiv.5
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 08:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ev7Ucf9yQHKFm4OaUwi2NMoPbZclvoMpqLYxFBXNT3c=;
        b=ZokBLKS1bgAUWMY5xVr+DFi0/G6+E+kvWWXmS4olvoVaUmDZ5ork+iDoYQ71dyY9q3
         8ami5468FVf7bR9zc/9hNGUUC0ZA3ENJP5+rNXLg/QZT34wu6jPwtbLePfl33Udi4mOI
         zPSsbr71ARcPj44cqd2DDr2kxmRp4eQTlCiZfbwKjH6iRxBAS94GYVpHtgH6WK1jnqD3
         v3xoN9VMuP4FTN+l9D0A5Am/9pE5tGR+KSKtfjBI3UAkNt8HEuCVITYoI4J8JvSoJgLR
         5CgknXebplbH9r3SzHAy/4SiQO0hcIff385u7YEmpuOTjx+WFwvz+b6ho9Z0TrkgZ3vD
         PV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ev7Ucf9yQHKFm4OaUwi2NMoPbZclvoMpqLYxFBXNT3c=;
        b=UCm7Igzc11JDKjR4j2fLFmN/nlGig1rY3V3RB47EVJYTZ8YAJT1pdnu7PxrYc2dhBv
         U50iLOpeePxbcAJ3JEzoQRCMGc7F3MUTSTXCCFD7dirWpfbZEaiaKO7eTYh9Aqe1XkUj
         karr+VAtxpB/SzONUYiv6GZSEMSnohKFJl1MBLrjEffu3ok7k1M2czTWuqFqszz+t5tE
         OSyYmweHVdHwY9m3+1t9XfRg7tNCsjEb+fwUzT+6VaeIz3J6ehDmvE9BRTAsS/MC78Vr
         PXnwYnzAPLXeW2KPqGnzBuucos4+kdGHaAQigYdgng4u05Y9ch50iV88XHowDiVWYl8u
         NbWA==
X-Gm-Message-State: AOAM530M0ufd/bvFiO/wFT9svNTIDiN8gwvjnT8DWMsNKWryCu8MaxoH
        XiO2HVO2tgPruJY3lCw8PEw=
X-Google-Smtp-Source: ABdhPJwoao+FOvoTGpUx6lG8x0zA7+eBQ+KeuhY27GZuNXJlEKcvdCOH8baZ7SHxG71exM3Cej3kag==
X-Received: by 2002:a05:6808:b30:: with SMTP id t16mr8906122oij.35.1627918079011;
        Mon, 02 Aug 2021 08:27:59 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:34d1:2d41:f9b7:ccbc? ([2600:1700:e72:80a0:34d1:2d41:f9b7:ccbc])
        by smtp.gmail.com with ESMTPSA id i10sm1757651ood.48.2021.08.02.08.27.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 08:27:58 -0700 (PDT)
Subject: Re: [PATCH v4 0/9] Final optimization batch (#15): use memory pools
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>
References: <pull.990.v3.git.1627645664.gitgitgadget@gmail.com>
 <pull.990.v4.git.1627752458.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <bc74066d-028a-bf7a-cbf1-fda0053bfe00@gmail.com>
Date:   Mon, 2 Aug 2021 11:27:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <pull.990.v4.git.1627752458.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/31/2021 1:27 PM, Elijah Newren via GitGitGadget wrote:
> This series textually depends on en/ort-perf-batch-14, but the ideas are
> orthogonal to it and orthogonal to previous series. It can be reviewed
> independently.
> 
> Changes since v1, addressing Eric's feedback:
> 
>  * Fixed a comment that became out-of-date in patch 1
>  * Swapped commits 2 and 3 so that one can better motivate the other.
> 
> Changes since v2, addressing Peff's feedback:
> 
>  * Rebased on en/ort-perf-batch-14 (resolving a trivial conflict with the
>    new string_list_init_nodup() usage)
>  * Added a new preliminary patch renaming str*_func() to str*_clear_func()
>  * Added a new final patch that hardcodes that we'll just use memory pools
> 
> Changes since v3, as per Peff's feedback:
> 
>  * Don't only remove the extra complexity from the USE_MEMORY_POOL #define;
>    also remove the original bookkeeping complexity needed to track
>    individual frees when not using a memory pool.
I read the discussion leading to these changes and gave this version another
pass. Looks good to me. Thanks!

-Stolee
