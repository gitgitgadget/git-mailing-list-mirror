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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0000C433DB
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 13:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60098221EB
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 13:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392221AbhARNcR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 08:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392329AbhARNbS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 08:31:18 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A34C061574
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 05:30:37 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id e9so4496033plh.3
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 05:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9agrTWTHFmsUY1eE8dN68yYPhF/oWhWJZPc+ri76juc=;
        b=HxL8DIue8FQvkbcC4f11m94BGX54Zu5ZXLuapS1/7x5TprsoSXisFBY7z0jJtE1yWw
         4272RxYjr3A04YmUDJibfkp7HhCD0lOB9X427QnlOAqIVTQvDiversQbtFAn4KQXMn5A
         cyJEZmhaw11kZZ20Dys0AYkVJmEOFUfom4zAEurIKGRq3J3EklY73qS8ZlSOvWbZDpzN
         ALWYm6e0T5lea64epwKLRqGWL1sIWxdwZmFehQkb5WynhMqy0Qgqkmx7m6mvUWV36CrK
         IylW8n+CML9ABOKpwYHnxWsJf/tSNohnYdslLZh3ub+5r8KN46laSu7q0RBTmXXhXQKa
         zYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9agrTWTHFmsUY1eE8dN68yYPhF/oWhWJZPc+ri76juc=;
        b=g7yqfHpyKIRlC54hDOS+EYkGX9CSo/PUXI7IMD9yQeF8AOPXoRQ+bc9of4eD6r0Ztk
         hwpUvNNjq9VchjQ9jBe+iUJW/Q4QEqfB/JVsbqsmPIPKjTuQcBgQTrWHZe/C0IlEKrbf
         rP5PqDD5+nttTOUKVdOaVU2G+Izl8q7Mc3dWtR+xoS+6QFK3s+HbTl53g0ovMf50+V56
         /Ht/ReKLcbWY6DR3FbTOSSZMY8qcsnkhMUFTOi3u1H3ujqOkZYGOAn8T+rn30Igqwt61
         +eqMns4roW+s0YX+mp6ZkUrpq+UhMYk8l1tXES44PPp6qEAfNBjM+H5FjzN2dVpulex5
         XTZg==
X-Gm-Message-State: AOAM530IoRayhtQ693EqgzZpDdkGCT45Cy0SenavRdYS7j/mOdAXb/0E
        lJ/vALwW/81qVqqieMWH3YI=
X-Google-Smtp-Source: ABdhPJxKxCjMH70Bwv36+M+DbV+Onc0cl/DhOznxth6yUWbobEyg4+kSTQgR4CuoqL6FoaMGcq7qyg==
X-Received: by 2002:a17:90a:70ce:: with SMTP id a14mr13204986pjm.19.1610976636982;
        Mon, 18 Jan 2021 05:30:36 -0800 (PST)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id m11sm3160010pjz.44.2021.01.18.05.30.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2021 05:30:35 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH 2/2] t5411: refactor check of refs using test_cmp_refs
Date:   Mon, 18 Jan 2021 08:30:11 -0500
Message-Id: <20210118133011.15331-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20210117222151.GY8396@szeder.dev>
References: <20210117222151.GY8396@szeder.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Add new helper 'test_cmp_refs' to check references in a repository.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t5411/common-functions.sh                   | 15 +++++++
 t/t5411/once-0010-report-status-v1.sh         |  5 +--
 t/t5411/test-0000-standard-git-push.sh        | 24 ++++------
 .../test-0001-standard-git-push--porcelain.sh | 24 ++++------
 t/t5411/test-0002-pre-receive-declined.sh     |  6 +--
 ...st-0003-pre-receive-declined--porcelain.sh |  6 +--
 t/t5411/test-0011-no-hook-error.sh            | 12 ++---
 t/t5411/test-0012-no-hook-error--porcelain.sh | 12 ++---
 t/t5411/test-0013-bad-protocol.sh             | 45 ++++---------------
 t/t5411/test-0014-bad-protocol--porcelain.sh  | 45 ++++---------------
 t/t5411/test-0020-report-ng.sh                | 12 ++---
 t/t5411/test-0021-report-ng--porcelain.sh     | 12 ++---
 t/t5411/test-0022-report-unexpect-ref.sh      |  6 +--
 ...est-0023-report-unexpect-ref--porcelain.sh |  6 +--
 t/t5411/test-0024-report-unknown-ref.sh       |  6 +--
 ...test-0025-report-unknown-ref--porcelain.sh |  6 +--
 t/t5411/test-0026-push-options.sh             | 18 +++-----
 t/t5411/test-0027-push-options--porcelain.sh  | 18 +++-----
 t/t5411/test-0030-report-ok.sh                |  6 +--
 t/t5411/test-0031-report-ok--porcelain.sh     |  6 +--
 t/t5411/test-0032-report-with-options.sh      |  5 +--
 ...est-0033-report-with-options--porcelain.sh |  5 +--
 t/t5411/test-0034-report-ft.sh                |  6 +--
 t/t5411/test-0035-report-ft--porcelain.sh     |  6 +--
 ...t-0036-report-multi-rewrite-for-one-ref.sh | 18 +++-----
 ...rt-multi-rewrite-for-one-ref--porcelain.sh | 18 +++-----
 t/t5411/test-0038-report-mixed-refs.sh        |  6 +--
 .../test-0039-report-mixed-refs--porcelain.sh |  6 +--
 t/t5411/test-0040-process-all-refs.sh         |  6 +--
 .../test-0041-process-all-refs--porcelain.sh  |  6 +--
 ...t-0050-proc-receive-refs-with-modifiers.sh | 18 +++-----
 31 files changed, 126 insertions(+), 264 deletions(-)

