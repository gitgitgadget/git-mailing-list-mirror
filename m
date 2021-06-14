Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEFBC4743C
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8107B61456
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbhFNKiJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 06:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbhFNKgH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 06:36:07 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B68C06124A
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:33:46 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id f2so13966073wri.11
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cK1frXyFosxC/C8dSIIURLDtFIILEqZV19uz7dhmrWY=;
        b=nFmJj8GqAxW/ybsBnIV8FzDk5VMke1O145+jJwuGJQS6BPDzjynx3VM/dI7US/uw0X
         O1JPaYmMI48eVxDdVv6XSWSFr5zeuaHJACjl246EqUGVYVe1XJDUhOHUsHemr8+dHNHV
         5irpMvpp+4X0jgqkcBqXuh4lWx24UB+h1OgcwLbvBzRDFrKyrJVMmPd2nYMgL4TW08ig
         mXgmS57ueVKoRTak9G2aATKXoibdGLnplyN4y5Vtiou7RH3MjN/XZ0zya48gQ8cpfW+y
         w7xW2VMFfmoo2oFV2GroiMnAjMMFWt9jv2/xoctM7Br4kqPAzrSD7Ay8nDQ3CRxuS7O/
         wM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cK1frXyFosxC/C8dSIIURLDtFIILEqZV19uz7dhmrWY=;
        b=eG3x7E3UPSrKzUfHhvui1qMmhuNWsGJXG5tg4h7I/6ntZL0sC9/WQEZNH9aEcXFeWx
         aafbfFc48yQUqaxJciBaGNsR3/to5jwi3HTHipkehvL+bmG6q2ptR5U6sdual4U3jH4S
         pwuH/73zIgVap5CyatjwfEQrX3sG0YykZW/mcOtr9sBsc5iBCJy/m/G7rTSjoI1tngej
         kVqXTBsqllTsclf00jtj2QFkeLQBxNBGQ/yh1c/4F1Y2obK9dPFFrM0uxUyOIdCJj1ma
         ie60K05Z5Timbcdvf8CfVUwnJHglyynpF0tqUV0SbVPFFhiHrZqujtXZS0WqfxywgFFS
         SBfw==
X-Gm-Message-State: AOAM532eeFifb3eHz25HvsBIIDTzu6hPsz+G0TGqOZx6YfwgR/NQ1s35
        YuLDjsZ1pAhtGxcRn3Mmv4T9i7DSBN16ZA==
X-Google-Smtp-Source: ABdhPJwRnhM3lNpQCbD7Qvr5z5QkPyyJ5leYszGWSTDxYBJthJGkEUIDp858eAXIlsSP8WeIcanN9A==
X-Received: by 2002:a5d:5987:: with SMTP id n7mr17951670wri.293.1623666824104;
        Mon, 14 Jun 2021 03:33:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w18sm15911843wrt.55.2021.06.14.03.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 03:33:43 -0700 (PDT)
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
Subject: [PATCH v2 00/30] Minimal restart of "config-based-hooks"
Date:   Mon, 14 Jun 2021 12:32:49 +0200
Message-Id: <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
In-Reply-To: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
References: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I proposed splitting Emily's "hook config" topic[1] into at least a
topic that retains all current behavior of the codebase, and merely
refactors existing behavior to new APIs, and then doing behavior
changes later.

This is a re-roll of an attempt to do that. See v1's CL [2] for much
more details.

I was hoping to get more feedback from Emily in reply to [3] and
related E-Mails on the v1, but as it's been almost 2 weeks with no
reply, and both her topic and mine semantically conflict with changes
since merged to "master" I thought I'd send this re-roll.

