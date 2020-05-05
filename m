Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF1AC4725B
	for <git@archiver.kernel.org>; Tue,  5 May 2020 14:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85341206A5
	for <git@archiver.kernel.org>; Tue,  5 May 2020 14:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3I7EsW0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbgEEOlv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 10:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729484AbgEEOlr (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 May 2020 10:41:47 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD4BC061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 07:41:47 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id u10so901213pls.8
        for <git@vger.kernel.org>; Tue, 05 May 2020 07:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=77QmFNxODz4b0j360mFzc/eK/VmoPjY0AS5ov4aGX60=;
        b=D3I7EsW0LHOtnWhoR44NyH6H4EGsmFeh2Q4qGCuqwRAWOo90vKUVOqDpKz3D8lEA5h
         DYcnGfq+MySIRRwsOcPFeF3DDLdf6fAbyCtiEu+Hzs695/0jLXobnMSnCumZYTzkoIVv
         o/PkFPJATGblfhpy+8y7mekokdK29ETBaNos8YeVNhrhE4bkQlwJHcaQ8cJP2+h+KE/K
         QrL9Qf8qsLY05aT+9g7C7yTsGJpGQ2OPoHxvs27QQSuMV2HuPgq5bqjXwsq/7wuI5gjS
         tk9eNiELIGvXKM/d0wTNIuXQGmmxA2+NpeIV5GzlYOIGEMJRJyErb9HEGcRpRVnYJ1Vb
         zP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=77QmFNxODz4b0j360mFzc/eK/VmoPjY0AS5ov4aGX60=;
        b=lwaPMDhuZRwwbEeQpXobTMT2Kf8I3MSNDafIYXpOtCx+G61lb2Wr8CN8xVq9u9JmQC
         59CuRfAJnycUA8yUsBlu/4BRnC06VxjB7lj/B7FM8PEHPv3vuoFKfF0SgG2mqG3kU5Fa
         xoxtGgD2S2Jq50gXUYu155KqyCvXg9HfkRv2o2MteqmEbLUHAjrUDORDVOZChzc/svIY
         9Rve9B9iDc4xCCQxdzjzrBdexU+0yGscwEkeJa7Pig0JKfULQ34tUTq0Im5GQI91Wqh6
         5nP543hva/LsOAhJGz+Cuid6UPqgkFBP76wElsEqSUgomKZtMs0i5tewQLUHOFwEIAT0
         A8Jw==
X-Gm-Message-State: AGi0PuZPTRqBX6yRT5qVzvIKcKMky4IBDmlzgwPtbpeSorLD6ffkvpaf
        qHQMaWlH1sA8wZMkgOdKGbc=
X-Google-Smtp-Source: APiQypLOyjhts/rs5CPLUzFKNnrQUwCmSvNQiyzqB3weiuu3cb515kUvUwdKTpXMCLZVY0u0upvPtA==
X-Received: by 2002:a17:902:a413:: with SMTP id p19mr3562451plq.1.1588689706571;
        Tue, 05 May 2020 07:41:46 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id f99sm2431012pjg.22.2020.05.05.07.41.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2020 07:41:45 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v14 6/7] receive-pack: new config receive.procReceiveRefs
Date:   Tue,  5 May 2020 10:41:30 -0400
Message-Id: <20200505144131.30048-7-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <CANYiYbFCG1_hdy1kA06wjrvGSQ2=y-hJX3Rsh-rn=X9tcqv1VQ@mail.gmail.com>
References: <CANYiYbFCG1_hdy1kA06wjrvGSQ2=y-hJX3Rsh-rn=X9tcqv1VQ@mail.gmail.com>
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
 Documentation/config/receive.txt              |  14 +++
 builtin/receive-pack.c                        |  43 +++++--
 t/t5411/test-0010-proc-receive-settings.sh    |   7 ++
 t/t5411/test-0040-process-all-refs.sh         | 113 +++++++++++++++++
 .../test-0041-process-all-refs--porcelain.sh  | 114 ++++++++++++++++++
 5 files changed, 284 insertions(+), 7 deletions(-)
 create mode 100644 t/t5411/test-0010-proc-receive-settings.sh
 create mode 100644 t/t5411/test-0040-process-all-refs.sh
 create mode 100644 t/t5411/test-0041-process-all-refs--porcelain.sh

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
index f57d997121..88926c8664 100644
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
 
