Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57CCC77B73
	for <git@archiver.kernel.org>; Sun, 30 Apr 2023 06:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjD3Gp1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Apr 2023 02:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjD3GpZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2023 02:45:25 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915F9E6
        for <git@vger.kernel.org>; Sat, 29 Apr 2023 23:45:23 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2a8ba693f69so12683891fa.0
        for <git@vger.kernel.org>; Sat, 29 Apr 2023 23:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682837122; x=1685429122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n84I9h49C0WCndWHyhn9IFTSBUV+BQ8FBoykTGHsC4I=;
        b=VTw9RQd8ENJvfI4yBiZs9JsgQVoYu/wdlJs7/qNsBiCUn7P0J+phNd3vWNrpOcG40M
         yk5Srg3vRWfRmLG+X0zWGC5+88dPCIkaBzUWLfgZaEKMO7Lah+57yOL7j4ju/O5icNpQ
         LiQNt1DzihECDMHHra5tVAhUZhClkFetGEdIdYtOgYVM8h9+IBr6IJPngG11NbjkYE6a
         PQmeM8z8me21WA56DzKzCOE+cXsiGgEScpCBH4SdjrfX96Nmz5HzgsxaS9Q8FyNymR6T
         7A31x7qnDYVTxqLF+NtmDrkckSzFrfg0fm7BD1jc4dVF1pe6uJYUPM/WB7X+EjqbyApH
         LZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682837122; x=1685429122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n84I9h49C0WCndWHyhn9IFTSBUV+BQ8FBoykTGHsC4I=;
        b=clusSAMIoyc1wR5GHA4x8F0szzvQdbUrfPRd3cEB2NeCQTC6EQGdyy6AOSoEV21kQ3
         5c06lr0XphXv6EWamc2oFM6FwuT0aLa6V7lhs58eeRwZG9RgD6cfKhvMEKcTGvOrB/wU
         UU8VWMMCdpwP0nj2R3pxTvZlKT44SxzXBbYJRugp5Imxw8HtOuxeqECyd0fN15abQOSm
         w8GUy8Chzu6mPMZTmX4FyIXcTbkjOQTrY0eCiXgSitcshj4of7ugE/G01jvnYdpNXlxp
         ihbn5Pj9aNjdkhKxKSDjHU0yDvJkbJtHDHtmT6AvQTWqumEf8KN6idk6g4jTnFlM4mU4
         bNPg==
X-Gm-Message-State: AC+VfDxg3HbSRmSPm2yaohajtolFJKTt1rzvxV7TiOKNlM3W5iNAsW9L
        A16u0wKBESEurboXqJA509hZZ0kWn2DJRTZGNzY=
X-Google-Smtp-Source: ACHHUZ6rpFRg1PmmNPcihyJZO8gwV2I3zojVQMMkJgwkemLiITM/9LmkP5ZDzxMbDlcj9zPEgwb7CvYx5dTPO4UMnKY=
X-Received: by 2002:a2e:8602:0:b0:2a8:b350:3a6b with SMTP id
 a2-20020a2e8602000000b002a8b3503a6bmr2707904lji.28.1682837121453; Sat, 29 Apr
 2023 23:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230407072415.1360068-1-christian.couder@gmail.com>
 <20230407072415.1360068-12-christian.couder@gmail.com> <8daf2603-2818-9c9d-7a06-6af2872a045a@github.com>
 <89c78da5-388a-e52b-b20b-e376ac90de14@github.com> <CABPp-BGfG3VeY1gOugzig8PLan1AS66BMWnyFSOsLOy-zqLdXw@mail.gmail.com>
 <b9732826-5732-0f87-9527-f49c38514fd7@github.com> <CABPp-BG3xNmwbtu+tstLr8bT24rr0gG65ZvD1rEeus_V8OYk=Q@mail.gmail.com>
 <bbdd3697-bc10-f311-dbef-99917603ce4f@github.com> <CABPp-BH5rLZyjLD91Bn=xThMXHk=q+kGcqPjPDOT0-N4fHfquA@mail.gmail.com>
 <f5dd91a7-ba11-917a-39e2-2737829558cb@github.com> <CABPp-BFCKrbSZQtRD1MnXrwB91O2YK9ZuGd6BiYQZ2zrpLp+uw@mail.gmail.com>
 <58f7918f-6ca3-2158-7d9e-bfcd8eb24b0d@github.com>
