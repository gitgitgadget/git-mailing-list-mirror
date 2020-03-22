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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AD4C4332B
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 13:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DADF206C3
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 13:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbwQyprC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgCVNSd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 09:18:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45698 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgCVNSc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 09:18:32 -0400
Received: by mail-pf1-f195.google.com with SMTP id j10so6053771pfi.12
        for <git@vger.kernel.org>; Sun, 22 Mar 2020 06:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PESyKR4iPcYjgIHxcQV4H+XVpUpKr0EsxBPuGFVqUdY=;
        b=hbwQyprC/+E7LOUBwOwOEG35giz9NY56wDwOtTAkvSnpERoxjgev9npNfTwdkrC1N4
         ylRrlaph7DUd2+nZxhC82yLtUE88eDl9k4o3BJf/Y++/Yu//ksZ+6NojT5hrxZoP4nOh
         anPX/vdQgcOvt1l7+/0KMtdcXmK1Dtq9tCC/PNmumPN8JPLZ4EZGLAHOf1qSDyfLZAxc
         WI2PJDsXPFq+bTaYrr7k6s+ne2MtNYYMngwukuZ6ULskn7KUhA2qMEeJ5SfK9cRFZi5+
         FSHTrJgavuzP+H1eh3PwBKXgG5wtWyNquoX+7JSRwAlb+XCm8yFSDVnezwIaJO9mu+aO
         qeLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PESyKR4iPcYjgIHxcQV4H+XVpUpKr0EsxBPuGFVqUdY=;
        b=jjcFySo3nWZdinkuYOkSZRYmBQWFDQojyTF5cZDXD5W0yczKVPR2iY4j6YjkStYjE0
         PXGwAE1cXfhBHPuXVaVyLAIZlHx7SNPRkl95R/I0fu1gZnw9uo1s6u27uuaCS9LukPRj
         a1io420BlLIZymoRUDAVnQvwbTApxStQfnQ0xWw65Xzfba7Qli38bbdoTTUlXqoXRu30
         O4AajcSYk84bL0pSwc4EueV5mJEmSgYZai22LywWjOCJRPJf32fX29HXOrdE4CQRX8gi
         aZMw/g3u3sVCSQ+kFcoijCoifWEOknHgwwG7qRSnQWYqG6M1LNwlc4TTsl4cvsNoHE3k
         i/Rw==
X-Gm-Message-State: ANhLgQ2khIKbquL4oMUiJFnRxeqSsNJapWSk7jNT4WkWXl1QoZMxV9S6
        UQJ91figwjF2kUWT/n9tTOQ=
X-Google-Smtp-Source: ADFU+vtdUee6K8m/8MRMa+YWTJk3U0CT6PjQIecPGs11CCwAXYuJK4V3azT5f+D4ry8q+T8TxpUhBg==
X-Received: by 2002:a63:fd0d:: with SMTP id d13mr15400329pgh.302.1584883109813;
        Sun, 22 Mar 2020 06:18:29 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id nh4sm9456432pjb.39.2020.03.22.06.18.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Mar 2020 06:18:29 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v4 5/5] receive-pack: refactor report for proc-receive
