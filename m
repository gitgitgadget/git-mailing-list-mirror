Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB665C43217
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 23:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbiKOX2D (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 18:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbiKOX1q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 18:27:46 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062EC27930
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 15:27:43 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id i21so24192357edj.10
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 15:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w+UDdofHgB3JC5ieDG7U31fRtlR2wOezfvoxe7hRUhI=;
        b=MAXnV71LZZPRNfbDj4eK9BAWLw30dPKgdTUfdUkZzUa2Vm4fHLALq4GMQTkLuoUMwz
         VDlComL2PYSOKkfUSujCBm4KWk0B3P4SpK7oxW0TOsPwwhoafwxCxDFo4hzaZfDD/mUM
         NAQquE6JZ2noZHYgNy8C/XIP9oYSHzpEwhglhHlU8i2Tprr6jLREvfRBP/NLSqJfNuU+
         tXb3HA5Tvxt5iZZDklVhc3zlb7X1A/TfnXkd0PYToMUxo7cCaPSx4oy0FUsCkOVENFIn
         B0F0HdNtjr8suwxvevOAJTriHOWhPOIjNzbWqB5iQ/hR8eBC+Qft1gGOVYzIUfDi5keq
         6TUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w+UDdofHgB3JC5ieDG7U31fRtlR2wOezfvoxe7hRUhI=;
        b=qY7ssXpBrzx4symkEoioCkIL6Ud7uKORl3GKHdeS7VjElmd2aD27HTcziiSiQnN4S/
         z2Khvp8wKCU41dJdG+EtubOtSIdQrwlDDW88ndYY/uiJjvhLTq05Jk+5njfj5a312jU4
         f1w1hJKd61KioAK5SK8jdo3BAS8fwNta7oQI8BhG2CfS0gNNHrukrgpyVbM7XQmu0rQ3
         N9DvzGADeYsZv2KHhkASEjFgFVMkzg/Vd+t8jGlHElKo2JFlu9M+UDDb0EYVf6tay3N3
         yQpP/29UUaLZ06KoKRdmXNj5DBL1Z2ZPLxeXG9EQMncen8JxjUc8tGRHMzWy3Oc7YSn4
         El7A==
X-Gm-Message-State: ANoB5pmsjBr/S3cAfnqZdLcWTFRvGeXOKQ2EZFcGu34YQ8dzbnfOkc6/
        o+FZX7b8aOAGC0cY2s66IzEgun3ByylKhA==
X-Google-Smtp-Source: AA0mqf5ZxTZmhZssczZc4qyu+w1euqvoI8X7Wu5kAttzHtENx5eBLAqWM60T4+ttghjI8RxOmqv5RA==
X-Received: by 2002:aa7:c499:0:b0:44e:baab:54e7 with SMTP id m25-20020aa7c499000000b0044ebaab54e7mr17324309edq.265.1668554861486;
        Tue, 15 Nov 2022 15:27:41 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id c8-20020a056402120800b0045726e8a22bsm6722096edw.46.2022.11.15.15.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 15:27:40 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ov5LA-003ou1-0W;
        Wed, 16 Nov 2022 00:27:40 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jacob Abel <jacobabel@nullpo.dev>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 2/2] worktree add: add --orphan flag
Date:   Tue, 15 Nov 2022 23:35:51 +0100
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
 <20221104213401.17393-1-jacobabel@nullpo.dev>
 <20221110233137.10414-1-jacobabel@nullpo.dev>
 <20221110233137.10414-3-jacobabel@nullpo.dev>
 <221115.86iljfkjjo.gmgdl@evledraar.gmail.com>
 <CAPig+cRuJVN2Hc-oNF10sx=ZzArb8skXUQ8m5Qek2e-o4c9VEg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <CAPig+cRuJVN2Hc-oNF10sx=ZzArb8skXUQ8m5Qek2e-o4c9VEg@mail.gmail.com>
Message-ID: <221116.86a64rkdcj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 15 2022, Eric Sunshine wrote:

