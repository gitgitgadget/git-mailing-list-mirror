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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835ADC43381
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 14:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AA22221FC
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 14:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392232AbhARNcA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 08:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392322AbhARNbQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 08:31:16 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F89C061573
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 05:30:35 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d4so8659473plh.5
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 05:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3i9X0mN47i+y4sKDZLYL5BADmn3zXuGn5YEz8RNtxcA=;
        b=iFBLX1qjWF4uwBH3QF9wu9onI5dhRXlOW4Ro+jgn3f4vRCZSrMs7dEgJWBL0a8hHVn
         cZ3IRv7illP8re2HtUmlUnPNIAt6egPhRlnZxETGU3fPt2+eg/cLBxMHbXJRiX9RQHoN
         URA4eY//LJYRmdhORQOTspBQP9Ox6qDmdGij+FrxKl8dqrbenniOVaVyc8c6fK45f3xx
         afAmf8s9lwik9YjIqp63A4Xm0DUHC4hfoGbiojpiGNEnuU42+xl9UDbz33NxR2GjX3W3
         pYckiZ2tG6wZImCQKgusE23DKwuPyC3igNfp2kCEWQPbuPojVpn7fFEsDeTfMJDzryxp
         NxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3i9X0mN47i+y4sKDZLYL5BADmn3zXuGn5YEz8RNtxcA=;
        b=BkK+epZjvfBnXYsR1Jou+1UJ66f3IXqS4K6GMDe42e8qppZfZylBBeciD59fQ+Tqpc
         tB0iZCojyqfydTqERDf+1TwzfczyRTSjpoLXr5+EagOj0wdDx1sWalgp+VT0GOp5ZMko
         ACNOyJr3/sz1Q9LhuI8JCGhUDoffWX/kSmMLAhjJjrrqWheyoC6zQWkk8xRGwHbfIB72
         +MScweZ6xLQHmeAIaShn0tMOUcDqiC/Ui27X4tbuauIFgcjh/9DtJQTayhTq87h6kHdo
         7WAfq8UCbC27enDAIwUVQ5NO6gC4PzLSgjRmonK1shrrArLIhao0B/ss5lW95F5+KA8x
         ZuVQ==
X-Gm-Message-State: AOAM5322GFq15YIXUpBZXqPiohlwQkMZc5oU/FM+StVDZ7hUusWWJkv5
        AfHbKcsgwFRaKFieZhg1++A=
X-Google-Smtp-Source: ABdhPJx/H2S7Q8e3ULoPMZA3oQeGKiBxCIzNtOAhAQmY5gxT0gjj+GIy/6r6RVRBWObZSJpGdLdzgQ==
X-Received: by 2002:a17:90a:d24a:: with SMTP id o10mr24976014pjw.160.1610976635051;
        Mon, 18 Jan 2021 05:30:35 -0800 (PST)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id m11sm3160010pjz.44.2021.01.18.05.30.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2021 05:30:33 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH 1/2] t5411: remove file after use to prevent overwriting
Date:   Mon, 18 Jan 2021 08:30:10 -0500
Message-Id: <20210118133011.15331-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20210117222151.GY8396@szeder.dev>
References: <20210117222151.GY8396@szeder.dev>
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

