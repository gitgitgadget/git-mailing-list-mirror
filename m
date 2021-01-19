Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DBAC433E9
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 14:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5393E23137
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 14:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390707AbhASOud (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 09:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731703AbhASKZp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 05:25:45 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B12C061574
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 02:25:04 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id p15so11427649pjv.3
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 02:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W1h/LbUG2tGWUwzIyVYd41LOkqIBGFkoKybwJ+koNks=;
        b=i+lFfJ/8IaW1b3USMqybbiz+R3sIvkbTjWbRWK/bUTG+stLR5ai5R7/ezASMnDVaON
         OpKlZghfGH8rUhpDdT4uyFFOzlAU+VDh8sLcowi3rm1Jev9vrHcILkxA6PdZyLI2qhPj
         Fm5MNd9sI1el44sIsc+s2P+A8x9vptFUMt6ymZzEVUnd2FZJl4Fn8IPWzcKDcKyh8WJB
         +WJYm4URuEwE5ctNKcsqymsjU6Wt95k3gPjGkZUf1ybakAD/desbmJZo9F3BzqbL+8Qp
         naWZqwnx/Icx2oejhqQousWbM2T4ABHxSx0P+KKK0XQUbJokm9IXn5Fk0NIDsw6AsEeW
         Htww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W1h/LbUG2tGWUwzIyVYd41LOkqIBGFkoKybwJ+koNks=;
        b=Vpd5x/x3vcKsLhW42fQ/CO1xKJE2E1J/+pGBeRfiy7shVHHGQOlta5gp13UoMcHXYB
         jL6xjGTxohon6yM+4tA9z6TIvi9Femd4cey9YNdp+KT8ydeGxGBS2gK+jggb4NHUTEKu
         mLDHsbN21/JB6Q8X3Tb3BfLikpxCIomioaUYg8bmYDvKpCOV7thoALfP+nAZVfqzMASN
         saTu3wAD8gGdZRCWr/vOD6k1TiCSDNCWoBdM8eYvULbOezt9TOcbdFKha/823lHsCNhv
         nzNKDyoVXRyhNaz3CMSL1w9HoeDrks+7aojLgYmALsnYodROfEXmsF3wcRXHBZ2Ihjsb
         zVUQ==
X-Gm-Message-State: AOAM530VpY6puxq58qYaFcXmReVntUnffwpA3xsbXXPyP5plbvQRWPeP
        EY4efupLdCUwQcnyH1GSn7s=
X-Google-Smtp-Source: ABdhPJyS3LYyebOL1ndx8L9RdqbRv+llzHNEmUYCCyTZEJ1VxlUe4++Pxv9ki8glzMauTN4khDSO5g==
X-Received: by 2002:a17:90a:c306:: with SMTP id g6mr4722883pjt.104.1611051903973;
        Tue, 19 Jan 2021 02:25:03 -0800 (PST)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id t8sm2400032pjd.51.2021.01.19.02.25.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jan 2021 02:25:03 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v2 1/2] t5411: use different out file to prevent overwriting
Date:   Tue, 19 Jan 2021 05:24:58 -0500
Message-Id: <20210119102459.28986-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <e1c9c9cf-4498-6861-bb39-53ceeb9c0fe7@kdbg.org>
References: <e1c9c9cf-4498-6861-bb39-53ceeb9c0fe7@kdbg.org>
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
index 47b058af7e..b074417d4b 100644
--- a/t/t5411/test-0000-standard-git-push.sh
+++ b/t/t5411/test-0000-standard-git-push.sh
@@ -35,11 +35,11 @@ test_expect_success "git-push --atomic ($PROTOCOL)" '
 	test_must_fail git -C workbench push --atomic origin \
 		main \
 		$B:refs/heads/next \
-		>out 2>&1 &&
+		>out-0000-1 2>&1 &&
 	filter_out_user_friendly_and_stable_output \
 		-e "/^To / { p; }" \
 		-e "/^ ! / { p; }" \
-		<out >actual &&
+		<out-0000-1 >actual &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
 	 ! [rejected] main -> main (non-fast-forward)
