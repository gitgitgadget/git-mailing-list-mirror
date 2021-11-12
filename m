Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86B0C433F5
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 17:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E4BD604DB
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 17:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbhKLRpr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 12:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbhKLRpq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 12:45:46 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DE3C061766
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 09:42:55 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id i12so7541737wmq.4
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 09:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=FkpMp3XYrq21/NEPmpEAlIjHhQqqMQ5OFa9N7TXBFG8=;
        b=oQl25kN8rTFcyQ+zH4SQJ89qPPaDgH+h8QIX8injp9iInAngCYqZMQ8/05Mq0T8Ihd
         Tam4+OJJkwvlLx8rvemf4nMhj4Oq9Wygy1fJ53goPdx21dQaqp3EYXXQeV+nQxSTmeS6
         CrheSBS7ahdsbf7A+YTezCaxjWo8Tj0XpnuaUxLApOjfcIr63/ouQMsEontEX6Nlw3+d
         aUGKfMctoRp5G3985RihXRHEmoMtVdOjWcNgYB/dnPYVuSECBhwUT0pgfyNU5p1wl/Oq
         O7dJ939xVJTzrZqTu7KARCUnK3rDC8m76xxWNdd68T7iB21L+y50SZSgcBrhABBykfGc
         ZR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FkpMp3XYrq21/NEPmpEAlIjHhQqqMQ5OFa9N7TXBFG8=;
        b=nQs368QZysd5LIhOy9dSqsf+3sH9zZEr9NEmoCXHU+ndhg79JJturh9zOve3D7FrTN
         mM+G0MEa+le0lL9GluX/G+k7/XGgPfToq18pvpYwQz2/CnqafGiM4GQ+a88Fkf4vxUYm
         SkahEflOybts8b2CA0HhQw8FKbmeyxyWKSJd/MFQyKB1VDEnkVq0PgLTJ4wrssUa0lgT
         oROQs19exg0SWUmkofyP1OQvxp4NC6NhWbOKBGj2cts8EO5Hk+AMTHpyQvnTYQTCvzRD
         zHFjWudFTr8FERHF2hGXYXf85nUBSenoQ11wtn8kTUpbmnOAyvUoJmZtIdVyN04P0Md/
         mJ/g==
X-Gm-Message-State: AOAM532+8DX2SoYxKaBb0fsFax9AALu6KDfkVCVG7n0QxuoD74nWK2us
        /h9LZ8CFq65SXPCBbd4UTJ5BfiXQ4/k=
X-Google-Smtp-Source: ABdhPJydpAHfHr0ZedZmQKpmv7AjtSQeSRqbGz+TmHV0jL46VTk+RqedSaCdUUIEDZ6UNf+W59U1wg==
X-Received: by 2002:a7b:c8ca:: with SMTP id f10mr36271871wml.6.1636738974034;
        Fri, 12 Nov 2021 09:42:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w17sm6532740wrp.79.2021.11.12.09.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 09:42:53 -0800 (PST)
Message-Id: <pull.1134.git.git.1636738973089.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 Nov 2021 17:42:52 +0000
Subject: [PATCH] sequencer: fix environment that 'exec' commands run under
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
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

How we arrived at the current situation is perhaps merited.  The setting
of GIT_DIR and GIT_WORK_TREE done by sequencer.c arose from a sequence
of historical accidents:

* When rebase was implemented as a shell command, it would call
  git-sh-setup, which among other things would set GIT_DIR -- but not
  export it.  This meant that when rebase --exec commands were run via
      /bin/sh -c "$COMMAND"
  they would not inherit the GIT_DIR setting.  The fact that GIT_DIR
  was not set in the run $COMMAND is the behavior we'd like to restore.

* When the rebase--helper builtin was introduced to allow incrementally
  replacing shell with C code, we were in an implementation that was
  half shell, half C.  In particular, commit 18633e1a22 ("rebase -i: use
  the rebase--helper builtin", 2017-02-09) added calls to
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
git-rebase become a full builtin, had it not been for the fact that
sequencer.c started exporting GIT_DIR and GIT_WORK_TREE in the interim.
Stop exporting them now.

Signed-off-by: Elijah Newren <newren@gmail.com>
Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    sequencer: fix environment that 'exec' commands run under
    
    I'm not sure if the added regression tests make sense, or if t3409 is
    the best place to put them (taking over a recently removed t3409 that
    was used for the deprecated preserve merges option).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1134%2Fnewren%2Ffix-rebase-exec-environ-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1134/newren/fix-rebase-exec-environ-v1
Pull-Request: https://github.com/git/git/pull/1134

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
