Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18136C433DB
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 01:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C328E61A3E
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 01:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhCZBoC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 21:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhCZBnk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 21:43:40 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CFBC06174A
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 18:43:40 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p19so2176529wmq.1
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 18:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=G9aHkk73KSRYEv/0I4A0PGDaGg3djitYb31FbhyoXlE=;
        b=j3xVZAFDc/tKp8PXGqIcm+x4oIF4wAMQO7+1SFS2+DOwb/SJdZgV9XcAXaotU2zhxx
         jYBySx2WN91JXuT0F//Ga0xaigREsyQ8WpgH26luaNcaVj2+x/OQbiQR3j+mJ1B5NIfT
         jnceqmKBjfdCvhP6UfhgOyJJpFwcLSs/S2umP+qpR8DqLTVTxEDBcKxWThNBfOJF2rf2
         L9AK34xRRHfiXMi6oqWGn5g6863ETIX6fP/P8Po1J1X3pDwEYV7K8kcdKDhPWUvq9mWU
         k48B+V3p0875mFA+jN/bELMcGzwk8IMwJjXg/e+mkDIezBtbrSx/4Y+sJtsXoNIpZa1Z
         +nqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=G9aHkk73KSRYEv/0I4A0PGDaGg3djitYb31FbhyoXlE=;
        b=QZY9iciDtJmRa65qAEjlL0R7rvovWk5XbFZQJuSLSsH70x+DNb5WfbyXNAx2lU2VUL
         zeY5p9ncsebdRB9rZ+ndYHHUZj/tWg36tIh30bRDuYcyNjAtzzrULRyyTsnGXyQC7vRd
         HVBI3iEjQhxFChdNzz5/NvhHFesLMbLCU6pEXtPVjb6bYhuTg1v1wHIN6e+ZlY5MmcWd
         ytGcShIOoT7rYQ4XKkHpOE3y2XGEWkj9FnS2DCUXuK1o+Hj4TITt2Kd6WJP8Cu9IHo8e
         C+dWAiLYP9fK5eyhU3TB1ycriyTQqGQmgdBURdThD56lz6ft4ReO/BTP7CtHugvCj2gH
         8FpA==
X-Gm-Message-State: AOAM532sbOT30KrnY7EV563RThE9+jPeGBVCapzlTYxX4jgVwFGPXOu2
        BhUIaEfJV4XVtDZux3Y0wT3n06kK7Lo=
X-Google-Smtp-Source: ABdhPJxml+q2+NMjF0+dUs0T/8dICqx6Z4K9aNisBdjt6rU78WzcHoc33WO6rq7fcpuVrhJ8FJHN5A==
X-Received: by 2002:a1c:2017:: with SMTP id g23mr10370538wmg.126.1616723018432;
        Thu, 25 Mar 2021 18:43:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h12sm3353796wrv.58.2021.03.25.18.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 18:43:37 -0700 (PDT)
Message-Id: <pull.908.v2.git.1616723016659.gitgitgadget@gmail.com>
In-Reply-To: <pull.908.git.1616105016055.gitgitgadget@gmail.com>
References: <pull.908.git.1616105016055.gitgitgadget@gmail.com>
From:   "Albert Cui via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Mar 2021 01:43:36 +0000
Subject: [PATCH v2] hooks: propose project configured hooks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Albert Cui <albertqcui@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Albert Cui <albertqcui@gmail.com>,
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
Change-Id: I5f6747524b97c51dfe5fa28e48ea03981b2da5b8
---
    [RFC] hooks: propose project configured hooks
    
    V2:
    
     * Clarify usage of the word repository; "repository owner" is
       specifically confusing so changed to "project"
     * Add section about local vs remote hooks, and why think why there's
       still use case for local hooks
     * Change design principles section to be more explicit about security
       considerations
     * Introduce requirement for a command to set up hooks
     * Add UX examples
    
    Signed-off-by: Albert Cui albertqcui@gmail.com Helped-by: Emily Shaffer
    emilyshaffer@google.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-908%2Falbertcui%2Fhooks-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-908/albertcui/hooks-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/908

