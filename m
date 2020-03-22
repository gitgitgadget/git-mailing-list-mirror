Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456F9C54FD0
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 13:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0821220732
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 13:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEpjjNXK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgCVNSa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 09:18:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44953 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgCVNSa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 09:18:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id 142so477531pgf.11
        for <git@vger.kernel.org>; Sun, 22 Mar 2020 06:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=01w8KPiHkG2SsbnEMti1/FXC1MagSaV8mXqqk9txZhI=;
        b=aEpjjNXKoC+0ox4Wc+MQNIHwuH/fXICRC3g4Wv19/uxumkk0w7DThFJS8rz6GLAugm
         Q7JMXOg55kK6CU5oYXfjkBGaUB0AKaMKAAxBg9xPoRwDXmsc/KXz4JURuqSfd0FhV4dA
         GfCWqGjfNcF7fvP+7CSSHQOAAEExpyKG7Wy1Q/VieiRHlyMlr+Do8As5v7BrQlOGMtab
         T9c/nGQ6HW+V0veSIoVtWiFtsq781OjtfNNHUbO5LIseHCfMkdoOfkRTWSIfMe2FDQj/
         dcy2moELOQ/mEm6YLbZEvM2BosggO37zZmOeUR+oojBv4c1wYCrmB74bJNh6OiIC989t
         sKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=01w8KPiHkG2SsbnEMti1/FXC1MagSaV8mXqqk9txZhI=;
        b=uba4IvEeOYTRJghrXnglT5lXqzzCYJyVbpXMFNVqoyvW50TGEx1ulOb3+GcVFi+yey
         bRzjaGnVZeunc2ia8itNzWhesQtt879ZdmStrnWjpX03LjcyjLBK19X4vYwa9PZIA5La
         kaITATEeJp2/ycTPEKMyn5seKyqdZOvsPjJ+lLOVaBPO9RAGeVoF/Tz59MfmdzyZZIUP
         cvmp/oONiX1jbvOZKYFulOYTLXuw8oHpGbXAfh26fzlbi6OO+XMqtjKDpP5ErxXrP/ea
         a22EoAbO2N+r5e5ihkZNg9HUrEdTNlycrg8rnfoDlMcjTHpr/akuzbDb2XP/5Ce70s3b
         ZtKw==
X-Gm-Message-State: ANhLgQ2kCLkAgFRQUgJ39W1KPxZh2XftXB3MdJOpM1b2WDu8kgE431cp
        NYq4zkRKwdz09tonPalnYtw=
X-Google-Smtp-Source: ADFU+vvR13MWnNSggv3nkb7mu7heeDeVjFBc7/KTrMk+IAGcSMhz4J5EjyZGQ0WUM1o3FIJtwnXziQ==
X-Received: by 2002:a65:4d48:: with SMTP id j8mr10311474pgt.144.1584883107429;
        Sun, 22 Mar 2020 06:18:27 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id nh4sm9456432pjb.39.2020.03.22.06.18.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Mar 2020 06:18:26 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v4 2/5] receive-pack: add new proc-receive hook
Date:   Sun, 22 Mar 2020 09:18:12 -0400
Message-Id: <20200322131815.11872-3-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200313122318.78000-1-zhiyou.jx@alibaba-inc.com>
References: <20200313122318.78000-1-zhiyou.jx@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

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
field (`run_proc_receive`) on for the command.  Commands with this filed
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
the result to replace the commands that have specific `run_proc_receive`
field turned on.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 Makefile                     |   1 +
 builtin/receive-pack.c       | 275 +++++++++++++++++-
 t/helper/test-proc-receive.c | 164 +++++++++++
 t/helper/test-tool.c         |   1 +
 t/helper/test-tool.h         |   1 +
 t/t5411-proc-receive-hook.sh | 528 +++++++++++++++++++++++++++++++++++
 6 files changed, 965 insertions(+), 5 deletions(-)
 create mode 100644 t/helper/test-proc-receive.c

diff --git a/Makefile b/Makefile
index 9804a0758b..0a08a0504e 100644
--- a/Makefile
+++ b/Makefile
@@ -725,6 +725,7 @@ TEST_BUILTINS_OBJS += test-parse-pathspec-file.o
 TEST_BUILTINS_OBJS += test-path-utils.o
 TEST_BUILTINS_OBJS += test-pkt-line.o
 TEST_BUILTINS_OBJS += test-prio-queue.o