To resolve this issue, we can remove the file 'out' after use.  The
long-running 'git receive-pack' will not redirect its output to the new
created 'out' file which has a different file descriptor.

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t5411/test-0000-standard-git-push.sh         |  4 ++++
 .../test-0001-standard-git-push--porcelain.sh  |  4 ++++
 t/t5411/test-0002-pre-receive-declined.sh      |  2 ++
 ...est-0003-pre-receive-declined--porcelain.sh |  2 ++
 t/t5411/test-0011-no-hook-error.sh             |  4 ++++
 t/t5411/test-0012-no-hook-error--porcelain.sh  |  4 ++++
 t/t5411/test-0013-bad-protocol.sh              | 18 ++++++++++++++++++
 t/t5411/test-0014-bad-protocol--porcelain.sh   | 18 ++++++++++++++++++
 t/t5411/test-0020-report-ng.sh                 |  4 ++++
 t/t5411/test-0021-report-ng--porcelain.sh      |  4 ++++
 t/t5411/test-0022-report-unexpect-ref.sh       |  2 ++
 ...test-0023-report-unexpect-ref--porcelain.sh |  2 ++
 t/t5411/test-0024-report-unknown-ref.sh        |  2 ++
 .../test-0025-report-unknown-ref--porcelain.sh |  2 ++
 t/t5411/test-0026-push-options.sh              |  2 ++
 t/t5411/test-0027-push-options--porcelain.sh   |  2 ++
 t/t5411/test-0032-report-with-options.sh       |  2 ++
 ...test-0033-report-with-options--porcelain.sh |  2 ++
 t/t5411/test-0038-report-mixed-refs.sh         |  2 ++
 .../test-0039-report-mixed-refs--porcelain.sh  |  2 ++
 20 files changed, 84 insertions(+)

diff --git a/t/t5411/test-0000-standard-git-push.sh b/t/t5411/test-0000-standard-git-push.sh
index 47b058af7e..694d8e8dc2 100644
--- a/t/t5411/test-0000-standard-git-push.sh
+++ b/t/t5411/test-0000-standard-git-push.sh
@@ -40,6 +40,8 @@ test_expect_success "git-push --atomic ($PROTOCOL)" '
 		-e "/^To / { p; }" \
 		-e "/^ ! / { p; }" \
 		<out >actual &&
+	# Prevent accidential changes by the internal "receive-pack" process.
+	rm out &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
 	 ! [rejected] main -> main (non-fast-forward)
@@ -67,6 +69,8 @@ test_expect_success "non-fast-forward git-push ($PROTOCOL)" '
 		$B:refs/heads/next \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
+	# Prevent accidential changes by the internal "receive-pack" process.
+	rm out &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/next
diff --git a/t/t5411/test-0001-standard-git-push--porcelain.sh b/t/t5411/test-0001-standard-git-push--porcelain.sh
index bbead12bbb..6cf0bc7034 100644
--- a/t/t5411/test-0001-standard-git-push--porcelain.sh
+++ b/t/t5411/test-0001-standard-git-push--porcelain.sh
@@ -42,6 +42,8 @@ test_expect_success "git-push --atomic ($PROTOCOL/porcelain)" '
 		-e "/^To / { p; }" \
 		-e "/^! / { p; }" \
 		<out >actual &&
+	# Prevent accidential changes by the internal "receive-pack" process.
+	rm out &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
 	!    refs/heads/main:refs/heads/main    [rejected] (non-fast-forward)
@@ -69,6 +71,8 @@ test_expect_success "non-fast-forward git-push ($PROTOCOL/porcelain)" '
 		$B:refs/heads/next \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
+	# Prevent accidential changes by the internal "receive-pack" process.
+	rm out &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/next
diff --git a/t/t5411/test-0002-pre-receive-declined.sh b/t/t5411/test-0002-pre-receive-declined.sh
index e7d113a158..61c3ee1b7f 100644
--- a/t/t5411/test-0002-pre-receive-declined.sh
+++ b/t/t5411/test-0002-pre-receive-declined.sh
@@ -14,6 +14,8 @@ test_expect_success "git-push is declined ($PROTOCOL)" '
 		HEAD:refs/heads/next \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
+	# Prevent accidential changes by the internal "receive-pack" process.
+	rm out &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
 	 ! [remote rejected] <COMMIT-B> -> main (pre-receive hook declined)
diff --git a/t/t5411/test-0003-pre-receive-declined--porcelain.sh b/t/t5411/test-0003-pre-receive-declined--porcelain.sh
index cc0cca6a47..0a9cc2d44a 100644
--- a/t/t5411/test-0003-pre-receive-declined--porcelain.sh
+++ b/t/t5411/test-0003-pre-receive-declined--porcelain.sh
@@ -14,6 +14,8 @@ test_expect_success "git-push is declined ($PROTOCOL/porcelain)" '
 		HEAD:refs/heads/next \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
