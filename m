Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D07BC433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 10:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbiBPKY5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 05:24:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiBPKYx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 05:24:53 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73123206DD2
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 02:24:41 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id lw4so3452679ejb.12
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 02:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=k9IW677CWd5gQ5AYhu8GTSNt/uSPm2Q0OxfgmaRRVQg=;
        b=My+Z6I72wHs3RmViWsQTrbepvZfL3Ce+9xcs423bMfnvSlB26CsATKggUkRQ9GGCuY
         4DjZ5Ne1LC3t++f7kUxpO5kql5wmGgqb+uLbOkDegf1Fo4BCHuSBPYZJlM+SzreYxmf/
         ThyzFqFRF13M4wWzaNRG2PZI+78LTaXV24DZPBzCfp/wWIc2vwSefKfKRtjVbSgGBYPy
         k7z7d9+xp8DKu3S6SsAR3VZpSb0B1O5k4qdgFBUOfNcop0KOu3379BGfOGXS5hHiOF4r
         qNIqY7jxm76s7JrNWwkyCiCz9Y2IxMmVB2yXcW5pGkSUOrc4coTd6sjhUxf8WRJEUj8z
         kJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=k9IW677CWd5gQ5AYhu8GTSNt/uSPm2Q0OxfgmaRRVQg=;
        b=ArQD8MXilfcepl62V8FMLryRQ/+tD7HCo474QczWknVIWDzZ/UIdKtNzrR3S9GfquZ
         /f9oG8YWTdHSk4T4Z3Cw+fHLwhXwL9H/R15n7+KqQBru1sMUG9+q8LRCvK4Dl2fNp1vV
         piD5nIRmAc1RsXnlCXPI0OlwJHMcxSCcVi3wEru3bGKdwkaN1L3Oj3LRMrFxiZ8U+M9H
         J+xN1YrxJlK3SqEW8XHjcxBHRG8hteiDjAlzlkAUtIAuWfDS5NJe2z1UJQoXjYeL0gZo
         O3TSLNXOriUAYOlJv/qUUYvL23zzKtlgOJiSM1t6fo5UWNdbbVzw4my8AZsVrRxtjb4g
         QYPA==
X-Gm-Message-State: AOAM5331p2yuy1hYvuKlPqZ/7+vvmPTpB+3ryXJgQnEnMRLEEVyotCY7
        ak6szFPsBJO7bvgS6j+itAG7oroOwo5kLw==
X-Google-Smtp-Source: ABdhPJy9D2C1r1rQC9MlreqGPt72IUD+4PTOx+bbJm6321t5YDk+tWIUjqAiknxZ87L/v8rFFrljcA==
X-Received: by 2002:a17:906:c0c:b0:6ce:e59c:c38a with SMTP id s12-20020a1709060c0c00b006cee59cc38amr1644166ejf.483.1645007079427;
        Wed, 16 Feb 2022 02:24:39 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id a26sm3787964ejs.143.2022.02.16.02.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 02:24:38 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nKHUE-003CWr-94;
        Wed, 16 Feb 2022 11:24:38 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/9] t5526: use grep to assert on fetches
Date:   Wed, 16 Feb 2022 11:02:35 +0100
References: <20220210044152.78352-1-chooglen@google.com>
 <20220215172318.73533-1-chooglen@google.com>
 <20220215172318.73533-3-chooglen@google.com>
 <220215.86r183x043.gmgdl@evledraar.gmail.com>
 <kl6ltucz5wys.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <kl6ltucz5wys.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <220216.86y22bt8gp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 16 2022, Glen Choo wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Wed, Feb 16 2022, Glen Choo wrote:
