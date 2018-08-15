Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F72F1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 21:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbeHOX73 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 19:59:29 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:37684 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbeHOX73 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 19:59:29 -0400
Received: by mail-qt0-f179.google.com with SMTP id n6-v6so2821477qtl.4
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 14:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Jfyi8UY2CtqimJZetV8jY9Wf9WYMBdEfnoX0mmNaYHA=;
        b=eFMtt2ND0CaVf0FxBr3Yrl3P85tsPgE7ThOnxdQGEPuTod7cjXqCw/myttikh3x0fU
         pCdfGZPgm6gulKY+t+lSFudIbCx/pJX9SbW4LqNSfnAxuUxIXdU+BNSw7AIVv1MCbOfg
         mQzkKz1nL1nFvtEw8sjzKdojuv/qnMG3/MkOjHRPNXCNVHx9FHLVKrTMbYx24uWmC/0Z
         dYDMu9UoItJbmQangswlmvQKeuWh+7FU55CSp20F0i5xeWAL1kPKfS8VokA8TIVYkfrN
         1Shf726cSxhl+/O3nGvO6YOWGz/BCeS7CDPd07YKm+q7S3W1VrIBs4wja2B+OYsQL1Ej
         qO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jfyi8UY2CtqimJZetV8jY9Wf9WYMBdEfnoX0mmNaYHA=;
        b=i0u+5L2PwUKceK30gfwUiV9We8AGXxBfvkbh4exlj8LovycSC4SiLNQLER7lss1jzd
         dDHJBZ+2TCP0sygyw23XPbpFKnzjCLPmpB8hZ003RSQlJ41h2+jzDgvmCa1ymhiahUgZ
         lyCjj+CMOjaAPykL15CdYossNzz0tuncD/pnrQb91DEDWjcMxGzOeNXyJ2tqoZfS0JD/
         3uKKUvgYf1C1MFyJ848Ile/uJS+2ZEwTKMEERAwx+cUSYwK8W+Ekhot8Dh2znGEQbcik
         gEIzb4lltTsAycDqoEvJ/i7qRrDgzpf4HKwQ/lj1zZ21sCVCaqFRVxi+M8b3B9jZutfB
         qqZA==
X-Gm-Message-State: AOUpUlHM2Or6CZvG/SdBGbpJSKNVy2001OXSQYJxUIXoxa63nIgbRNGy
        RYjh9TU1mWg31EfKltdqoatahglv
X-Google-Smtp-Source: AA+uWPxskpJhxaHcQoYJskOYeFemh79J24CE0OZDAYEBnfkfX2lDtgkzmOVM40VAIG9ruMKrUxnvPg==
X-Received: by 2002:a0c:87e5:: with SMTP id 34-v6mr23522008qvk.30.1534367138038;
        Wed, 15 Aug 2018 14:05:38 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id t27-v6sm16388456qkl.11.2018.08.15.14.05.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 14:05:37 -0700 (PDT)
Subject: Re: [PATCH v2] checkout: optimize "git checkout -b <new_branch>"
From:   Ben Peart <peartben@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20180724180122.29212-1-benpeart@microsoft.com>
 <20180731163909.19004-1-benpeart@microsoft.com>
 <CACsJy8DMEMsDnKZc65K-0EJcm2udXZ7OKY=xoFmX4COM0dSH=g@mail.gmail.com>
 <3900401c-4d7b-233c-2098-9771a06ec0dd@gmail.com>
 <20180803155838.GA13512@duynguyen.home>
 <21ac52cb-6a23-01c7-c593-59bd86ebca52@gmail.com>
Message-ID: <d15a36bc-96a8-5d92-5e41-23d726535cf3@gmail.com>
Date:   Wed, 15 Aug 2018 17:05:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <21ac52cb-6a23-01c7-c593-59bd86ebca52@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/6/2018 10:25 AM, Ben Peart wrote:
> 
> 
> On 8/3/2018 11:58 AM, Duy Nguyen wrote:
>> On Thu, Aug 02, 2018 at 02:02:00PM -0400, Ben Peart wrote:
>>>
>>>
> 
>> But if you still want to push it further, this is something I have in
>> mind. It probably has bugs, but at least preliminary test shows me
>> that it could skip 99% work inside unpack_trees() and not need to
>> write the index.
>>
>> The main check to determine "checkout -b" is basically the new
>> oidcmp() in merge_working_tree(). Not sure if I miss any condition in
>> that check, I didn't look very closely at checkout code.
>>
> 
> Thanks Duy.  I think this is an interesting idea to pursue but... when I 
> tried running this patch on a virtualized repo it started triggering 
> many object downloads.  After taking a quick look, it appears that 
> CE_UPDATE is set on every cache entry so check_updates() ends up calling 
> checkout_entry() which writes out every file to the working tree - even 
> those supposedly skipped by the skip-wortree bit.  Oops.
> 
> Not too surprising (you did say it probably has bugs :)) but it means I 
> can't trivially get performance data on how much this will help.  It 
> also fails a lot of tests (see below).
> 
> It experience does highlight the additional risk of this model of 
> changing the underlying functions (vs the high level optimization of my 
> original patch).  In addition, the new special cases in those 
> lower-level functions do add additional complexity and fragility to the 
> codebase.  So, like most things, to me it isn't a clear better/worse 
> decision - it's just different.  While I like the idea of general 
> optimizations that could apply more broadly to other commands; I do 
> worry about the additional complexity, amount of code churn, and 
> associated risk with the change.
> 
> When I have cycles, I'll take a look at how to fix this bug and get some 
> performance data.  I just wanted to give you a heads up that I'm not 
> ignoring your patch, just that it is going to take additional time and 
> effort before I can properly evaluate how much impact it will have.
> 

