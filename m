Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B87C433ED
	for <git@archiver.kernel.org>; Mon, 17 May 2021 17:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C82C261263
	for <git@archiver.kernel.org>; Mon, 17 May 2021 17:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238340AbhEQRZB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 13:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237875AbhEQRY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 13:24:59 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EA0C061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 10:23:43 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id t4-20020a05683014c4b02902ed26dd7a60so6213536otq.7
        for <git@vger.kernel.org>; Mon, 17 May 2021 10:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C4V2yQbdyyYOSiK8vam0OGhPpxFcVWp2jwrTAdrD/EI=;
        b=hbTmSzkFsd6D8jA3kIT/KdGHGcA6BJlSeQ97iaK8n8hMHx4s9357ZW/m0CP0zx2pZo
         UMHxOfiom6vSfGh7Y9froZcitTwEREUN79D9onwmM20sZ2ddjKPmj1H+8DxiYioVCkEW
         P8uK9V7u4BdtUbvzWP9Ym/OnjVubESzbPN+lL25j02E6q/3KnyxOxluazmGNvL8jY5lC
         jy3prJdQ720is14X3jJPz3PcYXhayVNHUcWyjRkHMpHK36gcEmCgReYx+OEXqC/QutML
         JPKvuh2pbfgEHn3rTncXEomIBQLzFsuhVkdVinOhAJCwFUHUz7kYU2tdXtbeznXe8VtH
         qMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C4V2yQbdyyYOSiK8vam0OGhPpxFcVWp2jwrTAdrD/EI=;
        b=GfhDlGK9DIKQk9WhOeeNg0jqeZaZVOBGo1aqWD97D+62IeyqPYGpNDD0fTVMRikmSr
         L3vscnQjJqzk3HMysB3Gab3TbmZrcmwX9LFQhmJr/azrhYtOuTy3JTxBTxnUC7WY5YDV
         3Y1be0E02UKORhyHAAyfGmHq6AX3vb76eFU2UJ+7ohpGkRmDCYnNSghujmiMgkCrsO8d
         f1w6nY/Jd8WLiKD4uDNTMFRbxGpejRhe8kJ7N5l5iBpjLwQnrAghIMBMhp3w+riJli28
         kWHicm45iNZbziDqfNbf8Vxe3upwLcCszW6LysUQwvfZKQiIPc1LJ5jJXDn9Ccs7d0LG
         J59w==
X-Gm-Message-State: AOAM532MJhjO/nzPivyOA7uGcf2d2o2gqUA3+zlRYTKjvoJdlpehw4m8
        KEzmBN3hutvhp/D+30LZEOs=
X-Google-Smtp-Source: ABdhPJzCS8OyxeR9/8ht8OAW75RMr8JkKeUO841zOqhZ7I5Q0StxAIX3rYC6s8d08n77HRBCI01xvw==
X-Received: by 2002:a9d:4697:: with SMTP id z23mr547592ote.109.1621272222527;
        Mon, 17 May 2021 10:23:42 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:68e5:b0b1:d7d3:e820? ([2600:1700:e72:80a0:68e5:b0b1:d7d3:e820])
        by smtp.gmail.com with ESMTPSA id 64sm3127063oob.12.2021.05.17.10.23.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 10:23:42 -0700 (PDT)
Subject: Re: [PATCH v5 0/9] Directory traversal fixes
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>
References: <pull.1020.v4.git.git.1620758049.gitgitgadget@gmail.com>
 <pull.1020.v5.git.git.1620840502.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e03ea953-5d43-fe33-3219-364ef69691b1@gmail.com>
Date:   Mon, 17 May 2021 13:23:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <pull.1020.v5.git.git.1620840502.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/12/2021 1:28 PM, Elijah Newren via GitGitGadget wrote:
> This patchset fixes a few directory traversal issues, where fill_directory()
> would traverse into directories that it shouldn't and not traverse into
> directories that it should (one of which was originally reported on this
> list at [1]). And it includes a few cleanups

Sorry that I've been sleeping on this series since v1. I re-read this
version from scratch and only found a couple nitpicks.

> If anyone has any ideas about a better place to put the "Some sidenotes"
> from the sixth commit message rather than keeping them in a random commit
> message, that might be helpful.

I don't have any better ideas, sorry.

Thanks,
-Stolee