> On Tue, Nov 15, 2022 at 4:13 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> On Thu, Nov 10 2022, Jacob Abel wrote:
>> > Adds support for creating an orphan branch when adding a new worktree.
>> > This functionality is equivalent to git switch's --orphan flag.
>> >
>> > The original reason this feature was implemented was to allow a user
>> > to initialise a new repository using solely the worktree oriented
>> > workflow. Example usage included below.
>> >
>> > $ GIT_DIR=3D".git" git init --bare
>> > $ git worktree add --orphan master master/
>> >
>> > Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
>> > ---
>> > +Create a worktree containing an orphan branch named `<branch>` with a
>> > +clean working directory.  See `--orphan` in linkgit:git-switch[1] for
>> > +more details.
>>
>> Seeing as "git switch" is still marked "EXPERIMENTAL", it may be prudent
>> in general to avoid linking to it in lieu of "git checkout".
>>
>> In this case in particular though the "more details" are almost
>> completely absent from the "git-switch" docs, and they don't (which is
>> their won flaw) link to the more detailed "git-checkout" docs.
>>
>> But for this patch, it seems much better to link to the "checkout" docs,
>> no?
>
> Sorry, no. The important point here is that the --orphan option being
> added to `git worktree add` closely follows the behavior of `git
> switch --orphan`, which is quite different from the behavior of `git
> checkout --orphan`.
>
> The `git switch --orphan` documentation doesn't seem particularly
> lacking; it correctly describes the (very) simplified behavior of that
> command over `git checkout --orphan`. I might agree that there isn't
> much reason to link to git-switch for "more details", though, since
> there isn't really anything else that needs to be said.

Aside from what it says now: 1/2 of what I'm saying is that linking to
it while it says it's "EXPERIMENTAL" might be either jumping the gun.

Or maybe we should just declare it non-"EXPERIMENTAL", but in any case
this unrelated topic might want to avoid that altogether and just link
to the "checkout" version.

A quick grep of our docs (for linkgit:git-switch) that this would be the
first mention outside of user-manual.txt where we link to it when it's
not in the context of "checkout or switch", or where we're explaining
something switch-specific (i.e. the "suggestDetachingHead" advice).

Having said that I don't really care, just a suggestion...

> If we did want to say something else here, we might copy one sentence
> from the `git checkout --orphan` documentation:
>
>     The first commit made on this new branch will have no parents and
>     it will be the root of a new history totally disconnected from all
>     the other branches and commits.
>
> The same sentence could be added to `git switch --orphan`
> documentation, but that's outside the scope of this patch series (thus
> can be done later by someone).

I think I was partially confused by skimming the SYNOPSIS and thinking
this supported <start-point> like checkout, which as I found in
https://lore.kernel.org/git/221115.86edu3kfqz.gmgdl@evledraar.gmail.com/
just seems to be a missing assertion where we want to die() if that's
provided in this mode.

What I also found a bit confusing (but maybe it's just me) is that the
"with a clean working directory" seemed at first to be drawing a
distinction between this behavior and that of "git switch", but from
poking at it some more it seems to be expressing "this is like git
switch's --orphan" with that.

I think instead of "clean working tree" it would be better to talk about
"tracked files", as "git switch --orphan" does, which AFAICT is what it
means. But then again the reason "switch" does that is because you have
*existing* tracked files, which inherently doesn't apply for "worktree".

Hrm.

So, I guess it depends on your mental model of this operation, but at
least I think it's more intuitive to explain it in terms of "git
checkout --orphan", not "git switch --orphan". I.e.:

	Create a worktree containing an orphan branch named
	`<branch>`. This works like linkgit:git-checkout[1]'s `--orphan'
	option, except '<start-point>` isn't supported, and the "clear
	the index" doesn't apply (as "worktree add" will always have a
	new index)".

Whereas defining this in terms of git-switch's "All tracked files are
removed" might just be more confusing. What files? Since it's "worktree
add" there weren't any in the first place.

Anyway, I don't mind it as it is, but maybe the above write-up helps for
#leftoverbits if we ever want to unify these docs. I.e. AFAICT we could:

 * Link from git-worktree to git-checkout, saying the above
 * Link from git-switch to git-checkout, ditto, but that we also "remove
   tracked files [of the current HEAD]".

>> > +test_expect_success '"add" --orphan/-b mutually exclusive' '
>> > +     test_must_fail git worktree add --orphan poodle -b poodle bamboo
>> > +'
>> > +
>> > +test_expect_success '"add" --orphan/-B mutually exclusive' '
>> > +     test_must_fail git worktree add --orphan poodle -B poodle bamboo
>> > +'
>> > +
>> > +test_expect_success '"add" --orphan/--detach mutually exclusive' '
>> > +     test_must_fail git worktree add --orphan poodle --detach bamboo
>> > +'
>> > +
>> > +test_expect_success '"add" --orphan/--no-checkout mutually exclusive'=
 '