Now that the unpack-trees and cache-tree optimizations are settling 
down, I took a look at this proposed patch again with the intent of 
debugging why so many tests were broken by it.

The most obvious first fix was for all the segment faults when 
dereferencing a NULL pointer.  Adding an additional test so that we only 
perform the optimization when we actually have commit ID's to compare 
fixed a bunch of the test failures.

The next fix was to resolve all the breaks caused by applying this 
optimization when sparse-checkout is turned on.  Since we are skipping 
the logic to update the skip-worktree bit, I added an additional test so 
that we only perform the optimization when sparse checkout is not turned 
on.  Of course, this does completely remove the optimization when using 
sparse checkout so it isn't a workable permanent solution but it let me 
make progress.

There are still test failures with submodules and partial clone.  I 
haven't found/added the necessary tests to prevent those breaks nor the 
few other remaining breaks.

My current set of tests looks like this:

	if (!core_apply_sparse_checkout &&
		old_branch_info->commit &&
		new_branch_info->commit &&
		!oidcmp(&old_branch_info->commit->object.oid,
			&new_branch_info->commit->object.oid)) {

While I'm sure I could find and add additional tests to handle the 
remaining bugs, the net result is starting to look as fragile as the 
original patch.

Unfortunately it has the additional downsides of 1) being at a much 
lower level where we risk breaking more code paths and 2) not being 
nearly as much savings (with the original patch checkout -b <new branch> 
takes 0.3 seconds, this patch will make it take >4 seconds.)

Net, net - I don't think this particular path is a better path to pursue.

I understand the concern with the fragility of the current patch and 
it's set of tests to determine if the optimization is valid.  I also 
understand the concern with the potential change in behavior (ie not 
showing the local changes - even though nothing has changed).  Other 
than switching the optimization back to be "opt-in" via a config flag, I 
don't currently have a great answer.  I'll keep thinking and looking but 
am open to suggestions!



> Test Summary Report
> -------------------
> ./t1011-read-tree-sparse-checkout.sh               (Wstat: 256 Tests: 21 
> Failed: 1)
>    Failed test:  20
>    Non-zero exit status: 1
> ./t1400-update-ref.sh                              (Wstat: 256 Tests: 
> 170 Failed: 73)
>    Failed tests:  40, 42-45, 55-59, 70, 72, 82, 85, 87-88
>                  90-100, 103-110, 113-119, 127, 129-130
>                  132-133, 136-137, 140-147, 150-157, 160-166
>                  170
>    Non-zero exit status: 1
> ./t2011-checkout-invalid-head.sh                   (Wstat: 256 Tests: 10 
> Failed: 5)
>    Failed tests:  3, 6-7, 9-10
>    Non-zero exit status: 1
> ./t2015-checkout-unborn.sh                         (Wstat: 256 Tests: 6 
> Failed: 3)
>    Failed tests:  2-4
>    Non-zero exit status: 1
> ./t2017-checkout-orphan.sh                         (Wstat: 256 Tests: 13 
> Failed: 7)
>    Failed tests:  7-13
>    Non-zero exit status: 1
> ./t3033-merge-toplevel.sh                          (Wstat: 256 Tests: 13 
> Failed: 11)
>    Failed tests:  3-13
>    Non-zero exit status: 1
> ./t3200-branch.sh                                  (Wstat: 256 Tests: 
> 139 Failed: 2)
>    Failed tests:  137-138
>    Non-zero exit status: 1
> ./t5616-partial-clone.sh                           (Wstat: 256 Tests: 13 
> Failed: 1)
>    Failed test:  4
>    Non-zero exit status: 1
> ./t5516-fetch-push.sh                              (Wstat: 256 Tests: 90 
> Failed: 1)
>    Failed test:  34
>    Non-zero exit status: 1
> ./t6300-for-each-ref.sh                            (Wstat: 256 Tests: 
> 205 Failed: 9)
>    Failed tests:  189-196, 199
>    Non-zero exit status: 1
> ./t7114-reset-sparse-checkout.sh                   (Wstat: 256 Tests: 3 
> Failed: 2)
>    Failed tests:  2-3
>    Non-zero exit status: 1
> ./t7063-status-untracked-cache.sh                  (Wstat: 256 Tests: 50 
> Failed: 1)
>    Failed test:  23
>    Non-zero exit status: 1
> ./t7201-co.sh                                      (Wstat: 256 Tests: 38 
> Failed: 33)
>    Failed tests:  4, 6-27, 29-38
>    Non-zero exit status: 1
> ./t7409-submodule-detached-work-tree.sh            (Wstat: 256 Tests: 2 
> Failed: 1)
>    Failed test:  1
>    Non-zero exit status: 1
> ./t9350-fast-export.sh                             (Wstat: 256 Tests: 37 
> Failed: 1)
>    Failed test:  12
>    Non-zero exit status: 1
> ./t9903-bash-prompt.sh                             (Wstat: 256 Tests: 65 
> Failed: 52)
>    Failed tests:  4, 6-10, 14-34, 36, 39-51, 53-62, 65
>    Non-zero exit status: 1
> Files=834, Tests=19658, 2081 wallclock secs (10.42 usr 15.09 sys + 
> 1082.56 cusr 3530.46 csys = 4638.53 CPU)
> Result: FAIL
> 
> 
