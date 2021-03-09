Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F092DC433E6
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 20:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C68D365256
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 20:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbhCIUVI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 15:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbhCIUUp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 15:20:45 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD1BC06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 12:20:45 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id h7so7099857qvm.2
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 12:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mMZisoUp759/CIZx1GjkraelpX8hnvg+7G1xV1bClpE=;
        b=fYz1YitxmVtIeUpaQp8tYYjCMJD7suV9n/geeavREHOjZjnQEvEgkUgVPwCa9JVN9G
         7upyM2Thd89/etcsIq0T0WNeMqt1iRXIPzxqlFjgRANMZJAWeT8lRZpfH+oKzbHU+8sc
         5/GCS/kWI3IyaDeDrLUWyoB0j+jsVqG18D/Gjv0V8Gq0PvxpJT/D04tsTJe9hc7lN2NI
         kJfdbFQSwnXvjCWzxn+B7AtKqQR5Mxwfmc5mM6HO0pWsZeUKgiIX/gu4M4M05iYNuLLl
         xprh6Avk4Z4SHaNw+nM6VyUFnQKZs7KjUJm8X9kod7HjpbUZuWOdYTkno1Z0IeAAz+dO
         akqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mMZisoUp759/CIZx1GjkraelpX8hnvg+7G1xV1bClpE=;
        b=U3gyqceq/MD4pqLk1CRaozCY/AYiDlsLwJCkTLTEKB2ftnon9ThxvcdEiPC+i7+A6Z
         wST/nUgwgo9on0/9Ub/1ZoPw1YCBDnhl0c3Y092Jxb3wH3UxUwKBC6yKyZHctp2DljE9
         F0BjpiEA5ivg2ERfoDDOMm4gw77qjYzdwpiHP8zXEmhufaNCoPqTf6WFU5aAtzuPfIU0
         adICB9gROuTZ3lbKqoLWb+FKqs5renLynZs8W2R2IsM1NN/LFlOKZsb70yLgQyDioL6K
         2JvfYYRlmUxWFZeaBHKTY44tbO3l5bnm9JhqK5LtmcrZVuEnxDFeYO1gfAkvJBu0nkvM
         K0eQ==
X-Gm-Message-State: AOAM530fSscdtzNNBoWO9vpRfRrWLmCw6kAJgvYhT+kZ9IDam6k4CsPg
        YVD5vmYT7JZrolJfV6j+VYRfjJZMUfdjtg==
X-Google-Smtp-Source: ABdhPJx+8g/wPDKnrVyP7r8xZiDVBXkV2wMRtxH3ClwcG3s2LBe9qa3L5xjO3nJi0GjYatUAl6r8Ag==
X-Received: by 2002:ad4:44ef:: with SMTP id p15mr5575281qvt.25.1615321244670;
        Tue, 09 Mar 2021 12:20:44 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:88a7:dd04:71df:86ee? ([2600:1700:e72:80a0:88a7:dd04:71df:86ee])
        by smtp.gmail.com with ESMTPSA id f2sm5611934qkb.50.2021.03.09.12.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 12:20:44 -0800 (PST)
Subject: Re: [PATCH 17/20] sparse-checkout: disable sparse-index
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, gitster@pobox.com,
        pclouds@gmail.com, jrnieder@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
 <bcf960ef2362e32e2f8d7e06a31a925936f62bc1.1614111270.git.gitgitgadget@gmail.com>
 <20210227123253.GC3590451@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <48e9c3d6-407a-1843-2d91-22112410e3f8@gmail.com>
Date:   Tue, 9 Mar 2021 15:20:42 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210227123253.GC3590451@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/27/2021 7:32 AM, SZEDER Gábor wrote:
> On Tue, Feb 23, 2021 at 08:14:26PM +0000, Derrick Stolee via GitGitGadget wrote:
>> +test_expect_success 'sparse-index enabled and disabled' '
>> +	git -C repo sparse-checkout init --cone --sparse-index &&
>> +	test_cmp_config -C repo true extensions.sparseIndex &&
>> +	test-tool -C repo read-cache --table >cache &&
>> +	grep " tree " cache &&
>> +
>> +	git -C repo sparse-checkout disable &&
>> +	test-tool -C repo read-cache --table >cache &&
>> +	! grep " tree " cache &&
>> +	git -C repo config --list >config &&
>> +	! grep extensions.sparseindex config
>> +'
> 
> This test passes with GIT_TEST_SPLIT_INDEX=1 at the moment, because,
> unfortunately, GIT_TEST_SPLIT_INDEX has been broken for the past two
> years.  However, if I run it with my WIP fixes for that issue [1],
> then it will fail:
> 
>   +git -C repo sparse-checkout init --cone --sparse-index
>   +test_cmp_config -C repo true extensions.sparseIndex
>   +test-tool -C repo read-cache --table
>   +grep  tree  cache
>   error: last command exited with $?=1
>   not ok 16 - sparse-index enabled and disabled
> 
> https://travis-ci.com/github/szeder/git-cooking-topics-for-travis-ci/jobs/486702444#L2594
> 
> [1] Try to run it with:
> 
>       https://github.com/szeder/git split-index-fixes
> 
>     The code is, I believe, close to final, the commit messages,
>     however, are far from being finished.

I'll keep that in mind. I should have added a variable
that disables GIT_TEST_SPLIT_INDEX for this test script,
since the sparse-index is (currently) incompatible with
the split-index. I bet that the test is failing because
it isn't actually writing the sparse-directory entry due
to that short-circuit check.

Thanks,
-Stolee
