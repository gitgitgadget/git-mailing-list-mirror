Return-Path: <SRS0=5D3W=ZY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3992C432C0
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 23:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EB7120640
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 23:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEP3NqGg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfLBXsd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Dec 2019 18:48:33 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38140 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfLBXsd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Dec 2019 18:48:33 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so1433272wrh.5
        for <git@vger.kernel.org>; Mon, 02 Dec 2019 15:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fmm53L9uw3mt57dUlRLmuVM4LNvnuw2cbqRh9p0L8MU=;
        b=AEP3NqGgrFIQKQYjtm4aQrEbtTLc687f8OQNeoUtojXF/ozRk8/IhzTRysMHKrEp9S
         MMGNPg3rjTNjsPaZI8SeBCNQet3b4yRJllZOxOj6ktJG1uh/exySahGkwBjDrOGblOBH
         ksZZhGO88iRs4g4xJLERnbOztbxGoQ4+tbzXbG/I4cLQcNJx1Yrs+ZcbuV4d8T02qDtc
         gx4MfPKmx9qVfSz8/aSrjI33gQyUqHZHKTHrmOcXiQf6LQ0xqDtLQhZrXGsT1djyOWQ7
         +xXjvs0lVFv+h0+Jj3bQRWj3auUOCt9GAVnZH7Rz4tm2qHDq9GarqK4XP3uSag1ViTzg
         OLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fmm53L9uw3mt57dUlRLmuVM4LNvnuw2cbqRh9p0L8MU=;
        b=XyYhlumHQJFSP442qoDdsd3QLnx/uZFXoWZtFolmN6dwKSKPx9mWq2efDyO3qnuZ70
         RXRGI53p2fcPrv6Sajne0QT5JbHcEGw90raiwDdP/lQafbTIeBTRYrdHQeMCbiq3hcKL
         r3Kr3NTWacsihJqpDHuOOGZohuW+NNXZ97Ie9q/B5HFzQkLVRZkcH1GAjwizpvfyavpr
         Ee/psdYnWTplNtiX9fuDMNRwiddf1ws1LUGTJZiUKTE5ItwMfwU70yIz4lOcuCJmq5Vv
         e4hJP0yhR16UoXveRhBby6ILEomBa5s8PWLVK4vs8e/xB7JGoAkCUbe0IfJhrExdWvrg
         5tPg==
X-Gm-Message-State: APjAAAXcfDAPWverl/qgNwcY8NIdRbBmg1IeBtTVLEeEo7xeemyo9B0A
        SxadbSl46AOO0XgU2M5XyqimtU1Q
X-Google-Smtp-Source: APXvYqwHNsCXWkX4dOh23MLDVZ937Met6cbjfjuWzG6txgBXefefnYYu8nL/geZoptgp6gMnkqdrVA==
X-Received: by 2002:a5d:404b:: with SMTP id w11mr1808979wrp.171.1575330509011;
        Mon, 02 Dec 2019 15:48:29 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-25-142.w86-222.abo.wanadoo.fr. [86.222.24.142])
        by smtp.googlemail.com with ESMTPSA id e16sm1148360wrj.80.2019.12.02.15.48.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Dec 2019 15:48:28 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v3 0/2] rebase -i: extend rebase.missingCommitsCheck
Date:   Tue,  3 Dec 2019 00:47:57 +0100
Message-Id: <20191202234759.26201-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191104095449.9964-1-alban.gruin@gmail.com>
References: <20191104095449.9964-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To prevent mistakes when editing a branch, rebase features a knob,
rebase.missingCommitsCheck, to warn the user if a commit was dropped.
Unfortunately, this check is only effective for the initial edit, which
means that if you edit the todo list at a later point of the rebase and
drop a commit, no warnings or errors would be issued.

This adds the ability to check if commits were dropped when editing the
todo list with `--edit-todo', and when resuming a rebase.

The first patch moves moves check_todo_list_from_file() and
`edit_todo_list_advice' from sequencer.c to rebase-interactive.c so the
latter can be used by edit_todo_list() and todo_list_check().  The
second patch adds the check to `--edit-todo' and `--continue' and tests.

