Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18410C432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6A71610A0
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345011AbhIBNMq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 09:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244365AbhIBNMl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 09:12:41 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BEBC061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 06:11:43 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id g18so2838445wrc.11
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 06:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vZPYEsu5+Ak//YmhzNHq7+R7ye4DWxr+OgDo+miH1cY=;
        b=CmY0n8c7ojtzyW9Wsy90CJB+nUrjPuv+Ti11to/WuXvzj9vRoAHtjodpgA6OA6LjFm
         asz6zPp6GqkzT81TZDD8qTcru8A0+WOjM42IZUl3MxPrdhr2GCmrK4P8/YvFi1kvauMq
         /NWNf7EUBxMl2sXh5dE2O5b6OPq2q7vb4OviODQfScnkkPVKyihTG2ek4QRl/nyF9Ir8
         QI/VOemgE5cXqEz38XEB9dvzucmW0XZmC5KiPfLjlatYhclJnRCH1ctw4DHpiRLO58XJ
         jUxiPPF8SyybbzVAwa5+9in39QRogTMcX5lVrIaeMpdinCGkNP8Sbz8Sr3Qwt2KvG8Mj
         /seQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vZPYEsu5+Ak//YmhzNHq7+R7ye4DWxr+OgDo+miH1cY=;
        b=S4MUQRVnqcsw2jLMZZuDDTMBaP/kFM2ph0qhM9pfuU1R7pqDVXRcori4m30bMYKmCC
         fp/fZCzNqEXEFIbFtdif2UKl+XmR1lGOzzbX9+c+sM/LGdXmapZ8guBH9QjMBIJ6tthf
         BER1Y5X+cEjQ5cXcRLKIPffWQ0X6qLod0EsPezp8oOhpc9boPQJl8uJPNbR3n7YL2YTe
         gvJujXh7uF0hGV12hnMpKdtW5A8nEEMETe+rcfSNl6JquMdzCAY2GIk2GsvPmAuEIuCF
         2gTd8AENG1uiBZZhVTzTCtHKPN5s/snMSgo77IiVdDuYAmwSolKNTeGQO/HWBksYpQbi
         lTeg==
X-Gm-Message-State: AOAM531ueOHZ5wN89jcptMydMd1TWWurfRrQDA8x3XsPR99j13ZbiCcO
        pHLg5AEcLP/Ak7GalBV9jjv3/4cFR6P5Mg==
X-Google-Smtp-Source: ABdhPJyylLtP+QVXiFl52fU3CP1IkNGzCGrUjiULhXddbUTuWPsaXFwfSoY1jSKeVdV0q/vbNKVTkQ==
X-Received: by 2002:adf:e910:: with SMTP id f16mr3710508wrm.393.1630588300893;
        Thu, 02 Sep 2021 06:11:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm1479635wmq.36.2021.09.02.06.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 06:11:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 00/36] Run hooks via "git run hook" & hook library
Date:   Thu,  2 Sep 2021 15:11:00 +0200
Message-Id: <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.816.g1ba32acadee
In-Reply-To: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
References: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This topic refactors our hook execution to use a new hook.[ch] API and
rew "git hook run" tool in the case of the Perl & Python scripts that
execute hooks. It should contain no functional changes in how hooks
are run.

It's mainly authored by Emily Schaffer & is followed-up by her series
to make hooks configurable via normal "git config": [1]

See [2] for the v4 of this. A range-diff follows, but some of the main
changes:

 * The part where we die() if we're asked about a hook not listed in
   githooks(5) is gone. This makes things in Emily's follow-on topic
   much easier.

 * Various whitespace/small refactoring changes designed to make
   Emily's follow-on topic smaller.

 * Changed "/*" to "/**" comments in hook.h as appropriate (API
   comments).

 * I also re-arranged some functions in the header file to make those
   API comments easier to follow. I.e. we start with structs, and then
   various functions grouped by their respective functionality.

 * Various small commit message / comment rewording etc., some in
   response to Emily's feedback, others that I found myself.

