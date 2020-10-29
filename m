Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8585C2D0A3
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 20:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BE5C2087D
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 20:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFqB60ru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgJ2UE3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 16:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgJ2UE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 16:04:28 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF9BC0613CF
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 13:04:26 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id j24so5480285ejc.11
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 13:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=8Qzl2e9MaQCENYduwA2E7BsNAuKtFN/uliGE4mIgI0I=;
        b=JFqB60ruxS4UCzG6Pq90K81jvQUtwq+41VPGhiusgTHnf843AUz78tBlNyVK0aOEbj
         Qg4nRgFT9C4nCK9la4oxSpw3J5AdR4zJtXNanv6ElXx6eMsGpteedalY1vtDumu7Sxko
         GfhGkwOjWcFL5TPK8BBA0YzJIHWTWrL+2v6g/1jF8ObUJIMI7xCE7ejAnYoh0oWwQg8i
         9bgzDdzhyvOvhYN+eIffoP3l+nG9Q26h8TKpBsgE+IYuG0BWBH42Hc305xgHpslnsMVw
         99qhuxGy4ccTP1JKQ50kwdVeyoV/7rKxLX48thQA2gjmgS9+MXFDwKNI5loYjeQnnXZn
         dYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=8Qzl2e9MaQCENYduwA2E7BsNAuKtFN/uliGE4mIgI0I=;
        b=JOKA3wFi2hjxPRL9vRq9AgS89TZ+TuFf1dF1DSrKoSkGqK2jrYCCRTSCX/kt75XiBY
         AR98lD+sUtkQVCSbeutvpOFU5PsKrvQWUN0Zicv1mf8eRst82n2TJUdydxuSElIiGt2i
         0dS3gMz6TQK7ukcvK+q8VzhHOVNWuvJC6xy0fDhffxblO0S5lC+FSt7c+vddyk3v53CW
         wj0Aajf+xeuVlodJbZ40a8hCE+TG8tTwGKZyZejEIJlbd3cZNX/FP1AvlDbJpt41gjqi
         cmbgckxwUP8LJ55gWryWVCszJkdZNrw27J8uupQKOAjqxpLA2/KO8sjFuekPLfbcUp52
         lrIQ==
X-Gm-Message-State: AOAM532Z6o7oL7UfC2Am2IloOB+QAunb+9zqkqc01Uk42zQGccP3JruU
        q7QTeCDS8xyYbXhVAg7Z4SNtTlcVmNw=
X-Google-Smtp-Source: ABdhPJx9+x7TqpxvGCmUy6R0n2IK8g0wBZmmiFTm4hbhL9eAoawSc/9hpG3Wr1f7HgtpSJT4HMuJ0A==
X-Received: by 2002:a17:907:9604:: with SMTP id gb4mr5848320ejc.336.1604001864734;
        Thu, 29 Oct 2020 13:04:24 -0700 (PDT)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id cz11sm2060390edb.62.2020.10.29.13.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 13:04:23 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     h@google.com, git@vger.kernel.org
Subject: Re: [PATCH v4 1/9] doc: propose hooks managed by the config
References: <20200909004939.1942347-1-emilyshaffer@google.com> <20200909004939.1942347-2-emilyshaffer@google.com> <87mu0ygzk1.fsf@evledraar.gmail.com> <20201022005848.GD2774782@google.com> <87zh4chi73.fsf@evledraar.gmail.com> <20201029153858.GG2774782@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <20201029153858.GG2774782@google.com>
Date:   Thu, 29 Oct 2020 21:04:23 +0100
Message-ID: <87tuuchk8o.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 29 2020, Emily Shaffer wrote:

> On Fri, Oct 23, 2020 at 09:10:24PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> >> You already use "hookdir" for something else though, so that's a bit
>> >> confusing, perhaps s/hookcmd/definehookcmd/ would be less confusing, =
or
>> >> perhaps more confusing...
>> >
>> > "Hookdir" might be the wrong word to use, too - maybe it's better to
>> > mirror "hookspath" there. Eitherway, "hookdir" and "hookspath" are
>> > similar enough that I think it would be confusing, and "hookcmd" is
>> > already getting some side-eye from me for not being a great choice.
>> >
>> > Some thoughts for "a path to a directory in which multiple scripts for=
 a
