Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1261C433E1
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 17:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 915EC2067C
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 17:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sRqkbrP4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgHXRmd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgHXRmS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 13:42:18 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E644C061573
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 10:42:17 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id q3so3263777pls.11
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 10:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vj/tMc8DKLPGZoA9OMQmtAyMKXCoc2uP+F0e81N3Qg0=;
        b=sRqkbrP40LUgQxKIk2YOYjiGkBAvwxWmYKR7rCXYv7smjS4gsQl8C8tOhxTTEU+w7a
         nf4+SaVwdH1zxdyxq4sexgfpJgY9fTTTHnH4dNBXVtWeGXjJcl86BU6SBfNUPZTvyvOK
         DljrZfcxGy/lLxmv2tNw1ZnFTbgJ4yW52MShAxowDwIQJ/47Q53L0ZujlL3AMPhLTv6C
         T1A9fnfQYcK0DpBd5pNiar/v3tMBDQYdqcuKbUXt4gBh9bwYMX+J9xUi+a6AP4mxAHvA
         VPQojN7CzIGLQmiLOv8ELa0dJtqjG3i7ZKQ9V5hU95anL+ZZsTlHfJ8m/gZFsb+M26m1
         hcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vj/tMc8DKLPGZoA9OMQmtAyMKXCoc2uP+F0e81N3Qg0=;
        b=SS+FNibSJGTvQSLnrzpbqCdmf8o/LBXXDpNzMKzoQVjKCUL6u8XPkjVnTimqWIjvqw
         NxT0ziwBndvJqZ4sgZF/X6dDU5S8pi5f7pj95Gy6ycUx7UU7ncTorJd3pCb0uwHrwZ1e
         cd5gGZlozcwzFOryeTU3AY/mgqsIFs4g/40zqj3zhsuJ//wDt9hSPwnraDaXHjc68IKX
         lCOFMe7UvGYyF9t1RO9iKkV4tpM6EpFAWLLCOUHXpZN0Iw191vjYYjGzqKQVj0HxdBwF
         Est4JsELawb5aV1+5OJ+RXIcRLSAHKoihx6QLAwk/dV4+vxvrZcCZU5+66744t9swwqh
         kSNA==
X-Gm-Message-State: AOAM532ElD3a+l5TFYrI+csUwBCNt0iDUEBg8OVRmejLXDrMJAFQoT6S
        /416NlOUKuN9b6rIOvIWd1M=
X-Google-Smtp-Source: ABdhPJyYfOEMmx6+TCAJB5MgV/4dIVRNWMLs5fo7hc/FzZ4sHJ6ERoLv+ucDDJsXWrU+4arBek0jZA==
X-Received: by 2002:a17:90b:4c0f:: with SMTP id na15mr310864pjb.119.1598290935450;
        Mon, 24 Aug 2020 10:42:15 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id b15sm9773162pgk.14.2020.08.24.10.42.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 10:42:14 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v18 03/10] receive-pack: add new proc-receive hook
Date:   Mon, 24 Aug 2020 13:41:55 -0400
Message-Id: <20200824174202.11710-4-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200815171740.6257-1-worldhello.net@gmail.com>
References: <20200815171740.6257-1-worldhello.net@gmail.com>
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

    # Version and features negotiation.
    S: PKT-LINE(version=1\0push-options atomic...)
    S: flush-pkt
    H: PKT-LINE(version=1\0push-options...)
    H: flush-pkt

    # Send commands from server to the hook.
    S: PKT-LINE(<old-oid> <new-oid> <ref>)
    S: ... ...
    S: flush-pkt
    # Send push-options only if the 'push-options' feature is enabled.
    S: PKT-LINE(push-option)
    S: ... ...
    S: flush-pkt

    # Receive result from the hook.
    # OK, run this command successfully.
    H: PKT-LINE(ok <ref>)
    # NO, I reject it.
    H: PKT-LINE(ng <ref> <reason>)
    # Fall through, let 'receive-pack' to execute it.
    H: PKT-LINE(ok <ref>)
    H: PKT-LINE(option fall-through)
    # OK, but has an alternate reference.  The alternate reference name
    # and other status can be given in options
    H: PKT-LINE(ok <ref>)
    H: PKT-LINE(option refname <refname>)
    H: PKT-LINE(option old-oid <old-oid>)
    H: PKT-LINE(option new-oid <new-oid>)
    H: PKT-LINE(option forced-update)
    H: ... ...
    H: flush-pkt

After receiving a command, the hook will execute the command, and may
create/update different reference.  For example, a command for a pseudo
reference "refs/for/master/topic" may create/update different reference
such as "refs/pull/123/head".  The alternate reference name and other
status are given in option lines.

The list of commands returned from "proc-receive" will replace the
relevant commands that are sent from user to "receive-pack", and
"receive-pack" will continue to run the "execute_commands" function and
other routines.  Finally, the result of the execution of these commands
will be reported to end user.

The reporting function from "receive-pack" to "send-pack" will be
extended in latter commit just like what the "proc-receive" hook reports
to "receive-pack".

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 Makefile                                      |   1 +
 builtin/receive-pack.c                        | 296 +++++++++++++++++-
 remote.h                                      |   8 +
 t/helper/test-proc-receive.c                  | 176 +++++++++++
 t/helper/test-tool.c                          |   1 +
 t/helper/test-tool.h                          |   1 +
 t/t5411/test-0011-no-hook-error.sh            |  64 ++++
 t/t5411/test-0012-no-hook-error--porcelain.sh |  66 ++++
 t/t5411/test-0013-bad-protocol.sh             | 217 +++++++++++++
 t/t5411/test-0014-bad-protocol--porcelain.sh  | 160 ++++++++++
 t/t5411/test-0020-report-ng.sh                |  67 ++++
 t/t5411/test-0021-report-ng--porcelain.sh     |  69 ++++
 t/t5411/test-0022-report-unexpect-ref.sh      |  45 +++
 ...est-0023-report-unexpect-ref--porcelain.sh |  46 +++
 t/t5411/test-0024-report-unknown-ref.sh       |  34 ++
 ...test-0025-report-unknown-ref--porcelain.sh |  35 +++
 t/t5411/test-0026-push-options.sh             |  79 +++++
 t/t5411/test-0027-push-options--porcelain.sh  |  82 +++++
 t/t5411/test-0030-report-ok.sh                |  35 +++
 t/t5411/test-0031-report-ok--porcelain.sh     |  36 +++
 t/t5411/test-0032-report-with-options.sh      | 256 +++++++++++++++
 ...est-0033-report-with-options--porcelain.sh | 265 ++++++++++++++++
 t/t5411/test-0034-report-ft.sh                |  44 +++
 t/t5411/test-0035-report-ft--porcelain.sh     |  45 +++
 ...t-0036-report-multi-rewrite-for-one-ref.sh | 159 ++++++++++
 ...rt-multi-rewrite-for-one-ref--porcelain.sh | 162 ++++++++++
 t/t5411/test-0038-report-mixed-refs.sh        |  89 ++++++
 .../test-0039-report-mixed-refs--porcelain.sh |  91 ++++++
 28 files changed, 2626 insertions(+), 3 deletions(-)
 create mode 100644 t/helper/test-proc-receive.c
 create mode 100644 t/t5411/test-0011-no-hook-error.sh
 create mode 100644 t/t5411/test-0012-no-hook-error--porcelain.sh
 create mode 100644 t/t5411/test-0013-bad-protocol.sh
 create mode 100644 t/t5411/test-0014-bad-protocol--porcelain.sh
 create mode 100644 t/t5411/test-0020-report-ng.sh
 create mode 100644 t/t5411/test-0021-report-ng--porcelain.sh
 create mode 100644 t/t5411/test-0022-report-unexpect-ref.sh
 create mode 100644 t/t5411/test-0023-report-unexpect-ref--porcelain.sh
 create mode 100644 t/t5411/test-0024-report-unknown-ref.sh
 create mode 100644 t/t5411/test-0025-report-unknown-ref--porcelain.sh
 create mode 100644 t/t5411/test-0026-push-options.sh
 create mode 100644 t/t5411/test-0027-push-options--porcelain.sh
 create mode 100644 t/t5411/test-0030-report-ok.sh
 create mode 100644 t/t5411/test-0031-report-ok--porcelain.sh
 create mode 100644 t/t5411/test-0032-report-with-options.sh
 create mode 100644 t/t5411/test-0033-report-with-options--porcelain.sh
 create mode 100644 t/t5411/test-0034-report-ft.sh
 create mode 100644 t/t5411/test-0035-report-ft--porcelain.sh
 create mode 100644 t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
 create mode 100644 t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh
 create mode 100644 t/t5411/test-0038-report-mixed-refs.sh
 create mode 100644 t/t5411/test-0039-report-mixed-refs--porcelain.sh

