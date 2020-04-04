Return-Path: <SRS0=+7zH=5U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D30C2BA1E
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 13:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA3F1206E9
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 13:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVk49Gwf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgDDNn5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Apr 2020 09:43:57 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33320 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgDDNn5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Apr 2020 09:43:57 -0400
Received: by mail-pl1-f194.google.com with SMTP id ay1so3977148plb.0
        for <git@vger.kernel.org>; Sat, 04 Apr 2020 06:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PhA2eJ07XkkhauRMK/W0MqKTbjSH8PZTRSDwpbZ/na4=;
        b=QVk49GwfedDk9BI0fUmSCMdGchUIXUoB02lay5MzplxDNwuV1sQLz4wdpn6jRsAh+M
         4Ad2UxapOI3lkcIVqmSZZyCVc781C1nNnnVx0ckX5qpu02yvTfR26qNvOiFk8ko40q0F
         J8OvKBptPSpxiN1mjj8pfAQIXKzEwkzZVJmSF5PPljWsW72WGkuOSD2SppHP/liQcMmx
         dFEzbT4Bm8g1Vx2eXSiO3OD0KrNaeIsJmhcelJ8NJ2VAlbfRGj+JF6FO/FSRtpVl3MxE
         eSDMnp+Itd8o4SSRx46d3APBZeXhvP6gt3Bmw3VnXItR21nFAVGJCYCL7ZWULjONpEgl
         Gq/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PhA2eJ07XkkhauRMK/W0MqKTbjSH8PZTRSDwpbZ/na4=;
        b=Ssu0Conl9xYIKMtF9lqVAzIoPWgQvwCamr8+SLGyG+oxwVOboaNZox6Phbf5UYYHvF
         U8pCX2c4bsipB9jHBl9lOqWBKA6fhbVgbeXrLiyw/AfT3MhQS15YQ3dezHEWbSIyWgjz
         owYXwV3wlaBG9o6EJ1gM5dFxYh6sHIlSQhiLMYnx8Ze+tISEmjW8yqIQPvrpn7rF2ZJ5
         pZ8T1dnst90ql/GYWGSD23iRxUcEgrCI9bqymGm+W7p+qFg2NhddAQhaBFHC5WH+XIof
         snGQb2lzjpm4m2lP0JJXDgAOd8rN32Vgxqmmrw2PqqO+og/j9lFgHJE5tT6dBuf4VvO8
         D2Tg==
X-Gm-Message-State: AGi0PuZIozfzFlpAiNjOI1Fm4N/n1Msvk19VVUmJEhS/AchwKY2vTslb
        PyByxaEJkUIKRiraeR3ilqE=
X-Google-Smtp-Source: APiQypI9NMXaV84zvSHLWM/zzjaCe5j4XSTSg2qajwuyzezr2g1p3tnL+UjhhbaWcv8H9FQrckxO0g==
X-Received: by 2002:a17:902:507:: with SMTP id 7mr12490926plf.42.1586007832971;
        Sat, 04 Apr 2020 06:43:52 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id y15sm7755531pfc.206.2020.04.04.06.43.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Apr 2020 06:43:52 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v8 2/7] receive-pack: add new proc-receive hook
Date:   Sat,  4 Apr 2020 09:43:40 -0400
Message-Id: <20200404134345.10655-3-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200403160838.6252-1-worldhello.net@gmail.com>
References: <20200403160838.6252-1-worldhello.net@gmail.com>
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

