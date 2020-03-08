Return-Path: <SRS0=m/qT=4Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D37C10DCE
	for <git@archiver.kernel.org>; Sun,  8 Mar 2020 14:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF06120866
	for <git@archiver.kernel.org>; Sun,  8 Mar 2020 14:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tWozBiYY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgCHO55 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Mar 2020 10:57:57 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46966 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgCHO55 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Mar 2020 10:57:57 -0400
Received: by mail-pl1-f193.google.com with SMTP id w12so2934246pll.13
        for <git@vger.kernel.org>; Sun, 08 Mar 2020 07:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h1+0yQBBlsWTa4wZeHOBULXGtYFduAGxNGjgPYhzpq0=;
        b=tWozBiYYwNtEViFXzIIFh394vGB6M32gm8q7o8ulZVIC5yWwFDnLlScuNteryErsJz
         /7UC/AWotRCYTSvinbcIyjTiHGV9pSU8pURrjAB4SDQrpYkfXJLWpcDhQ3/6in2nQRt0
         JxbvFrUffRXcPz8DzeuqymPX1D53hS+6A6g709YvO4i/kM6VKZoMRexkj2GLazQLM4Xe
         8RRjJIRfQ7wUbXabYSgdfMtRDFgHJ0huFcEsrDmj9K/mdJpxzhxGWxLmfhOiSg8ts3aO
         acifvh+EE5l1IMPJ3QbC5z1kICkfX5Gdsi+kYytX916U3se0KqouVTZHu42Tty+ws4ax
         xbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h1+0yQBBlsWTa4wZeHOBULXGtYFduAGxNGjgPYhzpq0=;
        b=TleU7O8MjSCApNXokydDI4qB21WbJr/rj/pQgXkbQtrvwhO6lUnE/gRukdH2fl72sx
         JjuvH8WWr55XKO/kGhTW4Y3p/t3jg4/gTg8O1pRF0lnV6PdzHhw8dzagoWEIID5Rw0+5
         tCdOTPC8G6RY6VH4/yK74HQ62ul/jdDf2q6kH6Om8zkgDQiDiVh2zYxqkYR4ncj/E4NK
         8dmI4Q7F8n2jKOWeGYGLUSaspG2Gs5PBGmizRImzOzPcHEYmg6KEF3coc3WWzcv8c0ZN
         PiltUgM3pUpYAH0qf9ZuNaWvbs0isIXY5sDU+5BEJWV+k420RSIjteJwOyTLyZTidz0A
         I1Hw==
X-Gm-Message-State: ANhLgQ2QuuHfhDlouqEZPr1lZpEJzQdnRq1PrrPBYV/SeoaMvkoI17gr
        yC38K3cM4CxxrJMn98RtI2WFgdc6
X-Google-Smtp-Source: ADFU+vvJlKlh8GuGqZCuAdtewW/7//rnX84y85CV7qMFvVIr9Tg8I5GyByjBUYxSj+ZdILSIwHrksA==
X-Received: by 2002:a17:90a:cb8a:: with SMTP id a10mr1282315pju.89.1583679475256;
        Sun, 08 Mar 2020 07:57:55 -0700 (PDT)
Received: from localhost.localdomain ([117.136.0.219])
        by smtp.gmail.com with ESMTPSA id q7sm27339309pfs.17.2020.03.08.07.57.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Mar 2020 07:57:54 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
X-Google-Original-From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v2 1/5] receive-pack: add new proc-receive hook
Date:   Sun,  8 Mar 2020 22:56:27 +0800
Message-Id: <20200308145631.64040-2-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.26.0.rc0.5.gb02b988a14.dirty
In-Reply-To: <CANYiYbE2V3bLfEgH-aRDv4Y5V+_BTZn-oUN7fOVpARm+_14BdQ@mail.gmail.com>
References: <CANYiYbE2V3bLfEgH-aRDv4Y5V+_BTZn-oUN7fOVpARm+_14BdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git calls an internal `execute_commands` function to handle commands
sent from client to `git-receive-pack`.  Regardless of what references
the user pushes, git creates or updates the corresponding references if
the user has write-permission.  A contributor who has no
write-permission, cannot push to the repository directly.  So, the
contributor has to write commits to an alternate location, and sends
pull request by emails or by other ways.  We call this workflow as a
distributed workflow.

