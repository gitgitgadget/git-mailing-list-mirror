Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF602C433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 11:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351658AbhLCLFu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 06:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbhLCLFs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 06:05:48 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E49C06173E
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 03:02:24 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id e3so9973304edu.4
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 03:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=bbtl9A2z+blWIQb0I0X9YMx1nFcUNhWLaxi7T9cU/5I=;
        b=E9v928SIwi0pUdpSErRal2Ytp6En3TGBgGUt4nJdrKnyVXteDYZTyh9kpN7kWy4DL2
         VIKmIT7LiWqGHRMbx3M0onzcKoJGYrgx/A64BuWpZNDdc2tLgY9sDyHmaqS9RWDGn00i
         sRcifubKgqdhKW7ZdCjN4H3uol2TaPdjxa6DRxqDI0MSWYrWXenGN4fu3zSH8fv8YkGN
         /LLHJ0gmzNFm+NNeuA/Mox+NjGzuL29zQK4i2u2NGrO8qviQmKPMIZa9JFGEYK3cBRbB
         AeExvcybVS+Nx5UUZ96I1MTfpRne7GPkEEYJhCwt/aqPs8/O0n+ORrn0uXh/g07Y0R3/
         I8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=bbtl9A2z+blWIQb0I0X9YMx1nFcUNhWLaxi7T9cU/5I=;
        b=bPPzdWHPszkpMVccYS3sj0NNHrMHBtiHhdB/mbpqRvi64uhcq3d/CHPXsV3jl0I0ZT
         q9PnWEkKJRZy8+7CS4gt8etxG349I9YWj1uSN88V9a5rlVMh8PY47AsAoEWNCrJ/Zol8
         ia5MYaIueXmDMetpv04g/dAfM8VkWjEMO0oVkWccIj1h6NxDD8msggEUpuwWt8YUD07M
         +S8IRAk1f6PuUPciAFjTrRrDfQr5RYxXhfwpLAaDBOUt3PmSq+pL+GSLk9GvINBw4IQd
         k+1Md/SOw0Y1tuu/acHSO2njekM1VfigrqUpccmp5BF9ZCmNoXabKpYQMZxH+aYHYMAL
         oFMw==
X-Gm-Message-State: AOAM531FJZttsGKbz60OWn3gf6AIrk2PkAsDoYMor3KYDWMCDMtxoBgS
        iMBXvPzImdxAWpqVnPRz/rw=
X-Google-Smtp-Source: ABdhPJxk7BRxA+dIUBJXe2MF491Bo2eHrGrcd4fhWAv183V7kz5dILev25xCZE4xYq2py4VDI28rkA==
X-Received: by 2002:a05:6402:2686:: with SMTP id w6mr25699689edd.141.1638529342515;
        Fri, 03 Dec 2021 03:02:22 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id u10sm1675724edo.16.2021.12.03.03.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 03:02:21 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mt6Ka-0005Ya-At;
        Fri, 03 Dec 2021 12:02:20 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v3 10/10] progress.c: add & assert a "global_progress"
 variable
Date:   Fri, 03 Dec 2021 11:29:26 +0100
References: <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com>
        <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com>
        <patch-v3-10.10-01d5bbfce76-20211013T222329Z-avarab@gmail.com>
        <20211025050202.GC2101@szeder.dev> <xmqq35op4f7n.fsf@gitster.g>
        <20211202231421.GA624717@szeder.dev>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211202231421.GA624717@szeder.dev>
Message-ID: <211203.868rx2t0hv.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 03 2021, SZEDER G=C3=A1bor wrote:

> On Mon, Oct 25, 2021 at 02:38:04AM -0700, Junio C Hamano wrote:
>> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>>=20
>> > I still very much dislike the idea of a BUG() in the progress code
>> > that can trigger outside of the test suite, because the progress line
>> > is only a UI gimmick and not a crucial part of any Git operation, and
>> > even though a progress line might be buggy, the underlying Git
>> > operation is not affected by it and would still finish successfully,
>> > as was the case with the dozen of so progress line bugs in the past.
>>=20
>> I too recall that we have fixed numerous bugs in the past year in
>> the area, but weren't they kind of obvious ones _once_ they are
>> pointed out at you (e.g. progress never reaching to 100%)?  Yet the
>> developers have failed to catch them because their eyes would coast
>> over without paying attention to them, exactly because the progress
>> bar is merely a UI gimmick.
>>=20
>> I haven't formed a firm opinion on this yet, but I think the idea
>> behind these BUG() is to help such problems be caught while they are
>> still in the lab.  You may not notice when your live progress bar
>> behaved a bit funny, but if you hit a BUG(), that would be squarely
>> in your face and you cannot ignore it.
>
> The "outside of the test suite" part is important.  Running the test
> suite with a GIT_TEST_CHECK_PROGRESS knob is sufficient to catch these
> issues as my inital two patch series have shown at the very beginning
> of this thread before =C3=86var hijacked them.

