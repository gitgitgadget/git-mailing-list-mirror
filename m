Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DC3C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 20:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0215361037
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 20:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240866AbhHDUix (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 16:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbhHDUiw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 16:38:52 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B899C0613D5
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 13:38:38 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id l19so4831336pjz.0
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 13:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tUBcC0SNCBp3PnfiZFxMfw+Mig/Up7EwgRYp7Itl2Lg=;
        b=h6ZKNYKOnYoX9MlLMZ25pTeeh5j3InJu7v+bxMW1ucwzQxRrk06RaxwsH5/GDoeBmi
         lAoKYME5Z8BFikY6nMmU16S8j8jN1WTHqnesgk2+dd6p+aTt6OMmSnABILnleWao1Y4M
         8zsNUv2YvxRxAmwLtsjU7o/vu6Pk3i0rPQ9u2281t4EUivtgiDUqi/KGLR0VBZ0Sx3CJ
         5fgKY6xE5tzz5K/uUASOSZvAMpNYjCusJ5m5dK0YB5/R4hkT+J4YBHMcGdFFTRfHP4cG
         d3IVPuHfXoJ0tUbNXqZBBkOPnjEzudNJRZ4qxdWCmIOxKjSGPslbekiDxKAI8I/t4WZD
         TAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tUBcC0SNCBp3PnfiZFxMfw+Mig/Up7EwgRYp7Itl2Lg=;
        b=uOiuaT2xCGCZWgzBI8N267kLCt9YNJ9rljMxKOaep50CcD1nYgGSHlXmb6P+cUbK9G
         iTSe6k70aKcAUW8tIIlGLzfeWyHENWw8AAD1pywgSECKJqiyRg4nNsdRa7H2Woe5ez2p
         M9nwAJHs9osKrY1U6Keh9zdRQx95pLJLnL8VlRAKWJkEKStH7mWj7it0GGbSzr4/Cd1U
         cY5LQQi7WoDMp41d7PrZNP75jdA1yjQ+H1p5ykmPyM+Yi1HpO/ERoKZBaOAn+3e3M60q
         4OFfYg0AtX7fsF09ZSWZEmHgevnhJnFcpt3AlkAqGkzjs6rJJQ/D07rkQ5sxoTBSmPb7
         4quw==
X-Gm-Message-State: AOAM530e+S+cpQWsPolHgdtlGBBqjfyx7hL03ODewBHGf0728JVMr6Ug
        sZOzAWXUsJjPzCphzvbLehVthQ==
X-Google-Smtp-Source: ABdhPJwU+LlPBqor6y04zMsIQP4MWRHaWB0vp2tPe3ptiY8FPabgHTl9exDAHsSNG0dve3wXBaKJ2A==
X-Received: by 2002:a63:556:: with SMTP id 83mr100763pgf.1.1628109517348;
        Wed, 04 Aug 2021 13:38:37 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:ceb5:ef37:ced5:2d8c])
        by smtp.gmail.com with ESMTPSA id r18sm5022052pgk.54.2021.08.04.13.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 13:38:36 -0700 (PDT)
Date:   Wed, 4 Aug 2021 13:38:30 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 8/9] hook: teach 'hookcmd' config to alias hook scripts
Message-ID: <YQr6xojzxk3xJrTw@google.com>
References: <20210715232603.3415111-1-emilyshaffer@google.com>
 <20210715232603.3415111-9-emilyshaffer@google.com>
 <87fswey5wd.fsf@evledraar.gmail.com>
 <YPn/5GLrAb17KqyB@google.com>
 <87bl6ttmlv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bl6ttmlv.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 23, 2021 at 09:41:35AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> On Thu, Jul 22 2021, Emily Shaffer wrote:
> 
> > On Fri, Jul 16, 2021 at 11:13:42AM +0200, Ævar Arnfjörð Bjarmason wrote:
> >> 
> >> 
> >> On Thu, Jul 15 2021, Emily Shaffer wrote:
> >> 
> >> > To enable fine-grained options which apply to a single hook executable,
> >> > and to make it easier for a single executable to be run on multiple hook
> >> > events, teach "hookcmd.<alias>.config". These can be configured as
> >> > follows:
> >> > [...]
> >> > diff --git a/Documentation/config/hook.txt b/Documentation/config/hook.txt
> >> > index a97b980cca..5b35170664 100644
> >> > --- a/Documentation/config/hook.txt
> >> > +++ b/Documentation/config/hook.txt
> >> > @@ -3,6 +3,11 @@ hook.<command>.command::
> >> >  	executable on your device, a oneliner for your shell, or the name of a
> >> >  	hookcmd. See linkgit:git-hook[1].
> >> >  
> >> > +hookcmd.<name>.command::
> >> > +	A command to execute during a hook for which <name> has been specified
> >> > +	as a command. This can be an executable on your device or a oneliner for
> >> > +	your shell. See linkgit:git-hook[1].
> >> > +
> >> > [...]
> >> > +Global config
> >> > +----
> >> > +  [hook "post-commit"]
> >> > +    command = "linter"
> >> > +    command = "~/typocheck.sh"
> >> > +
> >> > +  [hookcmd "linter"]
> >> > +    command = "/bin/linter --c"
> >> > +----
> >> > +
> >> > +Local config
> >> > +----
> >> > +  [hook "prepare-commit-msg"]
> >> > +    command = "linter"
> >> > +  [hook "post-commit"]
> >> > +    command = "python ~/run-test-suite.py"
> >> > +----
> >> > +
> >> > +With these configs, you'd then run post-commit hooks in this order:
> >> > +
> >> > +  /bin/linter --c
> >> > +  ~/typocheck.sh
> >> > +  python ~/run-test-suite.py
> >> > +  .git/hooks/post-commit (if present)
> >> > +
> >> > +and prepare-commit-msg hooks in this order:
> >> > +
> >> > +  /bin/linter --c
> >> > +  .git/hooks/prepare-commit-msg (if present)
> >> >  
> >> 
> >> I still have outstanding feedback on the fundamental design
> >> here. I.e. why is this not:
> >> 
> >>     hook.<name>.event = post-commit
> >>     hook.<name>.command = <path>
> >> 
> >> See:
> >> 
> >> https://lore.kernel.org/git/87mtv8fww3.fsf@evledraar.gmail.com/
> >> 
> >> As noted there I don't see why not, and more complexity results from the
> >> design choice of doing it the way you're proposing. I.e. we can't
> >> discover hooks based on config prefixes, and we end up sticking full FS
> >> paths in config keys.
> >
> > Interesting. My gut says that it would make it harder to neatly write a
> > config with the same hook running at the very beginning of one event and
> > the very end of another, but I'm not sure whether that's a case to
> > optimize for.
> >
> > I would also need twice as many lines to run a script I wrote as a hook
> > - that is, the base case which is probably all most people will need. So
> > with your proposal I *must* name every hook I want to add. Instead of
> > "hook.pre-commit.command = ~/check-for-debug-strings" I need to
> > configure "hook.check-debug-strings.event = pre-commit" and
> > "hook.check-debug-strings.command = ~/check-for-debug-strings". That's a
> > little frustrating, and if I never want to skip that check or move it
> > later or something, it will be extra overhead for no gain for me.
> 
> The gain is that "git hook list" becomes a trivial "git config
> -show-origin --show-scope --get-regexp" wrapper.

This isn't a very compelling reason to me, if it makes the user
experience worse. (I'm not convinced that it does - just saying I
disagree with this reasoning.)

> 
> So the series either doesn't need "git hook list" or such a thing
> becomes much less complex, especially given the proposed addition of
> other features in the area like "git hook edit", i.e. (quoting the
> linked E-Mail):

I still think "git hook list" is useful to have for end-users, compared
to remembering the appropriate "git config" invocation. It futureproofs
us if we do want to change the execution ordering to something besides
config order, it's easier to remember/more discoverable, etc.

>     As just one example; surely "git config edit <name>" would need to
>     run around and find config files to edit, then open them in a loop
>     for you, no?
> 
>     Which we'd eventually want for "git config" in general with an
>     --edit-regexp option or whatever, which brings us (well, at least
>     me) back to "then let's just add it to git-config?".
> 
> > I do agree that your approach bans the regrettably awkward
> > "hookcmd.~/check-for-debug-strings.skip = true", but I'm not sure
> > whether or not it's worth it.
> 
> That design choice also means that you can't expand the path using "git
> config --get --type=path.

Yeah, this is a pretty handy point.

