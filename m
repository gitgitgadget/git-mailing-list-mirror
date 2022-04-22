Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE8AC433EF
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 09:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445938AbiDVJ1k (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 05:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446004AbiDVJ1f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 05:27:35 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5209F403D4
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 02:24:41 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id r13so15202684ejd.5
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 02:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7wXV/T1X6Z0SeeZNMAo9vp+vdSZemchyAs/Jv5g3Duk=;
        b=BuT7htxqy0d1lG5yQ89i0lCFlEdAXWuXWZFNfP98/dQgjvuEZFyynsFGhsCp358gps
         GjsU0wK/8c4slRpuWasw3Z8uy+/Lj/ZixGTAn3dAHMlD8sd6B2siRx7DM+dg/cH5lRXp
         Ppr+UAE+xxRtDXO+2Bmte+JKOGejTt6R8vm18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7wXV/T1X6Z0SeeZNMAo9vp+vdSZemchyAs/Jv5g3Duk=;
        b=edA0u9bfsicDOPkAkjr8TEBwGE7WotaOkamBvZDMSfoLTaF5ZjxLLlzzkve1snb+ob
         XY4bOTvnANZaKtypB59FCV9OnT23ugvC7o05/B2ykg3wwCtFnKRcdXwyu6Y93TjhaAnH
         HCPyNU/A+Wlx3nKkMoGjaozfpD3PWESQTTUH3tupHH3Qi0d4jNF+Mhdj7gnW7xCzdq9J
         cTGyuLzrW04p3Py+KpMh1n50XNdhdj6EdKvK5rvpnjZ0vtUEhbrZzRoxf/5nQJaDzNtF
         uhWltp1BRtop3KsvZRJOETodf9+sRhJK7JOACTfUQI0DBHp/SPF2KCTgoT/YMu5arGmq
         833A==
X-Gm-Message-State: AOAM532hssN/jrBZHKuNpoyIsxTyfjoWQeUOdS80g3HF2tO4p1SVWKzK
        Jp3vEKKGCXguTllHCKZBjHZsjqSdN5V7LUA3b8i6tg==
X-Google-Smtp-Source: ABdhPJyX8wJTkE5O+jmZH0tGnXgu5W7uSBuSPpEsGedeNVuKN/5QUbSzKpUfdXtcWYGq9SCp6HRS+2GW8psxtAs62zM=
X-Received: by 2002:a17:906:4fc8:b0:6d8:5059:f998 with SMTP id
 i8-20020a1709064fc800b006d85059f998mr3273766ejw.487.1650619479659; Fri, 22
 Apr 2022 02:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1161.v3.git.1646032466.gitgitgadget@gmail.com>
 <pull.1161.v4.git.1647843442911.gitgitgadget@gmail.com> <Yl2qwO0SMPOhb5h9@google.com>
 <CAPMMpogY5vZU8gyRSYh+BM4goPPtJw0cCiM-31sy-s_uGRv8uA@mail.gmail.com>
 <xmqqczhbr6pv.fsf@gitster.g> <CAPMMpohQei9vBBm=7hC=N5LPwzMCED=fZcXyePnrkLCHfCJTZw@mail.gmail.com>
 <xmqqlevzkxrf.fsf@gitster.g> <CAPMMpoiCD+fG=bs2j4Rin5Pvip9Mre9iqLcOb2LYnDQK9cuRxw@mail.gmail.com>
 <xmqqzgkddf8m.fsf@gitster.g>
In-Reply-To: <xmqqzgkddf8m.fsf@gitster.g>
From:   Tao Klerks <tao@klerks.biz>
Date:   Fri, 22 Apr 2022 11:24:26 +0200
Message-ID: <CAPMMpoj+g-XFKXoAXzW4d6WZRSBO_uE6MRsw2jWUPAjqWFQt2A@mail.gmail.com>
Subject: Re: [PATCH v4] merge: new autosetupmerge option 'simple' for matching branches
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josh Steadmon <steadmon@google.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 22, 2022 at 4:27 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Tao Klerks <tao@klerks.biz> writes:
>
> >> I am wondering if that is more irritating than it is
> >> worth.  Instead, if you tell them to use branch.autosetupmerge=simple
> >> and use push.default to something better than simple, wouldn't that
> >> cover more cases and give fewer roadblocks to the end-user with
> >> unnecessary errors?
> >
> > I think you're on to something I missed here.
> >
> > Unfortunately, I'm not sure what "something better than simple" for
> > push.default actually is, in the current system.
>
> "none", probably.  Much better than "current" that can create new
> branches on the other side, which you would want to do with an
> explicit end-user instruction (i.e. not with "git push", but with
> "git push origin topic").
>

Hmm, I don't understand you here. You either mean "simple is the best
option you could choose for push.default, when
branch.autosetupmerge=simple, none of the other options are better",
or there's a small typo and you're saying "push.default=nothing would
be better". I'll assume the latter, but I'm not sure because I don't
see how it can be a good-faith statement.

"nothing" is a good setting for someone who needs and/or wants to make
a conscious choice about where they push to, *every time* they push,
regardless of any remote tracking information. For whom the
operational and mental overhead of choosing a target ref to push to
every time is less than the cost of defaulting to *any* given workflow
or "local to remote branch mapping strategy".

How could this possibly be something we recommend or think is
generally "best" for arbitrary, especially novice, users??

> This depends on what you are really trying to achieve.  If we think
> it through, perhaps it may turn out to be a combination of a bit
> flawed workflow with a bit inadequate toolset.
>
> With "simple" (both in branch.autosetupmerge and push.default), I
> can see that if you create "main" from their "main" and "maint" from
> their "maint", you want to see that
>
>  (1) your "git pull" to integrate what happend on their "main" or
>      "maint" respectively, and
>
>  (2) your "git push" to push what you did on your "main" to their
>      "main", and "maint" to "maint".
>
> But it is totally unclear what you really want to do on "topic" you
> created this way:
>
>     $ git checkout -b topic origin/main
>

The idea of the "simple" workflow which I propose to better support,
is that in creating this branch in this way, you are very clearly
saying:
---
I want to create a new topic branch 'topic' that starts at the current
state of 'origin/main':
* I will want to be able to "back up" my topic branch by pushing it to
the server - and "git push" should do the right thing, just that -
push my current branch to the server.
* I will want to be able to collaborate with others on this topic
branch - after I have pushed, and they have checked out this same
branch, we will all be able to push and pull on this branch seamlessly
* I will choose whether and when to merge in newer changes from
"origin/main", and do so explicitly (not using a simple "git pull")
* I will choose whether and when to rebase on top of "origin/main",
assuming I work alone on this branch or my collaborators are
sufficiently comfortable with rebasing workflows that it will be ok,
and do so explicitly (not using a simple "git pull")
* I will choose whether and when to push my changes on this branch
back to master, and do so by explicitly pushing master after having
merged in this topic branch
---

I would argue that git generally has a "problem", in that
"branch.XXX.merge" entries have two classes of
meanings/interpretation:
* That is the "parent branch"
** The one I want changes from, when I say "update me with changes"
** The one I eventually want to get my changes to
* That is the "remote instance/address" of *this* branch
** If I pull, it's to get changes to the same branch that others might have made
** When I push, it's to get this branch onto the server (not to get my
changes into the "upstream")

