Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE47C07E9E
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 00:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CBBA6135B
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 00:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhGKAaK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 20:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhGKAaK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 20:30:10 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D4AC0613DD
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 17:27:23 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id k31-20020a05600c1c9fb029021727d66d33so7276717wms.0
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 17:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=A2MsytVDZ/MKYVzl8V4+XT6FUu+fzgflwk26I0FOry8=;
        b=aoXM/6oNF+ZibdLwXmlzNm3MxRlBpE86fEvUa1tZBdejkJvwTBI7+d346Yy0OvxIdv
         lFDE9Il4zvsaxLFB39SgvZWG9OHOzbxseoS3/kdf9WylxZ4g2Z9Pzk9cl41wq0upUSJU
         cw8bhdDv1ItAFIALYVcFhIUuzcyFQcyKSQzIx2wpELR2n/Hk4NKcC8/FrH0Uuf9yFWcG
         jVy2Xhg7qUQoy06sKyNAH0nQWmDNArlTuwkSRxgE91Cm7Oau04OCaeOEGcnafx09Va7N
         e0XzfmDIIMROK33EcimqKofhcStdbBwW8066BrddrcjS1MCSzw0lPK7BJXTIINci/ODZ
         PPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=A2MsytVDZ/MKYVzl8V4+XT6FUu+fzgflwk26I0FOry8=;
        b=KsM5d3fwC1/y2LnVdS7zuq4UnkmfGyho9Y+juaHe18MWFsrcD5wj6walaxNefMCRDm
         kUGhn2tZ2NgvPC5wb1Mii05GV6eVB91WQZdopjZ6kMcZR8RETVOM20Rl0M4ObjpaPhpO
         MJqqTbgvJGN9sQnyNT2EiTesWMxZoGuuAAV0VvouskILe/ddsd/xIBQ1jF1NfiQBLO+p
         OXkemH3wDw8ZezGqPMwZOjuABPCR0rNtd5F4hiqMQwHf8ZP4tw1wDYZTjfg8fBiDVX50
         fiQI8loPkiDQHQRpaLxfBmbHOuG5Hc2eK3vBAhzKokPaNZWFQA/D5d7roCSNf2lsOTQ4
         zIrA==
X-Gm-Message-State: AOAM533Ewrvj4Qm0HMFTrwZzzBVa94ILmrnLG6CYExnkxkT8SXaetpIK
        lGgLzcZ879IITQkeUJKiCSzip6ZZXwI=
X-Google-Smtp-Source: ABdhPJxpAu2B0ml+GPoMnv8KCT/A1ugPySg2WE5uclTQYsWPwggaKj9uxwu6gyJKs4dr7hvN07Ri0g==
X-Received: by 2002:a7b:c5d2:: with SMTP id n18mr6659685wmk.97.1625963241801;
        Sat, 10 Jul 2021 17:27:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v15sm16228050wmj.39.2021.07.10.17.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 17:27:21 -0700 (PDT)
Message-Id: <pull.992.v3.git.1625963240.gitgitgadget@gmail.com>
In-Reply-To: <pull.992.v2.git.1625759443.gitgitgadget@gmail.com>
References: <pull.992.v2.git.1625759443.gitgitgadget@gmail.com>
From:   "Stephen Manz via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 11 Jul 2021 00:27:17 +0000
Subject: [PATCH v3 0/3] worktree: teach add to accept --reason with --lock
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Stephen Manz <smanz@alum.mit.edu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The default reason stored in the lock file, "added with --lock", is unlikely
to be what the user would have given in a separate git worktree lock
command. Allowing --reason to be specified along with --lock when adding a
working tree gives the user control over the reason for locking without
needing a second command.

