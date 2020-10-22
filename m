Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A27C2D0A3
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 00:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 696F32237B
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 00:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CUcxBdlK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894530AbgJVA6z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 20:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2894527AbgJVA6y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 20:58:54 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6463C0613CE
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 17:58:54 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id l18so2566138pgg.0
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 17:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=X75WM4ipqnmKVPnVAF4ruLR0E1TPAPJ2nXyK0Gz1ri4=;
        b=CUcxBdlKCf5NxtWl2S8HCUU8np7KAqzQxWKizQIt5/LYK3gGjj+ct7fWQPHm7Rf6e0
         GWuxqKCt/YegYXZZqeD7DdKvSyOYNmy7kKBgl2PvbIt/W23YVuZXT5SOfzoL0c9vRiLj
         6Tku6i7BaDYt+pzaSFH1wrYZYHK9rzTPybagwcHAfEE3AhBOMYWzRUsaWj03+3eaulla
         P2dVPJ3dfT+XnB9wPwFYsQxIxl9FxhWvXycbrEbBQ6j7LQaI1ZtSAMsDfBGePMT+Yf/z
         EwFokKVwxZmubHVWZWHPnZL20nmgHPXHRwFolq3M7DGLZZPUdulYCzmZRJ4tL92W4gqv
         nRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=X75WM4ipqnmKVPnVAF4ruLR0E1TPAPJ2nXyK0Gz1ri4=;
        b=r0l+eXUEFu4TQq06uWBrlF8zRzuTZg8o5R/ytabCJZxUXifgMMf2Lj0qStPrtVHxBM
         V1fiyrx/mGspdzg7zdeAaWZuEr0dn68A3TSLDGO/WhTFFL6sNWGy5mykqy7pG24Tbw7D
         UYu6AeAytzESb9XBKdDOp4E/3XthaKc6vAGeNc3itthdlrl1rlcfTSFNeZ0lPdNlrwj9
         qcVz3N0Fi8pT/Pt7jHCvmH0uIB5Wn2u89NOmyddtxuT45u3OdVi2uw21mq4xJyP55VU4
         U2+27yBaOa5MyvzVYGH5nFXIqwW2JUy3nOH3Xc3Dcru2QD7dhi+jcejorzazN1kcSgru
         8aUQ==
X-Gm-Message-State: AOAM533DTcZAAYtyJrJCUSxA0RBQNGe/n4/ouNGnc5/jKpZukBnVrMCc
        d1NcvSZi+nqftLyfUB6hms6/Uw==
X-Google-Smtp-Source: ABdhPJzrhRpoILH6yD+ii8WRD44OKwC8h/mxS00csCABe2y0AJSrrcrlH59sHzUbrN5IZ+IFdLnswQ==
X-Received: by 2002:a62:53c1:0:b029:156:438e:2d6c with SMTP id h184-20020a6253c10000b0290156438e2d6cmr184631pfb.37.1603328333582;
        Wed, 21 Oct 2020 17:58:53 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id n6sm14731pjj.34.2020.10.21.17.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 17:58:52 -0700 (PDT)
Date:   Wed, 21 Oct 2020 17:58:48 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 1/9] doc: propose hooks managed by the config
Message-ID: <20201022005848.GD2774782@google.com>
References: <20200909004939.1942347-1-emilyshaffer@google.com>
 <20200909004939.1942347-2-emilyshaffer@google.com>
 <87mu0ygzk1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mu0ygzk1.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 07, 2020 at 11:23:10AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> On Wed, Sep 09 2020, Emily Shaffer wrote:
> 
> First, thanks a lot for working on this. As you may have found I've done
> some small amount of actual work in this area before, but mostly just
> blathered about it on the ML.
> 
> > Begin a design document for config-based hooks, managed via git-hook.
> > Focus on an overview of the implementation and motivation for design
> > decisions. Briefly discuss the alternatives considered before this
> > point. Also, attempt to redefine terms to fit into a multihook world.
> > [...]
> > +[[status-quo]]
> > +=== Status quo
> > +
> > +Today users can implement multihooks themselves by using a "trampoline script"
> > +as their hook, and pointing that script to a directory or list of other scripts
> > +they wish to run.
> 
> ...or by setting core.hooksPath in their local/global/system
> config. Granted it doesn't cover the malicious hook injection case
> you're also trying to solve, but does address e.g. having a git server
> with a lot of centralized hooks.