For local-only branches, git currently encourages the former
interpretation; when you create the new branch, by default you get the
tracking branch set up.

As soon as you wish to keep your changes on the remote, however, and
especially if you're going to share this topic branch with others,
*you have to give up that interpretation*, for that branch! Git does
not provide you with any facility to indicate a "parent branch",
besides using "branch.XXX.merge" on *local* branches. There's also no
way to share a concept of "parent branch" with others, via a remote,
inherent in git. You can of course look at the commits on your branch
and compare to the commit histories of other branches, you can use
naming strategies to indicate an intended parent, etc - but there's no
inherent storage and signalling mechanism for this idea of a "parent
branch" that you create a topic branch from, with the intent of
merging back eventually.

I call this a "problem" because, in my experience, it confuses people.
The system defaults to setting a "branch.XXX.merge" relationship,
presumably in the hopes of being helpful, but as soon as you want to
share your topic branch (or even just back it up on the server without
jumping through strange hoops), you need to give up that "helpfulness"
and switch to the other model where that just stores the remote
instance of the same branch, rather than the parent.

My proposal here is to support a workflow that accepts, and assumes,
that git does not really have the concept of a "parent branch", and
that "branch.XXX.merge" relationships exist primarily to support the
relationship between local branches and their remote instances.

That of course introduces a tradeoff/compromise: What the user loses,
in this workflow, is the ability to have many very short-lived
local-only branches, all with the same "branch.XXX.merge" upstream,
treating that upstream as the "parent" implicitly. This workflow does
not of course prevent you or discourage you from creating lots of
short-lived local branches - but it does take away the *assumption*
that they're local-only, and the corresponding facility to treat the
upstream as the thing push and pull should work with.

Based on your feedback here, maybe "simple" is not the right name to
associate with workflow, its assumptions and tradeoffs - I believe is
accurately represents the intent and closely relates to the apparent
design intent behind the push.default=simple option, but I'd love
proposals as to how to name (and do) it better!

> Currently, with both set to "simple", you do not even get .remote
> and .merge for the "topic" branch, so your "git pull" simply does
> not work.  And "git push" will also refuse to work.
>

That's right - because the assumption is that you've just created a
new independent branch - independent by name, and therefore
independent by default. You can of course add "--track" if you know
what you're doing and know this is a local-only branch and you want it
to track what you branched from and have "pull" bring in changes from
there (without explicitly specifying so)!

> But then why are you [*] forking from origin/main in the first
> place?  What is the purpose you created 'topic' and what do you
> plan to do with the result you develop on 'topic'?

