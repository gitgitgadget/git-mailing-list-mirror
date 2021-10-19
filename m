Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4B1C433EF
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 23:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42E88611B0
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 23:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhJSXXl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 19:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbhJSXXk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 19:23:40 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5827C06161C
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 16:21:26 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id b189-20020a1c1bc6000000b0030da052dd4fso6165681wmb.3
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 16:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aAhpyryFly8LksTlo+YJfBETDNQ6Jk2//p3I2QXQ7r0=;
        b=NfrFTte9OqoYEm6D1QPcz6XWLqbak+9hI13rurwalHY/xDy9o3pf0GgtVkv7J9EYw+
         UnL6aj7n8BN+1t4mzNDur3kWSYZM/YFaxbTEqURcCZ4vVAQjl+AgWcpSnGtSt3Gq/uRR
         iOqLjHAzQECymv8r6n3BclskZnbH+e/ZvkHdnCP4rdbGKOXdlZdkuwZjW3MFpBFb18XM
         P7evzTK5+J4O7PIyHPctGxGJsiC19U+JDpPP1aF3bNVjfwd4293T+elaUf+yegiyjs3r
         oZyFBuDbtnY4ZzXSZvctldlOtX04DUWmhwuorncB+ByRqsDmbaaAKhtBOoisDgIcBRNr
         AExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aAhpyryFly8LksTlo+YJfBETDNQ6Jk2//p3I2QXQ7r0=;
        b=P8hx2TmAqW0yJ6XkxtTdlcRD0fSXBrCWgq1PF42PV+icwV1ubDIf9Th/SxvGXx9eaI
         Nk167DR5gjfn78BWzhIhSHTa0ijVZuW8xROZjxcIlc8NGsK25QMLPZXrlq4uNNJ/kA1z
         N1jrxtVMkAycSG16veh1QgIu7XURFaMxu9NLD4v5XEqrfhIRNfgzwvRR9/7dQ4TdZDdr
         hqUyqsWKG0QeNNeA8jWo1NGV10erSLWIgQBAAQ5kFOeUV+h4l+zDQLInAnVZAWhIWhWA
         ZZtmwvPOOpeNDCY9RR88OD6CZ93ihOjuMBE0Y80ThcJUe+jZ/QaHGMHNM19bOvjHD43I
         UKfg==
X-Gm-Message-State: AOAM532JTx0wJHDvwU7QMdtzlzD7wQmC7rN0v9tvcSR2mTdBkgCJOcG8
        YSKs4RH8+G4Ox1l0mdp7LG4AZGV4AvP9eA==
X-Google-Smtp-Source: ABdhPJy0wd75E5ffRhp11nA3lM2al9ncPmE+0OUrEvnPkSmrQUjIZ89RCMzCl5WiRtLSHdagBZLDwA==
X-Received: by 2002:a05:600c:1c88:: with SMTP id k8mr9570711wms.169.1634685685114;
        Tue, 19 Oct 2021 16:21:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g25sm304644wrc.88.2021.10.19.16.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 16:21:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 00/13] hook.[ch]: new library to run hooks + simple hook conversion
Date:   Wed, 20 Oct 2021 01:20:38 +0200
Message-Id: <cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Part 2 of the greater configurable hook saga, starting by converting
some existing simple hooks to the new hook.[ch] library and "git hook
run" utility.

For more context:

See v2: https://lore.kernel.org/git/cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com
and v1: https://lore.kernel.org/git/cover-00.13-00000000000-20211012T131934Z-avarab@gmail.com/

Changes since v2:

 * I got some of the s/struct hook/const char *hook_path/ conversion
   wrong in v1->v2, which is the cause of the bug in "seen" with
   t2400*.sh, this fixes that.

 * The commit message for the git-p4 change was also out of date (made
   sense before some previous re-ordering). I also updated a comment
   there.

 * Rebased on "master" for getting past a couple of small
   conflicts. (seen in the range-diff).

 * An include was happening in the wrong commit (was used later in the
   series), moved.

Emily Shaffer (12):
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

Ævar Arnfjörð Bjarmason (1):
  git hook run: add an --ignore-missing flag

 .gitignore                 |   1 +
 Documentation/git-hook.txt |  45 +++++++++++++
 Documentation/githooks.txt |   4 ++
 Makefile                   |   1 +
 builtin.h                  |   1 +
 builtin/am.c               |   8 ++-
 builtin/checkout.c         |  14 ++--
 builtin/clone.c            |   7 +-
 builtin/gc.c               |   3 +-
 builtin/hook.c             |  90 +++++++++++++++++++++++++
 builtin/merge.c            |   4 +-
 builtin/rebase.c           |   8 ++-
 builtin/receive-pack.c     |   7 +-
 builtin/worktree.c         |  28 ++++----
 command-list.txt           |   1 +
 commit.c                   |  15 +++--
 git-p4.py                  |  70 ++-----------------
 git-send-email.perl        |  22 +++---
 git.c                      |   1 +
 hook.c                     | 121 +++++++++++++++++++++++++++++++++
 hook.h                     |  56 ++++++++++++++++
 read-cache.c               |  11 ++-
 reset.c                    |  14 ++--
 run-command.c              |  32 ---------
 run-command.h              |  17 -----
 t/t1800-hook.sh            | 134 +++++++++++++++++++++++++++++++++++++
 t/t9001-send-email.sh      |   4 +-
 27 files changed, 550 insertions(+), 169 deletions(-)
 create mode 100644 Documentation/git-hook.txt
 create mode 100644 builtin/hook.c
 create mode 100755 t/t1800-hook.sh

