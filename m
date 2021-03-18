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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8603EC433E0
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 22:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44CC964F30
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 22:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhCRWDu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 18:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbhCRWDj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 18:03:39 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E50C06174A
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 15:03:38 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id k128so2021629wmk.4
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 15:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=wCMDPjI6XIt0i45pJHIHNTvDBEMWptwSvUefng+m3mM=;
        b=Rgx8/g/Lm+ml/OV8Of1NTQeVcDItcqcfPVi/vDvXLYaGa+QnMJcZFEmKY+jbKXFnF1
         CH4pOC1kJ3PLIIE514nlbbU5HmlONx0I6oOJyNNj/gjE0mOlw+e1yjyLcFAXLshqM3o5
         rju9RPFS8aGkdGbXq5V3rNRA/zxvxadPeESVv4RwilyNj+x7Ue0+fukbIieGPsJD4Ggq
         PO45MKsAbAgWqsz/tuHOt45qz9bctEfMAdgn/v46ig93Ki3kfUo9jFYiLY5A6m3couYP
         mOZutXoT+sAiKKxyMFO07sp7WqVP7o6B0c5NjKuxClgcQ5u1bGHfcM96MUmqOkPgT5o3
         Mi9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wCMDPjI6XIt0i45pJHIHNTvDBEMWptwSvUefng+m3mM=;
        b=EWGQt0ErMuKEKo15cbtBS69sEc6UVSiLgcbOlDer+5TQnezT3BqvFCMfX0M88XfZXq
         LzYih70AbsqGEfqC7Kncj5biO/4tJF8xHRiYd4hmu9Dv11Rc4wzRq2v1cYDf0JCAu/DI
         ExZ5HJ5bbukFh1TbtitKsURehxqdFg18hC+lyvAC4dSfw2o4Ivs6S/IxQOLbjWjVbADz
         R8zRzQalw8oTy2tldoKB73X1Mukr3A+fs/Vgp3GuRWTEpl9KFXMZihSfgKDVjrc9qoe7
         SNMDPWJCOXTjCMgW+pJhTx0yvcw3NSeZS+xNk3NWsPBJMmDXRRIZ5FP+i6ZOlUA59bfo
         vJNg==
X-Gm-Message-State: AOAM530dXMf5xqzebJk9n0KZF60kRE3u0oJFPDrTGMWeujLZLjIalF/f
        08wZRGwwAjp8hd4L8tPpRjSxuPkLfCI=
X-Google-Smtp-Source: ABdhPJwAMQOk2qsyS91jdjAs6t1aESlqM8TwcVsgnIGMvSNXhVvzSp0UEUCkRg6ZE3OgZ5zmjiK5VA==
X-Received: by 2002:a1c:4e12:: with SMTP id g18mr996265wmh.56.1616105017187;
        Thu, 18 Mar 2021 15:03:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l8sm4732262wrx.83.2021.03.18.15.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 15:03:36 -0700 (PDT)
Message-Id: <pull.908.git.1616105016055.gitgitgadget@gmail.com>
From:   "Albert Cui via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Mar 2021 22:03:35 +0000
Subject: [PATCH] hooks: propose repository owner configured hooks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Albert Cui <albertqcui@gmail.com>,
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

We propose adding native Git functionality to allow project maintainers to
specify hooks that a user ought to install and utilize in their development
workflows. This patch documents the requirements we propose for this feature
as well as a design sketch for implementation.

Signed-off-by: Albert Cui <albertqcui@gmail.com>
Helped-by: Emily Shaffer <emilyshaffer@google.com>
---
    hooks: propose repository owner configured hooks
    
    Hooks today are configured at the repository level, making it difficult
    to share hooks across repositories. Configuration-based hook management,
    by moving hooks configuration to the config, makes this much easier.
    However, there is still no good way for project maintainers to encourage
    or enforce adoption of specific hook commands on specific hook events in
    a repository. As such, there are many tools that provide this
    functionality on top of Git.
    
    We propose adding native Git functionality to allow project maintainers
    to specify hooks that a user ought to install and utilize in their
    development workflows. This patch documents the requirements we propose
    for this feature as well as a design sketch for implementation.
    
    Signed-off-by: Albert Cui albertqcui@gmail.com Helped-by: Emily Shaffer
    emilyshaffer@google.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-908%2Falbertcui%2Fhooks-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-908/albertcui/hooks-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/908

 Documentation/Makefile                        |   1 +
 .../technical/repository-owner-hooks.txt      | 294 ++++++++++++++++++
 2 files changed, 295 insertions(+)
 create mode 100644 Documentation/technical/repository-owner-hooks.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 81d1bf7a049b..cdd52143f883 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -96,6 +96,7 @@ TECH_DOCS += technical/protocol-common
 TECH_DOCS += technical/protocol-v2
 TECH_DOCS += technical/racy-git
 TECH_DOCS += technical/reftable
