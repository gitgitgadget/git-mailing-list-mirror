Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD686C388F9
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 19:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DFF720BED
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 19:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M12JWcj3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754264AbgJWTK2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 15:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754259AbgJWTK2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 15:10:28 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2130C0613CE
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 12:10:27 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id dt13so3783987ejb.12
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 12:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=v8qtjF/TF72+hTwDH/c/PUNwaZfU1yBTup3i5d+H+vE=;
        b=M12JWcj3wkY72qOKyyXl00pn4ccIbMdYR5CEZ5bn0jrKqMTBm4Fq80C0KOc4Sexd3/
         C4KBWft6peOWrSm56khtU94XkO5WsvOgzHc/u4LHAOBQkcuG804K21EoU5Jl4QR5djii
         zcFXgmmcdMR4M2YIZWRzoax33MNwKNUiX6bNqQuwd5xBCL1tnxxlZ7Qkw/mSiuoRmOSV
         ZThWDpCyBvf+Zk+iQ+lWfZJF/wb87O/h8F2LQUBB+P6nBwt+JSPdBgsM2xye4hcd2Z3m
         chEdcfqjChFzkyasapryEqVfeDyF6bJXEWFvIrxsqsaF4EA2O5yyByGPsYOF6d1aAQ5P
         SKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=v8qtjF/TF72+hTwDH/c/PUNwaZfU1yBTup3i5d+H+vE=;
        b=D5kmbRQFVYZ1p7oDRWX3C2leFSIK7fPDTEj6f4jQ5U2SR/bvghKNJkNkoL1IK8tvhF
         h+0ofPABIIhjo012Wuv0YgVgA0/TJK4O5xQQkYZRQ0//TxCbeD/V2q+HWn3AW0QsgZ3d
         Y0OSxYsQFibDW3lxTjD98Fw24rKWd1ful9LqNWsqfHohuX6vPdY2opi6FZivPT5SfJUx
         hK/fJlvfFOm/drovjjZtOcEGivjtSjclU6DFqzxRC+XfnXrW9lNFW3M46UQkn6FA/Kv5
         1XOKQ1914FZROFJdeBByLda/bhznyEnvzm9UIJof3sHbfLx5tgHlzQkgBpzggjtDTyUG
         05nQ==
X-Gm-Message-State: AOAM530F4OoKPMgodTswQ46xbe+R7pYoPn4+z9EEQGpD7Rv+Qm50jakF
        6ArLSOCf6MxhQp83GEneAK+cjx3DlqI=
X-Google-Smtp-Source: ABdhPJwRCHI79hCza75bubOh0O+Xm3bh1IeyjGIOhEIPZnUPtrfjnobZeFGiDhdHjpN97hFnz5h41Q==
X-Received: by 2002:a17:906:7844:: with SMTP id p4mr3408924ejm.26.1603480226062;
        Fri, 23 Oct 2020 12:10:26 -0700 (PDT)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id yw17sm1224067ejb.97.2020.10.23.12.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 12:10:25 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 1/9] doc: propose hooks managed by the config
References: <20200909004939.1942347-1-emilyshaffer@google.com> <20200909004939.1942347-2-emilyshaffer@google.com> <87mu0ygzk1.fsf@evledraar.gmail.com> <20201022005848.GD2774782@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <20201022005848.GD2774782@google.com>
Date:   Fri, 23 Oct 2020 21:10:24 +0200
Message-ID: <87zh4chi73.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 22 2020, Emily Shaffer wrote:

> On Wed, Oct 07, 2020 at 11:23:10AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>=20
>>=20
>> On Wed, Sep 09 2020, Emily Shaffer wrote:
>>=20
>> First, thanks a lot for working on this. As you may have found I've done
>> some small amount of actual work in this area before, but mostly just
>> blathered about it on the ML.
>>=20
>> > Begin a design document for config-based hooks, managed via git-hook.
>> > Focus on an overview of the implementation and motivation for design
>> > decisions. Briefly discuss the alternatives considered before this
>> > point. Also, attempt to redefine terms to fit into a multihook world.
>> > [...]
>> > +[[status-quo]]
>> > +=3D=3D=3D Status quo
>> > +
>> > +Today users can implement multihooks themselves by using a "trampolin=
e script"
>> > +as their hook, and pointing that script to a directory or list of oth=
er scripts
>> > +they wish to run.
>>=20
>> ...or by setting core.hooksPath in their local/global/system
>> config. Granted it doesn't cover the malicious hook injection case
>> you're also trying to solve, but does address e.g. having a git server
>> with a lot of centralized hooks.
>
> Aha, setting core.hooksPath in the global/system config had not occurred
> to me.