Changes since v2:

 A. Addressed comments by Felipe, thanks! The "remove the [old] API"
    is now a separate commit / other minor nits fixed.

 B. Fixed a test failure due to "mkdir .git/hooks"; semantic conflict
    with my now-landed f0d4d398e28 (test-lib: split up and deprecate
    test_create_repo(), 2021-05-10)

 C. Fixed a portibility issue in the new generate-hooklist.sh.

 D. Clarified what a TOCTOU is, reworded commit message.

 E. I'd added various "we get closer to removing the hook code" in
    commit messages after we'd removed the hook code. We were really
    just porting bespoke behavior to hook.h.

 F. Fixed trivial conflict with master's 410334ed521 (read-cache: use
    hashfile instead of git_hash_ctx, 2021-05-18) in read-cache.c.

 G. In my v1 I added two patches at the beginning to fix/add
    hook-related tests. I'll just submit those as separate
    patches. There's no dependency between those and this topic, other
    than basic this one on top of them granting more assurances that
    this one doesn't break any existing hook behavior than the current
    tests on "master".

1. http://lore.kernel.org/git/20210527000856.695702-1-emilyshaffer@google.com
2. https://lore.kernel.org/git/cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com/
3. https://lore.kernel.org/git/87y2bs7gyc.fsf@evledraar.gmail.com/

Emily Shaffer (26):
  hook: add 'run' subcommand
  hook.c: add a hook_exists() wrapper and use it in bugreport.c
  gc: use hook library for pre-auto-gc hook
  rebase: teach pre-rebase to use hook.h
  am: convert applypatch hooks to use config
  hooks: convert 'post-checkout' hook to hook library
  merge: use config-based hooks for post-merge hook
  send-email: use 'git hook run' for 'sendemail-validate'
  git-p4: use 'git hook' to run hooks
  commit: use hook.h to execute hooks
  read-cache: convert post-index-change hook to use config
  receive-pack: convert push-to-checkout hook to hook.h
  run-command: remove old run_hook_{le,ve}() hook API
  run-command: allow stdin for run_processes_parallel
  hook: support passing stdin to hooks
  am: convert 'post-rewrite' hook to hook.h
  run-command: add stdin callback for parallelization
  hook: provide stdin by string_list or callback
  hook: convert 'post-rewrite' hook in sequencer.c to hook.h
  transport: convert pre-push hook to use config
  reference-transaction: use hook.h to run hooks
  run-command: allow capturing of collated output
  hooks: allow callers to capture output
  receive-pack: convert 'update' hook to hook.h
  post-update: use hook.h library
  receive-pack: convert receive hooks to hook.h

Ævar Arnfjörð Bjarmason (4):
  run-command.h: move find_hook() to hook.h
  git hook run: add an --ignore-missing flag
  hooks: fix a TOCTOU in "did we run a hook?" heuristic
  hook-list.h: add a generated list of hooks, like config-list.h

 .gitignore                  |   2 +
 Documentation/git-hook.txt  |  49 ++++++
 Documentation/githooks.txt  |   4 +
 Makefile                    |  16 +-
 builtin.h                   |   1 +
 builtin/am.c                |  34 ++--
 builtin/bugreport.c         |  46 ++----
 builtin/checkout.c          |  17 +-
 builtin/clone.c             |   7 +-
 builtin/commit.c            |  19 ++-
 builtin/fetch.c             |   1 +
 builtin/gc.c                |   8 +-
 builtin/hook.c              |  72 +++++++++
 builtin/merge.c             |  22 ++-
 builtin/rebase.c            |   9 +-
 builtin/receive-pack.c      | 299 ++++++++++++++++++------------------
 builtin/submodule--helper.c |   2 +-
 builtin/worktree.c          |  31 ++--
 command-list.txt            |   1 +
 commit.c                    |  17 +-
 commit.h                    |   3 +-
 generate-hooklist.sh        |  24 +++
 git-p4.py                   |  72 +--------
 git-send-email.perl         |  20 ++-
 git.c                       |   1 +
 hook.c                      | 224 +++++++++++++++++++++++++++
 hook.h                      | 122 +++++++++++++++
 read-cache.c                |  12 +-
 refs.c                      |  43 ++----
 reset.c                     |  15 +-
 run-command.c               | 157 ++++++++++---------
 run-command.h               |  55 ++++---
 sequencer.c                 |  88 +++++------
 submodule.c                 |   1 +
 t/helper/test-run-command.c |  46 +++++-
 t/t0061-run-command.sh      |  37 +++++
 t/t1800-hook.sh             | 162 +++++++++++++++++++
 t/t9001-send-email.sh       |   4 +-
 transport.c                 |  58 ++-----
 39 files changed, 1246 insertions(+), 555 deletions(-)
 create mode 100644 Documentation/git-hook.txt
 create mode 100644 builtin/hook.c
 create mode 100755 generate-hooklist.sh
 create mode 100644 hook.c
 create mode 100644 hook.h
 create mode 100755 t/t1800-hook.sh