[The rest here is a summary of how this topic interacts with a re-roll
of Emily's topic coming after this, feel free to skip it if only
reading this topic]:

I have my own version of Emily's series rebased on top of this with
some significant changes / fixes, which I mainly rebased/hacked up to
validate that all the changes here made sense.

That version is an extensive edit not of her v3 (which I believe maps
to her own 30ffe98601e) but the cf1f8e34a34 tip I found at the tip of
her "config-based-hooks-restart" a couple of days ago)[3], which
already incorporated some of my own feedback. That version is at my
avar-nasamuffin/config-based-hooks-restart-3[4].

Emily: You should be able to run something like this to get a sensible
range-diff of it v.s. what you have now (probably with
s/nasamuffin/origin/):

    git range-diff \
    gitster/ab/config-based-hooks-base..nasamuffin/config-based-hooks-restart \
    avar/es-avar/config-based-hooks-6..avar/avar-nasamuffin/config-based-hooks-restart-3

There's a few miscellaneous fixes in there, e.g. it passes all commits
with SANITIZE=leak now, and the "hook: allow running non-native hooks"
commit is entirely gone except for the doc change, as it wasn't needed
with the changes I've made in this v5 (we'd already allow running
non-native hooks). Likewise all the fn() and fn_gently() function
split wasn't needed anymore, as it's all "gentle" now. It has a
trivial CI failure[6] (coccinelle nitpick), but other than that passes
all tests.

1. https://lore.kernel.org/git/20210819033450.3382652-1-emilyshaffer@google.com/
2. https://lore.kernel.org/git/cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com/
3. https://github.com/nasamuffin/git/tree/config-based-hooks-restart
4. https://github.com/avar/git/tree/avar-nasamuffin/config-based-hooks-restart-3
5. https://github.com/avar/git/runs/3493829211
6. https://github.com/avar/git/runs/3493829211

Emily Shaffer (26):
  hook.c: add a hook_exists() wrapper and use it in bugreport.c
  hook: add 'run' subcommand
  gc: use hook library for pre-auto-gc hook
  rebase: convert pre-rebase to use hook.h
  am: convert applypatch to use hook.h
  hooks: convert 'post-checkout' hook to hook library
  merge: convert post-merge to use hook.h
  send-email: use 'git hook run' for 'sendemail-validate'
  git-p4: use 'git hook' to run hooks
  commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
  read-cache: convert post-index-change to use hook.h
  receive-pack: convert push-to-checkout hook to hook.h
  run-command: remove old run_hook_{le,ve}() hook API
  run-command: allow stdin for run_processes_parallel
  hook: support passing stdin to hooks
  am: convert 'post-rewrite' hook to hook.h
  run-command: add stdin callback for parallelization
  hook: provide stdin by string_list or callback
  hook: convert 'post-rewrite' hook in sequencer.c to hook.h
  transport: convert pre-push hook to hook.h
  reference-transaction: use hook.h to run hooks
  run-command: allow capturing of collated output
  hooks: allow callers to capture output
  receive-pack: convert 'update' hook to hook.h
  post-update: use hook.h library
  receive-pack: convert receive hooks to hook.h

