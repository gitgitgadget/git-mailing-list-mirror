Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF37C4363C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 09:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 274E52080A
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 09:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXQgPo0U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgJGJXP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 05:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbgJGJXP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 05:23:15 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE3AC061755
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 02:23:14 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id l17so1382148edq.12
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 02:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=0l8eazWgAngmn+Y2yrq+Hr1FKYRx9n5s/1cPqX3m5YQ=;
        b=dXQgPo0UamEu0mKHyr94xAcUzlhxQBGD0zsn3/NLFCPyzDwK7NBuwLBBezhe6d2SkK
         5jSWV0t5mTe8D/iRsOpnrasJP6yQL2do5gPbpkPPbMHprLXT8l9KVgONJ4YAittd4+mD
         xb+0/BYHrYOhIVGVdmkdvd1WJZbNBw47JDVlgfnSwtdUGpTp8rZ+eFnLd207VP8c/pRH
         FBAHe8dt7AXbQwVa7rYF/euXtCJYkCHgUde9E5iGAU9HqIa+Sznqo3US5NENLLjdxcxE
         E5dkjZOAQjkyTbqLEuqUPIYv23c0T6rK5n+l6dHYgyYX8VnQzzC1r65Y5o3exRFICB/G
         U6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=0l8eazWgAngmn+Y2yrq+Hr1FKYRx9n5s/1cPqX3m5YQ=;
        b=jyPPN++EEqJ9B6JULuoZEC3L54H+tBiN0jViBYeoNiet6Z9pdFX0NhlvmH1qMTC2lC
         WleQ0mHjQbNnlGCPre/XydEVJ86x723dGkBNxpZjJoX+RfgnUyxxd6fjJSogirQMplqt
         ZnqxiTE6undWHoFEor/V/nOLVC6J4/cgRTF4QFzXK4eKcwnWfimtqVFHQrZ6MC/I7h9U
         pNjhTfuVK2w1vQ8EWABG9MdxZphybbXG4JTBMPUfYJYJpiJ+4J9gQJuGA9yDIl32HzqZ
         XEwRHUZGO/WsWcEYKSlSIk4BwH3IXkHxRM45tLyzYtiiiOELkCdYoUXjmJWC7QV2a9Fv
         HKoQ==
X-Gm-Message-State: AOAM533A7EB9/2A0hkYPn82LrZUltao6mBFLjk+r9ZaRBLg/NORmg/RO
        Uex/j3LYimh6gHD0Ck7qa/qugw/hlPn1hg==
X-Google-Smtp-Source: ABdhPJxPlqolynsIaEgmzReQGi4qo0FPHBBY6W493RGpDCfbxh6NlJ6559Df8RGUbLrhrosBQj2LkA==
X-Received: by 2002:aa7:dcc2:: with SMTP id w2mr2530553edu.121.1602062592047;
        Wed, 07 Oct 2020 02:23:12 -0700 (PDT)
Received: from evledraar (dhcp-077-248-252-018.chello.nl. [77.248.252.18])
        by smtp.gmail.com with ESMTPSA id i14sm1104161ejp.2.2020.10.07.02.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 02:23:11 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 1/9] doc: propose hooks managed by the config
References: <20200909004939.1942347-1-emilyshaffer@google.com> <20200909004939.1942347-2-emilyshaffer@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <20200909004939.1942347-2-emilyshaffer@google.com>
Date:   Wed, 07 Oct 2020 11:23:10 +0200
Message-ID: <87mu0ygzk1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 09 2020, Emily Shaffer wrote:

First, thanks a lot for working on this. As you may have found I've done
some small amount of actual work in this area before, but mostly just
blathered about it on the ML.

> Begin a design document for config-based hooks, managed via git-hook.
> Focus on an overview of the implementation and motivation for design
> decisions. Briefly discuss the alternatives considered before this
> point. Also, attempt to redefine terms to fit into a multihook world.
> [...]
> +[[status-quo]]
> +=== Status quo
> +
> +Today users can implement multihooks themselves by using a "trampoline script"
> +as their hook, and pointing that script to a directory or list of other scripts
> +they wish to run.

...or by setting core.hooksPath in their local/global/system
config. Granted it doesn't cover the malicious hook injection case
you're also trying to solve, but does address e.g. having a git server
with a lot of centralized hooks.

The "trampoline script" also isn't needed for the common case you
mention, you just symlink the .git/hooks directory (as e.g. GitLab
does). People usually use a trampoline script for e.g. using GNU
parallel or something to execute N hooks.


> +[[hook-directories]]
> +=== Hook directories
> +
> +Other contributors have suggested Git learn about the existence of a directory
> +such as `.git/hooks/<hookname>.d` and execute those hooks in alphabetical order.

