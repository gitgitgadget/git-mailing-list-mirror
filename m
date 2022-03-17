Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80DBC433F5
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 22:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiCQWqE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 18:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiCQWqD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 18:46:03 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698ED1AFE91
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 15:44:46 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id q194so5557056qke.5
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 15:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=5Z2nHa4bCjt2ysqXzjeEggqp2PIJWZRUnHVgq63EQNQ=;
        b=lsXEGwdT5QsaRLHhncES6ronvN/uqqk4T3vBL4tz1ae+GYOJDaqOVf3vYZCBmd1RRY
         OLr2L1s0t598aUTNrTMW9ev4lV9EGUr7CC5DC3C5SxuYM4QC92EbdJGWUHPuBuiwXBrJ
         6IbnkQ3nGyTgq5e/+6Q8ph2WMTK9HMpLvsoNYoutC9kRpy0KEqFrIOpM25xUJd5iw7zx
         /c8kpTcFBOC2L0QUoDORCUy1ZQS3Qas+ik/4bi9thKhRAG6GwxMqfeR1N0ApqLeZWPU9
         077L4ru8nz8eDIQHOGEhkI5ciPs1VOqRq2X479kuJTyz9xVAilx6XPEEBCYhEMtXdOTJ
         HdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=5Z2nHa4bCjt2ysqXzjeEggqp2PIJWZRUnHVgq63EQNQ=;
        b=3Hv03oAB/06Ky4xLiDXVuNUzaFpOth3TFuGimmVNnQk9dVNcc71RXUG5SWb9v4udyg
         YnptINSOY8g0F6mrFr8hMOcX7LnWaHcIYgnS7iGzJG3ZDLmiqvf/esiFF72Swsx7pQyz
         cPTzIzUeIbts2XSI57/nyw/ugL6bqzlCRVR00oaU4IAniqOV+rLd4p8TSOkjVLYyVwh8
         vD4dSxqlqY3AcobQmR9FWvRdD4it8LOd5tC3juIuzlZFLuAC/iGbTkIfKYcAA+MsFme/
         XK0FrrAiuSMCDnVb9hv0n4htUMRxkTs5FCdxnwBwyK64HlnLiCAc5GHS8qxLOgimaums
         Ah0g==
X-Gm-Message-State: AOAM531e487wJQYZZkgxRiQ+3pBmpTN+LGc+ZJPJ9D44UV0qsEoZoazm
        TfkLIbPCOtoUY8iE1q6wktU=
X-Google-Smtp-Source: ABdhPJym00xTlOo8kL4PXUp7rlNESIygBOGV3SZsPzExd3aJZuB5+Fll4UkOm+bpu5Xw/Rnqvw2j4A==
X-Received: by 2002:a05:620a:22b0:b0:67d:79b6:a063 with SMTP id p16-20020a05620a22b000b0067d79b6a063mr4309773qkh.54.1647557085453;
        Thu, 17 Mar 2022 15:44:45 -0700 (PDT)
Received: from [10.37.129.2] (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id 20-20020ac84e94000000b002e1d5505fb6sm4723741qtp.63.2022.03.17.15.44.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Mar 2022 15:44:45 -0700 (PDT)
From:   John Cai <johncai86@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v4 1/3] rebase: test showing bug in rebase with non-branch
Date:   Thu, 17 Mar 2022 18:44:44 -0400
X-Mailer: MailMate (1.14r5852)
Message-ID: <1BEA9176-EB83-4E7C-A592-037667D0D9ED@gmail.com>
In-Reply-To: <xmqqo824e145.fsf@gitster.g>
References: <pull.1226.v3.git.git.1647487001.gitgitgadget@gmail.com>
 <pull.1226.v4.git.git.1647546828.gitgitgadget@gmail.com>
 <cac51a949eed0fa593247a593aae2b100be6f4f2.1647546828.git.gitgitgadget@gmail.com>
 <xmqqo824e145.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 17 Mar 2022, at 17:10, Junio C Hamano wrote:

> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: John Cai <johncai86@gmail.com>
>>
>> Currently when rebase is used with a non branch, and <oid> is up to
>> date with base:
>>
>> git rebase base <oid>
>>
>> It will update the ref that HEAD is pointing at to <oid>, and leave HEAD
>> unmodified.
>>
>> This is a bug. The expected behavior is that the branch HEAD points at
>> remains unmodified while HEAD is updated to point to <oid> in detached
>> HEAD mode.
>
> Never do tests this way.
>
> The primary reason why we do not want to write our tests the way
> this patch does is because we do not _care_ how it is broken in the
> behaviour of the original code.  'main' moving out of $old_main is
> the bug we care about.  It is still buggy if it did not move to
> Second, but some other commit.  Yet this patch insists that 'main'
> to move to Second and nothing else.  What we want is 'main' to stay
> at $old_main in the end anyway, and we should directly test that
> condition.

I was attemping to follow the advice to "show" vs "tell" in [1]. All this
make sense to me however.

>
> If you insist to have two commits (which I strongly recommend
> against in this case), you write a test that makes sure that 'main'
> stays at $old_main, but mark the test with test_expect_failure.  And
> then later in the step that fixes the code, flip "expect_failure" to
> "expect_success".
>
> But it is not ideal, either.  Imagine what you see in "git show"
> output of the commit that fixed the problem.  Most of the test that
> shows the behaviour that the commit _cares_ about will be outside
> post-context of the hunk that flips test_expect_failure to
> test_expect_success.
>
> The best and the simplest way, for a simple case like this, to write
> test is to add the test to expect what we want to see in the end,
> and do so in the same commit as the one that corrects the behaviour
> of the code.  If somebody wants to see what the breakage looks like,
> it is easy to
>
>  (1) checkout the commit that fixes the code and adds such a test,
>
>  (2) tentatively revert everything outside t/, and
>
>  (3) run the test with "-i -v" options.
>
> Then test_expect_success that wants to see 'main' to stay at
> $old_main will show that 'main' moved by a test failure.  Working
> from a patch is the same way, i.e. you can apply only the parts
> inside t/ and run the current code to see the breakage, and then
> apply the rest to see the fix.
>
>> +test_expect_success 'switch to non-branch changes branch HEAD points to' '
>> +	git checkout main &&
>> +	old_main=$(git rev-parse HEAD) &&
>> +	git rebase First Second^0 &&
>
>> +	test_cmp_rev HEAD main &&
>> +	test_cmp_rev main $(git rev-parse Second) &&
>> +	git symbolic-ref HEAD
>
> I already said that the second one should expect main to be at
> $old_main, but the "HEAD and main are the same" and "HEAD is a
> symolic-ref" test can be replaced with a single test that is "HEAD
> is a symbolic-ref to 'main'", which would be more strict.  I.e.
>
> 	test "$(git symbolic-ref HEAD)" = refs/heads/main &&
> 	test_cmp_rev main "$old_main"
>
> And such a test that expects the correct behaviour we want to have
> in the end should be added in [PATCH 3/3] when the code is fixed,
> not here in a separate commit.

1. https://lore.kernel.org/git/220317.86r170d6zs.gmgdl@evledraar.gmail.com/

>
>> +'
>
> Thanks.
