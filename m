Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBF8D20248
	for <e@80x24.org>; Tue, 16 Apr 2019 10:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbfDPKSz (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 06:18:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35189 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfDPKSx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 06:18:53 -0400
Received: by mail-wm1-f66.google.com with SMTP id y197so12777838wmd.0
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 03:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=u7kCqJ9qNi3xnazzAy8usIS3JjkvlHaD3GHraxX3K3E=;
        b=BCuhf1rfEVOpaBHcqEDxaP+g7uHmzLhAGDqpu3CXncfZKBZQGP2D9MAo7dNCZa/xu9
         gzmlDhSLzTVH/q6I/l0VfUBCg2VXTzkVFoxgjZXjhrpTAxSrWg+ZEsWSO/+lKo2LRlQT
         3WARCD2ck9vGLvCURODXd8rxag4kwrhvvqxsaNrGV8AkUIIGQmHWfAtIK2ScJICSbh2S
         RKyNJ/If+B5YLaHQGHdczwVYgrKeuLjjBlTje8MdchAOSiUT0ITsMTkd6WqBBCc2vXEb
         cFvS/McIjx+sApbPwzqg74tQCzgt0bY4OzVDSM57bhox7jZ7OvvLXIbrtEqp8CdIqk4s
         9zow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=u7kCqJ9qNi3xnazzAy8usIS3JjkvlHaD3GHraxX3K3E=;
        b=BWVRzop++9jZGyTh79DjVgea+aIbJ5tOpbbjhIOVJYHBvLXTixXrOQeuP81oB3dM1S
         byucnrC4/uv8NJuSXxA9BOntwntmWHbq9TzIvas5+f1dVBk/decT9KJy6THBedmKu7Y9
         nB2bUeWa4b8SROWkjCjmxS2kWisv5OJ3EDCTGilOaflC5NPJiEm7Ooo+8l43XWJXD6ya
         AQnj14BTiB4zVx0k6H/ajBoUddtd/xqxqEPR7wkk84PSuqTal+O9eUTg8bm/M0mT2wjU
         wi747H8AUGwhr5KqhlWLyL2YwH/rRi47feI0DysNMDhjIXFDKEkU+yfg3hvbriWNCYf2
         buWw==
X-Gm-Message-State: APjAAAUN7HAnV/MN+Tcz6YGjeuyNe0sRsY8CXuI5nhW88SMpRW5toBSE
        ysoyA1A6U1SYkM78BpzAtYs0pABfqoE=
X-Google-Smtp-Source: APXvYqyV+e15bZgTCCGd79K50nyYokutGKcSRmvAlYryzOu+B5QcJkonHUowcek6rcVSVVmA5tkiGw==
X-Received: by 2002:a1c:244:: with SMTP id 65mr26751359wmc.42.1555409931475;
        Tue, 16 Apr 2019 03:18:51 -0700 (PDT)
Received: from lindisfarne.localdomain (host-92-22-21-176.as13285.net. [92.22.21.176])
        by smtp.gmail.com with ESMTPSA id t74sm3220118wmt.3.2019.04.16.03.18.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 03:18:51 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 2/2] fix cherry-pick/revert status after commit
Date:   Tue, 16 Apr 2019 11:18:42 +0100
Message-Id: <20190416101842.16556-3-phillip.wood123@gmail.com>
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

If the user commits a conflict resolution using `git commit` in the
middle of a sequence of cherry-picks/reverts then `git status` missed
the fact that a cherry-pick/revert is still in progress.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c            | 35 +++++++++++++++++++++++++++++++++++
 sequencer.h            |  2 ++
 t/t7512-status-help.sh | 36 ++++++++++++++++++++++++++++++++++++
 wt-status.c            | 39 ++++++++++++++++++++++++++++++++++-----
 4 files changed, 107 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 7c7b8a07c4..c6a9a35422 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2142,6 +2142,41 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
 	return !item->commit;
 }
 
