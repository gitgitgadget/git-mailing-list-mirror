Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73968C433E0
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 20:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DBA3206C3
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 20:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KimF9r4w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733002AbgFIU0n (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 16:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbgFIU0l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jun 2020 16:26:41 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F216C05BD1E
        for <git@vger.kernel.org>; Tue,  9 Jun 2020 13:26:41 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a127so51153pfa.12
        for <git@vger.kernel.org>; Tue, 09 Jun 2020 13:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jrU1PTTIhmbQzM2OnUonYtaG5eoVXIPa/jVygMNP1NY=;
        b=KimF9r4w0N452edXhXRk0sM2SiiZnT4TN/Gj3+G82ohLszMaoMZ9yKOOn5tm7zJO1A
         uWY2+BUqb1pxD6zAqVjh/7P0dzVgKfEDa3dLV1qdBkvmLALk3u9Bop0eCySRvTgdeUe3
         6/aVujPXpIDjbJoxylSL9f0ECrR0eV/UQUbIi2c2AkIvD07eAe2F2NrP4PXZDTHWbrYW
         4yNtUbZb68Z5kRWCDj32SzpRYbgBMacPaDhchGDH1u96vP28Z7mLGkDuxIh7HnZzbnsm
         Mld99CDLcZYVGNNTonsbaD6MGnuTbYKmLTIp6zPRWxWEf6tPIRCJEujElhxwo0vGCiWB
         EnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jrU1PTTIhmbQzM2OnUonYtaG5eoVXIPa/jVygMNP1NY=;
        b=q7p88gNQthGESvBc2b3w0bqZC2ZiQYq2TR1l3oBWso04CDs8PpyBva1v6Sn9IEPMeT
         8W7P4cixCe94JdMQ7Bl80oSlwglYnzXmOl84rfOFTT/kKDGXIGwMZkIZpetLu9mWr45l
         W+COafGhfm6okMPYf0jp4OfCRemCbMdnyrwmCnMS+VJ5ei/tRcEwMEPVThUe54gzrEOy
         SnW2Kov9zofqFw1ft5Pch1vZ5/vkellqaqsnv19B+LqcBgkcd0rr1TlPtzPamH32++9H
         ws2WAVqbROUhzWfMMVspfre/pykYKKYAjXwfmjIFLWZs++CMd996OVUuBmigPrGtuxDI
         6pVQ==
X-Gm-Message-State: AOAM5327pr+9KqyExgdcSma4qokFBrxDtQmA8KdLMJi5u4dAN2sk709U
        LUcgZZPPp7e9XLlGonBWGvM8wk1/noY=
X-Google-Smtp-Source: ABdhPJw6ZSLM5XTJ2IAB6M35xJebGW8bIIQwWHzWRHqgBrdPkXNHSmKkk74KIcXDEcICcwg/pViKVw==
X-Received: by 2002:a65:450d:: with SMTP id n13mr24887778pgq.86.1591734400483;
        Tue, 09 Jun 2020 13:26:40 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id a12sm3313241pjw.35.2020.06.09.13.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 13:26:39 -0700 (PDT)
Date:   Tue, 9 Jun 2020 13:26:35 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/4] doc: propose hooks managed by the config
Message-ID: <20200609202635.GC148632@google.com>
References: <20200521185414.43760-1-emilyshaffer@google.com>
 <20200521185414.43760-2-emilyshaffer@google.com>
 <355b7780-0096-42a9-01df-387ec17cb206@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <355b7780-0096-42a9-01df-387ec17cb206@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 22, 2020 at 11:13:07AM +0100, Phillip Wood wrote:
> 
> Hi Emily
> 
> Thanks for working on this
> 
> On 21/05/2020 19:54, Emily Shaffer wrote:
> > Begin a design document for config-based hooks, managed via git-hook.
> > Focus on an overview of the implementation and motivation for design
> > decisions. Briefly discuss the alternatives considered before this
> > point. Also, attempt to redefine terms to fit into a multihook world.
> > 
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> >  Documentation/Makefile                        |   1 +
> >  .../technical/config-based-hooks.txt          | 320 ++++++++++++++++++
> >  2 files changed, 321 insertions(+)
> >  create mode 100644 Documentation/technical/config-based-hooks.txt
> > 
> > diff --git a/Documentation/Makefile b/Documentation/Makefile
> > index 15d9d04f31..5b21f31d31 100644
> > --- a/Documentation/Makefile
> > +++ b/Documentation/Makefile
> > @@ -80,6 +80,7 @@ SP_ARTICLES += $(API_DOCS)
> >  TECH_DOCS += MyFirstContribution
> >  TECH_DOCS += MyFirstObjectWalk
> >  TECH_DOCS += SubmittingPatches
> > +TECH_DOCS += technical/config-based-hooks
> >  TECH_DOCS += technical/hash-function-transition
> >  TECH_DOCS += technical/http-protocol
> >  TECH_DOCS += technical/index-format
> > diff --git a/Documentation/technical/config-based-hooks.txt b/Documentation/technical/config-based-hooks.txt
> > new file mode 100644
> > index 0000000000..59cdc25a47
> > --- /dev/null
> > +++ b/Documentation/technical/config-based-hooks.txt
> > @@ -0,0 +1,320 @@
> > +Configuration-based hook management
> > +===================================
> > +
> > +== Motivation
> > +
> > +Treat hooks as a first-class citizen by replacing the .git/hook/hookname path as
> > +the only source of hooks to execute, in a way which is friendly to users with
> > +multiple repos which have similar needs.
> > +
> > +Redefine "hook" as an event rather than a single script, allowing users to
> > +perform unrelated actions on a single event.
> > +
> > +Take a step closer to safety when copying zipped Git repositories from untrusted
> > +users.
> 
> Having read through this (admittedly fairly quickly) I'm not sure what
> that step is

Ok, I'll try to clarify it a little here.

> 
> > +
> > +Make it easier for users to discover Git's hook feature and automate their
> > +workflows.
> > +
> > +== User interfaces
> > +
> > +=== Config schema
> > +
> > +Hooks can be introduced by editing the configuration manually. There are two new
> > +sections added, `hook` and `hookcmd`.
> > +
> > +==== `hook`
> > +
> > +Primarily contains subsections for each hook event. These subsections define
> > +hook command execution order;
> 
> May be "The order of these subsections define the hook command execution
> order" ?

Nice. Took it verbatim.

> 
> > hook commands can be specified by passing the
> > +command directly if no additional configuration is needed, or by passing the
> > +name of a `hookcmd`.
> 
> I know what you mean by "passing" but as this section is talking about
> config settings perhaps it should refer to the keys and values.

Sure.

> 
> > If Git does not find a `hookcmd` whose subsection matches
> > +the value of the given command string, Git will try to execute the string
> > +directly. Hooks are executed by passing the resolved command string to the
> > +shell.
> 
> Do we really need to invoke the shell just to split a command-line and
> look up the command in $PATH? If we used split_commandline() in alias.c
> then we could avoid invoking this extra process for each hook command.

I'll want to experiment a little bit with this and figure out what works
best - you may be right, and I could also be wrong about platform
compatibility doing it the way I described. I haven't written this bit
yet - so I'd like to update this section of the design doc when I get to
the implementation, so that it matches.

> 
> > Hook event subsections can also contain per-hook-event settings.
> > +
> > +Also contains top-level hook execution settings, for example,
> > +`hook.warnHookDir`, `hook.runHookDir`, or `hook.disableAll`.
> 
> (see sections ...) ? for the forward references to these settings?

Sure. I think the best way to do this is if I use anchors for all the
sections; this works without me specifying it in Asciidoctor but needs
to be explicitly specified in Asciidoc. So I'll make sure to include
that with the next iteration.

> 
> > +
> > +----
> > +[hook "pre-commit"]
> > +  command = perl-linter
> > +  command = /usr/bin/git-secrets --pre-commit
> > +
> > +[hook "pre-applypatch"]
> > +  command = perl-linter
> > +  error = ignore
> > +
> > +[hook]
> > +  runHookDir = interactive
> > +----
> > +
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
> > +
> > +=== Command-line API
> > +
> > +Users should be able to view, reorder, and create hook commands via the command
> > +line. External tools should be able to view a list of hooks in the correct order
> > +to run.
> > +
> > +*`git hook list <hook-event>`*
> > +
> > +*`git hook list (--system|--global|--local|--worktree)`*
> > +
> > +*`git hook edit <hook-event>`*
> > +
> > +*`git hook add <hook-command> <hook-event> <options...>`*
> > +
> > +=== Hook editor
> > +
> > +The tool which is presented by `git hook edit <hook-command>`. Ideally, this
> > +tool should be easier to use than manually editing the config, and then produce
> > +a concise config afterwards. It may take a form similar to `git rebase
> > +--interactive`.
> 
> rebase -i is not necessarily an exemplar of user interface design, what
> sort of thing do you have in mind?