In-Reply-To: <58f7918f-6ca3-2158-7d9e-bfcd8eb24b0d@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 29 Apr 2023 23:45:09 -0700
Message-ID: <CABPp-BGRtcBQ_6fkMrTskV9dk71ffycXZ8hEE_RaOrAdza_wLA@mail.gmail.com>
Subject: Re: [PATCH 11/14] replay: use standard revision ranges
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 24, 2023 at 8:23=E2=80=AFAM Derrick Stolee <derrickstolee@githu=
b.com> wrote:
>
> On 4/22/2023 9:18 PM, Elijah Newren wrote:
> > On Thu, Apr 20, 2023 at 6:44=E2=80=AFAM Derrick Stolee <derrickstolee@g=
ithub.com> wrote:
> >>
> >> On 4/20/2023 12:53 AM, Elijah Newren wrote:
> >>> On Tue, Apr 18, 2023 at 6:10=E2=80=AFAM Derrick Stolee <derrickstolee=
@github.com> wrote:
>
> >>  3. (Ordering options) Modifications to how those commits are ordered,
> >>     such as --topo-order, --date-order, and --reverse. These seem to
> >>     be overridden by git-replay (although, --reverse probably causes
> >>     some confusion right now).
> >
> > Yep, intentionally overridden.
> >
> > Could you elaborate on what you mean by --reverse causing confusion?
>
> It's very unlikely that a list of patches will successfully apply
> when applied in the reverse order. If we allow the argument, then
> someone will try it thinking they can flip their commits. Then they
> might be surprised when there are a bunch of conflicts on every
> commit.
>
> Basically, I'm not super thrilled about exposing options that are
> unlikely to be valuable to users and instead are more likely to cause
> confusion due to changes that won't successfully apply.

Oh, I got thrown by the "right now" portion of your comment; I
couldn't see how time or future changes would affect anything to make
it less (or more) confusing for users.

Quick clarification, though: while you correctly point out the type of
confusion the user would experience without my overriding, my
overriding of rev.reverse (after setup_revisions() returns, not before
it is called) precludes that experience.  The override means none of
the above happens, and they would instead just wonder why their option
is being ignored.

[...]
> > The rest is all fair, but I'd like to point out that there are a few
> > problems here:
> >
> >   * Tests should generally be passing before submitting upstream, so
> > all the code to implement them needs to be sent too
> >   * Submitted patch series have to be digestible sizes; not everything
> > can be submitted at once
> >   * Christian and Dscho wanted some of what I had implemented despite
> > other parts not being ready
>
> Outside of my first response (using positional arguments, recommended
> before you provided the extra context I was missing) I have not
> suggested implementing something that can't be forward compatible.

True, and maybe I was misunderstanding, but I thought you were trying
to make it forward compatible to only slight deviations while ruling
out most potential future changes, including ones I was specifically
highlighting as minimum eventual requirements.  While it was clear
that _some_ of the limitations you were trying to impose were only on
v1, it sounded like you were also trying to rule out a wide swath of
things permanently.  That's where things really concerned me, and why
I specifically asked which you were trying to do.

To be honest, I'm still unsure what your original intent was.  But it
probably doesn't matter now, as it sounds like you've shifted.  I
_think_ an accurate summary of where we are now at the end of
this thread is:
  * I am predominantly concerned about flexibility/potential for
git-replay in the future (what goes in v1 doesn't matter *if* it
doesn't affect the future, but that's a huge "if").
  * You are predominantly concerned about v1 and only including the
portions of functionality that have associated tests

I think there's enough wiggle room to mostly satisfy both viewpoints.

You helped with my concern by stating that categories (1) and (2)
should be fine for git-replay in the future.  (It at least handles the
forms of potential lock-in that I already know about, though I'm
worried there are others.)

I believe we can give you what you want via a tweak to the hack you
previously suggested for v1 only: rule out passing any options with a
leading dash to setup_revisions(), *and* throw an error if
revs->prune_data.nr is nonzero after calling setup_revisions().  But
I'd want us to include a comment pointing out that it's a hack, and
include in that note that in the future we want to allow all options
in categories (1) and (2) to be passed to setup_revisions() (or passed
to a suitable refactoring thereof).