diff --git a/t/t5411/common-functions.sh b/t/t5411/common-functions.sh
index 344d13f61a..4835dd5182 100644
--- a/t/t5411/common-functions.sh
+++ b/t/t5411/common-functions.sh
@@ -59,3 +59,18 @@ filter_out_user_friendly_and_stable_output () {
 	make_user_friendly_and_stable_output |
 		sed -n ${1+"$@"}
 }
+
+test_cmp_refs () {
+	indir=
+	if test "$1" = "-C"
+	then
+		shift
+		indir="$1"
+		shift
+	fi
+	indir=${indir:+"$indir"/}
+	cat >show-ref.expect &&
+	git ${indir:+ -C "$indir"} show-ref >show-ref.pristine &&
+	make_user_friendly_and_stable_output <show-ref.pristine >show-ref.filtered &&
+	test_cmp show-ref.expect show-ref.filtered
+}
diff --git a/t/t5411/once-0010-report-status-v1.sh b/t/t5411/once-0010-report-status-v1.sh
index cb431a9c91..1233a46eac 100644
--- a/t/t5411/once-0010-report-status-v1.sh
+++ b/t/t5411/once-0010-report-status-v1.sh
@@ -83,12 +83,9 @@ test_expect_success "proc-receive: report status v1" '
 	EOF
 	test_cmp expect actual &&
 
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/for/main/topic1
 	<COMMIT-A> refs/heads/foo
 	<COMMIT-B> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
diff --git a/t/t5411/test-0000-standard-git-push.sh b/t/t5411/test-0000-standard-git-push.sh
index 694d8e8dc2..7af6026749 100644
--- a/t/t5411/test-0000-standard-git-push.sh
+++ b/t/t5411/test-0000-standard-git-push.sh
@@ -19,13 +19,11 @@ test_expect_success "git-push ($PROTOCOL)" '
 	 * [new branch] HEAD -> next
 	EOF
 	test_cmp expect actual &&
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-B> refs/heads/main
 	<COMMIT-A> refs/heads/next
 	EOF
-	test_cmp expect actual
 '
 
 # Refs of upstream : main(B)  next(A)
@@ -48,13 +46,11 @@ test_expect_success "git-push --atomic ($PROTOCOL)" '
 	 ! [rejected] <COMMIT-B> -> next (atomic push failed)
 	EOF
 	test_cmp expect actual &&
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-B> refs/heads/main
 	<COMMIT-A> refs/heads/next
 	EOF
-	test_cmp expect actual
 '
 
 # Refs of upstream : main(B)  next(A)
@@ -81,13 +77,11 @@ test_expect_success "non-fast-forward git-push ($PROTOCOL)" '
 	 ! [rejected] main -> main (non-fast-forward)
 	EOF
 	test_cmp expect actual &&
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-B> refs/heads/main
 	<COMMIT-B> refs/heads/next
 	EOF
-	test_cmp expect actual
 '
 
 # Refs of upstream : main(B)  next(B)
@@ -123,15 +117,13 @@ test_expect_success "git-push -f ($PROTOCOL)" '
 	 * [new branch] HEAD -> a/b/c
 	EOF
 	test_cmp expect actual &&
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/a/b/c
 	<COMMIT-A> refs/heads/main
 	<COMMIT-A> refs/review/main/topic
 	<TAG-v123> refs/tags/v123
 	EOF
-	test_cmp expect actual
 '
 
 # Refs of upstream : main(A)  tags/v123  refs/review/main/topic(A)  a/b/c(A)