@@ -1810,15 +1825,26 @@ static void execute_commands(struct command *commands,
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
@@ -2317,6 +2343,8 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	string_list_init(&proc_receive_refs, 0);
+
 	packet_trace_identity("receive-pack");
 
 	argc = parse_options(argc, argv, prefix, options, receive_pack_usage, 0);
@@ -2434,5 +2462,6 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 	oid_array_clear(&shallow);
 	oid_array_clear(&ref);
 	free((void *)push_cert_nonce);
+	string_list_clear(&proc_receive_refs, 0);
 	return 0;
 }
diff --git a/t/t5411/test-0010-proc-receive-settings.sh b/t/t5411/test-0010-proc-receive-settings.sh
new file mode 100644
index 0000000000..a36809927b
--- /dev/null
+++ b/t/t5411/test-0010-proc-receive-settings.sh
@@ -0,0 +1,7 @@
+test_expect_success "add two receive.procReceiveRefs settings" '
+	(
+		cd "$upstream" &&
+		git config --add receive.procReceiveRefs refs/for &&
+		git config --add receive.procReceiveRefs refs/review/
+	)
+'
diff --git a/t/t5411/test-0040-process-all-refs.sh b/t/t5411/test-0040-process-all-refs.sh
new file mode 100644
index 0000000000..b07c999f53
--- /dev/null
+++ b/t/t5411/test-0040-process-all-refs.sh
@@ -0,0 +1,113 @@
+test_expect_success "config receive.procReceiveRefs = refs ($PROTOCOL)" '
+	git -C "$upstream" config --unset-all receive.procReceiveRefs &&
+	git -C "$upstream" config --add receive.procReceiveRefs refs
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+test_expect_success "setup upstream branches ($PROTOCOL)" '
+	(
+		cd "$upstream" &&
+		git update-ref refs/heads/master $B &&
+		git update-ref refs/heads/foo $A &&
+		git update-ref refs/heads/bar $A &&
+		git update-ref refs/heads/baz $A
+	)
+
+'
+
+test_expect_success "setup proc-receive hook ($PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/heads/master" \
+		-r "option fall-through" \
+		-r "ok refs/heads/foo" \
+		-r "option fall-through" \
+		-r "ok refs/heads/bar" \
+		-r "option fall-through" \
+		-r "ok refs/for/master/topic" \
+		-r "option refname refs/pull/123/head" \
+		-r "option old-oid $A" \
+		-r "option new-oid $B" \
+		-r "ok refs/for/next/topic" \
+		-r "option refname refs/pull/124/head" \
+		-r "option old-oid $B" \
+		-r "option new-oid $A" \
+		-r "option forced-update"
+	EOF
+'
+
+# Refs of upstream : master(B)             foo(A)  bar(A))  baz(A)
+# Refs of workbench: master(A)  tags/v123
+# git push -f      : master(A)             (NULL)  (B)              refs/for/master/topic(A)  refs/for/next/topic(A)
+test_expect_success "proc-receive: process all refs ($PROTOCOL)" '
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
+	remote: proc-receive> ok refs/heads/master
+	remote: proc-receive> option fall-through
+	remote: proc-receive> ok refs/heads/foo
+	remote: proc-receive> option fall-through
+	remote: proc-receive> ok refs/heads/bar
+	remote: proc-receive> option fall-through
+	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> option refname refs/pull/123/head
+	remote: proc-receive> option old-oid <COMMIT-A>
+	remote: proc-receive> option new-oid <COMMIT-B>
+	remote: proc-receive> ok refs/for/next/topic
+	remote: proc-receive> option refname refs/pull/124/head
+	remote: proc-receive> option old-oid <COMMIT-B>
+	remote: proc-receive> option new-oid <COMMIT-A>
+	remote: proc-receive> option forced-update
+	remote: # post-receive hook
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/bar
+	remote: post-receive< <COMMIT-A> <ZERO-OID> refs/heads/foo
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/heads/master
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/pull/123/head
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/pull/124/head
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
+
+# Refs of upstream : master(A)             bar(A)  baz(B)
+# Refs of workbench: master(A)  tags/v123
+test_expect_success "cleanup ($PROTOCOL)" '
+	(
+		cd "$upstream" &&
+		git update-ref -d refs/heads/bar &&
+		git update-ref -d refs/heads/baz
+	)
+'
diff --git a/t/t5411/test-0041-process-all-refs--porcelain.sh b/t/t5411/test-0041-process-all-refs--porcelain.sh
new file mode 100644
index 0000000000..7092db0a06
--- /dev/null
+++ b/t/t5411/test-0041-process-all-refs--porcelain.sh
@@ -0,0 +1,114 @@
+test_expect_success "config receive.procReceiveRefs = refs ($PROTOCOL)" '
+	git -C "$upstream" config --unset-all receive.procReceiveRefs &&
+	git -C "$upstream" config --add receive.procReceiveRefs refs
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+test_expect_success "setup upstream branches ($PROTOCOL)" '
+	(
+		cd "$upstream" &&
+		git update-ref refs/heads/master $B &&
+		git update-ref refs/heads/foo $A &&
+		git update-ref refs/heads/bar $A &&
+		git update-ref refs/heads/baz $A
+	)
+
+'
+
+test_expect_success "setup proc-receive hook ($PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/heads/master" \
+		-r "option fall-through" \
+		-r "ok refs/heads/foo" \
+		-r "option fall-through" \
+		-r "ok refs/heads/bar" \
+		-r "option fall-through" \
+		-r "ok refs/for/master/topic" \
+		-r "option refname refs/pull/123/head" \
+		-r "option old-oid $A" \
+		-r "option new-oid $B" \
+		-r "ok refs/for/next/topic" \
+		-r "option refname refs/pull/124/head" \
+		-r "option old-oid $B" \
+		-r "option new-oid $A" \
+		-r "option forced-update"
+	EOF
+'
+
+# Refs of upstream : master(B)             foo(A)  bar(A))  baz(A)
+# Refs of workbench: master(A)  tags/v123
+# git push -f      : master(A)             (NULL)  (B)              refs/for/master/topic(A)  refs/for/next/topic(A)
+test_expect_success "proc-receive: process all refs ($PROTOCOL/porcelain)" '
+	git -C workbench push --porcelain -f origin \
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
+	remote: proc-receive> ok refs/heads/master
+	remote: proc-receive> option fall-through
+	remote: proc-receive> ok refs/heads/foo
+	remote: proc-receive> option fall-through
+	remote: proc-receive> ok refs/heads/bar
+	remote: proc-receive> option fall-through
+	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> option refname refs/pull/123/head
+	remote: proc-receive> option old-oid <COMMIT-A>
+	remote: proc-receive> option new-oid <COMMIT-B>
+	remote: proc-receive> ok refs/for/next/topic
+	remote: proc-receive> option refname refs/pull/124/head
+	remote: proc-receive> option old-oid <COMMIT-B>
+	remote: proc-receive> option new-oid <COMMIT-A>
+	remote: proc-receive> option forced-update
+	remote: # post-receive hook
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/bar
+	remote: post-receive< <COMMIT-A> <ZERO-OID> refs/heads/foo
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/heads/master
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/pull/123/head
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/pull/124/head
+	To <URL/of/upstream.git>
+	     <COMMIT-B>:refs/heads/bar    <OID-A>..<OID-B>
+	-    :refs/heads/foo    [deleted]
+	+    HEAD:refs/heads/master    <OID-B>...<OID-A> (forced update)
+	     HEAD:refs/pull/123/head    <OID-A>..<OID-B>
+	+    HEAD:refs/pull/124/head    <OID-B>...<OID-A> (forced update)
+	Done
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
+
+# Refs of upstream : master(A)             bar(A)  baz(B)
+# Refs of workbench: master(A)  tags/v123
+test_expect_success "cleanup ($PROTOCOL)" '
+	(
+		cd "$upstream" &&
+		git update-ref -d refs/heads/bar &&
+		git update-ref -d refs/heads/baz
+	)
+'
-- 
2.26.1.120.g98702cf3e9

