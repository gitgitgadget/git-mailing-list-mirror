Return-Path: <SRS0=e9fP=54=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38509C2BB85
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 13:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3BE620673
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 13:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXO/jmRB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgDLNaf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Apr 2020 09:30:35 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45564 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgDLNae (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Apr 2020 09:30:34 -0400
Received: by mail-pf1-f194.google.com with SMTP id r14so3363485pfl.12
        for <git@vger.kernel.org>; Sun, 12 Apr 2020 06:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DyKsoWBiwTvJAe8nLkby6crzUu1gfw6aZ/c7Bc9TE3Q=;
        b=FXO/jmRB9o+Co9A3QKHhuVEGPt5dJjimP/scB1cIDXLg+/30l99Ba/8Fk4EeoLW+B6
         33A8HmOTwH0JtOv/cwOzy7+8zPA57Hffgn5Fta6rAmddUl2H3zgo5+FnkxIeWxGaamfg
         nzTN+FSVMnGc8CtZDb6oJh9IaNQWc6WV5xpgqHwO9Eei3dDwdlp9f54qvnLS4sh+hWzL
         jSsIC24rJTIkI5QmQ/7gh8P4doIISb7qpeSY7mfLMUaJ1Jxfrmz3MosPJ0eEoELrsB7+
         C9R4L8uq8OnomMA5fg/BB4D13NWfGF13QjEn/jUulvDyez1xHLMXVVjXHrzwgmevph0j
         fCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DyKsoWBiwTvJAe8nLkby6crzUu1gfw6aZ/c7Bc9TE3Q=;
        b=PE45d5FOCSSiZuRg/6IA+Kw0kN78VTv/TEfObdwwEQWChtYUIL9yc754FdbYOZZfIS
         HonTAnKynJJ2/TS3PUfOfAVWi4yFatKmIfCWgbwj4mrEvoPv6Yjvekan8oKvH56j7U7I
         11ya07ImOfL3U9F6htdM+NjcLap2+9WVUAri8NgqxnTenKIl0wh58E5mmp7cCTdq20ee
         IBjw/Xk7ISWSiFuza2EEtuZaMBLpxFDTYIhJWYPZ5wFpc0Mgkrc+Y4x360NWO9c6Vran
         MpMGRkDVvPzzwmC7HsgRUQlEefHOBd6UdSJsh6kVsL+dPu4YnS8imMX4NCI9wzx4S9cJ
         Aw9g==
X-Gm-Message-State: AGi0PuZ9sPBj7vuCkeiucoTU9M1/U2WZVaco1sY8XQOyf5SFbUHieTpP
        6YfGVH/p40tFaXP+sC87CLUvCjV8
X-Google-Smtp-Source: APiQypIviMkvxiaK081WZWIbN/ftlWk4Hm5dYQTk5UhYy6y7ghbW13K4Dj2ix6/F9bKn0omiztP2VQ==
X-Received: by 2002:a63:a51e:: with SMTP id n30mr7687528pgf.85.1586698233568;
        Sun, 12 Apr 2020 06:30:33 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id 139sm6093363pfv.0.2020.04.12.06.30.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Apr 2020 06:30:33 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v10 6/8] receive-pack: extension for server-side report
Date:   Sun, 12 Apr 2020 09:30:20 -0400
Message-Id: <20200412133022.17590-7-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200407120813.25025-1-worldhello.net@gmail.com>
References: <20200407120813.25025-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Each command for the "proc-receive" hook may point to a pseudo-reference
and always has a zero-old as its old-oid.  But the "proc-receive" hook
may update an alternate reference and the reference may exist already
(has a non-zero old-oid).  And we may want certain commands to bypass
the "proc-receive" hook and let "receive-pack" handle them.

In order to report proper reference name, old-oid, and let certain
commands fall through, an extensible reporting method for "proc-receive"
and "receive-pack" is introduced.

The "proc-receive" hook can report its results in the following format:

    # OK, run this command successfully.
    PKT-LINE(<old-oid> <new-oid> <ref> ok)

    # NO, I reject it.
    PKT-LINE(<old-oid> <new-oid> <ref> ng <reason>)

    # Fall through, let "receive-pack" to execute it.
    PKT-LINE(<old-oid> <new-oid> <ref> ft)

    # OK, but has an alternate reference.  The alternate reference name
    # and other status are given in key=value pairs after the null
    # character.
    PKT-LINE(<old-oid> <new-oid> <ref> ok\0ref=refs/pull/123/head
             forced-update)