diff --git a/t/t5411/test-0001-standard-git-push--porcelain.sh b/t/t5411/test-0001-standard-git-push--porcelain.sh
index 6cf0bc7034..9e5c40f39c 100644
--- a/t/t5411/test-0001-standard-git-push--porcelain.sh
+++ b/t/t5411/test-0001-standard-git-push--porcelain.sh
@@ -20,13 +20,11 @@ test_expect_success "git-push ($PROTOCOL/porcelain)" '
 	Done
 	EOF
 	test_cmp expect actual &&
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-B> refs/heads/main
 	<COMMIT-A> refs/heads/next
 	EOF
-	test_cmp expect actual
 '
 
 # Refs of upstream : main(B)  next(A)
@@ -50,13 +48,11 @@ test_expect_success "git-push --atomic ($PROTOCOL/porcelain)" '
 	!    <COMMIT-B>:refs/heads/next    [rejected] (atomic push failed)
 	EOF
 	test_cmp expect actual &&
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-B> refs/heads/main
 	<COMMIT-A> refs/heads/next
 	EOF
-	test_cmp expect actual
 '
 
 # Refs of upstream : main(B)  next(A)
@@ -84,13 +80,11 @@ test_expect_success "non-fast-forward git-push ($PROTOCOL/porcelain)" '
 	Done
 	EOF
 	test_cmp expect actual &&
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-B> refs/heads/main
 	<COMMIT-B> refs/heads/next
 	EOF
-	test_cmp expect actual
 '
 
 # Refs of upstream : main(B)  next(B)
@@ -127,15 +121,13 @@ test_expect_success "git-push -f ($PROTOCOL/porcelain)" '
 	Done
 	EOF
 	test_cmp expect actual &&
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/a/b/c
 	<COMMIT-A> refs/heads/main
 	<COMMIT-A> refs/review/main/topic
 	<TAG-v123> refs/tags/v123
 	EOF
-	test_cmp expect actual
 '
 
 # Refs of upstream : main(A)  tags/v123  refs/review/main/topic(A)  a/b/c(A)
diff --git a/t/t5411/test-0002-pre-receive-declined.sh b/t/t5411/test-0002-pre-receive-declined.sh
index 61c3ee1b7f..7c70d45057 100644
--- a/t/t5411/test-0002-pre-receive-declined.sh
+++ b/t/t5411/test-0002-pre-receive-declined.sh
@@ -22,12 +22,10 @@ test_expect_success "git-push is declined ($PROTOCOL)" '
 	 ! [remote rejected] HEAD -> next (pre-receive hook declined)
 	EOF
 	test_cmp expect actual &&
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
 
 test_expect_success "cleanup ($PROTOCOL)" '
diff --git a/t/t5411/test-0003-pre-receive-declined--porcelain.sh b/t/t5411/test-0003-pre-receive-declined--porcelain.sh
index 0a9cc2d44a..ea38248fc5 100644
--- a/t/t5411/test-0003-pre-receive-declined--porcelain.sh
+++ b/t/t5411/test-0003-pre-receive-declined--porcelain.sh
@@ -23,12 +23,10 @@ test_expect_success "git-push is declined ($PROTOCOL/porcelain)" '
 	Done
 	EOF
 	test_cmp expect actual &&
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
 
 test_expect_success "cleanup ($PROTOCOL/porcelain)" '
diff --git a/t/t5411/test-0011-no-hook-error.sh b/t/t5411/test-0011-no-hook-error.sh
index fd2bd20b76..778b833f9d 100644
--- a/t/t5411/test-0011-no-hook-error.sh
+++ b/t/t5411/test-0011-no-hook-error.sh
@@ -21,13 +21,11 @@ test_expect_success "proc-receive: no hook, fail to push special ref ($PROTOCOL)
 	 ! [remote rejected] HEAD -> refs/for/main/topic (fail to run proc-receive hook)
 	EOF
 	test_cmp expect actual &&
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	<COMMIT-A> refs/heads/next
 	EOF
-	test_cmp expect actual
 '
 
 # Refs of upstream : main(A)             next(A)
@@ -59,10 +57,8 @@ test_expect_success "proc-receive: no hook, all failed for atomic push ($PROTOCO
 	 ! [remote rejected] HEAD -> refs/for/main/topic (fail to run proc-receive hook)
 	EOF
 	test_cmp expect actual &&
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
diff --git a/t/t5411/test-0012-no-hook-error--porcelain.sh b/t/t5411/test-0012-no-hook-error--porcelain.sh
index 025a9c7186..371831d170 100644
--- a/t/t5411/test-0012-no-hook-error--porcelain.sh
+++ b/t/t5411/test-0012-no-hook-error--porcelain.sh
@@ -22,13 +22,11 @@ test_expect_success "proc-receive: no hook, fail to push special ref ($PROTOCOL/
 	Done
 	EOF
 	test_cmp expect actual &&
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	<COMMIT-A> refs/heads/next
 	EOF
