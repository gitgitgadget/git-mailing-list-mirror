Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38426C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 01:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06511610A8
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 01:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236925AbhHEBLO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 21:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbhHEBLN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 21:11:13 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1384EC061765
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 18:10:59 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id zb12so1811036ejb.5
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 18:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=qDNoYMQRfK/KVePu+GtUpTK0JrNyWT0RCQMULXuQ2rM=;
        b=d9Fzuswk3N03KAOWTGSY7pGkoThQfPSPLki3vMT1qtVSwKyrH4tG1IPut8Y4DDDf1/
         4wojnswcsWxxuPJ5WW2IoeRGX5o0uFJFQe1Kn/j0+iWJwxSmm/WaoO6llVUIyGlieHBJ
         ALt839NB4n3CnM2HOb91WMZD2CPHqnBN6Tl3DoTtDmdTjJP1nbnGwHqFdl+f1+BbRhrs
         ZoJAuwbfuyqGQQZ0RJEe8oPassgMzOSBiCeTUeCOSZbIBBF0UTwFbr7GVi13U0EPHQ3W
         xo/RviKNhMH7xQJy4pq0fujt76heiXZoIc5sVfkUfTcHMvw6nTfwfdJ/+kHq2sgNdFY6
         H3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=qDNoYMQRfK/KVePu+GtUpTK0JrNyWT0RCQMULXuQ2rM=;
        b=daNUIsLaQPBmG5KPo4dQ+0lagTQGrFE/+Th/57QPwk3R0fz0xSU90e9EloCKvb9Q92
         mqCTHLs8uY74A719AUdRJChaZfnem70Y/9y8hJZPcLAxHqQJXZGzLwHsK1pmuI4PZZih
         h83RRGmPhU6nwnfEPmZ9ESaMr82Jzmn+JCB2Q2c8dgYd08YRKyUMfyA7JXB4EL90q3a7
         OTsIzNKVxw9rlBU2mlYUxevT63pXIjKH/l2MrS/TETkRHey2JnyB3mXezGvCqZYByjtF
         Hyl0nkdAK0sceoeijuJnva3HpFS62DTHfmggEbAf8yEXDicv0BJOugDIknv2ADfe/I8o
         IpXw==
X-Gm-Message-State: AOAM532eOz0a+qqlCqF1N2xLUye5U+3P8kvbRBNaqwikYPkdr9qyr7gy
        5XWIYXoQhpeAE+VSBQbdPrk=
X-Google-Smtp-Source: ABdhPJxxYu4NclymRIzTyVHGLA5lsl+dCTt0nZAKE88OgsC/uMkjUPeqwtVLAP8+7AveRFjCMN3rDg==
X-Received: by 2002:a17:906:5ac5:: with SMTP id x5mr1918353ejs.271.1628125857185;
        Wed, 04 Aug 2021 18:10:57 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id w5sm1166108ejz.25.2021.08.04.18.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 18:10:56 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 8/9] hook: teach 'hookcmd' config to alias hook scripts
Date:   Thu, 05 Aug 2021 02:17:29 +0200
References: <20210715232603.3415111-1-emilyshaffer@google.com>
 <20210715232603.3415111-9-emilyshaffer@google.com>
 <87fswey5wd.fsf@evledraar.gmail.com> <YPn/5GLrAb17KqyB@google.com>
 <87bl6ttmlv.fsf@evledraar.gmail.com> <YQr6xojzxk3xJrTw@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YQr6xojzxk3xJrTw@google.com>
Message-ID: <877dh0n1b3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 04 2021, Emily Shaffer wrote:

> On Fri, Jul 23, 2021 at 09:41:35AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>=20
>>=20
>> On Thu, Jul 22 2021, Emily Shaffer wrote:
>>=20
>> > On Fri, Jul 16, 2021 at 11:13:42AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>> >>=20
>> >>=20
>> >> On Thu, Jul 15 2021, Emily Shaffer wrote:
>> >>=20
>> >> > To enable fine-grained options which apply to a single hook executa=
ble,
>> >> > and to make it easier for a single executable to be run on multiple=
 hook
