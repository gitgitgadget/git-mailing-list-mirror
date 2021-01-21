Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF229C433E9
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 03:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 678D0238E4
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 03:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732098AbhAUDsF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 22:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393391AbhAUCyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 21:54:16 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2864DC0613C1
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 18:53:36 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 15so426684pgx.7
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 18:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7KR20ESIN9u24oJh8omwKi+kmAfd1U++oKp37Cve45o=;
        b=C6Keufg8PQmYbuWbYruSBTXX2FnQrFCfGn3PUm9WO+a590WRZ4/wltAwOs+K7Ufc37
         vOir3+CHl0jKGGidWxODAHa8TfN6nOcDy2u26bVV30QI4SWCAwiAM7Bm4p2dNs39zSrC
         Chjv3JMn7ABk/GRzH4DmEg3PhWU6Z5qLt3frVOqhi4tA0bstF4mc2hZrUTZ0BxChW53I
         IVjYxWFoz8OA43oPduXYdf5UnXKr6AUd3yTkn3928d2JVG869EGJAblP/+HBit0T56Vu
         /m9msMAWOF77PZqn0IehW4k0cCFvvkKBBnUHTnihIV1l75AEJIwKM3psVmgVVlZfJthT
         SSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7KR20ESIN9u24oJh8omwKi+kmAfd1U++oKp37Cve45o=;
        b=LEv6D6cdkJ+GVrXEqVo7WXNX/h+GJkf6XV8g5th4LxD8MPxPL2lEKT1bOqIeFs2kzy
         uLogpYo12k9+PdWfndN3LzIe1mG6AoliJLIOaSydMKcfD7TIJ/bJDIFjKXuaiRilgPX3
         V0RCHlMYXfSMVCV+7UhNmRpqklf/iWZjX83rTxgunP9eVS/3Bn0gaFjECRRpYUiKKDls
         en/CuIpvBM9+DE11jEQs+DCMOTwtlyjTZQNkMNYlhFFejlwZCjMQUmeg0sPRLArl1M+B
         7vZWsz8i+Bn8yU8G4A3i4auVTFeVEli3841hSfBgDjKvv0X5NrfNp69O4/dHKBNtfXoN
         ppOw==
X-Gm-Message-State: AOAM532XkAn9c0mVp4r87hw4GS2MDe9anc9VgMuD9MGzjqiQLuBFwdNV
        hedGs88Gp2Aq9dNH43r+WwY=
X-Google-Smtp-Source: ABdhPJwurlvNhPmMucwjeVL3j4OvvC3NYYQKXHKxTFsAnFjc80pZTQl3cTR6lM9yt9Pt4iBTtVcTqQ==
X-Received: by 2002:a63:5a01:: with SMTP id o1mr12529916pgb.407.1611197615477;
        Wed, 20 Jan 2021 18:53:35 -0800 (PST)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id y10sm3561624pff.197.2021.01.20.18.53.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jan 2021 18:53:34 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v3 1/2] t5411: use different out file to prevent overwriting
Date:   Wed, 20 Jan 2021 21:53:30 -0500
Message-Id: <20210121025331.21658-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20210120124906.GA8396@szeder.dev>
References: <20210120124906.GA8396@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

SZEDER reported that t5411 failed in Travis CI's s390x environment a
couple of times, and could be reproduced with '--stress' test on this
specific environment.  The test failure messages might look like this:

    + test_cmp expect actual
    --- expect      2021-01-17 21:55:23.430750004 +0000
    +++ actual      2021-01-17 21:55:23.430750004 +0000
    @@ -1 +1 @@
    -<COMMIT-A> refs/heads/main
    +<COMMIT-A> refs/heads/maifatal: the remote end hung up unexpectedly
    error: last command exited with $?=1
    not ok 86 - proc-receive: not support push options (builtin protocol)

The file 'actual' is filtered from the file 'out' which contains result
of 'git show-ref' command.  Due to the error messages from other process
is written into the file 'out' accidentally, t5411 failed.  SZEDER finds
the root cause of this issue:

 - 'git push' is executed with its standard output and error redirected
   to the file 'out'.

 - 'git push' executes 'git receive-pack' internally, which inherits
   the open file descriptors, so its output and error goes into that
   same 'out' file.

 - 'git push' ends without waiting for the close of 'git-receive-pack'
   for some cases, and the file 'out' is reused for test of
   'git show-ref' afterwards.

 - A mixture of the output of 'git show-ref' abd 'git receive-pack'
   leads to this issue.

