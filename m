Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8248C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 20:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B562E61078
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 20:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349670AbhIHUDi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 16:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241581AbhIHUDg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 16:03:36 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7C4C061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 13:02:27 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id u4so3011332qta.2
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 13:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7YDkmRcMTSFLFQA0rK7ydWAizBTjUbppS/unVFfCNkY=;
        b=Rd2C+lHmTq+vNsn/FGjqnm0VzbliwvB/QMUd2lsKHFVXaHF2V8oE+eTCNbpqzaaya2
         FAnEEd6x6Woy+hVaswgXNG60pkA/W0ZdkXQhVLiFK7KSMN+ulniDuxe0Z9SnXN45Vlup
         S/+117VZSTyFSWmqbHEVCiur/x3z4F9yczwR4yR42KeMLq9NM62sn+aV4cN8X7obpQ7H
         /p7f20rMiPnUiomt9iQXqvKuxyJrZUQhMzKkmbiPSDg97lSegFexAiUd+0hXX5Q48aZB
         uQl91veHaEMoyadsXPhRcVXLGRbyffqdeIqS1+cyiExTRBo32x8rZvKbZkUP7iYY4ODh
         fwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7YDkmRcMTSFLFQA0rK7ydWAizBTjUbppS/unVFfCNkY=;
        b=AuIPdUnlm1R3To9oL/6+xpDBPeca8oVqaMTDppcQD6FtoevAQt9MVbOv4/sG+bKEdq
         x4OUgWEGEiCc2NzmXom4m8BIW0aDntf6AYdepMjEJy7NPl6eYLyFOAhcj520e5BykMCR
         bBdcOzO7fn+35ZG5il32/VdyGVdaNmch5pB1jLsGAWS+pTU1908iq/7vcXmTuttfz8aA
         sbRKgrdVdSbPlnNC9YYsO7mZ2PZ90KQ+BHxb36d+wzttHIk9Ti6MJQZA2F8UKc0NEhIV
         qjuKBwmNk/jF0+7mg0qmzCbYZxR0u1gkLhxpJsm4BvZLocgg132AH5wj55B/Wbz7lXPA
         sEhw==
X-Gm-Message-State: AOAM5307tNFgnxO7JrwmEbFxKR1ZafxOi/QIYxZtc3M1yR6e41SbmfIn
        atbSJKLrmWa7NhhAVXQKhYs=
X-Google-Smtp-Source: ABdhPJz40qRyetUAF60KkdWJvOLTofF9EO5Byn2YHtm8Nc90hhFVyGpjaI2b5bVbZAJnnNrGyA1pSw==
X-Received: by 2002:ac8:7f06:: with SMTP id f6mr93256qtk.262.1631131346430;
        Wed, 08 Sep 2021 13:02:26 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:79fe:8f64:ef46:a881? ([2600:1700:e72:80a0:79fe:8f64:ef46:a881])
        by smtp.gmail.com with ESMTPSA id w6sm85413qkf.95.2021.09.08.13.02.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 13:02:26 -0700 (PDT)
Subject: Re: [PATCH 06/13] add: skip paths that are outside sparse-checkout
 cone
From:   Derrick Stolee <stolee@gmail.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>, gitgitgadget@gmail.com
Cc:     derrickstolee@github.com, dstolee@microsoft.com,
        git@vger.kernel.org, gitster@pobox.com, newren@gmail.com
References: <eeba97ad492307302637faf33f6bf6ae8965faa3.1629842085.git.gitgitgadget@gmail.com>
 <20210827211310.108999-1-matheus.bernardino@usp.br>
 <28762f8f-d9b4-caf8-18b5-3cdbf6b59a7d@gmail.com>
Message-ID: <41852f4f-5b37-2527-c907-1de2a6d2018d@gmail.com>
Date:   Wed, 8 Sep 2021 16:02:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <28762f8f-d9b4-caf8-18b5-3cdbf6b59a7d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/8/2021 3:46 PM, Derrick Stolee wrote:
> On 8/27/2021 5:13 PM, Matheus Tavares wrote:
>> On Tue, Aug 24, 2021 at 6:54 PM Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com> wrote:
>>>
>>> Subject: [PATCH 06/13] add: skip paths that are outside sparse-checkout cone
>>
>> Perhaps this could be "skip _tracked_ paths that ..." (to help
>> differentiate the end goal of this patch from the previous one).
>>
>>> diff --git a/pathspec.c b/pathspec.c
>>> index 44306fdaca2..0e6e60fdc5a 100644
>>> --- a/pathspec.c
>>> +++ b/pathspec.c
>>> @@ -39,7 +39,8 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
>>>                 return;
>>>         for (i = 0; i < istate->cache_nr; i++) {
>>>                 const struct cache_entry *ce = istate->cache[i];
>>> -               if (sw_action == PS_IGNORE_SKIP_WORKTREE && ce_skip_worktree(ce))
>>> +               if (sw_action == PS_IGNORE_SKIP_WORKTREE &&
>>> +                   (ce_skip_worktree(ce) || !path_in_sparse_checkout(ce->name, istate)))
>>
>> Hmm, even though we skip the sparse paths here, cmd_add() will call
>> add_files_to_cache() at the end and still update these paths in the
>> index. I think there are two ways to fix this. We could either change
>> run_diff_files() to skip these paths (but I don't know how other callers
>> of this functions want to handle this, so maybe this needs to hide
>> behind an option flag):
> 
> You are absolutely right to point this out. I had missed this interaction.
> But, this is also already broken. The patch below adds a check to show that
> 'git add' does not add the sparse_entry, but it does (even when applied
> before any patch in this series). That is: all the modified tests fail
> after this change. I'll work to fix this issue before the next version of
> this series.

Of course, the reason for the failures is because the 'sparse_entry' is
staged as part of setup_sparse_entry. Not a bug.

This makes things more difficult to test, so I'll look around for an
alternative way to test that 'git add' is behaving correctly.

Thanks,
-Stolee
