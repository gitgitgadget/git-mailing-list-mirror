Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29E0C2BB54
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 12:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B8F206F7
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 12:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiT9VFAA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbgDGMIZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 08:08:25 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:34984 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbgDGMIY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 08:08:24 -0400
Received: by mail-pf1-f180.google.com with SMTP id a13so732238pfa.2
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 05:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v1jJN+P+rvSSaTa0cMo/s2c7wwX384ryG7L7urnsdJ4=;
        b=AiT9VFAABlA1TcuhtqLJREz8+Yh01y+O4XujaVBISU3k39Yvsjs7F84MBGXz5vkIHs
         22PKOkmxOLAXaogAMHWnY2O2Nd94LMlg2b/G5s850DQoKeLDp/TaiKrj7PPtKw9fWWCy
         4avaQFUOskAT/aACmPjn1TpUknhM/LxFLagHVBD9JAiBok1C2IbG5g2gjznXFeIExmKd
         lW42sLk6MtqrhgLXTc0hfF22Vj04BhPHoU7TpIYIzinbeIjef7RHkPOzzHBR+aWBl/7I
         d7vJRlaFJW3JpyICYGwlsFbSaONnIngdJiOjGdy2POl0vjLjvnI2wwpOjB5BvSga0HUZ
         eabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v1jJN+P+rvSSaTa0cMo/s2c7wwX384ryG7L7urnsdJ4=;
        b=dltKcVHPyHYIOgh2UUTibY8C3tSKJwoAekQGYb23X5Oy5xWtDVHufYbUn2L2aL19uT
         eUCb5IwN/xkI7GQ106g7D48Dw4yOshrU1m9OSXGaaqEiUH3ZMXHo5Ns/IaqN+Dpu0cQ2
         WX/0BI4znuw9xbc69xB+Ap8MDar5pLFUmUZcn0xjvHxhT99fqAQ3vt4nZDs3fmI5a/+A
         x8EbNR70We3fhx+AWiscJlXfP0MGW/hBcp2i8y6ELnpflu2XTNkt0FkHZfweoJrggp4X
         8vY4AEJbbet68nXELh/hkZA4RXe0h2s5H47sZJwwblDrLDY31rh76hCQl+5Qok7+S6sD
         GfsA==
X-Gm-Message-State: AGi0PuZLLSeXg6UQ+tt06aj1npJG3wNyqFvAfCz1F8g/NAgcGh1Ql6ki
        /Nl5aC8Xk/ECGPIQovLE3d0=
X-Google-Smtp-Source: APiQypKmYqYioRL9std5JUImKrl/kd4SvvlS/n4oogE4gRMcElIkQ0Qf5A7JInwq+tcR0ygBKmD3pw==
X-Received: by 2002:a65:68cb:: with SMTP id k11mr1728098pgt.78.1586261303213;
        Tue, 07 Apr 2020 05:08:23 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id e26sm14061833pfj.61.2020.04.07.05.08.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2020 05:08:22 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v9 5/6] receive-pack: refactor report for proc-receive
Date:   Tue,  7 Apr 2020 08:08:12 -0400
Message-Id: <20200407120813.25025-6-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200404134345.10655-1-worldhello.net@gmail.com>
References: <20200404134345.10655-1-worldhello.net@gmail.com>
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
 builtin/receive-pack.c       | 24 +++++++---
 t/t5411/common-test-cases.sh | 90 +++++++++++++++++++++++++++++++++---
 transport-helper.c           | 64 ++++++++++++-------------
 transport.c                  | 25 ++++++++--
 4 files changed, 156 insertions(+), 47 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index a78daa6733..73acb1b5c8 100644
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
@@ -913,7 +914,12 @@ static int read_proc_receive_result(struct packet_reader *reader,
 			else
 				hint->error_string = "failed";
 			code = -1;
-		} else if (strcmp("ok", status)) {
+		} else if (!strcmp("ok", status)) {
+			hint->extra_string = xstrdup_or_null(msg);
+		} else if (!strcmp("ft", status)) {
+			/* Reset "run_proc_receive" field, and continue to run in "receive-pack" */
+			hint->run_proc_receive = 0;
+		} else {
 			strbuf_addf(errmsg, "proc-receive has bad status '%s' for '%s'\n",
 				    status, reader->line);
 			code = -1;
@@ -922,7 +928,8 @@ static int read_proc_receive_result(struct packet_reader *reader,
 		}
 		oidcpy(&hint->old_oid, &old_oid);
 		oidcpy(&hint->new_oid, &new_oid);
-		hint->run_proc_receive |= RUN_PROC_RECEIVE_RETURNED;
+		if (hint->run_proc_receive)
+			hint->run_proc_receive |= RUN_PROC_RECEIVE_RETURNED;
 	}
 
 	for (cmd = commands; cmd; cmd = cmd->next)
@@ -2188,12 +2195,17 @@ static void report(struct command *commands, const char *unpack_status)
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
 
diff --git a/t/t5411/common-test-cases.sh b/t/t5411/common-test-cases.sh
index a9e80c374b..a2a16c0ed4 100644
--- a/t/t5411/common-test-cases.sh
+++ b/t/t5411/common-test-cases.sh
@@ -640,8 +640,8 @@ test_expect_success "setup proc-receive hook" '
 
 	test-tool proc-receive -v \
 		-r "$ZERO_OID $A refs/review/a/b/c/topic ok" \
