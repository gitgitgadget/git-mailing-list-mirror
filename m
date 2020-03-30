Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55770C2D0EF
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 16:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E4920776
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 16:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q1a8/ueJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730194AbgC3Q6L (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 12:58:11 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:46320 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbgC3Q6K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 12:58:10 -0400
Received: by mail-pf1-f173.google.com with SMTP id q3so8853371pff.13
        for <git@vger.kernel.org>; Mon, 30 Mar 2020 09:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nZ9V5SHmsHZAHi0iGUfkU+8+hk73Wbz1mHwZkMVjlcs=;
        b=q1a8/ueJFyDaMW1lkRh80v8fyRBo1avq6gX9iFawYdYVVJdzN2KGbFgrC+jYgndZn/
         7Dow7rJHH1ah9tR5bI6D+rQrPCR1l8z1twCDwc8Q86Qldmr1zj/ygHMY8km6eerxVA9m
         NNcuIB0Z+Y7fdshM9M6ccL6ZCYgpZYgph4f62TMyN+ozOkJj+4WbrGXwucb5XIMwyAKd
         voAIo7CqX9Wbm+E+micbnVGDhitrnSA9oqINZdvwopK2RLO5nj+uFuKKTZ7xvy8QayiD
         VTFsrm6dz3rwQmwTTx+D2MnttqnZH7a4SPOmtYX0XwMQ6hveZWXmIEgzPbTkGKRoF8UN
         fkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nZ9V5SHmsHZAHi0iGUfkU+8+hk73Wbz1mHwZkMVjlcs=;
        b=VvoidkSpmFO1W/qcghBkLHg/gy046mE0VBPqCrFCw1UgppfDmVehDZaY7P1mjjrSZa
         yHki6OQ3puVzW9mtJm83+ACKI7Y0IcuJI4xnCe7J6+xAUWZHnz+PfC2TTTZ/ICz/VUt0
         lsY8dc/PNNCLZ7dSJ3AY7tBju5KgNwy+WjSB+EQtm+e3uX/vsuui796m87WKwyXOC4jc
         A5fkeQ0zdUW/uI33vA0h/pDHwUfEulxG+i9bQ6SSypc1AFTohd7UiRyNrIQMLhXsAQ0i
         OjyzJS1mOCjm7C0zCpaQp2vPbJ/uC59lJ4PAlqmYHLoCmcAmrEDoqIuODr04ZVcRK1w6
         981Q==
X-Gm-Message-State: ANhLgQ1GeBocB0Nv1Gdt3S0eZcgIb8bbrTDSF6HUSYTMMheyK8ES7xsO
        sXiai/mEr+0k+V9CSFcgs+8=
X-Google-Smtp-Source: ADFU+vuWXGhftqyx11+fUGm8U89Ydjb9W2BjztXFMeW75xdMAYttY2Kkn5lV9PyZIJxIsUmaRmLlcQ==
X-Received: by 2002:a63:7b5e:: with SMTP id k30mr13452410pgn.209.1585587488193;
        Mon, 30 Mar 2020 09:58:08 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id a24sm10589604pfl.115.2020.03.30.09.58.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Mar 2020 09:58:07 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v5 5/6] receive-pack: refactor report for proc-receive
Date:   Mon, 30 Mar 2020 12:57:53 -0400
Message-Id: <20200330165754.19195-6-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200304113312.34229-1-zhiyou.jx@alibaba-inc.com>
References: <20200304113312.34229-1-zhiyou.jx@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

The "proc-receive" may update one or more references, and will send its
result one by one in pkt-line format.  Each line of the result has four
fields and one optional message field, as "<old-oid> <new-oid> <ref>
<status> [<message>]".  See the following example:

    # OK, run this command successfully.
    PKT-LINE(old-oid new-oid ref ok)

    # NO, I reject it.
    PKT-LINE(old-oid new-oid ref ng reason)

    # OK, but use an alternate reference.
    PKT-LINE(old-oid new-oid ref ok ref:alt-ref)

    # It will fallthrough to receive-pack to execute.
    PKT-LINE(old-oid new-oid ref ft)

The first three fields have the same foramt as a command.

The forth field has a two-letter status code.  Available status code:

* ok: The command runs successfully.  If the optional message has a
  prefix "ref:", the hook has created/updated an alternate reference
  instead.

* ng: Fail to run the command. Error message is in the optional message
  field.