@@ -65,8 +65,8 @@ test_expect_success "non-fast-forward git-push ($PROTOCOL)" '
 		push origin \
 		main \
 		$B:refs/heads/next \
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-0000-2 2>&1 &&
+	make_user_friendly_and_stable_output <out-0000-2 >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/next
diff --git a/t/t5411/test-0001-standard-git-push--porcelain.sh b/t/t5411/test-0001-standard-git-push--porcelain.sh
index bbead12bbb..8a0de5cac8 100644
--- a/t/t5411/test-0001-standard-git-push--porcelain.sh
+++ b/t/t5411/test-0001-standard-git-push--porcelain.sh
@@ -36,12 +36,12 @@ test_expect_success "git-push --atomic ($PROTOCOL/porcelain)" '
 	test_must_fail git -C workbench push --atomic --porcelain origin \
 		main \
 		$B:refs/heads/next \
-		>out 2>&1 &&
+		>out-0001-1 2>&1 &&
 	filter_out_user_friendly_and_stable_output \
 		-e "s/^# GETTEXT POISON #//" \
 		-e "/^To / { p; }" \
 		-e "/^! / { p; }" \
-		<out >actual &&
+		<out-0001-1 >actual &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
 	!    refs/heads/main:refs/heads/main    [rejected] (non-fast-forward)
@@ -67,8 +67,8 @@ test_expect_success "non-fast-forward git-push ($PROTOCOL/porcelain)" '
 		push --porcelain origin \
 		main \
 		$B:refs/heads/next \
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-0001-2 2>&1 &&
+	make_user_friendly_and_stable_output <out-0001-2 >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/next
diff --git a/t/t5411/test-0002-pre-receive-declined.sh b/t/t5411/test-0002-pre-receive-declined.sh
index e7d113a158..83edcb037b 100644
--- a/t/t5411/test-0002-pre-receive-declined.sh
+++ b/t/t5411/test-0002-pre-receive-declined.sh
@@ -12,8 +12,8 @@ test_expect_success "git-push is declined ($PROTOCOL)" '
 	test_must_fail git -C workbench push origin \
 		$B:refs/heads/main \
 		HEAD:refs/heads/next \
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-0002-1 2>&1 &&
+	make_user_friendly_and_stable_output <out-0002-1 >actual &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
 	 ! [remote rejected] <COMMIT-B> -> main (pre-receive hook declined)
diff --git a/t/t5411/test-0003-pre-receive-declined--porcelain.sh b/t/t5411/test-0003-pre-receive-declined--porcelain.sh
index cc0cca6a47..8f3bbeccca 100644
--- a/t/t5411/test-0003-pre-receive-declined--porcelain.sh
+++ b/t/t5411/test-0003-pre-receive-declined--porcelain.sh
@@ -12,8 +12,8 @@ test_expect_success "git-push is declined ($PROTOCOL/porcelain)" '
 	test_must_fail git -C workbench push --porcelain origin \
 		$B:refs/heads/main \
 		HEAD:refs/heads/next \
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-0003-1 2>&1 &&
+	make_user_friendly_and_stable_output <out-0003-1 >actual &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
 	!    <COMMIT-B>:refs/heads/main    [remote rejected] (pre-receive hook declined)
diff --git a/t/t5411/test-0011-no-hook-error.sh b/t/t5411/test-0011-no-hook-error.sh
index c50830982f..11c85a32d5 100644
--- a/t/t5411/test-0011-no-hook-error.sh
+++ b/t/t5411/test-0011-no-hook-error.sh
@@ -5,8 +5,8 @@ test_expect_success "proc-receive: no hook, fail to push special ref ($PROTOCOL)
 	test_must_fail git -C workbench push origin \
 		HEAD:next \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-0011-1 2>&1 &&
+	make_user_friendly_and_stable_output <out-0011-1 >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
@@ -41,8 +41,8 @@ test_expect_success "proc-receive: no hook, all failed for atomic push ($PROTOCO
 	test_must_fail git -C workbench push --atomic origin \
 		$B:main \
 		HEAD:next \