+TECH_DOCS += technical/repository-owner-hooks
 TECH_DOCS += technical/send-pack-pipeline
 TECH_DOCS += technical/shallow
 TECH_DOCS += technical/signature-format
diff --git a/Documentation/technical/repository-owner-hooks.txt b/Documentation/technical/repository-owner-hooks.txt
new file mode 100644
index 000000000000..9d80c7b4c4c3
--- /dev/null
+++ b/Documentation/technical/repository-owner-hooks.txt
@@ -0,0 +1,294 @@
+Repository Owner Hooks Administration
+-------------------------------------
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
+* The `pre-commit` hook event: before committing, a developer may want to lint
+their changes to enforce certain code style and quality. If there are style
+issues, the developer may want the commit to fail so that they can fix the
+issues.
+
+* The `commit-msg` hook event: after committing, repository owners may want to
+enforce a certain commit message style. This may be out of necessity:
+https://www.gerritcodereview.com/[Gerrit Code Review], for example, requires
+each commit to have a Change-Id in the footer.
+
+* The `pre-push` hook: before pushing, repository owners may want to verify that
+pushes are going to the correct remote to prevent leaks.
+
+A common thread between these use cases is to enforce certain behavior across
+many developers working in the same code base, encouraging best practices and
+healthy code quality.
+
+Hooks today are configured at the repository level, making it difficult to share
+hooks across repositories.
+https://lore.kernel.org/git/20210311021037.3001235-2-emilyshaffer@google.com[Configuration-based
+hook management], by moving hooks configuration to the config, makes this much
+easier. However, there is still no good way for project maintainers to encourage
+or enforce adoption of specific hook commands on specific hook events in a
+repository. As such, there are many tools that provide this functionality on top
+of Git (see <<prior-art, Prior Art>>).
+
+We propose adding native Git functionality to allow project maintainers to
+specify hooks that a user ought to install and utilize in their development
+workflows.
+
+User Goals / Critical User Journeys
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+* As a repository owner / project maintainer,
+
+    ** I want to enforce code style so I require developers to use a
+    standardized linter.
+
+    ** I want to prevent leaks / share code widely so I check that developers
+    are uploading code to the right place.
+
+    ** I want this to just work for all the developers in my repository, without
+    needing to support them through configuration.
+
+* As a developer developing in a repository,
+
+    ** I want to set up my workspace
+
+    ** I want control over what code runs on my machine
+
+    ** I want to skip hooks from running (for various reasons)
+
+Design Principles
+~~~~~~~~~~~~~~~~~
+
+* *Make it easy:* Developers just want to get their work done. Introducing
+friction is bad, especially when it prevents development from even starting e.g.
+workspace set up.
+
+* *Treat hooks as software, not configuration:* We take seriously the
+responsibility that comes with causing arbitrary code to run on a user's
+machine. Such code needs to come from a reputable source, be automatically
+updated, and run with user consent.
+
+Feature Requirements
+~~~~~~~~~~~~~~~~~~~~
+
+Minimum Feature Set
+^^^^^^^^^^^^^^^^^^^
+
+* A repository owner can specify a configuration for what hook commands are
+enabled for what hook events
+
+* A repository owner can specify, in this configuration, where the hook
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
+* Users must explicitly approve hook execution at least once (yes/no)
+
+    ** This could happen during setup or at execution time
+
+    ** When a hook command changes, a user should re-approve execution (note:
+    implementation should not interfere with requirement listed in “Fast
+    Follows")
+
+    * Users do not need to run setup scripts to install hooks --- the setup flow
+    happens automatically at clone time
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
+Example workflow
+^^^^^^^^^^^^^^^^
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