* ft: Will fallthrough to receive-pack to execute.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 builtin/receive-pack.c       | 21 +++++++--
 t/t5411-proc-receive-hook.sh | 90 +++++++++++++++++++++++++++++++++---
 transport-helper.c           | 64 ++++++++++++-------------
 transport.c                  | 59 +++++++++++++----------
 4 files changed, 168 insertions(+), 66 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 21b3a1d3fa..5e98eac3aa 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -328,6 +328,7 @@ static void write_head_info(void)
 struct command {
 	struct command *next;
 	const char *error_string;
+	const char *extra_string;
 	unsigned int skip_update:1,
 		     did_not_exist:1,
 		     run_proc_receive:2;
@@ -906,7 +907,12 @@ static int read_proc_receive_result(struct packet_reader *reader,
 			else
 				hint->error_string = "failed";
 			code = 1;
-		} else if (strcmp("ok", status)) {
+		} else if (!strcmp("ok", status)) {
+			hint->extra_string = xstrdup_or_null(msg);
+		} else if (!strcmp("ft", status)) {
+			/* Reset "run_proc_receive" field, and continue to run in "receive-pack" */
+			hint->run_proc_receive = 0;
+		} else {
 			die("protocol error: proc-receive has bad status '%s' for '%s'",
 			    status, reader->line);
 		}
@@ -2161,12 +2167,17 @@ static void report(struct command *commands, const char *unpack_status)
 	packet_buf_write(&buf, "unpack %s\n",
 			 unpack_status ? unpack_status : "ok");
 	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (!cmd->error_string)
-			packet_buf_write(&buf, "ok %s\n",
-					 cmd->ref_name);
-		else
+		if (!cmd->error_string) {
+			if (!cmd->extra_string)
+				packet_buf_write(&buf, "ok %s\n",
+						 cmd->ref_name);
+			else
+				packet_buf_write(&buf, "ok %s%c%s\n",
+						 cmd->ref_name, ' ', cmd->extra_string);
+		} else {
 			packet_buf_write(&buf, "ng %s %s\n",
 					 cmd->ref_name, cmd->error_string);
+		}
 	}
 	packet_buf_flush(&buf);
 
diff --git a/t/t5411-proc-receive-hook.sh b/t/t5411-proc-receive-hook.sh
index 4c3699fa85..119fd2fe59 100755
--- a/t/t5411-proc-receive-hook.sh
+++ b/t/t5411-proc-receive-hook.sh
@@ -726,9 +726,9 @@ test_expect_success "setup proc-receive hook" '
 	printf >&2 "# proc-receive hook\n"
 
 	test-tool proc-receive -v \
-		-r "$ZERO_OID $A refs/for/next/topic ok" \
+		-r "$ZERO_OID $A refs/for/next/topic ok ref:refs/pull/123/head" \
 		-r "$ZERO_OID $A refs/review/a/b/c/topic ok" \
-		-r "$ZERO_OID $A refs/for/master/topic ok"
+		-r "$ZERO_OID $A refs/for/master/topic ok ref:refs/pull/124/head"
 	EOF
 	chmod a+x upstream/hooks/proc-receive
 '
@@ -752,17 +752,17 @@ test_expect_success "report update of all special refs" '
 	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
 	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic
 	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
-	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/next/topic ok
+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/next/topic ok ref:refs/pull/123/head
 	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic ok
-	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic ok
+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic ok ref:refs/pull/124/head
 	remote: # post-receive hook
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
 	To ../upstream
-	 * [new reference] HEAD -> refs/for/next/topic
+	 * [new reference] HEAD -> refs/pull/123/head
 	 * [new reference] HEAD -> refs/review/a/b/c/topic
-	 * [new reference] HEAD -> refs/for/master/topic
+	 * [new reference] HEAD -> refs/pull/124/head
 	EOF
 	test_cmp expect actual &&
 	git -C upstream show-ref >out &&
@@ -791,6 +791,7 @@ test_expect_success "setup proc-receive hook" '
 # git push         :                       bar(A)  baz(A)  refs/for/next/topic(A)  foo(A)  refs/for/master/topic(A)
 test_expect_success "report mixed refs update" '
 	git -C workbench push origin \
+		$B:refs/heads/master \
 		HEAD:refs/heads/bar \
 		HEAD:refs/heads/baz \
 		HEAD:refs/for/next/topic \
@@ -800,6 +801,7 @@ test_expect_success "report mixed refs update" '
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
+	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/bar
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
@@ -811,12 +813,14 @@ test_expect_success "report mixed refs update" '
 	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/next/topic ok
 	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic ok
 	remote: # post-receive hook
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/bar
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
 	To ../upstream