-		HEAD:refs/for/main/topic >out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		HEAD:refs/for/main/topic >out-0011-2 2>&1 &&
+	make_user_friendly_and_stable_output <out-0011-2 >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
diff --git a/t/t5411/test-0012-no-hook-error--porcelain.sh b/t/t5411/test-0012-no-hook-error--porcelain.sh
index 14ea433481..f89754b480 100644
--- a/t/t5411/test-0012-no-hook-error--porcelain.sh
+++ b/t/t5411/test-0012-no-hook-error--porcelain.sh
@@ -5,8 +5,8 @@ test_expect_success "proc-receive: no hook, fail to push special ref ($PROTOCOL/
 	test_must_fail git -C workbench push --porcelain origin \
 		HEAD:next \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-0012-1 2>&1 &&
+	make_user_friendly_and_stable_output <out-0012-1 >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
@@ -42,8 +42,8 @@ test_expect_success "proc-receive: no hook, all failed for atomic push ($PROTOCO
 	test_must_fail git -C workbench push --porcelain --atomic origin \
 		$B:main \
 		HEAD:next \
-		HEAD:refs/for/main/topic >out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		HEAD:refs/for/main/topic >out-0012-2 2>&1 &&
+	make_user_friendly_and_stable_output <out-0012-2 >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
diff --git a/t/t5411/test-0013-bad-protocol.sh b/t/t5411/test-0013-bad-protocol.sh
index b9be12be77..888fd951c3 100644
--- a/t/t5411/test-0013-bad-protocol.sh
+++ b/t/t5411/test-0013-bad-protocol.sh
@@ -11,8 +11,8 @@ test_expect_success "setup proc-receive hook (unknown version, $PROTOCOL)" '
 test_expect_success "proc-receive: bad protocol (unknown version, $PROTOCOL)" '
 	test_must_fail git -C workbench push origin \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-0013-1 2>&1 &&
+	make_user_friendly_and_stable_output <out-0013-1 >actual &&
 
 	# Check status report for git-push
 	sed -n \
@@ -55,18 +55,18 @@ test_expect_success "setup proc-receive hook (hook --die-read-version, $PROTOCOL
 test_expect_success "proc-receive: bad protocol (hook --die-read-version, $PROTOCOL)" '
 	test_must_fail git -C workbench push origin \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
+		>out-0013-2 2>&1 &&
 	filter_out_user_friendly_and_stable_output \
 		-e "/^To / { p; }" \
 		-e "/^ ! / { p; }" \
-		<out >actual &&
+		<out-0013-2 >actual &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
 	 ! [remote rejected] HEAD -> refs/for/main/topic (fail to run proc-receive hook)
 	EOF
 	test_cmp expect actual &&
-	grep "remote: fatal: die with the --die-read-version option" out &&
-	grep "remote: error: fail to negotiate version with proc-receive hook" out &&
+	grep "remote: fatal: die with the --die-read-version option" out-0013-2 &&
+	grep "remote: error: fail to negotiate version with proc-receive hook" out-0013-2 &&
 
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
@@ -89,18 +89,18 @@ test_expect_success "setup proc-receive hook (hook --die-write-version, $PROTOCO
 test_expect_success "proc-receive: bad protocol (hook --die-write-version, $PROTOCOL)" '
 	test_must_fail git -C workbench push origin \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
+		>out-0013-3 2>&1 &&
 	filter_out_user_friendly_and_stable_output \
 		-e "/^To / { p; }" \
 		-e "/^ ! / { p; }" \
-		<out >actual &&
+		<out-0013-3 >actual &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
 	 ! [remote rejected] HEAD -> refs/for/main/topic (fail to run proc-receive hook)
 	EOF
 	test_cmp expect actual &&
