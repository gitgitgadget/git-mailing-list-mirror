Return-Path: <SRS0=NddV=BZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863D2C433E4
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 22:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ADF32053B
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 22:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZ5PlISn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbgHOWCT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728736AbgHOVvZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:25 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE68C00214C
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 10:17:56 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p37so6008584pgl.3
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 10:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nsNf4QL1oWA7gvZJamVcHudSK0xhS9L24ksYmbdXjVs=;
        b=HZ5PlISnhFfmVAYHFpMEd/wtid1ByoWJYHiCZX+Dg6eTz7ClcxZFoz11A2P3mXVSkF
         psNtEmtuTEey/AGU1ixgBmq4ePtxpwCa8lRmFgYV+fjz9fz3iu2/ImLX/TmVJcKHsfFR
         OT0RSh6RjeSKKTLmnqGczs/s6kgk0gwxuTlP6GrlM23a7D9arUIqQ/zxKLlFgTUxpddX
         4cjc1rxjBnqi3AO4u7/cfq0LilbyvhF1CqOBLTxxAsuZ517bmi9rlM74r2KHwkrE9gY9
         DCpVeVBjbM6C3eLiGw8CuFedJB/SloKhri4iiVUQF9xMkXzHHOclJIoJU3q88TKO4Yta
         0N0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nsNf4QL1oWA7gvZJamVcHudSK0xhS9L24ksYmbdXjVs=;
        b=dtq70XPMTJyY6nlMkajHX+glXXDt1uec4v6mjrmuimg/4r198/Az7iiQg1RzC8BWyT
         hksa6NsRp9EbleN+gMxQRJyk2/1W27lqCtnnFVMQQV8d2i8NgeIyjrahVBFlj8JDvZ7v
         FSG/90YvcRbd1KuAUYwBu1xVbmP98y2k+iytzKj0V5OQwSHF46cOUT8Oqmz6Hh6+nIhW
         RuPSox2itwe7OKyr/daE+Iy6GqPYazvAMzgVeS3gDbxV5qMtrSghGiEYbMIbIK7NaZdM
         agAY9Q9LI0AMvmpHCMQstA8krh/3V2n7PiILEyX86eH/+bs3qT8tiRzR+UfwEmVhGzRM
         P9WQ==
X-Gm-Message-State: AOAM532IaOP1Q4pcUTLv73sErznWqtYkVYd5UQVfFmfs15shQXxm5Bxg
        z4+IGsXfopC8gxIrLXNOuhw=
X-Google-Smtp-Source: ABdhPJxjwAyyUM1X9BZ0y+7NdxDEAu2m1XV0l+FAQdE1dFf0JHgDbi73HlCvS302Zo/C6MOKLSzhWA==
X-Received: by 2002:aa7:9f10:: with SMTP id g16mr5754069pfr.148.1597511875402;
        Sat, 15 Aug 2020 10:17:55 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id x13sm11040596pga.30.2020.08.15.10.17.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Aug 2020 10:17:54 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v17 07/10] receive-pack: new config receive.procReceiveRefs
Date:   Sat, 15 Aug 2020 13:17:37 -0400
Message-Id: <20200815171740.6257-8-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200518094039.757-1-worldhello.net@gmail.com>
References: <20200518094039.757-1-worldhello.net@gmail.com>
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

Optional modifiers can be provided in the beginning of value of the
config variable to filter commands for specific actions: create (a),
mofify (m), delete (d). E.g.:

    git config --system --add receive.procReceiveRefs ad:refs/heads

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 Documentation/config/receive.txt              |  19 +++
 builtin/receive-pack.c                        | 110 ++++++++++++++-
 t/t5411/once-0010-report-status-v1.sh         |   4 +
 t/t5411/test-0010-proc-receive-settings.sh    |   7 +
 t/t5411/test-0040-process-all-refs.sh         | 113 ++++++++++++++++
 .../test-0041-process-all-refs--porcelain.sh  | 114 ++++++++++++++++
 t/t5411/test-0050-proc-receive-refs.sh        | 128 ++++++++++++++++++
 7 files changed, 488 insertions(+), 7 deletions(-)
 create mode 100644 t/t5411/test-0010-proc-receive-settings.sh
 create mode 100644 t/t5411/test-0040-process-all-refs.sh
 create mode 100644 t/t5411/test-0041-process-all-refs--porcelain.sh
 create mode 100644 t/t5411/test-0050-proc-receive-refs.sh

