Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9838C433DF
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 15:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A286D2087D
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 15:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWrZQMZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgH0PqN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbgH0PqE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 11:46:04 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A177AC061233
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 08:46:03 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mt12so2831927pjb.4
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 08:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oWhnpWxHOvDJ2yAWDhi4DEY+l0OlUHRcu25dGx3/zmI=;
        b=OWrZQMZZndhjGVdau9qW1GrPJtowe0DwbKpJSqSUREybnTmerCQPPXTiJE/iHYw2vS
         8YPhyOUkwERVuNINBs0KF4EEfmLMdpDkMyNebsHQZtpQyIxe4NYoxGKdQeCNYwvq0+x8
         B2enA2JxbwhCFbzEfPJrHdoOPJ5NxpzB8xSy9NoSc3b5Ssu3/K8SRc6TGUqcJcra9N78
         s4866rrFC8hUOfjPeART9gpSDh22l5dePL2wqTLBGcRcodoQts39k/ByKR4zLdBPqHA/
         21NO/DzNQwinEx1mpVq4+wVQhsuBRNU23gfTex7tbwFyhRTP+K3JC6qkHIdwoYgacns9
         vTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oWhnpWxHOvDJ2yAWDhi4DEY+l0OlUHRcu25dGx3/zmI=;
        b=AlIrtFbAAjo/gm8G5ksWvX1YOrfMCLnMxwYTqrEsbKeWbZtjmx5Gon5R1Typ3IpJvF
         +41pn9AfQgv8tWJipM6wIFwI1ayQ4u/3UUfdVYLTtkvHqQ40jRY8WBueJCjn+W7jvPj3
         e21ZMFjfMYCA3rLBoq5DB7e3dtT/RY2KLZIL0BcWBhIC/mjbrbVivmd96oDz2JX0kU1U
         63D2QelkY8z0RPl8W/dJ4nS+IjuAHfyN8nfLSPOImJcLyfhvZPQTMoUPFRTKrh1RuQhX
         t1T3RqP4/zD89/HWX8AHxAMoq+fWPldVD6JKnrPkibqdoW/RLun5rZZ1UzXQZK/D1d8u
         TyLg==
X-Gm-Message-State: AOAM533n7M7BUtu8/ECcnZ9FUHrh+kP5nZ35ltEVGw0l3wFnTN24cujI
        WgcTKo+ntYSoBxbEeUYfPdii/S+a/RLQBg==
X-Google-Smtp-Source: ABdhPJy8POe5YuN14nmlQubR+ZWPLR/+GwSFJL+W6yKW8AV846LFkrveYREOl9YhRiiTEagnE8c3Tw==
X-Received: by 2002:a17:90a:5791:: with SMTP id g17mr11476940pji.77.1598543163039;
        Thu, 27 Aug 2020 08:46:03 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id x5sm3129218pfj.1.2020.08.27.08.46.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 08:46:02 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v19 07/10] receive-pack: new config receive.procReceiveRefs
Date:   Thu, 27 Aug 2020 11:45:48 -0400
Message-Id: <20200827154551.5966-8-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200824174202.11710-1-worldhello.net@gmail.com>
References: <20200824174202.11710-1-worldhello.net@gmail.com>
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

If the specific prefix strings given by the config variables match the
reference names of the commands which are sent from git client to
`receive-pack`, these commands will be executed by an external hook
(named "proc-receive"), instead of the internal `execute_commands`
function.

For example, if it is set to "refs/for", pushing to a reference such as
"refs/for/master" will not create or update reference "refs/for/master",
but may create or update a pull request directly by running the hook
"proc-receive".