Ævar Arnfjörð Bjarmason (10):
  Makefile: mark "check" target as .PHONY
  Makefile: stop hardcoding {command,config}-list.h
  Makefile: remove an out-of-date comment
  hook.[ch]: move find_hook() from run-command.c to hook.c
  hook.c users: use "hook_exists()" instead of "find_hook()"
  hook-list.h: add a generated list of hooks, like config-list.h
  git hook run: add an --ignore-missing flag
  hook tests: test for exact "pre-push" hook input
  hook tests: use a modern style for "pre-push" tests
  hooks: fix a TOCTOU in "did we run a hook?" heuristic

 .gitignore                          |   2 +
 Documentation/git-hook.txt          |  51 +++++
 Documentation/githooks.txt          |   4 +
 Makefile                            |  26 ++-
 builtin.h                           |   1 +
 builtin/am.c                        |  29 +--
 builtin/bugreport.c                 |  46 +----
 builtin/checkout.c                  |  14 +-
 builtin/clone.c                     |   6 +-
 builtin/commit.c                    |  19 +-
 builtin/fetch.c                     |   1 +
 builtin/gc.c                        |   3 +-
 builtin/hook.c                      |  98 ++++++++++
 builtin/merge.c                     |  21 +-
 builtin/rebase.c                    |   6 +-
 builtin/receive-pack.c              | 285 +++++++++++++---------------
 builtin/submodule--helper.c         |   2 +-
 builtin/worktree.c                  |  29 ++-
 command-list.txt                    |   1 +
 commit.c                            |  16 +-
 commit.h                            |   3 +-
 compat/vcbuild/README               |   2 +-
 config.mak.uname                    |   6 +-
 contrib/buildsystems/CMakeLists.txt |   7 +
 generate-hooklist.sh                |  18 ++
 git-p4.py                           |  72 +------
 git-send-email.perl                 |  20 +-
 git.c                               |   1 +
 hook.c                              | 219 +++++++++++++++++++++
 hook.h                              | 127 +++++++++++++
 read-cache.c                        |  11 +-
 refs.c                              |  41 ++--
 reset.c                             |  14 +-
 run-command.c                       | 157 +++++++--------
 run-command.h                       |  55 +++---
 sequencer.c                         |  86 ++++-----
 submodule.c                         |   1 +
 t/helper/test-run-command.c         |  46 ++++-
 t/t0061-run-command.sh              |  37 ++++
 t/t1800-hook.sh                     | 151 +++++++++++++++
 t/t5571-pre-push-hook.sh            |  94 +++++----
 t/t9001-send-email.sh               |   4 +-
 transport.c                         |  57 ++----
 43 files changed, 1278 insertions(+), 611 deletions(-)
 create mode 100644 Documentation/git-hook.txt
 create mode 100644 builtin/hook.c
 create mode 100755 generate-hooklist.sh
 create mode 100644 hook.c
 create mode 100644 hook.h
 create mode 100755 t/t1800-hook.sh

