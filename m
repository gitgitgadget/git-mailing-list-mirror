Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28662C433F5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 10:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0470E61373
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 10:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbhJDKB7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 06:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbhJDKB7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 06:01:59 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457DEC061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 03:00:10 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r10so13277023wra.12
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 03:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yuq/AQNIiHFUWd42936vfu7x0rP4mnIfj1D+dEhVA7k=;
        b=ZRCAaYFT9T5gWs8J+oNyzx/4S67JCb8x8tN7Xp+gFDPQBQhR/dkBdTNQyysYLYPxfF
         6rle5td9Xz+vCgtyjTL1SdXLfZ9CEgYSOyFL81KLuQ7FgIBUVX97FwZoJJFd2Z+r8yZe
         HA1G7/aVd40z7HUS16M86pBfIeE4tJJNqCihmWkhV5rGoIEZksabn+AxHvk2Zc/5i41C
         TIX2Ni57THQYtluS0CuCopZT0i+cHLqnhwg7H65jrpFn14wb7qgLLX2Tp/ki8Cf897Yy
         Wn66wYYy2vjVb6wQ2ocSslo3qH7N+C3xLOeKVOO8J8o2IklhiKV5ozcuS7PWJ5XP2N+6
         abwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yuq/AQNIiHFUWd42936vfu7x0rP4mnIfj1D+dEhVA7k=;
        b=rDNUEoaYSR1CzfAL3BV/637ibAwwyy7LoGjee+tPqHyEGoeuoulRM7ajJWnPceXuB4
         hiN/RzonPMgWr8A9KGapv91EbRSHJ249drcSN8xU6I/JU+zrfNVJrnffsbpgY1l+dxyo
         DDdhQKw0MLiVQhn2BiTfzqRLMGko+cC0cWyHLOETmvLj0A6QL3Wkg9b3DYr/m34g+vEF
         siXt2DbpgQCcDvEVy0RGRkerycIrTlenptHeTzJVr+8rXZX44hYA2bTZpaeGVmogowi7
         ZpmYEfgLCXwd3Z6FW+Vytpog89jx1tpI5sJLYQ+x930EfCjeqCFizO+mma9WY5jNNQfi
         kZXw==
X-Gm-Message-State: AOAM532XSjBMR9l84luz5b4eGogTJ+nsig3CgdBud70z/rS2dSPFr1VS
        86T2zOncqurxI6wWFaRE1TI=
X-Google-Smtp-Source: ABdhPJyoJ2kIKbnTV/LAeNJX+mXWszj2mgK7wQxOeWm/N7ymwPdjoovSzK0Q/WU9sdrtMOM0mGTwLg==
X-Received: by 2002:adf:a34c:: with SMTP id d12mr12550466wrb.267.1633341608889;
        Mon, 04 Oct 2021 03:00:08 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.gmail.com with ESMTPSA id r27sm13728895wrr.70.2021.10.04.03.00.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 03:00:08 -0700 (PDT)
Message-ID: <b298f8cb-f55f-86f0-52fc-8d9db0047525@gmail.com>
Date:   Mon, 4 Oct 2021 11:00:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 03/11] reset_head(): don't run checkout hook if there is
 an error
Content-Language: en-GB-large
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
 <28872cbca687b057663a4e3408cb94d69fb60f94.1633082702.git.gitgitgadget@gmail.com>
 <xmqqtui05uxr.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqtui05uxr.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 01/10/2021 21:52, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> The hook should only be run if the worktree and refs were successfully
>> updated.
> 
> OK.  This is a behaviour change visible to end-users, and deserves a
> mention in the release notes.
> 
>   - When "git rebase" attempted to check out a branch (or detached

It only affects "git rebase --apply" as the "merge" backend forks "git 
checkout" which does not run the hook if it cannot update the worktree 
or refs.

>     the HEAD) to work on, we used to always call the "post-checkout"
>     hook, even if the checkout failed to update the ref.  The hook is
>     no longer called if the checkout fails.
> 
> or something.
> 
> Again, can the bug this step fixes be protected with a new test in
> t/ please?

I'll try and come up with something - it should be possible to arrange 
an untracked file to make unpack_trees() to fail, I'm not sure how we'd 
make update_ref() fail

Best Wishes

Phillip

>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>   reset.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/reset.c b/reset.c
>> index fc4dae3fd2d..5abb1a5683e 100644
>> --- a/reset.c
>> +++ b/reset.c
>> @@ -125,7 +125,7 @@ reset_head_refs:
>>   			ret = create_symref("HEAD", switch_to_branch,
>>   					    reflog_head);
>>   	}
>> -	if (run_hook)
>> +	if (!ret && run_hook)
>>   		run_hook_le(NULL, "post-checkout",
>>   			    oid_to_hex(orig ? orig : null_oid()),
>>   			    oid_to_hex(oid), "1", NULL);
