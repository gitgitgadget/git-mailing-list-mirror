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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D338C433DF
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 17:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A8F22067C
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 17:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etcsuJsb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgHXRmo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgHXRmS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 13:42:18 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E06AC0613ED
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 10:42:18 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id q1so4584370pjd.1
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 10:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lIVXQ3guhKr0I28n1MWdQImuARMyzdwetKvWNhgqxBY=;
        b=etcsuJsbA4/bDL6sHTv9I9HNn3lbt96GYpMbF01stf2NaNa9ICYbipXKYQ7tcXCAHW
         7y0uGt4td2D8tBymt5HNmJO00Eh4xg9KFulvZNyqdBRkFkcylwCgD4Nsa7z2A5W5UbwI
         3woq+BZcV7URJqPPE4LH4rrVnatH/nvRoeaCQr6sPIi4EWrEguHxGh70RMxNHImto5hO
         hNGSr7hB0QpxVV/Vgfkkln5LwAY6NmmyzI7H/6CSvMSY0DsftrkGsiZf20TaBrGkrddM
         lJPOMuovtHeVbZcMSYVq4gR4F1a73qlmSKbmP6Cdq4DbvNg8rKlfSijOP2oHyeOojp/T
         iQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lIVXQ3guhKr0I28n1MWdQImuARMyzdwetKvWNhgqxBY=;
        b=XnxovCjXGunpTvsc1+XvXJ9lL/h8Dyb1djNzCdYoH9XjbP1s4eQskC2jFmeLgWNzD7
         k0zYSUfHDH+bJGA6+MdJYxFe+JmE5Ere2BqUNRCfzrrJAZ+jsz0IOdTNLgQ6VtFt2VGT
         IDajs02oiSEldWbfg/lPyAU8PV3e/fiDr5TlrF4Wru6cmH0kcY8ZCG13Q2aTotHu8vzN
         kNeWnjN86XPmcYB3VJ/V7q5M5MheoPFgeTJ/Kb2jkb8rU/hGHsEEN6nHVO+JWdj7qdpK
         19oeiiaasnBPKVtE59z3TziQMBPaF9E5bxSfsL8Uj8hA/uMOBifPSdQo0iuv8wNC7r59
         lE7g==
X-Gm-Message-State: AOAM531JcgamWPVxBohWsS0n2QOJkkzFGycsmiWlJbNEqSvRodtS+aph
        +lFzQYrF4EE9E3krlhbRFHY=
X-Google-Smtp-Source: ABdhPJzMkXmETPqopGWIhpy9wStUsINdMGuhvJSJYB6FbULR66aLk6QWWfpLT+1FTRJ+DyTKFjyDWg==
X-Received: by 2002:a17:902:c20a:: with SMTP id 10mr3452275pll.38.1598290937762;
        Mon, 24 Aug 2020 10:42:17 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id b15sm9773162pgk.14.2020.08.24.10.42.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 10:42:16 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>, Jeff King <peff@peff.net>
Subject: [PATCH v18 05/10] New capability "report-status-v2" for git-push
Date:   Mon, 24 Aug 2020 13:41:57 -0400
Message-Id: <20200824174202.11710-6-worldhello.net@gmail.com>
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

The new introduced "proc-receive" hook may handle a command for a
pseudo-reference with a zero-old as its old-oid, while the hook may
create or update a reference with different name, different new-oid,
and different old-oid (the reference may exist already with a non-zero
old-oid).  Current "report-status" protocol cannot report the status for
such reference rewrite.

Add new capability "report-status-v2" and new report protocol which is
not backward compatible for report of git-push.

If a user pushes to a pseudo-reference "refs/for/master/topic", and
"receive-pack" creates two new references "refs/changes/23/123/1" and
"refs/changes/24/124/1", for client without the knowledge of
"report-status-v2", "receive-pack" will only send "ok/ng" directives in
the report, such as:

    ok ref/for/master/topic

But for client which has the knowledge of "report-status-v2",
"receive-pack" will use "option" directives to report more attributes
for the reference given by the above "ok/ng" directive.

    ok refs/for/master/topic
    option refname refs/changes/23/123/1
    option new-oid <new-oid>
    ok refs/for/master/topic
    option refname refs/changes/24/124/1
    option new-oid <new-oid>

The client will report two new created references to the end user.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 builtin/receive-pack.c                        |  54 +++++++-
 builtin/send-pack.c                           |  19 +++
 remote.h                                      |   1 +
 send-pack.c                                   | 101 +++++++++++---
 t/t5411-proc-receive-hook.sh                  |   9 ++
 t/t5411/once-0010-report-status-v1.sh         |  90 ++++++++++++
 t/t5411/test-0032-report-with-options.sh      |  14 +-
 ...est-0033-report-with-options--porcelain.sh |  14 +-
 ...t-0036-report-multi-rewrite-for-one-ref.sh |  11 +-
 ...rt-multi-rewrite-for-one-ref--porcelain.sh |  11 +-
 t/t5411/test-0038-report-mixed-refs.sh        |   2 +-
 .../test-0039-report-mixed-refs--porcelain.sh |   2 +-
 transport-helper.c                            | 128 ++++++++++++++----
 transport.c                                   | 116 ++++++++++++----
 14 files changed, 472 insertions(+), 100 deletions(-)
 create mode 100644 t/t5411/once-0010-report-status-v1.sh

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 38f230248d..d6a216b2e3 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -56,6 +56,7 @@ static int advertise_push_options;
 static int unpack_limit = 100;
 static off_t max_input_size;
 static int report_status;
+static int report_status_v2;
 static int use_sideband;
 static int use_atomic;
 static int use_push_options;