Suggested by Junio, this "proc-receive" hook reads the commands,
push-options (optional), and send result using a protocol in pkt-line
format.  In the following example, The letter "S" stands for
"receive-pack" and letter "H" stands for the hook.

    # Version and capabilities negotiation.
    S: PKT-LINE(version=1\0push-options atomic...)
    S: flush-pkt
    H: PKT-LINE(version=1\0push-options...)
    H: flush-pkt

    # Send commands from server to the hook.
    S: PKT-LINE(old-oid new-oid ref)
    S: ... ...
    S: flush-pkt
    # Only if push-options have been negotiated.
    S: PKT-LINE(push-option)
    S: ... ...
    S: flush-pkt

    # Receive result from the hook.
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

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 Makefile                     |   1 +
 builtin/receive-pack.c       | 264 +++++++++++++++-
 t/helper/test-proc-receive.c | 172 ++++++++++
 t/helper/test-tool.c         |   1 +
 t/helper/test-tool.h         |   1 +
 t/t5411-proc-receive-hook.sh | 592 ++++++++++++++++++++++++++++++++++-
 6 files changed, 1017 insertions(+), 14 deletions(-)
 create mode 100644 t/helper/test-proc-receive.c

diff --git a/Makefile b/Makefile
index ef1ff2228f..1c52c280ce 100644
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
index 2cc18bbffd..0760536d58 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -308,11 +308,14 @@ static void write_head_info(void)
 	packet_flush(1);
 }
 
+#define RUN_PROC_RECEIVE_SCHEDULED	1
+#define RUN_PROC_RECEIVE_RETURNED	2
 struct command {
 	struct command *next;
 	const char *error_string;
 	unsigned int skip_update:1,
-		     did_not_exist:1;
+		     did_not_exist:1,
+		     run_proc_receive:2;
 	int index;
 	struct object_id old_oid;
 	struct object_id new_oid;
@@ -817,6 +820,234 @@ static int run_update_hook(struct command *cmd)
 	return finish_command(&proc);
 }
 
