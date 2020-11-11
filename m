Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7E7C56201
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 11:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E20182075A
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 11:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSDG7DMo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgKKLcc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 06:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgKKLcT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 06:32:19 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787CFC0613D4
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 03:32:18 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id r10so1254166pgb.10
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 03:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n1tzgOCLSM/Oiji2EJo58G5w/GsIQYzJzUpLqPC0Cno=;
        b=JSDG7DMoByjwTc8FLaBMzmbAXHpPDGMylCinH0YPHxiNAxp0wtxjtLs9SpJPTqVMP8
         phr5bMPczTyZZ6j/SvAKEtqfCTQzj1wVrFG+eNQyIwqGdrvBNwMXfMx9NtPR5BlIEg5/
         P85uZQfYDOc9MnBc1chBDxyH1+wGG+x3c3vhIBqc8GwLSsPlspxRylYFZy1UvGCsT02W
         EHFRaFWzLfyubsN0U7lFctyIUY1whIz+m4HWbeN7OBPvIuJlSAwmy0ipXT99sm0tYzub
         R3ofS/jSeTrk8h5j3C7vc8mZCPlpOm/vAf2kva6dr04HTEK428b/rP/8xq2DwY9wQYpr
         hZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n1tzgOCLSM/Oiji2EJo58G5w/GsIQYzJzUpLqPC0Cno=;
        b=oCaT7PrWiWa0b4+H7oRQSNWTIR2g20ePx4PjmE7T5dUNEefW8yuI/o7bFaaOtSgbis
         m9wP5KdDKPhaEvZQpIeLTDX8sD1fRD/q2Td5ALUFxnh6kIfHf0AOHFqwofudBFKq1vfK
         7mlIRXgoZbVaJd7AIY0iibM6ee3X+0Ib7S3lwFs8tyHXOuboDtg3PtUe9lYtOv8E1saU
         pyQ1/smBAM3B0nml9ezXWQgLU7VWV44vtWGyK3jwj0jFgh8XyXnSYOR+a28kGRRoOPih
         39Qw/Fw/KB7o7ifAS7VIF5picCDspgkFbN2+Aqu49M0DYpsIOP2/5esalLIY81p9OyTd
         6acA==
X-Gm-Message-State: AOAM531qhePsbx17oE5VgvuYEE9sM56gmSKwQ+zl7htZ4BjtHr4icsAq
        H93z6A7pTW5a8iUZx9mQmlE=
X-Google-Smtp-Source: ABdhPJys/4pGbUEfAMGbBhj78PQMnRK/0oxCCGig8j6MWFZWWzkItx4VNzhwa6XFxwf9xangxmPMSQ==
X-Received: by 2002:a63:e449:: with SMTP id i9mr20725632pgk.438.1605094338038;
        Wed, 11 Nov 2020 03:32:18 -0800 (PST)
Received: from localhost.localdomain ([47.89.83.4])
        by smtp.gmail.com with ESMTPSA id s19sm2137525pfe.26.2020.11.11.03.32.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Nov 2020 03:32:17 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
X-Google-Original-From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v4 3/3] receive-pack: use default version 0 for proc-receive
Date:   Wed, 11 Nov 2020 19:32:02 +0800
Message-Id: <20201111113202.24911-4-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.29.0.dirty
In-Reply-To: <CANYiYbH-x6khgTkkFV29+7AjghOZmG69_6-sQcm2489WMHOWAA@mail.gmail.com>
References: <CANYiYbH-x6khgTkkFV29+7AjghOZmG69_6-sQcm2489WMHOWAA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the verison negotiation phase between "receive-pack" and
"proc-receive", "proc-receive" can send an empty flush-pkt to end the
negotiation and use default version 0. Capabilities (such as
"push-options") are not supported in version 0.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 builtin/receive-pack.c                       |  7 ++-
 t/helper/test-proc-receive.c                 | 16 +++--
 t/t5411/test-0026-push-options.sh            | 60 +++++++++++++++++++
 t/t5411/test-0027-push-options--porcelain.sh | 62 ++++++++++++++++++++
 4 files changed, 138 insertions(+), 7 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 2bd736525f..f1f0f7bef6 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1192,7 +1192,12 @@ static int run_proc_receive_hook(struct command *commands,
 		goto cleanup;
 	}
 
