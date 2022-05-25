Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904D8C433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 13:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbiEYN0Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 09:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbiEYN0U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 09:26:20 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E111C136
        for <git@vger.kernel.org>; Wed, 25 May 2022 06:26:13 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g20so1456862edj.10
        for <git@vger.kernel.org>; Wed, 25 May 2022 06:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=LUnAepmZT8L1Tc4+xwoexVtbllTrii8WWgkvxEfyAmw=;
        b=bEqswUY+gxvU7uZozh3NWrxjiQ78BoKs5sTmThefFHSv91n+SNSn2/FzDHo7sGOvCV
         hF5upYYAyXntIGD/Gm2Gj5nHYOkAVYGIc3Rq2yQjXb+kBtqD0h2+H65KKgMqf/Gpkw1I
         qs68U/vQ8N9/ADGca+s0UTACrbgzXxp0RULuFJF8L3yU42gGOZ4PtBcP7ZaEBRcxWSBY
         azqa6QPIU1jcdhra4qSZmZhyHz2A29z6pjeYQAwBTaeaNx9EYBaLUVLuMC5JyNydp4Yo
         oQtnqpyIGvZs7Ow4vnnUpWtpyV08eiM6p+eMIF9yV2FvZ4TjoFMevQppuV7uf0U7OzzM
         QUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=LUnAepmZT8L1Tc4+xwoexVtbllTrii8WWgkvxEfyAmw=;
        b=rYXVTs0YgbUtdCgZwjIPc+cL/UnvrFYD6G4zFQ4xs9GPrZIbiQ723CLG6C7L7Mls3j
         5Oh/KFJ0s4iwwvMs380t8MUERI4KjXTBVxT0QJVXzmM5r3TklGKWoXHG8zRpZwUnBtSX
         Ledzuld8lR9IXOfJDOXWNcE9qt3HKMHvAEai+8ZatjeQPAPZQz3X8zH444ae/crTxyJY
         AIKM96sqaWj+k4qzqHgKZCGh8KXg6MR8sHr92BoMWf0GQ6xyqiroMykqDfCCnMzE8HQ8
         BPoRg1BKo8FS2ot0Ktak9SDkQwbeLSPr3H1RaU6yFAUirBhIkzzNEstCAjR4kB27r3gE
         nwTQ==
X-Gm-Message-State: AOAM532MliXP2HUILPmolKRVrZx4UBJfD2TbXMJoMXqy7condLLbrXmO
        gFz4NM9KEhztcUmNMc+wn3M=
X-Google-Smtp-Source: ABdhPJzPtx7xcxlRpecb9aJ77qc9pzC/Ik0WdN5mBgI1E8AqDBoOOVmr+aHHd8eZcifHiSGMjYlECw==
X-Received: by 2002:aa7:ce1a:0:b0:42a:ee9e:17a0 with SMTP id d26-20020aa7ce1a000000b0042aee9e17a0mr34162434edv.34.1653485172194;
        Wed, 25 May 2022 06:26:12 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id 25-20020a17090600d900b006fe0abb00f0sm8045930eji.209.2022.05.25.06.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:26:11 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ntr1e-003oPk-SJ;
        Wed, 25 May 2022 15:26:10 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 0/8] hook API: connect hooks to the TTY again, fixes
 a v2.36.0 regression
Date:   Wed, 25 May 2022 15:00:52 +0200
References: <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com>
        <cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com>
        <nycvar.QRO.7.76.6.2205251308381.352@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <nycvar.QRO.7.76.6.2205251308381.352@tvgsbejvaqbjf.bet>
Message-ID: <220525.86fskxu4jx.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 25 2022, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> as promised in the Git IRC Standup [*1*], a review.
>
> On Wed, 18 May 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (8):
>>   run-command tests: change if/if/... to if/else if/else
>>   run-command API: use "opts" struct for run_processes_parallel{,_tr2}()
>>   run-command tests: test stdout of run_command_parallel()
>>   run-command.c: add an initializer for "struct parallel_processes"
>>   run-command: add an "ungroup" option to run_process_parallel()
>>   hook tests: fix redirection logic error in 96e7225b310
>>   hook API: don't redundantly re-set "no_stdin" and "stdout_to_stderr"
>>   hook API: fix v2.36.0 regression: hooks should be connected to a TTY
>
> I started reviewing the patches individually, but have some higher-level
> concerns that put my per-patch review on hold.
>
> Keeping in mind that the intention is to fix a regression that was
> introduced by way of refactoring (most of our recent regressions seem to
> share that trait [*2*]), I strongly advise against another round of
> refactoring [*3*], especially against tying it to fix a regression.
>
> In this instance, it would be very easy to fix the bug without any
> refactoring. In a nutshell, the manifestation of the bug amplifies this
> part of the commit message of 96e7225b310 (hook: add 'run' subcommand,
> 2021-12-22):
>
>     Some of the implementation here, such as a function being named
>     run_hooks_opt() when it's tasked with running one hook, to using the
>     run_processes_parallel_tr2() API to run with jobs=3D1 is somewhere
>     between a bit odd and and an overkill for the current features of this
>     "hook run" command and the hook.[ch] API.
>
> It is this switch to `run_processes_parallel()` that is the root cause of
> the regression.

