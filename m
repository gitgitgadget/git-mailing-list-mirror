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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB183C433DF
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 17:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8F092067C
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 17:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cy6xUuHy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgHXRme (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgHXRmS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 13:42:18 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E26C061755
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 10:42:17 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id p15so1027416pli.6
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 10:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oJOnLx001mlmQ3uZcYbe7M7qCAT+P1kynidn98oyJjs=;
        b=Cy6xUuHyJHHwljUADB2ghoYYu2cbyUJAPMZj+Hiu1irHlGxdWdcBjAF4UHEnctQKzo
         veOM5dH/YA/7yBfdZbdxVJmargSJAcVb8dFl8HUNDILkIkWpsBFgJvt+1ZegqMoC9ufx
         zPb0bRIjSCIAHwqOWv8pXjNocnW64SBHr7MddTaHyH8/xKCO+OgoLX/AbCnBl/J9SvqP
         S4ZS980O18gpRJLSZazLlS30DHIzgQNesRWdhkqL9u75GznbdA5ow+0Gts9OmWwzuzR8
         6A2w2Xq4rNHwo2ePT5pgj2S2PZE83FY1YNPWuRAw2cNgtZ7i+cAsbT8Yt4pp1GuHpkZK
         TdAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oJOnLx001mlmQ3uZcYbe7M7qCAT+P1kynidn98oyJjs=;
        b=ry8+LaqXu4n48+nq6pDQd1NA2d2iOMr15pSEjbGdNzvj7ja1dR1JivsBy6tQRqRUa1
         AId+XNOIOQUyq5+rFEaBsLHO7R/RvKu8CF5Z6WEMwV0juBqYyEFuEehiC/1AOnL3jQQP
         ENQ1IQkNf0LmZe8i8a0Wc3gfOBRt0nFNHt4IvNoMIw+UAnl6Fo+dizs1Np2dYrFKMjni
         oiXx1j7JRuHG9uOIvd7MYCd0e1Rqdo+OqZBxrD/PQ6aGLN696yZ30nntgjiz9Vp0WMyZ
         A+rLeNTXGILKi47ZjOTfKIx3+WHvEIo2cuOk8oLk4zFXhIlFFbidjB38Rt8K1ZU4kFl8
         MJ7Q==
X-Gm-Message-State: AOAM530dJDIYxUY20mpXxBJOYWSveNriwR/QVwWJDQn8hh52G641dK8r
        AAszfHwTBopjVAtaPir589A=
X-Google-Smtp-Source: ABdhPJxrEz4GxMYEkrjt9cad0uu8sO/ApKiBU2dOKqReF6Y8u3TWO5Sc1oEjW8AMwyfwxOUcBnl6lg==
X-Received: by 2002:a17:902:a982:: with SMTP id bh2mr4579021plb.182.1598290936353;
        Mon, 24 Aug 2020 10:42:16 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id b15sm9773162pgk.14.2020.08.24.10.42.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 10:42:15 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v18 04/10] receive-pack: feed report options to post-receive
Date:   Mon, 24 Aug 2020 13:41:56 -0400
Message-Id: <20200824174202.11710-5-worldhello.net@gmail.com>
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