>> >> > events, teach "hookcmd.<alias>.config". These can be configured as
>> >> > follows:
>> >> > [...]
>> >> > diff --git a/Documentation/config/hook.txt b/Documentation/config/h=
ook.txt
>> >> > index a97b980cca..5b35170664 100644
>> >> > --- a/Documentation/config/hook.txt
>> >> > +++ b/Documentation/config/hook.txt
>> >> > @@ -3,6 +3,11 @@ hook.<command>.command::
>> >> >  	executable on your device, a oneliner for your shell, or the name=
 of a
>> >> >  	hookcmd. See linkgit:git-hook[1].
>> >> >=20=20
>> >> > +hookcmd.<name>.command::
>> >> > +	A command to execute during a hook for which <name> has been spec=
ified
>> >> > +	as a command. This can be an executable on your device or a oneli=
ner for
>> >> > +	your shell. See linkgit:git-hook[1].
>> >> > +
>> >> > [...]
>> >> > +Global config
>> >> > +----
>> >> > +  [hook "post-commit"]
>> >> > +    command =3D "linter"
>> >> > +    command =3D "~/typocheck.sh"
>> >> > +
>> >> > +  [hookcmd "linter"]
>> >> > +    command =3D "/bin/linter --c"
>> >> > +----
>> >> > +
>> >> > +Local config
>> >> > +----
>> >> > +  [hook "prepare-commit-msg"]
>> >> > +    command =3D "linter"
>> >> > +  [hook "post-commit"]
>> >> > +    command =3D "python ~/run-test-suite.py"
>> >> > +----
>> >> > +
>> >> > +With these configs, you'd then run post-commit hooks in this order:
>> >> > +
>> >> > +  /bin/linter --c
>> >> > +  ~/typocheck.sh
>> >> > +  python ~/run-test-suite.py
>> >> > +  .git/hooks/post-commit (if present)
>> >> > +
>> >> > +and prepare-commit-msg hooks in this order:
>> >> > +
>> >> > +  /bin/linter --c
>> >> > +  .git/hooks/prepare-commit-msg (if present)
>> >> >=20=20
>> >>=20
>> >> I still have outstanding feedback on the fundamental design
>> >> here. I.e. why is this not:
>> >>=20
>> >>     hook.<name>.event =3D post-commit
>> >>     hook.<name>.command =3D <path>
>> >>=20
>> >> See:
>> >>=20
>> >> https://lore.kernel.org/git/87mtv8fww3.fsf@evledraar.gmail.com/
>> >>=20
>> >> As noted there I don't see why not, and more complexity results from =
the
>> >> design choice of doing it the way you're proposing. I.e. we can't
>> >> discover hooks based on config prefixes, and we end up sticking full =
FS
>> >> paths in config keys.
>> >
>> > Interesting. My gut says that it would make it harder to neatly write a
>> > config with the same hook running at the very beginning of one event a=
nd
>> > the very end of another, but I'm not sure whether that's a case to
>> > optimize for.
>> >
>> > I would also need twice as many lines to run a script I wrote as a hook
>> > - that is, the base case which is probably all most people will need. =
So
>> > with your proposal I *must* name every hook I want to add. Instead of
>> > "hook.pre-commit.command =3D ~/check-for-debug-strings" I need to
>> > configure "hook.check-debug-strings.event =3D pre-commit" and
>> > "hook.check-debug-strings.command =3D ~/check-for-debug-strings". That=
's a
>> > little frustrating, and if I never want to skip that check or move it
>> > later or something, it will be extra overhead for no gain for me.
>>=20
>> The gain is that "git hook list" becomes a trivial "git config
>> -show-origin --show-scope --get-regexp" wrapper.
>
> This isn't a very compelling reason to me, if it makes the user
> experience worse. (I'm not convinced that it does - just saying I
> disagree with this reasoning.)

...(see below)...

>>=20
>> So the series either doesn't need "git hook list" or such a thing
>> becomes much less complex, especially given the proposed addition of
>> other features in the area like "git hook edit", i.e. (quoting the
>> linked E-Mail):
>
> I still think "git hook list" is useful to have for end-users, compared
> to remembering the appropriate "git config" invocation. It futureproofs
> us if we do want to change the execution ordering to something besides
> config order, it's easier to remember/more discoverable, etc.

To clarify: I'm not against there being a "git hook list", I think we
should have it.

