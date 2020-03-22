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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6A5C54FD1
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 13:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45FD6206C3
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 13:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVwYqZNE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgCVNSb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 09:18:31 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:40408 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgCVNSa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 09:18:30 -0400
Received: by mail-pg1-f172.google.com with SMTP id t24so5717969pgj.7
        for <git@vger.kernel.org>; Sun, 22 Mar 2020 06:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=59Ye2YrJ2JXhHSe6f4fSVZcprQwmdvuNx3+vM7mYsY0=;
        b=nVwYqZNEvfc7ACuOU0x+/HUjHcNYa6uYh4FkJJ0UyghrXGcNrR6OIp9BlPtfgPbeXy
         tlPm0iTr+UJidbIJIBkZ8B4zcLxHSHtmtokrqsOwOYNuauLa4vTp4WlETnncbBU5icDf
         Jk+GqxL+llUDR5loIaNHnnegA1zJwYW7LM4g5N7/lmmyz5BzmHSXyTcqUEZEEgrbjKOX
         F1roWU2msxN/AxqdojYMAbVWgHOTqOdJsHMTDU8r4z+/6aY9e0m3NlWSi2C1Qm+3pt6q
         JuN/YNLKM/A13pkHq4pWDs/tcv65psLR9qit2CS83eIbbp4V6gTX2pTSxaULXpx9gCvJ
         mtLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=59Ye2YrJ2JXhHSe6f4fSVZcprQwmdvuNx3+vM7mYsY0=;
        b=QvXxe/e4xDydYM54Pap7FZe7V3cKT2vxiMTfqYFn9f0trN7BTgs3z/0v3lt+f9wghA
         0XSwm86lpOlP9lm5I/1CMoTxnCZyC43ziURnNJWrh/fhBhy1RWqDMbwkiNjqUnNVfK8U
         02sOZV31bB+V4bvK3IppVdullfJuBXSb5VdIm6nwvEKZo3VIA9/A/Rr75tinWu0xwzOM
         FvrdTlivxMq9dO7C+WyprxKh+YNTi5TjrDixlmspMrhI/GYVSWMvuZ9qLL8NQSJC3WAt
         mm9wBKLSb/WjkYryeiL3gZYCfGcWl0poV5kHri4dcbWLg+gui6vu609YDAYNmHDv7x4/
         eCxw==
X-Gm-Message-State: ANhLgQ2ldWzVa4OPsiNBXIpApvQQ/iItvS5qil2ZrVFovQN7scz3/Fqi
        6b+L1GcKsmvYC8aTNnWQ0d7uL/ND
X-Google-Smtp-Source: ADFU+vtZCIH2W10fKmQ015zCBfEdNWEk2Zx9MhxoVFvVqHwrwWaSMfMadeLJH2md4MgKyJmf84uL7w==
X-Received: by 2002:a63:5d04:: with SMTP id r4mr17228877pgb.241.1584883109078;
        Sun, 22 Mar 2020 06:18:29 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id nh4sm9456432pjb.39.2020.03.22.06.18.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Mar 2020 06:18:28 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v4 4/5] receive-pack: new config receive.procReceiveRefs
Date:   Sun, 22 Mar 2020 09:18:14 -0400
Message-Id: <20200322131815.11872-5-worldhello.net@gmail.com>
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

Add a new multi-valued config variable "receive.procReceiveRefs"
for `receive-pack` command, like the follows:

    git config --system --add receive.procReceiveRefs refs/for/
    git config --system --add receive.procReceiveRefs refs/drafts/

If the specific prefix strings match the reference names of the commands
which are sent by git client to `receive-pack`, these commands will be
executed by an external hook (named "proc-receive"), instead of the
internal `execute_commands` function.

For example, if it is set to "refs/for/", pushing to a reference such as
"refs/for/master" will not create or update reference "refs/for/master",
but may create or update a pull request directly by running the external
hook.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 Documentation/config/receive.txt |  14 +++
 builtin/receive-pack.c           |  43 +++++--
 t/t5411-proc-receive-hook.sh     | 204 +++++++++++++++++++++++++++++++
 3 files changed, 254 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/receive.txt b/Documentation/config/receive.txt
index 65f78aac37..0178f2d478 100644
--- a/Documentation/config/receive.txt
+++ b/Documentation/config/receive.txt
@@ -114,6 +114,20 @@ receive.hideRefs::
 	An attempt to update or delete a hidden ref by `git push` is
 	rejected.
 
+receive.procReceiveRefs::
+	This is a multi-valued variable that defines reference prefixes
+	to match the commands in `receive-pack`.  Commands matching the
+	prefixes will be executed by an external hooks "proc-receive",
+	instead of the internal `execute_commands` function.  If this
+	variable is not defined, the "proc-receive" hook will never be
+	used, and all commands will be executed by the internal
+	`execute_commands` function.
+
+	For example, if this variable is set to "refs/for/", pushing to
+	reference such as "refs/for/master" will not create or update a
+	reference named "refs/for/master", but may create or update a
+	pull request directly by running an external hook.
+
 receive.updateServerInfo::
 	If set to true, git-receive-pack will run git-update-server-info
 	after receiving data from git-push and updating refs.
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 0aca08eb65..fef97e6985 100644
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
 