Changes since v2:

 * Updated first of the 3 commits to include a step in the test to unlock
   the worktree when test completes and modified commit message accordingly.
 * Updated second commit to wrap "initializing" string with _() to mark it
   for translation, as requested. I had originally opted not to mark it,
   since, when --lock is not given, file locked gets removed after the
   working tree is populated. Thus, it's not really user-facing. Modified
   the commit message accordingly.
 * Updated the third commit to have no new lock_reason member of struct
   add_opts and changed type of member keep_locked from int to const char *,
   as suggested.

The file, .git/worktrees/name-of-worktree/locked, is created even if --lock
isn't given, although only temporarily. In this instance, "initializing" is
written to the file, but the file is removed at the end of the add-worktree
operation. My goal was to maintain this behavior,

Changes since v1:

 * Split changes into 3 commits. The first commit is removal of git
   rev-parse in the test above the ones I'm adding. The second is wrapping
   the "added with --lock" string with _() to mark it for translation. The
   third commit is the main change.
 * Reworked the if-else-if-else to if-else if-else
 * Added test_when_finished ... command to unlock the working tree
 * Changed test_expect_failure to test_expect_success and embedded
   test_must_fail and test_path_is_missing commands

Note: I don't see how to disambiguate --lock with no --reason from no --lock
at all. I still think that the original keep_locked boolean is needed along
with the new lock_reason char array. If I don't add lock_reason and change
keep_locked to a char array, it will start as NULL. But it will remain NULL
if --lock alone is given or if --lock isn't given at all.

cc: Eric Sunshine sunshine@sunshineco.com

Stephen Manz (3):
  t2400: clean up '"add" worktree with lock' test
  worktree: mark lock strings with `_()` for translation
  worktree: teach `add` to accept --reason <string> with --lock

 Documentation/git-worktree.txt |  4 ++--
 builtin/worktree.c             | 21 ++++++++++++++++-----
 t/t2400-worktree-add.sh        | 15 ++++++++++++++-
 3 files changed, 32 insertions(+), 8 deletions(-)


base-commit: d486ca60a51c9cb1fe068803c3f540724e95e83a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-992%2FSRManz%2Flock_reason-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-992/SRManz/lock_reason-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/992

