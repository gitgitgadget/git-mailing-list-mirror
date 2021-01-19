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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00017C433E6
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 14:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C00DC2313A
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 14:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391469AbhASOu4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 09:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731752AbhASKZq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 05:25:46 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABF6C061575
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 02:25:05 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id o20so3554320pfu.0
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 02:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JrhvJpmQ/mlFfk33Ph+9GEI9Bi00wpWo3KiaLyRcTVg=;
        b=h36xGJDx/zLWiHoT6U/B9xRyYKIaMSS0yyvLI4qT/wxuVy56PJngB2zf47uKa/CuWf
         1XqDnKs6VzHgOHCZaBYnsTC26pCO90Dpu9s/vIMyvkkm7eJEB5+g/Q4QPz+RLRW0XFFQ
         LtrFjnA2Y6b0TLhpfoMBgNzlNbn2lwWPm/QRR5qaL6Gp1lzPHsVOtJJzc7z6NoyRyp94
         yw4HWkQUj1MlHxlT1NwplGwu2ZorMUeHXdw0QWz1EvgorurzgOgjHn/Go4ao9WwJ5/BR
         zb2Q/pauK8baEZSIrle+iYEjJsIn7GaZLVjnAatUeobr8gBbzu0D4dYpMZOzJtaHXuAY
         wKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JrhvJpmQ/mlFfk33Ph+9GEI9Bi00wpWo3KiaLyRcTVg=;
        b=JDMztu0SzgKxosnfyl54yfy9JE9CgQucgXywcK1Oyl+fBEn7ctk/Fid+zcRAEiI719
         GZ39Oew+2wS5mMPILwAzDcZYRqs0LHoavR3Qvu1uHjiakKXUF+OPP6Xx/Tl3/yIpWpVV
         h4T072LiZU06sI675aEtO0Gnr9l1kvcjokGSJV0hGqPhRmlxOLh2JSV2eBXS+AaeK7UX
         8Vy94/HkovlL1Xl0mFUIm6MTRdIzobCAPYnnw+AufZYggV5txeG7fr1iMWxxmnbHTppg
         FpYVNg0D8Or/eo2sBt5sZfR/ZatQuyD+kYOXQ2oRf4XdRM6Ir0OiUXjPn1aonhdpPJsQ
         Sgjg==
X-Gm-Message-State: AOAM5336j9iM4u4aC63ErLR5jq6IZ2OYOBsfXZHJHRppTYjSpSF26cs4
        8N9/yZ90DIj999ncQUichAc=
X-Google-Smtp-Source: ABdhPJyGrRfDfQiz5SSndaoTEptTxn3OV1YyLiWfrK4wLCXKSZlhHjPpp85++Y+PCrvwhUzdf+rPAQ==
X-Received: by 2002:a63:f013:: with SMTP id k19mr3758412pgh.151.1611051905266;
        Tue, 19 Jan 2021 02:25:05 -0800 (PST)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id t8sm2400032pjd.51.2021.01.19.02.25.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jan 2021 02:25:04 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v2 2/2] t5411: refactor check of refs using test_cmp_refs
