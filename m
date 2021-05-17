Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD67DC433B4
	for <git@archiver.kernel.org>; Mon, 17 May 2021 15:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A37FF61019
	for <git@archiver.kernel.org>; Mon, 17 May 2021 15:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241064AbhEQPFn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 11:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240515AbhEQPDH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 11:03:07 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DC5C0611E2
        for <git@vger.kernel.org>; Mon, 17 May 2021 07:23:44 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id w127so2807707oig.12
        for <git@vger.kernel.org>; Mon, 17 May 2021 07:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SC9kDA27mESPmAgK9uH0ahK3NJAOlEHIxvkzzsyr9Ao=;
        b=pQFWNawZwKD66HT6v4ssjR4Z2r6LJeYNOjkxMvW9P9ddwu32aQ4UiHE0MB8TOA07hc
         y8XAIevANaMVYfw/OZihtF8s7KZEikSurapdrGRD0gK8orbz+bEqxbz402xWrlDVrid3
         Qa2Z9Uz4w+GmTVou/lYeYq6QcoLhEl/WWjzb/4NVLiWMA16mYgQINwtXh35QTPKUoQeP
         tsHAip82zkQLOSpHhf+qK6wlHkotaq2Egw5bRJYvOegeJw1STSUDmuVoEXeFDHwabtAl
         1pGTt6esLjXpz3V1ygLNXAuzUWp7fUvBDhpi0CR4c8E8o1DIHgkS4iPIl1Mz49pWXmoS
         HpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SC9kDA27mESPmAgK9uH0ahK3NJAOlEHIxvkzzsyr9Ao=;
        b=EFq7mhegh2XB+n4sT36giAJj/oyBYu8Df7ZX1ywIbLJN1/fZYvKoT0yrWexHU4jjPM
         gfqAVF2snFmm9yD4cwFlPimRuo1DiDK8pG5kGOXHJ+/wHxip7z+RTrpHAOjSfOZSHDLM
         0lBEfdUbfCND6dKF6JopoAbNpL+0NFloPLeGQ11FCe0GNXQBlqRMtOSKucj+TWF3JgLh
         9SVIiWBrCkyUZEtotE+avLIxOF+X2nnzX1/+63NGyWLf/kkQDMa+O8DZl5SFF8RE6pcR
         nnxMcicj4vezXRrgkkaZ4jHpR2o0aQuWj6k4zKXUswgF4WIGsNhlZLzeldMC1+rGRnM4
         IjtA==
X-Gm-Message-State: AOAM532Jov+oCzwM69vW8sXsyAf16voEAtNcoJmpS7RpaAkKAPWnUcyT
        egSsPV9p0TDS9bigWTEfrTKX+CAledMFyQ==
X-Google-Smtp-Source: ABdhPJxqEhIBBDeod09W6MO4F3hl1E8dkrTV+hp5BkJ/QgCyBcgUBWniYI55xdLAbbuuzLMXTt2NOg==
X-Received: by 2002:a05:6808:997:: with SMTP id a23mr57473oic.129.1621261422950;
        Mon, 17 May 2021 07:23:42 -0700 (PDT)
Received: from Derricks-MBP.attlocal.net ([2600:1700:e72:80a0:20ee:d66c:315:bb13])
        by smtp.gmail.com with ESMTPSA id v28sm3169394ood.27.2021.05.17.07.23.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 07:23:42 -0700 (PDT)
Subject: Re: [PATCH v2 13/13] merge-ort, diffcore-rename: employ cached
 renames when possible
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
References: <pull.859.git.1616621553.gitgitgadget@gmail.com>
 <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
 <91b6768adf2d1777219fb2d83cc2363f1497dbbd.1620094339.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f0c50259-5627-482b-1daf-b73819cde108@gmail.com>
