Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A59C2D0DB
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 21:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27648207FD
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 21:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBvncY5n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgA1VRr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 16:17:47 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50460 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgA1VRq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 16:17:46 -0500
Received: by mail-wm1-f65.google.com with SMTP id a5so4087815wmb.0
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 13:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yRe9mOAOPQUwtbg9Iyn1V+YqSjBArrQ1rkFEUiWqJNg=;
        b=OBvncY5nxBGwwLwaS0VmOJjT1uHtjV6U8l0U0ZbjnEigFl75lY2wmjZRiIPVt+LASY
         eIMMErejds3AXbGCGBHo1fbIPa3B58Plm2NEAeXxv/RKT/8oQohvhHwhTz9MP/iBcFZs
         wHimDao6lNBuRK6zEhmeFkzWKS5oIAgk3hCw4yF/hOgdVKBVhzj1BGucygZ2oF+xsIrb
         zYjV5R67CdFqgOCQcMNnajDqS46hUsEW9RVZdQnEF1BMFZO2C0KqPPGMpWlX2PIXIsRj
         DPVYgV0wPGXntgXOOPq3On9sOnXLOAo2lFNIIltmmeFkO+iyhki+WVkwwpDsGYUnkvrL
         OmlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yRe9mOAOPQUwtbg9Iyn1V+YqSjBArrQ1rkFEUiWqJNg=;
        b=c4w13u6sbG+obS91N0aMteQwBJcqseKregU/JWbwmzcMBFrDi61PPzeCr9KSoc7Rw7
         R639O3EKRglbvjNwt7QW3UUb6ue8QYwEdx2MctJwTg197GHcgyOWE0El7hGx3hzJIsQN
         3tXUK2eZoqUI1SBdWWKi35Lm1fTGDXiwQAYPMLiGQeo2G8q/JkOSbPQyJwyzqnrpY6Fo
         SGiRV5yESexgSIzWH6f7UGBRwuO61HMB3N5x2EHclf1KMnLvjpnvSEyh+lUhe2PKIxTa
         Is1p0DbxyjvwDlWRvlna/3WbajKuG2gRB7vph0lzt6LArfTi0bypqEiul3BrbL8+mnrm
         ZTsA==
X-Gm-Message-State: APjAAAUrUAMFPXD1fo3XIBgrHfbKIV8a+cqdu+qopE53GGID9OX/iFSZ
        Rjb/jrSkdC75s81ianADi4vm0WOf
X-Google-Smtp-Source: APXvYqzMvxiiw3mcNYMiRPbKhrkau3xPidRUhbnI5PND7GQIllB5btfxZcojBHPlYEmTtr20lXmbMw==
X-Received: by 2002:a7b:c416:: with SMTP id k22mr7364790wmi.25.1580246263597;
        Tue, 28 Jan 2020 13:17:43 -0800 (PST)
Received: from localhost.localdomain (atoulouse-551-1-75-233.w92-146.abo.wanadoo.fr. [92.146.226.233])
        by smtp.googlemail.com with ESMTPSA id y6sm27056035wrl.17.2020.01.28.13.17.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jan 2020 13:17:43 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v6 2/2] rebase-interactive: warn if commit is dropped with `rebase --edit-todo'
Date:   Tue, 28 Jan 2020 22:12:46 +0100
Message-Id: <20200128211246.10855-3-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200128211246.10855-1-alban.gruin@gmail.com>
References: <20200125175436.29786-1-alban.gruin@gmail.com>
 <20200128211246.10855-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When set to "warn" or "error", `rebase.missingCommitsCheck' would make
`rebase -i' warn if the user removed commits from the todo list to
prevent mistakes.  Unfortunately, `rebase --edit-todo' and `rebase
--continue' don't take it into account.

