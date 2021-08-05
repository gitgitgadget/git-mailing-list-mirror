Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0477C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 21:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC518606A5
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 21:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhHEVqM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 17:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbhHEVqL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 17:46:11 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7CAC0613D5
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 14:45:57 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id t7-20020a17090a5d87b029017807007f23so14988973pji.5
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 14:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=NMV5cyq7dv4Bysejt5BpxieCL+2y9drynrGxJlPiO5A=;
        b=Lb5L4dMmaL58lRv3o3Z5v2Tfeqe+klT0L8XGELofKpzX0EYWXfpEHj5a/Phaq5aOAY
         JIh+E6kY2cXli1yj2DwBKM4akzn3+pgu11gd1l69PQBfcUOypYmRgEeThHDC131Ji3G5
         De6RlMjfUTAqdO3In5DamwYj9g7CCMD/IxFKAEo8jdY6mADMOvUPBk7XJhavro3M7sYI
         8Ng3qoGTErAPRr5OrJMJ5ShpzSCqO2yybu9xxjH3AuJQGd24LB14MuAtJUhX8Y3/H1xQ
         G4WbkXmdUJ/MuhB6A5AGfBxTHHfuqC66Jqq55FIF1OVwNaIGXt1ygJBMJ1fXZjq9NxvU
         td0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NMV5cyq7dv4Bysejt5BpxieCL+2y9drynrGxJlPiO5A=;
        b=Hoi4y1m4ffdYsIRnWaKGYYe8BSKMSS/d7Rv49MQdmughBuAZObltGwhIPicj+jh6JJ
         C+DXxUsTR7nr9AB1K8y4lAOZtH7bJOZvrbQ92QiFU3udnk1LA0ZvRIZohgw6R9LSNdBD
         V/sZwa5kJDbopPDbNjvOtobB5oIqiZYueAog3lHQwlcFoMuhbGO5Trzbz+pP3PlmlJ4Q
         1gv7suMYsMVOIZ6V4tncD5nhzyJI+y9Z4OtOtr5kaRLVIn1G65Yuz4olag0ANuuqQW3N
         PeWwbJnPySSdILIEH7rmYpdm8AmbbUquTu+tDxBY3wS/2KuH85ohOlA93q3bWM8PlXbC
         8jzQ==
X-Gm-Message-State: AOAM5330sv/dHU4xUo5SQ8bXo7dyxgkNmx8SWWHN35ggfc3Hw+/Q20+/
        +FVd/LTG5UsaayYva1oqbQ+U2A==
X-Google-Smtp-Source: ABdhPJxNa0qHZfsZfcsiIn5HjBw+ATZkGEXJaw5mZmHnZWU9TLERGJP0O97LjNaEC7upihh6yGOlQQ==
X-Received: by 2002:a17:90a:4306:: with SMTP id q6mr17014153pjg.202.1628199956225;
        Thu, 05 Aug 2021 14:45:56 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:536b:25aa:509:bcb5])
        by smtp.gmail.com with ESMTPSA id c23sm7854765pfn.140.2021.08.05.14.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 14:45:55 -0700 (PDT)
Date:   Thu, 5 Aug 2021 14:45:49 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 8/9] hook: teach 'hookcmd' config to alias hook scripts
Message-ID: <YQxcDZSEvrRKIN+L@google.com>
References: <20210715232603.3415111-1-emilyshaffer@google.com>
 <20210715232603.3415111-9-emilyshaffer@google.com>
 <87fswey5wd.fsf@evledraar.gmail.com>
 <YPn/5GLrAb17KqyB@google.com>
 <87bl6ttmlv.fsf@evledraar.gmail.com>
 <YQr6xojzxk3xJrTw@google.com>
 <877dh0n1b3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877dh0n1b3.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 05, 2021 at 02:17:29AM +0200, Ævar Arnfjörð Bjarmason wrote:
> >> The gain is that "git hook list" becomes a trivial "git config
> >> -show-origin --show-scope --get-regexp" wrapper.
> >
> > This isn't a very compelling reason to me, if it makes the user
> > experience worse. (I'm not convinced that it does - just saying I
> > disagree with this reasoning.)
> 
> ...(see below)...
> 
> >> 
> >> So the series either doesn't need "git hook list" or such a thing
> >> becomes much less complex, especially given the proposed addition of
> >> other features in the area like "git hook edit", i.e. (quoting the
> >> linked E-Mail):
> >
> > I still think "git hook list" is useful to have for end-users, compared
> > to remembering the appropriate "git config" invocation. It futureproofs
> > us if we do want to change the execution ordering to something besides
> > config order, it's easier to remember/more discoverable, etc.
> 
> To clarify: I'm not against there being a "git hook list", I think we
> should have it.
> 
> It's useful UI. I.e. we have "run", it makes sense to have the same
> mechanism spew out its idea of what hooks are where, especially since
> that's not entirely contained in the config, but a union of config and
> GIT_DIR/hooks (and then there's core.hooksPath...).
> 
> So I'm very much for it being there.
> 
> I've just been commenting on the relative complexity of the config
> schema, which in one way surfaces as not being able to do the config
> part of the "git hook list" as a simple shell-out (or equivalent library
> invocation) of "git config" under the hood, but also means that users
> need to mentally track a more complex format when e.g. manually editing
> config...

Sure, makes sense.

> >> 
> >> And means that you presumably need to detect this case and error about
> >> it, but my proposed model does not:
> >> 
> >>     hook.post-commit.command = echo hi
> >>     # User error: "*.type" and <event-or-name>" does not match for
> >>     # "hook.*.command"
> >>     hook.post-commit.type    = pre-commit
> >> 
> >> And furthermore, that if someone in your model were to do:
> >> 
> >>     hook.verify-commit.command = echo hi
> >> 
> >> It's "dangling" today, but if a later version of git learns about a
> >> "verify-commit" hook we'll start running it unexpectedly.
> >
> > No, that's in fact as designed, with my model B. The user configured
> > "echo hi" to run on "verify-commit" events; if those events are
> > initially used by some wrapper, but later we decide they're a great idea
> > and absorb the verify-commit event into native Git, then this is working
> > as intended. I think your argument is based on a misunderstanding of the
> > design.
> >
> > Could it be that the way I provided the examples (my schema after A: and
> > your schema after B:) made it hard to parse? Sorry about that if so.
> 
> Aren't you assuming that users who specify a verify-commit will be happy
> because git's usurping of that will 1=1 match what they were using
> "verify-commit" for.
> 
> I'm pointing out that we can't know that, and since you want to make
> "git hook run" a general thing that runs any <name> of script you've
> configured, and not just what's in githooks(5) that it becomes very
> likely that if we add a new hook with some obvious name that we'll
> either break things for users, or subtly change behavior.
> 
> Which isn't just theoretical, e.g. I tend to run something like a "git
> log --check @{u}.." before I run git-send-email, with this configurable
> hook mechanism having a "git hook run sendemail-check" would be a way I
> might expose that in my own ~/.gitconfig.
> 
> But if git-send-email learns a "sendemail-check" and the behavior
> doesn't exactly match mine; E.g. maybe it similar to pre-auto-gc expects
> me to return a status code to ask me if I want to abort on a failed
> --check, but mine expects a revision range to run "log --check".
> 
> In practice that's a non-issue with the current hook mechanism,
> i.e. nobody's sticking a script into .git/hooks/my-custom-name and
> expecting it to do anything useful (and if they are, they have only
> themselves to blame).
> 
> Whereas we'd now be actively inviting users to squat on the same
> namespace we ourselves will need for future hooks.

Yeah, this is a good point. Seems worth a note in the 'git hook run'
doc, making a point that "you can use this for your wrapper to run
specific hooks, but be careful about namespace collisions". We're a lot
less likely to add a hook named "repotool-verify-commit" than we are to
add a hook named "verify-commit", for example.

I think it's enough to warn about future namespace collisions and make
an "at your own risk" note.

> > Maybe we can take the essential spirit of this implementation but make
> > it a little bit simpler. In pseudocode:
> >
> > populate_list(hookname):
> >   # look for everybody who says "hook.*.event = $hookname"
> >   hooks = get_configs_matching(hook.*.event, hookname)
> >   # the "*" bit is the bit we dereference later
> >   for hook in hooks:
> >     hook_list.add({.name = hook.key.subsection})
> >
> > run_hooks(hook_list):
> >   for hook in hook_list:
> >     # should we even run?
> >     if (get_last_config("hook." + hook.name + ".skip"))
> >       continue
> >
> >     # dereference the hook name and find out the command
> >     cmd = get_last_config("hook." + hook.name + ".command")
> >     run(cmd)
> >
> > The price for this improved readability is an extra config lookup in
> > each case. But the code is still readable, definitely moreso than
> > rewalking the config list over and over as the implementation stands
> > now. I personally think it's worth it.
> 
> I think the less complicated user experience is for our config system to
> work as consistently as possible with other config. If we define special
> rules and what's effectively special syntax with "skip" etc. we're
> asking users to read how that works, and keep that all in their head
> just to deal with that one area of our config.
> 
> > (One could also imagine a more readable placeholder than /bin/true in
> > the "hook.<name>.command" field, but then we get to decide just how hard
> > we want to avoid colliding with legitimate user hook names. Is .command
> > = skip enough? is .command = RESERVED_NAME_SKIP_THIS_HOOK enough? Is
> > something unrunnable like .command = "skip me" enough, although it could
> > conceivably collide with a determined user?)
> 
> All of that's something you'll need to explain in detail to users, which
> all seems way more complex than a simple:
> 
>     To skip a previously defined hook insert a noop-command, any will
>     do, but setting it to "true" (usually /bin/true) is a handy
>     convention for doing nothing.
> 
> I.e. by keeping the config field as doing one thing only you avoid any
> such collisions etc.

I disagree fundamentally that "find and run a noop command like
/bin/true" is simpler to average users than "skip it by setting a
config". Like I said below, by including "skip" both approaches will
work.

> > No, but it's something I'm interested in passing as an environment
> > variable. I didn't add it to this series because it seemed to me to
> > distract from the core feature. We would like to add it to simplify our
> > invocations of https://github.com/awslabs/git-secrets, so it's on my
> > radar.
> 
> Having such an env var as part of the initial series seems like a
> sensible thing to have.

Eh. To me, it feels like feature creep. It also is something we could
add today to the existing hook mechanism (even if it's a little
pointless since you can basename, like you say), so it feels orthogonal.
I would prefer not to add it in this series.

> 
> > And even without this, just today I wanted to configure a hook to really
> > make sure I had config.mak set up in all my Git worktrees (since you
> > pointed out I pushed code that fails -Wall.... ;) ) and set it up to run
> > on both pre-commit and post-checkout. So yes, it is feasible now, for
> > very stupid hooks.
> 
> Aside: It's nice to use DEVELOPER=1 in config.mak (or as make param)
> when hacking on git, it'll set -Wall -Werror and other nice warning
> flags.