The first intuitive reaction to resolve this issue is to remove the
file 'out' after use, so that the newly created file 'out' will have a
different file descriptor and will not be overwritten by the
'git receive-pack' process.  But Johannes pointed out that removing an
open file is not possible on Windows.  So we use different temporary
file names to store the output of 'git push' to solve this issue.

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Helped-by: Johannes Sixt <j6t@kdbg.org>
Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t5411/test-0000-standard-git-push.sh        |  8 +--
 .../test-0001-standard-git-push--porcelain.sh |  8 +--
 t/t5411/test-0002-pre-receive-declined.sh     |  4 +-
 ...st-0003-pre-receive-declined--porcelain.sh |  4 +-
 t/t5411/test-0011-no-hook-error.sh            |  8 +--
 t/t5411/test-0012-no-hook-error--porcelain.sh |  8 +--
 t/t5411/test-0013-bad-protocol.sh             | 50 +++++++++----------
 t/t5411/test-0014-bad-protocol--porcelain.sh  | 50 +++++++++----------
 t/t5411/test-0020-report-ng.sh                |  8 +--
 t/t5411/test-0021-report-ng--porcelain.sh     |  8 +--
 t/t5411/test-0022-report-unexpect-ref.sh      |  4 +-
 ...est-0023-report-unexpect-ref--porcelain.sh |  4 +-
 t/t5411/test-0024-report-unknown-ref.sh       |  4 +-
 ...test-0025-report-unknown-ref--porcelain.sh |  4 +-
 t/t5411/test-0026-push-options.sh             |  4 +-
 t/t5411/test-0027-push-options--porcelain.sh  |  4 +-
 t/t5411/test-0032-report-with-options.sh      |  4 +-
 ...est-0033-report-with-options--porcelain.sh |  4 +-
 t/t5411/test-0038-report-mixed-refs.sh        |  4 +-
 .../test-0039-report-mixed-refs--porcelain.sh |  4 +-
 20 files changed, 98 insertions(+), 98 deletions(-)

diff --git a/t/t5411/test-0000-standard-git-push.sh b/t/t5411/test-0000-standard-git-push.sh
index 47b058af7e..bdc4907191 100644
--- a/t/t5411/test-0000-standard-git-push.sh
+++ b/t/t5411/test-0000-standard-git-push.sh
@@ -35,11 +35,11 @@ test_expect_success "git-push --atomic ($PROTOCOL)" '
 	test_must_fail git -C workbench push --atomic origin \
 		main \
 		$B:refs/heads/next \
-		>out 2>&1 &&
+		>out-$test_count 2>&1 &&
 	filter_out_user_friendly_and_stable_output \
 		-e "/^To / { p; }" \
 		-e "/^ ! / { p; }" \
-		<out >actual &&
+		<out-$test_count >actual &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
 	 ! [rejected] main -> main (non-fast-forward)
@@ -65,8 +65,8 @@ test_expect_success "non-fast-forward git-push ($PROTOCOL)" '
 		push origin \
 		main \
 		$B:refs/heads/next \
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-$test_count 2>&1 &&
+	make_user_friendly_and_stable_output <out-$test_count >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/next
diff --git a/t/t5411/test-0001-standard-git-push--porcelain.sh b/t/t5411/test-0001-standard-git-push--porcelain.sh
index bbead12bbb..59630ef7e5 100644
--- a/t/t5411/test-0001-standard-git-push--porcelain.sh
+++ b/t/t5411/test-0001-standard-git-push--porcelain.sh
@@ -36,12 +36,12 @@ test_expect_success "git-push --atomic ($PROTOCOL/porcelain)" '
 	test_must_fail git -C workbench push --atomic --porcelain origin \
 		main \
 		$B:refs/heads/next \
-		>out 2>&1 &&
+		>out-$test_count 2>&1 &&
 	filter_out_user_friendly_and_stable_output \
 		-e "s/^# GETTEXT POISON #//" \
 		-e "/^To / { p; }" \
 		-e "/^! / { p; }" \
-		<out >actual &&
+		<out-$test_count >actual &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
 	!    refs/heads/main:refs/heads/main    [rejected] (non-fast-forward)
