Return-Path: <SRS0=qItC=6C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D839C3A5A0
	for <git@archiver.kernel.org>; Sat, 18 Apr 2020 16:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CC3421D6C
	for <git@archiver.kernel.org>; Sat, 18 Apr 2020 16:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJf30fSc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgDRQEF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Apr 2020 12:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726907AbgDRQDy (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 18 Apr 2020 12:03:54 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F1CC061A0F
        for <git@vger.kernel.org>; Sat, 18 Apr 2020 09:03:54 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d1so2687458pfh.1
        for <git@vger.kernel.org>; Sat, 18 Apr 2020 09:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FkN3azort0vMzqBc2oKYFKfI73U1BHF84Jk99SFKhyE=;
        b=DJf30fScyj8KS13timX7ls05LHG0O1MAj35Vn+93U56fYS1UHtFa5TR/ymmO4urRTH
         08ls4ayUy/9/tr9TdepMwl+8yDSVf8iPbmfZ2umLjOPdrWwyAR1MCqPUoxZS7H0nudVx
         TCh9ILpzB7p0ls/9mT3TAk5RT4V+z5syGtkE9GddN21wMJFG+bf7aAigekcaJiuwJPcX
         Mc6ZQiTrH6YcB0LReksJws3Lhd+Zj9ToBGnNHUAJig/1FmKC2MJmlNn8Q2wPxAoFaruz
         gvy7ldqYsHnbFMq5ta01Z+XVdIdrMZcd/t7OBu36vKgO+ND3ig5K2lm+ymtHQMTv76ze
         SETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FkN3azort0vMzqBc2oKYFKfI73U1BHF84Jk99SFKhyE=;
        b=jMYfJbLxrxpoe8doKj52OZekURiqh0+0H/vGzAtp5T2OjSYL4086dUZQ8W1oUXgxmi
         aohCYhTntJpVXcGKs/mBuxV26Q2ZSLDRVJE48KfotrAOZKEZBI79OcHFruX8q728GAun
         snK/bboSWqVp+Zd+B1pOyDQq6Oj/GGSGIEyYzv+fnw1Qwtn0z5HTW2fLs4G72CT4qQpB
         iDo6ViaW2jc6XaJLqWzNUbe8SA5k6VIPYfgdODqNyc6HLGKgI7xMjHEEgTQHku2pAns0
         2sSFj0rICjfni7FXm3MUsvFHB+BFCTHcdaRi5hanXBd1PxPBmW+qXH/VzBXtE6G4CM1f
         bEFA==
X-Gm-Message-State: AGi0PuZGEbsY8Eh4V0/gNPUSlHZB1amP/LvgjbOkALWcLCAk3oagtmYO
        7Ik0Qn7goJ0HoVrlRYmp0wY=
X-Google-Smtp-Source: APiQypIeuJik0AhKbhmYkGDb7G5oTHYvgg5bXONz/JYhrgqlHp4NqIjpqk5QpCYO3GdZ+AVXW+tAdg==
X-Received: by 2002:a62:d119:: with SMTP id z25mr7443463pfg.153.1587225831950;
        Sat, 18 Apr 2020 09:03:51 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id i187sm22461649pfg.33.2020.04.18.09.03.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Apr 2020 09:03:51 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v13 3/8] receive-pack: add new proc-receive hook
Date:   Sat, 18 Apr 2020 12:03:29 -0400
Message-Id: <20200418160334.15631-4-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200414123257.27449-1-worldhello.net@gmail.com>
References: <20200414123257.27449-1-worldhello.net@gmail.com>
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
    H: PKT-LINE(ft <ref>)
    # OK, but has an alternate reference.  The alternate reference name
    # is given in the third parameter, and other status can be given in
    # key-value pairs.
    H: PKT-LINE(alt <ref> <alt-ref> old-oid=<old-oid> new-oid=<new-oid>
                forced-update)
    H: ... ...
    H: flush-pkt

After receiving a command, the hook will execute the command, and may
create/update different reference.  For example, a command for a pseudo
reference "refs/for/master/topic" may create/update different reference
such as "refs/pull/123/head".  The alternate reference name and other
status are given in key-value pairs as extended status of the report
line.

The list of commands returned from "proc-receive" will replace the
relevant commands that are sent from user to "receive-pack", and
"receive-pack" will continue to run the "execute_commands" function and
other routines.  Finally, the result of the execution of these commands
will be reported to end user.

The reporting function from "receive-pack" to "send-pack" is extended
using a backward compatible way by adding key-value pairs after an null
character, like:

    # OK, run this command successfully with optional extended-status.
    ok <reference>\0ref=refs/pull/123/head old-oid=...

    # NO, I reject it.
    ng <reference> <error message>

