Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E23C4708F
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 07:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A7566139A
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 07:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbhFBH5j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 03:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhFBH5j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 03:57:39 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A6CC061574
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 00:55:54 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id g8so2519423ejx.1
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 00:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=3N8no+pmeb0TTScel8GoZmCqdvvhyPx09tbb+KLQOso=;
        b=NLFoErRW80EvMKwVdSDcjO5tHULGnYmMtbJ6fUjCLZLrau1KCbdG/mOUn6yJVj1pRo
         zL0YahxFwLZiPb6QmTgb8RtY3Zh97vMjLXCSNMNuHuiEgkVRhDDN5ex9L3JXgc6fkNuh
         X9zXlSPg0tAl+GojTnhVIY4Udqq0rY+YD6opK5/An7k2NCLglzkjJc30eLK2hdKxDFLV
         08fZZh7+X/O62UYEQgJB2h2lV/Mnjhq2+fwkhWVlNgYBhIDl+G6ykm6MX+93scLHxvIA
         HbiaZnNugXYynHWuuVR+XLfAkCyeGYsgMCsME8cLed65UDAYoXUP9JGZijI/YpP5BCbS
         Dskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=3N8no+pmeb0TTScel8GoZmCqdvvhyPx09tbb+KLQOso=;
        b=ClE9eF/gelCS6sjUQRBl0mI1RYFNqFDzHWBblM0epPO45c/UFgFJHBX3Dq94KeHWP5
         uTcX11XKnU91k+/R7x5sCsdoORiooSRPlAGeK3vq55B9SNECFYQnpNL9BXc3Zz23wijc
         oRZgwXYNH+2lLmMGCNhDyH3tacpolcWcSI7WrEj/kjPMC+k3maBTQAXVD+qQhlFDgriO
         AKPu5ZqLoG3F89jmLmfZhREHfWZv6yZs2zXAwiqOgr4XmCZhmO/ml9Na68hOj9M8o24I
         zx/UXp3z9EuViKBzFbi0eGSk2yeVU+/cl+ZfmXQ4ckXprVtD96znzYC527950FF+m5es
         8riw==
X-Gm-Message-State: AOAM5326csQ40MIK+VOJBuInXiOyxh1i5IUXyMXYvlIToKAMmITdG6c4
        ndERBYyEY/w0TK95TcGV79LeaxC5Ao4=
X-Google-Smtp-Source: ABdhPJz/feg3vxpsUeMTi8jx2BBQUGzjbsQ3Nq/jL3Ky3I+xvbiE8uOLP8KGS7uXgW8CGAs6mCsHZQ==
X-Received: by 2002:a17:906:c1ca:: with SMTP id bw10mr33810898ejb.512.1622620552185;
        Wed, 02 Jun 2021 00:55:52 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id b25sm806950edv.9.2021.06.02.00.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 00:55:51 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 00/31] minimal restart of "config-based-hooks"
Date:   Wed, 02 Jun 2021 09:46:09 +0200
References: <87lf80l1m6.fsf@evledraar.gmail.com>
 <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
 <YLZ5H2Muh39Q4M5T@google.com>
 <179668e9-008a-0b70-a193-b0a479ba0146@gmail.com>
 <60b71a37cb4aa_67d0208bf@natae.notmuch>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <60b71a37cb4aa_67d0208bf@natae.notmuch>
Message-ID: <871r9k8zui.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 02 2021, Felipe Contreras wrote:

> Derrick Stolee wrote:
>> On 6/1/2021 2:14 PM, Emily Shaffer wrote:
>> > On Fri, May 28, 2021 at 02:11:02PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>> >>
>> >> After suggesting[1] an another round that the config-based-hook
>> >> topic[2] should take a more incremental approach to reach its end goal
>> >> I thought I'd try hacking that up.
>>=20
>> I think sending this complete reorganization of a long-lived topic
>> is not helpful, especially because the end-to-end diff is significant.
>
> The end-to-end diff is significant because it's not the full patch
> series.
>
> Give me pointers to the two branches and I'll get you a patch series on
> top of =C3=86var's that gets you *exactly* zero end-to-end diff to Emily's
> series.

At https://github.com/avar/git this series is at
es-avar/config-based-hooks-2 (there's an unsubmitted *-3 with the minor
fix I already noted, pending any other feedback).