diff --git a/Makefile b/Makefile
index 3d3a39fc19..607aeabeee 100644
--- a/Makefile
+++ b/Makefile
@@ -722,6 +722,7 @@ TEST_BUILTINS_OBJS += test-parse-pathspec-file.o
 TEST_BUILTINS_OBJS += test-path-utils.o
 TEST_BUILTINS_OBJS += test-pkt-line.o
 TEST_BUILTINS_OBJS += test-prio-queue.o
+TEST_BUILTINS_OBJS += test-proc-receive.o
 TEST_BUILTINS_OBJS += test-progress.o
 TEST_BUILTINS_OBJS += test-reach.o
 TEST_BUILTINS_OBJS += test-read-cache.o
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index a00f91c1a0..2b63b92545 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -308,11 +308,15 @@ static void write_head_info(void)
 	packet_flush(1);
 }
 
+#define RUN_PROC_RECEIVE_SCHEDULED	1
+#define RUN_PROC_RECEIVE_RETURNED	2
 struct command {
 	struct command *next;
 	const char *error_string;
+	struct ref_push_report *report;
 	unsigned int skip_update:1,
-		     did_not_exist:1;
+		     did_not_exist:1,
+		     run_proc_receive:2;
 	int index;
 	struct object_id old_oid;
 	struct object_id new_oid;
@@ -838,6 +842,268 @@ static int run_update_hook(struct command *cmd)
 	return finish_command(&proc);
 }
 