Range-diff against v1:
 1:  8ac2efc71a0 <  -:  ----------- hooks tests: don't leave "actual" nonexisting on failure
 2:  eb37693f7dc <  -:  ----------- gc tests: add a test for the "pre-auto-gc" hook
 3:  1ad4e69f7da !  1:  447d349c738 hook: add 'run' subcommand
    @@ t/t1800-hook.sh (new)
     +
     +. ./test-lib.sh
     +
    -+test_expect_success 'setup .git/hooks' '
    -+	mkdir .git/hooks
    -+'
    -+
     +test_expect_success 'git hook run -- nonexistent hook' '
     +	cat >stderr.expect <<-\EOF &&
     +	error: cannot find a hook named does-not-exist
 4:  1a67a1cc065 =  2:  85195a78cfb run-command.h: move find_hook() to hook.h
 5:  a6f0817ad81 =  3:  eb5bdd993c8 hook.c: add a hook_exists() wrapper and use it in bugreport.c
 6:  b186fde43e1 =  4:  da2763192ae gc: use hook library for pre-auto-gc hook
 7:  528402fac69 =  5:  51e6e72f239 rebase: teach pre-rebase to use hook.h
 8:  69842c74383 =  6:  d2f3b26d464 am: convert applypatch hooks to use config
 9:  9b32c14669b !  7:  d884465aab3 hooks: convert 'post-checkout' hook to hook library
    @@ hook.h: struct run_hooks_opt
     
      ## read-cache.c ##
     @@
    - #include "thread-utils.h"
      #include "progress.h"
      #include "sparse-index.h"
    + #include "csum-file.h"
     +#include "hook.h"
      
      /* Mask for the name length in ce_flags in the on-disk index */
10:  201c654bb0c =  8:  ad6e7507841 merge: use config-based hooks for post-merge hook
11:  e65d8bd6e6f =  9:  8d8b2d26453 git hook run: add an --ignore-missing flag
12:  8795e9ceab8 = 10:  1953326d1db send-email: use 'git hook run' for 'sendemail-validate'
13:  03129460fd2 = 11:  aa970a81752 git-p4: use 'git hook' to run hooks
14:  3f3610f5ed3 = 12:  7756f10aac9 commit: use hook.h to execute hooks
15:  6482a3e4cb8 = 13:  0300607a9b4 read-cache: convert post-index-change hook to use config
 -:  ----------- > 14:  ec4ad437f86 receive-pack: convert push-to-checkout hook to hook.h