diff --git a/Documentation/config/receive.txt b/Documentation/config/receive.txt
index 65f78aac37..7f1a1bd00c 100644
--- a/Documentation/config/receive.txt
+++ b/Documentation/config/receive.txt
@@ -114,6 +114,25 @@ receive.hideRefs::
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
+commands for specific actions: create (a), mofify (m), delete (d). E.g.:
++
+	git config --system --add receive.procReceiveRefs ad:refs/heads
+ 
 receive.updateServerInfo::
 	If set to true, git-receive-pack will run git-update-server-info
 	after receiving data from git-push and updating refs.
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index a687218167..b7e4ee1483 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -98,6 +98,16 @@ static int keepalive_in_sec = 5;
 
 static struct tmp_objdir *tmp_objdir;
 
+static struct proc_receive_ref {
+	unsigned int want_add:1,
+		     want_delete:1,
+		     want_modify:1;
+	char *ref_prefix;
+	struct proc_receive_ref *next;
+} *proc_receive_ref = NULL;
+
+static void proc_receive_ref_append(const char *prefix);
+
 static enum deny_action parse_deny_action(const char *var, const char *value)
 {
 	if (value) {
@@ -230,6 +240,13 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
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
 
@@ -325,6 +342,84 @@ struct command {
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
+			prefix++;
+		}
+		prefix++;
+	} else {
+		ref_pattern->want_add = 1;
+		ref_pattern->want_delete = 1;
+		ref_pattern->want_modify = 1;
+	}
+	ref_pattern->next = NULL;
+	ref_pattern->ref_prefix = xstrdup(prefix);
+	len = strlen(ref_pattern->ref_prefix);
+	while (len && ref_pattern->ref_prefix[len - 1] == '/')
+		ref_pattern->ref_prefix[--len] = '\0';
+	if (proc_receive_ref == NULL) {
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
+		int neg = 0;
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
+		if (*match == '!') {
+			neg = 1;
+			match++;
+		}
+
+		if (skip_prefix(cmd->ref_name, match, &remains) &&
+		    (!*remains || *remains == '/')) {
+			if (!neg)
+				return 1;
+		} else if (neg) {
+			return 1;
+		}
+	}
+	return 0;
+}
+
 static void rp_error(const char *err, ...) __attribute__((format (printf, 1, 2)));
 static void rp_warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
 
@@ -1812,14 +1907,15 @@ static void execute_commands(struct command *commands,
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
diff --git a/t/t5411/test-0050-proc-receive-refs.sh b/t/t5411/test-0050-proc-receive-refs.sh
new file mode 100644
index 0000000000..50d4f159f8
--- /dev/null
+++ b/t/t5411/test-0050-proc-receive-refs.sh
@@ -0,0 +1,128 @@
+test_expect_success "config receive.procReceiveRefs with modifiers ($PROTOCOL)" '
+	(
+		cd "$upstream" &&
+		git config --unset-all receive.procReceiveRefs &&
+		git config --add receive.procReceiveRefs m:refs/heads/master &&
+		git config --add receive.procReceiveRefs ad:refs/heads &&
+		git config --add receive.procReceiveRefs "a:!refs/heads"
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
+	git -C "$upstream" update-ref refs/tags/v123 $TAG &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
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
+# Refs of upstream : master(A)  tags/v123
+# Refs of workbench: master(A)  tags/v123
+# git push         : NULL       NULL       next(A)
+test_expect_success "proc-receive: create/delete branch, and delete tag ($PROTOCOL)" '
+	git -C workbench push origin \
+		:refs/heads/master \
+		$A:refs/heads/next \
+		:refs/tags/v123 >out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <COMMIT-A> <ZERO-OID> refs/heads/master
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
+	remote: post-receive< <TAG-v123> <ZERO-OID> refs/tags/v123
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/pull/124/head
+	To <URL/of/upstream.git>
+	 - [deleted] refs/pull/123/head
+	 - [deleted] v123
+	 * [new reference] <COMMIT-A> -> refs/pull/124/head
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
-- 
2.28.0