-	grep "remote: fatal: die with the --die-write-version option" out &&
-	grep "remote: error: fail to negotiate version with proc-receive hook" out &&
+	grep "remote: fatal: die with the --die-write-version option" out-0013-3 &&
+	grep "remote: error: fail to negotiate version with proc-receive hook" out-0013-3 &&
 
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
@@ -123,17 +123,17 @@ test_expect_success "setup proc-receive hook (hook --die-read-commands, $PROTOCO
 test_expect_success "proc-receive: bad protocol (hook --die-read-commands, $PROTOCOL)" '
 	test_must_fail git -C workbench push origin \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
+		>out-0013-4 2>&1 &&
 	filter_out_user_friendly_and_stable_output \
 		-e "/^To / { p; }" \
 		-e "/^ ! / { p; }" \
-		<out >actual &&
+		<out-0013-4 >actual &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
 	 ! [remote rejected] HEAD -> refs/for/main/topic (fail to run proc-receive hook)
 	EOF
 	test_cmp expect actual &&
-	grep "remote: fatal: die with the --die-read-commands option" out &&
+	grep "remote: fatal: die with the --die-read-commands option" out-0013-4 &&
 
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
@@ -158,17 +158,17 @@ test_expect_success "proc-receive: bad protocol (hook --die-read-push-options, $
 	test_must_fail git -C workbench push origin \
 		-o reviewers=user1,user2 \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
+		>out-0013-5 2>&1 &&
 	filter_out_user_friendly_and_stable_output \
 		-e "/^To / { p; }" \
 		-e "/^ ! / { p; }" \
-		<out >actual &&
+		<out-0013-5 >actual &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
 	 ! [remote rejected] HEAD -> refs/for/main/topic (fail to run proc-receive hook)
 	EOF
 	test_cmp expect actual &&
-	grep "remote: fatal: die with the --die-read-push-options option" out &&
+	grep "remote: fatal: die with the --die-read-push-options option" out-0013-5 &&
 
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
@@ -191,17 +191,17 @@ test_expect_success "setup proc-receive hook (hook --die-write-report, $PROTOCOL
 test_expect_success "proc-receive: bad protocol (hook --die-write-report, $PROTOCOL)" '
 	test_must_fail git -C workbench push origin \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
+		>out-0013-6 2>&1 &&
 	filter_out_user_friendly_and_stable_output \
 		-e "/^To / { p; }" \
 		-e "/^ ! / { p; }" \
-		<out >actual &&
+		<out-0013-6 >actual &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
 	 ! [remote rejected] HEAD -> refs/for/main/topic (fail to run proc-receive hook)
 	EOF
 	test_cmp expect actual &&
-	grep "remote: fatal: die with the --die-write-report option" out &&
+	grep "remote: fatal: die with the --die-write-report option" out-0013-6 &&
 
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
@@ -224,8 +224,8 @@ test_expect_success "setup proc-receive hook (no report, $PROTOCOL)" '
 test_expect_success "proc-receive: bad protocol (no report, $PROTOCOL)" '
 	test_must_fail git -C workbench push origin \
 		HEAD:refs/heads/next \
-		HEAD:refs/for/main/topic >out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		HEAD:refs/for/main/topic >out-0013-7 2>&1 &&
+	make_user_friendly_and_stable_output <out-0013-7 >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
@@ -270,8 +270,8 @@ test_expect_success "setup proc-receive hook (no ref, $PROTOCOL)" '
 test_expect_success "proc-receive: bad protocol (no ref, $PROTOCOL)" '
 	test_must_fail git -C workbench push origin \
 		HEAD:refs/for/main/topic\
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-0013-8 2>&1 &&
+	make_user_friendly_and_stable_output <out-0013-8 >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
@@ -306,8 +306,8 @@ test_expect_success "setup proc-receive hook (unknown status, $PROTOCOL)" '
 test_expect_success "proc-receive: bad protocol (unknown status, $PROTOCOL)" '
 	test_must_fail git -C workbench push origin \
 			HEAD:refs/for/main/topic \
