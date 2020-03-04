Return-Path: <SRS0=VPsx=4V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39C7C3F2CD
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 11:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70BBA20848
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 11:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTICJZ+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387916AbgCDLeT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Mar 2020 06:34:19 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45635 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387774AbgCDLeS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Mar 2020 06:34:18 -0500
Received: by mail-pf1-f195.google.com with SMTP id 2so822909pfg.12
        for <git@vger.kernel.org>; Wed, 04 Mar 2020 03:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ne5F8ZRMvh556lbsimJKy9wo8h0Xh4HmkQ76OU4R18Y=;
        b=RTICJZ+GC3bjLwOyHYGBrqOjb9dWkFvrtj2IABL9JMbGDjvgGmoPbz8/dtGr6yuqL7
         nQsLT99btDZbkb3vAYrKhBTq+6w9VGKA3pB4x55eVfAhH9m9X29nVGPscKBr5KwH6m3l
         dkTyd/AcD/rOGxl0KOMEMyRak86pWEbyUMuTkUu80j2Rrmf8FVmfVnbxmehyV18PjJ2m
         syvJOK4Q+oug3P6BKjdADS+qk3aG+8CC6pTzIM5SQ5PMUemYtXOOWcfOCRU6eRDXhszS
         RqdfmevresDC2rNL5JsoXaR9OR51rgUPZ6e7hleHAa12g/ucpf8o9ld/6kNEqALgBCVJ
         EYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ne5F8ZRMvh556lbsimJKy9wo8h0Xh4HmkQ76OU4R18Y=;
        b=db63P2WrMVab9A9kJR4rs1H0AjpHdfkb1eol5g59bp36Q3+j4egAwQZihEWO65hYJn
         MLe2T64TSgj05SeqQ/LdzRy7UQJoKhJKI9e2kH0DIwb3vMkjoD3c7EAvG7uu2UnFjC46
         EIJFrqed7w78PP1PEb/HaNSFpW3HnQK2Xq6N9pgw/tAyNTVKQa103p012EZGfMpxuBUR
         0fF7+cbOd6PqQWlAPa+/VE4Xss+h9E8/cfay2ihJfLa+5w/WeS/pRlDi09LoBzPb+/iZ
         9VtcXzLs4k3utRwr5Rj3kS/9TsWK1Qfzadjk207tYMVwFvqIIFzT355ATQO1SKm//f1M
         9yig==
X-Gm-Message-State: ANhLgQ2M+f9VRH1WUFyTQreHtBHjA+BrhWVUZiYBBPpCIjm+Ytf+NOhF
        0kW6Q9yd9Uap6gaGOgBfqCRNL6Tt4V2/QA==
X-Google-Smtp-Source: ADFU+vvRjBz8VCemwQMGFK946JTtFVI4sm+WNX4l1z1pSgkK+9ZCeJweU3ru8esVCqFE1WH0LFF2fg==
X-Received: by 2002:a63:5251:: with SMTP id s17mr2247011pgl.160.1583321657233;
        Wed, 04 Mar 2020 03:34:17 -0800 (PST)
Received: from localhost.localdomain ([47.89.83.4])
        by smtp.gmail.com with ESMTPSA id d77sm15350050pfd.109.2020.03.04.03.34.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Mar 2020 03:34:16 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
X-Google-Original-From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
To:     Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/7] receive-pack: new config receive.executeCommandsHookRefs
Date:   Wed,  4 Mar 2020 19:33:11 +0800
Message-Id: <20200304113312.34229-7-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.25.1.362.g51ebf55b93
In-Reply-To: <20200304113312.34229-1-zhiyou.jx@alibaba-inc.com>
References: <20200304113312.34229-1-zhiyou.jx@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new multi-valued config variable "receive.executeCommandsHookRefs"
for `receive-pack` command, like the follows:

    git config --system --add receive.executeCommandsHookRefs refs/for/
    git config --system --add receive.executeCommandsHookRefs refs/drafts/

If the specific prefix strings match the reference names of the commands
which are sent by git client to `receive-pack`, these commands will be
executed by an external hook (named "execute-commands"), instead of the
internal `execute_commands` function.

