Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AE1C433EF
	for <git@archiver.kernel.org>; Sat,  4 Dec 2021 05:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbhLDFk1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Dec 2021 00:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbhLDFk1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Dec 2021 00:40:27 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E521C061751
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 21:37:02 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d24so10348404wra.0
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 21:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=snML+fKBbbiWLP0GCW5zSDOeQsw9/kBbnObPT4kOlvs=;
        b=KBU7DWosVD+1NIrT37KfPPG4N2cezZ4rBSCMqJ+b+Rw9WYF+6AvqaTb/NWzwIa5n6b
         ck26o0HS3pRX7DjJOdkKYJt3axDkdNlDcbY/OGkrR5Sa03RMzH4YjH3y8HKOvk8GOx3q
         YnhXT1beflMZ7cmToezQ+bwa8WHQgLAM2VEXZ2nGhCK4CrEUWSJW6KtfDWjT9kXtmw6V
         i4OB5r6zYtsYX21QfULX+vCaYxZ9PksrGN8K/pQfTqNfU6hmdVpKuBLgvVvn8uLVdhbf
         QzZA/LOWDmrbIhfzW3Fe2FgQdLBEF/ajEyJydtu/u7hlTaxVyg0ZrI5r2a8z8d7PfkRo
         9/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=snML+fKBbbiWLP0GCW5zSDOeQsw9/kBbnObPT4kOlvs=;
        b=nPRJ/7bO3pHlaNU0U1yCSysHtfSHHEtX4GeOS6t9ZRoDQfViW1FRE5oFhihVlyJa/R
         QFVpnkfaYUHyYds0E5P7s2UQ/aeDyJyCJYZTENxfiis5W4aeKGHHQNKE/Y3MW2vbyLuZ
         AglA9MfdkdGIshGWN7kWqBEu40dUYufW5qwIix2IvRQl8GXwUS6IhpWXWIfWHmzfXr8j
         xhU8gIa/F4w4w5+Ad5Vkv/8IClPFEvWsn1MjeJ7EH9XnCoxEA0C6gR1S1tJaKSdmc+iH
         efwZU1Jeg02RXzVv4Pz3HewuVsNAaUClQc9uP3Sw5I11sWEJWAF8TH+yupZvepoOkkLG
         RDZQ==
X-Gm-Message-State: AOAM530V5frjxpePpvX5kJ0uYAzsK9qpgOIUF0kQ5XNbb53tp6Yb5r4h
        ODFr5fT3LJ1ihkCE/NJPb2UK9hP75Ts=
X-Google-Smtp-Source: ABdhPJwCRybRL6vqG2dVWbDIqH0U6TdMPrK1rY6fG8S3xTzGjUuWb4KgSnK081C4TTjPone0PRpaOw==
X-Received: by 2002:adf:e54a:: with SMTP id z10mr25726678wrm.328.1638596220712;
        Fri, 03 Dec 2021 21:37:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y7sm4389188wrw.55.2021.12.03.21.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 21:37:00 -0800 (PST)
Message-Id: <pull.1134.v3.git.git.1638596219656.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.v2.git.git.1637041986945.gitgitgadget@gmail.com>
References: <pull.1134.v2.git.git.1637041986945.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 04 Dec 2021 05:36:59 +0000
Subject: [PATCH v3] sequencer: do not export GIT_DIR and GIT_WORK_TREE for
 'exec'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Commands executed from `git rebase --exec` can give different behavior
from within that environment than they would outside of it, due to the
fact that sequencer.c exports both GIT_DIR and GIT_WORK_TREE.  For
example, if the relevant script calls something like

  git -C ../otherdir log --format=%H --no-walk

the user may be surprised to find that the command above does not show a
commit hash from ../otherdir, because $GIT_DIR prevents automatic gitdir
detection and makes the -C option useless.

This is a regression in behavior from the original legacy
implemented-in-shell rebase.  It is perhaps rare for it to cause
problems in practice, especially since most small problems that were
caused by this area of bugs has been fixed-up in the past in a way that
masked the particular bug observed without fixing the real underlying
problem.

An explanation of how we arrived at the current situation is perhaps
merited.  The setting of GIT_DIR and GIT_WORK_TREE done by sequencer.c
arose from a sequence of historical accidents:

* When rebase was implemented as a shell command, it would call
  git-sh-setup, which among other things would set GIT_DIR -- but not
  export it.  This meant that when rebase --exec commands were run via
      /bin/sh -c "$COMMAND"
  they would not inherit the GIT_DIR setting.  The fact that GIT_DIR
  was not set in the run $COMMAND is the behavior we'd like to restore.

