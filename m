Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86932C433FE
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 00:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiKPATz convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 15 Nov 2022 19:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiKPATx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 19:19:53 -0500
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6156027FD8
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 16:19:52 -0800 (PST)
Received: by mail-io1-f42.google.com with SMTP id b2so12036012iof.12
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 16:19:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YFJUWk4YVFSwSqF0QYr5EQcYgjANT81C1+jsB6w8x1k=;
        b=i2jEEsejWz2B59P9TBdQCAUYzI+PHkh8mFT7DMYGyVSOtYia4AoTsW1HKRKSuQF2Ij
         9KsILizHhGrGbvQmEe2tfAU25kWillQa0BUALueVWhlqTYXbXGk4NrcRuZrrHuEc6rri
         f2w1vfJrMvxJFL9GDjRHfSpAag/QS3baa2WzE6Qd0o/YrQM62x1odggk9at0PnQ7lRvY
         4wfJrEL2s6TBB0Hi/ItXmrdqZc9bmZ6ClvbUunZciv4Ezk36XvWp1R3NyuBHJCnWP3IV
         bnnbiEz8WpBtoxAMtAAGnvc89mL3U4k7Ix/TDvb6BQGXduj1vh3k0COxipdsPcZmaO02
         9Lbw==
X-Gm-Message-State: ANoB5pmqCs9KOV4VNG9eJHvXnRpB4T2EC3FcGu5m95Xuyk2zjbJE7+OW
        +bOPqST570/f8cDWG6KEy+C+W/LP7FhJnVyKOm0n3vcpTmc=
X-Google-Smtp-Source: AA0mqf6dcc7uXCZ05wPcjLQ8L869uz4EQ0yG3ChUgIU5NVY0ahImmyOc0/o65kja+CC5BKoEOwX1WHpriMk5CQDFUKQ=
X-Received: by 2002:a5e:8b05:0:b0:6cb:4c03:6d6e with SMTP id
 g5-20020a5e8b05000000b006cb4c036d6emr1286333iok.168.1668557991511; Tue, 15
 Nov 2022 16:19:51 -0800 (PST)
MIME-Version: 1.0
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev>
 <20221110233137.10414-1-jacobabel@nullpo.dev> <20221110233137.10414-3-jacobabel@nullpo.dev>
 <221115.86iljfkjjo.gmgdl@evledraar.gmail.com> <CAPig+cRuJVN2Hc-oNF10sx=ZzArb8skXUQ8m5Qek2e-o4c9VEg@mail.gmail.com>
 <221116.86a64rkdcj.gmgdl@evledraar.gmail.com>
In-Reply-To: <221116.86a64rkdcj.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 15 Nov 2022 19:19:40 -0500
Message-ID: <CAPig+cQiyd9yGE_XpPZmzLQnNDMypnrEgkV7nqRZZn3j6E0APQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] worktree add: add --orphan flag
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jacob Abel <jacobabel@nullpo.dev>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 15, 2022 at 6:27 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Tue, Nov 15 2022, Eric Sunshine wrote:
> > On Tue, Nov 15, 2022 at 4:13 PM Ævar Arnfjörð Bjarmason
> > <avarab@gmail.com> wrote:
> >> But for this patch, it seems much better to link to the "checkout" docs,
> >> no?
> >
> > Sorry, no. The important point here is that the --orphan option being
> > added to `git worktree add` closely follows the behavior of `git
> > switch --orphan`, which is quite different from the behavior of `git
> > checkout --orphan`.
> >
> > The `git switch --orphan` documentation doesn't seem particularly
> > lacking; it correctly describes the (very) simplified behavior of that
> > command over `git checkout --orphan`. I might agree that there isn't
> > much reason to link to git-switch for "more details", though, since
> > there isn't really anything else that needs to be said.
>
> Aside from what it says now: 1/2 of what I'm saying is that linking to
> it while it says it's "EXPERIMENTAL" might be either jumping the gun.
>
> Or maybe we should just declare it non-"EXPERIMENTAL", but in any case
> this unrelated topic might want to avoid that altogether and just link
> to the "checkout" version.

Even better would be for the documentation added by this patch to be
self-contained and not bother linking anywhere to further explain
--orphan. That would satisfy your concern, I think, as well as my
concern that `git checkout --orphan` documentation is inappropriate
for `git worktree add --orphan`.

