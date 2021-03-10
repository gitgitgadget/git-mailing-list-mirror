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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0557C433E9
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 18:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5BBF64FBA
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 18:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbhCJSUq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 13:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbhCJSUd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 13:20:33 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D16C061760
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 10:20:33 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id d20so20117778oiw.10
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 10:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PM5F9K8Wi4rtwmXo7in8NfJ6tqZCNF4PhkPzHijdARk=;
        b=FilmXB2+ljGnZAotMJgPO4f/SBAjm+jso7pa/3gOzSe4BkSTlBFLUFRXPBnziBywGr
         k7Qm14hDVvjtNiRQdREEKRtJvB4BqMyWD9UZYanqUgKwTW5eOasLKw7F2SCkwaAhpli6
         6Lry5HxvE4N1QDKg+La2WCfGKVBy3ItYqKiIorPMLzldJiUo4Ok1p+1JqXNwO0UHcan8
         oUMJnRubkMbtdSA1i/jqoZoeFVMmKwfXyExiE8mkpxi5Vzhs5Z6f/Dd48zcU0JVayp9q
         SaWiX12mDjIWSmpuGLhRJuIR4pQanhyJ+wA3YFz0F0r+kKg8EV+daVW1VKBvrWC2nB8l
         sqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PM5F9K8Wi4rtwmXo7in8NfJ6tqZCNF4PhkPzHijdARk=;
        b=HhBItutmHjR/2pZ3dzzXKaM+Uibd2yKwZPTMgkSLNAocmPYk04iRkbNQat4xhZ0E0C
         SQPwc3XHTd2CrEDf9zqQX1Fd417i8fYUxILbag5Rxd2vdG90NAPs48szeXnPgZ/qK49m
         tx/omqu51w68GOMXhEO1bMp9v0fyk1Mrtsh+Q1wKcygMzA8REJXKRCl0DGuWUWGuQR8P
         zvGSxTYMpRQnueAyNgKzBQ4prEjiX5W2+69zy5Uj+OqtTkmAzPDlQQ6Jc3a4kshWLQ7j
         Wm8BdXKv+Fmc26JO97bnCmXqDhsYIHgiUMOi19M107VkZoAuskDQB5Cd3XhGnws0XFcM
         K3BQ==
X-Gm-Message-State: AOAM533imC1ZPM2UASrycQS+NkiBorhz18tweoUJa2kHSq2cbgXzs773
        V1uwaMzJUBjk8o9vfuefGWc=
X-Google-Smtp-Source: ABdhPJyRwWB16xwCliH4Xeg9F/7MksHBdzehsmSNrmx5vcyQAuvdMgXbUebbimGCbbAxv07b05wuXA==
X-Received: by 2002:aca:4d55:: with SMTP id a82mr3301736oib.23.1615400432390;
        Wed, 10 Mar 2021 10:20:32 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:cc70:a06f:72ba:12a7? ([2600:1700:e72:80a0:cc70:a06f:72ba:12a7])
        by smtp.gmail.com with ESMTPSA id c10sm62142otu.78.2021.03.10.10.20.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 10:20:31 -0800 (PST)
Subject: Re: [PATCH 17/20] sparse-checkout: disable sparse-index
From:   Derrick Stolee <stolee@gmail.com>
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, gitster@pobox.com,
        pclouds@gmail.com, jrnieder@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
 <bcf960ef2362e32e2f8d7e06a31a925936f62bc1.1614111270.git.gitgitgadget@gmail.com>
 <20210227123253.GC3590451@szeder.dev>
 <48e9c3d6-407a-1843-2d91-22112410e3f8@gmail.com>
Message-ID: <3f6d26ad-fb51-b1ca-2dd9-5e1a47c7c430@gmail.com>
Date:   Wed, 10 Mar 2021 13:20:29 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <48e9c3d6-407a-1843-2d91-22112410e3f8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/9/2021 3:20 PM, Derrick Stolee wrote:
> On 2/27/2021 7:32 AM, SZEDER Gábor wrote:
>> On Tue, Feb 23, 2021 at 08:14:26PM +0000, Derrick Stolee via GitGitGadget wrote:
>>> +test_expect_success 'sparse-index enabled and disabled' '
>>> +	git -C repo sparse-checkout init --cone --sparse-index &&
>>> +	test_cmp_config -C repo true extensions.sparseIndex &&
>>> +	test-tool -C repo read-cache --table >cache &&
>>> +	grep " tree " cache &&
>>> +
>>> +	git -C repo sparse-checkout disable &&
>>> +	test-tool -C repo read-cache --table >cache &&
>>> +	! grep " tree " cache &&
>>> +	git -C repo config --list >config &&
>>> +	! grep extensions.sparseindex config
>>> +'
>>
>> This test passes with GIT_TEST_SPLIT_INDEX=1 at the moment, because,
>> unfortunately, GIT_TEST_SPLIT_INDEX has been broken for the past two
>> years.  However, if I run it with my WIP fixes for that issue [1],
>> then it will fail:
>>
>>   +git -C repo sparse-checkout init --cone --sparse-index
>>   +test_cmp_config -C repo true extensions.sparseIndex
>>   +test-tool -C repo read-cache --table
>>   +grep  tree  cache
>>   error: last command exited with $?=1
>>   not ok 16 - sparse-index enabled and disabled
>>
>> https://travis-ci.com/github/szeder/git-cooking-topics-for-travis-ci/jobs/486702444#L2594
>>
>> [1] Try to run it with:
>>
>>       https://github.com/szeder/git split-index-fixes
>>
>>     The code is, I believe, close to final, the commit messages,
>>     however, are far from being finished.
> 
> I'll keep that in mind. I should have added a variable
> that disables GIT_TEST_SPLIT_INDEX for this test script,
> since the sparse-index is (currently) incompatible with
> the split-index. I bet that the test is failing because
> it isn't actually writing the sparse-directory entry due
> to that short-circuit check.

The next version will include GIT_TEST_SPLIT_INDEX=0 at
the start and that will make it work with your branch.

Thanks,
-Stolee