Range-diff against v4:
 1:  81fe1ed90d5 =  1:  ac419613fdc Makefile: mark "check" target as .PHONY
 2:  0f749530777 !  2:  a161b7f0a5c Makefile: stop hardcoding {command,config}-list.h
    @@ Commit message
         this refactoring we'll only need to add the new file to the
         GENERATED_H variable, not EXCEPT_HDRS, the vcbuild/README etc.
     
    -    I have not tested the Windows-specific change in config.mak.uname
    -    being made here, but we use other variables from the Makefile in the
    -    same block, and the GENERATED_H is fully defined before we include
    -    config.mak.uname.
    -
         Hardcoding command-list.h there seems to have been a case of
         copy/paste programming in 976aaedca0 (msvc: add a Makefile target to
         pre-generate the Visual Studio solution, 2019-07-29). The
 3:  644b31fe281 =  3:  ffef1d3257e Makefile: remove an out-of-date comment
 4:  89c4d44b0c3 !  4:  545e16c6f04 hook.[ch]: move find_hook() to this new library
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    hook.[ch]: move find_hook() to this new library
    +    hook.[ch]: move find_hook() from run-command.c to hook.c
     
         Move the find_hook() function from run-command.c to a new hook.c
         library. This change establishes a stub library that's pretty
    @@ hook.h (new)
     +#ifndef HOOK_H
     +#define HOOK_H
     +
    -+/*
    ++/**
     + * Returns the path to the hook file, or NULL if the hook is missing
     + * or disabled. Note that this points to static storage that will be
    -+ * overwritten by further calls to find_hook and run_hook_*.
    ++ * overwritten by further calls to find_hook().
     + */
     +const char *find_hook(const char *name);
     +
 5:  3514e0c0251 !  5:  a9bc4519e9a hook.c: add a hook_exists() wrapper and use it in bugreport.c
    @@ hook.h
       */
      const char *find_hook(const char *name);
      
    -+/*
    ++/**
     + * A boolean version of find_hook()
     + */
     +int hook_exists(const char *hookname);
 6:  d5ef40f77dc !  6:  e99ec2e6f8f hook.c users: use "hook_exists()" insted of "find_hook()"
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    hook.c users: use "hook_exists()" insted of "find_hook()"
    +    hook.c users: use "hook_exists()" instead of "find_hook()"
     
         Use the new hook_exists() function instead of find_hook() where the
         latter was called in boolean contexts. This make subsequent changes in
 7:  4cfd72722c1 !  7:  2ffb2332c8a hook-list.h: add a generated list of hooks, like config-list.h
    @@ Commit message
         hook-list.h: add a generated list of hooks, like config-list.h
     
         Make githooks(5) the source of truth for what hooks git supports, and
    -    die hooks we don't know about in find_hook(). This ensures that the
    -    documentation and the C code's idea about existing hooks doesn't
    -    diverge.
    +    punt out early on hooks we don't know about in find_hook(). This
    +    ensures that the documentation and the C code's idea about existing
    +    hooks doesn't diverge.
     
         We still have Perl and Python code running its own hooks, but that'll
         be addressed by Emily Shaffer's upcoming "git hook run" command.
    @@ Commit message
         listing only knowing about 1/4 of the p4 hooks. It didn't know about
         the recent "reference-transaction" hook either.
     
    +    We could make the find_hook() function die() or BUG() out if the new
    +    known_hook() returned 0, but let's make it return NULL just as it does
    +    when it can't find a hook of a known type. Making it die() is overly
    +    anal, and unlikely to be what we need in catching stupid typos in the
    +    name of some new hook hardcoded in git.git's sources. By making this
    +    be tolerant of unknown hook names, changes in a later series to make
    +    "git hook run" run arbitrary user-configured hook names will be easier
    +    to implement.
    +
         I have not been able to directly test the CMake change being made
         here. Since 4c2c38e800 (ci: modification of main.yml to use cmake for
         vs-build job, 2020-06-26) some of the Windows CI has a hard dependency
    @@ generate-hooklist.sh (new)
     +	NULL,
     +};
     +EOF
    -
    - ## hook.c ##
    -@@
    - #include "cache.h"
    - #include "hook.h"
    - #include "run-command.h"
    -+#include "hook-list.h"
    -+
    -+static int known_hook(const char *name)
    -+{
    -+	const char **p;
    -+	size_t len = strlen(name);
    -+	for (p = hook_name_list; *p; p++) {
    -+		const char *hook = *p;
    -+
    -+		if (!strncmp(name, hook, len) && hook[len] == '\0')
    -+			return 1;
    -+	}
    -+
    -+	return 0;
    -+}
    - 
    - const char *find_hook(const char *name)
    - {
    - 	static struct strbuf path = STRBUF_INIT;
    - 
    -+	if (!known_hook(name))
    -+		die(_("the hook '%s' is not known to git, should be in hook-list.h via githooks(5)"),
    -+		    name);
    -+
    - 	strbuf_reset(&path);
    - 	strbuf_git_path(&path, "hooks/%s", name);
    - 	if (access(path.buf, X_OK) < 0) {
 8:  7cb4a4cb69e !  8:  72dd1010f5b hook: add 'run' subcommand
    @@ builtin/hook.c (new)
     +	/* Need to take into account core.hooksPath */
     +	git_config(git_default_config, NULL);
     +
    ++	/*
    ++	 * We are not using a plain run_hooks() because we'd like to
    ++	 * detect missing hooks. Let's find it ourselves and call
    ++	 * run_hooks() instead.
    ++	 */
     +	hook_name = argv[0];
     +	hook_path = find_hook(hook_name);
     +	if (!hook_path) {
    @@ git.c: static struct cmd_struct commands[] = {
     
      ## hook.c ##
     @@
    + #include "cache.h"
      #include "hook.h"
      #include "run-command.h"
    - #include "hook-list.h"
     +#include "config.h"
      
    - static int known_hook(const char *name)
    + const char *find_hook(const char *name)
      {
    - 	const char **p;
    - 	size_t len = strlen(name);
    -+	static int test_hooks_ok = -1;
    -+
    - 	for (p = hook_name_list; *p; p++) {
    - 		const char *hook = *p;
    - 
    -@@ hook.c: static int known_hook(const char *name)
    - 			return 1;
    - 	}
    - 
    -+	if (test_hooks_ok == -1)
    -+		test_hooks_ok = git_env_bool("GIT_TEST_FAKE_HOOKS", 0);
    -+
    -+	if (test_hooks_ok &&
    -+	    (!strcmp(name, "test-hook") ||
    -+	     !strcmp(name, "does-not-exist")))
    -+		return 1;
    -+
    - 	return 0;
    - }
    - 
     @@ hook.c: int hook_exists(const char *name)
      {
      	return !!find_hook(name);
    @@ hook.h
     @@
      #ifndef HOOK_H
      #define HOOK_H
    -+#include "strbuf.h"
     +#include "strvec.h"
    -+#include "run-command.h"
    - 
    - /*
    -  * Returns the path to the hook file, or NULL if the hook is missing
    -@@ hook.h: const char *find_hook(const char *name);
    -  */
    - int hook_exists(const char *hookname);
    - 
    ++
     +struct hook {
     +	/* The path to the hook */
     +	const char *hook_path;
    @@ hook.h: const char *find_hook(const char *name);
     +	.args = STRVEC_INIT, \
     +}
     +
    -+/*
    -+ * Callback provided to feed_pipe_fn and consume_sideband_fn.
    -+ */
     +struct hook_cb_data {
     +	/* rc reflects the cumulative failure state */
     +	int rc;
    @@ hook.h: const char *find_hook(const char *name);
     +	struct hook *run_me;
     +	struct run_hooks_opt *options;
     +};
    -+
    + 
    + /**
    +  * Returns the path to the hook file, or NULL if the hook is missing
    +@@ hook.h: const char *find_hook(const char *name);
    +  */
    + int hook_exists(const char *hookname);
    + 
    ++/**
    ++ * Clear data from an initialized "struct run_hooks-opt".
    ++ */
     +void run_hooks_opt_clear(struct run_hooks_opt *o);
     +
     +/**
    @@ hook.h: const char *find_hook(const char *name);
     
      ## t/t1800-hook.sh (new) ##
     @@
    -+#!/bin/bash
    ++#!/bin/sh
     +
     +test_description='git-hook command'
     +
    @@ t/t1800-hook.sh (new)
     +	grep "unknown option" err
     +'
     +
    -+test_expect_success 'setup GIT_TEST_FAKE_HOOKS=true to permit "test-hook" and "does-not-exist" names"' '
    -+	GIT_TEST_FAKE_HOOKS=true &&
    -+	export GIT_TEST_FAKE_HOOKS
    -+'
    -+
     +test_expect_success 'git hook run: nonexistent hook' '
     +	cat >stderr.expect <<-\EOF &&
     +	error: cannot find a hook named test-hook
 9:  2b8500aa675 !  9:  821cc9bf11e gc: use hook library for pre-auto-gc hook
    @@ hook.c: int run_hooks(const char *hook_name, const char *hook_path,
     +	}
     +
     +	ret = run_hooks(hook_name, hook_path, options);
    ++
     +cleanup:
     +	run_hooks_opt_clear(options);
    ++
     +	return ret;
     +}
     
    @@ hook.h: void run_hooks_opt_clear(struct run_hooks_opt *o);
     + * with run_hooks().
     + *
     + * If "options" is provided calls run_hooks_opt_clear() on it for
    -+ * you. If "options" is NULL a scratch one will be provided for you
    -+ * before calling run_hooks().
    ++ * you. If "options" is NULL the default options from
    ++ * RUN_HOOKS_OPT_INIT will be used.
     + */
     +int run_hooks_oneshot(const char *hook_name, struct run_hooks_opt *options);
     +
10:  3ee55d2c10f = 10:  d71c90254ea rebase: convert pre-rebase to use hook.h
11:  050f20d14f0 = 11:  ea3af2ccc4d am: convert applypatch to use hook.h
12:  ac875d284da ! 12:  fed0b52f88f hooks: convert 'post-checkout' hook to hook library
    @@ hook.h: struct run_hooks_opt
      	/* Args to be passed to each hook */
      	struct strvec args;
     +
    -+	/* Resolve and run the "absolute_path(hook)" instead of
    ++	/*
    ++	 * Resolve and run the "absolute_path(hook)" instead of
     +	 * "hook". Used for "git worktree" hooks
     +	 */
     +	int absolute_path;
13:  69763bc2255 = 13:  53d8721a0e3 merge: convert post-merge to use hook.h
14:  2ca1ca1b8e4 ! 14:  d60827a2856 git hook run: add an --ignore-missing flag
    @@ builtin/hook.c: static int run(int argc, const char **argv, const char *prefix)
      	};
      	int ret;
     @@ builtin/hook.c: static int run(int argc, const char **argv, const char *prefix)
    - 	git_config(git_default_config, NULL);
    - 
    + 	/*
    + 	 * We are not using a plain run_hooks() because we'd like to
    + 	 * detect missing hooks. Let's find it ourselves and call
    +-	 * run_hooks() instead.
    ++	 * run_hooks() instead...
    + 	 */
      	hook_name = argv[0];
     +	if (ignore_missing)
    ++		/* ... act like a plain run_hooks() under --ignore-missing */
     +		return run_hooks_oneshot(hook_name, &opt);
      	hook_path = find_hook(hook_name);
      	if (!hook_path) {
15:  5b66b04bec7 = 15:  d4976a0821f send-email: use 'git hook run' for 'sendemail-validate'
16:  14a37a43db2 = 16:  99f3dcd1945 git-p4: use 'git hook' to run hooks
17:  ad5d0e0e7de = 17:  509761454e6 commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
18:  3d3a33e2674 = 18:  e2c94d95427 read-cache: convert post-index-change to use hook.h
19:  893f8666301 ! 19:  fa7d0d24ea2 receive-pack: convert push-to-checkout hook to hook.h
    @@ Commit message
         Move the push-to-checkout hook away from run-command.h to and over to
         the new hook.h library.
     
    +    This removes the last direct user of run_hook_le(), so we could remove
    +    that function now, but let's leave that to a follow-up cleanup commit.
    +
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
20:  070433deba5 = 20:  428bb5a6792 run-command: remove old run_hook_{le,ve}() hook API
21:  1028e0c1667 = 21:  994f6ad8602 run-command: allow stdin for run_processes_parallel
22:  639e59e9ed0 = 22:  3ccc654a664 hook: support passing stdin to hooks
23:  7d1925cca48 = 23:  f548e3d15e7 am: convert 'post-rewrite' hook to hook.h
24:  0c24221b522 = 24:  bb119fa7cc0 run-command: add stdin callback for parallelization
25:  05d1085f7eb ! 25:  2439f7752b8 hook: provide stdin by string_list or callback
    @@ hook.c: int run_hooks_oneshot(const char *hook_name, struct run_hooks_opt *optio
      		ret = 0;
     
      ## hook.h ##
    -@@ hook.h: int hook_exists(const char *hookname);
    +@@
    + #ifndef HOOK_H
    + #define HOOK_H
    ++#include "strbuf.h"
    + #include "strvec.h"
    ++#include "run-command.h"
    + 
      struct hook {
      	/* The path to the hook */
      	const char *hook_path;
    @@ hook.h: struct run_hooks_opt
      };
      
      #define RUN_HOOKS_OPT_INIT { \
    -@@ hook.h: struct run_hooks_opt
    - 	.args = STRVEC_INIT, \
    - }
    +@@ hook.h: int run_hooks(const char *hookname, const char *hook_path,
    +  */
    + int run_hooks_oneshot(const char *hook_name, struct run_hooks_opt *options);
      
    -+/*
    ++/**
     + * To specify a 'struct string_list', set 'run_hooks_opt.feed_pipe_ctx' to the
    -+ * string_list and set 'run_hooks_opt.feed_pipe' to 'pipe_from_string_list()'.
    ++ * string_list and set 'run_hooks_opt.feed_pipe' to pipe_from_string_list().
     + * This will pipe each string in the list to stdin, separated by newlines.  (Do
     + * not inject your own newlines.)
     + */
     +int pipe_from_string_list(struct strbuf *pipe, void *pp_cb, void *pp_task_cb);
     +
    - /*
    -  * Callback provided to feed_pipe_fn and consume_sideband_fn.
    -  */
    + #endif
26:  4b7175af2e5 = 26:  48a380b3a91 hook: convert 'post-rewrite' hook in sequencer.c to hook.h
27:  3f24e056410 = 27:  af6b9292aaa transport: convert pre-push hook to hook.h
28:  ecf75f33233 ! 28:  957691f0b6d hook tests: test for exact "pre-push" hook input
    @@ Commit message
     
         Extend the tests added in ec55559f937 (push: Add support for pre-push
         hooks, 2013-01-13) to exhaustively test for the exact input we're
    -    expecting. This helps a parallel series that's refactoring how the
    -    hook is called, to e.g. make sure that we don't miss a trailing
    -    newline.
    +    expecting. This ensures that we e.g. don't miss a trailing newline.
    +
    +    Appending to a file called "actual" is the established convention in
    +    this test for hooks, see the rest of the tests added in
    +    ec55559f937 (push: Add support for pre-push hooks, 2013-01-13). Let's
    +    follow that convention here.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
29:  2c961be94b4 ! 29:  88fe2621549 hook tests: use a modern style for "pre-push" tests
    @@ t/t5571-pre-push-hook.sh: echo "$2" >>actual
     -EOF
     -
      test_expect_success 'push with hook' '
    -+	cat >expected <<-EOF &&
    ++	cat >expect <<-EOF &&
     +	parent1
     +	repo1
     +	refs/heads/main $COMMIT2 refs/heads/foreign $COMMIT1
    @@ t/t5571-pre-push-hook.sh: echo "$2" >>actual
     +
      	git push parent1 main:foreign &&
     -	diff expected actual
    -+	test_cmp expected actual
    ++	test_cmp expect actual
      '
      
      test_expect_success 'add a branch' '
30:  1ce456f9d9d = 30:  1d905e81779 reference-transaction: use hook.h to run hooks
31:  6e5f1f5bd3a = 31:  fac56a9d8af run-command: allow capturing of collated output
32:  0b6e9c6d07a = 32:  7d185cdf9d1 hooks: allow callers to capture output
33:  dcf63634338 = 33:  c8150e1239f receive-pack: convert 'update' hook to hook.h
34:  f352a485e59 = 34:  a20ad847c14 post-update: use hook.h library
35:  ceef2f3e804 = 35:  79c380be6ed receive-pack: convert receive hooks to hook.h
36:  b71d7628b40 ! 36:  fe056098534 hooks: fix a TOCTOU in "did we run a hook?" heuristic
    @@ hook.h: struct hook_cb_data {
     +	int *invoked_hook;
      };
      
    - void run_hooks_opt_clear(struct run_hooks_opt *o);
    + /**
     
      ## sequencer.c ##
     @@ sequencer.c: static int run_prepare_commit_msg_hook(struct repository *r,
-- 
2.33.0.816.g1ba32acadee