Aha, setting core.hooksPath in the global/system config had not occurred
to me.

> 
> The "trampoline script" also isn't needed for the common case you
> mention, you just symlink the .git/hooks directory (as e.g. GitLab
> does). People usually use a trampoline script for e.g. using GNU
> parallel or something to execute N hooks.

Hm, I don't think that's quite true. Symlinking out .git/hooks doesn't
give me more than one $HOOKDIR/pre-commit - it just gives me a different
one. So if I wanted to run three different hooks, $HOOKDIR/pre-commit
would need to do the work of all three, regardless of where $HOOKDIR
points. That's what I meant when I said "multihooks" in this section.

But I think what you're trying to say is this: the "status quo" section
doesn't fully cover the status quo. There are more tricks than I
mentioned, e.g. 'git config --global core.hooksPath
/home/emily/githook/' to get the same set of hooks to run everywhere.
This approach still has some drawbacks - for example, it doesn't allow
me to use language-specific linters if I have repos in various
languages, without exempting an individual repo from the ~/githook/ by
'git config --local core.hooksPath
/home/emily/my-python-thing/.git/hook'.

It looks like, then, the "status quo" section needs some rework for the
next iteration.

> 
> 
> > +[[hook-directories]]
> > +=== Hook directories
> > +
> > +Other contributors have suggested Git learn about the existence of a directory
> > +such as `.git/hooks/<hookname>.d` and execute those hooks in alphabetical order.
> 
> ...which seems like an easy thing to add later by having a "hookdir" in
> addition to "hookcmd", i.e. just specify a glob there instead of a
> cmd/path.

Hum, interesting! Something like so:

[hook.pre-commit]
  command = last-minute-checks

