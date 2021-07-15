Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C05C47E48
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 15:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE27861278
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 15:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238127AbhGOPM4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 11:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237940AbhGOPM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 11:12:56 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1519C06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 08:10:02 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id z1so5324975ils.0
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 08:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lCM+bGHt161QMDhOhu53jLm2e+AQ4z+kL+bXSMmrpeI=;
        b=lS9TpHJrwCW86YVctgcECpAD6d14ZJ+crmR85iKe6okojEhBvPMgpLi6ppy0goh2l+
         1AybbOpUMQucRfzrq8wint7M8UJqnzI36gtVl6J083s9PxhXx39blq1mUvH4CP6QlX3X
         Ii4YdrmyYAeqFzAWPdzj3bgbzUewr4/sBeFl301+VyQeo0mqEIqvmlt3xxDn9dlDttgC
         D5gkQw5Mw2szhUxWPyr39hX/UC1i5ZXwUGQDpjh7qRSvbpwE9zvsL0Lkn0RGerJZH3nt
         5xip9jtuRE/C43OKCr8D9WPzPY5j8YkvWnjdTX58Urke72Lt2QeHjgQIJyit1sJkQ/fP
         xh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lCM+bGHt161QMDhOhu53jLm2e+AQ4z+kL+bXSMmrpeI=;
        b=o7Tm7jh2wZ02RpgJV2OxOQk+zVT04LLCn9tN8tj8xoOU9RBCB+GaWweh6N2w0TIIuO
         5nIJBveeDwV3cX4Mh5Y8dS5zhyJQ4qJIMZNANk9VvLzQwDvErfpCwmIJ7r8xJUd5zkro
         tyWHodOSYavBgg8dgdu8T5QDM3bLQfhWNNF5CY/+dNZANzLc4aBwMIS2zNDB6Zzwkrqx
         y7iMFd/Zi1gZWYjnczTvgwEuDMJlPJ9KOFR6URLUeTOkKxw0gwZ8/ECHFuU+sezbw+g/
         8bf4UaDaCzz+MbsRE7OHxYYsY/01P0aTCwJOZQ3JyzPlnyhkxYlEpHQGb0l6QvgwTXRQ
         cnVA==
X-Gm-Message-State: AOAM533mJfNcc3bSmUf8HeW2poGehK/EgW8Ou/20/yMBPoCIQue2lR2o
        W/a5Voayv+TrqMTNFxUAmAw=
X-Google-Smtp-Source: ABdhPJyeGtTq8r0LzMDyTlziMaUGw2mRvf2fOmfXMeuvcFVJbmRoYR+3xIOuUyX6Z9EhHIyU6eeaGg==
X-Received: by 2002:a05:6e02:d41:: with SMTP id h1mr2864944ilj.191.1626361802070;
        Thu, 15 Jul 2021 08:10:02 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:b51d:31f1:a0d6:7fc2? ([2600:1700:e72:80a0:b51d:31f1:a0d6:7fc2])
        by smtp.gmail.com with ESMTPSA id i2sm3159372ilq.83.2021.07.15.08.10.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 08:10:01 -0700 (PDT)
Subject: Re: [PATCH v2 7/7] merge-ort: restart merge with cached renames to
 reduce process entry cost
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.988.git.1625111177.gitgitgadget@gmail.com>
 <pull.988.v2.git.1626204784.gitgitgadget@gmail.com>
 <7133f0efa520b3d0cadb059151daa12484fdb003.1626204784.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d91ed8a0-b37b-7dfa-10bf-e068f30e9691@gmail.com>
Date:   Thu, 15 Jul 2021 11:09:59 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <7133f0efa520b3d0cadb059151daa12484fdb003.1626204784.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/13/2021 3:33 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
...
> Often, I noticed that when the optimization does not apply, it is
> because there are a handful of relevant sources -- maybe even only one.
> It felt frustrating to need to recurse into potentially hundreds or even
> thousands of directories just for a single rename, but it was needed for
> correctness.
> 
> However, staring at this list of functions and noticing that
> process_entries() is the most expensive and knowing I could avoid it if
> I had cached renames suggested a simple idea: change
>    collect_merge_info()
>    detect_and_process_renames()
>    process_entries()
> into
>    collect_merge_info()
>    detect_and_process_renames()
>    <cache all the renames, and restart>
>    collect_merge_info()
>    detect_and_process_renames()
>    process_entries()
> 
> This may seem odd and look like more work.  However, note that although
> we run collect_merge_info() twice, the second time we get to employ
> trivial directory resolves, which makes it much faster, so the increased
> time in collect_merge_info() is small.  While we run
> detect_and_process_renames() again, all renames are cached so it's
> nearly a no-op (we don't call into diffcore_rename_extended() but we do
> have a little bit of data structure checking and fixing up).  And the
> big payoff comes from the fact that process_entries(), will be much
> faster due to having far fewer entries to process.

I enjoyed the story you tell here.

> +	if (path_count_after) {
> +		/*
> +		 * Not sure were the right cut-off is for the optimization
> +		 * to redo collect_merge_info after we've cached the
> +		 * regular renames is.  Basically, collect_merge_info(),
> +		 * detect_regular_renames(), and process_entries() are
> +		 * similar costs and all big tent poles.  Caching the
> +		 * result of detect_regular_renames() means that redoing
> +		 * that one function will cost us virtually 0 extra, so it
> +		 * depends on the other two functions, which are both O(N)
> +		 * cost in the number of paths.  Thus, it makes sense that
> +		 * if we can cut the number of paths in half, then redoing
> +		 * collect_merge_info() at half cost in order to get
> +		 * process_entries() at half cost should be about equal
> +		 * cost.  If we can cut by more than half, then we would
> +		 * win.  The fact that process_entries() is about 10%-20%
> +		 * more expensive than collect_merge_info() suggests we
> +		 * could make the factor be less than two.  The fact that
> +		 * even when we have renames cached, we still have to
> +		 * traverse down to the individual (relevant) renames,
> +		 * which suggests we should perhaps use a bigger factor.
> +		 *
> +		 * The exact number isn't critical, since the code will
> +		 * work even if we get the factor wrong -- it just might be
> +		 * slightly slower if we're a bit off.  For now, just error
> +		 * on the side of a bigger fudge.  For the linux kernel

super-nit: s/linux/Linux/

> +		 * testcases I was looking at with massive renames, the
> +		 * ratio came in around 50 to 250, which clearly would
> +		 * trigger this optimization and provided some *very* nice
> +		 * speedups.

This bit of your testing might be more appropriate for your commit
message. This discussion of a test made at a certain point in time
is more likely to go stale than the description of how this factor
does not change correctness, only performance.

> +		 */
> +		int wanted_factor = 3;

and perhaps make it 'const'?

> +
> +		/* We should only redo collect_merge_info one time */
> +		assert(renames->redo_after_renames == 0);
> +
> +		if (path_count_after / path_count_before > wanted_factor) {

With truncation from integer division, this condition is equivalent* to

	path_count_after >= 4 * path_count_before

Or, do you want to change this to a ">=" so that the factor of 3 seems
more accurate?

*I understand the intention of using division to avoid (unlikely)
overflow via multiplication. The truncation is causing some confusion.
  
> -test_expect_merge_algorithm failure failure '12f: Trivial directory resolve, caching, all kinds of fun' '
> +test_expect_merge_algorithm failure success '12f: Trivial directory resolve, caching, all kinds of fun' '
>  	test_setup_12f &&
>  	(
>  		cd 12f &&
> 

Oh, and a bonus test success! Excellent.

Thanks,
-Stolee