+	 <OID>..<OID> <COMMIT-B> -> master
 	 * [new branch] HEAD -> bar
 	 * [new branch] HEAD -> baz
 	 * [new reference] HEAD -> refs/for/next/topic
@@ -830,6 +834,80 @@ test_expect_success "report mixed refs update" '
 	<COMMIT-A> refs/heads/bar
 	<COMMIT-A> refs/heads/baz
 	<COMMIT-A> refs/heads/foo
+	<COMMIT-B> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "config receive.procReceiveRefs for all ref/" '
+	git -C upstream config --add receive.procReceiveRefs refs/
+'
+
+test_expect_success "setup proc-receive hook" '
+	cat >upstream/hooks/proc-receive <<-EOF &&
+	#!/bin/sh
+
+	printf >&2 "# proc-receive hook\n"
+
+	test-tool proc-receive -v \
+		-r "$B $A refs/heads/master ft" \
+		-r "$A $ZERO_OID refs/heads/foo ft" \
+		-r "$A $B refs/heads/bar ft" \
+		-r "$A $B refs/for/master/topic ok ref:refs/pull/123/head" \
+		-r "$B $A refs/for/next/topic ok ref:refs/pull/124/head"
+	EOF
+	chmod a+x upstream/hooks/proc-receive
+'
+
+# Refs of upstream : master(B)             foo(A)  bar(A))  baz(A)
+# Refs of workbench: master(A)  tags/v123
+# git push -f      :                       (NULL)  (B)              refs/for/master/topic(A)  refs/for/next/topic(A)
+test_expect_success "report test: fallthrough" '
+	git -C workbench push -f origin \
+		HEAD:refs/heads/master \
+		:refs/heads/foo \
+		$B:refs/heads/bar \
+		HEAD:refs/for/master/topic \
+		HEAD:refs/for/next/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/bar
+	remote: pre-receive< <COMMIT-A> <ZERO-OID> refs/heads/foo
+	remote: pre-receive< <COMMIT-B> <COMMIT-A> refs/heads/master
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <COMMIT-A> <COMMIT-B> refs/heads/bar
+	remote: proc-receive< <COMMIT-A> <ZERO-OID> refs/heads/foo
+	remote: proc-receive< <COMMIT-B> <COMMIT-A> refs/heads/master
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
+	remote: proc-receive> <COMMIT-B> <COMMIT-A> refs/heads/master ft
+	remote: proc-receive> <COMMIT-A> <ZERO-OID> refs/heads/foo ft
+	remote: proc-receive> <COMMIT-A> <COMMIT-B> refs/heads/bar ft
+	remote: proc-receive> <COMMIT-A> <COMMIT-B> refs/for/master/topic ok ref:refs/pull/123/head
+	remote: proc-receive> <COMMIT-B> <COMMIT-A> refs/for/next/topic ok ref:refs/pull/124/head
+	remote: # post-receive hook
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/bar
+	remote: post-receive< <COMMIT-A> <ZERO-OID> refs/heads/foo
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/heads/master
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/for/next/topic
+	To ../upstream
+	 <OID>..<OID> <COMMIT-B> -> bar
+	 - [deleted] foo
+	 + <OID>...<OID> HEAD -> master (forced update)
+	 * [new reference] HEAD -> refs/pull/123/head
+	 * [new reference] HEAD -> refs/pull/124/head
+	EOF
+	test_cmp expect actual &&
+	git -C upstream show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-B> refs/heads/bar
+	<COMMIT-A> refs/heads/baz
 	<COMMIT-A> refs/heads/master
 	EOF
 	test_cmp expect actual
