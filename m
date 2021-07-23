Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8DAC4320E
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 09:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63A4360EC0
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 09:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbhGWIhN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 04:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbhGWIhM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 04:37:12 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495C3C061757
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 02:17:45 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id hp25so2556299ejc.11
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 02:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=W6BSqzTollZS41gtIbO2SR4n56Hi6az3fwBbKwArrRE=;
        b=k0GrBH3xzfViRjsqqAooRc5wM/JU2v9irsR21SkIMdqojWaJQGIGXPz4FhgSraI3L1
         eyBof01FG44VbNL6XQQ7QNhl0zTmhasJVPt3WoIpUfHQAFfIZjRmQmzZVN+Kgd2Fegjy
         q+sbvWz6TCz8NALSnulF4DReViHomMsmJQlVQJLb0cA1i72h/ei+RJvDsmCjY88f3MUK
         qVq0HX4ogpUYDTfRiVP2Lzf3fF1rONQC5PO65vYhI0qcqZlO3elS3DAB7KRipv2T/rO1
         zyNOEApKcLWuN2/1nD0Uo7EtIIY912zNkpTibQv5Y+R+wPpRW7hrqn9e/bkZXGSayV/3
         NLSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=W6BSqzTollZS41gtIbO2SR4n56Hi6az3fwBbKwArrRE=;
        b=A3/wV7LU1Hpz2XpmCvfyYdKNB9rUMJlDLi9o4MVKZLTybo2t3h70Hq9D0SmA0wbEwC
         5BpQSu1717mHghIBnz7qez3Y5ZPkQq+OfBMjPWt/PY8oGs8/sIlloNXLgNYUeRWlZxBy
         jN72DQijjHW5WeVE/y8b6LdXgAJoCRC27MkpOjG/vzJHvYXfzou73jf2fp7Ayd7QKrQ5
         a+WCjysP64gb72ZtoeDCDKoHVf5dZSXLi6A7Sjt3CFOR7+BUPWF+EyeCTB0n1mdOPj0A
         K2FcUdbAEJDXvRNjcaNkaGCmvrrOtDECPYZ9iX04FyQOSo9ePXxlcEa7hdlGlQ4yRbYY
         8uqg==
X-Gm-Message-State: AOAM532HzS/ziXqUL2iPYTESfHJ+i7A5vog9/cKs6LWph434vutDLoOE
        dAIkoXElaDjupXunCgnZkL4=
X-Google-Smtp-Source: ABdhPJw4z0ci7WDXkv2IFApyHPmpQEKaAxJQqvC7M20XphMkq3dvX3Od3EeIBw3DBbVVZPBl8BjFtw==
X-Received: by 2002:a17:906:78f:: with SMTP id l15mr3830010ejc.93.1627031863556;
        Fri, 23 Jul 2021 02:17:43 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id d2sm10305947ejy.108.2021.07.23.02.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 02:17:43 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 8/9] hook: teach 'hookcmd' config to alias hook scripts
Date:   Fri, 23 Jul 2021 09:41:35 +0200
References: <20210715232603.3415111-1-emilyshaffer@google.com>
 <20210715232603.3415111-9-emilyshaffer@google.com>
 <87fswey5wd.fsf@evledraar.gmail.com> <YPn/5GLrAb17KqyB@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YPn/5GLrAb17KqyB@google.com>
Message-ID: <87bl6ttmlv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 22 2021, Emily Shaffer wrote:

> On Fri, Jul 16, 2021 at 11:13:42AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>=20
>>=20
>> On Thu, Jul 15 2021, Emily Shaffer wrote:
>>=20
>> > To enable fine-grained options which apply to a single hook executable,
>> > and to make it easier for a single executable to be run on multiple ho=
ok
>> > events, teach "hookcmd.<alias>.config". These can be configured as
>> > follows:
>> > [...]
>> > diff --git a/Documentation/config/hook.txt b/Documentation/config/hook=
.txt
>> > index a97b980cca..5b35170664 100644
>> > --- a/Documentation/config/hook.txt
>> > +++ b/Documentation/config/hook.txt
>> > @@ -3,6 +3,11 @@ hook.<command>.command::
>> >  	executable on your device, a oneliner for your shell, or the name of=
 a
>> >  	hookcmd. See linkgit:git-hook[1].
>> >=20=20
>> > +hookcmd.<name>.command::
>> > +	A command to execute during a hook for which <name> has been specifi=
ed
>> > +	as a command. This can be an executable on your device or a oneliner=
 for