Thanks for patience on this - I didn't really have a clear idea before
when I wrote the doc because I don't have much expertise in user
interfaces. However, since then I worked with some UX experts here, so
I'll make a better writeup in the next iteration - I've got a much
clearer idea of how that should look, now.

> 
> > +
> > +== Implementation
> > +
> > +=== Library
> > +
> > +`hook.c` and `hook.h` are responsible for interacting with the config files. In
> > +the case when the code generating a hook event doesn't have special concerns
> > +about how to run the hooks, the hook library will provide a basic API to call
> > +all hooks in config order with an `argv_array` provided by the code which
> > +generates the hook event:
> > +
> > +*`int run_hooks(const char *hookname, struct argv_array *args)`*
> > +
> > +This call includes the hook command provided by `run-command.h:find_hook()`;
> > +eventually, this legacy hook will be gated by a config `hook.runHookDir`. The
> > +config is checked against a number of cases:
> > +
> > +- "no": the legacy hook will not be run
> > +- "interactive": Git will prompt the user before running the legacy hook
> > +- "warn": Git will print a warning to stderr before running the legacy hook
> > +- "yes" (default): Git will silently run the legacy hook
> > +
> > +In case this list is expanded in the future, if a value for `hook.runHookDir` is
> > +given which Git does not recognize, Git should discard that config entry. For
> > +example, if "warn" was specified at system level and "junk" was specified at
> > +global level, Git would resolve the value to "warn"; if the only time the config
> > +was set was to "junk", Git would use the default value of "yes".
> > +
> > +If the caller wants to do something more complicated, the hook library can also
> > +provide a callback API:
> > +
> > +*`int for_each_hookcmd(const char *hookname, hookcmd_function *cb)`*
> > +
> > +Finally, to facilitate the builtin, the library will also provide the following
> > +APIs to interact with the config:
> > +
> > +----
> > +int set_hook_commands(const char *hookname, struct string_list *commands,
> > +	enum config_scope scope);
> > +int set_hookcmd(const char *hookcmd, struct hookcmd options);
> > +
> > +int list_hook_commands(const char *hookname, struct string_list *commands);
> > +int list_hooks_in_scope(enum config_scope scope, struct string_list *commands);
> > +----
> > +
> > +`struct hookcmd` is expected to grow in size over time as more functionality is
> > +added to hooks; so that other parts of the code don't need to understand the
> > +config schema, `struct hookcmd` should contain logical values instead of string
> > +pairs.
> > +
> > +----
> > +struct hookcmd {
> > +  const char *name;
> > +  const char *command;
> > +
> > +  /* for illustration only; not planned at present */
> > +  int parallelizable;
> > +  const char *hookcmd_before;
> > +  const char *hookcmd_after;
> > +  enum recovery_action on_fail;
> > +}
> > +----
> > +
> > +=== Builtin
> > +
> > +`builtin/hook.c` is responsible for providing the frontend. It's responsible for
> > +formatting user-provided data and then calling the library API to set the
> > +configs as appropriate. The builtin frontend is not responsible for calling the
> > +config directly, so that other areas of Git can rely on the hook library to
> > +understand the most recent config schema for hooks.
> > +
> > +=== Migration path
> > +
> > +==== Stage 0
> > +
> > +Hooks are called by running `run-command.h:find_hook()` with the hookname and
> > +executing the result. The hook library and builtin do not exist. Hooks only
> > +exist as specially named scripts within `.git/hooks/`.
> > +
> > +==== Stage 1
> > +
> > +`git hook list --porcelain <hook-event>` is implemented. Users can replace their
> > +`.git/hooks/<hook-event>` scripts with a trampoline based on `git hook list`'s
> > +output. Modifier commands like `git hook add` and `git hook edit` can be
> > +implemented around this time as well.
> > +
> > +==== Stage 2
> > +
> > +`hook.h:run_hooks()` is taught to include `run-command.h:find_hook()` at the
> > +end; calls to `find_hook()` are replaced with calls to `run_hooks()`. Users can
> > +opt-in to config-based hooks simply by creating some in their config; otherwise
> > +users should remain unaffected by the change.
> > +
> > +==== Stage 3
> > +
> > +The call to `find_hook()` inside of `run_hooks()` learns to check for a config,
> > +`hook.runHookDir`. Users can opt into managing their hooks completely via the
> > +config this way.
> > +
> > +==== Stage 4
> > +
> > +`.git/hooks` is removed from the template and the hook directory is considered
> > +deprecated. To avoid breaking older repos, the default of `hook.runHookDir` is
> > +not changed, and `find_hook()` is not removed.
> > +
> > +== Caveats
> > +
> > +=== Security and repo config
> > +
> > +Part of the motivation behind this refactor is to mitigate hooks as an attack
> > +vector;footnote:[https://lore.kernel.org/git/20171002234517.GV19555@aiede.mtv.corp.google.com/]
> > +however, as the design stands, users can still provide hooks in the repo-level
> > +config, which is included when a repo is zipped and sent elsewhere.  The
> > +security of the repo-level config is still under discussion; this design
> > +generally assumes the repo-level config is secure, which is not true yet. The
> > +goal is to avoid an overcomplicated design to work around a problem which has
> > +ceased to exist.
> > +
> > +=== Ease of use
> > +
> > +The config schema is nontrivial; that's why it's important for the `git hook`
> > +modifier commands to be usable.
> 
> That's an important point
> 
> > Contributors with UX expertise are encouraged to
> > +share their suggestions.
> > +
> > +== Alternative approaches
> > +
> > +A previous summary of alternatives exists in the
> > +archives.footnote:[https://lore.kernel.org/git/20191116011125.GG22855@google.com]
> > +
> > +=== Status quo
> > +
> > +Today users can implement multihooks themselves by using a "trampoline script"
> > +as their hook, and pointing that script to a directory or list of other scripts
> > +they wish to run.
> > +
> > +=== Hook directories
> > +
> > +Other contributors have suggested Git learn about the existence of a directory
> > +such as `.git/hooks/<hookname>.d` and execute those hooks in alphabetical order.
> > +
> > +=== Comparison table
> > +
> > +.Comparison of alternatives
> > +|===
> > +|Feature |Config-based hooks |Hook directories |Status quo
> > +
> > +|Supports multiple hooks
> > +|Natively
> > +|Natively
> > +|With user effort
> > +
> > +|Safer for zipped repos
> > +|A little
> > +|No
> > +|No
> > +
> > +|Previous hooks just work
> > +|If configured
> > +|Yes
> > +|Yes
> > +
> > +|Can install one hook to many repos
> > +|Yes
> > +|No
> > +|No
> > +
> > +|Discoverability
> > +|Better (in `git help git`)
> > +|Same as before
> > +|Same as before
> > +
> > +|Hard to run unexpected hook
> > +|If configured
> > +|No
> > +|No
> > +|===
> > +
> > +== Future work
> > +
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
> > +
> > +=== Parallelization
> > +
> > +Users with many hooks might want to run them simultaneously, if the hooks don't
> > +modify state; if one hook depends on another's output, then users will want to
> > +specify those dependencies. If we decide to solve this problem, we may want to
> > +look to modern build systems for inspiration on how to manage dependencies and
> > +parallel tasks.
> > +
> > +=== Securing hookdir hooks
> > +
> > +With the design as written in this doc, it's still possible for a malicious user
> > +to modify `.git/config` to include `hook.pre-receive.command = rm -rf /`, then
> > +zip their repo and send it to another user. It may be necessary to teach Git to
> > +only allow one-line hooks like this if they were configured outside of the local
> > +scope;
> 
> Does "disabling one-line hooks" mean "disable passing command line
> arguments to the hook"? I'm not sure that gains much security - can't I
> just set 'hook.pre-receive.command = ./delete-everything' and include
> delete-everything in my malicious repo?

No, I meant something more along the lines of:

- hookcmds cannot be specified at the repo/worktree level
- hook.pre-receive.command's value *must* be a hookcmd name

I'll try to make that more clear next round.

Thanks for reading.
 - Emily

> > or another approach, like a list of safe projects, might be useful. It
> > +may also be sufficient (or at least useful) to teach a `hook.disableAll` config
> > +or similar flag to the Git executable.
> > +
> > +=== Submodule inheritance
> > +
> > +It's possible some submodules may want to run the identical set of hooks that
> > +their superrepo runs. While a globally-configured hook set is helpful, it's not
> > +a great solution for users who have multiple repos-with-submodules under the
> > +same user. It would be useful for submodules to learn how to run hooks from
> > +their superrepo's config, or inherit that hook setting.
> > +
> > +== Glossary
> > +
> > +*hook event*
> > +
> > +A point during Git's execution where user scripts may be run, for example,
> > +_prepare-commit-msg_ or _pre-push_.
> > +
> > +*hook command*
> > +
> > +A user script or executable which will be run on one or more hook events.
> > 
> 
