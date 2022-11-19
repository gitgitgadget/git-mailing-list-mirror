Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4064C4332F
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 03:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbiKSDJc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 22:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbiKSDJ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 22:09:29 -0500
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C905E68C48
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 19:09:27 -0800 (PST)
Date:   Sat, 19 Nov 2022 03:09:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1668827366; x=1669086566;
        bh=h9Ddl+tcdEerBm3wzBFPI28EF5zf+1vAalkFnFGpMeM=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=f12YUsWVlAUfqnnzw9fOneH3Srr7FSf7WfhEqAe140sFzG/DgitHhcQkqamHTQRFq
         TVW4JPTF6wKIw9kjtElp9rBGZ/BmQY89aR1TySTlX+8ZkK7O4bC0GYced6HrWpd5uv
         Hk1WzRtbthQWsXM4U9uBv5A67VPMhswB1MEy4xjShjfT6ycP3Ab84J/V0muvDPJfxv
         Ev76elzdc6satu/tzpyGoXb7R7Nsu+UFfzObEmg2KtJ7Z90UaL/R+oc+FpY2So69hN
         AEndrkLh3vKaR93P53nVJcLw3BFC1mWmsjQEYqm1b1swUV8eZh5IDJ0mG2dkMcRvTw
         7FQ8WcV7Xf1/w==
To:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 2/2] worktree add: add --orphan flag
Message-ID: <20221119030907.ukv562zfmm53acre@phi>
In-Reply-To: <221116.86a64rkdcj.gmgdl@evledraar.gmail.com>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev> <20221110233137.10414-1-jacobabel@nullpo.dev> <20221110233137.10414-3-jacobabel@nullpo.dev> <221115.86iljfkjjo.gmgdl@evledraar.gmail.com> <CAPig+cRuJVN2Hc-oNF10sx=ZzArb8skXUQ8m5Qek2e-o4c9VEg@mail.gmail.com> <221116.86a64rkdcj.gmgdl@evledraar.gmail.com>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/11/15 11:35PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
> On Tue, Nov 15 2022, Eric Sunshine wrote:
>
> > On Tue, Nov 15, 2022 at 4:13 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
> >> On Thu, Nov 10 2022, Jacob Abel wrote:
> >> > Adds support for creating an orphan branch when adding a new worktre=
e.
> >> > This functionality is equivalent to git switch's --orphan flag.
> >> >
> >> > The original reason this feature was implemented was to allow a user
> >> > to initialise a new repository using solely the worktree oriented
> >> > workflow. Example usage included below.
> >> >
> >> > $ GIT_DIR=3D".git" git init --bare
> >> > $ git worktree add --orphan master master/
> >> >
> >> > Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
> >> > ---
> >> > +Create a worktree containing an orphan branch named `<branch>` with=
 a
> >> > +clean working directory.  See `--orphan` in linkgit:git-switch[1] f=
or
> >> > +more details.
> >>
> >> Seeing as "git switch" is still marked "EXPERIMENTAL", it may be prude=
nt
> >> in general to avoid linking to it in lieu of "git checkout".
> >>
> >> In this case in particular though the "more details" are almost
> >> completely absent from the "git-switch" docs, and they don't (which is
> >> their won flaw) link to the more detailed "git-checkout" docs.
> >>
> >> But for this patch, it seems much better to link to the "checkout" doc=
s,
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
>
> A quick grep of our docs (for linkgit:git-switch) that this would be the
> first mention outside of user-manual.txt where we link to it when it's
> not in the context of "checkout or switch", or where we're explaining
> something switch-specific (i.e. the "suggestDetachingHead" advice).
>
> Having said that I don't really care, just a suggestion...
>
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
>
> What I also found a bit confusing (but maybe it's just me) is that the
> "with a clean working directory" seemed at first to be drawing a
> distinction between this behavior and that of "git switch", but from
> poking at it some more it seems to be expressing "this is like git
> switch's --orphan" with that.
>
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
> =09Create a worktree containing an orphan branch named
> =09`<branch>`. This works like linkgit:git-checkout[1]'s `--orphan'
> =09option, except '<start-point>` isn't supported, and the "clear
> =09the index" doesn't apply (as "worktree add" will always have a
> =09new index)".
>
> Whereas defining this in terms of git-switch's "All tracked files are
> removed" might just be more confusing. What files? Since it's "worktree
> add" there weren't any in the first place.
>
> Anyway, I don't mind it as it is, but maybe the above write-up helps for
> #leftoverbits if we ever want to unify these docs. I.e. AFAICT we could:
>
>  * Link from git-worktree to git-checkout, saying the above
>  * Link from git-switch to git-checkout, ditto, but that we also "remove
>    tracked files [of the current HEAD]".

Apologies for the mistake in the SYNOPSIS. As mentioned in the other replie=
s
I've updated it as you indicated to correct that.

