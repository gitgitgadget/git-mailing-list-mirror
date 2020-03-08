Return-Path: <SRS0=m/qT=4Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7AAC10DCE
	for <git@archiver.kernel.org>; Sun,  8 Mar 2020 15:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B79ED206D7
	for <git@archiver.kernel.org>; Sun,  8 Mar 2020 15:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="scG8Atcl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgCHPiV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Mar 2020 11:38:21 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46197 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgCHPiV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Mar 2020 11:38:21 -0400
Received: by mail-pl1-f193.google.com with SMTP id w12so2955595pll.13
        for <git@vger.kernel.org>; Sun, 08 Mar 2020 08:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AuSuczbp7OAbcM+VS15c2HS1KScBgkjTZzdeNHBKt2I=;
        b=scG8AtclmBZIrH7hZF8q8GbehKbU9jYVYPK2Qwv7xqYLvHZ5/1kBisudjQkvpqMFpM
         MdKUX8IitMW0tFmZn8PwBNBSzgCqhmDc0EZfdB/iEmMdKh/ERZlbjKwj9Se8mqGpRzhZ
         vFeHJbVtboUlDF8SHchcZo4glHAztmm02uJPTnh7qs1I89vVpAQbPh4i3nwwDWhl/i+Q
         QotDdoBDD7Xk/qCk0ZEiI7t4OSENp+gWUimNV3M0iOk63qm9g3Gli3JIkZu+JanfozPG
         w1sqHg4ZrfdL9siKTdAkMKx/a7u1VqvovmQtc8nOyn5WOVSqZEpJmofrz6beERsC+m8u
         2hww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AuSuczbp7OAbcM+VS15c2HS1KScBgkjTZzdeNHBKt2I=;
        b=oSS8yatgBoh8M+KZCoKxUXgixsnSbK5OmdZmLFJW3BsbgM9a4D7MURy0YyG+iCI7pK
         rM60oP/G272IA0bGCRbRk1FDIjbrZHATUl86//smBu0ckh1PwMPG/qEcqY/z6qDGXKry
         5/SkgT/CayOdSEemNe5dTdgzZpK9HTLakuKHIaiC9+uCFzyqYhXo0oTZww4ZR1y7i0TX
         ww+o/mLfZOh6HaSurYYi0a99MeR8x0RNXWAypzWiQVcgXXS5JcR/KN1nJSrA3U2x87Iu
         FmUEVGK9ANIqVg06Nxt9IhwcmScgAMb91EqnXVs6SWJnGLC/djmJ2xNGAHmPpbwSA7dw
         32Zg==
X-Gm-Message-State: ANhLgQ2EKc1i7n92VXEUgGDHT4wY+xSOK3ghlxgJboPj0wv+bm02QcG/
        aXkFU1PWAI92lCoJJecvbWQ=
X-Google-Smtp-Source: ADFU+vuTny3inpH+BkBtHVluUYZAS2ilrT22+KyhZ38UFQUYJ9YagLJZk+0yZRYF7dYkaz9qoE73jA==
X-Received: by 2002:a17:902:b604:: with SMTP id b4mr11803341pls.340.1583681900031;
        Sun, 08 Mar 2020 08:38:20 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id a143sm18141508pfd.108.2020.03.08.08.38.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Mar 2020 08:38:19 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v2 3/5] receive-pack: new config receive.procReceiveRefs
Date:   Sun,  8 Mar 2020 11:38:14 -0400
Message-Id: <20200308153816.4690-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <CANYiYbE2V3bLfEgH-aRDv4Y5V+_BTZn-oUN7fOVpARm+_14BdQ@mail.gmail.com>
References: <CANYiYbE2V3bLfEgH-aRDv4Y5V+_BTZn-oUN7fOVpARm+_14BdQ@mail.gmail.com>
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
 builtin/receive-pack.c           |  49 ++++++--
 t/t5411-proc-receive-hook.sh     | 189 +++++++++++++++++++++++++++----
 3 files changed, 220 insertions(+), 32 deletions(-)

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
index 23d0c224d2..5aff682758 100644
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
 