@@ -67,8 +67,8 @@ test_expect_success "non-fast-forward git-push ($PROTOCOL/porcelain)" '
 		push --porcelain origin \
 		main \
 		$B:refs/heads/next \
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-$test_count 2>&1 &&
+	make_user_friendly_and_stable_output <out-$test_count >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/next
diff --git a/t/t5411/test-0002-pre-receive-declined.sh b/t/t5411/test-0002-pre-receive-declined.sh
index e7d113a158..c5c76bfe93 100644
--- a/t/t5411/test-0002-pre-receive-declined.sh
+++ b/t/t5411/test-0002-pre-receive-declined.sh
@@ -12,8 +12,8 @@ test_expect_success "git-push is declined ($PROTOCOL)" '
 	test_must_fail git -C workbench push origin \
 		$B:refs/heads/main \
 		HEAD:refs/heads/next \
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-$test_count 2>&1 &&
+	make_user_friendly_and_stable_output <out-$test_count >actual &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
 	 ! [remote rejected] <COMMIT-B> -> main (pre-receive hook declined)
diff --git a/t/t5411/test-0003-pre-receive-declined--porcelain.sh b/t/t5411/test-0003-pre-receive-declined--porcelain.sh
index cc0cca6a47..45050b642a 100644
--- a/t/t5411/test-0003-pre-receive-declined--porcelain.sh
+++ b/t/t5411/test-0003-pre-receive-declined--porcelain.sh
@@ -12,8 +12,8 @@ test_expect_success "git-push is declined ($PROTOCOL/porcelain)" '
 	test_must_fail git -C workbench push --porcelain origin \
 		$B:refs/heads/main \
 		HEAD:refs/heads/next \
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-$test_count 2>&1 &&
+	make_user_friendly_and_stable_output <out-$test_count >actual &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
 	!    <COMMIT-B>:refs/heads/main    [remote rejected] (pre-receive hook declined)
diff --git a/t/t5411/test-0011-no-hook-error.sh b/t/t5411/test-0011-no-hook-error.sh
index c50830982f..77b45b0cbd 100644
--- a/t/t5411/test-0011-no-hook-error.sh
+++ b/t/t5411/test-0011-no-hook-error.sh
@@ -5,8 +5,8 @@ test_expect_success "proc-receive: no hook, fail to push special ref ($PROTOCOL)
 	test_must_fail git -C workbench push origin \
 		HEAD:next \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-$test_count 2>&1 &&
+	make_user_friendly_and_stable_output <out-$test_count >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
@@ -41,8 +41,8 @@ test_expect_success "proc-receive: no hook, all failed for atomic push ($PROTOCO
 	test_must_fail git -C workbench push --atomic origin \
 		$B:main \
 		HEAD:next \
-		HEAD:refs/for/main/topic >out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		HEAD:refs/for/main/topic >out-$test_count 2>&1 &&
+	make_user_friendly_and_stable_output <out-$test_count >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
diff --git a/t/t5411/test-0012-no-hook-error--porcelain.sh b/t/t5411/test-0012-no-hook-error--porcelain.sh
index 14ea433481..142f4835e4 100644
--- a/t/t5411/test-0012-no-hook-error--porcelain.sh
+++ b/t/t5411/test-0012-no-hook-error--porcelain.sh
@@ -5,8 +5,8 @@ test_expect_success "proc-receive: no hook, fail to push special ref ($PROTOCOL/
 	test_must_fail git -C workbench push --porcelain origin \
 		HEAD:next \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-$test_count 2>&1 &&
+	make_user_friendly_and_stable_output <out-$test_count >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
@@ -42,8 +42,8 @@ test_expect_success "proc-receive: no hook, all failed for atomic push ($PROTOCO
 	test_must_fail git -C workbench push --porcelain --atomic origin \
 		$B:main \
 		HEAD:next \
-		HEAD:refs/for/main/topic >out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		HEAD:refs/for/main/topic >out-$test_count 2>&1 &&
+	make_user_friendly_and_stable_output <out-$test_count >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
diff --git a/t/t5411/test-0013-bad-protocol.sh b/t/t5411/test-0013-bad-protocol.sh
index b9be12be77..bddface163 100644
--- a/t/t5411/test-0013-bad-protocol.sh
+++ b/t/t5411/test-0013-bad-protocol.sh
@@ -11,8 +11,8 @@ test_expect_success "setup proc-receive hook (unknown version, $PROTOCOL)" '
 test_expect_success "proc-receive: bad protocol (unknown version, $PROTOCOL)" '
 	test_must_fail git -C workbench push origin \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-$test_count 2>&1 &&
