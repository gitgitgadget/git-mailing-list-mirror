Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0C1C433F5
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 09:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238644AbiBQJ0x (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 04:26:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238635AbiBQJ0t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 04:26:49 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6064C2A255
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 01:26:34 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id c6so5766221edk.12
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 01:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=kW9TqnvYDM+qawLj7ydkcgXMjo6V44kODQ6xPCa9bt0=;
        b=DKCJbpVb8LqyN1XQViElKtTsTRzjG3kizmrCwFAMPJrSa+l/Ezl0THKJewwYT0Sqpq
         6qIdYUI2hoEVMmIsiWN/kdBkFbk2ZGs31TS+zHwCBcx10Jdt9JiOy0NO3wymriJcZjqa
         +dY/tIrD1pg733P+QL8nzTFZQepjeRsEDaYa4HXahZ0SADmOzoaQ42O/IQBQkKhnrqEp
         ghRhQAF7SI/Ep3UeqoKWeHmRbjnq71po25rJ7C2pj8AdHLDTlLdqh+Ivf3yboEUsePPn
         vzR99wBQzFkpLwWqi73rrUB07uNeFc9WCjQtvfT43+l29TaQYUoZJFgpNOZh66ufTL/E
         yABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=kW9TqnvYDM+qawLj7ydkcgXMjo6V44kODQ6xPCa9bt0=;
        b=XZcaT2r0nDusXH1dO5YXVRCZQx8NMKnmlGh7oe6eyFqOziGbGJODL4EkHC5EtQqgOx
         NWcHlsTuRuBy7A5wWa4GcmXPgxng7uIJa6v0TAuJZ8C3suyTtTnEKJCiyechtakvkEzP
         FdL3c15vJhaS2N94rQH0kIyhsLx3wqGMH+Jqn6ENI8QsoRFWN8n93UQX0AyLo+XxKAa6
         ME/8aHF4IUlPlwT9L+Z1GF6Opb4jCEiVSO5U7GjKroSM89X8Yx4CZNL3xpPfe+B8LPQo
         +dGDqPdjYBOckiLUQ+btndY/H4K4gPvSlMwvjXk8ZzeMfu7M0EGFLNy5IXvtq3D5jnYs
         G9EQ==
X-Gm-Message-State: AOAM530NNGLkWIG2zxNNFoc3MngG+hBNboS12ZzwMYbUPIp6Jx8vT7bI
        Po5RvZyYEBQIv12gw4l4ZJit1HRsdoo/iA==
X-Google-Smtp-Source: ABdhPJzrLBkW7DuFV9BdFjtlxrWWaYZkohXAKDKtkfEpaRVKgBHAigezExrYUq/edbLZT87/DbfVyw==
X-Received: by 2002:a05:6402:4305:b0:410:d56e:efe3 with SMTP id m5-20020a056402430500b00410d56eefe3mr1645592edc.440.1645089992444;
        Thu, 17 Feb 2022 01:26:32 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id q8sm2955383edd.10.2022.02.17.01.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 01:26:31 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nKd3X-003flh-C6;
        Thu, 17 Feb 2022 10:26:31 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/9] t5526: use grep to assert on fetches
Date:   Thu, 17 Feb 2022 10:25:52 +0100
References: <20220210044152.78352-1-chooglen@google.com>
 <20220215172318.73533-1-chooglen@google.com>
 <20220215172318.73533-3-chooglen@google.com>
 <220215.86r183x043.gmgdl@evledraar.gmail.com>
 <kl6ltucz5wys.fsf@chooglen-macbookpro.roam.corp.google.com>
 <220216.86y22bt8gp.gmgdl@evledraar.gmail.com>
 <kl6l7d9u5eay.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <kl6l7d9u5eay.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <220217.86iltdj12w.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 17 2022, Glen Choo wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Wed, Feb 16 2022, Glen Choo wrote:
>>
>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>>
>>>> On Wed, Feb 16 2022, Glen Choo wrote:
>>>>
>>>>> In a previous commit, we replaced test_cmp invocations with
>>>>> verify_fetch_result(). Finish the process of removing test_cmp by usi=
ng
>>>>> grep in verify_fetch_result() instead.
>>>>>
>>>>> This makes the tests less sensitive to changes because, instead of
>>>>> checking the whole stderr, we only grep for the lines of the form
>>>>>
>>>>> * "<old-head>..<new-head>\s+branch\s+-> origin/branch"
>>>>> * "Fetching submodule <submodule-path>" (if fetching a submodule)
>>>>>
>>>>> when we expect the repo to have fetched. If we expect the repo to not
>>>>> have fetched, grep to make sure the lines are absent. Also, simplify =
the
>>>>> assertions by using grep patterns that match only the relevant pieces=
 of