@@ -239,7 +240,7 @@ static void show_ref(const char *path, const struct object_id *oid)
 		struct strbuf cap = STRBUF_INIT;
 
 		strbuf_addstr(&cap,
-			      "report-status delete-refs side-band-64k quiet");
+			      "report-status report-status-v2 delete-refs side-band-64k quiet");
 		if (advertise_atomic_push)
 			strbuf_addstr(&cap, " atomic");
 		if (prefer_ofs_delta)
@@ -1937,6 +1938,8 @@ static struct command *read_head_info(struct packet_reader *reader,
 			const char *feature_list = reader->line + linelen + 1;
 			if (parse_feature_request(feature_list, "report-status"))
 				report_status = 1;
+			if (parse_feature_request(feature_list, "report-status-v2"))
+				report_status_v2 = 1;
 			if (parse_feature_request(feature_list, "side-band-64k"))
 				use_sideband = LARGE_PACKET_MAX;
 			if (parse_feature_request(feature_list, "quiet"))
@@ -2248,6 +2251,51 @@ static void report(struct command *commands, const char *unpack_status)
 	strbuf_release(&buf);
 }
 
+static void report_v2(struct command *commands, const char *unpack_status)
+{
+	struct command *cmd;
+	struct strbuf buf = STRBUF_INIT;
+	struct ref_push_report *report;
+
+	packet_buf_write(&buf, "unpack %s\n",
+			 unpack_status ? unpack_status : "ok");
+	for (cmd = commands; cmd; cmd = cmd->next) {
+		int count = 0;
+
+		if (cmd->error_string) {
+			packet_buf_write(&buf, "ng %s %s\n",
+					 cmd->ref_name,
+					 cmd->error_string);
+			continue;
+		}
+		packet_buf_write(&buf, "ok %s\n",
+				 cmd->ref_name);
+		for (report = cmd->report; report; report = report->next) {
+			if (count++ > 0)
+				packet_buf_write(&buf, "ok %s\n",
+						 cmd->ref_name);
+			if (report->ref_name)
+				packet_buf_write(&buf, "option refname %s\n",
+						 report->ref_name);
+			if (report->old_oid)
+				packet_buf_write(&buf, "option old-oid %s\n",
+						 oid_to_hex(report->old_oid));
+			if (report->new_oid)
+				packet_buf_write(&buf, "option new-oid %s\n",
+						 oid_to_hex(report->new_oid));
+			if (report->forced_update)
+				packet_buf_write(&buf, "option forced-update\n");
+		}
+	}
+	packet_buf_flush(&buf);
+
+	if (use_sideband)
+		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
+	else
+		write_or_die(1, buf.buf, buf.len);
+	strbuf_release(&buf);
+}
+
 static int delete_only(struct command *commands)
 {
 	struct command *cmd;
@@ -2356,7 +2404,9 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 				 &push_options);
 		if (pack_lockfile)
 			unlink_or_warn(pack_lockfile);
-		if (report_status)
+		if (report_status_v2)
+			report_v2(commands, unpack_status);
+		else if (report_status)
 			report(commands, unpack_status);
 		run_receive_hook(commands, "post-receive", 1,
 				 &push_options);
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index f2c5a34402..2777cc4371 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -29,10 +29,12 @@ static struct send_pack_args args;
 static void print_helper_status(struct ref *ref)
 {
 	struct strbuf buf = STRBUF_INIT;
+	struct ref_push_report *report;
 
 	for (; ref; ref = ref->next) {
 		const char *msg = NULL;
 		const char *res;
+		int count = 0;
 
 		switch(ref->status) {
 		case REF_STATUS_NONE:
@@ -94,6 +96,23 @@ static void print_helper_status(struct ref *ref)
 		}
 		strbuf_addch(&buf, '\n');
 
+		if (ref->status == REF_STATUS_OK) {
+			for (report = ref->report; report; report = report->next) {
+				if (count++ > 0)
+					strbuf_addf(&buf, "ok %s\n", ref->name);
+				if (report->ref_name)
+					strbuf_addf(&buf, "option refname %s\n",
+						report->ref_name);
+				if (report->old_oid)
+					strbuf_addf(&buf, "option old-oid %s\n",
+						oid_to_hex(report->old_oid));
+				if (report->new_oid)
+					strbuf_addf(&buf, "option new-oid %s\n",
+						oid_to_hex(report->new_oid));
+				if (report->forced_update)
+					strbuf_addstr(&buf, "option forced-update\n");
+			}
+		}
 		write_or_die(1, buf.buf, buf.len);
 	}
 	strbuf_release(&buf);
diff --git a/remote.h b/remote.h
index ca7735b441..6d1e5c49f8 100644
--- a/remote.h
+++ b/remote.h
@@ -148,6 +148,7 @@ struct ref {
 		REF_STATUS_ATOMIC_PUSH_FAILED
 	} status;
 	char *remote_status;
+	struct ref_push_report *report;
 	struct ref *peer_ref; /* when renaming */
 	char name[FLEX_ARRAY]; /* more */
 };