+	# Prevent accidential changes by the internal "receive-pack" process.
+	rm out &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
 	!    <COMMIT-B>:refs/heads/main    [remote rejected] (pre-receive hook declined)
diff --git a/t/t5411/test-0011-no-hook-error.sh b/t/t5411/test-0011-no-hook-error.sh
index c50830982f..fd2bd20b76 100644
--- a/t/t5411/test-0011-no-hook-error.sh
+++ b/t/t5411/test-0011-no-hook-error.sh
@@ -7,6 +7,8 @@ test_expect_success "proc-receive: no hook, fail to push special ref ($PROTOCOL)
 		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
+	# Prevent accidential changes by the internal "receive-pack" process.
+	rm out &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
@@ -43,6 +45,8 @@ test_expect_success "proc-receive: no hook, all failed for atomic push ($PROTOCO
 		HEAD:next \
 		HEAD:refs/for/main/topic >out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
+	# Prevent accidential changes by the internal "receive-pack" process.
+	rm out &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
diff --git a/t/t5411/test-0012-no-hook-error--porcelain.sh b/t/t5411/test-0012-no-hook-error--porcelain.sh
index 14ea433481..025a9c7186 100644
--- a/t/t5411/test-0012-no-hook-error--porcelain.sh
+++ b/t/t5411/test-0012-no-hook-error--porcelain.sh
@@ -7,6 +7,8 @@ test_expect_success "proc-receive: no hook, fail to push special ref ($PROTOCOL/
 		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
+	# Prevent accidential changes by the internal "receive-pack" process.
+	rm out &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
@@ -44,6 +46,8 @@ test_expect_success "proc-receive: no hook, all failed for atomic push ($PROTOCO
 		HEAD:next \
 		HEAD:refs/for/main/topic >out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
+	# Prevent accidential changes by the internal "receive-pack" process.
+	rm out &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
diff --git a/t/t5411/test-0013-bad-protocol.sh b/t/t5411/test-0013-bad-protocol.sh
index b9be12be77..d20a4e6681 100644
--- a/t/t5411/test-0013-bad-protocol.sh
+++ b/t/t5411/test-0013-bad-protocol.sh
@@ -13,6 +13,8 @@ test_expect_success "proc-receive: bad protocol (unknown version, $PROTOCOL)" '
 		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
+	# Prevent accidential changes by the internal "receive-pack" process.
+	rm out &&
 
 	# Check status report for git-push
 	sed -n \
@@ -67,6 +69,8 @@ test_expect_success "proc-receive: bad protocol (hook --die-read-version, $PROTO
 	test_cmp expect actual &&
 	grep "remote: fatal: die with the --die-read-version option" out &&
 	grep "remote: error: fail to negotiate version with proc-receive hook" out &&
+	# Prevent accidential changes by the internal "receive-pack" process.
+	rm out &&
 
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
@@ -101,6 +105,8 @@ test_expect_success "proc-receive: bad protocol (hook --die-write-version, $PROT
 	test_cmp expect actual &&
 	grep "remote: fatal: die with the --die-write-version option" out &&
 	grep "remote: error: fail to negotiate version with proc-receive hook" out &&
+	# Prevent accidential changes by the internal "receive-pack" process.
+	rm out &&
 
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
@@ -134,6 +140,8 @@ test_expect_success "proc-receive: bad protocol (hook --die-read-commands, $PROT
 	EOF
 	test_cmp expect actual &&
 	grep "remote: fatal: die with the --die-read-commands option" out &&
+	# Prevent accidential changes by the internal "receive-pack" process.
+	rm out &&
 
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
@@ -169,6 +177,8 @@ test_expect_success "proc-receive: bad protocol (hook --die-read-push-options, $
 	EOF
 	test_cmp expect actual &&
 	grep "remote: fatal: die with the --die-read-push-options option" out &&
