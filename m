Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABA5220248
	for <e@80x24.org>; Tue, 16 Apr 2019 10:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbfDPKSy (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 06:18:54 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34001 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfDPKSw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 06:18:52 -0400
Received: by mail-wm1-f65.google.com with SMTP id r186so1990178wmf.1
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 03:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=QPpRyTitZ+ouejSVJljRlAuALjakKXal2VLYVS+mhuc=;
        b=rZZvoYGv9KdmRCsy4iHx2KEs8ttA2T8O2cdyFhwpcaDS/1CkV2Q1zDogNqT8r5gAk2
         1IBkzeIs3QzZWKOOc7Je1hL3DUcKgE07gRoEyxtbZalCH5VNzJq+sVTZF2Dd6MRwDRB3
         DAPb6NSILUR4eTZClJRV0zkIC/MYbI4WnEI6dQwYWB8F6kLVCEwTwcFVvJEOHx8nGn45
         cNxBsDPAl0sgYoke7mgRWt9pHBLNcZ++YPvt3yC1uvDE6Htk07u/dKa+/oz8Myqm42QJ
         YBwhTDbfpUU7hHkjlhYG2vj9AtRygl/ZMM71ZoOn6AagDLFLeWFq/m+qkjtS3W9cKoML
         qEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=QPpRyTitZ+ouejSVJljRlAuALjakKXal2VLYVS+mhuc=;
        b=patVrtICD6DxxMnZAKSL5l6HuRVFiRgHlOsnS1wKWz1UEV6Pwcu+Tfaa4M6hGSmeiv
         WUMc/PtmoHBWcH7c2OLhBd5DUmE1nKzSIaZJR5+OQXoZJ8ggraFkEZdDuAGmOqqwRjGv
         JYTRa9+AAdfYKacfWxA8HFGkETriwZHqrSsSyb3hHvkqwakQTWqPnrdy6TSZt3JoI0j6
         88Bb4c4Ezlxggn1sWkERZSOZ17FB894Bu6NUzAzHNSU0rm2ujHpRFirNgsPyelJhcgnP
         kOAiIWPESxOKlFtDm0+L6VBqeP3WpZzL0o0rqX3uaoeZqJ9HcC3ntdO78J5wfnM4CThM
         mSCA==
X-Gm-Message-State: APjAAAXYs7HkwFjspCmXF2761h4zLsQoSioNHwk1BmIm8xtaJxr5s2Up
        ecBPc4arNrH3qVqdmT67o8cLF7Wt+YI=
X-Google-Smtp-Source: APXvYqyUE6qB+x7QtIflxsvHQq8CwEccR4xuiAVQYmT3TsiKmdggvEBwGyi+S2vWhnj+fPIm8NnaUA==
X-Received: by 2002:a05:600c:21d3:: with SMTP id x19mr26334149wmj.2.1555409930422;
        Tue, 16 Apr 2019 03:18:50 -0700 (PDT)
Received: from lindisfarne.localdomain (host-92-22-21-176.as13285.net. [92.22.21.176])
        by smtp.gmail.com with ESMTPSA id t74sm3220118wmt.3.2019.04.16.03.18.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 03:18:49 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 1/2] commit/reset: try to clean up sequencer state
Date:   Tue, 16 Apr 2019 11:18:41 +0100
Message-Id: <20190416101842.16556-2-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190416101842.16556-1-phillip.wood123@gmail.com>
References: <20190329163009.493-1-phillip.wood123@gmail.com>
 <20190416101842.16556-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When cherry-picking or reverting a sequence of commits and if the final
pick/revert has conflicts and the user uses `git commit` to commit the
conflict resolution and does not run `git cherry-pick --continue` then
the sequencer state is left behind. This can cause problems later. In my
case I cherry-picked a sequence of commits the last one of which I
committed with `git commit` after resolving some conflicts, then a while
later, on a different branch I aborted a revert which rewound my HEAD to
the end of the cherry-pick sequence on the previous branch. Avoid this
potential problem by removing the sequencer state if we're committing or
resetting the final pick in a sequence.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 branch.c                        |  4 +--
 builtin/commit.c                |  3 +-
 sequencer.c                     | 51 +++++++++++++++++++++++++++++++++
 sequencer.h                     |  1 +
 t/t3507-cherry-pick-conflict.sh | 39 +++++++++++++++++++++++++
 5 files changed, 94 insertions(+), 4 deletions(-)

diff --git a/branch.c b/branch.c
index 28b81a7e02..643694542a 100644
--- a/branch.c
+++ b/branch.c
@@ -5,6 +5,7 @@
 #include "refs.h"
 #include "refspec.h"
 #include "remote.h"
+#include "sequencer.h"
 #include "commit.h"
 #include "worktree.h"
 
