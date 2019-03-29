Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45401202BB
	for <e@80x24.org>; Fri, 29 Mar 2019 16:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbfC2Qc2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 12:32:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44058 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbfC2Qc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 12:32:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id y7so3305140wrn.11
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 09:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=Py/bPB5sbovzenr2sctxEbkMb5g2NI5LKmdsc9jJR1s=;
        b=aHKvuuZ6vn5AZFHJL7rRNvJtAAevWCUTBIskiZUGX5JUvKvQ7Pz2kslymTWSaGYVY2
         +m1e6n1b+vdkXNm450xYI2cbR2PMXKGohfI69p9efiBOrJRuqH8QwtDikO/9nhTC3U8c
         RlttnVqn4H/KkPMllFj6tSnNWRtdb6GWUk57zoCrHZFxaQ85z+I0gM4Acw4X5aFnc06O
         EbTwSBNgpv+X7rrZHRDII3GolR5QTgjGDJeqjJ4kkZ7RZXUm+Wp2ANp78+HdEUZS5v2b
         Va6OO9RqMVcvNsFgVf435dRKZ+b8/bYR3TBDQzqIEpcKc/ReZV5IwIDiCRMvdqQTyNxs
         uuOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=Py/bPB5sbovzenr2sctxEbkMb5g2NI5LKmdsc9jJR1s=;
        b=ddP+I/tEk+aXEq4LO2hUijjHwxzaxDflYuJUhmcjjJSKDvYfZwcWIv6a7dLKW/hHP+
         qjsEbb8WMIXgii58LsXUxXRTOjzod9B3NOKLfDibw30k5Hd3HcB6CLxMi2sgzXArln9R
         3EKIJA9cKB445dWvjox6g6i6VnQMzYLLAiqdbBpIVGRSWexccDoZbTkVrTot9DES+7wc
         tJFgPn9TA1ciSWJyPJa80Gr9PV8cmeviXkti76jMfC/QM1u2TegdcO2rRotvMZQDptO9
         C3fi5GFnjADi1Zlyeck2KNs7pSUw3NNUHW0jx3WYxM8d+EGokLR11ri8bWe495y0cOc3
         7h9g==
X-Gm-Message-State: APjAAAUq/Hv53QIKOVBy8EIHHh0oiS2tk3haMQeccMH3rV27gZVqyGhl
        vN7GbQvsHBC/m2vcrEPS3AYofCZhqM4=
X-Google-Smtp-Source: APXvYqyEDOaMI9BYzJBubj5+0Cah+cU+RGV9xP7bUTOTBZVhf1nGYKMtwYKpBL+ng7pAoiSn1fHu0Q==
X-Received: by 2002:a5d:6181:: with SMTP id j1mr31106456wru.11.1553877144992;
        Fri, 29 Mar 2019 09:32:24 -0700 (PDT)
Received: from localhost.localdomain (host-89-242-191-183.as13285.net. [89.242.191.183])
        by smtp.gmail.com with ESMTPSA id j64sm3463175wmb.36.2019.03.29.09.32.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 09:32:24 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 1/2] commit/reset: try to clean up sequencer state
Date:   Fri, 29 Mar 2019 16:30:08 +0000
Message-Id: <20190329163009.493-2-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190329163009.493-1-phillip.wood123@gmail.com>
References: <20190329163009.493-1-phillip.wood123@gmail.com>
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
 branch.c                        |  7 +++++--
 builtin/commit.c                |  7 +++++--
 sequencer.c                     | 23 +++++++++++++++++++++++
 sequencer.h                     |  1 +
 t/t3507-cherry-pick-conflict.sh | 19 +++++++++++++++++++
 5 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/branch.c b/branch.c
index 28b81a7e02..9ed60081c1 100644
--- a/branch.c
+++ b/branch.c
@@ -5,6 +5,7 @@
 #include "refs.h"
 #include "refspec.h"
 #include "remote.h"
+#include "sequencer.h"
 #include "commit.h"
 #include "worktree.h"
 
@@ -339,8 +340,10 @@ void create_branch(struct repository *r,
 
 void remove_branch_state(struct repository *r)
 {
-	unlink(git_path_cherry_pick_head(r));
-	unlink(git_path_revert_head(r));
+	if (!unlink(git_path_cherry_pick_head(r)))
+		sequencer_post_commit_cleanup();
+	if (!unlink(git_path_revert_head(r)))
+		sequencer_post_commit_cleanup();
 	unlink(git_path_merge_head(r));
 	unlink(git_path_merge_rr(r));
 	unlink(git_path_merge_msg(r));
diff --git a/builtin/commit.c b/builtin/commit.c
index 2986553d5f..422b7d62a5 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1657,8 +1657,10 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		die("%s", err.buf);
 	}
 
-	unlink(git_path_cherry_pick_head(the_repository));
-	unlink(git_path_revert_head(the_repository));
+	if (!unlink(git_path_cherry_pick_head(the_repository)))
+		sequencer_post_commit_cleanup();
+	if (!unlink(git_path_revert_head(the_repository)))
+		sequencer_post_commit_cleanup();
 	unlink(git_path_merge_head(the_repository));
 	unlink(git_path_merge_msg(the_repository));
 	unlink(git_path_merge_mode(the_repository));
@@ -1678,6 +1680,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	if (amend && !no_post_rewrite) {
 		commit_post_rewrite(the_repository, current_head, &oid);
 	}
+
 	if (!quiet) {
 		unsigned int flags = 0;
 
diff --git a/sequencer.c b/sequencer.c
index 0db410d590..028699209f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2220,6 +2220,29 @@ static ssize_t strbuf_read_file_or_whine(struct strbuf *sb, const char *path)
 	return len;
 }
 
+void sequencer_post_commit_cleanup(void)
+{
+	struct replay_opts opts = REPLAY_OPTS_INIT;
+	struct strbuf buf = STRBUF_INIT;
+	const char *eol;
+	const char *todo_path = git_path_todo_file();
+
+	if (strbuf_read_file(&buf, todo_path, 0) < 0) {
+		if (errno == ENOENT) {
+			return;
+		} else {
+			error_errno("unable to open '%s'", todo_path);
+			return;
+		}
+	}
+	/* If there is only one line then we are done */
+	eol = strchr(buf.buf, '\n');
+	if (!eol || !eol[1])
+		sequencer_remove_state(&opts);
+
+	strbuf_release(&buf);
+}
+
 static int read_populate_todo(struct repository *r,
 			      struct todo_list *todo_list,
 			      struct replay_opts *opts)
diff --git a/sequencer.h b/sequencer.h
index 4d505b3590..43548295a1 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -144,3 +144,4 @@ int read_author_script(const char *path, char **name, char **email, char **date,
 void parse_strategy_opts(struct replay_opts *opts, char *raw_opts);
 int write_basic_state(struct replay_opts *opts, const char *head_name,
 		      const char *onto, const char *orig_head);
+void sequencer_post_commit_cleanup(void);
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 0db166152a..69e6389e69 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -156,6 +156,25 @@ test_expect_success 'successful commit clears CHERRY_PICK_HEAD' '
 
 	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
 '
+test_expect_success 'successful final commit clears sequencer state' '
+	pristine_detach initial &&
+
+	test_must_fail git cherry-pick base picked-signed &&
+	echo resolved >foo &&
+	test_path_is_file .git/sequencer/todo &&
+	git commit -a &&
+	test_must_fail test_path_exists .git/sequencer
+'
+
+test_expect_success 'reset after final pick clears sequencer state' '
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
-- 
2.21.0