Optional modifiers can be provided in the beginning of the value to
filter commands for specific actions: create (a), modify (m),
delete (d). A `!` can be included in the modifiers to negate the
reference prefix entry. E.g.:

    git config --system --add receive.procReceiveRefs ad:refs/heads
    git config --system --add receive.procReceiveRefs !:refs/heads

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 Documentation/config/receive.txt              |  22 +++
 builtin/receive-pack.c                        | 106 +++++++++++++-
 t/t5411/once-0010-report-status-v1.sh         |   4 +
 t/t5411/test-0010-proc-receive-settings.sh    |   7 +
 t/t5411/test-0040-process-all-refs.sh         | 113 +++++++++++++++
 .../test-0041-process-all-refs--porcelain.sh  | 114 +++++++++++++++
 ...t-0050-proc-receive-refs-with-modifiers.sh | 135 ++++++++++++++++++
 7 files changed, 494 insertions(+), 7 deletions(-)
 create mode 100644 t/t5411/test-0010-proc-receive-settings.sh
 create mode 100644 t/t5411/test-0040-process-all-refs.sh
 create mode 100644 t/t5411/test-0041-process-all-refs--porcelain.sh
 create mode 100644 t/t5411/test-0050-proc-receive-refs-with-modifiers.sh

diff --git a/Documentation/config/receive.txt b/Documentation/config/receive.txt
index 65f78aac37..85d5b5a3d2 100644
--- a/Documentation/config/receive.txt
+++ b/Documentation/config/receive.txt
@@ -114,6 +114,28 @@ receive.hideRefs::
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
++
+For example, if this variable is set to "refs/for", pushing to reference
+such as "refs/for/master" will not create or update a reference named
+"refs/for/master", but may create or update a pull request directly by
+running the hook "proc-receive".
++
+Optional modifiers can be provided in the beginning of the value to filter
+commands for specific actions: create (a), modify (m), delete (d).
+A `!` can be included in the modifiers to negate the reference prefix entry.
+E.g.:
++
+	git config --system --add receive.procReceiveRefs ad:refs/heads
+	git config --system --add receive.procReceiveRefs !:refs/heads
+
 receive.updateServerInfo::
 	If set to true, git-receive-pack will run git-update-server-info
 	after receiving data from git-push and updating refs.
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e3dfb17ad4..bb9909c52e 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -98,6 +98,17 @@ static int keepalive_in_sec = 5;
 
 static struct tmp_objdir *tmp_objdir;
 