-			>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+			>out-0013-9 2>&1 &&
+	make_user_friendly_and_stable_output <out-0013-9 >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
diff --git a/t/t5411/test-0014-bad-protocol--porcelain.sh b/t/t5411/test-0014-bad-protocol--porcelain.sh
index fdb4569109..1ecf0a3976 100644
--- a/t/t5411/test-0014-bad-protocol--porcelain.sh
+++ b/t/t5411/test-0014-bad-protocol--porcelain.sh
@@ -11,8 +11,8 @@ test_expect_success "setup proc-receive hook (unknown version, $PROTOCOL/porcela
 test_expect_success "proc-receive: bad protocol (unknown version, $PROTOCOL/porcelain)" '
 	test_must_fail git -C workbench push --porcelain origin \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-0014-1 2>&1 &&
+	make_user_friendly_and_stable_output <out-0014-1 >actual &&
 
 	# Check status report for git-push
 	sed -n \
@@ -55,18 +55,18 @@ test_expect_success "setup proc-receive hook (hook --die-read-version, $PROTOCOL
 test_expect_success "proc-receive: bad protocol (hook --die-read-version, $PROTOCOL/porcelain)" '
 	test_must_fail git -C workbench push --porcelain origin \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
+		>out-0014-2 2>&1 &&
 	filter_out_user_friendly_and_stable_output \
 		-e "/^To / { p; n; p; n; p; }" \
-		<out >actual &&
+		<out-0014-2 >actual &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
 	!    HEAD:refs/for/main/topic    [remote rejected] (fail to run proc-receive hook)
 	Done
 	EOF
 	test_cmp expect actual &&
-	grep "remote: fatal: die with the --die-read-version option" out &&
-	grep "remote: error: fail to negotiate version with proc-receive hook" out &&
+	grep "remote: fatal: die with the --die-read-version option" out-0014-2 &&
+	grep "remote: error: fail to negotiate version with proc-receive hook" out-0014-2 &&
 
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
@@ -89,18 +89,18 @@ test_expect_success "setup proc-receive hook (hook --die-write-version, $PROTOCO
 test_expect_success "proc-receive: bad protocol (hook --die-write-version, $PROTOCOL/porcelain)" '
 	test_must_fail git -C workbench push --porcelain origin \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
+		>out-0014-3 2>&1 &&
 	filter_out_user_friendly_and_stable_output \
 		-e "/^To / { p; n; p; n; p; }" \
-		<out >actual &&
+		<out-0014-3 >actual &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
 	!    HEAD:refs/for/main/topic    [remote rejected] (fail to run proc-receive hook)
 	Done
 	EOF
 	test_cmp expect actual &&
-	grep "remote: fatal: die with the --die-write-version option" out &&
-	grep "remote: error: fail to negotiate version with proc-receive hook" out &&
+	grep "remote: fatal: die with the --die-write-version option" out-0014-3 &&
+	grep "remote: error: fail to negotiate version with proc-receive hook" out-0014-3 &&
 
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
@@ -123,17 +123,17 @@ test_expect_success "setup proc-receive hook (hook --die-read-commands, $PROTOCO
 test_expect_success "proc-receive: bad protocol (hook --die-read-commands, $PROTOCOL/porcelain)" '
 	test_must_fail git -C workbench push --porcelain origin \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
+		>out-0014-4 2>&1 &&
 	filter_out_user_friendly_and_stable_output \
 		-e "/^To / { p; n; p; n; p; }" \
-		<out >actual &&
+		<out-0014-4 >actual &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
 	!    HEAD:refs/for/main/topic    [remote rejected] (fail to run proc-receive hook)
 	Done
 	EOF
 	test_cmp expect actual &&
-	grep "remote: fatal: die with the --die-read-commands option" out &&
+	grep "remote: fatal: die with the --die-read-commands option" out-0014-4 &&
 
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
@@ -158,17 +158,17 @@ test_expect_success "proc-receive: bad protocol (hook --die-read-push-options, $
 	test_must_fail git -C workbench push --porcelain origin \
 		-o reviewers=user1,user2 \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
+		>out-0014-5 2>&1 &&
 	filter_out_user_friendly_and_stable_output \
 		-e "/^To / { p; n; p; n; p; }" \