-	test_cmp expect actual
 '
 
 # Refs of upstream : main(A)             next(A)
@@ -61,10 +59,8 @@ test_expect_success "proc-receive: no hook, all failed for atomic push ($PROTOCO
 	Done
 	EOF
 	test_cmp expect actual &&
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
diff --git a/t/t5411/test-0013-bad-protocol.sh b/t/t5411/test-0013-bad-protocol.sh
index d20a4e6681..43d37f4109 100644
--- a/t/t5411/test-0013-bad-protocol.sh
+++ b/t/t5411/test-0013-bad-protocol.sh
@@ -36,12 +36,9 @@ test_expect_success "proc-receive: bad protocol (unknown version, $PROTOCOL)" '
 	EOF
 	test_cmp expect actual-error &&
 
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
 
 test_expect_success "setup proc-receive hook (hook --die-read-version, $PROTOCOL)" '
@@ -72,12 +69,9 @@ test_expect_success "proc-receive: bad protocol (hook --die-read-version, $PROTO
 	# Prevent accidential changes by the internal "receive-pack" process.
 	rm out &&
 
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
 
 test_expect_success "setup proc-receive hook (hook --die-write-version, $PROTOCOL)" '
@@ -108,12 +102,9 @@ test_expect_success "proc-receive: bad protocol (hook --die-write-version, $PROT
 	# Prevent accidential changes by the internal "receive-pack" process.
 	rm out &&
 
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
 
 test_expect_success "setup proc-receive hook (hook --die-read-commands, $PROTOCOL)" '
@@ -143,12 +134,9 @@ test_expect_success "proc-receive: bad protocol (hook --die-read-commands, $PROT
 	# Prevent accidential changes by the internal "receive-pack" process.
 	rm out &&
 
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
 
 test_expect_success "setup proc-receive hook (hook --die-read-push-options, $PROTOCOL)" '
@@ -180,12 +168,9 @@ test_expect_success "proc-receive: bad protocol (hook --die-read-push-options, $
 	# Prevent accidential changes by the internal "receive-pack" process.
 	rm out &&
 
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
 
 test_expect_success "setup proc-receive hook (hook --die-write-report, $PROTOCOL)" '
@@ -215,12 +200,9 @@ test_expect_success "proc-receive: bad protocol (hook --die-write-report, $PROTO
 	# Prevent accidential changes by the internal "receive-pack" process.
 	rm out &&
 
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
 
 test_expect_success "setup proc-receive hook (no report, $PROTOCOL)" '
@@ -254,13 +236,10 @@ test_expect_success "proc-receive: bad protocol (no report, $PROTOCOL)" '
 	EOF
 	test_cmp expect actual &&
 
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	<COMMIT-A> refs/heads/next
 	EOF
-	test_cmp expect actual
 '
 
 # Refs of upstream : main(A)             next(A)
@@ -300,12 +279,9 @@ test_expect_success "proc-receive: bad protocol (no ref, $PROTOCOL)" '
 	EOF
 	test_cmp expect actual &&
 
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
 
 test_expect_success "setup proc-receive hook (unknown status, $PROTOCOL)" '
@@ -338,10 +314,7 @@ test_expect_success "proc-receive: bad protocol (unknown status, $PROTOCOL)" '
 	EOF
 	test_cmp expect actual &&
 
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
diff --git a/t/t5411/test-0014-bad-protocol--porcelain.sh b/t/t5411/test-0014-bad-protocol--porcelain.sh
index a286030f3e..c6299b4849 100644
--- a/t/t5411/test-0014-bad-protocol--porcelain.sh
+++ b/t/t5411/test-0014-bad-protocol--porcelain.sh
@@ -36,12 +36,9 @@ test_expect_success "proc-receive: bad protocol (unknown version, $PROTOCOL/porc
 	EOF
 	test_cmp expect actual-error &&
 
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
 
 test_expect_success "setup proc-receive hook (hook --die-read-version, $PROTOCOL/porcelain)" '
@@ -72,12 +69,9 @@ test_expect_success "proc-receive: bad protocol (hook --die-read-version, $PROTO
 	# Prevent accidential changes by the internal "receive-pack" process.
 	rm out &&
 
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
 
 test_expect_success "setup proc-receive hook (hook --die-write-version, $PROTOCOL/porcelain)" '
@@ -108,12 +102,9 @@ test_expect_success "proc-receive: bad protocol (hook --die-write-version, $PROT
 	# Prevent accidential changes by the internal "receive-pack" process.
 	rm out &&
 
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
 
 test_expect_success "setup proc-receive hook (hook --die-read-commands, $PROTOCOL/porcelain)" '
