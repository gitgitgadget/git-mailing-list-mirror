Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65316C7EE24
	for <git@archiver.kernel.org>; Sat, 13 May 2023 03:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241134AbjEMDIE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 23:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEMDIC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 23:08:02 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8784C12
        for <git@vger.kernel.org>; Fri, 12 May 2023 20:08:00 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1960539df06so5790764fac.1
        for <git@vger.kernel.org>; Fri, 12 May 2023 20:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683947279; x=1686539279;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPYsybv/dv2fB/WQJvWzy+E3uNOKJQnTdqHWHjlyZTo=;
        b=UgTfMcecriqnRYj7ojS23hk9ms+eqOdmKR7ZG3SxzEn8bkY3nTw7nrhebaS5B69cbK
         vvurFuPbxMTcM+wiyG9DEzwdQ17vDNCvzDZGmpZIlRugMelhis1pMO0y3CZ6HN/XZtCR
         XuO4oxLqst1J9j1YzgOALs7GNWMDNkihylXCtizzBZiUYAsNtQU0f82z40+Boy5Edv5C
         lHviarjTZLDhZMjQaVvqJpeSbRqhhjpIP8Rrj7tOGx7GO37sHaQIg4pevygxXrGMEP30
         wYPMp7jP2SqECKeK83FaX3ZTluy9wW/94xEURCxP5UkVpFHo8kAG6vdrKmpq2Xzvazgb
         rShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683947279; x=1686539279;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sPYsybv/dv2fB/WQJvWzy+E3uNOKJQnTdqHWHjlyZTo=;
        b=MAl0/xwmePYi55KMkLKnSczBKZlQqxIuD7Hj1YJYizTwUwUM6uBtYtnKVzeGxJO1LR
         vbLQWZDUcofj11YqAZ+bzKynCTqCTNAi/pXEDU2awgkEGpYdSRMGoW5ARRWj6M3A/UA4
         ngVYAiWC33ecA/VV+9Wdms5Boe7kODFTTJfUH2gi9M3svbvdrxKWBmu0O8mU9bQFzI1p
         QlW/xrPoWQ0iVg+urmROwfcAlpJqbOlLyawZDKdHQiPZCTxgwKZwCQjCqzM9saH89HuT
         NE2DvXpv2Bbr+1+FacTifxnnyR/FMYtUDnG8V76AkcwTExhx/X5Cw1LWZoJhazzCaJVi
         wf+A==
X-Gm-Message-State: AC+VfDx35yftEp9SOJQlvuHkcJFW5+u0rp+rPeHOoLhObgW+/wPk5/Ol
        xC8jcHiQqHUUNxE25k5V/sc=
X-Google-Smtp-Source: ACHHUZ6Og/0YMRaPB6fEqz35Vp5sHLiEZpal5eNRTXs+pljKbRm0sQpTemFzJ28hNyAATW2n9hqdLg==
X-Received: by 2002:a05:6871:6aa3:b0:196:4cb3:8e6e with SMTP id zf35-20020a0568716aa300b001964cb38e6emr6321463oab.12.1683947279505;
        Fri, 12 May 2023 20:07:59 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id g5-20020a05687085c500b00187e500e7b3sm9722732oal.49.2023.05.12.20.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 20:07:58 -0700 (PDT)
Date:   Fri, 12 May 2023 21:07:57 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <645eff0d77c74_21b4f8294d5@chronos.notmuch>
In-Reply-To: <20230511012558.GA1464167@coredump.intra.peff.net>
References: <xmqqfs8bith1.fsf_-_@gitster.g>
 <20230505165952.335256-1-gitster@pobox.com>
 <645995f53dd75_7c6829483@chronos.notmuch>
 <xmqqsfc62t8y.fsf@gitster.g>
 <6459c31038e81_7c68294ee@chronos.notmuch>
 <xmqqjzxgzua0.fsf@gitster.g>
 <645c25dcb590b_7b63e294ea@chronos.notmuch>
 <645c2bc57fdd0_7c6152945e@chronos.notmuch>
 <20230511012558.GA1464167@coredump.intra.peff.net>
Subject: Re: [PATCH v2] diff: fix interaction between the "-s" option and
 other options
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Wed, May 10, 2023 at 05:41:57PM -0600, Felipe Contreras wrote:
> > Felipe Contreras wrote:
> > > Junio C Hamano wrote:

> > > > And it led to unproductive and irritating waste of time number of times, and
> > > > eventually you were asked to leave the development community for at least a
> > > > few times.
> > > 
> > > That is blatantly false. As a member of Git's Project Leadership Committee, you
> > > should know precisely how many times the committee has excercised this power,
> > > and it hasn't been "a few times", it has been one time.
> > 
> > And for the record: that one time I was asked by the committee to not interact
> > with certain members of the community for a few months.
> > 
> > The amount of times I was asked to "leave the development community" is *zero*.
> 
> You're right, in the sense that the first time you were asked to leave
> we did not have a CoC,