When commands are fed to the "post-receive" hook, report options will
be parsed and the real old-oid, new-oid, reference name will feed to
the "post-receive" hook.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 builtin/receive-pack.c                        | 30 ++++++++++++++++---
 t/t5411/test-0032-report-with-options.sh      | 14 ++++-----
 ...est-0033-report-with-options--porcelain.sh | 14 ++++-----
 ...t-0036-report-multi-rewrite-for-one-ref.sh | 11 +++++--
 ...rt-multi-rewrite-for-one-ref--porcelain.sh | 11 +++++--
 t/t5411/test-0038-report-mixed-refs.sh        |  2 +-
 .../test-0039-report-mixed-refs--porcelain.sh |  2 +-
 7 files changed, 58 insertions(+), 26 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 2b63b92545..38f230248d 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -694,6 +694,7 @@ static void prepare_push_cert_sha1(struct child_process *proc)
 
 struct receive_hook_feed_state {
 	struct command *cmd;
+	struct ref_push_report *report;
 	int skip_broken;
 	struct strbuf buf;
 	const struct string_list *push_options;
@@ -781,11 +782,31 @@ static int feed_receive_hook(void *state_, const char **bufp, size_t *sizep)
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
+	if (!state->report)
+		state->report = cmd->report;
+	if (state->report) {
+		struct object_id *old_oid;
+		struct object_id *new_oid;
+		const char *ref_name;
+
+		old_oid = state->report->old_oid ? state->report->old_oid : &cmd->old_oid;
+		new_oid = state->report->new_oid ? state->report->new_oid : &cmd->new_oid;
+		ref_name = state->report->ref_name ? state->report->ref_name : cmd->ref_name;
+		strbuf_addf(&state->buf, "%s %s %s\n",
+			    oid_to_hex(old_oid), oid_to_hex(new_oid),
+			    ref_name);
+		state->report = state->report->next;
+		if (!state->report)
+			state->cmd = cmd->next;
+	} else {
+		strbuf_addf(&state->buf, "%s %s %s\n",
+			    oid_to_hex(&cmd->old_oid), oid_to_hex(&cmd->new_oid),
+			    cmd->ref_name);
+		state->cmd = cmd->next;
+	}
 	if (bufp) {
 		*bufp = state->buf.buf;
 		*sizep = state->buf.len;
@@ -804,6 +825,7 @@ static int run_receive_hook(struct command *commands,
 	strbuf_init(&state.buf, 0);
 	state.cmd = commands;
 	state.skip_broken = skip_broken;
+	state.report = NULL;
 	if (feed_receive_hook(&state, NULL, NULL))
 		return 0;
 	state.cmd = commands;
diff --git a/t/t5411/test-0032-report-with-options.sh b/t/t5411/test-0032-report-with-options.sh
index a743aa8018..c559c207fa 100644
--- a/t/t5411/test-0032-report-with-options.sh
+++ b/t/t5411/test-0032-report-with-options.sh
@@ -54,7 +54,7 @@ test_expect_success "proc-receive: report option refname ($PROTOCOL)" '
 	remote: proc-receive> ok refs/for/master/topic
 	remote: proc-receive> option refname refs/pull/123/head
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/pull/123/head
 	To <URL/of/upstream.git>
 	 * [new reference] HEAD -> refs/for/master/topic
 	EOF
@@ -87,7 +87,7 @@ test_expect_success "proc-receive: report option refname and forced-update ($PRO
 	remote: proc-receive> option refname refs/pull/123/head
 	remote: proc-receive> option forced-update
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/pull/123/head
 	To <URL/of/upstream.git>
 	 * [new reference] HEAD -> refs/for/master/topic
 	EOF
@@ -121,7 +121,7 @@ test_expect_success "proc-receive: report option refname and old-oid ($PROTOCOL)
 	remote: proc-receive> option refname refs/pull/123/head
 	remote: proc-receive> option old-oid <COMMIT-B>
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/pull/123/head
 	To <URL/of/upstream.git>
 	 * [new reference] HEAD -> refs/for/master/topic
 	EOF
@@ -153,7 +153,7 @@ test_expect_success "proc-receive: report option old-oid ($PROTOCOL)" '
 	remote: proc-receive> ok refs/for/master/topic
 	remote: proc-receive> option old-oid <COMMIT-B>
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/for/master/topic
 	To <URL/of/upstream.git>
 	 * [new reference] HEAD -> refs/for/master/topic
 	EOF
@@ -187,7 +187,7 @@ test_expect_success "proc-receive: report option old-oid and new-oid ($PROTOCOL)
 	remote: proc-receive> option old-oid <COMMIT-A>
 	remote: proc-receive> option new-oid <COMMIT-B>
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
 	To <URL/of/upstream.git>
 	 * [new reference] HEAD -> refs/for/master/topic
 	EOF
@@ -237,9 +237,9 @@ test_expect_success "proc-receive: report with multiple rewrites ($PROTOCOL)" '
 	remote: proc-receive> option forced-update
 	remote: proc-receive> option new-oid <COMMIT-A>
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/pull/123/head
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/pull/124/head
 	To <URL/of/upstream.git>
 	 * [new reference] HEAD -> refs/for/next/topic
 	 * [new reference] HEAD -> refs/for/a/b/c/topic
diff --git a/t/t5411/test-0033-report-with-options--porcelain.sh b/t/t5411/test-0033-report-with-options--porcelain.sh
index 439b97b06e..ea9312234e 100644
--- a/t/t5411/test-0033-report-with-options--porcelain.sh
+++ b/t/t5411/test-0033-report-with-options--porcelain.sh
@@ -55,7 +55,7 @@ test_expect_success "proc-receive: report option refname ($PROTOCOL/porcelain)"
 	remote: proc-receive> ok refs/for/master/topic
 	remote: proc-receive> option refname refs/pull/123/head
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/pull/123/head
 	To <URL/of/upstream.git>
 	*    HEAD:refs/for/master/topic    [new reference]
 	Done
@@ -90,7 +90,7 @@ test_expect_success "proc-receive: report option refname and forced-update ($PRO
 	remote: proc-receive> option refname refs/pull/123/head
 	remote: proc-receive> option forced-update
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/pull/123/head
 	To <URL/of/upstream.git>
 	*    HEAD:refs/for/master/topic    [new reference]
 	Done
@@ -125,7 +125,7 @@ test_expect_success "proc-receive: report option refname and old-oid ($PROTOCOL/
 	remote: proc-receive> option refname refs/pull/123/head
 	remote: proc-receive> option old-oid <COMMIT-B>
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/pull/123/head
 	To <URL/of/upstream.git>
 	*    HEAD:refs/for/master/topic    [new reference]
 	Done
@@ -158,7 +158,7 @@ test_expect_success "proc-receive: report option old-oid ($PROTOCOL/porcelain)"
 	remote: proc-receive> ok refs/for/master/topic
 	remote: proc-receive> option old-oid <COMMIT-B>
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/for/master/topic
 	To <URL/of/upstream.git>
 	*    HEAD:refs/for/master/topic    [new reference]
 	Done
@@ -193,7 +193,7 @@ test_expect_success "proc-receive: report option old-oid and new-oid ($PROTOCOL/
 	remote: proc-receive> option old-oid <COMMIT-A>
 	remote: proc-receive> option new-oid <COMMIT-B>
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
 	To <URL/of/upstream.git>
 	*    HEAD:refs/for/master/topic    [new reference]
 	Done
@@ -245,9 +245,9 @@ test_expect_success "proc-receive: report with multiple rewrites ($PROTOCOL/porc
 	remote: proc-receive> option forced-update
 	remote: proc-receive> option new-oid <COMMIT-A>
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/pull/123/head
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/pull/124/head
 	To <URL/of/upstream.git>
 	*    HEAD:refs/for/next/topic    [new reference]
 	*    HEAD:refs/for/a/b/c/topic    [new reference]
diff --git a/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh b/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
index 12acf9ea1f..67cc4a8a4c 100644
--- a/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
+++ b/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
@@ -41,7 +41,9 @@ test_expect_success "proc-receive: multiple rewrite for one ref, no refname for
 	remote: proc-receive> option old-oid <COMMIT-A>
 	remote: proc-receive> option new-oid <COMMIT-B>
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/changes/24/124/1
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/changes/25/125/1
 	To <URL/of/upstream.git>
 	 * [new reference] HEAD -> refs/for/master/topic
 	EOF
@@ -99,7 +101,9 @@ test_expect_success "proc-receive: multiple rewrites for one ref, no refname for
 	remote: proc-receive> option new-oid <COMMIT-A>
 	remote: proc-receive> option forced-update
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/changes/24/124/1
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/changes/25/125/1
 	To <URL/of/upstream.git>
 	 * [new reference] HEAD -> refs/for/master/topic
 	EOF
@@ -145,7 +149,8 @@ test_expect_success "proc-receive: multiple rewrites for one ref ($PROTOCOL)" '
 	remote: proc-receive> option old-oid <COMMIT-A>
 	remote: proc-receive> option new-oid <COMMIT-B>
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/changes/23/123/1
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/changes/24/124/2
 	To <URL/of/upstream.git>
 	 * [new reference] HEAD -> refs/for/master/topic
 	EOF
diff --git a/t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh b/t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh
index f4a2c56e14..1dc8551bc6 100644
--- a/t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh
+++ b/t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh
@@ -41,7 +41,9 @@ test_expect_success "proc-receive: multiple rewrite for one ref, no refname for
 	remote: proc-receive> option old-oid <COMMIT-A>
 	remote: proc-receive> option new-oid <COMMIT-B>
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/changes/24/124/1
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/changes/25/125/1
 	To <URL/of/upstream.git>
 	*    HEAD:refs/for/master/topic    [new reference]
 	Done
@@ -100,7 +102,9 @@ test_expect_success "proc-receive: multiple rewrites for one ref, no refname for
 	remote: proc-receive> option new-oid <COMMIT-A>
 	remote: proc-receive> option forced-update
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/changes/24/124/1
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/changes/25/125/1
 	To <URL/of/upstream.git>
 	*    HEAD:refs/for/master/topic    [new reference]
 	Done
@@ -147,7 +151,8 @@ test_expect_success "proc-receive: multiple rewrites for one ref ($PROTOCOL/porc
 	remote: proc-receive> option old-oid <COMMIT-A>
 	remote: proc-receive> option new-oid <COMMIT-B>
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/changes/23/123/1
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/changes/24/124/2
 	To <URL/of/upstream.git>
 	*    HEAD:refs/for/master/topic    [new reference]
 	Done
diff --git a/t/t5411/test-0038-report-mixed-refs.sh b/t/t5411/test-0038-report-mixed-refs.sh
index 1dd6a97a97..bfc8d586d6 100644
--- a/t/t5411/test-0038-report-mixed-refs.sh
+++ b/t/t5411/test-0038-report-mixed-refs.sh
@@ -53,7 +53,7 @@ test_expect_success "proc-receive: report update of mixed refs ($PROTOCOL)" '
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic2
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
 	To <URL/of/upstream.git>
 	 <OID-A>..<OID-B> <COMMIT-B> -> master
 	 * [new branch] HEAD -> bar
diff --git a/t/t5411/test-0039-report-mixed-refs--porcelain.sh b/t/t5411/test-0039-report-mixed-refs--porcelain.sh
index 32ebf63dcf..5d021a4837 100644
--- a/t/t5411/test-0039-report-mixed-refs--porcelain.sh
+++ b/t/t5411/test-0039-report-mixed-refs--porcelain.sh
@@ -53,7 +53,7 @@ test_expect_success "proc-receive: report update of mixed refs ($PROTOCOL/porcel
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic2
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
 	To <URL/of/upstream.git>
 	     <COMMIT-B>:refs/heads/master    <OID-A>..<OID-B>
 	*    HEAD:refs/heads/bar    [new branch]
-- 
2.26.2.543.ge7de2a6e37

