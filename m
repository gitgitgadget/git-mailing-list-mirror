Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D56C433E0
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 13:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 928836191E
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 13:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbhCWN0k (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 09:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbhCWN0f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 09:26:35 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555EBC061574
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 06:26:09 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id i81so15495153oif.6
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 06:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f6PHuCyT/ZnoYxAvZxEIXWwveNe6aVyE28vfIUluZ/E=;
        b=azwlUjdZ0ktqMgD3Nh+m35UG3EgTAhGGxGkBFfA78su+zDd/RaemN4XPJ/S0vTevoH
         J7ciam16xuqfLukRQcpTZ4AOMiXCCvloSZK2VfT5QZlgXyJGk3eExMILPtFrV5onCvI5
         /tG6dJcCL53Fxq37GR39Tm3YZstKW0Y88Gnn0UtDek1l9ZxeMYcMACGuh5x04dZc1UKc
         vOxILOZptmMleCi5EylwAi01EfSb+jfCdPnmORzjvDkBib5xz3zsa0B/2xbDBcC5vURb
         5Mjo/+u3XRLgI8ICHjqU/eD8dPjyAO41B1zJteNNFh7btzQYxPHlCDN4tl+5Qd2lSigP
         yhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f6PHuCyT/ZnoYxAvZxEIXWwveNe6aVyE28vfIUluZ/E=;
        b=ge4EWX8Ab47U0XzU+L4z28EJTEMTVbRD01NuLXoA2ay6z3Q6z+wgC5/l1wqPyPPeCH
         hadU5/oNuSuGSFTWYPlRRBv4IuDDT7qkNKzrzZkgEDH/xIQj/grqNX0uCs8mpp9H7LUU
         gnzmVQbMhW/sa/r/sy5OQhnf+j/Ea/Ra6XUjniLlLfMTfNEkkxrYTaKj2zekDZaeQbxN
         m/BSkCtI38GiO7Bnk63tfsU8P1QQ60BpOEo15yck40cUJDvrc9mygSRKBNh5tfC9q7R/
         o1XXcg3lzo/WzKlad3SzVHSC+ner975sahi1HG0ZtsEvWx5WW6JNTGIltjt8XAh6mr5n
         Lpcw==
X-Gm-Message-State: AOAM532zehU2JA9gdZccj9rLPxVXQ1Cq9xIxb9FAaA1iRVvf+wjAJvyp
        DlVDaU0P/PuXyi8viBF670rsuI6r7nVcB3/M
X-Google-Smtp-Source: ABdhPJxshUx66SJ2Eb0xHrjicGUbC3+8tmXA0PVbHPwS+8/md4LqUa6kl36AkWvb34Rcs44CSccc1A==
X-Received: by 2002:aca:484e:: with SMTP id v75mr3380828oia.56.1616505968696;
        Tue, 23 Mar 2021 06:26:08 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:19be:10a5:ec17:ace3? ([2600:1700:e72:80a0:19be:10a5:ec17:ace3])
        by smtp.gmail.com with ESMTPSA id g6sm3714968ooh.29.2021.03.23.06.26.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 06:26:08 -0700 (PDT)
Subject: Re: [PATCH 20/27] merge-ort: ensure full index
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
 <fb4c7038b7468c77c4d3c5181f0cb0de85d1149f.1615929436.git.gitgitgadget@gmail.com>
 <CABPp-BF93UaU7JnwxQiEp2wf1jffLfQax+z4_8Q3-6DxXPUgRg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e445a124-4715-a304-a006-08c2d1ad86ad@gmail.com>
Date:   Tue, 23 Mar 2021 09:26:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CABPp-BF93UaU7JnwxQiEp2wf1jffLfQax+z4_8Q3-6DxXPUgRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/18/2021 1:31 AM, Elijah Newren wrote:
> On Tue, Mar 16, 2021 at 2:17 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> Before iterating over all cache entries, ensure that a sparse index is
>> expanded to a full one to avoid unexpected behavior.
>>
>> This is a top candidate for updating later with a proper integration
>> with the sparse index, since we will likely enable the ORT strategy by
>> default when the sparse index is enabled. This appears to be the only
> 
> s/appears to be/is/   :-)
> 
>> place where the ORT strategy interacts with the index in such a global
>> way, so that integration should be clear once the ORT strategy and the
>> sparse index topics stabilize.
> 
> Right, there is one more patch that will touch this function -- patch
> 7 from the series that marks merge-ort stable over here:
> https://lore.kernel.org/git/pull.905.v2.git.1616016485.gitgitgadget@gmail.com/
> 
> While I have more optimizations for merge-ort, none of them will touch
> this function.

Yes, I noticed that that was one of the conflicts introduced with
this series.

I took a closer look at that patch and method, and it seems like
it only cares about paths with SKIP_WORKTREE _and_ is conflicted.
If it has a conflict, then I believe we won't collapse those
entries to a sparse-directory entry.

I think I will drop this patch for now, and rely on the fact that
I plan to enable merge-ORT directly if sparse-index is enabled.
At that time, I will carefully test this logic.

For now, the 'command_requires_full_index' guard will be
sufficient to preserve behavior.

Thanks,
-Stolee