The assumption, in this workflow, is that you plan to work on that
branch, potentially push to origin to back up or share your work, and
will decide explicitly when to merge in changes from the origin you
branched (forked) from, or merge changes up there.

>
>         Side note: "you" do not refer to"Tao, the advocate of the
>         'simple' configuration", but figuratively the user who
>         followed the "simple" route and created topic out of
>         origin/main that is not connected to origin/main.
>
> Whatever you commit on topic eventually becomes part of what you'd
> push to origin or elsewhere.  I'd assume it would be origin, because
> as the user who choose 'simple', you have some branches that you
> push back to the same name over there.  Presumably, those are the
> primary integration branches the project has, like 'trunk', 'main',
> 'master', etc.
>
> So perhaps the user would have been better off to fork off of the
> LOCAL branch that would eventually be pushed back?  In other words,
> the above user who created 'topic' would have done
>
>     $ git checkout -b main origin/main
>

(completely beside the point, but they would be more likely to have
just done "git checkout main", for the same outcome)

> to use as a local integration branch that collects the work you will
> do locally that is targetted for their 'main' track, so to create a
> topic that aims to be part of what is pushed back to their 'main'
> track, you would want to do
>
>     $ git checkout -b topic main
>
> instead?  That way, "git push" would either not get .merge/.remote
> (when branch.autosetupmerge is set to 'true') or point at your local
> 'main' branch.

I'm not sure I understand or agree with what you're saying here with
"would [otherwise] point at your local 'main' branch". I have to
assume you mean that would be the outcome with "always", while the
former would be the outcome with "true" and "false" (and the proposed
"simple"), and there would be a third possible outcome with "inherit",
where "topic" would end up tracking "origin/main" directly.

>
>  - The symptom you get from the former is no better than what you
>    get from branch.autosetupmerge=simple but it is not worse.
>    "push" and "pull" refuses to work and suggest you to do something
>    additional.

In suggesting the user could/should have done that (in order to get a
sane workflow, presumably), you are also suggesting that they should
keep the state of that "local version of the upstream they eventually
want to get their changes into" up-to-date: They should first check
out master (for example), pull on master to get the state they expect,
and *then* create their new differently-named local branch.

If they take a shortcut (specify the origin branch), they would get
the wrong behavior, and stand a good chance of not understanding what
is happening. I think this is a "bad" process - a bad thing to force
users to learn/understand in order for them to be productive.

>
>  - The latter would make your "git push" and "git pull" on 'topic'
>    to work with your local 'main', treating your 'main' in a way
>    very similar to how you treat your remote 'main' when you are on
>    your own 'main', which is quite reasonable if your change flow is
>    designed to be "work on topic, when the changes on topic proves
>    OK, send that to main, and when the changes on main proves OK,
>    send that to their main".

(assuming you were referring to a "branch.autosetupmerge=always" outcome)

It can be considered "reasonable" if this branch is local-only, yes.
As a user, you then need to understand this duality / distinction
between local-only branches that pull directly against some "semantic
upstream", and local-and-remote branches that

>
> I guess I am esseentially saying that the usefulness of "simple" for
> branch.autosetupmerge is dubious.
>

I understand that, and respectfully disagree :)

> > Do you agree that none of the push.default options available today are
> > "right" for this flow? Do you have a preference or opinion as to
> > whether:
> > * push.default=current should be changed to set up tracking when absent, or
> > * push.default=simple should be changed to "simply" push and set up
> > tracking when there is no tracking, or
> > * a new push.default option should be introduced for this behavior, or
> > * some other configuration should be introduced to specify "and set up
> > tracking on default push if missing" (and if so, under what
> > circumstances should it kick in?)
>
> None of the above, I guess.

I made a mistake here, in under-emphasising "for this flow"; your
answer seems to be more of an "in general, git is powerful enough that
if the user knows to and chooses to do the right thing, they get the
right outcome, and this proposed flow is flawed because it
under-supports local short-lived never-individually-pushed branches".
I completely agree with the former, and while I agree I would love to
have an even better flow that could easily and transparently support
"parent branch" and "server representation of the branch" as separate
concepts - git simply isn't there at this time (and I don't know how
to get it there, and I suspect you and others would not want to bake
such concepts into git).

You stated earlier that I would do my users a disservice in setting
things up to support this flow (by default), without making it
significantly discoverable for the wider git user community, because
they would find that git later behaved differently in other settings.
This is true, but doing them a disservice in terms of git expertise
across contexts is far less important, to me in my context, than
making them comfortable and productive in this specific context - and
coming from , the blinkered workflow I propose is a veritable utopia
of power & flexibility compared to the very-central VCS they come
from. It is also well in-line with how our governance processes and
DevOps processes work, in terms of the meaning of "branch" on the
shared server.

Anyway, I've gone way off-topic I think. I hope I can convince you
that this workflow makes sense for some segment of the git current and
future population, that (with adjustments yet to be made), pushing to
same-name on the remote with tracking implicitly/by default makes
sense, and that making this workflow discoverable to users beyond my
org would also have value.