Date:   Sun, 22 Mar 2020 09:18:15 -0400
Message-Id: <20200322131815.11872-6-worldhello.net@gmail.com>
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

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 builtin/receive-pack.c       | 21 +++++++--
 t/t5411-proc-receive-hook.sh | 90 +++++++++++++++++++++++++++++++++---
 transport.c                  | 27 +++++++----
 3 files changed, 119 insertions(+), 19 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index fef97e6985..c791f562d0 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -326,6 +326,7 @@ static void write_head_info(void)
 struct command {
 	struct command *next;
 	const char *error_string;
+	const char *extra_string;
 	unsigned int skip_update:1,
 		     did_not_exist:1,
 		     run_proc_receive:1;
@@ -883,7 +884,12 @@ static int read_proc_receive_result(struct packet_reader *reader,
 			else
 				cmd->error_string = "failed";
 			code = 1;
-		} else if (strcmp("ok", status)) {
+		} else if (!strcmp("ok", status)) {
+			cmd->extra_string = xstrdup_or_null(msg);
+		} else if (!strcmp("ft", status)) {
+			/* Reset "run_proc_receive" field, and continue to run in "receive-pack" */
+			cmd->run_proc_receive = 0;
+		} else {
 			die("protocol error: proc-receive has bad status '%s' for '%s'",
 			    status, reader->line);
 		}
@@ -2190,12 +2196,17 @@ static void report(struct command *commands, const char *unpack_status)
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
index f9681bed34..917988ab57 100755
--- a/t/t5411-proc-receive-hook.sh
+++ b/t/t5411-proc-receive-hook.sh
@@ -691,9 +691,9 @@ test_expect_success "setup proc-receive hook" '
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
@@ -716,17 +716,17 @@ test_expect_success "report update of all special refs" '
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
-	 * [new reference]   HEAD -> refs/for/next/topic
+	 * [new reference]   HEAD -> refs/pull/123/head
 	 * [new reference]   HEAD -> refs/review/a/b/c/topic
-	 * [new reference]   HEAD -> refs/for/master/topic
+	 * [new reference]   HEAD -> refs/pull/124/head
 	EOF
 	test_cmp expect actual &&
 	(
@@ -873,4 +873,82 @@ test_expect_success "report mixed refs update (special ref first)" '
 	test_cmp expect actual
 '
 
+test_expect_success "config receive.procReceiveRefs for all ref/" '
+	(
+		cd upstream &&
+		git config --add receive.procReceiveRefs refs/
+	)
+'
+
+test_expect_success "setup proc-receive hook" '
+	cat >upstream/hooks/proc-receive <<-EOF &&
+	#!/bin/sh
+
+	printf >&2 "# proc-receive hook\n"
+
+	test-tool proc-receive -v \
+		-r "$A $ZERO_OID refs/heads/yyy ft" \
+		-r "$B $A refs/heads/zzz ft" \
+		-r "$A $B refs/for/master/topic ok ref:refs/pull/123/head" \
+		-r "$A $B refs/heads/master ft" \
+		-r "$B $A refs/for/next/topic ok ref:refs/pull/124/head"
+	EOF
+	chmod a+x upstream/hooks/proc-receive
+'
+
+test_expect_success "report test: fallthrough" '
+	(
+		cd workbench &&
+		git push -f origin \
+			:refs/heads/yyy \
+			$A:refs/heads/zzz \
+			HEAD:refs/for/master/topic \
+			HEAD:refs/for/next/topic \
+			$B:refs/heads/master
+	) >out 2>&1 &&
+	format_git_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
+	remote: pre-receive< <COMMIT-A> <ZERO-OID> refs/heads/yyy
+	remote: pre-receive< <COMMIT-B> <COMMIT-A> refs/heads/zzz
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
+	remote: proc-receive< <COMMIT-A> <ZERO-OID> refs/heads/yyy
+	remote: proc-receive< <COMMIT-B> <COMMIT-A> refs/heads/zzz
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
+	remote: proc-receive> <COMMIT-A> <ZERO-OID> refs/heads/yyy ft
+	remote: proc-receive> <COMMIT-B> <COMMIT-A> refs/heads/zzz ft
+	remote: proc-receive> <COMMIT-A> <COMMIT-B> refs/for/master/topic ok ref:refs/pull/123/head
+	remote: proc-receive> <COMMIT-A> <COMMIT-B> refs/heads/master ft
+	remote: proc-receive> <COMMIT-B> <COMMIT-A> refs/for/next/topic ok ref:refs/pull/124/head
+	remote: # post-receive hook
+	remote: post-receive< <COMMIT-A> <ZERO-OID> refs/heads/yyy
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/heads/zzz
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/for/next/topic
+	To ../upstream
+	   1029397..ce858e6  <COMMIT-B> -> master
+	 - [deleted]         yyy
+	 + ce858e6...1029397 <COMMIT-A> -> zzz (forced update)
+	 * [new reference]   HEAD -> refs/pull/123/head
+	 * [new reference]   HEAD -> refs/pull/124/head
+	EOF
+	test_cmp expect actual &&
+	(
+		cd upstream &&
+		git show-ref
+	) >out &&
+	format_git_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-B> refs/heads/master
+	<COMMIT-A> refs/heads/zzz
+	EOF
+	test_cmp expect actual
+'
+
 test_done
diff --git a/transport.c b/transport.c
index b5b7bb841e..d51af11d48 100644
--- a/transport.c
+++ b/transport.c
@@ -463,11 +463,16 @@ static void print_ref_status(char flag, const char *summary,
 			     struct ref *to, struct ref *from, const char *msg,
 			     int porcelain, int summary_width)
 {
+	char *to_name = to->name;
+
+	if (to->remote_status && !strncmp("ref:", to->remote_status, 4))
+		to_name = to->remote_status + 4;
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
@@ -481,9 +486,9 @@ static void print_ref_status(char flag, const char *summary,
 		fprintf(stderr, " %s%c %-*s%s ", red, flag, summary_width,
 			summary, reset);
 		if (from)
-			fprintf(stderr, "%s -> %s", prettify_refname(from->name), prettify_refname(to->name));
+			fprintf(stderr, "%s -> %s", prettify_refname(from->name), prettify_refname(to_name));
 		else
-			fputs(prettify_refname(to->name), stderr);
+			fputs(prettify_refname(to_name), stderr);
 		if (msg) {
 			fputs(" (", stderr);
 			fputs(msg, stderr);
@@ -498,13 +503,19 @@ static void print_ok_ref_status(struct ref *ref, int porcelain, int summary_widt
 	if (ref->deletion)
 		print_ref_status('-', "[deleted]", ref, NULL, NULL,
 				 porcelain, summary_width);
-	else if (is_null_oid(&ref->old_oid))
+	else if (is_null_oid(&ref->old_oid)) {
+		char *refname;
+
+		if (ref->remote_status && !strncmp(ref->remote_status, "ref:", 4))
+			refname = ref->remote_status + 4;
+		else
+			refname = ref->name;
 		print_ref_status('*',
-			(starts_with(ref->name, "refs/tags/") ? "[new tag]" :
-			(starts_with(ref->name, "refs/heads/") ? "[new branch]" :
+			(starts_with(refname, "refs/tags/") ? "[new tag]" :
+			(starts_with(refname, "refs/heads/") ? "[new branch]" :
 			"[new reference]")),
 			ref, ref->peer_ref, NULL, porcelain, summary_width);
-	else {
+	} else {
 		struct strbuf quickref = STRBUF_INIT;
 		char type;
 		const char *msg;
-- 
2.26.0.rc1.33.g4914ba4bcf