+int sequencer_get_last_command(struct repository *r, enum replay_action *action)
+{
+	struct todo_item item;
+	char *eol;
+	const char *todo_file;
+	struct strbuf buf = STRBUF_INIT;
+	int ret = -1;
+
+	todo_file = git_path_todo_file();
+	if (strbuf_read_file(&buf, todo_file, 0) < 0) {
+		if (errno == ENOENT)
+			return -1;
+		else
+			return error_errno("unable to open '%s'", todo_file);
+	}
+	eol = strchrnul(buf.buf, '\n');
+	if (buf.buf != eol && eol[-1] == '\r')
+		eol--; /* strip Carriage Return */
+	if (parse_insn_line(r, &item, buf.buf, eol))
+		goto fail;
+	if (item.command == TODO_PICK)
+		*action = REPLAY_PICK;
+	else if (item.command == TODO_REVERT)
+		*action = REPLAY_REVERT;
+	else
+		goto fail;
+
+	ret = 0;
+
+ fail:
+	strbuf_release(&buf);
+
+	return ret;
+}
+
 static int parse_insn_buffer(struct repository *r, char *buf,
 			     struct todo_list *todo_list)
 {
diff --git a/sequencer.h b/sequencer.h
index 6c7cf8d72f..c4b79165d3 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -145,3 +145,5 @@ void parse_strategy_opts(struct replay_opts *opts, char *raw_opts);
 int write_basic_state(struct replay_opts *opts, const char *head_name,
 		      const char *onto, const char *orig_head);
 void sequencer_post_commit_cleanup(struct repository *r);
+int sequencer_get_last_command(struct repository* r,
+			       enum replay_action *action);
diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 458608cc1e..c1eb72555d 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -780,6 +780,24 @@ EOF
 	test_i18ncmp expected actual
 '
 
+test_expect_success 'status when cherry-picking after committing conflict resolution' '
+	git reset --hard cherry_branch &&
+	test_when_finished "git cherry-pick --abort" &&
+	test_must_fail git cherry-pick cherry_branch_second one_cherry &&
+	echo end >main.txt &&
+	git commit -a &&
+	cat >expected <<EOF &&
+On branch cherry_branch
+Cherry-pick currently in progress.
+  (run "git cherry-pick --continue" to continue)
+  (use "git cherry-pick --abort" to cancel the cherry-pick operation)
+
+nothing to commit (use -u to show untracked files)
+EOF
+	git status --untracked-files=no >actual &&
+	test_i18ncmp expected actual
+'
+
 test_expect_success 'status showing detached at and from a tag' '
 	test_commit atag tagging &&
 	git checkout atag &&
@@ -857,6 +875,24 @@ EOF
 	test_i18ncmp expected actual
 '
 
+test_expect_success 'status while reverting after committing conflict resolution' '
+	test_when_finished "git revert --abort" &&
+	git reset --hard new &&
+	test_must_fail git revert old new &&
+	echo reverted >to-revert.txt &&
+	git commit -a &&
+	cat >expected <<EOF &&
+On branch master
+Revert currently in progress.
+  (run "git revert --continue" to continue)
+  (use "git revert --abort" to cancel the revert operation)
+
+nothing to commit (use -u to show untracked files)
+EOF
+	git status --untracked-files=no >actual &&
+	test_i18ncmp expected actual
+'
+
 test_expect_success 'prepare for different number of commits rebased' '
 	git reset --hard master &&
 	git checkout -b several_commits &&
diff --git a/wt-status.c b/wt-status.c
index 1f564b12d2..1dbb4d949c 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -17,6 +17,7 @@
 #include "utf8.h"
 #include "worktree.h"
 #include "lockfile.h"
+#include "sequencer.h"
 
 static const char cut_line[] =
 "------------------------ >8 ------------------------\n";
@@ -1369,12 +1370,22 @@ static void show_rebase_in_progress(struct wt_status *s,
 static void show_cherry_pick_in_progress(struct wt_status *s,
 					 const char *color)
 {
-	status_printf_ln(s, color, _("You are currently cherry-picking commit %s."),
-			find_unique_abbrev(&s->state.cherry_pick_head_oid, DEFAULT_ABBREV));
+	if (is_null_oid(&s->state.cherry_pick_head_oid))
+		status_printf_ln(s, color,
+			_("Cherry-pick currently in progress."));
+	else
+		status_printf_ln(s, color,
+			_("You are currently cherry-picking commit %s."),
+			find_unique_abbrev(&s->state.cherry_pick_head_oid,
+					   DEFAULT_ABBREV));
+
 	if (s->hints) {
 		if (has_unmerged(s))
 			status_printf_ln(s, color,
 				_("  (fix conflicts and run \"git cherry-pick --continue\")"));
+		else if (is_null_oid(&s->state.cherry_pick_head_oid))
+			status_printf_ln(s, color,
+				_("  (run \"git cherry-pick --continue\" to continue)"));
 		else
 			status_printf_ln(s, color,
 				_("  (all conflicts fixed: run \"git cherry-pick --continue\")"));
@@ -1387,12 +1398,21 @@ static void show_cherry_pick_in_progress(struct wt_status *s,
 static void show_revert_in_progress(struct wt_status *s,
 				    const char *color)
 {
-	status_printf_ln(s, color, _("You are currently reverting commit %s."),
-			 find_unique_abbrev(&s->state.revert_head_oid, DEFAULT_ABBREV));
+	if (is_null_oid(&s->state.revert_head_oid))
+		status_printf_ln(s, color,
+			_("Revert currently in progress."));
+	else
+		status_printf_ln(s, color,
+			_("You are currently reverting commit %s."),
+			find_unique_abbrev(&s->state.revert_head_oid,
+					   DEFAULT_ABBREV));
 	if (s->hints) {
 		if (has_unmerged(s))
 			status_printf_ln(s, color,
 				_("  (fix conflicts and run \"git revert --continue\")"));
+		else if (is_null_oid(&s->state.revert_head_oid))
+			status_printf_ln(s, color,
+				_("  (run \"git revert --continue\" to continue)"));
 		else
 			status_printf_ln(s, color,
 				_("  (all conflicts fixed: run \"git revert --continue\")"));
@@ -1563,6 +1583,7 @@ void wt_status_get_state(struct repository *r,
 {
 	struct stat st;
 	struct object_id oid;
+	enum replay_action action;
 
 	if (!stat(git_path_merge_head(r), &st)) {
 		wt_status_check_rebase(NULL, state);
@@ -1580,7 +1601,15 @@ void wt_status_get_state(struct repository *r,
 		state->revert_in_progress = 1;
 		oidcpy(&state->revert_head_oid, &oid);
 	}
-
+	if (!sequencer_get_last_command(r, &action)) {
+		if (action == REPLAY_PICK) {
+			state->cherry_pick_in_progress = 1;
+			oidcpy(&state->cherry_pick_head_oid, &null_oid);
+		} else {
+			state->revert_in_progress = 1;
+			oidcpy(&state->revert_head_oid, &null_oid);
+		}
+	}
 	if (get_detached_from)
 		wt_status_get_detached_from(r, state);
 }
-- 
2.21.0