Parsing the extended status of the report lines for "send-pack" is not
implemented in this commit, so we can make a compatible test on old
version of a Git client.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 Makefile                                      |   1 +
 builtin/receive-pack.c                        | 356 +++++++++++++++++-
 t/helper/test-proc-receive.c                  | 175 +++++++++
 t/helper/test-tool.c                          |   1 +
 t/helper/test-tool.h                          |   1 +
 t/t5411/test-0011-no-hook-error.sh            |  64 ++++
 t/t5411/test-0012-no-hook-error--porcelain.sh |  66 ++++
 t/t5411/test-0013-bad-protocol.sh             | 225 +++++++++++
 t/t5411/test-0014-bad-protocol--porcelain.sh  | 160 ++++++++
 t/t5411/test-0020-report-ng.sh                |  67 ++++
 t/t5411/test-0021-report-ng--porcelain.sh     |  69 ++++
 t/t5411/test-0022-report-unexpect-ref.sh      |  45 +++
 ...est-0023-report-unexpect-ref--porcelain.sh |  46 +++
 t/t5411/test-0024-report-unknown-ref.sh       |  34 ++
 ...test-0025-report-unknown-ref--porcelain.sh |  35 ++
 t/t5411/test-0026-push-options.sh             |  79 ++++
 t/t5411/test-0027-push-options--porcelain.sh  |  82 ++++
 t/t5411/test-0030-report-ok.sh                |  35 ++
 t/t5411/test-0031-report-ok--porcelain.sh     |  36 ++
 t/t5411/test-0032-report-alt.sh               | 229 +++++++++++
 t/t5411/test-0033-report-alt--porcelain.sh    | 236 ++++++++++++
 t/t5411/test-0034-report-ft.sh                |  42 +++
 t/t5411/test-0035-report-ft--porcelain.sh     |  43 +++
 .../test-0036-report-multi-alt-for-one-ref.sh | 155 ++++++++
 ...report-multi-alt-for-one-ref--porcelain.sh | 159 ++++++++
 t/t5411/test-0038-report-mixed-refs.sh        |  74 ++++
 .../test-0039-report-mixed-refs--porcelain.sh |  75 ++++
 27 files changed, 2581 insertions(+), 9 deletions(-)
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
 create mode 100644 t/t5411/test-0032-report-alt.sh
 create mode 100644 t/t5411/test-0033-report-alt--porcelain.sh
 create mode 100644 t/t5411/test-0034-report-ft.sh
 create mode 100644 t/t5411/test-0035-report-ft--porcelain.sh
 create mode 100644 t/t5411/test-0036-report-multi-alt-for-one-ref.sh
 create mode 100644 t/t5411/test-0037-report-multi-alt-for-one-ref--porcelain.sh
 create mode 100644 t/t5411/test-0038-report-mixed-refs.sh
 create mode 100644 t/t5411/test-0039-report-mixed-refs--porcelain.sh

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
index 2cc18bbffd..0081bf1415 100644
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
+	const char *extended_status;
 	unsigned int skip_update:1,
-		     did_not_exist:1;
+		     did_not_exist:1,
+		     run_proc_receive:2;
 	int index;
 	struct object_id old_oid;
 	struct object_id new_oid;
@@ -817,6 +821,307 @@ static int run_update_hook(struct command *cmd)
 	return finish_command(&proc);
 }
 