-		<out >actual &&
+		<out-0014-5 >actual &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
 	!    HEAD:refs/for/main/topic    [remote rejected] (fail to run proc-receive hook)
 	Done
 	EOF
 	test_cmp expect actual &&
-	grep "remote: fatal: die with the --die-read-push-options option" out &&
+	grep "remote: fatal: die with the --die-read-push-options option" out-0014-5 &&
 
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
@@ -191,17 +191,17 @@ test_expect_success "setup proc-receive hook (hook --die-write-report, $PROTOCOL
 test_expect_success "proc-receive: bad protocol (hook --die-write-report, $PROTOCOL/porcelain)" '
 	test_must_fail git -C workbench push --porcelain origin \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
+		>out-0014-6 2>&1 &&
 	filter_out_user_friendly_and_stable_output \
 		-e "/^To / { p; n; p; n; p; }" \
-		<out >actual &&
+		<out-0014-6 >actual &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
 	!    HEAD:refs/for/main/topic    [remote rejected] (fail to run proc-receive hook)
 	Done
 	EOF
 	test_cmp expect actual &&
-	grep "remote: fatal: die with the --die-write-report option" out &&
+	grep "remote: fatal: die with the --die-write-report option" out-0014-6 &&
 
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
@@ -224,8 +224,8 @@ test_expect_success "setup proc-receive hook (no report, $PROTOCOL/porcelain)" '
 test_expect_success "proc-receive: bad protocol (no report, $PROTOCOL/porcelain)" '
 	test_must_fail git -C workbench push --porcelain origin \
 		HEAD:refs/heads/next \
-		HEAD:refs/for/main/topic >out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		HEAD:refs/for/main/topic >out-0014-7 2>&1 &&
+	make_user_friendly_and_stable_output <out-0014-7 >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
@@ -270,8 +270,8 @@ test_expect_success "setup proc-receive hook (no ref, $PROTOCOL/porcelain)" '
 test_expect_success "proc-receive: bad protocol (no ref, $PROTOCOL/porcelain)" '
 	test_must_fail git -C workbench push --porcelain origin \
 		HEAD:refs/for/main/topic\
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-0014-8 2>&1 &&
+	make_user_friendly_and_stable_output <out-0014-8 >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
@@ -307,8 +307,8 @@ test_expect_success "setup proc-receive hook (unknown status, $PROTOCOL/porcelai
 test_expect_success "proc-receive: bad protocol (unknown status, $PROTOCOL/porcelain)" '
 	test_must_fail git -C workbench push --porcelain origin \
 			HEAD:refs/for/main/topic \
-			>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+			>out-0014-9 2>&1 &&
+	make_user_friendly_and_stable_output <out-0014-9 >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
diff --git a/t/t5411/test-0020-report-ng.sh b/t/t5411/test-0020-report-ng.sh
index 5a9e0daf2d..41efafc55e 100644
--- a/t/t5411/test-0020-report-ng.sh
+++ b/t/t5411/test-0020-report-ng.sh
@@ -12,8 +12,8 @@ test_expect_success "setup proc-receive hook (ng, no message, $PROTOCOL)" '
 test_expect_success "proc-receive: fail to update (ng, no message, $PROTOCOL)" '
 	test_must_fail git -C workbench push origin \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-0020-1 2>&1 &&
+	make_user_friendly_and_stable_output <out-0020-1 >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
@@ -46,8 +46,8 @@ test_expect_success "setup proc-receive hook (ng message, $PROTOCOL)" '
 test_expect_success "proc-receive: fail to update (ng, with message, $PROTOCOL)" '
 	test_must_fail git -C workbench push origin \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-0020-2 2>&1 &&
+	make_user_friendly_and_stable_output <out-0020-2 >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
diff --git a/t/t5411/test-0021-report-ng--porcelain.sh b/t/t5411/test-0021-report-ng--porcelain.sh
index 93475a83cf..65b22618cc 100644
--- a/t/t5411/test-0021-report-ng--porcelain.sh
+++ b/t/t5411/test-0021-report-ng--porcelain.sh
@@ -12,8 +12,8 @@ test_expect_success "setup proc-receive hook (ng, no message, $PROTOCOL/porcelai
 test_expect_success "proc-receive: fail to update (ng, no message, $PROTOCOL/porcelain)" '
 	test_must_fail git -C workbench push --porcelain origin \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-0021-1 2>&1 &&
