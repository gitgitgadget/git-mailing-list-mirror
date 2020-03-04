Return-Path: <SRS0=VPsx=4V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2968CC3F2D1
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 11:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A902166E
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 11:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSJQQw3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387860AbgCDLeN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Mar 2020 06:34:13 -0500
Received: from mail-pf1-f174.google.com ([209.85.210.174]:34527 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387799AbgCDLeL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Mar 2020 06:34:11 -0500
Received: by mail-pf1-f174.google.com with SMTP id y21so846456pfp.1
        for <git@vger.kernel.org>; Wed, 04 Mar 2020 03:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+pGsHVHvzZ4Xzsp15UJfcJV/KQQThRfqCP1bSx5XGk4=;
        b=HSJQQw3DkhNl/wllrUihawz/CVmWdK8raARoMgo7JgckYRmtyvBq78n5DvIoggrhjm
         J3qrpz10PsncW3DbvcV+OHN1mmfBlT5O20p1ESSyN08ZVfrahFpISrc5GU8RUJccFv8g
         O2x9B2i15rldDga9UPYMbN3eH6SQ7ZEythJcMFRzUl3GAN8GGzacVOMuBEeCypvi2vka
         FbhZ4FlxOQ1/nSOE+UuUbnjtoI+1XQebcyGoA71IiWtvxL3ZK3tgvhUE6Qe9zdAJuTJw
         n8eEhScgBvkF13zq9gbbPQSHS3wf3ocsMhMXUVmNWEhwqofEkhSGiTiVCnhPIiboiQl7
         6vSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+pGsHVHvzZ4Xzsp15UJfcJV/KQQThRfqCP1bSx5XGk4=;
        b=ivQpobsJTHw33Dke1HXdqOMyP4/YxrPH2tEKD7sD8zeZ+4eMJ8fjGQZVHqkwaApcRU
         6eiEPOgldrkDhhmAx5PBgk/o+N8nD1wr5nqLGXfN7a69marVIzSaG+vvhdkbwjoHSzg4
         Mci6SNGrJUuzKjfxokDNzP5uWgpnVSMbZ//+hZUuXWP0dFEXZCrCox7ARiOB47mUaGvo
         Baq5d25rVZPPRaiBiIyb3jCjar8B6ncjHgHIDUAjPQsk+tA+p2iU297h7vdxoryxy8/G
         LKtxN0dn2Dw7O3/kaMKFhkyb7ozEqqvfOLqTNvRnxnuHD/aF5VAolba7910g7nEq+02g
         AAAQ==
X-Gm-Message-State: ANhLgQ1lHWQYktHE6QmmNwtIfMJPqL8sFPSgpaZ0uLuy8y3u7Bw65GNL
        PTEnhgLAxnYTGgjR1+DoobxePOXCbUEhIA==
X-Google-Smtp-Source: ADFU+vupzhFASNZmDbFmbHqWlmgDw4CME5o3YrTTW1pT6kqhYLIVz3HXfsJ6+Ugrb+8FwaSh8fwHRQ==
X-Received: by 2002:a65:488d:: with SMTP id n13mr2176098pgs.91.1583321646749;
        Wed, 04 Mar 2020 03:34:06 -0800 (PST)
Received: from localhost.localdomain ([47.89.83.4])
        by smtp.gmail.com with ESMTPSA id d77sm15350050pfd.109.2020.03.04.03.34.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Mar 2020 03:34:06 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
X-Google-Original-From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
To:     Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/7] receive-pack: new external execute-commands hook
Date:   Wed,  4 Mar 2020 19:33:06 +0800
Message-Id: <20200304113312.34229-2-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.25.1.362.g51ebf55b93
In-Reply-To: <20200304113312.34229-1-zhiyou.jx@alibaba-inc.com>
References: <20200304113312.34229-1-zhiyou.jx@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git calls an internal `execute_commands` function to handle commands
sent from client to `git-receive-pack`.  Regardless of what references
the user pushes, git creates or updates the corresponding references
if the user has write permission.  A contributor who has no write
permission, cannot push to the the repository directly.  So, the
contributor has to write commits to an alternate location, and sends
pull request by emails or by other ways.  We call this distributed
workflow.

