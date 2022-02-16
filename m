Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2A9C433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 03:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238409AbiBPDJq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 22:09:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344106AbiBPDJo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 22:09:44 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BAE9A9A7
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 19:09:18 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id iy10-20020a17090b16ca00b001b8a7ed5b2cso3751979pjb.7
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 19:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=mPT62hoSvdpYTUPkqZmu9Aa8FmBUZv4N+O13q22BK/Y=;
        b=cJZfG4ontT89u6LaZbrUPt3QiecJO6Sf8u59UsoNes6TSoj3NQJ0wC3Fe2vVJ1MPOo
         lRdWyaExQndVv4tZe9qzAGF2CRCCBCdPqlOd9yeF3AXe/Xy3/qBMqAOIQvXFVBXRaQDy
         EseUh9bwCdEGLa+R/PeqLWV57gqAuOCYDmEaE3f4g3lskz6+M/NqWzQcxz1S08hTt1P4
         +Af9ior4QcrtXoYSJ1fW416FcfVLIdXy6NdwYPHkL5eCH0DBNh11V4DkwoUBxdXpua46
         OvjNrDdm5D/I7LuWpHNpY8MbGf7Bl1503tsvImhMRiuTNS9YldQiuq7sTAf+L3R9N/HV
         Gj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=mPT62hoSvdpYTUPkqZmu9Aa8FmBUZv4N+O13q22BK/Y=;
        b=BkPPceIsKo3lEQoyn5rtOihsgGrP7l+CzoL6AucatleVxGC58dqB0zsQOBu0lu1oSx
         h5BecF0TdVBe3hL+q1Sm3AgOuc8PvlcrvJ1HGaQpYpxv5MIK9+/aR4p++1jnxE37kMZV
         Cvs4z0gpevV0t1TcoqvXwyb+lLmmxmQ+ieesbA8fHSBUFpHA8ik5vmak0Kezuf3cHTJ1
         G2gtcn++yRsUO9HtW/fcAJIAXAlog588gzX7h5fW/dxm1BT7ksQDytmhYfBI30OFHXRH
         wZuA0U8BwM97A0ndZXU8flW51TRwCQIK4bl3guT5EbLBBbZB/4nuTs9WgbftqkO+Oypp
         Kf5w==
X-Gm-Message-State: AOAM531QBWKS/Jr5GU3ksPlz8U0NZYOtvtPkMWIfH+OfOuUpArluW9lE
        oabNLAnOT6y1U7LLdt2THcDGYTBZ1n71ug==
X-Google-Smtp-Source: ABdhPJweUoilyyB+0r+Bw+CHZpHDuVDbO9CTfwf5lSt2nlQXI7NfvOMEwK3jc8ndMMHCXlxmhkgU6gMSDWAWZw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:7c06:b0:14e:f6c2:62a5 with SMTP
 id x6-20020a1709027c0600b0014ef6c262a5mr727303pll.22.1644980957973; Tue, 15
 Feb 2022 19:09:17 -0800 (PST)
Date:   Wed, 16 Feb 2022 11:09:15 +0800
In-Reply-To: <220215.86r183x043.gmgdl@evledraar.gmail.com>
Message-Id: <kl6ltucz5wys.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220210044152.78352-1-chooglen@google.com> <20220215172318.73533-1-chooglen@google.com>
 <20220215172318.73533-3-chooglen@google.com> <220215.86r183x043.gmgdl@evledraar.gmail.com>