+static struct command *find_command_by_refname(struct command *list,
+					       const char *refname)
+{
+	for (; list; list = list->next)
+		if (!strcmp(list->ref_name, refname))
+			return list;
+	return NULL;
+}
+
+static int read_proc_receive_report(struct packet_reader *reader,
+				    struct command *commands,
+				    struct strbuf *errmsg)
+{
+	struct command *cmd;
+	struct command *hint = NULL;
+	struct ref_push_report *report = NULL;
+	int new_report = 0;
+	int code = 0;
+	int once = 0;
+
+	for (;;) {
+		struct object_id old_oid, new_oid;
+		const char *head;
+		const char *refname;
+		char *p;
+
+		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
+			break;
+
+		head = reader->line;
+		p = strchr(head, ' ');
+		if (!p) {
+			strbuf_addf(errmsg, "proc-receive reported incomplete status line: '%s'\n", head);
+			code = -1;
+			continue;
+		}
+		*p++ = '\0';
+		if (!strcmp(head, "option")) {
+			const char *key, *val;
+
+			if (!hint || !(report || new_report)) {
+				if (!once++)
+					strbuf_addstr(errmsg, "proc-receive reported 'option' without a matching 'ok/ng' directive\n");
+				code = -1;
+				continue;
+			}
+			if (new_report) {
+				if (!hint->report) {
+					hint->report = xcalloc(1, sizeof(struct ref_push_report));
+					report = hint->report;
+				} else {
+					report = hint->report;
+					while (report->next)
+						report = report->next;
+					report->next = xcalloc(1, sizeof(struct ref_push_report));
+					report = report->next;
+				}
+				new_report = 0;
+			}
+			key = p;
+			p = strchr(key, ' ');
+			if (p)
+				*p++ = '\0';
+			val = p;
+			if (!strcmp(key, "refname"))
+				report->ref_name = xstrdup_or_null(val);
+			else if (!strcmp(key, "old-oid") && val &&
+				 !parse_oid_hex(val, &old_oid, &val))
+				report->old_oid = oiddup(&old_oid);
+			else if (!strcmp(key, "new-oid") && val &&
+				 !parse_oid_hex(val, &new_oid, &val))
+				report->new_oid = oiddup(&new_oid);
+			else if (!strcmp(key, "forced-update"))
+				report->forced_update = 1;
+			else if (!strcmp(key, "fall-through"))
+				/* Fall through, let 'receive-pack' to execute it. */
+				hint->run_proc_receive = 0;
+			continue;
+		}
+
+		report = NULL;
+		new_report = 0;
+		refname = p;
+		p = strchr(refname, ' ');
+		if (p)
+			*p++ = '\0';
+		if (strcmp(head, "ok") && strcmp(head, "ng")) {
+			strbuf_addf(errmsg, "proc-receive reported bad status '%s' on ref '%s'\n",
+				    head, refname);
+			code = -1;
+			continue;
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
+			code = -1;
+			continue;
+		}
+		if (!hint->run_proc_receive) {
+			strbuf_addf(errmsg, "proc-receive reported status on unexpected ref: %s\n",
+				    refname);
+			code = -1;
+			continue;
+		}
+		hint->run_proc_receive |= RUN_PROC_RECEIVE_RETURNED;
+		if (!strcmp(head, "ng")) {
+			if (p)
+				hint->error_string = xstrdup(p);
+			else
+				hint->error_string = "failed";
+			code = -1;
+			continue;
+		}
+		new_report = 1;
+	}
+
+	for (cmd = commands; cmd; cmd = cmd->next)
+		if (cmd->run_proc_receive && !cmd->error_string &&
+		    !(cmd->run_proc_receive & RUN_PROC_RECEIVE_RETURNED)) {
+		    cmd->error_string = "proc-receive failed to report status";
+		    code = -1;
+		}
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
+	int hook_use_push_options = 0;
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
+			   PACKET_READ_GENTLE_ON_EOF);
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
+					hook_use_push_options = 1;
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
+		if (!cmd->run_proc_receive || cmd->skip_update || cmd->error_string)
+			continue;
+		packet_write_fmt(proc.in, "%s %s %s",
+				 oid_to_hex(&cmd->old_oid),
+				 oid_to_hex(&cmd->new_oid),
+				 cmd->ref_name);
+	}
+	packet_flush(proc.in);
+
+	/* Send push options */
+	if (hook_use_push_options) {
+		struct string_list_item *item;
+
+		for_each_string_list_item(item, push_options)
+			packet_write_fmt(proc.in, "%s", item->string);
+		packet_flush(proc.in);
+	}
+
+	/* Read result from proc-receive */
+	code = read_proc_receive_report(&reader, commands, &errmsg);
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
@@ -1413,7 +1679,7 @@ static void execute_commands_non_atomic(struct command *commands,
 	struct strbuf err = STRBUF_INIT;
 
 	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (!should_process_cmd(cmd))
+		if (!should_process_cmd(cmd) || cmd->run_proc_receive)
 			continue;
 
 		transaction = ref_transaction_begin(&err);
@@ -1453,7 +1719,7 @@ static void execute_commands_atomic(struct command *commands,
 	}
 
 	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (!should_process_cmd(cmd))
+		if (!should_process_cmd(cmd) || cmd->run_proc_receive)
 			continue;
 
 		cmd->error_string = update(cmd, si);
@@ -1489,6 +1755,7 @@ static void execute_commands(struct command *commands,
 	struct iterate_data data;
 	struct async muxer;
 	int err_fd = 0;
+	int run_proc_receive = 0;
 
 	if (unpacker_error) {
 		for (cmd = commands; cmd; cmd = cmd->next)
@@ -1518,6 +1785,21 @@ static void execute_commands(struct command *commands,
 
 	reject_updates_to_hidden(commands);
 
+	/*
+	 * Try to find commands that have special prefix in their reference names,
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
@@ -1544,6 +1826,14 @@ static void execute_commands(struct command *commands,
 	free(head_name_to_free);
 	head_name = head_name_to_free = resolve_refdup("HEAD", 0, NULL, NULL);
 
+	if (run_proc_receive &&
+	    run_proc_receive_hook(commands, push_options))
+		for (cmd = commands; cmd; cmd = cmd->next)
+			if (!cmd->error_string &&
+			    !(cmd->run_proc_receive & RUN_PROC_RECEIVE_RETURNED) &&
+			    (cmd->run_proc_receive || use_atomic))
+				cmd->error_string = "fail to run proc-receive hook";
+
 	if (use_atomic)
 		execute_commands_atomic(commands, si);
 	else
diff --git a/remote.h b/remote.h
index 11d8719b58..ca7735b441 100644
--- a/remote.h
+++ b/remote.h
@@ -93,6 +93,14 @@ int for_each_remote(each_remote_fn fn, void *priv);
 
 int remote_has_url(struct remote *remote, const char *url);
 
+struct ref_push_report {
+	const char *ref_name;
+	struct object_id *old_oid;
+	struct object_id *new_oid;
+	unsigned int forced_update:1;
+	struct ref_push_report *next;
+};
+
 struct ref {
 	struct ref *next;
 	struct object_id old_oid;
diff --git a/t/helper/test-proc-receive.c b/t/helper/test-proc-receive.c
new file mode 100644
index 0000000000..42164d9898
--- /dev/null
+++ b/t/helper/test-proc-receive.c
@@ -0,0 +1,176 @@
+#include "cache.h"
+#include "connect.h"
+#include "parse-options.h"
+#include "pkt-line.h"
+#include "sigchain.h"
+#include "test-tool.h"
+
+static const char *proc_receive_usage[] = {
+	"test-tool proc-receive [<options>...]",
+	NULL
+};
+
+static int die_version;
+static int die_readline;
+static int no_push_options;
+static int use_atomic;
+static int use_push_options;
+static int verbose;
+static int version = 1;
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
+	if (server_version != 1 || die_version)
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
+		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
+			break;
+
+		if (parse_oid_hex(reader->line, &old_oid, &p) ||
+		    *p++ != ' ' ||
+		    parse_oid_hex(p, &new_oid, &p) ||
+		    *p++ != ' ' ||
+		    die_readline)
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
+	int nongit_ok = 0;
+	struct packet_reader reader;
+	struct command *commands = NULL;
+	struct string_list push_options = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
+	struct option options[] = {
+		OPT_BOOL(0, "no-push-options", &no_push_options,
+			 "disable push options"),
+		OPT_BOOL(0, "die-version", &die_version,
+			 "die during version negotiation"),
+		OPT_BOOL(0, "die-readline", &die_readline,
+			 "die when readline"),
+		OPT_STRING_LIST('r', "return", &returns, "old/new/ref/status/msg",
+				"return of results"),
+		OPT__VERBOSE(&verbose, "be verbose"),
+		OPT_INTEGER('V', "version", &version,
+			    "use this protocol version number"),
+		OPT_END()
+	};
+
+	setup_git_directory_gently(&nongit_ok);
+
+	argc = parse_options(argc, argv, "test-tools", options, proc_receive_usage, 0);
+	if (argc > 0)
+		usage_msg_opt("Too many arguments.", proc_receive_usage, options);
+	packet_reader_init(&reader, 0, NULL, 0,
+			   PACKET_READ_CHOMP_NEWLINE |
+			   PACKET_READ_DIE_ON_ERR_PACKET);
+
+	sigchain_push(SIGPIPE, SIG_IGN);
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
+		for (cmd = commands; cmd; cmd = cmd->next)
+			fprintf(stderr, "proc-receive< %s %s %s\n",
+				oid_to_hex(&cmd->old_oid),
+				oid_to_hex(&cmd->new_oid),
+				cmd->ref_name);
+
+		if (push_options.nr > 0)
+			for_each_string_list_item(item, &push_options)
+				fprintf(stderr, "proc-receive< %s\n", item->string);
+
+		if (returns.nr)
+			for_each_string_list_item(item, &returns)
+				fprintf(stderr, "proc-receive> %s\n", item->string);
+	}
+
+	if (returns.nr)
+		for_each_string_list_item(item, &returns)
+			packet_write_fmt(1, "%s\n", item->string);
+	packet_flush(1);
+	sigchain_pop(SIGPIPE);
+
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 590b2efca7..a0d3966b29 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -46,6 +46,7 @@ static struct test_cmd cmds[] = {
 	{ "path-utils", cmd__path_utils },
 	{ "pkt-line", cmd__pkt_line },
 	{ "prio-queue", cmd__prio_queue },
+	{ "proc-receive", cmd__proc_receive},
 	{ "progress", cmd__progress },
 	{ "reach", cmd__reach },
 	{ "read-cache", cmd__read_cache },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index ddc8e990e9..07034d3f38 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -35,6 +35,7 @@ int cmd__parse_pathspec_file(int argc, const char** argv);
 int cmd__path_utils(int argc, const char **argv);
 int cmd__pkt_line(int argc, const char **argv);
 int cmd__prio_queue(int argc, const char **argv);
+int cmd__proc_receive(int argc, const char **argv);
 int cmd__progress(int argc, const char **argv);
 int cmd__reach(int argc, const char **argv);
 int cmd__read_cache(int argc, const char **argv);
diff --git a/t/t5411/test-0011-no-hook-error.sh b/t/t5411/test-0011-no-hook-error.sh
new file mode 100644
index 0000000000..bb6ec92a92
--- /dev/null
+++ b/t/t5411/test-0011-no-hook-error.sh
@@ -0,0 +1,64 @@
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       next(A)  refs/for/master/topic(A)
+test_expect_success "proc-receive: no hook, fail to push special ref ($PROTOCOL)" '
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
+test_expect_success "cleanup ($PROTOCOL)" '
+	git -C "$upstream" update-ref -d refs/heads/next
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push --atomic: (B)                   next(A)  refs/for/master/topic(A)
+test_expect_success "proc-receive: no hook, all failed for atomic push ($PROTOCOL)" '
+	test_must_fail git -C workbench push --atomic origin \
+		$B:master \
+		HEAD:next \
+		HEAD:refs/for/master/topic >out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: error: cannot find hook "proc-receive"
+	To <URL/of/upstream.git>
+	 ! [remote rejected] <COMMIT-B> -> master (fail to run proc-receive hook)
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
diff --git a/t/t5411/test-0012-no-hook-error--porcelain.sh b/t/t5411/test-0012-no-hook-error--porcelain.sh
new file mode 100644
index 0000000000..4814f74dc2
--- /dev/null
+++ b/t/t5411/test-0012-no-hook-error--porcelain.sh
@@ -0,0 +1,66 @@
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       next(A)  refs/for/master/topic(A)
+test_expect_success "proc-receive: no hook, fail to push special ref ($PROTOCOL/porcelain)" '
+	test_must_fail git -C workbench push --porcelain origin \
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
+	*    HEAD:refs/heads/next    [new branch]
+	!    HEAD:refs/for/master/topic    [remote rejected] (fail to run proc-receive hook)
+	Done
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
+test_expect_success "cleanup ($PROTOCOL/porcelain)" '
+	git -C "$upstream" update-ref -d refs/heads/next
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push --atomic: (B)                   next(A)  refs/for/master/topic(A)
+test_expect_success "proc-receive: no hook, all failed for atomic push ($PROTOCOL/porcelain)" '
+	test_must_fail git -C workbench push --porcelain --atomic origin \
+		$B:master \
+		HEAD:next \
+		HEAD:refs/for/master/topic >out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: error: cannot find hook "proc-receive"
+	To <URL/of/upstream.git>
+	!    <COMMIT-B>:refs/heads/master    [remote rejected] (fail to run proc-receive hook)
+	!    HEAD:refs/heads/next    [remote rejected] (fail to run proc-receive hook)
+	!    HEAD:refs/for/master/topic    [remote rejected] (fail to run proc-receive hook)
+	Done
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
diff --git a/t/t5411/test-0013-bad-protocol.sh b/t/t5411/test-0013-bad-protocol.sh
new file mode 100644
index 0000000000..c5fe4cb37b
--- /dev/null
+++ b/t/t5411/test-0013-bad-protocol.sh
@@ -0,0 +1,217 @@
+test_expect_success "setup proc-receive hook (unknown version, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v --version 2
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/master/topic(A)
+test_expect_success "proc-receive: bad protocol (unknown version, $PROTOCOL)" '
+	test_must_fail git -C workbench push origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+
+	# Check status report for git-push
+	sed -n \
+		-e "/^To / { p; n; p; }" \
+		<actual >actual-report &&
+	cat >expect <<-EOF &&
+	To <URL/of/upstream.git>
+	 ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
+	EOF
+	test_cmp expect actual-report &&
+
+	# Check error message from "receive-pack", but ignore unstable fatal error
+	# message ("remote: fatal: the remote end hung up unexpectedly") which
+	# is different from the remote HTTP server with different locale settings.
+	grep "^remote: error:" <actual >actual-error &&
+	cat >expect <<-EOF &&
+	remote: error: proc-receive version "2" is not supported
+	EOF
+	test_cmp expect actual-error &&
+
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (hook --die-version, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v --die-version
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/master/topic(A)
+test_expect_success "proc-receive: bad protocol (hook --die-version, $PROTOCOL)" '
+	test_must_fail git -C workbench push origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: fatal: bad protocol version: 1
+	remote: error: proc-receive version "0" is not supported
+	To <URL/of/upstream.git>
+	 ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
+	EOF
+	test_cmp expect actual &&
+
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (hook --die-readline, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v --die-readline
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/master/topic(A)
+test_expect_success "proc-receive: bad protocol (hook --die-readline, $PROTOCOL)" '
+	test_must_fail git -C workbench push origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+
+	grep "remote: fatal: protocol error: expected \"old new ref\", got \"<ZERO-OID> <COMMIT-A> refs/for/master/topic\"" actual &&
+
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (no report, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       next(A)  refs/for/master/topic(A)
+test_expect_success "proc-receive: bad protocol (no report, $PROTOCOL)" '
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
+	 ! [remote rejected] HEAD -> refs/for/master/topic (proc-receive failed to report status)
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
+test_expect_success "cleanup ($PROTOCOL)" '
+	git -C "$upstream" update-ref -d refs/heads/next
+
+'
+
+test_expect_success "setup proc-receive hook (no ref, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/master/topic
+test_expect_success "proc-receive: bad protocol (no ref, $PROTOCOL)" '
+	test_must_fail git -C workbench push origin \
+		HEAD:refs/for/master/topic\
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> ok
+	remote: error: proc-receive reported incomplete status line: "ok"
+	To <URL/of/upstream.git>
+	 ! [remote rejected] HEAD -> refs/for/master/topic (proc-receive failed to report status)
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
+test_expect_success "setup proc-receive hook (unknown status, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "xx refs/for/master/topic"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/master/topic
+test_expect_success "proc-receive: bad protocol (unknown status, $PROTOCOL)" '
+	test_must_fail git -C workbench push origin \
+			HEAD:refs/for/master/topic \
+			>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> xx refs/for/master/topic
+	remote: error: proc-receive reported bad status "xx" on ref "refs/for/master/topic"
+	To <URL/of/upstream.git>
+	 ! [remote rejected] HEAD -> refs/for/master/topic (proc-receive failed to report status)
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
diff --git a/t/t5411/test-0014-bad-protocol--porcelain.sh b/t/t5411/test-0014-bad-protocol--porcelain.sh
new file mode 100644
index 0000000000..53b47b0185
--- /dev/null
+++ b/t/t5411/test-0014-bad-protocol--porcelain.sh
@@ -0,0 +1,160 @@
+test_expect_success "setup proc-receive hook (unknown version, $PROTOCOL/porcelain)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v --version 2
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/master/topic(A)
+test_expect_success "proc-receive: bad protocol (unknown version, $PROTOCOL/porcelain)" '
+	test_must_fail git -C workbench push --porcelain origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+
+	# Check status report for git-push
+	sed -n \
+		-e "/^To / { p; n; p; n; p; }" \
+		<actual >actual-report &&
+	cat >expect <<-EOF &&
+	To <URL/of/upstream.git>
+	!    HEAD:refs/for/master/topic    [remote rejected] (fail to run proc-receive hook)
+	Done
+	EOF
+	test_cmp expect actual-report &&
+
+	# Check error message from "receive-pack", but ignore unstable fatal error
+	# message ("remote: fatal: the remote end hung up unexpectedly") which
+	# is different from the remote HTTP server with different locale settings.
+	grep "^remote: error:" <actual >actual-error &&
+	cat >expect <<-EOF &&
+	remote: error: proc-receive version "2" is not supported
+	EOF
+	test_cmp expect actual-error &&
+
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (no report, $PROTOCOL/porcelain)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       next(A)  refs/for/master/topic(A)
+test_expect_success "proc-receive: bad protocol (no report, $PROTOCOL/porcelain)" '
+	test_must_fail git -C workbench push --porcelain origin \
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
+	*    HEAD:refs/heads/next    [new branch]
+	!    HEAD:refs/for/master/topic    [remote rejected] (proc-receive failed to report status)
+	Done
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
+test_expect_success "cleanup ($PROTOCOL/porcelain)" '
+	git -C "$upstream" update-ref -d refs/heads/next
+
+'
+
+test_expect_success "setup proc-receive hook (no ref, $PROTOCOL/porcelain)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/master/topic
+test_expect_success "proc-receive: bad protocol (no ref, $PROTOCOL/porcelain)" '
+	test_must_fail git -C workbench push --porcelain origin \
+		HEAD:refs/for/master/topic\
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> ok
+	remote: error: proc-receive reported incomplete status line: "ok"
+	To <URL/of/upstream.git>
+	!    HEAD:refs/for/master/topic    [remote rejected] (proc-receive failed to report status)
+	Done
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
+test_expect_success "setup proc-receive hook (unknown status, $PROTOCOL/porcelain)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "xx refs/for/master/topic"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/master/topic
+test_expect_success "proc-receive: bad protocol (unknown status, $PROTOCOL/porcelain)" '
+	test_must_fail git -C workbench push --porcelain origin \
+			HEAD:refs/for/master/topic \
+			>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> xx refs/for/master/topic
+	remote: error: proc-receive reported bad status "xx" on ref "refs/for/master/topic"
+	To <URL/of/upstream.git>
+	!    HEAD:refs/for/master/topic    [remote rejected] (proc-receive failed to report status)
+	Done
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
diff --git a/t/t5411/test-0020-report-ng.sh b/t/t5411/test-0020-report-ng.sh
new file mode 100644
index 0000000000..f726b7ca9c
--- /dev/null
+++ b/t/t5411/test-0020-report-ng.sh
@@ -0,0 +1,67 @@
+test_expect_success "setup proc-receive hook (ng, no message, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ng refs/for/master/topic"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/master/topic
+test_expect_success "proc-receive: fail to update (ng, no message, $PROTOCOL)" '
+	test_must_fail git -C workbench push origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> ng refs/for/master/topic
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
+test_expect_success "setup proc-receive hook (ng message, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ng refs/for/master/topic error msg"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/master/topic
+test_expect_success "proc-receive: fail to update (ng, with message, $PROTOCOL)" '
+	test_must_fail git -C workbench push origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> ng refs/for/master/topic error msg
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
diff --git a/t/t5411/test-0021-report-ng--porcelain.sh b/t/t5411/test-0021-report-ng--porcelain.sh
new file mode 100644
index 0000000000..fbf5569103
--- /dev/null
+++ b/t/t5411/test-0021-report-ng--porcelain.sh
@@ -0,0 +1,69 @@
+test_expect_success "setup proc-receive hook (ng, no message, $PROTOCOL/porcelain)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ng refs/for/master/topic"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/master/topic
+test_expect_success "proc-receive: fail to update (ng, no message, $PROTOCOL/porcelain)" '
+	test_must_fail git -C workbench push --porcelain origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> ng refs/for/master/topic
+	To <URL/of/upstream.git>
+	!    HEAD:refs/for/master/topic    [remote rejected] (failed)
+	Done
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
+test_expect_success "setup proc-receive hook (ng message, $PROTOCOL/porcelain)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ng refs/for/master/topic error msg"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/master/topic
+test_expect_success "proc-receive: fail to update (ng, with message, $PROTOCOL/porcelain)" '
+	test_must_fail git -C workbench push --porcelain origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> ng refs/for/master/topic error msg
+	To <URL/of/upstream.git>
+	!    HEAD:refs/for/master/topic    [remote rejected] (error msg)
+	Done
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
diff --git a/t/t5411/test-0022-report-unexpect-ref.sh b/t/t5411/test-0022-report-unexpect-ref.sh
new file mode 100644
index 0000000000..92a415b929
--- /dev/null
+++ b/t/t5411/test-0022-report-unexpect-ref.sh
@@ -0,0 +1,45 @@
+test_expect_success "setup proc-receive hook (unexpected ref, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/heads/master"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         : (B)                   refs/for/master/topic
+test_expect_success "proc-receive: report unexpected ref ($PROTOCOL)" '
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
+	remote: proc-receive> ok refs/heads/master
+	remote: error: proc-receive reported status on unexpected ref: refs/heads/master
+	remote: # post-receive hook
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
+	To <URL/of/upstream.git>
+	 <OID-A>..<OID-B> <COMMIT-B> -> master
+	 ! [remote rejected] HEAD -> refs/for/master/topic (proc-receive failed to report status)
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
+# Refs of upstream : master(B)
+# Refs of workbench: master(A)  tags/v123
+test_expect_success "cleanup ($PROTOCOL)" '
+	git -C "$upstream" update-ref refs/heads/master $A
+'
diff --git a/t/t5411/test-0023-report-unexpect-ref--porcelain.sh b/t/t5411/test-0023-report-unexpect-ref--porcelain.sh
new file mode 100644
index 0000000000..acbf93e40a
--- /dev/null
+++ b/t/t5411/test-0023-report-unexpect-ref--porcelain.sh
@@ -0,0 +1,46 @@
+test_expect_success "setup proc-receive hook (unexpected ref, $PROTOCOL/porcelain)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/heads/master"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         : (B)                   refs/for/master/topic
+test_expect_success "proc-receive: report unexpected ref ($PROTOCOL/porcelain)" '
+	test_must_fail git -C workbench push --porcelain origin \
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
+	remote: proc-receive> ok refs/heads/master
+	remote: error: proc-receive reported status on unexpected ref: refs/heads/master
+	remote: # post-receive hook
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
+	To <URL/of/upstream.git>
+	     <COMMIT-B>:refs/heads/master    <OID-A>..<OID-B>
+	!    HEAD:refs/for/master/topic    [remote rejected] (proc-receive failed to report status)
+	Done
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
+# Refs of upstream : master(B)
+# Refs of workbench: master(A)  tags/v123
+test_expect_success "cleanup ($PROTOCOL/porcelain)" '
+	git -C "$upstream" update-ref refs/heads/master $A
+'
diff --git a/t/t5411/test-0024-report-unknown-ref.sh b/t/t5411/test-0024-report-unknown-ref.sh
new file mode 100644
index 0000000000..c3946f329a
--- /dev/null
+++ b/t/t5411/test-0024-report-unknown-ref.sh
@@ -0,0 +1,34 @@
+test_expect_success "setup proc-receive hook (unexpected ref, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/for/master/topic"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/a/b/c/my/topic
+test_expect_success "proc-receive: report unknown reference ($PROTOCOL)" '
+	test_must_fail git -C workbench push origin \
+		HEAD:refs/for/a/b/c/my/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/my/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/my/topic
+	remote: proc-receive> ok refs/for/master/topic
+	remote: error: proc-receive reported status on unknown ref: refs/for/master/topic
+	To <URL/of/upstream.git>
+	 ! [remote rejected] HEAD -> refs/for/a/b/c/my/topic (proc-receive failed to report status)
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
diff --git a/t/t5411/test-0025-report-unknown-ref--porcelain.sh b/t/t5411/test-0025-report-unknown-ref--porcelain.sh
new file mode 100644
index 0000000000..d093b1a579
--- /dev/null
+++ b/t/t5411/test-0025-report-unknown-ref--porcelain.sh
@@ -0,0 +1,35 @@
+test_expect_success "setup proc-receive hook (unexpected ref, $PROTOCOL/porcelain)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/for/master/topic"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/a/b/c/my/topic
+test_expect_success "proc-receive: report unknown reference ($PROTOCOL/porcelain)" '
+	test_must_fail git -C workbench push --porcelain origin \
+		HEAD:refs/for/a/b/c/my/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/my/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/my/topic
+	remote: proc-receive> ok refs/for/master/topic
+	remote: error: proc-receive reported status on unknown ref: refs/for/master/topic
+	To <URL/of/upstream.git>
+	!    HEAD:refs/for/a/b/c/my/topic    [remote rejected] (proc-receive failed to report status)
+	Done
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
diff --git a/t/t5411/test-0026-push-options.sh b/t/t5411/test-0026-push-options.sh
new file mode 100644
index 0000000000..d0c4da8b23
--- /dev/null
+++ b/t/t5411/test-0026-push-options.sh
@@ -0,0 +1,79 @@
+test_expect_success "setup proc-receive hook and disable push-options ($PROTOCOL)" '
+	git -C "$upstream" config receive.advertisePushOptions false &&
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/for/master/topic"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push -o ...  :                       refs/for/master/topic
+test_expect_success "proc-receive: not support push options ($PROTOCOL)" '
+	test_must_fail git -C workbench push \
+		-o issue=123 \
+		-o reviewer=user1 \
+		origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	test_i18ngrep "fatal: the receiving end does not support push options" \
+		actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "enable push options ($PROTOCOL)" '
+	git -C "$upstream" config receive.advertisePushOptions true
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push -o ...  :                       next(A)  refs/for/master/topic
+test_expect_success "proc-receive: push with options ($PROTOCOL)" '
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
+	remote: proc-receive> ok refs/for/master/topic
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
+# Refs of upstream : master(A)             next(A)
+# Refs of workbench: master(A)  tags/v123
+test_expect_success "cleanup ($PROTOCOL)" '
+	git -C "$upstream" update-ref -d refs/heads/next
+'
diff --git a/t/t5411/test-0027-push-options--porcelain.sh b/t/t5411/test-0027-push-options--porcelain.sh
new file mode 100644
index 0000000000..c89a1e7c57
--- /dev/null
+++ b/t/t5411/test-0027-push-options--porcelain.sh
@@ -0,0 +1,82 @@
+test_expect_success "setup proc-receive hook and disable push-options ($PROTOCOL/porcelain)" '
+	git -C "$upstream" config receive.advertisePushOptions false &&
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/for/master/topic"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push -o ...  :                       refs/for/master/topic
+test_expect_success "proc-receive: not support push options ($PROTOCOL/porcelain)" '
+	test_must_fail git -C workbench push \
+		--porcelain \
+		-o issue=123 \
+		-o reviewer=user1 \
+		origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	test_i18ngrep "fatal: the receiving end does not support push options" \
+		actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "enable push options ($PROTOCOL/porcelain)" '
+	git -C "$upstream" config receive.advertisePushOptions true
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push -o ...  :                       next(A)  refs/for/master/topic
+test_expect_success "proc-receive: push with options ($PROTOCOL/porcelain)" '
+	git -C workbench push \
+		--porcelain \
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
+	remote: proc-receive> ok refs/for/master/topic
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	To <URL/of/upstream.git>
+	*    HEAD:refs/heads/next    [new branch]
+	*    HEAD:refs/for/master/topic    [new reference]
+	Done
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
+test_expect_success "cleanup ($PROTOCOL/porcelain)" '
+	git -C "$upstream" update-ref -d refs/heads/next
+'
diff --git a/t/t5411/test-0030-report-ok.sh b/t/t5411/test-0030-report-ok.sh
new file mode 100644
index 0000000000..44c99d3831
--- /dev/null
+++ b/t/t5411/test-0030-report-ok.sh
@@ -0,0 +1,35 @@
+test_expect_success "setup proc-receive hook (ok, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/for/master/topic"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/master/topic
+test_expect_success "proc-receive: ok ($PROTOCOL)" '
+	git -C workbench push origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> ok refs/for/master/topic
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
diff --git a/t/t5411/test-0031-report-ok--porcelain.sh b/t/t5411/test-0031-report-ok--porcelain.sh
new file mode 100644
index 0000000000..3223b26184
--- /dev/null
+++ b/t/t5411/test-0031-report-ok--porcelain.sh
@@ -0,0 +1,36 @@
+test_expect_success "setup proc-receive hook (ok, $PROTOCOL/porcelain)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/for/master/topic"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/master/topic
+test_expect_success "proc-receive: ok ($PROTOCOL/porcelain)" '
+	git -C workbench push --porcelain origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> ok refs/for/master/topic
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	To <URL/of/upstream.git>
+	*    HEAD:refs/for/master/topic    [new reference]
+	Done
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
diff --git a/t/t5411/test-0032-report-with-options.sh b/t/t5411/test-0032-report-with-options.sh
new file mode 100644
index 0000000000..a743aa8018
--- /dev/null
+++ b/t/t5411/test-0032-report-with-options.sh
@@ -0,0 +1,256 @@
+test_expect_success "setup proc-receive hook (option without matching ok, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "option refname refs/pull/123/head" \
+		-r "option old-oid $B"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
+test_expect_success "proc-receive: report option without matching ok ($PROTOCOL)" '
+	test_must_fail git -C workbench push origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> option refname refs/pull/123/head
+	remote: proc-receive> option old-oid <COMMIT-B>
+	remote: error: proc-receive reported "option" without a matching "ok/ng" directive
+	To <URL/of/upstream.git>
+	 ! [remote rejected] HEAD -> refs/for/master/topic (proc-receive failed to report status)
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (option refname, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/for/master/topic" \
+		-r "option refname refs/pull/123/head"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
+test_expect_success "proc-receive: report option refname ($PROTOCOL)" '
+	git -C workbench push origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> option refname refs/pull/123/head
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	To <URL/of/upstream.git>
+	 * [new reference] HEAD -> refs/for/master/topic
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (option refname and forced-update, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/for/master/topic" \
+		-r "option refname refs/pull/123/head" \
+		-r "option forced-update"
+	EOF
+'
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
+test_expect_success "proc-receive: report option refname and forced-update ($PROTOCOL)" '
+	git -C workbench push origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> option refname refs/pull/123/head
+	remote: proc-receive> option forced-update
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	To <URL/of/upstream.git>
+	 * [new reference] HEAD -> refs/for/master/topic
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (option refname and old-oid, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/for/master/topic" \
+		-r "option refname refs/pull/123/head" \
+		-r "option old-oid $B"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
+test_expect_success "proc-receive: report option refname and old-oid ($PROTOCOL)" '
+	git -C workbench push origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> option refname refs/pull/123/head
+	remote: proc-receive> option old-oid <COMMIT-B>
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	To <URL/of/upstream.git>
+	 * [new reference] HEAD -> refs/for/master/topic
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (option old-oid, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/for/master/topic" \
+		-r "option old-oid $B"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
+test_expect_success "proc-receive: report option old-oid ($PROTOCOL)" '
+	git -C workbench push origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> option old-oid <COMMIT-B>
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	To <URL/of/upstream.git>
+	 * [new reference] HEAD -> refs/for/master/topic
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (option old-oid and new-oid, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/for/master/topic" \
+		-r "option old-oid $A" \
+		-r "option new-oid $B"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
+test_expect_success "proc-receive: report option old-oid and new-oid ($PROTOCOL)" '
+	git -C workbench push origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> option old-oid <COMMIT-A>
+	remote: proc-receive> option new-oid <COMMIT-B>
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	To <URL/of/upstream.git>
+	 * [new reference] HEAD -> refs/for/master/topic
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (report with multiple rewrites, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/for/a/b/c/topic" \
+		-r "ok refs/for/next/topic" \
+		-r "option refname refs/pull/123/head" \
+		-r "ok refs/for/master/topic" \
+		-r "option refname refs/pull/124/head" \
+		-r "option old-oid $B" \
+		-r "option forced-update" \
+		-r "option new-oid $A"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
+test_expect_success "proc-receive: report with multiple rewrites ($PROTOCOL)" '
+	git -C workbench push origin \
+		HEAD:refs/for/next/topic \
+		HEAD:refs/for/a/b/c/topic \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> ok refs/for/a/b/c/topic
+	remote: proc-receive> ok refs/for/next/topic
+	remote: proc-receive> option refname refs/pull/123/head
+	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> option refname refs/pull/124/head
+	remote: proc-receive> option old-oid <COMMIT-B>
+	remote: proc-receive> option forced-update
+	remote: proc-receive> option new-oid <COMMIT-A>
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	To <URL/of/upstream.git>
+	 * [new reference] HEAD -> refs/for/next/topic
+	 * [new reference] HEAD -> refs/for/a/b/c/topic
+	 * [new reference] HEAD -> refs/for/master/topic
+	EOF
+	test_cmp expect actual &&
+
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
diff --git a/t/t5411/test-0033-report-with-options--porcelain.sh b/t/t5411/test-0033-report-with-options--porcelain.sh
new file mode 100644
index 0000000000..439b97b06e
--- /dev/null
+++ b/t/t5411/test-0033-report-with-options--porcelain.sh
@@ -0,0 +1,265 @@
+test_expect_success "setup proc-receive hook (option without matching ok, $PROTOCOL/porcelain)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "option refname refs/pull/123/head" \
+		-r "option old-oid $B"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
+test_expect_success "proc-receive: report option without matching ok ($PROTOCOL/porcelain)" '
+	test_must_fail git -C workbench push --porcelain origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> option refname refs/pull/123/head
+	remote: proc-receive> option old-oid <COMMIT-B>
+	remote: error: proc-receive reported "option" without a matching "ok/ng" directive
+	To <URL/of/upstream.git>
+	!    HEAD:refs/for/master/topic    [remote rejected] (proc-receive failed to report status)
+	Done
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (option refname, $PROTOCOL/porcelain)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/for/master/topic" \
+		-r "option refname refs/pull/123/head"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
+test_expect_success "proc-receive: report option refname ($PROTOCOL/porcelain)" '
+	git -C workbench push --porcelain origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> option refname refs/pull/123/head
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	To <URL/of/upstream.git>
+	*    HEAD:refs/for/master/topic    [new reference]
+	Done
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (option refname and forced-update, $PROTOCOL/porcelain)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/for/master/topic" \
+		-r "option refname refs/pull/123/head" \
+		-r "option forced-update"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
+test_expect_success "proc-receive: report option refname and forced-update ($PROTOCOL/porcelain)" '
+	git -C workbench push --porcelain origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> option refname refs/pull/123/head
+	remote: proc-receive> option forced-update
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	To <URL/of/upstream.git>
+	*    HEAD:refs/for/master/topic    [new reference]
+	Done
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (option refname and old-oid, $PROTOCOL/porcelain)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/for/master/topic" \
+		-r "option refname refs/pull/123/head" \
+		-r "option old-oid $B"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
+test_expect_success "proc-receive: report option refname and old-oid ($PROTOCOL/porcelain)" '
+	git -C workbench push --porcelain origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> option refname refs/pull/123/head
+	remote: proc-receive> option old-oid <COMMIT-B>
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	To <URL/of/upstream.git>
+	*    HEAD:refs/for/master/topic    [new reference]
+	Done
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (option old-oid, $PROTOCOL/porcelain)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/for/master/topic" \
+		-r "option old-oid $B"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
+test_expect_success "proc-receive: report option old-oid ($PROTOCOL/porcelain)" '
+	git -C workbench push --porcelain origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> option old-oid <COMMIT-B>
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	To <URL/of/upstream.git>
+	*    HEAD:refs/for/master/topic    [new reference]
+	Done
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (option old-oid and new-oid, $PROTOCOL/porcelain)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/for/master/topic" \
+		-r "option old-oid $A" \
+		-r "option new-oid $B"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
+test_expect_success "proc-receive: report option old-oid and new-oid ($PROTOCOL/porcelain)" '
+	git -C workbench push --porcelain origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> option old-oid <COMMIT-A>
+	remote: proc-receive> option new-oid <COMMIT-B>
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	To <URL/of/upstream.git>
+	*    HEAD:refs/for/master/topic    [new reference]
+	Done
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (report with multiple rewrites, $PROTOCOL/porcelain)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/for/a/b/c/topic" \
+		-r "ok refs/for/next/topic" \
+		-r "option refname refs/pull/123/head" \
+		-r "ok refs/for/master/topic" \
+		-r "option refname refs/pull/124/head" \
+		-r "option old-oid $B" \
+		-r "option forced-update" \
+		-r "option new-oid $A"
+
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
+test_expect_success "proc-receive: report with multiple rewrites ($PROTOCOL/porcelain)" '
+	git -C workbench push --porcelain origin \
+		HEAD:refs/for/next/topic \
+		HEAD:refs/for/a/b/c/topic \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> ok refs/for/a/b/c/topic
+	remote: proc-receive> ok refs/for/next/topic
+	remote: proc-receive> option refname refs/pull/123/head
+	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> option refname refs/pull/124/head
+	remote: proc-receive> option old-oid <COMMIT-B>
+	remote: proc-receive> option forced-update
+	remote: proc-receive> option new-oid <COMMIT-A>
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	To <URL/of/upstream.git>
+	*    HEAD:refs/for/next/topic    [new reference]
+	*    HEAD:refs/for/a/b/c/topic    [new reference]
+	*    HEAD:refs/for/master/topic    [new reference]
+	Done
+	EOF
+	test_cmp expect actual &&
+
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
diff --git a/t/t5411/test-0034-report-ft.sh b/t/t5411/test-0034-report-ft.sh
new file mode 100644
index 0000000000..aca2b0676c
--- /dev/null
+++ b/t/t5411/test-0034-report-ft.sh
@@ -0,0 +1,44 @@
+test_expect_success "setup proc-receive hook (ft, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/for/master/topic" \
+		-r "option fall-through"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/master/topic(B)
+test_expect_success "proc-receive: fall throught, let receive-pack to execute ($PROTOCOL)" '
+	git -C workbench push origin \
+		$B:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-B> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-B> refs/for/master/topic
+	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> option fall-through
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-B> refs/for/master/topic
+	To <URL/of/upstream.git>
+	 * [new reference] <COMMIT-B> -> refs/for/master/topic
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-B> refs/for/master/topic
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+# Refs of upstream : master(A)             refs/for/master/topic(A)
+# Refs of workbench: master(A)  tags/v123
+test_expect_success "cleanup ($PROTOCOL)" '
+	git -C "$upstream" update-ref -d refs/for/master/topic
+'
diff --git a/t/t5411/test-0035-report-ft--porcelain.sh b/t/t5411/test-0035-report-ft--porcelain.sh
new file mode 100644
index 0000000000..30ffffb352
--- /dev/null
+++ b/t/t5411/test-0035-report-ft--porcelain.sh
@@ -0,0 +1,45 @@
+test_expect_success "setup proc-receive hook (fall-through, $PROTOCOL/porcelain)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/for/master/topic" \
+		-r "option fall-through"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/master/topic(B)
+test_expect_success "proc-receive: fall throught, let receive-pack to execute ($PROTOCOL/porcelain)" '
+	git -C workbench push --porcelain origin \
+		$B:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-B> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-B> refs/for/master/topic
+	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> option fall-through
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-B> refs/for/master/topic
+	To <URL/of/upstream.git>
+	*    <COMMIT-B>:refs/for/master/topic    [new reference]
+	Done
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-B> refs/for/master/topic
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+# Refs of upstream : master(A)             refs/for/master/topic(A)
+# Refs of workbench: master(A)  tags/v123
+test_expect_success "cleanup ($PROTOCOL/porcelain)" '
+	git -C "$upstream" update-ref -d refs/for/master/topic
+'
diff --git a/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh b/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
new file mode 100644
index 0000000000..12acf9ea1f
--- /dev/null
+++ b/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
@@ -0,0 +1,159 @@
+test_expect_success "setup proc-receive hook (multiple rewrites for one ref, no refname for the 1st rewrite, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/for/master/topic" \
+		-r "option old-oid $A" \
+		-r "option new-oid $B" \
+		-r "ok refs/for/master/topic" \
+		-r "option refname refs/changes/24/124/1" \
+		-r "option old-oid $ZERO_OID" \
+		-r "option new-oid $A" \
+		-r "ok refs/for/master/topic" \
+		-r "option refname refs/changes/25/125/1" \
+		-r "option old-oid $A" \
+		-r "option new-oid $B"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/master/topic(A)
+test_expect_success "proc-receive: multiple rewrite for one ref, no refname for the 1st rewrite ($PROTOCOL)" '
+	git -C workbench push origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> option old-oid <COMMIT-A>
+	remote: proc-receive> option new-oid <COMMIT-B>
+	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> option refname refs/changes/24/124/1
+	remote: proc-receive> option old-oid <ZERO-OID>
+	remote: proc-receive> option new-oid <COMMIT-A>
+	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> option refname refs/changes/25/125/1
+	remote: proc-receive> option old-oid <COMMIT-A>
+	remote: proc-receive> option new-oid <COMMIT-B>
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
+test_expect_success "setup proc-receive hook (multiple rewrites for one ref, no refname for the 2nd rewrite, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/for/master/topic" \
+		-r "option refname refs/changes/24/124/1" \
+		-r "option old-oid $ZERO_OID" \
+		-r "option new-oid $A" \
+		-r "ok refs/for/master/topic" \
+		-r "option old-oid $A" \
+		-r "option new-oid $B" \
+		-r "ok refs/for/master/topic" \
+		-r "option refname refs/changes/25/125/1" \
+		-r "option old-oid $B" \
+		-r "option new-oid $A" \
+		-r "option forced-update"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/master/topic(A)
+test_expect_success "proc-receive: multiple rewrites for one ref, no refname for the 2nd rewrite ($PROTOCOL)" '
+	git -C workbench push origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> option refname refs/changes/24/124/1
+	remote: proc-receive> option old-oid <ZERO-OID>
+	remote: proc-receive> option new-oid <COMMIT-A>
+	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> option old-oid <COMMIT-A>
+	remote: proc-receive> option new-oid <COMMIT-B>
+	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> option refname refs/changes/25/125/1
+	remote: proc-receive> option old-oid <COMMIT-B>
+	remote: proc-receive> option new-oid <COMMIT-A>
+	remote: proc-receive> option forced-update
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
+test_expect_success "setup proc-receive hook (multiple rewrites for one ref, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/for/master/topic" \
+		-r "option refname refs/changes/23/123/1" \
+		-r "ok refs/for/master/topic" \
+		-r "option refname refs/changes/24/124/2" \
+		-r "option old-oid $A" \
+		-r "option new-oid $B"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/master/topic(A)
+test_expect_success "proc-receive: multiple rewrites for one ref ($PROTOCOL)" '
+	git -C workbench push origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> option refname refs/changes/23/123/1
+	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> option refname refs/changes/24/124/2
+	remote: proc-receive> option old-oid <COMMIT-A>
+	remote: proc-receive> option new-oid <COMMIT-B>
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
diff --git a/t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh b/t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh
new file mode 100644
index 0000000000..f4a2c56e14
--- /dev/null
+++ b/t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh
@@ -0,0 +1,162 @@
+test_expect_success "setup proc-receive hook (multiple rewrites for one ref, no refname for the 1st rewrite, $PROTOCOL/porcelain)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/for/master/topic" \
+		-r "option old-oid $A" \
+		-r "option new-oid $B" \
+		-r "ok refs/for/master/topic" \
+		-r "option refname refs/changes/24/124/1" \
+		-r "option old-oid $ZERO_OID" \
+		-r "option new-oid $A" \
+		-r "ok refs/for/master/topic" \
+		-r "option refname refs/changes/25/125/1" \
+		-r "option old-oid $A" \
+		-r "option new-oid $B"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/master/topic(A)
+test_expect_success "proc-receive: multiple rewrite for one ref, no refname for the 1st rewrite ($PROTOCOL/porcelain)" '
+	git -C workbench push --porcelain origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> option old-oid <COMMIT-A>
+	remote: proc-receive> option new-oid <COMMIT-B>
+	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> option refname refs/changes/24/124/1
+	remote: proc-receive> option old-oid <ZERO-OID>
+	remote: proc-receive> option new-oid <COMMIT-A>
+	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> option refname refs/changes/25/125/1
+	remote: proc-receive> option old-oid <COMMIT-A>
+	remote: proc-receive> option new-oid <COMMIT-B>
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	To <URL/of/upstream.git>
+	*    HEAD:refs/for/master/topic    [new reference]
+	Done
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
+test_expect_success "setup proc-receive hook (multiple rewrites for one ref, no refname for the 2nd rewrite, $PROTOCOL/porcelain)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/for/master/topic" \
+		-r "option refname refs/changes/24/124/1" \
+		-r "option old-oid $ZERO_OID" \
+		-r "option new-oid $A" \
+		-r "ok refs/for/master/topic" \
+		-r "option old-oid $A" \
+		-r "option new-oid $B" \
+		-r "ok refs/for/master/topic" \
+		-r "option refname refs/changes/25/125/1" \
+		-r "option old-oid $B" \
+		-r "option new-oid $A" \
+		-r "option forced-update"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/master/topic(A)
+test_expect_success "proc-receive: multiple rewrites for one ref, no refname for the 2nd rewrite ($PROTOCOL/porcelain)" '
+	git -C workbench push --porcelain origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> option refname refs/changes/24/124/1
+	remote: proc-receive> option old-oid <ZERO-OID>
+	remote: proc-receive> option new-oid <COMMIT-A>
+	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> option old-oid <COMMIT-A>
+	remote: proc-receive> option new-oid <COMMIT-B>
+	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> option refname refs/changes/25/125/1
+	remote: proc-receive> option old-oid <COMMIT-B>
+	remote: proc-receive> option new-oid <COMMIT-A>
+	remote: proc-receive> option forced-update
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	To <URL/of/upstream.git>
+	*    HEAD:refs/for/master/topic    [new reference]
+	Done
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
+test_expect_success "setup proc-receive hook (multiple rewrites for one ref, $PROTOCOL/porcelain)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/for/master/topic" \
+		-r "option refname refs/changes/23/123/1" \
+		-r "ok refs/for/master/topic" \
+		-r "option refname refs/changes/24/124/2" \
+		-r "option old-oid $A" \
+		-r "option new-oid $B"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/master/topic(A)
+test_expect_success "proc-receive: multiple rewrites for one ref ($PROTOCOL/porcelain)" '
+	git -C workbench push --porcelain origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> option refname refs/changes/23/123/1
+	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> option refname refs/changes/24/124/2
+	remote: proc-receive> option old-oid <COMMIT-A>
+	remote: proc-receive> option new-oid <COMMIT-B>
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	To <URL/of/upstream.git>
+	*    HEAD:refs/for/master/topic    [new reference]
+	Done
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
diff --git a/t/t5411/test-0038-report-mixed-refs.sh b/t/t5411/test-0038-report-mixed-refs.sh
new file mode 100644
index 0000000000..1dd6a97a97
--- /dev/null
+++ b/t/t5411/test-0038-report-mixed-refs.sh
@@ -0,0 +1,89 @@
+test_expect_success "setup proc-receive hook ($PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/for/next/topic2" \
+		-r "ng refs/for/next/topic1 fail to call Web API" \
+		-r "ok refs/for/master/topic" \
+		-r "option refname refs/for/master/topic" \
+		-r "option old-oid $A" \
+		-r "option new-oid $B"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         : (B)                   bar(A)  baz(A)  refs/for/next/topic(A)  foo(A)  refs/for/master/topic(A)
+test_expect_success "proc-receive: report update of mixed refs ($PROTOCOL)" '
+	test_must_fail git -C workbench push origin \
+		$B:refs/heads/master \
+		HEAD:refs/heads/bar \
+		HEAD:refs/heads/baz \
+		HEAD:refs/for/next/topic2 \
+		HEAD:refs/for/next/topic1 \
+		HEAD:refs/heads/foo \
+		HEAD:refs/for/master/topic \
+		HEAD:refs/for/next/topic3 \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/bar
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic2
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic1
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic3
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic2
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic1
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic3
+	remote: proc-receive> ok refs/for/next/topic2
+	remote: proc-receive> ng refs/for/next/topic1 fail to call Web API
+	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> option refname refs/for/master/topic
+	remote: proc-receive> option old-oid <COMMIT-A>
+	remote: proc-receive> option new-oid <COMMIT-B>
+	remote: # post-receive hook
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/bar
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic2
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	To <URL/of/upstream.git>
+	 <OID-A>..<OID-B> <COMMIT-B> -> master
+	 * [new branch] HEAD -> bar
+	 * [new branch] HEAD -> baz
+	 * [new reference] HEAD -> refs/for/next/topic2
+	 * [new branch] HEAD -> foo
+	 * [new reference] HEAD -> refs/for/master/topic
+	 ! [remote rejected] HEAD -> refs/for/next/topic1 (fail to call Web API)
+	 ! [remote rejected] HEAD -> refs/for/next/topic3 (proc-receive failed to report status)
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/bar
+	<COMMIT-A> refs/heads/baz
+	<COMMIT-A> refs/heads/foo
+	<COMMIT-B> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+# Refs of upstream : master(B)             foo(A)  bar(A))  baz(A)
+# Refs of workbench: master(A)  tags/v123
+test_expect_success "cleanup ($PROTOCOL)" '
+	(
+		cd "$upstream" &&
+		git update-ref refs/heads/master $A &&
+		git update-ref -d refs/heads/foo &&
+		git update-ref -d refs/heads/bar &&
+		git update-ref -d refs/heads/baz
+	)
+'
diff --git a/t/t5411/test-0039-report-mixed-refs--porcelain.sh b/t/t5411/test-0039-report-mixed-refs--porcelain.sh
new file mode 100644
index 0000000000..32ebf63dcf
--- /dev/null
+++ b/t/t5411/test-0039-report-mixed-refs--porcelain.sh
@@ -0,0 +1,91 @@
+test_expect_success "setup proc-receive hook ($PROTOCOL/porcelain)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/for/next/topic2" \
+		-r "ng refs/for/next/topic1 fail to call Web API" \
+		-r "ok refs/for/master/topic" \
+		-r "option refname refs/for/master/topic" \
+		-r "option old-oid $A" \
+		-r "option new-oid $B"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         : (B)                   bar(A)  baz(A)  refs/for/next/topic(A)  foo(A)  refs/for/master/topic(A)
+test_expect_success "proc-receive: report update of mixed refs ($PROTOCOL/porcelain)" '
+	test_must_fail git -C workbench push --porcelain origin \
+		$B:refs/heads/master \
+		HEAD:refs/heads/bar \
+		HEAD:refs/heads/baz \
+		HEAD:refs/for/next/topic2 \
+		HEAD:refs/for/next/topic1 \
+		HEAD:refs/heads/foo \
+		HEAD:refs/for/master/topic \
+		HEAD:refs/for/next/topic3 \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/bar
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic2
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic1
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic3
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic2
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic1
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic3
+	remote: proc-receive> ok refs/for/next/topic2
+	remote: proc-receive> ng refs/for/next/topic1 fail to call Web API
+	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> option refname refs/for/master/topic
+	remote: proc-receive> option old-oid <COMMIT-A>
+	remote: proc-receive> option new-oid <COMMIT-B>
+	remote: # post-receive hook
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/bar
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic2
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	To <URL/of/upstream.git>
+	     <COMMIT-B>:refs/heads/master    <OID-A>..<OID-B>
+	*    HEAD:refs/heads/bar    [new branch]
+	*    HEAD:refs/heads/baz    [new branch]
+	*    HEAD:refs/for/next/topic2    [new reference]
+	*    HEAD:refs/heads/foo    [new branch]
+	*    HEAD:refs/for/master/topic    [new reference]
+	!    HEAD:refs/for/next/topic1    [remote rejected] (fail to call Web API)
+	!    HEAD:refs/for/next/topic3    [remote rejected] (proc-receive failed to report status)
+	Done
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/bar
+	<COMMIT-A> refs/heads/baz
+	<COMMIT-A> refs/heads/foo
+	<COMMIT-B> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+# Refs of upstream : master(B)             foo(A)  bar(A))  baz(A)
+# Refs of workbench: master(A)  tags/v123
+test_expect_success "cleanup ($PROTOCOL/porcelain)" '
+	(
+		cd "$upstream" &&
+		git update-ref refs/heads/master $A &&
+		git update-ref -d refs/heads/foo &&
+		git update-ref -d refs/heads/bar &&
+		git update-ref -d refs/heads/baz
+	)
+
+'
-- 
2.26.2.543.ge7de2a6e37