[hookdir.last-minute-checks]
  dir = /home/emily/last-minute-checks/*

And then the hooks library knows to go and run everything in
~/last-minute-checks/. This is easier to keep fresh than:

[hook.pre-commit]
  command = /home/emily/last-minute-checks/c-linter
  command = /home/emily/last-minute-checks/check-for-debug-prints
  command = /home/emily/last-minute-checks/check-for-notes
  ...

I actually like the idea of this for folks who might have a small number
of hooks they wrote for themselves. I wonder if it's applicable for
something like git-secrets, which presumably users would grab with a
'git clone' later.

It doesn't seem at odds with the rest of the design - how would you feel
about me adding it to the "future work" section at the end? Future work,
rather than "Emily will do this in the next couple of rounds", because:
 - I think nobody already has their hooks in $HOOKDIR/hook/pre-commit.d
   without a corresponding trampoline in $HOOKDIR/hook/pre-commit; so
   they could still call that trampoline, for now
 - I think it might be prone to some bikeshedding - e.g. should we
   recurse into ~/last-minute-checks/linters/c/? how far? what if some
   script requires magic options? etc? But as I'm typing those questions
   out they sound mostly trivial or ridiculous, so maybe my assessment
   is wrong here.
 - It sounds like you might be keen to write it, or at the very least,
   more keen than me
 - Practically speaking, I am not sure I have time to do it alongside
   the rest of the series. Again, my bikeshedding assessment could be
   wrong, and this extra feature could be totally trivial.

> You already use "hookdir" for something else though, so that's a bit
> confusing, perhaps s/hookcmd/definehookcmd/ would be less confusing, or
> perhaps more confusing...

"Hookdir" might be the wrong word to use, too - maybe it's better to
mirror "hookspath" there. Eitherway, "hookdir" and "hookspath" are
similar enough that I think it would be confusing, and "hookcmd" is
already getting some side-eye from me for not being a great choice.

Some thoughts for "a path to a directory in which multiple scripts for a
single hook live":
 - hookset
 - hookbatch (ugh, redundant with MS scripting)
 - hook.pre-commit.all-of = ~/last-minute-checks/
 -  "   "  .everything-in = "   "
...?

I think I named a couple silly ideas for "hookcmd" in another mail.

> 
> > [...]
> > +[[execution-ordering]]
> > +=== Execution ordering
> > +
> > +We may find that config order is insufficient for some users; for example,
> > +config order makes it difficult to add a new hook to the system or global config
> > +which runs at the end of the hook list. A new ordering schema should be:
> > +
> > +1) Specified by a `hook.order` config, so that users will not unexpectedly see
> > +their order change;
> > +
> > +2) Either dependency or numerically based.
> > +
> > +Dependency-based ordering is prone to classic linked-list problems, like a
> > +cycles and handling of missing dependencies. But, it paves the way for enabling
> > +parallelization if some tasks truly depend on others.
> >
> > +Numerical ordering makes it tricky for Git to generate suggested ordering
> > +numbers for each command, but is easy to determine a definitive order.
> > +
> > +[[parallelization]]
> > +=== Parallelization
> > +
> > +Users with many hooks might want to run them simultaneously, if the hooks don't
> > +modify state; if one hook depends on another's output, then users will want to
> > +specify those dependencies. If we decide to solve this problem, we may want to
> > +look to modern build systems for inspiration on how to manage dependencies and
> > +parallel tasks.
> 
> If you're taking requests it would make me very happy if we had
> parallelism in this from day one. It's the kind of thing that's hard to
> do by default once a feature is shipped since people will implicitly
> depend on it not being there, i.e. we won't know what we're breaking.

Hm. This might be tricky.

Some hooks are inherently not able to be parallelized - for example,
hooks which modify a given file, like the commit message draft. In
general, based on the handful of hooks I've converted locally, it's hard
to check whether a callsite assumes a hook could have modified state.
Usually this seems to be done with a call to find_hook() ("was there a
hook that might have run?") and then reopening the file. Sometimes a
file is reopened unconditionally. Sometimes the find_hook() call is
very far away from the run_hook_le() call.

The rest, then, which only read a file and say yes or no, probably don't
need to have a strict ordering - at least as far as Git is concerned.
And I think that's what you're worried about:

[hook.theoretical-parallelizable-event]
  command = check-and-mark-a-file-foo
  command = check-file-foo-and-do-something-else
  command = do-something-totally-unrelated

On day 1 of this feature, as written, this is safe. But if we aren't
careful and we start to parallelize *without* setting up dependency
ordering, e.g. 'git config --global hook.parallelize', and turn that on
by default without warning anyone, then the author of this config will
be unhappy.

But as I read further, you're talking about specifically *not* allowing
dependency ordering...

> 
> I think doing it this way is simple, covers most use cases, and solves a
> lot of the problems you note:
> 
> 1. Don't use config order to execute hooks, use glob'd name order
>    regardless of origin. I.e. a system-level hook is called "001-first"
>    is executed before a local hook called "999-at-the-end" (or the other
>    way around, i.e. hook origin doesn't matter).

Can you say a little more about why different ordering schema would
matter, if we effectively don't care which jobs are in parallel with
which, as you describe? I'm not quite following.

> 
> 2. We execute hooks parallel in that glob order, i.e. a pthread for-loop
>    that starts the 001-first task first, eventually getting to
>    999-at-the-end N at a time. I.e. the same as:
> 
>        parallel --jobs N --halt-on-error soon,fail=1" ::: <hooks-in-glob-order>
> 
>    This allows for parallelism but guarantees the very useful case of
>    having a global log hook being guaranteed to execute.

Ah, I think you're suggesting the glob order specifically to make up for
--halt-on-error in this case.

> 
> 3. A hook can define "parallel=no" in its config. We'll then run it
>    while no other hook is running.
> 
> 4. We don't attempt to do dependencies etc, if you need that sort of
>    complexity you can just make one of the hooks be a hook runner as
>    users do now for the common "make it parallel" case.

If we aren't attempting any magical ordering, then I don't really see a
big difference between glob vs. config order - presumably for most users
the effect would be same, e.g. N = $(nproc * hyperthreading), M = (number of scripts I
care to run) probably will often result in M < N, so all jobs would run
simultaneously anyways.

> 
> It's a relatively small change to the code you have already. I.e. the
> for_each() in run_hooks() would be called N times for each continuous
> glob'd parallel/non-parallel segment, and hook_list()'s config parsing
> would learn to spew those out as a list-of-lists.
> 
> This also gives you a rudimentary implementation of the dependency
> schema you proposed for free. I.e. a definition of (pseudocode):
> 
>     hookcmd=000-first
>     parallel=no
> 
>     hookcmd=250-middle-abc
>     hookcmd=250-middle-xyz
> 
>     hookcmd=300-gather
>     parallel=no
> 
>     hookcmd=999-the-end
> 
> Would result in the pseudocode execution of;
> 
>     segments=[[000-first],
>               [250-middle-abc, 250-middle-xyz],

Hum. This seems to say "folks who started their hooks with the same
number agree that their hooks should also run simultaneously" - which
sounds like an even harder problem than "how do I know my ordering
number isn't the same as someone else's in another config file". Or else
I'm misunderstanding your pseudo :)

Ah, I see later you mention it directly as a dependency schema. I think
this offers the same set of problems I saw trying to use this as an
ordering schema, but worse in all the usual ways parallelism provides.
It is still impossible for someone writing a global or system config to
know where in the dependency chain more local hooks reside.

>               [300-gather],
>               [999-the-end]]
>     for each s in segments:
>         ok = run_in_parallel(s)
>         last if !ok # or, depending on "early exit?" config
> 
> I.e.:
> 
>  * The common case of people adding N hooks won't take sum(N) time.
> 
>  * parallel=no hooks aren't run in parallel with other non-parallel
>    hooks
> 
>  * We support a rudimentary dependency schema as a side-effect,
>    i.e. defining 300-gather as non-parallel allows it to act as the sole
>    "reduce" step in a map/reduce in a "map" step started with the 250-*
>    hooks.

As I understand it, the main concerns you have about getting
parallelization to happen on day 1 are like so:

 - keep users from assuming serial execution
 - avoid a messy schema change to deal with dependencies

I see the benefit of the former; I don't like the new schema proposed by
the latter. I do see that not turning it on day 1 would prevent us from
turning it on by default later, in case users did something silly like
assume dependencies.

Hrm.

I think we could turn on parallelization day 1 by providing an
explicitly-parallel API in hook.h (and a similar 'git hook run foo
--parallel' flag), and being more careful when converting hooks to call
run_hooks_parallel() instead of run_hooks(). That way hooks which will
never be parallelizable (e.g. commit-msg) won't get burned later by us
trying to be clever. Everyone else who can be parallelized is, in config
order, with no dependency management whatsoever. That leaves the door
open for us to add dependency management however we want later on, but
users can still roll their own with a launcher script today.

I know I rambled a lot - I was trying to convince myself :) For now, I'd
prefer to add more detail to the "future work" section of the doc and
then not touch this problem with a very long pole... ;) Thoughts
welcome.

> 
> > +[[securing-hookdir-hooks]]
> > +=== Securing hookdir hooks
> > +
> > +With the design as written in this doc, it's still possible for a malicious user
> > +to modify `.git/config` to include `hook.pre-receive.command = rm -rf /`, then
> > +zip their repo and send it to another user. It may be necessary to teach Git to
> > +only allow inlined hooks like this if they were configured outside of the local
> > +scope (in other words, only run hookcmds, and only allow hookcmds to be
> > +configured in global or system scope); or another approach, like a list of safe
> > +projects, might be useful. It may also be sufficient (or at least useful) to
> > +teach a `hook.disableAll` config or similar flag to the Git executable.
> 
> I think this part of the doc should note a bit of the context in
> https://lore.kernel.org/git/20171002234517.GV19555@aiede.mtv.corp.google.com/
> 
> I.e. even if we get a 100% secure hook implementation we've done
> practically nothing for overall security, since we'll still run the
> pager, aliases etc. from that local repo.
> 
> This is a great step in the right direction, but it behooves us to note
> that, so some user reading this documentation without context doesn't
> think inspecting untrusted repositories like that is safe just because
> they set the right hook settings in their config (once what's being
> proposed here is implemented).

Yeah, I agree. I'll try to make that clearer in the doc in the next
reroll.

Very sorry again for having missed this - I think the first weeks of
October I was working from my local todo list instead of from the list
of replies in mutt. Urk.

 - Emily