Then es/config-based-hooks-v9-basis-for-es-avar/config-based-hooks-2 is
Emily's v9 as applied by Junio, which is what I started work on. Right
now it's identical to Junio's (at https://github.com/gitster/git)
gitster/es/config-based-hooks, I just saved it away in case that branch
moves.

A diff --stat -p between es-avar/config-based-hooks-2~2 and that topic
follows, i.e. my topic submitted here minus my last two fixes-on-top
patches.

I.e. this would be more-or-less the diff we'd apply to get to the
end-state (minus reverting a few bugfixes etc. I made along the line,
e.g. I forgot to mention that I added the "git hook run
--ignore-missing" to fix another TOCTOU race, except one introduced by
Emily's series).

 Documentation/Makefile                           |   1 +
 Documentation/config/hook.txt                    |  27 ++
 Documentation/git-hook.txt                       | 157 +++++++--
 Documentation/githooks.txt                       |  79 ++++-
 Documentation/technical/api-parse-options.txt    |   7 +
 Documentation/technical/config-based-hooks.txt   | 369 +++++++++++++++++++=
++
 builtin/am.c                                     |  27 +-
 builtin/bugreport.c                              |   2 +-
 builtin/checkout.c                               |   4 +-
 builtin/clone.c                                  |   3 +-
 builtin/commit.c                                 |  12 +-
 builtin/gc.c                                     |   3 +-
 builtin/hook.c                                   | 182 +++++++++--
 builtin/merge.c                                  |  13 +-
 builtin/pack-objects.c                           | 174 +---------
 builtin/rebase.c                                 |   3 +-
 builtin/receive-pack.c                           |  51 ++-
 builtin/worktree.c                               |   7 +-
 commit.c                                         |  10 +-
 commit.h                                         |   3 +-
 git-p4.py                                        |  13 +-
 git-send-email.perl                              |  35 +-
 git.c                                            |   2 +-
 hook.c                                           | 397 +++++++++++++++++++=
----
 hook.h                                           | 109 ++++---
 pack-objects.h                                   | 159 +++++++++
 parse-options-cb.c                               |  16 +
 parse-options.h                                  |   4 +
 perl/Git.pm                                      |  13 +
 read-cache.c                                     |   3 +-
 refs.c                                           |   8 +-
 reset.c                                          |   4 +-
 run-command.c                                    |   1 -
 sequencer.c                                      |  16 +-
 t/helper/test-parse-options.c                    |   6 +
 t/t0040-parse-options.sh                         |  27 ++
 t/t1092-sparse-checkout-compatibility.sh         |   6 +-
 t/t1350-config-hooks-path.sh                     |   1 -
 t/t1360-config-based-hooks.sh                    | 329 +++++++++++++++++++
 t/t1416-ref-transaction-hooks.sh                 |  12 +-
 t/t1800-hook.sh                                  | 158 ---------
 t/t2080-parallel-checkout-basics.sh              |   2 +-
 t/t5411/test-0015-too-many-hooks-error.sh        |  47 +++
 t/t6500-gc.sh                                    |  46 ---
 t/t7503-pre-commit-and-pre-merge-commit-hooks.sh |  17 +-
 t/t9001-send-email.sh                            |  16 +-
 transport.c                                      |   6 +-
 47 files changed, 1941 insertions(+), 646 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 2aae4c9cbb3..5d19eddb0eb 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -90,6 +90,7 @@ SP_ARTICLES +=3D $(API_DOCS)
 TECH_DOCS +=3D MyFirstContribution
 TECH_DOCS +=3D MyFirstObjectWalk
 TECH_DOCS +=3D SubmittingPatches
+TECH_DOCS +=3D technical/config-based-hooks
 TECH_DOCS +=3D technical/hash-function-transition
 TECH_DOCS +=3D technical/http-protocol
 TECH_DOCS +=3D technical/index-format
diff --git a/Documentation/config/hook.txt b/Documentation/config/hook.txt
new file mode 100644
index 00000000000..4f66bb35cf8
--- /dev/null
+++ b/Documentation/config/hook.txt
@@ -0,0 +1,27 @@
+hook.<command>.command::
+	A command to execute during the <command> hook event. This can be an
+	executable on your device, a oneliner for your shell, or the name of a
+	hookcmd. See linkgit:git-hook[1].
+
+hookcmd.<name>.command::
+	A command to execute during a hook for which <name> has been specified
+	as a command. This can be an executable on your device or a oneliner for
+	your shell. See linkgit:git-hook[1].
+
+hookcmd.<name>.skip::
+	Specify this boolean to remove a command from earlier in the execution
+	order. Useful if you want to make a single repo an exception to hook
+	configured at the system or global scope. If there is no hookcmd
+	specified for the command you want to skip, you can use the value of
+	`hook.<command>.command` as <name> as a shortcut. The "skip" setting
+	must be specified after the "hook.<command>.command" to have an effect.
+
+hook.runHookDir::
+	Controls how hooks contained in your hookdir are executed. Can be any of
+	"yes", "warn", "interactive", or "no". Defaults to "yes". See
+	linkgit:git-hook[1] and linkgit:git-config[1] "core.hooksPath").
+
+hook.jobs::
+	Specifies how many hooks can be run simultaneously during parallelized
+	hook execution. If unspecified, defaults to the number of processors on
+	the current system.
diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
index 816b3eda460..24e00a6f4af 100644
--- a/Documentation/git-hook.txt
+++ b/Documentation/git-hook.txt
@@ -3,46 +3,159 @@ git-hook(1)
=20
 NAME
 ----
-git-hook - run git hooks
+git-hook - Manage configured hooks
=20
 SYNOPSIS
 --------
 [verse]
-'git hook' run [--to-stdin=3D<path>] [--ignore-missing] <hook-name> [-- <h=
ook-args>]
+'git hook' list <hook-name>
+'git hook' run [(-e|--env)=3D<var>...] [(-a|--arg)=3D<arg>...] [--to-stdin=
=3D<path>]
+	[(-j|--jobs) <n>] <hook-name>
=20
 DESCRIPTION
 -----------
+You can list and run configured hooks with this command. Later, you will b=
e able
+to add and modify hooks with this command.
=20
-This command is an interface to git hooks (see linkgit:githooks[5]).
-Currently it only provides a convenience wrapper for running hooks for
-use by git itself. In the future it might gain other functionality.
+In general, when instructions suggest adding a script to
+`.git/hooks/<something>`, you can specify it in the config instead by runn=
ing
+`git config --add hook.<something>.command <path-to-script>` - this way yo=
u can
+share the script between multiple repos. That is, `cp ~/my-script.sh
+~/project/.git/hooks/pre-commit` would become `git config --add
+hook.pre-commit.command ~/my-script.sh`.
=20
-SUBCOMMANDS
------------
+This command parses the default configuration files for sections `hook` and
+`hookcmd`. `hook` is used to describe the commands which will be run durin=
g a
+particular hook event; commands are run in the order Git encounters them d=
uring
+the configuration parse (see linkgit:git-config[1]). `hookcmd` is used to
+describe attributes of a specific command. If additional attributes don't =
need
+to be specified, a command to run can be specified directly in the `hook`
+section; if a `hookcmd` by that name isn't found, Git will attempt to run =
the
+provided value directly. For example:
+
+Global config
+----
+  [hook "post-commit"]
+    command =3D "linter"
+    command =3D "~/typocheck.sh"
+
+  [hookcmd "linter"]
+    command =3D "/bin/linter --c"
+----
+
+Local config
+----
+  [hook "prepare-commit-msg"]
+    command =3D "linter"
+  [hook "post-commit"]
+    command =3D "python ~/run-test-suite.py"
+----
+
+With these configs, you'd then see:
+
+----
+$ git hook list "post-commit"
+global: /bin/linter --c
+global: ~/typocheck.sh
+local: python ~/run-test-suite.py
+
+$ git hook list "prepare-commit-msg"
+local: /bin/linter --c
+----
+
+If there is a command you wish to run in most cases but have one or two
+exceptional repos where it should be skipped, you can use specify
+`hookcmd.<name>.skip`, for example:
+
+System config
+----
+  [hook "pre-commit"]
+    command =3D check-for-secrets
+
+  [hookcmd "check-for-secrets"]
+    command =3D /bin/secret-checker --aggressive
+----
=20
-run::
+Local config
+----
+  [hookcmd "check-for-secrets"]
+    skip =3D true
+  # This works for inlined hook commands, too:
+  [hookcmd "~/typocheck.sh"]
+    skip =3D true
+----
=20
-	Run the `<hook-name>` hook. Any positional arguments to the
-	hook should be passed after an optional "--" (or
-	"--end-of-options"). See "OPTIONS" below for the arguments
-	this accepts.
+After these configs are added, the hook list becomes:
+
+----
+$ git hook list "post-commit"
+global: /bin/linter --c
+local: python ~/run-test-suite.py
+
+$ git hook list "pre-commit"
+no commands configured for hook 'pre-commit'
+----
+
+COMMANDS
+--------
+
+list `<hook-name>`::
+
+List the hooks which have been configured for `<hook-name>`. Hooks appear
+in the order they should be run, and print the config scope where the rele=
vant
+`hook.<hook-name>.command` was specified, not the `hookcmd` (if applicable=
).
+This output is human-readable and the format is subject to change over tim=
e.
+
+run [(-e|--env)=3D<var>...] [(-a|--arg)=3D<arg>...] [--to-stdin=3D<path>] =
[(-j|--jobs)<n>] `<hook-name>`::
+
+Runs hooks configured for `<hook-name>`, in the same order displayed by `g=
it
+hook list`. Hooks configured this way may be run prepended with `sh -c`, so
+paths containing special characters or spaces should be wrapped in single
+quotes: `command =3D '/my/path with spaces/script.sh' some args`.
=20
 OPTIONS
 -------
+--run-hookdir::
+	Overrides the hook.runHookDir config. Must be 'yes', 'warn',
+	'interactive', or 'no'. Specifies how to handle hooks located in the Git
+	hook directory (core.hooksPath).
+
+-a::
+--arg::
+	Only valid for `run`.
++
+Specify arguments to pass to every hook that is run.
+
+-e::
+--env::
+	Only valid for `run`.
++
+Specify environment variables to set for every hook that is run.
=20
 --to-stdin::
-	For "run"; Specify a file which will be streamed into the
-	hook's stdin. The hook will receive the entire file from
-	beginning to EOF.
+	Only valid for `run`.
++
+Specify a file which will be streamed into stdin for every hook that is ru=
n.
+Each hook will receive the entire file from beginning to EOF.
=20
---ignore-missing::
-	Ignore any missing hook by quietly returning zero. Used for
-	tools that want to do a blind one-shot run of a hook that may
-	or may not be present.
+-j::
+--jobs::
+	Only valid for `run`.
++
+Specify how many hooks to run simultaneously. If this flag is not specifie=
d, use
+the value of the `hook.jobs` config. If the config is not specified, use t=
he
+number of CPUs on the current system. Some hooks may be ineligible for
+parallelization: for example, 'commit-msg' intends hooks modify the commit
+message body and cannot be parallelized.
=20
-SEE ALSO
---------
-linkgit:githooks[5]
+HOOKS
+-----
+For a list of hooks which can be configured and how they work, see
+linkgit:githooks[5].
+
+CONFIGURATION
+-------------
+include::config/hook.txt[]
=20
 GIT
 ---
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index a16e62bc8c8..d780cb3b18d 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -7,15 +7,16 @@ githooks - Hooks used by Git
=20
 SYNOPSIS
 --------
+'git hook'
 $GIT_DIR/hooks/* (or \`git config core.hooksPath`/*)
=20
=20
 DESCRIPTION
 -----------
=20
-Hooks are programs you can place in a hooks directory to trigger
-actions at certain points in git's execution. Hooks that don't have
-the executable bit set are ignored.
+Hooks are programs you can specify in your config (see linkgit:git-hook[1]=
) or
+place in a hooks directory to trigger actions at certain points in git's
+execution. Hooks that don't have the executable bit set are ignored.
=20
 By default the hooks directory is `$GIT_DIR/hooks`, but that can be
 changed via the `core.hooksPath` configuration variable (see
@@ -58,6 +59,9 @@ the message file.
 The default 'applypatch-msg' hook, when enabled, runs the
 'commit-msg' hook, if the latter is enabled.
=20
+Hooks run during 'applypatch-msg' will not be parallelized, because hooks =
are
+expected to edit the file holding the commit log message.
+
 pre-applypatch
 ~~~~~~~~~~~~~~
=20
@@ -73,6 +77,9 @@ make a commit if it does not pass certain test.
 The default 'pre-applypatch' hook, when enabled, runs the
 'pre-commit' hook, if the latter is enabled.
=20
+Hooks run during 'pre-applypatch' will be run in parallel, unless hook.job=
s is
+configured to 1.
+
 post-applypatch
 ~~~~~~~~~~~~~~~
=20
@@ -82,6 +89,9 @@ and is invoked after the patch is applied and a commit is=
 made.
 This hook is meant primarily for notification, and cannot affect
 the outcome of `git am`.
=20
+Hooks run during 'post-applypatch' will be run in parallel, unless hook.jo=
bs is
+configured to 1.
+
 pre-commit
 ~~~~~~~~~~
=20
@@ -103,6 +113,8 @@ The default 'pre-commit' hook, when enabled--and with t=
he
 `hooks.allownonascii` config option unset or set to false--prevents
 the use of non-ASCII filenames.
=20
+Hooks executed during 'pre-commit' will not be parallelized.
+
 pre-merge-commit
 ~~~~~~~~~~~~~~~~
=20
@@ -125,6 +137,8 @@ need to be resolved and the result committed separately=
 (see
 linkgit:git-merge[1]). At that point, this hook will not be executed,
 but the 'pre-commit' hook will, if it is enabled.
=20
+Hooks executed during 'pre-merge-commit' will not be parallelized.
+
 prepare-commit-msg
 ~~~~~~~~~~~~~~~~~~
=20
@@ -150,6 +164,9 @@ be used as replacement for pre-commit hook.
 The sample `prepare-commit-msg` hook that comes with Git removes the
 help message found in the commented portion of the commit template.
=20
+Hooks executed during 'prepare-commit-msg' will not be parallelized, becau=
se
+hooks are expected to edit the file containing the commit log message.
+
 commit-msg
 ~~~~~~~~~~
=20
@@ -166,6 +183,9 @@ file.
 The default 'commit-msg' hook, when enabled, detects duplicate
 `Signed-off-by` trailers, and aborts the commit if one is found.
=20
+Hooks executed during 'commit-msg' will not be parallelized, because hooks=
 are
+expected to edit the file containing the proposed commit log message.
+
 post-commit
 ~~~~~~~~~~~
=20
@@ -175,6 +195,9 @@ invoked after a commit is made.
 This hook is meant primarily for notification, and cannot affect
 the outcome of `git commit`.
=20
+Hooks executed during 'post-commit' will run in parallel, unless hook.jobs=
 is
+configured to 1.
+
 pre-rebase
 ~~~~~~~~~~
=20
@@ -184,6 +207,9 @@ two parameters.  The first parameter is the upstream fr=
om which
 the series was forked.  The second parameter is the branch being
 rebased, and is not set when rebasing the current branch.
=20
+Hooks executed during 'pre-rebase' will run in parallel, unless hook.jobs =
is
+configured to 1.
+
 post-checkout
 ~~~~~~~~~~~~~
=20
@@ -206,6 +232,8 @@ This hook can be used to perform repository validity ch=
ecks, auto-display
 differences from the previous HEAD if different, or set working dir metada=
ta
 properties.
=20
+Hooks executed during 'post-checkout' will not be parallelized.
+
 post-merge
 ~~~~~~~~~~
=20
@@ -220,6 +248,9 @@ save and restore any form of metadata associated with t=
he working tree
 (e.g.: permissions/ownership, ACLS, etc).  See contrib/hooks/setgitperms.p=
erl
 for an example of how to do this.
=20
+Hooks executed during 'post-merge' will run in parallel, unless hook.jobs =
is
+configured to 1.
+
 pre-push
 ~~~~~~~~
=20
@@ -249,6 +280,9 @@ If this hook exits with a non-zero status, `git push` w=
ill abort without
 pushing anything.  Information about why the push is rejected may be sent
 to the user by writing to standard error.
=20
+Hooks executed during 'pre-push' will run in parallel, unless hook.jobs is
+configured to 1.
+
 [[pre-receive]]
 pre-receive
 ~~~~~~~~~~~
@@ -290,6 +324,8 @@ will be set to zero, `GIT_PUSH_OPTION_COUNT=3D0`.
 See the section on "Quarantine Environment" in
 linkgit:git-receive-pack[1] for some caveats.
=20
+Hooks executed during 'pre-receive' will not be parallelized.
+
 [[update]]
 update
 ~~~~~~
@@ -335,6 +371,9 @@ The default 'update' hook, when enabled--and with
 `hooks.allowunannotated` config option unset or set to false--prevents
 unannotated tags to be pushed.
=20
+Hooks executed during 'update' are run in parallel, unless hook.jobs is
+configured to 1.
+
 [[proc-receive]]
 proc-receive
 ~~~~~~~~~~~~
@@ -397,6 +436,10 @@ the input.  The exit status of the 'proc-receive' hook=
 only determines
 the success or failure of the group of commands sent to it, unless
 atomic push is in use.
=20
+It is forbidden to specify more than one hook for 'proc-receive'. If a
+globally-configured 'proc-receive' must be overridden, use
+'hookcmd.<global-hook>.skip =3D true' to ignore it.
+
 [[post-receive]]
 post-receive
 ~~~~~~~~~~~~
@@ -436,6 +479,9 @@ environment variables will not be set. If the client se=
lects
 to use push options, but doesn't transmit any, the count variable
 will be set to zero, `GIT_PUSH_OPTION_COUNT=3D0`.
=20
+Hooks executed during 'post-receive' are run in parallel, unless hook.jobs=
 is
+configured to 1.
+
 [[post-update]]
 post-update
 ~~~~~~~~~~~
@@ -468,6 +514,9 @@ Both standard output and standard error output are forw=
arded to
 `git send-pack` on the other end, so you can simply `echo` messages
 for the user.
=20
+Hooks run during 'post-update' will be run in parallel, unless hook.jobs is
+configured to 1.
+
 reference-transaction
 ~~~~~~~~~~~~~~~~~~~~~
=20
@@ -506,6 +555,9 @@ The exit status of the hook is ignored for any state ex=
cept for the
 cause the transaction to be aborted. The hook will not be called with
 "aborted" state in that case.
=20
+Hooks run during 'reference-transaction' will be run in parallel, unless
+hook.jobs is configured to 1.
+
 push-to-checkout
 ~~~~~~~~~~~~~~~~
=20
@@ -536,6 +588,7 @@ that switches branches while
 keeping the local changes in the working tree that do not interfere
 with the difference between the branches.
=20
+Hooks executed during 'push-to-checkout' will not be parallelized.
=20
 pre-auto-gc
 ~~~~~~~~~~~
@@ -544,6 +597,9 @@ This hook is invoked by `git gc --auto` (see linkgit:gi=
t-gc[1]). It
 takes no parameter, and exiting with non-zero status from this script
 causes the `git gc --auto` to abort.
=20
+Hooks run during 'pre-auto-gc' will be run in parallel, unless hook.jobs is
+configured to 1.
+
 post-rewrite
 ~~~~~~~~~~~~
=20
@@ -569,6 +625,9 @@ The hook always runs after the automatic note copying (=
see
 "notes.rewrite.<command>" in linkgit:git-config[1]) has happened, and
 thus has access to these notes.
=20
+Hooks run during 'post-rewrite' will be run in parallel, unless hook.jobs =
is
+configured to 1.
+
 The following command-specific comments apply:
=20
 rebase::
@@ -591,9 +650,12 @@ e-mails.
 fsmonitor-watchman
 ~~~~~~~~~~~~~~~~~~
=20
-This hook is invoked when the configuration option `core.fsmonitor` is
-set to `.git/hooks/fsmonitor-watchman` or `.git/hooks/fsmonitor-watchmanv2`
-depending on the version of the hook to use.
+This hook is invoked when the configuration option `core.fsmonitor` is set=
 to a
+path containing an executable. It *cannot* be specified via the usual
+`hook.fsmonitor-watchman.command` configuration or by providing an executa=
ble
+in `.git/hooks/fsmonitor-watchman`. The arguments provided to the hook are
+determined by the value of the `core.fsmonitorHookVersion` configuration
+option.
=20
 Version 1 takes two arguments, a version (1) and the time in elapsed
 nanoseconds since midnight, January 1, 1970.
@@ -698,9 +760,8 @@ and "0" meaning they were not.
 Only one parameter should be set to "1" when the hook runs.  The hook
 running passing "1", "1" should not be possible.
=20
-SEE ALSO
---------
-linkgit:git-hook[1]
+Hooks run during 'post-index-change' will be run in parallel, unless hook.=
jobs
+is configured to 1.
=20
 GIT
 ---
diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/=
technical/api-parse-options.txt
index 5a60bbfa7f4..f79b17e7fcd 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -173,6 +173,13 @@ There are some macros to easily define options:
 	The string argument is stored as an element in `string_list`.
 	Use of `--no-option` will clear the list of preceding values.
=20
+`OPT_STRVEC(short, long, &struct strvec, arg_str, description)`::
+	Introduce an option with a string argument, meant to be specified
+	multiple times.
+	The string argument is stored as an element in `strvec`, and later
+	arguments are added to the same `strvec`.
+	Use of `--no-option` will clear the list of preceding values.
+
 `OPT_INTEGER(short, long, &int_var, description)`::
 	Introduce an option with integer argument.
 	The integer is put into `int_var`.
diff --git a/Documentation/technical/config-based-hooks.txt b/Documentation=
/technical/config-based-hooks.txt
new file mode 100644
index 00000000000..1f973117e44
--- /dev/null
+++ b/Documentation/technical/config-based-hooks.txt
@@ -0,0 +1,369 @@
+Configuration-based hook management
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+:sectanchors:
+
+[[motivation]]
+=3D=3D Motivation
+
+Replace the `.git/hook/hookname` path as the only source of hooks to execu=
te;
+allow users to define hooks using config files, in a way which is friendly=
 to
+users with multiple repos which have similar needs - hooks can be easily s=
hared
+between multiple Git repos.
+
+Redefine "hook" as an event rather than a single script, allowing users to
+perform multiple unrelated actions on a single event.
+
+Make it easier for users to discover Git's hook feature and automate their
+workflows.
+
+[[user-interfaces]]
+=3D=3D User interfaces
+
+[[config-schema]]
+=3D=3D=3D Config schema
+
+Hooks can be introduced by editing the configuration manually. There are t=
wo new
+sections added, `hook` and `hookcmd`.
+
+[[config-schema-hook]]
+=3D=3D=3D=3D `hook`
+
+Primarily contains subsections for each hook event. The order of variables=
 in
+these subsections defines the hook command execution order; hook commands =
can be
+specified by setting the value directly to the command if no additional
+configuration is needed, or by setting the value as the name of a `hookcmd=
`. If
+Git does not find a `hookcmd` whose subsection matches the value of the gi=
ven
+command string, Git will try to execute the string directly. Hooks are exe=
cuted
+by passing the resolved command string to the shell. In the future, hook e=
vent
+subsections could also contain per-hook-event settings; see
+<<per-hook-event-settings,the section in Future Work>> for more details.
+
+Also contains top-level hook execution settings, for example, `hook.runHoo=
kDir`.
+(These settings are described more in <<library,Library>>.)
+
+----
+[hook "pre-commit"]
+  command =3D perl-linter
+  command =3D /usr/bin/git-secrets --pre-commit
+
+[hook "pre-applypatch"]
+  command =3D perl-linter
+  # for illustration purposes; error behavior isn't planned yet
+  error =3D ignore
+
+[hook]
+  runHookDir =3D interactive
+----
+
+[[config-schema-hookcmd]]
+=3D=3D=3D=3D `hookcmd`
+
+Defines a hook command and its attributes, which will be used when a hook =
event
+occurs. Unqualified attributes are assumed to apply to this hook during al=
l hook
+events, but event-specific attributes can also be supplied. The example ru=
ns
+`/usr/bin/lint-it --language=3Dperl <args passed by Git>`, but for repos w=
hich
+include this config, the hook command will be skipped for all events.
+Theoretically, the last line could be used to "un-skip" the hook command f=
or
+`pre-commit` hooks, but this hasn't been scoped or implemented yet.
+
+----
+[hookcmd "perl-linter"]
+  command =3D /usr/bin/lint-it --language=3Dperl
+  skip =3D true
+  # for illustration purposes; below hasn't been defined yet
+  pre-commit-skip =3D false
+----
+
+[[command-line-api]]
+=3D=3D=3D Command-line API
+
+Users should be able to view, run, reorder, and create hook commands via t=
he
+command line. External tools should be able to view a list of hooks in the
+correct order to run. Modifier commands (`edit` and `add`) have not been
+implemented yet and may not be if manually editing the config proves usable
+enough.
+
+*`git hook list <hook-event>`*
+
+*`git hook run <hook-event> [-a <arg>]... [-e <env-var>]...`*
+
+*`git hook edit <hook-event>`*
+
+*`git hook add <hook-command> <hook-event> <options...>`*
+
+[[hook-editor]]
+=3D=3D=3D Hook editor
+
+The tool which is presented by `git hook edit <hook-command>`. Ideally, th=
is
+tool should be easier to use than manually editing the config, and then pr=
oduce
+a concise config afterwards. It may take a form similar to `git rebase
+--interactive`. This has not been designed or implemented yet and may not =
be if
+the config proves usable enough.
+
+[[implementation]]
+=3D=3D Implementation
+
+[[library]]
+=3D=3D=3D Library
+
+`hook.c` and `hook.h` are responsible for interacting with the config file=
s. The
+hook library provides a basic API to call all hooks in config order with m=
ore
+complex options passed via `struct run_hooks_opt`:
+
+*`int run_hooks(const char *hookname, struct run_hooks_opt *options)`*
+
+`struct run_hooks_opt` allows callers to set:
+
+- environment variables
+- command-line arguments
+- behavior for the hook command provided by `run-command.h:find_hook()` (s=
ee
+  below)
+- a method to provide stdin to each hook, either via a file containing std=
in, a
+  `struct string_list` containing a list of lines to print, or a callback
+  function to allow the caller to populate stdin manually
+- a method to process stdout from each hook, e.g. for printing to sideband
+  during a network operation
+- parallelism
+- a custom working directory for hooks to execute in
+
+And this struct can be extended with more options as necessary in the futu=
re.
+
+The "legacy" hook provided by `run-command.h:find_hook()` - that is, the h=
ook
+present in `.git/hooks/<hookname>` or
+`$(git config --get core.hooksPath)/<hookname>` - can be handled in a numb=
er of
+ways, providing an avenue to deprecate these "legacy" hooks if desired. The
+handling is based on a config `hook.runHookDir`, which is checked against a
+number of cases:
+
+- "no": the legacy hook will not be run
+- "error": Git will print a warning to stderr before ignoring the legacy h=
ook
+- "interactive": Git will prompt the user before running the legacy hook
+- "warn": Git will print a warning to stderr before running the legacy hook
+- "yes" (default): Git will silently run the legacy hook
+
+In case this list is expanded in the future, if a value for `hook.runHookD=
ir` is
+given which Git does not recognize, Git should discard that config entry. =
For
+example, if "warn" was specified at system level and "junk" was specified =
at
+global level, Git would resolve the value to "warn"; if the only time the =
config
+was set was to "junk", Git would use the default value of "yes" (but print=
 a
+warning to the user first to let them know their value is wrong).
+
+`struct hookcmd` is expected to grow in size over time as more functionali=
ty is
+added to hooks; so that other parts of the code don't need to understand t=
he
+config schema, `struct hookcmd` should contain logical values instead of s=
tring
+pairs.
+
+By default, hook parallelism is chosen based on the semantics of each hook;
+callsites initialize their `struct run_hooks_opt` via one of two macros,
+`RUN_HOOKS_OPT_INIT_SYNC` or `RUN_HOOKS_OPT_INIT_ASYNC`. The default numbe=
r of
+jobs can be configured in `hook.jobs`; this config applies across all hook
+events. If unset, the value of `online_cpus()` (equivalent to `nproc`) is =
used.
+
+[[builtin]]
+=3D=3D=3D Builtin
+
+`builtin/hook.c` is responsible for providing the frontend. It's responsib=
le for
+formatting user-provided data and then calling the library API to set the
+configs as appropriate. The builtin frontend is not responsible for callin=
g the
+config directly, so that other areas of Git can rely on the hook library to
+understand the most recent config schema for hooks.
+
+[[migration]]
+=3D=3D=3D Migration path
+
+[[stage-0]]
+=3D=3D=3D=3D Stage 0
+
+Hooks are called by running `run-command.h:find_hook()` with the hookname =
and
+executing the result. The hook library and builtin do not exist. Hooks only
+exist as specially named scripts within `.git/hooks/`.
+
+[[stage-1]]
+=3D=3D=3D=3D Stage 1
+
+`git hook list --porcelain <hook-event>` is implemented. `hook.h:run_hooks=
()` is
+taught to include `run-command.h:find_hook()` at the end; calls to `find_h=
ook()`
+are replaced with calls to `run_hooks()`. Users can opt-in to config-based=
 hooks
+simply by creating some in their config; otherwise users should remain
+unaffected by the change.
+
+[[stage-2]]
+=3D=3D=3D=3D Stage 2
+
+The call to `find_hook()` inside of `run_hooks()` learns to check for a co=
nfig,
+`hook.runHookDir`. Users can opt into managing their hooks completely via =
the
+config this way.
+
+[[stage-3]]
+=3D=3D=3D=3D Stage 3
+
+`.git/hooks` is removed from the template and the hook directory is consid=
ered
+deprecated. To avoid breaking older repos, the default of `hook.runHookDir=
` is
+not changed, and `find_hook()` is not removed.
+
+[[caveats]]
+=3D=3D Caveats
+
+[[security]]
+=3D=3D=3D Security and repo config
+
+Part of the motivation behind this refactor is to mitigate hooks as an att=
ack
+vector.footnote:[https://lore.kernel.org/git/20171002234517.GV19555@aiede.=
mtv.corp.google.com/]
+However, as the design stands, users can still provide hooks in the repo-l=
evel
+config, which is included when a repo is zipped and sent elsewhere. The
+security of the repo-level config is still under discussion; this design
+generally assumes the repo-level config is secure, which is not true yet. =
This
+assumption was made to avoid overcomplicating the design. So, this series
+doesn't particularly improve security or resistance to zip attacks.
+
+[[ease-of-use]]
+=3D=3D=3D Ease of use
+
+The config schema is nontrivial; that's why it's important for the `git ho=
ok`
+modifier commands to be usable. Contributors with UX expertise are encoura=
ged to
+share their suggestions.
+
+[[alternatives]]
+=3D=3D Alternative approaches
+
+A previous summary of alternatives exists in the
+archives.footnote:[https://lore.kernel.org/git/20191116011125.GG22855@goog=
le.com]
+
+The table below shows a number of goals and how they might be achieved with
+config-based hooks, by implementing directory support (i.e.
+'.git/hooks/pre-commit.d'), or as hooks are run today.
+
+.Comparison of alternatives
+|=3D=3D=3D
+|Feature |Config-based hooks |Hook directories |Status quo
+
+|Supports multiple hooks
+|Natively
+|Natively
+|With user effort
+
+|Supports parallelization
+|Natively
+|Natively
+|No (user's multihook trampoline script would need to handle parallelism)
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
+|With symlinks or core.hooksPath
+|With symlinks or core.hooksPath
+
+|Discoverability
+|Findable with 'git help git' or tab-completion via 'git hook' subcommand
+|Findable via improved documentation
+|Same as before
+
+|Hard to run unexpected hook
+|If configured
+|Could be made to warn or look for a config
+|No
+|=3D=3D=3D
+
+[[status-quo]]
+=3D=3D=3D Status quo
+
+Today users can implement multihooks themselves by using a "trampoline scr=
ipt"
+as their hook, and pointing that script to a directory or list of other sc=
ripts
+they wish to run.
+
+[[hook-directories]]
+=3D=3D=3D Hook directories
+
+Other contributors have suggested Git learn about the existence of a direc=
tory
+such as `.git/hooks/<hookname>.d` and execute those hooks in alphabetical =
order.
+
+[[future-work]]
+=3D=3D Future work
+
+[[execution-ordering]]
+=3D=3D=3D Execution ordering
+
+We may find that config order is insufficient for some users; for example,
+config order makes it difficult to add a new hook to the system or global =
config
+which runs at the end of the hook list. A new ordering schema should be:
+
+1) Specified by a `hook.order` config, so that users will not unexpectedly=
 see
+their order change;
+
+2) Either dependency or numerically based.
+
+Dependency-based ordering is prone to classic linked-list problems, like a
+cycles and handling of missing dependencies. But, it paves the way for ena=
bling
+parallelization if some tasks truly depend on others.
+
+Numerical ordering makes it tricky for Git to generate suggested ordering
+numbers for each command, but is easy to determine a definitive order.
+
+[[parallelization]]
+=3D=3D=3D Parallelization with dependencies
+
+Currently hooks use a naive parallelization scheme or are run in series.  =
But if
+one hook depends on another's output, then users will want to specify those
+dependencies. If we decide to solve this problem, we may want to look to m=
odern
+build systems for inspiration on how to manage dependencies and parallel t=
asks.
+
+[[nontrivial-hooks]]
+=3D=3D=3D Multihooks and nontrivial output
+
+Some hooks - like 'proc-receive' - don't lend themselves well to multihook=
s at
+all. In the case of 'proc-receive', for now, multiple hook definitions are
+disallowed. In the future we might be able to conceive a better approach, =
for
+example, running the hooks in series and using the output from one hook as=
 the
+input to the next.
+
+[[securing-hookdir-hooks]]
+=3D=3D=3D Securing hookdir hooks
+
+With the design as written in this doc, it's still possible for a maliciou=
s user
+to modify `.git/config` to include `hook.pre-receive.command =3D rm -rf /`=
, then
+zip their repo and send it to another user. It may be necessary to teach G=
it to
+only allow inlined hooks like this if they were configured outside of the =
local
+scope (in other words, only run hookcmds, and only allow hookcmds to be
+configured in global or system scope); or another approach, like a list of=
 safe
+projects, might be useful. It may also be sufficient (or at least useful) =
to
+teach a `hook.disableAll` config or similar flag to the Git executable.
+
+[[submodule-inheritance]]
+=3D=3D=3D Submodule inheritance
+
+It's possible some submodules may want to run the identical set of hooks t=
hat
+their superrepo runs. While a globally-configured hook set is helpful, it'=
s not
+a great solution for users who have multiple repos-with-submodules under t=
he
+same user. It would be useful for submodules to learn how to run hooks from
+their superrepo's config, or inherit that hook setting.
+
+[[per-hook-event-settings]]
+=3D=3D=3D Per-hook-event settings
+
+It might be desirable to keep settings specifically for some hook events, =
but
+not for others - for example, a user may wish to disable hookdir hooks for=
 all
+events but pre-commit, which they haven't had time to convert yet; or, a u=
ser
+may wish for execution order settings to differ based on hook event. In th=
at
+case, it would be useful to set something like `hook.pre-commit.executionO=
rder`
+which would not apply to the 'prepare-commit-msg' hook, for example.
+
+[[glossary]]
+=3D=3D Glossary
+
+*hook event*
+
+A point during Git's execution where user scripts may be run, for example,
+_prepare-commit-msg_ or _pre-push_.
+
+*hook command*
+
+A user script or executable which will be run on one or more hook events.
diff --git a/builtin/am.c b/builtin/am.c
index 6e4f9c80360..d2534f9a1ff 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -11,7 +11,6 @@
 #include "parse-options.h"
 #include "dir.h"
 #include "run-command.h"
-#include "hook.h"
 #include "quote.h"
 #include "tempfile.h"
 #include "lockfile.h"
@@ -34,6 +33,7 @@
 #include "string-list.h"
 #include "packfile.h"
 #include "repository.h"
+#include "hook.h"
=20
 /**
  * Returns the length of the first line of msg.
@@ -445,7 +445,9 @@ static void am_destroy(const struct am_state *state)
 static int run_applypatch_msg_hook(struct am_state *state)
 {
 	int ret;
-	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt;
+
+	run_hooks_opt_init_sync(&opt);
=20
 	assert(state->msg);
 	strvec_push(&opt.args, am_path(state, "final-commit"));
@@ -467,9 +469,11 @@ static int run_applypatch_msg_hook(struct am_state *st=
ate)
  */
 static int run_post_rewrite_hook(const struct am_state *state)
 {
-	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt;
 	int ret;
=20
+	run_hooks_opt_init_async(&opt);
+
 	strvec_push(&opt.args, "rebase");
 	opt.path_to_stdin =3D am_path(state, "rewritten");
=20
@@ -1602,14 +1606,17 @@ static void do_commit(const struct am_state *state)
 	struct commit_list *parents =3D NULL;
 	const char *reflog_msg, *author, *committer =3D NULL;
 	struct strbuf sb =3D STRBUF_INIT;
-	struct run_hooks_opt hook_opt_pre =3D RUN_HOOKS_OPT_INIT;
-	struct run_hooks_opt hook_opt_post =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt hook_opt;
+
+	run_hooks_opt_init_async(&hook_opt);
=20
-	if (run_hooks("pre-applypatch", &hook_opt_pre)) {
-		run_hooks_opt_clear(&hook_opt_pre);
+	if (run_hooks("pre-applypatch", &hook_opt)) {
+		run_hooks_opt_clear(&hook_opt);
 		exit(1);
 	}
=20
+	run_hooks_opt_clear(&hook_opt);
+
 	if (write_cache_as_tree(&tree, 0, NULL))
 		die(_("git write-tree failed to write a tree"));
=20
@@ -1659,10 +1666,10 @@ static void do_commit(const struct am_state *state)
 		fclose(fp);
 	}
=20
-	run_hooks("post-applypatch", &hook_opt_post);
+	run_hooks_opt_init_async(&hook_opt);
+	run_hooks("post-applypatch", &hook_opt);
=20
-	run_hooks_opt_clear(&hook_opt_pre);
-	run_hooks_opt_clear(&hook_opt_post);
+	run_hooks_opt_clear(&hook_opt);
 	strbuf_release(&sb);
 }
=20
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 941c8d5e270..190272ba70f 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -82,7 +82,7 @@ static void get_populated_hooks(struct strbuf *hook_info,=
 int nongit)
 	}