It's a useful hack.

>>=20
>> The "trampoline script" also isn't needed for the common case you
>> mention, you just symlink the .git/hooks directory (as e.g. GitLab
>> does). People usually use a trampoline script for e.g. using GNU
>> parallel or something to execute N hooks.
>
> Hm, I don't think that's quite true. Symlinking out .git/hooks doesn't
> give me more than one $HOOKDIR/pre-commit - it just gives me a different
> one. So if I wanted to run three different hooks, $HOOKDIR/pre-commit
> would need to do the work of all three, regardless of where $HOOKDIR
> points. That's what I meant when I said "multihooks" in this section.
>
> But I think what you're trying to say is this: the "status quo" section
> doesn't fully cover the status quo. There are more tricks than I
> mentioned, e.g. 'git config --global core.hooksPath
> /home/emily/githook/' to get the same set of hooks to run everywhere.
> This approach still has some drawbacks - for example, it doesn't allow
> me to use language-specific linters if I have repos in various
> languages, without exempting an individual repo from the ~/githook/ by
> 'git config --local core.hooksPath
> /home/emily/my-python-thing/.git/hook'.
>
> It looks like, then, the "status quo" section needs some rework for the
> next iteration.

Re-reading your original patch I think I just misread that. I thought
you were saying a stub script was needed in the .git to point to a
multi-hook script, but I was pointing out that you can just symlink to
the multi-hook script (as e.g. GitLab does), but reading it again & this
I don't thin you meant that at all. Nevermind.