Yes, or more generally to the new hook API which makes use of it.

> The current iteration of the patch series does not fix that.

Because the plan is still to continue in this direction and go for
Emily's config-based hooks, which will run in parallel.

And to fix that would at this point be a larger functional change,
because we'd be running with more code we haven't tested before,
i.e. hook.[ch] on some new backend. So just passing down the appropriate
flags to have run-command.[ch] do the right thing for us seemed to be
the least bad option.

> In the commit message from which I quoted, the plan is laid out to
> eventually run more than one hook. If that is still the plan, we will be
> presented with the unfortunate choice to either never running them in
> parallel, or alternatively reintroducing the regression where the hooks
> run detached from stdin/stdout/stderr.

No, because you can have N processes all connected to a terminal with
"ungroup", what you can't do is guarantee that they won't interleave.

But as discussed in some previous threads that would be OK, since that
would come as an opt-in to parallel hook execution. I.e. you could pick
one of:

 1. Current behavior
 2. Our parallel hook execution (whatever "ungroup" etc. settings that enta=
ils)
 3. Your own parallel hook execution

It only matters that we don't regress in #1, for #2 we could have
different behavior, but just document the caveats as such.

IOW it's OK if you run parallel hooks and we decide that they won't be
connected to a terminal, because that's a new feature we don't have yet,
one you'd need to opt into.

> It is pretty clear that there is no actual choice, and the hooks will
> never be able to run in parallel. Therefore, the fix should move
> `run_hooks_opt()` away from calling `run_processes_parallel()`.

They will run in parallel, see above.

> In any case, regression fixes should not be mixed with refactorings unless
> the latter make the former easier, which is not the case here.

I noted upthread/side-thread (in any case, in discussions around this)
that I wished I'd come up with something smaller, but couldn't.

If you want to try your hand at that I'd love to see it.

But basically migrating the hook API to a new "backend" would also be a
large change, so would making the bare minumum change in
run-command.[ch].

But hey, I might be wrong. So if you think it's obvious that this could
be much smaller I'd love to see patches for it...

> Footnote *1*:
> https://colabti.org/irclogger/irclogger_log/git-devel?date=3D2022-05-23#l=
44
>
> Footnote *2*: I say "seem" because it would take a proper retro to analyze
> what was the reason for the uptick in regressions, and even more
> importantly to analyze what we can learn from the experience.

Yes, that might be interesting.

I'll only note that I think you're focusing on the wrong thing here with
"refactorings".

If you look at the history of this hooks API topic it started early on
with a version where the config-based hooks + parallelism (currently not
here yet) were combined with making the existing hook users use the new
API (partially here now).

Now, I suggested that be split up so that we'd first re-implement all
existing hooks on the new API, and *then* perform any feature changes.

Except of course by doing so that alters the nature of those changes in
your definition, I assume, i.e. it goes from a feature series to
"refactorings".

Whereas I think the important thing to optimize for is to make smaller
incremental changes. Here we had a bug, and it's relatively easy to fix
it, it would be much harder if we had a bigger delta in v2.36 with not
only this bug, but some other regressions.

Which isn't hypothetical b.t.w., until 3-4 months ago nobody had seen
that the config-based hooks topic we had kicking around had a severe
performance regression. I found it and Emily & I have been kicking
around a fix for it (mostly off-list).

But if we'd done that we'd have a more broken release, but we also
wouldn't have "refactorings". I.e. the run_parallel API would actually
be used, but we'd have this breakage plus some others.

Anyway, I think there's lots of things we could probably do better in
delivering more reliable software. I'm just pointing out that here that
I think focusing on a part of a larger progression from A..B and saying
that it refactored something as being bad is to make a categorical
mistake. Because a re-doing of that state to make each step not have any
of those would result in larger change deltas.

> Footnote *3*: The refactoring, as Junio suspected, might very well go a
> bit over board. Even if a new variation of the `run_processes_parallel()`
> function that takes a struct should be necessary, it would be easy -- and
> desirable -- to keep the current function signatures unchanged and simply
> turn them into shims that then call the new variant. That would make the
> refactoring much easier to review, and in turn it would make it less
> likely to introduce another regression.

Sure, we could instead add a third variant to it in addition to the two
on "master", instead of unifying them as is done here.

But per the v1 feedback the consensus seemed to be that this was a good
direction, and to the extent that there were objections it was that I
should add the rest of the arguments to the "opts" struct.

But again, I'm fully open to that, I tried that and didn't think the end
result was any simpler to review, but perhaps you'd like to try...