Range-diff vs v2:

 1:  5459e5bb421 ! 1:  5618933279d t2400: remove unneeded `git rev-parse` from '"add" worktree with lock' test
     @@ Metadata
      Author: Stephen Manz <smanz@alum.mit.edu>
      
       ## Commit message ##
     -    t2400: remove unneeded `git rev-parse` from '"add" worktree with lock' test
     +    t2400: clean up '"add" worktree with lock' test
      
     -    It must have come from a copy-paste of another test
     +    - remove unneeded `git rev-parse` which must have come from a copy-paste
     +      of another test
     +    - unlock the worktree with test_when_finished
      
          Signed-off-by: Stephen Manz <smanz@alum.mit.edu>
      
     @@ t/t2400-worktree-add.sh: test_expect_success '"add" worktree' '
       test_expect_success '"add" worktree with lock' '
      -	git rev-parse HEAD >expect &&
       	git worktree add --detach --lock here-with-lock main &&
     ++	test_when_finished "git worktree unlock here-with-lock || :" &&
       	test -f .git/worktrees/here-with-lock/locked
       '
     + 
 2:  30196cc9369 ! 2:  ceb7a58b004 worktree: default lock string should be marked with `_()` for translation
     @@ Metadata
      Author: Stephen Manz <smanz@alum.mit.edu>
      
       ## Commit message ##
     -    worktree: default lock string should be marked with `_()` for translation
     +    worktree: mark lock strings with `_()` for translation
     +
     +    - default lock string, "added with --lock"
     +    - temporary lock string, "initializing"
      
          Signed-off-by: Stephen Manz <smanz@alum.mit.edu>
      
       ## builtin/worktree.c ##
      @@ builtin/worktree.c: static int add_worktree(const char *path, const char *refname,
     + 	 */
     + 	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
       	if (!opts->keep_locked)
     - 		write_file(sb.buf, "initializing");
     +-		write_file(sb.buf, "initializing");
     ++		write_file(sb.buf, _("initializing"));
       	else
      -		write_file(sb.buf, "added with --lock");
      +		write_file(sb.buf, _("added with --lock"));
 3:  4d17b31921a ! 3:  9a414a3078b worktree: teach `add` to accept --reason <string> with --lock
     @@ Documentation/git-worktree.txt: With `list`, annotate missing working trees as p
      
       ## builtin/worktree.c ##
      @@ builtin/worktree.c: struct add_opts {
     + 	int detach;
       	int quiet;
       	int checkout;
     - 	int keep_locked;
     -+	const char *lock_reason;
     +-	int keep_locked;
     ++	const char *keep_locked;
       };
       
       static int show_only;
      @@ builtin/worktree.c: static int add_worktree(const char *path, const char *refname,
     + 	 * after the preparation is over.
     + 	 */
       	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
     - 	if (!opts->keep_locked)
     - 		write_file(sb.buf, "initializing");
     -+	else if (opts->lock_reason)
     -+		write_file(sb.buf, "%s", opts->lock_reason);
     +-	if (!opts->keep_locked)
     +-		write_file(sb.buf, _("initializing"));
     ++	if (opts->keep_locked)
     ++		write_file(sb.buf, "%s", opts->keep_locked);
       	else
     - 		write_file(sb.buf, _("added with --lock"));
     +-		write_file(sb.buf, _("added with --lock"));
     ++		write_file(sb.buf, _("initializing"));
       
     + 	strbuf_addf(&sb_git, "%s/.git", path);
     + 	if (safe_create_leading_directories_const(sb_git.buf))
      @@ builtin/worktree.c: static int add(int ac, const char **av, const char *prefix)
     + 	const char *branch;
     + 	const char *new_branch = NULL;
     + 	const char *opt_track = NULL;
     ++	const char *lock_reason = NULL;
     ++	int keep_locked = 0;
     + 	struct option options[] = {
     + 		OPT__FORCE(&opts.force,
     + 			   N_("checkout <branch> even if already checked out in other worktree"),
     +@@ builtin/worktree.c: static int add(int ac, const char **av, const char *prefix)
     + 			   N_("create or reset a branch")),
       		OPT_BOOL('d', "detach", &opts.detach, N_("detach HEAD at named commit")),
       		OPT_BOOL(0, "checkout", &opts.checkout, N_("populate the new working tree")),
     - 		OPT_BOOL(0, "lock", &opts.keep_locked, N_("keep the new working tree locked")),
     -+		OPT_STRING(0, "reason", &opts.lock_reason, N_("string"),
     +-		OPT_BOOL(0, "lock", &opts.keep_locked, N_("keep the new working tree locked")),
     ++		OPT_BOOL(0, "lock", &keep_locked, N_("keep the new working tree locked")),
     ++		OPT_STRING(0, "reason", &lock_reason, N_("string"),
      +			   N_("reason for locking")),
       		OPT__QUIET(&opts.quiet, N_("suppress progress reporting")),
       		OPT_PASSTHRU(0, "track", &opt_track, NULL,
     @@ builtin/worktree.c: static int add(int ac, const char **av, const char *prefix)
       	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
       	if (!!opts.detach + !!new_branch + !!new_branch_force > 1)
       		die(_("-b, -B, and --detach are mutually exclusive"));
     -+	if (opts.lock_reason && !opts.keep_locked)
     ++	if (lock_reason && !keep_locked)
      +		die(_("--reason requires --lock"));
     ++	if (lock_reason)
     ++		opts.keep_locked = lock_reason;
     ++	else if (keep_locked)
     ++		opts.keep_locked = _("added with --lock");
     ++
       	if (ac < 1 || ac > 2)
       		usage_with_options(worktree_usage, options);
       

-- 
gitgitgadget