* When the rebase--helper builtin was introduced to allow incrementally
  replacing shell with C code, we had an implementation that was half
  shell, half C.  In particular, commit 18633e1a22 ("rebase -i: use the
  rebase--helper builtin", 2017-02-09) added calls to
      exec git rebase--helper ...
  which caused rebase--helper to inherit the GIT_DIR environment
  variable from the shell.  git's setup would change the environment
  variable from an absolute path to a relative one (".git"), but would
  leave it set.  This meant that when rebase --exec commands were run
  via
      run_command_v_opt(...)
  they would inherit the GIT_DIR setting.

* In commit 09d7b6c6fa ("sequencer: pass absolute GIT_DIR to exec
  commands", 2017-10-31), it was noted that the GIT_DIR caused problems
  with some commands; e.g.
      git rebase --exec 'cd subdir && git describe' ...
  would have GIT_DIR=.git which was invalid due to the change to the
  subdirectory.  Instead of questioning why GIT_DIR was set, that commit
  instead made sequencer change GIT_DIR to be an absolute path and
  explicitly export it via
      argv_array_pushf(&child_env, "GIT_DIR=%s", absolute_path(get_git_dir()));
      run_command_v_opt_cd_env(..., child_env.argv)

* In commit ab5e67d751 ("sequencer: pass absolute GIT_WORK_TREE to exec
  commands", 2018-07-14), it was noted that when GIT_DIR is set but
  GIT_WORK_TREE is not, that we do not discover GIT_WORK_TREE but just
  assume it is '.'.  That is incorrect if trying to run commands from a
  subdirectory.  However, rather than question why GIT_DIR was set, that
  commit instead also added GIT_WORK_TREE to the list of things to
  export.

Each of the above problems would have been fixed automatically when
git-rebase became a full builtin, had it not been for the fact that
sequencer.c started exporting GIT_DIR and GIT_WORK_TREE in the interim.
Stop exporting them now.

Signed-off-by: Elijah Newren <newren@gmail.com>
Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Acked-by: Johannes Altmanninger <aclopte@gmail.com>
Acked-by: Phillip Wood <phillip.wood123@gmail.com>
---
    sequencer: fix environment that 'exec' commands run under
    
    Changes since v2:
    
     * Make sure I've included all 3 Acked-by's.
     * The 2.35 cycle has started and it's been weeks since I sent v2, so
       it's time to resend. :-)
    
    Changes since v1:
    
     * Fix wording in multiple locations pointed out by Johannes
       Altmanninger

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1134%2Fnewren%2Ffix-rebase-exec-environ-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1134/newren/fix-rebase-exec-environ-v3
Pull-Request: https://github.com/git/git/pull/1134

Range-diff vs v2:

 1:  c647c45375a ! 1:  4f5862c212f sequencer: do not export GIT_DIR and GIT_WORK_TREE for 'exec'
     @@ Commit message
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
          Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
     +    Acked-by: Johannes Altmanninger <aclopte@gmail.com>
     +    Acked-by: Phillip Wood <phillip.wood123@gmail.com>
      
       ## sequencer.c ##
      @@ sequencer.c: static int error_failed_squash(struct repository *r,


 sequencer.c               |  9 +--------
 t/t3409-rebase-environ.sh | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+), 8 deletions(-)
 create mode 100755 t/t3409-rebase-environ.sh

diff --git a/sequencer.c b/sequencer.c
index ea96837cde3..9afdbe3e3d1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3495,17 +3495,12 @@ static int error_failed_squash(struct repository *r,
 
 static int do_exec(struct repository *r, const char *command_line)
 {
-	struct strvec child_env = STRVEC_INIT;
 	const char *child_argv[] = { NULL, NULL };
 	int dirty, status;
 
 	fprintf(stderr, _("Executing: %s\n"), command_line);
 	child_argv[0] = command_line;
-	strvec_pushf(&child_env, "GIT_DIR=%s", absolute_path(get_git_dir()));
-	strvec_pushf(&child_env, "GIT_WORK_TREE=%s",
-		     absolute_path(get_git_work_tree()));
-	status = run_command_v_opt_cd_env(child_argv, RUN_USING_SHELL, NULL,
-					  child_env.v);
+	status = run_command_v_opt(child_argv, RUN_USING_SHELL);
 
 	/* force re-reading of the cache */
 	if (discard_index(r->index) < 0 || repo_read_index(r) < 0)
@@ -3535,8 +3530,6 @@ static int do_exec(struct repository *r, const char *command_line)
 		status = 1;
 	}
 
-	strvec_clear(&child_env);
-
 	return status;
 }
 
diff --git a/t/t3409-rebase-environ.sh b/t/t3409-rebase-environ.sh
new file mode 100755
index 00000000000..83ffb39d9ff
--- /dev/null
+++ b/t/t3409-rebase-environ.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+
+test_description='git rebase interactive environment'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit one &&
+	test_commit two &&
+	test_commit three
+'
+
+test_expect_success 'rebase --exec does not muck with GIT_DIR' '
+	git rebase --exec "printf %s \$GIT_DIR >environ" HEAD~1 &&
+	test_must_be_empty environ
+'
+
+test_expect_success 'rebase --exec does not muck with GIT_WORK_TREE' '
+	git rebase --exec "printf %s \$GIT_WORK_TREE >environ" HEAD~1 &&
+	test_must_be_empty environ
+'
+
+test_done

base-commit: 88d915a634b449147855041d44875322de2b286d
-- 
gitgitgadget