This is literally what I was saying I wrote the hook to do, and is also
a tip I included when I wrote MyFirstContribution.txt.

> > I am not sure what it means for a single executable to write "parallel =
> > true" - it is a single executable.
> >
> > Ok, that is me being facetious - I think you are saying we can AND
> > together all of the 'hook.<thing-with-event-we-care-about>.parallel' to
> > decide whether or not to run in parallel.
> 
> Right, the case (whatever the config mechanism) wanting to use several
> off-the-shelf hooks and accomplish through git some version of this:
> 
>     parallel -j8 pre-receive-parallel-*.sh &&
>     parallel -j1 pre-receive-non-parallel-*.sh
> 
> I.e. since we have N scripts for the "pre-receive" type, and we're
> expecting to say whether on not parallelism is OK or not, it seems like
> a natural thing we'll want to declare that differently for some of those
> than for others.
> 
> > I would rather not discuss this now, for this series, because regardless
> > of which config schema we use today, we can figure out "parallel unless
> > we really don't want it" later on. It is too complex to discuss in the
> > context of "hey, we should also configure hooks somewhere else". Let's
> > leave it for future work.
> 
> The point is that no, we really can't figure it out as easily later on
> regardless of the config schema.
> 
> Because with 1=many you can't have 1=many.someAttribute=XYZ without that
> *.someAttribute=XYZ declaring something for all of 1=many, whereas if
> it's 1=1 then 1=1.someAttribute.XYZ obviously applies only to that 1=1.

I think this is moot, since we are moving to "all config hooks have a
name", but my plan previously was to let this be set on a hookcmd.
Essentially, your suggestion is to make every hook a hookcmd. My point
was that it's easy to extend [object which represents an executable] in
the config to include "always run me in series" or "run me in series for
this specific event" regardless. That is, one could imagine, discarding
entirely the hookcmd junk and going with the schema I sketched in my
last email (which lands somewhere between yours and mine):

[hook "linter"]
  command = ~/linter.sh
  event = pre-commit
  parallel = false

or...

[hook "linter"]
  command = ~/linter.sh
  event = pre-commit
  event = commit-msg

[hook "linter.commit-msg"]
  parallel = false

Or even...

[hook "linter"]
  command = ~/linter.sh
  event = pre-commit
  event = commit-msg
  parallel = commit-msg

The possibilities go on, as far as configuration goes.