-		-r "$ZERO_OID $A refs/for/next/topic ok" \
-		-r "$ZERO_OID $A refs/for/master/topic ok"
+		-r "$ZERO_OID $A refs/for/next/topic ok ref:refs/pull/123/head" \
+		-r "$ZERO_OID $A refs/for/master/topic ok ref:refs/pull/124/head"
 	EOF
 	chmod a+x "$upstream/hooks/proc-receive"
 '
@@ -666,16 +666,16 @@ test_expect_success "report update of all special refs" '
 	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic
 	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
 	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic ok
-	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/next/topic ok
-	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic ok
+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/next/topic ok ref:refs/pull/123/head
+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic ok ref:refs/pull/124/head
 	remote: # post-receive hook
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
 	To <URL/of/upstream.git>
-	 * [new reference] HEAD -> refs/for/next/topic
+	 * [new reference] HEAD -> refs/pull/123/head
 	 * [new reference] HEAD -> refs/review/a/b/c/topic
-	 * [new reference] HEAD -> refs/for/master/topic
+	 * [new reference] HEAD -> refs/pull/124/head
 	EOF
 	test_cmp expect actual &&
 	git -C "$upstream" show-ref >out &&
@@ -704,6 +704,7 @@ test_expect_success "setup proc-receive hook" '
 # git push         :                       bar(A)  baz(A)  refs/for/next/topic(A)  foo(A)  refs/for/master/topic(A)
 test_expect_success "report mixed refs update" '
 	git -C workbench push origin \
+		$B:refs/heads/master \
 		HEAD:refs/heads/bar \
 		HEAD:refs/heads/baz \
 		HEAD:refs/for/next/topic \
@@ -713,6 +714,7 @@ test_expect_success "report mixed refs update" '
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
+	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/bar
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
@@ -724,12 +726,14 @@ test_expect_success "report mixed refs update" '
 	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/next/topic ok
 	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic ok
 	remote: # post-receive hook
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/bar
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
 	To <URL/of/upstream.git>
+	 <OID>..<OID> <COMMIT-B> -> master
 	 * [new branch] HEAD -> bar
 	 * [new branch] HEAD -> baz
 	 * [new reference] HEAD -> refs/for/next/topic
@@ -743,6 +747,80 @@ test_expect_success "report mixed refs update" '
 	<COMMIT-A> refs/heads/bar
 	<COMMIT-A> refs/heads/baz
 	<COMMIT-A> refs/heads/foo
+	<COMMIT-B> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "config receive.procReceiveRefs for all ref/" '
+	git -C "$upstream" config --add receive.procReceiveRefs refs/
+'
+
+test_expect_success "setup proc-receive hook" '
+	cat >"$upstream/hooks/proc-receive" <<-EOF &&
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
+	chmod a+x "$upstream/hooks/proc-receive"
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
+	To <URL/of/upstream.git>
+	 <OID>..<OID> <COMMIT-B> -> bar
+	 - [deleted] foo
+	 + <OID>...<OID> HEAD -> master (forced update)
+	 * [new reference] HEAD -> refs/pull/123/head
+	 * [new reference] HEAD -> refs/pull/124/head
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
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
index 272c0f4046..97b7c6a442 100644
--- a/transport.c
+++ b/transport.c
@@ -463,11 +463,28 @@ static void print_ref_status(char flag, const char *summary,
 			     struct ref *to, struct ref *from, const char *msg,
 			     int porcelain, int summary_width)
 {
+	char *from_name = NULL;
+	char *to_name = NULL;
+
+	if (from) {
+		if (from->remote_status && !strncmp(from->remote_status, "ref:", 4))
+			from_name = from->remote_status + 4;
+		else
+			from_name = from->name;
+	}
+
+	if (to) {
+		if (to->remote_status && !strncmp(to->remote_status, "ref:", 4))
+			to_name = to->remote_status + 4;
+		else
+			to_name = to->name;
+	}
+
 	if (porcelain) {
 		if (from)
-			fprintf(stdout, "%c\t%s:%s\t", flag, from->name, to->name);
+			fprintf(stdout, "%c\t%s:%s\t", flag, from_name, to_name);
 		else
-			fprintf(stdout, "%c\t:%s\t", flag, to->name);
+			fprintf(stdout, "%c\t:%s\t", flag, to_name);
 		if (msg)
 			fprintf(stdout, "%s (%s)\n", summary, msg);
 		else
@@ -481,9 +498,9 @@ static void print_ref_status(char flag, const char *summary,
 		fprintf(stderr, " %s%c %-*s%s ", red, flag, summary_width,
 			summary, reset);
 		if (from)
-			fprintf(stderr, "%s -> %s", prettify_refname(from->name), prettify_refname(to->name));
+			fprintf(stderr, "%s -> %s", prettify_refname(from_name), prettify_refname(to_name));
 		else
-			fputs(prettify_refname(to->name), stderr);
+			fputs(prettify_refname(to_name), stderr);
 		if (msg) {
 			fputs(" (", stderr);
 			fputs(msg, stderr);
-- 
2.24.1.15.g448c31058d.agit.4.5

