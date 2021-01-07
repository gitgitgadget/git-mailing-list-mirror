Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E270C433DB
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 13:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 015CD22B45
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 13:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbhAGNht (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 08:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbhAGNhs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 08:37:48 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BE1C0612F4
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 05:37:08 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id r9so6130938ioo.7
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 05:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QA6hekqA0reyczUxgppViVD+0Dc/PvWP7KguDyCvXbQ=;
        b=s6e65C4aOOkAKgu4/HHxBZa5WP+TZzG9aD8xeUouSLNHQ5K6qWDcCfa2TIR0Y08AWU
         q7jL2Xa2My0GjkzB/NjHYWwX0RjJuio71FIBf2UYxPew4y11J8CeyVf0DaPs9xSCKqvp
         TFnnYrAbAMMVL1NJ3ZH7kx5zU/qDtgLFuFPrENqGSJU7u5xEDc5CA9NUiEgRMTMdnvsg
         UOSKsGYE4BGEAScPDM4dPVBW4OUsWfPeWpXPNfeDzCezvmXPErVDlllH3fgZj8IDCdn/
         2+nRSsdXwUfXTnLeWrVXZ532oHXvE313G4Dsz5LS1h2N8zyss1MAywWS0tIwxFZmDB4G
         1csg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QA6hekqA0reyczUxgppViVD+0Dc/PvWP7KguDyCvXbQ=;
        b=Lj2qdNrh+nNM0SFrk4+cX/LQ25ktos38veUiWnvhSVJfnVFoELnl6qdgu14ktymLT9
         zr2bbCBw2BNizZ5bVpxlNK10NKvkngl1EF55NBxB6qjSHDnLxVuy0K2Wx7y4RqsUEo+C
         H43BZs4YU56m1awmOay5qLnTZdphCNgiML0DHMMcnfzTfPBcU6coQnhB3yT6vu7pEHnp
         /ystsc2BzTyH2cBnrDT09R9XR4z9tbjyMug0I8zB3vq58X2BIAYB5AuuTrY8fpkUseyQ
         AAgCr8a64h319U7KrAW/ORdjTD9H58LiA7ZqAA2FYvybowE9hnGv3GODyWZqJB/p84hE
         PWkw==
X-Gm-Message-State: AOAM530mUzGfuh4QTYjyGcCu7qscb1LA67mIqEFvt0W85XLcwqElP4LJ
        h3Px4KIjeroRKngb8tWnA5A=
X-Google-Smtp-Source: ABdhPJyPTCXOjdYt3dgSTlBVr9D7cOL2gIljzfqX4TCpvq19obzogEEZAoRamAVt/sDcqXyO/xeIeg==
X-Received: by 2002:a6b:bac3:: with SMTP id k186mr1270088iof.194.1610026627852;
        Thu, 07 Jan 2021 05:37:07 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id l20sm3461986ioh.49.2021.01.07.05.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 05:37:06 -0800 (PST)
Subject: Re: [PATCH v3] mergetool--lib: fix '--tool-help' to correctly show
 available tools
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        pudinha <rogi@skylittlesystem.org>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <pull.825.v2.git.1609184505071.gitgitgadget@gmail.com>
 <pull.825.v3.git.1609981745668.gitgitgadget@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <e5d24e6e-9a69-aa1f-483b-b892497a0e20@gmail.com>
Date:   Thu, 7 Jan 2021 08:37:05 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <pull.825.v3.git.1609981745668.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 2021-01-06 à 20:09, Philippe Blain via GitGitGadget a écrit :
> From: Philippe Blain <levraiphilippeblain@gmail.com>
> 
> ...
> ---
>      Fix regression in 'git {diff,merge}tool --tool-help'
>      
>      Changes since v1:
>      
>       * Changed commit authorship (v1 sent with wrong identity).
>      
>      v1: I went with Johannes' suggestion finally because upon further
>      inspection, René's patch for some reason (I did not debug further)
>      caused to code to never reach 'any_shown=yes' in show_tool_help,
>      therefore changing the output of the command.
>      
>      I guess it's too late for inclusion in 2.30...

Forgot to summarize changes since v2:

- rewrote the description of the symptom of the bug to reflect what
was really happening
- changed the test to not rely on hard-coding the number of tools,
and just checking a few known tools are shown instead