This adds the ability for `rebase --edit-todo' and `rebase --continue'
to check if commits were dropped by the user.  As both edit_todo_list()
and complete_action() parse the todo list and check for dropped commits,
the code doing so in the latter is removed to reduce duplication.
`edit_todo_list_advice' is removed from sequencer.c as it is no longer
used there.

This changes when a backup of the todo list is made.  Until now, it was
saved only once, before the initial edit.  Now, it is also made if the
original todo list has no errors or no dropped commits.  Thus, the
backup should be error-free.  Without this, sequencer_continue()
(`rebase --continue') could only compare the current todo list against
the original, unedited list.  Before this change, this file was only
used by edit_todo_list() and `rebase -p' to create the backup before
the initial edit, and check_todo_list_from_file(), only used by
`rebase -p' to check for dropped commits after its own initial edit.

If the edited list has an error, a file, `dropped', is created to
report the issue.  Otherwise, it is deleted.  Usually, the edited list
is compared against the list before editing, but if this file exists,
it will be compared to the backup.  Also, if the file exists,
sequencer_continue() checks the list for dropped commits.  If the
check was performed every time, it would fail when resuming a rebase
after resolving a conflict, as the backup will contain commits that
were picked, but they will not be in the new list.  It's safe to
ignore this check if `dropped' does not exist, because that means that
no errors were found at the last edition, so any missing commits here
have already been picked.

Five tests are added to t3404.  The tests for
`rebase.missingCommitsCheck = warn' and `rebase.missingCommitsCheck =
error' have a similar structure.  First, we start a rebase with an
incorrect command on the first line.  Then, we edit the todo list,
removing the first and the last lines.  This demonstrates that
`--edit-todo' notices dropped commits, but not when the command is
incorrect.  Then, we restore the original todo list, and edit it to
remove the last line.  This demonstrates that if we add a commit after
the initial edit, then remove it, `--edit-todo' will notice that it
has been dropped.  Then, the actual rebase takes place.  In the third
test, it is also checked that `--continue' will refuse to resume the
rebase if commits were dropped.  The fourth test checks that no errors
are raised when resuming a rebase after resolving a conflict, the fifth
checks that no errors are raised when editing the todo list after
pausing the rebase.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---

Notes:
    I don't think the way I create `expect.3' files in "rebase --edit-todo
    respects rebase.missingCommitsCheck = warning" & "... = error" is the
    best practice.  Perhaps I should create a new file from scratch instead
    of calling `head' and `tail' successively?

 rebase-interactive.c          |  53 ++++++++++++---
 rebase-interactive.h          |   3 +
 sequencer.c                   |  22 +++----
 sequencer.h                   |   1 +
 t/t3404-rebase-interactive.sh | 121 ++++++++++++++++++++++++++++++++++
 5 files changed, 179 insertions(+), 21 deletions(-)

diff --git a/rebase-interactive.c b/rebase-interactive.c
index 45f29c28a8..ac001dea58 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -5,6 +5,7 @@
 #include "strbuf.h"
 #include "commit-slab.h"
 #include "config.h"