It would be more convenient to work in a centralized workflow like what
Gerrit provided for some cases.  For example, a read-only user who
cannot push to a branch directly can run the following `git push`
command to push commits to a pseudo reference (has a prefix "refs/for/",
not "refs/heads/") to create a code review.

    git push origin \
        HEAD:refs/for/<branch-name>/<session>

The `<branch-name>` in the above example can be as simple as "master",
or a more complicated branch name like "foo/bar".  The `<session>` in
the above example command can be the local branch name of the client
side, such as "my/topic".

We cannot implement a centralized workflow elegantly by using
"pre-receive" + "post-receive", because Git will call the internal
function "execute_commands" to create references (even the special
pseudo reference) between these two hooks.  Even though we can delete
the temporarily created pseudo reference via the "post-receive" hook,
having a temporary reference is not safe for concurrent pushes.

So, add a filter and a new handler to support this kind of workflow.
The filter will check the prefix of the reference name, and if the
command has a special reference name, the filter will turn a specific
field (`have_special_ref`) on for the command.  Commands with this filed
turned on will be executed by a new handler (an hook named
"proc-receive") instead of the internal `execute_commands` function.
We can use this "proc-receive" command to create pull requests or send
emails for code review.

This "proc-receive" hook executes once for the receive operation. It
takes no arguments, but gets the same information as the pre-receive
hook does on its standard input.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 builtin/receive-pack.c       |  93 +++++-
 t/t5411-proc-receive-hook.sh | 547 +++++++++++++++++++++++++++++++++++
 2 files changed, 628 insertions(+), 12 deletions(-)
 create mode 100755 t/t5411-proc-receive-hook.sh

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 2cc18bbffd..23d0c224d2 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -312,7 +312,8 @@ struct command {
 	struct command *next;
 	const char *error_string;
 	unsigned int skip_update:1,
-		     did_not_exist:1;
+		     did_not_exist:1,
+		     have_special_ref:1;
 	int index;
 	struct object_id old_oid;
 	struct object_id new_oid;
@@ -669,6 +670,9 @@ static void prepare_push_cert_sha1(struct child_process *proc)
 
 struct receive_hook_feed_state {
 	struct command *cmd;
+	int feed_normal_ref;
+	int feed_special_ref;
+	int hook_must_exist;
 	int skip_broken;
 	struct strbuf buf;
 	const struct string_list *push_options;
@@ -684,8 +688,14 @@ static int run_and_feed_hook(const char *hook_name, feed_fn feed,
 	int code;
 
 	argv[0] = find_hook(hook_name);
-	if (!argv[0])
-		return 0;
+	if (!argv[0]) {
+		if (feed_state->hook_must_exist) {
+			rp_error("cannot to find hook '%s'", hook_name);
+			return 1;
+		} else {
+			return 0;
+		}
+	}
 
 	argv[1] = NULL;
 
@@ -751,9 +761,17 @@ static int feed_receive_hook(void *state_, const char **bufp, size_t *sizep)
 	struct receive_hook_feed_state *state = state_;
 	struct command *cmd = state->cmd;
 
-	while (cmd &&
-	       state->skip_broken && (cmd->error_string || cmd->did_not_exist))
-		cmd = cmd->next;
+	while (cmd) {
+		if (state->skip_broken && (cmd->error_string || cmd->did_not_exist))
+			cmd = cmd->next;
+		else if (state->feed_special_ref && cmd->have_special_ref)
+			break;
+		else if (state->feed_normal_ref && !cmd->have_special_ref)
+			break;
+		else
+			cmd = cmd->next;
+	}
+
 	if (!cmd)
 		return -1; /* EOF */
 	strbuf_reset(&state->buf);
@@ -778,6 +796,9 @@ static int run_receive_hook(struct command *commands,
 
 	strbuf_init(&state.buf, 0);
 	state.cmd = commands;
+	state.feed_normal_ref = 1;
+	state.feed_special_ref = 1;
+	state.hook_must_exist = 0;
 	state.skip_broken = skip_broken;
 	if (feed_receive_hook(&state, NULL, NULL))
 		return 0;
@@ -817,6 +838,27 @@ static int run_update_hook(struct command *cmd)
 	return finish_command(&proc);
 }
 
+static int run_proc_receive_hook(struct command *commands,
+				 const struct string_list *push_options)
+{
+	struct receive_hook_feed_state state;
+	int status;
+
+	strbuf_init(&state.buf, 0);
+	state.cmd = commands;
+	state.feed_normal_ref = 0;
+	state.feed_special_ref = 1;
+	state.hook_must_exist = 1;
+	state.skip_broken = 1;
+	if (feed_receive_hook(&state, NULL, NULL))
+		return 0;
+	state.cmd = commands;
+	state.push_options = push_options;
+	status = run_and_feed_hook("proc-receive", feed_receive_hook, &state);
+	strbuf_release(&state.buf);
+	return status;
+}
+
 static char *refuse_unconfigured_deny_msg =
 	N_("By default, updating the current branch in a non-bare repository\n"
 	   "is denied, because it will make the index and work tree inconsistent\n"
@@ -1392,7 +1434,7 @@ static void execute_commands_non_atomic(struct command *commands,
 	struct strbuf err = STRBUF_INIT;
 
 	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (!should_process_cmd(cmd))
+		if (!should_process_cmd(cmd) || cmd->have_special_ref)
 			continue;
 
 		transaction = ref_transaction_begin(&err);
@@ -1432,7 +1474,7 @@ static void execute_commands_atomic(struct command *commands,
 	}
 
 	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (!should_process_cmd(cmd))
+		if (!should_process_cmd(cmd) || cmd->have_special_ref)
 			continue;
 
 		cmd->error_string = update(cmd, si);
@@ -1468,6 +1510,8 @@ static void execute_commands(struct command *commands,
 	struct iterate_data data;
 	struct async muxer;
 	int err_fd = 0;
+	int have_special_ref = 0;
+	int have_normal_ref = 0;
 
 	if (unpacker_error) {
 		for (cmd = commands; cmd; cmd = cmd->next)
@@ -1497,6 +1541,22 @@ static void execute_commands(struct command *commands,
 
 	reject_updates_to_hidden(commands);
 
+	/* Try to find commands that have special prefix in their reference names,
+	 * and mark them to run an external "proc-receive" hook later.
+	 */
+	for (cmd = commands; cmd; cmd = cmd->next) {
+		if (!should_process_cmd(cmd))
+			continue;
+
+		/* TODO: replace the fixed prefix by looking up git config variables. */
+		if (!strncmp(cmd->ref_name, "refs/for/", 9)) {
+			cmd->have_special_ref = 1;
+			have_special_ref = 1;
+		} else {
+			have_normal_ref = 1;
+		}
+	}
+
 	if (run_receive_hook(commands, "pre-receive", 0, push_options)) {
 		for (cmd = commands; cmd; cmd = cmd->next) {
 			if (!cmd->error_string)
@@ -1523,10 +1583,19 @@ static void execute_commands(struct command *commands,
 	free(head_name_to_free);
 	head_name = head_name_to_free = resolve_refdup("HEAD", 0, NULL, NULL);
 
-	if (use_atomic)
-		execute_commands_atomic(commands, si);
-	else
-		execute_commands_non_atomic(commands, si);
+	if (have_special_ref && run_proc_receive_hook(commands, push_options)) {
+		for (cmd = commands; cmd; cmd = cmd->next) {
+			if (!cmd->error_string  && (cmd->have_special_ref || use_atomic))
+				cmd->error_string = "fail to run proc-receive hook";
+		}
+	}
+
+	if (have_normal_ref) {
+		if (use_atomic)
+			execute_commands_atomic(commands, si);
+		else
+			execute_commands_non_atomic(commands, si);
+	}
 
 	if (shallow_update)
 		warn_if_skipped_connectivity_check(commands, si);
diff --git a/t/t5411-proc-receive-hook.sh b/t/t5411-proc-receive-hook.sh
new file mode 100755
index 0000000000..01f67965bf
--- /dev/null
+++ b/t/t5411-proc-receive-hook.sh
@@ -0,0 +1,547 @@
+#!/bin/sh
+#
+# Copyright (c) 2018-2020 Jiang Xin
+#
+
+test_description='Test proc-receive hook on special git-push refspec'
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
+test_expect_success "setup repository" '
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
+	## proc-receive hook
+	cat >$bare/hooks/proc-receive <<-EOF &&
+	#!/bin/sh
+
+	printf >&2 "execute: proc-receive hook\n"
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
+		$bare/hooks/proc-receive \
+'
+
+test_expect_success "(1) standard git-push command" '
+	(
+		cd work &&
+		git update-ref HEAD $A &&
+		git push origin HEAD HEAD:maint HEAD:a/b/c 2>&1
+	) >out &&
+	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
+	cat >expect <<-EOF &&
+	remote: execute: pre-receive hook
+	remote: >> old: $ZERO_OID, new: $A, ref: refs/heads/master.
+	remote: >> old: $ZERO_OID, new: $A, ref: refs/heads/maint.
+	remote: >> old: $ZERO_OID, new: $A, ref: refs/heads/a/b/c.
+	remote: execute: post-receive hook
+	remote: >> old: $ZERO_OID, new: $A, ref: refs/heads/master.
+	remote: >> old: $ZERO_OID, new: $A, ref: refs/heads/maint.
+	remote: >> old: $ZERO_OID, new: $A, ref: refs/heads/a/b/c.
+	EOF
+	test_cmp expect actual &&
+	(
+		cd $bare &&
+		git show-ref
+	) >actual &&
+	cat >expect <<-EOF &&
+	$A refs/heads/a/b/c
+	$A refs/heads/maint
+	$A refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "(1) push one special ref" '
+	(
+		cd work &&
+		git update-ref HEAD $B &&
+		git push origin HEAD:refs/for/master/my/topic
+	) >out 2>&1 &&
+	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
+	cat >expect <<-EOF &&
+	remote: execute: pre-receive hook
+	remote: >> old: $ZERO_OID, new: $B, ref: refs/for/master/my/topic.
+	remote: execute: proc-receive hook
+	remote: >> old: $ZERO_OID, new: $B, ref: refs/for/master/my/topic.
+	remote: execute: post-receive hook
+	remote: >> old: $ZERO_OID, new: $B, ref: refs/for/master/my/topic.
+	EOF
+	test_cmp expect actual &&
+	(
+		cd $bare &&
+		git show-ref
+	) >actual &&
+	cat >expect <<-EOF &&
+	$A refs/heads/a/b/c
+	$A refs/heads/maint
+	$A refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "(1) push both a normal and a special refs" '
+	(
+		cd work &&
+		git push origin \
+			HEAD:refs/for/maint/my/topic \
+			HEAD:refs/heads/master
+	) >out 2>&1 &&
+	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
+	cat >expect <<-EOF &&
+	remote: execute: pre-receive hook
+	remote: >> old: $A, new: $B, ref: refs/heads/master.
+	remote: >> old: $ZERO_OID, new: $B, ref: refs/for/maint/my/topic.
+	remote: execute: proc-receive hook
+	remote: >> old: $ZERO_OID, new: $B, ref: refs/for/maint/my/topic.
+	remote: execute: post-receive hook
+	remote: >> old: $A, new: $B, ref: refs/heads/master.
+	remote: >> old: $ZERO_OID, new: $B, ref: refs/for/maint/my/topic.
+	EOF
+	test_cmp expect actual &&
+	(
+		cd $bare &&
+		git show-ref
+	) >actual &&
+	cat >expect <<-EOF &&
+	$A refs/heads/a/b/c
+	$A refs/heads/maint
+	$B refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "(1) cleanup" '
+	(
+		cd $bare &&
+		git update-ref refs/heads/master $A $B &&
+		git show-ref
+	) >actual &&
+	cat >expect <<-EOF &&
+	$A refs/heads/a/b/c
+	$A refs/heads/maint
+	$A refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "(2) remove proc-receive hook" '
+	mv $bare/hooks/proc-receive $bare/hooks/proc-receive.ok
+'
+
+test_expect_success "(2) standard git-push command" '
+	(
+		cd work &&
+		git update-ref HEAD $B &&
+		git push origin HEAD:master 2>&1
+	) >out &&
+	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
+	cat >expect <<-EOF &&
+	remote: execute: pre-receive hook
+	remote: >> old: $A, new: $B, ref: refs/heads/master.
+	remote: execute: post-receive hook
+	remote: >> old: $A, new: $B, ref: refs/heads/master.
+	EOF
+	test_cmp expect actual &&
+	(
+		cd $bare &&
+		git show-ref
+	) >actual &&
+	cat >expect <<-EOF &&
+	$A refs/heads/a/b/c
+	$A refs/heads/maint
+	$B refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "(2) cleanup" '
+	(
+		cd $bare &&
+		git update-ref refs/heads/master $A $B &&
+		git show-ref
+	) >actual &&
+	cat >expect <<-EOF &&
+	$A refs/heads/a/b/c
+	$A refs/heads/maint
+	$A refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "(2) push one special ref (failed)" '
+	(
+		cd work &&
+		git update-ref HEAD $B &&
+		test_must_fail git push origin HEAD:refs/for/a/b/c/my/topic
+	) >out 2>&1 &&
+	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
+	cat >expect <<-EOF &&
+	remote: execute: pre-receive hook
+	remote: >> old: $ZERO_OID, new: $B, ref: refs/for/a/b/c/my/topic.
+	remote: error: cannot to find hook '"'"'proc-receive'"'"'
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "(2) push both a normal and a special refs (one failed)" '
+	(
+		cd work &&
+		git update-ref HEAD $B &&
+		test_must_fail git push origin \
+			HEAD:refs/for/maint/my/topic \
+			HEAD:refs/heads/master
+	) >out 2>&1 &&
+	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
+	cat >expect <<-EOF &&
+	remote: execute: pre-receive hook
+	remote: >> old: $A, new: $B, ref: refs/heads/master.
+	remote: >> old: $ZERO_OID, new: $B, ref: refs/for/maint/my/topic.
+	remote: error: cannot to find hook '"'"'proc-receive'"'"'
+	remote: execute: post-receive hook
+	remote: >> old: $A, new: $B, ref: refs/heads/master.
+	EOF
+	test_cmp expect actual &&
+	(
+		cd $bare &&
+		git show-ref
+	) >actual &&
+	cat >expect <<-EOF &&
+	$A refs/heads/a/b/c
+	$A refs/heads/maint
+	$B refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "(2) cleanup" '
+	(
+		cd $bare &&
+		git update-ref refs/heads/master $A $B &&
+		git show-ref
+	) >actual &&
+	cat >expect <<-EOF &&
+	$A refs/heads/a/b/c
+	$A refs/heads/maint
+	$A refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "(2) atomic push both a normal and a special refs (failed)" '
+	(
+		cd work &&
+		git update-ref HEAD $B &&
+		test_must_fail git push --atomic origin \
+			HEAD:refs/for/maint/my/topic \
+			HEAD:refs/heads/master
+	) >out 2>&1 &&
+	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
+	cat >expect <<-EOF &&
+	remote: execute: pre-receive hook
+	remote: >> old: $A, new: $B, ref: refs/heads/master.
+	remote: >> old: $ZERO_OID, new: $B, ref: refs/for/maint/my/topic.
+	remote: error: cannot to find hook '"'"'proc-receive'"'"'
+	EOF
+	test_cmp expect actual &&
+	(
+		cd $bare &&
+		git show-ref
+	) >actual &&
+	cat >expect <<-EOF &&
+	$A refs/heads/a/b/c
+	$A refs/heads/maint
+	$A refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "(3) new proc-receive hook (return error)" '
+	cat >$bare/hooks/proc-receive <<-EOF &&
+	#!/bin/sh
+
+	printf >&2 "execute: proc-receive hook\n"
+
+	while read old new ref
+	do
+		printf >&2 ">> old: \$old, new: \$new, ref: \$ref.\n"
+	done
+
+	printf >&2 "fail to run proc-receive\n"
+	exit 1
+	EOF
+	chmod a+x $bare/hooks/proc-receive
+'
+
+test_expect_success "(3) standard git-push command" '
+	(
+		cd work &&
+		git update-ref HEAD $B &&
+		git push origin HEAD:master 2>&1
+	) >out &&
+	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
+	cat >expect <<-EOF &&
+	remote: execute: pre-receive hook
+	remote: >> old: $A, new: $B, ref: refs/heads/master.
+	remote: execute: post-receive hook
+	remote: >> old: $A, new: $B, ref: refs/heads/master.
+	EOF
+	test_cmp expect actual &&
+	(
+		cd $bare &&
+		git show-ref
+	) >actual &&
+	cat >expect <<-EOF &&
+	$A refs/heads/a/b/c
+	$A refs/heads/maint
+	$B refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "(3) cleanup" '
+	(
+		cd $bare &&
+		git update-ref refs/heads/master $A $B &&
+		git show-ref
+	) >actual &&
+	cat >expect <<-EOF &&
+	$A refs/heads/a/b/c
+	$A refs/heads/maint
+	$A refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "(3) push both a normal and a special refs (one failed)" '
+	(
+		cd work &&
+		git update-ref HEAD $B &&
+		test_must_fail git push origin \
+			HEAD:refs/for/maint/my/topic \
+			HEAD:refs/heads/master
+	) >out 2>&1 &&
+	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
+	cat >expect <<-EOF &&
+	remote: execute: pre-receive hook
+	remote: >> old: $A, new: $B, ref: refs/heads/master.
+	remote: >> old: $ZERO_OID, new: $B, ref: refs/for/maint/my/topic.
+	remote: execute: proc-receive hook
+	remote: >> old: $ZERO_OID, new: $B, ref: refs/for/maint/my/topic.
+	remote: fail to run proc-receive
+	remote: execute: post-receive hook
+	remote: >> old: $A, new: $B, ref: refs/heads/master.
+	EOF
+	test_cmp expect actual &&
+	(
+		cd $bare &&
+		git show-ref
+	) >actual &&
+	cat >expect <<-EOF &&
+	$A refs/heads/a/b/c
+	$A refs/heads/maint
+	$B refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "(3) cleanup" '
+	(
+		cd $bare &&
+		git update-ref refs/heads/master $A $B &&
+		git show-ref
+	) >actual &&
+	cat >expect <<-EOF &&
+	$A refs/heads/a/b/c
+	$A refs/heads/maint
+	$A refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "(3) atomic push a normal and a special refs (failed)" '
+	(
+		cd work &&
+		git update-ref HEAD $B &&
+		test_must_fail git push --atomic origin \
+			HEAD:refs/for/maint/my/topic \
+			HEAD:refs/heads/master
+	) >out 2>&1 &&
+	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
+	cat >expect <<-EOF &&
+	remote: execute: pre-receive hook
+	remote: >> old: $A, new: $B, ref: refs/heads/master.
+	remote: >> old: $ZERO_OID, new: $B, ref: refs/for/maint/my/topic.
+	remote: execute: proc-receive hook
+	remote: >> old: $ZERO_OID, new: $B, ref: refs/for/maint/my/topic.
+	remote: fail to run proc-receive
+	EOF
+	test_cmp expect actual &&
+	(
+		cd $bare &&
+		git show-ref
+	) >actual &&
+	cat >expect <<-EOF &&
+	$A refs/heads/a/b/c
+	$A refs/heads/maint
+	$A refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "(4) restore proc-receive hook" '
+	mv $bare/hooks/proc-receive $bare/hooks/proc-receive.fail &&
+	mv $bare/hooks/proc-receive.ok $bare/hooks/proc-receive
+'
+
+test_expect_success "(4) push two special references" '
+	(
+		cd work &&
+		git update-ref HEAD $B &&
+		git push origin \
+			HEAD:refs/for/maint/my/topic \
+			HEAD:refs/for/a/b/c/my/topic
+	) >out 2>&1 &&
+	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
+	cat >expect <<-EOF &&
+	remote: execute: pre-receive hook
+	remote: >> old: $ZERO_OID, new: $B, ref: refs/for/maint/my/topic.
+	remote: >> old: $ZERO_OID, new: $B, ref: refs/for/a/b/c/my/topic.
+	remote: execute: proc-receive hook
+	remote: >> old: $ZERO_OID, new: $B, ref: refs/for/maint/my/topic.
+	remote: >> old: $ZERO_OID, new: $B, ref: refs/for/a/b/c/my/topic.
+	remote: execute: post-receive hook
+	remote: >> old: $ZERO_OID, new: $B, ref: refs/for/maint/my/topic.
+	remote: >> old: $ZERO_OID, new: $B, ref: refs/for/a/b/c/my/topic.
+	EOF
+	test_cmp expect actual &&
+	(
+		cd $bare &&
+		git show-ref
+	) >actual &&
+	cat >expect <<-EOF &&
+	$A refs/heads/a/b/c
+	$A refs/heads/maint
+	$A refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "(5) new pre-receive hook hook (return error)" '
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
+
+	printf >&2 ">> ERROR: declined in pre-receive hook\n"
+	exit 1
+	EOF
+	chmod a+x $bare/hooks/pre-receive
+'
+
+test_expect_success "(5) push two special references (declined)" '
+	(
+		cd work &&
+		test_must_fail git push origin \
+			HEAD:refs/for/master/my/topic \
+			HEAD:refs/for/maint/my/topic
+	) >out 2>&1 &&
+	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
+	cat >expect <<-EOF &&
+	remote: execute: pre-receive hook
+	remote: >> old: $ZERO_OID, new: $B, ref: refs/for/master/my/topic.
+	remote: >> old: $ZERO_OID, new: $B, ref: refs/for/maint/my/topic.
+	remote: >> ERROR: declined in pre-receive hook
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "(5) push both a normal and a special refs (declined)" '
+	(
+		cd work &&
+		test_must_fail git push origin \
+			HEAD:refs/for/master/my/topic \
+			HEAD:refs/heads/master
+	) >out 2>&1 &&
+	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
+	cat >expect <<-EOF &&
+	remote: execute: pre-receive hook
+	remote: >> old: $A, new: $B, ref: refs/heads/master.
+	remote: >> old: $ZERO_OID, new: $B, ref: refs/for/master/my/topic.
+	remote: >> ERROR: declined in pre-receive hook
+	EOF
+	test_cmp expect actual
+'
+
+test_done
-- 
2.26.0.rc0.5.gb02b988a14.dirty