>>>>> information, e.g. <old-head> is irrelevant because we only want to kn=
ow
>>>>> if the fetch was performed, so we don't need to know where the branch
>>>>> was before the fetch.
>>>>
>>>> I tried ejecting 1/9 and 2/9 out of this series locally, and it passes
>>>> all tests until the new tests you add in 7/9.
>>>>
>>>> As ugly as some of the pre-image is, I wonder if dropping these first
>>>> two and biting the bullet and just continuing with the test_cmp is
>>>> better.
>>>>
>>>> The test_cmp is going to catch issues that even the cleverest grep
>>>> combinations won't, e.g. in the submodule-in-C series I discovered a b=
ug
>>>> where all of our testing & the existing series hadn't spotted that we
>>>> were dropping a \n at the end in one of the messages.
>>>
>>> I think there are two schools of thought on how to test informational
>>> messages:
>>>
>>> - assert an exact match on the exact output that we generate
>>> - assert that the output contains the pieces of information we care
>>>   about
>>>
>>> These two approaches are virtually opposites on two axes - the former
>>> will catch unintentional changes (like you've noted)[...]
>>
>> Yes, and to be fair I'm thoroughly in the "assert an exact match" camp,
>> i.e. "let's just use test_cmp", and not everyone would agree with that.
>>
>> I mean, I don't think we should test_cmp every single instance of a
>> command, but for things that are *the tests* concerning themselves with
>> what the output should be, yes we should do that.
>
> That's a good point I hadn't considered, which is that if we want any
> hope of catching unintentional changes in our test suite, we'd want
> _some_ test to check the output. For "git fetch --recurse-submodules",
> it makes the most sense for that test to live in this file.
>
> By eliminating all instances of test_cmp in this file in particular, we
> lose assurances that we don't introduce accidental changes. It makes
> sense to at least have some tests explicitly for output.
>
>>
>>> [...] and the latter saves on maintenance effort and tends to be less n=
oisy in tests.
>>
>> I also don't think you're right about the other approach "sav[ing] on
>> [future] maintenance effort" in this case.
>>
>> If I was needing to adjust some of this output I'd spend way longer on
>> trying to carefully reason that some series of "grep" invocations were
>> really doing the right thing, and probably end up doing the equivalent
>> of a "test_cmp" for myself out of general paranoia, whereas adjusting
>> the output.
>
> That's fair. I've optimized the tests for readability by putting
> complicated logic in the test helper. But any diligent test reader would
> need to read the test helper to convince themselves of its correctness.
> In this case, I agree that the helper is too complex.
>
>>> Personally, I'm a bit torn between both approaches in general because I
>>> want tests to be maintainable (testing the exact output is a bit of an
>>> antipattern at Google), but I'm not very comfortable with the fact that
>>> unintended changes can sneak through.
>>
>> Yes, anyway whatever one thinks in general what I meant to point out
>> here with "biting the bullet" is that whatever one thinks in general
>> about the right approch for new tests, this series in particular seems
>> to be creating more work for itself than it needs by refactoring the
>> test_cmp in existing tests just to add a few new ones.
>>
>> I.e. even if you'd like to not use test_cmp-alike for the new tests,
>> wouldn't it be simpler to just leave the old ones in place and use your
>> new helper for your new tests?
>
> I'm not sure about this - avoiding changing old tests leads to
> fragmentation in the test suite and even the same file. I find it very
> challenging to read/modify files like this, because there is no longer a
> consistent style for the file, and I have to figure out which is the
> "good" way to write tests.
>
> This suggestion makes sense if there's some qualitative difference
> between the new tests and old ones besides just 'being new'. This isn't
> true for this series, so I'd prefer to keep things consistent.
>
>>> So I don't think there's a correct answer in general. Maybe an
>>> acceptable rule of thumb is that test_cmp is good until it starts
>>> getting in the way of reading and writing understandable tests.
>>>
>>> If we agree on that rule, then for this patch, I think replacing
>>> test_cmp is the way to go, primarily because it lets us ignore the 'old
>>> head' of the branch before the fetch, e.g. in the quoted example..
>>
>> [...]
>>
>>>>>  test_expect_success setup '
>>>>> @@ -274,13 +277,10 @@ test_expect_success "Recursion doesn't happen w=
hen no new commits are fetched in
>>>>>  '
>>>>>=20=20
>>>>>  test_expect_success "Recursion stops when no new submodule commits a=
re fetched" '
>>>>> -	head1=3D$(git rev-parse --short HEAD) &&
>>>>>  	git add submodule &&
>>>>>  	git commit -m "new submodule" &&
>>>>> -	head2=3D$(git rev-parse --short HEAD) &&
>>>>> -	echo "From $pwd/." > expect.err.super &&
>>>>> -	echo "   $head1..$head2  super      -> origin/super" >>expect.err.s=
uper &&
>>>>
>>>> ...as opposed to if we just rolled the generation of this into some
>>>> utility printf function.
>>>
>>> we'd still have to deal with $head1 if we use test_cmp. That's fine for
>>> this test, because it's pretty simple, but it gets pretty janky later
>>> on:
>>>
>>>   @@ -345,20 +339,13 @@ test_expect_success "Recursion picks up all sub=
modules when necessary" '
>>>         git fetch &&
>>>         git checkout -q FETCH_HEAD
>>>       ) &&
>>>   -		head1=3D$(git rev-parse --short HEAD^) &&
>>>       git add subdir/deepsubmodule &&
>>>       git commit -m "new deepsubmodule" &&
>>>   -		head2=3D$(git rev-parse --short HEAD) &&
>>>   -		echo "Fetching submodule submodule" > ../expect.err.sub &&
>>>   -		echo "From $pwd/submodule" >> ../expect.err.sub &&
>>>   -		echo "   $head1..$head2  sub        -> origin/sub" >> ../expect.er=
r.sub
>>>   +		git rev-parse --short HEAD >../subhead
>>>     ) &&
>>>   -	head1=3D$(git rev-parse --short HEAD) &&
>>>     git add submodule &&
>>>     git commit -m "new submodule" &&
>>>   -	head2=3D$(git rev-parse --short HEAD) &&
>>>   -	echo "From $pwd/." > expect.err.super &&
>>>   -	echo "   $head1..$head2  super      -> origin/super" >> expect.err.=
super &&
>>>   +	git rev-parse --short HEAD >superhead &&
>>>     (
>>>       cd downstream &&
>>>       git fetch >../actual.out 2>../actual.err
>>>
>>> In this example, we have two $head1 variables in different subshells,
>>> one of which is HEAD, but the other is HEAD^. The reason why we want
>>> HEAD^ isn't obvious (IIRC it's because the submodule upstream is 2
>>> commits ahead because we add the deepsubmodule in a separate commit), in
>>> my opinion, and I got tripped up quite a few times trying to read and
>>> understand the test. That's a lot of effort to spend on irrelevant
>>> information - the test actually cares about what it fetched, not where
>>> the ref used to be.
>>>
>>> So for that reason, I'd prefer to remove test_cmp for this test.
>>
>> I agree that it's pretty irrelevant, but I also think we'd be throwing
>> the baby out with the bath water by entirely doing away with test_cmp
>> here, there's an easier way to do this.
> [...]
>> Instead let's just test once somewhere that when we run submodule
>> fetching that submodules are indeed updated appropriately. Surely other
>> submodule tests will break if the "update" code is made to NOOP, or
>> update to the wrong HEAD>
>>
>> Then for all these test_cmp tests we can just sed-away the
>> $head1..$head2 with something like (untested):
>>
>>     sed -n -e 's/[^.]*\.\.[^.]*/OLD..NEW/g'
>>
>> I.e. let's just skip this entire ceremony with asserting the old/new
>> HEAD unless it's really needed (and then we can probably do it once
>> outside a test_cmp).
>>
>> If you grep through the test suite for "sed" adjacent to "test_cmp"
>> you'll find a lot of such examples of munging the output before
>> test_cmp-ing it.
>
> Makes sense, I hadn't considered this (though I have seen the pattern in
> the test suite, oops). The most compelling argument in favor of this is
> that this could remove a lot of the complexity of verify_fetch_result(),
> which is impeding test readability.
>
>> I.e. none of these tests surely need to test that we updated from
>> $head1..$head2 again and again with the corresponding verbosity in test
>> setup and shelling out to "git rev-parse --short HEAD" or whatever.
>
> I find the converse (we are testing the formatting over and over again)
> less convincing. In these tests, we really are checking for $head2 in
> the stderr to verify that the correct thing was fetched. I'm not
> convinced that we should be relying on _other_ submodule tests to tell
> us that submodule fetch is broken. Which brings me back to the original
> motivation of this patch..
>
>>
>> That's perfectly fine here, since the actual point of the test_cmp is to
>> check the formatting/order etc. of the output itself, not to continually
>> re-assert that submodule updating still works, and that we get the right
>> OIDs.
>
> which is that these tests actually are continually re-asserting the
> submodule updating works correctly in the different circumstances, and
> since we use the stderr to check this, test_cmp adds unwarranted noise.
>
> But you are correct in that the point of test_cmp is to check
> formatting/order etc. There is value in using test_cmp for this purpose,
> and getting rid of it entirely creates a hole in our test coverage.
> (This wouldn't mean that we'd need to use test_cmp _everywhere_ though,
> only that we need to use test_cmp _somewhere_.)
>
> As it stands:
>
> +   test_cmp can improve the readability of the test helpers and
>     debuggability of tests vs grep
> +/- test_cmp can catch formatting changes that are hard to catch
>     otherwise, though at the cost of being sensitive to _any_ formatting
>     changes
> -   test_cmp needs some munging to eliminate unnecessary information
>
> so on the whole, I think it's worth trying to use test_cmp in the test
> helper. We may not _need_ it everywhere, but if it would be nice to use
> it in as many places as possible.

I think whatever you opt to go for here makes sense. I just wanted to
provide the feedback in case it was helpful, i.e. when reading it I
found these conversions a bit odd, wondered if they were strictly needed
etc.

Thanks!
