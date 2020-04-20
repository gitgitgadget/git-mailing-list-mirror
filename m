Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A81FC54FCB
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 23:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 015922064C
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 23:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HGjdHQwR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgDTXxW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 19:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725989AbgDTXxV (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Apr 2020 19:53:21 -0400
Received: from mail-ua1-x94a.google.com (mail-ua1-x94a.google.com [IPv6:2607:f8b0:4864:20::94a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC3FC061A0E
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 16:53:21 -0700 (PDT)
Received: by mail-ua1-x94a.google.com with SMTP id v27so5625372uaa.22
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 16:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=y4qX2zn+HQyj3v4521mMm8yD2bnKxtKHhI13NupAT5c=;
        b=HGjdHQwR3Q4ZNmr0R6PpvA/lF0EVFYojOfIlzJGZUlJl0PGgFKJxIeIj5hqDEzh0DQ
         2CzNWL0x6QWyiFEMbOZMmVtrF6jyNaGGu6ZaZ4tKEeiMcYF6ZJZ/ILMsBlHRtPg3+RQZ
         K8kKdSS22EYHCkhCPzZWd5lZRUVY4WdevMjr7/VfrY1LW4Yxg0Oj0+wdIhavyaB/UHwW
         BGBOO0jIyov60f1WqRX7+dFyDZ/L2Xq7MKVw/vlS3pM18eXuY+IXur2GI8uB0hvkTact
         eyR0AK0TazKSuSdaDw+F9HVGaA2L7bxLrctc5HHHN7Ymo9D6iyXFLWvHllPYKdwkc1WR
         DOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=y4qX2zn+HQyj3v4521mMm8yD2bnKxtKHhI13NupAT5c=;
        b=Ep+YGusCb5pEmTeyp6DIFCtW0OFIrSGGalNFCUwHmQ4ZHe+3mDiYNuYGQi6FujiHDq
         pOHvw5HLK2WolJVCbz9SAdr74nGfDoADGx3TQVgSGlE/SDsk+zg7wkxirzzOcDom8Cdq
         YiYoMS6AnEYMFi8UHFfx8tpoSIJbrwufXhivO0LTBGl4Qw6C7KPUiECCrD/yXQFsyHal
         y/wuB4KgXKc9LaQQIKqyopbiAbFTahGiqJQrKLMFqKjjg2sLI7O63KCK2Oe1Bf7wxEXK
         pLvvuMTb5x+XhKZ+rZtb5MeubSwIbaxwnbakBcD41fGPBH91Cga3P8EqqB5IZPhgpTI5
         WHiw==
X-Gm-Message-State: AGi0PuYhJcZv/WVGJpGplehM4R268jdLF1yVUtpu8lO9tIJApSEVP0bo
        vF8BptlyUVlU4n6lOLSibnX5IhkWjIIAONAYD9KmTTNKy/l+NeqRa5SqK52moqn/eAAgoEDKOKO
        J/juDXdLlMdvZE/YRRST9nxCEe7R9Bc140Kd/RmAnZO6q3YVKA0rK8bLPi+PE41fjG5rUVa3flA
        ==
X-Google-Smtp-Source: APiQypIwn2CW+4WUAgIJzhXfqkkL7Knw7kL6p+mMe63Sy5XJ7BqAYjryRKTu7HBxS6pza6sk7gwitdJ+nhMj0mNy638=
X-Received: by 2002:a1f:99d1:: with SMTP id b200mr6178665vke.95.1587426800321;
 Mon, 20 Apr 2020 16:53:20 -0700 (PDT)
Date:   Mon, 20 Apr 2020 16:53:10 -0700
In-Reply-To: <20200415205941.GB24777@google.com>
Message-Id: <20200420235310.94493-1-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20191210023335.49987-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH] doc: propose hooks managed by the config
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Begin a design document for config-based hooks, managed via git-hook.
Focus on an overview of the implementation and motivation for design
decisions. Briefly discuss the alternatives considered before this
point. Also, attempt to redefine terms to fit into a multihook world.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
Hi all,

I wasn't sure whether it made more sense to leave the design doc in the
conversation or not, but I figured it fit well into the context. I tried
to also add relevant IDs to the "References" headers to this mail.

Hopefully this is complete enough that we can discuss it directly until
we feel comfortable getting ready for implementation. I'm planning to
send a reply today with some comments, too.

 - Emily

 Documentation/Makefile                        |   1 +
 .../technical/config-based-hooks.txt          | 317 ++++++++++++++++++
 2 files changed, 318 insertions(+)
 create mode 100644 Documentation/technical/config-based-hooks.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 8fe829cc1b..301111f236 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -79,6 +79,7 @@ SP_ARTICLES += $(API_DOCS)
 TECH_DOCS += MyFirstContribution
 TECH_DOCS += MyFirstObjectWalk
 TECH_DOCS += SubmittingPatches
+TECH_DOCS += technical/config-based-hooks
 TECH_DOCS += technical/hash-function-transition
 TECH_DOCS += technical/http-protocol
 TECH_DOCS += technical/index-format
diff --git a/Documentation/technical/config-based-hooks.txt b/Documentation/technical/config-based-hooks.txt
new file mode 100644
index 0000000000..38893423be
--- /dev/null
+++ b/Documentation/technical/config-based-hooks.txt
@@ -0,0 +1,317 @@
+Configuration-based hook management
+===================================
+
+== Motivation
+
+Treat hooks as a first-class citizen by replacing the .git/hook/hookname path as
+the only source of hooks to execute, in a way which is friendly to users with
+multiple repos which have similar needs.
+
+Redefine "hook" as an event rather than a single script, allowing users to
+perform unrelated actions on a single event.
+
+Take a step closer to safety when copying zipped Git repositories from untrusted
+users.
+
+Make it easier for users to discover Git's hook feature and automate their
+workflows.
+
+== User interfaces
+
+=== Config schema
+
+Hooks can be introduced by editing the configuration manually. There are two new
+sections added, `hook` and `hookcmd`.
+
+==== `hook`
+
+Primarily contains subsections for each hook event. These subsections define
+hook command execution order; hook commands can be specified by passing the
+command directly if no additional configuration is needed, or by passing the
+name of a `hookcmd`. If Git does not find a `hookcmd` whose subsection matches
+the value of the given command string, Git will try to execute the string
+directly. Hook event subsections can also contain per-hook-event settings.
+
+Also contains top-level hook execution settings, for example,
+`hook.warnHookDir`, `hook.runHookDir`, or `hook.disableAll`.
+
+----
+[hook "pre-commit"]
+  command = perl-linter
+  command = /usr/bin/git-secrets --pre-commit
+
+[hook "pre-applypatch"]
+  command = perl-linter
+  error = ignore
+
+[hook]
+  warnHookDir = true
+  runHookDir = prompt
+----
+
+==== `hookcmd`
+
+Defines a hook command and its attributes, which will be used when a hook event
+occurs. Unqualified attributes are assumed to apply to this hook during all hook
+events, but event-specific attributes can also be supplied. The example runs
+`/usr/bin/lint-it --language=perl <args passed by Git>`, but for repos which
+include this config, the hook command will be skipped for all events to which
+it's normally subscribed _except_ `pre-commit`.
+
+----
+[hookcmd "perl-linter"]
+  command = /usr/bin/lint-it --language=perl
+  skip = true
+  pre-commit-skip = false
+----
+
+=== Command-line API
+
+Users should be able to view, reorder, and create hook commands via the command
+line. External tools should be able to view a list of hooks in the correct order
+to run.
+
+*`git hook list <hook-event>`*
+
+*`git hook list (--system|--global|--local|--worktree)`*
+
+*`git hook edit <hook-event>`*
+
+*`git hook add <hook-command> <hook-event> <options...>`*
+
+=== Hook editor
+
+The tool which is presented by `git hook edit <hook-command>`. Ideally, this
+tool should be easier to use than manually editing the config, and then produce
+a concise config afterwards. It may take a form similar to `git rebase
+--interactive`.
+
+== Implementation
+
+=== Library
+
+`hook.c` and `hook.h` are responsible for interacting with the config files. In
+the case when the code generating a hook event doesn't have special concerns
+about how to run the hooks, the hook library will provide a basic API to call
+all hooks in config order with an `argv_array` provided by the code which
+generates the hook event:
+
+*`int run_hooks(const char *hookname, struct argv_array *args)`*
+
+This call includes the hook command provided by `run-command.h:find_hook()`;
+eventually, this legacy hook will be gated by a config `hook.runHookDir`. The
+config is checked against a number of cases:
+
+- "no": the legacy hook will not be run
+- "interactive": Git will prompt the user before running the legacy hook
+- "warn": Git will print a warning to stderr before running the legacy hook
+- "yes" (default): Git will silently run the legacy hook
+
+If `hook.runHookDir` is provided more than once, Git will use the most
+restrictive setting provided, for security reasons.
+
+If the caller wants to do something more complicated, the hook library can also
+provide a callback API:
+
+*`int for_each_hookcmd(const char *hookname, hookcmd_function *cb)`*
+
+Finally, to facilitate the builtin, the library will also provide the following
+APIs to interact with the config:
+
+----
+int set_hook_commands(const char *hookname, struct string_list *commands,
+	enum config_scope scope);
+int set_hookcmd(const char *hookcmd, struct hookcmd options);
+
+int list_hook_commands(const char *hookname, struct string_list *commands);
+int list_hooks_in_scope(enum config_scope scope, struct string_list *commands);
+----
+
+`struct hookcmd` is expected to grow in size over time as more functionality is
+added to hooks; so that other parts of the code don't need to understand the
+config schema, `struct hookcmd` should contain logical values instead of string
+pairs.
+
+----
+struct hookcmd {
+  const char *name;
+  const char *command;
+
+  /* for illustration only; not planned at present */
+  int parallelizable;
+  const char *hookcmd_before;
+  const char *hookcmd_after;
+  enum recovery_action on_fail;
+}
+----
+
+=== Builtin
+
+`builtin/hook.c` is responsible for providing the frontend. It's responsible for
+formatting user-provided data and then calling the library API to set the
+configs as appropriate. The builtin frontend is not responsible for calling the
+config directly, so that other areas of Git can rely on the hook library to
+understand the most recent config schema for hooks.
+
+=== Migration path
+
+==== Stage 0
+
+Hooks are called by running `run-command.h:find_hook()` with the hookname and
+executing the result. The hook library and builtin do not exist. Hooks only
+exist as specially named scripts within `.git/hooks/`.
+
+==== Stage 1
+
+`git hook list --porcelain <hook-event>` is implemented. Users can replace their
+`.git/hooks/<hook-event>` scripts with a trampoline based on `git hook list`'s
+output. Modifier commands like `git hook add` and `git hook edit` can be
+implemented around this time as well.
+
+==== Stage 2
+
+`hook.h:run_hooks()` is taught to include `run-command.h:find_hook()` at the
+end; calls to `find_hook()` are replaced with calls to `run_hooks()`. Users can
+opt-in to config-based hooks simply by creating some in their config; otherwise
+users should remain unaffected by the change.
+
+==== Stage 3
+
+The call to `find_hook()` inside of `run_hooks()` learns to check for a config,
+`hook.runHookDir`. Users can opt into managing their hooks completely via the
+config this way.
+
+==== Stage 4
+
+`.git/hooks` is removed from the template and the hook directory is considered
+deprecated. To avoid breaking older repos, the default of `hook.runHookDir` is
+not changed, and `find_hook()` is not removed.
+
+== Caveats
+
+=== Security and repo config
+
+Part of the motivation behind this refactor is to mitigate hooks as an attack
+vector;footnote:[https://lore.kernel.org/git/20171002234517.GV19555@aiede.mtv.corp.google.com/]
+however, as the design stands, users can still provide hooks in the repo-level
+config, which is included when a repo is zipped and sent elsewhere.  The
+security of the repo-level config is still under discussion; this design
+generally assumes the repo-level config is secure, which is not true yet. The
+goal is to avoid an overcomplicated design to work around a problem which has
+ceased to exist.
+
+=== Ease of use
+
+The config schema is nontrivial; that's why it's important for the `git hook`
+modifier commands to be usable. Contributors with UX expertise are encouraged to
+share their suggestions.
+
+== Alternative approaches
+
+A previous summary of alternatives exists in the
+archives.footnote:[https://lore.kernel.org/git/20191116011125.GG22855@google.com]
+
+=== Status quo
+
+Today users can implement multihooks themselves by using a "trampoline script"
+as their hook, and pointing that script to a directory or list of other scripts
+they wish to run.
+
+=== Hook directories
+
+Other contributors have suggested Git learn about the existence of a directory
+such as `.git/hooks/<hookname>.d` and execute those hooks in alphabetical order.
+
+=== Comparison table
+
+.Comparison of alternatives
+|===
+|Feature |Config-based hooks |Hook directories |Status quo
+
+|Supports multiple hooks
+|Natively
+|Natively
+|With user effort
+
+|Safer for zipped repos
+|A little
+|No
+|No
+
+|Previous hooks just work
+|If configured
+|Yes
+|Yes
+
+|Can install one hook to many repos
+|Yes
+|No
+|No
+
+|Discoverability
+|Better (in `git help git`)
+|Same as before
+|Same as before
+
+|Hard to run unexpected hook
+|If configured
+|No
+|No
+|===
+
+== Future work
+
+=== Execution ordering
+
+We may find that config order is insufficient for some users; for example,
+config order makes it difficult to add a new hook to the system or global config
+which runs at the end of the hook list. A new ordering schema should be:
+
+1) Specified by a `hook.order` config, so that users will not unexpectedly see
+their order change;
+
+2) Either dependency or numerically based.
+
+Dependency-based ordering is prone to classic linked-list problems, like a
+cycles and handling of missing dependencies. But, it paves the way for enabling
+parallelization if some tasks truly depend on others.
+
+Numerical ordering makes it tricky for Git to generate suggested ordering
+numbers for each command, but is easy to determine a definitive order.
+
+=== Parallelization
+
+Users with many hooks might want to run them simultaneously, if the hooks don't
+modify state; if one hook depends on another's output, then users will want to
+specify those dependencies. If we decide to solve this problem, we may want to
+look to modern build systems for inspiration on how to manage dependencies and
+parallel tasks.
+
+=== Securing hookdir hooks
+
+With the design as written in this doc, it's still possible for a malicious user
+to modify `.git/config` to include `hook.pre-receive.command = rm -rf /`, then
+zip their repo and send it to another user. It may be necessary to teach Git to
+only allow one-line hooks like this if they were configured outside of the local
+scope; or another approach, like a list of safe projects, might be useful. It
+may also be sufficient (or at least useful) to teach a `hook.disableAll` config
+or similar flag to the Git executable.
+
+=== Submodule inheritance
+
+It's possible some submodules may want to run the identical set of hooks that
+their superrepo runs. While a globally-configured hook set is helpful, it's not
+a great solution for users who have multiple repos-with-submodules under the
+same user. It would be useful for submodules to learn how to run hooks from
+their superrepo's config, or inherit that hook setting.
+
+== Glossary
+
+*hook event*
+
+A point during Git's execution where user scripts may be run, for example,
+_prepare-commit-msg_ or _pre-push_.
+
+*hook command*
+
+A user script or executable which will be run on one or more hook events.
-- 
2.26.1.301.g55bc3eb7cb9-goog

