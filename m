Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA8801F453
	for <e@80x24.org>; Tue, 29 Jan 2019 15:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbfA2PDL (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 10:03:11 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34495 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728463AbfA2PDJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 10:03:09 -0500
Received: by mail-wr1-f67.google.com with SMTP id f7so22525490wrp.1
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 07:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kDcLHKco57nr34a639P+RdSZcQGpCSVal/5bC84DNt4=;
        b=DIwz1ZWjEabaiNn6JyKKYwY1Wbe3Li9CWsFRxRFYEuMz7w5QliwXO+PRsNNmDQ/MJp
         MJ/XO5ZeP5Cf0gZEM9uFYct29G58tbvNBncGrC+dyXtdeTlIcGAnTeo0v8Q3u5Y9509v
         oBOUMuHh7auRheyM3SimPEZpoQo0DjJZiXUSfZjcJNPRzHkAi5kCbRy4I2mRw2OSDkhL
         sXckpsP6m09iwUqQbfFMBV7bUyCBbzybd4BNJaUWe/jbjw5kMtLjsUw9/cm/yMLLDr2N
         5xl9HiZISAlxRaqcz0nnBvVdHZlYrzzy+HJLSVg9C73r8rwsiOsp1VZg0OOJXf82ofwT
         1AbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kDcLHKco57nr34a639P+RdSZcQGpCSVal/5bC84DNt4=;
        b=e8D28sW8cDJi3LxsjfFhB1UrJpUjA5qfVgwbZyueuovuCV5nGafu5g9VsY7Ell+Jr/
         YFIBqVfH0DmHh7QRRLBy/aFztAT2HaAnAB7GfwF8sBNKYrP2pFcHeDax4WAjBbIzITaZ
         fjGHlIZ+Wf2Bk77R/jF5LjGZuuZf6AZ/4RzEaVV5C+FeC0H0jQY07a/31L6ZOFRlH0fk
         PvQaBjBDcV9bmc9r+FcilA+JpxIW6U6vidUPY5W1+OahWWrt5JtGTxDIW2JC6u8ATSkm
         5SsHJPSomummYfLA+Iize6nM7Rm/21KZDnCJaculI7kh0AIJ4176FDc5J4Xff8Y8ZH0C
         QQZw==
X-Gm-Message-State: AJcUukc8L7/UjbN8btJ6+YmSrN5UslcM1eKAaG1PrUKT2ja0W91c9az3
        TSwnvsIBfJIZdn9AmO/1hDGe1n7Z
X-Google-Smtp-Source: ALg8bN7AgDAet4s7l0ndns/yq3BmNxSbIajeYXJJ4R1UV7sm4ve8CPkVYBGEhNL0VyuHomezTndAcw==
X-Received: by 2002:adf:90e5:: with SMTP id i92mr25170332wri.210.1548774186368;
        Tue, 29 Jan 2019 07:03:06 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-47-104.w86-221.abo.wanadoo.fr. [86.221.54.104])
        by smtp.googlemail.com with ESMTPSA id 129sm4420851wmd.18.2019.01.29.07.03.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 07:03:05 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v6 06/16] sequencer: refactor check_todo_list() to work on a todo_list
Date:   Tue, 29 Jan 2019 16:01:49 +0100
Message-Id: <20190129150159.10588-7-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129150159.10588-1-alban.gruin@gmail.com>
References: <20190123205821.27459-1-alban.gruin@gmail.com>
 <20190129150159.10588-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This refactors check_todo_list() to work on a todo_list to avoid
redundant reads and writes to the disk.  The function is renamed
todo_list_check().  The parsing of the two todo lists is left to the
caller.

As rebase -p still need to check the todo list from the disk, a new
function is introduced, check_todo_list_from_file().  It reads the file
from the disk, parses it, pass the todo_list to todo_list_check(), and
writes it back to the disk.

