Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3F6C433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 11:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B00D61437
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 11:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbhDULWI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 07:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbhDULWG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 07:22:06 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4198C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 04:21:33 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id j7so12006830eds.8
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 04:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=hKbsTn4saLMQb+WnL+zHGMnVhwt7OHRCABXEg/OjKx8=;
        b=JoYNLKuAox/itLDTsVbFIys/dukSzckFX9XfoIkLm2wHzDWPsu5fNhc3mceIyM+feu
         IeekcHxLB3FprcIrM2jDWy5KK0qGPoNo6rG2182ABbODr6cPr07AcCf+CCjZ39G4xzgQ
         jTjISm6zcAfgD/d6cxP/8hWBCedus3MqPdRACEqFNoBxMMB9QzJJGtexh8PpKl7u4uDc
         xPVuVWmJc6TKxZsuLgp6iMGHOhWWsIW6qAxvNh8p9ZzPtpji+UwSA32aaaHAJpCgBZKY
         4vy2Vb4k7N7HTU0o702zNdOY9O1dG584x+iyp4qjIuWP2fqyA7eIyTV4u6jMgEs48E7t
         yzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=hKbsTn4saLMQb+WnL+zHGMnVhwt7OHRCABXEg/OjKx8=;
        b=HizL+n3AH5cmW7+at3FUcmtHNfJjAsIPwQO3ZC7yeykaW59pJ51SR8Ne9OHW1wcP7Y
         Y/24eVFP3KtPwurY3IF1oYpI5BKJQJXJQmQNEyuQHSAhpPSW97Wj5LoxPp0O+zvliDe6
         pHJ5dItAaPGDRubEpw64HS+TUgsBpAhyiLO20o4TPLZrUzY8HOPr9R2SzJcCncSlW0x/
         2w8XLO7Dylc7hZrbyWHll8CbsBlmb+q9Ttn84yd9QXDUr9HQgxg4A4L5NFEhqXJmtMf5
         4EImizGilVLeyQBurxJmUcXfe71R/mevX8mBu55Ag9x7wcHsjt0MVKs8R+1yuxBQbq6O
         B1Cw==
X-Gm-Message-State: AOAM533TMS2IIkaWt+vnyn9AZYuqo094TESl+HUKhu3WgNsnUlWUoCnU
        4CKOzARz0G5XcbQqWdpDmgTHTIpclFqJ2w==
X-Google-Smtp-Source: ABdhPJxQkydWZzoDqzAIAEDL1eewHLrYfbOf4tIWQgXbGTM4v5IR3aAMgEsjZVcdKEWHlOsnH5Z1BA==
X-Received: by 2002:aa7:d2d6:: with SMTP id k22mr35310902edr.9.1619004091869;
        Wed, 21 Apr 2021 04:21:31 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id w13sm3067079edx.80.2021.04.21.04.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 04:21:31 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v7 00/28] reftable library
References: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
 <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com>
 <878s5c3wti.fsf@evledraar.gmail.com>
 <CAFQ2z_MF3SbKf8yXBvkOcLGg03dVxJW3F=c6ZDUtstEbZUUMCQ@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <CAFQ2z_MF3SbKf8yXBvkOcLGg03dVxJW3F=c6ZDUtstEbZUUMCQ@mail.gmail.com>
Date:   Wed, 21 Apr 2021 13:21:30 +0200
Message-ID: <87lf9b3mth.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 21 2021, Han-Wen Nienhuys wrote:

> On Wed, Apr 21, 2021 at 9:45 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> > The commits up to "hash.h: provide constants for the hash IDs" should =
be
>> > good to merge to 'next'.
>>
>> With how Junio queues things up perhaps submitting this as another
>> "prep" series would be good, to reduce future reviewer fatigue,
>> i.e. anything we can make land on master makes re-rolls that much
>> smaller.
>
> will do.
>
>> > There are several test fixups, but I've put them in another series bec=
ause
>> > GGG enforces max 30 commits.
>>
>> I left a bunch of comments on the test prep series now. Probably good to
>> have it split up regardless of GGG limits.
>>
>> Re the comments I left on the test series. I'm very happy to see the
>> start of addressing the "it must be tested" concerns I had in
>> https://lore.kernel.org/git/87wnt2th1v.fsf@evledraar.gmail.com/
>
> It may look like the start, but I've been improving the number of
> tests that pass continuously since I posted the first version of this
> code over a year ago.

FWIW I meant or meant to say something closer to "a start at the
numerous failures I noted in the v6 discussion", not "no work has been
done at all on this front". Sorry.

>> I don't see the point of having re-rolls of this topic while the test
>> changes topic it's based on hasn't finished
>> marking/splitting/refactoring the various tests that do and don't depend
>> on the file backend.
>>
>> At least when I review it I'm just left with going in circles digging
>> into one of those failing test, figuring out if it's really
>> refs/files-backend.c specific or not etc., and as long as we can't turn
>> on GIT_TEST_REFTABLE=3Dtrue in CI as part of this series I don't see a
>> path to making it advance to next->master.
>
> The point of posting updates is to garner feedback, especially from
> people familiar with the Git code itself.

So you agree that we should make the tests pass first, then shouldn't
these me marked as RFC/PATCH?

I for one would find that a lot less confusing, "PATCH" means "the
author considers this ready to land on master sans undiscovered bugs
etc.

> If you would like this effort to move forward faster,

Yes, I'm keen to help move it forward.

