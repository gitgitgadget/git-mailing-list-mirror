Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC40C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 23:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D93ED60EB9
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 23:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236182AbhHEXZ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 19:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhHEXZ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 19:25:26 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DBAC0613D5
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 16:25:11 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id zb12so7443761ejb.5
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 16:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=8Lprbf1dR3LFrFrwW2GR/bPjqJkUz0j6dPw18Z2hR6k=;
        b=jSutHtGZu+tyemWzsmBquomjvOrLc0i8iZ7anaAXKOB1DO1j8PVufAZID6Fg2YDhiX
         pmNeKvu7W3HgL3npxmh7E8vhpy0MG01ltfHzGdS72ape3UeGYe6h8pp2xZLti5BHU3M9
         0Dk1rS6MKxP9GVqR4UkjzA12wWnqmRMFZpaOzDSHnJsXHWnr6daUMY39BRKDd+c4/G+8
         D6L8YoX79tKrD4HsddgVaHUKD5zkSVNtbcoCAKo2Qdrd20fQn9r3eNuqinPqb0yGjJT3
         C0wLDVSWsxwHycH5MPgjCmw78VJDg/NULgzFlFUqCFx2y4iOAtWXAEjXrQMg0V6fUNi4
         AzMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=8Lprbf1dR3LFrFrwW2GR/bPjqJkUz0j6dPw18Z2hR6k=;
        b=G3HNyj6DTfm02SfVWoq/zeQw5vo+y4e5NIsX/8IouVUdSyXq+4GVnoHyefnShr0RZk
         ml7Z5aRs/1gMW+ckIXY29LuPELByr/x6uC+cWawBhe9QF0dv721Imt8W/iUUzNI2pwTm
         v7SYnhC7ZvirDBRc8IWn+wKOXp7046Ez0ZLEKqERWkqQhslS1dMKIWMGoTbNow+Jg/D4
         p0nTGHpRzYeIAHurOFDZMmXwIIHBFa05eDo4RWrDDp5ifuVud13n6VNtnOtw4t+Djjob
         a30bXzSbD72f9T01tvSUYWqRjwNFBSQopkmG9jHigoa1pnnwVAFAY5DO/99aNgQ5sAK9
         jRNw==
X-Gm-Message-State: AOAM532Od5mZhcQY0aOrfaQpK5KFJmZ5KkDoXriuzPbnav5tkrgTo8ga
        IiiFT8CRe+ELRKO41MkMJ1A=
X-Google-Smtp-Source: ABdhPJzugLOf5Xq/Nk14IZOg2GDXhZQNgibuH4cij/DKl6hup2V8GPHu29VgHeexetkRrJGFtnrAGA==
X-Received: by 2002:a17:906:f2d7:: with SMTP id gz23mr7194177ejb.486.1628205909623;
        Thu, 05 Aug 2021 16:25:09 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id ch5sm1603769edb.61.2021.08.05.16.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 16:25:09 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 8/9] hook: teach 'hookcmd' config to alias hook scripts
Date:   Fri, 06 Aug 2021 00:26:02 +0200
References: <20210715232603.3415111-1-emilyshaffer@google.com>
        <20210715232603.3415111-9-emilyshaffer@google.com>
        <87fswey5wd.fsf@evledraar.gmail.com> <YPn/5GLrAb17KqyB@google.com>
        <87bl6ttmlv.fsf@evledraar.gmail.com> <YQr6xojzxk3xJrTw@google.com>
        <877dh0n1b3.fsf@evledraar.gmail.com> <YQxcDZSEvrRKIN+L@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YQxcDZSEvrRKIN+L@google.com>
Message-ID: <87sfznzd7v.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 05 2021, Emily Shaffer wrote:

> On Thu, Aug 05, 2021 at 02:17:29AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> [...]
>> > No, that's in fact as designed, with my model B. The user configured
>> > "echo hi" to run on "verify-commit" events; if those events are
>> > initially used by some wrapper, but later we decide they're a great id=
ea
>> > and absorb the verify-commit event into native Git, then this is worki=
ng
>> > as intended. I think your argument is based on a misunderstanding of t=
he
>> > design.
>> >
>> > Could it be that the way I provided the examples (my schema after A: a=
nd
>> > your schema after B:) made it hard to parse? Sorry about that if so.
>>=20
>> Aren't you assuming that users who specify a verify-commit will be happy
>> because git's usurping of that will 1=3D1 match what they were using
>> "verify-commit" for.
>>=20
>> I'm pointing out that we can't know that, and since you want to make
>> "git hook run" a general thing that runs any <name> of script you've
>> configured, and not just what's in githooks(5) that it becomes very
>> likely that if we add a new hook with some obvious name that we'll
>> either break things for users, or subtly change behavior.
>>=20
>> Which isn't just theoretical, e.g. I tend to run something like a "git
>> log --check @{u}.." before I run git-send-email, with this configurable
>> hook mechanism having a "git hook run sendemail-check" would be a way I
>> might expose that in my own ~/.gitconfig.
>>=20
>> But if git-send-email learns a "sendemail-check" and the behavior
>> doesn't exactly match mine; E.g. maybe it similar to pre-auto-gc expects
>> me to return a status code to ask me if I want to abort on a failed
>> --check, but mine expects a revision range to run "log --check".
>>=20
>> In practice that's a non-issue with the current hook mechanism,
>> i.e. nobody's sticking a script into .git/hooks/my-custom-name and
>> expecting it to do anything useful (and if they are, they have only
>> themselves to blame).
>>=20
>> Whereas we'd now be actively inviting users to squat on the same
>> namespace we ourselves will need for future hooks.
>
> Yeah, this is a good point. Seems worth a note in the 'git hook run'
> doc, making a point that "you can use this for your wrapper to run
> specific hooks, but be careful about namespace collisions". We're a lot
> less likely to add a hook named "repotool-verify-commit" than we are to
> add a hook named "verify-commit", for example.
>
> I think it's enough to warn about future namespace collisions and make
> an "at your own risk" note.

I might have lost track at this point, but later examples in this E-Mail
you show don't seem to require such a note.

I.e. it's only an issue if we conflate a semantically meaningful slot
like "pre-commit" in the config with one that can also have the meaning
of simply defining an arbitrary user-decided name.

There's no such collision if the config uses
e.g. hook.mycheck.event=3Dpre-commit & hook.mycheck.command=3Dmycmd, as
opposed to hook.pre-commit.command=3Dmycmd.

On the specifics of that example: I don't really care about the
bikeshedding of the config key naming specifics, just the semantics of
not putting user defined names and hook type names in the same slot if
we can avoid it.

>> > No, but it's something I'm interested in passing as an environment
>> > variable. I didn't add it to this series because it seemed to me to
>> > distract from the core feature. We would like to add it to simplify our
>> > invocations of https://github.com/awslabs/git-secrets, so it's on my
>> > radar.
>>=20
>> Having such an env var as part of the initial series seems like a
>> sensible thing to have.
>
> Eh. To me, it feels like feature creep. It also is something we could
> add today to the existing hook mechanism (even if it's a little
> pointless since you can basename, like you say), so it feels orthogonal.
> I would prefer not to add it in this series.

Sure, I guess you can add two hook sections to replace e.g. your
{pre,post}-receive hook (which are commonly routed to the same script
with file-based hooks). Having a single setenv() seems easy enough, and
I'd bet a way more common use-case than wanting to skip earlier defined
hooks...

>> > I am not sure what it means for a single executable to write "parallel=
 =3D
