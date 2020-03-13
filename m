Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF29C2BB1D
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 12:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6461220746
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 12:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbFQtU7q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgCMMXl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Mar 2020 08:23:41 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:55048 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgCMMXl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Mar 2020 08:23:41 -0400
Received: by mail-pj1-f66.google.com with SMTP id np16so4082831pjb.4
        for <git@vger.kernel.org>; Fri, 13 Mar 2020 05:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wd7nI0zYG7imupVlmf/R4x1VUVB/7pnY6pJzCqnzgrw=;
        b=SbFQtU7qKgYG7OJ6ZSHLhphRaOjYL+zvd5r/5r9GPntHXb4oinL3qUh+tj2LU0YOTH
         5PjGIU6cULNlwnwlkTG3cFsTM3NcIxsInrhah22v12hR0wFhqpwser8Yn789rcYBdLWP
         /X7LX1i9fDrb9WPMyqqyw1ovZ/KmCGHsi8lnrILbaNGoPrYCR4nlSvb349JNO/vgcBZ7
         cNoRx3LzH+p2sduK+Y7OTYg0C2iJVzBbgtZcL33fUaGzMgl8o0bCboXEbiQMLSjAz6c+
         YcIG8XVrIF48EpleOT3Cn2DAj6yz5neDc2rWcohxt/RyI+q4UJ/RHRUlGDKSKLZIFmQh
         dFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wd7nI0zYG7imupVlmf/R4x1VUVB/7pnY6pJzCqnzgrw=;
        b=fbI0SsuOSztc8iu8QIBp2sXhfeVHTE63PZqPDorpzat6QzN+bwml2kV3M0O9AmG+u2
         WuqwIlIo5+mzXBt1161i2t8949mmZzi5A5ovrjfKTHbP6duiquh53VgHT2IRqlrm84k8
         /K6way3eW/TCftRLlOSxkZ5oEMKNX+J45aMD7GsxHO7SdsAFP00zoxOlMNoSF8FXFjrD
         D9knEHm4lbiqeKX8INEX8JrvPenCeeMoO0jnUT3pKGtdOpIjNyKuyMQk+Isqdv6U9Elk
         mvBPY2eEVWK2VvEw9YR0OBJv4v0np/GPg+cTzpzApCBcdVjram4D0pijYLuU+F8upx+E
         5zpw==
X-Gm-Message-State: ANhLgQ1hli3OBPMpgf+f7A0ndAsxgH6/yi+qIwD3zLKIXUKDc4CnjE5B
        V3AEJYVi1uS20gAI2J5mRqM=
X-Google-Smtp-Source: ADFU+vsTtXBMbV2LPWlMH0M3MbfFFxIie7tdPP5O61eHWZuDejw9hnjBfcVaB8Iilh6W5ZSzVvhU4A==
X-Received: by 2002:a17:902:a701:: with SMTP id w1mr11887960plq.165.1584102219804;
        Fri, 13 Mar 2020 05:23:39 -0700 (PDT)
Received: from localhost.localdomain ([47.89.83.4])
        by smtp.gmail.com with ESMTPSA id 134sm5346690pfy.27.2020.03.13.05.23.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2020 05:23:39 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
X-Google-Original-From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v3 1/4] receive-pack: add new proc-receive hook
Date:   Fri, 13 Mar 2020 20:23:15 +0800
Message-Id: <20200313122318.78000-2-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.26.0.rc1.5.gca1e965b06
In-Reply-To: <CANYiYbHvqLX_OozgAXJ8MbuLipqUdj4CpbExe0oiCcyUyb=Osw@mail.gmail.com>
References: <CANYiYbHvqLX_OozgAXJ8MbuLipqUdj4CpbExe0oiCcyUyb=Osw@mail.gmail.com>
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

This "proc-receive" hook reads commands, push-options (optional), and
send result using a protocol in pkt-line format.  In the following
example, The letter "S" stands for "receive-pack" and letter "H" stands
for the hook.

    S: PKT-LINE(version=1\0push-options ...)
    S: flush-pkt

    H: PKT-LINE(version=1\0push-options ...)
    H: flush-pkt

    S: PKT-LINE(old-oid new-oid ref)
    S: ... ...
    S: flush-pkt

    # Optional, only if push-options is negotiated.
    S: PKT-LINE(push-option)
    S: ... ...
    S: flush-pkt

    # OK, run this command successfully.
    H: PKT-LINE(old-oid new-oid ref ok)

    # NO, I reject it.
    H: PKT-LINE(old-oid new-oid ref ng reason)

    # OK, but use an alternate reference. (in latter commit)
    H: PKT-LINE(old-oid new-oid ref ok ref:alt-ref)

    # It will fallthrough to receive-pack to execute. (in latter commit)
    H: PKT-LINE(old-oid new-oid ref ft)

    H: ... ...
    H: flush-pkt