It's useful UI. I.e. we have "run", it makes sense to have the same
mechanism spew out its idea of what hooks are where, especially since
that's not entirely contained in the config, but a union of config and
GIT_DIR/hooks (and then there's core.hooksPath...).

So I'm very much for it being there.

I've just been commenting on the relative complexity of the config
schema, which in one way surfaces as not being able to do the config
part of the "git hook list" as a simple shell-out (or equivalent library
invocation) of "git config" under the hood, but also means that users
need to mentally track a more complex format when e.g. manually editing
config...

>> [...]
>> But isn't the real difference not in the differing prefixes, i.e. hook.*
>> and hookcmd.* (A) v.s. always hook.* (B, which is what I'm mainly
>> focusing on, i.e. what requires the added complexity.
>>=20
>> But that in that in your proposed way of doing it it's:
>>=20
>>     hook.<event-or-name>.*
>>=20
>> V.s. my suggestion of:
>>=20
>>     hook.<name>.*
>>=20
>
> No, I think that's a misunderstanding of proposal A. My proposal A is
> always hook.<event>.*, and hookcmd.<name>.*, and the way that I read
> your proposal B is that it's always hook.<name>.*.

Ah, thanks.

>> And thus whenever you have a <event-or-name> that just happens to be a
>> built-in hook listed in githooks(5) we in (A) implicitly expand config
>> like:
>>=20
>>     hook.post-commit.command =3D echo foo
>>=20
>>=20
>>     hook.post-commit.command =3D echo hi
>>     hook.post-commit.type    =3D post-commit
>
> This is where I'm becoming confused. I *think* you're saying that with
> your proposal B, if the subsection happens to be the name of a built-in
> hook, we can skip the .event field. But it also reads like you're saying
> this is how my proposal A works, which isn't the case, because the
> subsection is always assumed to be the name of the hook event we're
> trying to run.

I *think* this is best addressed below, moving on...

>>=20
>> But not knowing about "foo" we don't expand:
>>=20
>>     hook.foo.command =3D echo foo
>>=20
>>=20
>>     hook.foo.command =3D echo hi
>>     hook.foo.type    =3D foo # This would be an error, or ignored.
>>=20
>> But rather leave "dangling" for the user to later supply the "*.event"
>> themselves, i.e.:
>>=20
>>     hook.foo.command =3D echo hi
>>     hook.foo.event =3D post-commit
>
> If you're talking about proposal B, then no, this isn't how it works.
> This config would imply that someone else (like a wrapper) can run "echo
> hi" by asking for "git hook run foo". But I'm not sure exactly that
> that's what you mean...

...and on (maybe)....

>>=20
>> And means that you presumably need to detect this case and error about
>> it, but my proposed model does not:
>>=20
>>     hook.post-commit.command =3D echo hi
>>     # User error: "*.type" and <event-or-name>" does not match for
>>     # "hook.*.command"
>>     hook.post-commit.type    =3D pre-commit
>>=20
>> And furthermore, that if someone in your model were to do:
>>=20
>>     hook.verify-commit.command =3D echo hi
>>=20
>> It's "dangling" today, but if a later version of git learns about a
>> "verify-commit" hook we'll start running it unexpectedly.
>
> No, that's in fact as designed, with my model B. The user configured
> "echo hi" to run on "verify-commit" events; if those events are
> initially used by some wrapper, but later we decide they're a great idea
> and absorb the verify-commit event into native Git, then this is working
> as intended. I think your argument is based on a misunderstanding of the
> design.
>
> Could it be that the way I provided the examples (my schema after A: and
> your schema after B:) made it hard to parse? Sorry about that if so.

Aren't you assuming that users who specify a verify-commit will be happy
because git's usurping of that will 1=3D1 match what they were using
"verify-commit" for.

I'm pointing out that we can't know that, and since you want to make
"git hook run" a general thing that runs any <name> of script you've
configured, and not just what's in githooks(5) that it becomes very
likely that if we add a new hook with some obvious name that we'll
either break things for users, or subtly change behavior.

Which isn't just theoretical, e.g. I tend to run something like a "git
log --check @{u}.." before I run git-send-email, with this configurable
hook mechanism having a "git hook run sendemail-check" would be a way I
might expose that in my own ~/.gitconfig.

But if git-send-email learns a "sendemail-check" and the behavior
doesn't exactly match mine; E.g. maybe it similar to pre-auto-gc expects
me to return a status code to ask me if I want to abort on a failed
--check, but mine expects a revision range to run "log --check".

In practice that's a non-issue with the current hook mechanism,
i.e. nobody's sticking a script into .git/hooks/my-custom-name and
expecting it to do anything useful (and if they are, they have only
themselves to blame).

Whereas we'd now be actively inviting users to squat on the same
namespace we ourselves will need for future hooks.

>>=20
>> Because your design conflates the slot for known hook type names and
>> user-supplied names.
>>=20
>> On balance I think it's better just to always supply two lines per-hook,
>> but whether we have this proposed shorthand or not is mostly orthogonal
>> to everything I mentioned in
>> https://lore.kernel.org/git/87mtv8fww3.fsf@evledraar.gmail.com/
>>=20
>> I.e. my proposed version could also have it, but thinking about it I
>> think it's not worth it, we should always use <name>, not
>> <event-or-name> for the reasons noted if you'll read ahead...
>>=20
>> > #4 - Skip a script configured more globally
>> > A:
>> > (original config)
>> > [hook "post-commit"]
>> > 	command =3D /corp/stuff/corp-post-commit
>> > (local config)
>> > [hookcmd "/corp/stuff/corp-post-commit"]
>> > 	skip =3D true
>> > OR,
>> > (original config)
>> > [hookcmd "corp-pc"]
>> > 	command =3D /corp/stuff/corp-post-commit
>> > [hook "post-commit"]
>> > 	command =3D corp-pc
>> > (local config)
>> > [hookcmd "corp-pc"]
>> > 	skip =3D true
>> > B:
>> > (original config)
>> > [hook "corp-pc"]
>> > 	event =3D post-commit
>> > 	command =3D /corp/stuff/corp-post-commit
>> > (local config)
>> > [hook "corp-pc"]
>> > 	skip =3D true
>>=20
>> ...which are among other things that no, my proposed version doesn't
>> have "skip" at all, see point #3 at
>> https://lore.kernel.org/git/87mtv8fww3.fsf@evledraar.gmail.com/
>>=20
>> I.e. I think the "skip" is a thing that falls out of a complexity of
>> your design that I'm proposing to do away with.
>>=20
>> That complexity being that you use <event-or-name> and I use <name>, and
>> you want to in turn support N number of "*.command" for any
>> "hook.<event-or-name>".
>>=20
>> I'm suggesting we use the typical "last key wins" semantics, if you want
>> multiple commands for a given hook type you'll just supply multiple
>> "hook.<name>" sections with the same "hook.*.event =3D type" in all.
>>=20
>> The way to skip hooks in my proposal is:
>>=20
>>     hook.<name>.command =3D true
>
> I see - instead of fiddly reorganizing the list, you're just changing
> what the specific hook name is redirecting to.
>
> Then, instead of storing the resolved command in the 'struct hook', we
> can store the name, and always dereference the name right before
> execution, using last-one-wins semantics.
>
> The only thing I don't like about this is that it's a little bit
> confusing to the user. I personally would rather have more complicated
> code and less complicated user experience, so I like 'skip' more because
> it's readable and because you don't need to guess "oh, it'll just
> execute /bin/true which is a noop". That's easy to understand for
> someone familiar with Unix scripting (and therefore for we Git
> contributors), but confusing for everybody else.
>
> Maybe we can take the essential spirit of this implementation but make
> it a little bit simpler. In pseudocode:
>
> populate_list(hookname):
>   # look for everybody who says "hook.*.event =3D $hookname"
>   hooks =3D get_configs_matching(hook.*.event, hookname)
>   # the "*" bit is the bit we dereference later
>   for hook in hooks:
>     hook_list.add({.name =3D hook.key.subsection})
>
> run_hooks(hook_list):
>   for hook in hook_list:
>     # should we even run?
>     if (get_last_config("hook." + hook.name + ".skip"))
>       continue
>
>     # dereference the hook name and find out the command
>     cmd =3D get_last_config("hook." + hook.name + ".command")
>     run(cmd)
>
> The price for this improved readability is an extra config lookup in
> each case. But the code is still readable, definitely moreso than
> rewalking the config list over and over as the implementation stands
> now. I personally think it's worth it.

I think the less complicated user experience is for our config system to
work as consistently as possible with other config. If we define special
rules and what's effectively special syntax with "skip" etc. we're
asking users to read how that works, and keep that all in their head
just to deal with that one area of our config.

> (One could also imagine a more readable placeholder than /bin/true in
> the "hook.<name>.command" field, but then we get to decide just how hard
> we want to avoid colliding with legitimate user hook names. Is .command
> =3D skip enough? is .command =3D RESERVED_NAME_SKIP_THIS_HOOK enough? Is
> something unrunnable like .command =3D "skip me" enough, although it could
> conceivably collide with a determined user?)

All of that's something you'll need to explain in detail to users, which
all seems way more complex than a simple:

    To skip a previously defined hook insert a noop-command, any will
    do, but setting it to "true" (usually /bin/true) is a handy
    convention for doing nothing.

I.e. by keeping the config field as doing one thing only you avoid any
such collisions etc.

>>=20
>> Or whatever noop command you want on the RHS. In practice we wouldn't
>> invoke "true", just like we don't invoke "cat" for "PAGER=3Dcat".
>>=20
>> But unlike "*.skip" that doesn't require complexity in implementation or
>> user understanding, it just falls naturally out of the rest of the
>> model.
>>=20
>> > #5 - Execute one script for multiple events
>> > A:
>> > [hookcmd "reusable-hook"]
>> > 	command =3D /long/path/reusable-hook
>> > [hook "post-commit"]
>> > 	command =3D reusable-hook
>> > [hook "pre-commit"]
>> > 	command =3D reusable-hook
>> > [hook "prepare-commit-msg"]
>> > 	command =3D reusable-hook
>> > B:
>> > [hook "reusable-hook"]
>> > 	command =3D /long/path/reusable-hook
>> > 	event =3D post-commit
>> > 	event =3D pre-commit
>> > 	event =3D prepare-commit-msg
>>=20
>> It's been so long since I wrote the original E-Mail that I'm having to
>> skim my own summary there & come up with things as I go along, so maybe
>> this conflicts with something I said earlier.
>>=20
>> But no, I don't think I meant that *.event should be multi-value, or
>> that that magic is worthwhile. I.e. I think we just want:
>>=20
>>     [hook "not-a-reusable-section-1"]
>>         command =3D /long/path/reusable-hook
>>         event =3D post-commit
>>     [hook "not-a-reusable-section-2"]
>>         command =3D /long/path/reusable-hook
>>         event =3D pre-commit
>>     [hook "not-a-reusable-section-3"]
>>         command =3D /long/path/reusable-hook
>>         event =3D prepare-commit-msg
>>=20
>> I.e. is wanting to use the same command for N different hooks really
>> that common a use-case to avoid a little verbosity, and quite a lot of
>> complexity?
>>=20
>> How would such a hook even be implemented?
>>=20
>> We don't have anything in your hook execution model (and I don't
>> remember you adding this) which passes down a "you are this type of
>> hook" to hooks.
>
> No, but it's something I'm interested in passing as an environment
> variable. I didn't add it to this series because it seemed to me to
> distract from the core feature. We would like to add it to simplify our
> invocations of https://github.com/awslabs/git-secrets, so it's on my
> radar.

Having such an env var as part of the initial series seems like a
sensible thing to have.

> And even without this, just today I wanted to configure a hook to really
> make sure I had config.mak set up in all my Git worktrees (since you
> pointed out I pushed code that fails -Wall.... ;) ) and set it up to run
> on both pre-commit and post-checkout. So yes, it is feasible now, for
> very stupid hooks.

