Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27856C4363D
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 21:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AECAD239CF
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 21:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="liIdRmNw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgIXVyT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 17:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgIXVyT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 17:54:19 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E17EC0613CE
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 14:54:19 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id l126so862466pfd.5
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 14:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ltfr8ADBi3aSfuSKrEqQ6/15Z9Q976vNEcpmIXjNvB0=;
        b=liIdRmNwZUo2Pt8jfdj7vCP8klw0IN2lFMPiCpG4sCw0zZWWg0/Q9HtY6bYzBlfOv4
         eECEdy4ayPjTd4EJLgq4fG8d/l4tK/WZY27fZsU0maIJjSonTVo96OPIs3Zwr0gS+Mmo
         mJN6KuAr/Xw5zntwnQ2ZzshcGRt/IlTyn8Jjd+whNwoTwNVna4fV/5gwaP+gox0JuBAx
         YU28kwXNB8NDWxS9WSWkM0WMVqUzQb7vrFw7tZoIUyJIF5qkWlTsy+dK9+K/n9eRECbb
         tf6r8IrrQ6B6QPhHcD1IYL29LPgFg56OjnoMjyRhdxVM/AY8ykeNL6Q/82fY0ytrAPPM
         MSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ltfr8ADBi3aSfuSKrEqQ6/15Z9Q976vNEcpmIXjNvB0=;
        b=hrGot2yw/iyinVs6T2ON9yeJCxLXx44f/A+zAAjBhPgxhNb+yB/5pYu46+TrJg+s2T
         RAL5sWMSZOc15tF+UIl3NUMZmWkuNxxYoCdW9FXDJL2f90xIf5L/TBtxUKrW/OAarKC7
         n9+avuAbE0nFUfVkC6QS1yCALBpdAbCfRI/2rSDGM5smmoiTki7c6P9AfrNBh4M9H4tp
         9ecxQUP0iXqt5RomtE4BflqkN5MFbJBs3pBUSjhkvRQVJr89Tqqa1T9MInH1A8wx9zMK
         9lZ38nZ7o1Z8xm5IiF1iTSm/LMIta8Yq9B5p5yhs4VZbCy43JPTcue5in3+PuBh/uCL3
         scMw==
X-Gm-Message-State: AOAM533OxIN3MOjqMcS8jnlsg44k+dOuNHKGU//DLX7+VgMeduutdAT7
        Yiy7zILWYK6VpMGviDf6JfWSFg==
X-Google-Smtp-Source: ABdhPJzmfJwRZtyjWBYTW5WLn9CWtdYochheG90aK3DoczrqPWkAu13PQ6SIESMcAHfO30c63WwNBw==
X-Received: by 2002:a63:1a66:: with SMTP id a38mr869258pgm.253.1600984458226;
        Thu, 24 Sep 2020 14:54:18 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id z18sm401977pfn.186.2020.09.24.14.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 14:54:16 -0700 (PDT)
Date:   Thu, 24 Sep 2020 14:54:11 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 1/9] doc: propose hooks managed by the config
Message-ID: <20200924215411.GG331156@google.com>
References: <20200909004939.1942347-2-emilyshaffer@google.com>
 <20200923225910.1276940-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923225910.1276940-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 23, 2020 at 03:59:10PM -0700, Jonathan Tan wrote:
> 
> For this review, I'll just concern myself with overall design and
> structure.

Thanks - the design doc is now slightly old, so it's nice to have some
fresh eyes on it.

> 
> For this patch, overall I think it's better if there's a clear
> distinction between what we are implementing now and what we are
> implementing later.

I took a light hand when I checked for this - the topic isn't complete
yet, and there's some work in the design doc which I want to include in
this topic, but which hasn't been sent around (or written) yet.

> 
> > +[[motivation]]
> > +== Motivation
> > +
> > +Treat hooks as a first-class citizen by replacing the .git/hook/hookname path as
> > +the only source of hooks to execute, in a way which is friendly to users with
> > +multiple repos which have similar needs.
> 
> I don't understand what "first-class citizen" here means - probably
> better to just omit that phrase and describe the new way of doing hooks.

Sure.

> 
> > +[[config-schema-hook]]
> > +==== `hook`
> > +
> > +Primarily contains subsections for each hook event. These order of these
> > +subsections defines the hook command execution order
> 
> The execution order is defined by the order of a multivalue config
> variable, I think, not the order of subsections? Besides, I believe that
> there's one subsection per hook event (e.g. hook."pre-commit"), not one
> subsection per command.

Ok. Have changed to "The order of variables in these subsections
defines..."