Date:   Tue, 19 Jan 2021 05:24:59 -0500
Message-Id: <20210119102459.28986-3-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <e1c9c9cf-4498-6861-bb39-53ceeb9c0fe7@kdbg.org>
References: <e1c9c9cf-4498-6861-bb39-53ceeb9c0fe7@kdbg.org>
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
index b074417d4b..63e0536727 100644
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
@@ -46,13 +44,11 @@ test_expect_success "git-push --atomic ($PROTOCOL)" '
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
@@ -77,13 +73,11 @@ test_expect_success "non-fast-forward git-push ($PROTOCOL)" '
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
@@ -119,15 +113,13 @@ test_expect_success "git-push -f ($PROTOCOL)" '
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
index 8a0de5cac8..4b872eb0a6 100644
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
@@ -48,13 +46,11 @@ test_expect_success "git-push --atomic ($PROTOCOL/porcelain)" '
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
@@ -80,13 +76,11 @@ test_expect_success "non-fast-forward git-push ($PROTOCOL/porcelain)" '
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
@@ -123,15 +117,13 @@ test_expect_success "git-push -f ($PROTOCOL/porcelain)" '
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
index 83edcb037b..ce1c18f824 100644
--- a/t/t5411/test-0002-pre-receive-declined.sh
+++ b/t/t5411/test-0002-pre-receive-declined.sh
@@ -20,12 +20,10 @@ test_expect_success "git-push is declined ($PROTOCOL)" '
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
index 8f3bbeccca..7f882d9c12 100644
--- a/t/t5411/test-0003-pre-receive-declined--porcelain.sh
+++ b/t/t5411/test-0003-pre-receive-declined--porcelain.sh
@@ -21,12 +21,10 @@ test_expect_success "git-push is declined ($PROTOCOL/porcelain)" '
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
index 11c85a32d5..3c42995019 100644
--- a/t/t5411/test-0011-no-hook-error.sh
+++ b/t/t5411/test-0011-no-hook-error.sh
@@ -19,13 +19,11 @@ test_expect_success "proc-receive: no hook, fail to push special ref ($PROTOCOL)
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
@@ -55,10 +53,8 @@ test_expect_success "proc-receive: no hook, all failed for atomic push ($PROTOCO
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
index f89754b480..b8603607fe 100644
--- a/t/t5411/test-0012-no-hook-error--porcelain.sh
+++ b/t/t5411/test-0012-no-hook-error--porcelain.sh
@@ -20,13 +20,11 @@ test_expect_success "proc-receive: no hook, fail to push special ref ($PROTOCOL/
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
@@ -57,10 +55,8 @@ test_expect_success "proc-receive: no hook, all failed for atomic push ($PROTOCO
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
index 888fd951c3..895ba8e3b9 100644
--- a/t/t5411/test-0013-bad-protocol.sh
+++ b/t/t5411/test-0013-bad-protocol.sh
@@ -34,12 +34,9 @@ test_expect_success "proc-receive: bad protocol (unknown version, $PROTOCOL)" '
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
@@ -68,12 +65,9 @@ test_expect_success "proc-receive: bad protocol (hook --die-read-version, $PROTO
 	grep "remote: fatal: die with the --die-read-version option" out-0013-2 &&
 	grep "remote: error: fail to negotiate version with proc-receive hook" out-0013-2 &&
 
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
 
 test_expect_success "setup proc-receive hook (hook --die-write-version, $PROTOCOL)" '
@@ -102,12 +96,9 @@ test_expect_success "proc-receive: bad protocol (hook --die-write-version, $PROT
 	grep "remote: fatal: die with the --die-write-version option" out-0013-3 &&
 	grep "remote: error: fail to negotiate version with proc-receive hook" out-0013-3 &&
 
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
 
 test_expect_success "setup proc-receive hook (hook --die-read-commands, $PROTOCOL)" '
@@ -135,12 +126,9 @@ test_expect_success "proc-receive: bad protocol (hook --die-read-commands, $PROT
 	test_cmp expect actual &&
 	grep "remote: fatal: die with the --die-read-commands option" out-0013-4 &&
 
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
 
 test_expect_success "setup proc-receive hook (hook --die-read-push-options, $PROTOCOL)" '
@@ -170,12 +158,9 @@ test_expect_success "proc-receive: bad protocol (hook --die-read-push-options, $
 	test_cmp expect actual &&
 	grep "remote: fatal: die with the --die-read-push-options option" out-0013-5 &&
 
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
 
 test_expect_success "setup proc-receive hook (hook --die-write-report, $PROTOCOL)" '
@@ -203,12 +188,9 @@ test_expect_success "proc-receive: bad protocol (hook --die-write-report, $PROTO
 	test_cmp expect actual &&
 	grep "remote: fatal: die with the --die-write-report option" out-0013-6 &&
 
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
 
 test_expect_success "setup proc-receive hook (no report, $PROTOCOL)" '