+#include "dir.h"
 
 static const char edit_todo_list_advice[] =
 N_("You can fix this with 'git rebase --edit-todo' "
@@ -97,21 +98,24 @@ int edit_todo_list(struct repository *r, struct todo_list *todo_list,
 		   struct todo_list *new_todo, const char *shortrevisions,
 		   const char *shortonto, unsigned flags)
 {
-	const char *todo_file = rebase_path_todo();
+	const char *todo_file = rebase_path_todo(),
+		*todo_backup = rebase_path_todo_backup();
 	unsigned initial = shortrevisions && shortonto;
+	int incorrect = 0;
 
 	/* If the user is editing the todo list, we first try to parse
 	 * it.  If there is an error, we do not return, because the user
 	 * might want to fix it in the first place. */
 	if (!initial)
-		todo_list_parse_insn_buffer(r, todo_list->buf.buf, todo_list);
+		incorrect = todo_list_parse_insn_buffer(r, todo_list->buf.buf, todo_list) |
+			file_exists(rebase_path_dropped());
 
 	if (todo_list_write_to_file(r, todo_list, todo_file, shortrevisions, shortonto,
 				    -1, flags | TODO_LIST_SHORTEN_IDS | TODO_LIST_APPEND_TODO_HELP))
 		return error_errno(_("could not write '%s'"), todo_file);
 
-	if (initial &&
-	    todo_list_write_to_file(r, todo_list, rebase_path_todo_backup(),
+	if (!incorrect &&
+	    todo_list_write_to_file(r, todo_list, todo_backup,
 				    shortrevisions, shortonto, -1,
 				    (flags | TODO_LIST_APPEND_TODO_HELP) & ~TODO_LIST_SHORTEN_IDS) < 0)
 		return error(_("could not write '%s'."), rebase_path_todo_backup());
@@ -123,10 +127,23 @@ int edit_todo_list(struct repository *r, struct todo_list *todo_list,
 	if (initial && new_todo->buf.len == 0)
 		return -3;
 
-	/* For the initial edit, the todo list gets parsed in
-	 * complete_action(). */
-	if (!initial)
-		return todo_list_parse_insn_buffer(r, new_todo->buf.buf, new_todo);
+	if (todo_list_parse_insn_buffer(r, new_todo->buf.buf, new_todo)) {
+		fprintf(stderr, _(edit_todo_list_advice));
+		return -4;
+	}
+
+	if (incorrect) {
+		if (todo_list_check_against_backup(r, new_todo)) {
+			write_file(rebase_path_dropped(), "");
+			return -4;
+		}
+
+		if (incorrect > 0)
+			unlink(rebase_path_dropped());
+	} else if (todo_list_check(todo_list, new_todo)) {
+		write_file(rebase_path_dropped(), "");
+		return -4;
+	}
 
 	return 0;
 }
@@ -191,11 +208,27 @@ int todo_list_check(struct todo_list *old_todo, struct todo_list *new_todo)
 		"the level of warnings.\n"
 		"The possible behaviours are: ignore, warn, error.\n\n"));
 
+	fprintf(stderr, _(edit_todo_list_advice));
+
 leave_check:
 	clear_commit_seen(&commit_seen);
 	return res;
 }
 
+int todo_list_check_against_backup(struct repository *r, struct todo_list *todo_list)
+{
+	struct todo_list backup = TODO_LIST_INIT;
+	int res = 0;
+
+	if (strbuf_read_file(&backup.buf, rebase_path_todo_backup(), 0) > 0) {
+		todo_list_parse_insn_buffer(r, backup.buf.buf, &backup);
+		res = todo_list_check(&backup, todo_list);
+	}
+
+	todo_list_release(&backup);
+	return res;
+}
+
 int check_todo_list_from_file(struct repository *r)
 {
 	struct todo_list old_todo = TODO_LIST_INIT, new_todo = TODO_LIST_INIT;
@@ -214,10 +247,10 @@ int check_todo_list_from_file(struct repository *r)
 	res = todo_list_parse_insn_buffer(r, old_todo.buf.buf, &old_todo);
 	if (!res)
 		res = todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo);
-	if (!res)
-		res = todo_list_check(&old_todo, &new_todo);
 	if (res)
 		fprintf(stderr, _(edit_todo_list_advice));
+	if (!res)
+		res = todo_list_check(&old_todo, &new_todo);
 out:
 	todo_list_release(&old_todo);
 	todo_list_release(&new_todo);
diff --git a/rebase-interactive.h b/rebase-interactive.h
index 5f41bf5a28..4af0c1fcc7 100644
--- a/rebase-interactive.h
+++ b/rebase-interactive.h
@@ -11,7 +11,10 @@ void append_todo_help(unsigned keep_empty, int command_count,
 int edit_todo_list(struct repository *r, struct todo_list *todo_list,
 		   struct todo_list *new_todo, const char *shortrevisions,
 		   const char *shortonto, unsigned flags);
+
 int todo_list_check(struct todo_list *old_todo, struct todo_list *new_todo);
+int todo_list_check_against_backup(struct repository *r,
+				   struct todo_list *todo_list);
 
 int check_todo_list_from_file(struct repository *r);
 
diff --git a/sequencer.c b/sequencer.c
index 9365fc3e5a..638098b936 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -57,6 +57,8 @@ static GIT_PATH_FUNC(rebase_path, "rebase-merge")
 GIT_PATH_FUNC(rebase_path_todo, "rebase-merge/git-rebase-todo")
 GIT_PATH_FUNC(rebase_path_todo_backup, "rebase-merge/git-rebase-todo.backup")
 
+GIT_PATH_FUNC(rebase_path_dropped, "rebase-merge/dropped")
+
 /*
  * The rebase command lines that have already been processed. A line
  * is moved here when it is first handled, before any associated user
@@ -4239,6 +4241,14 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
 	if (is_rebase_i(opts)) {
 		if ((res = read_populate_todo(r, &todo_list, opts)))
 			goto release_todo_list;
+
+		if (file_exists(rebase_path_dropped())) {
+			if ((res = todo_list_check_against_backup(r, &todo_list)))
+				goto release_todo_list;
+
+			unlink(rebase_path_dropped());
+		}
+
 		if (commit_staged_changes(r, opts, &todo_list)) {
 			res = -1;
 			goto release_todo_list;
@@ -4985,12 +4995,6 @@ int todo_list_write_to_file(struct repository *r, struct todo_list *todo_list,
 	return res;
 }
 
-static const char edit_todo_list_advice[] =
-N_("You can fix this with 'git rebase --edit-todo' "
-"and then run 'git rebase --continue'.\n"
-"Or you can abort the rebase with 'git rebase"
-" --abort'.\n");
-
 /* skip picking commits whose parents are unchanged */
 static int skip_unnecessary_picks(struct repository *r,
 				  struct todo_list *todo_list,
@@ -5088,11 +5092,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		todo_list_release(&new_todo);
 
 		return error(_("nothing to do"));
-	}
-
-	if (todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo) ||
-	    todo_list_check(todo_list, &new_todo)) {
-		fprintf(stderr, _(edit_todo_list_advice));
+	} else if (res == -4) {
 		checkout_onto(r, opts, onto_name, &onto->object.oid, orig_head);
 		todo_list_release(&new_todo);
 
diff --git a/sequencer.h b/sequencer.h
index 5d4df0807c..84dc4160d5 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -11,6 +11,7 @@ const char *git_path_commit_editmsg(void);
 const char *git_path_seq_dir(void);
 const char *rebase_path_todo(void);
 const char *rebase_path_todo_backup(void);
+const char *rebase_path_dropped(void);
 
 #define APPEND_SIGNOFF_DEDUP (1u << 0)
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index b90ea0fe44..d79a3ef505 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1463,6 +1463,127 @@ test_expect_success 'rebase -i respects rebase.missingCommitsCheck = error' '
 	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
 '
 
+test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = ignore' '
+	test_config rebase.missingCommitsCheck ignore &&
+	rebase_setup_and_clean missing-commit &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="break 1 2 3 4 5" git rebase -i --root &&
+		FAKE_LINES="1 2 3 4" git rebase --edit-todo &&
+		git rebase --continue 2>actual
+	) &&
+	test D = $(git cat-file commit HEAD | sed -ne \$p) &&
+	test_i18ngrep \
+		"Successfully rebased and updated refs/heads/missing-commit" \
+		actual
+'
+
+test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = warn' '
+	cat >expect <<-EOF &&
+	error: invalid line 1: badcmd $(git rev-list --pretty=oneline --abbrev-commit -1 master~4)
+	Warning: some commits may have been dropped accidentally.
+	Dropped commits (newer to older):
+	 - $(git rev-list --pretty=oneline --abbrev-commit -1 master)
+	 - $(git rev-list --pretty=oneline --abbrev-commit -1 master~4)
+	To avoid this message, use "drop" to explicitly remove a commit.
+	EOF
+	head -n4 expect >expect.2 &&
+	tail -n1 expect >>expect.2 &&
+	tail -n4 expect.2 >expect.3 &&
+	test_config rebase.missingCommitsCheck warn &&
+	rebase_setup_and_clean missing-commit &&
+	(
+		set_fake_editor &&
+		test_must_fail env FAKE_LINES="bad 1 2 3 4 5" \
+			git rebase -i --root &&
+		cp .git/rebase-merge/git-rebase-todo.backup orig &&
+		FAKE_LINES="2 3 4" git rebase --edit-todo 2>actual.2 &&
+		head -n6 actual.2 >actual &&
+		test_i18ncmp expect actual &&
+		cp orig .git/rebase-merge/git-rebase-todo &&
+		FAKE_LINES="1 2 3 4" git rebase --edit-todo 2>actual.2 &&
+		head -n4 actual.2 >actual &&
+		test_i18ncmp expect.3 actual &&
+		git rebase --continue 2>actual
+	) &&
+	test D = $(git cat-file commit HEAD | sed -ne \$p) &&
+	test_i18ngrep \
+		"Successfully rebased and updated refs/heads/missing-commit" \
+		actual
+'
+
+test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = error' '
+	cat >expect <<-EOF &&
+	error: invalid line 1: badcmd $(git rev-list --pretty=oneline --abbrev-commit -1 master~4)
+	Warning: some commits may have been dropped accidentally.
+	Dropped commits (newer to older):
+	 - $(git rev-list --pretty=oneline --abbrev-commit -1 master)
+	 - $(git rev-list --pretty=oneline --abbrev-commit -1 master~4)
+	To avoid this message, use "drop" to explicitly remove a commit.
+
+	Use '\''git config rebase.missingCommitsCheck'\'' to change the level of warnings.
+	The possible behaviours are: ignore, warn, error.
+
+	You can fix this with '\''git rebase --edit-todo'\'' and then run '\''git rebase --continue'\''.
+	Or you can abort the rebase with '\''git rebase --abort'\''.
+	EOF
+	tail -n11 expect >expect.2 &&
+	head -n3 expect.2 >expect.3 &&
+	tail -n7 expect.2 >>expect.3 &&
+	test_config rebase.missingCommitsCheck error &&
+	rebase_setup_and_clean missing-commit &&
+	(
+		set_fake_editor &&
+		test_must_fail env FAKE_LINES="bad 1 2 3 4 5" \
+			git rebase -i --root &&
+		cp .git/rebase-merge/git-rebase-todo.backup orig &&
+		test_must_fail env FAKE_LINES="2 3 4" \
+			git rebase --edit-todo 2>actual &&
+		test_i18ncmp expect actual &&
+		test_must_fail git rebase --continue 2>actual &&
+		test_i18ncmp expect.2 actual &&
+		test_must_fail git rebase --edit-todo &&
+		cp orig .git/rebase-merge/git-rebase-todo &&
+		test_must_fail env FAKE_LINES="1 2 3 4" \
+			git rebase --edit-todo 2>actual &&
+		test_i18ncmp expect.3 actual &&
+		test_must_fail git rebase --continue 2>actual &&
+		test_i18ncmp expect.3 actual &&
+		cp orig .git/rebase-merge/git-rebase-todo &&
+		FAKE_LINES="1 2 3 4 drop 5" git rebase --edit-todo &&
+		git rebase --continue 2>actual
+	) &&
+	test D = $(git cat-file commit HEAD | sed -ne \$p) &&
+	test_i18ngrep \
+		"Successfully rebased and updated refs/heads/missing-commit" \
+		actual
+'
+
+test_expect_success 'rebase.missingCommitsCheck = error after resolving conflicts' '
+	test_config rebase.missingCommitsCheck error &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="drop 1 break 2 3 4" git rebase -i A E
+	) &&
+	git rebase --edit-todo &&
+	test_must_fail git rebase --continue &&
+	echo x >file1 &&
+	git add file1 &&
+	git rebase --continue
+'
+
+test_expect_success 'rebase.missingCommitsCheck = error when editing for a second time' '
+	test_config rebase.missingCommitsCheck error &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="1 break 2 3" git rebase -i A D &&
+		cp .git/rebase-merge/git-rebase-todo todo &&
+		test_must_fail env FAKE_LINES=2 git rebase --edit-todo &&
+		GIT_SEQUENCE_EDITOR="cp todo" git rebase --edit-todo &&
+		git rebase --continue
+	)
+'
+
 test_expect_success 'respects rebase.abbreviateCommands with fixup, squash and exec' '
 	rebase_setup_and_clean abbrevcmd &&
 	test_commit "first" file1.txt "first line" first &&
-- 
2.24.1

