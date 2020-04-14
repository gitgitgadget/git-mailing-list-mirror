Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD22C2BA19
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 12:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D96FA2076D
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 12:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFqryohC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502011AbgDNMdf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 08:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2501995AbgDNMdK (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Apr 2020 08:33:10 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2417EC061A41
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 05:33:10 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id n13so5919510pgp.11
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 05:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6GGu5LvFAFFKgeyAKIK04qH38V7mAAWyhW0lGfGSRg4=;
        b=nFqryohCE0bBimPsYiK4rc7c9UfoWuMub9wDTeYrLxAJ1fS2JQ+S10vVYXGBcc7fiq
         LzQCWiOHIP50QTaWKLpypYASnTTyE+nFH3HvQK+it/goNn5/8j1eMRobAg6bjDgviuuP
         DIXaGduCmtRzy0J2bBJGQ2e9ekoAym7lr0O/6oIn0D93QKb2VYnP0w1QBvD/tnZmcbCW
         AjYXqpMJQFV5X+tfTY7U5KOcf4BP9/3TjwO3V4gmtWnRdHVbK0Onk+EycJbCt/f7+AdS
         sdvWTvWshf117uixGikC08ouuYU20mHoPo4E9QZ9lcZUTXwIc+CKwKnn1xA+ysfeUazy
         6W1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6GGu5LvFAFFKgeyAKIK04qH38V7mAAWyhW0lGfGSRg4=;
        b=gPh4H0DhOqroH9M/vz1WxcuWy39YNRl/jZvBk8WQJFo2JJzwy2Siy05eEqg6ymcKBg
         daEAP+zDPIsiNkwemkuXrFn4eTpW/u/zNEqrhPVLOKUJiMNS4BxRxSxilJFOrvDDm9EK
         EYJfgZDqtiXdPZaUYh/nYX+yyafDSPW61OoeaKif23soiGPiM5h9eAid9hWXQr42+gF1
         sQqluC7DU+U7NGssSPYYlnAnsB1OZzY9zgfLE939rulIxGbCD7lwTOGCAzsv5ftipvI4
         I5L4nYh3nLmvjj3TAtIVNRwjvDFq4BeP9f5pF+p65N/iR5HjwofpmWkoxAdS/3R8Jlax
         u9MQ==
X-Gm-Message-State: AGi0PuYwwfwlHyzXfzgiGfa3IfSTeOzr5eYa9N7hQ0m1dNiGBzWhUSk1
        knKA1yy7Bf/GrJ/Q/CLTwDw=
X-Google-Smtp-Source: APiQypKnbcOYn2hJDdewe0X9Jt1HVQ9o5c5hK8lLC6eadWaQLaQp594Y3uEVCXldrHCeArqDZ8GDxw==
X-Received: by 2002:a62:8684:: with SMTP id x126mr22684849pfd.160.1586867589610;
        Tue, 14 Apr 2020 05:33:09 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id c9sm996177pfp.53.2020.04.14.05.33.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Apr 2020 05:33:09 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v12 6/7] receive-pack: new config receive.procReceiveRefs
Date:   Tue, 14 Apr 2020 08:32:56 -0400
Message-Id: <20200414123257.27449-7-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <xmqq3697cax0.fsf@gitster.c.googlers.com>
References: <xmqq3697cax0.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Add a new multi-valued config variable "receive.procReceiveRefs"
for `receive-pack` command, like the follows:

    git config --system --add receive.procReceiveRefs refs/for
    git config --system --add receive.procReceiveRefs refs/drafts

If the specific prefix strings match the reference names of the commands
which are sent from git client to `receive-pack`, these commands will be
executed by an external hook (named "proc-receive"), instead of the
internal `execute_commands` function.

For example, if it is set to "refs/for", pushing to a reference such as
"refs/for/master" will not create or update reference "refs/for/master",
but may create or update a pull request directly by running the hook
"proc-receive".

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 Documentation/config/receive.txt | 14 +++++
 builtin/receive-pack.c           | 43 ++++++++++++---
 t/t5411/common-test-cases.sh     | 94 +++++++++++++++++++++++++++++---
 3 files changed, 136 insertions(+), 15 deletions(-)

