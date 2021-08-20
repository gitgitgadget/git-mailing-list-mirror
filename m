Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAC3C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 15:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3580F61102
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 15:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241014AbhHTPFg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 11:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241017AbhHTPFe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 11:05:34 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1B7C061756
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 08:04:55 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id e14so11153865qkg.3
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 08:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hKfWC/r5/OIW/7QHd8vLuMQlwo4hOyFDr1sCGom2Pfs=;
        b=kPiH046Rh2Q09zntZXNFXcCsFBNAHtu5XNOGcrCr/fkIISsjMjJhf9hk2MPHPejq+w
         pylIZ+e4KpRAamHcT4xk391ehWHkeyF6Yuw+f2/PmIk7Lo9rWm4GyX5qxf1s3SFzQYKr
         hundL2/+BCr1Y1z9kisqLKdRF1Zs48Umd3OpOY0sGr+1HpvbwdzhBUsvB07m9Mi5bWcy
         uR2Mq/nTgWi1UBOGqDBo2E/9Y6Vkbhsk27uYyPEDFMb2Ch3ZobAeq8i9jUhDji2Mh7IX
         w4nY2+PMthj5Vrj4UhJzrbC0LIOeMsrkQlWz65pGlQP6G0fBtK9k7xuxnaJD3cJeZgfE
         QAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hKfWC/r5/OIW/7QHd8vLuMQlwo4hOyFDr1sCGom2Pfs=;
        b=aGIVBIvt7Lssyax5xUm0P3dBAEf3Q7UpBqk+400qcp31hwlrjU5w+v6DfNjy+q53pp
         kZUb/3D2GzO6zrUrDJ9O7x7PtYRfPIrZOpELLvAEPgWWXfHirmwp3jJDoUxv9B5Avcm9
         BwoITUUnoDkHUH1hxi4bjg0nlvEKrfPouV/abN3Z0JPqM37p9xASsY26QU44sT79mvcE
         4UeDWWEa1Hao272HIF0OwKjhxj7AoO1AdGaSILoMv8pgPKbU99bWGjZzbl11yLMnEDJD
         DrxCFHTjoa9TJV9ElGrEMw6t7QXDcFCPeBjlmt3e9KKNPHOshfQHEH3Zu9o7L2VFV9i/
         cCMw==
X-Gm-Message-State: AOAM531QXRQnnU4WCyzo9p2Zx/E3DK1oNwUVVKPRt5mkf3nijQWqr+c/
        ocxYqBR1vNqZFsqVNFFa544=
X-Google-Smtp-Source: ABdhPJxOX3mEBU8SMQvSBiXkdOKOr/o/V5SwdaBpI3xVtPDJaTXE9gc4ro3ThsiBVNoU+J0Jrnrivg==
X-Received: by 2002:a37:9581:: with SMTP id x123mr9236731qkd.477.1629471894752;
        Fri, 20 Aug 2021 08:04:54 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:f436:fc6f:2dd3:d49? ([2600:1700:e72:80a0:f436:fc6f:2dd3:d49])
        by smtp.gmail.com with ESMTPSA id 187sm3282315qke.32.2021.08.20.08.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 08:04:54 -0700 (PDT)
Subject: Re: [PATCH v2 3/8] sparse-index: silently return when cache tree
 fails
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1009.git.1627579637.gitgitgadget@gmail.com>
 <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com>
 <371985352680a767dfacb5477aa77e92e04008ee.1628625013.git.gitgitgadget@gmail.com>
 <CABPp-BFYHZUtiBy1B1NqvKD-S7cT-L138H0rF4-6J_sEpPXYAQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4ec57b02-fcec-cc7a-69c4-5d593fbeb648@gmail.com>
Date:   Fri, 20 Aug 2021 11:04:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BFYHZUtiBy1B1NqvKD-S7cT-L138H0rF4-6J_sEpPXYAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/19/2021 2:24 PM, Elijah Newren wrote:
> On Tue, Aug 10, 2021 at 12:50 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> If cache_tree_update() returns a non-zero value, then it could not
>> create the cache tree. This is likely due to a path having a merge
>> conflict. Since we are already returning early, let's return silently to
>> avoid making it seem like we failed to write the index at all.
>>
>> If we remove our dependence on the cache tree within
>> convert_to_sparse(), then we could still recover from this scenario and
>> have a sparse index.
>>
>> When constructing the cache-tree extension in convert_to_sparse(), it is
>> possible that we construct a tree object that is new to the object
>> database. Without the WRITE_TREE_MISSING_OK flag, this results in an
>> error that halts our conversion to a sparse index. Add this flag to
>> remove this limitation.
> 
> Would this only happen when the user has staged but uncommitted
> changes outside the sparsity paths, and tries to sparsify while in
> that state?  (Notably, this is a much different condition than the
> above mentioned merge conflict case that would case
> cache_tree_update() to just fail.)
> 
> I think it might be nicer to split this commit in two, just to make it
> easier to understand for future readers.  This seems like two logical
> changes and trying to understand them and why would I think be easier
> if the two were split.  I'd be tempted to put the
> WRITE_TREE_MISSING_OK first.

Ironically, I _had_ this as two commits because I discovered the
problems independently. It wasn't until I was organizing things that
I realized I was editing the same 'if' twice and thought it better
to merge patches. But I also don't feel strongly about that, so I
can split them.

>> +       /*
>> +        * Silently return if there is a problem with the cache tree update,
>> +        * which might just be due to a conflict state in some entry.
>> +        *
>> +        * This might create new tree objects, so be sure to use
>> +        * WRITE_TREE_MISSING_OK.
>> +        */
>> +       if (cache_tree_update(istate, WRITE_TREE_MISSING_OK))
>> +               return 0;
...
> These feel like cases where it would be nice to have a testcase
> demonstrating the change in behavior.  Perhaps just splitting the
> commit would be enough, but it took a bit of time to try to understand
> what would change and why, despite the simple changes.

I found these were required in the Scalar functional tests, so I bet
that if I remove this change I can create a test case from that. Thanks.

-Stolee