diff --git a/transport-helper.c b/transport-helper.c
index 20a7185ec4..cec3495d59 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -747,37 +747,39 @@ static int push_update_ref_status(struct strbuf *buf,
 			msg = xstrdup(msg);
 		strbuf_release(&msg_buf);
 
-		if (!strcmp(msg, "no match")) {
-			status = REF_STATUS_NONE;
-			FREE_AND_NULL(msg);
-		}
-		else if (!strcmp(msg, "up to date")) {
-			status = REF_STATUS_UPTODATE;
-			FREE_AND_NULL(msg);
-		}
-		else if (!strcmp(msg, "non-fast forward")) {
-			status = REF_STATUS_REJECT_NONFASTFORWARD;
-			FREE_AND_NULL(msg);
-		}
-		else if (!strcmp(msg, "already exists")) {
-			status = REF_STATUS_REJECT_ALREADY_EXISTS;
-			FREE_AND_NULL(msg);
-		}
-		else if (!strcmp(msg, "fetch first")) {
-			status = REF_STATUS_REJECT_FETCH_FIRST;
-			FREE_AND_NULL(msg);
-		}
-		else if (!strcmp(msg, "needs force")) {
-			status = REF_STATUS_REJECT_NEEDS_FORCE;
-			FREE_AND_NULL(msg);
-		}
-		else if (!strcmp(msg, "stale info")) {
-			status = REF_STATUS_REJECT_STALE;
-			FREE_AND_NULL(msg);
-		}
-		else if (!strcmp(msg, "forced update")) {
-			forced = 1;
-			FREE_AND_NULL(msg);
+		if (status != REF_STATUS_OK) {
+			if (!strcmp(msg, "no match")) {
+				status = REF_STATUS_NONE;
+				FREE_AND_NULL(msg);
+			}
+			else if (!strcmp(msg, "up to date")) {
+				status = REF_STATUS_UPTODATE;
+				FREE_AND_NULL(msg);
+			}
+			else if (!strcmp(msg, "non-fast forward")) {
+				status = REF_STATUS_REJECT_NONFASTFORWARD;
+				FREE_AND_NULL(msg);
+			}
+			else if (!strcmp(msg, "already exists")) {
+				status = REF_STATUS_REJECT_ALREADY_EXISTS;
+				FREE_AND_NULL(msg);
+			}
+			else if (!strcmp(msg, "fetch first")) {
+				status = REF_STATUS_REJECT_FETCH_FIRST;
+				FREE_AND_NULL(msg);
+			}
+			else if (!strcmp(msg, "needs force")) {
+				status = REF_STATUS_REJECT_NEEDS_FORCE;
+				FREE_AND_NULL(msg);
+			}
+			else if (!strcmp(msg, "stale info")) {
+				status = REF_STATUS_REJECT_STALE;
+				FREE_AND_NULL(msg);
+			}
+			else if (!strcmp(msg, "forced update")) {
+				forced = 1;
+				FREE_AND_NULL(msg);
+			}
 		}
 	}
 
diff --git a/transport.c b/transport.c
index 272c0f4046..28731fa014 100644
--- a/transport.c
+++ b/transport.c
@@ -459,15 +459,18 @@ void transport_update_tracking_ref(struct remote *remote, struct ref *ref, int v
 	}
 }
 
