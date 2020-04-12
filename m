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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55C9C352B6
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 13:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF68920673
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 13:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6Kbt8az"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgDLNae (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Apr 2020 09:30:34 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:38306 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgDLNad (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Apr 2020 09:30:33 -0400
Received: by mail-pg1-f174.google.com with SMTP id p8so3331958pgi.5
        for <git@vger.kernel.org>; Sun, 12 Apr 2020 06:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eBq2DMTG1zsRCX23vFlnEO2sIQ+lxz0GgRNEYq4lFpY=;
        b=m6Kbt8azylbWI+QLbof1L4A6vXCBs+XILmKPbG8DxElde5dPKWoXUWBJlKp7SPGhVK
         FZNLanVM3O3cr7m6C7VK8y7X2PEWKrQ61+q6Bwkh1n3su2K50IMQ4tfGheCaC7ENPajz
         ztTVsUOM6eGdg8m72OfghJEimDlCcBSyLlJOmIan1wzp1uMPdWS8m161NSkIzDYioAAH
         l2fbKgVbAblG3ei8vUTT7g4DhmtAFxgXJMkesupvMLd/o1UzVSDzgsvZovzDEkkx97YL
         E+zDVArdsnNShEIQPBAbd2evZ34au2QKHyBEaGi9kilktvbjGMTagjVlsvr7h6oM+zsX
         PP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eBq2DMTG1zsRCX23vFlnEO2sIQ+lxz0GgRNEYq4lFpY=;
        b=VSsBeyVMqL8ECeo9b0Ty0Wo9Y1d36j01f02pB2g891O8hF9UePvnPMpbg8E+y8KkQ6
         fkbWOAb38KhEB0RMJyXblZOQezZqZlMha2oAsNMZeypW5DzkWmzarnUxHnlyBbAx9M3g
         W0jANOt9iZ8MaGVQ5gfaKG/4klDEqLRdaYao0gOJ0ffWb0rMMDhBGH8kXVLd27+pmAHR
         LlPsVyy1zm7kzWcdBEckiX+s1HK44RlwnJGnlOlpp4dGxnzSivoAvIKu9xh8rCQXGdvX
         KLVlFzSzj70rafEn2DkpXAXm9uyDr8/8jKOMpnWy02af5HLaIN57rn0FO+c/bGUg+AZN
         4mWw==
X-Gm-Message-State: AGi0PuZH5n7PluyDUpEHQFBLpd1bL2EOn4WJy/AqGMsB8boSBiAPhqoA
        lnmDw8yoGA/FsH2yxEW0Cds=
X-Google-Smtp-Source: APiQypL3hV4b67zdSiOPm/Ea/2mdDdpoFDeEvCOxPP7Mye8tAL6JMg9m2tIZ1hO/eAhKWKdAeHTGRw==
X-Received: by 2002:a63:3002:: with SMTP id w2mr12882446pgw.290.1586698232072;
        Sun, 12 Apr 2020 06:30:32 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id 139sm6093363pfv.0.2020.04.12.06.30.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Apr 2020 06:30:31 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v10 4/8] receive-pack: new config receive.procReceiveRefs
Date:   Sun, 12 Apr 2020 09:30:18 -0400
Message-Id: <20200412133022.17590-5-worldhello.net@gmail.com>
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
 Documentation/config/receive.txt |  14 ++++
 builtin/receive-pack.c           |  43 ++++++++--
 t/t5411/common-test-cases.sh     | 130 +++++++++++++++++++++++++++++++
 3 files changed, 180 insertions(+), 7 deletions(-)

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
index 1a57c5bb3b..bdd0f0f448 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -76,6 +76,7 @@ static struct object_id push_cert_oid;
 static struct signature_check sigcheck;
 static const char *push_cert_nonce;
 static const char *cert_nonce_seed;
+static struct string_list proc_receive_refs;
 
 static const char *NONCE_UNSOLICITED = "UNSOLICITED";
 static const char *NONCE_BAD = "BAD";
@@ -228,6 +229,20 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
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
+		string_list_insert(&proc_receive_refs, prefix);
+		return 0;
+	}
+
 	return git_default_config(var, value, cb);
 }
 
