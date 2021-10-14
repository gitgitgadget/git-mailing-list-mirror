Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B59EC433F5
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 17:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 264BE61053
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 17:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbhJNRXd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 13:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbhJNRXb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 13:23:31 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B106C061570
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 10:21:26 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id z77-20020a1c7e50000000b0030db7b70b6bso87767wmc.1
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 10:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=tn2xopO+IRpkHdBG6hULyWccc16fnRUyFURG/IrLjic=;
        b=DJvZ3c+Scki/R8UlELyyjl52NGmuvCyC6Shd9Is8lFg5Nh9DcTUzMX3D8dpLj905kq
         /YxZ46ccl2zVR/1FLf3ooRW5pqUQI9wbntM5aJ1FJPvbpt8uKKJSYl7opxYU9Kc2crzm
         iriFIC/owxnvtc3IGOzhmQCEULORBQHBwdPMTltgXtC+0FRFqZ9wcfXHNBhHccG1XsCj
         Fb1vZeYhswTSK16fC5Mt/0z9eWT6ssKOTq4S2ut8ITbKjcX9zB3w4kl/gthclg2qSJNz
         uyG8FF74Lm9fMMplYEqf6MOnCJorrJ7fuzl6UGAGAOaEuAUyhAsKzcBJ65vRPC+2EY6Q
         Jd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=tn2xopO+IRpkHdBG6hULyWccc16fnRUyFURG/IrLjic=;
        b=B3maFwv+f0IoT4tAKiS3G+UaCi+UjuwqkXG267cmPAQd/CXdb+tQiXO2rkq5xMpGN9
         K2eQPhZsHPCCZn+lJPTYHUUVMFuznuuIQjzKdmydBauzqcV1Dplef7JfAo3zC1bdizBa
         e8aedUgUi4Q+mIZKxcKlkBKDkEq6TPCvhXm3xoTlg/Bs8UDEuicuGMIFb1zTw7rxf328
         Znpn72wVNsvnqbn2iXeVAdfBElRO1MSaSjSKiGIVZXUVhAfoB1SMDMlie/br+HfdLwOA
         t6cWLtKhOqk3VfL8fLUJfR2ApwZgVVQSnF+BDD54GS/wY/TihtD+RP+vdT1+enVxredc
         E7zw==
X-Gm-Message-State: AOAM533iaHyp/2uLSf9K96o4dA8Q3MwRHixepYHvwqRWRq6Fr2zXmG9S
        EgPjZqTuH1ySQ3b99wjqUuM=
X-Google-Smtp-Source: ABdhPJywQjvd0c561abMOkIXzsPmgAng4CfRu83PAHXKy39QlVOF6w2R/7PDIwiCVx25N8kG5adzrw==
X-Received: by 2002:a1c:29c7:: with SMTP id p190mr7053254wmp.65.1634232084299;
        Thu, 14 Oct 2021 10:21:24 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id w26sm2795052wmk.34.2021.10.14.10.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 10:21:23 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        David Turner <novalis@novalis.org>,
        Elijah Newren <newren@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: test-lib.sh musings: test_expect_failure considered harmful
Date:   Thu, 14 Oct 2021 19:11:17 +0200
References: <87tuhmk19c.fsf@evledraar.gmail.com>
 <xmqq4k9m6vkw.fsf@gitster.g>
 <d643863c-7683-fe4b-e4f2-3fefc475006b@gmail.com>
 <xmqq4k9kj15p.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqq4k9kj15p.fsf@gitster.g>
Message-ID: <87zgrbfrot.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 13 2021, Junio C Hamano wrote:

> Derrick Stolee <stolee@gmail.com> writes:
>
>>> But even with the shortcomings of expect_failure, it still is much
>>> better than claiming that we expect a bogus outcome.
>>> 
>>> Improving the shortcomings of expect_failure would be a much better
>>> use of our time than advocating an abuse of expect_sucess, I would
>>> think.
>>
>> I agree that test_expect_failure has these drawbacks. I've recently
>> been using _expect_success to document "bad" behavior so we can verify
>> that behavior changes when that behavior is fixed. But it does have
>> the drawback of looking like we claim the result is by design.
>
> Yeah, I think I saw (and I think I used the same technique myself)
> people expect a bad output with test_expect_success with an in-code
> (not in-log) comment that explicitly says "This documents the
> current behaviour, which is wrong", and that is a very acceptable
> solution, I would think.
>
>> One possible way to correct this is to create a "test_expected_failure"
>> helper that could be placed on the step(s) of the &&-chain that are
>> expected to fail. The helper could set some variable to true if the
>> failure is hit, and false otherwise. It can also convert a failure
>> into a positive result. Then, test_expect_failure could look for that
>> variable's value (after verifying that the &&-chain returns success)
>> to show that all expected failures completed correctly.
>
> Yup, I would very much like the direction, and further imagine that
> the above approach can be extended to ...
>
>> This could have the side-effect of having a "fixed" test_expect_failure
>> show as a failed test, not a "TODO" message.
>
> ... avoid such downside.  Perhaps call that magic "we know this step
> fails currently" test_known_breakage and declare that we deprecate
> the use of test_expect_failure in new tests.  Such a test might look
> like this:
>
>     test_expect_success 'commit error message should not duplicate' '
> 	test_when_finished "chmod -R u+rwx ." &&
> 	chmod u-rwx .git/objects/ &&
> 	orig_head=$(git rev-parse HEAD) &&
> 	test_must_fail git commit --allow-empty -m "read-only" 2>rawerr &&
> 	grep "insufficient permission" rawerr >err &&
> 	test_known_breakage test_line_count = 1 err &&
> 	new_head=$(git rev-parse HEAD) &&
> 	test "$orig_head" = "$new_head"
>     '
>
> which may use your trick to turn both failure and success to OK (to
> let the remainder of the test to continue) but signal the
> surrounding test_expect_success to say either "TODO know breakage"
> or "Fixed".

I don't see how it's a downside. Considering the behavior bad now
shouldn't entail that we should be fuzzy about testing what exactly *is*
happening right now. If one bad but expected state turns into another
unexpected bad state the test should fail.

In this case this thread spawned off a fix where we print an error
twice, instead of once:
https://lore.kernel.org/git/cover-v2-0.2-00000000000-20211012T142950Z-avarab@gmail.com/#t

That sucks a bit, but printing pages full of such errors in a loop would
be way worse, which we'll hide if we insist on not testing the exact
emitted output, or on such "test_known_breakage" helpers.

It's just a downside because when we fix bugs we'll need to go through
the "expected failure" tests and adjust them, but that seems like a
feature to me.

Now I can submit a patch that fixes a known bug with no test suite
changes, and I might not even notice that I fixed one.

We may want to have tests for something that really is nondeterministic,
e.g. for the code I added in 2d3c02f5db6 (die(): stop hiding errors due
to overzealous recursion guard, 2017-06-21).

But that'll only be the case for some tiny minority (or none) of the
existing callers of "test_expect_failure".

1. https://lore.kernel.org/git/87tuhmk19c.fsf@evledraar.gmail.com/
