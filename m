Return-Path: <SRS0=5D3W=ZY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD41C432C0
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 23:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A43220663
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 23:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/xE9Ns5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfLBXsh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Dec 2019 18:48:37 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39572 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfLBXsg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Dec 2019 18:48:36 -0500
Received: by mail-wm1-f68.google.com with SMTP id s14so1474303wmh.4
        for <git@vger.kernel.org>; Mon, 02 Dec 2019 15:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b8sZv/l8O1AER37wlz1/9yLwrZX4g6qzZq6VBYldD3I=;
        b=f/xE9Ns5iX6BCl/X9SMRko99VFpbJgOooxgtWD1eut7FjfOEWoQAmvFIvRYqAe4cDI
         JtX2gmrny/XS+iPSmHOy7ahSV+mMgR3Ia4VMfSpRYbpWOgTV4Zk3jeVFIZFsIbrz4Svm
         t83vl0z6y6HeyZutC0kFY0epdu7fI/Rkdyq4uPm9DrsZM7cUjeUt+BQMXAVscD8sPleK
         33Z17eDTEu938v5OQGnYJ3EMh5621M5J8mJZ/LZTPQZAeRiS/OK+aAQ770CkDcws20r+
         nQ1vyVMbkpacxCWhNledTUxpldv3Rc0onQsjIger0njLiQJcs9wtwF3Zb5J5jxWT2c6E
         h5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b8sZv/l8O1AER37wlz1/9yLwrZX4g6qzZq6VBYldD3I=;
        b=IpaScshsbelJEfuznEveP1N3UKmXgwOZhzCpA0ntnw2Bc8NmaWSsjDVvNu37Df4oja
         GZSYGYdiIX/lUmh3wnPq1ZLNuVVIW/eaeiOCJHWTuHLYpJ9GfvJtiNWr3n1FuuhHuvMf
         nh9/MVDAEMCHP7QBC4+2AtWkxEmcTukjAQuPwPrrP39cQC8EyDf0lbDVhAaWqJzQukv0
         cfNmjyJufWJnmf7b2eBFfTGHzCjsYSbrsmKufieft42/er3TpKgSUXivs5Lqyv7moHjB
         g/foxMJ26L5yhOYYUSwSOcfrsY2Rl5TGW0ggCsyJbVVw2z6rw/sZCFZUn0QTvMKu64OW
         7FCw==
X-Gm-Message-State: APjAAAVQhHaJrVbzirwhNARSRhTTIGJs6fv1uSx8KZwZLyAJx8BVLGH+
        trFHrndvPHCMnAqrQEXUGDjZWkXO
X-Google-Smtp-Source: APXvYqxgR7p56cqh/k6Svt9CqwZRA2/F4fBIpRB1rbQsn4DWhsHHXiP1eHpYQ6wW7MXOLOAm9ogckg==
X-Received: by 2002:a05:600c:2549:: with SMTP id e9mr10444072wma.160.1575330512764;
        Mon, 02 Dec 2019 15:48:32 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-25-142.w86-222.abo.wanadoo.fr. [86.222.24.142])
        by smtp.googlemail.com with ESMTPSA id e16sm1148360wrj.80.2019.12.02.15.48.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Dec 2019 15:48:32 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v3 2/2] rebase-interactive: warn if commit is dropped with `rebase --edit-todo'
Date:   Tue,  3 Dec 2019 00:47:59 +0100
Message-Id: <20191202234759.26201-3-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191202234759.26201-1-alban.gruin@gmail.com>
References: <20191104095449.9964-1-alban.gruin@gmail.com>
 <20191202234759.26201-1-alban.gruin@gmail.com>
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
saved only before the initial edit.  Now, it is always performed before
the todo list is edited.  Without this, sequencer_continue() (`rebase
--continue') could only compare the current todo list against the
original, unedited list.  Before this change, this file was only used by
edit_todo_list() and `rebase -p' to create the backup before the initial
edit, and check_todo_list_from_file(), only used by `rebase -p' to check
for dropped commits after its own initial edit.