> 
> We do have that with the "includeIf" construct, but if we can avoid it
> we should, it makes it play nicer with other assumptions and features of
> the config system.
> 
> As noted in the follow-up reply while we don't case normalize the LeVeL"
> part of "ThReE.LeVeL.KeY" that's tolower(), which we know isn't a 1=1
> mapping on some
> FS's. https://lore.kernel.org/git/87y2ebo16v.fsf@evledraar.gmail.com/

This, too.

> 
> > To help us visualize the change, here's some common and complicated
> > tasks and how they look with either schema (let mine be A and yours be
> > B):
> 
> Before diving into that, I'll just say I don't care about the trivial
> specifics of how this is done, i.e. the bikeshedding of what the config
> keys etc. are named.
> 
> Just in (as noted above) design choices here forcing avoidable
> complexity in other areas.
> 
> > #1 - Add a oneliner (not executing a script)
> > A:
> > [hook "post-commit"]
> > 	command = echo post commit
> > B:
> > [hook "oneliner"]
> > 	event = post-commit
> > 	command = echo post commit
> > #2 - Execute a script
> > A:
> > [hook "post-commit"]
> > 	command = ~/my-post-commit-hook
> > B:
> > [hook "script"]
> > 	event = post-commit
> > 	command = ~/my-post-commit-hook
> 
> ...
> 
> > #3 - Run a handful of scripts in a specific order on one event
> > A:
> > [hook "post-commit"]
> > 	command = ~/my-post-commit-1
> > 	command = ~/my-post-commit-2
> > 	command = ~/my-post-commit-3
> > B:
> > [hook "script 1"]
> > 	event = post-commit
> > 	command = ~/my-post-commit-1
> > [hook "script 2"]
> > 	event = post-commit
> > 	command = ~/my-post-commit-2
> > [hook "script 3"]
> > 	event = post-commit
> > 	command = ~/my-post-commit-3
> 
> To reply to all the above, yes, your suggestion comes out ahead in being
> less verbose.
> 
> But isn't the real difference not in the differing prefixes, i.e. hook.*
> and hookcmd.* (A) v.s. always hook.* (B, which is what I'm mainly
> focusing on, i.e. what requires the added complexity.
> 
> But that in that in your proposed way of doing it it's:
> 
>     hook.<event-or-name>.*
> 
> V.s. my suggestion of:
> 
>     hook.<name>.*
> 

No, I think that's a misunderstanding of proposal A. My proposal A is
always hook.<event>.*, and hookcmd.<name>.*, and the way that I read
your proposal B is that it's always hook.<name>.*.

> And thus whenever you have a <event-or-name> that just happens to be a
> built-in hook listed in githooks(5) we in (A) implicitly expand config
> like:
> 
>     hook.post-commit.command = echo foo
> 
> 
>     hook.post-commit.command = echo hi
>     hook.post-commit.type    = post-commit

This is where I'm becoming confused. I *think* you're saying that with
your proposal B, if the subsection happens to be the name of a built-in
hook, we can skip the .event field. But it also reads like you're saying
this is how my proposal A works, which isn't the case, because the
subsection is always assumed to be the name of the hook event we're
trying to run.

> 
> But not knowing about "foo" we don't expand:
> 
>     hook.foo.command = echo foo
> 
> 
>     hook.foo.command = echo hi
>     hook.foo.type    = foo # This would be an error, or ignored.
> 
> But rather leave "dangling" for the user to later supply the "*.event"
> themselves, i.e.:
> 
>     hook.foo.command = echo hi
>     hook.foo.event = post-commit

If you're talking about proposal B, then no, this isn't how it works.
This config would imply that someone else (like a wrapper) can run "echo
hi" by asking for "git hook run foo". But I'm not sure exactly that
that's what you mean...

> 
> And means that you presumably need to detect this case and error about
> it, but my proposed model does not:
> 
>     hook.post-commit.command = echo hi
>     # User error: "*.type" and <event-or-name>" does not match for
>     # "hook.*.command"
>     hook.post-commit.type    = pre-commit
> 
> And furthermore, that if someone in your model were to do:
> 
>     hook.verify-commit.command = echo hi
> 
> It's "dangling" today, but if a later version of git learns about a
> "verify-commit" hook we'll start running it unexpectedly.

No, that's in fact as designed, with my model B. The user configured
"echo hi" to run on "verify-commit" events; if those events are
initially used by some wrapper, but later we decide they're a great idea
and absorb the verify-commit event into native Git, then this is working
as intended. I think your argument is based on a misunderstanding of the
design.

Could it be that the way I provided the examples (my schema after A: and
your schema after B:) made it hard to parse? Sorry about that if so.

> 
> Because your design conflates the slot for known hook type names and
> user-supplied names.
> 
> On balance I think it's better just to always supply two lines per-hook,
> but whether we have this proposed shorthand or not is mostly orthogonal
> to everything I mentioned in
> https://lore.kernel.org/git/87mtv8fww3.fsf@evledraar.gmail.com/
> 
> I.e. my proposed version could also have it, but thinking about it I
> think it's not worth it, we should always use <name>, not
> <event-or-name> for the reasons noted if you'll read ahead...
> 
> > #4 - Skip a script configured more globally
> > A:
> > (original config)
> > [hook "post-commit"]
> > 	command = /corp/stuff/corp-post-commit
> > (local config)
> > [hookcmd "/corp/stuff/corp-post-commit"]
> > 	skip = true
> > OR,
> > (original config)
> > [hookcmd "corp-pc"]
> > 	command = /corp/stuff/corp-post-commit
> > [hook "post-commit"]
> > 	command = corp-pc
> > (local config)
> > [hookcmd "corp-pc"]
> > 	skip = true
> > B:
> > (original config)
> > [hook "corp-pc"]
> > 	event = post-commit
> > 	command = /corp/stuff/corp-post-commit
> > (local config)
> > [hook "corp-pc"]
> > 	skip = true
> 
> ...which are among other things that no, my proposed version doesn't
> have "skip" at all, see point #3 at
> https://lore.kernel.org/git/87mtv8fww3.fsf@evledraar.gmail.com/
> 
> I.e. I think the "skip" is a thing that falls out of a complexity of
> your design that I'm proposing to do away with.
> 
> That complexity being that you use <event-or-name> and I use <name>, and
> you want to in turn support N number of "*.command" for any
> "hook.<event-or-name>".
> 
> I'm suggesting we use the typical "last key wins" semantics, if you want
> multiple commands for a given hook type you'll just supply multiple
> "hook.<name>" sections with the same "hook.*.event = type" in all.
> 
> The way to skip hooks in my proposal is:
> 
>     hook.<name>.command = true

I see - instead of fiddly reorganizing the list, you're just changing
what the specific hook name is redirecting to.

Then, instead of storing the resolved command in the 'struct hook', we
can store the name, and always dereference the name right before
execution, using last-one-wins semantics.

The only thing I don't like about this is that it's a little bit
confusing to the user. I personally would rather have more complicated
code and less complicated user experience, so I like 'skip' more because
it's readable and because you don't need to guess "oh, it'll just
execute /bin/true which is a noop". That's easy to understand for
someone familiar with Unix scripting (and therefore for we Git
contributors), but confusing for everybody else.

Maybe we can take the essential spirit of this implementation but make
it a little bit simpler. In pseudocode:

populate_list(hookname):
  # look for everybody who says "hook.*.event = $hookname"
  hooks = get_configs_matching(hook.*.event, hookname)
  # the "*" bit is the bit we dereference later
  for hook in hooks:
    hook_list.add({.name = hook.key.subsection})

run_hooks(hook_list):
  for hook in hook_list:
    # should we even run?
    if (get_last_config("hook." + hook.name + ".skip"))
      continue

    # dereference the hook name and find out the command
    cmd = get_last_config("hook." + hook.name + ".command")
    run(cmd)

The price for this improved readability is an extra config lookup in
each case. But the code is still readable, definitely moreso than
rewalking the config list over and over as the implementation stands
now. I personally think it's worth it.

(One could also imagine a more readable placeholder than /bin/true in
the "hook.<name>.command" field, but then we get to decide just how hard
we want to avoid colliding with legitimate user hook names. Is .command
= skip enough? is .command = RESERVED_NAME_SKIP_THIS_HOOK enough? Is
something unrunnable like .command = "skip me" enough, although it could
conceivably collide with a determined user?)

> 
> Or whatever noop command you want on the RHS. In practice we wouldn't
> invoke "true", just like we don't invoke "cat" for "PAGER=cat".
> 
> But unlike "*.skip" that doesn't require complexity in implementation or
> user understanding, it just falls naturally out of the rest of the
> model.
> 
> > #5 - Execute one script for multiple events
> > A:
> > [hookcmd "reusable-hook"]
> > 	command = /long/path/reusable-hook
> > [hook "post-commit"]
> > 	command = reusable-hook
> > [hook "pre-commit"]
> > 	command = reusable-hook
> > [hook "prepare-commit-msg"]
> > 	command = reusable-hook
> > B:
> > [hook "reusable-hook"]
> > 	command = /long/path/reusable-hook
> > 	event = post-commit
> > 	event = pre-commit
> > 	event = prepare-commit-msg
> 
> It's been so long since I wrote the original E-Mail that I'm having to
> skim my own summary there & come up with things as I go along, so maybe
> this conflicts with something I said earlier.
> 
> But no, I don't think I meant that *.event should be multi-value, or
> that that magic is worthwhile. I.e. I think we just want:
> 
>     [hook "not-a-reusable-section-1"]
>         command = /long/path/reusable-hook
>         event = post-commit
>     [hook "not-a-reusable-section-2"]
>         command = /long/path/reusable-hook
>         event = pre-commit
>     [hook "not-a-reusable-section-3"]
>         command = /long/path/reusable-hook
>         event = prepare-commit-msg
> 
> I.e. is wanting to use the same command for N different hooks really
> that common a use-case to avoid a little verbosity, and quite a lot of
> complexity?
> 
> How would such a hook even be implemented?
> 
> We don't have anything in your hook execution model (and I don't
> remember you adding this) which passes down a "you are this type of
> hook" to hooks.