diff --git a/send-pack.c b/send-pack.c
index d1b7edc995..dfaf505c96 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -153,25 +153,79 @@ static int receive_status(struct packet_reader *reader, struct ref *refs)
 {
 	struct ref *hint;
 	int ret;
+	struct ref_push_report *report = NULL;
+	int new_report = 0;
+	int once = 0;
 
 	hint = NULL;
 	ret = receive_unpack_status(reader);
 	while (1) {
+		struct object_id old_oid, new_oid;
+		const char *head;
 		const char *refname;
-		char *msg;
+		char *p;
 		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
 			break;
-		if (!starts_with(reader->line, "ok ") && !starts_with(reader->line, "ng ")) {
-			error("invalid ref status from remote: %s", reader->line);
+		head = reader->line;
+		p = strchr(head, ' ');
+		if (!p) {
+			error("invalid status line from remote: %s", reader->line);
 			ret = -1;
 			break;
 		}
+		*p++ = '\0';
 
-		refname = reader->line + 3;
-		msg = strchr(refname, ' ');
-		if (msg)
-			*msg++ = '\0';
+		if (!strcmp(head, "option")) {
+			const char *key, *val;
 
+			if (!hint || !(report || new_report)) {
+				if (!once++)
+					error("'option' without a matching 'ok/ng' directive");
+				ret = -1;
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
+			continue;
+		}
+
+		report = NULL;
+		new_report = 0;
+		if (strcmp(head, "ok") && strcmp(head, "ng")) {
+			error("invalid ref status from remote: %s", head);
+			ret = -1;
+			break;
+		}
+		refname = p;
+		p = strchr(refname, ' ');
+		if (p)
+			*p++ = '\0';
 		/* first try searching at our hint, falling back to all refs */
 		if (hint)
 			hint = find_ref_by_name(hint, refname);
@@ -179,22 +233,27 @@ static int receive_status(struct packet_reader *reader, struct ref *refs)
 			hint = find_ref_by_name(refs, refname);
 		if (!hint) {
 			warning("remote reported status on unknown ref: %s",
-					refname);
+				refname);
 			continue;
 		}
-		if (hint->status != REF_STATUS_EXPECTING_REPORT) {
+		if (hint->status != REF_STATUS_EXPECTING_REPORT &&
+		    hint->status != REF_STATUS_OK &&
+		    hint->status != REF_STATUS_REMOTE_REJECT) {
 			warning("remote reported status on unexpected ref: %s",
-					refname);
+				refname);
 			continue;
 		}
-
-		if (reader->line[0] == 'o' && reader->line[1] == 'k')
-			hint->status = REF_STATUS_OK;
-		else
+		if (!strcmp(head, "ng")) {
 			hint->status = REF_STATUS_REMOTE_REJECT;
-		hint->remote_status = xstrdup_or_null(msg);
-		/* start our next search from the next ref */
-		hint = hint->next;
+			if (p)
+				hint->remote_status = xstrdup(p);
+			else
+				hint->remote_status = "failed";
+		} else {
+			hint->status = REF_STATUS_OK;
+			hint->remote_status = xstrdup_or_null(p);
+			new_report = 1;
+		}
 	}
 	return ret;
 }
@@ -369,7 +428,9 @@ int send_pack(struct send_pack_args *args,
 	struct packet_reader reader;
 
 	/* Does the other end support the reporting? */
-	if (server_supports("report-status"))
+	if (server_supports("report-status-v2"))
+		status_report = 2;
+	else if (server_supports("report-status"))
 		status_report = 1;
 	if (server_supports("delete-refs"))
 		allow_deleting_refs = 1;
@@ -418,8 +479,10 @@ int send_pack(struct send_pack_args *args,
 
 	use_push_options = push_options_supported && args->push_options;
 
-	if (status_report)
+	if (status_report == 1)
 		strbuf_addstr(&cap_buf, " report-status");
+	else if (status_report == 2)
+		strbuf_addstr(&cap_buf, " report-status-v2");
 	if (use_sideband)
 		strbuf_addstr(&cap_buf, " side-band-64k");
 	if (quiet_supported && (args->quiet || !args->progress))
diff --git a/t/t5411-proc-receive-hook.sh b/t/t5411-proc-receive-hook.sh
index 3a684353a8..746487286f 100755
--- a/t/t5411-proc-receive-hook.sh
+++ b/t/t5411-proc-receive-hook.sh
@@ -78,6 +78,15 @@ run_proc_receive_hook_test() {
 # Initialize the upstream repository and local workbench.
 setup_upstream_and_workbench
 
+# Load test cases that only need to be executed once.
+for t in  "$TEST_DIRECTORY"/t5411/once-*.sh
+do
+	. "$t"
+done
+
+# Initialize the upstream repository and local workbench.
+setup_upstream_and_workbench
+
 # Run test cases for 'proc-receive' hook on local file protocol.
 run_proc_receive_hook_test local
 
diff --git a/t/t5411/once-0010-report-status-v1.sh b/t/t5411/once-0010-report-status-v1.sh
new file mode 100644
index 0000000000..bf410dc418
--- /dev/null
+++ b/t/t5411/once-0010-report-status-v1.sh
@@ -0,0 +1,90 @@
+test_expect_success "setup proc-receive hook" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/for/master/topic1" \
+		-r "option fall-through" \
+		-r "ok refs/for/master/topic2" \
+		-r "option refname refs/for/changes/23/123/1" \
+		-r "option new-oid $A" \
+		-r "ok refs/for/master/topic2" \
+		-r "option refname refs/for/changes/24/124/2" \
+		-r "option old-oid $B" \
+		-r "option new-oid $A" \
+		-r "option forced-update" \
+		-r "ng refs/for/next/topic target branch not exist"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         : (B)                   refs/for/master/topic1(A)  foo(A)  refs/for/next/topic(A)  refs/for/master/topic2(A)
+test_expect_success "proc-receive: report status v1" '
+	{
+		if test -z "$GIT_DEFAULT_HASH" || test "$GIT_DEFAULT_HASH" = "sha1"
+		then
+			printf "%s %s refs/heads/master\0report-status\n" \
+				$A $B | packetize
+		else
+			printf "%s %s refs/heads/master\0report-status object-format=$GIT_DEFAULT_HASH\n" \
+				$A $B | packetize
+		fi &&
+		printf "%s %s refs/for/master/topic1\n" \
+			$ZERO_OID $A | packetize &&
+		printf "%s %s refs/heads/foo\n" \
+			$ZERO_OID $A | packetize &&
+		printf "%s %s refs/for/next/topic\n" \
+			$ZERO_OID $A | packetize &&
+		printf "%s %s refs/for/master/topic2\n" \
+			$ZERO_OID $A | packetize &&
+		printf 0000 &&
+		printf "" | git -C "$upstream" pack-objects --stdout
+	} | git receive-pack "$upstream" --stateless-rpc \
+	>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	# pre-receive hook
+	pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
+	pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic1
+	pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
+	pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
+	pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic2
+	# proc-receive hook
+	proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic1
+	proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
+	proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic2
+	proc-receive> ok refs/for/master/topic1
+	proc-receive> option fall-through
+	proc-receive> ok refs/for/master/topic2
+	proc-receive> option refname refs/for/changes/23/123/1
+	proc-receive> option new-oid <COMMIT-A>
+	proc-receive> ok refs/for/master/topic2
+	proc-receive> option refname refs/for/changes/24/124/2
+	proc-receive> option old-oid <COMMIT-B>
+	proc-receive> option new-oid <COMMIT-A>
+	proc-receive> option forced-update
+	proc-receive> ng refs/for/next/topic target branch not exist
+	000eunpack ok
+	0019ok refs/heads/master
+	001eok refs/for/master/topic1
+	0016ok refs/heads/foo
+	0033ng refs/for/next/topic target branch not exist
+	001eok refs/for/master/topic2
+	0000# post-receive hook
+	post-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
+	post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic1
+	post-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
+	post-receive< <ZERO-OID> <COMMIT-A> refs/for/changes/23/123/1
+	post-receive< <COMMIT-B> <COMMIT-A> refs/for/changes/24/124/2
+	EOF
+	test_cmp expect actual &&
+
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/for/master/topic1
+	<COMMIT-A> refs/heads/foo
+	<COMMIT-B> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
diff --git a/t/t5411/test-0032-report-with-options.sh b/t/t5411/test-0032-report-with-options.sh
index c559c207fa..b77b78c49f 100644
--- a/t/t5411/test-0032-report-with-options.sh
+++ b/t/t5411/test-0032-report-with-options.sh
@@ -56,7 +56,7 @@ test_expect_success "proc-receive: report option refname ($PROTOCOL)" '
 	remote: # post-receive hook
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/pull/123/head
 	To <URL/of/upstream.git>
-	 * [new reference] HEAD -> refs/for/master/topic
+	 * [new reference] HEAD -> refs/pull/123/head
 	EOF
 	test_cmp expect actual
 '
@@ -89,7 +89,7 @@ test_expect_success "proc-receive: report option refname and forced-update ($PRO
 	remote: # post-receive hook
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/pull/123/head
 	To <URL/of/upstream.git>
-	 * [new reference] HEAD -> refs/for/master/topic
+	 * [new reference] HEAD -> refs/pull/123/head
 	EOF
 	test_cmp expect actual
 '
@@ -123,7 +123,7 @@ test_expect_success "proc-receive: report option refname and old-oid ($PROTOCOL)
 	remote: # post-receive hook
 	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/pull/123/head
 	To <URL/of/upstream.git>
-	 * [new reference] HEAD -> refs/for/master/topic
+	 <OID-B>..<OID-A> HEAD -> refs/pull/123/head
 	EOF
 	test_cmp expect actual
 '
@@ -155,7 +155,7 @@ test_expect_success "proc-receive: report option old-oid ($PROTOCOL)" '
 	remote: # post-receive hook
 	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/for/master/topic
 	To <URL/of/upstream.git>
-	 * [new reference] HEAD -> refs/for/master/topic
+	 <OID-B>..<OID-A> HEAD -> refs/for/master/topic
 	EOF
 	test_cmp expect actual
 '
@@ -189,7 +189,7 @@ test_expect_success "proc-receive: report option old-oid and new-oid ($PROTOCOL)
 	remote: # post-receive hook
 	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
 	To <URL/of/upstream.git>
-	 * [new reference] HEAD -> refs/for/master/topic
+	 <OID-A>..<OID-B> HEAD -> refs/for/master/topic
 	EOF
 	test_cmp expect actual
 '
@@ -241,9 +241,9 @@ test_expect_success "proc-receive: report with multiple rewrites ($PROTOCOL)" '
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
 	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/pull/124/head
 	To <URL/of/upstream.git>
-	 * [new reference] HEAD -> refs/for/next/topic
+	 * [new reference] HEAD -> refs/pull/123/head
 	 * [new reference] HEAD -> refs/for/a/b/c/topic
-	 * [new reference] HEAD -> refs/for/master/topic
+	 + <OID-B>...<OID-A> HEAD -> refs/pull/124/head (forced update)
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0033-report-with-options--porcelain.sh b/t/t5411/test-0033-report-with-options--porcelain.sh
index ea9312234e..1fe352b686 100644
--- a/t/t5411/test-0033-report-with-options--porcelain.sh
+++ b/t/t5411/test-0033-report-with-options--porcelain.sh
@@ -57,7 +57,7 @@ test_expect_success "proc-receive: report option refname ($PROTOCOL/porcelain)"
 	remote: # post-receive hook
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/pull/123/head
 	To <URL/of/upstream.git>
-	*    HEAD:refs/for/master/topic    [new reference]
+	*    HEAD:refs/pull/123/head    [new reference]
 	Done
 	EOF
 	test_cmp expect actual
@@ -92,7 +92,7 @@ test_expect_success "proc-receive: report option refname and forced-update ($PRO
 	remote: # post-receive hook
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/pull/123/head
 	To <URL/of/upstream.git>
-	*    HEAD:refs/for/master/topic    [new reference]
+	*    HEAD:refs/pull/123/head    [new reference]
 	Done
 	EOF
 	test_cmp expect actual
@@ -127,7 +127,7 @@ test_expect_success "proc-receive: report option refname and old-oid ($PROTOCOL/
 	remote: # post-receive hook
 	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/pull/123/head
 	To <URL/of/upstream.git>
-	*    HEAD:refs/for/master/topic    [new reference]
+	     HEAD:refs/pull/123/head    <OID-B>..<OID-A>
 	Done
 	EOF
 	test_cmp expect actual
@@ -160,7 +160,7 @@ test_expect_success "proc-receive: report option old-oid ($PROTOCOL/porcelain)"
 	remote: # post-receive hook
 	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/for/master/topic
 	To <URL/of/upstream.git>
-	*    HEAD:refs/for/master/topic    [new reference]
+	     HEAD:refs/for/master/topic    <OID-B>..<OID-A>
 	Done
 	EOF
 	test_cmp expect actual
@@ -195,7 +195,7 @@ test_expect_success "proc-receive: report option old-oid and new-oid ($PROTOCOL/
 	remote: # post-receive hook
 	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
 	To <URL/of/upstream.git>
-	*    HEAD:refs/for/master/topic    [new reference]
+	     HEAD:refs/for/master/topic    <OID-A>..<OID-B>
 	Done
 	EOF
 	test_cmp expect actual
@@ -249,9 +249,9 @@ test_expect_success "proc-receive: report with multiple rewrites ($PROTOCOL/porc
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
 	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/pull/124/head
 	To <URL/of/upstream.git>
-	*    HEAD:refs/for/next/topic    [new reference]
+	*    HEAD:refs/pull/123/head    [new reference]
 	*    HEAD:refs/for/a/b/c/topic    [new reference]
-	*    HEAD:refs/for/master/topic    [new reference]
+	+    HEAD:refs/pull/124/head    <OID-B>...<OID-A> (forced update)
 	Done
 	EOF
 	test_cmp expect actual &&
diff --git a/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh b/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
index 67cc4a8a4c..27d58edd14 100644
--- a/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
+++ b/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
@@ -45,7 +45,9 @@ test_expect_success "proc-receive: multiple rewrite for one ref, no refname for
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/changes/24/124/1
 	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/changes/25/125/1
 	To <URL/of/upstream.git>
-	 * [new reference] HEAD -> refs/for/master/topic
+	 <OID-A>..<OID-B> HEAD -> refs/for/master/topic
+	 * [new reference] HEAD -> refs/changes/24/124/1
+	 <OID-A>..<OID-B> HEAD -> refs/changes/25/125/1
 	EOF
 	test_cmp expect actual &&
 	git -C "$upstream" show-ref >out &&
@@ -105,7 +107,9 @@ test_expect_success "proc-receive: multiple rewrites for one ref, no refname for
 	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
 	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/changes/25/125/1
 	To <URL/of/upstream.git>
-	 * [new reference] HEAD -> refs/for/master/topic
+	 * [new reference] HEAD -> refs/changes/24/124/1
+	 <OID-A>..<OID-B> HEAD -> refs/for/master/topic
+	 + <OID-B>...<OID-A> HEAD -> refs/changes/25/125/1 (forced update)
 	EOF
 	test_cmp expect actual &&
 	git -C "$upstream" show-ref >out &&
@@ -152,7 +156,8 @@ test_expect_success "proc-receive: multiple rewrites for one ref ($PROTOCOL)" '
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/changes/23/123/1
 	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/changes/24/124/2
 	To <URL/of/upstream.git>
-	 * [new reference] HEAD -> refs/for/master/topic
+	 * [new reference] HEAD -> refs/changes/23/123/1
+	 <OID-A>..<OID-B> HEAD -> refs/changes/24/124/2
 	EOF
 	test_cmp expect actual &&
 	git -C "$upstream" show-ref >out &&
diff --git a/t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh b/t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh
index 1dc8551bc6..77b5b22ed4 100644
--- a/t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh
+++ b/t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh
@@ -45,7 +45,9 @@ test_expect_success "proc-receive: multiple rewrite for one ref, no refname for
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/changes/24/124/1
 	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/changes/25/125/1
 	To <URL/of/upstream.git>
-	*    HEAD:refs/for/master/topic    [new reference]
+	     HEAD:refs/for/master/topic    <OID-A>..<OID-B>
+	*    HEAD:refs/changes/24/124/1    [new reference]
+	     HEAD:refs/changes/25/125/1    <OID-A>..<OID-B>
 	Done
 	EOF
 	test_cmp expect actual &&
@@ -106,7 +108,9 @@ test_expect_success "proc-receive: multiple rewrites for one ref, no refname for
 	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
 	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/changes/25/125/1
 	To <URL/of/upstream.git>
-	*    HEAD:refs/for/master/topic    [new reference]
+	*    HEAD:refs/changes/24/124/1    [new reference]
+	     HEAD:refs/for/master/topic    <OID-A>..<OID-B>
+	+    HEAD:refs/changes/25/125/1    <OID-B>...<OID-A> (forced update)
 	Done
 	EOF
 	test_cmp expect actual &&
@@ -154,7 +158,8 @@ test_expect_success "proc-receive: multiple rewrites for one ref ($PROTOCOL/porc
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/changes/23/123/1
 	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/changes/24/124/2
 	To <URL/of/upstream.git>
-	*    HEAD:refs/for/master/topic    [new reference]
+	*    HEAD:refs/changes/23/123/1    [new reference]
+	     HEAD:refs/changes/24/124/2    <OID-A>..<OID-B>
 	Done
 	EOF
 	test_cmp expect actual &&
diff --git a/t/t5411/test-0038-report-mixed-refs.sh b/t/t5411/test-0038-report-mixed-refs.sh
index bfc8d586d6..a74a2cb449 100644
--- a/t/t5411/test-0038-report-mixed-refs.sh
+++ b/t/t5411/test-0038-report-mixed-refs.sh
@@ -60,7 +60,7 @@ test_expect_success "proc-receive: report update of mixed refs ($PROTOCOL)" '
 	 * [new branch] HEAD -> baz
 	 * [new reference] HEAD -> refs/for/next/topic2
 	 * [new branch] HEAD -> foo
-	 * [new reference] HEAD -> refs/for/master/topic
+	 <OID-A>..<OID-B> HEAD -> refs/for/master/topic
 	 ! [remote rejected] HEAD -> refs/for/next/topic1 (fail to call Web API)
 	 ! [remote rejected] HEAD -> refs/for/next/topic3 (proc-receive failed to report status)
 	EOF
diff --git a/t/t5411/test-0039-report-mixed-refs--porcelain.sh b/t/t5411/test-0039-report-mixed-refs--porcelain.sh
index 5d021a4837..e4baa13ea3 100644
--- a/t/t5411/test-0039-report-mixed-refs--porcelain.sh
+++ b/t/t5411/test-0039-report-mixed-refs--porcelain.sh
@@ -60,7 +60,7 @@ test_expect_success "proc-receive: report update of mixed refs ($PROTOCOL/porcel
 	*    HEAD:refs/heads/baz    [new branch]
 	*    HEAD:refs/for/next/topic2    [new reference]
 	*    HEAD:refs/heads/foo    [new branch]
-	*    HEAD:refs/for/master/topic    [new reference]
+	     HEAD:refs/for/master/topic    <OID-A>..<OID-B>
 	!    HEAD:refs/for/next/topic1    [remote rejected] (fail to call Web API)
 	!    HEAD:refs/for/next/topic3    [remote rejected] (proc-receive failed to report status)
 	Done
diff --git a/transport-helper.c b/transport-helper.c
index a46afcb69d..1738c81ea0 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -719,13 +719,61 @@ static int fetch(struct transport *transport,
 	return -1;
 }
 
+struct push_update_ref_state {
+	struct ref *hint;
+	struct ref_push_report *report;
+	int new_report;
+};
+
 static int push_update_ref_status(struct strbuf *buf,
-				   struct ref **ref,
+				   struct push_update_ref_state *state,
 				   struct ref *remote_refs)
 {
 	char *refname, *msg;
 	int status, forced = 0;
 
+	if (starts_with(buf->buf, "option ")) {
+		struct object_id old_oid, new_oid;
+		const char *key, *val;
+		char *p;
+
+		if (!state->hint || !(state->report || state->new_report))
+			die(_("'option' without a matching 'ok/error' directive"));
+		if (state->new_report) {
+			if (!state->hint->report) {
+				state->hint->report = xcalloc(1, sizeof(struct ref_push_report));
+				state->report = state->hint->report;
+			} else {
+				state->report = state->hint->report;
+				while (state->report->next)
+					state->report = state->report->next;
+				state->report->next = xcalloc(1, sizeof(struct ref_push_report));
+				state->report = state->report->next;
+			}
+			state->new_report = 0;
+		}
+		key = buf->buf + 7;
+		p = strchr(key, ' ');
+		if (p)
+			*p++ = '\0';
+		val = p;
+		if (!strcmp(key, "refname"))
+			state->report->ref_name = xstrdup_or_null(val);
+		else if (!strcmp(key, "old-oid") && val &&
+			 !parse_oid_hex(val, &old_oid, &val))
+			state->report->old_oid = oiddup(&old_oid);
+		else if (!strcmp(key, "new-oid") && val &&
+			 !parse_oid_hex(val, &new_oid, &val))
+			state->report->new_oid = oiddup(&new_oid);
+		else if (!strcmp(key, "forced-update"))
+			state->report->forced_update = 1;
+		/* Not update remote namespace again. */
+		return 1;
+	}
+
+	state->report = NULL;
+	state->new_report = 0;
+
 	if (starts_with(buf->buf, "ok ")) {
 		status = REF_STATUS_OK;
 		refname = buf->buf + 3;
@@ -781,16 +829,16 @@ static int push_update_ref_status(struct strbuf *buf,
 		}
 	}
 
-	if (*ref)
-		*ref = find_ref_by_name(*ref, refname);
-	if (!*ref)
-		*ref = find_ref_by_name(remote_refs, refname);
-	if (!*ref) {
+	if (state->hint)
+		state->hint = find_ref_by_name(state->hint, refname);
+	if (!state->hint)
+		state->hint = find_ref_by_name(remote_refs, refname);
+	if (!state->hint) {
 		warning(_("helper reported unexpected status of %s"), refname);
 		return 1;
 	}
 
-	if ((*ref)->status != REF_STATUS_NONE) {
+	if (state->hint->status != REF_STATUS_NONE) {
 		/*
 		 * Earlier, the ref was marked not to be pushed, so ignore the ref
 		 * status reported by the remote helper if the latter is 'no match'.
@@ -799,9 +847,11 @@ static int push_update_ref_status(struct strbuf *buf,
 			return 1;
 	}
 
-	(*ref)->status = status;
-	(*ref)->forced_update |= forced;
-	(*ref)->remote_status = msg;
+	if (status == REF_STATUS_OK)
+		state->new_report = 1;
+	state->hint->status = status;
+	state->hint->forced_update |= forced;
+	state->hint->remote_status = msg;
 	return !(status == REF_STATUS_OK);
 }
 
@@ -809,37 +859,57 @@ static int push_update_refs_status(struct helper_data *data,
 				    struct ref *remote_refs,
 				    int flags)
 {
+	struct ref *ref;
+	struct ref_push_report *report;
 	struct strbuf buf = STRBUF_INIT;
-	struct ref *ref = remote_refs;
-	int ret = 0;
+	struct push_update_ref_state state = { remote_refs, NULL, 0 };
 
 	for (;;) {
-		char *private;
-
 		if (recvline(data, &buf)) {
-			ret = 1;
-			break;
+			strbuf_release(&buf);
+			return 1;
 		}
-
 		if (!buf.len)
 			break;
+		push_update_ref_status(&buf, &state, remote_refs);
+	}
+	strbuf_release(&buf);
 
-		if (push_update_ref_status(&buf, &ref, remote_refs))
-			continue;
+	if (flags & TRANSPORT_PUSH_DRY_RUN || !data->rs.nr || data->no_private_update)
+		return 0;
 
-		if (flags & TRANSPORT_PUSH_DRY_RUN || !data->rs.nr || data->no_private_update)
-			continue;
+	/* propagate back the update to the remote namespace */
+	for (ref = remote_refs; ref; ref = ref->next) {
+		char *private;
 
-		/* propagate back the update to the remote namespace */
-		private = apply_refspecs(&data->rs, ref->name);
-		if (!private)
+		if (ref->status != REF_STATUS_OK)
 			continue;
-		update_ref("update by helper", private, &ref->new_oid, NULL,
-			   0, 0);
-		free(private);
+
+		if (!ref->report) {
+			private = apply_refspecs(&data->rs, ref->name);
+			if (!private)
+				continue;
+			update_ref("update by helper", private, &(ref->new_oid),
+				   NULL, 0, 0);
+			free(private);
+		} else {
+			for (report = ref->report; report; report = report->next) {
+				private = apply_refspecs(&data->rs,
+							 report->ref_name
+							 ? report->ref_name
+							 : ref->name);
+				if (!private)
+					continue;
+				update_ref("update by helper", private,
+					   report->new_oid
+					   ? report->new_oid
+					   : &(ref->new_oid),
+					   NULL, 0, 0);
+				free(private);
+			}
+		}
 	}
-	strbuf_release(&buf);
-	return ret;
+	return 0;
 }
 
 static void set_common_push_options(struct transport *transport,
diff --git a/transport.c b/transport.c
index 26fefd13c1..e146de6c4e 100644
--- a/transport.c
+++ b/transport.c
@@ -461,13 +461,21 @@ void transport_update_tracking_ref(struct remote *remote, struct ref *ref, int v
 
 static void print_ref_status(char flag, const char *summary,
 			     struct ref *to, struct ref *from, const char *msg,
+			     struct ref_push_report *report,
 			     int porcelain, int summary_width)
 {
+	const char *to_name;
+
+	if (report && report->ref_name)
+		to_name = report->ref_name;
+	else
+		to_name = to->name;
+
 	if (porcelain) {
 		if (from)
-			fprintf(stdout, "%c\t%s:%s\t", flag, from->name, to->name);
+			fprintf(stdout, "%c\t%s:%s\t", flag, from->name, to_name);
 		else
-			fprintf(stdout, "%c\t:%s\t", flag, to->name);
+			fprintf(stdout, "%c\t:%s\t", flag, to_name);
 		if (msg)
 			fprintf(stdout, "%s (%s)\n", summary, msg);
 		else
@@ -481,9 +489,11 @@ static void print_ref_status(char flag, const char *summary,
 		fprintf(stderr, " %s%c %-*s%s ", red, flag, summary_width,
 			summary, reset);
 		if (from)
-			fprintf(stderr, "%s -> %s", prettify_refname(from->name), prettify_refname(to->name));
+			fprintf(stderr, "%s -> %s",
+				prettify_refname(from->name),
+				prettify_refname(to_name));
 		else
-			fputs(prettify_refname(to->name), stderr);
+			fputs(prettify_refname(to_name), stderr);
 		if (msg) {
 			fputs(" (", stderr);
 			fputs(msg, stderr);
@@ -493,27 +503,52 @@ static void print_ref_status(char flag, const char *summary,
 	}
 }
 
-static void print_ok_ref_status(struct ref *ref, int porcelain, int summary_width)
+static void print_ok_ref_status(struct ref *ref,
+				struct ref_push_report *report,
+				int porcelain, int summary_width)
 {
+	struct object_id *old_oid;
+	struct object_id *new_oid;
+	const char *ref_name;
+	int forced_update;
+
+	if (report && report->old_oid)
+		old_oid = report->old_oid;
+	else
+		old_oid = &ref->old_oid;
+	if (report && report->new_oid)
+		new_oid = report->new_oid;
+	else
+		new_oid = &ref->new_oid;
+	if (report && report->forced_update)
+		forced_update = report->forced_update;
+	else
+		forced_update = ref->forced_update;
+	if (report && report->ref_name)
+		ref_name = report->ref_name;
+	else
+		ref_name = ref->name;
+
 	if (ref->deletion)
 		print_ref_status('-', "[deleted]", ref, NULL, NULL,
-				 porcelain, summary_width);
-	else if (is_null_oid(&ref->old_oid))
+				 report, porcelain, summary_width);
+	else if (is_null_oid(old_oid))
 		print_ref_status('*',
-				 (starts_with(ref->name, "refs/tags/")
+				 (starts_with(ref_name, "refs/tags/")
 				  ? "[new tag]"
-				  : (starts_with(ref->name, "refs/heads/")
+				  : (starts_with(ref_name, "refs/heads/")
 				     ? "[new branch]"
 				     : "[new reference]")),
-				 ref, ref->peer_ref, NULL, porcelain, summary_width);
+				 ref, ref->peer_ref, NULL,
+				 report, porcelain, summary_width);
 	else {
 		struct strbuf quickref = STRBUF_INIT;
 		char type;
 		const char *msg;
 
-		strbuf_add_unique_abbrev(&quickref, &ref->old_oid,
+		strbuf_add_unique_abbrev(&quickref, old_oid,
 					 DEFAULT_ABBREV);
-		if (ref->forced_update) {
+		if (forced_update) {
 			strbuf_addstr(&quickref, "...");
 			type = '+';
 			msg = "forced update";
@@ -522,16 +557,17 @@ static void print_ok_ref_status(struct ref *ref, int porcelain, int summary_widt
 			type = ' ';
 			msg = NULL;
 		}
-		strbuf_add_unique_abbrev(&quickref, &ref->new_oid,
+		strbuf_add_unique_abbrev(&quickref, new_oid,
 					 DEFAULT_ABBREV);
 
 		print_ref_status(type, quickref.buf, ref, ref->peer_ref, msg,
-				 porcelain, summary_width);
+				 report, porcelain, summary_width);
 		strbuf_release(&quickref);
 	}
 }
 
-static int print_one_push_status(struct ref *ref, const char *dest, int count,
+static int print_one_push_report(struct ref *ref, const char *dest, int count,
+				 struct ref_push_report *report,
 				 int porcelain, int summary_width)
 {
 	if (!count) {
@@ -543,65 +579,89 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count,
 	switch(ref->status) {
 	case REF_STATUS_NONE:
 		print_ref_status('X', "[no match]", ref, NULL, NULL,
-				 porcelain, summary_width);
+				 report, porcelain, summary_width);
 		break;
 	case REF_STATUS_REJECT_NODELETE:
 		print_ref_status('!', "[rejected]", ref, NULL,
 				 "remote does not support deleting refs",
-				 porcelain, summary_width);
+				 report, porcelain, summary_width);
 		break;
 	case REF_STATUS_UPTODATE:
 		print_ref_status('=', "[up to date]", ref,
-				 ref->peer_ref, NULL, porcelain, summary_width);
+				 ref->peer_ref, NULL,
+				 report, porcelain, summary_width);
 		break;
 	case REF_STATUS_REJECT_NONFASTFORWARD:
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
-				 "non-fast-forward", porcelain, summary_width);
+				 "non-fast-forward",
+				 report, porcelain, summary_width);
 		break;
 	case REF_STATUS_REJECT_ALREADY_EXISTS:
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
-				 "already exists", porcelain, summary_width);
+				 "already exists",
+				 report, porcelain, summary_width);
 		break;
 	case REF_STATUS_REJECT_FETCH_FIRST:
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
-				 "fetch first", porcelain, summary_width);
+				 "fetch first",
+				 report, porcelain, summary_width);
 		break;
 	case REF_STATUS_REJECT_NEEDS_FORCE:
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
-				 "needs force", porcelain, summary_width);
+				 "needs force",
+				 report, porcelain, summary_width);
 		break;
 	case REF_STATUS_REJECT_STALE:
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
-				 "stale info", porcelain, summary_width);
+				 "stale info",
+				 report, porcelain, summary_width);
 		break;
 	case REF_STATUS_REJECT_SHALLOW:
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
 				 "new shallow roots not allowed",
-				 porcelain, summary_width);
+				 report, porcelain, summary_width);
 		break;
 	case REF_STATUS_REMOTE_REJECT:
 		print_ref_status('!', "[remote rejected]", ref,
 				 ref->deletion ? NULL : ref->peer_ref,
-				 ref->remote_status, porcelain, summary_width);
+				 ref->remote_status,
+				 report, porcelain, summary_width);
 		break;
 	case REF_STATUS_EXPECTING_REPORT:
 		print_ref_status('!', "[remote failure]", ref,
 				 ref->deletion ? NULL : ref->peer_ref,
 				 "remote failed to report status",
-				 porcelain, summary_width);
+				 report, porcelain, summary_width);
 		break;
 	case REF_STATUS_ATOMIC_PUSH_FAILED:
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
-				 "atomic push failed", porcelain, summary_width);
+				 "atomic push failed",
+				 report, porcelain, summary_width);
 		break;
 	case REF_STATUS_OK:
-		print_ok_ref_status(ref, porcelain, summary_width);
+		print_ok_ref_status(ref, report, porcelain, summary_width);
 		break;
 	}
 
 	return 1;
 }
 
+static int print_one_push_status(struct ref *ref, const char *dest, int count,
+				 int porcelain, int summary_width)
+{
+	struct ref_push_report *report;
+	int n = 0;
+
+	if (!ref->report)
+		return print_one_push_report(ref, dest, count,
+					     NULL, porcelain, summary_width);
+
+	for (report = ref->report; report; report = report->next)
+		print_one_push_report(ref, dest, count + n++,
+				      report, porcelain, summary_width);
+	return n;
+}
+
 static int measure_abbrev(const struct object_id *oid, int sofar)
 {
 	char hex[GIT_MAX_HEXSZ + 1];
-- 
2.26.2.543.ge7de2a6e37