That is is once again: *false*.

The git community has *never* asked me to leave.

> Likewise, many times during which your behavior has been a problem on the
> list,

False: it was not a problem on the list, it was a problem *for some people* on
the list.

> people did not ask you to leave, but simply said "I am not going to read your
> messages anymore".

Yes, and for every person who has said "I am not going to read your messages"
publicly, I received a response saying "thank you for saying what we are all
thinking but cannot say aloud for fear of reprisals" privately.

You do understand that people have different opinions? Some people hate Donald
Trump, some people don't. And some people cannot express their honest opinion
at $dayjob.

Having a different opinion is OK. And the foundation of a functioning civilized
democracy is to tolerate the opinions of others.

> For example, here's Junio asking you to leave in 2013:
> 
>   https://lore.kernel.org/git/7vsj0lvs8f.fsf@alter.siamese.dyndns.org/

Read the thread.

My objective was to show that the code organization was wrong, and libgit.a was
not an actual library. If there ever was any hope of having an actual libgit
library, the code needed to be reorganized:

====
  The plan is simple; make libgit.a a proper library, starting by
  clarifying what goes into libgit.a, and what doesn't. If there's any
  hopes of ever having a public library, it's clear what code doesn't
  belong in libgit.a; code that is meant for builtins, that code belongs
  in builtins/lib.a, or similar.
====
Felipe Contreras: [1]

The whole libification project of Google proves I was right: git was not (and
is not) ready to be a library. libgit.a is not nearly close to be an actual
standalone library. Pretty far from it.

Just today Elijah Newren sent a 27-patch series [2] attempting to move in the
right direction, but doesn't even begin to tip the scales to make libgit.so
possible.

My proposal did receive positive feedback:

====
  Nice joke patch to illustrate your point ;)
====
Ramkumar Ramachandra: [3]

====
  This is a good example: yes, I'm convinced that the code does need to
  be reorganized.
====
Ramkumar Ramachandra: [4]

Even you yourself provided useful positive feedback based on my proposal:

====
  If we want to start caring, then we probably need to create a separate
  "kitchen sink"-like library, with the rule that things in libgit.a
  cannot depend on it. In other words, a support library for Git's
  commands, for the parts that are not appropriate to expose as part of a
  library API.
====
Jeff King: [5]

Junio also provided good feedback initially:

====
  Another thing to think about is looking at pieces of data and
  functions defined in each *.o files and moving things around within
  them.  For example, looking at the dependency chain I quoted earlier
  for sequencer.o to build upload-pack, which is about responding to
  "git fetch" on the sending side:

  ...

  It is already crazy. There is no reason for the pack sender to be
  linking with the sequencer interpreter machinery. If the function
  definition (and possibly other ones) are split into separate source
  files (still in libgit.a), git-upload-pack binary does not have to
  pull in the whole sequencer.c at all.
====
Junio C Hamano: [6]

Things started to turn south when I expressed the following opinion:

====
  But init_copy_notes_for_rewrite() can *not* be used by anything other
  than git builtins. Standalone binaries will never use such a function,
  therefore it doesn't belong in libgit.a. Another example is
  alias_lookup(). They belong in builtin/lib.a.
====
Felipe Contreras: [7]

Junio asked me for an example of a function that would not belong to libgit.so,
and I said `init_copy_notes_for_rewrite()` is an example of a function that
nothing outside the `git` binary would need.

====
  But that is not a good justification for closing door to others that
  come later who may want to have a standalone that would want to use
  it.  Think about rewriting filter-branch.sh in C but not as a
  built-in, for example.
====
Junio C Hamano: [8]

I argued nobody would actually do that, and I was right, as eventually
filter-branch.sh was rewritten in C, but as a builtin, as I said it would.

Junio then argued that there was no justification for my claim that certain
functions would only be used by git builtins, and therefore they should not
belong in a libgit.so library:

====
  >> You still haven't justified why we have to _forbid_ any outside
  >> callers from calling copy_notes_for_rewrite().
  >
  > Because only builtins _should_ use it.

  And there is no justification behind that "_should_" claim; you are
  not making any technical argument to explain it.
====
Junio C Hamano: [9]

Google's libification project proves I was right: some functions should not
belong in libgit.a.

If Junio had listened to me back in 2013, the changes Google developers are
working on now to make libgit.a something that remotely resembles an actual
library would not be as monumental as they are in 2023.

Instead of considering my argument, Junio chose to attack me personally:

====
  I do not see a point in continuing to discuss this (or any design
  level issues) with you.  You seem to go into a wrong direction to
  break the design of the overall system, not in a direction to
  improve anything.  I do not know, and at this point I do not care,
  if you are doing so deliberately to sabotage Git.  Just stop.