The reporting function for "receive-pack" is also extended using a
backward compatible way by adding key-value pairs after an null
character, like:

    # OK, run this command successfully with optional extended-status.
    ok <reference>\0ref=refs/pull/123/head old-oid=...

    # NO, I reject it.
    ng <reference> <error message>

This commit only includes changes on the server side, so we can make
a compatible test on old version of a Git client.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 builtin/receive-pack.c       | 51 +++++++++++++++++----
 t/helper/test-proc-receive.c | 14 +++++-
 t/t5411/common-test-cases.sh | 88 ++++++++++++++++++++++++++++++++++--
 3 files changed, 137 insertions(+), 16 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index bdd0f0f448..9f5309a014 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -328,6 +328,7 @@ static void write_head_info(void)
 struct command {
 	struct command *next;
 	const char *error_string;
+	const char *extended_status;
 	unsigned int skip_update:1,
 		     did_not_exist:1,
 		     run_proc_receive:2;
@@ -850,6 +851,7 @@ static int read_proc_receive_report(struct packet_reader *reader,
 {
 	struct command *cmd;
 	struct command *hint = NULL;
+	struct strbuf extended_status = STRBUF_INIT;
 	int code = 0;
 
 	for (;;) {
@@ -858,9 +860,11 @@ static int read_proc_receive_report(struct packet_reader *reader,
 		const char *p;
 		char *status;
 		char *msg = NULL;
+		int len;
 
 		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
 			break;
+		len = strlen(reader->line);
 		if (parse_oid_hex(reader->line, &old_oid, &p) ||
 		    *p++ != ' ' ||
 		    parse_oid_hex(p, &new_oid, &p) ||
@@ -912,6 +916,9 @@ static int read_proc_receive_report(struct packet_reader *reader,
 			else
 				hint->error_string = "failed";
 			code = -1;
+		} else if (!strcmp("ft", status)) {
+			/* Reset "run_proc_receive" field, and continue to run in "receive-pack" */
+			hint->run_proc_receive = 0;
 		} else if (strcmp("ok", status)) {
 			strbuf_addf(errmsg, "proc-receive has bad status '%s' for '%s'\n",
 				    status, reader->line);
@@ -919,9 +926,24 @@ static int read_proc_receive_report(struct packet_reader *reader,
 			/* Skip marking it as RUN_PROC_RECEIVE_RETURNED */
 			continue;
 		}
-		oidcpy(&hint->old_oid, &old_oid);
-		oidcpy(&hint->new_oid, &new_oid);
-		hint->run_proc_receive |= RUN_PROC_RECEIVE_RETURNED;
+		if (reader->pktlen > len)
+			strbuf_addstr(&extended_status, (char *)reader->line + len + 1);
+		if (oidcmp(&hint->old_oid, &old_oid)) {
+			oidcpy(&hint->old_oid, &old_oid);
+			strbuf_addf(&extended_status, "%sold-oid=%s",
+				    extended_status.len > 0 ? " ": "",
+				    oid_to_hex(&old_oid));
+		}
+		if (oidcmp(&hint->new_oid, &new_oid)) {
+			oidcpy(&hint->new_oid, &new_oid);
+			strbuf_addf(&extended_status, "%snew-oid=%s",
+				    extended_status.len > 0 ? " ": "",
+				    oid_to_hex(&new_oid));
+		}
+		if (extended_status.len > 0)
+			hint->extended_status = strbuf_detach(&extended_status, NULL);
+		if (hint->run_proc_receive)
+			hint->run_proc_receive |= RUN_PROC_RECEIVE_RETURNED;
 	}
 
 	for (cmd = commands; cmd; cmd = cmd->next)
@@ -2179,12 +2201,23 @@ static void report(struct command *commands, const char *unpack_status)
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
index 8fb143d692..c9f5c5aae4 100644
--- a/t/helper/test-proc-receive.c
+++ b/t/helper/test-proc-receive.c
@@ -159,8 +159,18 @@ int cmd__proc_receive(int argc, const char **argv)
 	}
 
 	if (returns.nr)
-		for_each_string_list_item(item, &returns)
-			packet_write_fmt(1, "%s\n", item->string);
+		for_each_string_list_item(item, &returns) {
+			char *p;
+
+			p = strstr(item->string, "\\0");
+			if (p) {
+				*p = '\0';
+				p += 2;
+				packet_write_fmt(1, "%s%c%s\n", item->string, '\0', p);
+			} else {
+				packet_write_fmt(1, "%s\n", item->string);
+			}
+		}
 	packet_flush(1);
 	sigchain_pop(SIGPIPE);
 
diff --git a/t/t5411/common-test-cases.sh b/t/t5411/common-test-cases.sh
index d6ad0e1bc8..35fe73c34e 100644
--- a/t/t5411/common-test-cases.sh
+++ b/t/t5411/common-test-cases.sh
@@ -640,8 +640,8 @@ test_expect_success "setup proc-receive hook" '
 
 	test-tool proc-receive -v \
 		-r "$ZERO_OID $A refs/review/a/b/c/topic ok" \
-		-r "$ZERO_OID $A refs/for/next/topic ok" \
-		-r "$B $A refs/for/master/topic ok"
+		-r "$ZERO_OID $A refs/for/next/topic ok\0ref=refs/pull/123/head" \
+		-r "$B $A refs/for/master/topic ok\0ref=refs/pull/124/head forced-update"
 	EOF
 	chmod a+x "$upstream/hooks/proc-receive"
 '
@@ -666,8 +666,8 @@ test_expect_success "report update of all special refs" '
 	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic
 	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
 	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic ok
-	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/next/topic ok
-	remote: proc-receive> <COMMIT-B> <COMMIT-A> refs/for/master/topic ok
+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/next/topic ok\0ref=refs/pull/123/head
+	remote: proc-receive> <COMMIT-B> <COMMIT-A> refs/for/master/topic ok\0ref=refs/pull/124/head forced-update
 	remote: # post-receive hook
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic
@@ -701,9 +701,10 @@ test_expect_success "setup proc-receive hook" '
 
 # Refs of upstream : master(A)
 # Refs of workbench: master(A)  tags/v123
-# git push         :                       bar(A)  baz(A)  refs/for/next/topic(A)  foo(A)  refs/for/master/topic(A)
+# git push         : (B)                   bar(A)  baz(A)  refs/for/next/topic(A)  foo(A)  refs/for/master/topic(A)
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
 	remote: proc-receive> <COMMIT-A> <COMMIT-B> refs/for/master/topic ok
 	remote: # post-receive hook
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/bar
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
 	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
 	To <URL/of/upstream.git>
+	 <OID-A>..<OID-B> <COMMIT-B> -> master
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
+test_expect_success "config receive.procReceiveRefs for all refs" '
+	git -C "$upstream" config --add receive.procReceiveRefs refs
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
+		-r "$A $B refs/for/master/topic ok\0ref=refs/pull/123/head" \
+		-r "$B $A refs/for/next/topic ok\0ref=refs/pull/124/head forced-update"
+	EOF
+	chmod a+x "$upstream/hooks/proc-receive"
+'
+
+# Refs of upstream : master(B)             foo(A)  bar(A))  baz(A)
+# Refs of workbench: master(A)  tags/v123
+# git push -f      : master(A)             (NULL)  (B)              refs/for/master/topic(A)  refs/for/next/topic(A)
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
+	remote: proc-receive> <COMMIT-A> <COMMIT-B> refs/for/master/topic ok\0ref=refs/pull/123/head
+	remote: proc-receive> <COMMIT-B> <COMMIT-A> refs/for/next/topic ok\0ref=refs/pull/124/head forced-update
+	remote: # post-receive hook
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/bar
+	remote: post-receive< <COMMIT-A> <ZERO-OID> refs/heads/foo
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/heads/master
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/for/next/topic
+	To <URL/of/upstream.git>
+	 <OID-A>..<OID-B> <COMMIT-B> -> bar
+	 - [deleted] foo
+	 + <OID-B>...<OID-A> HEAD -> master (forced update)
+	 * [new reference] HEAD -> refs/for/master/topic
+	 * [new reference] HEAD -> refs/for/next/topic
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
-- 
2.24.1.15.g448c31058d.agit.4.5

