Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A1BC433EF
	for <git@archiver.kernel.org>; Sat, 19 Mar 2022 11:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242785AbiCSLXc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Mar 2022 07:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238827AbiCSLXb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Mar 2022 07:23:31 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B21199E2D
        for <git@vger.kernel.org>; Sat, 19 Mar 2022 04:22:10 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id y22so12966378eds.2
        for <git@vger.kernel.org>; Sat, 19 Mar 2022 04:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=AH7MhClip718V/rfA5fedni8qtCwNGo4Z1T8RTmuQxw=;
        b=AVzIllhlegBLK+orjXuISRPG/XW5IRIa69Qxnn+9IjaTc46TA2lntj0ov6OxfkQ+HO
         aCVIvMibZoZQB5iBxmyV4A4/hBW8yoNmFW23ztFQjztURPP4vFOA3+Rr8oNJ2Y8rIXws
         UAsuriddaVGn53a9Nojor8eVz9AR8XAZhAxn67fMowzoaNnBUH0B0msrG7EH8MspYOWy
         D1U+7R+uvIn9CNz6KFNOccB9qd0X8QmAxkLIksUC1wPdYQGWQBVGm2/vUPkalDnVIYZN
         IpA4pZRWb5VojnAWU0QjiNAgUrnKe95Kq1KOl3wY6F+Knhc37lpone/sEYy3YoeXFewS
         fzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=AH7MhClip718V/rfA5fedni8qtCwNGo4Z1T8RTmuQxw=;
        b=vxzaoxEcxWQtby+qkQgmGQ/kt4fy6/9ElW+R+Y37I2BD+mAE6ezpe0wg/LWj5nz0bA
         4fLHgKk3+czGiQWe7bpJuJ2lD6mPFyq6aWXVLeal/JnJUFdHmtyPj2YoGgDuvBcBaecV
         M/hCAd/BlJfdFuhX3vecr6QhGcvaS0hB8pQZk3sX9LwQxUhZD66R3Me0NNcQRMUqJviN
         dSJ0nvTrYQrc0PF5Wx8a28MJ72QxpKHsIhtE+fUfD0AuJWHo2866P2EEMEQBwZa1qmQX
         qtUKLJUpTYIOUkahklq/Hgo5R53NkTKYyz/AwBFwCNoCNfY2lSAv2QqO76sLZijhtu0g
         /+qQ==
X-Gm-Message-State: AOAM532gkuhyO3dDeML5gb8aHYiZtxzOxBzWYYMUnJCMAJUuD6EAen/H
        bbjRht6QrhHgOecOo9j4BHa7WnyUTzvdNhip
X-Google-Smtp-Source: ABdhPJyJmYMvyrIpEHthPjEDhy2PraMPrTuVF1Dx2hZlXkakvDNBdYYxl8hSSj3rd6OyGSaOYz0NKQ==
X-Received: by 2002:a05:6402:518a:b0:416:b181:10ea with SMTP id q10-20020a056402518a00b00416b18110eamr14424770edd.276.1647688928483;
        Sat, 19 Mar 2022 04:22:08 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ky5-20020a170907778500b006d1b2dd8d4csm4803363ejc.99.2022.03.19.04.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 04:22:07 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nVX9q-003qmx-5Z;
        Sat, 19 Mar 2022 12:22:06 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/7] test-lib: add a "test_expect_todo", similar to
 "test_expect_failure"
Date:   Sat, 19 Mar 2022 12:11:10 +0100
References: <cover-0.7-00000000000-20220318T002951Z-avarab@gmail.com>
 <patch-1.7-4624abc2591-20220318T002951Z-avarab@gmail.com>
 <xmqqczij9jeg.fsf@gitster.g> <xmqq8rt77zp7.fsf@gitster.g>
 <220319.86v8waetae.gmgdl@evledraar.gmail.com> <xmqqilsa76ve.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <xmqqilsa76ve.fsf@gitster.g>