As get_missing_commit_check_level() and the enum
missing_commit_check_level are no longer needed inside of sequencer.c,
they are moved to rebase-interactive.c, and made static again.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/rebase--interactive.c |   2 +-
 rebase-interactive.c          |  91 ++++++++++++++++++++++++-
 rebase-interactive.h          |   2 +
 sequencer.c                   | 121 +++++++---------------------------
 sequencer.h                   |   9 +--
 5 files changed, 117 insertions(+), 108 deletions(-)

diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index 0898eb4c59..df19ccaeb9 100644
--- a/builtin/rebase--interactive.c
+++ b/builtin/rebase--interactive.c
@@ -256,7 +256,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 		ret = transform_todo_file(the_repository, flags);
 		break;
 	case CHECK_TODO_LIST:
-		ret = check_todo_list(the_repository);
+		ret = check_todo_list_from_file(the_repository);
 		break;
 	case REARRANGE_SQUASH:
 		ret = rearrange_squash(the_repository);
diff --git a/rebase-interactive.c b/rebase-interactive.c
index 842fa07e7e..dfa6dd530f 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -1,8 +1,32 @@
 #include "cache.h"
 #include "commit.h"
-#include "rebase-interactive.h"
 #include "sequencer.h"
+#include "rebase-interactive.h"
 #include "strbuf.h"
+#include "commit-slab.h"
+#include "config.h"
+
+enum missing_commit_check_level {
+	MISSING_COMMIT_CHECK_IGNORE = 0,
+	MISSING_COMMIT_CHECK_WARN,
+	MISSING_COMMIT_CHECK_ERROR
+};
+
+static enum missing_commit_check_level get_missing_commit_check_level(void)
+{
+	const char *value;
+
+	if (git_config_get_value("rebase.missingcommitscheck", &value) ||
+			!strcasecmp("ignore", value))
+		return MISSING_COMMIT_CHECK_IGNORE;
+	if (!strcasecmp("warn", value))
+		return MISSING_COMMIT_CHECK_WARN;
+	if (!strcasecmp("error", value))
+		return MISSING_COMMIT_CHECK_ERROR;
+	warning(_("unrecognized setting %s for option "
+		  "rebase.missingCommitsCheck. Ignoring."), value);
+	return MISSING_COMMIT_CHECK_IGNORE;
+}
 
 void append_todo_help(unsigned edit_todo, unsigned keep_empty,
 		      struct strbuf *buf)
@@ -89,3 +113,68 @@ int edit_todo_list(struct repository *r, unsigned flags)
 
 	return 0;
 }
+
+define_commit_slab(commit_seen, unsigned char);
+/*
+ * Check if the user dropped some commits by mistake
+ * Behaviour determined by rebase.missingCommitsCheck.
+ * Check if there is an unrecognized command or a
+ * bad SHA-1 in a command.
+ */
+int todo_list_check(struct todo_list *old_todo, struct todo_list *new_todo)
+{
+	enum missing_commit_check_level check_level = get_missing_commit_check_level();
+	struct strbuf missing = STRBUF_INIT;
+	int res = 0, i;
+	struct commit_seen commit_seen;
+
+	init_commit_seen(&commit_seen);
+
+	if (check_level == MISSING_COMMIT_CHECK_IGNORE)
+		goto leave_check;
+
+	/* Mark the commits in git-rebase-todo as seen */
+	for (i = 0; i < new_todo->nr; i++) {
+		struct commit *commit = new_todo->items[i].commit;
+		if (commit)
+			*commit_seen_at(&commit_seen, commit) = 1;
+	}
+
+	/* Find commits in git-rebase-todo.backup yet unseen */
+	for (i = old_todo->nr - 1; i >= 0; i--) {
+		struct todo_item *item = old_todo->items + i;
+		struct commit *commit = item->commit;
+		if (commit && !*commit_seen_at(&commit_seen, commit)) {
+			strbuf_addf(&missing, " - %s %.*s\n",
+				    find_unique_abbrev(&commit->object.oid, DEFAULT_ABBREV),
+				    item->arg_len,
+				    todo_item_get_arg(old_todo, item));
+			*commit_seen_at(&commit_seen, commit) = 1;
+		}
+	}
+
+	/* Warn about missing commits */
+	if (!missing.len)
+		goto leave_check;
+
+	if (check_level == MISSING_COMMIT_CHECK_ERROR)
+		res = 1;
+
+	fprintf(stderr,
+		_("Warning: some commits may have been dropped accidentally.\n"
+		"Dropped commits (newer to older):\n"));
+
+	/* Make the list user-friendly and display */
+	fputs(missing.buf, stderr);
+	strbuf_release(&missing);
+
+	fprintf(stderr, _("To avoid this message, use \"drop\" to "
+		"explicitly remove a commit.\n\n"
+		"Use 'git config rebase.missingCommitsCheck' to change "
+		"the level of warnings.\n"
+		"The possible behaviours are: ignore, warn, error.\n\n"));
+
+leave_check:
+	clear_commit_seen(&commit_seen);
+	return res;
+}
diff --git a/rebase-interactive.h b/rebase-interactive.h
index 17b6c9f6d0..187b5032d6 100644
--- a/rebase-interactive.h
+++ b/rebase-interactive.h
@@ -3,9 +3,11 @@
 
 struct strbuf;
 struct repository;
