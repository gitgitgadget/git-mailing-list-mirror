Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC8BC4338F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 18:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E364561042
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 18:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbhHRSwe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 14:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhHRSwe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 14:52:34 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE18C061764
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 11:51:59 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id r26so4799120oij.2
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 11:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rXi9Ms2Kf5htg3fGhqfjU1m8JilYsg3D6wZPldll1cQ=;
        b=Cszk+/0HgLzd0OkOHnQFo1BjK0cBgQmkGDB5EFLBcql2Z5bbK7NBwZDj2w9AKz432n
         2tctiJZOONExk7X0pDJvz83nlGqsIa0I93NYgQHTerbXwXMgDkw6BahI1qBrRiboSYTs
         Bajda0YyAtxXvTmEqT086GR2UNxhW7L4Z6j/bBES5KHqvWeShFLcoTqBJhNzCmK2epBp
         DUx6XrbjjxUGla/KrxNN++k7kGqTVY6mSbguhdpLGtZeI2cxwRljYCZBDsJHkov7Rfi6
         AuTBeNS6tSVyg4lBmoFaSMAxWXIozBjElkceAWeVmBmjmy92T0N9H1Y/EARW9nCcvoJf
         qYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rXi9Ms2Kf5htg3fGhqfjU1m8JilYsg3D6wZPldll1cQ=;
        b=plq6y4nr8DbmoPjmaKJ5WiJmDAidpeJX1CMMhR6l1hgETkXKm4TGJny93eu1Z9uD+q
         /kqtHSfZDAVPjT0NTcBBkSh0wdkp8UiiqGCVAZJEqCATjDgDUUyVAfUj3fkUtmm/6W85
         A+xfi+EtBOLw1QdY7cw6qDScwuKjP3+nVMIy3tc0A6H7WZ0h2JL6kcJKPe9kYs1gL8jS
         f6ubWMa20kQmkSG9NLC61DjQgX6MpnW9YDFp7tICMQTycsfQ3YQKpvY9+3O8YtRjvCsd
         lz8o9Mh6g3nWW+FVNLS9FjWnIMgjqCko3muID7qSyMujNvo2Jz5GqLc1nMjMKrAgFVl5
         OxSg==
X-Gm-Message-State: AOAM5315R3q7JM8BfhEwbNerFKxEafebCKMJ72oKIMNhG7D++I55JfIh
        Dv+mcw8wM5NYwxhnjeTI0W0=
X-Google-Smtp-Source: ABdhPJwcTAiO9aNanuZ9ibD0ckEZiSi+EkedlJ9yotyICTd7efqqjNfv5l/GwciRXgAlouBx2kfFpw==
X-Received: by 2002:a54:4008:: with SMTP id x8mr8074481oie.113.1629312718316;
        Wed, 18 Aug 2021 11:51:58 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:581d:96e0:cdbb:9c3d? ([2600:1700:e72:80a0:581d:96e0:cdbb:9c3d])
        by smtp.gmail.com with ESMTPSA id n9sm173718otn.54.2021.08.18.11.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 11:51:57 -0700 (PDT)
Subject: Re: [PATCH 5/6] tests: disable GIT_TEST_SPLIT_INDEX for sparse index
 tests
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <20210817174938.3009923-1-szeder.dev@gmail.com>
 <20210817174938.3009923-6-szeder.dev@gmail.com>
 <6f900a58-19b4-753c-18f5-852eaebc1527@gmail.com>
 <20210817213201.GD2257957@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3a683988-4ee3-65be-e1f9-cb2392e8bbe1@gmail.com>
Date:   Wed, 18 Aug 2021 14:51:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210817213201.GD2257957@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/17/2021 5:32 PM, SZEDER Gábor wrote:
> On Tue, Aug 17, 2021 at 02:26:23PM -0400, Derrick Stolee wrote:
>> On 8/17/2021 1:49 PM, SZEDER Gábor wrote:
>>> The sparse index and split index features are said to be currently
>>> incompatible [1], and consequently GIT_TEST_SPLIT_INDEX=1 might
>>> interfere with the test cases exercising the sparse index feature.
>>> Therefore GIT_TEST_SPLIT_INDEX is already explicitly disabled for the
>>> whole of 't1092-sparse-checkout-compatibility.sh'.  There are,
>>> however, two other test cases exercising sparse index, namely
>>> 'sparse-index enabled and disabled' in
>>> 't1091-sparse-checkout-builtin.sh' and 'status succeeds with sparse
>>> index' in 't7519-status-fsmonitor.sh', and these two could fail with
>>> GIT_TEST_SPLIT_INDEX=1 as well [2].
>>>
>>> Unset GIT_TEST_SPLIT_INDEX and disable the split index in these two
>>> test cases to avoid such interference.
>>>
>>> Note that this is the minimal change to merely avoid failures when
>>> these test cases are run with GIT_TEST_SPLIT_INDEX=1.  Interestingly,
>>> though, without these changes the 'git sparse-checkout init --cone
>>> --sparse-index' commands still succeed even with split index, and set
>>> all the necessary configuration variables and create the initial
>>> '$GIT_DIR/info/sparse-checkout' file, but the test failures are caused
>>> by later sanity checks finding that the index is not in fact a sparse
>>> index.  This indicates that 'git sparse-checkout init --sparse-index'
>>> lacks some error checking and its tests lack coverage related to split
>>> index, but fixing those issues (let alone making sparse index
>>> comparible with split index) is beyond the scope of this patch series.
>>
>> s/comparible/compatible.
>>
>> I agree that making these two things compatible is not something to
>> solve today. I'm not sure they should _ever_ be solved because of
>> the complexity involved (what if the base index is not sparse but
>> the tip wants to be, or vice-versa?,
> 
> I think that this's not an issue, because a shared index file is not
> for forever, but it's expected that a new shared index is written
> every once in a while anyway, see splitIndex.maxPercentChange.  So
> whenever sparse index gets enabled/disabled we could just write a new
> shared index accordingly.  Maybe even when the sparse patterns change,
> if necessary.
> 
>> or if a directory must be expanded because of a conflict?).
> 
> I'm not quite up-to-date in sparse index terminology, so I'm not sure
> that this means...  but as mentioned above we can just write a new
> shared index when deemed necessary.
> 
>> They use very different approaches
>> to solve a similar problem: how to deal with large index files.
>>
>> * The split index reduces index _write_ time by only editing a diff
>>   of the base index.
>>
>> * The sparse index reduces index _read and write_ time by writing a
>>   smaller index, but only if the user is using cone mode sparse-
>>   checkout.
> 
> Yeah, I think that in general there is more to be gained with sparse
> index than with split index, though the split index might further
> reduce the write time of a sparse index, because the amount of data
> written is proportional with the nr of changed files instead of the nr
> of all files in the sparse index.  I'm not sure that it's worth it,
> either.
> 
> My remarks about compatibility primarily stem from your remarks about
> compatibility in response to my sparse vs. split test failure report
> in:
> 
>   https://public-inbox.org/git/48e9c3d6-407a-1843-2d91-22112410e3f8@gmail.com/
> 
>   "the sparse-index is (currently) incompatible with the split-index"
> 
> I assumed that that "(currently)" implies that eventually the two will
> be made compatible.