For example, if it is set to "refs/for/", pushing to a reference such as
"refs/for/master" will not create or update reference "refs/for/master",
but may create or update a pull request directly by running the external
hook.  Use more than one definition to specify multiple prefix strings.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 Documentation/config/receive.txt | 11 +++++
 builtin/receive-pack.c           | 48 ++++++++++++++++-----
 t/t5411-execute-commands-hook.sh | 72 ++++++++++++++++++++++++++++++--
 3 files changed, 117 insertions(+), 14 deletions(-)

diff --git a/Documentation/config/receive.txt b/Documentation/config/receive.txt
index 65f78aac37..a8e2125e62 100644
--- a/Documentation/config/receive.txt
+++ b/Documentation/config/receive.txt
@@ -108,6 +108,17 @@ receive.denyNonFastForwards::
 	even if that push is forced. This configuration variable is
 	set when initializing a shared repository.
 
+receive.executeCommandsHookRefs::
+	If the specific prefix matches the reference name of the command
+	which is sent by the client to `receive-pack`, the command will be
+	executed by an external hook (named "execute-commands"), instead of
+	the internal `execute_commands` function. For example, if it is
+	set to "refs/for/", pushing to reference such as "refs/for/master"
+	will not create or update a reference named "refs/for/master", but
+	may create or update a pull request directly by running the external
+	hook. Use more than one definition to specify multiple prefix
+	strings.
+
 receive.hideRefs::
 	This variable is the same as `transfer.hideRefs`, but applies
 	only to `receive-pack` (and so affects pushes, but not fetches).
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index fd2f3ba80a..f78adeffd4 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -75,6 +75,7 @@ static struct object_id push_cert_oid;
 static struct signature_check sigcheck;
 static const char *push_cert_nonce;
 static const char *cert_nonce_seed;
+static struct string_list execute_commands_hook_refs;
 
 static const char *NONCE_UNSOLICITED = "UNSOLICITED";
 static const char *NONCE_BAD = "BAD";
@@ -228,6 +229,20 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (strcmp(var, "receive.executecommandshookrefs") == 0) {
+		char *prefix;
+		int len;
+
+		if (!value)
+			return config_error_nonbool(var);
+		prefix = xstrdup(value);
+		len = strlen(prefix);
+		while (len && prefix[len - 1] == '/')
+			prefix[--len] = '\0';
+		string_list_insert(&execute_commands_hook_refs, prefix);
+		return 0;
+	}
+
 	return git_default_config(var, value, cb);
 }
 