To me, the harder part of this problem is actually implementing the
execution. We had some discussions at length early on in the
config-based hook series about ways to do this kind of complex "some
stuff needs synchronous execution and some stuff doesn't, in the same
event" and decided that it mostly resolved to "you ain't gonna need it"
principle. So I would prefer to discuss this when we find out we do
actually need it.

> 
> >> I haven't thought about it deeply, but have a hunch that having sections
> >> be a 1=1 mapping with a specific command instead of either 1=1 or 1=many
> >> is going to make that easier to implement and understand.
> >
> > Sure, probably. But it can be added later to either schema... ;)
> >
> >
> > Anyway, I did a quick strawpoll with my colleagues (Jonathan Nieder,
> > Jonathan Tan, and Josh Steadmon) and they all like your syntax more. I
> > am ambivalent between the two, personally.
> >
> > So what I will do, hopefully today, maybe not, is the following:
> >
> >  - no more hookcmd. (and there was much rejoicing)
> >  - Hooks are specified with "[hook "name-of-hook"]"
> 
> Thanks, I look forward to checking that out. As should be obvious from
> my misunderstanding of some of your config proposal (I snippet out some
> of those from the reply) I'm still not entirely clear on even what the
> current proposed behavior is, hopefully something simpler will be easier
> to grok ... :)

Fingers crossed ;)

> 
> >  - I do see value in having an explicit .skip field rather than mapping
> >    .command to a noop, so "hook.name-of-hook.skip" as described above.
> >    Of course the method you described will work regardless, since its
> >    mechanism is based on the inherent result of executing /bin/true.
> 
> I think we've mainly focused on the theoretical aspect of this, but FWIW
> I'm still entirely unclear on what this feature is even aimed for.
> 
> All of the rest of our config does not have an explicit "skip" for
> anything, just last-set-wins. In terms of a real-world use-case wouldn't
> a user just edit or comment out the config earlier in ~/.gitconfig, and
> not "skip" it at the end with "git config [...] --add"?
> 
> I suspect that the use-case is some Googly centrally managed
> /etc/gitconfig, but that's just speculation...

Yep, this is exactly why. We've talked often on-list about how we ship
and configure Git for Googlers, but the upshot is "we pack up 'next' and
also ship an '/etc/gitconfig'".

But I can also think of one really basic scenario when I'd want to skip
a hook in one repo without just commenting out my ~/.gitconfig: the
Gerrit Change-Id hook.

Gerrit requires all commit messages to contain this Change-Id: abc123
footer. It adds the footer by way of a commit-msg hook. That hook works
the same regardless of what your Gerrit remote is, so you can run the
same script on any project that uses Gerrit for code review. If, as I have in
the past, the vast majority of my projects use Gerrit, but I have one
project which does not, then I would love to configure the Gerrit
Change-Id hook globally and un-configure it for my one non-Gerrit
project.

(At that time, I maintained a subsystem in a project based on Yocto, so
I needed to regularly contribute to 5-10 projects, all but one of which
used Gerrit. The one non-Gerrit one used a mailing list. I also had a
hobby project and my dotfiles, neither of which used Gerrit. This is not
an uncommon use case.)

> 
> >  - I do see value in allowing "hook.name-of-hook.event" to be defined
> >    repeatably, as described above, so I will include that.
> > [...]
> >  - figuring out what the heck we want to do with allowing hooks to
> >    describe whether they allow parallelism
> 
> Which just to check if we're on the same page, needs to be figured out
> because of the complexity of that "defined repeatably", no?

As I wrote above, I think this falls under YAGNI, to be honest, and I
don't think we've painted ourselves into a corner if we do end up
needing it. I think the semantical complexity is a harder problem than
the syntactical complexity, and I'd rather just punt it ;)

> 
> > Unfortunately I've dropped the design doc from this series, since nobody
> > seemed interested in having it checked in, but I'll try to rework the
> > help doc to make the schema more clear.
> 
> FWIW I wasn't opposed to it per-se, but remembered commenting on it in
> earlier rounds, and it being some combination of docs that should really
> be in manpages (i.e. describing current actual behavior), more general
> rational and "why is it like this" (which correctly belongs in design
> docs), and musings about hypothetical future features (e.g. "git hook
> edit" and the like)'.

Yeah, that's pretty typical of design docs at places I've worked now and
in the past. I don't have a big problem with not checking it in - those
kinds of docs are most valuable during the early design stage, and so I
think that doc has now served its purpose.

 - Emily