No, but it's something I'm interested in passing as an environment
variable. I didn't add it to this series because it seemed to me to
distract from the core feature. We would like to add it to simplify our
invocations of https://github.com/awslabs/git-secrets, so it's on my
radar.

And even without this, just today I wanted to configure a hook to really
make sure I had config.mak set up in all my Git worktrees (since you
pointed out I pushed code that fails -Wall.... ;) ) and set it up to run
on both pre-commit and post-checkout. So yes, it is feasible now, for
very stupid hooks.

> 
> It's now implicit in that the hook invoked at .git/hooks/post-commit or
> .git/hooks/pre-commit can check its own basename, but it won't be with
> configurable hooks.
> 
> We could start passing down a GIT_HOOK_TYPE in the environment or
> whatever, but I think the simpler case of just having the user do it is
> better.
> 
> I'm assuming that mainly because people have wanted a
> "/long/path/reusable-hook" router script because we have not supported
> executing N hooks, or supported concurrency. Once we do that the
> complexity of such routing scripts (mostly, not everyone's needs will be
> met) will be replaced by a little bit of config.

The above linked git-secrets is an example; the config is irritating and
doesn't really need to be there, when we could just teach the script
itself how to check GIT_HOOK_TYPE envvar.

> 
> I don't see why it's worth it to micro-optimize for lines in that config
> at the cost of increased config complexity.
> 
> For example, how do you "skip" an "event" type? You have it for
> "*.command"? So let's say in your model (A) I have system config like:
(The following isn't how my model A works, because it refers always to
"hook.<event>", as I mentioned above. But I also covered this same topic
in detail earlier in this email, so I'm going to snip this section.)

> > #6 - Execute the same script early for one event and late for another
> > event
> > A:
> > (global)
> > [hookcmd "reusable-hook"]
> > 	command = /long/path/reusable-hook
> > [hook "pre-commit"]
> > 	command = reusable-hook
> > (local)
> > [hook "post-commit"]
> > 	command = other
> > 	command = hooks
> > 	command = reusable-hook
> 
> Even with I think it's fair to say deep knowledge of your proposal at
> this point I still needed to read this a few times to see if that:
> 
>     command = reusable-hook
> 
> Is referring to:
> 
>     [hookcmd "reusable-hook"]
> 
> I.e. is it going to run:
> 
>     command = /long/path/reusable-hook
> 
> Or is it just re-specifying /long/path/reusable-hook but relying on a
> $PATH lookup?
> 
> Having reasoned through that I think the answer is the former. But that
> also means that in your model:
> 
>     [hookcmd "rm -rf /"]
>     command = echo this will not actually destroy your data
>     [hook "pre-commit"]
>     command = rm -rf /
> 
> Is going to run that friendly "echo" command, since "command = rm -rf /"
> just refers to the "rm -rf /" <name>, not <command>, right the "hookcmd"
> line is removed, at which point we'll stop treating it as a <name> and
> run it as a <command>?
> 
> In practice I think users are unlikely to use actively harmful names
> like that.
> 
> I'm just making the point that I should not need to know about previous
> config to see if a "hook.pre-commit.command = rm -rf /" is harmless or
> not, or need to carefully squint to see if the "reusable-hook" is
> referring to a section name or command name.
> 
> Or am I just confused at this point?

Nah, that's an accurate understanding of how it would work with the
current implementation. Sure, it's a good point.

> 
> > B:
> > (global)
> > [hook "reusable-hook"]
> > 	command = /long/path/reusable-hook
> > 	event = pre-commit
> > (local)
> > [hook "other"]
> > 	event = post-commit
> > 	command = other
> > [hook "hooks"]
> > 	event = post-commit
> > 	command = hooks
> > [hook "reusable-hook"]
> > 	event = reusable-hook

Hm, I think I mistyped when I wrote "event = reusable-hook" here, and
meant to write "event = post-commit" to indicate that we would move
"reusable-hook" to the bottom of the execution list for "post-commit".

I'll snip most of the rebuttal about my typo.

> 
>         (global)
> 	[hook "reusable-hook"]
> 		command = /long/path/reusable-hook
> 		event = pre-commit
> 
> 	(local)
> 	[hook "reusable-hook"]
> 		command = true # skip it
> 
>         # The "hooks" name is arbitrary, "my-hooks" or whatever would be
>         # clearer, but just going with your example...
> 
> 	[hook "hooks"]
> 		event = post-commit
> 		command = hooks
>         # Not very reusable then...   
> 	[hook "reusable-hook"]
>                 command = /long/path/reusable-hook
> 		event = pre-commit
> 
> 
> > [...]Please feel free to chime in with more use cases that you think would
> > be handy which I forgot :)
> 
> I couldn't find this at a quick glance but I think we also had a
> disussion at some point about hooks controlling parallelism. AFAICT your
> current implementation just has global:
> 
>     hook.jobs=N
> 
> And we then blacklist certain hooks to always have hook.jobs=1, e.g. the
> commit-msg hook that needs an implicit "lock" on that file (or rather,
> we think that's the most common use-case).
> 
> I think my version of always having hook.<name>.{event,command} be one
> value is also better in that case, i.e. we'd then:
> 
>     [hook "myhook"]
>     command = some-command
>     event = pre-receive
>     parallel = true # the default
> 
>     [hook "myhook2"]
>     command = some-command2
>     event = pre-receive
>     parallel = true # the default
> 
>     [hook "myhook3"]
>     command = some-unconcurrent-command
>     event = pre-receive
>     parallel = false # I'm not OK with concurrency

I am not sure what it means for a single executable to write "parallel =
true" - it is a single executable.

Ok, that is me being facetious - I think you are saying we can AND
together all of the 'hook.<thing-with-event-we-care-about>.parallel' to
decide whether or not to run in parallel.

I would rather not discuss this now, for this series, because regardless
of which config schema we use today, we can figure out "parallel unless
we really don't want it" later on. It is too complex to discuss in the
context of "hey, we should also configure hooks somewhere else". Let's
leave it for future work.

> I haven't thought about it deeply, but have a hunch that having sections
> be a 1=1 mapping with a specific command instead of either 1=1 or 1=many
> is going to make that easier to implement and understand.

Sure, probably. But it can be added later to either schema... ;)


Anyway, I did a quick strawpoll with my colleagues (Jonathan Nieder,
Jonathan Tan, and Josh Steadmon) and they all like your syntax more. I
am ambivalent between the two, personally.

So what I will do, hopefully today, maybe not, is the following:

 - no more hookcmd. (and there was much rejoicing)
 - Hooks are specified with "[hook "name-of-hook"]"
 - I do see value in having an explicit .skip field rather than mapping
   .command to a noop, so "hook.name-of-hook.skip" as described above.
   Of course the method you described will work regardless, since its
   mechanism is based on the inherent result of executing /bin/true.
 - I do see value in allowing "hook.name-of-hook.event" to be defined
   repeatably, as described above, so I will include that.

And left for later work:
 - teaching HOOK_EVENT_NAME=post-commit (etc)
 - figuring out what the heck we want to do with allowing hooks to
   describe whether they allow parallelism

Unfortunately I've dropped the design doc from this series, since nobody
seemed interested in having it checked in, but I'll try to rework the
help doc to make the schema more clear.

Thanks, I think it was useful to hash this out.

 - Emily