>> > +	your shell. See linkgit:git-hook[1].
>> > +
>> > [...]
>> > +Global config
>> > +----
>> > +  [hook "post-commit"]
>> > +    command =3D "linter"
>> > +    command =3D "~/typocheck.sh"
>> > +
>> > +  [hookcmd "linter"]
>> > +    command =3D "/bin/linter --c"
>> > +----
>> > +
>> > +Local config
>> > +----
>> > +  [hook "prepare-commit-msg"]
>> > +    command =3D "linter"
>> > +  [hook "post-commit"]
>> > +    command =3D "python ~/run-test-suite.py"
>> > +----
>> > +
>> > +With these configs, you'd then run post-commit hooks in this order:
>> > +
>> > +  /bin/linter --c
>> > +  ~/typocheck.sh
>> > +  python ~/run-test-suite.py
>> > +  .git/hooks/post-commit (if present)
>> > +
>> > +and prepare-commit-msg hooks in this order:
>> > +
>> > +  /bin/linter --c
>> > +  .git/hooks/prepare-commit-msg (if present)
>> >=20=20
>>=20
>> I still have outstanding feedback on the fundamental design
>> here. I.e. why is this not:
>>=20
>>     hook.<name>.event =3D post-commit
>>     hook.<name>.command =3D <path>
>>=20
>> See:
>>=20
>> https://lore.kernel.org/git/87mtv8fww3.fsf@evledraar.gmail.com/
>>=20
>> As noted there I don't see why not, and more complexity results from the
>> design choice of doing it the way you're proposing. I.e. we can't
>> discover hooks based on config prefixes, and we end up sticking full FS
>> paths in config keys.
>
> Interesting. My gut says that it would make it harder to neatly write a
> config with the same hook running at the very beginning of one event and
> the very end of another, but I'm not sure whether that's a case to
> optimize for.
>
> I would also need twice as many lines to run a script I wrote as a hook
> - that is, the base case which is probably all most people will need. So
> with your proposal I *must* name every hook I want to add. Instead of
> "hook.pre-commit.command =3D ~/check-for-debug-strings" I need to
> configure "hook.check-debug-strings.event =3D pre-commit" and
> "hook.check-debug-strings.command =3D ~/check-for-debug-strings". That's a
> little frustrating, and if I never want to skip that check or move it
> later or something, it will be extra overhead for no gain for me.

The gain is that "git hook list" becomes a trivial "git config
-show-origin --show-scope --get-regexp" wrapper.

So the series either doesn't need "git hook list" or such a thing
becomes much less complex, especially given the proposed addition of
other features in the area like "git hook edit", i.e. (quoting the
linked E-Mail):

    As just one example; surely "git config edit <name>" would need to
    run around and find config files to edit, then open them in a loop
    for you, no?

    Which we'd eventually want for "git config" in general with an
    --edit-regexp option or whatever, which brings us (well, at least
    me) back to "then let's just add it to git-config?".

> I do agree that your approach bans the regrettably awkward
> "hookcmd.~/check-for-debug-strings.skip =3D true", but I'm not sure
> whether or not it's worth it.

That design choice also means that you can't expand the path using "git
config --get --type=3Dpath.

We do have that with the "includeIf" construct, but if we can avoid it
we should, it makes it play nicer with other assumptions and features of
the config system.

As noted in the follow-up reply while we don't case normalize the LeVeL"
part of "ThReE.LeVeL.KeY" that's tolower(), which we know isn't a 1=3D1
mapping on some
FS's. https://lore.kernel.org/git/87y2ebo16v.fsf@evledraar.gmail.com/

> To help us visualize the change, here's some common and complicated
> tasks and how they look with either schema (let mine be A and yours be
> B):

Before diving into that, I'll just say I don't care about the trivial
specifics of how this is done, i.e. the bikeshedding of what the config
keys etc. are named.

Just in (as noted above) design choices here forcing avoidable
complexity in other areas.

> #1 - Add a oneliner (not executing a script)
> A:
> [hook "post-commit"]
> 	command =3D echo post commit
> B:
> [hook "oneliner"]
> 	event =3D post-commit
> 	command =3D echo post commit
> #2 - Execute a script
> A:
> [hook "post-commit"]
> 	command =3D ~/my-post-commit-hook
> B:
> [hook "script"]
> 	event =3D post-commit
> 	command =3D ~/my-post-commit-hook