+	make_user_friendly_and_stable_output <out-$test_count >actual &&
 
 	# Check status report for git-push
 	sed -n \
@@ -55,18 +55,18 @@ test_expect_success "setup proc-receive hook (hook --die-read-version, $PROTOCOL
 test_expect_success "proc-receive: bad protocol (hook --die-read-version, $PROTOCOL)" '
 	test_must_fail git -C workbench push origin \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
+		>out-$test_count 2>&1 &&
 	filter_out_user_friendly_and_stable_output \
 		-e "/^To / { p; }" \
 		-e "/^ ! / { p; }" \
-		<out >actual &&
+		<out-$test_count >actual &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
 	 ! [remote rejected] HEAD -> refs/for/main/topic (fail to run proc-receive hook)
 	EOF
 	test_cmp expect actual &&
-	grep "remote: fatal: die with the --die-read-version option" out &&
-	grep "remote: error: fail to negotiate version with proc-receive hook" out &&
+	grep "remote: fatal: die with the --die-read-version option" out-$test_count &&
+	grep "remote: error: fail to negotiate version with proc-receive hook" out-$test_count &&
 
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
@@ -89,18 +89,18 @@ test_expect_success "setup proc-receive hook (hook --die-write-version, $PROTOCO
 test_expect_success "proc-receive: bad protocol (hook --die-write-version, $PROTOCOL)" '
 	test_must_fail git -C workbench push origin \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
+		>out-$test_count 2>&1 &&
 	filter_out_user_friendly_and_stable_output \
 		-e "/^To / { p; }" \
 		-e "/^ ! / { p; }" \
-		<out >actual &&
+		<out-$test_count >actual &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
 	 ! [remote rejected] HEAD -> refs/for/main/topic (fail to run proc-receive hook)
 	EOF
 	test_cmp expect actual &&
-	grep "remote: fatal: die with the --die-write-version option" out &&
-	grep "remote: error: fail to negotiate version with proc-receive hook" out &&
+	grep "remote: fatal: die with the --die-write-version option" out-$test_count &&
+	grep "remote: error: fail to negotiate version with proc-receive hook" out-$test_count &&
 
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
@@ -123,17 +123,17 @@ test_expect_success "setup proc-receive hook (hook --die-read-commands, $PROTOCO
 test_expect_success "proc-receive: bad protocol (hook --die-read-commands, $PROTOCOL)" '
 	test_must_fail git -C workbench push origin \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
+		>out-$test_count 2>&1 &&
 	filter_out_user_friendly_and_stable_output \
 		-e "/^To / { p; }" \
 		-e "/^ ! / { p; }" \
-		<out >actual &&
+		<out-$test_count >actual &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
 	 ! [remote rejected] HEAD -> refs/for/main/topic (fail to run proc-receive hook)
 	EOF
 	test_cmp expect actual &&
-	grep "remote: fatal: die with the --die-read-commands option" out &&
+	grep "remote: fatal: die with the --die-read-commands option" out-$test_count &&
 
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
@@ -158,17 +158,17 @@ test_expect_success "proc-receive: bad protocol (hook --die-read-push-options, $
 	test_must_fail git -C workbench push origin \
 		-o reviewers=user1,user2 \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
+		>out-$test_count 2>&1 &&
 	filter_out_user_friendly_and_stable_output \
 		-e "/^To / { p; }" \
 		-e "/^ ! / { p; }" \
-		<out >actual &&
+		<out-$test_count >actual &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
 	 ! [remote rejected] HEAD -> refs/for/main/topic (fail to run proc-receive hook)
 	EOF
 	test_cmp expect actual &&
-	grep "remote: fatal: die with the --die-read-push-options option" out &&
+	grep "remote: fatal: die with the --die-read-push-options option" out-$test_count &&
 
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
@@ -191,17 +191,17 @@ test_expect_success "setup proc-receive hook (hook --die-write-report, $PROTOCOL
 test_expect_success "proc-receive: bad protocol (hook --die-write-report, $PROTOCOL)" '
 	test_must_fail git -C workbench push origin \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
+		>out-$test_count 2>&1 &&
 	filter_out_user_friendly_and_stable_output \
 		-e "/^To / { p; }" \
 		-e "/^ ! / { p; }" \
-		<out >actual &&
+		<out-$test_count >actual &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
 	 ! [remote rejected] HEAD -> refs/for/main/topic (fail to run proc-receive hook)
 	EOF
 	test_cmp expect actual &&