+struct todo_list;
 
 void append_todo_help(unsigned edit_todo, unsigned keep_empty,
 		      struct strbuf *buf);
 int edit_todo_list(struct repository *r, unsigned flags);
+int todo_list_check(struct todo_list *old_todo, struct todo_list *new_todo);
 
 #endif
diff --git a/sequencer.c b/sequencer.c
index 87b43994ff..266f80d704 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4605,112 +4605,37 @@ int transform_todo_file(struct repository *r, unsigned flags)
 	return 0;
 }
 
-enum missing_commit_check_level get_missing_commit_check_level(void)
-{
-	const char *value;
-
-	if (git_config_get_value("rebase.missingcommitscheck", &value) ||
-			!strcasecmp("ignore", value))
-		return MISSING_COMMIT_CHECK_IGNORE;
-	if (!strcasecmp("warn", value))
-		return MISSING_COMMIT_CHECK_WARN;
-	if (!strcasecmp("error", value))
-		return MISSING_COMMIT_CHECK_ERROR;
-	warning(_("unrecognized setting %s for option "
-		  "rebase.missingCommitsCheck. Ignoring."), value);
-	return MISSING_COMMIT_CHECK_IGNORE;
-}
+static const char edit_todo_list_advice[] =
+N_("You can fix this with 'git rebase --edit-todo' "
+"and then run 'git rebase --continue'.\n"
+"Or you can abort the rebase with 'git rebase"
+" --abort'.\n");
 
-define_commit_slab(commit_seen, unsigned char);
-/*
- * Check if the user dropped some commits by mistake
- * Behaviour determined by rebase.missingCommitsCheck.
- * Check if there is an unrecognized command or a
- * bad SHA-1 in a command.
- */
-int check_todo_list(struct repository *r)
+int check_todo_list_from_file(struct repository *r)
 {
-	enum missing_commit_check_level check_level = get_missing_commit_check_level();
-	struct strbuf todo_file = STRBUF_INIT;
-	struct todo_list todo_list = TODO_LIST_INIT;
-	struct strbuf missing = STRBUF_INIT;
-	int advise_to_edit_todo = 0, res = 0, i;
-	struct commit_seen commit_seen;
-
-	init_commit_seen(&commit_seen);
+	struct todo_list old_todo = TODO_LIST_INIT, new_todo = TODO_LIST_INIT;
+	int res = 0;
 
-	strbuf_addstr(&todo_file, rebase_path_todo());
-	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file.buf) < 0) {
+	if (strbuf_read_file_or_whine(&new_todo.buf, rebase_path_todo()) < 0) {
 		res = -1;
-		goto leave_check;
-	}
-	advise_to_edit_todo = res =
-		todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list);
-
-	if (res || check_level == MISSING_COMMIT_CHECK_IGNORE)
-		goto leave_check;
-
-	/* Mark the commits in git-rebase-todo as seen */
-	for (i = 0; i < todo_list.nr; i++) {
-		struct commit *commit = todo_list.items[i].commit;
-		if (commit)
-			*commit_seen_at(&commit_seen, commit) = 1;
+		goto out;
 	}
 
