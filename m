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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB0EC43460
	for <git@archiver.kernel.org>; Wed,  5 May 2021 19:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72E98613EA
	for <git@archiver.kernel.org>; Wed,  5 May 2021 19:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhEETMh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 15:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbhEETMf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 15:12:35 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0970DC06174A
        for <git@vger.kernel.org>; Wed,  5 May 2021 12:11:37 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id s8so3005498wrw.10
        for <git@vger.kernel.org>; Wed, 05 May 2021 12:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uPoH4LHQ5k+xzOzlaLOqquMMvvBY9DfnfR+WxJvx6Eg=;
        b=cS59D9kXCSSK4lNowwvL2a64YyhI1P0SVZfEQsXOiAdqbrjkv3OCBRyjGPVfRlMmRa
         NXdUbLwCpOzW/easnLfiTHmj3LM9LwhHw/MnO9kqyZzMki00pvjz84zdgwusyo1Y+VmO
         Tx0hYMvQ+ux1ecVECCVLIzkSh/QuDCvir6QeKYwY0A4LgWdBDvrslJQn89Iy7k5h0udJ
         WzgOcM1LwucVklu3ZnhoNuUpS20dOhD/8OVRVcd7gSoER940OYSVtdf4KBfxOZekrIco
         /O/vOtQUBEzVuYLU8p4bJN8mqPfu2vuOAG8wMiJHBwTlJmwR3AD99yClHXMWn2kPyweh
         rNPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uPoH4LHQ5k+xzOzlaLOqquMMvvBY9DfnfR+WxJvx6Eg=;
        b=IdJYkE7OckfZGDL4ivHhHZEKu+jH5QoSM67dFfkyG9bqNBi0tg9mWOwmk3IaL1OT6f
         qk90cNsKcuuIsr33sB+FEzeR83wEip3DSWRYcYvgz+8VU++lsBhegkN3BGnzjHjegfIL
         EH4V1fVFKVjQSaEspJepLt7ARzHf2S97VxQnflCpj2XcNg563709pJ2M+pvrcmjY6JdY
         CxwpQFJKF2ns6mIQM44hE1YP/S3I3pPWC9WmWTtANQ2ffMUbNWi/1jQrJtM7IpoVxtG3
         UdyTKhnT2SxQn2nXPZLZdlCbq2Wi2tjXXu1ns37rCVs1yuIdV0+qMptktymgsyx9/RCn
         BbLA==
X-Gm-Message-State: AOAM530uLK4ZJ69WHmQ/RPUn6fienSnShlVP3k9WmeUj8ejchKb8ovls
        VuR+VSpAGupGKmCpVe+MPMB/v+YsbT0=
X-Google-Smtp-Source: ABdhPJz4LUb536C4esO8Vtn96eBcejaL2JbyBlSalbXn7ZQMK14VzY19nOrh0KaDaPI5ymd+NPgIbg==
X-Received: by 2002:adf:f7c4:: with SMTP id a4mr658720wrq.20.1620241895215;
        Wed, 05 May 2021 12:11:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n7sm273057wri.14.2021.05.05.12.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 12:11:34 -0700 (PDT)
Message-Id: <pull.908.v4.git.1620241892929.gitgitgadget@gmail.com>
In-Reply-To: <pull.908.v3.git.1619228290023.gitgitgadget@gmail.com>
References: <pull.908.v3.git.1619228290023.gitgitgadget@gmail.com>
From:   "Albert Cui via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 May 2021 19:11:32 +0000
Subject: [PATCH v4] hooks: propose project configured hooks
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
    
    V4:
    
     * Streamline local vs server-side checks section and better detail this
       workflow
     * Talk about GPG signing as an alternative way to create trust
     * Add contributors bypassing local hooks to threat model
    
    Signed-off-by: Albert Cui albertqcui@gmail.com Helped-by: Emily Shaffer
    emilyshaffer@google.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-908%2Falbertcui%2Fhooks-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-908/albertcui/hooks-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/908