-	grep "remote: fatal: die with the --die-write-report option" out &&
+	grep "remote: fatal: die with the --die-write-report option" out-$test_count &&
 
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
@@ -224,8 +224,8 @@ test_expect_success "setup proc-receive hook (no report, $PROTOCOL)" '
 test_expect_success "proc-receive: bad protocol (no report, $PROTOCOL)" '
 	test_must_fail git -C workbench push origin \
 		HEAD:refs/heads/next \
-		HEAD:refs/for/main/topic >out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		HEAD:refs/for/main/topic >out-$test_count 2>&1 &&
+	make_user_friendly_and_stable_output <out-$test_count >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
@@ -270,8 +270,8 @@ test_expect_success "setup proc-receive hook (no ref, $PROTOCOL)" '
 test_expect_success "proc-receive: bad protocol (no ref, $PROTOCOL)" '
 	test_must_fail git -C workbench push origin \
 		HEAD:refs/for/main/topic\
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-$test_count 2>&1 &&
+	make_user_friendly_and_stable_output <out-$test_count >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
@@ -306,8 +306,8 @@ test_expect_success "setup proc-receive hook (unknown status, $PROTOCOL)" '
 test_expect_success "proc-receive: bad protocol (unknown status, $PROTOCOL)" '
 	test_must_fail git -C workbench push origin \
 			HEAD:refs/for/main/topic \
-			>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+			>out-$test_count 2>&1 &&
+	make_user_friendly_and_stable_output <out-$test_count >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
diff --git a/t/t5411/test-0014-bad-protocol--porcelain.sh b/t/t5411/test-0014-bad-protocol--porcelain.sh
index fdb4569109..64bfa27dcc 100644
--- a/t/t5411/test-0014-bad-protocol--porcelain.sh
+++ b/t/t5411/test-0014-bad-protocol--porcelain.sh
@@ -11,8 +11,8 @@ test_expect_success "setup proc-receive hook (unknown version, $PROTOCOL/porcela
 test_expect_success "proc-receive: bad protocol (unknown version, $PROTOCOL/porcelain)" '
 	test_must_fail git -C workbench push --porcelain origin \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-$test_count 2>&1 &&
+	make_user_friendly_and_stable_output <out-$test_count >actual &&
 
 	# Check status report for git-push
 	sed -n \
@@ -55,18 +55,18 @@ test_expect_success "setup proc-receive hook (hook --die-read-version, $PROTOCOL
 test_expect_success "proc-receive: bad protocol (hook --die-read-version, $PROTOCOL/porcelain)" '
 	test_must_fail git -C workbench push --porcelain origin \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
+		>out-$test_count 2>&1 &&
 	filter_out_user_friendly_and_stable_output \
 		-e "/^To / { p; n; p; n; p; }" \
-		<out >actual &&
+		<out-$test_count >actual &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
 	!    HEAD:refs/for/main/topic    [remote rejected] (fail to run proc-receive hook)
 	Done
 	EOF
 	test_cmp expect actual &&
-	grep "remote: fatal: die with the --die-read-version option" out &&
-	grep "remote: error: fail to negotiate version with proc-receive hook" out &&
+	grep "remote: fatal: die with the --die-read-version option" out-$test_count &&
+	grep "remote: error: fail to negotiate version with proc-receive hook" out-$test_count &&
 
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
@@ -89,18 +89,18 @@ test_expect_success "setup proc-receive hook (hook --die-write-version, $PROTOCO
 test_expect_success "proc-receive: bad protocol (hook --die-write-version, $PROTOCOL/porcelain)" '
 	test_must_fail git -C workbench push --porcelain origin \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
+		>out-$test_count 2>&1 &&
 	filter_out_user_friendly_and_stable_output \
 		-e "/^To / { p; n; p; n; p; }" \
-		<out >actual &&
+		<out-$test_count >actual &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
 	!    HEAD:refs/for/main/topic    [remote rejected] (fail to run proc-receive hook)
 	Done
 	EOF
 	test_cmp expect actual &&
-	grep "remote: fatal: die with the --die-write-version option" out &&
-	grep "remote: error: fail to negotiate version with proc-receive hook" out &&
+	grep "remote: fatal: die with the --die-write-version option" out-$test_count &&
+	grep "remote: error: fail to negotiate version with proc-receive hook" out-$test_count &&
 
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
@@ -123,17 +123,17 @@ test_expect_success "setup proc-receive hook (hook --die-read-commands, $PROTOCO
 test_expect_success "proc-receive: bad protocol (hook --die-read-commands, $PROTOCOL/porcelain)" '
 	test_must_fail git -C workbench push --porcelain origin \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