+static struct command *find_command_by_refname(const struct command *list,
+					       const char *refname)
+{
+	for ( ; list; list = list->next)
+		if (!strcmp(list->ref_name, refname))
+			return (struct command *)list;
+	return NULL;
+}
+
+static int read_proc_receive_result(struct packet_reader *reader,
+				    struct command *commands,
+				    struct strbuf *errmsg)
+{
+	struct command *hint;
+	struct command *cmd;
+	int code = 0;
+
+	hint = NULL;
+	for (;;) {
+		struct object_id old_oid, new_oid;
+		const char *refname;
+		const char *p;
+		char *status;
+		char *msg = NULL;
+
+		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
+			break;
+		if (parse_oid_hex(reader->line, &old_oid, &p) ||
+		    *p++ != ' ' ||
+		    parse_oid_hex(p, &new_oid, &p) ||
+		    *p++ != ' ') {
+			strbuf_addf(errmsg, "proc-receive expected 'old new ref status [msg]', got '%s'",
+				    reader->line);
+			return -1;
+		}
+
+		refname = p;
+		status = strchr(p, ' ');
+		if (!status) {
+			strbuf_addf(errmsg, "proc-receive expected 'old new ref status [msg]', got '%s'",
+				    reader->line);
+			return -1;
+		}
+		*status++ = '\0';
+		if (strlen(status) > 2 && *(status + 2) == ' ') {
+			msg = status + 2;
+			*msg++ = '\0';
+		}
+		if (strlen(status) != 2) {
+			strbuf_addf(errmsg, "proc-receive has bad status '%s' for '%s'",
+				    status, reader->line);
+			return -1;
+		}
+
+		/* first try searching at our hint, falling back to all refs */
+		if (hint)
+			hint = find_command_by_refname(hint, refname);
+		if (!hint)
+			hint = find_command_by_refname(commands, refname);
+		if (!hint) {
+			strbuf_addf(errmsg, "proc-receive reported status on unknown ref: %s\n",
+				    refname);
+			continue;
+		}
+		if (!hint->run_proc_receive) {
+			strbuf_addf(errmsg, "proc-receive reported status on ref of builtin command: %s\n",
+				    refname);
+			continue;
+		}
+		hint->run_proc_receive |= RUN_PROC_RECEIVE_RETURNED;
+		oidcpy(&hint->old_oid, &old_oid);
+		oidcpy(&hint->new_oid, &new_oid);
+		if (!strcmp(status, "ng")) {
+			if (msg)
+				hint->error_string = xstrdup(msg);
+			else
+				hint->error_string = "failed";
+			code = -1;
+		} else if (strcmp("ok", status)) {
+			strbuf_addf(errmsg, "proc-receive has bad status '%s' for '%s'",
+				    status, reader->line);
+			return -1;
+		}
+	}
+
+	for (cmd = commands; cmd; cmd = cmd->next)
+		if (cmd->run_proc_receive &&
+		    !(cmd->run_proc_receive & RUN_PROC_RECEIVE_RETURNED)) {
+		    cmd->error_string = "no report from proc-receive";
+		    code = -1;
+		}
+
+	return code;
+}
+
+static int run_proc_receive_hook(struct command *commands,
+				 const struct string_list *push_options)
+{
+	struct child_process proc = CHILD_PROCESS_INIT;
+	struct async muxer;
+	struct command *cmd;
+	const char *argv[2];
+	struct packet_reader reader;
+	struct strbuf cap = STRBUF_INIT;
+	struct strbuf errmsg = STRBUF_INIT;
+	int pr_use_push_options = 0;
+	int version = 0;
+	int code;
+
+	argv[0] = find_hook("proc-receive");
+	if (!argv[0]) {
+		rp_error("cannot find hook 'proc-receive'");
+		return -1;
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
+	if (use_atomic)
+		strbuf_addstr(&cap, " atomic");
+	if (use_push_options)
+		strbuf_addstr(&cap, " push-options");
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
+	if (version != 1) {
+		strbuf_addf(&errmsg, "proc-receive version '%d' is not supported",
+			    version);
+		code = -1;
+		goto cleanup;
+	}
+
+	/* Send commands */
+	for (cmd = commands; cmd; cmd = cmd->next) {
+		char *old_hex, *new_hex;
+
+		if (!cmd->run_proc_receive || cmd->skip_update || cmd->error_string)
+			continue;
+		old_hex = oid_to_hex(&cmd->old_oid);
+		new_hex = oid_to_hex(&cmd->new_oid);
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
+		packet_flush(proc.in);
+	}
+
+	/* Read result from proc-receive */
+	code = read_proc_receive_result(&reader, commands, &errmsg);
+
+cleanup:
+	close(proc.in);
+	close(proc.out);
+	if (use_sideband)
+		finish_async(&muxer);
+	if (finish_command(&proc))
+		code = -1;
+	if (errmsg.len >0) {
+		char *p = errmsg.buf;
+
+		p += errmsg.len - 1;
+		if (*p == '\n')
+			*p = '\0';
+		rp_error("%s", errmsg.buf);
+		strbuf_release(&errmsg);
+	}
+	sigchain_pop(SIGPIPE);
+
+	return code;
+}
+
 static char *refuse_unconfigured_deny_msg =
 	N_("By default, updating the current branch in a non-bare repository\n"
 	   "is denied, because it will make the index and work tree inconsistent\n"
@@ -1392,7 +1623,7 @@ static void execute_commands_non_atomic(struct command *commands,
 	struct strbuf err = STRBUF_INIT;
 
 	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (!should_process_cmd(cmd))
+		if (!should_process_cmd(cmd) || cmd->run_proc_receive)
 			continue;
 
 		transaction = ref_transaction_begin(&err);
@@ -1432,7 +1663,7 @@ static void execute_commands_atomic(struct command *commands,
 	}
 
 	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (!should_process_cmd(cmd))
+		if (!should_process_cmd(cmd) || cmd->run_proc_receive)
 			continue;
 
 		cmd->error_string = update(cmd, si);
@@ -1468,6 +1699,7 @@ static void execute_commands(struct command *commands,
 	struct iterate_data data;
 	struct async muxer;
 	int err_fd = 0;
+	int run_proc_receive = 0;
 
 	if (unpacker_error) {
 		for (cmd = commands; cmd; cmd = cmd->next)
@@ -1497,6 +1729,20 @@ static void execute_commands(struct command *commands,
 
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
+			cmd->run_proc_receive = RUN_PROC_RECEIVE_SCHEDULED;
+			run_proc_receive = 1;
+		}
+	}
+
 	if (run_receive_hook(commands, "pre-receive", 0, push_options)) {
 		for (cmd = commands; cmd; cmd = cmd->next) {
 			if (!cmd->error_string)
@@ -1523,6 +1769,18 @@ static void execute_commands(struct command *commands,
 	free(head_name_to_free);
 	head_name = head_name_to_free = resolve_refdup("HEAD", 0, NULL, NULL);
 
+	if (run_proc_receive) {
+		int code;
+
+		code = run_proc_receive_hook(commands, push_options);
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
diff --git a/t/helper/test-proc-receive.c b/t/helper/test-proc-receive.c
new file mode 100644
index 0000000000..ed30817905
--- /dev/null
+++ b/t/helper/test-proc-receive.c
@@ -0,0 +1,172 @@
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
+static int use_atomic = 0;
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
+				if (parse_feature_request(feature_list, "atomic"))
+					use_atomic= 1;
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
+		FLEX_ALLOC_STR(cmd, ref_name, refname);
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
+		if (use_push_options || use_atomic)
+			fprintf(stderr, "proc-receive:%s%s\n",
+				use_atomic? " atomic": "",
+				use_push_options ? " push_options": "");
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
index 31eedcd241..f865433a61 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -44,6 +44,7 @@ static struct test_cmd cmds[] = {
 	{ "path-utils", cmd__path_utils },
 	{ "pkt-line", cmd__pkt_line },
 	{ "prio-queue", cmd__prio_queue },
+	{ "proc-receive", cmd__proc_receive},
 	{ "progress", cmd__progress },
 	{ "reach", cmd__reach },
 	{ "read-cache", cmd__read_cache },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 4eb5e6609e..059008cf22 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -34,6 +34,7 @@ int cmd__parse_pathspec_file(int argc, const char** argv);
 int cmd__path_utils(int argc, const char **argv);
 int cmd__pkt_line(int argc, const char **argv);
 int cmd__prio_queue(int argc, const char **argv);
+int cmd__proc_receive(int argc, const char **argv);
 int cmd__progress(int argc, const char **argv);
 int cmd__reach(int argc, const char **argv);
 int cmd__read_cache(int argc, const char **argv);
diff --git a/t/t5411-proc-receive-hook.sh b/t/t5411-proc-receive-hook.sh
index 1784bcb584..dbcf9f165c 100755
--- a/t/t5411-proc-receive-hook.sh
+++ b/t/t5411-proc-receive-hook.sh
@@ -43,8 +43,11 @@ create_commits_in () {
 # Format the output of git-push, git-show-ref and other commands to make a
 # user-friendly and stable text.  We can easily prepare the expect text
 # without having to worry about future changes of the commit ID and spaces
-# of the output.  We also replce single quotes with double quotes, because
-# it is boring to prepare unquoted single quotes in expect txt.
+# of the output.  Single quotes are replaced with double quotes, because
+# it is boring to prepare unquoted single quotes in expect txt.  We also
+# remove some locale error messages, which break test if we turn on
+# `GIT_TEST_GETTEXT_POISON=true` in order to test unintentional translations
+# on plumbing commands.
 make_user_friendly_and_stable_output () {
 	sed \
 		-e "s/  *\$//" \
@@ -54,13 +57,16 @@ make_user_friendly_and_stable_output () {
 		-e "s/$B/<COMMIT-B>/g" \
 		-e "s/$TAG/<TAG-v123>/g" \
 		-e "s/$ZERO_OID/<ZERO-OID>/g" \
-		-e "s/[0-9a-f]\{7,\}/<OID>/g"
+		-e "s/[0-9a-f]\{7,\}/<OID>/g" \
+		-e "s#To ../upstream.git#To <URL/of/upstream.git>#" \
+		-e "/^error: / d"
 }
 
 # Refs of upstream : master(B)  next(A)
 # Refs of workbench: master(A)           tags/v123
 test_expect_success "setup" '
-	git init --bare upstream &&
+	upstream=upstream.git &&
+	git init --bare "$upstream" &&
 	git init workbench &&
 	create_commits_in workbench A B &&
 	(
@@ -68,7 +74,7 @@ test_expect_success "setup" '
 		# Try to make a stable fixed width for abbreviated commit ID,
 		# this fixed-width oid will be replaced with "<OID>".
 		git config core.abbrev 7 &&
-		git remote add origin ../upstream &&
+		git remote add origin ../$upstream &&
 		git update-ref refs/heads/master $A &&
 		git tag -m "v123" v123 $A &&
 		git push origin \
@@ -78,7 +84,7 @@ test_expect_success "setup" '
 	TAG=$(git -C workbench rev-parse v123) &&
 
 	# setup pre-receive hook
-	cat >upstream/hooks/pre-receive <<-\EOF &&
+	cat >"$upstream/hooks/pre-receive" <<-\EOF &&
 	#!/bin/sh
 
 	echo >&2 "# pre-receive hook"
@@ -90,7 +96,7 @@ test_expect_success "setup" '
 	EOF
 
 	# setup post-receive hook
-	cat >upstream/hooks/post-receive <<-\EOF &&
+	cat >"$upstream/hooks/post-receive" <<-\EOF &&
 	#!/bin/sh
 
 	echo >&2 "# post-receive hook"
@@ -102,8 +108,8 @@ test_expect_success "setup" '
 	EOF
 
 	chmod a+x \
-		upstream/hooks/pre-receive \
-		upstream/hooks/post-receive
+		"$upstream/hooks/pre-receive" \
+		"$upstream/hooks/post-receive"
 '
 
 # Refs of upstream : master(B)  next(A)
@@ -131,7 +137,7 @@ test_expect_success "normal git-push command" '
 	remote: post-receive< <ZERO-OID> <TAG-v123> refs/tags/v123
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/review/master/topic
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/a/b/c
-	To ../upstream
+	To <URL/of/upstream.git>
 	 + <OID>...<OID> HEAD -> master (forced update)
 	 - [deleted] next
 	 * [new tag] v123 -> v123
@@ -139,7 +145,7 @@ test_expect_success "normal git-push command" '
 	 * [new branch] HEAD -> a/b/c
 	EOF
 	test_cmp expect actual &&
-	git -C upstream show-ref >out &&
+	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
 	<COMMIT-A> refs/heads/a/b/c
@@ -150,4 +156,568 @@ test_expect_success "normal git-push command" '
 	test_cmp expect actual
 '
 
+# Refs of upstream : master(A)  tags/v123  refs/review/master/topic(A)  a/b/c(A)
+# Refs of workbench: master(A)  tags/v123
+test_expect_success "cleanup" '
+	(
+		cd "$upstream" &&
+		git update-ref -d refs/review/master/topic &&
+		git update-ref -d refs/tags/v123 &&
+		git update-ref -d refs/heads/a/b/c
+	)
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       next(A)  refs/for/master/topic(A)
+test_expect_success "no proc-receive hook, fail to push special ref" '
+	test_must_fail git -C workbench push origin \
+		HEAD:next \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: error: cannot find hook "proc-receive"
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
+	To <URL/of/upstream.git>
+	 * [new branch] HEAD -> next
+	 ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/next
+	EOF
+	test_cmp expect actual
+'
+
+# Refs of upstream : master(A)             next(A)
+# Refs of workbench: master(A)  tags/v123
+test_expect_success "cleanup" '
+	git -C "$upstream" update-ref -d refs/heads/next
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push --atomic:                       next(A)  refs/for/master/topic(A)
+test_expect_success "no proc-receive hook, fail all for atomic push" '
+	test_must_fail git -C workbench push --atomic origin \
+		HEAD:next \
+		HEAD:refs/for/master/topic >out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: error: cannot find hook "proc-receive"
+	To <URL/of/upstream.git>
+	 ! [remote rejected] HEAD -> next (fail to run proc-receive hook)
+	 ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (bad version)" '
+	cat >"$upstream/hooks/proc-receive" <<-EOF &&
+	#!/bin/sh
+
+	printf >&2 "# proc-receive hook\n"
+
+	test-tool proc-receive -v --version 2
+	EOF
+	chmod a+x "$upstream/hooks/proc-receive"
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/master/topic(A)
+test_expect_success "proc-receive bad protocol: unknown version" '
+	test_must_fail git -C workbench push origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: fatal: the remote end hung up unexpectedly
+	remote: error: proc-receive version "2" is not supported
+	To <URL/of/upstream.git>
+	 ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
+	EOF
+	test_i18ncmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (no report)" '
+	cat >"$upstream/hooks/proc-receive" <<-EOF
+	#!/bin/sh
+
+	printf >&2 "# proc-receive hook\n"
+
+	test-tool proc-receive -v
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       next(A)  refs/for/master/topic(A)
+test_expect_success "proc-receive bad protocol: no report" '
+	test_must_fail git -C workbench push origin \
+		HEAD:refs/heads/next \
+		HEAD:refs/for/master/topic >out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
+	To <URL/of/upstream.git>
+	 * [new branch] HEAD -> next
+	 ! [remote rejected] HEAD -> refs/for/master/topic (no report from proc-receive)
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/next
+	EOF
+	test_cmp expect actual
+'
+
+# Refs of upstream : master(A)             next(A)
+# Refs of workbench: master(A)  tags/v123
+test_expect_success "cleanup" '
+	git -C "$upstream" update-ref -d refs/heads/next
+
+'
+
+test_expect_success "setup proc-receive hook (bad oid)" '
+	cat >"$upstream/hooks/proc-receive" <<-EOF
+	#!/bin/sh
+
+	printf >&2 "# proc-receive hook\n"
+
+	test-tool proc-receive -v \
+		-r "bad-id new-id ref ok"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/master/topic
+test_expect_success "proc-receive bad protocol: bad oid" '
+	test_must_fail git -C workbench push origin \
+		HEAD:refs/for/master/topic\
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> bad-id new-id ref ok
+	remote: error: proc-receive expected "old new ref status [msg]", got "bad-id new-id ref ok"
+	To <URL/of/upstream.git>
+	 ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (no status)" '
+	cat >"$upstream/hooks/proc-receive" <<-EOF
+	#!/bin/sh
+
+	printf >&2 "# proc-receive hook\n"
+
+	test-tool proc-receive -v \
+		-r "$ZERO_OID $A refs/for/master/topic"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/master/topic
+test_expect_success "proc-receive bad protocol: no status" '
+	test_must_fail git -C workbench push origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: error: proc-receive expected "old new ref status [msg]", got "<ZERO-OID> <COMMIT-A> refs/for/master/topic"
+	To <URL/of/upstream.git>
+	 ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (unknown status)" '
+	cat >"$upstream/hooks/proc-receive" <<-EOF
+	#!/bin/sh
+
+	printf >&2 "# proc-receive hook\n"
+
+	test-tool proc-receive -v \
+		-r "$ZERO_OID $A refs/for/master/topic xx msg"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/master/topic
+test_expect_success "proc-receive bad protocol: unknown status" '
+	test_must_fail git -C workbench push origin \
+			HEAD:refs/for/master/topic \
+			>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic xx msg
+	remote: error: proc-receive has bad status "xx" for "<ZERO-OID> <COMMIT-A> refs/for/master/topic"
+	To <URL/of/upstream.git>
+	 ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (bad status)" '
+	cat >"$upstream/hooks/proc-receive" <<-EOF
+	#!/bin/sh
+
+	printf >&2 "# proc-receive hook\n"
+
+	test-tool proc-receive -v \
+		-r "$ZERO_OID $A refs/for/master/topic bad status"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/master/topic
+test_expect_success "proc-receive bad protocol: bad status" '
+	test_must_fail git -C workbench push origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic bad status
+	remote: error: proc-receive has bad status "bad status" for "<ZERO-OID> <COMMIT-A> refs/for/master/topic"
+	To <URL/of/upstream.git>
+	 ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (ng)" '
+	cat >"$upstream/hooks/proc-receive" <<-EOF
+	#!/bin/sh
+
+	printf >&2 "# proc-receive hook\n"
+
+	test-tool proc-receive -v \
+		-r "$ZERO_OID $A refs/for/master/topic ng"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/master/topic
+test_expect_success "proc-receive: fail to update (no message)" '
+	test_must_fail git -C workbench push origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic ng
+	To <URL/of/upstream.git>
+	 ! [remote rejected] HEAD -> refs/for/master/topic (failed)
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (ng message)" '
+	cat >"$upstream/hooks/proc-receive" <<-EOF
+	#!/bin/sh
+
+	printf >&2 "# proc-receive hook\n"
+
+	test-tool proc-receive -v \
+		-r "$ZERO_OID $A refs/for/master/topic ng error msg"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/master/topic
+test_expect_success "proc-receive: fail to update (has message)" '
+	test_must_fail git -C workbench push origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic ng error msg
+	To <URL/of/upstream.git>
+	 ! [remote rejected] HEAD -> refs/for/master/topic (error msg)
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (report status on builtin command)" '
+	cat >"$upstream/hooks/proc-receive" <<-EOF
+	#!/bin/sh
+
+	printf >&2 "# proc-receive hook\n"
+
+	test-tool proc-receive -v \
+		-r "$ZERO_OID $A refs/heads/master ok"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         : (B)                   refs/for/master/topic
+test_expect_success "proc-receive: warning on report for builtin command" '
+	test_must_fail git -C workbench push origin \
+		$B:refs/heads/master \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/heads/master ok
+	remote: error: proc-receive reported status on ref of builtin command: refs/heads/master
+	remote: # post-receive hook
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
+	To <URL/of/upstream.git>
+	 <OID>..<OID> <COMMIT-B> -> master
+	 ! [remote rejected] HEAD -> refs/for/master/topic (no report from proc-receive)
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-B> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "cleanup" '
+	git -C "$upstream" update-ref refs/heads/master $A
+'
+
+test_expect_success "setup proc-receive hook (ok)" '
+	cat >"$upstream/hooks/proc-receive" <<-EOF
+	#!/bin/sh
+
+	printf >&2 "# proc-receive hook\n"
+
+	test-tool proc-receive -v \
+		-r "$ZERO_OID $A refs/for/master/topic ok"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/master/topic
+test_expect_success "proc-receive: ok" '
+	git -C workbench push origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic ok
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	To <URL/of/upstream.git>
+	 * [new reference] HEAD -> refs/for/master/topic
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/a/b/c/my/topic
+test_expect_success "proc-receive: no report from proc-receive" '
+	test_must_fail git -C workbench push origin \
+		HEAD:refs/for/a/b/c/my/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/my/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/my/topic
+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic ok
+	remote: error: proc-receive reported status on unknown ref: refs/for/master/topic
+	To <URL/of/upstream.git>
+	 ! [remote rejected] HEAD -> refs/for/a/b/c/my/topic (no report from proc-receive)
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push -o ...  :                       refs/for/master/topic
+test_expect_success "not support push options" '
+	test_must_fail git -C workbench push \
+		-o issue=123 \
+		-o reviewer=user1 \
+		origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	fatal: the receiving end does not support push options
+	fatal: the remote end hung up unexpectedly
+	EOF
+	test_i18ncmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "enable push options" '
+	git -C "$upstream" config receive.advertisePushOptions true
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push -o ...  :                       next(A)  refs/for/master/topic
+test_expect_success "push with options" '
+	git -C workbench push \
+		--atomic \
+		-o issue=123 \
+		-o reviewer=user1 \
+		origin \
+		HEAD:refs/heads/next \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive: atomic push_options
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive< issue=123
+	remote: proc-receive< reviewer=user1
+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic ok
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	To <URL/of/upstream.git>
+	 * [new branch] HEAD -> next
+	 * [new reference] HEAD -> refs/for/master/topic
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/next
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.24.1.15.g448c31058d.agit.4.5