I am saying that I think for me or anyone else to do that in any
sensible way the path forward is to make the tests pass with
GIT_TEST_REFTABLE=3Dtrue.

IOW a large part of the feedback you're looking for is already part of
the codebase. Nobody can keep all of it in their head, but we've encoded
all the tricky edge cases we could think of in the tests.

So in particular per my feedback on the test series: It's only when we
start digging into those tests that we discover the interesting bits,
i.e. how things like .git/SOME_FILE behaves per[1], and my comments
about reflog behavior in [2].

Anyway, I think I'm just repeating myself at this point, but part of the
reason is that I don't think I've gotten a straight answer about the
point-by-point questions I had in [3].

I.e. reaching some consensus on things like whether
GIT_TEST_REFTABLE=3Dtrue passing under CI being a hard-prereq for this
series or not is surely one of the first things to sketch out before
figuring out how to move this forward.

Also, with how unhappy Junio is with my patch-dumping I'm probably the
last person to give advice about managing mailing list attention, but
still: here's an attempt:

In v6 I noted that t5510-fetch.sh had a segfault[4], you said you'd
check it out, and reading your cover letter nothing stood out about
that, so I assumed it was sorted out somehow.

But running it now yields a BUG() instead:
=20=20=20=20
    BUG: refs.c:1038: free called on a prepared reference transaction
    Aborted
    [...]
    not ok 18 - fetch --atomic aborts all reference updates if hook aborts

And trying the whole test suite with --verbose-log yields:
=20=20=20=20
    $ grep -e 'Segmentation fault'  -e BUG: test-results/*
    test-results/t0210-trace2-normal.out:BUG: t/helper/test-trace2.c:206: t=
he bug message
    test-results/t1400-update-ref.out:BUG: refs.c:1038: free called on a pr=
epared reference transaction
    test-results/t1400-update-ref.out:BUG: refs.c:1038: free called on a pr=
epared reference transaction
    test-results/t4058-diff-duplicates.out:Segmentation fault
    test-results/t4058-diff-duplicates.out:Segmentation fault
    test-results/t4058-diff-duplicates.out:Segmentation fault
    test-results/t4058-diff-duplicates.out:Segmentation fault
    test-results/t5510-fetch.out:BUG: refs.c:1038: free called on a prepare=
d reference transaction
    test-results/t5510-fetch.out:BUG: refs.c:1038: free called on a prepare=
d reference transaction
    test-results/t5600-clone-fail-cleanup.out:Segmentation fault
    test-results/t5600-clone-fail-cleanup.out:Segmentation fault
    test-results/t5600-clone-fail-cleanup.out:Segmentation fault
    test-results/t5601-clone.out:Segmentation fault
    test-results/t6423-merge-rename-directories.out:                test_i1=
8ngrep ! BUG: err &&

Not all of that is yours, FWIW "seen" is currently doing, and the "diff"
failures are ac14de13b2 (t4058: explore duplicate tree entry handling in
a bit more detail, 2020-12-11).
=20=20=20=20
    $ grep -e 'Segmentation fault'  -e BUG: test-results/*
    test-results/t0210-trace2-normal.out:BUG: t/helper/test-trace2.c:206: t=
he bug message
    test-results/t1406-submodule-ref-store.out:BUG: refs/files-backend.c:13=
9: operation pack_refs requires abilities 0x6, but only have 0x5
    test-results/t1406-submodule-ref-store.out:BUG: refs/files-backend.c:13=
9: operation create_symref requires abilities 0x2, but only have 0x5
    test-results/t1406-submodule-ref-store.out:BUG: refs/files-backend.c:13=
9: operation delete_refs requires abilities 0x2, but only have 0x5
    test-results/t1406-submodule-ref-store.out:BUG: refs/files-backend.c:13=
9: operation rename_ref requires abilities 0x2, but only have 0x5
    test-results/t1406-submodule-ref-store.out:BUG: refs/files-backend.c:13=
9: operation delete_reflog requires abilities 0x2, but only have 0x5
    test-results/t1406-submodule-ref-store.out:BUG: refs/files-backend.c:13=
9: operation create_reflog requires abilities 0x2, but only have 0x5
    test-results/t4058-diff-duplicates.out:Segmentation fault
    test-results/t4058-diff-duplicates.out:Segmentation fault
    test-results/t4058-diff-duplicates.out:Segmentation fault
    test-results/t4058-diff-duplicates.out:Segmentation fault
    test-results/t6423-merge-rename-directories.out:                test_i1=
8ngrep ! BUG: err &&

Anyway, the "clone"/"fetch"/"update-ref" failures look new with
GIT_TEST_REFTABLE=3Dtrue.

So to close up the attempt at getting feedback: I think we'd probably be
better off still discussing "I tried this to fix the segfault, but now I
get this BUG" rather than a 30 patch re-roll.

>  I am most in need of review for the part that glues the library
> together with the git code itself (ie. the commit introducing
> refs/reftable-backend.c).

In other and briefer words I don't think this series is in need of
review at this point, it's in need of *addressing* review, where review
is both the ghosts from the past of failing tests, and outstanding
segfaults/BUG()s being hit.

1. https://lore.kernel.org/git/87k0ow2n29.fsf@evledraar.gmail.com/=20
2. https://lore.kernel.org/git/87pmyo3zvw.fsf@evledraar.gmail.com/
3. https://lore.kernel.org/git/87wnt2th1v.fsf@evledraar.gmail.com/
4. https://lore.kernel.org/git/87im4qejpk.fsf@evledraar.gmail.com/