@@ -1738,15 +1753,26 @@ static void execute_commands(struct command **orig_commands,
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
-			cmd->run_proc_receive = 1;
-			run_proc_receive = 1;
+		for (cmd = commands; cmd; cmd = cmd->next) {
+			if (!should_process_cmd(cmd))
+				continue;
+
+			strbuf_setlen(&refname_full, prefix_len);
+			strbuf_addstr(&refname_full, cmd->ref_name);
+			if (ref_is_matched(&proc_receive_refs, cmd->ref_name, refname_full.buf)) {
+				cmd->run_proc_receive = 1;
+				run_proc_receive = 1;
+			}
 		}
+
+		strbuf_release(&refname_full);
 	}
 
 	if (run_receive_hook(commands, "pre-receive", 0, push_options)) {
@@ -2207,6 +2233,8 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	string_list_init(&proc_receive_refs, 0);
+
 	packet_trace_identity("receive-pack");
 
 	argc = parse_options(argc, argv, prefix, options, receive_pack_usage, 0);
@@ -2322,5 +2350,6 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 	oid_array_clear(&shallow);
 	oid_array_clear(&ref);
 	free((void *)push_cert_nonce);
+	string_list_clear(&proc_receive_refs, 0);
 	return 0;
 }
diff --git a/t/t5411-proc-receive-hook.sh b/t/t5411-proc-receive-hook.sh
index d114559792..f9681bed34 100755
--- a/t/t5411-proc-receive-hook.sh
+++ b/t/t5411-proc-receive-hook.sh
@@ -168,6 +168,14 @@ test_expect_success "cleanup" '
 	)
 '
 
+test_expect_success "add two receive.procReceiveRefs settings" '
+	(
+		cd upstream &&
+		git config --add receive.procReceiveRefs refs/for/ &&
+		git config --add receive.procReceiveRefs refs/review/
+	)
+'
+
 test_expect_success "no proc-receive hook, fail to push special ref" '
 	(
 		cd workbench &&
@@ -669,4 +677,200 @@ test_expect_success "push with options" '
 	test_cmp expect actual
 '
 
+test_expect_success "cleanup" '
+	(
+		cd upstream &&
+		git update-ref -d refs/heads/next
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
+		-r "$ZERO_OID $A refs/for/next/topic ok" \
+		-r "$ZERO_OID $A refs/review/a/b/c/topic ok" \
+		-r "$ZERO_OID $A refs/for/master/topic ok"
+	EOF
+	chmod a+x upstream/hooks/proc-receive
+'
+
+test_expect_success "report update of all special refs" '
+	(
+		cd workbench &&
+		git push origin \
+			HEAD:refs/for/next/topic \
+			HEAD:refs/review/a/b/c/topic \
+			HEAD:refs/for/master/topic
+	) >out 2>&1 &&
+	format_git_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/next/topic ok
+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic ok
+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic ok
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	To ../upstream
+	 * [new reference]   HEAD -> refs/for/next/topic
+	 * [new reference]   HEAD -> refs/review/a/b/c/topic
+	 * [new reference]   HEAD -> refs/for/master/topic
+	EOF
+	test_cmp expect actual &&
+	(
+		cd upstream &&
+		git show-ref
+	) >out &&
+	format_git_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook" '
+	cat >upstream/hooks/proc-receive <<-EOF &&
+	#!/bin/sh
+
+	printf >&2 "# proc-receive hook\n"
+
+	test-tool proc-receive -v \
+		-r "$ZERO_OID $A refs/for/next/topic ok" \
+		-r "$ZERO_OID $A refs/for/master/topic ok"
+	EOF
+	chmod a+x upstream/hooks/proc-receive
+'
+
+test_expect_success "report mixed refs update (head first)" '
+	(
+		cd workbench &&
+		git push origin \
+			HEAD:refs/heads/zzz \
+			HEAD:refs/for/next/topic \
+			HEAD:refs/heads/yyy \
+			HEAD:refs/for/master/topic
+	) >out 2>&1 &&
+	format_git_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/zzz
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/yyy
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/next/topic ok
+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic ok
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/zzz
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/yyy
+	To ../upstream
+	 * [new branch]      HEAD -> zzz
+	 * [new reference]   HEAD -> refs/for/next/topic
+	 * [new branch]      HEAD -> yyy
+	 * [new reference]   HEAD -> refs/for/master/topic
+	EOF
+	test_cmp expect actual &&
+	(
+		cd upstream &&
+		git show-ref
+	) >out &&
+	format_git_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/yyy
+	<COMMIT-A> refs/heads/zzz
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "cleanup" '
+	(
+		cd upstream &&
+		git update-ref -d refs/heads/yyy &&
+		git update-ref -d refs/heads/zzz
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
+		-r "$ZERO_OID $A refs/for/next/topic ok" \
+		-r "$ZERO_OID $A refs/review/a/b/c/topic ok" \
+		-r "$ZERO_OID $A refs/for/master/topic ok"
+	EOF
+	chmod a+x upstream/hooks/proc-receive
+'
+
+test_expect_success "report mixed refs update (special ref first)" '
+	(
+		cd workbench &&
+		git push origin \
+			HEAD:refs/for/next/topic \
+			$B:refs/heads/zzz \
+			HEAD:refs/review/a/b/c/topic \
+			HEAD:refs/heads/yyy \
+			HEAD:refs/for/master/topic
+	) >out 2>&1 &&
+	format_git_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-B> refs/heads/zzz
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/yyy
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: # proc-receive hook
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/next/topic ok
+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic ok
+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic ok
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-B> refs/heads/zzz
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/yyy
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	To ../upstream
+	 * [new reference]   HEAD -> refs/for/next/topic
+	 * [new branch]      <COMMIT-B> -> zzz
+	 * [new reference]   HEAD -> refs/review/a/b/c/topic
+	 * [new branch]      HEAD -> yyy
+	 * [new reference]   HEAD -> refs/for/master/topic
+	EOF
+	test_cmp expect actual &&
+	(
+		cd upstream &&
+		git show-ref
+	) >out &&
+	format_git_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/yyy
+	<COMMIT-B> refs/heads/zzz
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.26.0.rc1.33.g4914ba4bcf