...which seems like an easy thing to add later by having a "hookdir" in
addition to "hookcmd", i.e. just specify a glob there instead of a
cmd/path.

You already use "hookdir" for something else though, so that's a bit
confusing, perhaps s/hookcmd/definehookcmd/ would be less confusing, or
perhaps more confusing...

> [...]
> +[[execution-ordering]]
> +=== Execution ordering
> +
> +We may find that config order is insufficient for some users; for example,
> +config order makes it difficult to add a new hook to the system or global config
> +which runs at the end of the hook list. A new ordering schema should be:
> +
> +1) Specified by a `hook.order` config, so that users will not unexpectedly see
> +their order change;
> +
> +2) Either dependency or numerically based.
> +
> +Dependency-based ordering is prone to classic linked-list problems, like a
> +cycles and handling of missing dependencies. But, it paves the way for enabling
> +parallelization if some tasks truly depend on others.
>
> +Numerical ordering makes it tricky for Git to generate suggested ordering
> +numbers for each command, but is easy to determine a definitive order.
> +
> +[[parallelization]]
> +=== Parallelization
> +
> +Users with many hooks might want to run them simultaneously, if the hooks don't
> +modify state; if one hook depends on another's output, then users will want to
> +specify those dependencies. If we decide to solve this problem, we may want to
> +look to modern build systems for inspiration on how to manage dependencies and
> +parallel tasks.

If you're taking requests it would make me very happy if we had
parallelism in this from day one. It's the kind of thing that's hard to
do by default once a feature is shipped since people will implicitly
depend on it not being there, i.e. we won't know what we're breaking.

I think doing it this way is simple, covers most use cases, and solves a
lot of the problems you note:

1. Don't use config order to execute hooks, use glob'd name order
   regardless of origin. I.e. a system-level hook is called "001-first"
   is executed before a local hook called "999-at-the-end" (or the other
   way around, i.e. hook origin doesn't matter).

2. We execute hooks parallel in that glob order, i.e. a pthread for-loop
   that starts the 001-first task first, eventually getting to
   999-at-the-end N at a time. I.e. the same as:

       parallel --jobs N --halt-on-error soon,fail=1" ::: <hooks-in-glob-order>

   This allows for parallelism but guarantees the very useful case of
   having a global log hook being guaranteed to execute.

3. A hook can define "parallel=no" in its config. We'll then run it
   while no other hook is running.

4. We don't attempt to do dependencies etc, if you need that sort of
   complexity you can just make one of the hooks be a hook runner as
   users do now for the common "make it parallel" case.

It's a relatively small change to the code you have already. I.e. the
for_each() in run_hooks() would be called N times for each continuous
glob'd parallel/non-parallel segment, and hook_list()'s config parsing
would learn to spew those out as a list-of-lists.

This also gives you a rudimentary implementation of the dependency
schema you proposed for free. I.e. a definition of (pseudocode):

    hookcmd=000-first
    parallel=no

    hookcmd=250-middle-abc
    hookcmd=250-middle-xyz

    hookcmd=300-gather
    parallel=no

    hookcmd=999-the-end

Would result in the pseudocode execution of;

    segments=[[000-first],
              [250-middle-abc, 250-middle-xyz],
              [300-gather],
              [999-the-end]]
    for each s in segments:
        ok = run_in_parallel(s)
        last if !ok # or, depending on "early exit?" config

I.e.:

 * The common case of people adding N hooks won't take sum(N) time.

 * parallel=no hooks aren't run in parallel with other non-parallel
   hooks

 * We support a rudimentary dependency schema as a side-effect,
   i.e. defining 300-gather as non-parallel allows it to act as the sole
   "reduce" step in a map/reduce in a "map" step started with the 250-*
   hooks.

> +[[securing-hookdir-hooks]]
> +=== Securing hookdir hooks
> +
> +With the design as written in this doc, it's still possible for a malicious user
> +to modify `.git/config` to include `hook.pre-receive.command = rm -rf /`, then
> +zip their repo and send it to another user. It may be necessary to teach Git to
> +only allow inlined hooks like this if they were configured outside of the local
> +scope (in other words, only run hookcmds, and only allow hookcmds to be
> +configured in global or system scope); or another approach, like a list of safe
> +projects, might be useful. It may also be sufficient (or at least useful) to
> +teach a `hook.disableAll` config or similar flag to the Git executable.

I think this part of the doc should note a bit of the context in
https://lore.kernel.org/git/20171002234517.GV19555@aiede.mtv.corp.google.com/

I.e. even if we get a 100% secure hook implementation we've done
practically nothing for overall security, since we'll still run the
pager, aliases etc. from that local repo.

This is a great step in the right direction, but it behooves us to note
that, so some user reading this documentation without context doesn't
think inspecting untrusted repositories like that is safe just because
they set the right hook settings in their config (once what's being
proposed here is implemented).