+	# Prevent accidential changes by the internal "receive-pack" process.
+	rm out &&
 
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
@@ -202,6 +212,8 @@ test_expect_success "proc-receive: bad protocol (hook --die-write-report, $PROTO
 	EOF
 	test_cmp expect actual &&
 	grep "remote: fatal: die with the --die-write-report option" out &&
+	# Prevent accidential changes by the internal "receive-pack" process.
+	rm out &&
 
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
@@ -226,6 +238,8 @@ test_expect_success "proc-receive: bad protocol (no report, $PROTOCOL)" '
 		HEAD:refs/heads/next \
 		HEAD:refs/for/main/topic >out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
+	# Prevent accidential changes by the internal "receive-pack" process.
+	rm out &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
@@ -272,6 +286,8 @@ test_expect_success "proc-receive: bad protocol (no ref, $PROTOCOL)" '
 		HEAD:refs/for/main/topic\
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
+	# Prevent accidential changes by the internal "receive-pack" process.
+	rm out &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
@@ -308,6 +324,8 @@ test_expect_success "proc-receive: bad protocol (unknown status, $PROTOCOL)" '
 			HEAD:refs/for/main/topic \
 			>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
+	# Prevent accidential changes by the internal "receive-pack" process.
+	rm out &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
diff --git a/t/t5411/test-0014-bad-protocol--porcelain.sh b/t/t5411/test-0014-bad-protocol--porcelain.sh
index fdb4569109..a286030f3e 100644
--- a/t/t5411/test-0014-bad-protocol--porcelain.sh
+++ b/t/t5411/test-0014-bad-protocol--porcelain.sh
@@ -13,6 +13,8 @@ test_expect_success "proc-receive: bad protocol (unknown version, $PROTOCOL/porc
 		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
+	# Prevent accidential changes by the internal "receive-pack" process.
+	rm out &&
 
 	# Check status report for git-push
 	sed -n \
@@ -67,6 +69,8 @@ test_expect_success "proc-receive: bad protocol (hook --die-read-version, $PROTO
 	test_cmp expect actual &&
 	grep "remote: fatal: die with the --die-read-version option" out &&
 	grep "remote: error: fail to negotiate version with proc-receive hook" out &&
+	# Prevent accidential changes by the internal "receive-pack" process.
+	rm out &&
 
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
@@ -101,6 +105,8 @@ test_expect_success "proc-receive: bad protocol (hook --die-write-version, $PROT
 	test_cmp expect actual &&
 	grep "remote: fatal: die with the --die-write-version option" out &&
 	grep "remote: error: fail to negotiate version with proc-receive hook" out &&
+	# Prevent accidential changes by the internal "receive-pack" process.
+	rm out &&
 
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
@@ -134,6 +140,8 @@ test_expect_success "proc-receive: bad protocol (hook --die-read-commands, $PROT
 	EOF
 	test_cmp expect actual &&
 	grep "remote: fatal: die with the --die-read-commands option" out &&
+	# Prevent accidential changes by the internal "receive-pack" process.
+	rm out &&
 
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
@@ -169,6 +177,8 @@ test_expect_success "proc-receive: bad protocol (hook --die-read-push-options, $
 	EOF
 	test_cmp expect actual &&
 	grep "remote: fatal: die with the --die-read-push-options option" out &&
+	# Prevent accidential changes by the internal "receive-pack" process.
+	rm out &&
 
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
@@ -202,6 +212,8 @@ test_expect_success "proc-receive: bad protocol (hook --die-write-report, $PROTO
 	EOF
 	test_cmp expect actual &&
 	grep "remote: fatal: die with the --die-write-report option" out &&
+	# Prevent accidential changes by the internal "receive-pack" process.
+	rm out &&
 
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
@@ -226,6 +238,8 @@ test_expect_success "proc-receive: bad protocol (no report, $PROTOCOL/porcelain)
 		HEAD:refs/heads/next \
 		HEAD:refs/for/main/topic >out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