>>=20
>>=20
>> > +[[hook-directories]]
>> > +=3D=3D=3D Hook directories
>> > +
>> > +Other contributors have suggested Git learn about the existence of a =
directory
>> > +such as `.git/hooks/<hookname>.d` and execute those hooks in alphabet=
ical order.
>>=20
>> ...which seems like an easy thing to add later by having a "hookdir" in
>> addition to "hookcmd", i.e. just specify a glob there instead of a
>> cmd/path.
>
> Hum, interesting! Something like so:
>
> [hook.pre-commit]
>   command =3D last-minute-checks
>
> [hookdir.last-minute-checks]
>   dir =3D /home/emily/last-minute-checks/*
>
> And then the hooks library knows to go and run everything in
> ~/last-minute-checks/. This is easier to keep fresh than:
>
> [hook.pre-commit]
>   command =3D /home/emily/last-minute-checks/c-linter
>   command =3D /home/emily/last-minute-checks/check-for-debug-prints
>   command =3D /home/emily/last-minute-checks/check-for-notes
>   ...
>
> I actually like the idea of this for folks who might have a small number
> of hooks they wrote for themselves. I wonder if it's applicable for
> something like git-secrets, which presumably users would grab with a
> 'git clone' later.
>
> It doesn't seem at odds with the rest of the design - how would you feel
> about me adding it to the "future work" section at the end? Future work,
> rather than "Emily will do this in the next couple of rounds", because:
>  - I think nobody already has their hooks in $HOOKDIR/hook/pre-commit.d
>    without a corresponding trampoline in $HOOKDIR/hook/pre-commit; so
>    they could still call that trampoline, for now
>  - I think it might be prone to some bikeshedding - e.g. should we
>    recurse into ~/last-minute-checks/linters/c/? how far? what if some
>    script requires magic options? etc? But as I'm typing those questions
>    out they sound mostly trivial or ridiculous, so maybe my assessment
>    is wrong here.
>  - It sounds like you might be keen to write it, or at the very least,
>    more keen than me
>  - Practically speaking, I am not sure I have time to do it alongside
>    the rest of the series. Again, my bikeshedding assessment could be
>    wrong, and this extra feature could be totally trivial.
>
>> You already use "hookdir" for something else though, so that's a bit
>> confusing, perhaps s/hookcmd/definehookcmd/ would be less confusing, or
>> perhaps more confusing...
>
> "Hookdir" might be the wrong word to use, too - maybe it's better to
> mirror "hookspath" there. Eitherway, "hookdir" and "hookspath" are
> similar enough that I think it would be confusing, and "hookcmd" is
> already getting some side-eye from me for not being a great choice.
>
> Some thoughts for "a path to a directory in which multiple scripts for a
> single hook live":
>  - hookset
>  - hookbatch (ugh, redundant with MS scripting)
>  - hook.pre-commit.all-of =3D ~/last-minute-checks/
>  -  "   "  .everything-in =3D "   "
> ...?
>
> I think I named a couple silly ideas for "hookcmd" in another mail.

To both of the above: Yeah I'm not saying you need to do the work, just
that I think it would be a useful case to bikeshed now since it seems
inevitable that we'll get a "find hooks in this dir by glob" once we
have this facility. So having a config syntax for that which isn't
overly confusing / extensible to that case would be useful, i.e. as the
current syntax uses "dir" already.

>>=20
>> > [...]
>> > +[[execution-ordering]]
>> > +=3D=3D=3D Execution ordering
>> > +
>> > +We may find that config order is insufficient for some users; for exa=
mple,
>> > +config order makes it difficult to add a new hook to the system or gl=
obal config
>> > +which runs at the end of the hook list. A new ordering schema should =
be:
>> > +
>> > +1) Specified by a `hook.order` config, so that users will not unexpec=
tedly see
>> > +their order change;
>> > +
>> > +2) Either dependency or numerically based.
>> > +
>> > +Dependency-based ordering is prone to classic linked-list problems, l=
ike a
>> > +cycles and handling of missing dependencies. But, it paves the way fo=
r enabling
>> > +parallelization if some tasks truly depend on others.
>> >
>> > +Numerical ordering makes it tricky for Git to generate suggested orde=
ring
>> > +numbers for each command, but is easy to determine a definitive order.
>> > +
>> > +[[parallelization]]
>> > +=3D=3D=3D Parallelization
>> > +
>> > +Users with many hooks might want to run them simultaneously, if the h=
ooks don't
>> > +modify state; if one hook depends on another's output, then users wil=
l want to
>> > +specify those dependencies. If we decide to solve this problem, we ma=
y want to
>> > +look to modern build systems for inspiration on how to manage depende=
ncies and
>> > +parallel tasks.
>>=20
>> If you're taking requests it would make me very happy if we had
>> parallelism in this from day one. It's the kind of thing that's hard to
>> do by default once a feature is shipped since people will implicitly
>> depend on it not being there, i.e. we won't know what we're breaking.
>
> Hm. This might be tricky.
>
> Some hooks are inherently not able to be parallelized - for example,
> hooks which modify a given file, like the commit message draft. In
> general, based on the handful of hooks I've converted locally, it's hard
> to check whether a callsite assumes a hook could have modified state.
> Usually this seems to be done with a call to find_hook() ("was there a
> hook that might have run?") and then reopening the file. Sometimes a
> file is reopened unconditionally. Sometimes the find_hook() call is
> very far away from the run_hook_le() call.
>
> The rest, then, which only read a file and say yes or no, probably don't
> need to have a strict ordering - at least as far as Git is concerned.
> And I think that's what you're worried about:
>
> [hook.theoretical-parallelizable-event]
>   command =3D check-and-mark-a-file-foo
>   command =3D check-file-foo-and-do-something-else
>   command =3D do-something-totally-unrelated
>
> On day 1 of this feature, as written, this is safe. But if we aren't
> careful and we start to parallelize *without* setting up dependency
> ordering, e.g. 'git config --global hook.parallelize', and turn that on
> by default without warning anyone, then the author of this config will
> be unhappy.
>
> But as I read further, you're talking about specifically *not* allowing
> dependency ordering...
>
>>=20
>> I think doing it this way is simple, covers most use cases, and solves a
>> lot of the problems you note:
>>=20
>> 1. Don't use config order to execute hooks, use glob'd name order
>>    regardless of origin. I.e. a system-level hook is called "001-first"
>>    is executed before a local hook called "999-at-the-end" (or the other
>>    way around, i.e. hook origin doesn't matter).
>
> Can you say a little more about why different ordering schema would
> matter, if we effectively don't care which jobs are in parallel with
> which, as you describe? I'm not quite following.
>
>>=20
>> 2. We execute hooks parallel in that glob order, i.e. a pthread for-loop
>>    that starts the 001-first task first, eventually getting to
>>    999-at-the-end N at a time. I.e. the same as:
>>=20
>>        parallel --jobs N --halt-on-error soon,fail=3D1" ::: <hooks-in-gl=
ob-order>
>>=20
>>    This allows for parallelism but guarantees the very useful case of
>>    having a global log hook being guaranteed to execute.
>
> Ah, I think you're suggesting the glob order specifically to make up for
> --halt-on-error in this case.
>
>>=20
>> 3. A hook can define "parallel=3Dno" in its config. We'll then run it
>>    while no other hook is running.
>>=20
>> 4. We don't attempt to do dependencies etc, if you need that sort of
>>    complexity you can just make one of the hooks be a hook runner as
>>    users do now for the common "make it parallel" case.
>
> If we aren't attempting any magical ordering, then I don't really see a
> big difference between glob vs. config order - presumably for most users
> the effect would be same, e.g. N =3D $(nproc * hyperthreading), M =3D (nu=
mber of scripts I
> care to run) probably will often result in M < N, so all jobs would run
> simultaneously anyways.
>
>>=20
>> It's a relatively small change to the code you have already. I.e. the
>> for_each() in run_hooks() would be called N times for each continuous
>> glob'd parallel/non-parallel segment, and hook_list()'s config parsing
>> would learn to spew those out as a list-of-lists.
>>=20
>> This also gives you a rudimentary implementation of the dependency
>> schema you proposed for free. I.e. a definition of (pseudocode):
>>=20
>>     hookcmd=3D000-first
>>     parallel=3Dno
>>=20
>>     hookcmd=3D250-middle-abc
>>     hookcmd=3D250-middle-xyz
>>=20
>>     hookcmd=3D300-gather
>>     parallel=3Dno
>>=20
>>     hookcmd=3D999-the-end
>>=20
>> Would result in the pseudocode execution of;
>>=20
>>     segments=3D[[000-first],
>>               [250-middle-abc, 250-middle-xyz],
>
> Hum. This seems to say "folks who started their hooks with the same
> number agree that their hooks should also run simultaneously" - which
> sounds like an even harder problem than "how do I know my ordering
> number isn't the same as someone else's in another config file". Or else
> I'm misunderstanding your pseudo :)

The prefix number isn't meaningful in that way, i.e. if you have 10
threads and 5 hooks starting with 250-* they won't all be invoked at the
same time.

> Ah, I see later you mention it directly as a dependency schema. I think
> this offers the same set of problems I saw trying to use this as an
> ordering schema, but worse in all the usual ways parallelism provides.
> It is still impossible for someone writing a global or system config to
> know where in the dependency chain more local hooks reside.
>
>>               [300-gather],
>>               [999-the-end]]
>>     for each s in segments:
>>         ok =3D run_in_parallel(s)
>>         last if !ok # or, depending on "early exit?" config
>>=20
>> I.e.:
>>=20
>>  * The common case of people adding N hooks won't take sum(N) time.
>>=20
>>  * parallel=3Dno hooks aren't run in parallel with other non-parallel
>>    hooks
>>=20
>>  * We support a rudimentary dependency schema as a side-effect,
>>    i.e. defining 300-gather as non-parallel allows it to act as the sole
>>    "reduce" step in a map/reduce in a "map" step started with the 250-*
>>    hooks.
>
> As I understand it, the main concerns you have about getting
> parallelization to happen on day 1 are like so:
>
>  - keep users from assuming serial execution
>  - avoid a messy schema change to deal with dependencies
>
> I see the benefit of the former; I don't like the new schema proposed by
> the latter. I do see that not turning it on day 1 would prevent us from
> turning it on by default later, in case users did something silly like
> assume dependencies.
>
> Hrm.
>
> I think we could turn on parallelization day 1 by providing an
> explicitly-parallel API in hook.h (and a similar 'git hook run foo
> --parallel' flag), and being more careful when converting hooks to call
> run_hooks_parallel() instead of run_hooks(). That way hooks which will
> never be parallelizable (e.g. commit-msg) won't get burned later by us
> trying to be clever. Everyone else who can be parallelized is, in config
> order, with no dependency management whatsoever. That leaves the door
> open for us to add dependency management however we want later on, but
> users can still roll their own with a launcher script today.
>
> I know I rambled a lot - I was trying to convince myself :) For now, I'd
> prefer to add more detail to the "future work" section of the doc and
> then not touch this problem with a very long pole... ;) Thoughts
> welcome.

I'm replying to much of the above in general here, particularly since
much of it was in the form of a question you answered yourself later :)

Yes as you point out the reason I'm raising the parallel thing now is
"keep users from assuming serial execution", i.e. any implementation
that isn't like that from day 1 will need more verbose syntax to opt-in
to that.

I think parallel is the sane default, although there's a really strong
case as you point out with the "commit-msg" hook for treating that on a
hook-type basis. E.g. commit-msg (in-place editing of as single file)
being non-parallel by default, but e.g. post-commit, pre-applypatch,
pre-receive and other "should we proceed?" hooks being parallel.

But I'm also raising a general concern with the design of the API /
command around this.

I don't see the need for having a git hook list/edit/add command at
all. We should just keep this simpler and be able to point to "git
config --add/--get-regexp" etc.

It seems the reason to introduce this command API around it is because
you're imagining that git needs to manage hooks whose relative execution
order is important, and to later on once this lands aim to implement a
much more complex dependency management schema.

I just can't imagine a case that needs that where say those 10 hooks
need to execute in exact order 1/2/3/4 where the author of that tight
coupling wouldn't also desire to roll that all into one script, or at
least that it's an obscure enough case that we can just say "do that".

Whereas I do think "run a bunch of independent checks, if all pass
proceed" is *the* common case, e.g. adding a bunch of pre-receive
hooks. If we tell the user we'll treat those as independent programs we
can run them in parallel. The vast majority of users will benefit from
the default faster execution.

The "glob order" case I mentioned is extra complexity on top of that,
yes, but I think that concession is sane for the common case of "yes
parallel, but I want to always run the always-exit-0 log
hook". E.g. I've used this to setup a hook to run push
attempts/successes in a hook framework that runs N pre-receive hooks.

All that being said I'm open to being convinced, I just don't see what
the target user is, and the submitted docs don't really make a case for
it. I.e. there's plenty of "what" not "why would someone want this...".

>>=20
>> > +[[securing-hookdir-hooks]]
>> > +=3D=3D=3D Securing hookdir hooks
>> > +
>> > +With the design as written in this doc, it's still possible for a mal=
icious user
>> > +to modify `.git/config` to include `hook.pre-receive.command =3D rm -=
rf /`, then
>> > +zip their repo and send it to another user. It may be necessary to te=
ach Git to
>> > +only allow inlined hooks like this if they were configured outside of=
 the local
>> > +scope (in other words, only run hookcmds, and only allow hookcmds to =
be
>> > +configured in global or system scope); or another approach, like a li=
st of safe
>> > +projects, might be useful. It may also be sufficient (or at least use=
ful) to
>> > +teach a `hook.disableAll` config or similar flag to the Git executabl=
e.
>>=20
>> I think this part of the doc should note a bit of the context in
>> https://lore.kernel.org/git/20171002234517.GV19555@aiede.mtv.corp.google=
.com/
>>=20
>> I.e. even if we get a 100% secure hook implementation we've done
>> practically nothing for overall security, since we'll still run the
>> pager, aliases etc. from that local repo.
>>=20
>> This is a great step in the right direction, but it behooves us to note
>> that, so some user reading this documentation without context doesn't
>> think inspecting untrusted repositories like that is safe just because
>> they set the right hook settings in their config (once what's being
>> proposed here is implemented).
>
> Yeah, I agree. I'll try to make that clearer in the doc in the next
> reroll.
>
> Very sorry again for having missed this - I think the first weeks of
> October I was working from my local todo list instead of from the list
> of replies in mutt. Urk.

*nod*