@@ -1734,15 +1749,26 @@ static void execute_commands(struct command *commands,
 	/* Try to find commands that have special prefix in their reference names,
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
+			if (ref_is_matched(&proc_receive_refs, cmd->ref_name, refname_full.buf)) {
+				cmd->run_proc_receive = RUN_PROC_RECEIVE_SCHEDULED;
+				run_proc_receive = 1;
+			}
 		}
+
+		strbuf_release(&refname_full);
 	}
 
 	if (run_receive_hook(commands, "pre-receive", 0, push_options)) {
@@ -2196,6 +2222,8 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	string_list_init(&proc_receive_refs, 0);
+
 	packet_trace_identity("receive-pack");
 
 	argc = parse_options(argc, argv, prefix, options, receive_pack_usage, 0);
@@ -2311,5 +2339,6 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 	oid_array_clear(&shallow);
 	oid_array_clear(&ref);
 	free((void *)push_cert_nonce);
+	string_list_clear(&proc_receive_refs, 0);
 	return 0;
 }
diff --git a/t/t5411/common-test-cases.sh b/t/t5411/common-test-cases.sh
index 8e30c8f31e..d6ad0e1bc8 100644
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
@@ -617,3 +625,125 @@ test_expect_success "push with options" '
 	EOF
 	test_cmp expect actual
 '
+
+# Refs of upstream : master(A)             next(A)
+# Refs of workbench: master(A)  tags/v123
+test_expect_success "cleanup" '
+	git -C "$upstream" update-ref -d refs/heads/next
+'
+
+test_expect_success "setup proc-receive hook" '
+	cat >"$upstream/hooks/proc-receive" <<-EOF &&
+	#!/bin/sh
+
+	printf >&2 "# proc-receive hook\n"
+
+	test-tool proc-receive -v \
+		-r "$ZERO_OID $A refs/review/a/b/c/topic ok" \
+		-r "$ZERO_OID $A refs/for/next/topic ok" \
+		-r "$B $A refs/for/master/topic ok"
+	EOF
+	chmod a+x "$upstream/hooks/proc-receive"
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/next/topic(A)  refs/review/a/b/c/topic(A)  refs/for/master/topic(A)
+test_expect_success "report update of all special refs" '
+	git -C workbench push origin \
+		HEAD:refs/for/next/topic \
+		HEAD:refs/review/a/b/c/topic \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic ok
+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/next/topic ok
+	remote: proc-receive> <COMMIT-B> <COMMIT-A> refs/for/master/topic ok
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/for/master/topic
+	To <URL/of/upstream.git>
+	 * [new reference] HEAD -> refs/for/next/topic
+	 * [new reference] HEAD -> refs/review/a/b/c/topic
+	 * [new reference] HEAD -> refs/for/master/topic
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook" '
+	cat >"$upstream/hooks/proc-receive" <<-EOF &&
+	#!/bin/sh
+
+	printf >&2 "# proc-receive hook\n"
+
+	test-tool proc-receive -v \
+		-r "$ZERO_OID $A refs/for/next/topic ok" \
+		-r "$A $B refs/for/master/topic ok"
+	EOF
+	chmod a+x "$upstream/hooks/proc-receive"
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       bar(A)  baz(A)  refs/for/next/topic(A)  foo(A)  refs/for/master/topic(A)
+test_expect_success "report mixed refs update" '
+	git -C workbench push origin \
+		HEAD:refs/heads/bar \
+		HEAD:refs/heads/baz \
+		HEAD:refs/for/next/topic \
+		HEAD:refs/heads/foo \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/bar
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/next/topic ok
+	remote: proc-receive> <COMMIT-A> <COMMIT-B> refs/for/master/topic ok
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/bar
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
+	To <URL/of/upstream.git>
+	 * [new branch] HEAD -> bar
+	 * [new branch] HEAD -> baz
+	 * [new reference] HEAD -> refs/for/next/topic
+	 * [new branch] HEAD -> foo
+	 * [new reference] HEAD -> refs/for/master/topic
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/bar
+	<COMMIT-A> refs/heads/baz
+	<COMMIT-A> refs/heads/foo
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
-- 
2.24.1.15.g448c31058d.agit.4.5