=20
 	for (i =3D 0; i < ARRAY_SIZE(hook); i++)
-		if (hook_exists(hook[i]))
+		if (hook_exists(hook[i], HOOKDIR_USE_CONFIG))
 			strbuf_addf(hook_info, "%s\n", hook[i]);
 }
=20
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 6205ace09f6..1797f05a50e 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -107,9 +107,11 @@ struct branch_info {
 static int post_checkout_hook(struct commit *old_commit, struct commit *ne=
w_commit,
 			      int changed)
 {
-	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt;
 	int rc;
=20
+	run_hooks_opt_init_sync(&opt);
+
 	/* "new_commit" can be NULL when checking out from the index before
 	   a commit exists. */
 	strvec_pushl(&opt.args,
diff --git a/builtin/clone.c b/builtin/clone.c
index 6687025bea5..2a2a03bf768 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -776,7 +776,7 @@ static int checkout(int submodule_progress)
 	struct tree *tree;
 	struct tree_desc t;
 	int err =3D 0;
-	struct run_hooks_opt hook_opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt hook_opt;
=20
 	if (option_no_checkout)
 		return 0;
@@ -822,6 +822,7 @@ static int checkout(int submodule_progress)
 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
=20
+	run_hooks_opt_init_sync(&hook_opt);
 	strvec_pushl(&hook_opt.args, oid_to_hex(null_oid()), oid_to_hex(&oid), "1=
", NULL);
 	err |=3D run_hooks("post-checkout", &hook_opt);
 	run_hooks_opt_clear(&hook_opt);
diff --git a/builtin/commit.c b/builtin/commit.c
index dad4e565443..7e01802961f 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -19,7 +19,6 @@
 #include "revision.h"
 #include "wt-status.h"
 #include "run-command.h"
-#include "hook.h"
 #include "refs.h"
 #include "log-tree.h"
 #include "strbuf.h"
@@ -37,6 +36,7 @@
 #include "help.h"
 #include "commit-reach.h"
 #include "commit-graph.h"
+#include "hook.h"
=20
 static const char * const builtin_commit_usage[] =3D {
 	N_("git commit [<options>] [--] <pathspec>..."),
@@ -729,7 +729,7 @@ static int prepare_to_commit(const char *index_file, co=
nst char *prefix,
 	/* This checks and barfs if author is badly specified */
 	determine_author_info(author_ident);
=20
-	if (!no_verify && run_commit_hook(use_editor, index_file, "pre-commit", N=
ULL))
+	if (!no_verify && run_commit_hook(use_editor, 0, index_file, "pre-commit"=
, NULL))
 		return 0;
=20
 	if (squash_message) {
@@ -1045,7 +1045,7 @@ static int prepare_to_commit(const char *index_file, =
const char *prefix,
 		return 0;
 	}
=20
-	if (!no_verify && hook_exists("pre-commit")) {
+	if (!no_verify && hook_exists("pre-commit", HOOKDIR_USE_CONFIG)) {
 		/*
 		 * Re-read the index as pre-commit hook could have updated it,
 		 * and write it out as a tree.  We must do this before we invoke
@@ -1060,7 +1060,7 @@ static int prepare_to_commit(const char *index_file, =
const char *prefix,
 		return 0;
 	}
=20
-	if (run_commit_hook(use_editor, index_file, "prepare-commit-msg",
+	if (run_commit_hook(use_editor, 0, index_file, "prepare-commit-msg",
 			    git_path_commit_editmsg(), hook_arg1, hook_arg2, NULL))
 		return 0;
=20
@@ -1077,7 +1077,7 @@ static int prepare_to_commit(const char *index_file, =
const char *prefix,
 	}
=20
 	if (!no_verify &&
-	    run_commit_hook(use_editor, index_file, "commit-msg", git_path_commit=
_editmsg(), NULL)) {
+	    run_commit_hook(use_editor, 0, index_file, "commit-msg", git_path_com=
mit_editmsg(), NULL)) {
 		return 0;
 	}
=20
@@ -1830,7 +1830,7 @@ int cmd_commit(int argc, const char **argv, const cha=
r *prefix)
=20
 	repo_rerere(the_repository, 0);
 	run_auto_maintenance(quiet);
-	run_commit_hook(use_editor, get_index_file(), "post-commit", NULL);
+	run_commit_hook(use_editor, 1, get_index_file(), "post-commit", NULL);
 	if (amend && !no_post_rewrite) {
 		commit_post_rewrite(the_repository, current_head, &oid);
 	}
diff --git a/builtin/gc.c b/builtin/gc.c
index a12641a691d..16890b097cd 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -349,7 +349,7 @@ static void add_repack_incremental_option(void)
=20
 static int need_to_gc(void)
 {
-	struct run_hooks_opt hook_opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt hook_opt;
=20
 	/*
 	 * Setting gc.auto to 0 or negative can disable the
@@ -397,6 +397,7 @@ static int need_to_gc(void)
 	else
 		return 0;
=20
+	run_hooks_opt_init_async(&hook_opt);
 	if (run_hooks("pre-auto-gc", &hook_opt)) {
 		run_hooks_opt_clear(&hook_opt);
 		return 0;
diff --git a/builtin/hook.c b/builtin/hook.c
index baaef4dce49..c79a961e801 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -7,53 +7,133 @@
 #include "strvec.h"
=20
 static const char * const builtin_hook_usage[] =3D {
-	N_("git hook run [--to-stdin=3D<path>] <hook-name> [-- <hook-args>]"),
+	N_("git hook list <hookname>"),
+	N_("git hook run [(-e|--env)=3D<var>...] [(-a|--arg)=3D<arg>...]"
+	   "[--to-stdin=3D<path>] [(-j|--jobs) <count>] <hookname>"),
 	NULL
 };
=20
+static enum hookdir_opt should_run_hookdir;
+
+static int list(int argc, const char **argv, const char *prefix)
+{
+	struct list_head *head, *pos;
+	const char *hookname =3D NULL;
+	struct strbuf hookdir_annotation =3D STRBUF_INIT;
+
+	struct option list_options[] =3D {
+		OPT_END(),
+	};
+
+	argc =3D parse_options(argc, argv, prefix, list_options,
+			     builtin_hook_usage, 0);
+
+	if (argc < 1) {
+		usage_msg_opt(_("You must specify a hook event name to list."),
+			      builtin_hook_usage, list_options);
+	}
+
+	hookname =3D argv[0];
+
+	head =3D hook_list(hookname);
+
+	if (list_empty(head)) {
+		printf(_("no commands configured for hook '%s'\n"),
+		       hookname);
+		return 0;
+	}
+
+	list_for_each(pos, head) {
+		struct hook *item =3D list_entry(pos, struct hook, list);
+		item =3D list_entry(pos, struct hook, list);
+		if (item) {
+			if (item->from_hookdir) {
+				/*
+				 * TRANSLATORS: do not translate 'hookdir' as
+				 * it matches the config setting.
+				 */
+				switch (should_run_hookdir) {
+				case HOOKDIR_NO:
+					printf(_("hookdir: %s (will not run)\n"),
+					       item->command.buf);
+					break;
+				case HOOKDIR_ERROR:
+					printf(_("hookdir: %s (will error and not run)\n"),
+					       item->command.buf);
+					break;
+				case HOOKDIR_INTERACTIVE:
+					printf(_("hookdir: %s (will prompt)\n"),
+					       item->command.buf);
+					break;
+				case HOOKDIR_WARN:
+					printf(_("hookdir: %s (will warn but run)\n"),
+					       item->command.buf);
+					break;
+				case HOOKDIR_YES:
+				/*
+				 * The default behavior should agree with
+				 * hook.c:configured_hookdir_opt(). HOOKDIR_UNKNOWN should just
+				 * do the default behavior.
+				 */
+				case HOOKDIR_UNKNOWN:
+				default:
+					printf(_("hookdir: %s\n"),
+						 item->command.buf);
+					break;
+				}
+			} else {
+				/*
+				 * TRANSLATORS: "<config scope>: <path>". Both fields
+				 * should be left untranslated; config scope matches the
+				 * output of 'git config --show-scope'. Marked for
+				 * translation to provide better RTL support later.
+				 */
+				printf(_("%s: %s\n"),
+					config_scope_name(item->origin),
+					item->command.buf);
+			}
+		}
+	}
+
+	clear_hook_list(head);
+	strbuf_release(&hookdir_annotation);
+
+	return 0;
+}
+
 static int run(int argc, const char **argv, const char *prefix)
 {
-	int i;
-	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
+	struct strbuf hookname =3D STRBUF_INIT;
+	struct run_hooks_opt opt;
 	int rc =3D 0;
-	int ignore_missing =3D 0;
-	const char *hook_name;
-	const char *hook_path;
=20
 	struct option run_options[] =3D {
-		OPT_BOOL(0, "ignore-missing", &ignore_missing,
-			 N_("exit quietly with a zero exit code if the requested hook cannot be=
 found")),
+		OPT_STRVEC('e', "env", &opt.env, N_("var"),
+			   N_("environment variables for hook to use")),
+		OPT_STRVEC('a', "arg", &opt.args, N_("args"),
+			   N_("argument to pass to hook")),
 		OPT_STRING(0, "to-stdin", &opt.path_to_stdin, N_("path"),
 			   N_("file to read into hooks' stdin")),
+		OPT_INTEGER('j', "jobs", &opt.jobs,
+			    N_("run up to <n> hooks simultaneously")),
 		OPT_END(),
 	};
=20
+	run_hooks_opt_init_async(&opt);
+
 	argc =3D parse_options(argc, argv, prefix, run_options,
-			     builtin_hook_usage, PARSE_OPT_KEEP_UNKNOWN | PARSE_OPT_KEEP_DASHDA=
SH);
-
-	if (argc > 2) {
-		if (strcmp(argv[2], "--") &&
-		    strcmp(argv[2], "--end-of-options"))
-			/* Having a -- for "run" is mandatory */
-			usage_with_options(builtin_hook_usage, run_options);
-		/* Add our arguments, start after -- */
-		for (i =3D 3 ; i < argc; i++)
-			strvec_push(&opt.args, argv[i]);
-	}
+			     builtin_hook_usage, 0);
=20
-	/* Need to take into account core.hooksPath */
-	git_config(git_default_config, NULL);
+	if (argc < 1)
+		usage_msg_opt(_("You must specify a hook event to run."),
+			      builtin_hook_usage, run_options);
=20
-	hook_name =3D argv[1];
-	hook_path =3D find_hook(hook_name);
-	if (!hook_path) {
-		if (ignore_missing)
-			return 0;
-		error("cannot find a hook named %s", hook_name);
-		return 1;
-	}
-	rc =3D run_found_hooks(hook_name, hook_path, &opt);
+	strbuf_addstr(&hookname, argv[0]);
+	opt.run_hookdir =3D should_run_hookdir;
=20
+	rc =3D run_hooks(hookname.buf, &opt);
+
+	strbuf_release(&hookname);
 	run_hooks_opt_clear(&opt);
=20
 	return rc;
@@ -61,12 +141,50 @@ static int run(int argc, const char **argv, const char=
 *prefix)
=20
 int cmd_hook(int argc, const char **argv, const char *prefix)
 {
+	const char *run_hookdir =3D NULL;
+
 	struct option builtin_hook_options[] =3D {
+		OPT_STRING(0, "run-hookdir", &run_hookdir, N_("option"),
+			   N_("what to do with hooks found in the hookdir")),
 		OPT_END(),
 	};
=20
-	if (!strcmp(argv[1], "run"))
+	argc =3D parse_options(argc, argv, prefix, builtin_hook_options,
+			     builtin_hook_usage, PARSE_OPT_KEEP_UNKNOWN);
+
+	/* after the parse, we should have "<command> <hookname> <args...>" */
+	if (argc < 2)
+		usage_with_options(builtin_hook_usage, builtin_hook_options);
+
+	git_config(git_default_config, NULL);
+
+
+	/* argument > config */
+	if (run_hookdir)
+		if (!strcmp(run_hookdir, "no"))
+			should_run_hookdir =3D HOOKDIR_NO;
+		else if (!strcmp(run_hookdir, "error"))
+			should_run_hookdir =3D HOOKDIR_ERROR;
+		else if (!strcmp(run_hookdir, "yes"))
+			should_run_hookdir =3D HOOKDIR_YES;
+		else if (!strcmp(run_hookdir, "warn"))
+			should_run_hookdir =3D HOOKDIR_WARN;
+		else if (!strcmp(run_hookdir, "interactive"))
+			should_run_hookdir =3D HOOKDIR_INTERACTIVE;
+		else
+			/*
+			 * TRANSLATORS: leave "yes/warn/interactive/no"
+			 * untranslated; the strings are compared literally.
+			 */
+			die(_("'%s' is not a valid option for --run-hookdir "
+			      "(yes, warn, interactive, no)"), run_hookdir);
+	else
+		should_run_hookdir =3D configured_hookdir_opt();
+
+	if (!strcmp(argv[0], "list"))
+		return list(argc, argv, prefix);
+	if (!strcmp(argv[0], "run"))
 		return run(argc, argv, prefix);
+
 	usage_with_options(builtin_hook_usage, builtin_hook_options);
-	return 1;
 }
diff --git a/builtin/merge.c b/builtin/merge.c
index a9363b94065..7a524cb3e35 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -13,7 +13,6 @@
 #include "builtin.h"
 #include "lockfile.h"
 #include "run-command.h"
-#include "hook.h"
 #include "diff.h"
 #include "diff-merges.h"
 #include "refs.h"
@@ -44,6 +43,7 @@
 #include "commit-reach.h"
 #include "wt-status.h"
 #include "commit-graph.h"
+#include "hook.h"
=20
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -448,7 +448,7 @@ static void finish(struct commit *head_commit,
 		   const struct object_id *new_head, const char *msg)
 {
 	struct strbuf reflog_message =3D STRBUF_INIT;
-	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt;
 	const struct object_id *head =3D &head_commit->object.oid;
=20
 	if (!msg)
@@ -490,6 +490,7 @@ static void finish(struct commit *head_commit,
 	}
=20
 	/* Run a post-merge hook */
+	run_hooks_opt_init_async(&opt);
 	strvec_push(&opt.args, squash ? "1" : "0");
 	run_hooks("post-merge", &opt);
 	run_hooks_opt_clear(&opt);
@@ -845,14 +846,14 @@ static void prepare_to_commit(struct commit_list *rem=
oteheads)
 	struct strbuf msg =3D STRBUF_INIT;
 	const char *index_file =3D get_index_file();
=20
-	if (!no_verify && run_commit_hook(0 < option_edit, index_file, "pre-merge=
-commit", NULL))
+	if (!no_verify && run_commit_hook(0 < option_edit, 0, index_file, "pre-me=
rge-commit", NULL))
 		abort_commit(remoteheads, NULL);
 	/*
 	 * Re-read the index as pre-merge-commit hook could have updated it,
 	 * and write it out as a tree.  We must do this before we invoke
 	 * the editor and after we invoke run_status above.
 	 */
-	if (hook_exists("pre-merge-commit"))
+	if (hook_exists("pre-merge-commit", HOOKDIR_USE_CONFIG))
 		discard_cache();
 	read_cache_from(index_file);
 	strbuf_addbuf(&msg, &merge_msg);
@@ -873,7 +874,7 @@ static void prepare_to_commit(struct commit_list *remot=
eheads)
 		append_signoff(&msg, ignore_non_trailer(msg.buf, msg.len), 0);
 	write_merge_heads(remoteheads);
 	write_file_buf(git_path_merge_msg(the_repository), msg.buf, msg.len);
-	if (run_commit_hook(0 < option_edit, get_index_file(), "prepare-commit-ms=
g",
+	if (run_commit_hook(0 < option_edit, 0, get_index_file(), "prepare-commit=
-msg",
 			    git_path_merge_msg(the_repository), "merge", NULL))
 		abort_commit(remoteheads, NULL);
 	if (0 < option_edit) {
@@ -881,7 +882,7 @@ static void prepare_to_commit(struct commit_list *remot=
eheads)
 			abort_commit(remoteheads, NULL);
 	}
=20
-	if (!no_verify && run_commit_hook(0 < option_edit, get_index_file(),
+	if (!no_verify && run_commit_hook(0 < option_edit, 0, get_index_file(),
 					  "commit-msg",
 					  git_path_merge_msg(the_repository), NULL))
 		abort_commit(remoteheads, NULL);
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index de00adbb9e0..6ded130e45b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -37,134 +37,6 @@
 #include "shallow.h"
 #include "promisor-remote.h"
=20
-/*
- * Objects we are going to pack are collected in the `to_pack` structure.
- * It contains an array (dynamically expanded) of the object data, and a m=
ap
- * that can resolve SHA1s to their position in the array.
- */
-static struct packing_data to_pack;
-
-static inline struct object_entry *oe_delta(
-		const struct packing_data *pack,
-		const struct object_entry *e)
-{
-	if (!e->delta_idx)
-		return NULL;
-	if (e->ext_base)
-		return &pack->ext_bases[e->delta_idx - 1];
-	else
-		return &pack->objects[e->delta_idx - 1];
-}
-
-static inline unsigned long oe_delta_size(struct packing_data *pack,
-					  const struct object_entry *e)
-{
-	if (e->delta_size_valid)
-		return e->delta_size_;
-
-	/*
-	 * pack->delta_size[] can't be NULL because oe_set_delta_size()
-	 * must have been called when a new delta is saved with
-	 * oe_set_delta().
-	 * If oe_delta() returns NULL (i.e. default state, which means
-	 * delta_size_valid is also false), then the caller must never
-	 * call oe_delta_size().
-	 */
-	return pack->delta_size[e - pack->objects];
-}
-
-unsigned long oe_get_size_slow(struct packing_data *pack,
-			       const struct object_entry *e);
-
-static inline unsigned long oe_size(struct packing_data *pack,
-				    const struct object_entry *e)
-{
-	if (e->size_valid)
-		return e->size_;
-
-	return oe_get_size_slow(pack, e);
-}
-
-static inline void oe_set_delta(struct packing_data *pack,
-				struct object_entry *e,
-				struct object_entry *delta)
-{
-	if (delta)
-		e->delta_idx =3D (delta - pack->objects) + 1;
-	else
-		e->delta_idx =3D 0;
-}
-
-static inline struct object_entry *oe_delta_sibling(
-		const struct packing_data *pack,
-		const struct object_entry *e)
-{
-	if (e->delta_sibling_idx)
-		return &pack->objects[e->delta_sibling_idx - 1];
-	return NULL;
-}
-
-static inline struct object_entry *oe_delta_child(
-		const struct packing_data *pack,
-		const struct object_entry *e)
-{
-	if (e->delta_child_idx)
-		return &pack->objects[e->delta_child_idx - 1];
-	return NULL;
-}
-
-static inline void oe_set_delta_child(struct packing_data *pack,
-				      struct object_entry *e,
-				      struct object_entry *delta)
-{
-	if (delta)
-		e->delta_child_idx =3D (delta - pack->objects) + 1;
-	else
-		e->delta_child_idx =3D 0;
-}
-
-static inline void oe_set_delta_sibling(struct packing_data *pack,
-					struct object_entry *e,
-					struct object_entry *delta)
-{
-	if (delta)
-		e->delta_sibling_idx =3D (delta - pack->objects) + 1;
-	else
-		e->delta_sibling_idx =3D 0;
-}
-
-static inline void oe_set_size(struct packing_data *pack,
-			       struct object_entry *e,
-			       unsigned long size)
-{
-	if (size < pack->oe_size_limit) {
-		e->size_ =3D size;
-		e->size_valid =3D 1;
-	} else {
-		e->size_valid =3D 0;
-		if (oe_get_size_slow(pack, e) !=3D size)
-			BUG("'size' is supposed to be the object size!");
-	}
-}
-
-static inline void oe_set_delta_size(struct packing_data *pack,
-				     struct object_entry *e,
-				     unsigned long size)
-{
-	if (size < pack->oe_delta_size_limit) {
-		e->delta_size_ =3D size;
-		e->delta_size_valid =3D 1;
-	} else {
-		packing_data_lock(pack);
-		if (!pack->delta_size)
-			ALLOC_ARRAY(pack->delta_size, pack->nr_alloc);
-		packing_data_unlock(pack);
-
-		pack->delta_size[e - pack->objects] =3D size;
-		e->delta_size_valid =3D 0;
-	}
-}
-
 #define IN_PACK(obj) oe_in_pack(&to_pack, obj)
 #define SIZE(obj) oe_size(&to_pack, obj)
 #define SET_SIZE(obj,size) oe_set_size(&to_pack, obj, size)
@@ -184,6 +56,13 @@ static const char *pack_usage[] =3D {
 	NULL
 };
=20
+/*
+ * Objects we are going to pack are collected in the `to_pack` structure.
+ * It contains an array (dynamically expanded) of the object data, and a m=
ap
+ * that can resolve SHA1s to their position in the array.
+ */
+static struct packing_data to_pack;
+
 static struct pack_idx_entry **written_list;
 static uint32_t nr_result, nr_written, nr_seen;
 static struct bitmap_index *bitmap_git;
@@ -422,17 +301,6 @@ static void copy_pack_data(struct hashfile *f,
 	}
 }
=20
-static inline int oe_size_greater_than(struct packing_data *pack,
-				       const struct object_entry *lhs,
-				       unsigned long rhs)
-{
-	if (lhs->size_valid)
-		return lhs->size_ > rhs;
-	if (rhs < pack->oe_size_limit) /* rhs < 2^x <=3D lhs ? */
-		return 1;
-	return oe_get_size_slow(pack, lhs) > rhs;
-}
-
 /* Return 0 if we will bust the pack-size limit */
 static unsigned long write_no_reuse_object(struct hashfile *f, struct obje=
ct_entry *entry,
 					   unsigned long limit, int usable_delta)
@@ -774,14 +642,6 @@ static int mark_tagged(const char *path, const struct =
object_id *oid, int flag,
 	return 0;
 }
=20
-static inline unsigned char oe_layer(struct packing_data *pack,
-				     struct object_entry *e)
-{
-	if (!pack->layer)
-		return 0;
-	return pack->layer[e - pack->objects];
-}
-
 static inline void add_to_write_order(struct object_entry **wo,
 			       unsigned int *endp,
 			       struct object_entry *e)
@@ -2371,26 +2231,6 @@ static pthread_mutex_t progress_mutex;
  * progress_mutex for protection.
  */
=20
-static inline int oe_size_less_than(struct packing_data *pack,
-				    const struct object_entry *lhs,
-				    unsigned long rhs)
-{
-	if (lhs->size_valid)
-		return lhs->size_ < rhs;
-	if (rhs < pack->oe_size_limit) /* rhs < 2^x <=3D lhs ? */
-		return 0;
-	return oe_get_size_slow(pack, lhs) < rhs;
-}
-
-static inline void oe_set_tree_depth(struct packing_data *pack,
-				     struct object_entry *e,
-				     unsigned int tree_depth)
-{
-	if (!pack->tree_depth)
-		CALLOC_ARRAY(pack->tree_depth, pack->nr_alloc);
-	pack->tree_depth[e - pack->objects] =3D tree_depth;
-}
-
 /*
  * Return the size of the object without doing any delta
  * reconstruction (so non-deltas are true object sizes, but deltas
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 2081f6fa8db..fe9f144cad6 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1314,7 +1314,7 @@ int cmd_rebase(int argc, const char **argv, const cha=
r *prefix)
 	char *squash_onto_name =3D NULL;
 	int reschedule_failed_exec =3D -1;
 	int allow_preemptive_ff =3D 1;
-	struct run_hooks_opt hook_opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt hook_opt;
 	struct option builtin_rebase_options[] =3D {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
@@ -2024,6 +2024,7 @@ int cmd_rebase(int argc, const char **argv, const cha=
r *prefix)
 	}
=20
 	/* If a hook exists, give it a chance to interrupt*/
+	run_hooks_opt_init_async(&hook_opt);
 	strvec_pushl(&hook_opt.args, options.upstream_arg, argc ? argv[0] : NULL,=
 NULL);
 	if (!ok_to_skip_pre_rebase &&
 	    run_hooks("pre-rebase", &hook_opt)) {
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index ec90e10477a..f44b58e456d 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -7,7 +7,6 @@
 #include "pkt-line.h"
 #include "sideband.h"
 #include "run-command.h"
-#include "hook.h"
 #include "exec-cmd.h"
 #include "commit.h"
 #include "object.h"
@@ -30,6 +29,7 @@
 #include "commit-reach.h"
 #include "worktree.h"
 #include "shallow.h"
+#include "hook.h"
=20
 static const char * const receive_pack_usage[] =3D {
 	N_("git receive-pack <git-dir>"),
@@ -910,11 +910,13 @@ static int run_receive_hook(struct command *commands,
 			    int skip_broken,
 			    const struct string_list *push_options)
 {
-	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt;
 	struct receive_hook_feed_context ctx;
 	int rc;
 	struct command *iter =3D commands;
=20
+	run_hooks_opt_init_async(&opt);
+
 	/* if there are no valid commands, don't invoke the hook at all. */
 	while (iter && skip_broken && (iter->error_string || iter->did_not_exist))
 		iter =3D iter->next;
@@ -956,9 +958,11 @@ static int run_receive_hook(struct command *commands,
=20
 static int run_update_hook(struct command *cmd)
 {
-	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt;
 	int code;
=20
+	run_hooks_opt_init_async(&opt);
+
 	strvec_pushl(&opt.args,
 		     cmd->ref_name,
 		     oid_to_hex(&cmd->old_oid),
@@ -1128,11 +1132,38 @@ static int run_proc_receive_hook(struct command *co=
mmands,
 	int version =3D 0;
 	int code;
=20
-	argv[0] =3D find_hook("proc-receive");
-	if (!argv[0]) {
+	struct hook *proc_receive =3D NULL;
+	struct list_head *pos, *hooks;
+
+	hooks =3D hook_list("proc-receive");
+
+	list_for_each(pos, hooks) {
+		if (proc_receive) {
+			rp_error("only one 'proc-receive' hook can be specified");
+			return -1;
+		}
+		proc_receive =3D list_entry(pos, struct hook, list);
+		/* check if the hookdir hook should be ignored */
+		if (proc_receive->from_hookdir) {
+			switch (configured_hookdir_opt()) {
+			case HOOKDIR_INTERACTIVE:
+			case HOOKDIR_NO:
+				proc_receive =3D NULL;
+				break;
+			default:
+				break;
+			}
+		}
+
+	}
+
+	if (!proc_receive) {
 		rp_error("cannot find hook 'proc-receive'");
 		return -1;
 	}
+
+
+	argv[0] =3D proc_receive->command.buf;
 	argv[1] =3D NULL;
=20
 	proc.argv =3D argv;
@@ -1442,7 +1473,9 @@ static const char *push_to_checkout(unsigned char *ha=
sh,
 				    struct strvec *env,
 				    const char *work_tree)
 {
-	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt;
+
+	run_hooks_opt_init_sync(&opt);
=20
 	strvec_pushf(env, "GIT_WORK_TREE=3D%s", absolute_path(work_tree));
 	strvec_pushv(&opt.env, env->v);
@@ -1477,7 +1510,7 @@ static const char *update_worktree(unsigned char *sha=
1, const struct worktree *w
=20
 	strvec_pushf(&env, "GIT_DIR=3D%s", absolute_path(git_dir));
=20
-	if (!hook_exists(push_to_checkout_hook))
+	if (!hook_exists(push_to_checkout_hook, HOOKDIR_USE_CONFIG))
 		retval =3D push_to_deploy(sha1, &env, work_tree);
 	else
 		retval =3D push_to_checkout(sha1, &env, work_tree);
@@ -1640,7 +1673,9 @@ static const char *update(struct command *cmd, struct=
 shallow_info *si)
 static void run_update_post_hook(struct command *commands)
 {
 	struct command *cmd;
-	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt;
+
+	run_hooks_opt_init_async(&opt);
=20
 	for (cmd =3D commands; cmd; cmd =3D cmd->next) {
 		if (cmd->error_string || cmd->did_not_exist)
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 2ad26a76f4c..017b2cfcb58 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -8,12 +8,12 @@
 #include "branch.h"
 #include "refs.h"
 #include "run-command.h"
-#include "hook.h"
 #include "sigchain.h"
 #include "submodule.h"
 #include "utf8.h"
 #include "worktree.h"
 #include "quote.h"
+#include "hook.h"
=20
 static const char * const worktree_usage[] =3D {
 	N_("git worktree add [<options>] <path> [<commit-ish>]"),
@@ -382,7 +382,9 @@ static int add_worktree(const char *path, const char *r=
efname,
 	 * is_junk is cleared, but do return appropriate code when hook fails.
 	 */
 	if (!ret && opts->checkout) {
-		struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
+		struct run_hooks_opt opt;
+
+		run_hooks_opt_init_sync(&opt);
=20
 		strvec_pushl(&opt.env, "GIT_DIR", "GIT_WORK_TREE", NULL);
 		strvec_pushl(&opt.args,
@@ -391,7 +393,6 @@ static int add_worktree(const char *path, const char *r=
efname,
 			     "1",
 			     NULL);
 		opt.dir =3D path;
-		opt.absolute_path =3D 1;
=20
 		ret =3D run_hooks("post-checkout", &opt);
=20
diff --git a/commit.c b/commit.c
index e8147a88fc6..0da5b7e7f1a 100644
--- a/commit.c
+++ b/commit.c
@@ -1696,13 +1696,19 @@ size_t ignore_non_trailer(const char *buf, size_t l=
en)
 	return boc ? len - boc : len - cutoff;
 }
=20
-int run_commit_hook(int editor_is_used, const char *index_file,
+int run_commit_hook(int editor_is_used, int parallelize, const char *index=
_file,
 		    const char *name, ...)
 {
-	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt;
 	va_list args;
 	const char *arg;
 	int ret;
+
+	run_hooks_opt_init_sync(&opt);
+
+	if (parallelize)
+		opt.jobs =3D configured_hook_jobs();
+
 	strvec_pushf(&opt.env, "GIT_INDEX_FILE=3D%s", index_file);
=20
 	/*
diff --git a/commit.h b/commit.h
index df42eb434f3..a90c094ec27 100644
--- a/commit.h
+++ b/commit.h
@@ -363,7 +363,8 @@ int compare_commits_by_commit_date(const void *a_, cons=
t void *b_, void *unused)
 int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_=
, void *unused);
=20
 LAST_ARG_MUST_BE_NULL
-int run_commit_hook(int editor_is_used, const char *index_file, const char=
 *name, ...);
+int run_commit_hook(int editor_is_used, int parallelize, const char *index=
_file,
+		    const char *name, ...);
=20
 /* Sign a commit or tag buffer, storing the result in a header. */
 int sign_with_header(struct strbuf *buf, const char *keyid);
diff --git a/git-p4.py b/git-p4.py
index e76d8df3139..7d770957719 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -207,12 +207,15 @@ def decode_path(path):
         return path
=20
 def run_git_hook(cmd, param=3D[]):
+    """Execute a hook if the hook exists."""
+    if not cmd:
+        return True
+
     """args are specified with -a <arg> -a <arg> -a <arg>"""
-    args =3D ['git', 'hook', 'run', '--ignore-missing', cmd]
-    if param:
-        args.append("--")
-        for p in param:
-            args.append(p)
+    args =3D (['git', 'hook', 'run'] +
+            ["-a" + arg for arg in param] +
+            [cmd])
+
     return subprocess.call(args) =3D=3D 0
=20
 def write_pipe(c, stdin):
diff --git a/git-send-email.perl b/git-send-email.perl
index 2ab8dfdbded..b55687453e0 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -213,13 +213,13 @@ sub format_2822_time {
 my $editor;
=20
 sub system_or_msg {
-	my ($args, $msg, $cmd_name) =3D @_;
+	my ($args, $msg) =3D @_;
 	system(@$args);
 	my $signalled =3D $? & 127;
 	my $exit_code =3D $? >> 8;
 	return unless $signalled or $exit_code;
=20
-	my @sprintf_args =3D ($cmd_name ? $cmd_name : $args->[0], $exit_code);
+	my @sprintf_args =3D ($args->[0], $exit_code);
 	if (defined $msg) {
 		# Quiet the 'redundant' warning category, except we
 		# need to support down to Perl 5.8, so we can't do a
@@ -1958,31 +1958,12 @@ sub unique_email_list {
 sub validate_patch {
 	my ($fn, $xfer_encoding) =3D @_;
=20
-	if ($repo) {
-		my $hook_name =3D 'sendemail-validate';
-		my $hooks_path =3D $repo->command_oneline('rev-parse', '--git-path', 'ho=
oks');
-		my $validate_hook =3D catfile($hooks_path, $hook_name);
-		my $hook_error;
-		if (-x $validate_hook) {
-			my $target =3D abs_path($fn);
-			# The hook needs a correct cwd and GIT_DIR.
-			my $cwd_save =3D cwd();
-			chdir($repo->wc_path() or $repo->repo_path())
-				or die("chdir: $!");
-			local $ENV{"GIT_DIR"} =3D $repo->repo_path();
-			my @validate_hook =3D ("git", "hook", "run", "--ignore-missing", $hook_=
name, "--", $target);
-			$hook_error =3D system_or_msg(\@validate_hook, undef,
-						       "git hook run $hook_name -- <patch>");
-			chdir($cwd_save) or die("chdir: $!");
-		}
-		if ($hook_error) {
-			$hook_error =3D sprintf(__("fatal: %s: rejected by %s hook\n" .
-						 $hook_error . "\n" .
-						 "warning: no patches were sent\n"),
-					      $fn, $hook_name);
-			die $hook_error;
-		}
-	}
+	my $target =3D abs_path($fn);
+
+	system_or_die(["git", "hook", "run", "sendemail-validate", "-j1", "-a", $=
target],
+		sprintf(__("fatal: %s: rejected by sendemail-validate hook\n" .
+			   "warning: no patches were sent\n"),
+		        $fn));
=20
 	# Any long lines will be automatically fixed if we use a suitable transfer
 	# encoding.
diff --git a/git.c b/git.c
index 540909c391f..39988ee3b02 100644
--- a/git.c
+++ b/git.c
@@ -538,7 +538,7 @@ static struct cmd_struct commands[] =3D {
 	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
 	{ "hash-object", cmd_hash_object },
 	{ "help", cmd_help },
-	{ "hook", cmd_hook, RUN_SETUP },
+	{ "hook", cmd_hook, RUN_SETUP_GENTLY },
 	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "init", cmd_init_db },
 	{ "init-db", cmd_init_db },
diff --git a/hook.c b/hook.c
index 17ae65eca31..ff80e52eddd 100644
--- a/hook.c
+++ b/hook.c
@@ -1,8 +1,224 @@
 #include "cache.h"
+
 #include "hook.h"
+#include "config.h"
 #include "run-command.h"
+#include "prompt.h"
+
+void free_hook(struct hook *ptr)
+{
+	if (ptr) {
+		strbuf_release(&ptr->command);
+		free(ptr->feed_pipe_cb_data);
+	}
+	free(ptr);
+}
+
+static struct hook * find_hook_by_command(struct list_head *head, const ch=
ar *command)
+{
+	struct list_head *pos =3D NULL, *tmp =3D NULL;
+	struct hook *found =3D NULL;
+
+	list_for_each_safe(pos, tmp, head) {
+		struct hook *it =3D list_entry(pos, struct hook, list);
+		if (!strcmp(it->command.buf, command)) {
+		    list_del(pos);
+		    found =3D it;
+		    break;
+		}
+	}
+	return found;
+}
+
+static void append_or_move_hook(struct list_head *head, const char *comman=
d)
+{
+	struct hook *to_add =3D find_hook_by_command(head, command);
+
+	if (!to_add) {
+		/* adding a new hook, not moving an old one */
+		to_add =3D xmalloc(sizeof(*to_add));
+		strbuf_init(&to_add->command, 0);
+		strbuf_addstr(&to_add->command, command);
+		to_add->from_hookdir =3D 0;
+		to_add->feed_pipe_cb_data =3D NULL;
+	}
+
+	/* re-set the scope so we show where an override was specified */
+	to_add->origin =3D current_config_scope();
+
+	list_add_tail(&to_add->list, head);
+}
+
+static void remove_hook(struct list_head *to_remove)
+{
+	struct hook *hook_to_remove =3D list_entry(to_remove, struct hook, list);
+	list_del(to_remove);
+	free_hook(hook_to_remove);
+}
+
+void clear_hook_list(struct list_head *head)
+{
+	struct list_head *pos, *tmp;
+	list_for_each_safe(pos, tmp, head)
+		remove_hook(pos);
+}
+
+struct hook_config_cb
+{
+	struct strbuf *hookname;
+	struct list_head *list;
+};
+
+static int hook_config_lookup(const char *key, const char *value, void *cb=
_data)
+{
+	struct hook_config_cb *data =3D cb_data;
+	const char *hook_key =3D data->hookname->buf;
+	struct list_head *head =3D data->list;
+
+	if (!strcmp(key, hook_key)) {
+		const char *command =3D value;
+		struct strbuf hookcmd_name =3D STRBUF_INIT;
+		int skip =3D 0;
+
+		/*
+		 * Check if we're removing that hook instead. Hookcmds are
+		 * removed by name, and inlined hooks are removed by command
+		 * content.
+		 */
+		strbuf_addf(&hookcmd_name, "hookcmd.%s.skip", command);
+		git_config_get_bool(hookcmd_name.buf, &skip);
+
+		/*
+		 * Check if a hookcmd with that name exists. If it doesn't,
+		 * 'git_config_get_value()' is documented not to touch &command,
+		 * so we don't need to do anything.
+		 */
+		strbuf_reset(&hookcmd_name);
+		strbuf_addf(&hookcmd_name, "hookcmd.%s.command", command);
+		git_config_get_value(hookcmd_name.buf, &command);
+
+		if (!command) {
+			strbuf_release(&hookcmd_name);
+			BUG("git_config_get_value overwrote a string it shouldn't have");
+		}
+
+		/*
+		 * TODO: implement an option-getting callback, e.g.
+		 *   get configs by pattern hookcmd.$value.*
+		 *   for each key+value, do_callback(key, value, cb_data)
+		 */
+
+		if (skip) {
+			struct hook *to_remove =3D find_hook_by_command(head, command);
+			if (to_remove)
+				remove_hook(&(to_remove->list));
+		} else {
+			append_or_move_hook(head, command);
+		}
+
+		strbuf_release(&hookcmd_name);
+	}
+
+	return 0;
+}
+
+enum hookdir_opt configured_hookdir_opt(void)
+{
+	const char *key;
+	if (git_config_get_value("hook.runhookdir", &key))
+		return HOOKDIR_YES; /* by default, just run it. */
+
+	if (!strcmp(key, "no"))
+		return HOOKDIR_NO;
+
+	if (!strcmp(key, "error"))
+		return HOOKDIR_ERROR;
+
+	if (!strcmp(key, "yes"))
+		return HOOKDIR_YES;
+
+	if (!strcmp(key, "warn"))
+		return HOOKDIR_WARN;
+
+	if (!strcmp(key, "interactive"))
+		return HOOKDIR_INTERACTIVE;
+
+	return HOOKDIR_UNKNOWN;
+}
+
+int configured_hook_jobs(void)
+{
+	int n =3D online_cpus();
+	git_config_get_int("hook.jobs", &n);
+
+	return n;
+}
+
+static int should_include_hookdir(const char *path, enum hookdir_opt cfg)
+{
+	struct strbuf prompt =3D STRBUF_INIT;
+	/*
+	 * If the path doesn't exist, don't bother adding the empty hook and
+	 * don't bother checking the config or prompting the user.
+	 */
+	if (!path)
+		return 0;
+
+	switch (cfg)
+	{
+	case HOOKDIR_ERROR:
+		fprintf(stderr, _("Skipping legacy hook at '%s'\n"),
+			path);
+		/* FALLTHROUGH */
+	case HOOKDIR_NO:
+		return 0;
+	case HOOKDIR_WARN:
+		fprintf(stderr, _("Running legacy hook at '%s'\n"),
+			path);
+		return 1;
+	case HOOKDIR_INTERACTIVE:
+		do {
+			/*
+			 * TRANSLATORS: Make sure to include [Y] and [n]
+			 * in your translation. Only English input is
+			 * accepted. Default option is "yes".
+			 */
+			fprintf(stderr, _("Run '%s'? [Y/n] "), path);
+			git_read_line_interactively(&prompt);
+			/*
+			 * In case of prompt =3D '' - that is, user hit enter,
+			 * saying "yes I want the default" - strncasecmp will
+			 * return 0 regardless. So list the default first.
+			 *
+			 * Case insensitively, accept "y", "ye", or "yes" as
+			 * "yes"; accept "n" or "no" as "no".
+			 */
+			if (!strncasecmp(prompt.buf, "yes", prompt.len)) {
+				strbuf_release(&prompt);
+				return 1;
+			} else if (!strncasecmp(prompt.buf, "no", prompt.len)) {
+				strbuf_release(&prompt);
+				return 0;
+			}
+			/* otherwise, we didn't understand the input */
+		} while (prompt.len); /* an empty reply means default (yes) */
+		return 1;
+	/*
+	 * HOOKDIR_UNKNOWN should match the default behavior, but let's
+	 * give a heads up to the user.
+	 */
+	case HOOKDIR_UNKNOWN:
+		fprintf(stderr,
+			_("Unrecognized value for 'hook.runHookDir'. "
+			  "Is there a typo? "));
+		/* FALLTHROUGH */
+	case HOOKDIR_YES:
+	default:
+		return 1;
+	}
+}
=20
-const char *find_hook(const char *name)
+static const char *find_legacy_hook(const char *name)
 {
 	static struct strbuf path =3D STRBUF_INIT;
=20
@@ -36,9 +252,77 @@ const char *find_hook(const char *name)
 	return path.buf;
 }
=20
-int hook_exists(const char *name)
+
+struct list_head* hook_list(const char* hookname)
+{
+	struct strbuf hook_key =3D STRBUF_INIT;
+	struct list_head *hook_head =3D xmalloc(sizeof(struct list_head));
+	struct hook_config_cb cb_data =3D { &hook_key, hook_head };
+
+	INIT_LIST_HEAD(hook_head);
+
+	if (!hookname)
+		return NULL;
+
+	strbuf_addf(&hook_key, "hook.%s.command", hookname);
+
+	git_config(hook_config_lookup, &cb_data);
+
+	if (have_git_dir()) {
+		const char *legacy_hook_path =3D find_legacy_hook(hookname);
+
+		/* Unconditionally add legacy hook, but annotate it. */
+		if (legacy_hook_path) {
+			struct hook *legacy_hook;
+
+			append_or_move_hook(hook_head,
+					    absolute_path(legacy_hook_path));
+			legacy_hook =3D list_entry(hook_head->prev, struct hook,
+						 list);
+			legacy_hook->from_hookdir =3D 1;
+		}
+	}
+
+	strbuf_release(&hook_key);
+	return hook_head;
+}
+
+void run_hooks_opt_init_sync(struct run_hooks_opt *o)
 {
-	return !!find_hook(name);
+	strvec_init(&o->env);
+	strvec_init(&o->args);
+	o->path_to_stdin =3D NULL;
+	o->run_hookdir =3D configured_hookdir_opt();
+	o->jobs =3D 1;
+	o->dir =3D NULL;
+	o->feed_pipe =3D NULL;
+	o->feed_pipe_ctx =3D NULL;
+	o->consume_sideband =3D NULL;
+}
+
+void run_hooks_opt_init_async(struct run_hooks_opt *o)
+{
+	run_hooks_opt_init_sync(o);
+	o->jobs =3D configured_hook_jobs();
+}
+
+int hook_exists(const char *hookname, enum hookdir_opt should_run_hookdir)
+{
+	const char *value =3D NULL; /* throwaway */
+	struct strbuf hook_key =3D STRBUF_INIT;
+	int could_run_hookdir;
+
+	if (should_run_hookdir =3D=3D HOOKDIR_USE_CONFIG)
+		should_run_hookdir =3D configured_hookdir_opt();
+
+	could_run_hookdir =3D (should_run_hookdir =3D=3D HOOKDIR_INTERACTIVE ||
+				should_run_hookdir =3D=3D HOOKDIR_WARN ||
+				should_run_hookdir =3D=3D HOOKDIR_YES)
+				&& !!find_legacy_hook(hookname);
+
+	strbuf_addf(&hook_key, "hook.%s.command", hookname);
+
+	return (!git_config_get_value(hook_key.buf, &value)) || could_run_hookdir;
 }
=20
 void run_hooks_opt_clear(struct run_hooks_opt *o)
@@ -51,8 +335,7 @@ int pipe_from_string_list(struct strbuf *pipe, void *pp_=
cb, void *pp_task_cb)
 {
 	int *item_idx;
 	struct hook *ctx =3D pp_task_cb;
-	struct hook_cb_data *hook_cb =3D pp_cb;
-	struct string_list *to_pipe =3D hook_cb->options->feed_pipe_ctx;
+	struct string_list *to_pipe =3D ((struct hook_cb_data*)pp_cb)->options->f=
eed_pipe_ctx;
=20
 	/* Bootstrap the state manager if necessary. */
 	if (!ctx->feed_pipe_cb_data) {
@@ -76,10 +359,10 @@ static int pick_next_hook(struct child_process *cp,
 			  void **pp_task_cb)
 {
 	struct hook_cb_data *hook_cb =3D pp_cb;
-	struct hook *run_me =3D hook_cb->run_me;
+	struct hook *hook =3D hook_cb->run_me;
=20
-	if (!run_me)
-		BUG("did we not return 1 in notify_hook_finished?");
+	if (!hook)
+		return 0;
=20
 	/* reopen the file for stdin; run_command closes it. */
 	if (hook_cb->options->path_to_stdin) {
@@ -92,13 +375,20 @@ static int pick_next_hook(struct child_process *cp,
 	} else {
 		cp->no_stdin =3D 1;
 	}
+
 	cp->env =3D hook_cb->options->env.v;
 	cp->stdout_to_stderr =3D 1;
-	cp->trace2_hook_name =3D hook_cb->hook_name;
+	cp->trace2_hook_name =3D hook_cb->hookname;
 	cp->dir =3D hook_cb->options->dir;
=20
+	/*
+	 * Commands from the config could be oneliners, but we know
+	 * for certain that hookdir commands are not.
+	 */
+	cp->use_shell =3D !hook->from_hookdir;
+
 	/* add command */
-	strvec_push(&cp->args, run_me->hook_path);
+	strvec_push(&cp->args, hook->command.buf);
=20
 	/*
 	 * add passed-in argv, without expanding - let the user get back
@@ -107,7 +397,14 @@ static int pick_next_hook(struct child_process *cp,
 	strvec_pushv(&cp->args, hook_cb->options->args.v);
=20
 	/* Provide context for errors if necessary */
-	*pp_task_cb =3D run_me;
+	*pp_task_cb =3D hook;
+
+	/* Get the next entry ready */
+	if (hook_cb->run_me->list.next =3D=3D hook_cb->head)
+		hook_cb->run_me =3D NULL;
+	else
+		hook_cb->run_me =3D list_entry(hook_cb->run_me->list.next,
+					     struct hook, list);
=20
 	return 1;
 }
@@ -122,10 +419,13 @@ static int notify_start_failure(struct strbuf *out,
 	/* |=3D rc in cb */
 	hook_cb->rc |=3D 1;
=20
-	strbuf_addf(out, _("Couldn't start hook '%s'\n"),
-		    attempted->hook_path);
+	strbuf_addf(out, _("Couldn't start '%s', configured in '%s'\n"),
+		    attempted->command.buf,
+		    attempted->from_hookdir ? "hookdir"
+			: config_scope_name(attempted->origin));
=20
-	return 1;
+	/* NEEDSWORK: if halt_on_error is desired, do it here. */
+	return 0;
 }
=20
 static int notify_hook_finished(int result,
@@ -138,29 +438,36 @@ static int notify_hook_finished(int result,
 	/* |=3D rc in cb */
 	hook_cb->rc |=3D result;
=20
-	return 1;
+	/* NEEDSWORK: if halt_on_error is desired, do it here. */
+	return 0;
 }
=20
-int run_found_hooks(const char *hook_name, const char *hook_path,
-		    struct run_hooks_opt *options)
-{
-	struct strbuf abs_path =3D STRBUF_INIT;
-	struct hook my_hook =3D {
-		.hook_path =3D hook_path,
-	};
-	struct hook_cb_data cb_data =3D {
-		.rc =3D 0,
-		.hook_name =3D hook_name,
-		.options =3D options,
-	};
-	if (options->absolute_path) {
-		strbuf_add_absolute_path(&abs_path, hook_path);
-		my_hook.hook_path =3D abs_path.buf;
+int run_hooks(const char *hookname, struct run_hooks_opt *options)
+{
+	struct list_head *to_run, *pos =3D NULL, *tmp =3D NULL;
+	struct hook_cb_data cb_data =3D { 0, hookname, NULL, NULL, options };
+
+	if (!options)
+		BUG("a struct run_hooks_opt must be provided to run_hooks");
+
+	if (options->path_to_stdin && options->feed_pipe)
+		BUG("choose only one method to populate stdin");
+
+	to_run =3D hook_list(hookname);
+
+	list_for_each_safe(pos, tmp, to_run) {
+		struct hook *hook =3D list_entry(pos, struct hook, list);
+
+		if (hook->from_hookdir &&
+		    !should_include_hookdir(hook->command.buf, options->run_hookdir))
+			    list_del(pos);
 	}
-	cb_data.run_me =3D &my_hook;
=20
-	if (options->jobs !=3D 1)
-		BUG("we do not handle %d or any other !=3D 1 job number yet", options->j=
obs);
+	if (list_empty(to_run))
+		return 0;
+
+	cb_data.head =3D to_run;
+	cb_data.run_me =3D list_entry(to_run->next, struct hook, list);
=20
 	run_processes_parallel_tr2(options->jobs,
 				   pick_next_hook,
@@ -170,29 +477,7 @@ int run_found_hooks(const char *hook_name, const char =
*hook_path,
 				   notify_hook_finished,
 				   &cb_data,
 				   "hook",
-				   hook_name);
-	if (options->absolute_path)
-		strbuf_release(&abs_path);
+				   hookname);
=20
 	return cb_data.rc;
 }
-
-int run_hooks(const char *hook_name, struct run_hooks_opt *options)
-{
-	const char *hook_path;
-	int ret;
-	if (!options)
-		BUG("a struct run_hooks_opt must be provided to run_hooks");
-
-	if (options->path_to_stdin && options->feed_pipe)
-		BUG("choose only one method to populate stdin");
-
-	hook_path =3D find_hook(hook_name);
-
-	/* Care about nonexistence? Use run_found_hooks() */
-	if (!hook_path)
-		return 0;
-
-	ret =3D run_found_hooks(hook_name, hook_path, options);
-	return ret;
-}
diff --git a/hook.h b/hook.h
index 5f895032341..f32189380a8 100644
--- a/hook.h
+++ b/hook.h
@@ -1,12 +1,19 @@
-#ifndef HOOK_H
-#define HOOK_H
+#include "config.h"
+#include "list.h"
 #include "strbuf.h"
 #include "strvec.h"
 #include "run-command.h"
=20
 struct hook {
-	/* The path to the hook */
-	const char *hook_path;
+	struct list_head list;
+	/*
+	 * Config file which holds the hook.*.command definition.
+	 * (This has nothing to do with the hookcmd.<name>.* configs.)
+	 */
+	enum config_scope origin;
+	/* The literal command to run. */
+	struct strbuf command;
+	unsigned from_hookdir : 1;
=20
 	/*
 	 * Use this to keep state for your feed_pipe_fn if you are using
@@ -15,6 +22,32 @@ struct hook {
 	void *feed_pipe_cb_data;
 };
=20
+/*
+ * Provides a linked list of 'struct hook' detailing commands which should=
 run
+ * in response to the 'hookname' event, in execution order.
+ */
+struct list_head* hook_list(const char *hookname);
+
+enum hookdir_opt
+{
+	HOOKDIR_USE_CONFIG,
+	HOOKDIR_NO,
+	HOOKDIR_ERROR,
+	HOOKDIR_WARN,
+	HOOKDIR_INTERACTIVE,
+	HOOKDIR_YES,
+	HOOKDIR_UNKNOWN,
+};
+
+/*
+ * Provides the hookdir_opt specified in the config without consulting any
+ * command line arguments.
+ */
+enum hookdir_opt configured_hookdir_opt(void);
+
+/* Provides the number of threads to use for parallel hook execution. */
+int configured_hook_jobs(void);
+
 struct run_hooks_opt
 {
 	/* Environment vars to be set for each hook */
@@ -23,20 +56,15 @@ struct run_hooks_opt
 	/* Args to be passed to each hook */
 	struct strvec args;
=20
-	/* Number of threads to parallelize across */
-	int jobs;
-
-	/* Resolve and run the "absolute_path(hook)" instead of
-	 * "hook". Used for "git worktree" hooks
+	/*
+	 * How should the hookdir be handled?
+	 * Leave the run_hooks_opt_init_*() default in most cases; this only needs
+	 * to be overridden if the user can override it at the command line.
 	 */
-	int absolute_path;
-
-	/* Path to initial working directory for subprocess */
-	const char *dir;
+	enum hookdir_opt run_hookdir;
=20
 	/* Path to file which should be piped to stdin for each hook */
 	const char *path_to_stdin;
-
 	/*
 	 * Callback and state pointer to ask for more content to pipe to stdin.
 	 * Will be called repeatedly, for each hook. See
@@ -57,13 +85,14 @@ struct run_hooks_opt
 	 * for an example.
 	 */
 	consume_sideband_fn consume_sideband;
-};
=20
-#define RUN_HOOKS_OPT_INIT { \
-	.jobs =3D 1, \
-	.env =3D STRVEC_INIT, \
-	.args =3D STRVEC_INIT, \
-}
+	/* Number of threads to parallelize across */
+	int jobs;
+
+	/* Path to initial working directory for subprocess */
+	const char *dir;
+
+};
=20
 /*
  * To specify a 'struct string_list', set 'run_hooks_opt.feed_pipe_ctx' to=
 the
@@ -78,35 +107,33 @@ int pipe_from_string_list(struct strbuf *pipe, void *p=
p_cb, void *pp_task_cb);
  */
 struct hook_cb_data {
 	int rc;
-	const char *hook_name;
+	const char *hookname;
+	struct list_head *head;
 	struct hook *run_me;
 	struct run_hooks_opt *options;
 };
=20
-/*
- * Returns the path to the hook file, or NULL if the hook is missing
- * or disabled. Note that this points to static storage that will be
- * overwritten by further calls to find_hook and run_hook_*.
- */
-const char *find_hook(const char *name);
-
-/*
- * A boolean version of find_hook()
- */
-int hook_exists(const char *hookname);
-
+void run_hooks_opt_init_sync(struct run_hooks_opt *o);
+void run_hooks_opt_init_async(struct run_hooks_opt *o);
 void run_hooks_opt_clear(struct run_hooks_opt *o);
=20
 /*
- * Calls find_hook(hookname) and runs the hooks (if any) with
- * run_found_hooks().
+ * Returns 1 if any hooks are specified in the config or if a hook exists =
in the
+ * hookdir. Typically, invoke hook_exsts() like:
+ *   hook_exists(hookname, configured_hookdir_opt());
+ * Like with run_hooks, if you take a --run-hookdir flag, reflect that
+ * user-specified behavior here instead.
  */
-int run_hooks(const char *hook_name, struct run_hooks_opt *options);
+int hook_exists(const char *hookname, enum hookdir_opt should_run_hookdir);
=20
 /*
- * Takes an already resolved hook and runs it. Internally the simpler
- * run_hooks() will call this.
+ * Runs all hooks associated to the 'hookname' event in order. Each hook w=
ill be
+ * passed 'env' and 'args'. The file at 'stdin_path' will be closed and re=
opened
+ * for each hook that runs.
  */
-int run_found_hooks(const char *hookname, const char *hook_path,
-		    struct run_hooks_opt *options);
-#endif
+int run_hooks(const char *hookname, struct run_hooks_opt *options);
+
+/* Free memory associated with a 'struct hook' */
+void free_hook(struct hook *ptr);
+/* Empties the list at 'head', calling 'free_hook()' on each entry */
+void clear_hook_list(struct list_head *head);
diff --git a/pack-objects.h b/pack-objects.h
index dca2351ef94..9d88e3e518f 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -268,10 +268,152 @@ static inline void oe_set_in_pack(struct packing_dat=
a *pack,
 	pack->in_pack[e - pack->objects] =3D p;
 }
=20
+static inline struct object_entry *oe_delta(
+		const struct packing_data *pack,
+		const struct object_entry *e)
+{
+	if (!e->delta_idx)
+		return NULL;
+	if (e->ext_base)
+		return &pack->ext_bases[e->delta_idx - 1];
+	else
+		return &pack->objects[e->delta_idx - 1];
+}
+
+static inline void oe_set_delta(struct packing_data *pack,
+				struct object_entry *e,
+				struct object_entry *delta)
+{
+	if (delta)
+		e->delta_idx =3D (delta - pack->objects) + 1;
+	else
+		e->delta_idx =3D 0;
+}
+
 void oe_set_delta_ext(struct packing_data *pack,
 		      struct object_entry *e,
 		      const struct object_id *oid);
=20
+static inline struct object_entry *oe_delta_child(
+		const struct packing_data *pack,
+		const struct object_entry *e)
+{
+	if (e->delta_child_idx)
+		return &pack->objects[e->delta_child_idx - 1];
+	return NULL;
+}
+
+static inline void oe_set_delta_child(struct packing_data *pack,
+				      struct object_entry *e,
+				      struct object_entry *delta)
+{
+	if (delta)
+		e->delta_child_idx =3D (delta - pack->objects) + 1;
+	else
+		e->delta_child_idx =3D 0;
+}
+
+static inline struct object_entry *oe_delta_sibling(
+		const struct packing_data *pack,
+		const struct object_entry *e)
+{
+	if (e->delta_sibling_idx)
+		return &pack->objects[e->delta_sibling_idx - 1];
+	return NULL;
+}
+
+static inline void oe_set_delta_sibling(struct packing_data *pack,
+					struct object_entry *e,
+					struct object_entry *delta)
+{
+	if (delta)
+		e->delta_sibling_idx =3D (delta - pack->objects) + 1;
+	else
+		e->delta_sibling_idx =3D 0;
+}
+
+unsigned long oe_get_size_slow(struct packing_data *pack,
+			       const struct object_entry *e);
+static inline unsigned long oe_size(struct packing_data *pack,
+				    const struct object_entry *e)
+{
+	if (e->size_valid)
+		return e->size_;
+
+	return oe_get_size_slow(pack, e);
+}
+
+static inline int oe_size_less_than(struct packing_data *pack,
+				    const struct object_entry *lhs,
+				    unsigned long rhs)
+{
+	if (lhs->size_valid)
+		return lhs->size_ < rhs;
+	if (rhs < pack->oe_size_limit) /* rhs < 2^x <=3D lhs ? */
+		return 0;
+	return oe_get_size_slow(pack, lhs) < rhs;
+}
+
+static inline int oe_size_greater_than(struct packing_data *pack,
+				       const struct object_entry *lhs,
+				       unsigned long rhs)
+{
+	if (lhs->size_valid)
+		return lhs->size_ > rhs;
+	if (rhs < pack->oe_size_limit) /* rhs < 2^x <=3D lhs ? */
+		return 1;
+	return oe_get_size_slow(pack, lhs) > rhs;
+}
+
+static inline void oe_set_size(struct packing_data *pack,
+			       struct object_entry *e,
+			       unsigned long size)
+{
+	if (size < pack->oe_size_limit) {
+		e->size_ =3D size;
+		e->size_valid =3D 1;
+	} else {
+		e->size_valid =3D 0;
+		if (oe_get_size_slow(pack, e) !=3D size)
+			BUG("'size' is supposed to be the object size!");
+	}
+}
+
+static inline unsigned long oe_delta_size(struct packing_data *pack,
+					  const struct object_entry *e)
+{
+	if (e->delta_size_valid)
+		return e->delta_size_;
+
+	/*
+	 * pack->delta_size[] can't be NULL because oe_set_delta_size()
+	 * must have been called when a new delta is saved with
+	 * oe_set_delta().
+	 * If oe_delta() returns NULL (i.e. default state, which means
+	 * delta_size_valid is also false), then the caller must never
+	 * call oe_delta_size().
+	 */
+	return pack->delta_size[e - pack->objects];
+}
+
+static inline void oe_set_delta_size(struct packing_data *pack,
+				     struct object_entry *e,
+				     unsigned long size)
+{
+	if (size < pack->oe_delta_size_limit) {
+		e->delta_size_ =3D size;
+		e->delta_size_valid =3D 1;
+	} else {
+		packing_data_lock(pack);
+		if (!pack->delta_size)
+			ALLOC_ARRAY(pack->delta_size, pack->nr_alloc);
+		packing_data_unlock(pack);
+
+		pack->delta_size[e - pack->objects] =3D size;
+		e->delta_size_valid =3D 0;
+	}
+}
+
 static inline unsigned int oe_tree_depth(struct packing_data *pack,
 					 struct object_entry *e)
 {
@@ -280,6 +422,23 @@ static inline unsigned int oe_tree_depth(struct packin=
g_data *pack,
 	return pack->tree_depth[e - pack->objects];
 }
=20
+static inline void oe_set_tree_depth(struct packing_data *pack,
+				     struct object_entry *e,
+				     unsigned int tree_depth)
+{
+	if (!pack->tree_depth)
+		CALLOC_ARRAY(pack->tree_depth, pack->nr_alloc);
+	pack->tree_depth[e - pack->objects] =3D tree_depth;
+}
+
+static inline unsigned char oe_layer(struct packing_data *pack,
+				     struct object_entry *e)
+{
+	if (!pack->layer)
+		return 0;
+	return pack->layer[e - pack->objects];
+}
+
 static inline void oe_set_layer(struct packing_data *pack,
 				struct object_entry *e,
 				unsigned char layer)
diff --git a/parse-options-cb.c b/parse-options-cb.c
index 3c811e1e4a7..8227499eb6f 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -207,6 +207,22 @@ int parse_opt_string_list(const struct option *opt, co=
nst char *arg, int unset)
 	return 0;
 }
=20
+int parse_opt_strvec(const struct option *opt, const char *arg, int unset)
+{
+	struct strvec *v =3D opt->value;
+
+	if (unset) {
+		strvec_clear(v);
+		return 0;
+	}
+
+	if (!arg)
+		return -1;
+
+	strvec_push(v, arg);
+	return 0;
+}
+
 int parse_opt_noop_cb(const struct option *opt, const char *arg, int unset)
 {
 	return 0;
diff --git a/parse-options.h b/parse-options.h
index a845a9d9527..fcb0f1f31eb 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -178,6 +178,9 @@ struct option {
 #define OPT_STRING_LIST(s, l, v, a, h) \
 				    { OPTION_CALLBACK, (s), (l), (v), (a), \
 				      (h), 0, &parse_opt_string_list }
+#define OPT_STRVEC(s, l, v, a, h) \
+				    { OPTION_CALLBACK, (s), (l), (v), (a), \
+				      (h), 0, &parse_opt_strvec }
 #define OPT_UYN(s, l, v, h)         { OPTION_CALLBACK, (s), (l), (v), NULL=
, \
 				      (h), PARSE_OPT_NOARG, &parse_opt_tertiary }
 #define OPT_EXPIRY_DATE(s, l, v, h) \
@@ -297,6 +300,7 @@ int parse_opt_commits(const struct option *, const char=
 *, int);
 int parse_opt_commit(const struct option *, const char *, int);
 int parse_opt_tertiary(const struct option *, const char *, int);
 int parse_opt_string_list(const struct option *, const char *, int);
+int parse_opt_strvec(const struct option *, const char *, int);
 int parse_opt_noop_cb(const struct option *, const char *, int);
 enum parse_opt_result parse_opt_unknown_cb(struct parse_opt_ctx_t *ctx,
 					   const struct option *,
diff --git a/perl/Git.pm b/perl/Git.pm
index 02eacef0c2a..73ebbf80cc6 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -619,6 +619,19 @@ sub _prompt {
=20
 sub repo_path { $_[0]->{opts}->{Repository} }
=20
+=3Ditem hooks_path ()
+
+Return path to the hooks directory. Must be called on a repository instanc=
e.
+
+=3Dcut
+
+sub hooks_path {
+	my ($self) =3D @_;
+
+	my $dir =3D $self->command_oneline('rev-parse', '--git-path', 'hooks');
+	my $abs =3D abs_path($dir);
+	return $abs;
+}
=20
 =3Ditem wc_path ()
=20
diff --git a/read-cache.c b/read-cache.c
index a17bc30f870..ebb9c190562 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3132,7 +3132,7 @@ static int do_write_locked_index(struct index_state *=
istate, struct lock_file *l
 {
 	int ret;
 	int was_full =3D !istate->sparse_index;
-	struct run_hooks_opt hook_opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt hook_opt;
=20
 	ret =3D convert_to_sparse(istate);
=20
@@ -3161,6 +3161,7 @@ static int do_write_locked_index(struct index_state *=
istate, struct lock_file *l
 	else
 		ret =3D close_lock_file_gently(lock);
=20
+	run_hooks_opt_init_async(&hook_opt);
 	strvec_pushl(&hook_opt.args,
 		     istate->updated_workdir ? "1" : "0",
 		     istate->updated_skipworktree ? "1" : "0",
diff --git a/refs.c b/refs.c
index 1149e7e7dcb..32e993aaff3 100644
--- a/refs.c
+++ b/refs.c
@@ -10,7 +10,6 @@
 #include "refs.h"
 #include "refs/refs-internal.h"
 #include "run-command.h"
-#include "hook.h"
 #include "object-store.h"
 #include "object.h"
 #include "tag.h"
@@ -19,6 +18,7 @@
 #include "strvec.h"
 #include "repository.h"
 #include "sigchain.h"
+#include "hook.h"
=20
 /*
  * List of all available backends
@@ -2063,12 +2063,14 @@ static int run_transaction_hook(struct ref_transact=
ion *transaction,
 				const char *state)
 {
 	struct strbuf buf =3D STRBUF_INIT;
-	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt;
 	struct string_list to_stdin =3D STRING_LIST_INIT_DUP;
 	int ret =3D 0, i;
 	char o[GIT_MAX_HEXSZ + 1], n[GIT_MAX_HEXSZ + 1];
=20
-	if (!hook_exists("reference-transaction"))
+	run_hooks_opt_init_async(&opt);
+
+	if (!hook_exists("reference-transaction", HOOKDIR_USE_CONFIG))
 		return ret;
=20
 	strvec_push(&opt.args, state);
diff --git a/reset.c b/reset.c
index e6af33b901c..48d45f5b792 100644
--- a/reset.c
+++ b/reset.c
@@ -128,7 +128,9 @@ int reset_head(struct repository *r, struct object_id *=
oid, const char *action,
 					    reflog_head);
 	}
 	if (run_hook) {
-		struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
+		struct run_hooks_opt opt;
+
+		run_hooks_opt_init_sync(&opt);
 		strvec_pushl(&opt.args,
 			     oid_to_hex(orig ? orig : null_oid()),
 			     oid_to_hex(oid),
diff --git a/run-command.c b/run-command.c
index 4a1a7a10820..2ff76f3c2f1 100644
--- a/run-command.c
+++ b/run-command.c
@@ -8,7 +8,6 @@
 #include "string-list.h"
 #include "quote.h"
 #include "config.h"
-#include "hook.h"
=20
 void child_process_init(struct child_process *child)
 {
diff --git a/sequencer.c b/sequencer.c
index ec2761e47d9..3fa76687639 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -8,7 +8,6 @@
 #include "sequencer.h"
 #include "tag.h"
 #include "run-command.h"
-#include "hook.h"
 #include "exec-cmd.h"
 #include "utf8.h"
 #include "cache-tree.h"
@@ -35,6 +34,7 @@
 #include "commit-reach.h"
 #include "rebase-interactive.h"
 #include "reset.h"
+#include "hook.h"
 #include "string-list.h"
=20
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
@@ -1148,11 +1148,13 @@ int update_head_with_reflog(const struct commit *ol=
d_head,
 static int run_rewrite_hook(const struct object_id *oldoid,
 			    const struct object_id *newoid)
 {
-	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt;
 	struct strbuf tmp =3D STRBUF_INIT;
 	struct string_list to_stdin =3D STRING_LIST_INIT_DUP;
 	int code;
=20
+	run_hooks_opt_init_async(&opt);
+
 	strvec_push(&opt.args, "amend");
=20
 	strbuf_addf(&tmp,
@@ -1204,7 +1206,7 @@ static int run_prepare_commit_msg_hook(struct reposit=
ory *r,
 	} else {
 		arg1 =3D "message";
 	}
-	if (run_commit_hook(0, r->index_file, "prepare-commit-msg", name,
+	if (run_commit_hook(0, 0, r->index_file, "prepare-commit-msg", name,
 			    arg1, arg2, NULL))
 		ret =3D error(_("'prepare-commit-msg' hook failed"));
=20
@@ -1442,7 +1444,7 @@ static int try_to_commit(struct repository *r,
 		}
 	}
=20
-	if (hook_exists("prepare-commit-msg")) {
+	if (hook_exists("prepare-commit-msg", HOOKDIR_USE_CONFIG)) {
 		res =3D run_prepare_commit_msg_hook(r, msg, hook_commit);
 		if (res)
 			goto out;
@@ -1534,7 +1536,7 @@ static int try_to_commit(struct repository *r,
 		goto out;
 	}
=20
-	run_commit_hook(0, r->index_file, "post-commit", NULL);
+	run_commit_hook(0, 1, r->index_file, "post-commit", NULL);
 	if (flags & AMEND_MSG)
 		commit_post_rewrite(r, current_head, oid);
=20
@@ -4524,7 +4526,9 @@ static int pick_commits(struct repository *r,
 		if (!stat(rebase_path_rewritten_list(), &st) &&
 				st.st_size > 0) {
 			struct child_process notes_cp =3D CHILD_PROCESS_INIT;
-			struct run_hooks_opt hook_opt =3D RUN_HOOKS_OPT_INIT;
+			struct run_hooks_opt hook_opt;
+
+			run_hooks_opt_init_async(&hook_opt);
=20
 			notes_cp.in =3D open(rebase_path_rewritten_list(), O_RDONLY);
 			notes_cp.git_cmd =3D 1;
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index 2051ce57db7..922af561567 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "parse-options.h"
 #include "string-list.h"
+#include "strvec.h"
 #include "trace2.h"
=20
 static int boolean =3D 0;
@@ -15,6 +16,7 @@ static char *string =3D NULL;
 static char *file =3D NULL;
 static int ambiguous;
 static struct string_list list =3D STRING_LIST_INIT_NODUP;
+static struct strvec vector =3D STRVEC_INIT;
=20
 static struct {
 	int called;
@@ -133,6 +135,7 @@ int cmd__parse_options(int argc, const char **argv)
 		OPT_STRING('o', NULL, &string, "str", "get another string"),
 		OPT_NOOP_NOARG(0, "obsolete"),
 		OPT_STRING_LIST(0, "list", &list, "str", "add str to list"),
+		OPT_STRVEC(0, "vector", &vector, "str", "add str to strvec"),
 		OPT_GROUP("Magic arguments"),
 		OPT_ARGUMENT("quux", NULL, "means --quux"),
 		OPT_NUMBER_CALLBACK(&integer, "set integer to NUM",
@@ -183,6 +186,9 @@ int cmd__parse_options(int argc, const char **argv)
 	for (i =3D 0; i < list.nr; i++)
 		show(&expect, &ret, "list: %s", list.items[i].string);
=20
+	for (i =3D 0; i < vector.nr; i++)
+		show(&expect, &ret, "vector: %s", vector.v[i]);
+
 	for (i =3D 0; i < argc; i++)
 		show(&expect, &ret, "arg %02d: %s", i, argv[i]);
=20
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index ad4746d899a..485e0170bff 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -35,6 +35,7 @@ String options
     --st <st>             get another string (pervert ordering)
     -o <str>              get another string
     --list <str>          add str to list
+    --vector <str>        add str to strvec
=20
 Magic arguments
     --quux                means --quux
@@ -386,6 +387,32 @@ test_expect_success '--no-list resets list' '
 	test_cmp expect output
 '
=20
+cat >expect <<\EOF
+boolean: 0
+integer: 0
+magnitude: 0
+timestamp: 0
+string: (not set)
+abbrev: 7
+verbose: -1
+quiet: 0
+dry run: no
+file: (not set)
+vector: foo
+vector: bar
+vector: baz
+EOF
+test_expect_success '--vector keeps list of strings' '
+	test-tool parse-options --vector foo --vector=3Dbar --vector=3Dbaz >outpu=
t &&
+	test_cmp expect output
+'
+
+test_expect_success '--no-vector resets list' '
+	test-tool parse-options --vector=3Dother --vector=3Dirrelevant --vector=
=3Doptions \
+		--no-vector --vector=3Dfoo --vector=3Dbar --vector=3Dbaz >output &&
+	test_cmp expect output
+'
+
 test_expect_success 'multiple quiet levels' '
 	test-tool parse-options --expect=3D"quiet: 3" -q -q -q
 '
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-chec=
kout-compatibility.sh
index e9a815ca7aa..12e6c453024 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -106,18 +106,18 @@ init_repos () {
 run_on_sparse () {
 	(
 		cd sparse-checkout &&
-		GIT_PROGRESS_DELAY=3D100000 "$@" >../sparse-checkout-out 2>../sparse-che=
ckout-err
+		"$@" >../sparse-checkout-out 2>../sparse-checkout-err
 	) &&
 	(
 		cd sparse-index &&
-		GIT_PROGRESS_DELAY=3D100000 "$@" >../sparse-index-out 2>../sparse-index-=
err
+		"$@" >../sparse-index-out 2>../sparse-index-err
 	)
 }
=20
 run_on_all () {
 	(
 		cd full-checkout &&
-		GIT_PROGRESS_DELAY=3D100000 "$@" >../full-checkout-out 2>../full-checkou=
t-err
+		"$@" >../full-checkout-out 2>../full-checkout-err
 	) &&
 	run_on_sparse "$@"
 }
diff --git a/t/t1350-config-hooks-path.sh b/t/t1350-config-hooks-path.sh
index fa9647a7c0b..f1f9aee9f5d 100755
--- a/t/t1350-config-hooks-path.sh
+++ b/t/t1350-config-hooks-path.sh
@@ -5,7 +5,6 @@ test_description=3D'Test the core.hooksPath configuration v=
ariable'
 . ./test-lib.sh
=20
 test_expect_success 'set up a pre-commit hook in core.hooksPath' '
-	>actual &&
 	mkdir -p .git/custom-hooks .git/hooks &&
 	write_script .git/custom-hooks/pre-commit <<-\EOF &&
 	echo CUSTOM >>actual
diff --git a/t/t1360-config-based-hooks.sh b/t/t1360-config-based-hooks.sh
new file mode 100755
index 00000000000..43917172d74
--- /dev/null
+++ b/t/t1360-config-based-hooks.sh
@@ -0,0 +1,329 @@
+#!/bin/bash
+
+test_description=3D'config-managed multihooks, including git-hook command'
+
+. ./test-lib.sh
+
+ROOT=3D
+if test_have_prereq MINGW
+then
+	# In Git for Windows, Unix-like paths work only in shell scripts;
+	# `git.exe`, however, will prefix them with the pseudo root directory
+	# (of the Unix shell). Let's accommodate for that.
+	ROOT=3D"$(cd / && pwd)"
+fi
+
+setup_hooks () {
+	test_config hook.pre-commit.command "/path/ghi" --add
+	test_config_global hook.pre-commit.command "/path/def" --add
+}
+
+setup_hookcmd () {
+	test_config hook.pre-commit.command "abc" --add
+	test_config_global hookcmd.abc.command "/path/abc" --add
+}
+
+setup_hookdir () {
+	mkdir .git/hooks
+	write_script .git/hooks/pre-commit <<-EOF
+	echo \"Legacy Hook\"
+	EOF
+	test_when_finished rm -rf .git/hooks
+}
+
+test_expect_success 'git hook rejects commands without a mode' '
+	test_must_fail git hook pre-commit
+'
+
+
+test_expect_success 'git hook rejects commands without a hookname' '
+	test_must_fail git hook list
+'
+
+test_expect_success 'git hook runs outside of a repo' '
+	setup_hooks &&
+
+	cat >expected <<-EOF &&
+	global: $ROOT/path/def
+	EOF
+
+	nongit git config --list --global &&
+
+	nongit git hook list pre-commit >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git hook list orders by config order' '
+	setup_hooks &&
+
+	cat >expected <<-EOF &&
+	global: $ROOT/path/def
+	local: $ROOT/path/ghi
+	EOF
+
+	git hook list pre-commit >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git hook list dereferences a hookcmd' '
+	setup_hooks &&
+	setup_hookcmd &&
+
+	cat >expected <<-EOF &&
+	global: $ROOT/path/def
+	local: $ROOT/path/ghi
+	local: $ROOT/path/abc
+	EOF
+
+	git hook list pre-commit >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git hook list reorders on duplicate commands' '
+	setup_hooks &&
+
+	test_config hook.pre-commit.command "/path/def" --add &&
+
+	cat >expected <<-EOF &&
+	local: $ROOT/path/ghi
+	local: $ROOT/path/def
+	EOF
+
+	git hook list pre-commit >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git hook list shows hooks from the hookdir' '
+	setup_hookdir &&
+
+	cat >expected <<-EOF &&
+	hookdir: $(pwd)/.git/hooks/pre-commit
+	EOF
+
+	git hook list pre-commit >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'hook.runHookDir =3D no is respected by list' '
+	setup_hookdir &&
+
+	test_config hook.runHookDir "no" &&
+
+	cat >expected <<-EOF &&
+	hookdir: $(pwd)/.git/hooks/pre-commit (will not run)
+	EOF
+
+	git hook list pre-commit >actual &&
+	# the hookdir annotation is translated
+	test_cmp expected actual &&
+
+	git hook run pre-commit 2>actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'hook.runHookDir =3D error is respected by list' '
+	setup_hookdir &&
+
+	test_config hook.runHookDir "error" &&
+
+	cat >expected <<-EOF &&
+	hookdir: $(pwd)/.git/hooks/pre-commit (will error and not run)
+	EOF
+
+	git hook list pre-commit >actual &&
+	# the hookdir annotation is translated
+	test_cmp expected actual &&
+
+	cat >expected <<-EOF &&
+	Skipping legacy hook at '\''$(pwd)/.git/hooks/pre-commit'\''
+	EOF
+
+	git hook run pre-commit 2>actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'hook.runHookDir =3D warn is respected by list' '
+	setup_hookdir &&
+
+	test_config hook.runHookDir "warn" &&
+
+	cat >expected <<-EOF &&
+	hookdir: $(pwd)/.git/hooks/pre-commit (will warn but run)
+	EOF
+
+	git hook list pre-commit >actual &&
+	# the hookdir annotation is translated
+	test_cmp expected actual &&
+
+	cat >expected <<-EOF &&
+	Running legacy hook at '\''$(pwd)/.git/hooks/pre-commit'\''
+	"Legacy Hook"
+	EOF
+
+	git hook run pre-commit 2>actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git hook list removes skipped hookcmd' '
+	setup_hookcmd &&
+	test_config hookcmd.abc.skip "true" --add &&
+
+	cat >expected <<-EOF &&
+	no commands configured for hook '\''pre-commit'\''
+	EOF
+
+	git hook list pre-commit >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git hook list ignores skip referring to unused hookcm=
d' '
+	test_config hookcmd.abc.command "/path/abc" --add &&
+	test_config hookcmd.abc.skip "true" --add &&
+
+	cat >expected <<-EOF &&
+	no commands configured for hook '\''pre-commit'\''
+	EOF
+
+	git hook list pre-commit >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git hook list removes skipped inlined hook' '
+	setup_hooks &&
+	test_config hookcmd."$ROOT/path/ghi".skip "true" --add &&
+
+	cat >expected <<-EOF &&
+	global: $ROOT/path/def
+	EOF
+
+	git hook list pre-commit >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'hook.runHookDir =3D interactive is respected by list =
and run' '
+	setup_hookdir &&
+
+	test_config hook.runHookDir "interactive" &&
+
+	cat >expected <<-EOF &&
+	hookdir: $(pwd)/.git/hooks/pre-commit (will prompt)
+	EOF
+
+	git hook list pre-commit >actual &&
+	# the hookdir annotation is translated
+	test_cmp expected actual &&
+
+	test_write_lines n | git hook run pre-commit 2>actual &&
+	! grep "Legacy Hook" actual &&
+
+	test_write_lines y | git hook run pre-commit 2>actual &&
+	grep "Legacy Hook" actual
+'
+
+test_expect_success 'inline hook definitions execute oneliners' '
+	test_config hook.pre-commit.command "echo \"Hello World\"" &&
+
+	echo "Hello World" >expected &&
+
+	# hooks are run with stdout_to_stderr =3D 1
+	git hook run pre-commit 2>actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'inline hook definitions resolve paths' '
+	write_script sample-hook.sh <<-EOF &&
+	echo \"Sample Hook\"
+	EOF
+
+	test_when_finished "rm sample-hook.sh" &&
+
+	test_config hook.pre-commit.command "\"$(pwd)/sample-hook.sh\"" &&
+
+	echo \"Sample Hook\" >expected &&
+
+	# hooks are run with stdout_to_stderr =3D 1
+	git hook run pre-commit 2>actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git hook run can pass args and env vars' '
+	write_script sample-hook.sh <<-\EOF &&
+	echo $1
+	echo $2
+	echo $TEST_ENV_1
+	echo $TEST_ENV_2
+	EOF
+
+	test_config hook.pre-commit.command "\"$(pwd)/sample-hook.sh\"" &&
+
+	cat >expected <<-EOF &&
+	arg1
+	arg2
+	env1
+	env2
+	EOF
+
+	git hook run --arg arg1 \
+		--env TEST_ENV_1=3Denv1 \
+		-a arg2 \
+		-e TEST_ENV_2=3Denv2 \
+		pre-commit 2>actual &&
+
+	test_cmp expected actual
+'
+
+test_expect_success 'hookdir hook included in git hook run' '
+	setup_hookdir &&
+
+	echo \"Legacy Hook\" >expected &&
+
+	# hooks are run with stdout_to_stderr =3D 1
+	git hook run pre-commit 2>actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'out-of-repo runs excluded' '
+	setup_hooks &&
+
+	nongit test_must_fail git hook run pre-commit
+'
+
+test_expect_success 'hook.runHookDir is tolerant to unknown values' '
+	setup_hookdir &&
+
+	test_config hook.runHookDir "junk" &&
+
+	cat >expected <<-EOF &&
+	hookdir: $(pwd)/.git/hooks/pre-commit
+	EOF
+
+	git hook list pre-commit >actual &&
+	# the hookdir annotation is translated
+	test_cmp expected actual
+'
+
+test_expect_success 'stdin to multiple hooks' '
+	git config --add hook.test.command "xargs -P1 -I% echo a%" &&
+	git config --add hook.test.command "xargs -P1 -I% echo b%" &&
+	test_when_finished "test_unconfig hook.test.command" &&
+
+	cat >input <<-EOF &&
+	1
+	2
+	3
+	EOF
+
+	cat >expected <<-EOF &&
+	a1
+	a2
+	a3
+	b1
+	b2
+	b3
+	EOF
+
+	git hook run --to-stdin=3Dinput test 2>actual &&
+	test_cmp expected actual
+'
+
+test_done
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hoo=
ks.sh
index 6c941027a81..0a3c3e4a861 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -124,12 +124,12 @@ test_expect_success 'interleaving hook calls succeed'=
 '
 	EOF
=20
 	cat >expect <<-EOF &&
-		hooks/update refs/tags/PRE $ZERO_OID $PRE_OID
-		hooks/reference-transaction prepared
-		hooks/reference-transaction committed
-		hooks/update refs/tags/POST $ZERO_OID $POST_OID
-		hooks/reference-transaction prepared
-		hooks/reference-transaction committed
+		$(pwd)/target-repo.git/hooks/update refs/tags/PRE $ZERO_OID $PRE_OID
+		$(pwd)/target-repo.git/hooks/reference-transaction prepared
+		$(pwd)/target-repo.git/hooks/reference-transaction committed
+		$(pwd)/target-repo.git/hooks/update refs/tags/POST $ZERO_OID $POST_OID
+		$(pwd)/target-repo.git/hooks/reference-transaction prepared
+		$(pwd)/target-repo.git/hooks/reference-transaction committed
 	EOF
=20
 	git push ./target-repo.git PRE POST &&
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
deleted file mode 100755
index 9e2dd64275c..00000000000
--- a/t/t1800-hook.sh
+++ /dev/null
@@ -1,158 +0,0 @@
-#!/bin/bash
-
-test_description=3D'git-hook command'
-
-. ./test-lib.sh
-
-test_expect_success 'setup .git/hooks' '
-	mkdir .git/hooks
-'
-
-test_expect_success 'git hook run -- nonexistent hook' '
-	cat >stderr.expect <<-\EOF &&
-	error: cannot find a hook named does-not-exist
-	EOF
-	test_expect_code 1 git hook run does-not-exist 2>stderr.actual &&
-	test_cmp stderr.expect stderr.actual
-'
-
-test_expect_success 'git hook run -- nonexistent hook with --ignore-missin=
g' '
-	git hook run --ignore-missing does-not-exist 2>stderr.actual &&
-	test_must_be_empty stderr.actual
-'
-
-test_expect_success 'git hook run -- basic' '
-	write_script .git/hooks/test-hook <<-EOF &&
-	echo Test hook
-	EOF
-
-	cat >expect <<-\EOF &&
-	Test hook
-	EOF
-	git hook run test-hook 2>actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'git hook run -- stdout and stderr handling' '
-	write_script .git/hooks/test-hook <<-EOF &&
-	echo >&1 Will end up on stderr
-	echo >&2 Will end up on stderr
-	EOF
-
-	cat >stderr.expect <<-\EOF &&
-	Will end up on stderr
-	Will end up on stderr
-	EOF
-	git hook run test-hook >stdout.actual 2>stderr.actual &&
-	test_cmp stderr.expect stderr.actual &&
-	test_must_be_empty stdout.actual
-'
-
-test_expect_success 'git hook run -- exit codes are passed along' '
-	write_script .git/hooks/test-hook <<-EOF &&
-	exit 1
-	EOF
-
-	test_expect_code 1 git hook run test-hook &&
-
-	write_script .git/hooks/test-hook <<-EOF &&
-	exit 2
-	EOF
-
-	test_expect_code 2 git hook run test-hook &&
-
-	write_script .git/hooks/test-hook <<-EOF &&
-	exit 128
-	EOF
-
-	test_expect_code 128 git hook run test-hook &&
-
-	write_script .git/hooks/test-hook <<-EOF &&
-	exit 129
-	EOF
-
-	test_expect_code 129 git hook run test-hook
-'
-
-test_expect_success 'git hook run arg u ments without -- is not allowed' '
-	test_expect_code 129 git hook run test-hook arg u ments
-'
-
-test_expect_success 'git hook run -- pass arguments' '
-	write_script .git/hooks/test-hook <<-\EOF &&
-	echo $1
-	echo $2
-	EOF
-
-	cat >expect <<-EOF &&
-	arg
-	u ments
-	EOF
-
-	git hook run test-hook -- arg "u ments" 2>actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'git hook run -- out-of-repo runs excluded' '
-	write_script .git/hooks/test-hook <<-EOF &&
-	echo Test hook
-	EOF
-
-	nongit test_must_fail git hook run test-hook
-'
-
-test_expect_success 'git -c core.hooksPath=3D<PATH> hook run' '
-	mkdir my-hooks &&
-	write_script my-hooks/test-hook <<-EOF &&
-	echo Hook ran >>actual
-	EOF
-
-	cat >expect <<-\EOF &&
-	Test hook
-	Hook ran
-	Hook ran
-	Hook ran
-	Hook ran
-	EOF
-
-	# Test various ways of specifying the path. See also
-	# t1350-config-hooks-path.sh
-	>actual &&
-	git hook run test-hook 2>>actual &&
-	git -c core.hooksPath=3Dmy-hooks hook run test-hook 2>>actual &&
-	git -c core.hooksPath=3Dmy-hooks/ hook run test-hook 2>>actual &&
-	git -c core.hooksPath=3D"$PWD/my-hooks" hook run test-hook 2>>actual &&
-	git -c core.hooksPath=3D"$PWD/my-hooks/" hook run test-hook 2>>actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'set up a pre-commit hook in core.hooksPath' '
-	>actual &&
-	mkdir -p .git/custom-hooks .git/hooks &&
-	write_script .git/custom-hooks/pre-commit <<-\EOF &&
-	echo CUSTOM >>actual
-	EOF
-	write_script .git/hooks/pre-commit <<-\EOF
-	echo NORMAL >>actual
-	EOF
-'
-
-test_expect_success 'stdin to hooks' '
-	write_script .git/hooks/test-hook <<-\EOF &&
-	echo BEGIN stdin
-	cat
-	echo END stdin
-	EOF
-
-	cat >expect <<-EOF &&
-	BEGIN stdin
-	hello
-	END stdin
-	EOF
-
-	echo hello >input &&
-	git hook run --to-stdin=3Dinput test-hook 2>actual &&
-	test_cmp expect actual
-'
-
-test_done
diff --git a/t/t2080-parallel-checkout-basics.sh b/t/t2080-parallel-checkou=
t-basics.sh
index 3e0f8c675f7..7087818550f 100755
--- a/t/t2080-parallel-checkout-basics.sh
+++ b/t/t2080-parallel-checkout-basics.sh
@@ -114,7 +114,7 @@ do
=20
 	test_expect_success "$mode checkout" '
 		repo=3Dvarious_$mode &&
-		cp -R -P various $repo &&
+		cp -R various $repo &&
=20
 		# The just copied files have more recent timestamps than their
 		# associated index entries. So refresh the cached timestamps
diff --git a/t/t5411/test-0015-too-many-hooks-error.sh b/t/t5411/test-0015-=
too-many-hooks-error.sh
new file mode 100644
index 00000000000..2d645345101
--- /dev/null
+++ b/t/t5411/test-0015-too-many-hooks-error.sh
@@ -0,0 +1,47 @@
+test_expect_success "setup too  many proc-receive hooks (ok, $PROTOCOL)" '
+	write_script "proc-receive" <<-EOF &&
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/for/main/topic"
+	EOF
+
+	git -C "$upstream" config --add "hook.proc-receive.command" proc-receive =
&&
+	cp proc-receive "$upstream/hooks/proc-receive"
+'
+
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       next(A)  refs/for/main/topic(A)
+test_expect_success "proc-receive: reject more than one configured hook" '
+	test_must_fail git -C workbench push origin \
+		HEAD:next \
+		HEAD:refs/for/main/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
+	remote: error: only one "proc-receive" hook can be specified
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
+	To <URL/of/upstream.git>
+	 * [new branch] HEAD -> next
+	 ! [remote rejected] HEAD -> refs/for/main/topic (fail to run proc-receiv=
e hook)
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/main
+	<COMMIT-A> refs/heads/next
+	EOF
+	test_cmp expect actual
+'
+
+# Refs of upstream : main(A)             next(A)
+# Refs of workbench: main(A)  tags/v123
+test_expect_success "cleanup ($PROTOCOL)" '
+	git -C "$upstream" config --unset "hook.proc-receive.command" "proc-recei=
ve" &&
+	git -C "$upstream" update-ref -d refs/heads/next
+'
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 10c7ae7f09c..60d961b5260 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -95,52 +95,6 @@ test_expect_success 'gc --keep-largest-pack' '
 	)
 '
=20
-test_expect_success 'pre-auto-gc hook can stop auto gc' '
-	cat >err.expect <<-\EOF &&
-	no gc for you
-	EOF
-
-	git init pre-auto-gc-hook &&
-	(
-		cd pre-auto-gc-hook &&
-		write_script ".git/hooks/pre-auto-gc" <<-\EOF &&
-		echo >&2 no gc for you &&
-		exit 1
-		EOF
-
-		git config gc.auto 3 &&
-		git config gc.autoDetach false &&
-
-		# We need to create two object whose sha1s start with 17
-		# since this is what git gc counts.  As it happens, these
-		# two blobs will do so.
-		test_commit "$(test_oid obj1)" &&
-		test_commit "$(test_oid obj2)" &&
-
-		git gc --auto >../out.actual 2>../err.actual
-	) &&
-	test_must_be_empty out.actual &&
-	test_cmp err.expect err.actual &&
-
-	cat >err.expect <<-\EOF &&
-	will gc for you
-	Auto packing the repository for optimum performance.
-	See "git help gc" for manual housekeeping.
-	EOF
-
-	(
-		cd pre-auto-gc-hook &&
-		write_script ".git/hooks/pre-auto-gc" <<-\EOF &&
-		echo >&2 will gc for you &&
-		exit 0
-		EOF
-		git gc --auto >../out.actual 2>../err.actual
-	) &&
-
-	test_must_be_empty out.actual &&
-	test_cmp err.expect err.actual
-'
-
 test_expect_success 'auto gc with too many loose objects does not attempt =
to create bitmaps' '
 	test_config gc.auto 3 &&
 	test_config gc.autodetach false &&
diff --git a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh b/t/t7503-pre=
-commit-and-pre-merge-commit-hooks.sh
index 606d8d0f089..e9e37130332 100755
--- a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
+++ b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
@@ -8,8 +8,8 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
=20
 HOOKDIR=3D"$(git rev-parse --git-dir)/hooks"
-PRECOMMIT=3D"$HOOKDIR/pre-commit"
-PREMERGE=3D"$HOOKDIR/pre-merge-commit"
+PRECOMMIT=3D"$(pwd)/$HOOKDIR/pre-commit"
+PREMERGE=3D"$(pwd)/$HOOKDIR/pre-merge-commit"
=20
 # Prepare sample scripts that write their $0 to actual_hooks
 test_expect_success 'sample script setup' '
@@ -106,6 +106,19 @@ test_expect_success 'with succeeding hook' '
 	test_cmp expected_hooks actual_hooks
 '
=20
+# NEEDSWORK: when 'git hook add' and 'git hook remove' have been added, us=
e that
+# instead
+test_expect_success 'with succeeding hook (config-based)' '
+	test_when_finished "git config --unset hook.pre-commit.command success.sa=
mple" &&
+	test_when_finished "rm -f expected_hooks actual_hooks" &&
+	git config hook.pre-commit.command "$HOOKDIR/success.sample" &&
+	echo "$HOOKDIR/success.sample" >expected_hooks &&
+	echo "more" >>file &&
+	git add file &&
+	git commit -m "more" &&
+	test_cmp expected_hooks actual_hooks
+'
+
 test_expect_success 'with succeeding hook (merge)' '
 	test_when_finished "rm -f \"$PREMERGE\" expected_hooks actual_hooks" &&
 	cp "$HOOKDIR/success.sample" "$PREMERGE" &&
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 35b513c015f..bdf64728710 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -539,15 +539,13 @@ test_expect_success $PREREQ "--validate respects rela=
tive core.hooksPath path" '
 	test_path_is_file my-hooks.ran &&
 	cat >expect <<-EOF &&
 	fatal: longline.patch: rejected by sendemail-validate hook
-	fatal: command '"'"'git hook run sendemail-validate -- <patch>'"'"' died =
with exit code 1
 	warning: no patches were sent
 	EOF
 	test_cmp expect actual
 '
=20
 test_expect_success $PREREQ "--validate respects absolute core.hooksPath p=
ath" '
-	hooks_path=3D"$(pwd)/my-hooks" &&
-	test_config core.hooksPath "$hooks_path" &&
+	test_config core.hooksPath "$(pwd)/my-hooks" &&
 	test_when_finished "rm my-hooks.ran" &&
 	test_must_fail git send-email \
 		--from=3D"Example <nobody@example.com>" \
@@ -558,7 +556,6 @@ test_expect_success $PREREQ "--validate respects absolu=
te core.hooksPath path" '
 	test_path_is_file my-hooks.ran &&
 	cat >expect <<-EOF &&
 	fatal: longline.patch: rejected by sendemail-validate hook
-	fatal: command '"'"'git hook run sendemail-validate -- <patch>'"'"' died =
with exit code 1
 	warning: no patches were sent
 	EOF
 	test_cmp expect actual
@@ -2171,16 +2168,7 @@ test_expect_success $PREREQ 'invoke hook' '
 	mkdir -p .git/hooks &&
=20
 	write_script .git/hooks/sendemail-validate <<-\EOF &&
-	# test that we have the correct environment variable, pwd, and
-	# argument
-	case "$GIT_DIR" in
-	*.git)
-		true
-		;;
-	*)
-		false
-		;;
-	esac &&
+	# test that we have the correct argument
 	test -f 0001-add-main.patch &&
 	grep "add main" "$1"
 	EOF
diff --git a/transport.c b/transport.c
index 1146ed3143c..91911076264 100644
--- a/transport.c
+++ b/transport.c
@@ -2,7 +2,6 @@
 #include "config.h"
 #include "transport.h"
 #include "run-command.h"
-#include "hook.h"
 #include "pkt-line.h"
 #include "fetch-pack.h"
 #include "remote.h"
@@ -23,6 +22,7 @@
 #include "protocol.h"
 #include "object-store.h"
 #include "color.h"
+#include "hook.h"
=20
 static int transport_use_color =3D -1;
 static char transport_colors[][COLOR_MAXLEN] =3D {
@@ -1198,11 +1198,13 @@ static int run_pre_push_hook(struct transport *tran=
sport,
 			     struct ref *remote_refs)
 {
 	int ret =3D 0;
-	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt;
 	struct strbuf tmp =3D STRBUF_INIT;
 	struct ref *r;
 	struct string_list to_stdin =3D STRING_LIST_INIT_DUP;
=20
+	run_hooks_opt_init_async(&opt);
+
 	strvec_push(&opt.args, transport->remote->name);
 	strvec_push(&opt.args, transport->url);
=20