@@ -143,12 +134,9 @@ test_expect_success "proc-receive: bad protocol (hook --die-read-commands, $PROT
 	# Prevent accidential changes by the internal "receive-pack" process.
 	rm out &&
 
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
 
 test_expect_success "setup proc-receive hook (hook --die-read-push-options, $PROTOCOL/porcelain)" '
@@ -180,12 +168,9 @@ test_expect_success "proc-receive: bad protocol (hook --die-read-push-options, $
 	# Prevent accidential changes by the internal "receive-pack" process.
 	rm out &&
 
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
 
 test_expect_success "setup proc-receive hook (hook --die-write-report, $PROTOCOL/porcelain)" '
@@ -215,12 +200,9 @@ test_expect_success "proc-receive: bad protocol (hook --die-write-report, $PROTO
 	# Prevent accidential changes by the internal "receive-pack" process.
 	rm out &&
 
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
 
 test_expect_success "setup proc-receive hook (no report, $PROTOCOL/porcelain)" '
@@ -255,13 +237,10 @@ test_expect_success "proc-receive: bad protocol (no report, $PROTOCOL/porcelain)
 	EOF
 	test_cmp expect actual &&
 
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	<COMMIT-A> refs/heads/next
 	EOF
-	test_cmp expect actual
 '
 
 # Refs of upstream : main(A)             next(A)
@@ -301,12 +280,9 @@ test_expect_success "proc-receive: bad protocol (no ref, $PROTOCOL/porcelain)" '
 	EOF
 	test_cmp expect actual &&
 
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
 
 test_expect_success "setup proc-receive hook (unknown status, $PROTOCOL/porcelain)" '
@@ -340,10 +316,7 @@ test_expect_success "proc-receive: bad protocol (unknown status, $PROTOCOL/porce
 	EOF
 	test_cmp expect actual &&
 
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
diff --git a/t/t5411/test-0020-report-ng.sh b/t/t5411/test-0020-report-ng.sh
index 9f71da9fb6..37300d374b 100644
--- a/t/t5411/test-0020-report-ng.sh
+++ b/t/t5411/test-0020-report-ng.sh
@@ -26,12 +26,10 @@ test_expect_success "proc-receive: fail to update (ng, no message, $PROTOCOL)" '
 	 ! [remote rejected] HEAD -> refs/for/main/topic (failed)
 	EOF
 	test_cmp expect actual &&
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
 
 test_expect_success "setup proc-receive hook (ng message, $PROTOCOL)" '
@@ -62,10 +60,8 @@ test_expect_success "proc-receive: fail to update (ng, with message, $PROTOCOL)"
 	 ! [remote rejected] HEAD -> refs/for/main/topic (error msg)
 	EOF
 	test_cmp expect actual &&
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
diff --git a/t/t5411/test-0021-report-ng--porcelain.sh b/t/t5411/test-0021-report-ng--porcelain.sh
index 96065e3537..c40eb1060b 100644
--- a/t/t5411/test-0021-report-ng--porcelain.sh
+++ b/t/t5411/test-0021-report-ng--porcelain.sh
@@ -27,12 +27,10 @@ test_expect_success "proc-receive: fail to update (ng, no message, $PROTOCOL/por
 	Done
 	EOF
 	test_cmp expect actual &&
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
 
 test_expect_success "setup proc-receive hook (ng message, $PROTOCOL/porcelain)" '
@@ -64,10 +62,8 @@ test_expect_success "proc-receive: fail to update (ng, with message, $PROTOCOL/p
 	Done
 	EOF
 	test_cmp expect actual &&
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
diff --git a/t/t5411/test-0022-report-unexpect-ref.sh b/t/t5411/test-0022-report-unexpect-ref.sh
index 624dda7acc..6c1716b25a 100644
--- a/t/t5411/test-0022-report-unexpect-ref.sh
+++ b/t/t5411/test-0022-report-unexpect-ref.sh
@@ -32,12 +32,10 @@ test_expect_success "proc-receive: report unexpected ref ($PROTOCOL)" '
 	 ! [remote rejected] HEAD -> refs/for/main/topic (proc-receive failed to report status)
 	EOF
 	test_cmp expect actual &&
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-B> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
 
 # Refs of upstream : main(B)
diff --git a/t/t5411/test-0023-report-unexpect-ref--porcelain.sh b/t/t5411/test-0023-report-unexpect-ref--porcelain.sh
index dcb804afc8..46f44cdad5 100644
--- a/t/t5411/test-0023-report-unexpect-ref--porcelain.sh
+++ b/t/t5411/test-0023-report-unexpect-ref--porcelain.sh
@@ -33,12 +33,10 @@ test_expect_success "proc-receive: report unexpected ref ($PROTOCOL/porcelain)"
 	Done
 	EOF
 	test_cmp expect actual &&
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-B> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
 
 # Refs of upstream : main(B)