+		>out-$test_count 2>&1 &&
 	filter_out_user_friendly_and_stable_output \
 		-e "/^To / { p; n; p; n; p; }" \
-		<out >actual &&
+		<out-$test_count >actual &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
 	!    HEAD:refs/for/main/topic    [remote rejected] (fail to run proc-receive hook)
 	Done
 	EOF
 	test_cmp expect actual &&
-	grep "remote: fatal: die with the --die-read-commands option" out &&
+	grep "remote: fatal: die with the --die-read-commands option" out-$test_count &&
 
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
@@ -158,17 +158,17 @@ test_expect_success "proc-receive: bad protocol (hook --die-read-push-options, $
 	test_must_fail git -C workbench push --porcelain origin \
 		-o reviewers=user1,user2 \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
+		>out-$test_count 2>&1 &&
 	filter_out_user_friendly_and_stable_output \
 		-e "/^To / { p; n; p; n; p; }" \
-		<out >actual &&
+		<out-$test_count >actual &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
 	!    HEAD:refs/for/main/topic    [remote rejected] (fail to run proc-receive hook)
 	Done
 	EOF
 	test_cmp expect actual &&
-	grep "remote: fatal: die with the --die-read-push-options option" out &&
+	grep "remote: fatal: die with the --die-read-push-options option" out-$test_count &&
 
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
@@ -191,17 +191,17 @@ test_expect_success "setup proc-receive hook (hook --die-write-report, $PROTOCOL
 test_expect_success "proc-receive: bad protocol (hook --die-write-report, $PROTOCOL/porcelain)" '
 	test_must_fail git -C workbench push --porcelain origin \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
+		>out-$test_count 2>&1 &&
 	filter_out_user_friendly_and_stable_output \
 		-e "/^To / { p; n; p; n; p; }" \
-		<out >actual &&
+		<out-$test_count >actual &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
 	!    HEAD:refs/for/main/topic    [remote rejected] (fail to run proc-receive hook)
 	Done
 	EOF
 	test_cmp expect actual &&
-	grep "remote: fatal: die with the --die-write-report option" out &&
+	grep "remote: fatal: die with the --die-write-report option" out-$test_count &&
 
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
@@ -224,8 +224,8 @@ test_expect_success "setup proc-receive hook (no report, $PROTOCOL/porcelain)" '
 test_expect_success "proc-receive: bad protocol (no report, $PROTOCOL/porcelain)" '
 	test_must_fail git -C workbench push --porcelain origin \
 		HEAD:refs/heads/next \
-		HEAD:refs/for/main/topic >out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		HEAD:refs/for/main/topic >out-$test_count 2>&1 &&
+	make_user_friendly_and_stable_output <out-$test_count >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
@@ -270,8 +270,8 @@ test_expect_success "setup proc-receive hook (no ref, $PROTOCOL/porcelain)" '
 test_expect_success "proc-receive: bad protocol (no ref, $PROTOCOL/porcelain)" '
 	test_must_fail git -C workbench push --porcelain origin \
 		HEAD:refs/for/main/topic\
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-$test_count 2>&1 &&
+	make_user_friendly_and_stable_output <out-$test_count >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
@@ -307,8 +307,8 @@ test_expect_success "setup proc-receive hook (unknown status, $PROTOCOL/porcelai
 test_expect_success "proc-receive: bad protocol (unknown status, $PROTOCOL/porcelain)" '
 	test_must_fail git -C workbench push --porcelain origin \
 			HEAD:refs/for/main/topic \
-			>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+			>out-$test_count 2>&1 &&
+	make_user_friendly_and_stable_output <out-$test_count >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
diff --git a/t/t5411/test-0020-report-ng.sh b/t/t5411/test-0020-report-ng.sh
index 5a9e0daf2d..6618c91841 100644
--- a/t/t5411/test-0020-report-ng.sh
+++ b/t/t5411/test-0020-report-ng.sh
@@ -12,8 +12,8 @@ test_expect_success "setup proc-receive hook (ng, no message, $PROTOCOL)" '
 test_expect_success "proc-receive: fail to update (ng, no message, $PROTOCOL)" '
 	test_must_fail git -C workbench push origin \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-$test_count 2>&1 &&