As for a path forwards on the referencing of either git-checkout or git-swi=
tch
from git-worktree, I think I'm leaning towards Eric's approach (in his repl=
y
to this message) where we don't reference either and fully outline the
behavior itself.

>
> >> > +test_expect_success '"add" --orphan/-b mutually exclusive' '
> >> > +     test_must_fail git worktree add --orphan poodle -b poodle bamb=
oo
> >> > +'
> >> > +
> >> > +test_expect_success '"add" --orphan/-B mutually exclusive' '
> >> > +     test_must_fail git worktree add --orphan poodle -B poodle bamb=
oo
> >> > +'
> >> > +
> >> > +test_expect_success '"add" --orphan/--detach mutually exclusive' '
> >> > +     test_must_fail git worktree add --orphan poodle --detach bambo=
o
> >> > +'
> >> > +
> >> > +test_expect_success '"add" --orphan/--no-checkout mutually exclusiv=
e' '
> >> > +     test_must_fail git worktree add --orphan poodle --no-checkout =
bamboo
> >> > +'
> >> > +
> >> > +test_expect_success '"add" -B/--detach mutually exclusive' '
> >> > +     test_must_fail git worktree add -B poodle --detach bamboo main
> >> > +'
> >> > +
> >>
> >> This would be much better as a for-loop:
> >>
> >> for opt in -b -B ...
> >> do
> >>         test_expect_success "...$opt" '<test here, uses $opt>'
> >> done
> >>
> >> Note the ""-quotes for the description, and '' for the test, that's no=
t
> >> a mistake, we eval() the latter.
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
> =09diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
> =09index 93c340f4aff..5acfd48f418 100755
> =09--- a/t/t2400-worktree-add.sh
> =09+++ b/t/t2400-worktree-add.sh
> =09@@ -298,37 +298,21 @@ test_expect_success '"add" no auto-vivify with -=
-detach and <branch> omitted' '
> =09 =09test_must_fail git -C mish/mash symbolic-ref HEAD
> =09 '
>
> =09-test_expect_success '"add" -b/-B mutually exclusive' '
> =09-=09test_must_fail git worktree add -b poodle -B poodle bamboo main
> =09-'
> =09-
> =09-test_expect_success '"add" -b/--detach mutually exclusive' '
> =09-=09test_must_fail git worktree add -b poodle --detach bamboo main
> =09-'
> =09-
> =09-test_expect_success '"add" -B/--detach mutually exclusive' '
> =09-=09test_must_fail git worktree add -B poodle --detach bamboo main
> =09-'
> =09-
> =09-test_expect_success '"add" --orphan/-b mutually exclusive' '
> =09-=09test_must_fail git worktree add --orphan poodle -b poodle bamboo
> =09-'
> =09-
> =09-test_expect_success '"add" --orphan/-B mutually exclusive' '
> =09-=09test_must_fail git worktree add --orphan poodle -B poodle bamboo
> =09-'
> =09-
> =09-test_expect_success '"add" --orphan/--detach mutually exclusive' '
> =09-=09test_must_fail git worktree add --orphan poodle --detach bamboo
> =09-'
> =09-
> =09-test_expect_success '"add" --orphan/--no-checkout mutually exclusive'=
 '
> =09-=09test_must_fail git worktree add --orphan poodle --no-checkout bamb=
oo
> =09-'
> =09-
> =09-test_expect_success '"add" -B/--detach mutually exclusive' '
> =09-=09test_must_fail git worktree add -B poodle --detach bamboo main
> =09-'
> =09+test_wt_add_excl() {
> =09+=09local opts=3D"$@" &&
> =09+=09test_expect_success "'worktree add' with '$opts' has mutually excl=
usive options" '
> =09+=09=09test_must_fail git worktree add $opts
> =09+=09'
> =09+}
> =09+test_wt_add_excl -b poodle -B poodle bamboo main
> =09+test_wt_add_excl -b poodle --orphan poodle bamboo
> =09+test_wt_add_excl -b poodle --detach bamboo main
> =09+test_wt_add_excl -B poodle --detach bamboo main
> =09+test_wt_add_excl -B poodle --detach bamboo main
> =09+test_wt_add_excl -B poodle --orphan poodle bamboo
> =09+test_wt_add_excl --orphan poodle --detach bamboo
> =09+test_wt_add_excl --orphan poodle --no-checkout bamboo
> =09+test_wt_add_excl --orphan poodle bamboo main
>
> =09 test_expect_success '"add -B" fails if the branch is checked out' '
> =09 =09git rev-parse newmain >before &&
>
> I re-arranged that a bit, but probably not worth a loop. I *did* spot in
> doing that that if I sort the options I end up with a duplicate test,
> i.e. we test "-B poodle --detach bamboo main" twice.
>
> That seems to be added by mistake in 2/2, i.e. it's the existing test
> you can see in the diff context, just added at the end.

This is much clearer and more succinct. I've applied this to 2/2 for v4.