...

> #3 - Run a handful of scripts in a specific order on one event
> A:
> [hook "post-commit"]
> 	command =3D ~/my-post-commit-1
> 	command =3D ~/my-post-commit-2
> 	command =3D ~/my-post-commit-3
> B:
> [hook "script 1"]
> 	event =3D post-commit
> 	command =3D ~/my-post-commit-1
> [hook "script 2"]
> 	event =3D post-commit
> 	command =3D ~/my-post-commit-2
> [hook "script 3"]
> 	event =3D post-commit
> 	command =3D ~/my-post-commit-3

To reply to all the above, yes, your suggestion comes out ahead in being
less verbose.

But isn't the real difference not in the differing prefixes, i.e. hook.*
and hookcmd.* (A) v.s. always hook.* (B, which is what I'm mainly
focusing on, i.e. what requires the added complexity.

But that in that in your proposed way of doing it it's:

    hook.<event-or-name>.*

V.s. my suggestion of:

    hook.<name>.*

And thus whenever you have a <event-or-name> that just happens to be a
built-in hook listed in githooks(5) we in (A) implicitly expand config
like:

    hook.post-commit.command =3D echo foo

To:

    hook.post-commit.command =3D echo hi
    hook.post-commit.type    =3D post-commit

But not knowing about "foo" we don't expand:

    hook.foo.command =3D echo foo

To:

    hook.foo.command =3D echo hi
    hook.foo.type    =3D foo # This would be an error, or ignored.

But rather leave "dangling" for the user to later supply the "*.event"
themselves, i.e.:

    hook.foo.command =3D echo hi
    hook.foo.event =3D post-commit

And means that you presumably need to detect this case and error about
it, but my proposed model does not:

    hook.post-commit.command =3D echo hi
    # User error: "*.type" and <event-or-name>" does not match for
    # "hook.*.command"
    hook.post-commit.type    =3D pre-commit

And furthermore, that if someone in your model were to do:

    hook.verify-commit.command =3D echo hi

It's "dangling" today, but if a later version of git learns about a
"verify-commit" hook we'll start running it unexpectedly.

Because your design conflates the slot for known hook type names and
user-supplied names.

On balance I think it's better just to always supply two lines per-hook,
but whether we have this proposed shorthand or not is mostly orthogonal
to everything I mentioned in
https://lore.kernel.org/git/87mtv8fww3.fsf@evledraar.gmail.com/

I.e. my proposed version could also have it, but thinking about it I
think it's not worth it, we should always use <name>, not
<event-or-name> for the reasons noted if you'll read ahead...

> #4 - Skip a script configured more globally
> A:
> (original config)
> [hook "post-commit"]
> 	command =3D /corp/stuff/corp-post-commit
> (local config)
> [hookcmd "/corp/stuff/corp-post-commit"]
> 	skip =3D true
> OR,
> (original config)
> [hookcmd "corp-pc"]
> 	command =3D /corp/stuff/corp-post-commit
> [hook "post-commit"]
> 	command =3D corp-pc
> (local config)
> [hookcmd "corp-pc"]
> 	skip =3D true
> B:
> (original config)
> [hook "corp-pc"]
> 	event =3D post-commit
> 	command =3D /corp/stuff/corp-post-commit
> (local config)
> [hook "corp-pc"]
> 	skip =3D true

...which are among other things that no, my proposed version doesn't
have "skip" at all, see point #3 at
https://lore.kernel.org/git/87mtv8fww3.fsf@evledraar.gmail.com/

I.e. I think the "skip" is a thing that falls out of a complexity of
your design that I'm proposing to do away with.

That complexity being that you use <event-or-name> and I use <name>, and
you want to in turn support N number of "*.command" for any
"hook.<event-or-name>".

I'm suggesting we use the typical "last key wins" semantics, if you want
multiple commands for a given hook type you'll just supply multiple
"hook.<name>" sections with the same "hook.*.event =3D type" in all.

The way to skip hooks in my proposal is:

    hook.<name>.command =3D true

Or whatever noop command you want on the RHS. In practice we wouldn't
invoke "true", just like we don't invoke "cat" for "PAGER=3Dcat".

But unlike "*.skip" that doesn't require complexity in implementation or
user understanding, it just falls naturally out of the rest of the
model.

> #5 - Execute one script for multiple events
> A:
> [hookcmd "reusable-hook"]
> 	command =3D /long/path/reusable-hook
> [hook "post-commit"]
> 	command =3D reusable-hook
> [hook "pre-commit"]
> 	command =3D reusable-hook
> [hook "prepare-commit-msg"]
> 	command =3D reusable-hook
> B:
> [hook "reusable-hook"]
> 	command =3D /long/path/reusable-hook
> 	event =3D post-commit
> 	event =3D pre-commit
> 	event =3D prepare-commit-msg

It's been so long since I wrote the original E-Mail that I'm having to
skim my own summary there & come up with things as I go along, so maybe
this conflicts with something I said earlier.

But no, I don't think I meant that *.event should be multi-value, or
that that magic is worthwhile. I.e. I think we just want:

    [hook "not-a-reusable-section-1"]
        command =3D /long/path/reusable-hook
        event =3D post-commit
    [hook "not-a-reusable-section-2"]
        command =3D /long/path/reusable-hook
        event =3D pre-commit
    [hook "not-a-reusable-section-3"]
        command =3D /long/path/reusable-hook
        event =3D prepare-commit-msg

I.e. is wanting to use the same command for N different hooks really
that common a use-case to avoid a little verbosity, and quite a lot of
complexity?

How would such a hook even be implemented?

We don't have anything in your hook execution model (and I don't
remember you adding this) which passes down a "you are this type of
hook" to hooks.