diff --git a/t/t5411/test-0024-report-unknown-ref.sh b/t/t5411/test-0024-report-unknown-ref.sh
index af65355862..a543c5acf7 100644
--- a/t/t5411/test-0024-report-unknown-ref.sh
+++ b/t/t5411/test-0024-report-unknown-ref.sh
@@ -27,10 +27,8 @@ test_expect_success "proc-receive: report unknown reference ($PROTOCOL)" '
 	 ! [remote rejected] HEAD -> refs/for/a/b/c/my/topic (proc-receive failed to report status)
 	EOF
 	test_cmp expect actual &&
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
diff --git a/t/t5411/test-0025-report-unknown-ref--porcelain.sh b/t/t5411/test-0025-report-unknown-ref--porcelain.sh
index c336ec0e98..972df50ca7 100644
--- a/t/t5411/test-0025-report-unknown-ref--porcelain.sh
+++ b/t/t5411/test-0025-report-unknown-ref--porcelain.sh
@@ -28,10 +28,8 @@ test_expect_success "proc-receive: report unknown reference ($PROTOCOL/porcelain
 	Done
 	EOF
 	test_cmp expect actual &&
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
diff --git a/t/t5411/test-0026-push-options.sh b/t/t5411/test-0026-push-options.sh
index 46b1064fe6..049a474a0c 100644
--- a/t/t5411/test-0026-push-options.sh
+++ b/t/t5411/test-0026-push-options.sh
@@ -22,12 +22,10 @@ test_expect_success "proc-receive: not support push options ($PROTOCOL)" '
 	rm out &&
 	test_i18ngrep "fatal: the receiving end does not support push options" \
 		actual &&
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
 
 test_expect_success "enable push options ($PROTOCOL)" '
@@ -71,13 +69,11 @@ test_expect_success "proc-receive: ignore push-options for version 0 ($PROTOCOL)
 	 * [new reference] HEAD -> refs/for/main/topic
 	EOF
 	test_cmp expect actual &&
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	<COMMIT-A> refs/heads/next
 	EOF
-	test_cmp expect actual
 '
 
 test_expect_success "restore proc-receive hook ($PROTOCOL)" '
@@ -125,13 +121,11 @@ test_expect_success "proc-receive: push with options ($PROTOCOL)" '
 	 * [new reference] HEAD -> refs/for/main/topic
 	EOF
 	test_cmp expect actual &&
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	<COMMIT-A> refs/heads/next
 	EOF
-	test_cmp expect actual
 '
 
 # Refs of upstream : main(A)             next(A)
diff --git a/t/t5411/test-0027-push-options--porcelain.sh b/t/t5411/test-0027-push-options--porcelain.sh
index 79a49a638e..e0455b8b81 100644
--- a/t/t5411/test-0027-push-options--porcelain.sh
+++ b/t/t5411/test-0027-push-options--porcelain.sh
@@ -23,12 +23,10 @@ test_expect_success "proc-receive: not support push options ($PROTOCOL/porcelain
 	rm out &&
 	test_i18ngrep "fatal: the receiving end does not support push options" \
 		actual &&
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
 
 test_expect_success "enable push options ($PROTOCOL/porcelain)" '
@@ -74,13 +72,11 @@ test_expect_success "proc-receive: ignore push-options for version 0 ($PROTOCOL/
 	Done
 	EOF
 	test_cmp expect actual &&
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	<COMMIT-A> refs/heads/next
 	EOF
-	test_cmp expect actual
 '
 
 test_expect_success "restore proc-receive hook ($PROTOCOL/porcelain)" '
@@ -130,13 +126,11 @@ test_expect_success "proc-receive: push with options ($PROTOCOL/porcelain)" '
 	Done
 	EOF
 	test_cmp expect actual &&
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	<COMMIT-A> refs/heads/next
 	EOF
-	test_cmp expect actual
 '
 
 # Refs of upstream : main(A)             next(A)