-	todo_list_release(&todo_list);
-	strbuf_addstr(&todo_file, ".backup");
-	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file.buf) < 0) {
+	if (strbuf_read_file_or_whine(&old_todo.buf, rebase_path_todo_backup()) < 0) {
 		res = -1;
-		goto leave_check;
-	}
-	strbuf_release(&todo_file);
-	res = !!todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list);
-
-	/* Find commits in git-rebase-todo.backup yet unseen */
-	for (i = todo_list.nr - 1; i >= 0; i--) {
-		struct todo_item *item = todo_list.items + i;
-		struct commit *commit = item->commit;
-		if (commit && !*commit_seen_at(&commit_seen, commit)) {
-			strbuf_addf(&missing, " - %s %.*s\n",
-				    short_commit_name(commit),
-				    item->arg_len,
-				    todo_item_get_arg(&todo_list, item));
-			*commit_seen_at(&commit_seen, commit) = 1;
-		}
+		goto out;
 	}
 
-	/* Warn about missing commits */
-	if (!missing.len)
-		goto leave_check;
-
-	if (check_level == MISSING_COMMIT_CHECK_ERROR)
-		advise_to_edit_todo = res = 1;
-
-	fprintf(stderr,
-		_("Warning: some commits may have been dropped accidentally.\n"
-		"Dropped commits (newer to older):\n"));
-
-	/* Make the list user-friendly and display */
-	fputs(missing.buf, stderr);
-	strbuf_release(&missing);
-
-	fprintf(stderr, _("To avoid this message, use \"drop\" to "
-		"explicitly remove a commit.\n\n"
-		"Use 'git config rebase.missingCommitsCheck' to change "
-		"the level of warnings.\n"
-		"The possible behaviours are: ignore, warn, error.\n\n"));
-
-leave_check:
-	clear_commit_seen(&commit_seen);
-	strbuf_release(&todo_file);
-	todo_list_release(&todo_list);
-
-	if (advise_to_edit_todo)
-		fprintf(stderr,
-			_("You can fix this with 'git rebase --edit-todo' "
-			  "and then run 'git rebase --continue'.\n"
-			  "Or you can abort the rebase with 'git rebase"
-			  " --abort'.\n"));
+	res = todo_list_parse_insn_buffer(r, old_todo.buf.buf, &old_todo);
+	if (!res)
+		res = todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo);
+	if (!res)
+		res = todo_list_check(&old_todo, &new_todo);
+	if (res)
+		fprintf(stderr, _(edit_todo_list_advice));
+out:
+	todo_list_release(&old_todo);
+	todo_list_release(&new_todo);
 
 	return res;
 }
@@ -4888,7 +4813,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 
 	todo_list_release(&todo_list);
 
-	if (check_todo_list(r)) {
+	if (check_todo_list_from_file(r)) {
 		checkout_onto(opts, onto_name, onto, orig_head);
 		return -1;
 	}
diff --git a/sequencer.h b/sequencer.h
index dc3d8f76f7..1de97f188d 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -64,12 +64,6 @@ struct replay_opts {
 };
 #define REPLAY_OPTS_INIT { .action = -1, .current_fixups = STRBUF_INIT }
 
-enum missing_commit_check_level {
-	MISSING_COMMIT_CHECK_IGNORE = 0,
-	MISSING_COMMIT_CHECK_WARN,
-	MISSING_COMMIT_CHECK_ERROR
-};
-
 int write_message(const void *buf, size_t len, const char *filename,
 		  int append_eol);
 
@@ -154,8 +148,7 @@ int sequencer_make_script(struct repository *r, FILE *out, int argc,
 
 int sequencer_add_exec_commands(struct repository *r, const char *command);
 int transform_todo_file(struct repository *r, unsigned flags);
-enum missing_commit_check_level get_missing_commit_check_level(void);
-int check_todo_list(struct repository *r);
+int check_todo_list_from_file(struct repository *r);
 int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
 		    const char *onto, const char *orig_head, const char *cmd,
-- 
2.20.1