Range-diff against v2:
 1:  ba64faf0580 =  1:  02fd699e699 hook: add 'run' subcommand
 2:  e3dc0aed81b =  2:  42cc4d2c3c6 gc: use hook library for pre-auto-gc hook
 3:  6227a1e644d !  3:  cbbfd77a4f6 rebase: convert pre-rebase to use hook.h
    @@ builtin/rebase.c
      #define DEFAULT_REFLOG_ACTION "rebase"
      
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
    - 	char *squash_onto_name = NULL;
      	int reschedule_failed_exec = -1;
      	int allow_preemptive_ff = 1;
    + 	int preserve_merges_selected = 0;
     +	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
      	struct option builtin_rebase_options[] = {
      		OPT_STRING(0, "onto", &options.onto_name,
 4:  0e34eb54054 =  4:  b26cef24f39 am: convert applypatch to use hook.h
 5:  a4df96c1719 !  5:  2a747a65829 hooks: convert 'post-checkout' hook to hook library
    @@ hook.c: static int notify_hook_finished(int result,
      	struct hook_cb_data cb_data = {
      		.rc = 0,
      		.hook_name = hook_name,
    +-		.hook_path = hook_path,
    + 		.options = options,
    + 	};
    + 	int jobs = 1;
     @@ hook.c: int run_hooks(const char *hook_name, const char *hook_path,
      	if (!options)
      		BUG("a struct run_hooks_opt must be provided to run_hooks");
    @@ hook.c: int run_hooks(const char *hook_name, const char *hook_path,
     +		strbuf_add_absolute_path(&abs_path, hook_path);
     +		hook_path = abs_path.buf;
     +	}
    ++	cb_data.hook_path = hook_path;
     +
      	run_processes_parallel_tr2(jobs,
      				   pick_next_hook,
    @@ hook.h: struct run_hooks_opt
      
      #define RUN_HOOKS_OPT_INIT { \
     
    - ## read-cache.c ##
    -@@
    - #include "sparse-index.h"
    - #include "csum-file.h"
    - #include "promisor-remote.h"
    -+#include "hook.h"
    - 
    - /* Mask for the name length in ce_flags in the on-disk index */
    - 
    -
      ## reset.c ##
     @@
      #include "tree-walk.h"
 6:  327f916f8c3 =  6:  7a9fd8627cd merge: convert post-merge to use hook.h
 7:  328767015b1 =  7:  840fb530df3 git hook run: add an --ignore-missing flag
 8:  6c4ebd68d56 =  8:  716ebabd794 send-email: use 'git hook run' for 'sendemail-validate'
 9:  b1f52733e3c !  9:  95782109270 git-p4: use 'git hook' to run hooks
    @@ Commit message
         Python, we can directly call 'git hook run'. We emulate the existence
         check with the --ignore-missing flag.
     
    -    As this is the last hook execution in git.git to not go through "git
    -    hook run" or the hook.[ch] library we can now be absolutely sure that
    -    our assertion in hook.c that only hooks known by the generated (from
    -    githooks(5)) hook-list.h are permitted.
    +    We're dropping the "verbose" handling added in 9f59ca4d6af (git-p4:
    +    create new function run_git_hook, 2020-02-11), those who want
    +    diagnostic output about how hooks are run are now able to get that via
    +    e.g. the trace2 facility and GIT_TRACE=1.
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## git-p4.py ##
     @@ git-p4.py: def decode_path(path):
    -         return path
      
      def run_git_hook(cmd, param=[]):
    --    """Execute a hook if the hook exists."""
    +     """Execute a hook if the hook exists."""
     -    if verbose:
     -        sys.stderr.write("Looking for hook: %s\n" % cmd)
     -        sys.stderr.flush()
    @@ git-p4.py: def decode_path(path):
     -            use_shell = True
     -    return subprocess.call(cli, shell=use_shell)
     -
    -+    """args are specified with -a <arg> -a <arg> -a <arg>"""
     +    args = ['git', 'hook', 'run', '--ignore-missing', cmd]
     +    if param:
     +        args.append("--")
10:  dc31d98acdf = 10:  706426c8a79 commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
11:  58b7689e4af ! 11:  39069a9c3ff read-cache: convert post-index-change to use hook.h
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## read-cache.c ##
    +@@
    + #include "sparse-index.h"
    + #include "csum-file.h"
    + #include "promisor-remote.h"
    ++#include "hook.h"
    + 
    + /* Mask for the name length in ce_flags in the on-disk index */
    + 
     @@ read-cache.c: static int do_write_locked_index(struct index_state *istate, struct lock_file *l
      {
      	int ret;
12:  ae1e2a82147 = 12:  9818078f1e5 receive-pack: convert push-to-checkout hook to hook.h
13:  289d5a2d849 = 13:  1bc080d3611 run-command: remove old run_hook_{le,ve}() hook API
-- 
2.33.1.1338.g20da966911a

