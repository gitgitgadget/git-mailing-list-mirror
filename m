Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CF8F1F97E
	for <e@80x24.org>; Sun,  7 Oct 2018 20:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbeJHDIg (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Oct 2018 23:08:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40847 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeJHDIf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Oct 2018 23:08:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id d2-v6so14124551wro.7
        for <git@vger.kernel.org>; Sun, 07 Oct 2018 13:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B6XZDcYGXwLLw3RNVaebrTL5STZRjY5PFBNzt7FntZs=;
        b=ih5QoRq00GvZ71lzZjMz0NxD63VCB3hRVbsqeB5M0y+Yi+CfdS7WAIzmYLSIBESWdX
         k1kECIm3qKb/Dt9zQ5b7tQONS7NObkhoNBm4BM0iCLeErtH4AfSEhhsyqAreWx49i6k8
         JPoUbiDU8xCK09fERqS35P/uNOPZ8WSqlgSQ5UYaenfrqbHn9A0GstZIlviNJvM5jv6h
         rOqF+YXbvSig5NdZIISKkV8J+ieyUNyzucLqJ2mpOgkVP8kjg7ZLa1Yduct3njXqVvZY
         x1cqylludPXYdrz6q71Reyg5o7rwRzMoXZEdryTXYfDByNEN35Vno5tXAicx9hQcJytt
         lvSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B6XZDcYGXwLLw3RNVaebrTL5STZRjY5PFBNzt7FntZs=;
        b=OCOgIn1Mmvke0fsP478lBzrJROtdS024e5pI5OzSSuqewen1jDuGyFvhnZXeRcJ3eC
         Mug6owojlp2lirRyuquPkeOsD/5YqwXedW9jAW2zfQGMX8Yrg71HB8cJr8zBGq9YUptt
         9OZDXtu290EUB0Rmo6LO4fdaLpXjADrtvGeEj7R8qIPTiIqkKuWpKBKVI4BKJEo7sqJX
         aDuOjKnhnzyRWkcRkBDnGeH+lbZEj2jebh/sYdD7/Jyi9ta5ctgKzh9SlcJ2VkJcZwc8
         dyrwFKZG9BUCeY8ckQocztJvWeAz/GiMIfG8Ku+sWUSlpdXQunTJJbmodFkTat14kxSQ
         TDEA==
X-Gm-Message-State: ABuFfoiqpDWa9glW0UB6lCsi3Kbt0XGmcfOpYtF+qmCN0V5HAomAnxeb
        BM7qEdbkA44nF2mc7K8e1a1TAjL4
X-Google-Smtp-Source: ACcGV60120lC2sGETsWwJZl+ekttRD/1hEEDYSGyHOCEwumQN1c+FaswMB9jgHlnL3xyp20LzRConw==
X-Received: by 2002:adf:db8e:: with SMTP id u14-v6mr14721998wri.217.1538942410620;
        Sun, 07 Oct 2018 13:00:10 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-60-162.w92-136.abo.wanadoo.fr. [92.136.157.162])
        by smtp.googlemail.com with ESMTPSA id u76-v6sm17082538wmd.10.2018.10.07.13.00.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 13:00:10 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH 03/15] sequencer: refactor check_todo_list() to work on a todo_list
Date:   Sun,  7 Oct 2018 21:54:06 +0200
Message-Id: <20181007195418.25752-4-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181007195418.25752-1-alban.gruin@gmail.com>
References: <20181007195418.25752-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This refactors check_todo_list() to work on a todo_list to avoid
redundant reads and writes to the disk.  The function is renamed
todo_list_check().

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
 rebase-interactive.c          | 106 ++++++++++++++++++++++++++++++++-
 rebase-interactive.h          |   1 +
 sequencer.c                   | 109 ++++------------------------------
 sequencer.h                   |   9 +--
 5 files changed, 120 insertions(+), 107 deletions(-)

diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index a2ab68ed06..ea1f93ccb6 100644
--- a/builtin/rebase--interactive.c
+++ b/builtin/rebase--interactive.c
@@ -255,7 +255,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 		ret = transform_todos(flags);
 		break;
 	case CHECK_TODO_LIST:
-		ret = check_todo_list();
+		ret = check_todo_list_from_file();
 		break;
 	case REARRANGE_SQUASH:
 		ret = rearrange_squash();
diff --git a/rebase-interactive.c b/rebase-interactive.c
index 0f4119cbae..ef8540245d 100644
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
@@ -88,3 +112,83 @@ int edit_todo_list(unsigned flags)
 
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
+	int advise_to_edit_todo = 0, res = 0, i;
+	struct commit_seen commit_seen;
+
+	init_commit_seen(&commit_seen);
+
+	res = todo_list_parse_insn_buffer(old_todo->buf.buf, old_todo);
+	if (!res)
+		res = todo_list_parse_insn_buffer(new_todo->buf.buf, new_todo);
+	if (res) {
+		advise_to_edit_todo = res;
+		goto leave_check;
+	}
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
+				    item->arg_len, item->arg);
+			*commit_seen_at(&commit_seen, commit) = 1;
+		}
+	}
+
+	/* Warn about missing commits */
+	if (!missing.len)
+		goto leave_check;
+
+	if (check_level == MISSING_COMMIT_CHECK_ERROR)
+		advise_to_edit_todo = res = 1;
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
+
+	if (advise_to_edit_todo)
+		fprintf(stderr,
+			_("You can fix this with 'git rebase --edit-todo' "
+			  "and then run 'git rebase --continue'.\n"
+			  "Or you can abort the rebase with 'git rebase"
+			  " --abort'.\n"));
+
+	return res;
+}
diff --git a/rebase-interactive.h b/rebase-interactive.h
index 971da03776..6bc7bc315d 100644
--- a/rebase-interactive.h
+++ b/rebase-interactive.h
@@ -4,5 +4,6 @@
 void append_todo_help(unsigned edit_todo, unsigned keep_empty,
 		      struct strbuf *buf);
 int edit_todo_list(unsigned flags);
+int todo_list_check(struct todo_list *old_todo, struct todo_list *new_todo);
 
 #endif
diff --git a/sequencer.c b/sequencer.c
index bb8ca2477f..8dda61927c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4487,111 +4487,26 @@ int transform_todos(unsigned flags)
 	return i;
 }
 
-enum missing_commit_check_level get_missing_commit_check_level(void)
+int check_todo_list_from_file(void)
 {
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
-
-define_commit_slab(commit_seen, unsigned char);
-/*
- * Check if the user dropped some commits by mistake
- * Behaviour determined by rebase.missingCommitsCheck.
- * Check if there is an unrecognized command or a
- * bad SHA-1 in a command.
- */
-int check_todo_list(void)
-{
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
-		todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list);
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
-	res = !!todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list);
-
-	/* Find commits in git-rebase-todo.backup yet unseen */
-	for (i = todo_list.nr - 1; i >= 0; i--) {
-		struct todo_item *item = todo_list.items + i;
-		struct commit *commit = item->commit;
-		if (commit && !*commit_seen_at(&commit_seen, commit)) {
-			strbuf_addf(&missing, " - %s %.*s\n",
-				    short_commit_name(commit),
-				    item->arg_len, item->arg);
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
+	res = todo_list_check(&old_todo, &new_todo);
 
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
+out:
+	todo_list_release(&old_todo);
+	todo_list_release(&new_todo);
 
 	return res;
 }
@@ -4769,7 +4684,7 @@ int complete_action(struct replay_opts *opts, unsigned flags,
 
 	todo_list_release(&todo_list);
 
-	if (check_todo_list()) {
+	if (check_todo_list_from_file()) {
 		checkout_onto(opts, onto_name, onto, orig_head);
 		return -1;
 	}
diff --git a/sequencer.h b/sequencer.h
index c786dee543..fb8b85bf9e 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -63,12 +63,6 @@ struct replay_opts {
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
 
@@ -142,8 +136,7 @@ int sequencer_make_script(FILE *out, int argc, const char **argv,
 
 int sequencer_add_exec_commands(const char *command);
 int transform_todos(unsigned flags);
-enum missing_commit_check_level get_missing_commit_check_level(void);
-int check_todo_list(void);
+int check_todo_list_from_file(void);
 int complete_action(struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
 		    const char *onto, const char *orig_head, const char *cmd,
-- 
2.19.1

