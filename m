Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7E7C11F66
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 12:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9465C61D1C
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 12:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbhF2M6F (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 08:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbhF2M6A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 08:58:00 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BA0C061768
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 05:55:33 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id k206so7257265oif.2
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 05:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7U3t7BA66xNgTWP0lvJA7pQ9KYV8qUd3WHJeAcqSDdc=;
        b=ovLJila/gt8LLH1dvf/AdwOre6zIk8f0hFXqWc14u6qPxG0WqjaXzQ2bDqDjv7kVwa
         6m8T32CJBNHyE/TGTIrY4f+bQCwgjUNtK2qeiIwppruNTi/Go4P1l4PLLdhogLTsKO/m
         fzs4rXRa9ZDQ8qbZhmIxkMogI88P5mp0FFjpQFbPmBzKI9vMCq9otXPx8QQzvs9Ibyqh
         9b2/RPzqdt9nlJNo8vMK6Gxjp777uNmTT/uoFBevLzaVUC9roELGQiIKatJvCdzXbR3i
         klkpTWM8ui2nVmPnk6ahtJc8lH9bL6UmBqAS1ESZ++g+RH9UrRXrTQv9T2l+hQqCsMFi
         UmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7U3t7BA66xNgTWP0lvJA7pQ9KYV8qUd3WHJeAcqSDdc=;
        b=ukKh7DQSZI7y27jCmE+myWUWIoqEF0/D2TkNJfWV4GbDQLWSuKHQDyxgsdbyBPpXCt
         Z0niNz8QcawIJBYnkXks7mBo5H9fsGoiag8DdSIdYw5+h2ajGmd8/8t1vjFQ7/a+vMeq
         RegzB4dtAsbRmIi4Gwq5ElGBs9nC/4S0QW1JZ1whTvhF2VYlNGQGtktQ11hZGJqv++uS
         KGfKKlRW8P9w5QHa3TI2swQ0QQHQfYN2Y6iESPrU04rAMBIAw+jEmBt6oXlVFwtse6cl
         jLF98Oe6jgJMUShZclUWLwg6MabqxSSTEHIU+LN4s5gdVpToRVDs8jkE4uTOSWRpqo7A
         PN1A==
X-Gm-Message-State: AOAM532lf6EABnFHOTIOM8yMoIX2b1Y1MPq5TDeqe4JHQnEeP10hqyGl
        NWkyrzL2v5Jj+8CQRmxPpdE=
X-Google-Smtp-Source: ABdhPJwTNVzzvzS7s7M+efsm8v5QwjBFCiaJlflQo9oYVV0nevQWtMbE8k1csj9mHNCCpUPbuObPlA==
X-Received: by 2002:aca:c43:: with SMTP id i3mr24668093oiy.124.1624971332648;
        Tue, 29 Jun 2021 05:55:32 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:a008:8d1a:199e:a08b? ([2600:1700:e72:80a0:a008:8d1a:199e:a08b])
        by smtp.gmail.com with ESMTPSA id m1sm338552otl.0.2021.06.29.05.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 05:55:31 -0700 (PDT)
Subject: Re: [PATCH 3/3] merge-recursive: handle rename-to-self case
To:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
References: <pull.1039.git.git.1624727121.gitgitgadget@gmail.com>
 <dea97c25e52c0c5dcba7698cdc2af742344fe36d.1624727122.git.gitgitgadget@gmail.com>
 <xmqqeecl1foi.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7854e7b7-f128-e389-cc06-8b599c7b3e32@gmail.com>
Date:   Tue, 29 Jun 2021 08:55:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <xmqqeecl1foi.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/29/2021 12:02 AM, Junio C Hamano wrote:
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Elijah Newren <newren@gmail.com>
>>
>> Directory rename detection can cause transitive renames, e.g. if the two
>> different sides of history each do one half of:
>>     A/file -> B/file
>>     B/     -> C/
>> then directory rename detection transitively renames to give us
>>     A/file -> C/file
>>
>> However, when C/ == A/, note that this gives us
>>     A/file -> A/file.
> 
> Heh, of course this is recent because the "guess that directory B
> has been moved to C in its entirety" heuristic is quite new.
> 
> Nicely fixed and described.  Will queue.  Thanks.

I agree that the fixes in patches 2 and 3 are rather clean. The
tests added in patch 1 provide significant confidence in the
result, though I had a minor question about a possible third
test case.

Seeing the solutions that make the two tests pass leaves me to
consider that the third test case is likely unnecessary, because
there is nothing special about how the directories are being
renamed that must be handled by the fix.

Thanks,
-Stolee