+	# Prevent accidential changes by the internal "receive-pack" process.
+	rm out &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
@@ -272,6 +286,8 @@ test_expect_success "proc-receive: bad protocol (no ref, $PROTOCOL/porcelain)" '
 		HEAD:refs/for/main/topic\
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
+	# Prevent accidential changes by the internal "receive-pack" process.
+	rm out &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
@@ -309,6 +325,8 @@ test_expect_success "proc-receive: bad protocol (unknown status, $PROTOCOL/porce
 			HEAD:refs/for/main/topic \
 			>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
+	# Prevent accidential changes by the internal "receive-pack" process.
+	rm out &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
diff --git a/t/t5411/test-0020-report-ng.sh b/t/t5411/test-0020-report-ng.sh
index 5a9e0daf2d..9f71da9fb6 100644
--- a/t/t5411/test-0020-report-ng.sh
+++ b/t/t5411/test-0020-report-ng.sh
@@ -14,6 +14,8 @@ test_expect_success "proc-receive: fail to update (ng, no message, $PROTOCOL)" '
 		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
+	# Prevent accidential changes by the internal "receive-pack" process.
+	rm out &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
@@ -48,6 +50,8 @@ test_expect_success "proc-receive: fail to update (ng, with message, $PROTOCOL)"
 		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
+	# Prevent accidential changes by the internal "receive-pack" process.
+	rm out &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
diff --git a/t/t5411/test-0021-report-ng--porcelain.sh b/t/t5411/test-0021-report-ng--porcelain.sh
index 93475a83cf..96065e3537 100644
--- a/t/t5411/test-0021-report-ng--porcelain.sh
+++ b/t/t5411/test-0021-report-ng--porcelain.sh
@@ -14,6 +14,8 @@ test_expect_success "proc-receive: fail to update (ng, no message, $PROTOCOL/por
 		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
+	# Prevent accidential changes by the internal "receive-pack" process.
+	rm out &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
@@ -49,6 +51,8 @@ test_expect_success "proc-receive: fail to update (ng, with message, $PROTOCOL/p
 		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
+	# Prevent accidential changes by the internal "receive-pack" process.
+	rm out &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
diff --git a/t/t5411/test-0022-report-unexpect-ref.sh b/t/t5411/test-0022-report-unexpect-ref.sh
index f8be8a0ba1..624dda7acc 100644
--- a/t/t5411/test-0022-report-unexpect-ref.sh
+++ b/t/t5411/test-0022-report-unexpect-ref.sh
@@ -15,6 +15,8 @@ test_expect_success "proc-receive: report unexpected ref ($PROTOCOL)" '
 		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
+	# Prevent accidential changes by the internal "receive-pack" process.
+	rm out &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
diff --git a/t/t5411/test-0023-report-unexpect-ref--porcelain.sh b/t/t5411/test-0023-report-unexpect-ref--porcelain.sh
index 778150fa03..dcb804afc8 100644
--- a/t/t5411/test-0023-report-unexpect-ref--porcelain.sh
+++ b/t/t5411/test-0023-report-unexpect-ref--porcelain.sh
@@ -15,6 +15,8 @@ test_expect_success "proc-receive: report unexpected ref ($PROTOCOL/porcelain)"
 		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
+	# Prevent accidential changes by the internal "receive-pack" process.
+	rm out &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
diff --git a/t/t5411/test-0024-report-unknown-ref.sh b/t/t5411/test-0024-report-unknown-ref.sh
index d4e74e4681..af65355862 100644
--- a/t/t5411/test-0024-report-unknown-ref.sh
+++ b/t/t5411/test-0024-report-unknown-ref.sh
@@ -14,6 +14,8 @@ test_expect_success "proc-receive: report unknown reference ($PROTOCOL)" '
 		HEAD:refs/for/a/b/c/my/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
+	# Prevent accidential changes by the internal "receive-pack" process.
+	rm out &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/my/topic
diff --git a/t/t5411/test-0025-report-unknown-ref--porcelain.sh b/t/t5411/test-0025-report-unknown-ref--porcelain.sh
index 039e8b6163..c336ec0e98 100644
--- a/t/t5411/test-0025-report-unknown-ref--porcelain.sh
+++ b/t/t5411/test-0025-report-unknown-ref--porcelain.sh
@@ -14,6 +14,8 @@ test_expect_success "proc-receive: report unknown reference ($PROTOCOL/porcelain
 		HEAD:refs/for/a/b/c/my/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
