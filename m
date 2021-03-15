Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D214FC433E9
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 15:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7D4D64E45
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 15:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhCOPVf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 11:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbhCOPVM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 11:21:12 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51657C06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 08:21:12 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id w21-20020a9d63950000b02901ce7b8c45b4so5305307otk.5
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 08:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YwKwcHngv3/ecWSDOUmQtbhl20+wX4fFlo4vrvxmnJE=;
        b=BezBbyKuRSnA0/XyDE713+LRveuvBi56JuNY6uc+PXDLBdFkwJOXiKZIxwZOTWEgBm
         lo9yokF1s405ODpIUK+6iNEJ6rmATp4YHx/btE0ke66TY65qQkK2K0YEncxW/ZUODxAw
         H0xPo49qt0RYUDCWqmuTXDQImb2w9lgjmI0it1FbGTTmEtO/34n3AFY2zNxm3FgYYmQK
         VxVtzX97P+G+sE29rTNLjoVfi6/jS19EXnP8IlM3KiIPbfeRmkgWxZKzcdqArwlI+TJ6
         7nS32BiD6hiVFEjqcwavYDcNms0ZLo1pHTZA5EBSjUIKOhW3r7udA2Kw0pSEtT52sQi0
         dlIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YwKwcHngv3/ecWSDOUmQtbhl20+wX4fFlo4vrvxmnJE=;
        b=IgKdMcvl5QvnLUlRLmppCnWj3+evwy4d6r0PVvvf+0MVZuY/KAIp/HteeXBfCazrCi
         NUo8tBzmiM0HepZ7z0xtOkxHtf7bliW8ekBbeGFR+KZ3G3ge2jz7qE2cgzLoKUnZ7son
         VrmRo11BIJ7pcxU7WxOoWavO7lafGyHroUNmQnJFxTNlEFUGxpqJ+cvojWr4Pskiao7o
         O3BBg424Hzx8fGrIDD6xwXZXwLBxIogq4kgGwP7/jnWtHQck1ZPGMxyPJB8gtoucK9EB
         evoyb/OSkerFnsbevdiJdueUEwfpyrli3FnWbB/mmfeRi8VSJjI3DawhYPOq7DpQsfkm
         XVEg==
X-Gm-Message-State: AOAM531KNP8ypCylwN85SdRFcuJXyEXkMQwwFH0mueCIar6T9WF9GtLs
        zAwdTsvdhsIhKyLb49qv4dFT5kGzyBiOMA==
X-Google-Smtp-Source: ABdhPJywGP9ztwyluCCvgzE7NOanGnUBM9R1nCVNeCwMNMrb3GkVWBjuNvlGEk8NCxb/orH/u1pYnA==
X-Received: by 2002:a9d:3a34:: with SMTP id j49mr14146143otc.153.1615821671642;
        Mon, 15 Mar 2021 08:21:11 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:44e0:e2f9:fa7e:56fa? ([2600:1700:e72:80a0:44e0:e2f9:fa7e:56fa])
        by smtp.gmail.com with ESMTPSA id x17sm5646493oie.5.2021.03.15.08.21.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 08:21:11 -0700 (PDT)
Subject: Re: [PATCH 0/8] Optimization batch 10: avoid detecting even more
 irrelevant renames
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
References: <pull.853.git.1615674128.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8422759a-a4a3-4dc6-4ae7-4a61896b9946@gmail.com>
Date:   Mon, 15 Mar 2021 11:21:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <pull.853.git.1615674128.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/13/2021 5:22 PM, Elijah Newren via GitGitGadget wrote:> === Results ===
> 
> For the testcases mentioned in commit 557ac03 ("merge-ort: begin performance
> work; instrument with trace2_region_* calls", 2020-10-28), the changes in
> just this series improves the performance as follows:
> 
>                      Before Series           After Series
> no-renames:        5.680 s ±  0.096 s     5.665 s ±  0.129 s 
> mega-renames:     13.812 s ±  0.162 s    11.435 s ±  0.158 s
> just-one-mega:   506.0  ms ±  3.9  ms   494.2  ms ±  6.1  ms
> 
> 
> While those results may look somewhat meager, it is important to note that
> the previous optimizations have already reduced rename detection time to
> nearly 0 for these particular testcases so there just isn't much left to
> improve. The final patch in the series shows an alternate testcase where the
> previous optimizations aren't as effective (a simple cherry-pick of a commit
> that simply adds one new empty file), where there was a speedup factor of
> approximately 3 due to this series:
> 
>                      Before Series           After Series
> pick-empty:        1.936 s ±  0.024 s     688.1 ms ±  4.2 ms
> 
> 
> There was also another testcase at $DAYJOB where I saw a factor 7
> improvement from this particular optimization, so it certainly has the
> potential to help when the previous optimizations are not quite enough.

These performance numbers continue to be impressive.

I read through this series and found it clearly described. I can't
completely vouch for its correctness, because there are a lot of
moving parts at this point. I'll trust the test cases and Elijah's
additional manual testing at this point.

Outside of me talking out loud about an enum (which you can ignore)
I didn't see anything unusual about the code.

Thanks,
-Stolee