[...]
> >> so your progress here isn't blocked on refactoring the revisions
> >> API.
> >
> > Is that a positive or a negative?  That question may surprise you, so
> > let me explain.
> >
> > I have a conflict of interest of sorts.  When Christian and Dscho
> > (separately) approached me earlier this year and pointed out that
> > git-replay had the functionality they wanted, I was happy that others
> > liked it, and gave some pointers here and there, but I was _very_
> > worried that upstreaming it would result in something getting
> > backward-incompatibly locked into place that prevents the pieces that
> > are  still in progress from getting implemented.  And I was concerned
> > that my plans to create a tool people could experiment with, and that
> > we could get usability feedback on (as I suggested at the Git
> > contributors summit last year) might be in jeopardy as pieces of its
> > functionality get locked into place before it's even ready for
> > usability testing.  I was silently hoping they'd lose steam on
> > rebasing and cleaning up my patches or choose to just delay until I
> > could get real time to work on it with them.  (Since then, the one
> > person who had ever advocated for my Git work at $DAYJOB, the best
> > manager I had ever worked under, became not-a-manager.  I was
> > blindsided by that in February.  Also, I have been transferred to a
> > different team and am spinning up there.  And so, to my dismay, I'm
> > worried my little sliver of Git time at work may evaporate entirely
> > rather than return to previous healthier levels.)  Anyway, I've been
> > fretting about things getting "locked-in" for a few months.
>
> I'm also upset that you have been disrupted like this.

Thanks.

> > They didn't lose steam, as I found out when these patches were
> > submitted.  But, uh, I'm silently torn because I want to help
> > Christian and Dscho get what they want, but having them be blocked on
> > progress would reduce my stress.  A lot.
>
> From my perspective, git-replay's most important use is being able
> to generate rebases without a worktree or an interactive user. For
> now, I don't even care if that includes conflict resolution. That's
> enough of a lift that has enough unknowns that adding a complex CLI
> at this early stage seems like a hasty decision to me.  I'm voicing
> my opinion that we should avoid backwards-compatibility issues by
> implementing only the essentials.

That comment is mostly reasonable, but I'd like to nit-pick the last
sentence: while limiting the series further for now is okay, I don't
believe that only implementing the essentials is any kind of guarantee
against backwards-compatibility issues.  More on that below.

> That said, I also want to make sure that you eventually get the
> super-flexible command that you want, but only when the framework
> is ready for that kind of flexibility.

Yaay!!!

> > Is there any chance people would be willing to accept a "NO BACKWARD
> > COMPATIBILITY GUARANTEES" disclaimer on this command for a (long?)
> > while, like Victoria suggested at Review club?  That might be an
> > alternate solution that would lower my worries.
>
> I'm not crazy about this idea, especially when it is easy to do
> something simpler and avoid the need for it. But I'm just one voice
> and one opinion.

Sorry I wasn't clear.  I wasn't suggesting this as a way of avoiding
something simpler; I was suggesting it as an addition to doing
something simpler, because it's not clear to me that doing something
simpler is sufficient.

Actually, I think it goes a bit further than that.  Most of my
objections to various forms of simplifying are due to the fact that I
think that simplifying greatly increases the risks of accidental
backward compatibility issues.

Part of the reason why I feel that way is that simplifying has to go
through future rounds of review and people may well respond with, "oh,
that'd be easier if you just did <X> instead of <Y>" with an implicit
assumption that there's no difference between them if <simplification
Z> is being presented as all we need, since <X> and <Y> handle that
simplification equally well.  It's kind of hard to guess in advance
all the forms that <X>, <Y>, and <Z> combined can take, and I also
have no idea if I'll have time to respond to upcoming reviews in a
timely fashion given current conditions, especially as I'm not the one
submitting the patches, so simplifying is a *big* risk in my book.
And this clearly isn't just theoretical, as this thread started
precisely with a simplification suggestion that would have broken
everything.  But even more importantly, I didn't start git-replay
until I found too many backward compatibility issues in rebase that
just couldn't be resolved, and yet I know that when folks review
patches they will make suggestions in line with what they are familiar
with, likely meaning rebase-like behavior.  So, "limiting to the
essentials" sounds like "increase the risk of future problems" to
me...unless we include a
backward-compatibility-explicitly-not-guaranteed-right-now disclaimer
from the beginning.