+	make_user_friendly_and_stable_output <out-$test_count >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
@@ -46,8 +46,8 @@ test_expect_success "setup proc-receive hook (ng message, $PROTOCOL)" '
 test_expect_success "proc-receive: fail to update (ng, with message, $PROTOCOL)" '
 	test_must_fail git -C workbench push origin \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-$test_count 2>&1 &&
+	make_user_friendly_and_stable_output <out-$test_count >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
diff --git a/t/t5411/test-0021-report-ng--porcelain.sh b/t/t5411/test-0021-report-ng--porcelain.sh
index 93475a83cf..44ad1c7de4 100644
--- a/t/t5411/test-0021-report-ng--porcelain.sh
+++ b/t/t5411/test-0021-report-ng--porcelain.sh
@@ -12,8 +12,8 @@ test_expect_success "setup proc-receive hook (ng, no message, $PROTOCOL/porcelai
 test_expect_success "proc-receive: fail to update (ng, no message, $PROTOCOL/porcelain)" '
 	test_must_fail git -C workbench push --porcelain origin \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-$test_count 2>&1 &&
+	make_user_friendly_and_stable_output <out-$test_count >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
@@ -47,8 +47,8 @@ test_expect_success "setup proc-receive hook (ng message, $PROTOCOL/porcelain)"
 test_expect_success "proc-receive: fail to update (ng, with message, $PROTOCOL/porcelain)" '
 	test_must_fail git -C workbench push --porcelain origin \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-$test_count 2>&1 &&
+	make_user_friendly_and_stable_output <out-$test_count >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
diff --git a/t/t5411/test-0022-report-unexpect-ref.sh b/t/t5411/test-0022-report-unexpect-ref.sh
index f8be8a0ba1..b0c5a6e168 100644
--- a/t/t5411/test-0022-report-unexpect-ref.sh
+++ b/t/t5411/test-0022-report-unexpect-ref.sh
@@ -13,8 +13,8 @@ test_expect_success "proc-receive: report unexpected ref ($PROTOCOL)" '
 	test_must_fail git -C workbench push origin \
 		$B:refs/heads/main \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-$test_count 2>&1 &&
+	make_user_friendly_and_stable_output <out-$test_count >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
diff --git a/t/t5411/test-0023-report-unexpect-ref--porcelain.sh b/t/t5411/test-0023-report-unexpect-ref--porcelain.sh
index 778150fa03..212927b8dc 100644
--- a/t/t5411/test-0023-report-unexpect-ref--porcelain.sh
+++ b/t/t5411/test-0023-report-unexpect-ref--porcelain.sh
@@ -13,8 +13,8 @@ test_expect_success "proc-receive: report unexpected ref ($PROTOCOL/porcelain)"
 	test_must_fail git -C workbench push --porcelain origin \
 		$B:refs/heads/main \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-$test_count 2>&1 &&
+	make_user_friendly_and_stable_output <out-$test_count >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
diff --git a/t/t5411/test-0024-report-unknown-ref.sh b/t/t5411/test-0024-report-unknown-ref.sh
index d4e74e4681..94ffad55f2 100644
--- a/t/t5411/test-0024-report-unknown-ref.sh
+++ b/t/t5411/test-0024-report-unknown-ref.sh
@@ -12,8 +12,8 @@ test_expect_success "setup proc-receive hook (unexpected ref, $PROTOCOL)" '
 test_expect_success "proc-receive: report unknown reference ($PROTOCOL)" '
 	test_must_fail git -C workbench push origin \
 		HEAD:refs/for/a/b/c/my/topic \
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-$test_count 2>&1 &&
+	make_user_friendly_and_stable_output <out-$test_count >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/my/topic
diff --git a/t/t5411/test-0025-report-unknown-ref--porcelain.sh b/t/t5411/test-0025-report-unknown-ref--porcelain.sh
index 039e8b6163..8ee7e66472 100644
--- a/t/t5411/test-0025-report-unknown-ref--porcelain.sh
+++ b/t/t5411/test-0025-report-unknown-ref--porcelain.sh
@@ -12,8 +12,8 @@ test_expect_success "setup proc-receive hook (unexpected ref, $PROTOCOL/porcelai
 test_expect_success "proc-receive: report unknown reference ($PROTOCOL/porcelain)" '
 	test_must_fail git -C workbench push --porcelain origin \
 		HEAD:refs/for/a/b/c/my/topic \
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-$test_count 2>&1 &&
+	make_user_friendly_and_stable_output <out-$test_count >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/my/topic
diff --git a/t/t5411/test-0026-push-options.sh b/t/t5411/test-0026-push-options.sh
index e88edb16a4..bb2cf59bdc 100644
--- a/t/t5411/test-0026-push-options.sh
+++ b/t/t5411/test-0026-push-options.sh
@@ -16,8 +16,8 @@ test_expect_success "proc-receive: not support push options ($PROTOCOL)" '
 		-o reviewer=user1 \
 		origin \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-$test_count 2>&1 &&