====
Junio C Hamano: [9]

Even if Junio's opinion was the correct one (it's not: as Google's libification
project proves), it's not OK to personally attack a contributor merely for
expressing an opinion that happens to differ from that of the maintainer.

I am entitled to have my own opinion.

I already know what you are going to argue back: you are going to argue that
Google's libification project is different from my argument, but it's not:
Emily Shaffer's introductory mail explained the same thing:

====
  In other words, for some modules which
  already have clear boundaries inside of Git - like config.[ch],
  strbuf.[ch], etc. - we want to remove some implicit dependencies, like
  references to globals, and make explicit other dependencies, like
  references to other modules within Git.
====
Emily Shaffer: [10]

Google developers clearly believe the boundaries between "modules" are not
clear, and they should be. Which is *exactly* what I argued back in 2013.

You say Junio asked me to leave, but you conveniently avoid explaining *why*:
because he didn't like my opinion.

Junio was not content with simply saying "let's agree to disagree", he threw yet
another personal attack:

====
  So I do not think this is not even a bikeshedding.  Just one side
  being right, and the other side continuing to repeat nonsense
  without listening.
====
Junio C Hamano: [11]

And then:

====
  But what followed was a nonsense, which ended up wastign everybody's
  time:
====
Junio C Hamano: [12]

This breaks the current code of conduct, as it clearly is a behavior that is
not:

 * Demonstrating empathy and kindness toward other people
 * Being respectful of differing opinions, viewpoints, and experiences

This is what I objectively did *not* do in that thread:

 * Denigrate the opinions of others
 * Personally attack anybody

It was Junio the one who did that, not me.

Junio asked me to leave because I expressed an *opinion* he did not like.

Junio asked me to leave because I said in my opinion `copy_notes_for_rewrite()`
does not belong in libgit.a, because only git builtins should use it.

That's it.

I think it's incredibly deceitful of you to claim "Junio asked you to leave"
and provide a link, without explaining *why*.

Fast-forward to 2023, and Google developers are using the same language as I
did in 2013:

====
  Strbuf is a widely used basic structure that should only interact with other
  primitives in strbuf.[ch].
====
Calvin Wan: [13]

Is Junio asking them to leave the project for merely daring to express an
opinion about what *should* be the direction the Git project takes?

Of course not.

Ironically, the link you shared is a perfect example the double standards of
the Git project, in which a normative statement from a Google employee is par
for the course, but a normative statement from an unaffiliated contributor
(i.e. me) is complete heresy.

All of this is of course, nothing more than a smoke screen from the topic at hand.

---

This is the topic:

Subject: Re: [PATCH v2] diff: fix interaction between the "-s" option and other options

All that matters here is this:

 1. Apply Junio's patch
 2. Run this command `git diff -s --raw @~`

Does the command produce the same output before and after the patch? Yes or no.

That is it.

Stop dragging personal drama between Junio and me from 2013 in which nobody
else participated--including you--and answer the *only* relevant question in
this thread.

Does Junio's patch change the current behavior?

 a. Yes
 b. No

Cheers.

[1] https://lore.kernel.org/git/CAMP44s0cozMsTo7KQAjnqkqmvMwMw9D3SZrVxg48MOXkH9UQJQ@mail.gmail.com/
[2] https://lore.kernel.org/git/pull.1525.v2.git.1683875068.gitgitgadget@gmail.com/
[3] https://lore.kernel.org/git/CALkWK0mA7MXQv1k5bFpZLARDOHxU5kzKFXzcyUfb6NLZZY-=FA@mail.gmail.com/
[4] https://lore.kernel.org/git/CALkWK0=7PRndNc7XQ-PCPbVCp9vck909bA561JhQG6uXXj1n4g@mail.gmail.com/
[5] https://lore.kernel.org/git/20130610220627.GB28345@sigill.intra.peff.net/
[6] https://lore.kernel.org/git/7vwqq1ct0g.fsf@alter.siamese.dyndns.org/
[7] https://lore.kernel.org/git/CAMP44s03iXPVnunBdFT8etvZ-ew-D15A7mCV3wAAFXMNCpRAgA@mail.gmail.com/
[8] https://lore.kernel.org/git/7vppvsbkc3.fsf@alter.siamese.dyndns.org/
[9] https://lore.kernel.org/git/7vobbca1sr.fsf@alter.siamese.dyndns.org/
[10] https://lore.kernel.org/git/CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com/
[11] https://lore.kernel.org/git/7vehc8a05n.fsf@alter.siamese.dyndns.org/
[12] https://lore.kernel.org/git/7vzjuv14ir.fsf@alter.siamese.dyndns.org/
[13] https://lore.kernel.org/git/20230503184849.1809304-1-calvinwan@google.com/

-- 
Felipe Contreras