+	make_user_friendly_and_stable_output <out-0021-1 >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
@@ -47,8 +47,8 @@ test_expect_success "setup proc-receive hook (ng message, $PROTOCOL/porcelain)"
 test_expect_success "proc-receive: fail to update (ng, with message, $PROTOCOL/porcelain)" '
 	test_must_fail git -C workbench push --porcelain origin \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-0021-2 2>&1 &&
+	make_user_friendly_and_stable_output <out-0021-2 >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
diff --git a/t/t5411/test-0022-report-unexpect-ref.sh b/t/t5411/test-0022-report-unexpect-ref.sh
index f8be8a0ba1..4cbd474678 100644
--- a/t/t5411/test-0022-report-unexpect-ref.sh
+++ b/t/t5411/test-0022-report-unexpect-ref.sh
@@ -13,8 +13,8 @@ test_expect_success "proc-receive: report unexpected ref ($PROTOCOL)" '
 	test_must_fail git -C workbench push origin \
 		$B:refs/heads/main \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-0022-1 2>&1 &&
+	make_user_friendly_and_stable_output <out-0022-1 >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
diff --git a/t/t5411/test-0023-report-unexpect-ref--porcelain.sh b/t/t5411/test-0023-report-unexpect-ref--porcelain.sh
index 778150fa03..7804b87721 100644
--- a/t/t5411/test-0023-report-unexpect-ref--porcelain.sh
+++ b/t/t5411/test-0023-report-unexpect-ref--porcelain.sh
@@ -13,8 +13,8 @@ test_expect_success "proc-receive: report unexpected ref ($PROTOCOL/porcelain)"
 	test_must_fail git -C workbench push --porcelain origin \
 		$B:refs/heads/main \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-0023-1 2>&1 &&
+	make_user_friendly_and_stable_output <out-0023-1 >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
diff --git a/t/t5411/test-0024-report-unknown-ref.sh b/t/t5411/test-0024-report-unknown-ref.sh
index d4e74e4681..a048cb0f02 100644
--- a/t/t5411/test-0024-report-unknown-ref.sh
+++ b/t/t5411/test-0024-report-unknown-ref.sh
@@ -12,8 +12,8 @@ test_expect_success "setup proc-receive hook (unexpected ref, $PROTOCOL)" '
 test_expect_success "proc-receive: report unknown reference ($PROTOCOL)" '
 	test_must_fail git -C workbench push origin \
 		HEAD:refs/for/a/b/c/my/topic \
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-0024-1 2>&1 &&
+	make_user_friendly_and_stable_output <out-0024-1 >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/my/topic
diff --git a/t/t5411/test-0025-report-unknown-ref--porcelain.sh b/t/t5411/test-0025-report-unknown-ref--porcelain.sh
index 039e8b6163..b3c4fe6330 100644
--- a/t/t5411/test-0025-report-unknown-ref--porcelain.sh
+++ b/t/t5411/test-0025-report-unknown-ref--porcelain.sh
@@ -12,8 +12,8 @@ test_expect_success "setup proc-receive hook (unexpected ref, $PROTOCOL/porcelai
 test_expect_success "proc-receive: report unknown reference ($PROTOCOL/porcelain)" '
 	test_must_fail git -C workbench push --porcelain origin \
 		HEAD:refs/for/a/b/c/my/topic \
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-0025-1 2>&1 &&
+	make_user_friendly_and_stable_output <out-0025-1 >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/my/topic
diff --git a/t/t5411/test-0026-push-options.sh b/t/t5411/test-0026-push-options.sh
index e88edb16a4..7bc627cee6 100644
--- a/t/t5411/test-0026-push-options.sh
+++ b/t/t5411/test-0026-push-options.sh
@@ -16,8 +16,8 @@ test_expect_success "proc-receive: not support push options ($PROTOCOL)" '
 		-o reviewer=user1 \
 		origin \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-0026-1 2>&1 &&
