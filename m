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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93703C54F70
	for <git@archiver.kernel.org>; Sat, 18 Apr 2020 16:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6435D21D6C
	for <git@archiver.kernel.org>; Sat, 18 Apr 2020 16:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jk9D9D5w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgDRQEE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Apr 2020 12:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727782AbgDRQDy (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 18 Apr 2020 12:03:54 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F843C061A41
        for <git@vger.kernel.org>; Sat, 18 Apr 2020 09:03:54 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id r4so2745348pgg.4
        for <git@vger.kernel.org>; Sat, 18 Apr 2020 09:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d/DgP5T5zsc04C29q+POM7cdXFPVFCDcqqnHcI0JCcI=;
        b=Jk9D9D5wVdxaSZMfcjD5MiLDg7H+4bo4s8r/LTFPCIE5smd/UhGJRL8h7DegvGGDeX
         wiaJ389DCiZxIW5wMBpCwEzRX8ziclGuwn4GkJE80vfD4iAhCyEZbO3VZL+rfnZjK8Fe
         Z1qsILnSiHikhmnUwxXe+B+FoviSsmLHEB89SKqidN/M0D71zGbWURU9IrROaXUhGKHK
         BFlaHAPSDsRpsu/Vl6Wsnul8x1almnxF4JqipfMPPB0clXs0QZeOxi67XZcD5vvoad8Q
         vUCbTF2TlZxvMYZSm9DGIVPVs64/b4zlyX3SSzNG5wGZgY2kBn1UqvqNNqa2+6Vq2/b3
         7E3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d/DgP5T5zsc04C29q+POM7cdXFPVFCDcqqnHcI0JCcI=;
        b=ea9FR9ELXNkN+T5Q1lyj421WdX+0AKwSuUwyAltAjj0E3eSmHVEA0/od9ag0zO/RTc
         t1wk8KanxQ7yDGYHdyqBq8yltuBkc1RBrJGW9wi6vjJpOHKbh25utIs+w7vP2rfDmyPb
         9U01FJN74VfzqwXe3n5ReSpANeXrFaQjLAMsziyp6Gq5Z8fy5A83sTcPZ5LpkOmW3u07
         XpNEi4UoSxtPm2WKDplK01aBeze5zQE2XWaTxkI8ive08BKyPxXp5PENzXu8WBaoxyjf
         UZhIFpD8K7F9ocUnJTZxnI2IzO1r5lVh1L8qh2rHvCV5uQftIXUlrhvvftKiEkJvXau5
         dGCQ==
X-Gm-Message-State: AGi0PubruxQuvBRYQQtCEf/GEDiTnvT+MTyeQtlKtB7tJeA+KnIlHPSW
        +Xt7yuq5N82huuyd7KmRXHc=
X-Google-Smtp-Source: APiQypKIUl6A+i8Y2m9KWrO1DqXH5nhQrIFGnY+XCrRceOPnvEP5M+jJ2nNzItImkUYl9IJmpKvCsg==
X-Received: by 2002:aa7:9106:: with SMTP id 6mr8407689pfh.181.1587225833720;
        Sat, 18 Apr 2020 09:03:53 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id i187sm22461649pfg.33.2020.04.18.09.03.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Apr 2020 09:03:53 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v13 5/8] receive-pack: feed extended_status to post-receive
Date:   Sat, 18 Apr 2020 12:03:31 -0400
Message-Id: <20200418160334.15631-6-worldhello.net@gmail.com>
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