@@ -339,8 +340,7 @@ void create_branch(struct repository *r,
 
 void remove_branch_state(struct repository *r)
 {
-	unlink(git_path_cherry_pick_head(r));
-	unlink(git_path_revert_head(r));
+	sequencer_post_commit_cleanup(r);
 	unlink(git_path_merge_head(r));
 	unlink(git_path_merge_rr(r));
 	unlink(git_path_merge_msg(r));
diff --git a/builtin/commit.c b/builtin/commit.c
index 2986553d5f..9df3414d80 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1657,8 +1657,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		die("%s", err.buf);
 	}
 
-	unlink(git_path_cherry_pick_head(the_repository));
-	unlink(git_path_revert_head(the_repository));
+	sequencer_post_commit_cleanup(the_repository);
 	unlink(git_path_merge_head(the_repository));
 	unlink(git_path_merge_msg(the_repository));
 	unlink(git_path_merge_mode(the_repository));
diff --git a/sequencer.c b/sequencer.c
index 0db410d590..7c7b8a07c4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2220,6 +2220,57 @@ static ssize_t strbuf_read_file_or_whine(struct strbuf *sb, const char *path)
 	return len;
 }
 
+static int have_finished_the_last_pick(void)
+{
+	struct strbuf buf = STRBUF_INIT;
+	const char *eol;
+	const char *todo_path = git_path_todo_file();
+	int ret = 0;
+
+	if (strbuf_read_file(&buf, todo_path, 0) < 0) {
+		if (errno == ENOENT) {
+			return 0;
+		} else {
+			error_errno("unable to open '%s'", todo_path);
+			return 0;
+		}
+	}
+	/* If there is only one line then we are done */
+	eol = strchr(buf.buf, '\n');
+	if (!eol || !eol[1])
+		ret = 1;
+
+	strbuf_release(&buf);
+
+	return ret;
+}
+
+void sequencer_post_commit_cleanup(struct repository *r)
+{
+	struct replay_opts opts = REPLAY_OPTS_INIT;
+	int need_cleanup = 0;
+
+	if (file_exists(git_path_cherry_pick_head(r))) {
+		unlink(git_path_cherry_pick_head(r));
+		opts.action = REPLAY_PICK;
+		need_cleanup = 1;
+	}
+
+	if (file_exists(git_path_revert_head(r))) {
+		unlink(git_path_revert_head(r));
+		opts.action = REPLAY_REVERT;
+		need_cleanup = 1;
+	}
+
+	if (!need_cleanup)
+		return;
+
+	if (!have_finished_the_last_pick())
+		return;
+
+	sequencer_remove_state(&opts);
+}
+
 static int read_populate_todo(struct repository *r,
 			      struct todo_list *todo_list,
 			      struct replay_opts *opts)
diff --git a/sequencer.h b/sequencer.h
index 4d505b3590..6c7cf8d72f 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -144,3 +144,4 @@ int read_author_script(const char *path, char **name, char **email, char **date,
 void parse_strategy_opts(struct replay_opts *opts, char *raw_opts);
 int write_basic_state(struct replay_opts *opts, const char *head_name,
 		      const char *onto, const char *orig_head);
+void sequencer_post_commit_cleanup(struct repository *r);
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 0db166152a..cebf91dce2 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -156,6 +156,25 @@ test_expect_success 'successful commit clears CHERRY_PICK_HEAD' '
 
 	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
 '
+test_expect_success 'successful final commit clears cherry-pick state' '
+	pristine_detach initial &&
+
+	test_must_fail git cherry-pick base picked-signed &&
+	echo resolved >foo &&
+	test_path_is_file .git/sequencer/todo &&
+	git commit -a &&
+	test_must_fail test_path_exists .git/sequencer
+'
+
+test_expect_success 'reset after final pick clears cherry-pick state' '
+	pristine_detach initial &&
+
+	test_must_fail git cherry-pick base picked-signed &&
+	echo resolved >foo &&
+	test_path_is_file .git/sequencer/todo &&
+	git reset &&
+	test_must_fail test_path_exists .git/sequencer
+'
 
 test_expect_success 'failed cherry-pick produces dirty index' '
 	pristine_detach initial &&
@@ -316,6 +335,26 @@ test_expect_success 'failed commit does not clear REVERT_HEAD' '
 	test_cmp_rev picked REVERT_HEAD
 '
 
+test_expect_success 'successful final commit clears revert state' '
+       pristine_detach picked-signed &&
+
+       test_must_fail git revert picked-signed base &&
+       echo resolved >foo &&
+       test_path_is_file .git/sequencer/todo &&
+       git commit -a &&
+       test_must_fail test_path_exists .git/sequencer
+'
+
+test_expect_success 'reset after final pick clears revert state' '
+       pristine_detach picked-signed &&
+
+       test_must_fail git revert picked-signed base &&
+       echo resolved >foo &&
+       test_path_is_file .git/sequencer/todo &&
+       git reset &&
+       test_must_fail test_path_exists .git/sequencer
+'
+
 test_expect_success 'revert conflict, diff3 -m style' '
 	pristine_detach initial &&
 	git config merge.conflictstyle diff3 &&
-- 
2.21.0