@@ -1600,17 +1615,29 @@ static void execute_commands(struct command *commands,
 	/* Try to find commands that have special prefix, and will run these
 	 * commands using an external "execute-commands" hook.
 	 */
-	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (!should_process_cmd(cmd))
-			continue;
+	if (execute_commands_hook_refs.nr > 0) {
+		struct strbuf refname_full = STRBUF_INIT;
+		size_t prefix_len;
 
-		/* TODO: replace the fixed prefix by looking up git config variables. */
-		if (!strncmp(cmd->ref_name, "refs/for/", 9)) {
-			cmd->exec_by_hook = 1;
-			seen_exec_by_hook = 1;
-		} else
-			seen_internal_exec = 1;
-	}
+		strbuf_addstr(&refname_full, get_git_namespace());
+		prefix_len = refname_full.len;
+
+		for (cmd = commands; cmd; cmd = cmd->next) {
+			if (!should_process_cmd(cmd))
+				continue;
+
+			strbuf_setlen(&refname_full, prefix_len);
+			strbuf_addstr(&refname_full, cmd->ref_name);
+			if (ref_is_matched(&execute_commands_hook_refs, cmd->ref_name, refname_full.buf)) {
+				cmd->exec_by_hook = 1;
+				seen_exec_by_hook = 1;
+			} else
+				seen_internal_exec = 1;
+		}
+
+		strbuf_release(&refname_full);
+	} else
+		seen_internal_exec = 1;
 
 	if (seen_exec_by_hook) {
 		/* Try to find and run the `execute-commands--pre-receive` hook to check
@@ -2085,6 +2112,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 	};
 
 	argv_array_init(&post_receive_env_array);
+	string_list_init(&execute_commands_hook_refs, 0);
 
 	packet_trace_identity("receive-pack");
 
diff --git a/t/t5411-execute-commands-hook.sh b/t/t5411-execute-commands-hook.sh
index 1907d0619d..c8ee699773 100755
--- a/t/t5411-execute-commands-hook.sh
+++ b/t/t5411-execute-commands-hook.sh
@@ -41,6 +41,9 @@ test_expect_success setup '
 	# Enable push options for bare.git.
 	git -C $bare config receive.advertisePushOptions true &&
 
+	# Register ref prefix for execute-commands hook.
+	git -C $bare config --add receive.executeCommandsHookRefs refs/for/ &&
+
 	git clone --no-local $bare work &&
 	create_commits_in work A B
 '
@@ -229,6 +232,67 @@ test_expect_success "push two special references" '
 	test_cmp expect actual
 '
 
+test_expect_success "push two special references, but one is not registered" '
+	(
+		cd work &&
+		git push origin \
+			HEAD:refs/for/maint/my/topic \
+			HEAD:refs/drafts/maint/my/topic
+	) >out 2>&1 &&
+	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
+	cat >expect <<-EOF &&
+	remote: execute: execute-commands
+	remote: >> pre-receive mode
+	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/maint/my/topic.
+	remote: execute: pre-receive hook
+	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/drafts/maint/my/topic.
+	remote: execute: execute-commands
+	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/maint/my/topic.
+	remote: execute: post-receive hook
+	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/maint/my/topic.
+	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/drafts/maint/my/topic.
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "restore bare.git, and register new ref prefix" '
+	(
+		cd $bare &&
+		git config --add receive.executeCommandsHookRefs refs/drafts/ &&
+		git update-ref -d refs/drafts/maint/my/topic &&
+		git show-ref
+	) >actual &&
+	cat >expect <<-EOF &&
+	102939797ab91a4f201d131418d2c9d919dcdd2c refs/heads/a/b/c
+	102939797ab91a4f201d131418d2c9d919dcdd2c refs/heads/maint
+	102939797ab91a4f201d131418d2c9d919dcdd2c refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "push to two special references (all registered)" '
+	(
+		cd work &&
+		git push origin \
+			HEAD:refs/for/master/my/topic \
+			HEAD:refs/drafts/maint/my/topic
+	) >out 2>&1 &&
+	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
+	cat >expect <<-EOF &&
+	remote: execute: execute-commands
+	remote: >> pre-receive mode
+	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/master/my/topic.
+	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/drafts/maint/my/topic.
+	remote: execute: execute-commands
+	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/master/my/topic.
+	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/drafts/maint/my/topic.
+	remote: execute: post-receive hook
+	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/master/my/topic.
+	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/drafts/maint/my/topic.
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success "new execute-commands hook (fail with error)" '
 	mv $bare/hooks/execute-commands $bare/hooks/execute-commands.ok &&
 	cat >$bare/hooks/execute-commands <<-EOF &&
@@ -322,21 +386,21 @@ test_expect_success "push mixed references successfully" '
 	(
 		cd work &&
 		git push origin \
-			HEAD:refs/for/maint/my/topic \
+			HEAD:refs/drafts/maint/my/topic \
 			HEAD:refs/heads/master
 	) >out 2>&1 &&
 	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
 	cat >expect <<-EOF &&
 	remote: execute: execute-commands
 	remote: >> pre-receive mode
-	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/maint/my/topic.
+	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/drafts/maint/my/topic.
 	remote: execute: pre-receive hook
 	remote: >> old: 102939797ab91a4f201d131418d2c9d919dcdd2c, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/heads/master.
 	remote: execute: execute-commands
-	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/maint/my/topic.
+	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/drafts/maint/my/topic.
 	remote: execute: post-receive hook
 	remote: >> old: 102939797ab91a4f201d131418d2c9d919dcdd2c, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/heads/master.
-	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/maint/my/topic.
+	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/drafts/maint/my/topic.
 	EOF
 	test_cmp expect actual
 '
-- 
2.25.1.362.g51ebf55b93