It's now implicit in that the hook invoked at .git/hooks/post-commit or
.git/hooks/pre-commit can check its own basename, but it won't be with
configurable hooks.

We could start passing down a GIT_HOOK_TYPE in the environment or
whatever, but I think the simpler case of just having the user do it is
better.

I'm assuming that mainly because people have wanted a
"/long/path/reusable-hook" router script because we have not supported
executing N hooks, or supported concurrency. Once we do that the
complexity of such routing scripts (mostly, not everyone's needs will be
met) will be replaced by a little bit of config.

I don't see why it's worth it to micro-optimize for lines in that config
at the cost of increased config complexity.

For example, how do you "skip" an "event" type? You have it for
"*.command"? So let's say in your model (A) I have system config like:

    [hook "my-reusable"]
    command =3D /some/commit-msg-hook
    event =3D prepare-commit-msg

Now I want to skip that, easy enough, in my local config:

    [hook "my-reusable"]
    skip =3D true

Or if I wanted to also invoke it for commit-msg events, in my local
config (which piggy-backs on the system one):

    # Now runs for both prepare-commit-msg and commit-message
    [hook "my-reusable"]
    event =3D commit-msg

Or, if I want to skip the command name and substitute my own:

    [hook "my-reusable"]
    skip =3D true
    command =3D /my/commit-msg-hook

I'm just assuming you mean that to work, as discussed above I think all
this is leading us down the road of too much complexity.

But anyway, now I want to instead not run it as a prepare-commit-msg
hook, but a commit-msg hook.

As far as I can tell you haven't specified that, but I think something
consistent with your model would be

    [hook "my-reusable"]
    event =3D skip
    event =3D commit-msg

Or rather, because that conflates "skip" with a hook event type name:

    [hook "my-reusable"]
    skipEvent =3D true
    event =3D commit-msg

I.e. the "skip" you have now really means "skipCommand", so we'll need a
skipSomeName to skip other "hook.*.someName".

As noted above I think all of this is too complex, let's just do the
system config like this (exact same as the above):

    [hook "my-reusable"]
    command =3D /some/commit-msg-hook
    event =3D prepare-commit-msg

To skip it, in my local config:

    [hook "my-reusable"]
    command =3D true

And to re-use /some/commit-msg-hook without having to re-include it in
your local config the answer is that we don't support that level of
cleverness. Just do this:

    # First skip the system hook
    [hook "my-reusable"]
    command =3D true

    # Set up another hook, just copy/pasting the /some/commit-msg-hook comm=
and
    [hook "my-local"]
    command =3D /some/commit-msg-hook
    event =3D commit-msg

I.e. I think these cases of someone having say a /etc/gitconfig hook on
their system not under their control that they want to not run, *but*
not as the "event" there, but as another event type is too specific a
use-case for us to worry about.

