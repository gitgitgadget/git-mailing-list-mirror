Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11356C433ED
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 01:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7BCD61207
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 01:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbhDXBix (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 21:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbhDXBiw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 21:38:52 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D809C061574
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 18:38:13 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id f195-20020a1c1fcc0000b029012eb88126d7so2104856wmf.3
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 18:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jCuL5QeJQCsQndw1QkYIxidZBEaBT/iT7FByryK6L8w=;
        b=UR4rxm4s6YHLsQURq0nEqrhT2iCmP1yN7svEMIV4PowqScR0MSUA9UQevQKEQcGy1Q
         JDtkCcQN7A0My+yImApBjgVl2sReMEg90bXjn2Wp//3PXTWxfdnTTfm4TnIvPt4mbQ7q
         sjruj8zQVukrObIX4BPXQGP4ZrjfhRIYAzNkQOjwCAupR5/mUGfe51mSCuDMRkJoHPUu
         OMJCd/7Mg56m+WuVDen/qQBCF1BKz+FhfqNbHQJeDrA+RXwKQOBdpaWulQHATEsEW7Ng
         gGsirSDzWXM+QovVv8uJRQAQGJLg6e9cXdhBbr4XLDjyVeIfMpfoFhZRh+S9fi5Pk4Kh
         R56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jCuL5QeJQCsQndw1QkYIxidZBEaBT/iT7FByryK6L8w=;
        b=O1eSenUIxtkJM8g2njeFuAKTg/tpPeO6mmkOH27Z+xXPaQ3Nklj/XMIm+0MD6qiiGC
         vcuycnjg+2YVYMUgNSXKGh8JGJBRsFqFEw27TDZZNO3YKiFpxk29XQNGt8qDEONc2RAk
         PqXNNNQc5eUKct9e/gEFAKNrA5MOGdXkLM1QqKwVryDYiiBczB8/BY40cyAG1tPSjSwE
         RF16w75wZy8TQVGHdSuLp2j1zOuFzPDw/cHvYSPFRDRs6Rj8zVkQ/0fKE17xZ05th/Lv
         hXjP/VRefRI62Cyt5Hw5rj55NaW42XbRnU7LQZnklzSDN5N+b5RxEwSEal79SYiaey6+
         9F8g==
X-Gm-Message-State: AOAM532ccLdwHwshAZY9oTr94NVda/fot/MDU0RRGdDuKaSx9BvTa6hW
        R5Fs8BvEQN3yVlt4UNAccn9JwylAFnI=
X-Google-Smtp-Source: ABdhPJw9BHZAKLrJiLfmHz7cE3hngIXgKaPUJnuTJ1wo2tdw0/OjRjmoU2ZYcVpGctblJGDbgRyo/g==
X-Received: by 2002:a7b:c348:: with SMTP id l8mr8634306wmj.152.1619228291722;
        Fri, 23 Apr 2021 18:38:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a15sm11015255wrr.53.2021.04.23.18.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 18:38:11 -0700 (PDT)
Message-Id: <pull.908.v3.git.1619228290023.gitgitgadget@gmail.com>
In-Reply-To: <pull.908.v2.git.1616723016659.gitgitgadget@gmail.com>
References: <pull.908.v2.git.1616723016659.gitgitgadget@gmail.com>
From:   "Albert Cui via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 24 Apr 2021 01:38:09 +0000
Subject: [PATCH v3] hooks: propose project configured hooks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Albert Cui <albertqcui@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Ed Maste <emaste@freebsd.org>,
        Albert Cui <albertqcui@gmail.com>,
        Albert Cui <albertqcui@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Albert Cui <albertqcui@gmail.com>

Hooks today are configured at the repository level, making it difficult to
share hooks across repositories. Configuration-based hook management, by
moving hooks configuration to the config, makes this much easier. However,
there is still no good way for project maintainers to encourage or enforce
adoption of specific hook commands on specific hook events in a repository.
As such, there are many tools that provide this functionality on top of Git.

This patch documents the requirements we propose for this feature as well as
a design sketch for implementation.

Signed-off-by: Albert Cui <albertqcui@gmail.com>
Helped-by: Emily Shaffer <emilyshaffer@google.com>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
---
    [RFC] hooks: propose project configured hooks
    
    V3:
    
     * Add more motivation for feature
     * Formalize security threat model
     * Remove references to clone-time installation
     * Update requirements for when advice should appear, config location
     * Update UX examples
     * Suggest auto-update hooks behind config
    
    Signed-off-by: Albert Cui albertqcui@gmail.com Helped-by: Emily Shaffer
    emilyshaffer@google.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-908%2Falbertcui%2Fhooks-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-908/albertcui/hooks-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/908

Range-diff vs v2:

 1:  473e14edd441 ! 1:  e8fbcc060c71 hooks: propose project configured hooks
     @@ Commit message
      
          Signed-off-by: Albert Cui <albertqcui@gmail.com>
          Helped-by: Emily Shaffer <emilyshaffer@google.com>
     -    Change-Id: I5f6747524b97c51dfe5fa28e48ea03981b2da5b8
     +    Helped-by: Jonathan Nieder <jrnieder@gmail.com>
      
       ## Documentation/Makefile ##
      @@ Documentation/Makefile: TECH_DOCS += technical/protocol-common
     @@ Documentation/technical/project-configured-hooks.txt (new)
      +Project Configured Hooks
      +------------------------
      +
     ++// The '+' in Gerrit URL frightens asciidoctor.
     ++:chrome-os: https://chromium.googlesource.com/chromiumos/docs/+/HEAD/contributing.md#Upload-changes
     ++:repohook-read: https://android.googlesource.com/platform/tools/repohooks/+/refs/heads/master/rh/config.py
     ++:repohook-config: https://android.googlesource.com/platform/tools/repohooks/+/refs/heads/master#config-files
     ++
      +Background
      +~~~~~~~~~~
      +
      +Context
      +^^^^^^^
      +
     -+Git has https://git-scm.com/docs/githooks[hooks] functionality to allow users to
     ++Git has linkgit:githooks[hooks] functionality to allow users to
      +execute commands or scripts when certain Git events occur. Some use cases
      +include:
      +
     @@ Documentation/technical/project-configured-hooks.txt (new)
      +https://lore.kernel.org/git/20210311021037.3001235-2-emilyshaffer@google.com[Configuration-based
      +hook management], by moving hooks to the config, makes this easier; individuals
      +can at least configure hooks to be used across multiple workspaces on their
     -+host. However, there is still no good way for project maintainers to encourage
     -+or enforce adoption of specific hook commands on specific hook events in a
     -+clone. As such, there are many tools that provide this functionality on top of
     -+Git (see <<prior-art, Prior Art>>).
     ++host.
     ++
     ++However, there is still no good way for project maintainers to encourage or
     ++enforce adoption of specific hook commands on specific hook events in a clone.
     ++As such, there are many tools that provide this functionality on top of Git (see
     ++<<prior-art, Prior Art>>) with a lot of adoption across projects big and small:
     ++
     ++  * According to it's GitHub page, Husky has 22M million monthly downloads and is
     ++used by 437K projects.
     ++
     ++  * Example open source projects that depend on this type of behavior include
     ++  https://android.googlesource.com/platform/tools/repohooks/[the Android Open
     ++  Source Project], {chrome-os}[ChromeOS],
     ++  https://github.com/angular/angular/tree/master/.husky[Angular], and
     ++  https://github.com/webpack/webpack/tree/master/.husky[Webpack].
     ++
     ++The wide adoption of solutions combined with the fragmentation in solution
     ++adoption speaks to the opportunity for the Git project to provide a standard
     ++solution to Git users. In doing so, we can provide a secure, well-supported,
     ++well-maintained, and better functioning solution (e.g. does not require extra
     ++dependencies) that benefits all Git users.
      +
      +We propose adding native Git functionality to allow project maintainers to
      +specify hooks that a user ought to install and utilize in their development
     @@ Documentation/technical/project-configured-hooks.txt (new)
      +
      +A large motivation for this change is providing projects a method to enable
      +local checks of code e.g. linting. As documented in
     -+https://git-scm.com/docs/gitfaq#_hooks[gitfaq], in some cases, server-side
     ++linkgit:gitfaq#_hooks[gitfaq], in some cases, server-side
      +checks may be more appropriate, especially since developers can always skip
      +local hook execution. We think there are still benefits to local checks:
      +
     @@ Documentation/technical/project-configured-hooks.txt (new)
      +hooks to run at least before proposing code for submission to the central
      +repository to increase the chances of the code getting accepted.
      +
     -+In the ideal world, developers and project maintainers use both local and server
     -+side checks in their workflow. However, for many smaller projects, this may not
     -+be possible: CI may be too expensive to run or configure. The number of local
     -+solutions to this use case speaks to this need (see <<prior-art, Prior Art>>).
     -+Bringing this natively to Git can give all these developers a well-supported,
     -+secure implementation opposed to the fragmentation we see today.
     ++In the ideal world, developers and project maintainers use both local and
     ++server-side checks in their workflow. However, for many smaller projects, this
     ++may not be possible: server-side checks may be too expensive, either monetarily
     ++or in terms of time investment, to run. The number of local solutions to this
     ++use case speaks to this need (see <<prior-art, Prior Art>>). Bringing this
     ++natively to Git can give all these developers a well-supported, secure
     ++implementation opposed to the fragmentation we see today.
      +
      +User Goals / Critical User Journeys
      +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
     @@ Documentation/technical/project-configured-hooks.txt (new)
      +
      +    ** I want to skip hooks from running (for various reasons).
      +
     -+Security Considerations and Design Principles
     -+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     ++Security Threat Model
     ++~~~~~~~~~~~~~~~~~~~~~
     ++
     ++==== Principles
     ++
     ++1. It is unreasonable to require users to audit hook code themselves.
     ++
     ++    * Users do not have time
     ++    * Users, in general, are unfamiliar with system exploits / security
     ++    * Users may be unfamiliar with a hook’s implementation language
     ++    * Hooks may be compiled binaries and unauditable
     ++
     ++2. It is reasonable for users to make a trust decision based on where a hook comes from.
     ++
     ++    * Society functions on the basis of trust relationships formed between different
     ++    agents --- this is the basis for being able to accomplish more than one person
     ++    can personally accomplish. The complexity is giving users the power to make that
     ++    trust decision.
     ++    * Git users are already making trust decisions based on repository origin.
     ++
     ++==== Happy Path
     ++
     ++* User clones repository
     ++
     ++    ** Clone occurs over a secure transport (HTTPS / SSH)
     ++
     ++* After clone, repository suggests hooks to the user
     ++
     ++    ** User receives a non-interactive message advertising hooks available to
     ++    install
     ++
     ++    ** User can see what hooks and commands are being suggested and from what
     ++    remote.
     ++
     ++* User evaluates the hook's purpose and publisher and decides whether to install
     ++it
     ++
     ++    ** Installation happens through a separate command the user runs, not an
     ++    interactive prompt.
     ++
     ++* [Minimum Feature] A repository owner can update a hook, at which point users who have
     ++installed it can decide whether to upgrade or uninstall it
     ++
     ++    ** This avoids having to define in the first round of this feature whether
     ++    the hook's purpose and publisher have changed little enough to reuse the
     ++    user's previous consent.
      +
     -+We must balance the desire to make hooks setup easy for developers --- allowing
     -+them to get hooks set up with low friction, and hence increasing the probability
     -+of them adopting these hooks --- with protecting users from the security risks
     -+of arbitrary code execution on their hosts.
     ++    ** A good enhancement soon after would be to allow users to indicate at hook
     ++    installation time that they want to accept all updates of this same hook
     ++    from the same origin.
      +
     -+To inform the design, we propose these design principles:
     ++==== In-Scope Threats
      +
     -+* User consent: Users must explicitly agree to hooks usage; no hooks should
     -+execute without consent, and users should re-consent if hooks update. Users can
     -+opt-out of hooks.
     ++1. Repository owner changes hooks frequently to coax user into accidentally or
     ++mindlessly agreeing to install malicious hooks (“please make this prompt go
     ++away,” “why are you bothering me?”). Mitigation:
      +
     -+* Trust comes from the central repository:
     -+  ** Most users don't have the time or expertise to properly audit every hook
     -+  and what it does. There must be trust between the user and the remote that the
     -+  code came from, and the Git project should ensure trust to the degree it can
     -+  e.g. enforce HTTPS for its integrity guarantees.
     ++    ** Never interactively prompt for hook installation
      +
     -+  ** Since developers will likely build their local clone in their development
     -+  process, at some point, arbitrary code from the repository will be executed.
     -+  In this sense, hooks _with user consent_ do not introduce a new attack surface.
     ++    ** Advertise hooks up front instead of waiting until hooks are about to
     ++    execute. Up front, the user's intent is to set up their workspace so the
     ++    install message is relevant to them; when the user is in the middle of
     ++    another action, they are more likely to blindly agree.
      +
     -+* Give users visibility: Git must allow users to make informed decisions. This
     -+means surfacing essential information to the user in a visible manner e.g. what
     -+remotes the hooks are coming from, whether the hooks have changed in the latest
     -+checkout.
     ++    ** Give users an easy way to disable all advertisements for hooks
     ++
     ++2. Adversary intercepts requests for a repository and inserts malicious hooks
     ++(person-in-the-middle-type attacks). Mitigation:
     ++
     ++    ** Only receive hooks suggestions over HTTPS / SSH
     ++
     ++    ** Include the hook origin (domain name) in the command to install a hook
     ++
     ++3. Malicious repository owner convinces user, who does not intend to run any
     ++other git commands in the repository after clone, to install hooks. Mitigation:
     ++
     ++    ** Do not automatically install hooks on a normal `git clone`
     ++
     ++    ** Do not interactively prompt to install hooks after the clone is finished.
     ++
     ++4. Adversary exploits an old security issue with a hook that has since been
     ++patched. Mitigation:
     ++
     ++    ** Allow users to opt-into hooks getting auto-updated
     ++
     ++==== Out-of-Scope Threats
     ++
     ++1. Repository owner convinces a user who already intends to build code in the
     ++repository to knowingly and explicitly agree to install hooks. Justification:
     ++
     ++    ** This is equivalent (in terms of attack surface) to setting up your
     ++    dependencies / building the source code, and thus is not a new attack
     ++    surface.
     ++
     ++2. Typosquatting - user clones from a repository they think they trust but it
     ++isn’t really the right one. Justification:
     ++
     ++    ** Existing problem
     ++
     ++3. https://github.com/greatsuspender/thegreatsuspender/issues/1263[Malicious new
     ++maintainer] of the project creates malicious hooks. Justification:
     ++
     ++    ** Similar problem to #1 - maintainer could have instead updated build
     ++    files.
     ++
     ++    ** In the case for auto-updating hooks, updated hooks wouldn’t execute until
     ++    the user has issued commands in the repository.
      +
      +Feature Requirements
      +~~~~~~~~~~~~~~~~~~~~
     @@ Documentation/technical/project-configured-hooks.txt (new)
      +Minimum Feature Set
      +^^^^^^^^^^^^^^^^^^^
      +
     -+* A repository can specify a configuration for what hook commands are
     -+enabled for what hook events
     ++* A central repository can specify a recommended configuration for what hook
     ++commands are enabled for what hook events
     ++
     ++    * The suggested configuration should be equivalent to what a user could
     ++    manually install using config-based hooks.
      +
     -+* A repository can specify, in this configuration, where the hook
     -+commands reside
     ++* The configuration specifies where the hook commands reside
      +
      +    ** This could be a path to a script/binary within the repository
      +
     @@ Documentation/technical/project-configured-hooks.txt (new)
      +    ** This could be a user installed command or script/binary that exists
      +    outside of the repository and is present in `$PATH`
      +
     -+* This configuration should only apply if it was received over HTTPS
     ++* The configuration should only apply if it was received over a secure channel
     ++(HTTPS, SSH)
      +
     -+* A setup command for users to set up hooks
     ++* The configuration lives outside the worktree.
      +
     -+    ** Hook setup could happen at clone time assuming the user has consented
     -+    e.g. if `--setup-hooks` is passed to `git clone`
     ++    ** Allows updated hooks to apply across history and branches, reducing
     ++    the maintenance burden of keeping hooks updated.
      +
     -+* Users must explicitly approve hooks at least once
     ++    ** Allows different remotes to specify different configuration. This is
     ++    useful for public vs private central repositories or for repositories which
     ++    support different Git functionality.
      +
     -+    ** Running the setup command should count as approval, including if the user
     -+    consented during the clone
     ++* The user receives advice to install hooks.
      +
     -+    ** When a hook command changes, a user should re-approve execution (note:
     -+    implementation should not interfere with requirement listed in “Fast
     -+    Follows")
     ++    ** The advice should clearly indicate the suggested hook command(s) and hook
     ++    event(s) as well as the central repository that is suggesting them (via
     ++    remote URL).
      +
     -+* Automation is able to continue to use clone and other commands
     -+non-interactively
     ++    ** The user should be able to use configuration to turn off this advice.
     ++
     ++    ** The advice should appear at the following times:
     ++
     ++        *** After a clone
     ++
     ++        *** After a suggested hook would have run if not already installed. The
     ++        advice should include commands for installing the hook and invoking it.
     ++        For example, for a hook on 'git commit', the user should receive advice
     ++        to amend their commit after hook installation.
     ++
     ++* If, after fetch, the central repository suggests new or updated hooks, the
     ++user should receive advice to install these new hooks (note: implementation
     ++should not interfere with requirement listed in“Fast Follows")
      +
      +* Works across Windows/Linux/macOS
      +
      +Fast Follows
      +^^^^^^^^^^^^
      +
     -+* When prompted to execute a hook, users can specify always or never, even if
     -+the hook updates
     ++* Behind configuration, a user can opt to automatically install hook updates
     ++from a given remote.
      +
      +Nice to Haves
      +^^^^^^^^^^^^^
     @@ Documentation/technical/project-configured-hooks.txt (new)
      +
      +* Ensuring the user has installed software that isn't distributed with the repo
      +
     -+Implementation Exploration: Check "magic" branch for configs at fetch time
     -+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     -+
      +Example User Experience
     -+^^^^^^^^^^^^^^^^^^^^^^^
     -+
     -+===== Case 1: Consent through clone
     -+
     -+....
     -+$ git clone --setup-hooks
     -+...
     -+
     -+The following hooks were installed from remote `origin` ($ORIGIN_URL):
     ++~~~~~~~~~~~~~~~~~~~~~~~
      +
     -+pre-commit: git-secrets --pre_commit_hook
     -+pre-push:  $GIT_ROOT/pre_push.sh
     -+....
     -+
     -+===== Case 2: Prompting after clone
     ++==== Example 1: Suggestion to install after clone
      +....
     -+$ git clone
     ++$ git clone $ORIGIN_URL
      +...
      +
     -+Remote `origin` ($ORIGIN_URL) suggest installing the following hooks:
     -+
     ++Remote `origin` ($ORIGIN_URL) suggests the following hooks:
      +pre-commit: git-secrets --pre_commit_hook
      +pre-push:  $GIT_ROOT/pre_push.sh
      +
     -+# instead of prompting, we could give users commands to run instead
     -+# see case 3
     -+
     -+Do you wish to install them?
     -+1. Yes (this time)
     -+2. Yes (always from origin)
     -+3. No (not this time)
     -+4. No (never)
     ++If you wish to install them, run `git hook setup origin`.
     ++To always ignore hooks from `origin`, run `git hook ignore origin`.
      +....
      +
     -+===== Case 3: Re-prompting when hooks change
     ++==== Example 2: Altering when suggested hooks change
      +....
     -+$ git pull
     ++$ git pull origin
      +
      +The following hooks were updated from remote `origin` ($ORIGIN_URL):
      +
      +pre-push:  $GIT_ROOT/pre_push.sh
      +
      +If you wish to install them, run `git hook setup origin`.
     -+
     -+If you wish to always accept hooks from `origin`, run `git hook setup --always
     -+origin`. You should only do this if you trust code changes from origin.
     -+
      +To always ignore hooks from `origin`, run `git hook ignore origin`.
      +....
      +
     -+===== Case 4: Nudging when hooks weren't installed
     ++==== Example 3: Nudging when hooks weren't installed
      +....
      +$ git commit
     -+advice: The repository owner has recommended a 'pre-commit' hook that was not run.
     -+To view it, run `git show origin/refs/recommended-config:some-pre-commit`. To install it, run `git hook setup origin pre-commit`
     ++
     ++advice: The repository owner has recommended a 'pre-commit' hook that was not
     ++run: git-secrets --pre_commit_hook.
     ++
     ++To install it, run `git hook setup origin pre-commit`. After installation, apply
     ++the hook to your commit by running `git commit --amend`.
      +
      +Turn off this advice by setting config variable advice.missingHook to false."
      +....
      +
     ++==== Example 4: Prompting for automatic hook updates, if opted in via config
     ++....
     ++#~/.gitconfig
     ++[hook]
     ++   allowPromptingAutoUpdateFromRemote = $ORIGIN_URL
      +
     -+Implementation Sketch
     -+^^^^^^^^^^^^^^^^^^^^^
     ++$ git pull origin
      +
     -+* Perform fetch as normal
     ++The following hooks were updated from remote `origin` ($ORIGIN_URL):
      +
     -+* After fetch is complete, Git checks for a "magic" config branch (e.g.
     -++origin/refs/recommended-config+) which contains information about config lines
     -+an end-user may want (including hooks).
     ++pre-push:  $GIT_ROOT/pre_push.sh
      +
     -+* As part of the fetch subcommand, Git prompts users to install the configs
     -+contained there.
     ++If you wish to install them, run `git hook setup origin`.
      +
     -+    ** User responses to that prompt could be "sticky" - e.g. a user could reply
     -+    "no (this time)", "no (never)", "yes (this time)", or "yes (always)".
     -+    Always/never indicate that the user trusts the remote this config is coming
     -+    from, and should not apply to configs fetched from other remotes.
     ++# If and only if the config is set, following only messages shows and the
     ++# "always" flag works
      +
     -+Later, we might want to do this before the initial clone is performed; that
     -+workflow looks like:
     ++If you wish to always accept hooks from `origin`, run `git hook setup origin
     ++--always`. You should only do this if you trust code changes from origin.
      +
     -+* During clone, perform ls-refs as normal
     ++To always ignore hooks from `origin`, run `git hook ignore origin`.
     ++....
      +
     -+* If the server has a "magic" config branch, fetch only that config branch.
     ++Implementation Exploration: Check special config branch at fetch time
     ++~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      +
     -+* Prompt users as described above.
     ++* Perform fetch as normal
      +
     -+* Perform the rest of the clone.
     ++* After fetch is complete, Git checks for a "magic" config branch (e.g.
     +++origin/refs/recommended-config+) which contains information about config lines
     ++an end-user may want, including hooks.
     ++
     ++* As part of the fetch subcommand, Git alerts users (but not interactively) they
     ++can install install the configs contained there.
      +
      +Pros
      +^^^^
     @@ Documentation/technical/project-configured-hooks.txt (new)
      +* Repository owners have a method for providing recommended config for
      +contributors.
      +
     -+* Installation flow happens without additional user intervention.
     -+
      +* Keeping config branch and history separate from code branch and history means
      +it is versioned, but not tied to user's checkout.
      +
     -+* Letting users specify "always" or "never" reduces amount of pain introduced by
     -+interactive "configuration wizard" flow.
     -+
      +Cons
      +^^^^
      +
     -+* Requires addition of step to fetch (and later clone).
     -+
     -+* Turning a "set and forget" command like clone into an interactive session with
     -+the user is not ideal; care must be taken to avoid breaking bots.
     ++* Requires addition of step to fetch.
      +
      +* Inflating configs and executables from a remote tracking branch which is never
      +checked out could be slow.
     @@ Documentation/technical/project-configured-hooks.txt (new)
      +Prior Art
      +~~~~~~~~~
      +
     -+Husky
     -+^^^^^
     ++https://github.com/typicode/husky[Husky]
     ++^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
     ++
     ++* node.js ecosystem-based solution
      +
      +* Add it as a dev dependency in package.json
      +
     @@ Documentation/technical/project-configured-hooks.txt (new)
      +package.json with `husky install` will automate the installation of the husky
      +script in the .git directory.
      +
     -+pre-commit
     -+^^^^^^^^^^
     ++https://github.com/pre-commit/pre-commit[pre-commit]
     ++^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
     ++
     ++* Python-based solution
      +
      +* Acts as a package manager for linting, installing the required linters as
      +needed
     @@ Documentation/technical/project-configured-hooks.txt (new)
      +
      +* `--ignore-hooks` allows developers to run hooks without blocking
      +
     -+// The '+' in Gerrit URL frightens asciidoctor.
     -+:repohook-read: https://android.googlesource.com/platform/tools/repohooks/+/refs/heads/master/rh/config.py
     -+:repohook-config: https://android.googlesource.com/platform/tools/repohooks/+/refs/heads/master#config-files
     -+
      +* The hooks {repohook-read}[read] a {repohook-config}[config file] to determine
      +what code to actually execute.
      +
     @@ Documentation/technical/project-configured-hooks.txt (new)
      +    ** commit_msg_bug_field: require “Bug:” to be present in the commit message
      +    (built into repohooks)
      +
     ++
     ++Other Solutions
     ++^^^^^^^^^^^^^^^
     ++
     ++* https://github.com/sds/overcommit - Ruby
     ++* https://github.com/Arkweid/lefthook - Go
     ++* https://github.com/shibapm/Komondor - Swift
     ++
      +Glossary
      +~~~~~~~~
      +
     @@ Documentation/technical/project-configured-hooks.txt (new)
      +
      +*hook command*: A user script or executable which will be run on one or more
      +hook events.
     + \ No newline at end of file


 Documentation/Makefile                        |   1 +
 .../technical/project-configured-hooks.txt    | 528 ++++++++++++++++++
 2 files changed, 529 insertions(+)
 create mode 100644 Documentation/technical/project-configured-hooks.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 81d1bf7a049b..06ba5945c428 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -96,6 +96,7 @@ TECH_DOCS += technical/protocol-common
 TECH_DOCS += technical/protocol-v2
 TECH_DOCS += technical/racy-git
 TECH_DOCS += technical/reftable
+TECH_DOCS += technical/project-configured-hooks
 TECH_DOCS += technical/send-pack-pipeline
 TECH_DOCS += technical/shallow
 TECH_DOCS += technical/signature-format
diff --git a/Documentation/technical/project-configured-hooks.txt b/Documentation/technical/project-configured-hooks.txt
new file mode 100644
index 000000000000..eb18eb6aa1b4
--- /dev/null
+++ b/Documentation/technical/project-configured-hooks.txt
@@ -0,0 +1,528 @@
+Project Configured Hooks
+------------------------
+
+// The '+' in Gerrit URL frightens asciidoctor.
+:chrome-os: https://chromium.googlesource.com/chromiumos/docs/+/HEAD/contributing.md#Upload-changes
+:repohook-read: https://android.googlesource.com/platform/tools/repohooks/+/refs/heads/master/rh/config.py
+:repohook-config: https://android.googlesource.com/platform/tools/repohooks/+/refs/heads/master#config-files
+
+Background
+~~~~~~~~~~
+
+Context
+^^^^^^^
+
+Git has linkgit:githooks[hooks] functionality to allow users to
+execute commands or scripts when certain Git events occur. Some use cases
+include:
+
+* The `pre-commit` hook event:
+
+  ** A developer may want to lint their changes to enforce certain code style
+  and quality. The project may want the commit to fail so that commits that
+  violate the project's style don't get uploaded.
+
+  ** The project may want to prevent developers from committing passwords or
+  other sensitive information e.g. via
+  https://github.com/awslabs/git-secrets[git-secrets].
+
+* The `commit-msg` hook event: the project may want to enforce a certain commit
+message style. This may be out of necessity:
+https://www.gerritcodereview.com/[Gerrit Code Review], for example, requires
+each commit to have a Change-Id in the footer.
+
+* The `pre-push` hook: the project may want to verify that pushes are going to
+the correct central repository to prevent leaks.
+
+A common thread between these use cases is to enforce certain behavior across
+many developers working in the same code base, encouraging best practices and
+healthy code quality.
+
+Hooks today are configured individually in each clone, making it difficult for
+project maintainers to enforce hooks usage across them.
+https://lore.kernel.org/git/20210311021037.3001235-2-emilyshaffer@google.com[Configuration-based
+hook management], by moving hooks to the config, makes this easier; individuals
+can at least configure hooks to be used across multiple workspaces on their
+host.
+
+However, there is still no good way for project maintainers to encourage or
+enforce adoption of specific hook commands on specific hook events in a clone.
+As such, there are many tools that provide this functionality on top of Git (see
+<<prior-art, Prior Art>>) with a lot of adoption across projects big and small:
+
+  * According to it's GitHub page, Husky has 22M million monthly downloads and is
+used by 437K projects.
+
+  * Example open source projects that depend on this type of behavior include
+  https://android.googlesource.com/platform/tools/repohooks/[the Android Open
+  Source Project], {chrome-os}[ChromeOS],
+  https://github.com/angular/angular/tree/master/.husky[Angular], and
+  https://github.com/webpack/webpack/tree/master/.husky[Webpack].
+
+The wide adoption of solutions combined with the fragmentation in solution
+adoption speaks to the opportunity for the Git project to provide a standard
+solution to Git users. In doing so, we can provide a secure, well-supported,
+well-maintained, and better functioning solution (e.g. does not require extra
+dependencies) that benefits all Git users.
+
+We propose adding native Git functionality to allow project maintainers to
+specify hooks that a user ought to install and utilize in their development
+workflows.
+
+Server-side vs Local Checks
+^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+A large motivation for this change is providing projects a method to enable
+local checks of code e.g. linting. As documented in
+linkgit:gitfaq#_hooks[gitfaq], in some cases, server-side
+checks may be more appropriate, especially since developers can always skip
+local hook execution. We think there are still benefits to local checks:
+
+* Ensuring commit message style and preventing the committing of sensitive data,
+as described above. In particular, if CI results are public, as with many open
+source projects, server side checks are useless for guarding against leaking
+sensitive data.
+
+* Helps developers catch issues earlier: typically developers need to push to
+the remote to trigger server-side checks. Local hooks can be run anytime the
+developer wants. This is especially useful if the project has slow
+server-checks; catching issues locally can save the developer a lot of time
+waiting for CI. They are also useful for locally reproducing an issue identified
+in CI, helping resolve issues faster.
+
+* Since the typical goal of developers to submit changes to a central
+repository, their interests are aligned with the project maintainers'; while
+they can choose to skip local hook execution, it is in their interest to allow
+hooks to run at least before proposing code for submission to the central
+repository to increase the chances of the code getting accepted.
+
+In the ideal world, developers and project maintainers use both local and
+server-side checks in their workflow. However, for many smaller projects, this
+may not be possible: server-side checks may be too expensive, either monetarily
+or in terms of time investment, to run. The number of local solutions to this
+use case speaks to this need (see <<prior-art, Prior Art>>). Bringing this
+natively to Git can give all these developers a well-supported, secure
+implementation opposed to the fragmentation we see today.
+
+User Goals / Critical User Journeys
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+* As a project maintainer,
+
+    ** I want to enforce code style so I require developers to use a
+    standardized linter.
+
+    ** I want to prevent sensitive data from getting checked in.
+
+    ** I want to prevent leaks so I check that developers are uploading code to
+    the right private central repository. Conversely, I may want to encourage
+    more open source development and encourage developers to push to public
+    central repositories.
+
+    ** I want this to just work for all the developers in my project, without
+    needing to support them through configuration.
+
+* As a developer developing in a local clone,
+
+    ** I want to set up my workspace.
+
+    ** I want control over what code runs on my machine.
+
+    ** I want to set up my own hooks, in addition to or in lieu of project
+    configured hooks.
+
+    ** I want to skip hooks from running (for various reasons).
+
+Security Threat Model
+~~~~~~~~~~~~~~~~~~~~~
+
+==== Principles
+
+1. It is unreasonable to require users to audit hook code themselves.
+
+    * Users do not have time
+    * Users, in general, are unfamiliar with system exploits / security
+    * Users may be unfamiliar with a hook’s implementation language
+    * Hooks may be compiled binaries and unauditable
+
+2. It is reasonable for users to make a trust decision based on where a hook comes from.
+
+    * Society functions on the basis of trust relationships formed between different
+    agents --- this is the basis for being able to accomplish more than one person
+    can personally accomplish. The complexity is giving users the power to make that
+    trust decision.
+    * Git users are already making trust decisions based on repository origin.
+
+==== Happy Path
+
+* User clones repository
+
+    ** Clone occurs over a secure transport (HTTPS / SSH)
+
+* After clone, repository suggests hooks to the user
+
+    ** User receives a non-interactive message advertising hooks available to
+    install
+
+    ** User can see what hooks and commands are being suggested and from what
+    remote.
+
+* User evaluates the hook's purpose and publisher and decides whether to install
+it
+
+    ** Installation happens through a separate command the user runs, not an
+    interactive prompt.
+
+* [Minimum Feature] A repository owner can update a hook, at which point users who have
+installed it can decide whether to upgrade or uninstall it
+
+    ** This avoids having to define in the first round of this feature whether
+    the hook's purpose and publisher have changed little enough to reuse the
+    user's previous consent.
+
+    ** A good enhancement soon after would be to allow users to indicate at hook
+    installation time that they want to accept all updates of this same hook
+    from the same origin.
+
+==== In-Scope Threats
+
+1. Repository owner changes hooks frequently to coax user into accidentally or
+mindlessly agreeing to install malicious hooks (“please make this prompt go
+away,” “why are you bothering me?”). Mitigation:
+
+    ** Never interactively prompt for hook installation
+
+    ** Advertise hooks up front instead of waiting until hooks are about to
+    execute. Up front, the user's intent is to set up their workspace so the
+    install message is relevant to them; when the user is in the middle of
+    another action, they are more likely to blindly agree.
+
+    ** Give users an easy way to disable all advertisements for hooks
+
+2. Adversary intercepts requests for a repository and inserts malicious hooks
+(person-in-the-middle-type attacks). Mitigation:
+
+    ** Only receive hooks suggestions over HTTPS / SSH
+
+    ** Include the hook origin (domain name) in the command to install a hook
+
+3. Malicious repository owner convinces user, who does not intend to run any
+other git commands in the repository after clone, to install hooks. Mitigation:
+
+    ** Do not automatically install hooks on a normal `git clone`
+
+    ** Do not interactively prompt to install hooks after the clone is finished.
+
+4. Adversary exploits an old security issue with a hook that has since been
+patched. Mitigation:
+
+    ** Allow users to opt-into hooks getting auto-updated
+
+==== Out-of-Scope Threats
+
+1. Repository owner convinces a user who already intends to build code in the
+repository to knowingly and explicitly agree to install hooks. Justification:
+
+    ** This is equivalent (in terms of attack surface) to setting up your
+    dependencies / building the source code, and thus is not a new attack
+    surface.
+
+2. Typosquatting - user clones from a repository they think they trust but it
+isn’t really the right one. Justification:
+
+    ** Existing problem
+
+3. https://github.com/greatsuspender/thegreatsuspender/issues/1263[Malicious new
+maintainer] of the project creates malicious hooks. Justification:
+
+    ** Similar problem to #1 - maintainer could have instead updated build
+    files.
+
+    ** In the case for auto-updating hooks, updated hooks wouldn’t execute until
+    the user has issued commands in the repository.
+
+Feature Requirements
+~~~~~~~~~~~~~~~~~~~~
+
+Minimum Feature Set
+^^^^^^^^^^^^^^^^^^^
+
+* A central repository can specify a recommended configuration for what hook
+commands are enabled for what hook events
+
+    * The suggested configuration should be equivalent to what a user could
+    manually install using config-based hooks.
+
+* The configuration specifies where the hook commands reside
+
+    ** This could be a path to a script/binary within the repository
+
+    ** This could be a path to a script/binary contained within submodules of
+    the repository
+
+    ** This could be a user installed command or script/binary that exists
+    outside of the repository and is present in `$PATH`
+
+* The configuration should only apply if it was received over a secure channel
+(HTTPS, SSH)
+
+* The configuration lives outside the worktree.
+
+    ** Allows updated hooks to apply across history and branches, reducing
+    the maintenance burden of keeping hooks updated.
+
+    ** Allows different remotes to specify different configuration. This is
+    useful for public vs private central repositories or for repositories which
+    support different Git functionality.
+
+* The user receives advice to install hooks.
+
+    ** The advice should clearly indicate the suggested hook command(s) and hook
+    event(s) as well as the central repository that is suggesting them (via
+    remote URL).
+
+    ** The user should be able to use configuration to turn off this advice.
+
+    ** The advice should appear at the following times:
+
+        *** After a clone
+
+        *** After a suggested hook would have run if not already installed. The
+        advice should include commands for installing the hook and invoking it.
+        For example, for a hook on 'git commit', the user should receive advice
+        to amend their commit after hook installation.
+
+* If, after fetch, the central repository suggests new or updated hooks, the
+user should receive advice to install these new hooks (note: implementation
+should not interfere with requirement listed in“Fast Follows")
+
+* Works across Windows/Linux/macOS
+
+Fast Follows
+^^^^^^^^^^^^
+
+* Behind configuration, a user can opt to automatically install hook updates
+from a given remote.
+
+Nice to Haves
+^^^^^^^^^^^^^
+
+* A method to skip hook execution i.e. `--no-verify` works everywhere
+
+* Support a “warnings only mode” where hooks run but don’t block commands from
+executing
+
+Out of Scope
+^^^^^^^^^^^^
+
+* Ensuring the user has installed software that isn't distributed with the repo
+
+Example User Experience
+~~~~~~~~~~~~~~~~~~~~~~~
+
+==== Example 1: Suggestion to install after clone
+....
+$ git clone $ORIGIN_URL
+...
+
+Remote `origin` ($ORIGIN_URL) suggests the following hooks:
+pre-commit: git-secrets --pre_commit_hook
+pre-push:  $GIT_ROOT/pre_push.sh
+
+If you wish to install them, run `git hook setup origin`.
+To always ignore hooks from `origin`, run `git hook ignore origin`.
+....
+
+==== Example 2: Altering when suggested hooks change
+....
+$ git pull origin
+
+The following hooks were updated from remote `origin` ($ORIGIN_URL):
+
+pre-push:  $GIT_ROOT/pre_push.sh
+
+If you wish to install them, run `git hook setup origin`.
+To always ignore hooks from `origin`, run `git hook ignore origin`.
+....
+
+==== Example 3: Nudging when hooks weren't installed
+....
+$ git commit
+
+advice: The repository owner has recommended a 'pre-commit' hook that was not
+run: git-secrets --pre_commit_hook.
+
+To install it, run `git hook setup origin pre-commit`. After installation, apply
+the hook to your commit by running `git commit --amend`.
+
+Turn off this advice by setting config variable advice.missingHook to false."
+....
+
+==== Example 4: Prompting for automatic hook updates, if opted in via config
+....
+#~/.gitconfig
+[hook]
+   allowPromptingAutoUpdateFromRemote = $ORIGIN_URL
+
+$ git pull origin
+
+The following hooks were updated from remote `origin` ($ORIGIN_URL):
+
+pre-push:  $GIT_ROOT/pre_push.sh
+
+If you wish to install them, run `git hook setup origin`.
+
+# If and only if the config is set, following only messages shows and the
+# "always" flag works
+
+If you wish to always accept hooks from `origin`, run `git hook setup origin
+--always`. You should only do this if you trust code changes from origin.
+
+To always ignore hooks from `origin`, run `git hook ignore origin`.
+....
+
+Implementation Exploration: Check special config branch at fetch time
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+* Perform fetch as normal
+
+* After fetch is complete, Git checks for a "magic" config branch (e.g.
++origin/refs/recommended-config+) which contains information about config lines
+an end-user may want, including hooks.
+
+* As part of the fetch subcommand, Git alerts users (but not interactively) they
+can install install the configs contained there.
+
+Pros
+^^^^
+
+* Repository owners have a method for providing recommended config for
+contributors.
+
+* Keeping config branch and history separate from code branch and history means
+it is versioned, but not tied to user's checkout.
+
+Cons
+^^^^
+
+* Requires addition of step to fetch.
+
+* Inflating configs and executables from a remote tracking branch which is never
+checked out could be slow.
+
+Future Work
+~~~~~~~~~~~
+
+* Extending this to allow repository owners to specify specific configurations
+in general e.g. this repository should use partial-clone with these parameters.
+
+* Extending this to support submodules: We want to make sure this works in a way
+that's easy to adapt to submodules, who would likely need to run the same hooks
+as the superproject; for example, submodules could inherit the superproject
+config.
+
+* A way to perform general set up of a code base e.g. installing dependencies,
+any first-build related tasks
+
+* Sandboxing hook execution to provide higher levels of security.
+
+[[prior-art]]
+Prior Art
+~~~~~~~~~
+
+https://github.com/typicode/husky[Husky]
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+* node.js ecosystem-based solution
+
+* Add it as a dev dependency in package.json
+
+* Supports out-of-the-box configuration: Adding a `prepare` script in
+package.json with `husky install` will automate the installation of the husky
+script in the .git directory.
+
+https://github.com/pre-commit/pre-commit[pre-commit]
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+* Python-based solution
+
+* Acts as a package manager for linting, installing the required linters as
+needed
+
+* `pre-commit install` installs the pre-commit hook shim
+
+* Config is checked into the repository, allowing owners to set versions for
+linters
+
+* Provides some out-of-the-box hooks:
+https://github.com/pre-commit/pre-commit-hooks[https://github.com/pre-commit/pre-commit-hooks]
+
+Repo Hooks
+^^^^^^^^^^
+
+* A Git repository containing hooks commands is specified in the manifest and
+checked out during `repo init`.
+
+* A `repo-hooks` element specifies the Git repository where the hooks code lives
+and which hook to enable. This is typically
+https://android.googlesource.com/platform/tools/repohooks/.
+
+* The only hook event currently supported is `pre-upload`, running when people
+run +repo upload+.
+
+* The hooks code file name must be the same as the hook event name e.g.
+`pre-upload.py`.
+
+* When a hook is used for the first time, the user is prompted
+to approve execution
+
+    ** For manifests fetched via secure protocols (e.g. https://), the user is
+    prompted once.
+
+    ** For insecure protocols (e.g. http://), the user is prompted whenever the
+    registered repohooks project is updated and a hook is triggered.
+
+* Repo hooks must be python modules (Python 2 or 3, with 2 support deprecated)
+
+* Repo hooks run from the top of the repo directory
+
+    ** if the repo client is under `~/tree/`, then that is where the hook runs,
+    even if you ran repo in a git repository at `~/tree/src/foo/`, or in a
+    subdirectory of that git repository in `~/tree/src/foo/bar/`.
+
+* `--no-verify` allows developers to bypass hooks.
+
+* `--ignore-hooks` allows developers to run hooks without blocking
+
+* The hooks {repohook-read}[read] a {repohook-config}[config file] to determine
+what code to actually execute.
+
+    ** Config can be global e.g. at the top of the Repo workspace and local, and
+    they get merged together.
+
+    ** Local config: looks for the closest config file to where you ran repo,
+    allowing each repository to configure its own hooks
+
+* Example code that gets run:
+
+    ** pylint3 (requiring this to be installed on the host)
+
+    ** commit_msg_bug_field: require “Bug:” to be present in the commit message
+    (built into repohooks)
+
+
+Other Solutions
+^^^^^^^^^^^^^^^
+
+* https://github.com/sds/overcommit - Ruby
+* https://github.com/Arkweid/lefthook - Go
+* https://github.com/shibapm/Komondor - Swift
+
+Glossary
+~~~~~~~~
+
+*hook event*: A point during Git’s execution where user scripts may be run, for
+example, `prepare-commit-msg` or `pre-push`.
+
+*hook command*: A user script or executable which will be run on one or more
+hook events.
\ No newline at end of file

base-commit: a5828ae6b52137b913b978e16cd2334482eb4c1f
-- 
gitgitgadget