>> > true" - it is a single executable.
>> >
>> > Ok, that is me being facetious - I think you are saying we can AND
>> > together all of the 'hook.<thing-with-event-we-care-about>.parallel' to
>> > decide whether or not to run in parallel.
>>=20
>> Right, the case (whatever the config mechanism) wanting to use several
>> off-the-shelf hooks and accomplish through git some version of this:
>>=20
>>     parallel -j8 pre-receive-parallel-*.sh &&
>>     parallel -j1 pre-receive-non-parallel-*.sh
>>=20
>> I.e. since we have N scripts for the "pre-receive" type, and we're
>> expecting to say whether on not parallelism is OK or not, it seems like
>> a natural thing we'll want to declare that differently for some of those
>> than for others.
>>=20
>> > I would rather not discuss this now, for this series, because regardle=
ss
>> > of which config schema we use today, we can figure out "parallel unless
>> > we really don't want it" later on. It is too complex to discuss in the
>> > context of "hey, we should also configure hooks somewhere else". Let's
>> > leave it for future work.
>>=20
>> The point is that no, we really can't figure it out as easily later on
>> regardless of the config schema.
>>=20
>> Because with 1=3Dmany you can't have 1=3Dmany.someAttribute=3DXYZ withou=
t that
>> *.someAttribute=3DXYZ declaring something for all of 1=3Dmany, whereas if
>> it's 1=3D1 then 1=3D1.someAttribute.XYZ obviously applies only to that 1=
=3D1.
>
> I think this is moot, since we are moving to "all config hooks have a
> name", but my plan previously was to let this be set on a hookcmd.
> Essentially, your suggestion is to make every hook a hookcmd. My point
> was that it's easy to extend [object which represents an executable] in
> the config to include "always run me in series" or "run me in series for
> this specific event" regardless. That is, one could imagine, discarding
> entirely the hookcmd junk and going with the schema I sketched in my
> last email (which lands somewhere between yours and mine):

Just to be clear, I don't have any concrete suggestion in mind right now
(actually as I write this I can only vaguely recall what I suggested
before).

What I have been suggesting is not any specific implementation, but that
we have a bias for the simple over the complex for an initial
implementation.

Complexity can always be added later, whereas coming up with a config
schema that's irregular compared to other existing config in git is
something we might regret sooner than later.

> [hook "linter"]
>   command =3D ~/linter.sh
>   event =3D pre-commit
>   parallel =3D false
>
> or...
>
> [hook "linter"]
>   command =3D ~/linter.sh
>   event =3D pre-commit
>   event =3D commit-msg
>
> [hook "linter.commit-msg"]
>   parallel =3D false
>
> Or even...
>
> [hook "linter"]
>   command =3D ~/linter.sh
>   event =3D pre-commit
>   event =3D commit-msg
>   parallel =3D commit-msg
>
> The possibilities go on, as far as configuration goes.
>
> To me, the harder part of this problem is actually implementing the
> execution. We had some discussions at length early on in the
> config-based hook series about ways to do this kind of complex "some
> stuff needs synchronous execution and some stuff doesn't, in the same
> event" and decided that it mostly resolved to "you ain't gonna need it"
> principle. So I would prefer to discuss this when we find out we do
> actually need it.

What I was mainly going for with "we really can't figure it out as
easily later" above was not that this tweaking of "jobs" or parallelism
was essential per-hook.

But that it was a handy shorthand for a config attribute you might want
to define for hooks, and having what are effectively groups of hooks,
with N "command" or "event" in one section might make things more
complex once you'd want to define optional attributes for one of those
commands or events.