@@ -240,13 +222,10 @@ test_expect_success "proc-receive: bad protocol (no report, $PROTOCOL)" '
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
@@ -284,12 +263,9 @@ test_expect_success "proc-receive: bad protocol (no ref, $PROTOCOL)" '
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
@@ -320,10 +296,7 @@ test_expect_success "proc-receive: bad protocol (unknown status, $PROTOCOL)" '
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
index 1ecf0a3976..d66b946c4f 100644
--- a/t/t5411/test-0014-bad-protocol--porcelain.sh
+++ b/t/t5411/test-0014-bad-protocol--porcelain.sh
@@ -34,12 +34,9 @@ test_expect_success "proc-receive: bad protocol (unknown version, $PROTOCOL/porc
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
@@ -68,12 +65,9 @@ test_expect_success "proc-receive: bad protocol (hook --die-read-version, $PROTO
 	grep "remote: fatal: die with the --die-read-version option" out-0014-2 &&
 	grep "remote: error: fail to negotiate version with proc-receive hook" out-0014-2 &&
 
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
 
 test_expect_success "setup proc-receive hook (hook --die-write-version, $PROTOCOL/porcelain)" '
@@ -102,12 +96,9 @@ test_expect_success "proc-receive: bad protocol (hook --die-write-version, $PROT
 	grep "remote: fatal: die with the --die-write-version option" out-0014-3 &&
 	grep "remote: error: fail to negotiate version with proc-receive hook" out-0014-3 &&
 
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
 
 test_expect_success "setup proc-receive hook (hook --die-read-commands, $PROTOCOL/porcelain)" '
@@ -135,12 +126,9 @@ test_expect_success "proc-receive: bad protocol (hook --die-read-commands, $PROT
 	test_cmp expect actual &&
 	grep "remote: fatal: die with the --die-read-commands option" out-0014-4 &&
 
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
 
 test_expect_success "setup proc-receive hook (hook --die-read-push-options, $PROTOCOL/porcelain)" '
@@ -170,12 +158,9 @@ test_expect_success "proc-receive: bad protocol (hook --die-read-push-options, $
 	test_cmp expect actual &&
 	grep "remote: fatal: die with the --die-read-push-options option" out-0014-5 &&
 
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
 
 test_expect_success "setup proc-receive hook (hook --die-write-report, $PROTOCOL/porcelain)" '
@@ -203,12 +188,9 @@ test_expect_success "proc-receive: bad protocol (hook --die-write-report, $PROTO
 	test_cmp expect actual &&
 	grep "remote: fatal: die with the --die-write-report option" out-0014-6 &&
 
-	git -C "$upstream" show-ref >out &&
-	make_user_friendly_and_stable_output <out >actual &&
-	cat >expect <<-EOF &&
+	test_cmp_refs -C "$upstream" <<-EOF
 	<COMMIT-A> refs/heads/main
 	EOF
-	test_cmp expect actual
 '
 
 test_expect_success "setup proc-receive hook (no report, $PROTOCOL/porcelain)" '