I say "(currently)" because there is nothing stopping someone from
integrating them. I'm not sure anyone ever will.

> Anyway, I'm fine with leaving them incompatible, but 'git
> sparse-checkout' should still learn about split index, so it won't
> pretend to succeed after it couldn't do what it was asked to when
> there is a split index.  Maybe vice-versa as well.

You're saying that when 'git sparse-checkout init --cone --sparse-index'
doesn't write a sparse index because the index is already split, we
should actually die() saying "split index and sparse index are
incompatible" so the user knows why the sparse index was not enabled?
That seems reasonable for now, although it is successful in setting
the config to enable the sparse index opportunistically in the future.

>>>  test_expect_success 'sparse-index enabled and disabled' '
>>> -	git -C repo sparse-checkout init --cone --sparse-index &&
>>> -	test_cmp_config -C repo true index.sparse &&
>>> -	test-tool -C repo read-cache --table >cache &&
>>> -	grep " tree " cache &&
>>> -
>>> -	git -C repo sparse-checkout disable &&
>>> -	test-tool -C repo read-cache --table >cache &&
>>> -	! grep " tree " cache &&
>>> -	git -C repo config --list >config &&
>>> -	! grep index.sparse config
>>> +	(
>>> +		sane_unset GIT_TEST_SPLIT_INDEX &&
>>> +		git -C repo update-index --no-split-index &&
>>> +
>>> +		git -C repo sparse-checkout init --cone --sparse-index &&
>>> +		test_cmp_config -C repo true index.sparse &&
>>> +		test-tool -C repo read-cache --table >cache &&
>>> +		grep " tree " cache &&
>>> +
>>> +		git -C repo sparse-checkout disable &&
>>> +		test-tool -C repo read-cache --table >cache &&
>>> +		! grep " tree " cache &&
>>> +		git -C repo config --list >config &&
>>> +		! grep index.sparse config
>>> +	)
>>>  '
>>
>> This test is safe for now.
>>
>>>  test_expect_success 'status succeeds with sparse index' '
>>
>> This test is being edited in ds/sparse-index-ignored-files. v3
>> of the relevant patch was just sent today [1].
>>
>> [1] https://lore.kernel.org/git/e66106f7a99d94145eec983ea5e72b7cf8a8a479.1629206603.git.gitgitgadget@gmail.com/
>>
>> You might want to rebase on top of that topic. The edits to
>> the test are likely stable now.
> 
> Oh, no :)  The test 'cone mode clears ignored subdirectories' added in
> that patch series (as in 'seen', so not the newes version) fails with
> the working GIT_TEST_SPLIT_INDEX=1 as well, and I don't immediately
> see why, as it doesn't seem to use sparse index.
 
Oh interesting! This is because the index converts to a sparse index
in-memory solely so it can use the sparse directory entries to pick
which directories need to be deleted. In the presence of a split
index, convert_to_sparse() fails due to these lines:

	if (istate->split_index || istate->sparse_index || !istate->cache_nr ||
	    !core_apply_sparse_checkout || !core_sparse_checkout_cone)
		return 0;

	if (!istate->repo)
		istate->repo = the_repository;

	if (!(flags & SPARSE_INDEX_IGNORE_CONFIG)) {
		...

While this if here is checking the condition for creating it in-memory.

The fix is likely to do the following instead:

	if (istate->sparse_index || !istate->cache_nr ||
	    !core_apply_sparse_checkout || !core_sparse_checkout_cone)
		return 0;

	if (!istate->repo)
		istate->repo = the_repository;

	if (!(flags & SPARSE_INDEX_IGNORE_CONFIG)) {
		if (istate->split_index)
			return 0;
		...

and maybe even rename the flag to SPARSE_INDEX_MEMORY_ONLY or something.

Thanks for alerting me to this issue!

-Stolee
