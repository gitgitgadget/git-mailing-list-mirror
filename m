Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E8E51F461
	for <e@80x24.org>; Wed, 17 Jul 2019 14:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbfGQOmH (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jul 2019 10:42:07 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36738 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbfGQOmH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jul 2019 10:42:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id g67so18339991wme.1
        for <git@vger.kernel.org>; Wed, 17 Jul 2019 07:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bxNVyN9DKf2MUp+4R28QEcsjpDTJskvcn4VRx/f/bsY=;
        b=OcLyHt0cTMI61qpyGnPq/MwNycd5p14PU7YT0nkB7EcjlsedNHL/U1lI9FbWjK6lRF
         K89EagfONcj8yiTN+zh0hQaKogmLHvNPIN/AM9AlQg2raUw9SesB0anGJdQ4YiSjWbld
         YU/jignTJ8uc5zSZNe0GLPhcKcfDGnb4GIMpt7/AttvTZ1xm+A8Wo9nlkHUboOrfoxnp
         Z51F8mq0LWcZmgzZ099fY9q/wDwfT+qQKoPCkF251RzelPvxFbNYdrgn8xx6BJ2ozgkp
         Sh4D8RQ9gVw0UF0XX2X+53I4xumwI2A0zQlICUc2pMW/n/v67pvcMIPsn+wi0ss+yYxY
         qn/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bxNVyN9DKf2MUp+4R28QEcsjpDTJskvcn4VRx/f/bsY=;
        b=ZyJt76JBOEmbt/YfKeBndrC6H5u6iwQZderdboZg7JUVwQYS/mv4nKmEEUOJN6kE+N
         E5VSsglpAynuzBuo/CdG85ZgXOvPooyIgUFxqc70FD1xfnd7OTWr5alBZ55KfIQwTcDy
         UoU8wlKP6anC2mtBBtvFIos7Sh3gbIOEfsY64iU3qbNWM6kuAfPfiYHweBuVGwX5qp50
         V+/nrRkGYNMAq9/XfOTQN/NM4BMcZjjGY4GYiR0Whd+eqHtN/WmYiXzowNYuSVtQJ1rY
         5NVFIGBz2ktBq1tI5yXcjVaaz7S+sbwapAAlX+VB25RElpPd2wFJMKV24EVihDaqyWpo
         rnDQ==
X-Gm-Message-State: APjAAAW2y97082i8B0XhqUfMM7j2LJgvpvCl5+EaIQQmWZK8IP8WkO0c
        VDoFSFcNUYafrrM9z7JUmwxXN5zZ
X-Google-Smtp-Source: APXvYqx1N7SRWHMC8hJlNRPFtmZLo/tfcLHm9hTqCv2eD8erp5ZBULRDgo5GfB7Sv4UayIQ30FE9Kg==
X-Received: by 2002:a05:600c:212:: with SMTP id 18mr5703860wmi.88.1563374524151;
        Wed, 17 Jul 2019 07:42:04 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-658-1-183-65.w86-199.abo.wanadoo.fr. [86.199.38.65])
        by smtp.googlemail.com with ESMTPSA id p18sm21815968wrm.16.2019.07.17.07.42.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 07:42:03 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [RFC PATCH 7/9] rebase-interactive: todo_list_check() also uses the done list
Date:   Wed, 17 Jul 2019 16:39:16 +0200
Message-Id: <20190717143918.7406-8-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190717143918.7406-1-alban.gruin@gmail.com>
References: <20190717143918.7406-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

todo_list_check() works by checking if every commit in old_todo (the
backup list) is also present in new_todo (the todo list to check).

This works only when no commits have been picked (ie. right after the
initial edit).  In other cases, the backup list will contain one or
several commits that have been applied and are no longer in the todo
list.  Let's take this todo list, for instance:

	pick 123abc An interesting change
	break
	pick cba321 A boring change

After executing the `break' command, the backup list will contain the
original todo list, while the todo list will only contain the last
`pick' insn.  Even if commit 123abc has been picked up, in this case,
todo_list_check() will fail because it is not part of the todo list.