@@ -241,13 +223,10 @@ test_expect_success "proc-receive: bad protocol (no report, $PROTOCOL/porcelain)
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
@@ -285,12 +264,9 @@ test_expect_success "proc-receive: bad protocol (no ref, $PROTOCOL/porcelain)" '
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
@@ -322,10 +298,7 @@ test_expect_success "proc-receive: bad protocol (unknown status, $PROTOCOL/porce
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
index 41efafc55e..d3aa071a21 100644
--- a/t/t5411/test-0020-report-ng.sh
+++ b/t/t5411/test-0020-report-ng.sh
@@ -24,12 +24,10 @@ test_expect_success "proc-receive: fail to update (ng, no message, $PROTOCOL)" '
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
@@ -58,10 +56,8 @@ test_expect_success "proc-receive: fail to update (ng, with message, $PROTOCOL)"
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
index 65b22618cc..9bb82c2a30 100644
--- a/t/t5411/test-0021-report-ng--porcelain.sh
+++ b/t/t5411/test-0021-report-ng--porcelain.sh
@@ -25,12 +25,10 @@ test_expect_success "proc-receive: fail to update (ng, no message, $PROTOCOL/por
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
@@ -60,10 +58,8 @@ test_expect_success "proc-receive: fail to update (ng, with message, $PROTOCOL/p
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
index 4cbd474678..405c6b3372 100644
--- a/t/t5411/test-0022-report-unexpect-ref.sh
+++ b/t/t5411/test-0022-report-unexpect-ref.sh
@@ -30,12 +30,10 @@ test_expect_success "proc-receive: report unexpected ref ($PROTOCOL)" '
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
index 7804b87721..1fe3120741 100644
--- a/t/t5411/test-0023-report-unexpect-ref--porcelain.sh
+++ b/t/t5411/test-0023-report-unexpect-ref--porcelain.sh
@@ -31,12 +31,10 @@ test_expect_success "proc-receive: report unexpected ref ($PROTOCOL/porcelain)"
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
index a048cb0f02..b868d0bd7c 100644
--- a/t/t5411/test-0024-report-unknown-ref.sh
+++ b/t/t5411/test-0024-report-unknown-ref.sh
@@ -25,10 +25,8 @@ test_expect_success "proc-receive: report unknown reference ($PROTOCOL)" '
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
index b3c4fe6330..813b005797 100644
--- a/t/t5411/test-0025-report-unknown-ref--porcelain.sh
+++ b/t/t5411/test-0025-report-unknown-ref--porcelain.sh
@@ -26,10 +26,8 @@ test_expect_success "proc-receive: report unknown reference ($PROTOCOL/porcelain
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
index 7bc627cee6..c8e453f993 100644
--- a/t/t5411/test-0026-push-options.sh
+++ b/t/t5411/test-0026-push-options.sh
@@ -20,12 +20,10 @@ test_expect_success "proc-receive: not support push options ($PROTOCOL)" '
 	make_user_friendly_and_stable_output <out-0026-1 >actual &&
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
@@ -69,13 +67,11 @@ test_expect_success "proc-receive: ignore push-options for version 0 ($PROTOCOL)
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
@@ -123,13 +119,11 @@ test_expect_success "proc-receive: push with options ($PROTOCOL)" '
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
index 5b4884a260..804d666875 100644
--- a/t/t5411/test-0027-push-options--porcelain.sh
+++ b/t/t5411/test-0027-push-options--porcelain.sh
@@ -21,12 +21,10 @@ test_expect_success "proc-receive: not support push options ($PROTOCOL/porcelain
 	make_user_friendly_and_stable_output <out-0027-1 >actual &&
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
@@ -72,13 +70,11 @@ test_expect_success "proc-receive: ignore push-options for version 0 ($PROTOCOL/
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
@@ -128,13 +124,11 @@ test_expect_success "proc-receive: push with options ($PROTOCOL/porcelain)" '
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
index f5c67a1cc3..6040ea7aa7 100644
--- a/t/t5411/test-0032-report-with-options.sh
+++ b/t/t5411/test-0032-report-with-options.sh
@@ -247,10 +247,7 @@ test_expect_success "proc-receive: report with multiple rewrites ($PROTOCOL)" '
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
index 35e785a0fb..6c9b120eaf 100644
--- a/t/t5411/test-0033-report-with-options--porcelain.sh
+++ b/t/t5411/test-0033-report-with-options--porcelain.sh
@@ -256,10 +256,7 @@ test_expect_success "proc-receive: report with multiple rewrites ($PROTOCOL/porc
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
index 0c31447aaa..1fd5bfd1e2 100644
--- a/t/t5411/test-0038-report-mixed-refs.sh
+++ b/t/t5411/test-0038-report-mixed-refs.sh
@@ -65,15 +65,13 @@ test_expect_success "proc-receive: report update of mixed refs ($PROTOCOL)" '
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
index 7007dd98fc..23fb796efe 100644
--- a/t/t5411/test-0039-report-mixed-refs--porcelain.sh
+++ b/t/t5411/test-0039-report-mixed-refs--porcelain.sh
@@ -66,15 +66,13 @@ test_expect_success "proc-receive: report update of mixed refs ($PROTOCOL/porcel
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