>> > single hook live":
>> >  - hookset
>> >  - hookbatch (ugh, redundant with MS scripting)
>> >  - hook.pre-commit.all-of =3D ~/last-minute-checks/
>> >  -  "   "  .everything-in =3D "   "
>> > ...?
>> >
>> > I think I named a couple silly ideas for "hookcmd" in another mail.
>>=20
>> To both of the above: Yeah I'm not saying you need to do the work, just
>> that I think it would be a useful case to bikeshed now since it seems
>> inevitable that we'll get a "find hooks in this dir by glob" once we
>> have this facility. So having a config syntax for that which isn't
>> overly confusing / extensible to that case would be useful, i.e. as the
>> current syntax uses "dir" already.
>
> Yeah. I'm not sure that it needs to happen right away. Because
> hook.*.command // hookcommand.*.command gets passed right into
> run_command()-with-shell, it's possible for a user who's keen to also
> set `hook.*.command =3D find -type f /some/path | xargs` in the meantime.
> And also because it's passed right into run_command()-with-shell, it's
> hard to do some smart wildcarding on the .command config and try to
> figure out the right syntax. I'd just as soon see something explicit
> like the configs I mentioned above, which can be added pretty easily
> after the fact. I think what you're mostly saying, though, is "Leave
> some words for glob execution!" and that I can appreciate.

Yeah, or rather, just now in config key naming think about if the key
naming makes sense if it's expanded to support such glob inclusion,
which seems like a desired addition. But I won't belabor that point.

Just one thing to add: We don't really need to come up with a syntax &
semantics for glob inclusion special to this, we'd use the sort of glob
patterns "Conditional includes" use, as documented in  git-config(1).

>> > Hum. This seems to say "folks who started their hooks with the same
>> > number agree that their hooks should also run simultaneously" - which
>> > sounds like an even harder problem than "how do I know my ordering
>> > number isn't the same as someone else's in another config file". Or el=
se
>> > I'm misunderstanding your pseudo :)
>>=20
>> The prefix number isn't meaningful in that way, i.e. if you have 10
>> threads and 5 hooks starting with 250-* they won't all be invoked at the
>> same time.
>
> Ok. I misunderstood, then.
>
>> > I know I rambled a lot - I was trying to convince myself :) For now, I=
'd
>> > prefer to add more detail to the "future work" section of the doc and
>> > then not touch this problem with a very long pole... ;) Thoughts
>> > welcome.
>>=20
>> I'm replying to much of the above in general here, particularly since
>> much of it was in the form of a question you answered yourself later :)
>>=20
>> Yes as you point out the reason I'm raising the parallel thing now is
>> "keep users from assuming serial execution", i.e. any implementation
>> that isn't like that from day 1 will need more verbose syntax to opt-in
>> to that.
>>=20
>> I think parallel is the sane default, although there's a really strong
>> case as you point out with the "commit-msg" hook for treating that on a
>> hook-type basis. E.g. commit-msg (in-place editing of as single file)
>> being non-parallel by default, but e.g. post-commit, pre-applypatch,
>> pre-receive and other "should we proceed?" hooks being parallel.
>
> Yeah. I think you've sold me. So what I will do is thus: before I send
> the next reroll (as I'm pretty much done, locally, and hope to be ready
> for nits next time) I'll take a look in 'git help githooks' and see
> which ones expect writes to occur. I think there are more than just
> "commit-msg". I'll add a bit to run_hooks() and a corresponding flag to
> 'git hook run', plus relevant documentation. I'll also plan to add
> explicit documentation to 'git help githooks' mentioning parallel vs.
> serial execution.

Sounds good.

> But I will plan on writing it stupidly - user configurable job number
> but no dependency checking; and let the user turn off parallel execution
> for everyone (hook.jobs=3D1) or for just one hook
> (hook.pre-commit.parallel =3D false (?)). Like you and Jonathan N say, we
> can add more sugar like hookcmd.*.depends later on when we need it.

Yeah, that sounds great. As long as there's parallelism that stuff can
always be tweaked later.