> 
> > ; hook commands can be
> > +specified by setting the value directly to the command if no additional
> > +configuration is needed, or by setting the value as the name of a `hookcmd`. If
> > +Git does not find a `hookcmd` whose subsection matches the value of the given
> > +command string, Git will try to execute the string directly. Hooks are executed
> > +by passing the resolved command string to the shell.
> 
> [snip]
> 
> > Hook event subsections can
> > +also contain per-hook-event settings.
> 
> If this is not yet implemented, maybe list under "future work".

Good idea. Done.

> 
> > +
> > +Also contains top-level hook execution settings, for example,
> > +`hook.warnHookDir`, `hook.runHookDir`, or `hook.disableAll`. (These settings are
> > +described more in <<library,Library>>.)
> 
> I think it's clearer if you list this under "future work" - I didn't see
> any implementation of this.

Yeah, this is out of sync with what the implementation ended up looking
like; disableAll might still be a useful thing to include in the initial
feature topic, so I won't remove it, but warnHookDir is not necessary.

> 
> > +[hook "pre-commit"]
> > +  command = perl-linter
> > +  command = /usr/bin/git-secrets --pre-commit
> > +
> > +[hook "pre-applypatch"]
> > +  command = perl-linter
> > +  error = ignore
> 
> Is "error" implemented?

No, have marked it with a comment.

> 
> > +
> > +[hook]
> > +  runHookDir = interactive
> 
> Same question for "runHookDir".

It is in the reroll I'm trying to get out this week :)

> 
> > +[[config-schema-hookcmd]]
> > +==== `hookcmd`
> > +
> > +Defines a hook command and its attributes, which will be used when a hook event
> > +occurs. Unqualified attributes are assumed to apply to this hook during all hook
> > +events, but event-specific attributes can also be supplied. The example runs
> > +`/usr/bin/lint-it --language=perl <args passed by Git>`, but for repos which
> > +include this config, the hook command will be skipped for all events to which
> > +it's normally subscribed _except_ `pre-commit`.
> > +
> > +----
> > +[hookcmd "perl-linter"]
> > +  command = /usr/bin/lint-it --language=perl
> > +  skip = true
> > +  pre-commit-skip = false
> > +----
> 
> And the skips. (And several more below which I will skip.)

Again, this is in the reroll I'm working on.

> 
> > +If the caller wants to do something more complicated, the hook library can also
> > +provide a callback API:
> > +
> > +*`int for_each_hookcmd(const char *hookname, hookcmd_function *cb)`*
> 
> Is there a use case that would need such a function?

I'm not sure yet - but I'm not quite ready to cut it from the design
doc, until I finish migrating the existing hooks and know that it's not
needed. At that point it'll make sense to move it into the future work
section.

> 
> > +[[migration]]
> > +=== Migration path
> > +
> > +[[stage-0]]
> > +==== Stage 0
> > +
> > +Hooks are called by running `run-command.h:find_hook()` with the hookname and
> > +executing the result. The hook library and builtin do not exist. Hooks only
> > +exist as specially named scripts within `.git/hooks/`.
> > +
> > +[[stage-1]]
> > +==== Stage 1
> > +
> > +`git hook list --porcelain <hook-event>` is implemented. Users can replace their
> > +`.git/hooks/<hook-event>` scripts with a trampoline based on `git hook list`'s
> > +output. Modifier commands like `git hook add` and `git hook edit` can be
> > +implemented around this time as well.
> 
> This seems to contradict patch 8, which teaches Git to use the configs
> directly without any change to .git/hooks/<hook-event> (at least for
> certain commit-related hooks).

Yeah, I think this needs to be rephrased; at this point locally I've
completely removed the --porcelain patch - I'm pretty sure it needs to
be a format string instead.

> 
> > +[[future-work]]
> > +== Future work
> > +
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
> > +
> > +Numerical ordering makes it tricky for Git to generate suggested ordering
> > +numbers for each command, but is easy to determine a definitive order.
> 
> With this schema, and with the "skip" behavior described above (but not
> implemented in this patch set), rudimentary ordering can already be
> done; because a hook is removed and reinserted whenever it appears in
> the config, even a hook X in the system config can be made to run after a
> hook Y in the worktree config by adding Y then X in the worktree config,
> and if we want to disable X instead, we can just add "skip" to X.

Yep, that's why reordering is in the future work section :)

The problem with config ordering is like such: if I want everyone in
my enterprise to run 'git-secrets --prepare-commit-msg' as the very last
prepare-commit-msg hook, but I can only ship them an /etc/gitconfig,
then the best I can do is email my users and ask them to run 'git config
hook.prepare-commit-msg.command git-secrets-prepare-commit-msg' in every
new repo and include a 'hookcmd.git-secrets-prepare-commit-msg.command'
config in the /etc/gitconfig I ship. (I mention git-secrets here because
it's possible other hooks could have introduced credential secrets into
my user's commit message after git-secrets already ran.)

 - Emily