When commands are fed to the "post-receive" hook, `extended_status` will
be parsed and the real old-oid, new-oid, reference name will feed to
the "post-receive" hook.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 builtin/receive-pack.c                        | 57 +++++++++++++++++--
 t/t5411/test-0032-report-alt.sh               | 14 ++---
 t/t5411/test-0033-report-alt--porcelain.sh    | 14 ++---
 .../test-0036-report-multi-alt-for-one-ref.sh | 12 +++-
 ...report-multi-alt-for-one-ref--porcelain.sh | 12 +++-
 t/t5411/test-0038-report-mixed-refs.sh        |  2 +-
 .../test-0039-report-mixed-refs--porcelain.sh |  2 +-
 7 files changed, 87 insertions(+), 26 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 0081bf1415..529ac01e1c 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -754,17 +754,66 @@ static int feed_receive_hook(void *state_, const char **bufp, size_t *sizep)
 {
 	struct receive_hook_feed_state *state = state_;
 	struct command *cmd = state->cmd;
+	static char *extended_status = NULL;
 
 	while (cmd &&
 	       state->skip_broken && (cmd->error_string || cmd->did_not_exist))
 		cmd = cmd->next;
 	if (!cmd)
 		return -1; /* EOF */
+	if (!bufp)
+		return 0; /* OK, can feed something. */
 	strbuf_reset(&state->buf);
-	strbuf_addf(&state->buf, "%s %s %s\n",
-		    oid_to_hex(&cmd->old_oid), oid_to_hex(&cmd->new_oid),
-		    cmd->ref_name);
-	state->cmd = cmd->next;
+	if (cmd->extended_status && extended_status == NULL)
+		extended_status = (char *)cmd->extended_status;
+	if (extended_status) {
+		struct object_id old_oid;
+		struct object_id new_oid;
+		char *end;
+		char *val;
+		int len;
+
+		end = strstr(extended_status + 4, "ref=");
+		if (end)
+			*(end-1) = '\0';
+
+		val = (char *)parse_feature_value(extended_status, "old-oid", &len);
+		if (val && len && !get_oid_hex(val, &old_oid))
+			strbuf_addf(&state->buf, "%s ",
+				    oid_to_hex(&old_oid));
+		else
+			strbuf_addf(&state->buf, "%s ",
+				    oid_to_hex(&cmd->old_oid));
+
+		val = (char *)parse_feature_value(extended_status, "new-oid", &len);
+		if (val && len && !get_oid_hex(val, &new_oid))
+			strbuf_addf(&state->buf, "%s ",
+				    oid_to_hex(&new_oid));
+		else
+			strbuf_addf(&state->buf, "%s ",
+				    oid_to_hex(&cmd->new_oid));
+
+		val = (char *)parse_feature_value(extended_status, "ref", &len);
+		if (val && len)
+			strbuf_add(&state->buf, val, len);
+		else
+			strbuf_addstr(&state->buf, cmd->ref_name);
+
+		strbuf_addch(&state->buf, '\n');
+
+		if (end) {
+			extended_status = end;
+			*(end-1) = ' ';
+		} else {
+			extended_status = NULL;
+			state->cmd = cmd->next;
+		}
+	} else {
+		strbuf_addf(&state->buf, "%s %s %s\n",
+			    oid_to_hex(&cmd->old_oid), oid_to_hex(&cmd->new_oid),
+			    cmd->ref_name);
+		state->cmd = cmd->next;
+	}
 	if (bufp) {
 		*bufp = state->buf.buf;
 		*sizep = state->buf.len;
diff --git a/t/t5411/test-0032-report-alt.sh b/t/t5411/test-0032-report-alt.sh
index bf5faf4f2e..25bffd1127 100644
--- a/t/t5411/test-0032-report-alt.sh
+++ b/t/t5411/test-0032-report-alt.sh
@@ -50,7 +50,7 @@ test_expect_success "proc-receive: report alt (alt <ref> <alt-ref>, $PROTOCOL)"
 	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
 	remote: proc-receive> alt refs/for/master/topic refs/pull/123/head
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/pull/123/head
 	To <URL/of/upstream.git>
 	 * [new reference] HEAD -> refs/pull/123/head
 	EOF
@@ -80,7 +80,7 @@ test_expect_success "proc-receive: report alt (alt <ref> <alt-ref> forced-update
 	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
 	remote: proc-receive> alt refs/for/master/topic refs/pull/123/head forced-update
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/pull/123/head
 	To <URL/of/upstream.git>
 	 * [new reference] HEAD -> refs/pull/123/head
 	EOF
@@ -110,7 +110,7 @@ test_expect_success "proc-receive: report alt (alt <ref> <alt-ref> old-oid=X, $P
 	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
 	remote: proc-receive> alt refs/for/master/topic refs/pull/123/head old-oid=<COMMIT-B>
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/pull/123/head
 	To <URL/of/upstream.git>
 	 <OID-B>..<OID-A> HEAD -> refs/pull/123/head
 	EOF
@@ -140,7 +140,7 @@ test_expect_success "proc-receive: report alt (alt <ref> old-oid=X, $PROTOCOL)"
 	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
 	remote: proc-receive> alt refs/for/master/topic old-oid=<COMMIT-B>
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/for/master/topic
 	To <URL/of/upstream.git>
 	 <OID-B>..<OID-A> HEAD -> refs/for/master/topic
 	EOF
@@ -170,7 +170,7 @@ test_expect_success "proc-receive: report alt (alt <ref> old-oid=X new-oid=Y, $P
 	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
 	remote: proc-receive> alt refs/for/master/topic old-oid=<COMMIT-A> new-oid=<COMMIT-B>
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
 	To <URL/of/upstream.git>
 	 <OID-A>..<OID-B> HEAD -> refs/for/master/topic
 	EOF
@@ -210,9 +210,9 @@ test_expect_success "proc-receive: with multiple alt reports ($PROTOCOL)" '
 	remote: proc-receive> alt refs/for/next/topic refs/pull/123/head
 	remote: proc-receive> alt refs/for/master/topic refs/pull/124/head old-oid=<COMMIT-B> forced-update new-oid=<COMMIT-A>
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/pull/123/head
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/pull/124/head
 	To <URL/of/upstream.git>
 	 * [new reference] HEAD -> refs/pull/123/head
 	 * [new reference] HEAD -> refs/for/a/b/c/topic
diff --git a/t/t5411/test-0033-report-alt--porcelain.sh b/t/t5411/test-0033-report-alt--porcelain.sh
index 3aea911407..9f1b577424 100644
--- a/t/t5411/test-0033-report-alt--porcelain.sh
+++ b/t/t5411/test-0033-report-alt--porcelain.sh
@@ -51,7 +51,7 @@ test_expect_success "proc-receive: report alt (alt <ref> <alt-ref>, --porcelain,
 	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
 	remote: proc-receive> alt refs/for/master/topic refs/pull/123/head
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/pull/123/head
 	To <URL/of/upstream.git>
 	*    HEAD:refs/pull/123/head    [new reference]
 	Done
@@ -82,7 +82,7 @@ test_expect_success "proc-receive: report alt (alt <ref> <alt-ref> forced-update
 	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
 	remote: proc-receive> alt refs/for/master/topic refs/pull/123/head forced-update
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/pull/123/head
 	To <URL/of/upstream.git>
 	*    HEAD:refs/pull/123/head    [new reference]
 	Done
@@ -113,7 +113,7 @@ test_expect_success "proc-receive: report alt (alt <ref> <alt-ref> old-oid=X, --
 	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
 	remote: proc-receive> alt refs/for/master/topic refs/pull/123/head old-oid=<COMMIT-B>
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/pull/123/head
 	To <URL/of/upstream.git>
 	     HEAD:refs/pull/123/head    <OID-B>..<OID-A>
 	Done
@@ -144,7 +144,7 @@ test_expect_success "proc-receive: report alt (alt <ref> old-oid=X, --porcelain,
 	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
 	remote: proc-receive> alt refs/for/master/topic old-oid=<COMMIT-B>
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/for/master/topic
 	To <URL/of/upstream.git>
 	     HEAD:refs/for/master/topic    <OID-B>..<OID-A>
 	Done
@@ -175,7 +175,7 @@ test_expect_success "proc-receive: report alt (alt <ref> old-oid=X new-oid=Y, --
 	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
 	remote: proc-receive> alt refs/for/master/topic old-oid=<COMMIT-A> new-oid=<COMMIT-B>
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
 	To <URL/of/upstream.git>
 	     HEAD:refs/for/master/topic    <OID-A>..<OID-B>
 	Done
@@ -216,9 +216,9 @@ test_expect_success "proc-receive: with multiple alt reports (--porcelain, $PROT
 	remote: proc-receive> alt refs/for/next/topic refs/pull/123/head
 	remote: proc-receive> alt refs/for/master/topic refs/pull/124/head old-oid=<COMMIT-B> forced-update new-oid=<COMMIT-A>
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/pull/123/head
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/pull/124/head
 	To <URL/of/upstream.git>
 	*    HEAD:refs/pull/123/head    [new reference]
 	*    HEAD:refs/for/a/b/c/topic    [new reference]
diff --git a/t/t5411/test-0036-report-multi-alt-for-one-ref.sh b/t/t5411/test-0036-report-multi-alt-for-one-ref.sh
index d82b79ffff..1f6a4e10b2 100644
--- a/t/t5411/test-0036-report-multi-alt-for-one-ref.sh
+++ b/t/t5411/test-0036-report-multi-alt-for-one-ref.sh
@@ -25,7 +25,9 @@ test_expect_success "proc-receive: report multiple alt, no alt-ref for the 1st r
 	remote: proc-receive> alt refs/for/master/topic refs/changes/24/124/1 old-oid=<ZERO-OID> new-oid=<COMMIT-A>
 	remote: proc-receive> alt refs/for/master/topic refs/changes/25/125/1 old-oid=<COMMIT-A> new-oid=<COMMIT-B>
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/changes/24/124/1
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/changes/25/125/1
 	To <URL/of/upstream.git>
 	 <OID-A>..<OID-B> HEAD -> refs/for/master/topic
 	 * [new reference] HEAD -> refs/changes/24/124/1
@@ -67,7 +69,9 @@ test_expect_success "proc-receive: report multiple alt, no alt-ref for the 2nd r
 	remote: proc-receive> alt refs/for/master/topic old-oid=<COMMIT-A> new-oid=<COMMIT-B>
 	remote: proc-receive> alt refs/for/master/topic refs/changes/25/125/1 old-oid=<COMMIT-B> new-oid=<COMMIT-A> forced-update
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/changes/24/124/1
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/changes/25/125/1
 	To <URL/of/upstream.git>
 	 * [new reference] HEAD -> refs/changes/24/124/1
 	 <OID-A>..<OID-B> HEAD -> refs/for/master/topic
@@ -108,6 +112,7 @@ test_expect_success "proc-receive: report ok and alt for the same ref ($PROTOCOL
 	remote: proc-receive> alt refs/for/master/topic refs/changes/24/124/1 new-oid=<COMMIT-B> old-oid=<COMMIT-A>
 	remote: # post-receive hook
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/changes/24/124/1
 	To <URL/of/upstream.git>
 	 * [new reference] HEAD -> refs/for/master/topic
 	 <OID-A>..<OID-B> HEAD -> refs/changes/24/124/1
@@ -146,7 +151,8 @@ test_expect_success "proc-receive: report multiple response ($PROTOCOL)" '
 	remote: proc-receive> alt refs/for/master/topic refs/changes/23/123/1
 	remote: proc-receive> alt refs/for/master/topic refs/changes/24/124/2 old-oid=<COMMIT-A> new-oid=<COMMIT-B>
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/changes/23/123/1
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/changes/24/124/2
 	To <URL/of/upstream.git>
 	 * [new reference] HEAD -> refs/changes/23/123/1
 	 <OID-A>..<OID-B> HEAD -> refs/changes/24/124/2
diff --git a/t/t5411/test-0037-report-multi-alt-for-one-ref--porcelain.sh b/t/t5411/test-0037-report-multi-alt-for-one-ref--porcelain.sh
index 8cca63c2de..3a08a21b87 100644
--- a/t/t5411/test-0037-report-multi-alt-for-one-ref--porcelain.sh
+++ b/t/t5411/test-0037-report-multi-alt-for-one-ref--porcelain.sh
@@ -25,7 +25,9 @@ test_expect_success "proc-receive: report multiple alt, no alt-ref for the 1st r
 	remote: proc-receive> alt refs/for/master/topic refs/changes/24/124/1 old-oid=<ZERO-OID> new-oid=<COMMIT-A>
 	remote: proc-receive> alt refs/for/master/topic refs/changes/25/125/1 old-oid=<COMMIT-A> new-oid=<COMMIT-B>
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/changes/24/124/1
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/changes/25/125/1
 	To <URL/of/upstream.git>
 	     HEAD:refs/for/master/topic    <OID-A>..<OID-B>
 	*    HEAD:refs/changes/24/124/1    [new reference]
@@ -68,7 +70,9 @@ test_expect_success "proc-receive: report multiple alt, no alt-ref for the 2nd r
 	remote: proc-receive> alt refs/for/master/topic old-oid=<COMMIT-A> new-oid=<COMMIT-B>
 	remote: proc-receive> alt refs/for/master/topic refs/changes/25/125/1 old-oid=<COMMIT-B> new-oid=<COMMIT-A> forced-update
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/changes/24/124/1
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/changes/25/125/1
 	To <URL/of/upstream.git>
 	*    HEAD:refs/changes/24/124/1    [new reference]
 	     HEAD:refs/for/master/topic    <OID-A>..<OID-B>
@@ -110,6 +114,7 @@ test_expect_success "proc-receive: report ok and alt for the same ref (--porcela
 	remote: proc-receive> alt refs/for/master/topic refs/changes/24/124/1 new-oid=<COMMIT-B> old-oid=<COMMIT-A>
 	remote: # post-receive hook
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/changes/24/124/1
 	To <URL/of/upstream.git>
 	*    HEAD:refs/for/master/topic    [new reference]
 	     HEAD:refs/changes/24/124/1    <OID-A>..<OID-B>
@@ -149,7 +154,8 @@ test_expect_success "proc-receive: report multiple response (--porcelain, $PROTO
 	remote: proc-receive> alt refs/for/master/topic refs/changes/23/123/1
 	remote: proc-receive> alt refs/for/master/topic refs/changes/24/124/2 old-oid=<COMMIT-A> new-oid=<COMMIT-B>
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/changes/23/123/1
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/changes/24/124/2
 	To <URL/of/upstream.git>
 	*    HEAD:refs/changes/23/123/1    [new reference]
 	     HEAD:refs/changes/24/124/2    <OID-A>..<OID-B>
diff --git a/t/t5411/test-0038-report-mixed-refs.sh b/t/t5411/test-0038-report-mixed-refs.sh
index 566cb6e098..5ac2771914 100644
--- a/t/t5411/test-0038-report-mixed-refs.sh
+++ b/t/t5411/test-0038-report-mixed-refs.sh
@@ -39,7 +39,7 @@ test_expect_success "proc-receive: report update of mixed refs ($PROTOCOL)" '
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
 	To <URL/of/upstream.git>
 	 <OID-A>..<OID-B> <COMMIT-B> -> master
 	 * [new branch] HEAD -> bar
diff --git a/t/t5411/test-0039-report-mixed-refs--porcelain.sh b/t/t5411/test-0039-report-mixed-refs--porcelain.sh
index 4d617abb1a..55b408aca1 100644
--- a/t/t5411/test-0039-report-mixed-refs--porcelain.sh
+++ b/t/t5411/test-0039-report-mixed-refs--porcelain.sh
@@ -39,7 +39,7 @@ test_expect_success "proc-receive: report update of mixed refs (--porcelain, $PR
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
 	To <URL/of/upstream.git>
 	     <COMMIT-B>:refs/heads/master    <OID-A>..<OID-B>
 	*    HEAD:refs/heads/bar    [new branch]
-- 
2.24.1.15.g448c31058d.agit.4.5