Range-diff vs v1:

 1:  2a558d06245d ! 1:  473e14edd441 hooks: propose repository owner configured hooks
     @@ Metadata
      Author: Albert Cui <albertqcui@gmail.com>
      
       ## Commit message ##
     -    hooks: propose repository owner configured hooks
     +    hooks: propose project configured hooks
      
          Hooks today are configured at the repository level, making it difficult to
          share hooks across repositories. Configuration-based hook management, by
     @@ Commit message
          adoption of specific hook commands on specific hook events in a repository.
          As such, there are many tools that provide this functionality on top of Git.
      
     -    We propose adding native Git functionality to allow project maintainers to
     -    specify hooks that a user ought to install and utilize in their development
     -    workflows. This patch documents the requirements we propose for this feature
     -    as well as a design sketch for implementation.
     +    This patch documents the requirements we propose for this feature as well as
     +    a design sketch for implementation.
      
          Signed-off-by: Albert Cui <albertqcui@gmail.com>
          Helped-by: Emily Shaffer <emilyshaffer@google.com>
     +    Change-Id: I5f6747524b97c51dfe5fa28e48ea03981b2da5b8
      
       ## Documentation/Makefile ##
      @@ Documentation/Makefile: TECH_DOCS += technical/protocol-common
       TECH_DOCS += technical/protocol-v2
       TECH_DOCS += technical/racy-git
       TECH_DOCS += technical/reftable
     -+TECH_DOCS += technical/repository-owner-hooks
     ++TECH_DOCS += technical/project-configured-hooks
       TECH_DOCS += technical/send-pack-pipeline
       TECH_DOCS += technical/shallow
       TECH_DOCS += technical/signature-format
      
     - ## Documentation/technical/repository-owner-hooks.txt (new) ##
     + ## Documentation/technical/project-configured-hooks.txt (new) ##
      @@
     -+Repository Owner Hooks Administration
     -+-------------------------------------
     ++Project Configured Hooks
     ++------------------------
      +
      +Background
      +~~~~~~~~~~
     @@ Documentation/technical/repository-owner-hooks.txt (new)
      +execute commands or scripts when certain Git events occur. Some use cases
      +include:
      +
     -+* The `pre-commit` hook event: before committing, a developer may want to lint
     -+their changes to enforce certain code style and quality. If there are style
     -+issues, the developer may want the commit to fail so that they can fix the
     -+issues.
     ++* The `pre-commit` hook event:
      +
     -+* The `commit-msg` hook event: after committing, repository owners may want to
     -+enforce a certain commit message style. This may be out of necessity:
     ++  ** A developer may want to lint their changes to enforce certain code style
     ++  and quality. The project may want the commit to fail so that commits that
     ++  violate the project's style don't get uploaded.
     ++
     ++  ** The project may want to prevent developers from committing passwords or
     ++  other sensitive information e.g. via
     ++  https://github.com/awslabs/git-secrets[git-secrets].
     ++
     ++* The `commit-msg` hook event: the project may want to enforce a certain commit
     ++message style. This may be out of necessity:
      +https://www.gerritcodereview.com/[Gerrit Code Review], for example, requires
      +each commit to have a Change-Id in the footer.
      +
     -+* The `pre-push` hook: before pushing, repository owners may want to verify that
     -+pushes are going to the correct remote to prevent leaks.
     ++* The `pre-push` hook: the project may want to verify that pushes are going to
     ++the correct central repository to prevent leaks.
      +
      +A common thread between these use cases is to enforce certain behavior across
      +many developers working in the same code base, encouraging best practices and
      +healthy code quality.
      +
     -+Hooks today are configured at the repository level, making it difficult to share
     -+hooks across repositories.
     ++Hooks today are configured individually in each clone, making it difficult for
     ++project maintainers to enforce hooks usage across them.
      +https://lore.kernel.org/git/20210311021037.3001235-2-emilyshaffer@google.com[Configuration-based
     -+hook management], by moving hooks configuration to the config, makes this much
     -+easier. However, there is still no good way for project maintainers to encourage
     ++hook management], by moving hooks to the config, makes this easier; individuals
     ++can at least configure hooks to be used across multiple workspaces on their
     ++host. However, there is still no good way for project maintainers to encourage
      +or enforce adoption of specific hook commands on specific hook events in a
     -+repository. As such, there are many tools that provide this functionality on top
     -+of Git (see <<prior-art, Prior Art>>).
     ++clone. As such, there are many tools that provide this functionality on top of
     ++Git (see <<prior-art, Prior Art>>).
      +
      +We propose adding native Git functionality to allow project maintainers to
      +specify hooks that a user ought to install and utilize in their development
      +workflows.
      +
     ++Server-side vs Local Checks
     ++^^^^^^^^^^^^^^^^^^^^^^^^^^^
     ++
     ++A large motivation for this change is providing projects a method to enable
     ++local checks of code e.g. linting. As documented in
     ++https://git-scm.com/docs/gitfaq#_hooks[gitfaq], in some cases, server-side
     ++checks may be more appropriate, especially since developers can always skip
     ++local hook execution. We think there are still benefits to local checks:
     ++
     ++* Ensuring commit message style and preventing the committing of sensitive data,
     ++as described above. In particular, if CI results are public, as with many open
     ++source projects, server side checks are useless for guarding against leaking
     ++sensitive data.
     ++
     ++* Helps developers catch issues earlier: typically developers need to push to
     ++the remote to trigger server-side checks. Local hooks can be run anytime the
     ++developer wants. This is especially useful if the project has slow
     ++server-checks; catching issues locally can save the developer a lot of time
     ++waiting for CI. They are also useful for locally reproducing an issue identified
     ++in CI, helping resolve issues faster.
     ++
     ++* Since the typical goal of developers to submit changes to a central
     ++repository, their interests are aligned with the project maintainers'; while
     ++they can choose to skip local hook execution, it is in their interest to allow
     ++hooks to run at least before proposing code for submission to the central
     ++repository to increase the chances of the code getting accepted.
     ++
     ++In the ideal world, developers and project maintainers use both local and server
     ++side checks in their workflow. However, for many smaller projects, this may not
     ++be possible: CI may be too expensive to run or configure. The number of local
     ++solutions to this use case speaks to this need (see <<prior-art, Prior Art>>).
     ++Bringing this natively to Git can give all these developers a well-supported,
     ++secure implementation opposed to the fragmentation we see today.
     ++
      +User Goals / Critical User Journeys
      +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
      +
     -+* As a repository owner / project maintainer,
     ++* As a project maintainer,
      +
      +    ** I want to enforce code style so I require developers to use a
      +    standardized linter.
      +
     -+    ** I want to prevent leaks / share code widely so I check that developers
     -+    are uploading code to the right place.
     ++    ** I want to prevent sensitive data from getting checked in.
      +
     -+    ** I want this to just work for all the developers in my repository, without
     ++    ** I want to prevent leaks so I check that developers are uploading code to
     ++    the right private central repository. Conversely, I may want to encourage
     ++    more open source development and encourage developers to push to public
     ++    central repositories.
     ++
     ++    ** I want this to just work for all the developers in my project, without
      +    needing to support them through configuration.
      +
     -+* As a developer developing in a repository,
     ++* As a developer developing in a local clone,
     ++
     ++    ** I want to set up my workspace.
     ++
     ++    ** I want control over what code runs on my machine.
     ++
     ++    ** I want to set up my own hooks, in addition to or in lieu of project
     ++    configured hooks.
     ++
     ++    ** I want to skip hooks from running (for various reasons).
     ++
     ++Security Considerations and Design Principles
     ++~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      +
     -+    ** I want to set up my workspace
     ++We must balance the desire to make hooks setup easy for developers --- allowing
     ++them to get hooks set up with low friction, and hence increasing the probability
     ++of them adopting these hooks --- with protecting users from the security risks
     ++of arbitrary code execution on their hosts.
      +
     -+    ** I want control over what code runs on my machine
     ++To inform the design, we propose these design principles:
      +
     -+    ** I want to skip hooks from running (for various reasons)
     ++* User consent: Users must explicitly agree to hooks usage; no hooks should
     ++execute without consent, and users should re-consent if hooks update. Users can
     ++opt-out of hooks.
      +
     -+Design Principles
     -+~~~~~~~~~~~~~~~~~
     ++* Trust comes from the central repository:
     ++  ** Most users don't have the time or expertise to properly audit every hook
     ++  and what it does. There must be trust between the user and the remote that the
     ++  code came from, and the Git project should ensure trust to the degree it can
     ++  e.g. enforce HTTPS for its integrity guarantees.
      +
     -+* *Make it easy:* Developers just want to get their work done. Introducing
     -+friction is bad, especially when it prevents development from even starting e.g.
     -+workspace set up.
     ++  ** Since developers will likely build their local clone in their development
     ++  process, at some point, arbitrary code from the repository will be executed.
     ++  In this sense, hooks _with user consent_ do not introduce a new attack surface.
      +
     -+* *Treat hooks as software, not configuration:* We take seriously the
     -+responsibility that comes with causing arbitrary code to run on a user's
     -+machine. Such code needs to come from a reputable source, be automatically
     -+updated, and run with user consent.
     ++* Give users visibility: Git must allow users to make informed decisions. This
     ++means surfacing essential information to the user in a visible manner e.g. what
     ++remotes the hooks are coming from, whether the hooks have changed in the latest
     ++checkout.
      +
      +Feature Requirements
      +~~~~~~~~~~~~~~~~~~~~
     @@ Documentation/technical/repository-owner-hooks.txt (new)
      +Minimum Feature Set
      +^^^^^^^^^^^^^^^^^^^
      +
     -+* A repository owner can specify a configuration for what hook commands are
     ++* A repository can specify a configuration for what hook commands are
      +enabled for what hook events
      +
     -+* A repository owner can specify, in this configuration, where the hook
     ++* A repository can specify, in this configuration, where the hook
      +commands reside
      +
      +    ** This could be a path to a script/binary within the repository
     @@ Documentation/technical/repository-owner-hooks.txt (new)
      +    ** This could be a user installed command or script/binary that exists
      +    outside of the repository and is present in `$PATH`
      +
     -+* Users must explicitly approve hook execution at least once (yes/no)
     ++* This configuration should only apply if it was received over HTTPS
      +
     -+    ** This could happen during setup or at execution time
     ++* A setup command for users to set up hooks
     ++
     ++    ** Hook setup could happen at clone time assuming the user has consented
     ++    e.g. if `--setup-hooks` is passed to `git clone`
     ++
     ++* Users must explicitly approve hooks at least once
     ++
     ++    ** Running the setup command should count as approval, including if the user
     ++    consented during the clone
      +
      +    ** When a hook command changes, a user should re-approve execution (note:
      +    implementation should not interfere with requirement listed in “Fast
      +    Follows")
      +
     -+    * Users do not need to run setup scripts to install hooks --- the setup flow
     -+    happens automatically at clone time
     -+
      +* Automation is able to continue to use clone and other commands
      +non-interactively
      +
     @@ Documentation/technical/repository-owner-hooks.txt (new)
      +Implementation Exploration: Check "magic" branch for configs at fetch time
      +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      +
     -+Example workflow
     -+^^^^^^^^^^^^^^^^
     ++Example User Experience
     ++^^^^^^^^^^^^^^^^^^^^^^^
     ++
     ++===== Case 1: Consent through clone
     ++
     ++....
     ++$ git clone --setup-hooks
     ++...
     ++
     ++The following hooks were installed from remote `origin` ($ORIGIN_URL):
     ++
     ++pre-commit: git-secrets --pre_commit_hook
     ++pre-push:  $GIT_ROOT/pre_push.sh
     ++....
     ++
     ++===== Case 2: Prompting after clone
     ++....
     ++$ git clone
     ++...
     ++
     ++Remote `origin` ($ORIGIN_URL) suggest installing the following hooks:
     ++
     ++pre-commit: git-secrets --pre_commit_hook
     ++pre-push:  $GIT_ROOT/pre_push.sh
     ++
     ++# instead of prompting, we could give users commands to run instead
     ++# see case 3
     ++
     ++Do you wish to install them?
     ++1. Yes (this time)
     ++2. Yes (always from origin)
     ++3. No (not this time)
     ++4. No (never)
     ++....
     ++
     ++===== Case 3: Re-prompting when hooks change
     ++....
     ++$ git pull
     ++
     ++The following hooks were updated from remote `origin` ($ORIGIN_URL):
     ++
     ++pre-push:  $GIT_ROOT/pre_push.sh
     ++
     ++If you wish to install them, run `git hook setup origin`.
     ++
     ++If you wish to always accept hooks from `origin`, run `git hook setup --always
     ++origin`. You should only do this if you trust code changes from origin.
     ++
     ++To always ignore hooks from `origin`, run `git hook ignore origin`.
     ++....
     ++
     ++===== Case 4: Nudging when hooks weren't installed
     ++....
     ++$ git commit
     ++advice: The repository owner has recommended a 'pre-commit' hook that was not run.
     ++To view it, run `git show origin/refs/recommended-config:some-pre-commit`. To install it, run `git hook setup origin pre-commit`
     ++
     ++Turn off this advice by setting config variable advice.missingHook to false."
     ++....
     ++
     ++
     ++Implementation Sketch
     ++^^^^^^^^^^^^^^^^^^^^^
      +
      +* Perform fetch as normal
      +
     @@ Documentation/technical/repository-owner-hooks.txt (new)
      +* A way to perform general set up of a code base e.g. installing dependencies,
      +any first-build related tasks
      +
     ++* Sandboxing hook execution to provide higher levels of security.
     ++
      +[[prior-art]]
      +Prior Art
      +~~~~~~~~~


 Documentation/Makefile                        |   1 +
 .../technical/project-configured-hooks.txt    | 426 ++++++++++++++++++
 2 files changed, 427 insertions(+)
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
index 000000000000..e880dd7af300
--- /dev/null
+++ b/Documentation/technical/project-configured-hooks.txt
@@ -0,0 +1,426 @@
+Project Configured Hooks
+------------------------
+
+Background
+~~~~~~~~~~
+
+Context
+^^^^^^^
+
+Git has https://git-scm.com/docs/githooks[hooks] functionality to allow users to
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
+host. However, there is still no good way for project maintainers to encourage
+or enforce adoption of specific hook commands on specific hook events in a
+clone. As such, there are many tools that provide this functionality on top of
+Git (see <<prior-art, Prior Art>>).
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
+https://git-scm.com/docs/gitfaq#_hooks[gitfaq], in some cases, server-side
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
+In the ideal world, developers and project maintainers use both local and server
+side checks in their workflow. However, for many smaller projects, this may not
+be possible: CI may be too expensive to run or configure. The number of local
+solutions to this use case speaks to this need (see <<prior-art, Prior Art>>).
+Bringing this natively to Git can give all these developers a well-supported,
+secure implementation opposed to the fragmentation we see today.
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
+Security Considerations and Design Principles
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+We must balance the desire to make hooks setup easy for developers --- allowing
+them to get hooks set up with low friction, and hence increasing the probability
+of them adopting these hooks --- with protecting users from the security risks
+of arbitrary code execution on their hosts.
+
+To inform the design, we propose these design principles:
+
+* User consent: Users must explicitly agree to hooks usage; no hooks should
+execute without consent, and users should re-consent if hooks update. Users can
+opt-out of hooks.
+
+* Trust comes from the central repository:
+  ** Most users don't have the time or expertise to properly audit every hook
+  and what it does. There must be trust between the user and the remote that the
+  code came from, and the Git project should ensure trust to the degree it can
+  e.g. enforce HTTPS for its integrity guarantees.
+
+  ** Since developers will likely build their local clone in their development
+  process, at some point, arbitrary code from the repository will be executed.
+  In this sense, hooks _with user consent_ do not introduce a new attack surface.
+
+* Give users visibility: Git must allow users to make informed decisions. This
+means surfacing essential information to the user in a visible manner e.g. what
+remotes the hooks are coming from, whether the hooks have changed in the latest
+checkout.
+
+Feature Requirements
+~~~~~~~~~~~~~~~~~~~~
+
+Minimum Feature Set
+^^^^^^^^^^^^^^^^^^^
+
+* A repository can specify a configuration for what hook commands are
+enabled for what hook events
+
+* A repository can specify, in this configuration, where the hook
+commands reside
+
+    ** This could be a path to a script/binary within the repository
+
+    ** This could be a path to a script/binary contained within submodules of
+    the repository
+
+    ** This could be a user installed command or script/binary that exists
+    outside of the repository and is present in `$PATH`
+
+* This configuration should only apply if it was received over HTTPS
+
+* A setup command for users to set up hooks
+
+    ** Hook setup could happen at clone time assuming the user has consented
+    e.g. if `--setup-hooks` is passed to `git clone`
+
+* Users must explicitly approve hooks at least once
+
+    ** Running the setup command should count as approval, including if the user
+    consented during the clone
+
+    ** When a hook command changes, a user should re-approve execution (note:
+    implementation should not interfere with requirement listed in “Fast
+    Follows")
+
+* Automation is able to continue to use clone and other commands
+non-interactively
+
+* Works across Windows/Linux/macOS
+
+Fast Follows
+^^^^^^^^^^^^
+
+* When prompted to execute a hook, users can specify always or never, even if
+the hook updates
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
+Implementation Exploration: Check "magic" branch for configs at fetch time
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Example User Experience
+^^^^^^^^^^^^^^^^^^^^^^^
+
+===== Case 1: Consent through clone
+
+....
+$ git clone --setup-hooks
+...
+
+The following hooks were installed from remote `origin` ($ORIGIN_URL):
+
+pre-commit: git-secrets --pre_commit_hook
+pre-push:  $GIT_ROOT/pre_push.sh
+....
+
+===== Case 2: Prompting after clone
+....
+$ git clone
+...
+
+Remote `origin` ($ORIGIN_URL) suggest installing the following hooks:
+
+pre-commit: git-secrets --pre_commit_hook
+pre-push:  $GIT_ROOT/pre_push.sh
+
+# instead of prompting, we could give users commands to run instead
+# see case 3
+
+Do you wish to install them?
+1. Yes (this time)
+2. Yes (always from origin)
+3. No (not this time)
+4. No (never)
+....
+
+===== Case 3: Re-prompting when hooks change
+....
+$ git pull
+
+The following hooks were updated from remote `origin` ($ORIGIN_URL):
+
+pre-push:  $GIT_ROOT/pre_push.sh
+
+If you wish to install them, run `git hook setup origin`.
+
+If you wish to always accept hooks from `origin`, run `git hook setup --always
+origin`. You should only do this if you trust code changes from origin.
+
+To always ignore hooks from `origin`, run `git hook ignore origin`.
+....
+
+===== Case 4: Nudging when hooks weren't installed
+....
+$ git commit
+advice: The repository owner has recommended a 'pre-commit' hook that was not run.
+To view it, run `git show origin/refs/recommended-config:some-pre-commit`. To install it, run `git hook setup origin pre-commit`
+
+Turn off this advice by setting config variable advice.missingHook to false."
+....
+
+
+Implementation Sketch
+^^^^^^^^^^^^^^^^^^^^^
+
+* Perform fetch as normal
+
+* After fetch is complete, Git checks for a "magic" config branch (e.g.
++origin/refs/recommended-config+) which contains information about config lines
+an end-user may want (including hooks).
+
+* As part of the fetch subcommand, Git prompts users to install the configs
+contained there.
+
+    ** User responses to that prompt could be "sticky" - e.g. a user could reply
+    "no (this time)", "no (never)", "yes (this time)", or "yes (always)".
+    Always/never indicate that the user trusts the remote this config is coming
+    from, and should not apply to configs fetched from other remotes.
+
+Later, we might want to do this before the initial clone is performed; that
+workflow looks like:
+
+* During clone, perform ls-refs as normal
+
+* If the server has a "magic" config branch, fetch only that config branch.
+
+* Prompt users as described above.
+
+* Perform the rest of the clone.
+
+Pros
+^^^^
+
+* Repository owners have a method for providing recommended config for
+contributors.
+
+* Installation flow happens without additional user intervention.
+
+* Keeping config branch and history separate from code branch and history means
+it is versioned, but not tied to user's checkout.
+
+* Letting users specify "always" or "never" reduces amount of pain introduced by
+interactive "configuration wizard" flow.
+
+Cons
+^^^^
+
+* Requires addition of step to fetch (and later clone).
+
+* Turning a "set and forget" command like clone into an interactive session with
+the user is not ideal; care must be taken to avoid breaking bots.
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
+Husky
+^^^^^
+
+* Add it as a dev dependency in package.json
+
+* Supports out-of-the-box configuration: Adding a `prepare` script in
+package.json with `husky install` will automate the installation of the husky
+script in the .git directory.
+
+pre-commit
+^^^^^^^^^^
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
+// The '+' in Gerrit URL frightens asciidoctor.
+:repohook-read: https://android.googlesource.com/platform/tools/repohooks/+/refs/heads/master/rh/config.py
+:repohook-config: https://android.googlesource.com/platform/tools/repohooks/+/refs/heads/master#config-files
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
+Glossary
+~~~~~~~~
+
+*hook event*: A point during Git’s execution where user scripts may be run, for
+example, `prepare-commit-msg` or `pre-push`.
+
+*hook command*: A user script or executable which will be run on one or more
+hook events.

base-commit: a5828ae6b52137b913b978e16cd2334482eb4c1f
-- 
gitgitgadget