Aside: It's nice to use DEVELOPER=3D1 in config.mak (or as make param)
when hacking on git, it'll set -Wall -Werror and other nice warning
flags.

> [...]
>> > [...]Please feel free to chime in with more use cases that you think w=
ould
>> > be handy which I forgot :)
>>=20
>> I couldn't find this at a quick glance but I think we also had a
>> disussion at some point about hooks controlling parallelism. AFAICT your
>> current implementation just has global:
>>=20
>>     hook.jobs=3DN
>>=20
>> And we then blacklist certain hooks to always have hook.jobs=3D1, e.g. t=
he
>> commit-msg hook that needs an implicit "lock" on that file (or rather,
>> we think that's the most common use-case).
>>=20
>> I think my version of always having hook.<name>.{event,command} be one
>> value is also better in that case, i.e. we'd then:
>>=20
>>     [hook "myhook"]
>>     command =3D some-command
>>     event =3D pre-receive
>>     parallel =3D true # the default
>>=20
>>     [hook "myhook2"]
>>     command =3D some-command2
>>     event =3D pre-receive
>>     parallel =3D true # the default
>>=20
>>     [hook "myhook3"]
>>     command =3D some-unconcurrent-command
>>     event =3D pre-receive
>>     parallel =3D false # I'm not OK with concurrency
>
> I am not sure what it means for a single executable to write "parallel =3D
> true" - it is a single executable.
>
> Ok, that is me being facetious - I think you are saying we can AND
> together all of the 'hook.<thing-with-event-we-care-about>.parallel' to
> decide whether or not to run in parallel.

Right, the case (whatever the config mechanism) wanting to use several
off-the-shelf hooks and accomplish through git some version of this:

    parallel -j8 pre-receive-parallel-*.sh &&
    parallel -j1 pre-receive-non-parallel-*.sh

I.e. since we have N scripts for the "pre-receive" type, and we're
expecting to say whether on not parallelism is OK or not, it seems like
a natural thing we'll want to declare that differently for some of those
than for others.

> I would rather not discuss this now, for this series, because regardless
> of which config schema we use today, we can figure out "parallel unless
> we really don't want it" later on. It is too complex to discuss in the
> context of "hey, we should also configure hooks somewhere else". Let's
> leave it for future work.

The point is that no, we really can't figure it out as easily later on
regardless of the config schema.

Because with 1=3Dmany you can't have 1=3Dmany.someAttribute=3DXYZ without t=
hat
*.someAttribute=3DXYZ declaring something for all of 1=3Dmany, whereas if
it's 1=3D1 then 1=3D1.someAttribute.XYZ obviously applies only to that 1=3D=
1.

>> I haven't thought about it deeply, but have a hunch that having sections
>> be a 1=3D1 mapping with a specific command instead of either 1=3D1 or 1=
=3Dmany
>> is going to make that easier to implement and understand.
>
> Sure, probably. But it can be added later to either schema... ;)
>
>
> Anyway, I did a quick strawpoll with my colleagues (Jonathan Nieder,
> Jonathan Tan, and Josh Steadmon) and they all like your syntax more. I
> am ambivalent between the two, personally.
>
> So what I will do, hopefully today, maybe not, is the following:
>
>  - no more hookcmd. (and there was much rejoicing)
>  - Hooks are specified with "[hook "name-of-hook"]"