+static struct command *find_command_by_refname(const struct command *list,
+					       const char *refname)
+{
+	for (; list; list = list->next)
+		if (!strcmp(list->ref_name, refname))
+			return (struct command *)list;
+	return NULL;
+}
+
+static int read_proc_receive_report(struct packet_reader *reader,
+				    struct command *commands,
+				    struct strbuf *errmsg)
+{
+	struct command *cmd;
+	struct command *hint = NULL;
+	struct strbuf extended_status = STRBUF_INIT;
+	int code = 0;
+
+	for (;;) {
+		struct object_id old_oid, new_oid;
+		const char *status;
+		char *refname;
+		char *remains = NULL;
+
+		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
+			break;
+		status = reader->line;
+		refname = strchr(status, ' ');
+		if (refname) {
+			*refname++ = '\0';
+			remains = strchr(refname, ' ');
+			if (remains)
+				*remains++ = '\0';
+		}
+		if (!refname || strlen(refname) == 0) {
+			strbuf_addf(errmsg, "proc-receive expected '<status> <ref> ...', got '%s'\n",
+				    reader->line);
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
+			continue;
+		}
+		if (!hint->run_proc_receive) {
+			strbuf_addf(errmsg, "proc-receive reported status on unexpected ref: %s\n",
+				    refname);
+			continue;
+		}
+		if (!strcmp(status, "ng")) {
+			if (remains)
+				hint->error_string = xstrdup(remains);
+			else
+				hint->error_string = "failed";
+			code = -1;
+		} else if (!strcmp("ft", status)) {
+			/* Reset "run_proc_receive" field, and continue to run in "receive-pack" */
+			hint->run_proc_receive = 0;
+		} else if (!strcmp("alt", status)) {
+			char *alt_ref = NULL;
+			char *p1, *p2;
+
+			if (!remains) {
+				strbuf_addf(errmsg, "proc-receive expected 'alt <ref> <alt-ref> ...', got 'alt %s'\n",
+					    refname);
+				continue;
+			}
+			p1 = strchr(remains, '=');
+			p2 = strchr(remains, ' ');
+			if (!p1) {
+				/*
+				 * "alt <ref> <alt-ref>", or
+				 * "alt <ref> <alt-ref> forced-update"
+				 */
+				alt_ref = remains;
+				remains = p2;
+				if (remains)
+					*remains++ = '\0';
+			} else if (!p2) {
+				/* "alt <ref> old-oid=<oid>" */
+				alt_ref = NULL;
+			} else if (p1 > p2) {
+				/* "alt <ref> <alt-ref> old-oid=<oid>" */
+				alt_ref = remains;
+				remains = p2;
+				if (remains)
+					*remains++ = '\0';
+			} else {
+				/* "alt <ref> old-oid=<oid1> new-oid=<oid2>" */
+				alt_ref = NULL;
+			}
+
+			if (hint->extended_status)
+				strbuf_addstr(&extended_status, hint->extended_status);
+
+			/*
+			 * Already received an "ok <ref>" response, add an
+			 * additional "ref=<ref>" field.
+			 */
+			if (extended_status.len == 0 &&
+			    hint->run_proc_receive & RUN_PROC_RECEIVE_RETURNED)
+				strbuf_addf(&extended_status, "ref=%s", refname);
+
+			if (alt_ref)
+				strbuf_addf(&extended_status, "%sref=%s",
+					    extended_status.len > 0 ? " ": "",
+					    alt_ref);
+			else if (extended_status.len > 0)
+				/*
+				 * Start new extended status for refname, if it
+				 * is not the first report for this reference.
+				 */
+				strbuf_addf(&extended_status, " ref=%s", refname);
+
+			if (remains) {
+				const char *val;
+				int len;
+
+				val = parse_feature_value(remains, "old-oid", &len);
+				if (val && len > 0)
+					if (!parse_oid_hex(val, &old_oid, &val))
+						strbuf_addf(&extended_status, "%sold-oid=%s",
+							   extended_status.len > 0 ? " ": "",
+							   oid_to_hex(&old_oid));
+
+				val = parse_feature_value(remains, "new-oid", &len);
+				if (val && len > 0)
+					if (!parse_oid_hex(val, &new_oid, &val))
+						strbuf_addf(&extended_status, "%snew-oid=%s",
+							   extended_status.len > 0 ? " ": "",
+							   oid_to_hex(&new_oid));
+
+				if (parse_feature_request(remains, "forced-update"))
+					strbuf_addf(&extended_status, "%sforced-update",
+						    extended_status.len > 0 ? " ": "");
+			}
+
+			if (extended_status.len > 0) {
+				free((void *)hint->extended_status);
+				hint->extended_status = strbuf_detach(&extended_status, NULL);
+			}
+		} else if (strcmp("ok", status)) {
+			strbuf_addf(errmsg, "proc-receive reported bad status '%s' on ref '%s'\n",
+				    status, refname);
+			code = -1;
+			/* Skip marking it as RUN_PROC_RECEIVE_RETURNED */
+			continue;
+		}
+
+		if (hint->run_proc_receive)
+			hint->run_proc_receive |= RUN_PROC_RECEIVE_RETURNED;
+	}
+
+	for (cmd = commands; cmd; cmd = cmd->next)
+		if (cmd->run_proc_receive && !cmd->error_string &&
+		    !(cmd->run_proc_receive & RUN_PROC_RECEIVE_RETURNED)) {
+		    cmd->error_string = "proc-receive failed to report status";
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
+	if (pr_use_push_options) {
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
@@ -1392,7 +1697,7 @@ static void execute_commands_non_atomic(struct command *commands,
 	struct strbuf err = STRBUF_INIT;
 
 	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (!should_process_cmd(cmd))
+		if (!should_process_cmd(cmd) || cmd->run_proc_receive)
 			continue;
 
 		transaction = ref_transaction_begin(&err);
@@ -1432,7 +1737,7 @@ static void execute_commands_atomic(struct command *commands,
 	}
 
 	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (!should_process_cmd(cmd))
+		if (!should_process_cmd(cmd) || cmd->run_proc_receive)
 			continue;
 
 		cmd->error_string = update(cmd, si);
@@ -1468,6 +1773,7 @@ static void execute_commands(struct command *commands,
 	struct iterate_data data;
 	struct async muxer;
 	int err_fd = 0;
+	int run_proc_receive = 0;
 
 	if (unpacker_error) {
 		for (cmd = commands; cmd; cmd = cmd->next)
@@ -1497,6 +1803,21 @@ static void execute_commands(struct command *commands,
 
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
@@ -1523,6 +1844,12 @@ static void execute_commands(struct command *commands,
 	free(head_name_to_free);
 	head_name = head_name_to_free = resolve_refdup("HEAD", 0, NULL, NULL);
 
+	if (run_proc_receive &&
+	    run_proc_receive_hook(commands, push_options))
+		for (cmd = commands; cmd; cmd = cmd->next)
+			if (!cmd->error_string  && (cmd->run_proc_receive || use_atomic))
+				cmd->error_string = "fail to run proc-receive hook";
+
 	if (use_atomic)
 		execute_commands_atomic(commands, si);
 	else
@@ -1899,12 +2226,23 @@ static void report(struct command *commands, const char *unpack_status)
 	packet_buf_write(&buf, "unpack %s\n",
 			 unpack_status ? unpack_status : "ok");
 	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (!cmd->error_string)
-			packet_buf_write(&buf, "ok %s\n",
-					 cmd->ref_name);
-		else
-			packet_buf_write(&buf, "ng %s %s\n",
-					 cmd->ref_name, cmd->error_string);
+		if (!cmd->error_string) {
+			if (cmd->extended_status)
+				packet_buf_write(&buf, "ok %s%c%s\n",
+						 cmd->ref_name, '\0',
+						 cmd->extended_status);
+			else
+				packet_buf_write(&buf, "ok %s\n",
+						 cmd->ref_name);
+		} else {
+			if (cmd->extended_status)
+				packet_buf_write(&buf, "ng %s %s%c%s\n",
+						 cmd->ref_name, cmd->error_string,
+						 '\0', cmd->extended_status);
+			else
+				packet_buf_write(&buf, "ng %s %s\n",
+						 cmd->ref_name, cmd->error_string);
+		}
 	}
 	packet_buf_flush(&buf);
 
diff --git a/t/helper/test-proc-receive.c b/t/helper/test-proc-receive.c
new file mode 100644
index 0000000000..6ace1863b0
--- /dev/null
+++ b/t/helper/test-proc-receive.c
@@ -0,0 +1,175 @@
+#include "cache.h"
+#include "connect.h"
+#include "parse-options.h"
+#include "pkt-line.h"
+#include "sigchain.h"
+#include "string-list.h"
+#include "test-tool.h"
+
+static const char *proc_receive_usage[] = {
+	"test-tool proc-receive [<options>...]",
+	NULL
+};
+
+static int die_version = 0;
+static int die_readline = 0;
+static int no_push_options = 0;
+static int use_atomic = 0;
+static int use_push_options = 0;
+static int verbose = 0;
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
+	argc = parse_options(argc, argv, "test-tools", options, proc_receive_usage, 0);
+	if (argc > 0)
+		usage_msg_opt("Too many arguments.", proc_receive_usage, options);
+
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
index 0000000000..e3bd0962ab
--- /dev/null
+++ b/t/t5411/test-0012-no-hook-error--porcelain.sh
@@ -0,0 +1,66 @@
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       next(A)  refs/for/master/topic(A)
+test_expect_success "proc-receive: no hook, fail to push special ref (--porcelain, $PROTOCOL)" '
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
+test_expect_success "cleanup ($PROTOCOL)" '
+	git -C "$upstream" update-ref -d refs/heads/next
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push --atomic: (B)                   next(A)  refs/for/master/topic(A)
+test_expect_success "proc-receive: no hook, all failed for atomic push (--porcelain, $PROTOCOL)" '
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
index 0000000000..a375ddffd9
--- /dev/null
+++ b/t/t5411/test-0013-bad-protocol.sh
@@ -0,0 +1,225 @@
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
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: fatal: protocol error: expected "old new ref", got "<ZERO-OID> <COMMIT-A> refs/for/master/topic"
+	To <URL/of/upstream.git>
+	 ! [remote rejected] HEAD -> refs/for/master/topic (proc-receive failed to report status)
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
+	remote: error: proc-receive expected "<status> <ref> ...", got "ok"
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
index 0000000000..96bbed08fe
--- /dev/null
+++ b/t/t5411/test-0014-bad-protocol--porcelain.sh
@@ -0,0 +1,160 @@
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
+test_expect_success "proc-receive: bad protocol (unknown version, --porcelain, $PROTOCOL)" '
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
+test_expect_success "proc-receive: bad protocol (no report, --porcelain, $PROTOCOL)" '
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
+test_expect_success "proc-receive: bad protocol (no ref, --porcelain, $PROTOCOL)" '
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
+	remote: error: proc-receive expected "<status> <ref> ...", got "ok"
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
+test_expect_success "proc-receive: bad protocol (unknown status, --porcelain, $PROTOCOL)" '
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
index 0000000000..5c90d63287
--- /dev/null
+++ b/t/t5411/test-0021-report-ng--porcelain.sh
@@ -0,0 +1,69 @@
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
+test_expect_success "proc-receive: fail to update (ng, no message, --porcelain, $PROTOCOL)" '
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
+test_expect_success "proc-receive: fail to update (ng, with message, --porcelain, $PROTOCOL)" '
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
index 0000000000..f10715c2dc
--- /dev/null
+++ b/t/t5411/test-0023-report-unexpect-ref--porcelain.sh
@@ -0,0 +1,46 @@
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
+test_expect_success "proc-receive: report unexpected ref (--porcelain, $PROTOCOL)" '
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
+test_expect_success "cleanup ($PROTOCOL)" '
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
index 0000000000..b5a5d9b992
--- /dev/null
+++ b/t/t5411/test-0025-report-unknown-ref--porcelain.sh
@@ -0,0 +1,35 @@
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
+test_expect_success "proc-receive: report unknown reference (--porcelain, $PROTOCOL)" '
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
index 0000000000..243580db93
--- /dev/null
+++ b/t/t5411/test-0027-push-options--porcelain.sh
@@ -0,0 +1,82 @@
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
+test_expect_success "proc-receive: not support push options (--porcelain, $PROTOCOL)" '
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
+test_expect_success "enable push options ($PROTOCOL)" '
+	git -C "$upstream" config receive.advertisePushOptions true
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push -o ...  :                       next(A)  refs/for/master/topic
+test_expect_success "proc-receive: push with options (--porcelain, $PROTOCOL)" '
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
+test_expect_success "cleanup ($PROTOCOL)" '
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
index 0000000000..2a10bdc749
--- /dev/null
+++ b/t/t5411/test-0031-report-ok--porcelain.sh
@@ -0,0 +1,36 @@
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
+test_expect_success "proc-receive: ok (--porcelain, $PROTOCOL)" '
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
diff --git a/t/t5411/test-0032-report-alt.sh b/t/t5411/test-0032-report-alt.sh
new file mode 100644
index 0000000000..dec4afc4c1
--- /dev/null
+++ b/t/t5411/test-0032-report-alt.sh
@@ -0,0 +1,229 @@
+test_expect_success "setup proc-receive hook (alt <ref>, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "alt refs/for/master/topic"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
+test_expect_success "proc-receive: report alt (alt <ref>, $PROTOCOL)" '
+	test_must_fail git -C workbench push origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> alt refs/for/master/topic
+	remote: error: proc-receive expected "alt <ref> <alt-ref> ...", got "alt refs/for/master/topic"
+	To <URL/of/upstream.git>
+	 ! [remote rejected] HEAD -> refs/for/master/topic (proc-receive failed to report status)
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (alt <ref> <alt-ref>, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "alt refs/for/master/topic refs/pull/123/head"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
+test_expect_success "proc-receive: report alt (alt <ref> <alt-ref>, $PROTOCOL)" '
+	git -C workbench push origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> alt refs/for/master/topic refs/pull/123/head
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	To <URL/of/upstream.git>
+	 * [new reference] HEAD -> refs/for/master/topic
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (alt <ref> <alt-ref> forced-update, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "alt refs/for/master/topic refs/pull/123/head forced-update"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
+test_expect_success "proc-receive: report alt (alt <ref> <alt-ref> forced-update, $PROTOCOL)" '
+	git -C workbench push origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> alt refs/for/master/topic refs/pull/123/head forced-update
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	To <URL/of/upstream.git>
+	 * [new reference] HEAD -> refs/for/master/topic
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (alt <ref> <alt-ref> old-oid=X, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "alt refs/for/master/topic refs/pull/123/head old-oid=$B"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
+test_expect_success "proc-receive: report alt (alt <ref> <alt-ref> old-oid=X, $PROTOCOL)" '
+	git -C workbench push origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> alt refs/for/master/topic refs/pull/123/head old-oid=<COMMIT-B>
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	To <URL/of/upstream.git>
+	 * [new reference] HEAD -> refs/for/master/topic
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (alt <ref> old-oid=X, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "alt refs/for/master/topic old-oid=$B"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
+test_expect_success "proc-receive: report alt (alt <ref> old-oid=X, $PROTOCOL)" '
+	git -C workbench push origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> alt refs/for/master/topic old-oid=<COMMIT-B>
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	To <URL/of/upstream.git>
+	 * [new reference] HEAD -> refs/for/master/topic
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (alt <ref> old-oid=X new-oid=Y, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "alt refs/for/master/topic old-oid=$A new-oid=$B"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
+test_expect_success "proc-receive: report alt (alt <ref> old-oid=X new-oid=Y, $PROTOCOL)" '
+	git -C workbench push origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> alt refs/for/master/topic old-oid=<COMMIT-A> new-oid=<COMMIT-B>
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	To <URL/of/upstream.git>
+	 * [new reference] HEAD -> refs/for/master/topic
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (with multiple alt reports, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/for/a/b/c/topic" \
+		-r "alt refs/for/next/topic refs/pull/123/head" \
+		-r "alt refs/for/master/topic refs/pull/124/head old-oid=$B forced-update new-oid=$A"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
+test_expect_success "proc-receive: with multiple alt reports ($PROTOCOL)" '
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
+	remote: proc-receive> alt refs/for/next/topic refs/pull/123/head
+	remote: proc-receive> alt refs/for/master/topic refs/pull/124/head old-oid=<COMMIT-B> forced-update new-oid=<COMMIT-A>
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
diff --git a/t/t5411/test-0033-report-alt--porcelain.sh b/t/t5411/test-0033-report-alt--porcelain.sh
new file mode 100644
index 0000000000..49d76892ab
--- /dev/null
+++ b/t/t5411/test-0033-report-alt--porcelain.sh
@@ -0,0 +1,236 @@
+test_expect_success "setup proc-receive hook (alt <ref>, --porcelain, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "alt refs/for/master/topic"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
+test_expect_success "proc-receive: report alt (alt <ref>, --porcelain, $PROTOCOL)" '
+	test_must_fail git -C workbench push --porcelain origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> alt refs/for/master/topic
+	remote: error: proc-receive expected "alt <ref> <alt-ref> ...", got "alt refs/for/master/topic"
+	To <URL/of/upstream.git>
+	!    HEAD:refs/for/master/topic    [remote rejected] (proc-receive failed to report status)
+	Done
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (alt <ref> <alt-ref>, --porcelain, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "alt refs/for/master/topic refs/pull/123/head"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
+test_expect_success "proc-receive: report alt (alt <ref> <alt-ref>, --porcelain, $PROTOCOL)" '
+	git -C workbench push --porcelain origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> alt refs/for/master/topic refs/pull/123/head
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	To <URL/of/upstream.git>
+	*    HEAD:refs/for/master/topic    [new reference]
+	Done
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (alt <ref> <alt-ref> forced-update, --porcelain, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "alt refs/for/master/topic refs/pull/123/head forced-update"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
+test_expect_success "proc-receive: report alt (alt <ref> <alt-ref> forced-update, --porcelain, $PROTOCOL)" '
+	git -C workbench push --porcelain origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> alt refs/for/master/topic refs/pull/123/head forced-update
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	To <URL/of/upstream.git>
+	*    HEAD:refs/for/master/topic    [new reference]
+	Done
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (alt <ref> <alt-ref> old-oid=X, --porcelain, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "alt refs/for/master/topic refs/pull/123/head old-oid=$B"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
+test_expect_success "proc-receive: report alt (alt <ref> <alt-ref> old-oid=X, --porcelain, $PROTOCOL)" '
+	git -C workbench push --porcelain origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> alt refs/for/master/topic refs/pull/123/head old-oid=<COMMIT-B>
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	To <URL/of/upstream.git>
+	*    HEAD:refs/for/master/topic    [new reference]
+	Done
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (alt <ref> old-oid=X, --porcelain, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "alt refs/for/master/topic old-oid=$B"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
+test_expect_success "proc-receive: report alt (alt <ref> old-oid=X, --porcelain, $PROTOCOL)" '
+	git -C workbench push --porcelain origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> alt refs/for/master/topic old-oid=<COMMIT-B>
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	To <URL/of/upstream.git>
+	*    HEAD:refs/for/master/topic    [new reference]
+	Done
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (alt <ref> old-oid=X new-oid=Y, --porcelain, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "alt refs/for/master/topic old-oid=$A new-oid=$B"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
+test_expect_success "proc-receive: report alt (alt <ref> old-oid=X new-oid=Y, --porcelain, $PROTOCOL)" '
+	git -C workbench push --porcelain origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> alt refs/for/master/topic old-oid=<COMMIT-A> new-oid=<COMMIT-B>
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	To <URL/of/upstream.git>
+	*    HEAD:refs/for/master/topic    [new reference]
+	Done
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (with multiple alt reports, --porcelain, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/for/a/b/c/topic" \
+		-r "alt refs/for/next/topic refs/pull/123/head" \
+		-r "alt refs/for/master/topic refs/pull/124/head old-oid=$B forced-update new-oid=$A"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
+test_expect_success "proc-receive: with multiple alt reports (--porcelain, $PROTOCOL)" '
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
+	remote: proc-receive> alt refs/for/next/topic refs/pull/123/head
+	remote: proc-receive> alt refs/for/master/topic refs/pull/124/head old-oid=<COMMIT-B> forced-update new-oid=<COMMIT-A>
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
index 0000000000..a25fb0505e
--- /dev/null
+++ b/t/t5411/test-0034-report-ft.sh
@@ -0,0 +1,42 @@
+test_expect_success "setup proc-receive hook (ft, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ft refs/for/master/topic"
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
+	remote: proc-receive> ft refs/for/master/topic
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
index 0000000000..e5c6eae544
--- /dev/null
+++ b/t/t5411/test-0035-report-ft--porcelain.sh
@@ -0,0 +1,43 @@
+test_expect_success "setup proc-receive hook (ft, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ft refs/for/master/topic"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/master/topic(B)
+test_expect_success "proc-receive: fall throught, let receive-pack to execute (--porcelain, $PROTOCOL)" '
+	git -C workbench push --porcelain origin \
+		$B:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-B> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-B> refs/for/master/topic
+	remote: proc-receive> ft refs/for/master/topic
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
+test_expect_success "cleanup ($PROTOCOL)" '
+	git -C "$upstream" update-ref -d refs/for/master/topic
+'
diff --git a/t/t5411/test-0036-report-multi-alt-for-one-ref.sh b/t/t5411/test-0036-report-multi-alt-for-one-ref.sh
new file mode 100644
index 0000000000..fc019f709b
--- /dev/null
+++ b/t/t5411/test-0036-report-multi-alt-for-one-ref.sh
@@ -0,0 +1,155 @@
+test_expect_success "setup proc-receive hook (multiple alt, no alt-ref for the 1st resp, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "alt refs/for/master/topic old-oid=$A new-oid=$B" \
+		-r "alt refs/for/master/topic refs/changes/24/124/1 old-oid=$ZERO_OID new-oid=$A" \
+		-r "alt refs/for/master/topic refs/changes/25/125/1 old-oid=$A new-oid=$B"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/master/topic(A)
+test_expect_success "proc-receive: report multiple alt, no alt-ref for the 1st resp ($PROTOCOL)" '
+	git -C workbench push origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> alt refs/for/master/topic old-oid=<COMMIT-A> new-oid=<COMMIT-B>
+	remote: proc-receive> alt refs/for/master/topic refs/changes/24/124/1 old-oid=<ZERO-OID> new-oid=<COMMIT-A>
+	remote: proc-receive> alt refs/for/master/topic refs/changes/25/125/1 old-oid=<COMMIT-A> new-oid=<COMMIT-B>
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
+test_expect_success "setup proc-receive hook (multiple alt, no alt-ref for the 2nd resp, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "alt refs/for/master/topic refs/changes/24/124/1 old-oid=$ZERO_OID new-oid=$A" \
+		-r "alt refs/for/master/topic old-oid=$A new-oid=$B" \
+		-r "alt refs/for/master/topic refs/changes/25/125/1 old-oid=$B new-oid=$A forced-update"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/master/topic(A)
+test_expect_success "proc-receive: report multiple alt, no alt-ref for the 2nd resp ($PROTOCOL)" '
+	git -C workbench push origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> alt refs/for/master/topic refs/changes/24/124/1 old-oid=<ZERO-OID> new-oid=<COMMIT-A>
+	remote: proc-receive> alt refs/for/master/topic old-oid=<COMMIT-A> new-oid=<COMMIT-B>
+	remote: proc-receive> alt refs/for/master/topic refs/changes/25/125/1 old-oid=<COMMIT-B> new-oid=<COMMIT-A> forced-update
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
+test_expect_success "setup proc-receive hook (ok and alt for the same ref, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/for/master/topic" \
+		-r "alt refs/for/master/topic refs/changes/24/124/1 new-oid=$B old-oid=$A"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/master/topic(A)
+test_expect_success "proc-receive: report ok and alt for the same ref ($PROTOCOL)" '
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
+	remote: proc-receive> alt refs/for/master/topic refs/changes/24/124/1 new-oid=<COMMIT-B> old-oid=<COMMIT-A>
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
+test_expect_success "setup proc-receive hook (multiple responses, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "alt refs/for/master/topic refs/changes/23/123/1" \
+		-r "alt refs/for/master/topic refs/changes/24/124/2 old-oid=$A new-oid=$B"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/master/topic(A)
+test_expect_success "proc-receive: report multiple response ($PROTOCOL)" '
+	git -C workbench push origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> alt refs/for/master/topic refs/changes/23/123/1
+	remote: proc-receive> alt refs/for/master/topic refs/changes/24/124/2 old-oid=<COMMIT-A> new-oid=<COMMIT-B>
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
diff --git a/t/t5411/test-0037-report-multi-alt-for-one-ref--porcelain.sh b/t/t5411/test-0037-report-multi-alt-for-one-ref--porcelain.sh
new file mode 100644
index 0000000000..22607b135e
--- /dev/null
+++ b/t/t5411/test-0037-report-multi-alt-for-one-ref--porcelain.sh
@@ -0,0 +1,159 @@
+test_expect_success "setup proc-receive hook (multiple alt, no alt-ref for the 1st resp, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "alt refs/for/master/topic old-oid=$A new-oid=$B" \
+		-r "alt refs/for/master/topic refs/changes/24/124/1 old-oid=$ZERO_OID new-oid=$A" \
+		-r "alt refs/for/master/topic refs/changes/25/125/1 old-oid=$A new-oid=$B"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/master/topic(A)
+test_expect_success "proc-receive: report multiple alt, no alt-ref for the 1st resp (--porcelain, $PROTOCOL)" '
+	git -C workbench push --porcelain origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> alt refs/for/master/topic old-oid=<COMMIT-A> new-oid=<COMMIT-B>
+	remote: proc-receive> alt refs/for/master/topic refs/changes/24/124/1 old-oid=<ZERO-OID> new-oid=<COMMIT-A>
+	remote: proc-receive> alt refs/for/master/topic refs/changes/25/125/1 old-oid=<COMMIT-A> new-oid=<COMMIT-B>
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
+test_expect_success "setup proc-receive hook (multiple alt, no alt-ref for the 2nd resp, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "alt refs/for/master/topic refs/changes/24/124/1 old-oid=$ZERO_OID new-oid=$A" \
+		-r "alt refs/for/master/topic old-oid=$A new-oid=$B" \
+		-r "alt refs/for/master/topic refs/changes/25/125/1 old-oid=$B new-oid=$A forced-update"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/master/topic(A)
+test_expect_success "proc-receive: report multiple alt, no alt-ref for the 2nd resp (--porcelain, $PROTOCOL)" '
+	git -C workbench push --porcelain origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> alt refs/for/master/topic refs/changes/24/124/1 old-oid=<ZERO-OID> new-oid=<COMMIT-A>
+	remote: proc-receive> alt refs/for/master/topic old-oid=<COMMIT-A> new-oid=<COMMIT-B>
+	remote: proc-receive> alt refs/for/master/topic refs/changes/25/125/1 old-oid=<COMMIT-B> new-oid=<COMMIT-A> forced-update
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
+test_expect_success "setup proc-receive hook (ok and alt for the same ref, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/for/master/topic" \
+		-r "alt refs/for/master/topic refs/changes/24/124/1 new-oid=$B old-oid=$A"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/master/topic(A)
+test_expect_success "proc-receive: report ok and alt for the same ref (--porcelain, $PROTOCOL)" '
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
+	remote: proc-receive> alt refs/for/master/topic refs/changes/24/124/1 new-oid=<COMMIT-B> old-oid=<COMMIT-A>
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
+test_expect_success "setup proc-receive hook (multiple responses, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "alt refs/for/master/topic refs/changes/23/123/1" \
+		-r "alt refs/for/master/topic refs/changes/24/124/2 old-oid=$A new-oid=$B"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/master/topic(A)
+test_expect_success "proc-receive: report multiple response (--porcelain, $PROTOCOL)" '
+	git -C workbench push --porcelain origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> alt refs/for/master/topic refs/changes/23/123/1
+	remote: proc-receive> alt refs/for/master/topic refs/changes/24/124/2 old-oid=<COMMIT-A> new-oid=<COMMIT-B>
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
index 0000000000..dd03bf1538
--- /dev/null
+++ b/t/t5411/test-0038-report-mixed-refs.sh
@@ -0,0 +1,74 @@
+test_expect_success "setup proc-receive hook ($PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/for/next/topic" \
+		-r "alt refs/for/master/topic refs/for/master/topic old-oid=$A new-oid=$B"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         : (B)                   bar(A)  baz(A)  refs/for/next/topic(A)  foo(A)  refs/for/master/topic(A)
+test_expect_success "proc-receive: report update of mixed refs ($PROTOCOL)" '
+	git -C workbench push origin \
+		$B:refs/heads/master \
+		HEAD:refs/heads/bar \
+		HEAD:refs/heads/baz \
+		HEAD:refs/for/next/topic \
+		HEAD:refs/heads/foo \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/bar
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> ok refs/for/next/topic
+	remote: proc-receive> alt refs/for/master/topic refs/for/master/topic old-oid=<COMMIT-A> new-oid=<COMMIT-B>
+	remote: # post-receive hook
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/bar
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	To <URL/of/upstream.git>
+	 <OID-A>..<OID-B> <COMMIT-B> -> master
+	 * [new branch] HEAD -> bar
+	 * [new branch] HEAD -> baz
+	 * [new reference] HEAD -> refs/for/next/topic
+	 * [new branch] HEAD -> foo
+	 * [new reference] HEAD -> refs/for/master/topic
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
+
+'
diff --git a/t/t5411/test-0039-report-mixed-refs--porcelain.sh b/t/t5411/test-0039-report-mixed-refs--porcelain.sh
new file mode 100644
index 0000000000..e237f40db7
--- /dev/null
+++ b/t/t5411/test-0039-report-mixed-refs--porcelain.sh
@@ -0,0 +1,75 @@
+test_expect_success "setup proc-receive hook ($PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/for/next/topic" \
+		-r "alt refs/for/master/topic refs/for/master/topic old-oid=$A new-oid=$B"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         : (B)                   bar(A)  baz(A)  refs/for/next/topic(A)  foo(A)  refs/for/master/topic(A)
+test_expect_success "proc-receive: report update of mixed refs (--porcelain, $PROTOCOL)" '
+	git -C workbench push --porcelain origin \
+		$B:refs/heads/master \
+		HEAD:refs/heads/bar \
+		HEAD:refs/heads/baz \
+		HEAD:refs/for/next/topic \
+		HEAD:refs/heads/foo \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/bar
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> ok refs/for/next/topic
+	remote: proc-receive> alt refs/for/master/topic refs/for/master/topic old-oid=<COMMIT-A> new-oid=<COMMIT-B>
+	remote: # post-receive hook
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/bar
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	To <URL/of/upstream.git>
+	     <COMMIT-B>:refs/heads/master    <OID-A>..<OID-B>
+	*    HEAD:refs/heads/bar    [new branch]
+	*    HEAD:refs/heads/baz    [new branch]
+	*    HEAD:refs/for/next/topic    [new reference]
+	*    HEAD:refs/heads/foo    [new branch]
+	*    HEAD:refs/for/master/topic    [new reference]
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
+test_expect_success "cleanup ($PROTOCOL)" '
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
2.24.1.15.g448c31058d.agit.4.5