+	make_user_friendly_and_stable_output <out-0026-1 >actual &&
 	test_i18ngrep "fatal: the receiving end does not support push options" \
 		actual &&
 	git -C "$upstream" show-ref >out &&
diff --git a/t/t5411/test-0027-push-options--porcelain.sh b/t/t5411/test-0027-push-options--porcelain.sh
index 3a6561b5ea..5b4884a260 100644
--- a/t/t5411/test-0027-push-options--porcelain.sh
+++ b/t/t5411/test-0027-push-options--porcelain.sh
@@ -17,8 +17,8 @@ test_expect_success "proc-receive: not support push options ($PROTOCOL/porcelain
 		-o reviewer=user1 \
 		origin \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-0027-1 2>&1 &&
+	make_user_friendly_and_stable_output <out-0027-1 >actual &&
 	test_i18ngrep "fatal: the receiving end does not support push options" \
 		actual &&
 	git -C "$upstream" show-ref >out &&
diff --git a/t/t5411/test-0032-report-with-options.sh b/t/t5411/test-0032-report-with-options.sh
index a0faf5c7ff..f5c67a1cc3 100644
--- a/t/t5411/test-0032-report-with-options.sh
+++ b/t/t5411/test-0032-report-with-options.sh
@@ -13,8 +13,8 @@ test_expect_success "setup proc-receive hook (option without matching ok, $PROTO
 test_expect_success "proc-receive: report option without matching ok ($PROTOCOL)" '
 	test_must_fail git -C workbench push origin \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-0032-1 2>&1 &&
+	make_user_friendly_and_stable_output <out-0032-1 >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
diff --git a/t/t5411/test-0033-report-with-options--porcelain.sh b/t/t5411/test-0033-report-with-options--porcelain.sh
index 32ae26bcfb..35e785a0fb 100644
--- a/t/t5411/test-0033-report-with-options--porcelain.sh
+++ b/t/t5411/test-0033-report-with-options--porcelain.sh
@@ -13,8 +13,8 @@ test_expect_success "setup proc-receive hook (option without matching ok, $PROTO
 test_expect_success "proc-receive: report option without matching ok ($PROTOCOL/porcelain)" '
 	test_must_fail git -C workbench push --porcelain origin \
 		HEAD:refs/for/main/topic \
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-0033-1 2>&1 &&
+	make_user_friendly_and_stable_output <out-0033-1 >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
diff --git a/t/t5411/test-0038-report-mixed-refs.sh b/t/t5411/test-0038-report-mixed-refs.sh
index 0d071ebaa6..0c31447aaa 100644
--- a/t/t5411/test-0038-report-mixed-refs.sh
+++ b/t/t5411/test-0038-report-mixed-refs.sh
@@ -24,8 +24,8 @@ test_expect_success "proc-receive: report update of mixed refs ($PROTOCOL)" '
 		HEAD:refs/heads/foo \
 		HEAD:refs/for/main/topic \
 		HEAD:refs/for/next/topic3 \
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-0038-1 2>&1 &&
+	make_user_friendly_and_stable_output <out-0038-1 >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
diff --git a/t/t5411/test-0039-report-mixed-refs--porcelain.sh b/t/t5411/test-0039-report-mixed-refs--porcelain.sh
index d8409912fd..7007dd98fc 100644
--- a/t/t5411/test-0039-report-mixed-refs--porcelain.sh
+++ b/t/t5411/test-0039-report-mixed-refs--porcelain.sh
@@ -24,8 +24,8 @@ test_expect_success "proc-receive: report update of mixed refs ($PROTOCOL/porcel
 		HEAD:refs/heads/foo \
 		HEAD:refs/for/main/topic \
 		HEAD:refs/for/next/topic3 \
-		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
+		>out-0039-1 2>&1 &&
+	make_user_friendly_and_stable_output <out-0039-1 >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
-- 
2.28.0.15.gba9e81f0bd