+	make_user_friendly_and_stable_output <out-$test_count >actual &&
 	test_i18ngrep "fatal: the receiving end does not support push options" \
 		actual &&
 	git -C "$upstream" show-ref >out &&
diff --git a/t/t5411/test-0027-push-options--porcelain.sh b/t/t5411/test-0027-push-options--porcelain.sh
index 3a6561b5ea..54e4f8f1d2 100644
--- a/t/t5411/test-0027-push-options--porcelain.sh
+++ b/t/t5411/test-0027-push-options--porcelain.sh
@@ -17,8 +17,8 @@ test_expect_success "proc-receive: not support push options ($PROTOCOL/porcelain
 		-o reviewer=user1 \
 		origin \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-$test_count 2>&1 &&
+	make_user_friendly_and_stable_output <out-$test_count >actual &&
 	test_i18ngrep "fatal: the receiving end does not support push options" \
 		actual &&
 	git -C "$upstream" show-ref >out &&
diff --git a/t/t5411/test-0032-report-with-options.sh b/t/t5411/test-0032-report-with-options.sh
index a0faf5c7ff..e6aa0f7018 100644
--- a/t/t5411/test-0032-report-with-options.sh
+++ b/t/t5411/test-0032-report-with-options.sh
@@ -13,8 +13,8 @@ test_expect_success "setup proc-receive hook (option without matching ok, $PROTO
 test_expect_success "proc-receive: report option without matching ok ($PROTOCOL)" '
 	test_must_fail git -C workbench push origin \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-$test_count 2>&1 &&
+	make_user_friendly_and_stable_output <out-$test_count >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
diff --git a/t/t5411/test-0033-report-with-options--porcelain.sh b/t/t5411/test-0033-report-with-options--porcelain.sh
index 32ae26bcfb..a8ca5dd0dd 100644
--- a/t/t5411/test-0033-report-with-options--porcelain.sh
+++ b/t/t5411/test-0033-report-with-options--porcelain.sh
@@ -13,8 +13,8 @@ test_expect_success "setup proc-receive hook (option without matching ok, $PROTO
 test_expect_success "proc-receive: report option without matching ok ($PROTOCOL/porcelain)" '
 	test_must_fail git -C workbench push --porcelain origin \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-$test_count 2>&1 &&
+	make_user_friendly_and_stable_output <out-$test_count >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
diff --git a/t/t5411/test-0038-report-mixed-refs.sh b/t/t5411/test-0038-report-mixed-refs.sh
index 0d071ebaa6..286f80d423 100644
--- a/t/t5411/test-0038-report-mixed-refs.sh
+++ b/t/t5411/test-0038-report-mixed-refs.sh
@@ -24,8 +24,8 @@ test_expect_success "proc-receive: report update of mixed refs ($PROTOCOL)" '
 		HEAD:refs/heads/foo \
 		HEAD:refs/for/main/topic \
 		HEAD:refs/for/next/topic3 \
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-$test_count 2>&1 &&
+	make_user_friendly_and_stable_output <out-$test_count >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
diff --git a/t/t5411/test-0039-report-mixed-refs--porcelain.sh b/t/t5411/test-0039-report-mixed-refs--porcelain.sh
index d8409912fd..939b8a3b4f 100644
--- a/t/t5411/test-0039-report-mixed-refs--porcelain.sh
+++ b/t/t5411/test-0039-report-mixed-refs--porcelain.sh
@@ -24,8 +24,8 @@ test_expect_success "proc-receive: report update of mixed refs ($PROTOCOL/porcel
 		HEAD:refs/heads/foo \
 		HEAD:refs/for/main/topic \
 		HEAD:refs/for/next/topic3 \
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-$test_count 2>&1 &&
+	make_user_friendly_and_stable_output <out-$test_count >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
-- 
2.28.0.15.gba9e81f0bd

