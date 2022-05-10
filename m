Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB101C433FE
	for <git@archiver.kernel.org>; Tue, 10 May 2022 18:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345778AbiEJS1f (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 14:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348918AbiEJS1b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 14:27:31 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87571F0183
        for <git@vger.kernel.org>; Tue, 10 May 2022 11:27:24 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id p18-20020aa78612000000b0050d1c170018so6601424pfn.15
        for <git@vger.kernel.org>; Tue, 10 May 2022 11:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=J3e6yEQRaN2/UcKMG14HVkqGG7eg4+nznvpeTY0JJEo=;
        b=RglADIXBOXpEzGGdVSZnFWKwjTZiQA5hyJ//QLbUqH3kl2loZ9o3lFkYHWjKFsUbpM
         liZCHaTLnF9e5VE4tBoZexsNpSSDGhzPwVhg420+v7N1QBVToLe6ni1oEqvbRdDCM/Ga
         u0WLE90q5BG2WwOWInrSzJPLX2Fy8E6xHB0QNFYlBpIhoWFI+Out0Ps8bz3uppo+my1X
         Mxlj/NCYx1FJG9UmDWXsmqIwUkVj4yyQVN4xx79e40FbOb0GtzVknhfGfGbIQHO9D4NP
         tDYp/iWqwnQXunzjO63AjQ6ZBzESe3epfmTLl8BvWopyZT5hfcBCOm38Pt1SdD8keLFN
         e62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=J3e6yEQRaN2/UcKMG14HVkqGG7eg4+nznvpeTY0JJEo=;
        b=bInPhVqUoHX4Tt+x1HGeBeYdLvraTHEnjrt0KxbNQxlfZmVCeMyosW1vNKd1MI7Vfy
         7MP3hUorCtMUDrC4wZy1Pe9yf32OFM1IJbmbjPFnBnMcsEOhktR54xWaDysIHbxmxi7q
         ZHCGsq90QIMmV2X5kBZNLmenUl9CbPknTnqo/BQo5spOwR4bz5gbddmEJFzer3OWPzBN
         HMFLi1YILDInX/4NF1ftepMjq71l7dkPjVFlGSIvV2uKxsv8UTJKL4E3ecaQGaT+9nyu
         t0C4Ko4QngBoKa+MFMtuGQxyRuH/oNA4ZAzELFj1cuRBkfMCsRaIhyduc6bnmXEh62Bx
         N2AQ==
X-Gm-Message-State: AOAM531V22S+s1DqxbONJcuK1G6m+AioiQQ7oMGvS7e365NojfqHwI83
        sImM5OUmHNSd/mPbAK4tmpOoTOl2gj0B/g==
X-Google-Smtp-Source: ABdhPJwipBNl/xpvkG1hLvWlvlt1qelfrEOIKU6SdL+PCw7Kxqq+l9ewJsH1q1YQ3TBFy+XWhsIKABiOTTrETQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:7104:b0:15e:ddb8:199 with SMTP id
 a4-20020a170902710400b0015eddb80199mr21999158pll.80.1652207244116; Tue, 10
 May 2022 11:27:24 -0700 (PDT)
Date:   Tue, 10 May 2022 11:27:21 -0700
In-Reply-To: <3234941c-5190-819f-fe3a-f528942c6b44@gmail.com>
Message-Id: <kl6l35hh8cqe.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1262.git.git.1652138854255.gitgitgadget@gmail.com> <3234941c-5190-819f-fe3a-f528942c6b44@gmail.com>
Subject: Re: [PATCH] pull: only pass '--recurse-submodules' to subcommands
From:   Glen Choo <chooglen@google.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Cc:     Huang Zou <huang.zou@schrodinger.com>,
        Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Thanks Philippe and Junio, both! 

Philippe Blain <levraiphilippeblain@gmail.com> writes:

>>  	if (cleanup_arg)
>>  		/*
>>  		 * this only checks the validity of cleanup_arg; we don't need
>> diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
>> index fa6b4cca65c..65aaa7927fb 100755
>> --- a/t/t5572-pull-submodule.sh
>> +++ b/t/t5572-pull-submodule.sh
>> @@ -107,6 +107,20 @@ test_expect_success " --[no-]recurse-submodule and submodule.recurse" '
>>  	test_path_is_file super/sub/merge_strategy_4.t
>>  '
>>  
>> +test_expect_success "fetch.recurseSubmodules option triggers recursive fetch (but not recursive update)" '
>> +	test_commit -C child merge_strategy_5 &&
>> +	git -C parent submodule update --remote &&
>> +	git -C parent add sub &&
>> +	git -C parent commit -m "update submodule" &&
>> +
>> +	git -C super -c fetch.recursesubmodules=true pull --no-rebase &&
>> +	# Check that the submodule commit was fetched
>> +	sub_oid=$(git -C super rev-parse FETCH_HEAD:sub) &&
>> +	git -C super/sub cat-file -e $sub_oid &&
>> +	# Check that the submodule worktree did not update
>> +	! test_path_is_file super/sub/merge_strategy_5.t
>> +'
>> +
>
> OK so here we test the following situation:
>
> fetch.recurseSubmodules  submodule.recurse  --recurse-submodules  fetch result  pull result
> -----------------------  -----------------  --------------------  ------------  ------------
> true                     unset              absent                recursive     not recursive
>
> I think this is a good start, but since the default behaviour 
> of Git is the following:
>
> fetch.recurseSubmodules  submodule.recurse  --recurse-submodules  fetch result  pull result
> -----------------------  -----------------  --------------------  ------------  ------------
> default: on-demand       default: false     unset                 on-demand     not recursive
>
> we end up testing something not very far from the default behaviour.

Yes, I made a silly mistake with the test.. (I could've
sworn it made sense at the time).

- fetch.recurseSubmodules=true always worked correctly when
  submodule.recurse is not set because "git pull" realizes that the
  behavior is unspecified, so "git fetch" doesn't receive a
  "--recurse-submodules" and does the right thing.

  For completeness, we probably still want this test (even though it has
  always passed).

- I didn't test the actual buggy behavior, which is the precedence of
  the two config values.

  This would be a new test that tests something like
  fetch.recurseSubmodules=foo and submodule.recurse=bar. This should be
  enough to test precedence; I don't think we need to test more
  combinations of values.

I hope you both didn't waste too much time on this :)

