Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32247C433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 21:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238436AbiBOV7X (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 16:59:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbiBOV7W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 16:59:22 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7B77678
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 13:59:11 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id qx21so103718ejb.13
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 13:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=q4snD1qPq3DDemY6bz8EA4ItvxjS+HfQbXbEhfR/rIE=;
        b=fwpLvKFFoOabZkOzoWaApBfo9HsLnYWEf5GDrTUmxjDUkSqKNvKOP9iWvfEkj/Vdpz
         srm2YHdTMrQKV799X+wnWZ7CXMPShH9HAP+U1bEQ9QiQYJC7o2YO7dWCXKnlE1czKQBi
         HLb0COFKqPLBw3XoJIVxNYOVUFkRpRtX3M7c7BA9UrLMmR3OavjQQSHr5zsxNQM2MB1w
         lj1Qq8xiJ5zr9bnIyOJULXZ8BdvKrWgofcnsfMWLbTdgVoudmRE7Xmkg/yc7M43SjXnn
         3V7qto6Fn8uGUsGUWQeiIYxa76E31TfZnrwavY3oHQWX0QymbHpZFJgy2lTaMFI6Tt0n
         mObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=q4snD1qPq3DDemY6bz8EA4ItvxjS+HfQbXbEhfR/rIE=;
        b=kvDyFa4DGduWUhk30TDHG6r3HyWicieCjkp26QSxRgSFeSfIzoNjlwnMy75mwGAcFm
         ev9xP7UfZduFQmusMH0kHqXrxRqvy9Co4ZjSQ5llOBXFiohNlO0My2etG5hdFiyRQVF0
         itXiqdHcXB0Cn0A9PDvYQ2XoZUt5W9teinUSRSVbiOwAva4jGUEmX9ibIwoEZoDI7Xrt
         SSva8SzP+JYK9z5vX/u5n3pFtqjbqX57BBtPPOVEu0On9w81VUh2L90fGUokheNuw+wH
         qprWJmxH0ZYJWijAstclNFzg0JYZeDIPGNkijlnI38Gki4EHCicH7ZO9o3aBfwS2/DtN
         jsSA==
X-Gm-Message-State: AOAM530C3s5In0LvNVeOv7erzTCNM/u6JCut9cBnamDerLAiUHoQHzg+
        Sq4j1bnJS8zIylz/n9qX+Il0f+3WXC0=
X-Google-Smtp-Source: ABdhPJxxp/KCvTSl42Q+1bzXUMRwb8vZi0Ehks2AHU2A5gOo8HQY8SBO2RXYFm6lOaag+CJOgn/K7g==
X-Received: by 2002:a17:906:71d7:b0:6bb:c057:3a6 with SMTP id i23-20020a17090671d700b006bbc05703a6mr69488ejk.22.1644962349935;
        Tue, 15 Feb 2022 13:59:09 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id l1sm2712923ejb.81.2022.02.15.13.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 13:59:09 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nK5qm-002tAd-TW;
        Tue, 15 Feb 2022 22:59:08 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/9] t5526: use grep to assert on fetches
Date:   Tue, 15 Feb 2022 22:53:23 +0100
References: <20220210044152.78352-1-chooglen@google.com>
 <20220215172318.73533-1-chooglen@google.com>
 <20220215172318.73533-3-chooglen@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220215172318.73533-3-chooglen@google.com>
Message-ID: <220215.86r183x043.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 16 2022, Glen Choo wrote:

> In a previous commit, we replaced test_cmp invocations with
> verify_fetch_result(). Finish the process of removing test_cmp by using
> grep in verify_fetch_result() instead.
>
> This makes the tests less sensitive to changes because, instead of
> checking the whole stderr, we only grep for the lines of the form
>
> * "<old-head>..<new-head>\s+branch\s+-> origin/branch"
> * "Fetching submodule <submodule-path>" (if fetching a submodule)
>
> when we expect the repo to have fetched. If we expect the repo to not
> have fetched, grep to make sure the lines are absent. Also, simplify the
> assertions by using grep patterns that match only the relevant pieces of
> information, e.g. <old-head> is irrelevant because we only want to know
> if the fetch was performed, so we don't need to know where the branch
> was before the fetch.

I tried ejecting 1/9 and 2/9 out of this series locally, and it passes
all tests until the new tests you add in 7/9.

As ugly as some of the pre-image is, I wonder if dropping these first
two and biting the bullet and just continuing with the test_cmp is
better.

The test_cmp is going to catch issues that even the cleverest grep
combinations won't, e.g. in the submodule-in-C series I discovered a bug
where all of our testing & the existing series hadn't spotted that we
were dropping a \n at the end in one of the messages.

Particularly as:

>  # Verifies that the expected repositories were fetched. This is done by
> -# concatenating the files expect.err.[super|sub|deep] in the correct
> -# order and comparing it to the actual stderr.
> +# checking that the branches of [super|sub|deep] were updated to
> +# [super|sub|deep]head if the corresponding file exists.
>  #
> -# If a repo should not be fetched in the test, its corresponding
> -# expect.err file should be rm-ed.
> +# If the [super|sub|deep] head file does not exist, this verifies that
> +# the corresponding repo was not fetched. Thus, if a repo should not be
> +# fetched in the test, its corresponding head file should be
> +# rm-ed.
>  verify_fetch_result() {
>  	ACTUAL_ERR=$1 &&
> -	rm -f expect.err.combined &&
> -	if [ -f expect.err.super ]; then
> -		cat expect.err.super >>expect.err.combined
> +	# Each grep pattern is guaranteed to match the correct repo
> +	# because each repo uses a different name for their branch i.e.
> +	# "super", "sub" and "deep".
> +	if [ -f superhead ]; then
> +		grep -E "\.\.$(cat superhead)\s+super\s+-> origin/super" $ACTUAL_ERR
> +	else
> +		! grep "super" $ACTUAL_ERR
>  	fi &&
> -	if [ -f expect.err.sub ]; then
> -		cat expect.err.sub >>expect.err.combined
> +	if [ -f subhead ]; then
> +		grep "Fetching submodule submodule" $ACTUAL_ERR &&
> +		grep -E "\.\.$(cat subhead)\s+sub\s+-> origin/sub" $ACTUAL_ERR
> +	else
> +		! grep "Fetching submodule submodule" $ACTUAL_ERR
>  	fi &&
> -	if [ -f expect.err.deep ]; then
> -		cat expect.err.deep >>expect.err.combined
> -	fi &&
> -	test_cmp expect.err.combined $ACTUAL_ERR
> +	if [ -f deephead ]; then
> +		grep "Fetching submodule submodule/subdir/deepsubmodule" $ACTUAL_ERR &&
> +		grep -E "\.\.$(cat deephead)\s+deep\s+-> origin/deep" $ACTUAL_ERR
> +	else
> +		! grep "Fetching submodule submodule/subdir/deepsubmodule" $ACTUAL_ERR
> +	fi
>  }

This sort of thing is really hard to understand and review...

>  test_expect_success setup '
> @@ -274,13 +277,10 @@ test_expect_success "Recursion doesn't happen when no new commits are fetched in
>  '
>  
>  test_expect_success "Recursion stops when no new submodule commits are fetched" '
> -	head1=$(git rev-parse --short HEAD) &&
>  	git add submodule &&
>  	git commit -m "new submodule" &&
> -	head2=$(git rev-parse --short HEAD) &&
> -	echo "From $pwd/." > expect.err.super &&
> -	echo "   $head1..$head2  super      -> origin/super" >>expect.err.super &&

...as opposed to if we just rolled the generation of this into some
utility printf function.
