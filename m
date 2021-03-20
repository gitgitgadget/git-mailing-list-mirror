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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DC7C433DB
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 01:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F3756197F
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 01:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhCTBt4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 21:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhCTBtk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 21:49:40 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F44DC061760
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 18:49:40 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id m13so6759672oiw.13
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 18:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8tKyMh0a1+Mm2nUiilFWgMlECanJSyeSYMXgACqyN08=;
        b=HBbPHgxoemlZGhLvCH7SYBFszyhO9h1eEP9dbZhOobDd1sQ1zpheA37xwTYtxP0nma
         0CEfwku1Q89HwEpMasu0Noa/O+84N9Ch17UFAtHAI2tfIXtp5WM0Rhu0RoTwsMPiRqcg
         30Oad63Jy1DTFqi2IXqYsZClgPf9jfj2a5w/j5d5TmG1u82qMODU34ALYHjyrJk95BU1
         qvkH9t1ANq8wY88cZ/OlgUgleYlwMA/QICVXX1Yr5gl+8Yr9+ahihCBVfPB9ZVOUJNJ6
         dmKAEo7SYi0rW0yNLh5bopPWsuCy+22aRVfFvnr6jEXLDnaaPtGY07ajVEOxoghzZvSh
         WEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8tKyMh0a1+Mm2nUiilFWgMlECanJSyeSYMXgACqyN08=;
        b=P2KJ1vBktsAPaBS0r86YGQqU8GknmcGKilrk2f9NBjXUgU+apUiLo/NdEUXDg9Sw6L
         Z9zMyTkGTkUl5I8CzFXkMuF6Hc8RvCryJEWabophQBnY6y1xcZNu2zD9VEWvLv+nx7jX
         9V5MZTZnZDBwgyQT+K8GralVVyPM8zhsgv+To8TBOCaaespv0EuQ82CKi1tt1YTy9pRP
         ZoKff3CqUlOos0N5YTGppsTGWmuGG4xLixHE5UTsCpG+N0ehFv0QMSBbou64rDvZGRTU
         u5lTfUFjV9pcMUxKYd9lvBXR22lMuKsoLdy0/k6OUcdv8uZpkczfj/vX2GNEoiYBF/Pn
         0hog==
X-Gm-Message-State: AOAM5323m2ndi7gt8IGsdhI6UA222hxv4Qlu6MwnWzcO63gEqgANjOMr
        8lVkeZY2DSWL9mY7KsG5SqQ=
X-Google-Smtp-Source: ABdhPJxbXlXa0T4aKAdr/GUfF/dyWNmeotabpHInY4Z2V36HhLvRWlBQGpo31D3mIPvasbEPzSRj/Q==
X-Received: by 2002:a54:4806:: with SMTP id j6mr3136715oij.15.1616204979461;
        Fri, 19 Mar 2021 18:49:39 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:5c2:d98f:a8c3:5198? ([2600:1700:e72:80a0:5c2:d98f:a8c3:5198])
        by smtp.gmail.com with ESMTPSA id l190sm1610723oig.39.2021.03.19.18.49.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 18:49:39 -0700 (PDT)
Subject: Re: [PATCH v3 00/13] Declare merge-ort ready for general usage
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.905.v2.git.1616016485.gitgitgadget@gmail.com>
 <pull.905.v3.git.1616198636.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4da61e15-a490-673a-ef15-800321ac9eea@gmail.com>
Date:   Fri, 19 Mar 2021 21:49:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <pull.905.v3.git.1616198636.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/19/2021 8:03 PM, Elijah Newren via GitGitGadget wrote:
> This series depends on ort-perf-batch-10[1], and obsoletes the ort-remainder
> topic[2] (that hadn't been picked up yet, so hopefully this doesn't cause
> any confusion)
> 
> With this series, merge-ort is ready for general usage -- it passes all
> tests, passes dozens of tests that don't under merge-recursive, and
> merge-ort is is already significantly faster than merge-recursive when
> rename detection is involved. Users can select merge-ort by (a) passing
> -sort to either git merge or git rebase, or (b) by setting pull.twohead=ort
> [3], or (c) by setting GIT_TEST_MERGE_ALGORITHM=ort.
> 
> Changes since v2:
> 
>  * changed the last patch to default testing to ort so people don't have to
>    wait until CI for failures (but still keep linux-gcc testing
>    merge-recursive so it retains coverage), as suggested by Stolee

What a great suggestion! This series gets

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