Thanks, I look forward to checking that out. As should be obvious from
my misunderstanding of some of your config proposal (I snippet out some
of those from the reply) I'm still not entirely clear on even what the
current proposed behavior is, hopefully something simpler will be easier
to grok ... :)

>  - I do see value in having an explicit .skip field rather than mapping
>    .command to a noop, so "hook.name-of-hook.skip" as described above.
>    Of course the method you described will work regardless, since its
>    mechanism is based on the inherent result of executing /bin/true.

I think we've mainly focused on the theoretical aspect of this, but FWIW
I'm still entirely unclear on what this feature is even aimed for.

All of the rest of our config does not have an explicit "skip" for
anything, just last-set-wins. In terms of a real-world use-case wouldn't
a user just edit or comment out the config earlier in ~/.gitconfig, and
not "skip" it at the end with "git config [...] --add"?

I suspect that the use-case is some Googly centrally managed
/etc/gitconfig, but that's just speculation...

>  - I do see value in allowing "hook.name-of-hook.event" to be defined
>    repeatably, as described above, so I will include that.
> [...]
>  - figuring out what the heck we want to do with allowing hooks to
>    describe whether they allow parallelism

Which just to check if we're on the same page, needs to be figured out
because of the complexity of that "defined repeatably", no?

> Unfortunately I've dropped the design doc from this series, since nobody
> seemed interested in having it checked in, but I'll try to rework the
> help doc to make the schema more clear.

FWIW I wasn't opposed to it per-se, but remembered commenting on it in
earlier rounds, and it being some combination of docs that should really
be in manpages (i.e. describing current actual behavior), more general
rational and "why is it like this" (which correctly belongs in design
docs), and musings about hypothetical future features (e.g. "git hook
edit" and the like)'.