Subject: Re: [PATCH v2 2/9] t5526: use grep to assert on fetches
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Feb 16 2022, Glen Choo wrote:
>
>> In a previous commit, we replaced test_cmp invocations with
>> verify_fetch_result(). Finish the process of removing test_cmp by using
>> grep in verify_fetch_result() instead.
>>
>> This makes the tests less sensitive to changes because, instead of
>> checking the whole stderr, we only grep for the lines of the form
>>
>> * "<old-head>..<new-head>\s+branch\s+-> origin/branch"
>> * "Fetching submodule <submodule-path>" (if fetching a submodule)
>>
>> when we expect the repo to have fetched. If we expect the repo to not
>> have fetched, grep to make sure the lines are absent. Also, simplify the
>> assertions by using grep patterns that match only the relevant pieces of
>> information, e.g. <old-head> is irrelevant because we only want to know
>> if the fetch was performed, so we don't need to know where the branch
>> was before the fetch.
>
> I tried ejecting 1/9 and 2/9 out of this series locally, and it passes
> all tests until the new tests you add in 7/9.
>
> As ugly as some of the pre-image is, I wonder if dropping these first
> two and biting the bullet and just continuing with the test_cmp is
> better.
>
> The test_cmp is going to catch issues that even the cleverest grep
> combinations won't, e.g. in the submodule-in-C series I discovered a bug
> where all of our testing & the existing series hadn't spotted that we
> were dropping a \n at the end in one of the messages.

I think there are two schools of thought on how to test informational
messages:

- assert an exact match on the exact output that we generate
- assert that the output contains the pieces of information we care
  about

These two approaches are virtually opposites on two axes - the former
will catch unintentional changes (like you've noted) and the latter
saves on maintenance effort and tends to be less noisy in tests.

Personally, I'm a bit torn between both approaches in general because I
want tests to be maintainable (testing the exact output is a bit of an
antipattern at Google), but I'm not very comfortable with the fact that
unintended changes can sneak through.

So I don't think there's a correct answer in general. Maybe an
acceptable rule of thumb is that test_cmp is good until it starts
getting in the way of reading and writing understandable tests.

If we agree on that rule, then for this patch, I think replacing
test_cmp is the way to go, primarily because it lets us ignore the 'old
head' of the branch before the fetch, e.g. in the quoted example..

>>  test_expect_success setup '
>> @@ -274,13 +277,10 @@ test_expect_success "Recursion doesn't happen when=
 no new commits are fetched in
>>  '
>> =20
>>  test_expect_success "Recursion stops when no new submodule commits are =
fetched" '
>> -	head1=3D$(git rev-parse --short HEAD) &&
>>  	git add submodule &&
>>  	git commit -m "new submodule" &&
>> -	head2=3D$(git rev-parse --short HEAD) &&
>> -	echo "From $pwd/." > expect.err.super &&
>> -	echo "   $head1..$head2  super      -> origin/super" >>expect.err.supe=
r &&
>
> ...as opposed to if we just rolled the generation of this into some
> utility printf function.

we'd still have to deal with $head1 if we use test_cmp. That's fine for
this test, because it's pretty simple, but it gets pretty janky later
on:

  @@ -345,20 +339,13 @@ test_expect_success "Recursion picks up all submodu=
les when necessary" '
        git fetch &&
        git checkout -q FETCH_HEAD
      ) &&
  -		head1=3D$(git rev-parse --short HEAD^) &&
      git add subdir/deepsubmodule &&
      git commit -m "new deepsubmodule" &&
  -		head2=3D$(git rev-parse --short HEAD) &&
  -		echo "Fetching submodule submodule" > ../expect.err.sub &&
  -		echo "From $pwd/submodule" >> ../expect.err.sub &&
  -		echo "   $head1..$head2  sub        -> origin/sub" >> ../expect.err.su=
b
  +		git rev-parse --short HEAD >../subhead
    ) &&
  -	head1=3D$(git rev-parse --short HEAD) &&
    git add submodule &&
    git commit -m "new submodule" &&
  -	head2=3D$(git rev-parse --short HEAD) &&
  -	echo "From $pwd/." > expect.err.super &&
  -	echo "   $head1..$head2  super      -> origin/super" >> expect.err.supe=
r &&
  +	git rev-parse --short HEAD >superhead &&
    (
      cd downstream &&
      git fetch >../actual.out 2>../actual.err

In this example, we have two $head1 variables in different subshells,
one of which is HEAD, but the other is HEAD^. The reason why we want
HEAD^ isn't obvious (IIRC it's because the submodule upstream is 2
commits ahead because we add the deepsubmodule in a separate commit), in
my opinion, and I got tripped up quite a few times trying to read and
understand the test. That's a lot of effort to spend on irrelevant
information - the test actually cares about what it fetched, not where
the ref used to be.

So for that reason, I'd prefer to remove test_cmp for this test.
