Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EB5C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 17:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2192360F56
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 17:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238224AbhH3R1s (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 13:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238160AbhH3R1m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 13:27:42 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8569C061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 10:26:48 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id i3-20020a056830210300b0051af5666070so19343060otc.4
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 10:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lc2Yp8Eh/mZJpyzNwPn1dhOJZmFcXt7UdCFg8o03NNE=;
        b=ZnJGtrN5T3Y+vk3rommi3meCMbZnXc4IgK3Z9qE1rfUU/5HPv2v2rTNPhzuv456PVX
         vP5EqhkEONf0RMkGEWlvX3mLA5Xskt8dG+SmHLL8JlF5L9Q+XJ+2IDRCzdcyWitfEkQT
         PFjM95ggM6+069XvOF48sXkmMVF77AK7sqL+fAOqiPHrXmCF1RbkCjtBv3KMrszJ+JHY
         hsnXp25EWnRHJtO8vM6HesUoEZu3468nikJwaHxFek99kcUcXkOIlLfxlxa+yNIgIX+y
         2EbsvQIN9mO1zRJGXZYCKh/b/dGMKIeeZ2k9VU4fyWpYw9+IpbiPrRXTi2lURiBIO8+w
         mUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lc2Yp8Eh/mZJpyzNwPn1dhOJZmFcXt7UdCFg8o03NNE=;
        b=BotUwU3EQLuFqgquK7YL0NLHQMysYvsX+0kvCzCdZvrEUn6MmpKf2DzjBCZxcXCEYS
         pPna3tYK7wHEdiB99QkhJvnYUq3E8nQUuGtBm9jiQ4faEPV9Uu32mOMKJW3W1nC37Wu6
         SQa9pgY0SGFt6Qlbuao7Bywh3T+SzQvysBaShxcGNjMlCwoGPv3gDQrVHJtouhbXCpie
         yjKcYWmts9pCCZEP8oh0nX/ZFabdpRKoIJmHnWIvY4URej4AyvCFwuKZJC55CZ1YRudV
         GKcWSheUBkJRqr/DO28e23leN7IugcVD2YUrSxGJu4C8cxmcP80MTUxtvgcGZAzWzqnQ
         pi8w==
X-Gm-Message-State: AOAM5329ZHVjhFvaESc9vgiKvy0q+0Q7K3zD2AOZFfMS4xZnja1wtfSI
        v3HzDZehgolH3C2FT+nyLx0=
X-Google-Smtp-Source: ABdhPJygXBbM6Pb9SNOgVjeClhLeg6LAUSrv51Waene1ALoNf1PeBB9cjxFwS74Pn8u1Qwz00jgUOw==
X-Received: by 2002:a05:6830:154a:: with SMTP id l10mr20597841otp.97.1630344406744;
        Mon, 30 Aug 2021 10:26:46 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:e4d6:1362:a8d2:be4e? ([2600:1700:e72:80a0:e4d6:1362:a8d2:be4e])
        by smtp.gmail.com with ESMTPSA id o68sm3342950ota.33.2021.08.30.10.26.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 10:26:46 -0700 (PDT)
Subject: Re: [PATCH v2 0/6] Sparse Index: Integrate with merge, cherry-pick,
 rebase, and revert
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1019.git.1629220124.gitgitgadget@gmail.com>
 <pull.1019.v2.git.1629841965.gitgitgadget@gmail.com>
 <CABPp-BFXk++dktLnaTTuCe+keqkNuPzGyVi4uFsOpE4VxqAUdw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <cac6803c-b66b-e3b5-b31f-e20695c8b5e6@gmail.com>
Date:   Mon, 30 Aug 2021 13:26:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BFXk++dktLnaTTuCe+keqkNuPzGyVi4uFsOpE4VxqAUdw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/27/2021 6:56 PM, Elijah Newren wrote:
> On Tue, Aug 24, 2021 at 2:52 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
...
>> Updates in V2
>> =============
>>
>>  * The tests no longer specify GIT_TEST_MERGE_ALGORITHM or directly
>>    reference "-s ort". By relaxing this condition, I found an issue with
>>    'git cherry-pick' and 'git rebase' when using the 'recursive' algorithm
>>    which is fixed in a new patch.

This describes why the tests no longer use GIT_TEST_MERGE_ALGORITHM at
the top. It improves coverage in case users opt-out of ORT. Instead,

>>  * Use the pul.twohead config to specify the ORT merge algorithm to avoid
>>    expanding the sparse index when that is what we are testing.
> 
> pull.twohead, not pul.twohead.

We use this config option to specify when we _really care_ about the ORT
strategy as it is necessary to avoid expanding the full index.

> I'm curious, though, why use it instead of just setting
> GIT_TEST_MERGE_ALGORITHM=ort?  That'd seem to avoid the need for the
> explicit subshells and the sane_unset calls.
> 
>>
>>  * Corrected some misstatements in my commit messages.
> 
> I read over v2.  Other than some minor questions about whether using
> GIT_TEST_MERGE_ALGORITHM=ort would be easier, and a typo still present
> from v1, the series looks good to me.

Sorry about the typo, as I fixed it in Patch 3 but not Patch 2. I will
fix these in v3 after I send a v5 of the ignored files series.

Thanks,
-Stolee