diff --git a/Documentation/config/receive.txt b/Documentation/config/receive.txt
index 65f78aac37..e7b967feeb 100644
--- a/Documentation/config/receive.txt
+++ b/Documentation/config/receive.txt
@@ -114,6 +114,20 @@ receive.hideRefs::
 	An attempt to update or delete a hidden ref by `git push` is
 	rejected.
 
+receive.procReceiveRefs::
+	This is a multi-valued variable that defines reference prefixes
+	to match the commands in `receive-pack`.  Commands matching the
+	prefixes will be executed by an external hook "proc-receive",
+	instead of the internal `execute_commands` function.  If this
+	variable is not defined, the "proc-receive" hook will never be
+	used, and all commands will be executed by the internal
+	`execute_commands` function.
+
+	For example, if this variable is set to "refs/for", pushing to
+	reference such as "refs/for/master" will not create or update a
+	reference named "refs/for/master", but may create or update a
+	pull request directly by running the hook "proc-receive".
+
 receive.updateServerInfo::
 	If set to true, git-receive-pack will run git-update-server-info
 	after receiving data from git-push and updating refs.
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index fbbb01135e..40409b6dae 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -77,6 +77,7 @@ static struct object_id push_cert_oid;
 static struct signature_check sigcheck;
 static const char *push_cert_nonce;
 static const char *cert_nonce_seed;
+static struct string_list proc_receive_refs;
 
 static const char *NONCE_UNSOLICITED = "UNSOLICITED";
 static const char *NONCE_BAD = "BAD";
@@ -229,6 +230,20 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (strcmp(var, "receive.procreceiverefs") == 0) {
+		char *prefix;
+		int len;
+
+		if (!value)
+			return config_error_nonbool(var);
+		prefix = xstrdup(value);
+		len = strlen(prefix);
+		while (len && prefix[len - 1] == '/')
+			prefix[--len] = '\0';
+		string_list_append(&proc_receive_refs, prefix);
+		return 0;
+	}
+
 	return git_default_config(var, value, cb);
 }
 