diff --git a/t/t5411/test-0030-report-ok.sh b/t/t5411/test-0030-report-ok.sh
index 5d6feef118..8acb4f204f 100644
--- a/t/t5411/test-0030-report-ok.sh
+++ b/t/t5411/test-0030-report-ok.sh
@@ -26,10 +26,8 @@ test_expect_success "proc-receive: ok ($PROTOCOL)" '
 	 * [new reference] HEAD -> refs/for/main/topic
 	EOF
 	test_cmp expect actual &&
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
diff --git a/t/t5411/test-0031-report-ok--porcelain.sh b/t/t5411/test-0031-report-ok--porcelain.sh
index 91666d32df..a967718046 100644
--- a/t/t5411/test-0031-report-ok--porcelain.sh
+++ b/t/t5411/test-0031-report-ok--porcelain.sh
@@ -27,10 +27,8 @@ test_expect_success "proc-receive: ok ($PROTOCOL/porcelain)" '
 	Done
 	EOF
 	test_cmp expect actual &&
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
diff --git a/t/t5411/test-0032-report-with-options.sh b/t/t5411/test-0032-report-with-options.sh
index 4d058cc6ff..9711d69f1d 100644
--- a/t/t5411/test-0032-report-with-options.sh
+++ b/t/t5411/test-0032-report-with-options.sh
@@ -249,10 +249,7 @@ test_expect_success "proc-receive: report with multiple rewrites ($PROTOCOL)" '
 	EOF
 	test_cmp expect actual &&
 
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
diff --git a/t/t5411/test-0033-report-with-options--porcelain.sh b/t/t5411/test-0033-report-with-options--porcelain.sh
index 8ab908a6b0..7e699e8088 100644
--- a/t/t5411/test-0033-report-with-options--porcelain.sh
+++ b/t/t5411/test-0033-report-with-options--porcelain.sh
@@ -258,10 +258,7 @@ test_expect_success "proc-receive: report with multiple rewrites ($PROTOCOL/porc
 	EOF
 	test_cmp expect actual &&
 
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
diff --git a/t/t5411/test-0034-report-ft.sh b/t/t5411/test-0034-report-ft.sh
index c355c290d2..6e0d08b327 100644
--- a/t/t5411/test-0034-report-ft.sh
+++ b/t/t5411/test-0034-report-ft.sh
@@ -28,13 +28,11 @@ test_expect_success "proc-receive: fall throught, let receive-pack to execute ($
 	 * [new reference] <COMMIT-B> -> refs/for/main/topic
 	EOF
 	test_cmp expect actual &&
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-B> refs/for/main/topic
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
 
 # Refs of upstream : main(A)             refs/for/main/topic(A)
diff --git a/t/t5411/test-0035-report-ft--porcelain.sh b/t/t5411/test-0035-report-ft--porcelain.sh
index 8ce4e58f2a..81bae9f2ec 100644
--- a/t/t5411/test-0035-report-ft--porcelain.sh
+++ b/t/t5411/test-0035-report-ft--porcelain.sh
@@ -29,13 +29,11 @@ test_expect_success "proc-receive: fall throught, let receive-pack to execute ($
 	Done
 	EOF
 	test_cmp expect actual &&
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-B> refs/for/main/topic
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
 
 # Refs of upstream : main(A)             refs/for/main/topic(A)
diff --git a/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh b/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
index fad8eea8a0..be9b18b2b6 100644
--- a/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
+++ b/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
@@ -65,12 +65,10 @@ test_expect_success "proc-receive: multiple rewrite for one ref, no refname for
 	 <OID-A>..<OID-B> HEAD -> refs/changes/25/125/1
 	EOF
 	test_cmp expect actual &&
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
 
 test_expect_success "proc-receive: check remote-tracking #1 ($PROTOCOL)" '
@@ -142,12 +140,10 @@ test_expect_success "proc-receive: multiple rewrites for one ref, no refname for
 	 + <OID-B>...<OID-A> HEAD -> refs/changes/25/125/1 (forced update)
 	EOF
 	test_cmp expect actual &&
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
 
 test_expect_success "proc-receive: check remote-tracking #2 ($PROTOCOL)" '
@@ -205,12 +201,10 @@ test_expect_success "proc-receive: multiple rewrites for one ref ($PROTOCOL)" '
 	 <OID-A>..<OID-B> HEAD -> refs/changes/24/124/2
 	EOF
 	test_cmp expect actual &&
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
 
 test_expect_success "proc-receive: check remote-tracking #3 ($PROTOCOL)" '
diff --git a/t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh b/t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh
index dc254d57eb..95fb89c031 100644
--- a/t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh
+++ b/t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh
@@ -51,12 +51,10 @@ test_expect_success "proc-receive: multiple rewrite for one ref, no refname for
 	Done
 	EOF
 	test_cmp expect actual &&
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
 
 test_expect_success "setup proc-receive hook (multiple rewrites for one ref, no refname for the 2nd rewrite, $PROTOCOL/porcelain)" '
@@ -114,12 +112,10 @@ test_expect_success "proc-receive: multiple rewrites for one ref, no refname for
 	Done
 	EOF
 	test_cmp expect actual &&
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
 
 test_expect_success "setup proc-receive hook (multiple rewrites for one ref, $PROTOCOL/porcelain)" '