>> [...]
>> >  - I do see value in having an explicit .skip field rather than mapping
>> >    .command to a noop, so "hook.name-of-hook.skip" as described above.
>> >    Of course the method you described will work regardless, since its
>> >    mechanism is based on the inherent result of executing /bin/true.
>>=20
>> I think we've mainly focused on the theoretical aspect of this, but FWIW
>> I'm still entirely unclear on what this feature is even aimed for.
>>=20
>> All of the rest of our config does not have an explicit "skip" for
>> anything, just last-set-wins. In terms of a real-world use-case wouldn't
>> a user just edit or comment out the config earlier in ~/.gitconfig, and
>> not "skip" it at the end with "git config [...] --add"?
>>=20
>> I suspect that the use-case is some Googly centrally managed
>> /etc/gitconfig, but that's just speculation...
>
> Yep, this is exactly why. We've talked often on-list about how we ship
> and configure Git for Googlers, but the upshot is "we pack up 'next' and
> also ship an '/etc/gitconfig'".
>
> But I can also think of one really basic scenario when I'd want to skip
> a hook in one repo without just commenting out my ~/.gitconfig: the
> Gerrit Change-Id hook.
>
> Gerrit requires all commit messages to contain this Change-Id: abc123
> footer. It adds the footer by way of a commit-msg hook. That hook works
> the same regardless of what your Gerrit remote is, so you can run the
> same script on any project that uses Gerrit for code review. If, as I hav=
e in
> the past, the vast majority of my projects use Gerrit, but I have one
> project which does not, then I would love to configure the Gerrit
> Change-Id hook globally and un-configure it for my one non-Gerrit
> project.
>
> (At that time, I maintained a subsystem in a project based on Yocto, so
> I needed to regularly contribute to 5-10 projects, all but one of which
> used Gerrit. The one non-Gerrit one used a mailing list. I also had a
> hobby project and my dotfiles, neither of which used Gerrit. This is not
> an uncommon use case.)

> I disagree fundamentally that "find and run a noop command like
> /bin/true" is simpler to average users than "skip it by setting a
> config". Like I said below, by including "skip" both approaches will
> work.

In reply to this, and moving things around a bit in the reply:

>> All of that's something you'll need to explain in detail to users, which
>> all seems way more complex than a simple:
>>=20
>>     To skip a previously defined hook insert a noop-command, any will
>>     do, but setting it to "true" (usually /bin/true) is a handy
>>     convention for doing nothing.
>>=20
>> I.e. by keeping the config field as doing one thing only you avoid any
>> such collisions etc.
>
> I disagree fundamentally that "find and run a noop command like
> /bin/true" is simpler to average users than "skip it by setting a
> config". Like I said below, by including "skip" both approaches will
> work.

To clarify, I haven't been advocating for that "skip =3D true" convention
because I think it's a sensible thing per-se, but that I think this
use-case is something that an individual configurable feature in git
doesn't need stateful syntax to deal with.

We have any number of multi-value and single-value config within git. I
just don't see why on balance hooks need a special syntax to skip
earlier set config for hooks specifically.

E.g. this gerrit example would also be true of someone in a corporate
setting using git-send-email, and wanting a list of sendemail.cc on all
but their dotfiles project, or one other non-work project.

Does that mean we need a sendemail.skipCC and special handling for it in
git-send-email.perl? No, I think we'd generally advice users to just put
those projects under ~/work or whatever, and then use config includes to
set config for that group of projects based on the path:

    [includeIf "gitdir:~/work/"]
        path =3D ~/.gitconfig.d/work

Or, if a hook is really so special that it's needed everywhere define it
in /etc/gitconfig, and then just make the hook itself do:

    if test "$(git config --bool googleHooks.disableOurGlobalHook)" =3D "tr=
ue"
    then
        exit 0
    fi

Which is pretty much (with the hook.* config prefix) how we've adviced
users to do this since approximately forever with the sample hooks we
ship.

The advantage of using includes in that way is e.g. that you can easily
see how your hook came to be configured with:

    git config --list --show-origin

I.e. that (by convention) it comes via a conditionally included
~/.gitconfig.d/gerrit file. If it's a multi-value like sendemail.cc the
semantics are also clear, e.g. you can get all values we'll use with
"git config --get-all".

Whereas choosing to implement this with something that *looks* like a
config keyword, but really isn't is just confusing.

We need to explain in one way how users might arrange for the likes of
sendemail.cc to be defined for some, but not all of their repos, and
explain it differently when it comes to hooks. There's inherent value in
that explanation being the same for both.
