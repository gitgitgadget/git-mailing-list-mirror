Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20936C6377A
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 22:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAFC760698
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 22:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhGUWJq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 18:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhGUWJp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 18:09:45 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A20C061575
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 15:50:20 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id q15so3682925qkm.8
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 15:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IV9xcOc2y7lwiqQw3LkVWv1HgZ6zwkl94CrW1vgFFQM=;
        b=ujcEzP6gqrkXn7qvsTq77RmGrZYZw9VpkgEDzYp84jyn3SKcfq7LLzo8WAMgi/EfFT
         RpNM+Ja8A6STscCP5SBkukVwVc+G9zo2wCZI92GYK1C6RVqACRrtZ1akJvNzND4k3f2s
         l4GhX55jUxtE1DmsWSdymQe3yU/DcUuy4BrY/AwbD6skXL6n4TZIoynL5xvXPlbsRY4g
         TLbH/BRoswO3tdNccXwqQKYwZV+Ev7V1iek8yPHoHFEL4XoaY7ysNRwTP9IwdlcyH1de
         bxgz8vms570qmXwhZUYODxskQXkN2pdkzt1LZLBipO5SJLePaZAFfyjeYi1/Nnq4v22c
         XNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IV9xcOc2y7lwiqQw3LkVWv1HgZ6zwkl94CrW1vgFFQM=;
        b=YHJA4C/HvXfwe8XHr9Zq7exP+Hl8TMqxV5l73/ATlwDPFnEvORCD2A0x6co8ZE/htr
         87GHoYWF3Gyi1juR70er9MwM8r4vmHBXDjx2BpgDHcXfOVlgixzaovWfNDHpqFdJ6rG2
         uJhm6IQY2tyQS9hfpgSupkgRO5x2UUqj0fuH+t0Lg9oLtELi5feo6bDvU26GsL04jV/e
         Y3NPMwny405nsmyRUpTlQZVs0uEA67D+DdhOhjAfnG02nEroIB6Rm7TdHoqTGPyvz/Zw
         uVjfR0oRuiF7NXbFQMJ/jlEsVXRi+Be5cAGeX2gwChGIJQMTLavHoXW38glMgYJpxn1A
         0ncA==
X-Gm-Message-State: AOAM53189JCtCSdpVNcYbhwbp9jqDqdrAaRX9tQSF5upVi2y37Vsf38E
        ad4lRrGhfc8to/p8ayJhXyQ=
X-Google-Smtp-Source: ABdhPJzQr0JnHBG+pwaTabgvXemDOUtAcNf6+y6hoUAX72qjaQih63H1Eaf6b34tUG/3OUEQ+qP27w==
X-Received: by 2002:a05:620a:b4a:: with SMTP id x10mr37218376qkg.496.1626907819692;
        Wed, 21 Jul 2021 15:50:19 -0700 (PDT)
Received: from Derricks-MBP.attlocal.net ([2600:1700:e72:80a0:ced:1371:aa8d:4e71])
        by smtp.gmail.com with ESMTPSA id w185sm12089018qkd.30.2021.07.21.15.50.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 15:50:19 -0700 (PDT)
Subject: Re: [PATCH 2/5] add: allow operating on a sparse-only index
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, matheus.bernardino@usp.br,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.999.git.1626901619.gitgitgadget@gmail.com>
 <791c6c2c9ade5b065fc0f367e00c52a493d086ef.1626901619.git.gitgitgadget@gmail.com>
 <xmqqfsw7cnsv.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1c7170b3-c7e3-8cb6-0cb9-5dc96c7e7ce1@gmail.com>
Date:   Wed, 21 Jul 2021 18:50:17 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <xmqqfsw7cnsv.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/21/21 6:19 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> Disable command_requires_full_index for 'git add'. This does not require
>> any additional removals of ensure_full_index(). The main reason is that
>> 'git add' discovers changes based on the pathspec and the worktree
>> itself. These are then inserted into the index directly, and calls to
>> index_name_pos() or index_file_exists() already call expand_to_path() at
>> the appropriate time to support a sparse-index.
> 
> OK.  With that explained, it still is quite surprising that we only
> need this change (eh, rather, doing this change is safe without
> doing anything else).

Yes, all of the hard work was done by the earlier work to expand
a sparse index when we search for a specific path that lands
within a sparse directory. See 95e0321 (read-cache: expand on query
into sparse-directory entry, 2021-04-01) for the specifics.

>> -	# This "git add folder1/a" fails with a warning
>> -	# in the sparse repos, differing from the full
>> -	# repo. This is intentional.
>> -	test_sparse_match test_must_fail git add folder1/a &&
>> -	test_sparse_match test_must_fail git add --refresh folder1/a &&
>> -	test_all_match git status --porcelain=v2 &&
> 
> And nice to see a known limitation lifted.

Thank you for pointing this out. This actually starts to _fail_ now
that we allow sparse indexes in 'git add', but it's because the error
messages don't match, not that the 'test_must_fail' is violated.

Patch 4 adds a similar test that is then set to work in patch 5. That
allows us a clear way to describe the behavior change and to motivate
the fix in patch 5. This could be explained better, perhaps by merging
Patch 4 into this one. That helps describe how this specific case
changes behavior (for the worse) in this patch, but is handled in a
careful way later, once the behavior change is documented.

If there is a better way to reorganize these patches, then I could
try another approach.

Thanks,
-Stolee