This is based on 393adf7a6f ("sequencer: directly call pick_commits()
from complete_action()", 2019-11-24).

The tip of this series is tagged as "edit-todo-drop-v3" at
https://github.com/agrn/git.

Changes since v2:
 - Merged patches 1 and 2.
 - Reinstated support for `git rebase --continue'.
 - Print `edit_todo_list_advice' if a dropped commit was detected by
   `--edit-todo' or `--continue'.

Alban Gruin (2):
  sequencer: move check_todo_list_from_file() to rebase-interactive.c
  rebase-interactive: warn if commit is dropped with `rebase
    --edit-todo'

 rebase-interactive.c          | 57 ++++++++++++++++++++----
 rebase-interactive.h          |  2 +
 sequencer.c                   | 53 ++++++----------------
 sequencer.h                   |  1 -
 t/t3404-rebase-interactive.sh | 83 +++++++++++++++++++++++++++++++++++
 5 files changed, 147 insertions(+), 49 deletions(-)

Diff-intervalle contre v2:
-:  ---------- > 1:  996045a300 sequencer: move check_todo_list_from_file() to rebase-interactive.c
1:  6974b6c8f2 ! 2:  ba6d27e5b4 t3404: demonstrate that --edit-todo does not check for dropped commits
    @@ Metadata
     Author: Alban Gruin <alban.gruin@gmail.com>
     
      ## Commit message ##
    -    t3404: demonstrate that --edit-todo does not check for dropped commits
    +    rebase-interactive: warn if commit is dropped with `rebase --edit-todo'
     
    -    When set to "warn" or "error", `rebase.missingCommitCheck' would make
    -    rebase -i warn if the user removed commits from the todo list to prevent
    -    mistakes.  Unfortunately, rebase --edit-todo don't take it into account.
    +    When set to "warn" or "error", `rebase.missingCommitsCheck' would make
    +    `rebase -i' warn if the user removed commits from the todo list to
    +    prevent mistakes.  Unfortunately, `rebase --edit-todo' and `rebase
    +    --continue' don't take it into account.
     
    -    This adds three tests to t3404 to demonstrate this.  The first one is
    -    not broken, as when `rebase.missingCommitsCheck' is not set, nothing in
    -    particular must be done towards dropped commits.  The two others are
    -    broken, demonstrating the problem.
    +    This adds the ability for `rebase --edit-todo' and `rebase --continue'
    +    to check if commits were dropped by the user.  As both edit_todo_list()
    +    and complete_action() parse the todo list and check for dropped commits,
    +    the code doing so in the latter is removed to reduce duplication.
    +    `edit_todo_list_advice' is removed from sequencer.c as it is no longer
    +    used there.
     
    -    The tests for `rebase.missingCommitsCheck = warn' and
    -    `rebase.missingCommitsCheck = error' have a similar structure.  First,
    -    we start a rebase with an incorrect command on the first line.  Then, we
    -    edit the todo list, removing the first and the last lines.  This
    -    demonstrates that `--edit-todo' notices dropped commits, but not when
    -    the command is incorrect.  Then, we restore the original todo list, and
    -    edit it to remove the last line.  This demonstrates that if we add a
    -    commit after the initial edit, then remove it, `--edit-todo' will notice
    -    that it has been dropped.  Then, the actual rebase takes place.
    +    This changes when a backup of the todo list is made.  Until now, it was
    +    saved only before the initial edit.  Now, it is always performed before
    +    the todo list is edited.  Without this, sequencer_continue() (`rebase
    +    --continue') could only compare the current todo list against the
    +    original, unedited list.  Before this change, this file was only used by
    +    edit_todo_list() and `rebase -p' to create the backup before the initial
    +    edit, and check_todo_list_from_file(), only used by `rebase -p' to check
    +    for dropped commits after its own initial edit.
    +
    +    Three tests are added to t3404.  The tests for
    +    `rebase.missingCommitsCheck = warn' and `rebase.missingCommitsCheck =
    +    error' have a similar structure.  First, we start a rebase with an
    +    incorrect command on the first line.  Then, we edit the todo list,
    +    removing the first and the last lines.  This demonstrates that
    +    `--edit-todo' notices dropped commits, but not when the command is
    +    incorrect.  Then, we restore the original todo list, and edit it to
    +    remove the last line.  This demonstrates that if we add a commit after
    +    the initial edit, then remove it, `--edit-todo' will notice that it has
    +    been dropped.  Then, the actual rebase takes place.  In the third test,
    +    it is also checked that `--continue' will refuse to resume the rebase if
    +    commits were dropped.
     
         Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
     
    + ## rebase-interactive.c ##
    +@@ rebase-interactive.c: int edit_todo_list(struct repository *r, struct todo_list *todo_list,
    + 		   struct todo_list *new_todo, const char *shortrevisions,
    + 		   const char *shortonto, unsigned flags)
    + {
    +-	const char *todo_file = rebase_path_todo();
    ++	const char *todo_file = rebase_path_todo(),
    ++		*todo_backup = rebase_path_todo_backup();
    + 	unsigned initial = shortrevisions && shortonto;
    + 
    + 	/* If the user is editing the todo list, we first try to parse
    +@@ rebase-interactive.c: int edit_todo_list(struct repository *r, struct todo_list *todo_list,
    + 				    -1, flags | TODO_LIST_SHORTEN_IDS | TODO_LIST_APPEND_TODO_HELP))
    + 		return error_errno(_("could not write '%s'"), todo_file);
    + 
    +-	if (initial && copy_file(rebase_path_todo_backup(), todo_file, 0666))
    +-		return error(_("could not copy '%s' to '%s'."), todo_file,
    +-			     rebase_path_todo_backup());
    ++	unlink(todo_backup);
    ++	if (copy_file(todo_backup, todo_file, 0666))
    ++		return error(_("could not copy '%s' to '%s'."), todo_file, todo_backup);
    + 
    + 	if (launch_sequence_editor(todo_file, &new_todo->buf, NULL))
    + 		return -2;
    +@@ rebase-interactive.c: int edit_todo_list(struct repository *r, struct todo_list *todo_list,
    + 	if (initial && new_todo->buf.len == 0)
    + 		return -3;
    + 
    +-	/* For the initial edit, the todo list gets parsed in
    +-	 * complete_action(). */
    +-	if (!initial)
    +-		return todo_list_parse_insn_buffer(r, new_todo->buf.buf, new_todo);
    ++	if (todo_list_parse_insn_buffer(r, new_todo->buf.buf, new_todo)) {
    ++		fprintf(stderr, _(edit_todo_list_advice));
    ++		return -4;
    ++	}
    ++
    ++	if (todo_list_check(todo_list, new_todo))
    ++		return -4;
    + 
    + 	return 0;
    + }
    +@@ rebase-interactive.c: int todo_list_check(struct todo_list *old_todo, struct todo_list *new_todo)
    + 		"the level of warnings.\n"
    + 		"The possible behaviours are: ignore, warn, error.\n\n"));
    + 
    ++	fprintf(stderr, _(edit_todo_list_advice));
    ++
    + leave_check:
    + 	clear_commit_seen(&commit_seen);
    + 	return res;
    +
    + ## sequencer.c ##
    +@@ sequencer.c: int sequencer_continue(struct repository *r, struct replay_opts *opts)
    + 	if (read_populate_opts(opts))
    + 		return -1;
    + 	if (is_rebase_i(opts)) {
    ++		struct todo_list backup = TODO_LIST_INIT;
    ++
    + 		if ((res = read_populate_todo(r, &todo_list, opts)))
    + 			goto release_todo_list;
    ++
    ++		if (strbuf_read_file(&backup.buf, rebase_path_todo_backup(), 0) > 0) {
    ++			todo_list_parse_insn_buffer(r, backup.buf.buf, &backup);
    ++			res = todo_list_check(&backup, &todo_list);
    ++			todo_list_release(&backup);
    ++
    ++			if (res)
    ++				goto release_todo_list;
    ++		}
    ++
    + 		if (commit_staged_changes(r, opts, &todo_list))
    + 			return -1;
    + 	} else if (!file_exists(get_todo_path(opts)))
    +@@ sequencer.c: int todo_list_write_to_file(struct repository *r, struct todo_list *todo_list,
    + 	return res;
    + }
    + 
    +-static const char edit_todo_list_advice[] =
    +-N_("You can fix this with 'git rebase --edit-todo' "
    +-"and then run 'git rebase --continue'.\n"
    +-"Or you can abort the rebase with 'git rebase"
    +-" --abort'.\n");
    +-
    + /* skip picking commits whose parents are unchanged */
    + static int skip_unnecessary_picks(struct repository *r,
    + 				  struct todo_list *todo_list,
    +@@ sequencer.c: int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
    + 		todo_list_release(&new_todo);
    + 
    + 		return error(_("nothing to do"));
    +-	}
    +-
    +-	if (todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo) ||
    +-	    todo_list_check(todo_list, &new_todo)) {
    +-		fprintf(stderr, _(edit_todo_list_advice));
    ++	} else if (res == -4) {
    + 		checkout_onto(r, opts, onto_name, &onto->object.oid, orig_head);
    + 		todo_list_release(&new_todo);
    + 
    +
      ## t/t3404-rebase-interactive.sh ##
     @@ t/t3404-rebase-interactive.sh: test_expect_success 'rebase -i respects rebase.missingCommitsCheck = error' '
      	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
    @@ t/t3404-rebase-interactive.sh: test_expect_success 'rebase -i respects rebase.mi
     +		actual
     +'
     +
    -+test_expect_failure 'rebase --edit-todo respects rebase.missingCommitsCheck = warn' '
    ++test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = warn' '
     +	cat >expect <<-EOF &&
     +	error: invalid line 1: badcmd $(git rev-list --pretty=oneline --abbrev-commit -1 master~4)
     +	Warning: some commits may have been dropped accidentally.
    @@ t/t3404-rebase-interactive.sh: test_expect_success 'rebase -i respects rebase.mi
     +		actual
     +'
     +
    -+test_expect_failure 'rebase --edit-todo respects rebase.missingCommitsCheck = error' '
    ++test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = error' '
     +	cat >expect <<-EOF &&
     +	error: invalid line 1: badcmd $(git rev-list --pretty=oneline --abbrev-commit -1 master~4)
     +	Warning: some commits may have been dropped accidentally.
     +	Dropped commits (newer to older):
     +	 - $(git rev-list --pretty=oneline --abbrev-commit -1 master)
     +	To avoid this message, use "drop" to explicitly remove a commit.
    ++
    ++	Use '\''git config rebase.missingCommitsCheck'\'' to change the level of warnings.
    ++	The possible behaviours are: ignore, warn, error.
    ++
    ++	You can fix this with '\''git rebase --edit-todo'\'' and then run '\''git rebase --continue'\''.
    ++	Or you can abort the rebase with '\''git rebase --abort'\''.
     +	EOF
    -+	tail -n4 expect >expect.2 &&
    ++	tail -n10 expect >expect.2 &&
     +	test_config rebase.missingCommitsCheck error &&
     +	rebase_setup_and_clean missing-commit &&
     +	set_fake_editor &&
    @@ t/t3404-rebase-interactive.sh: test_expect_success 'rebase -i respects rebase.mi
     +		git rebase -i --root &&
     +	cp .git/rebase-merge/git-rebase-todo.backup orig &&
     +	test_must_fail env FAKE_LINES="2 3 4" \
    -+		git rebase --edit-todo 2>actual.2 &&
    -+	head -n5 actual.2 >actual &&
    ++		git rebase --edit-todo 2>actual &&
    ++	test_i18ncmp expect actual &&
    ++	test_must_fail git rebase --continue 2>actual &&
     +	test_i18ncmp expect actual &&
     +	cp orig .git/rebase-merge/git-rebase-todo &&
     +	test_must_fail env FAKE_LINES="1 2 3 4" \
    -+		git rebase --edit-todo 2>actual.2 &&
    -+	head -n4 actual.2 >actual &&
    ++		git rebase --edit-todo 2>actual &&
    ++	test_i18ncmp expect.2 actual &&
    ++	test_must_fail git rebase --continue 2>actual &&
     +	test_i18ncmp expect.2 actual &&
     +	cp orig .git/rebase-merge/git-rebase-todo &&
     +	FAKE_LINES="1 2 3 4 drop 5" git rebase --edit-todo &&
2:  a4a700ce8b < -:  ---------- rebase-interactive: warn if commit is dropped with --edit-todo
-- 
2.24.0