>>
>>> In a previous commit, we replaced test_cmp invocations with
>>> verify_fetch_result(). Finish the process of removing test_cmp by using
>>> grep in verify_fetch_result() instead.
>>>
>>> This makes the tests less sensitive to changes because, instead of
>>> checking the whole stderr, we only grep for the lines of the form
>>>
>>> * "<old-head>..<new-head>\s+branch\s+-> origin/branch"
>>> * "Fetching submodule <submodule-path>" (if fetching a submodule)
>>>
>>> when we expect the repo to have fetched. If we expect the repo to not
>>> have fetched, grep to make sure the lines are absent. Also, simplify the
>>> assertions by using grep patterns that match only the relevant pieces of
>>> information, e.g. <old-head> is irrelevant because we only want to know
>>> if the fetch was performed, so we don't need to know where the branch
>>> was before the fetch.
>>
>> I tried ejecting 1/9 and 2/9 out of this series locally, and it passes
>> all tests until the new tests you add in 7/9.
>>
>> As ugly as some of the pre-image is, I wonder if dropping these first
>> two and biting the bullet and just continuing with the test_cmp is
>> better.
>>
>> The test_cmp is going to catch issues that even the cleverest grep
>> combinations won't, e.g. in the submodule-in-C series I discovered a bug
>> where all of our testing & the existing series hadn't spotted that we
>> were dropping a \n at the end in one of the messages.
>
> I think there are two schools of thought on how to test informational
> messages:
>
> - assert an exact match on the exact output that we generate
> - assert that the output contains the pieces of information we care
>   about
>
> These two approaches are virtually opposites on two axes - the former
> will catch unintentional changes (like you've noted)[...]

Yes, and to be fair I'm thoroughly in the "assert an exact match" camp,
i.e. "let's just use test_cmp", and not everyone would agree with that.

I mean, I don't think we should test_cmp every single instance of a
command, but for things that are *the tests* concerning themselves with
what the output should be, yes we should do that.

> [...] and the latter saves on maintenance effort and tends to be less noi=
sy in tests.

I also don't think you're right about the other approach "sav[ing] on
[future] maintenance effort" in this case.

If I was needing to adjust some of this output I'd spend way longer on
trying to carefully reason that some series of "grep" invocations were
really doing the right thing, and probably end up doing the equivalent
of a "test_cmp" for myself out of general paranoia, whereas adjusting
the output.

Whereas adjusting the code, running the tests, and looking at the "diff
-u" failures from "test_cmp" and adjusting the output is an easy matter
of copy/pasting.

Then reviewers can just see what's a clear human-readable change,
e.g. imagine reviewing a patch where we start trying to aligning
something in the output where the patch has a pretty much 1=3D1 (test_cmp)
mapping to the before/after, v.s. doing the same with whatever "grep"
regex we wind up with.

> Personally, I'm a bit torn between both approaches in general because I
> want tests to be maintainable (testing the exact output is a bit of an
> antipattern at Google), but I'm not very comfortable with the fact that
> unintended changes can sneak through.

Yes, anyway whatever one thinks in general what I meant to point out
here with "biting the bullet" is that whatever one thinks in general
about the right approch for new tests, this series in particular seems
to be creating more work for itself than it needs by refactoring the
test_cmp in existing tests just to add a few new ones.

I.e. even if you'd like to not use test_cmp-alike for the new tests,
wouldn't it be simpler to just leave the old ones in place and use your
new helper for your new tests?

> So I don't think there's a correct answer in general. Maybe an
> acceptable rule of thumb is that test_cmp is good until it starts
> getting in the way of reading and writing understandable tests.
>
> If we agree on that rule, then for this patch, I think replacing
> test_cmp is the way to go, primarily because it lets us ignore the 'old
> head' of the branch before the fetch, e.g. in the quoted example..

[...]

>>>  test_expect_success setup '
>>> @@ -274,13 +277,10 @@ test_expect_success "Recursion doesn't happen whe=
n no new commits are fetched in
>>>  '
>>>=20=20
>>>  test_expect_success "Recursion stops when no new submodule commits are=
 fetched" '
>>> -	head1=3D$(git rev-parse --short HEAD) &&
>>>  	git add submodule &&
>>>  	git commit -m "new submodule" &&
>>> -	head2=3D$(git rev-parse --short HEAD) &&
>>> -	echo "From $pwd/." > expect.err.super &&
>>> -	echo "   $head1..$head2  super      -> origin/super" >>expect.err.sup=
er &&
>>
>> ...as opposed to if we just rolled the generation of this into some
>> utility printf function.
>
> we'd still have to deal with $head1 if we use test_cmp. That's fine for
> this test, because it's pretty simple, but it gets pretty janky later
> on:
>
>   @@ -345,20 +339,13 @@ test_expect_success "Recursion picks up all submo=
dules when necessary" '
>         git fetch &&
>         git checkout -q FETCH_HEAD
>       ) &&
>   -		head1=3D$(git rev-parse --short HEAD^) &&
>       git add subdir/deepsubmodule &&
>       git commit -m "new deepsubmodule" &&
>   -		head2=3D$(git rev-parse --short HEAD) &&
>   -		echo "Fetching submodule submodule" > ../expect.err.sub &&
>   -		echo "From $pwd/submodule" >> ../expect.err.sub &&
>   -		echo "   $head1..$head2  sub        -> origin/sub" >> ../expect.err.=
sub
>   +		git rev-parse --short HEAD >../subhead
>     ) &&
>   -	head1=3D$(git rev-parse --short HEAD) &&
>     git add submodule &&
>     git commit -m "new submodule" &&
>   -	head2=3D$(git rev-parse --short HEAD) &&
>   -	echo "From $pwd/." > expect.err.super &&
>   -	echo "   $head1..$head2  super      -> origin/super" >> expect.err.su=
per &&
>   +	git rev-parse --short HEAD >superhead &&
>     (
>       cd downstream &&
>       git fetch >../actual.out 2>../actual.err
>
> In this example, we have two $head1 variables in different subshells,
> one of which is HEAD, but the other is HEAD^. The reason why we want
> HEAD^ isn't obvious (IIRC it's because the submodule upstream is 2
> commits ahead because we add the deepsubmodule in a separate commit), in
> my opinion, and I got tripped up quite a few times trying to read and
> understand the test. That's a lot of effort to spend on irrelevant
> information - the test actually cares about what it fetched, not where
> the ref used to be.
>
> So for that reason, I'd prefer to remove test_cmp for this test.

I agree that it's pretty irrelevant, but I also think we'd be throwing
the baby out with the bath water by entirely doing away with test_cmp
here, there's an easier way to do this.

I.e. none of these tests surely need to test that we updated from
$head1..$head2 again and again with the corresponding verbosity in test
setup and shelling out to "git rev-parse --short HEAD" or whatever.

Instead let's just test once somewhere that when we run submodule
fetching that submodules are indeed updated appropriately. Surely other
submodule tests will break if the "update" code is made to NOOP, or
update to the wrong HEAD>

Then for all these test_cmp tests we can just sed-away the
$head1..$head2 with something like (untested):

    sed -n -e 's/[^.]*\.\.[^.]*/OLD..NEW/g'

I.e. let's just skip this entire ceremony with asserting the old/new
HEAD unless it's really needed (and then we can probably do it once
outside a test_cmp).

If you grep through the test suite for "sed" adjacent to "test_cmp"
you'll find a lot of such examples of munging the output before
test_cmp-ing it.

That's perfectly fine here, since the actual point of the test_cmp is to
check the formatting/order etc. of the output itself, not to continually
re-assert that submodule updating still works, and that we get the right
OIDs.



