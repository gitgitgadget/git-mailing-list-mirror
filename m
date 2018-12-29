Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 762E01F405
	for <e@80x24.org>; Sat, 29 Dec 2018 16:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbeL2QFO (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Dec 2018 11:05:14 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33549 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbeL2QFM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Dec 2018 11:05:12 -0500
Received: by mail-ed1-f67.google.com with SMTP id p6so19727661eds.0
        for <git@vger.kernel.org>; Sat, 29 Dec 2018 08:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=suIfa9FPqfyvIYQKFWniYiwpr75WhP9Gvrw3BoV4WJo=;
        b=dl6nHbsVdGtZEAUEupxHvNSPV4i44r3/a8idpn7pFxyP9DSk8aNyUn1WbK1mBmKycJ
         g/nWCkJbIcNLrlW80d+q8h3HjSVy7x/ES3YXnen7WBFQOTGI8tFxXDcrue+877LdqRaM
         fOhc22ECuEArPkKYIE1EI8PTRjU5OGq1aUU4mZqJm7neHjTUeWzqzaNsWqwKgNgdS4C6
         +0LaQw2MWFgtm16T1BhFB6UcPsS9NkIW2jucJNg/LPmZ8j2mj0x9l22/C7mp964xjuXE
         KZtGCjO3U9L+WUSqUMK2X6u02qo3qQgENglKlD5JCJ7sQxAo8SfeifhdrgmS7gZrJvgY
         s/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=suIfa9FPqfyvIYQKFWniYiwpr75WhP9Gvrw3BoV4WJo=;
        b=uL798NvFvPpeKq3QREHVpBG5pOSLi+EhW0yp5ELnb96CCHrzD4yYMCRNcpQXi21SNh
         8pCfLZzVAaCyqrJKzt5z8jn+ka1rdDXKgZteyyWhhljHWQedSGHW5sYmsaN7dnM9WDbg
         tw3VhI9pyLR9Wp7lfYCN4yty6geAAhaVuFqi2bnRRqtlm58u0zSB5vRTdAfyayC6HODm
         JaFsYs32lIe9En6SI5B5t+D8fnz9Qcez8LmSnqXv2b5axDiySQgLImftPZKSxiSEVYhL
         2RID4RL4W6Gi5hcc1nRKjphYf2TRke4xTUfahbs/T0nBMN1lwI4rRFp74i90VPE8Gsed
         c65w==
X-Gm-Message-State: AA+aEWZFBZ/0dJpqZdGW98M9zF5Op0zAMLWSbOjJ3ZY+v5tNZ+O7WA/G
        BtHg8iOKFeNlniD9cRyG+HtzDTIL
X-Google-Smtp-Source: AFSGD/XJEEKqeFTLl8JbiT9mKgLjaXWp3gy8azZVP4xgEGiHug5saMMqTnURACNQ+ttouF2wiB5O0g==
X-Received: by 2002:a05:6402:14cd:: with SMTP id f13mr26596072edx.224.1546099509272;
        Sat, 29 Dec 2018 08:05:09 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-184-107.w86-199.abo.wanadoo.fr. [86.199.39.107])
        by smtp.googlemail.com with ESMTPSA id b49sm15108663edb.73.2018.12.29.08.05.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Dec 2018 08:05:08 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v4 06/16] sequencer: refactor check_todo_list() to work on a todo_list
Date:   Sat, 29 Dec 2018 17:04:03 +0100
Message-Id: <20181229160413.19333-7-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181229160413.19333-1-alban.gruin@gmail.com>
References: <20181109080805.6350-1-alban.gruin@gmail.com>
 <20181229160413.19333-1-alban.gruin@gmail.com>
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
 rebase-interactive.h          |   1 +
 sequencer.c                   | 121 +++++++---------------------------
 sequencer.h                   |   9 +--
 5 files changed, 116 insertions(+), 108 deletions(-)

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
index 842fa07e7e..6157247e1f 100644
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
+				    old_todo->buf.buf + item->arg_offset);
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
index 17b6c9f6d0..dd0d717bc1 100644
--- a/rebase-interactive.h
+++ b/rebase-interactive.h
@@ -7,5 +7,6 @@ struct repository;
 void append_todo_help(unsigned edit_todo, unsigned keep_empty,
 		      struct strbuf *buf);
 int edit_todo_list(struct repository *r, unsigned flags);
+int todo_list_check(struct todo_list *old_todo, struct todo_list *new_todo);
 
 #endif
diff --git a/sequencer.c b/sequencer.c
index b932ca34f2..347a1a701f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4599,112 +4599,37 @@ int transform_todo_file(struct repository *r, unsigned flags)
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
-				    todo_list.buf.buf + item->arg_offset);
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
@@ -4882,7 +4807,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 
 	todo_list_release(&todo_list);
 
-	if (check_todo_list(r)) {
+	if (check_todo_list_from_file(r)) {
 		checkout_onto(opts, onto_name, onto, orig_head);
 		return -1;
 	}
diff --git a/sequencer.h b/sequencer.h
index 4643fb3b69..07a8418b0d 100644
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
 
@@ -152,8 +146,7 @@ int sequencer_make_script(struct repository *r, FILE *out, int argc,
 
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