16:  a16163d4fb5 ! 15:  477eb2245c3 receive-pack: convert push-to-checkout hook to hook.h
    @@ Metadata
     Author: Emily Shaffer <emilyshaffer@google.com>
     
      ## Commit message ##
    -    receive-pack: convert push-to-checkout hook to hook.h
    +    run-command: remove old run_hook_{le,ve}() hook API
     
    -    By using hook.h instead of run-command.h to invoke push-to-checkout,
    -    hooks can now be specified in the config as well as in the hookdir.
    -    push-to-checkout is not called anywhere but in builtin/receive-pack.c.
    -
    -    This is the last user of the run_hook_le() API, so let's remove it
    -    while we're at it, since run_hook_le() itself is the last user of
    -    run_hook_ve() we can remove that too. The last direct user of
    -    run_hook_le() was removed in the commit preceding this one.
    +    The new hook.h library has replaced all run-command.h hook-related
    +    functionality. So let's delete this dead code.
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## builtin/receive-pack.c ##
    -@@ builtin/receive-pack.c: static const char *push_to_checkout(unsigned char *hash,
    - 				    struct strvec *env,
    - 				    const char *work_tree)
    - {
    -+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
    -+
    - 	strvec_pushf(env, "GIT_WORK_TREE=%s", absolute_path(work_tree));
    --	if (run_hook_le(env->v, push_to_checkout_hook,
    --			hash_to_hex(hash), NULL))
    -+	strvec_pushv(&opt.env, env->v);
    -+	strvec_push(&opt.args, hash_to_hex(hash));
    -+	if (run_hooks(push_to_checkout_hook, &opt)) {
    -+		run_hooks_opt_clear(&opt);
    - 		return "push-to-checkout hook declined";
    --	else
    -+	} else {
    -+		run_hooks_opt_clear(&opt);
    - 		return NULL;
    -+	}
    - }
    - 
    - static const char *update_worktree(unsigned char *sha1, const struct worktree *worktree)
    -@@ builtin/receive-pack.c: static const char *update_worktree(unsigned char *sha1, const struct worktree *w
    - 
    - 	strvec_pushf(&env, "GIT_DIR=%s", absolute_path(git_dir));
    - 
    --	if (!find_hook(push_to_checkout_hook))
    -+	if (!hook_exists(push_to_checkout_hook))
    - 		retval = push_to_deploy(sha1, &env, work_tree);
    - 	else
    - 		retval = push_to_checkout(sha1, &env, work_tree);
    -
      ## run-command.c ##
     @@ run-command.c: int async_with_fork(void)
      #endif
17:  7020cf10c8e = 16:  53a3877a476 run-command: allow stdin for run_processes_parallel
18:  4745dcfce49 = 17:  c4f60db606d hook: support passing stdin to hooks
19:  986bfd89a54 = 18:  febf05ef232 am: convert 'post-rewrite' hook to hook.h
20:  756f52af22d = 19:  7baf2469d50 run-command: add stdin callback for parallelization
21:  3748f128763 ! 20:  2edf9dea41a hook: provide stdin by string_list or callback
    @@ Commit message
         In cases where a hook requires only a small amount of information via
         stdin, it should be simple for users to provide a string_list alone. But
         in more complicated cases where the stdin is too large to hold in
    -    memory, let's provide a callback the users can populate line after line
    -    with instead.
    +    memory, let's instead provide a callback the users can populate line
    +    after line.
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
22:  0cf0b1fea93 = 21:  303b31ee620 hook: convert 'post-rewrite' hook in sequencer.c to hook.h
23:  c59443a3b05 = 22:  62eecafb3ff transport: convert pre-push hook to use config
24:  f7c8c97cb81 ! 23:  6049b1cdc74 reference-transaction: use hook.h to run hooks
    @@ Metadata
      ## Commit message ##
         reference-transaction: use hook.h to run hooks
     
    -    By using the hook.h library, we get closer to removing the hook code
    -    in run-command.c.
    -
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
25:  f240a51ec4e = 24:  26ebbe4c545 run-command: allow capturing of collated output
26:  7f10efb7858 = 25:  251085b7525 hooks: allow callers to capture output
27:  c39c608e5cc ! 26:  e11a8f60071 receive-pack: convert 'update' hook to hook.h
    @@ Metadata
      ## Commit message ##
         receive-pack: convert 'update' hook to hook.h
     
    -    By using hook.h to invoke the 'update' hook we closer to removing the
    -    hooks code in run-command.c.
    +    This makes use of the new sideband API in hook.h added in the
    +    preceding commit.
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
28:  3519068a634 ! 27:  ecaedd13b89 post-update: use hook.h library
    @@ Metadata
      ## Commit message ##
         post-update: use hook.h library
     
    -    By using run_hooks() instead of run_hook_le(), 'post-update' hooks can
    -    be specified in the config as well as the hookdir.
    -
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
29:  3466f17af08 ! 28:  bb9d57f809a receive-pack: convert receive hooks to hook.h
    @@ Metadata
      ## Commit message ##
         receive-pack: convert receive hooks to hook.h
     
    -    By using the hook.h library to run receive hooks we get closer to
    -    deleting the hook functions in run-command.c
    -
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
30:  d93bdc0c294 ! 29:  793f112f7ab hooks: fix a TOCTOU in "did we run a hook?" heuristic
    @@ Metadata
      ## Commit message ##
         hooks: fix a TOCTOU in "did we run a hook?" heuristic
     
    -    Fix a race in code added in 680ee550d72 (commit: skip discarding the
    -    index if there is no pre-commit hook, 2017-08-14) by changing the
    -    hook.c API to optionally indicate whether or not the requested hook
    -    ran or not. This was suggested in the discussion around
    -    680ee550d72[1].
    +    Fix a Time-of-check to time-of-use (TOCTOU) race in code added in
    +    680ee550d72 (commit: skip discarding the index if there is no
    +    pre-commit hook, 2017-08-14).
     
    -    Let's also change this for the pre-merge-commit hook, see
    +    We can fix the race passing around information about whether or not we
    +    ran the hook in question, instead of running hook_exists() after the
    +    fact to check if the hook in question exists. This problem has been
    +    noted on-list when 680ee550d72 was discussed[1], but had not been
    +    fixed.
    +
    +    In addition to fixing this for the pre-commit hook as suggested there
    +    I'm also fixing this for the pre-merge-commit hook. See
         6098817fd7f (git-merge: honor pre-merge-commit hook, 2019-08-07) for
    -    the introduction of the previous behavior.
    +    the introduction of its previous behavior.
     
         Let's also change this for the push-to-checkout hook. Now instead of
         checking if the hook exists and either doing a push to checkout or a
    @@ Commit message
     
         In both of those cases we're saving ourselves CPU time by not
         preparing data for the hook that we'll then do nothing with if we
    -    don't have the hook, so using this "invoked_hook" pattern doesn't make
    -    sense there purely for optimization purposes.
    +    don't have the hook. So using this "invoked_hook" pattern doesn't make
    +    sense in those cases.
     
         More importantly, in those cases the worst we'll do is miss that we
         "should" run the hook because a new hook appeared, whereas in the
31:  896956250f6 ! 30:  bc086454d68 hook-list.h: add a generated list of hooks, like config-list.h
    @@ generate-hooklist.sh (new)
     +	cat <<EOF
     +static const char *hook_name_list[] = {
     +EOF
    -+	grep -C1 -h '^~~~' Documentation/githooks.txt |
    -+	grep '^[a-z0-9][a-z0-9-]*$' |
    -+	sort |
    -+	sed 's/^.*$/	"&",/'
    ++	perl -ne '
    ++		chomp;
    ++		@l[$.] = $_;
    ++		push @h => $l[$. - 1] if /^~~~+$/s;
    ++		END {
    ++			print qq[\t"$_",\n] for sort @h;
    ++		}
    ++	' <Documentation/githooks.txt
     +	cat <<EOF
     +	NULL,
     +};
    @@ hook.c
      	if (access(path.buf, X_OK) < 0) {
     
      ## t/t1800-hook.sh ##
    -@@ t/t1800-hook.sh: test_expect_success 'setup .git/hooks' '
    +@@ t/t1800-hook.sh: test_description='git-hook command'
      
      test_expect_success 'git hook run -- nonexistent hook' '
      	cat >stderr.expect <<-\EOF &&
-- 
2.32.0.rc3.434.gd8aed1f08a7