@@ -1767,15 +1782,26 @@ static void execute_commands(struct command *commands,
 	 * Try to find commands that have special prefix in their reference names,
 	 * and mark them to run an external "proc-receive" hook later.
 	 */
-	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (!should_process_cmd(cmd))
-			continue;
+	if (proc_receive_refs.nr > 0) {
+		struct strbuf refname_full = STRBUF_INIT;
+		size_t prefix_len;
+
+		strbuf_addstr(&refname_full, get_git_namespace());
+		prefix_len = refname_full.len;
 
-		/* TODO: replace the fixed prefix by looking up git config variables. */
-		if (!strncmp(cmd->ref_name, "refs/for/", 9)) {
-			cmd->run_proc_receive = RUN_PROC_RECEIVE_SCHEDULED;
-			run_proc_receive = 1;
+		for (cmd = commands; cmd; cmd = cmd->next) {
+			if (!should_process_cmd(cmd))
+				continue;
+
+			strbuf_setlen(&refname_full, prefix_len);
+			strbuf_addstr(&refname_full, cmd->ref_name);
+			if (ref_matches(&proc_receive_refs, cmd->ref_name, refname_full.buf)) {
+				cmd->run_proc_receive = RUN_PROC_RECEIVE_SCHEDULED;
+				run_proc_receive = 1;
+			}
 		}
+
+		strbuf_release(&refname_full);
 	}
 
 	if (run_receive_hook(commands, "pre-receive", 0, push_options)) {
@@ -2240,6 +2266,8 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	string_list_init(&proc_receive_refs, 0);
+
 	packet_trace_identity("receive-pack");
 
 	argc = parse_options(argc, argv, prefix, options, receive_pack_usage, 0);
@@ -2355,5 +2383,6 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 	oid_array_clear(&shallow);
 	oid_array_clear(&ref);
 	free((void *)push_cert_nonce);
+	string_list_clear(&proc_receive_refs, 0);
 	return 0;
 }
diff --git a/t/t5411/common-test-cases.sh b/t/t5411/common-test-cases.sh
index 397748dd6f..aa6319cf4d 100644
--- a/t/t5411/common-test-cases.sh
+++ b/t/t5411/common-test-cases.sh
@@ -53,6 +53,14 @@ test_expect_success "cleanup" '
 	)
 '
 
+test_expect_success "add two receive.procReceiveRefs settings" '
+	(
+		cd "$upstream" &&
+		git config --add receive.procReceiveRefs refs/for &&
+		git config --add receive.procReceiveRefs refs/review/
+	)
+'
+
 # Refs of upstream : master(A)
 # Refs of workbench: master(A)  tags/v123
 # git push         :                       next(A)  refs/for/master/topic(A)
@@ -572,7 +580,7 @@ test_expect_success "setup proc-receive hook (with extended status)" '
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
-		-r "ok refs/for/a/b/c/topic" \
+		-r "ok refs/review/a/b/c/topic" \
 		-r "alt refs/for/next/topic refs/pull/123/head" \
 		-r "alt refs/for/master/topic refs/pull/124/head old-oid=$B forced-update new-oid=$A"
 	EOF
@@ -580,33 +588,33 @@ test_expect_success "setup proc-receive hook (with extended status)" '
 
 # Refs of upstream : master(A)
 # Refs of workbench: master(A)  tags/v123
-# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
+# git push         :                       refs/for/next/topic(A)  refs/review/a/b/c/topic(A)  refs/for/master/topic(A)
 test_expect_success "proc-receive: report with extended status" '
 	git -C workbench push origin \
 		HEAD:refs/for/next/topic \
-		HEAD:refs/for/a/b/c/topic \
+		HEAD:refs/review/a/b/c/topic \
 		HEAD:refs/for/master/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
 	remote: # proc-receive hook
 	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic
 	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
-	remote: proc-receive> ok refs/for/a/b/c/topic
+	remote: proc-receive> ok refs/review/a/b/c/topic
 	remote: proc-receive> alt refs/for/next/topic refs/pull/123/head
 	remote: proc-receive> alt refs/for/master/topic refs/pull/124/head old-oid=<COMMIT-B> forced-update new-oid=<COMMIT-A>
 	remote: # post-receive hook
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
 	To <URL/of/upstream.git>
 	 * [new reference] HEAD -> refs/pull/123/head
-	 * [new reference] HEAD -> refs/for/a/b/c/topic
+	 * [new reference] HEAD -> refs/review/a/b/c/topic
 	 + <OID-B>...<OID-A> HEAD -> refs/pull/124/head (forced update)
 	EOF
 	test_cmp expect actual &&
@@ -718,3 +726,73 @@ test_expect_success "proc-receive: report update of mixed refs" '
 	EOF
 	test_cmp expect actual
 '
+
+test_expect_success "config add receive.procReceiveRefs = refs" '
+	git -C "$upstream" config --add receive.procReceiveRefs refs
+'
+
+test_expect_success "setup proc-receive hook" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ft refs/heads/master" \
+		-r "ft refs/heads/foo" \
+		-r "ft refs/heads/bar" \
+		-r "alt refs/for/master/topic refs/pull/123/head old-oid=$A new-oid=$B " \
+		-r "alt refs/for/next/topic refs/pull/124/head old-oid=$B new-oid=$A forced-update"
+	EOF
+'
+
+# Refs of upstream : master(B)             foo(A)  bar(A))  baz(A)
+# Refs of workbench: master(A)  tags/v123
+# git push -f      : master(A)             (NULL)  (B)              refs/for/master/topic(A)  refs/for/next/topic(A)
+test_expect_success "proc-receive: process all refs" '
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
+	remote: proc-receive> ft refs/heads/master
+	remote: proc-receive> ft refs/heads/foo
+	remote: proc-receive> ft refs/heads/bar
+	remote: proc-receive> alt refs/for/master/topic refs/pull/123/head old-oid=<COMMIT-A> new-oid=<COMMIT-B>
+	remote: proc-receive> alt refs/for/next/topic refs/pull/124/head old-oid=<COMMIT-B> new-oid=<COMMIT-A> forced-update
+	remote: # post-receive hook
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/bar
+	remote: post-receive< <COMMIT-A> <ZERO-OID> refs/heads/foo
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/heads/master
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
+	To <URL/of/upstream.git>
+	 <OID-A>..<OID-B> <COMMIT-B> -> bar
+	 - [deleted] foo
+	 + <OID-B>...<OID-A> HEAD -> master (forced update)
+	 <OID-A>..<OID-B> HEAD -> refs/pull/123/head
+	 + <OID-B>...<OID-A> HEAD -> refs/pull/124/head (forced update)
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-B> refs/heads/bar
+	<COMMIT-A> refs/heads/baz
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
-- 
2.24.1.15.g448c31058d.agit.4.5