-static void print_ref_status(char flag, const char *summary,
+static void print_ref_status(char flag, const char *summary, char *target_refname,
 			     struct ref *to, struct ref *from, const char *msg,
 			     int porcelain, int summary_width)
 {
+	if (!target_refname)
+		target_refname = to->name;
+
 	if (porcelain) {
 		if (from)
-			fprintf(stdout, "%c\t%s:%s\t", flag, from->name, to->name);
+			fprintf(stdout, "%c\t%s:%s\t", flag, from->name, target_refname);
 		else
-			fprintf(stdout, "%c\t:%s\t", flag, to->name);
+			fprintf(stdout, "%c\t:%s\t", flag, target_refname);
 		if (msg)
 			fprintf(stdout, "%s (%s)\n", summary, msg);
 		else
@@ -481,9 +484,9 @@ static void print_ref_status(char flag, const char *summary,
 		fprintf(stderr, " %s%c %-*s%s ", red, flag, summary_width,
 			summary, reset);
 		if (from)
-			fprintf(stderr, "%s -> %s", prettify_refname(from->name), prettify_refname(to->name));
+			fprintf(stderr, "%s -> %s", prettify_refname(from->name), prettify_refname(target_refname));
 		else
-			fputs(prettify_refname(to->name), stderr);
+			fputs(prettify_refname(target_refname), stderr);
 		if (msg) {
 			fputs(" (", stderr);
 			fputs(msg, stderr);
@@ -495,18 +498,26 @@ static void print_ref_status(char flag, const char *summary,
 
 static void print_ok_ref_status(struct ref *ref, int porcelain, int summary_width)
 {
+	char *refname;
+
+	if (ref->remote_status && !strncmp(ref->remote_status, "ref:", 4))
+		refname = ref->remote_status + 4;
+	else
+		refname = ref->name;
+
 	if (ref->deletion)
-		print_ref_status('-', "[deleted]", ref, NULL, NULL,
+		print_ref_status('-', "[deleted]", refname, ref, NULL, NULL,
 				 porcelain, summary_width);
-	else if (is_null_oid(&ref->old_oid))
+	else if (is_null_oid(&ref->old_oid)) {
+
 		print_ref_status('*',
-				 (starts_with(ref->name, "refs/tags/")
+				 (starts_with(refname, "refs/tags/")
 				  ? "[new tag]"
-				  : (starts_with(ref->name, "refs/heads/")
+				  : (starts_with(refname, "refs/heads/")
 				     ? "[new branch]"
 				     : "[new reference]")),
-				 ref, ref->peer_ref, NULL, porcelain, summary_width);
-	else {
+				 refname, ref, ref->peer_ref, NULL, porcelain, summary_width);
+	} else {
 		struct strbuf quickref = STRBUF_INIT;
 		char type;
 		const char *msg;
@@ -525,7 +536,7 @@ static void print_ok_ref_status(struct ref *ref, int porcelain, int summary_widt
 		strbuf_add_unique_abbrev(&quickref, &ref->new_oid,
 					 DEFAULT_ABBREV);
 
-		print_ref_status(type, quickref.buf, ref, ref->peer_ref, msg,
+		print_ref_status(type, quickref.buf, refname, ref, ref->peer_ref, msg,
 				 porcelain, summary_width);
 		strbuf_release(&quickref);
 	}
@@ -542,56 +553,56 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count,
 
 	switch(ref->status) {
 	case REF_STATUS_NONE:
-		print_ref_status('X', "[no match]", ref, NULL, NULL,
+		print_ref_status('X', "[no match]", NULL, ref, NULL, NULL,
 				 porcelain, summary_width);
 		break;
 	case REF_STATUS_REJECT_NODELETE:
-		print_ref_status('!', "[rejected]", ref, NULL,
+		print_ref_status('!', "[rejected]", NULL, ref, NULL,
 				 "remote does not support deleting refs",
 				 porcelain, summary_width);
 		break;
 	case REF_STATUS_UPTODATE:
-		print_ref_status('=', "[up to date]", ref,
+		print_ref_status('=', "[up to date]", NULL, ref,
 				 ref->peer_ref, NULL, porcelain, summary_width);
 		break;
 	case REF_STATUS_REJECT_NONFASTFORWARD:
-		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
+		print_ref_status('!', "[rejected]", NULL, ref, ref->peer_ref,
 				 "non-fast-forward", porcelain, summary_width);
 		break;
 	case REF_STATUS_REJECT_ALREADY_EXISTS:
-		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
+		print_ref_status('!', "[rejected]", NULL, ref, ref->peer_ref,
 				 "already exists", porcelain, summary_width);
 		break;
 	case REF_STATUS_REJECT_FETCH_FIRST:
-		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
+		print_ref_status('!', "[rejected]", NULL, ref, ref->peer_ref,
 				 "fetch first", porcelain, summary_width);
 		break;
 	case REF_STATUS_REJECT_NEEDS_FORCE:
-		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
+		print_ref_status('!', "[rejected]", NULL, ref, ref->peer_ref,
 				 "needs force", porcelain, summary_width);
 		break;
 	case REF_STATUS_REJECT_STALE:
-		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
+		print_ref_status('!', "[rejected]", NULL, ref, ref->peer_ref,
 				 "stale info", porcelain, summary_width);
 		break;
 	case REF_STATUS_REJECT_SHALLOW:
-		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
+		print_ref_status('!', "[rejected]", NULL, ref, ref->peer_ref,
 				 "new shallow roots not allowed",
 				 porcelain, summary_width);
 		break;
 	case REF_STATUS_REMOTE_REJECT:
-		print_ref_status('!', "[remote rejected]", ref,
+		print_ref_status('!', "[remote rejected]", NULL, ref,
 				 ref->deletion ? NULL : ref->peer_ref,
 				 ref->remote_status, porcelain, summary_width);
 		break;
 	case REF_STATUS_EXPECTING_REPORT:
-		print_ref_status('!', "[remote failure]", ref,
+		print_ref_status('!', "[remote failure]", NULL, ref,
 				 ref->deletion ? NULL : ref->peer_ref,
 				 "remote failed to report status",
 				 porcelain, summary_width);
 		break;
 	case REF_STATUS_ATOMIC_PUSH_FAILED:
-		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
+		print_ref_status('!', "[rejected]", NULL, ref, ref->peer_ref,
 				 "atomic push failed", porcelain, summary_width);
 		break;
 	case REF_STATUS_OK:
-- 
2.26.0.4.g39bcdcb101.dirty