Date:   Mon, 17 May 2021 10:23:41 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <91b6768adf2d1777219fb2d83cc2363f1497dbbd.1620094339.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/3/21 10:12 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
...
> diff --git a/merge-ort.c b/merge-ort.c
> index 2fc98b803d1c..17dc3deb3c73 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -753,15 +753,48 @@ static void add_pair(struct merge_options *opt,
>  	struct rename_info *renames = &opt->priv->renames;
>  	int names_idx = is_add ? side : 0;
>  
> -	if (!is_add) {
> +	if (is_add) {
> +		if (strset_contains(&renames->cached_target_names[side],
> +				    pathname))
> +			return;
> +	} else {
>  		unsigned content_relevant = (match_mask == 0);
>  		unsigned location_relevant = (dir_rename_mask == 0x07);
>  
> +		/*
> +		 * If pathname is found in cached_irrelevant[side] due to
> +		 * previous pick but for this commit content is relevant,
> +		 * then we need to remove it from cached_irrelevant.
> +		 */
> +		if (content_relevant)
> +			/* strset_remove is no-op if strset doesn't have key */
> +			strset_remove(&renames->cached_irrelevant[side],
> +				      pathname);

I see, content can become relevant again.

...

> diff --git a/t/t6429-merge-sequence-rename-caching.sh b/t/t6429-merge-sequence-rename-caching.sh
> index f47d8924ee73..035edc40b1eb 100755
> --- a/t/t6429-merge-sequence-rename-caching.sh
> +++ b/t/t6429-merge-sequence-rename-caching.sh
> @@ -101,10 +101,10 @@ test_expect_success 'caching renames does not preclude finding new ones' '
>  # dramatic change in size of the file, but remembering the rename and
>  # reusing it is reasonable too.
>  #
> -# Rename detection (diffcore_rename_extended()) will run twice here; it is
> -# not needed on the topic side of history for either of the two commits
> -# being merged, but it is needed on the upstream side of history for each
> -# commit being picked.
> +# We do test here that we expect rename detection to only be run once total
> +# (the topic side of history doesn't need renames, and with caching we
> +# should be able to only run rename detection on the upstream side one
> +# time.)
>  test_expect_success 'cherry-pick both a commit and its immediate revert' '
>  	test_create_repo pick-commit-and-its-immediate-revert &&
>  	(
> @@ -140,11 +140,11 @@ test_expect_success 'cherry-pick both a commit and its immediate revert' '
>  		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
>  		export GIT_TRACE2_PERF &&
>  
> -		test_might_fail test-tool fast-rebase --onto HEAD upstream~1 topic &&
> +		test-tool fast-rebase --onto HEAD upstream~1 topic &&

Here is a change of behavior, but it appears to be a good one!

>  		#git cherry-pick upstream~1..topic &&
>  
>  		grep region_enter.*diffcore_rename trace.output >calls &&
> -		test_line_count = 2 calls
> +		test_line_count = 1 calls
>  	)
...
> @@ -450,7 +459,7 @@ test_expect_success 'dir rename unneeded, then add new file to old dir' '
>  		#git cherry-pick upstream..topic &&
>  
>  		grep region_enter.*diffcore_rename trace.output >calls &&
> -		test_line_count = 3 calls &&
> +		test_line_count = 2 calls &&
>  
>  		git ls-files >tracked &&
>  		test_line_count = 5 tracked &&
> @@ -516,7 +525,7 @@ test_expect_success 'dir rename unneeded, then rename existing file into old dir
>  		#git cherry-pick upstream..topic &&
>  
>  		grep region_enter.*diffcore_rename trace.output >calls &&
> -		test_line_count = 4 calls &&
> +		test_line_count = 3 calls &&

I appreciate that this use of tracing demonstrates a change of
internal behavior.

>  		test_path_is_missing somefile &&
>  		test_path_is_missing olddir/newfile &&
> @@ -648,9 +657,8 @@ test_expect_success 'caching renames only on upstream side, part 1' '
>  # for the wrong side of history.
>  #
>  #
> -# This testcase should only need three calls to diffcore_rename_extended(),
> -# because there are no renames on the topic side of history for picking
> -# Topic_2.
> +# This testcase should only need two calls to diffcore_rename_extended(),
> +# both for the first merge, one for each side of history.
>  #
>  test_expect_success 'caching renames only on upstream side, part 2' '
>  	test_setup_topic_rename cache-renames-only-upstream-rename-file &&
> @@ -677,7 +685,7 @@ test_expect_success 'caching renames only on upstream side, part 2' '
>  		#git cherry-pick upstream..topic &&
>  
>  		grep region_enter.*diffcore_rename trace.output >calls &&
> -		test_line_count = 3 calls &&
> +		test_line_count = 2 calls &&

Same here.

As I was reading, I was also thinking that it would be good to
have some kind of tracing, if only a summary of how often we
relied upon the cached renames. That would present a mechanism
for the test cases to verify that the rename cache is behaving
as expected, but also provides a way to diagnose any issues that
might arise in the future by asking a user to reproduce a
problematic rebase/merge with a GIT_TRACE2* target. Such a
change would fit as a follow-up, and does not need to insert
into an already heavy patch.

I have now read all of the patches in this series to the level
I can. It's all very deep stuff, so the more we can rely on the
tests to show correctness, the better.

I appreciate the extra tests that you added, which increases my
confidence in the series.

Thanks,
-Stolee