-	if (version != 1) {
+	switch (version) {
+	case 0:
+		/* fallthrough */
+	case 1:
+		break;
+	default:
 		strbuf_addf(&errmsg, "proc-receive version '%d' is not supported",
 			    version);
 		code = -1;
diff --git a/t/helper/test-proc-receive.c b/t/helper/test-proc-receive.c
index 6652cedcee..cc08506cf0 100644
--- a/t/helper/test-proc-receive.c
+++ b/t/helper/test-proc-receive.c
@@ -45,8 +45,14 @@ static void proc_receive_verison(struct packet_reader *reader) {
 		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
 			break;
 
+		/* Ignore version negotiation for version 0 */
+		if (version == 0)
+			continue;
+
 		if (reader->pktlen > 8 && starts_with(reader->line, "version=")) {
 			server_version = atoi(reader->line+8);
+			if (server_version != 1)
+				die("bad protocol version: %d", server_version);
 			linelen = strlen(reader->line);
 			if (linelen < reader->pktlen) {
 				const char *feature_list = reader->line + linelen + 1;
@@ -58,15 +64,13 @@ static void proc_receive_verison(struct packet_reader *reader) {
 		}
 	}
 
-	if (server_version != 1)
-		die("bad protocol version: %d", server_version);
-
 	if (die_write_version)
 		die("die with the --die-write-version option");
 
-	packet_write_fmt(1, "version=%d%c%s\n",
-			 version, '\0',
-			 use_push_options && !no_push_options ? "push-options": "");
+	if (version != 0)
+		packet_write_fmt(1, "version=%d%c%s\n",
+				 version, '\0',
+				 use_push_options && !no_push_options ? "push-options": "");
 	packet_flush(1);
 }
 
diff --git a/t/t5411/test-0026-push-options.sh b/t/t5411/test-0026-push-options.sh
index d414be87d0..e88edb16a4 100644
--- a/t/t5411/test-0026-push-options.sh
+++ b/t/t5411/test-0026-push-options.sh
@@ -32,6 +32,66 @@ test_expect_success "enable push options ($PROTOCOL)" '
 	git -C "$upstream" config receive.advertisePushOptions true
 '
 
+test_expect_success "setup version=0 for proc-receive hook ($PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		--version 0 \
+		-r "ok refs/for/main/topic"
+	EOF
+'
+
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push -o ...  :                       next(A)  refs/for/main/topic
+test_expect_success "proc-receive: ignore push-options for version 0 ($PROTOCOL)" '
+	git -C workbench push \
+		--atomic \
+		-o issue=123 \
+		-o reviewer=user1 \
+		origin \
+		HEAD:refs/heads/next \
+		HEAD:refs/for/main/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
+	remote: proc-receive> ok refs/for/main/topic
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
+	To <URL/of/upstream.git>
+	 * [new branch] HEAD -> next
+	 * [new reference] HEAD -> refs/for/main/topic
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/main
+	<COMMIT-A> refs/heads/next
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "restore proc-receive hook ($PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/for/main/topic"
+	EOF
+'
+
+# Refs of upstream : main(A)             next(A)
+# Refs of workbench: main(A)  tags/v123
+test_expect_success "cleanup ($PROTOCOL)" '
+	git -C "$upstream" update-ref -d refs/heads/next
+'
+
 # Refs of upstream : main(A)
 # Refs of workbench: main(A)  tags/v123
 # git push -o ...  :                       next(A)  refs/for/main/topic
diff --git a/t/t5411/test-0027-push-options--porcelain.sh b/t/t5411/test-0027-push-options--porcelain.sh
index d5d0dcb172..3a6561b5ea 100644
--- a/t/t5411/test-0027-push-options--porcelain.sh
+++ b/t/t5411/test-0027-push-options--porcelain.sh
@@ -33,6 +33,68 @@ test_expect_success "enable push options ($PROTOCOL/porcelain)" '
 	git -C "$upstream" config receive.advertisePushOptions true
 '
 
+test_expect_success "setup version=0 for proc-receive hook ($PROTOCOL/porcelain)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		--version 0 \
+		-r "ok refs/for/main/topic"
+	EOF
+'
+
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push -o ...  :                       next(A)  refs/for/main/topic
+test_expect_success "proc-receive: ignore push-options for version 0 ($PROTOCOL/porcelain)" '
+	git -C workbench push \
+		--porcelain \
+		--atomic \
+		-o issue=123 \
+		-o reviewer=user1 \
+		origin \
+		HEAD:refs/heads/next \
+		HEAD:refs/for/main/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
+	remote: proc-receive> ok refs/for/main/topic
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
+	To <URL/of/upstream.git>
+	*    HEAD:refs/heads/next    [new branch]
+	*    HEAD:refs/for/main/topic    [new reference]
+	Done
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/main
+	<COMMIT-A> refs/heads/next
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "restore proc-receive hook ($PROTOCOL/porcelain)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/for/main/topic"
+	EOF
+'
+
+# Refs of upstream : main(A)             next(A)
+# Refs of workbench: main(A)  tags/v123
+test_expect_success "cleanup ($PROTOCOL/porcelain)" '
+	git -C "$upstream" update-ref -d refs/heads/next
+'
+
 # Refs of upstream : main(A)
 # Refs of workbench: main(A)  tags/v123
 # git push -o ...  :                       next(A)  refs/for/main/topic
-- 
2.29.0.dirty