Message-ID: <220319.86ilsadw69.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Mar 19 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> emit certain output.  We may assert the ideal future world like so:
>>>
>>> 	test_expect_success 'make sure foo works the way we want' '
>>> 		preparatory step &&
>>> 		test_must_fail git foo --bad-option >error &&
>>> 		grep "expected error message" error &&
>>> 		! grep "unwanted error message" error &&
>>> 		git foo >output &&
>>> 		grep expected output &&
>>> 		! grep unwanted output
>>> 	'
>>>
>>> Let's also imagine that right now, option parsing in "git foo",
>>> works but the main execution of the command does not work.
>>>
>>> With test_expect_todo, you have to write something like this
>>> to document the current breakage:
>>>
>>> 	test_expect_todo 'document breakage' '
>>> 		preparatory step &&
>>> 		test_must_fail git foo --bad-option >error &&
>>> 		grep "expected error message" error &&
>>> 		! grep "unwanted error message" error &&
>>> 		test_must_fail git foo >output &&
>>> 		! grep expected output &&
>>> 		grep unwanted output
>>> 	'
>>>
>>> You can see that this makes one thing unclear.
>>>
>>> Among the two test_must_fail and two !, which one(s) document the
>>> breakage?  In other words, which one of these four negations do we
>>> wish to lift eventually?  The answer is the latter two (we said that
>>> handling of "--bad-option" is already working), but it is not obvious
>>> in the above test_expect_todo test sequence.
>>>
>>> I'd suggest we allow our test to be written this way:
>>>
>>> 	test_expect_success 'make sure foo works the way we want' '
>>> 		preparatory step &&
>>> 		test_must_fail git foo --bad-option >error &&
>>> 		grep "expected error message" error &&
>>> 		! grep "unwanted error message" error &&
>>> 	test_ki git foo >output &&
>>> 	test_ki grep expected output &&
>>> 	test_ki ! grep unwanted output
>>> 	'
>>>
>>> and teach test_expect_success that an invocation of test_ki ("known
>>> issue"---a better name that is NOT test_must_fail very much welcome)
>>> means we hope this test someday passes without test_ki but not
>>> today, i.e. what your test_expect_todo means, and we unfortunately
>>> have to expect that the lines annotated with test_ki would "fail".
>
>> Have you had the time to look past patch 1/7 of this series? 2/7
>> introduces a "test_todo" helper, the "test_expect_todo" is just the
>> basic top-level primitive.
>
> No, and I do not have to.  I care about the most basic form first,
> and if you cannot get it right, it is not interesting.  You can
> consider the test_ki above as the primitive form of your "test_todo"
> that says "I want the command to give true, but I know it currently
> gives false".

Sure, and I do have that implemented. If you're just asking that my
"test_todo" or another helper do that by default, then that's easy.

I.e. I've got that, but not as one short "test_*" verb.

> And quite honestly, I am not interested in _how_ it currently
> happens to break.  We may want the command being tested to
> eventually count three commits, but due to a bug, it may only count
> one.  You may say "test_todo count --want 3 --expect 1 blah", but
> the "expect" part is much less interesting than the fact that the
> command being tested on _that_ line (not the whole sequence run with
> test_expect_failure) is clearly documented to want 3 but currently
> is broken, and it can be clearly distinguished from the normal
> test_must_fail or ! that documents that we do want a failure out of
> the command being tested there.

Yes, if you don't want to test the exact behavior you have/want that's
also easy.

> So with or without the "higher level" wrappers, how else, other than
> the way I showed in the message you are responding to as a rewrite
> of the example to use test_expect_todo, that uses two test_must_fail
> and two ! and makes which ones are expected failure and which ones
> are documentation of the current breakage, do you propose to write
> the equivalent?  It may be that your test_todo may be a different
> way to spell the test_ki marker I showed above, and if that is the
> case it is perfectly fine, but I want it to be THE primitive, not
> test_must_fail or !, to mark a single command in the test that
> currently does not work as expected.

Sure, yes it's basically a different way to spell the same thing....

>> I don't think we can categorically replace all of the
>> "test_expect_failure" cases, because in some of those it's too much of a
>> hassle to assert the exact current behavior, or we don't really care.
>>
>> But I think for most cases instead of a:
>>
>> 	test_ki ! grep unwanted output
>>
>> It makes more sense to do (as that helper does):
>>
>> 	test_todo grep --want yay --expect unwanted -- output
>
> My take is the complete opposite.  We can and should start small,
> and how exactly the current implementation happens to be broken does
> not matter most of the time.

Well, the tip of this series leaves ~20 uses of test_expect_todo v.s. a
remaining ~100 uses of test_expect_failure, so it is a small start. I
converted those things I thought made the most sense.

But I do think you want to test at least a fuzzy "how exactly" most of
the time. The reason I worked on this was because while authoring the
series you merged in ea05fd5fbf7 (Merge branch
'ab/keep-git-exit-codes-in-tests', 2022-03-16) I found that we had
various test_expect_failure that failed in ways very different than what
we'd expect.

Or, saying that something exits non-zero and we'd like to fix it isn't
the same as saying that we'd like to e.g. exclude it from SANITIZE=3Dleak
or SANITIZE=3Daddress testing. I.e. it still shouldn't leak, double-free()
or run into a BUG(), and if it does we'd like to know most of the time.

I think the only sensible thing to do to fix that is to have the
semantics of test_expect_todo, within that you can always decide to
ignore individual exit codes, but you can't really do it the other way
around (which is what test_expect_failure does).