>>=20
>> But I'm also raising a general concern with the design of the API /
>> command around this.
>>=20
>> I don't see the need for having a git hook list/edit/add command at
>> all. We should just keep this simpler and be able to point to "git
>> config --add/--get-regexp" etc.
>>=20
>> It seems the reason to introduce this command API around it is because
>> you're imagining that git needs to manage hooks whose relative execution
>> order is important, and to later on once this lands aim to implement a
>> much more complex dependency management schema.
>
> No, I don't think that's the reason to have list/edit/add. The reason is
> more for discoverability (if I 'git help git' or 'git^TAB', do I see
> something handy in the command list that I didn't know about before?)
> and user friendliness ("I can't remember the right config options to set
> this up every dang time"). And 'list', I think, is handy for giving
> users a dry run of what they can expect to see happen (and where to fix
> them, since it lists the origin). Yes, a user could put it all together
> from invocations of 'git config', but I personally think it's more
> useful for Git to tell me what Git is going to do/what Git wants than
> for my meat brain to try and guess :)

Okey, that makes sense & I've got nothing against that, just clarifying
since it *looked* like it was the first step in some future addition of
complexity around this.

It would be nice if the docs for the new command were modified to state
that clearly, even to the point of saying "this is really just sugar for
this similar git-config invocation".

>>=20
>> I just can't imagine a case that needs that where say those 10 hooks
>> need to execute in exact order 1/2/3/4 where the author of that tight
>> coupling wouldn't also desire to roll that all into one script, or at
>> least that it's an obscure enough case that we can just say "do that".
>>=20
>> Whereas I do think "run a bunch of independent checks, if all pass
>> proceed" is *the* common case, e.g. adding a bunch of pre-receive
>> hooks. If we tell the user we'll treat those as independent programs we
>> can run them in parallel. The vast majority of users will benefit from
>> the default faster execution.
>>=20
>> The "glob order" case I mentioned is extra complexity on top of that,
>> yes, but I think that concession is sane for the common case of "yes
>> parallel, but I want to always run the always-exit-0 log
>> hook". E.g. I've used this to setup a hook to run push
>> attempts/successes in a hook framework that runs N pre-receive hooks.
>
> Reading this, I think I'm still missing something key about what you
> think glob ordering provides.=20

For context, I feel strongly that we should do parallel by default for
implementing something like this, it's great that per the above
discussion you're open to that.

This "glob ordering" is an entirely separate idea I'm not strongly
advocating, there's pros & cons of doing that v.s. config ordering.

 * Con: less obvious than config order, you write hooks "a c b" in the
   config and we execute in "a b c" order.

 * Pro: Sidesteps the issues you noted in "Execution ordering" in the
   docs you're adding, i.e. now it'll be impossible to execute a
   repo-local hook before a system-wide one, you can override that with
   having a local one called "000-something".

   I.e. now we'd read the config in the normal config order, and thus if
   there's a system hook there's no way to define a local hook to run
   first, until we get some sort of override for that.

> I'm not following why having the log hook set early requires glob
> ordering over config ordering (since the config ordering schema allows
> reordering via replacement)
> [...]
>  and I'm not following why it's required to halt on failure.

I realize I didn't elaborate on this, there's some past discussion[1][2]
about this.=20

I.e. when running N hooks sometimes you'd want to run them all (e.g. to
send notifications), but for others such as pre-receive.d guard checks
you don't have to run all N, if one check (say one checks commit format
validity, another code syntax) fails you'd like to abort early.

So halting on failure is just saving CPU, you might have 10 hooks that
each take 1 second, no point in making the user wait on all 10 checks
for 10 seconds if a failure of any fails the push.

But OTOH you have other use-cases where users want to run them all
(talked about in the [1][2] discussion above), so it's been anticipated
as something we'd grow config for with multi-hook support.

The glob ordering allows common cases for things that aren't possible
with config-order with such early abort.

E.g. consider a server with some common system-wide pre-receive.d hook
(e.g. author e-mail envelope check), and a SOX/PCI controlled repository
where some compliance thing says all push attempts must be logged.

You could then do:

    /etc/git/hooks/pre-receive.d/email-check
    /path/to/repo/hooks/pre-receive.d/000-log-push-attempt-to-db
    /path/to/repo/hooks/pre-receive.d/some-other-check

And we'd always run the 000-* hook first, whereas in the current schema
you can't do that without editing the system-wide config.

>>=20
>> All that being said I'm open to being convinced, I just don't see what
>> the target user is, and the submitted docs don't really make a case for
>> it. I.e. there's plenty of "what" not "why would someone want this...".
>
> ACK. I'll try and go over the doc again before I reroll.
>
>  - Emily

1. https://lore.kernel.org/git/87wojjsv9p.fsf@evledraar.gmail.com/
2. https://public-inbox.org/git/CACBZZX6j6q2DUN_Z-Pnent1u714dVNPFBrL_PiEQyL=
mCzLUVxg@mail.gmail.com/