Three tests are added to t3404.  The tests for
`rebase.missingCommitsCheck = warn' and `rebase.missingCommitsCheck =
error' have a similar structure.  First, we start a rebase with an
incorrect command on the first line.  Then, we edit the todo list,
removing the first and the last lines.  This demonstrates that
`--edit-todo' notices dropped commits, but not when the command is
incorrect.  Then, we restore the original todo list, and edit it to
remove the last line.  This demonstrates that if we add a commit after
the initial edit, then remove it, `--edit-todo' will notice that it has
been dropped.  Then, the actual rebase takes place.  In the third test,
it is also checked that `--continue' will refuse to resume the rebase if
commits were dropped.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 rebase-interactive.c          | 22 ++++++----
 sequencer.c                   | 24 +++++-----
 t/t3404-rebase-interactive.sh | 83 +++++++++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+), 19 deletions(-)

diff --git a/rebase-interactive.c b/rebase-interactive.c
index ad5dd49c31..80b6a2e7a6 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -97,7 +97,8 @@ int edit_todo_list(struct repository *r, struct todo_list *todo_list,
 		   struct todo_list *new_todo, const char *shortrevisions,
 		   const char *shortonto, unsigned flags)
 {
-	const char *todo_file = rebase_path_todo();
+	const char *todo_file = rebase_path_todo(),
+		*todo_backup = rebase_path_todo_backup();
 	unsigned initial = shortrevisions && shortonto;
 
 	/* If the user is editing the todo list, we first try to parse
@@ -110,9 +111,9 @@ int edit_todo_list(struct repository *r, struct todo_list *todo_list,
 				    -1, flags | TODO_LIST_SHORTEN_IDS | TODO_LIST_APPEND_TODO_HELP))
 		return error_errno(_("could not write '%s'"), todo_file);
 
-	if (initial && copy_file(rebase_path_todo_backup(), todo_file, 0666))
-		return error(_("could not copy '%s' to '%s'."), todo_file,
-			     rebase_path_todo_backup());
+	unlink(todo_backup);
+	if (copy_file(todo_backup, todo_file, 0666))
+		return error(_("could not copy '%s' to '%s'."), todo_file, todo_backup);
 
 	if (launch_sequence_editor(todo_file, &new_todo->buf, NULL))
 		return -2;
@@ -121,10 +122,13 @@ int edit_todo_list(struct repository *r, struct todo_list *todo_list,
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
+	if (todo_list_check(todo_list, new_todo))
+		return -4;
 
 	return 0;
 }
@@ -189,6 +193,8 @@ int todo_list_check(struct todo_list *old_todo, struct todo_list *new_todo)
 		"the level of warnings.\n"
 		"The possible behaviours are: ignore, warn, error.\n\n"));
 
+	fprintf(stderr, _(edit_todo_list_advice));
+
 leave_check:
 	clear_commit_seen(&commit_seen);
 	return res;
diff --git a/sequencer.c b/sequencer.c
index 181bb35f5f..75d5ad0496 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4271,8 +4271,20 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
 	if (read_populate_opts(opts))
 		return -1;
 	if (is_rebase_i(opts)) {
+		struct todo_list backup = TODO_LIST_INIT;
+
 		if ((res = read_populate_todo(r, &todo_list, opts)))
 			goto release_todo_list;
+
+		if (strbuf_read_file(&backup.buf, rebase_path_todo_backup(), 0) > 0) {
+			todo_list_parse_insn_buffer(r, backup.buf.buf, &backup);
+			res = todo_list_check(&backup, &todo_list);
+			todo_list_release(&backup);
+
+			if (res)
+				goto release_todo_list;
+		}
+
 		if (commit_staged_changes(r, opts, &todo_list))
 			return -1;
 	} else if (!file_exists(get_todo_path(opts)))
@@ -4986,12 +4998,6 @@ int todo_list_write_to_file(struct repository *r, struct todo_list *todo_list,
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
@@ -5089,11 +5095,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
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
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 29a35840ed..9051c1e11d 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1343,6 +1343,89 @@ test_expect_success 'rebase -i respects rebase.missingCommitsCheck = error' '
 	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
 '
 
+test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = ignore' '
+	test_config rebase.missingCommitsCheck ignore &&
+	rebase_setup_and_clean missing-commit &&
+	set_fake_editor &&
+	FAKE_LINES="break 1 2 3 4 5" git rebase -i --root &&
+	FAKE_LINES="1 2 3 4" git rebase --edit-todo 2>actual &&
+	git rebase --continue 2>actual &&
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
+	To avoid this message, use "drop" to explicitly remove a commit.
+	EOF
+	tail -n4 expect >expect.2 &&
+	test_config rebase.missingCommitsCheck warn &&
+	rebase_setup_and_clean missing-commit &&
+	set_fake_editor &&
+	test_must_fail env FAKE_LINES="bad 1 2 3 4 5" \
+		git rebase -i --root &&
+	cp .git/rebase-merge/git-rebase-todo.backup orig &&
+	FAKE_LINES="2 3 4" git rebase --edit-todo 2>actual.2 &&
+	head -n5 actual.2 >actual &&
+	test_i18ncmp expect actual &&
+	cp orig .git/rebase-merge/git-rebase-todo &&
+	FAKE_LINES="1 2 3 4" git rebase --edit-todo 2>actual.2 &&
+	head -n4 actual.2 >actual &&
+	test_i18ncmp expect.2 actual &&
+	git rebase --continue 2>actual &&
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
+	To avoid this message, use "drop" to explicitly remove a commit.
+
+	Use '\''git config rebase.missingCommitsCheck'\'' to change the level of warnings.
+	The possible behaviours are: ignore, warn, error.
+
+	You can fix this with '\''git rebase --edit-todo'\'' and then run '\''git rebase --continue'\''.
+	Or you can abort the rebase with '\''git rebase --abort'\''.
+	EOF
+	tail -n10 expect >expect.2 &&
+	test_config rebase.missingCommitsCheck error &&
+	rebase_setup_and_clean missing-commit &&
+	set_fake_editor &&
+	test_must_fail env FAKE_LINES="bad 1 2 3 4 5" \
+		git rebase -i --root &&
+	cp .git/rebase-merge/git-rebase-todo.backup orig &&
+	test_must_fail env FAKE_LINES="2 3 4" \
+		git rebase --edit-todo 2>actual &&
+	test_i18ncmp expect actual &&
+	test_must_fail git rebase --continue 2>actual &&
+	test_i18ncmp expect actual &&
+	cp orig .git/rebase-merge/git-rebase-todo &&
+	test_must_fail env FAKE_LINES="1 2 3 4" \
+		git rebase --edit-todo 2>actual &&
+	test_i18ncmp expect.2 actual &&
+	test_must_fail git rebase --continue 2>actual &&
+	test_i18ncmp expect.2 actual &&
+	cp orig .git/rebase-merge/git-rebase-todo &&
+	FAKE_LINES="1 2 3 4 drop 5" git rebase --edit-todo &&
+	git rebase --continue 2>actual &&
+	test D = $(git cat-file commit HEAD | sed -ne \$p) &&
+	test_i18ngrep \
+		"Successfully rebased and updated refs/heads/missing-commit" \
+		actual
+'
+
 test_expect_success 'respects rebase.abbreviateCommands with fixup, squash and exec' '
 	rebase_setup_and_clean abbrevcmd &&
 	test_commit "first" file1.txt "first line" first &&
-- 
2.24.0

