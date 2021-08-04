Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DC6C432BE
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 14:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B011F60F58
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 14:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238014AbhHDO1l (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 10:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbhHDO1c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 10:27:32 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D81AC0613D5
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 07:27:19 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id f12so1722762qkh.10
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 07:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d36lJ4GTglvxx4WTLl/PtoKv+OVcG5Mz9SbRAFtYrl8=;
        b=n7I0Q84oF5iyhzeliKNCg6VqBTySHBRNEFzUeIIEV+qjv4rhc92eonvrPkN2BebF2V
         p2XkPHkW1TNrhXTe5IbMqzhXqChYPzq8qCD3Rmmk3MoDHuFEJemhk+iTyHKjzZmgik1L
         EPGuDXe3tE5G8yr124S1G9F8qvTV5r1E0EMcwoYG6TCUN5tthfARikmJQyOy2rMDIAV7
         I0gqHj5YooTBxU5UQy6W6yRAL2SzfSbyQWuy849P6lQ3FMCRXRKHi9kVY+04Ms090u8s
         mvTqoZGOtNyCKqfbli8rCe0WsnGeuImDDkcSA68/URVZbTvQ9njlPZkmaxuPTh+NT7pq
         agOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d36lJ4GTglvxx4WTLl/PtoKv+OVcG5Mz9SbRAFtYrl8=;
        b=pmij5qaSP/TVP46c7iCavibycnFRJJDbakrUy95P3DNQNCqJ4RrTI++tvkM5F0XWKL
         1OZTOZKfK5+SAYQqyMMTOfox8EypwvIkG3NJjR7CFWpc2685kc9rcu446KFLYV9ZVETI
         hJR3PLJhsRvG3DBj4ipNcfGXRsXm3yiI+6w0Jgzszi+S1ofzdSV1VKVHheGtWYYfAK4Z
         F1YxxWQh25r2RQ8hrO9Zp00p5Ku1sQLHre19yMHLB2tq75arbx0ZW6vfDEV81dycH70b
         rOWivaNcjpZ5pLWrQDMogNNwDvev6zMu4fLZBGMBpAEdeStqUYyAvepHpWcfwaRs2u5V
         aZiw==
X-Gm-Message-State: AOAM533HOALxa2fE0vAYWji26cMTSAATJvF4iNyyvxDPvyQNPQUDYWP0
        Hh/4fUNcn0REsbGiWLCmN4g=
X-Google-Smtp-Source: ABdhPJwOZSJrEh8wP+cgb70mhi60NlTsH1RrOB/+pW6gPAYU3xHk05DWiPV0tAMfjrRdcLou6ky8kQ==
X-Received: by 2002:ae9:e606:: with SMTP id z6mr26353535qkf.152.1628087238716;
        Wed, 04 Aug 2021 07:27:18 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3da5:bc29:43f3:f85c? ([2600:1700:e72:80a0:3da5:bc29:43f3:f85c])
        by smtp.gmail.com with ESMTPSA id d28sm1378645qkj.25.2021.08.04.07.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 07:27:18 -0700 (PDT)
Subject: Re: [PATCH 0/2] Switch default merge backend from recursive to ort
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1011.git.1628055482.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <19187114-4a91-19b8-7c41-407a4a661f41@gmail.com>
Date:   Wed, 4 Aug 2021 10:27:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <pull.1011.git.1628055482.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/4/2021 1:38 AM, Elijah Newren via GitGitGadget wrote:
> This is a reroll of my RFC series[1] to switch the default merge backend
> from recursive to ort. The consensus seems to be that we should do this
> immediately after the 2.33 release.
> 
> Note that folks who want to get the old merge backend after this series can
> simply set pull.twohead=recursive. (And, similarly, before this series,
> those who want to try out ort in Git 2.32 or Git 2.33 can set
> pull.twohead=ort.)
> 
> Changes since the RFC version of this series:
> 
>  * Now depends on the reroll of en/merge-strategy-docs I just submitted[2].
>  * Made tweaks to code and documentation suggested by Stolee, Dscho, and
>    Ævar

I'm happy with this version (modulo a super tiny nitpick that doesn't merit
a re-roll) and the docs that preceded it. I'm going to adapt my version for
the microsoft/git fork to take this version and put it in our v2.33.0
release.

Thanks,
-Stolee
