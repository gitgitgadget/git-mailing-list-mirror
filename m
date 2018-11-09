Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51A5B1F453
	for <e@80x24.org>; Fri,  9 Nov 2018 08:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbeKIRsE (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 12:48:04 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39399 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728222AbeKIRsE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 12:48:04 -0500
Received: by mail-wr1-f65.google.com with SMTP id b13so853767wrx.6
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 00:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u3VYcESaxXgHqrsaUyBUzqqRB3MjMQeJV2FA45RMPgQ=;
        b=k8ut6kLUXT40LhZxsyqLG5zBOx2dKfLZyP5e2yvs6x5JielpdXJrwHCd4dU3pFKGCD
         DTlVPH2r1KpV+sGYoDkP99dHMLm2/GJ06J5+h7FhPwRDGCFuykdt/Bqg84RC0Gl0qphw
         yPGb902FBNuAg5yczB7s35F5/EO8TmJETqJt6D+ZSZTdjKzB32tf4loQ/PQTvVIKTF4k
         ErzoGq7fvxXfIQVjyi4BcnIgkNgmExon6vhqGynQJV9CiPP/Et7A0EhrW2007KwIiwSQ
         N0NJT/+q0Xk7ROUVtV1enGhjyTFALZ/cG5i8fWtozboVSfahVxomPFjaEJySD9/kJILR
         NZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u3VYcESaxXgHqrsaUyBUzqqRB3MjMQeJV2FA45RMPgQ=;
        b=WFdvik3N/WnrvRetR8RVtt+llFxcKRSkiQ8pXnt0gaE3WhX4rkbQJkgBaVa4QDHT8W
         n68aJOWoLymaAVSVxSWchy2o4NbeeSItEXEwaK7FZLxQwcdUQw2NGhAkEU2VEnKFS7ry
         P0muh/3uMvFTnV+l7QTZc4/rFU2CkYfSYJZnlwICtUipCqh6DBPOyHfYuO1ud7RXouob
         HVKZnWpG1zq/5DxuYr1JILo1YlyvDHBX/+ayPv+fTTTd8bB40qCq/wBsXv/JQipo7qEG
         kVnT/rTa+3MaKe41kIKNVtE4FeR+C1PCWRopkjgNrY0l/j8T95bUKHtllO5VT3V/fHs3
         MhAA==
X-Gm-Message-State: AGRZ1gK8beiupvnqo1UMbGMefwA9TrBYOv75R6+q+gjvgbOyu/QQOoYb
        0UwY2PCW6p6WDjTUVV5J4n1ANDDO
X-Google-Smtp-Source: AJdET5d82sGB7+R+zIb+eGh3mtAuVkK3P1xG4QsKuDHv+B0W19nWDD1KSa4sUEdNq/FceTktZ8br0w==
X-Received: by 2002:adf:ded1:: with SMTP id i17-v6mr7104621wrn.307.1541750916433;
        Fri, 09 Nov 2018 00:08:36 -0800 (PST)
Received: from andromeda.lan (atoulouse-658-1-60-221.w92-136.abo.wanadoo.fr. [92.136.157.221])
        by smtp.googlemail.com with ESMTPSA id x194-v6sm3003973wmd.41.2018.11.09.00.08.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 00:08:35 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v3 05/16] sequencer: refactor check_todo_list() to work on a todo_list
Date:   Fri,  9 Nov 2018 09:07:54 +0100
Message-Id: <20181109080805.6350-6-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181109080805.6350-1-alban.gruin@gmail.com>
References: <20181027212930.9303-1-alban.gruin@gmail.com>
 <20181109080805.6350-1-alban.gruin@gmail.com>
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
No changes since v2.

 builtin/rebase--interactive.c |   2 +-
 rebase-interactive.c          |  90 ++++++++++++++++++++++++-
 rebase-interactive.h          |   1 +
 sequencer.c                   | 120 +++++++---------------------------
 sequencer.h                   |   9 +--
 5 files changed, 115 insertions(+), 107 deletions(-)

diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index abdf6126df..c1d87c0fe6 100644
--- a/builtin/rebase--interactive.c
+++ b/builtin/rebase--interactive.c
@@ -255,7 +255,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 		ret = transform_todo_file(flags);
 		break;
 	case CHECK_TODO_LIST:
-		ret = check_todo_list();
+		ret = check_todo_list_from_file();
 		break;
 	case REARRANGE_SQUASH:
 		ret = rearrange_squash();
diff --git a/rebase-interactive.c b/rebase-interactive.c
index 4cd487a450..3adcf39e07 100644
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
@@ -89,3 +113,67 @@ int edit_todo_list(unsigned flags)
 
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
index 19f24825d4..900899ef20 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4547,111 +4547,37 @@ int transform_todo_file(unsigned flags)
 	return res;
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
-int check_todo_list(void)
+int check_todo_list_from_file(void)
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
+	res = todo_list_parse_insn_buffer(old_todo.buf.buf, &old_todo);
+	if (!res)
+		res = todo_list_parse_insn_buffer(new_todo.buf.buf, &new_todo);
+	if (!res)
+		res = todo_list_check(&old_todo, &new_todo);
+	if (res)
+		fprintf(stderr, _(edit_todo_list_advice));
+out:
+	todo_list_release(&old_todo);
+	todo_list_release(&new_todo);
 
 	return res;
 }
@@ -4829,7 +4755,7 @@ int complete_action(struct replay_opts *opts, unsigned flags,
 
 	todo_list_release(&todo_list);
 
-	if (check_todo_list()) {
+	if (check_todo_list_from_file()) {
 		checkout_onto(opts, onto_name, onto, orig_head);
 		return -1;
 	}
diff --git a/sequencer.h b/sequencer.h
index e69357c95b..c78f00aadd 100644
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
 
@@ -148,8 +142,7 @@ int sequencer_make_script(FILE *out, int argc, const char **argv,
 
 int sequencer_add_exec_commands(const char *command);
 int transform_todo_file(unsigned flags);
-enum missing_commit_check_level get_missing_commit_check_level(void);
-int check_todo_list(void);
+int check_todo_list_from_file(void);
 int complete_action(struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
 		    const char *onto, const char *orig_head, const char *cmd,
-- 
2.19.1.872.ga867da739e