+	# Prevent accidential changes by the internal "receive-pack" process.
+	rm out &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/my/topic
diff --git a/t/t5411/test-0026-push-options.sh b/t/t5411/test-0026-push-options.sh
index e88edb16a4..46b1064fe6 100644
--- a/t/t5411/test-0026-push-options.sh
+++ b/t/t5411/test-0026-push-options.sh
@@ -18,6 +18,8 @@ test_expect_success "proc-receive: not support push options ($PROTOCOL)" '
 		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
+	# Prevent accidential changes by the internal "receive-pack" process.
+	rm out &&
 	test_i18ngrep "fatal: the receiving end does not support push options" \
 		actual &&
 	git -C "$upstream" show-ref >out &&
diff --git a/t/t5411/test-0027-push-options--porcelain.sh b/t/t5411/test-0027-push-options--porcelain.sh
index 3a6561b5ea..79a49a638e 100644
--- a/t/t5411/test-0027-push-options--porcelain.sh
+++ b/t/t5411/test-0027-push-options--porcelain.sh
@@ -19,6 +19,8 @@ test_expect_success "proc-receive: not support push options ($PROTOCOL/porcelain
 		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
+	# Prevent accidential changes by the internal "receive-pack" process.
+	rm out &&
 	test_i18ngrep "fatal: the receiving end does not support push options" \
 		actual &&
 	git -C "$upstream" show-ref >out &&
diff --git a/t/t5411/test-0032-report-with-options.sh b/t/t5411/test-0032-report-with-options.sh
index a0faf5c7ff..4d058cc6ff 100644
--- a/t/t5411/test-0032-report-with-options.sh
+++ b/t/t5411/test-0032-report-with-options.sh
@@ -15,6 +15,8 @@ test_expect_success "proc-receive: report option without matching ok ($PROTOCOL)
 		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
+	# Prevent accidential changes by the internal "receive-pack" process.
+	rm out &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
diff --git a/t/t5411/test-0033-report-with-options--porcelain.sh b/t/t5411/test-0033-report-with-options--porcelain.sh
index 32ae26bcfb..8ab908a6b0 100644
--- a/t/t5411/test-0033-report-with-options--porcelain.sh
+++ b/t/t5411/test-0033-report-with-options--porcelain.sh
@@ -15,6 +15,8 @@ test_expect_success "proc-receive: report option without matching ok ($PROTOCOL/
 		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
+	# Prevent accidential changes by the internal "receive-pack" process.
+	rm out &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
diff --git a/t/t5411/test-0038-report-mixed-refs.sh b/t/t5411/test-0038-report-mixed-refs.sh
index 0d071ebaa6..264a5d5c6d 100644
--- a/t/t5411/test-0038-report-mixed-refs.sh
+++ b/t/t5411/test-0038-report-mixed-refs.sh
@@ -26,6 +26,8 @@ test_expect_success "proc-receive: report update of mixed refs ($PROTOCOL)" '
 		HEAD:refs/for/next/topic3 \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
+	# Prevent accidential changes by the internal "receive-pack" process.
+	rm out &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
diff --git a/t/t5411/test-0039-report-mixed-refs--porcelain.sh b/t/t5411/test-0039-report-mixed-refs--porcelain.sh
index d8409912fd..1e9c06d2b7 100644
--- a/t/t5411/test-0039-report-mixed-refs--porcelain.sh
+++ b/t/t5411/test-0039-report-mixed-refs--porcelain.sh
@@ -26,6 +26,8 @@ test_expect_success "proc-receive: report update of mixed refs ($PROTOCOL/porcel
 		HEAD:refs/for/next/topic3 \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
+	# Prevent accidential changes by the internal "receive-pack" process.
+	rm out &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
-- 
2.28.0.15.gba9e81f0bd