@@ -163,10 +159,8 @@ test_expect_success "proc-receive: multiple rewrites for one ref ($PROTOCOL/porc
 	Done
 	EOF
 	test_cmp expect actual &&
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
diff --git a/t/t5411/test-0038-report-mixed-refs.sh b/t/t5411/test-0038-report-mixed-refs.sh
index 264a5d5c6d..88fa60e53c 100644
--- a/t/t5411/test-0038-report-mixed-refs.sh
+++ b/t/t5411/test-0038-report-mixed-refs.sh
@@ -67,15 +67,13 @@ test_expect_success "proc-receive: report update of mixed refs ($PROTOCOL)" '
 	 ! [remote rejected] HEAD -> refs/for/next/topic3 (proc-receive failed to report status)
 	EOF
 	test_cmp expect actual &&
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/bar
 	<COMMIT-A> refs/heads/baz
 	<COMMIT-A> refs/heads/foo
 	<COMMIT-B> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
 
 # Refs of upstream : main(B)             foo(A)  bar(A))  baz(A)
diff --git a/t/t5411/test-0039-report-mixed-refs--porcelain.sh b/t/t5411/test-0039-report-mixed-refs--porcelain.sh
index 1e9c06d2b7..6c36d9250f 100644
--- a/t/t5411/test-0039-report-mixed-refs--porcelain.sh
+++ b/t/t5411/test-0039-report-mixed-refs--porcelain.sh
@@ -68,15 +68,13 @@ test_expect_success "proc-receive: report update of mixed refs ($PROTOCOL/porcel
 	Done
 	EOF
 	test_cmp expect actual &&
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/bar
 	<COMMIT-A> refs/heads/baz
 	<COMMIT-A> refs/heads/foo
 	<COMMIT-B> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
 
 # Refs of upstream : main(B)             foo(A)  bar(A))  baz(A)
diff --git a/t/t5411/test-0040-process-all-refs.sh b/t/t5411/test-0040-process-all-refs.sh
index 2565302a17..fdcdcc7c2e 100644
--- a/t/t5411/test-0040-process-all-refs.sh
+++ b/t/t5411/test-0040-process-all-refs.sh
@@ -92,14 +92,12 @@ test_expect_success "proc-receive: process all refs ($PROTOCOL)" '
 	 + <OID-B>...<OID-A> HEAD -> refs/pull/124/head (forced update)
 	EOF
 	test_cmp expect actual &&
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-B> refs/heads/bar
 	<COMMIT-A> refs/heads/baz
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
 
 # Refs of upstream : main(A)             bar(A)  baz(B)
diff --git a/t/t5411/test-0041-process-all-refs--porcelain.sh b/t/t5411/test-0041-process-all-refs--porcelain.sh
index e21420b60d..73b35fe0aa 100644
--- a/t/t5411/test-0041-process-all-refs--porcelain.sh
+++ b/t/t5411/test-0041-process-all-refs--porcelain.sh
@@ -93,14 +93,12 @@ test_expect_success "proc-receive: process all refs ($PROTOCOL/porcelain)" '
 	Done
 	EOF
 	test_cmp expect actual &&
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-B> refs/heads/bar
 	<COMMIT-A> refs/heads/baz
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
 
 # Refs of upstream : main(A)             bar(A)  baz(B)
diff --git a/t/t5411/test-0050-proc-receive-refs-with-modifiers.sh b/t/t5411/test-0050-proc-receive-refs-with-modifiers.sh
index 2e29518ec5..7214647ada 100644
--- a/t/t5411/test-0050-proc-receive-refs-with-modifiers.sh
+++ b/t/t5411/test-0050-proc-receive-refs-with-modifiers.sh
@@ -50,12 +50,10 @@ test_expect_success "proc-receive: update branch and new tag ($PROTOCOL)" '
 	 * [new reference] v123 -> refs/pull/124/head
 	EOF
 	test_cmp expect actual &&
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
 
 # Refs of upstream : main(A)
@@ -63,14 +61,12 @@ test_expect_success "proc-receive: update branch and new tag ($PROTOCOL)" '
 test_expect_success "setup upstream: create tags/v123 ($PROTOCOL)" '
 	git -C "$upstream" update-ref refs/heads/topic $A &&
 	git -C "$upstream" update-ref refs/tags/v123 $TAG &&
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	<COMMIT-A> refs/heads/topic
 	<TAG-v123> refs/tags/v123
 	EOF
-	test_cmp expect actual
 '
 
 test_expect_success "setup proc-receive hook ($PROTOCOL)" '
@@ -125,11 +121,9 @@ test_expect_success "proc-receive: create/delete branch, and delete tag ($PROTOC
 	 * [new reference] <COMMIT-A> -> refs/pull/124/head
 	EOF
 	test_cmp expect actual &&
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	<COMMIT-B> refs/heads/topic
 	EOF
-	test_cmp expect actual
 '
-- 
2.28.0.15.gba9e81f0bd