It would be more convenient to work in a centralized workflow like what
Gerrit provided for some cases.  For example, a read-only user may run
the following `git push` command to push commits to a special reference
to create a code review, instead of updating a reference directly.

    git push -o reviewers=user1,user2 \
        -o oldoid=89c082363ac950d224a7259bfba3ccfbf4c560c4 \
        origin \
        HEAD:refs/for/<branch-name>/<session>

The `<branch-name>` in the above example can be as simple as "master",
or a more complicated branch name like "foo/bar".  The `<session>` in
the above example command can be the local branch name of the client
side, such as "my/topic".

In order to support this kind of workflow in CGit, add a filter and a
new handler.  The filter will check the prefix of the reference name,
and if the command has a special reference name, the filter will add a
specific tag (`exec_by_hook`) to the command.  Commands with this
specific tag will be executed by a new handler (an exeternal hook named
"execute-commands") instead of the internal `execute_commands` function.

There are two phases involved to run "execute-commands" hook:

* In order to check permissions for special `git-push` command, run a
  new "execute-commands--pre-receive" hook (or `execute-commands
  --pre-receive`, implemented in latter commit) instead of the
  "pre-receive" hook, because adding a new hook won't break the old
  implementation of the "pre-receive" hook.

* Then will call the "execute-commands" hook (without any parameter).
  This hook may call an external API to create a code review or send
  emails.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 builtin/receive-pack.c           | 135 ++++++++--
 t/t5411-execute-commands-hook.sh | 427 +++++++++++++++++++++++++++++++
 2 files changed, 540 insertions(+), 22 deletions(-)
 create mode 100755 t/t5411-execute-commands-hook.sh

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 411e0b4d99..24eb999ed4 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -311,7 +311,8 @@ struct command {
 	struct command *next;
 	const char *error_string;
 	unsigned int skip_update:1,
-		     did_not_exist:1;
+		     did_not_exist:1,
+		     exec_by_hook:1;
 	int index;
 	struct object_id old_oid;
 	struct object_id new_oid;
@@ -668,6 +669,8 @@ static void prepare_push_cert_sha1(struct child_process *proc)
 
 struct receive_hook_feed_state {
 	struct command *cmd;
+	int exec_by_hook;
+	int hook_must_exist;
 	int skip_broken;
 	struct strbuf buf;
 	const struct string_list *push_options;
@@ -683,8 +686,13 @@ static int run_and_feed_hook(const char *hook_name, feed_fn feed,
 	int code;
 
 	argv[0] = find_hook(hook_name);
-	if (!argv[0])
-		return 0;
+	if (!argv[0]) {
+		if (feed_state->hook_must_exist) {
+			rp_error("cannot to find hook '%s'", hook_name);
+			return 1;
+		} else
+			return 0;
+	}
 
 	argv[1] = NULL;
 
@@ -750,9 +758,15 @@ static int feed_receive_hook(void *state_, const char **bufp, size_t *sizep)
 	struct receive_hook_feed_state *state = state_;
 	struct command *cmd = state->cmd;
 
-	while (cmd &&
-	       state->skip_broken && (cmd->error_string || cmd->did_not_exist))
-		cmd = cmd->next;
+	while (cmd)
+		if (state->skip_broken && (cmd->error_string || cmd->did_not_exist))
+			cmd = cmd->next;
+		else if (state->exec_by_hook && !cmd->exec_by_hook)
+			cmd = cmd->next;
+		else if (!state->exec_by_hook && cmd->exec_by_hook)
+			cmd = cmd->next;
+		else
+			break;
 	if (!cmd)
 		return -1; /* EOF */
 	strbuf_reset(&state->buf);
@@ -777,6 +791,8 @@ static int run_receive_hook(struct command *commands,
 
 	strbuf_init(&state.buf, 0);
 	state.cmd = commands;
+	state.exec_by_hook = 0;
+	state.hook_must_exist = 0;
 	state.skip_broken = skip_broken;
 	if (feed_receive_hook(&state, NULL, NULL))
 		return 0;
@@ -816,14 +832,45 @@ static int run_update_hook(struct command *cmd)
 	return finish_command(&proc);
 }
 
-static int is_ref_checked_out(const char *ref)
+static int run_execute_commands_pre_receive_hook(struct command *commands,
+			    const struct string_list *push_options)
 {
-	if (is_bare_repository())
+	struct receive_hook_feed_state state;
+	int status;
+
+	strbuf_init(&state.buf, 0);
+	state.cmd = commands;
+	state.exec_by_hook = 1;
+	state.hook_must_exist = 0;
+	state.skip_broken = 0;
+	if (feed_receive_hook(&state, NULL, NULL))
 		return 0;
+	state.cmd = commands;
+	state.push_options = push_options;
+	status = run_and_feed_hook("execute-commands--pre-receive",
+			feed_receive_hook, &state);
+	strbuf_release(&state.buf);
+	return status;
+}
+
+static int run_execute_commands_hook(struct command *commands,
+				     const struct string_list *push_options)
+{
+	struct receive_hook_feed_state state;
+	int status;
 
-	if (!head_name)
+	strbuf_init(&state.buf, 0);
+	state.cmd = commands;
+	state.exec_by_hook = 1;
+	state.hook_must_exist = 1;
+	state.skip_broken = 1;
+	if (feed_receive_hook(&state, NULL, NULL))
 		return 0;
-	return !strcmp(head_name, ref);
+	state.cmd = commands;
+	state.push_options = push_options;
+	status = run_and_feed_hook("execute-commands", feed_receive_hook, &state);
+	strbuf_release(&state.buf);
+	return status;
 }
 
 static char *refuse_unconfigured_deny_msg =
@@ -1373,7 +1420,7 @@ static void warn_if_skipped_connectivity_check(struct command *commands,
 	int checked_connectivity = 1;
 
 	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (should_process_cmd(cmd) && si->shallow_ref[cmd->index]) {
+		if (should_process_cmd(cmd) && !cmd->exec_by_hook && si->shallow_ref[cmd->index]) {
 			error("BUG: connectivity check has not been run on ref %s",
 			      cmd->ref_name);
 			checked_connectivity = 0;
@@ -1390,7 +1437,7 @@ static void execute_commands_non_atomic(struct command *commands,
 	struct strbuf err = STRBUF_INIT;
 
 	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (!should_process_cmd(cmd))
+		if (!should_process_cmd(cmd) || cmd->exec_by_hook)
 			continue;
 
 		transaction = ref_transaction_begin(&err);
@@ -1430,7 +1477,7 @@ static void execute_commands_atomic(struct command *commands,
 	}
 
 	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (!should_process_cmd(cmd))
+		if (!should_process_cmd(cmd) || cmd->exec_by_hook)
 			continue;
 
 		cmd->error_string = update(cmd, si);
@@ -1466,6 +1513,8 @@ static void execute_commands(struct command *commands,
 	struct iterate_data data;
 	struct async muxer;
 	int err_fd = 0;
+	int seen_exec_by_hook = 0;
+	int seen_internal_exec = 0;
 
 	if (unpacker_error) {
 		for (cmd = commands; cmd; cmd = cmd->next)
@@ -1495,14 +1544,45 @@ static void execute_commands(struct command *commands,
 
 	reject_updates_to_hidden(commands);
 
-	if (run_receive_hook(commands, "pre-receive", 0, push_options)) {
-		for (cmd = commands; cmd; cmd = cmd->next) {
-			if (!cmd->error_string)
-				cmd->error_string = "pre-receive hook declined";
+	/* Try to find commands that have special prefix, and will run these
+	 * commands using an external "execute-commands" hook.
+	 */
+	for (cmd = commands; cmd; cmd = cmd->next) {
+		if (!should_process_cmd(cmd))
+			continue;
+
+		/* TODO: replace the fixed prefix by looking up git config variables. */
+		if (!strncmp(cmd->ref_name, "refs/for/", 9)) {
+			cmd->exec_by_hook = 1;
+			seen_exec_by_hook = 1;
+		} else
+			seen_internal_exec = 1;
+	}
+
+	if (seen_exec_by_hook) {
+		/* Try to find and run the `execute-commands--pre-receive` hook to check
+		 * permissions on the special commands.
+		 *
+		 * If it does not exists, try to run `execute-commands --pre-receive`.
+		 */
+		if (run_execute_commands_pre_receive_hook(commands, push_options)) {
+			for (cmd = commands; cmd; cmd = cmd->next) {
+				if (!cmd->error_string)
+					cmd->error_string = "execute-commands hook declined";
+			}
+			return;
 		}
-		return;
 	}
 
+	if (seen_internal_exec)
+		if (run_receive_hook(commands, "pre-receive", 0, push_options)) {
+			for (cmd = commands; cmd; cmd = cmd->next) {
+				if (!cmd->error_string)
+					cmd->error_string = "pre-receive hook declined";
+			}
+			return;
+		}
+
 	/*
 	 * Now we'll start writing out refs, which means the objects need
 	 * to be in their final positions so that other processes can see them.
@@ -1521,10 +1601,21 @@ static void execute_commands(struct command *commands,
 	free(head_name_to_free);
 	head_name = head_name_to_free = resolve_refdup("HEAD", 0, NULL, NULL);
 
-	if (use_atomic)
-		execute_commands_atomic(commands, si);
-	else
-		execute_commands_non_atomic(commands, si);
+	if (seen_exec_by_hook) {
+		if (run_execute_commands_hook(commands, push_options)) {
+			for (cmd = commands; cmd; cmd = cmd->next) {
+				if (!cmd->error_string  && (cmd->exec_by_hook || use_atomic))
+					cmd->error_string = "fail to run execute-commands hook";
+			}
+		}
+	}
+
+	if (seen_internal_exec) {
+		if (use_atomic)
+			execute_commands_atomic(commands, si);
+		else
+			execute_commands_non_atomic(commands, si);
+	}
 
 	if (shallow_update)
 		warn_if_skipped_connectivity_check(commands, si);
diff --git a/t/t5411-execute-commands-hook.sh b/t/t5411-execute-commands-hook.sh
new file mode 100755
index 0000000000..2ff0d5cbcd
--- /dev/null
+++ b/t/t5411-execute-commands-hook.sh
@@ -0,0 +1,427 @@
+#!/bin/sh
+#
+# Copyright (c) 2018-2020 Jiang Xin
+#
+
+test_description='Test execute-commands hook on special git-push refspec'
+
+. ./test-lib.sh
+
+bare=bare.git
+
+create_commits_in () {
+	repo="$1" &&
+	if ! parent=$(git -C "$repo" rev-parse HEAD^{} 2>/dev/null)
+	then
+		parent=
+	fi &&
+	T=$(git -C "$repo" write-tree) &&
+	shift &&
+	while test $# -gt 0
+	do
+		name=$1 &&
+		test_tick &&
+		if test -z "$parent"
+		then
+			oid=$(echo $name | git -C "$repo" commit-tree $T)
+		else
+			oid=$(echo $name | git -C "$repo" commit-tree -p $parent $T)
+		fi &&
+		eval $name=$oid &&
+		parent=$oid &&
+		shift ||
+		return 1
+	done &&
+	git -C "$repo" update-ref refs/heads/master $oid
+}
+
+test_expect_success setup '
+	git init --bare $bare &&
+
+	# Enable push options for bare.git.
+	git -C $bare config receive.advertisePushOptions true &&
+
+	git clone --no-local $bare work &&
+	create_commits_in work A B
+'
+
+test_expect_success "setup hooks" '
+	## execute-commands--pre-receive hook
+	cat >$bare/hooks/execute-commands--pre-receive <<-EOF &&
+	#!/bin/sh
+
+	printf >&2 "execute: execute-commands--pre-receive\n"
+
+	while read old new ref
+	do
+		printf >&2 ">> old: \$old, new: \$new, ref: \$ref.\n"
+	done
+	EOF
+
+	## execute-commands hook
+	cat >$bare/hooks/execute-commands <<-EOF &&
+	#!/bin/sh
+
+	printf >&2 "execute: execute-commands\n"
+
+	while read old new ref
+	do
+		printf >&2 ">> old: \$old, new: \$new, ref: \$ref.\n"
+	done
+	EOF
+
+	## pre-receive hook
+	cat >$bare/hooks/pre-receive <<-EOF &&
+	#!/bin/sh
+
+	printf >&2 "execute: pre-receive hook\n"
+
+	while read old new ref
+	do
+		printf >&2 ">> old: \$old, new: \$new, ref: \$ref.\n"
+	done
+	EOF
+
+	## post-receive hook
+	cat >$bare/hooks/post-receive <<-EOF &&
+	#!/bin/sh
+
+	printf >&2 "execute: post-receive hook\n"
+
+	while read old new ref
+	do
+		printf >&2 ">> old: \$old, new: \$new, ref: \$ref.\n"
+	done
+	EOF
+	chmod a+x \
+		$bare/hooks/pre-receive \
+		$bare/hooks/post-receive \
+		$bare/hooks/execute-commands \
+		$bare/hooks/execute-commands--pre-receive
+'
+
+test_expect_success "push normal branches and execute pre-receive and post-receive hooks" '
+	(
+		cd work &&
+		git update-ref HEAD $A &&
+		git push origin HEAD HEAD:maint 2>&1
+	) >out &&
+	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
+	cat >expect <<-EOF &&
+	remote: execute: pre-receive hook
+	remote: >> old: 0000000000000000000000000000000000000000, new: 102939797ab91a4f201d131418d2c9d919dcdd2c, ref: refs/heads/master.
+	remote: >> old: 0000000000000000000000000000000000000000, new: 102939797ab91a4f201d131418d2c9d919dcdd2c, ref: refs/heads/maint.
+	remote: execute: post-receive hook
+	remote: >> old: 0000000000000000000000000000000000000000, new: 102939797ab91a4f201d131418d2c9d919dcdd2c, ref: refs/heads/master.
+	remote: >> old: 0000000000000000000000000000000000000000, new: 102939797ab91a4f201d131418d2c9d919dcdd2c, ref: refs/heads/maint.
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "create local topic branch" '
+	(
+		cd work &&
+		git checkout -b my/topic origin/master
+	)
+'
+
+test_expect_failure "push one special ref: refs/for/master" '
+	(
+		cd work &&
+		git update-ref HEAD $B &&
+		git push origin HEAD:refs/for/master/my/topic
+	) >out 2>&1 &&
+	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
+	cat >expect <<-EOF &&
+	remote: execute: execute-commands--pre-receive
+	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/master/my/topic.
+	remote: execute: execute-commands
+	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/master/my/topic.
+	remote: execute: post-receive hook
+	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/master/my/topic.
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "remove execute-commands hook" '
+	mv $bare/hooks/execute-commands $bare/hooks/execute-commands.ok
+'
+
+test_expect_success "push branch: refs/heads/a/b/c" '
+	(
+		cd work &&
+		git update-ref HEAD $A &&
+		git push origin HEAD:a/b/c 2>&1
+	) >out &&
+	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
+	cat >expect <<-EOF &&
+	remote: execute: pre-receive hook
+	remote: >> old: 0000000000000000000000000000000000000000, new: 102939797ab91a4f201d131418d2c9d919dcdd2c, ref: refs/heads/a/b/c.
+	remote: execute: post-receive hook
+	remote: >> old: 0000000000000000000000000000000000000000, new: 102939797ab91a4f201d131418d2c9d919dcdd2c, ref: refs/heads/a/b/c.
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "fail to push special ref: refs/for/master" '
+	(
+		cd work &&
+		git update-ref HEAD $B &&
+		test_must_fail git push origin HEAD:refs/for/master/my/topic
+	) >out 2>&1 &&
+	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
+	cat >expect <<-EOF &&
+	remote: execute: execute-commands--pre-receive
+	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/master/my/topic.
+	remote: error: cannot to find hook '"'"'execute-commands'"'"'
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "add back the execute-commands hook" '
+	mv $bare/hooks/execute-commands.ok $bare/hooks/execute-commands
+'
+
+test_expect_failure "push one special ref: refs/for/a/b/c" '
+	(
+		cd work &&
+		git push origin HEAD:refs/for/a/b/c/my/topic
+	) >out 2>&1 &&
+	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
+	cat >expect <<-EOF &&
+	remote: execute: execute-commands--pre-receive
+	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/a/b/c/my/topic.
+	remote: execute: execute-commands
+	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/a/b/c/my/topic.
+	remote: execute: post-receive hook
+	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/a/b/c/my/topic.
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_failure "push two special references" '
+	(
+		cd work &&
+		git push origin \
+			HEAD:refs/for/maint/my/topic \
+			HEAD:refs/for/a/b/c/my/topic
+	) >out 2>&1 &&
+	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
+	cat >expect <<-EOF &&
+	remote: execute: execute-commands--pre-receive
+	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/maint/my/topic.
+	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/a/b/c/my/topic.
+	remote: execute: execute-commands
+	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/maint/my/topic.
+	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/a/b/c/my/topic.
+	remote: execute: post-receive hook
+	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/maint/my/topic.
+	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/a/b/c/my/topic.
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "new execute-commands hook (fail with error)" '
+	mv $bare/hooks/execute-commands $bare/hooks/execute-commands.ok &&
+	cat >$bare/hooks/execute-commands <<-EOF &&
+	#!/bin/sh
+
+	printf >&2 "execute: execute-commands\n"
+
+	while read old new ref
+	do
+		printf >&2 ">> old: \$old, new: \$new, ref: \$ref.\n"
+	done
+
+	printf >&2 "fail to run execute-commands\n"
+	exit 1
+	EOF
+	chmod a+x $bare/hooks/execute-commands
+'
+
+test_expect_success "successfully push normal ref, and fail to push special reference" '
+	(
+		cd work &&
+		test_must_fail git push origin \
+			HEAD:refs/for/maint/my/topic \
+			HEAD:refs/heads/master
+	) >out 2>&1 &&
+	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
+	cat >expect <<-EOF &&
+	remote: execute: execute-commands--pre-receive
+	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/maint/my/topic.
+	remote: execute: pre-receive hook
+	remote: >> old: 102939797ab91a4f201d131418d2c9d919dcdd2c, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/heads/master.
+	remote: execute: execute-commands
+	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/maint/my/topic.
+	remote: fail to run execute-commands
+	remote: execute: post-receive hook
+	remote: >> old: 102939797ab91a4f201d131418d2c9d919dcdd2c, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/heads/master.
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "restore remote master branch" '
+	(
+		cd $bare &&
+		git update-ref refs/heads/master $A $B &&
+		git show-ref
+	) >actual &&
+	cat >expect <<-eof &&
+	102939797ab91a4f201d131418d2c9d919dcdd2c refs/heads/a/b/c
+	102939797ab91a4f201d131418d2c9d919dcdd2c refs/heads/maint
+	102939797ab91a4f201d131418d2c9d919dcdd2c refs/heads/master
+	eof
+	test_cmp expect actual
+'
+
+test_expect_success "all mixed refs are failed to push in atomic mode" '
+	(
+		cd work &&
+		test_must_fail git push --atomic origin \
+			HEAD:refs/for/maint/my/topic \
+			HEAD:refs/heads/master
+	) >out 2>&1 &&
+	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
+	cat >expect <<-EOF &&
+	remote: execute: execute-commands--pre-receive
+	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/maint/my/topic.
+	remote: execute: pre-receive hook
+	remote: >> old: 102939797ab91a4f201d131418d2c9d919dcdd2c, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/heads/master.
+	remote: execute: execute-commands
+	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/maint/my/topic.
+	remote: fail to run execute-commands
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "restore execute-commands hook" '
+	mv $bare/hooks/execute-commands $bare/hooks/execute-commands.fail &&
+	mv $bare/hooks/execute-commands.ok $bare/hooks/execute-commands
+'
+
+test_expect_failure "push mixed references successfully" '
+	(
+		cd work &&
+		git push origin \
+			HEAD:refs/for/maint/my/topic \
+			HEAD:refs/heads/master
+	) >out 2>&1 &&
+	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
+	cat >expect <<-EOF &&
+	remote: execute: execute-commands--pre-receive
+	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/maint/my/topic.
+	remote: execute: pre-receive hook
+	remote: >> old: 102939797ab91a4f201d131418d2c9d919dcdd2c, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/heads/master.
+	remote: execute: execute-commands
+	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/maint/my/topic.
+	remote: execute: post-receive hook
+	remote: >> old: 102939797ab91a4f201d131418d2c9d919dcdd2c, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/heads/master.
+	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/maint/my/topic.
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "restore remote master branch" '
+	(
+		cd $bare &&
+		git update-ref refs/heads/master $A $B &&
+		git show-ref
+	) >actual &&
+	cat >expect <<-EOF &&
+	102939797ab91a4f201d131418d2c9d919dcdd2c refs/heads/a/b/c
+	102939797ab91a4f201d131418d2c9d919dcdd2c refs/heads/maint
+	102939797ab91a4f201d131418d2c9d919dcdd2c refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "new execute-commands--pre-receive hook (declined version)" '
+	mv $bare/hooks/execute-commands--pre-receive $bare/hooks/execute-commands--pre-receive.ok &&
+	cat >$bare/hooks/execute-commands--pre-receive <<-EOF &&
+	#!/bin/sh
+
+	printf >&2 "execute: execute-commands--pre-receive\n"
+
+	while read old new ref
+	do
+		printf >&2 ">> old: \$old, new: \$new, ref: \$ref.\n"
+	done
+
+	printf >&2 ">> ERROR: declined in execute-commands--pre-receive\n"
+	exit 1
+	EOF
+	chmod a+x $bare/hooks/execute-commands--pre-receive
+'
+
+test_expect_success "cannot push two special references (declined)" '
+	(
+		cd work &&
+		test_must_fail git push origin \
+			HEAD:refs/for/master/my/topic \
+			HEAD:refs/for/maint/my/topic
+	) >out 2>&1 &&
+	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
+	cat >expect <<-EOF &&
+	remote: execute: execute-commands--pre-receive
+	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/master/my/topic.
+	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/maint/my/topic.
+	remote: >> ERROR: declined in execute-commands--pre-receive
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "cannot push mixed references (declined)" '
+	(
+		cd work &&
+		test_must_fail git push origin \
+			HEAD:refs/for/master/my/topic \
+			HEAD:refs/heads/master
+	) >out 2>&1 &&
+	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
+	cat >expect <<-EOF &&
+	remote: execute: execute-commands--pre-receive
+	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/master/my/topic.
+	remote: >> ERROR: declined in execute-commands--pre-receive
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "new pre-receive hook (declined version)" '
+	mv $bare/hooks/execute-commands--pre-receive $bare/hooks/execute-commands--pre-receive.fail &&
+	mv $bare/hooks/execute-commands--pre-receive.ok $bare/hooks/execute-commands--pre-receive &&
+	mv $bare/hooks/pre-receive $bare/hooks/pre-receive.ok &&
+	cat >$bare/hooks/pre-receive <<-EOF &&
+	#!/bin/sh
+
+	printf >&2 "execute: pre-receive hook\n"
+
+	while read old new ref
+	do
+		printf >&2 ">> old: \$old, new: \$new, ref: \$ref.\n"
+	done
+	printf >&2 ">> ERROR: declined in pre-receive hook\n"
+	exit 1
+	EOF
+	chmod a+x $bare/hooks/pre-receive
+'
+
+test_expect_success "cannot push mixed references (declined)" '
+	(
+		cd work &&
+		test_must_fail git push origin \
+			HEAD:refs/for/master/my/topic \
+			HEAD:refs/heads/master
+	) >out 2>&1 &&
+	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
+	cat >expect <<-EOF &&
+	remote: execute: execute-commands--pre-receive
+	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/master/my/topic.
+	remote: execute: pre-receive hook
+	remote: >> old: 102939797ab91a4f201d131418d2c9d919dcdd2c, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/heads/master.
+	remote: >> ERROR: declined in pre-receive hook
+	EOF
+	test_cmp expect actual
+'
+
+test_done
-- 
2.25.1.362.g51ebf55b93