After receiving a command, the hook can create/update another alternate
reference.  For example, a command for a reference "refs/for/master" may
create a special reference, such as "refs/pull/123/head".  The alternate
reference can be returned from the result in an extensible format like
"<old-oid> <new-oid> <reference> <status> [<message>]".

The result will be stored in a command list, and "receive-pack" will use
the result to replace the commands that have specific `have_special_ref`
field turned on.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 builtin/receive-pack.c | 244 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 239 insertions(+), 5 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 2cc18bbffd..8cda2b9cf7 100644
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
@@ -817,6 +818,209 @@ static int run_update_hook(struct command *cmd)
 	return finish_command(&proc);
 }
 
+static int read_proc_receive_result(struct packet_reader *reader,
+				    struct command **commands)
+{
+	struct command **tail = commands;
+	int code = 0;
+
+	for (;;) {
+		struct object_id old_oid, new_oid;
+		struct command *cmd;
+		const char *refname;
+		const char *p;
+		char *status;
+		char *msg = NULL;
+
+		if (packet_reader_read(reader) != PACKET_READ_NORMAL) {
+			break;
+		}
+
+		if (parse_oid_hex(reader->line, &old_oid, &p) ||
+		    *p++ != ' ' ||
+		    parse_oid_hex(p, &new_oid, &p) ||
+		    *p++ != ' ')
+			die("protocol error: proc-receive expected 'old new ref status [msg]', got '%s'",
+			    reader->line);
+
+		refname = p;
+		status = strchr(p, ' ');
+		if (!status)
+			die("protocol error: proc-receive expected 'old new ref status [msg]', got '%s'",
+			    reader->line);
+		*status++ = '\0';
+
+		FLEX_ALLOC_MEM(cmd, ref_name, refname, strlen(refname));
+		oidcpy(&cmd->old_oid, &old_oid);
+		oidcpy(&cmd->new_oid, &new_oid);
+		cmd->have_special_ref = 1;
+
+		if (strlen(status) > 2 && *(status + 2) == ' ') {
+			msg = status + 2;
+			*msg++ = '\0';
+		}
+		if (strlen(status) != 2)
+			die("protocol error: proc-receive has bad status '%s' for '%s'",
+			    status, reader->line);
+		if (!strcmp(status, "ng")) {
+			if (msg)
+				cmd->error_string = xstrdup(msg);
+			else
+				cmd->error_string = "failed";
+			code = 1;
+		} else if (strcmp("ok", status)) {
+			rp_warning("unknown proc-receive status '%s' for '%s'",
+				   status, reader->line);
+			cmd->error_string = "bad status";
+			code = 1;
+		}
+
+		*tail = cmd;
+		tail = &cmd->next;
+	}
+	return code;
+}
+
+static int run_proc_receive_hook(struct command **commands,
+				 const struct string_list *push_options)
+{
+	struct child_process proc = CHILD_PROCESS_INIT;
+	struct async muxer;
+	struct command *result_commands = NULL;
+	struct command *cmd;
+	const char *argv[2];
+	struct packet_reader reader;
+	int pr_use_push_options = 0;
+	int version = 0;
+	int code;
+
+	argv[0] = find_hook("proc-receive");
+	if (!argv[0]) {
+		rp_error("cannot to find hook 'proc-receive'");
+		return 1;
+	}
+	argv[1] = NULL;
+
+	proc.argv = argv;
+	proc.in = -1;
+	proc.out = -1;
+	proc.trace2_hook_name = "proc-receive";
+
+	if (use_sideband) {
+		memset(&muxer, 0, sizeof(muxer));
+		muxer.proc = copy_to_sideband;
+		muxer.in = -1;
+		code = start_async(&muxer);
+		if (code)
+			return code;
+		proc.err = muxer.in;
+	} else {
+		proc.err = 0;
+	}
+
+	code = start_command(&proc);
+	if (code) {
+		if (use_sideband)
+			finish_async(&muxer);
+		return code;
+	}
+
+	sigchain_push(SIGPIPE, SIG_IGN);
+
+	/* Version negotiaton */
+	packet_reader_init(&reader, proc.out, NULL, 0,
+			   PACKET_READ_CHOMP_NEWLINE |
+			   PACKET_READ_DIE_ON_ERR_PACKET);
+	packet_write_fmt(proc.in, "version=1%c%s\n",
+			 '\0',
+			 use_push_options ? "push-options": "");
+	for (;;) {
+		int linelen;
+
+		if (packet_reader_read(&reader) != PACKET_READ_NORMAL)
+			break;
+
+		if (reader.pktlen > 8 && starts_with(reader.line, "version=")) {
+			version = atoi(reader.line+8);
+			linelen = strlen(reader.line);
+			if (linelen < reader.pktlen) {
+				const char *feature_list = reader.line + linelen + 1;
+				if (parse_feature_request(feature_list, "push-options"))
+					pr_use_push_options = 1;
+			}
+		}
+	}
+
+	if (version != 1)
+		die("protocol error: unknown proc-receive version '%d'", version);
+
+	/* Send commands */
+	for (cmd = *commands; cmd; cmd = cmd->next) {
+		char *old_hex, *new_hex;
+
+		if (!cmd->have_special_ref || cmd->skip_update ||
+		    cmd->did_not_exist || cmd->error_string)
+			continue;
+
+		old_hex = oid_to_hex(&cmd->old_oid);
+		new_hex = oid_to_hex(&cmd->new_oid);
+
+		packet_write_fmt(proc.in, "%s %s %s",
+				 old_hex, new_hex, cmd->ref_name);
+	}
+	packet_flush(proc.in);
+
+	/* Send push options */
+	if (pr_use_push_options) {
+		struct string_list_item *item;
+
+		for_each_string_list_item(item, push_options)
+			packet_write_fmt(proc.in, "%s", item->string);
+
+		packet_flush(proc.in);
+	}
+
+	/* Read result from proc-receive */
+	code = read_proc_receive_result(&reader, &result_commands);
+	close(proc.in);
+	close(proc.out);
+	if (finish_command(&proc))
+		die("proc-receive did not exit properly");
+
+	/* After receiving the result from the "proc-receive" hook,
+	 * "receive-pack" will use the result to replace commands that
+	 * have specific `have_special_ref` field.
+	 */
+	for (cmd = *commands; cmd; cmd = cmd->next)
+		if (!cmd->have_special_ref)
+			break;
+
+	if (!cmd || cmd->have_special_ref) {
+		cmd = result_commands;
+	} else {
+		struct command *tail = cmd;
+		for (;;) {
+			if (!tail->next)
+			       break;
+			else if (tail->next->have_special_ref)
+				tail->next = tail->next->next;
+			else
+				tail = tail->next;
+		}
+		tail->next = result_commands;
+	}
+	*commands = cmd;
+
+	// TODO: sort commands or not?
+
+	if (use_sideband)
+		finish_async(&muxer);
+
+	sigchain_pop(SIGPIPE);
+
+	return code;
+}
+
 static char *refuse_unconfigured_deny_msg =
 	N_("By default, updating the current branch in a non-bare repository\n"
 	   "is denied, because it will make the index and work tree inconsistent\n"
@@ -1392,7 +1596,7 @@ static void execute_commands_non_atomic(struct command *commands,
 	struct strbuf err = STRBUF_INIT;
 
 	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (!should_process_cmd(cmd))
+		if (!should_process_cmd(cmd) || cmd->have_special_ref)
 			continue;
 
 		transaction = ref_transaction_begin(&err);
@@ -1432,7 +1636,7 @@ static void execute_commands_atomic(struct command *commands,
 	}
 
 	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (!should_process_cmd(cmd))
+		if (!should_process_cmd(cmd) || cmd->have_special_ref)
 			continue;
 
 		cmd->error_string = update(cmd, si);
@@ -1458,16 +1662,19 @@ static void execute_commands_atomic(struct command *commands,
 	strbuf_release(&err);
 }
 
-static void execute_commands(struct command *commands,
+static void execute_commands(struct command **orig_commands,
 			     const char *unpacker_error,
 			     struct shallow_info *si,
 			     const struct string_list *push_options)
 {
+	struct command *commands = *orig_commands;
 	struct check_connected_options opt = CHECK_CONNECTED_INIT;
 	struct command *cmd;
 	struct iterate_data data;
 	struct async muxer;
 	int err_fd = 0;
+	int have_special_ref = 0;
+	int have_normal_ref = 0;
 
 	if (unpacker_error) {
 		for (cmd = commands; cmd; cmd = cmd->next)
@@ -1497,6 +1704,22 @@ static void execute_commands(struct command *commands,
 
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
@@ -1523,6 +1746,17 @@ static void execute_commands(struct command *commands,
 	free(head_name_to_free);
 	head_name = head_name_to_free = resolve_refdup("HEAD", 0, NULL, NULL);
 
+	if (have_special_ref) {
+		if (run_proc_receive_hook(orig_commands, push_options)) {
+			for (cmd = commands; cmd; cmd = cmd->next) {
+				if (!cmd->error_string  && (cmd->have_special_ref || use_atomic))
+					cmd->error_string = "fail to run proc-receive hook";
+			}
+		} else {
+			commands = *orig_commands;
+		}
+	}
+
 	if (use_atomic)
 		execute_commands_atomic(commands, si);
 	else
@@ -2019,7 +2253,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 			update_shallow_info(commands, &si, &ref);
 		}
 		use_keepalive = KEEPALIVE_ALWAYS;
-		execute_commands(commands, unpack_status, &si,
+		execute_commands(&commands, unpack_status, &si,
 				 &push_options);
 		if (pack_lockfile)
 			unlink_or_warn(pack_lockfile);
-- 
2.26.0.rc1.5.gca1e965b06

