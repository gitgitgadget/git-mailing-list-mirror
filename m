Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCC2C4363D
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 22:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0262C221EB
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 22:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UfMuvQDn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgIWW7Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 18:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIWW7P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 18:59:15 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EA4C0613CE
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 15:59:15 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id q5so560085pfl.16
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 15:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Ht3aqKjLV5sjZZF6ABWmid65NGyy6CbH5sawkZzqxHo=;
        b=UfMuvQDnIUC3oPNBQEupT6IQ3q8LYPaPqBWlgHUBulr9780JFNDYVNHuIBz7Ke7IYr
         h1SvxVLiNG687yrPQHwVwd46/Ba3y+AtW7m+E+VUMvg5PYctKfu3bgSgo7lqdIdqmyPg
         wf/sNyf1NKUtGKR/gumoZAUwKi3L+lU8Vso96s34U4YG4X5jyiMMUvSeDaYxaRLfL7J8
         aDMs+duC1dAWl37G706U68IhsiNQjHhiqN7YlFT9B5e8CtrQKywovm4H7gUpXOwrPxmP
         C9g9O9M98GhQ9MAUg+ykhTpWsZ/25n1+8XCLrozvau6NTeTjjt4LiaqjRr018YeoxB8/
         VpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ht3aqKjLV5sjZZF6ABWmid65NGyy6CbH5sawkZzqxHo=;
        b=ngd9D4tHiNpmuI6pfJDK8gby6WMWST7gJKqLehW5uMZckYeVfW/Vv7F5VeZOAVFXG9
         UWr60S5iPWjXN1b2SuReiGT0caWjZIga2Jp+Q9BjMeWTTiFCCxNayc1SjHKqY2vn7s2N
         nlOMmXuD8p6weB80a97MJXSA1+D8YOT0qZfIAmucvv615HqzpcGX3KtOsKoYYFQiMZDY
         K3S3ZTIXwS4KIfSIMeue+GVlfIh0Se0JdDggsND8C/n1wuYS2QN1LMxmdYL4yIYb5OR3
         A4W6X8uTeXpvOxSTOyoPsJId40+dpDTaMPrFlQvgOX+AOz/VDAMysVfjwahesPh3i8Is
         1D6w==
X-Gm-Message-State: AOAM531zoYlSevI9A4g57dVquBx1hYr4+oQ9D61BroHjKWNhQjGaHawL
        WbNPwPsdylu0zAT2nVABj/IktFoR63+2yzwF1wou
X-Google-Smtp-Source: ABdhPJx3dE9Cjs5kzt886MCygvgPkUR84/RV6ysYR33fU66PA8EoeSzrDGVH2nl2Cu5qY1gfJ2ImXPJ04jmt+jPmAHyy
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:a18:: with SMTP id
 gg24mr1304997pjb.59.1600901954652; Wed, 23 Sep 2020 15:59:14 -0700 (PDT)
Date:   Wed, 23 Sep 2020 15:59:10 -0700
In-Reply-To: <20200909004939.1942347-2-emilyshaffer@google.com>
Message-Id: <20200923225910.1276940-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200909004939.1942347-2-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: Re: [PATCH v4 1/9] doc: propose hooks managed by the config
From:   Jonathan Tan <jonathantanmy@google.com>
To:     emilyshaffer@google.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For this review, I'll just concern myself with overall design and
structure.

For this patch, overall I think it's better if there's a clear
distinction between what we are implementing now and what we are
implementing later.

> +[[motivation]]
> +== Motivation
> +
> +Treat hooks as a first-class citizen by replacing the .git/hook/hookname path as
> +the only source of hooks to execute, in a way which is friendly to users with
> +multiple repos which have similar needs.

I don't understand what "first-class citizen" here means - probably
better to just omit that phrase and describe the new way of doing hooks.

> +[[config-schema-hook]]
> +==== `hook`
> +
> +Primarily contains subsections for each hook event. These order of these
> +subsections defines the hook command execution order

The execution order is defined by the order of a multivalue config
variable, I think, not the order of subsections? Besides, I believe that
there's one subsection per hook event (e.g. hook."pre-commit"), not one
subsection per command.

> ; hook commands can be
> +specified by setting the value directly to the command if no additional
> +configuration is needed, or by setting the value as the name of a `hookcmd`. If
> +Git does not find a `hookcmd` whose subsection matches the value of the given
> +command string, Git will try to execute the string directly. Hooks are executed
> +by passing the resolved command string to the shell.

[snip]

> Hook event subsections can
> +also contain per-hook-event settings.

If this is not yet implemented, maybe list under "future work".

> +
> +Also contains top-level hook execution settings, for example,
> +`hook.warnHookDir`, `hook.runHookDir`, or `hook.disableAll`. (These settings are
> +described more in <<library,Library>>.)

I think it's clearer if you list this under "future work" - I didn't see
any implementation of this.

> +[hook "pre-commit"]
> +  command = perl-linter
> +  command = /usr/bin/git-secrets --pre-commit
> +
> +[hook "pre-applypatch"]
> +  command = perl-linter
> +  error = ignore

Is "error" implemented?

> +
> +[hook]
> +  runHookDir = interactive

Same question for "runHookDir".

> +[[config-schema-hookcmd]]
> +==== `hookcmd`
> +
> +Defines a hook command and its attributes, which will be used when a hook event
> +occurs. Unqualified attributes are assumed to apply to this hook during all hook
> +events, but event-specific attributes can also be supplied. The example runs
> +`/usr/bin/lint-it --language=perl <args passed by Git>`, but for repos which
> +include this config, the hook command will be skipped for all events to which
> +it's normally subscribed _except_ `pre-commit`.
> +
> +----
> +[hookcmd "perl-linter"]
> +  command = /usr/bin/lint-it --language=perl
> +  skip = true
> +  pre-commit-skip = false
> +----

And the skips. (And several more below which I will skip.)

> +If the caller wants to do something more complicated, the hook library can also
> +provide a callback API:
> +
> +*`int for_each_hookcmd(const char *hookname, hookcmd_function *cb)`*

Is there a use case that would need such a function?

> +[[migration]]
> +=== Migration path
> +
> +[[stage-0]]
> +==== Stage 0
> +
> +Hooks are called by running `run-command.h:find_hook()` with the hookname and
> +executing the result. The hook library and builtin do not exist. Hooks only
> +exist as specially named scripts within `.git/hooks/`.
> +
> +[[stage-1]]
> +==== Stage 1
> +
> +`git hook list --porcelain <hook-event>` is implemented. Users can replace their
> +`.git/hooks/<hook-event>` scripts with a trampoline based on `git hook list`'s
> +output. Modifier commands like `git hook add` and `git hook edit` can be
> +implemented around this time as well.

This seems to contradict patch 8, which teaches Git to use the configs
directly without any change to .git/hooks/<hook-event> (at least for
certain commit-related hooks).

> +[[future-work]]
> +== Future work
> +
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
> +
> +Numerical ordering makes it tricky for Git to generate suggested ordering
> +numbers for each command, but is easy to determine a definitive order.

With this schema, and with the "skip" behavior described above (but not
implemented in this patch set), rudimentary ordering can already be
done; because a hook is removed and reinserted whenever it appears in
the config, even a hook X in the system config can be made to run after a
hook Y in the worktree config by adding Y then X in the worktree config,
and if we want to disable X instead, we can just add "skip" to X.