> > If we did want to say something else here, we might copy one sentence
> > from the `git checkout --orphan` documentation:
> >
> >     The first commit made on this new branch will have no parents and
> >     it will be the root of a new history totally disconnected from all
> >     the other branches and commits.
> >
> > The same sentence could be added to `git switch --orphan`
> > documentation, but that's outside the scope of this patch series (thus
> > can be done later by someone).
>
> I think I was partially confused by skimming the SYNOPSIS and thinking
> this supported <start-point> like checkout, which as I found in
> https://lore.kernel.org/git/221115.86edu3kfqz.gmgdl@evledraar.gmail.com/
> just seems to be a missing assertion where we want to die() if that's
> provided in this mode.

I haven't read v3 yet, so I wasn't aware that the SYNOPSIS hadn't been
updated to match the reworked --orphan behavior implemented by v3, but
I can certainly understand how that would have led you astray. You're
quite correct that the SYNOPSIS should not be saying that <commit-ish>
is allowed with --orphan.

> What I also found a bit confusing (but maybe it's just me) is that the
> "with a clean working directory" seemed at first to be drawing a
> distinction between this behavior and that of "git switch", but from
> poking at it some more it seems to be expressing "this is like git
> switch's --orphan" with that.

"clean working directory" may indeed be ambiguous and confusing. It's
not necessarily clear if it means "no changes to tracked files" or "no
files in directory". We should use more precise terminology.

> I think instead of "clean working tree" it would be better to talk about
> "tracked files", as "git switch --orphan" does, which AFAICT is what it
> means. But then again the reason "switch" does that is because you have
> *existing* tracked files, which inherently doesn't apply for "worktree".
>
> Hrm.
>
> So, I guess it depends on your mental model of this operation, but at
> least I think it's more intuitive to explain it in terms of "git
> checkout --orphan", not "git switch --orphan". I.e.:
>
>         Create a worktree containing an orphan branch named
>         `<branch>`. This works like linkgit:git-checkout[1]'s `--orphan'
>         option, except '<start-point>` isn't supported, and the "clear
>         the index" doesn't apply (as "worktree add" will always have a
>         new index)".
>
> Whereas defining this in terms of git-switch's "All tracked files are
> removed" might just be more confusing. What files? Since it's "worktree
> add" there weren't any in the first place.

I would find it clearer not to talk about or reference `git checkout
--orphan` at all. And, as mentioned above, it shouldn't need to
reference `git switch --orphan` either. How about something like this
for the description of the `add` subcommand?

    Create a worktree containing no files and with an empty index, and
    associated with a new orphan branch named `<branch>`. The first
    commit made on this new branch will have no parents and will be
    the root of a new history disconnected from any other branches.

And then to document the --orphan command:

    With `add`, make the new worktree and index empty, and associate
    the worktree with a new orphan branch named `<new-branch>`.

> >> This would be much better as a for-loop:
> >
> > Such a loop would need to be more complex than this, wouldn't it, to
> > account for all the combinations? I'd normally agree about the loop,
> > but given that it requires extra complexity, I don't really mind
> > seeing the individual tests spelled out manually in this case; they're
> > dead simple to understand as written. I don't feel strongly either
> > way, but I also don't want to ask for extra work from the patch author
> > for a subjective change.
>
> Yeah, it's probably not worth it. This is partially cleaning up existing
> tests, but maybe:
>
>         -test_expect_success '"add" -b/-B mutually exclusive' '
>         -       test_must_fail git worktree add -b poodle -B poodle bamboo main
>         -'
>         -
>         +test_wt_add_excl() {
>         +       local opts="$@" &&
>         +       test_expect_success "'worktree add' with '$opts' has mutually exclusive options" '
>         +               test_must_fail git worktree add $opts
>         +       '
>         +}
>         +test_wt_add_excl -b poodle -B poodle bamboo main
>         +test_wt_add_excl -b poodle --orphan poodle bamboo

I'm rather "meh" here. Yes it's one line per test rather than rather
than two or three, but it isn't saving much typing, and it isn't
really making it easier for a reader to see what's going on. So,
considering that it's so subjective and I'd like to avoid asking the
patch author for subjective changes, I'm fine with the way it's done
already in the patch.

> I re-arranged that a bit, but probably not worth a loop. I *did* spot in
> doing that that if I sort the options I end up with a duplicate test,
> i.e. we test "-B poodle --detach bamboo main" twice.
>
> That seems to be added by mistake in 2/2, i.e. it's the existing test
> you can see in the diff context, just added at the end.

Dropping the duplicate sounds like a good idea.