>> > +     test_must_fail git worktree add --orphan poodle --no-checkout ba=
mboo
>> > +'
>> > +
>> > +test_expect_success '"add" -B/--detach mutually exclusive' '
>> > +     test_must_fail git worktree add -B poodle --detach bamboo main
>> > +'
>> > +
>>
>> This would be much better as a for-loop:
>>
>> for opt in -b -B ...
>> do
>>         test_expect_success "...$opt" '<test here, uses $opt>'
>> done
>>
>> Note the ""-quotes for the description, and '' for the test, that's not
>> a mistake, we eval() the latter.
>
> Such a loop would need to be more complex than this, wouldn't it, to
> account for all the combinations? I'd normally agree about the loop,
> but given that it requires extra complexity, I don't really mind
> seeing the individual tests spelled out manually in this case; they're
> dead simple to understand as written. I don't feel strongly either
> way, but I also don't want to ask for extra work from the patch author
> for a subjective change.

Yeah, it's probably not worth it. This is partially cleaning up existing
tests, but maybe:
=09
	diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
	index 93c340f4aff..5acfd48f418 100755
	--- a/t/t2400-worktree-add.sh
	+++ b/t/t2400-worktree-add.sh
	@@ -298,37 +298,21 @@ test_expect_success '"add" no auto-vivify with --det=
ach and <branch> omitted' '
	 	test_must_fail git -C mish/mash symbolic-ref HEAD
	 '
=09=20
	-test_expect_success '"add" -b/-B mutually exclusive' '
	-	test_must_fail git worktree add -b poodle -B poodle bamboo main
	-'
	-
	-test_expect_success '"add" -b/--detach mutually exclusive' '
	-	test_must_fail git worktree add -b poodle --detach bamboo main
	-'
	-
	-test_expect_success '"add" -B/--detach mutually exclusive' '
	-	test_must_fail git worktree add -B poodle --detach bamboo main
	-'
	-
	-test_expect_success '"add" --orphan/-b mutually exclusive' '
	-	test_must_fail git worktree add --orphan poodle -b poodle bamboo
	-'
	-
	-test_expect_success '"add" --orphan/-B mutually exclusive' '
	-	test_must_fail git worktree add --orphan poodle -B poodle bamboo
	-'
	-
	-test_expect_success '"add" --orphan/--detach mutually exclusive' '
	-	test_must_fail git worktree add --orphan poodle --detach bamboo
	-'
	-
	-test_expect_success '"add" --orphan/--no-checkout mutually exclusive' '
	-	test_must_fail git worktree add --orphan poodle --no-checkout bamboo
	-'
	-
	-test_expect_success '"add" -B/--detach mutually exclusive' '
	-	test_must_fail git worktree add -B poodle --detach bamboo main
	-'
	+test_wt_add_excl() {
	+	local opts=3D"$@" &&
	+	test_expect_success "'worktree add' with '$opts' has mutually exclusive =
options" '
	+		test_must_fail git worktree add $opts
	+	'
	+}
	+test_wt_add_excl -b poodle -B poodle bamboo main
	+test_wt_add_excl -b poodle --orphan poodle bamboo
	+test_wt_add_excl -b poodle --detach bamboo main
	+test_wt_add_excl -B poodle --detach bamboo main
	+test_wt_add_excl -B poodle --detach bamboo main
	+test_wt_add_excl -B poodle --orphan poodle bamboo
	+test_wt_add_excl --orphan poodle --detach bamboo
	+test_wt_add_excl --orphan poodle --no-checkout bamboo
	+test_wt_add_excl --orphan poodle bamboo main
=09=20
	 test_expect_success '"add -B" fails if the branch is checked out' '
	 	git rev-parse newmain >before &&
=09
I re-arranged that a bit, but probably not worth a loop. I *did* spot in
doing that that if I sort the options I end up with a duplicate test,
i.e. we test "-B poodle --detach bamboo main" twice.

That seems to be added by mistake in 2/2, i.e. it's the existing test
you can see in the diff context, just added at the end.