> #6 - Execute the same script early for one event and late for another
> event
> A:
> (global)
> [hookcmd "reusable-hook"]
> 	command =3D /long/path/reusable-hook
> [hook "pre-commit"]
> 	command =3D reusable-hook
> (local)
> [hook "post-commit"]
> 	command =3D other
> 	command =3D hooks
> 	command =3D reusable-hook

Even with I think it's fair to say deep knowledge of your proposal at
this point I still needed to read this a few times to see if that:

    command =3D reusable-hook

Is referring to:

    [hookcmd "reusable-hook"]

I.e. is it going to run:

    command =3D /long/path/reusable-hook

Or is it just re-specifying /long/path/reusable-hook but relying on a
$PATH lookup?

Having reasoned through that I think the answer is the former. But that
also means that in your model:

    [hookcmd "rm -rf /"]
    command =3D echo this will not actually destroy your data
    [hook "pre-commit"]
    command =3D rm -rf /

Is going to run that friendly "echo" command, since "command =3D rm -rf /"
just refers to the "rm -rf /" <name>, not <command>, right the "hookcmd"
line is removed, at which point we'll stop treating it as a <name> and
run it as a <command>?

In practice I think users are unlikely to use actively harmful names
like that.

I'm just making the point that I should not need to know about previous
config to see if a "hook.pre-commit.command =3D rm -rf /" is harmless or
not, or need to carefully squint to see if the "reusable-hook" is
referring to a section name or command name.

Or am I just confused at this point?

> B:
> (global)
> [hook "reusable-hook"]
> 	command =3D /long/path/reusable-hook
> 	event =3D pre-commit
> (local)
> [hook "other"]
> 	event =3D post-commit
> 	command =3D other
> [hook "hooks"]
> 	event =3D post-commit
> 	command =3D hooks
> [hook "reusable-hook"]
> 	event =3D reusable-hook

No, that's not what I'm proposing. I.e. "*.event" is reserved for
built-in events listed in githooks(5) that git itself knows about.

If you say "event =3D reusable-hook" that's going to be one of ignored,
warned or errored about.

(Probably "ignored" is the best thing to support multi-version setups,
but that's not hook-specific, just how we treat unknown config in
general)

My version of this would be the same as noted with "we don't support
that level of cleverness[...]" above.

I.e. you'd not re-use that "/long/path/reusable-hook", you can skip it
through "command =3D true", then just copy the relevnt part into your new
config. So:

        (global)
	[hook "reusable-hook"]
		command =3D /long/path/reusable-hook
		event =3D pre-commit

	(local)
	[hook "reusable-hook"]
		command =3D true # skip it

        # The "hooks" name is arbitrary, "my-hooks" or whatever would be
        # clearer, but just going with your example...

	[hook "hooks"]
		event =3D post-commit
		command =3D hooks
        # Not very reusable then...=20=20=20
	[hook "reusable-hook"]
                command =3D /long/path/reusable-hook
		event =3D pre-commit


> [...]Please feel free to chime in with more use cases that you think would
> be handy which I forgot :)

I couldn't find this at a quick glance but I think we also had a
disussion at some point about hooks controlling parallelism. AFAICT your
current implementation just has global:

    hook.jobs=3DN

And we then blacklist certain hooks to always have hook.jobs=3D1, e.g. the
commit-msg hook that needs an implicit "lock" on that file (or rather,
we think that's the most common use-case).

I think my version of always having hook.<name>.{event,command} be one
value is also better in that case, i.e. we'd then:

    [hook "myhook"]
    command =3D some-command
    event =3D pre-receive
    parallel =3D true # the default

    [hook "myhook2"]
    command =3D some-command2
    event =3D pre-receive
    parallel =3D true # the default

    [hook "myhook3"]
    command =3D some-unconcurrent-command
    event =3D pre-receive
    parallel =3D false # I'm not OK with concurrency

To go along with something like:

    hook
	jobs =3D 8

Or:

    [hookEvent "pre-receive"]
    jobs =3D 4

But if you have N numer of "command" in a section it gets murky, does
"parallel =3D false" then apply to the whole section, but sections can
have one or more values. So we'd need both a
"hookEvent.pre-receive.jobs=3DN" and per-section config to
control/suppress parallelism?

I haven't thought about it deeply, but have a hunch that having sections
be a 1=3D1 mapping with a specific command instead of either 1=3D1 or 1=3Dm=
any
is going to make that easier to implement and understand.