FWIW I didn't hijack and adjust your patches to be BUG() instead of a
test mode. We came up with more-or-less the same thing
independently around the same time.

You submitted yours on the 20th of June, but I hacked up mine on top af
on already-WIP series I had ~5 days earlier in response to another
discussion about progress.c[1]. You submitter yours first, and I then
replied to the effect of "here's a similar thing I had locally, RFC"[2].

Or do you mean the smaller "fix bogus counting" fixed that are now
landed[3]? I just wanted to push that forward since it seemed you
weren't per[4]. Sorry if I stepped on any toes there...

> Interested Git developers
> can even enable it in their .profile if they wish; I did so with
> GIT_TEST_SPLIT_INDEX for a while to expose some of my patches to more
> real-world use.
>
> However, I think it's conceptually a bad idea to abort with a BUG() an
> otherwise successful Git operation by default, when that bug happens
> to be in such an ancillary component as the progress display, and find
> the justifications given in the commit message unconvincing.

I think it's important to get to the root of what we really disagree
about here.

We hard die on all sorts of trivial things in BUG() already, as paging
through this shows:

    git grep -w -F 'BUG('

I.e. the general criteria for BUG() isn't whether we could
hypothetically recover from the scenario.

Which, if you adjust the code around many existing BUG()s to trigger the
"bad thing" (as it were..) is the case. I haven't done any exhaustive
checking, but I'd bet it's more common than not, or at least something
like 1/4 or 1/8 of them.

Rather it's a combination of:

 A. This should absolutely not happen
 B. We are sure (or are sure as we can be) that it doesn't
 C. We think if it does, we'll know/really want to know via tests/early int=
egration testing.
 D. We mark it with a BUG() because we're as confident as we reasonably can=
 be in A and B

I took your earlier comments to mean that you agreed on "A", but you
weren't so sure about "B". I agree that without confidence about "B"
that having "D" would be overzealous.

But here with your mention of "conceptually a bad idea to[...]" I'm not
so sure, i.e. it seems like you're saying that you're categorically
opposed to such use of BUG(). I think that's a fair stance to take if
that's what you're going for, but per the above I also think it's true
to say that a lot of our existing use of that API doesn't match that
worldview. I.e. it's not an UNRECOVARABLE_BUG(), but
SHOULD_NOT_ESCAPE_DEVELOPMENT_BUG().

I think that in this case we should be confident that we've got "B", as
explained in detail in the upthread patch[5].

I would be exceedingly paranoid about more exhaustive checks, e.g. I
don't think we've got enough coverage to have BUG() checks for some of
the things you added test-only asserts (which would be good) for in your
initial series.

I.e. asserting whether we hit 99% and not 100%, whether
display_progress() "misses" updates, or if we miss a call to
stop_progress(), or whatever else one might assert.

I've been running my personal git with many of those sorts of pedantic
assertions for a while now, but I'm still not confident those changes
are OK to submit for inclusion. I very much share your concerns in that
area.

But I think (and [5] argues) that it's *much* easier to be confident
about the narrow BUG() assertion being added here.

I.e. it's trivial to discover that almost all callers of progress.c are
never going to start more than one progress bar ever, so we can discard
those out of hand. For the rest they're rather easily auditable.

But clearly you disagree, and I thinks it helps neither of us to just
repeat our points, which is not what I'm trying to do here, but to get
to the following:

 - Can you cite specifically what about [5] you think wouldn't catch any
   cases where we couldn't be certain about the BUG(). I.e. it outlines
   the sort of testing I did, which involved forcing all hidden progress ba=
rs
   to ignore their existing isatty() checks, adding more pedantic asserts
   to narrow down potentially affected callers etc.

   Do you think that testing could have missed something? How & why?

 - Related to that, are there cases where you would agree that we've got "B=
",
   as opposed to others where we don't?

   As I've argued I do think these patches are ready as-is, but one alterna=
tive
   way forward with them would be to add the BUG() to everything, but white=
list
   those current callers that have >1 progress bar. Then as a (slow) follow=
-up
   proceed to un-whitelist those one at a time.

I'm not familiar with the GIT_TEST_SPLIT_INDEX changes you're
mentioning, but I'd think that those cases would have been more complex
(the code flow around index-related stuff) than the progress API users.

1. https://lore.kernel.org/git/87o8c8z105.fsf@evledraar.gmail.com/
2. https://lore.kernel.org/git/cover-00.25-00000000000-20210623T155626Z-ava=
rab@gmail.com/
3. https://lore.kernel.org/git/cover-v4-0.2-00000000000-20210909T010722Z-av=
arab@gmail.com/
4. https://lore.kernel.org/git/cover-0.3-0000000000-20210722T121801Z-avarab=
@gmail.com/
5. https://lore.kernel.org/git/patch-v6-8.8-bff919994b5-20211102T122507Z-av=
arab@gmail.com/