@@ -1544,17 +1559,30 @@ static void execute_commands(struct command *commands,
 	/* Try to find commands that have special prefix in their reference names,
 	 * and mark them to run an external "proc-receive" hook later.
 	 */
-	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (!should_process_cmd(cmd))
-			continue;
+	if (proc_receive_refs.nr > 0) {
+		struct strbuf refname_full = STRBUF_INIT;
+		size_t prefix_len;
 
-		/* TODO: replace the fixed prefix by looking up git config variables. */
-		if (!strncmp(cmd->ref_name, "refs/for/", 9)) {
-			cmd->have_special_ref = 1;
-			have_special_ref = 1;
-		} else {
-			have_normal_ref = 1;
+		strbuf_addstr(&refname_full, get_git_namespace());
+		prefix_len = refname_full.len;
+
+		for (cmd = commands; cmd; cmd = cmd->next) {
+			if (!should_process_cmd(cmd))
+				continue;
+
+			strbuf_setlen(&refname_full, prefix_len);
+			strbuf_addstr(&refname_full, cmd->ref_name);
+			if (ref_is_matched(&proc_receive_refs, cmd->ref_name, refname_full.buf)) {
+				cmd->have_special_ref = 1;
+				have_special_ref = 1;
+			} else {
+				have_normal_ref = 1;
+			}
 		}
+
+		strbuf_release(&refname_full);
+	} else {
+		have_normal_ref = 1;
 	}
 
 	if (run_receive_hook(commands, "pre-receive", 0, push_options)) {
@@ -2011,6 +2039,8 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	string_list_init(&proc_receive_refs, 0);
+
 	packet_trace_identity("receive-pack");
 
 	argc = parse_options(argc, argv, prefix, options, receive_pack_usage, 0);
@@ -2126,5 +2156,6 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 	oid_array_clear(&shallow);
 	oid_array_clear(&ref);
 	free((void *)push_cert_nonce);
+	string_list_clear(&proc_receive_refs, 0);
 	return 0;
 }
diff --git a/t/t5411-proc-receive-hook.sh b/t/t5411-proc-receive-hook.sh
index 01f67965bf..e3bb421078 100755
--- a/t/t5411-proc-receive-hook.sh
+++ b/t/t5411-proc-receive-hook.sh
@@ -91,17 +91,77 @@ test_expect_success "(1) standard git-push command" '
 	(
 		cd work &&
 		git update-ref HEAD $A &&
-		git push origin HEAD HEAD:maint HEAD:a/b/c 2>&1
+		git push origin HEAD HEAD:maint 2>&1
 	) >out &&
 	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
 	cat >expect <<-EOF &&
 	remote: execute: pre-receive hook
 	remote: >> old: $ZERO_OID, new: $A, ref: refs/heads/master.
 	remote: >> old: $ZERO_OID, new: $A, ref: refs/heads/maint.
-	remote: >> old: $ZERO_OID, new: $A, ref: refs/heads/a/b/c.
 	remote: execute: post-receive hook
 	remote: >> old: $ZERO_OID, new: $A, ref: refs/heads/master.
 	remote: >> old: $ZERO_OID, new: $A, ref: refs/heads/maint.
+	EOF
+	test_cmp expect actual &&
+	(
+		cd $bare &&
+		git show-ref
+	) >actual &&
+	cat >expect <<-EOF &&
+	$A refs/heads/maint
+	$A refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "(1) push one special ref (create one)" '
+	(
+		cd work &&
+		git update-ref HEAD $B &&
+		git push origin HEAD:refs/for/master/my/topic
+	) >out 2>&1 &&
+	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
+	cat >expect <<-EOF &&
+	remote: execute: pre-receive hook
+	remote: >> old: $ZERO_OID, new: $B, ref: refs/for/master/my/topic.
+	remote: execute: post-receive hook
+	remote: >> old: $ZERO_OID, new: $B, ref: refs/for/master/my/topic.
+	EOF
+	test_cmp expect actual &&
+	(
+		cd $bare &&
+		git show-ref
+	) >actual &&
+	cat >expect <<-EOF &&
+	$B refs/for/master/my/topic
+	$A refs/heads/maint
+	$A refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "(1) cleanup" '
+	(
+		cd $bare &&
+		git update-ref -d refs/for/master/my/topic
+	)
+'
+
+test_expect_success "(2) add config to turn on proc-receive" '
+	git -C $bare config --add receive.procReceiveRefs refs/for/
+'
+
+test_expect_success "(2) standard git-push command" '
+	(
+		cd work &&
+		git update-ref HEAD $A &&
+		git push origin HEAD:a/b/c 2>&1
+	) >out &&
+	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
+	cat >expect <<-EOF &&
+	remote: execute: pre-receive hook
+	remote: >> old: $ZERO_OID, new: $A, ref: refs/heads/a/b/c.
+	remote: execute: post-receive hook
 	remote: >> old: $ZERO_OID, new: $A, ref: refs/heads/a/b/c.
 	EOF
 	test_cmp expect actual &&
@@ -117,7 +177,7 @@ test_expect_success "(1) standard git-push command" '
 	test_cmp expect actual
 '
 
-test_expect_success "(1) push one special ref" '
+test_expect_success "(2) push one special ref" '
 	(
 		cd work &&
 		git update-ref HEAD $B &&
@@ -145,9 +205,10 @@ test_expect_success "(1) push one special ref" '
 	test_cmp expect actual
 '
 
-test_expect_success "(1) push both a normal and a special refs" '
+test_expect_success "(2) push both a normal and a special refs" '
 	(
 		cd work &&
+		git update-ref HEAD $B &&
 		git push origin \
 			HEAD:refs/for/maint/my/topic \
 			HEAD:refs/heads/master
@@ -176,7 +237,7 @@ test_expect_success "(1) push both a normal and a special refs" '
 	test_cmp expect actual
 '
 
-test_expect_success "(1) cleanup" '
+test_expect_success "(2) cleanup" '
 	(
 		cd $bare &&
 		git update-ref refs/heads/master $A $B &&
@@ -190,11 +251,93 @@ test_expect_success "(1) cleanup" '
 	test_cmp expect actual
 '
 
-test_expect_success "(2) remove proc-receive hook" '
+test_expect_success "(2) push two special references (one is not registered)" '
+	(
+		cd work &&
+		git push origin \
+			HEAD:refs/for/maint/my/topic \
+			HEAD:refs/drafts/maint/my/topic
+	) >out 2>&1 &&
+	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
+	cat >expect <<-EOF &&
+	remote: execute: pre-receive hook
+	remote: >> old: $ZERO_OID, new: $B, ref: refs/for/maint/my/topic.
+	remote: >> old: $ZERO_OID, new: $B, ref: refs/drafts/maint/my/topic.
+	remote: execute: proc-receive hook
+	remote: >> old: $ZERO_OID, new: $B, ref: refs/for/maint/my/topic.
+	remote: execute: post-receive hook
+	remote: >> old: $ZERO_OID, new: $B, ref: refs/for/maint/my/topic.
+	remote: >> old: $ZERO_OID, new: $B, ref: refs/drafts/maint/my/topic.
+	EOF
+	test_cmp expect actual &&
+	(
+		cd $bare &&
+		git show-ref
+	) >actual &&
+	cat >expect <<-EOF &&
+	$B refs/drafts/maint/my/topic
+	$A refs/heads/a/b/c
+	$A refs/heads/maint
+	$A refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "(2) cleanup" '
+	(
+		cd $bare &&
+		git update-ref -d refs/drafts/maint/my/topic &&
+		git show-ref
+	) >actual &&
+	cat >expect <<-EOF &&
+	$A refs/heads/a/b/c
+	$A refs/heads/maint
+	$A refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "(2) register new ref prefix" '
+	git -C $bare config --add receive.procReceiveRefs refs/drafts/
+'
+
+test_expect_success "(2) push to two special references (all registered)" '
+	(
+		cd work &&
+		git push origin \
+			HEAD:refs/for/master/my/topic \
+			HEAD:refs/drafts/maint/my/topic
+	) >out 2>&1 &&
+	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
+	cat >expect <<-EOF &&
+	remote: execute: pre-receive hook
+	remote: >> old: $ZERO_OID, new: $B, ref: refs/for/master/my/topic.
+	remote: >> old: $ZERO_OID, new: $B, ref: refs/drafts/maint/my/topic.
+	remote: execute: proc-receive hook
+	remote: >> old: $ZERO_OID, new: $B, ref: refs/for/master/my/topic.
+	remote: >> old: $ZERO_OID, new: $B, ref: refs/drafts/maint/my/topic.
+	remote: execute: post-receive hook
+	remote: >> old: $ZERO_OID, new: $B, ref: refs/for/master/my/topic.
+	remote: >> old: $ZERO_OID, new: $B, ref: refs/drafts/maint/my/topic.
+	EOF
+	test_cmp expect actual &&
+	(
+		cd $bare &&
+		git show-ref
+	) >actual &&
+	cat >expect <<-EOF &&
+	$A refs/heads/a/b/c
+	$A refs/heads/maint
+	$A refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "(3) remove proc-receive hook" '
 	mv $bare/hooks/proc-receive $bare/hooks/proc-receive.ok
 '
 
-test_expect_success "(2) standard git-push command" '
+test_expect_success "(3) standard git-push command" '
 	(
 		cd work &&
 		git update-ref HEAD $B &&
@@ -220,7 +363,7 @@ test_expect_success "(2) standard git-push command" '
 	test_cmp expect actual
 '
 
-test_expect_success "(2) cleanup" '
+test_expect_success "(3) cleanup" '
 	(
 		cd $bare &&
 		git update-ref refs/heads/master $A $B &&
@@ -234,7 +377,7 @@ test_expect_success "(2) cleanup" '
 	test_cmp expect actual
 '
 
-test_expect_success "(2) push one special ref (failed)" '
+test_expect_success "(3) push one special ref (failed)" '
 	(
 		cd work &&
 		git update-ref HEAD $B &&
@@ -249,7 +392,7 @@ test_expect_success "(2) push one special ref (failed)" '
 	test_cmp expect actual
 '
 
-test_expect_success "(2) push both a normal and a special refs (one failed)" '
+test_expect_success "(3) push both a normal and a special refs (one failed)" '
 	(
 		cd work &&
 		git update-ref HEAD $B &&
@@ -279,7 +422,7 @@ test_expect_success "(2) push both a normal and a special refs (one failed)" '
 	test_cmp expect actual
 '
 
-test_expect_success "(2) cleanup" '
+test_expect_success "(3) cleanup" '
 	(
 		cd $bare &&
 		git update-ref refs/heads/master $A $B &&
@@ -293,7 +436,7 @@ test_expect_success "(2) cleanup" '
 	test_cmp expect actual
 '
 
-test_expect_success "(2) atomic push both a normal and a special refs (failed)" '
+test_expect_success "(3) atomic push both a normal and a special refs (failed)" '
 	(
 		cd work &&
 		git update-ref HEAD $B &&
@@ -321,7 +464,7 @@ test_expect_success "(2) atomic push both a normal and a special refs (failed)"
 	test_cmp expect actual
 '
 
-test_expect_success "(3) new proc-receive hook (return error)" '
+test_expect_success "(4) new proc-receive hook (return error)" '
 	cat >$bare/hooks/proc-receive <<-EOF &&
 	#!/bin/sh
 
@@ -338,7 +481,7 @@ test_expect_success "(3) new proc-receive hook (return error)" '
 	chmod a+x $bare/hooks/proc-receive
 '
 
-test_expect_success "(3) standard git-push command" '
+test_expect_success "(4) standard git-push command" '
 	(
 		cd work &&
 		git update-ref HEAD $B &&
@@ -364,7 +507,7 @@ test_expect_success "(3) standard git-push command" '
 	test_cmp expect actual
 '
 
-test_expect_success "(3) cleanup" '
+test_expect_success "(4) cleanup" '
 	(
 		cd $bare &&
 		git update-ref refs/heads/master $A $B &&
@@ -378,7 +521,7 @@ test_expect_success "(3) cleanup" '
 	test_cmp expect actual
 '
 
-test_expect_success "(3) push both a normal and a special refs (one failed)" '
+test_expect_success "(4) push both a normal and a special refs (one failed)" '
 	(
 		cd work &&
 		git update-ref HEAD $B &&
@@ -410,7 +553,7 @@ test_expect_success "(3) push both a normal and a special refs (one failed)" '
 	test_cmp expect actual
 '
 
-test_expect_success "(3) cleanup" '
+test_expect_success "(4) cleanup" '
 	(
 		cd $bare &&
 		git update-ref refs/heads/master $A $B &&
@@ -424,7 +567,7 @@ test_expect_success "(3) cleanup" '
 	test_cmp expect actual
 '
 
-test_expect_success "(3) atomic push a normal and a special refs (failed)" '
+test_expect_success "(4) atomic push a normal and a special refs (failed)" '
 	(
 		cd work &&
 		git update-ref HEAD $B &&
@@ -454,12 +597,12 @@ test_expect_success "(3) atomic push a normal and a special refs (failed)" '
 	test_cmp expect actual
 '
 
-test_expect_success "(4) restore proc-receive hook" '
+test_expect_success "(5) restore proc-receive hook" '
 	mv $bare/hooks/proc-receive $bare/hooks/proc-receive.fail &&
 	mv $bare/hooks/proc-receive.ok $bare/hooks/proc-receive
 '
 
-test_expect_success "(4) push two special references" '
+test_expect_success "(5) push two special references" '
 	(
 		cd work &&
 		git update-ref HEAD $B &&
@@ -492,7 +635,7 @@ test_expect_success "(4) push two special references" '
 	test_cmp expect actual
 '
 
-test_expect_success "(5) new pre-receive hook hook (return error)" '
+test_expect_success "(6) new pre-receive hook hook (return error)" '
 	mv $bare/hooks/pre-receive $bare/hooks/pre-receive.ok &&
 	cat >$bare/hooks/pre-receive <<-EOF &&
 	#!/bin/sh
@@ -510,7 +653,7 @@ test_expect_success "(5) new pre-receive hook hook (return error)" '
 	chmod a+x $bare/hooks/pre-receive
 '
 
-test_expect_success "(5) push two special references (declined)" '
+test_expect_success "(6) push two special references (declined)" '
 	(
 		cd work &&
 		test_must_fail git push origin \
@@ -527,7 +670,7 @@ test_expect_success "(5) push two special references (declined)" '
 	test_cmp expect actual
 '
 
-test_expect_success "(5) push both a normal and a special refs (declined)" '
+test_expect_success "(6) push both a normal and a special refs (declined)" '
 	(
 		cd work &&
 		test_must_fail git push origin \
-- 
2.26.0.rc0.5.gb02b988a14.dirty

