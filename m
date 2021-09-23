Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70A3C433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 17:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95CA560F70
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 17:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbhIWRHC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 13:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbhIWRG7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 13:06:59 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D386C061574
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 10:05:28 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id y89so14859366ede.2
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 10:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=0WVWUXtS5Sn8WCzOdrlMJ7pRyjmpMVzTk6KqSuf9vSw=;
        b=J32GbsGHw8ImOv4+FQdosaoY8ourlchKcMJV6k+Mls5A9UIb1x6HbBmXz+rNzTU0Wr
         8ZUFgTsldPuF04yWRSD7N0iCjx/aAaqPjQo8LtQv4xnv+AHm3O9opEyGLUtphbc+h8ov
         z6L3FduII16XDFCq1+nc5z3n/8MqB96arWF0khJQS04OM/nTWEKzBzmZIA+GQnedFkDF
         u6z6f/EYMBSlBnvfn7/E2zCCTFdry198HZ5mwV4W7gGi+Aodhe0pxVU7xxAaqqmsupn9
         UwFOHaLT3xAqNHTYAPARkuNfFkzOTGnH+jTLRq5qEKn4phaLD1a3xrQWDBkoy3dRlywE
         jrgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=0WVWUXtS5Sn8WCzOdrlMJ7pRyjmpMVzTk6KqSuf9vSw=;
        b=EWJLgijE2htG/hrcJ8DVRhnVH71g+kT8ux3zs0IOV+aKmlNJLDXE/RRB7b3gfyfHBC
         wdpbNC6esTGEaeK1Zsx9l+u4ihgFMtFeE+w1nTHeIHKt1r7KVrWCD61e1XBG+l+jsO6/
         bRmoqKLxIRNG4iCNDRi5aApTiuImPN4HA869BndhNtFWji9LkrbeaebClb0Si/m/eXam
         GHnWq+qJIqizC+BuzGPAiO7L4iYLDARA8sFh2GcJFxv2hWN5wAu9eJxNqpDhIiEL1w0y
         MCrvIijx49IKZxDrgJMpxgWTa9Y5gm0sQNmrW5sOSHtuVqRntDvZSpfbhWBrKepLv36I
         gCOQ==
X-Gm-Message-State: AOAM532gnsh6P/hYi5d4pLDJxexEkUOSgKxMeWRYm9uqTmiJOj6RnerW
        Gm7iLi/VjKGDaC/pixB/4Hk=
X-Google-Smtp-Source: ABdhPJyAfwpRiLBHN8ZjbGncqTjC38dPU4yfTFcr9fAXRiB/ipjnThNicG9by9I7fXou2tQuP6ARcA==
X-Received: by 2002:a50:e081:: with SMTP id f1mr6903610edl.65.1632416726575;
        Thu, 23 Sep 2021 10:05:26 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k4sm3878453edq.92.2021.09.23.10.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 10:05:26 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2021, #06; Mon, 20)
Date:   Thu, 23 Sep 2021 18:51:12 +0200
References: <xmqq1r5iaj9j.fsf@gitster.g>
 <875yut8nns.fsf@evledraar.gmail.com> <xmqqczoz2qr3.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqczoz2qr3.fsf@gitster.g>
Message-ID: <87mto343ze.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 23 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> * ab/sanitize-leak-ci (2021-09-20) 2 commits
>>>  - tests: add a test mode for SANITIZE=3Dleak, run it in CI
>>>  - Makefile: add SANITIZE=3Dleak flag to GIT-BUILD-OPTIONS
>>>
>>>  CI learns to run the leak sanitizer builds.
>>>
>>>  Will merge to 'next'?
>>
>> Yes please, as noted in
>> https://lore.kernel.org/git/87r1dh8r62.fsf@evledraar.gmail.com/ more
>> leak fixes are waiting on this.
>
> Isn't the direction of dependency the other way?  Once fixes go in,
> checks will no longer complain, but until fixes are reviewed and
> applied, checking at CI will break the testing and this would need
> working around by marking various tests as "not ready to be tested".

The fixes are structured as fixing the code, and then for both
self-documentation & testing turning on:

    TEST_PASSES_SANITIZE_LEAK=3Dtrue

In the same commit, I could fix the leaks and have a second series later
for turning on the regression test, or just turning on the test and
having it kick in once it's merged with ab/sanitize-leak-ci, but waiting
until ab/sanitize-leak-ci hit master first seemed less confusing for
everyone.

But if you'd like to have 'em now with either of those caveats...

>> It seems due to the size of this series we might be better off splitting
>> up this already split-up series.
>>
>> I was trying to convince you to merge down the much more trivial changes
>> up to the <mark0> above, which are purely build system prep work. Any
>> chance you'd reconsider?
>>
>> I think a plan that might be better would be:
>>
>>  1. Eject both ab/config-based-hooks-base & es/config-based-hooks
>>  2. I'd submit a series up to the <mark0>, hopefully that can land fairly
>>     soon thereafter.
>>  3. Once that's in, another one for <mark0>..<mark1>, i.e. the "git hook
>>     run" command, but only the more basic bits, and migrating fairly
>>     simple hooks.
>>  4. Then <mark1>..<mark2>, followed by <mark2>..ab/config-based-hooks-ba=
se
>>  5. Then Emily's es/config-based-hooks.
>>
>> That's converting a 2-step process (ab/config-based-hooks-base +
>> es/config-based-hooks) into 5 steps, but I suspect it would go faster,
>> right now it seems there's no takers for a review of this rather large
>> series. What do you & Emily think?

[Just for anyone reading along, I've since pulled the trigger on that
proposed plan at
https://lore.kernel.org/git/cover-0.8-00000000000-20210923T095326Z-avarab@g=
mail.com/]

> Today I learned a phrase "six of one and half a dozen of another" ;-)
>
> I have been wondering if something like a book reading club is
> doable on the list.  A chairperson nominates (and perhaps resends) a
> series of patches that is of manageable size to be reviewed, perhaps
> even prime the discussion with some comments, likeminded folks chime
> in and we end up with a reviewed series?

Some of your colleagues at Google have been running such a review for
what I understand to have been a while, and have recently started
inviting external people. I attended one & applaud the effort.

I think we could run a similar thing here on-list if there's interest
(I'd participate). Perhaps just:

 1. Include a list of un-loved topics in What's Cooking (or someone
    could do it as a follow-up)
 2. Pick N, and distill it down to one, either asa BDFL decision or via
    some easy voting mechanism, like https://doodle.com or E-Mail replies.
 3. Send out a call for reviews with a re-send some time (a week?) later.

If you're not up for organizing it with everything you've got on your
plate I'd be up for doing it. I'd basically just:

 1. Read What's Cooking, subjectively note topics that seem to need love.
 2. Pick one for next week's on-list review club. Via the BFDL-decreed
    methof of "shuf | head -n 1" or similar.
 3. Send out weekly REVIEW CLUB E-Mail with a link to the relevant
    series (if active), or have it be a --cover-letter with a full
    re-send if it's been dead on-list for long enough for nobody to be
    bothered by two parallel threads as a result.

What do you & others think?