Range-diff vs v3:

 1:  e8fbcc060c71 ! 1:  0bdf84f277b9 hooks: propose project configured hooks
     @@ Documentation/technical/project-configured-hooks.txt (new)
      +Context
      +^^^^^^^
      +
     -+Git has linkgit:githooks[hooks] functionality to allow users to
     -+execute commands or scripts when certain Git events occur. Some use cases
     -+include:
     ++Git has linkgit:githooks[hooks] functionality that allows users and
     ++administrators to run tools or scripts when certain Git events occur. This
     ++enables workflows that define code style/quality and governance for a project,
     ++spanning both the client and the server:
      +
      +* The `pre-commit` hook event:
      +
     -+  ** A developer may want to lint their changes to enforce certain code style
     -+  and quality. The project may want the commit to fail so that commits that
     -+  violate the project's style don't get uploaded.
     ++  ** A developer may want to lint their changes to adapt the project's code
     ++  style. The project may want the commit to fail so that commits that violate
     ++  the project's style don't get uploaded.
      +
      +  ** The project may want to prevent developers from committing passwords or
      +  other sensitive information e.g. via
      +  https://github.com/awslabs/git-secrets[git-secrets].
      +
     -+* The `commit-msg` hook event: the project may want to enforce a certain commit
     -+message style. This may be out of necessity:
     -+https://www.gerritcodereview.com/[Gerrit Code Review], for example, requires
     -+each commit to have a Change-Id in the footer.
     ++* The `commit-msg` hook event: the project may require a certain commit message
     ++style. This may be out of necessity: https://www.gerritcodereview.com/[Gerrit
     ++Code Review], for example, requires each commit to have a Change-Id in the
     ++footer.
      +
      +* The `pre-push` hook: the project may want to verify that pushes are going to
      +the correct central repository to prevent leaks.
      +
     -+A common thread between these use cases is to enforce certain behavior across
     -+many developers working in the same code base, encouraging best practices and
     -+healthy code quality.
     ++* Finally, the `pre-receive` hook can be used to enforce the aforementioned
     ++checks on the server, rejecting any pushes which fail to pass.
      +
     -+Hooks today are configured individually in each clone, making it difficult for
     -+project maintainers to enforce hooks usage across them.
     ++Client-side hooks today are configured individually in each clone, making it
     ++difficult for project maintainers to define hooks usage across them.
      +https://lore.kernel.org/git/20210311021037.3001235-2-emilyshaffer@google.com[Configuration-based
     -+hook management], by moving hooks to the config, makes this easier; individuals
     -+can at least configure hooks to be used across multiple workspaces on their
     -+host.
     ++hook management], by moving hooks to the Git configuration, makes this easier;
     ++individuals can at least configure hooks to be used across multiple workspaces
     ++on their host.
      +
      +However, there is still no good way for project maintainers to encourage or
      +enforce adoption of specific hook commands on specific hook events in a clone.
     @@ Documentation/technical/project-configured-hooks.txt (new)
      +specify hooks that a user ought to install and utilize in their development
      +workflows.
      +
     -+Server-side vs Local Checks
     -+^^^^^^^^^^^^^^^^^^^^^^^^^^^
     -+
     -+A large motivation for this change is providing projects a method to enable
     -+local checks of code e.g. linting. As documented in
     -+linkgit:gitfaq#_hooks[gitfaq], in some cases, server-side
     -+checks may be more appropriate, especially since developers can always skip
     -+local hook execution. We think there are still benefits to local checks:
     -+
     -+* Ensuring commit message style and preventing the committing of sensitive data,
     -+as described above. In particular, if CI results are public, as with many open
     -+source projects, server side checks are useless for guarding against leaking
     -+sensitive data.
     -+
     -+* Helps developers catch issues earlier: typically developers need to push to
     -+the remote to trigger server-side checks. Local hooks can be run anytime the
     -+developer wants. This is especially useful if the project has slow
     -+server-checks; catching issues locally can save the developer a lot of time
     -+waiting for CI. They are also useful for locally reproducing an issue identified
     -+in CI, helping resolve issues faster.
     -+
     -+* Since the typical goal of developers to submit changes to a central
     -+repository, their interests are aligned with the project maintainers'; while
     -+they can choose to skip local hook execution, it is in their interest to allow
     -+hooks to run at least before proposing code for submission to the central
     -+repository to increase the chances of the code getting accepted.
     -+
     -+In the ideal world, developers and project maintainers use both local and
     -+server-side checks in their workflow. However, for many smaller projects, this
     -+may not be possible: server-side checks may be too expensive, either monetarily
     -+or in terms of time investment, to run. The number of local solutions to this
     -+use case speaks to this need (see <<prior-art, Prior Art>>). Bringing this
     -+natively to Git can give all these developers a well-supported, secure
     -+implementation opposed to the fragmentation we see today.
     ++Client-side and Server-side Checks
     ++^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
     ++
     ++As documented in linkgit:gitfaq#_hooks[gitfaq], server-side checks are often
     ++more appropriate than client-side checks, especially since developers are always
     ++free to skip local hook execution.
     ++
     ++Local checks, however, help developers catch issues earlier: typically,
     ++developers need to push to the remote to trigger server-side checks. Local hooks
     ++can be run anytime the developer wants. This is especially useful if the project
     ++has slow server-checks; catching issues locally can save the developer a lot of
     ++time waiting for server runs. They are also useful for locally reproducing an
     ++issue identified by the server.
     ++
     ++In an ideal world, developers and project maintainers use both local and
     ++server-side checks in their workflow. Local checks are best suited for a subset
     ++of checks that are on the server. The configured checks should be exactly the
     ++same across these two environments so that results are consistent and
     ++reproducible. The simplest way to do this would be to configure the same hook
     ++command locally and on the server.
     ++
     ++Local checks are typically configured as `pre-commit` or `pre-push` checks, and
     ++these scripts should run relatively quickly so as to not introduce too much
     ++friction into a developer's commit workflow (a reason why developers would skip
     ++these local checks); linting and secrets checking of the staged files is usually
     ++a good use case opposed to running an entire test suite.
     ++
     ++Server-side checks would then run on `pre-receive` to validate that the users'
     ++commit passes the checks.
      +
      +User Goals / Critical User Journeys
      +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
     @@ Documentation/technical/project-configured-hooks.txt (new)
      +
      +    ** Only receive hooks suggestions over HTTPS / SSH
      +
     -+    ** Include the hook origin (domain name) in the command to install a hook
     ++    ** Include the hook origin (domain name) in the command to install a hook.
     ++    If the configuration came from a signed commit, the signature could also be
     ++    shown.
      +
      +3. Malicious repository owner convinces user, who does not intend to run any
      +other git commands in the repository after clone, to install hooks. Mitigation:
     @@ Documentation/technical/project-configured-hooks.txt (new)
      +    ** In the case for auto-updating hooks, updated hooks wouldn’t execute until
      +    the user has issued commands in the repository.
      +
     ++4. Disobedient contributors bypass local hooks and attempt to push changes that
     ++go against the project's standards. This could range from the mild issue of
     ++using different coding style or a more serious issue of checking in credentials
     ++or user data. Justification:
     ++    ** Projects should be using server-side checks to require checks, and the
     ++    addition of this feature doesn't change that. Proper documentation of how we
     ++    expect users to use this can help prevent users from misusing this feature.
     ++
      +Feature Requirements
      +~~~~~~~~~~~~~~~~~~~~
      +
     @@ Documentation/technical/project-configured-hooks.txt (new)
      +* Behind configuration, a user can opt to automatically install hook updates
      +from a given remote.
      +
     ++* Allow users to make trust decisions based on GPG signing e.g. if the
     ++configuration came from a signed commit, the signature could be shown along
     ++with the remote it came from.
     ++
      +Nice to Haves
      +^^^^^^^^^^^^^
      +
     @@ Documentation/technical/project-configured-hooks.txt (new)
      +
      +*hook command*: A user script or executable which will be run on one or more
      +hook events.
     - \ No newline at end of file


 Documentation/Makefile                        |   1 +
 .../technical/project-configured-hooks.txt    | 537 ++++++++++++++++++
 2 files changed, 538 insertions(+)
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
index 000000000000..8555bdfa1d51
--- /dev/null
+++ b/Documentation/technical/project-configured-hooks.txt
@@ -0,0 +1,537 @@
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
+Git has linkgit:githooks[hooks] functionality that allows users and
+administrators to run tools or scripts when certain Git events occur. This
+enables workflows that define code style/quality and governance for a project,
+spanning both the client and the server:
+
+* The `pre-commit` hook event:
+
+  ** A developer may want to lint their changes to adapt the project's code
+  style. The project may want the commit to fail so that commits that violate
+  the project's style don't get uploaded.
+
+  ** The project may want to prevent developers from committing passwords or
+  other sensitive information e.g. via
+  https://github.com/awslabs/git-secrets[git-secrets].
+
+* The `commit-msg` hook event: the project may require a certain commit message
+style. This may be out of necessity: https://www.gerritcodereview.com/[Gerrit
+Code Review], for example, requires each commit to have a Change-Id in the
+footer.
+
+* The `pre-push` hook: the project may want to verify that pushes are going to
+the correct central repository to prevent leaks.
+
+* Finally, the `pre-receive` hook can be used to enforce the aforementioned
+checks on the server, rejecting any pushes which fail to pass.
+
+Client-side hooks today are configured individually in each clone, making it
+difficult for project maintainers to define hooks usage across them.
+https://lore.kernel.org/git/20210311021037.3001235-2-emilyshaffer@google.com[Configuration-based
+hook management], by moving hooks to the Git configuration, makes this easier;
+individuals can at least configure hooks to be used across multiple workspaces
+on their host.
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
+Client-side and Server-side Checks
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+As documented in linkgit:gitfaq#_hooks[gitfaq], server-side checks are often
+more appropriate than client-side checks, especially since developers are always
+free to skip local hook execution.
+
+Local checks, however, help developers catch issues earlier: typically,
+developers need to push to the remote to trigger server-side checks. Local hooks
+can be run anytime the developer wants. This is especially useful if the project
+has slow server-checks; catching issues locally can save the developer a lot of
+time waiting for server runs. They are also useful for locally reproducing an
+issue identified by the server.
+
+In an ideal world, developers and project maintainers use both local and
+server-side checks in their workflow. Local checks are best suited for a subset
+of checks that are on the server. The configured checks should be exactly the
+same across these two environments so that results are consistent and
+reproducible. The simplest way to do this would be to configure the same hook
+command locally and on the server.
+
+Local checks are typically configured as `pre-commit` or `pre-push` checks, and
+these scripts should run relatively quickly so as to not introduce too much
+friction into a developer's commit workflow (a reason why developers would skip
+these local checks); linting and secrets checking of the staged files is usually
+a good use case opposed to running an entire test suite.
+
+Server-side checks would then run on `pre-receive` to validate that the users'
+commit passes the checks.
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
+    ** Include the hook origin (domain name) in the command to install a hook.
+    If the configuration came from a signed commit, the signature could also be
+    shown.
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
+4. Disobedient contributors bypass local hooks and attempt to push changes that
+go against the project's standards. This could range from the mild issue of
+using different coding style or a more serious issue of checking in credentials
+or user data. Justification:
+    ** Projects should be using server-side checks to require checks, and the
+    addition of this feature doesn't change that. Proper documentation of how we
+    expect users to use this can help prevent users from misusing this feature.
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
+* Allow users to make trust decisions based on GPG signing e.g. if the
+configuration came from a signed commit, the signature could be shown along
+with the remote it came from.
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

base-commit: a5828ae6b52137b913b978e16cd2334482eb4c1f
-- 
gitgitgadget