+TEST_BUILTINS_OBJS += test-proc-receive.o
 TEST_BUILTINS_OBJS += test-progress.o
 TEST_BUILTINS_OBJS += test-reach.o
 TEST_BUILTINS_OBJS += test-read-cache.o
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 2cc18bbffd..0aca08eb65 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -312,7 +312,8 @@ struct command {
 	struct command *next;
 	const char *error_string;
 	unsigned int skip_update:1,
-		     did_not_exist:1;
+		     did_not_exist:1,
+		     run_proc_receive:1;
 	int index;
 	struct object_id old_oid;
 	struct object_id new_oid;
@@ -817,6 +818,241 @@ static int run_update_hook(struct command *cmd)
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
+		if (strlen(status) > 2 && *(status + 2) == ' ') {
+			msg = status + 2;
+			*msg++ = '\0';
+		}
+		if (strlen(status) != 2)
+			die("protocol error: proc-receive has bad status '%s' for '%s'",
+			    status, reader->line);
+
+		FLEX_ALLOC_MEM(cmd, ref_name, refname, strlen(refname));
+		oidcpy(&cmd->old_oid, &old_oid);
+		oidcpy(&cmd->new_oid, &new_oid);
+		cmd->run_proc_receive = 1;
+
+		if (!strcmp(status, "ng")) {
+			if (msg)
+				cmd->error_string = xstrdup(msg);
+			else
+				cmd->error_string = "failed";
+			code = 1;
+		} else if (strcmp("ok", status)) {
+			die("protocol error: proc-receive has bad status '%s' for '%s'",
+			    status, reader->line);
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
+	struct strbuf cap = STRBUF_INIT;
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
+	if (use_push_options)
+		strbuf_addstr(&cap, " push-options");
+	if (use_atomic)
+		strbuf_addstr(&cap, " atomic");
+	if (cap.len) {
+		packet_write_fmt(proc.in, "version=1%c%s\n", '\0', cap.buf + 1);
+		strbuf_release(&cap);
+	} else {
+		packet_write_fmt(proc.in, "version=1\n");
+	}
+	packet_flush(proc.in);
+
+	for (;;) {
+		int linelen;
+
+		if (packet_reader_read(&reader) != PACKET_READ_NORMAL)
+			break;
+
+		if (reader.pktlen > 8 && starts_with(reader.line, "version=")) {
+			version = atoi(reader.line + 8);
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
+		if (!cmd->run_proc_receive || cmd->skip_update || cmd->error_string)
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
+	if (use_sideband)
+		finish_async(&muxer);
+	if (finish_command(&proc))
+		die("proc-receive did not exit properly");
+
+	sigchain_pop(SIGPIPE);
+
+	/* After receiving the result from the "proc-receive" hook,
+	 * "receive-pack" will use the result to replace commands that
+	 * have specific `run_proc_receive` field.
+	 */
+	for (cmd = *commands; cmd; cmd = cmd->next)
+		if (!cmd->run_proc_receive)
+			break;
+
+	/* Merge commands with result_commands and sort */
+	if (!cmd) {
+		*commands = result_commands;
+	} else {
+		struct command *next_cmd = cmd;
+		struct command *next_result = result_commands;
+		struct command *head = NULL;
+		struct command *tail = NULL;
+
+		if (!next_result ||
+		    strcmp(next_cmd->ref_name, next_result->ref_name) < 0) {
+			head = next_cmd;
+			next_cmd = next_cmd->next;
+		} else {
+			head = next_result;
+			next_result = next_result->next;
+		}
+		tail = head;
+
+		for (;;) {
+			if (!next_cmd) {
+				tail->next = next_result;
+				break;
+			} else if (next_cmd->run_proc_receive) {
+				next_cmd = next_cmd->next;
+			} else if (!next_result) {
+				tail->next = next_cmd;
+				next_cmd = next_cmd->next;
+				tail = tail->next;
+			} else {
+				if (strcmp(next_cmd->ref_name, next_result->ref_name) < 0) {
+					tail->next = next_cmd;
+					next_cmd = next_cmd->next;
+					tail = tail->next;
+				} else {
+					tail->next = next_result;
+					next_result = next_result->next;
+					tail = tail->next;
+				}
+			}
+		}
+		*commands = head;
+	}
+
+	return code;
+}
+
 static char *refuse_unconfigured_deny_msg =
 	N_("By default, updating the current branch in a non-bare repository\n"
 	   "is denied, because it will make the index and work tree inconsistent\n"
@@ -1392,7 +1628,7 @@ static void execute_commands_non_atomic(struct command *commands,
 	struct strbuf err = STRBUF_INIT;
 
 	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (!should_process_cmd(cmd))
+		if (!should_process_cmd(cmd) || cmd->run_proc_receive)
 			continue;
 
 		transaction = ref_transaction_begin(&err);
@@ -1432,7 +1668,7 @@ static void execute_commands_atomic(struct command *commands,
 	}
 
 	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (!should_process_cmd(cmd))
+		if (!should_process_cmd(cmd) || cmd->run_proc_receive)
 			continue;
 
 		cmd->error_string = update(cmd, si);
@@ -1458,16 +1694,18 @@ static void execute_commands_atomic(struct command *commands,
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
+	int run_proc_receive = 0;
 
 	if (unpacker_error) {
 		for (cmd = commands; cmd; cmd = cmd->next)
@@ -1497,6 +1735,20 @@ static void execute_commands(struct command *commands,
 
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
+			cmd->run_proc_receive = 1;
+			run_proc_receive = 1;
+		}
+	}
+
 	if (run_receive_hook(commands, "pre-receive", 0, push_options)) {
 		for (cmd = commands; cmd; cmd = cmd->next) {
 			if (!cmd->error_string)
@@ -1523,6 +1775,19 @@ static void execute_commands(struct command *commands,
 	free(head_name_to_free);
 	head_name = head_name_to_free = resolve_refdup("HEAD", 0, NULL, NULL);
 
+	if (run_proc_receive) {
+		int code;
+
+		code = run_proc_receive_hook(orig_commands, push_options);
+		commands = *orig_commands;
+		if (code) {
+			for (cmd = commands; cmd; cmd = cmd->next) {
+				if (!cmd->error_string  && (cmd->run_proc_receive || use_atomic))
+					cmd->error_string = "fail to run proc-receive hook";
+			}
+		}
+	}
+
 	if (use_atomic)
 		execute_commands_atomic(commands, si);
 	else
@@ -2019,7 +2284,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 			update_shallow_info(commands, &si, &ref);
 		}
 		use_keepalive = KEEPALIVE_ALWAYS;
-		execute_commands(commands, unpack_status, &si,
+		execute_commands(&commands, unpack_status, &si,
 				 &push_options);
 		if (pack_lockfile)
 			unlink_or_warn(pack_lockfile);
diff --git a/t/helper/test-proc-receive.c b/t/helper/test-proc-receive.c
new file mode 100644
index 0000000000..e725cf9713
--- /dev/null
+++ b/t/helper/test-proc-receive.c
@@ -0,0 +1,164 @@
+#include "cache.h"
+#include "connect.h"
+#include "parse-options.h"
+#include "pkt-line.h"
+#include "string-list.h"
+#include "test-tool.h"
+
+static const char *proc_receive_usage[] = {
+	"test-tool proc-receive [<options>...]",
+	NULL
+};
+
+static int version = 1;
+static int verbose = 0;
+static int no_push_options = 0;
+static int use_push_options = 0;
+static struct string_list returns = STRING_LIST_INIT_NODUP;
+
+struct command {
+	struct command *next;
+	const char *error_string;
+	unsigned int skip_update:1,
+		     did_not_exist:1;
+	int index;
+	struct object_id old_oid;
+	struct object_id new_oid;
+	char ref_name[FLEX_ARRAY]; /* more */
+};
+
+static void proc_receive_verison(struct packet_reader *reader) {
+	int server_version = 0;
+
+	for (;;) {
+		int linelen;
+
+		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
+			break;
+
+		if (reader->pktlen > 8 && starts_with(reader->line, "version=")) {
+			server_version = atoi(reader->line+8);
+			linelen = strlen(reader->line);
+			if (linelen < reader->pktlen) {
+				const char *feature_list = reader->line + linelen + 1;
+				if (parse_feature_request(feature_list, "push-options"))
+					use_push_options = 1;
+			}
+		}
+	}
+
+	if (server_version != 1)
+		die("bad protocol version: %d", server_version);
+
+	packet_write_fmt(1, "version=%d%c%s\n",
+			 version, '\0',
+			 use_push_options && !no_push_options ? "push-options": "");
+	packet_flush(1);
+}
+
+static void proc_receive_read_commands(struct packet_reader *reader,
+				       struct command **commands)
+{
+	struct command **tail = commands;
+
+	for (;;) {
+		struct object_id old_oid, new_oid;
+		struct command *cmd;
+		const char *refname;
+		const char *p;
+
+		if (packet_reader_read(reader) != PACKET_READ_NORMAL) {
+			break;
+		}
+
+		if (parse_oid_hex(reader->line, &old_oid, &p) ||
+		    *p++ != ' ' ||
+		    parse_oid_hex(p, &new_oid, &p) ||
+		    *p++ != ' ')
+			die("protocol error: expected 'old new ref', got '%s'",
+			    reader->line);
+		refname = p;
+		FLEX_ALLOC_MEM(cmd, ref_name, refname, strlen(refname));
+		oidcpy(&cmd->old_oid, &old_oid);
+		oidcpy(&cmd->new_oid, &new_oid);
+
+		*tail = cmd;
+		tail = &cmd->next;
+	}
+}
+
+static void proc_receive_read_push_options(struct packet_reader *reader,
+					   struct string_list *options)
+{
+
+	if (no_push_options || !use_push_options)
+	       return;
+
+	while (1) {
+		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
+			break;
+
+		string_list_append(options, reader->line);
+	}
+}
+
+int cmd__proc_receive(int argc, const char **argv)
+{
+	struct packet_reader reader;
+	struct command *commands;
+	struct string_list push_options = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
+	struct option options[] = {
+		OPT_BOOL(0, "no-push-options", &no_push_options,
+			 "disable push options"),
+		OPT_STRING_LIST('r', "return", &returns, "old/new/ref/status/msg",
+				"return of results"),
+		OPT__VERBOSE(&verbose, "be verbose"),
+		OPT_INTEGER('V', "version", &version,
+			    "use this protocol version number"),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, "test-tools", options, proc_receive_usage, 0);
+	if (argc > 0)
+		usage_msg_opt("Too many arguments.", proc_receive_usage, options);
+
+	packet_reader_init(&reader, 0, NULL, 0,
+			   PACKET_READ_CHOMP_NEWLINE |
+			   PACKET_READ_DIE_ON_ERR_PACKET);
+
+	proc_receive_verison(&reader);
+	proc_receive_read_commands(&reader, &commands);
+	proc_receive_read_push_options(&reader, &push_options);
+
+	if (verbose) {
+		struct command *cmd;
+
+		for (cmd = commands; cmd; cmd = cmd->next) {
+			char *old_hex, *new_hex;
+
+			old_hex = oid_to_hex(&cmd->old_oid);
+			new_hex = oid_to_hex(&cmd->new_oid);
+			fprintf(stderr, "proc-receive< %s %s %s\n",
+				old_hex, new_hex, cmd->ref_name);
+		}
+
+		if (push_options.nr > 0) {
+			for_each_string_list_item(item, &push_options)
+				fprintf(stderr, "proc-receive< %s\n", item->string);
+		}
+
+		if (returns.nr) {
+			for_each_string_list_item(item, &returns)
+				fprintf(stderr, "proc-receive> %s\n", item->string);
+		}
+	}
+
+	if (returns.nr) {
+		for_each_string_list_item(item, &returns)
+			packet_write_fmt(1, "%s\n", item->string);
+	}
+	packet_flush(1);
+
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index c9a232d238..9bff461446 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -43,6 +43,7 @@ static struct test_cmd cmds[] = {
 	{ "path-utils", cmd__path_utils },
 	{ "pkt-line", cmd__pkt_line },
 	{ "prio-queue", cmd__prio_queue },
+	{ "proc-receive", cmd__proc_receive},
 	{ "progress", cmd__progress },
 	{ "reach", cmd__reach },
 	{ "read-cache", cmd__read_cache },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index c8549fd87f..71e5f1c372 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -33,6 +33,7 @@ int cmd__parse_pathspec_file(int argc, const char** argv);
 int cmd__path_utils(int argc, const char **argv);
 int cmd__pkt_line(int argc, const char **argv);
 int cmd__prio_queue(int argc, const char **argv);
+int cmd__proc_receive(int argc, const char **argv);
 int cmd__progress(int argc, const char **argv);
 int cmd__reach(int argc, const char **argv);
 int cmd__read_cache(int argc, const char **argv);
diff --git a/t/t5411-proc-receive-hook.sh b/t/t5411-proc-receive-hook.sh
index fe2861f2e6..d114559792 100755
--- a/t/t5411-proc-receive-hook.sh
+++ b/t/t5411-proc-receive-hook.sh
@@ -50,6 +50,24 @@ format_git_output () {
 		-e "s/'/\"/g"
 }
 
+# Asynchronous sideband may generate inconsistent output messages,
+# sort before comparison.
+test_sorted_cmp () {
+	if ! $GIT_TEST_CMP "$@"
+	then
+		cmd=$GIT_TEST_CMP
+		for f in "$@"
+		do
+			sort "$f" >"$f.sorted"
+			cmd="$cmd \"$f.sorted\""
+		done
+		if ! eval $cmd
+		then
+			$GIT_TEST_CMP "$@"
+		fi
+	fi
+}
+
 test_expect_success "setup" '
 	git init --bare upstream &&
 	git init workbench &&
@@ -141,4 +159,514 @@ test_expect_success "normal git-push command" '
 	test_cmp expect actual
 '
 
+test_expect_success "cleanup" '
+	(
+		cd upstream &&
+		git update-ref -d refs/review/master/topic &&
+		git update-ref -d refs/tags/v1.0.0 &&
+		git update-ref -d refs/heads/a/b/c
+	)
+'
+
+test_expect_success "no proc-receive hook, fail to push special ref" '
+	(
+		cd workbench &&
+		test_must_fail git push origin \
+			HEAD:next \
+			HEAD:refs/for/master/topic
+	) >out 2>&1 &&
+	format_git_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: error: cannot to find hook "proc-receive"
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
+	To ../upstream
+	 * [new branch]      HEAD -> next
+	 ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
+	error: failed to push some refs to "../upstream"
+	EOF
+	test_cmp expect actual &&
+	(
+		cd upstream &&
+		git show-ref
+	) >out &&
+	format_git_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/next
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "cleanup" '
+	(
+		cd upstream &&
+		git update-ref -d refs/heads/next
+	)
+'
+
+# TODO: report for the failure of master branch is unnecessary.
+test_expect_success "no proc-receive hook, fail all for atomic push" '
+	(
+		cd workbench &&
+		test_must_fail git push --atomic origin \
+			HEAD:next \
+			HEAD:refs/for/master/topic
+	) >out 2>&1 &&
+	format_git_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: error: cannot to find hook "proc-receive"
+	To ../upstream
+	 ! [rejected]        master (atomic push failed)
+	 ! [remote rejected] HEAD -> next (fail to run proc-receive hook)
+	 ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
+	error: failed to push some refs to "../upstream"
+	EOF
+	test_cmp expect actual &&
+	(
+		cd upstream &&
+		git show-ref
+	) >out &&
+	format_git_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (bad version)" '
+	cat >upstream/hooks/proc-receive <<-EOF &&
+	#!/bin/sh
+
+	printf >&2 "# proc-receive hook\n"
+
+	test-tool proc-receive -v --version 2
+	EOF
+	chmod a+x upstream/hooks/proc-receive
+'
+
+test_expect_success "proc-receive bad protocol: unknown version" '
+	(
+		cd workbench &&
+		test_must_fail git push origin \
+			HEAD:refs/for/master/topic
+	) >out 2>&1 &&
+	format_git_output <out | grep "protocol error" >actual &&
+	cat >expect <<-EOF &&
+	fatal: protocol error: unknown proc-receive version "2"
+	EOF
+	test_cmp expect actual &&
+	(
+		cd upstream &&
+		git show-ref
+	) >out &&
+	format_git_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (no report)" '
+	cat >upstream/hooks/proc-receive <<-EOF
+	#!/bin/sh
+
+	printf >&2 "# proc-receive hook\n"
+
+	test-tool proc-receive -v
+	EOF
+'
+
+test_expect_success "proc-receive bad protocol: no report" '
+	(
+		cd workbench &&
+		test_must_fail git push origin \
+			HEAD:refs/for/master/topic
+	) >out 2>&1 &&
+	format_git_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	To ../upstream
+	 ! [remote failure]  HEAD -> refs/for/master/topic (remote failed to report status)
+	error: failed to push some refs to "../upstream"
+	EOF
+	test_cmp expect actual &&
+	(
+		cd upstream &&
+		git show-ref
+	) >out &&
+	format_git_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (bad oid)" '
+	cat >upstream/hooks/proc-receive <<-EOF
+	#!/bin/sh
+
+	printf >&2 "# proc-receive hook\n"
+
+	test-tool proc-receive -v \
+		-r "bad-id new-id ref ok"
+	EOF
+'
+
+test_expect_success "proc-receive bad protocol: bad oid" '
+	(
+		cd workbench &&
+		test_must_fail git push origin \
+			HEAD:refs/for/master/topic
+	) >out 2>&1 &&
+	format_git_output <out | grep "protocol error" >actual &&
+	cat >expect <<-EOF &&
+	fatal: protocol error: proc-receive expected "old new ref status [msg]", got "bad-id new-id ref ok"
+	EOF
+	test_cmp expect actual &&
+	(
+		cd upstream &&
+		git show-ref
+	) >out &&
+	format_git_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (no status)" '
+	cat >upstream/hooks/proc-receive <<-EOF
+	#!/bin/sh
+
+	printf >&2 "# proc-receive hook\n"
+
+	test-tool proc-receive -v \
+		-r "$ZERO_OID $A refs/for/master/topic"
+	EOF
+'
+
+test_expect_success "proc-receive bad protocol: no status" '
+	(
+		cd workbench &&
+		test_must_fail git push origin \
+			HEAD:refs/for/master/topic
+	) >out 2>&1 &&
+	format_git_output <out | grep "protocol error" >actual &&
+	cat >expect <<-EOF &&
+	fatal: protocol error: proc-receive expected "old new ref status [msg]", got "<ZERO-OID> <COMMIT-A> refs/for/master/topic"
+	EOF
+	test_cmp expect actual &&
+	(
+		cd upstream &&
+		git show-ref
+	) >out &&
+	format_git_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (unknown status)" '
+	cat >upstream/hooks/proc-receive <<-EOF
+	#!/bin/sh
+
+	printf >&2 "# proc-receive hook\n"
+
+	test-tool proc-receive -v \
+		-r "$ZERO_OID $A refs/for/master/topic xx msg"
+	EOF
+'
+
+test_expect_success "proc-receive bad protocol: unknown status" '
+	(
+		cd workbench &&
+		test_must_fail git push origin \
+			HEAD:refs/for/master/topic
+	) >out 2>&1 &&
+	format_git_output <out | grep "protocol error" >actual &&
+	cat >expect <<-EOF &&
+	fatal: protocol error: proc-receive has bad status "xx" for "<ZERO-OID> <COMMIT-A> refs/for/master/topic"
+	EOF
+	test_cmp expect actual &&
+	(
+		cd upstream &&
+		git show-ref
+	) >out &&
+	format_git_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (bad status)" '
+	cat >upstream/hooks/proc-receive <<-EOF
+	#!/bin/sh
+
+	printf >&2 "# proc-receive hook\n"
+
+	test-tool proc-receive -v \
+		-r "$ZERO_OID $A refs/for/master/topic bad status"
+	EOF
+'
+
+test_expect_success "proc-receive bad protocol: bad status" '
+	(
+		cd workbench &&
+		test_must_fail git push origin \
+			HEAD:refs/for/master/topic
+	) >out 2>&1 &&
+	format_git_output <out | grep "protocol error" >actual &&
+	cat >expect <<-EOF &&
+	fatal: protocol error: proc-receive has bad status "bad status" for "<ZERO-OID> <COMMIT-A> refs/for/master/topic"
+	EOF
+	test_cmp expect actual &&
+	(
+		cd upstream &&
+		git show-ref
+	) >out &&
+	format_git_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (ng)" '
+	cat >upstream/hooks/proc-receive <<-EOF
+	#!/bin/sh
+
+	printf >&2 "# proc-receive hook\n"
+
+	test-tool proc-receive -v \
+		-r "$ZERO_OID $A refs/for/master/topic ng"
+	EOF
+'
+
+test_expect_success "proc-receive: fail to update (no message)" '
+	(
+		cd workbench &&
+		test_must_fail git push origin \
+			HEAD:refs/for/master/topic
+	) >out 2>&1 &&
+	format_git_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic ng
+	To ../upstream
+	 ! [remote rejected] HEAD -> refs/for/master/topic (failed)
+	error: failed to push some refs to "../upstream"
+	EOF
+	test_cmp expect actual &&
+	(
+		cd upstream &&
+		git show-ref
+	) >out &&
+	format_git_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (ng message)" '
+	cat >upstream/hooks/proc-receive <<-EOF
+	#!/bin/sh
+
+	printf >&2 "# proc-receive hook\n"
+
+	test-tool proc-receive -v \
+		-r "$ZERO_OID $A refs/for/master/topic ng error msg"
+	EOF
+'
+
+test_expect_success "proc-receive: fail to update (has message)" '
+	(
+		cd workbench &&
+		test_must_fail git push origin \
+			HEAD:refs/for/master/topic
+	) >out 2>&1 &&
+	format_git_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic ng error msg
+	To ../upstream
+	 ! [remote rejected] HEAD -> refs/for/master/topic (error msg)
+	error: failed to push some refs to "../upstream"
+	EOF
+	test_cmp expect actual &&
+	(
+		cd upstream &&
+		git show-ref
+	) >out &&
+	format_git_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (ok)" '
+	cat >upstream/hooks/proc-receive <<-EOF
+	#!/bin/sh
+
+	printf >&2 "# proc-receive hook\n"
+
+	test-tool proc-receive -v \
+		-r "$ZERO_OID $A refs/for/master/topic ok"
+	EOF
+'
+
+test_expect_success "proc-receive: ok" '
+	(
+		cd workbench &&
+		git push origin \
+			HEAD:refs/for/master/topic
+	) >out 2>&1 &&
+	format_git_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic ok
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	To ../upstream
+	 * [new reference]   HEAD -> refs/for/master/topic
+	EOF
+	test_cmp expect actual &&
+	(
+		cd upstream &&
+		git show-ref
+	) >out &&
+	format_git_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "proc-receive: report unknown ref" '
+	(
+		cd workbench &&
+		test_must_fail git push origin \
+			HEAD:refs/for/a/b/c/my/topic
+	) >out 2>&1 &&
+	format_git_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/my/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/my/topic
+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic ok
+	warning: remote reported status on unknown ref: refs/for/master/topic
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	To ../upstream
+	 ! [remote failure]  HEAD -> refs/for/a/b/c/my/topic (remote failed to report status)
+	error: failed to push some refs to "../upstream"
+	EOF
+	test_cmp expect actual &&
+	(
+		cd upstream &&
+		git show-ref
+	) >out &&
+	format_git_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "not support push options" '
+	(
+		cd workbench &&
+		test_must_fail git push \
+			-o issue=123 \
+			-o reviewer=user1 \
+			origin \
+			HEAD:refs/for/master/topic
+	) >out 2>&1 &&
+	format_git_output <out >actual &&
+	cat >expect <<-EOF &&
+	fatal: the receiving end does not support push options
+	fatal: the remote end hung up unexpectedly
+	EOF
+	test_cmp expect actual &&
+	(
+		cd upstream &&
+		git show-ref
+	) >out &&
+	format_git_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "enable push options" '
+	(
+		cd upstream &&
+		git config receive.advertisePushOptions true
+	)
+'
+
+test_expect_success "push with options" '
+	(
+		cd workbench &&
+		git push \
+			-o issue=123 \
+			-o reviewer=user1 \
+			origin \
+			HEAD:refs/heads/next \
+			HEAD:refs/for/master/topic
+	) >out 2>&1 &&
+	format_git_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive< issue=123
+	remote: proc-receive< reviewer=user1
+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic ok
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
+	To ../upstream
+	 * [new branch]      HEAD -> next
+	 * [new reference]   HEAD -> refs/for/master/topic
+	EOF
+	test_cmp expect actual &&
+	(
+		cd upstream &&
+		git show-ref
+	) >out &&
+	format_git_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/next
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.26.0.rc1.33.g4914ba4bcf