+static struct proc_receive_ref {
+	unsigned int want_add:1,
+		     want_delete:1,
+		     want_modify:1,
+		     negative_ref:1;
+	char *ref_prefix;
+	struct proc_receive_ref *next;
+} *proc_receive_ref;
+
+static void proc_receive_ref_append(const char *prefix);
+
 static enum deny_action parse_deny_action(const char *var, const char *value)
 {
 	if (value) {
@@ -230,6 +241,13 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (strcmp(var, "receive.procreceiverefs") == 0) {
+		if (!value)
+			return config_error_nonbool(var);
+		proc_receive_ref_append(value);
+		return 0;
+	}
+
 	return git_default_config(var, value, cb);
 }
 
@@ -326,6 +344,79 @@ struct command {
 	char ref_name[FLEX_ARRAY]; /* more */
 };
 
+static void proc_receive_ref_append(const char *prefix)
+{
+	struct proc_receive_ref *ref_pattern;
+	char *p;
+	int len;
+
+	ref_pattern = xcalloc(1, sizeof(struct proc_receive_ref));
+	p = strchr(prefix, ':');
+	if (p) {
+		while (prefix < p) {
+			if (*prefix == 'a')
+				ref_pattern->want_add = 1;
+			else if (*prefix == 'd')
+				ref_pattern->want_delete = 1;
+			else if (*prefix == 'm')
+				ref_pattern->want_modify = 1;
+			else if (*prefix == '!')
+				ref_pattern->negative_ref = 1;
+			prefix++;
+		}
+		prefix++;
+	} else {
+		ref_pattern->want_add = 1;
+		ref_pattern->want_delete = 1;
+		ref_pattern->want_modify = 1;
+	}
+	len = strlen(prefix);
+	while (len && prefix[len - 1] == '/')
+		len--;
+	ref_pattern->ref_prefix = xmemdupz(prefix, len);
+	if (!proc_receive_ref) {
+		proc_receive_ref = ref_pattern;
+	} else {
+		struct proc_receive_ref *end;
+
+		end = proc_receive_ref;
+		while (end->next)
+			end = end->next;
+		end->next = ref_pattern;
+	}
+}
+
+static int proc_receive_ref_matches(struct command *cmd)
+{
+	struct proc_receive_ref *p;
+
+	if (!proc_receive_ref)
+		return 0;
+
+	for (p = proc_receive_ref; p; p = p->next) {
+		const char *match = p->ref_prefix;
+		const char *remains;
+
+		if (!p->want_add && is_null_oid(&cmd->old_oid))
+			continue;
+		else if (!p->want_delete && is_null_oid(&cmd->new_oid))
+			continue;
+		else if (!p->want_modify &&
+			 !is_null_oid(&cmd->old_oid) &&
+			 !is_null_oid(&cmd->new_oid))
+			continue;
+
+		if (skip_prefix(cmd->ref_name, match, &remains) &&
+		    (!*remains || *remains == '/')) {
+			if (!p->negative_ref)
+				return 1;
+		} else if (p->negative_ref) {
+			return 1;
+		}
+	}
+	return 0;
+}
+
 static void rp_error(const char *err, ...) __attribute__((format (printf, 1, 2)));
 static void rp_warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
 
@@ -1814,14 +1905,15 @@ static void execute_commands(struct command *commands,
 	 * Try to find commands that have special prefix in their reference names,
 	 * and mark them to run an external "proc-receive" hook later.
 	 */
-	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (!should_process_cmd(cmd))
-			continue;
+	if (proc_receive_ref) {
+		for (cmd = commands; cmd; cmd = cmd->next) {
+			if (!should_process_cmd(cmd))
+				continue;
 
-		/* TODO: replace the fixed prefix by looking up git config variables. */
-		if (!strncmp(cmd->ref_name, "refs/for/", 9)) {
-			cmd->run_proc_receive = RUN_PROC_RECEIVE_SCHEDULED;
-			run_proc_receive = 1;
+			if (proc_receive_ref_matches(cmd)) {
+				cmd->run_proc_receive = RUN_PROC_RECEIVE_SCHEDULED;
+				run_proc_receive = 1;
+			}
 		}
 	}
 
diff --git a/t/t5411/once-0010-report-status-v1.sh b/t/t5411/once-0010-report-status-v1.sh
index bf410dc418..dc2cf4a522 100644
--- a/t/t5411/once-0010-report-status-v1.sh
+++ b/t/t5411/once-0010-report-status-v1.sh
@@ -1,3 +1,7 @@
+test_expect_success "setup receive.procReceiveRefs" '
+	git -C "$upstream" config --add receive.procReceiveRefs refs/for
+'
+
 test_expect_success "setup proc-receive hook" '
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
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
index 0000000000..0dd9824616
--- /dev/null
+++ b/t/t5411/test-0041-process-all-refs--porcelain.sh
@@ -0,0 +1,114 @@
+test_expect_success "config receive.procReceiveRefs = refs ($PROTOCOL/porcelain)" '
+	git -C "$upstream" config --unset-all receive.procReceiveRefs &&
+	git -C "$upstream" config --add receive.procReceiveRefs refs
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+test_expect_success "setup upstream branches ($PROTOCOL/porcelain)" '
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
+test_expect_success "setup proc-receive hook ($PROTOCOL/porcelain)" '
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
+test_expect_success "cleanup ($PROTOCOL/porcelain)" '
+	(
+		cd "$upstream" &&
+		git update-ref -d refs/heads/bar &&
+		git update-ref -d refs/heads/baz
+	)
+'
diff --git a/t/t5411/test-0050-proc-receive-refs-with-modifiers.sh b/t/t5411/test-0050-proc-receive-refs-with-modifiers.sh
new file mode 100644
index 0000000000..c22849cbe2
--- /dev/null
+++ b/t/t5411/test-0050-proc-receive-refs-with-modifiers.sh
@@ -0,0 +1,135 @@
+test_expect_success "config receive.procReceiveRefs with modifiers ($PROTOCOL)" '
+	(
+		cd "$upstream" &&
+		git config --unset-all receive.procReceiveRefs &&
+		git config --add receive.procReceiveRefs m:refs/heads/master &&
+		git config --add receive.procReceiveRefs ad:refs/heads &&
+		git config --add receive.procReceiveRefs "a!:refs/heads"
+	)
+'
+
+test_expect_success "setup proc-receive hook ($PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/heads/master" \
+		-r "option refname refs/pull/123/head" \
+		-r "option old-oid $A" \
+		-r "option new-oid $B" \
+		-r "ok refs/tags/v123 " \
+		-r "option refname refs/pull/124/head"
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         : master(B)  tags/v123
+test_expect_success "proc-receive: update branch and new tag ($PROTOCOL)" '
+	git -C workbench push origin \
+		$B:refs/heads/master \
+		v123 >out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
+	remote: pre-receive< <ZERO-OID> <TAG-v123> refs/tags/v123
+	remote: # proc-receive hook
+	remote: proc-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
+	remote: proc-receive< <ZERO-OID> <TAG-v123> refs/tags/v123
+	remote: proc-receive> ok refs/heads/master
+	remote: proc-receive> option refname refs/pull/123/head
+	remote: proc-receive> option old-oid <COMMIT-A>
+	remote: proc-receive> option new-oid <COMMIT-B>
+	remote: proc-receive> ok refs/tags/v123
+	remote: proc-receive> option refname refs/pull/124/head
+	remote: # post-receive hook
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/pull/123/head
+	remote: post-receive< <ZERO-OID> <TAG-v123> refs/pull/124/head
+	To <URL/of/upstream.git>
+	 <OID-A>..<OID-B> <COMMIT-B> -> refs/pull/123/head
+	 * [new reference] v123 -> refs/pull/124/head
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
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+test_expect_success "setup upstream: create tags/v123 ($PROTOCOL)" '
+	git -C "$upstream" update-ref refs/heads/topic $A &&
+	git -C "$upstream" update-ref refs/tags/v123 $TAG &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/topic
+	<TAG-v123> refs/tags/v123
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook ($PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/heads/master" \
+		-r "option refname refs/pull/123/head" \
+		-r "option old-oid $A" \
+		-r "option new-oid $ZERO_OID" \
+		-r "ok refs/heads/next" \
+		-r "option refname refs/pull/124/head" \
+		-r "option new-oid $A"
+	EOF
+'
+
+# Refs of upstream : master(A)  topic(A)  tags/v123
+# Refs of workbench: master(A)            tags/v123
+# git push         : NULL       topic(B)  NULL       next(A)
+test_expect_success "proc-receive: create/delete branch, and delete tag ($PROTOCOL)" '
+	git -C workbench push origin \
+		:refs/heads/master \
+		$B:refs/heads/topic \
+		$A:refs/heads/next \
+		:refs/tags/v123 >out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <COMMIT-A> <ZERO-OID> refs/heads/master
+	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/topic
+	remote: pre-receive< <TAG-v123> <ZERO-OID> refs/tags/v123
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
+	remote: # proc-receive hook
+	remote: proc-receive< <COMMIT-A> <ZERO-OID> refs/heads/master
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
+	remote: proc-receive> ok refs/heads/master
+	remote: proc-receive> option refname refs/pull/123/head
+	remote: proc-receive> option old-oid <COMMIT-A>
+	remote: proc-receive> option new-oid <ZERO-OID>
+	remote: proc-receive> ok refs/heads/next
+	remote: proc-receive> option refname refs/pull/124/head
+	remote: proc-receive> option new-oid <COMMIT-A>
+	remote: # post-receive hook
+	remote: post-receive< <COMMIT-A> <ZERO-OID> refs/pull/123/head
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/topic
+	remote: post-receive< <TAG-v123> <ZERO-OID> refs/tags/v123
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/pull/124/head
+	To <URL/of/upstream.git>
+	 - [deleted] refs/pull/123/head
+	 <OID-A>..<OID-B> <COMMIT-B> -> topic
+	 - [deleted] v123
+	 * [new reference] <COMMIT-A> -> refs/pull/124/head
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	<COMMIT-B> refs/heads/topic
+	EOF
+	test_cmp expect actual
+'
-- 
2.26.2.543.g44b58e439b