There is another list containing every command that have been executed:
the "done" list.  In our example, after the `break' command, the "done"
list will contain the first commit (123abc).  Comparing the backup list
against the todo list and the done list will fix this problem.

This changes todo_list_check() to compare old_todo against new_todo
_and_ the done list.  This should be useful to check the todo list when
resuming a rebase or reloading the todo list after an `exec' command,
but not for `--edit-todo' (the todo list is copied before edition).
But, for the sake of safety, it is still done in the next commit.

This also adds a function, todo_list_check_against_backup(), to load the
done list and the backup list, and call todo_list_check().

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 rebase-interactive.c | 57 ++++++++++++++++++++++++++++++++++++++------
 rebase-interactive.h |  6 ++++-
 sequencer.c          |  4 ++--
 3 files changed, 57 insertions(+), 10 deletions(-)

diff --git a/rebase-interactive.c b/rebase-interactive.c
index aa18ae82b7..c7dea85553 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -6,6 +6,8 @@
 #include "commit-slab.h"
 #include "config.h"
 
+static GIT_PATH_FUNC(rebase_path_done, "rebase-merge/done")
+
 enum missing_commit_check_level {
 	MISSING_COMMIT_CHECK_IGNORE = 0,
 	MISSING_COMMIT_CHECK_WARN,
@@ -124,13 +126,27 @@ int edit_todo_list(struct repository *r, struct todo_list *todo_list,
 }
 
 define_commit_slab(commit_seen, unsigned char);
+
+static void mark_commits_as_seen(struct commit_seen *commit_seen,
+				 struct todo_list *list)
+{
+	int i;
+
+	for (i = 0; i < list->nr; i++) {
+		struct commit *commit = list->items[i].commit;
+		if (commit)
+			*commit_seen_at(commit_seen, commit) = 1;
+	}
+}
+
 /*
  * Check if the user dropped some commits by mistake
  * Behaviour determined by rebase.missingCommitsCheck.
  * Check if there is an unrecognized command or a
  * bad SHA-1 in a command.
  */
-int todo_list_check(struct todo_list *old_todo, struct todo_list *new_todo)
+int todo_list_check(struct todo_list *old_todo, struct todo_list *new_todo,
+		    struct todo_list *done)
 {
 	enum missing_commit_check_level check_level = get_missing_commit_check_level();
 	struct strbuf missing = STRBUF_INIT;
@@ -142,12 +158,11 @@ int todo_list_check(struct todo_list *old_todo, struct todo_list *new_todo)
 	if (check_level == MISSING_COMMIT_CHECK_IGNORE)
 		goto leave_check;
 
-	/* Mark the commits in git-rebase-todo as seen */
-	for (i = 0; i < new_todo->nr; i++) {
-		struct commit *commit = new_todo->items[i].commit;
-		if (commit)
-			*commit_seen_at(&commit_seen, commit) = 1;
-	}
+	/* Mark the commits in git-rebase-todo and git-rebase-done as
+	   seen */
+	mark_commits_as_seen(&commit_seen, new_todo);
+	if (done)
+		mark_commits_as_seen(&commit_seen, done);
 
 	/* Find commits in git-rebase-todo.backup yet unseen */
 	for (i = old_todo->nr - 1; i >= 0; i--) {
@@ -187,3 +202,31 @@ int todo_list_check(struct todo_list *old_todo, struct todo_list *new_todo)
 	clear_commit_seen(&commit_seen);
 	return res;
 }
+
+int todo_list_check_against_backup(struct repository *r,
+				   struct todo_list *todo_list)
+{
+	struct todo_list done = TODO_LIST_INIT, initial = TODO_LIST_INIT;
+	int res;
+
+	if (strbuf_read_file(&done.buf, rebase_path_done(), 0) < 0 && errno != ENOENT)
+		return error(_("could not read '%s'"), rebase_path_done());
+
+	strbuf_read_file(&done.buf, rebase_path_done(), 0);
+	todo_list_parse_insn_buffer(r, done.buf.buf, &done);
+
+	if (strbuf_read_file(&initial.buf, rebase_path_todo_backup(), 0) < 0 &&
+	    errno != ENOENT) {
+		todo_list_release(&done);
+		return error(_("could not read '%s'"), rebase_path_done());
+	}
+
+	todo_list_parse_insn_buffer(r, initial.buf.buf, &initial);
+
+	res = todo_list_check(&initial, todo_list, &done);
+
+	todo_list_release(&done);
+	todo_list_release(&initial);
+
+	return res;
+}
diff --git a/rebase-interactive.h b/rebase-interactive.h
index 44dbb06311..ac401cda25 100644
--- a/rebase-interactive.h
+++ b/rebase-interactive.h
@@ -11,6 +11,10 @@ void append_todo_help(unsigned keep_empty, int command_count,
 int edit_todo_list(struct repository *r, struct todo_list *todo_list,
 		   struct todo_list *new_todo, const char *shortrevisions,
 		   const char *shortonto, unsigned flags);
-int todo_list_check(struct todo_list *old_todo, struct todo_list *new_todo);
+
+int todo_list_check(struct todo_list *old_todo, struct todo_list *new_todo,
+		    struct todo_list *done);
+int todo_list_check_against_backup(struct repository *r,
+				   struct todo_list *todo_list);
 
 #endif
diff --git a/sequencer.c b/sequencer.c
index 3fb15ff8d9..0638c92f12 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4898,7 +4898,7 @@ int check_todo_list_from_file(struct repository *r)
 	if (!res)
 		res = todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo);
 	if (!res)
-		res = todo_list_check(&old_todo, &new_todo);
+		res = todo_list_check(&old_todo, &new_todo, NULL);
 	if (res)
 		fprintf(stderr, _(edit_todo_list_advice));
 out:
@@ -5008,7 +5008,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 	}
 
 	if (todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo) ||
-	    todo_list_check(todo_list, &new_todo)) {
+	    todo_list_check(todo_list, &new_todo, NULL)) {
 		fprintf(stderr, _(edit_todo_list_advice));
 		checkout_onto(r, opts, onto_name, &onto->object.oid, orig_head);
 		todo_list_release(&new_todo);
-- 
2.22.0

