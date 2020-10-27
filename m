Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79083C4363A
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 22:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B91620790
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 22:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pe5Hk3vz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503167AbgJ0W6U (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 18:58:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40481 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442562AbgJ0W6T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 18:58:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id h5so3675132wrv.7
        for <git@vger.kernel.org>; Tue, 27 Oct 2020 15:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pIHCYNaGkPvxJ/2JTR6hP3IfIcrbzuXeRrLq/sVRBLs=;
        b=Pe5Hk3vz5mRdAPDaG5utCWDcpHIlufPY1kWhzXPBD3km+KfgUMvzssmJ8EnnmUcP59
         ElcHCeRTCGH2JZJjDj3xS5hXeo2Qm+uNJcp5UM41rr/fB2A4x7qzStmcgTRpTFZ3qPsU
         R6yMfX55CP91yb48ssp/7fOn3vfp7+CCYXO3bV6f68QjfY2/+LDIsh8XbjRybj+zv/fd
         KTagLe+dZMOHHj7E5er2k7spB+/KvPSx0IqPr3oBKljZ1d5W59Mi5mDvWiPiVVoaMcyW
         lF8Yn4uINLcbdzOFcAI0gsn7UJooT8WpjsPRb+lxXZlcLYejy4LPnSWlcXcdFYSlkJej
         1PUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pIHCYNaGkPvxJ/2JTR6hP3IfIcrbzuXeRrLq/sVRBLs=;
        b=im1/k48AxLlsuPCeAyK2qiQlh71T91kZK182vBMM/Li9XD1xjR52+jGOhetHAdYqs+
         do+G5Psj8dmlZ40LxYaAeopjVVpWLte+toV9/4Tx+EzTi1LtBQaLh9kqp3BBQVBCDwxC
         r0LVI1Atjp+q9AtUJy2B79gPldKE3E7vmpInwttLSCjRhVKiMlZz23gmMlPonFWYrSLb
         er+lmKyrY7CUju9sCikJZKqnAVfissTVIx5VD4aGlzWKtO/0QRvDXZdAiJF05N4zpW2G
         OqXQnInFym6L2m53Tct6wbTkTHYgS23/qXTxJdGxYMhwlQUmyN8xwXJnFGuSehM3LyUn
         4BDw==
X-Gm-Message-State: AOAM533FInKjjf/iZ10BCpMPKKZxjU1W/C3QR+rFZwKGt/XLhzIxpPMx
        cHnA5xZw0SRBT1az7D5+RW8dwYiRGfc=
X-Google-Smtp-Source: ABdhPJySavlkgQj5Hv8EJPjSJ7kZS4SCK7+j4vXgaaOcqwXYWIMbAwkYn6bAJ41TyXLZ6sbyGn66sg==
X-Received: by 2002:a05:6000:18d:: with SMTP id p13mr5281456wrx.248.1603839491777;
        Tue, 27 Oct 2020 15:58:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l26sm3434856wmi.39.2020.10.27.15.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 15:58:11 -0700 (PDT)
Message-Id: <ca914fbc4be1aa9b9276768ee1d9e7e89b27295d.1603839487.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.760.git.1603839487.gitgitgadget@gmail.com>
References: <pull.760.git.1603839487.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Oct 2020 22:58:06 +0000
Subject: [PATCH 3/4] t5411: adjust the remaining support files for
 init.defaultBranch=main
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This trick was performed via

	$ sed -i -e 's/master/main/g' -e 's/MASTER/MAIN/g' \
		-e 's/Master/Main/g' -- t/t5411/*

In the previous commit, we adjusted roughly half of the support files,
to stay under the 100kB limit (mails larger than that are rejected by
the Git mailing list).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5411/common-functions.sh                   |  2 +-
 t/t5411/once-0010-report-status-v1.sh         | 50 +++++-----
 t/t5411/test-0000-standard-git-push.sh        | 72 +++++++-------
 .../test-0001-standard-git-push--porcelain.sh | 72 +++++++-------
 t/t5411/test-0002-pre-receive-declined.sh     | 12 +--
 ...st-0003-pre-receive-declined--porcelain.sh | 12 +--
 t/t5411/test-0011-no-hook-error.sh            | 38 ++++----
 t/t5411/test-0012-no-hook-error--porcelain.sh | 38 ++++----
 t/t5411/test-0013-bad-protocol.sh             | 96 +++++++++----------
 t/t5411/test-0014-bad-protocol--porcelain.sh  | 70 +++++++-------
 t/t5411/test-0020-report-ng.sh                | 40 ++++----
 t/t5411/test-0021-report-ng--porcelain.sh     | 40 ++++----
 t/t5411/test-0022-report-unexpect-ref.sh      | 36 +++----
 ...est-0023-report-unexpect-ref--porcelain.sh | 36 +++----
 t/t5411/test-0024-report-unknown-ref.sh       | 12 +--
 ...test-0025-report-unknown-ref--porcelain.sh | 12 +--
 t/t5411/test-0026-push-options.sh             | 36 +++----
 t/t5411/test-0027-push-options--porcelain.sh  | 36 +++----
 18 files changed, 355 insertions(+), 355 deletions(-)

diff --git a/t/t5411/common-functions.sh b/t/t5411/common-functions.sh
index 6580bebd8e..521a347710 100644
--- a/t/t5411/common-functions.sh
+++ b/t/t5411/common-functions.sh
@@ -28,7 +28,7 @@ create_commits_in () {
 		shift ||
 		return 1
 	done &&
-	git -C "$repo" update-ref refs/heads/master $oid
+	git -C "$repo" update-ref refs/heads/main $oid
 }
 
 # Format the output of git-push, git-show-ref and other commands to make a
diff --git a/t/t5411/once-0010-report-status-v1.sh b/t/t5411/once-0010-report-status-v1.sh
index dc2cf4a522..6005ee0ecb 100644
--- a/t/t5411/once-0010-report-status-v1.sh
+++ b/t/t5411/once-0010-report-status-v1.sh
@@ -6,12 +6,12 @@ test_expect_success "setup proc-receive hook" '
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
-		-r "ok refs/for/master/topic1" \
+		-r "ok refs/for/main/topic1" \
 		-r "option fall-through" \
-		-r "ok refs/for/master/topic2" \
+		-r "ok refs/for/main/topic2" \
 		-r "option refname refs/for/changes/23/123/1" \
 		-r "option new-oid $A" \
-		-r "ok refs/for/master/topic2" \
+		-r "ok refs/for/main/topic2" \
 		-r "option refname refs/for/changes/24/124/2" \
 		-r "option old-oid $B" \
 		-r "option new-oid $A" \
@@ -20,26 +20,26 @@ test_expect_success "setup proc-receive hook" '
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         : (B)                   refs/for/master/topic1(A)  foo(A)  refs/for/next/topic(A)  refs/for/master/topic2(A)
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         : (B)                   refs/for/main/topic1(A)  foo(A)  refs/for/next/topic(A)  refs/for/main/topic2(A)
 test_expect_success "proc-receive: report status v1" '
 	{
 		if test -z "$GIT_DEFAULT_HASH" || test "$GIT_DEFAULT_HASH" = "sha1"
 		then
-			printf "%s %s refs/heads/master\0report-status\n" \
+			printf "%s %s refs/heads/main\0report-status\n" \
 				$A $B | packetize
 		else
-			printf "%s %s refs/heads/master\0report-status object-format=$GIT_DEFAULT_HASH\n" \
+			printf "%s %s refs/heads/main\0report-status object-format=$GIT_DEFAULT_HASH\n" \
 				$A $B | packetize
 		fi &&
-		printf "%s %s refs/for/master/topic1\n" \
+		printf "%s %s refs/for/main/topic1\n" \
 			$ZERO_OID $A | packetize &&
 		printf "%s %s refs/heads/foo\n" \
 			$ZERO_OID $A | packetize &&
 		printf "%s %s refs/for/next/topic\n" \
 			$ZERO_OID $A | packetize &&
-		printf "%s %s refs/for/master/topic2\n" \
+		printf "%s %s refs/for/main/topic2\n" \
 			$ZERO_OID $A | packetize &&
 		printf 0000 &&
 		printf "" | git -C "$upstream" pack-objects --stdout
@@ -48,35 +48,35 @@ test_expect_success "proc-receive: report status v1" '
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
 	# pre-receive hook
-	pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
-	pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic1
+	pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
+	pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic1
 	pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
 	pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
-	pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic2
+	pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic2
 	# proc-receive hook
-	proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic1
+	proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic1
 	proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
-	proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic2
-	proc-receive> ok refs/for/master/topic1
+	proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic2
+	proc-receive> ok refs/for/main/topic1
 	proc-receive> option fall-through
-	proc-receive> ok refs/for/master/topic2
+	proc-receive> ok refs/for/main/topic2
 	proc-receive> option refname refs/for/changes/23/123/1
 	proc-receive> option new-oid <COMMIT-A>
-	proc-receive> ok refs/for/master/topic2
+	proc-receive> ok refs/for/main/topic2
 	proc-receive> option refname refs/for/changes/24/124/2
 	proc-receive> option old-oid <COMMIT-B>
 	proc-receive> option new-oid <COMMIT-A>
 	proc-receive> option forced-update
 	proc-receive> ng refs/for/next/topic target branch not exist
 	000eunpack ok
-	0019ok refs/heads/master
-	001eok refs/for/master/topic1
+	0019ok refs/heads/main
+	001eok refs/for/main/topic1
 	0016ok refs/heads/foo
 	0033ng refs/for/next/topic target branch not exist
-	001eok refs/for/master/topic2
+	001eok refs/for/main/topic2
 	0000# post-receive hook
-	post-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
-	post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic1
+	post-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
+	post-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic1
 	post-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
 	post-receive< <ZERO-OID> <COMMIT-A> refs/for/changes/23/123/1
 	post-receive< <COMMIT-B> <COMMIT-A> refs/for/changes/24/124/2
@@ -86,9 +86,9 @@ test_expect_success "proc-receive: report status v1" '
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-A> refs/for/master/topic1
+	<COMMIT-A> refs/for/main/topic1
 	<COMMIT-A> refs/heads/foo
-	<COMMIT-B> refs/heads/master
+	<COMMIT-B> refs/heads/main
 	EOF
 	test_cmp expect actual
 '
diff --git a/t/t5411/test-0000-standard-git-push.sh b/t/t5411/test-0000-standard-git-push.sh
index e206587348..2b04b49367 100644
--- a/t/t5411/test-0000-standard-git-push.sh
+++ b/t/t5411/test-0000-standard-git-push.sh
@@ -1,39 +1,39 @@
-# Refs of upstream : master(A)  
-# Refs of workbench: master(A)  tags/v123
-# git-push         : master(B)             next(A)
+# Refs of upstream : main(A)  
+# Refs of workbench: main(A)  tags/v123
+# git-push         : main(B)             next(A)
 test_expect_success "git-push ($PROTOCOL)" '
 	git -C workbench push origin \
-		$B:refs/heads/master \
+		$B:refs/heads/main \
 		HEAD:refs/heads/next \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
-	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
+	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
 	remote: # post-receive hook
-	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
 	To <URL/of/upstream.git>
-	 <OID-A>..<OID-B> <COMMIT-B> -> master
+	 <OID-A>..<OID-B> <COMMIT-B> -> main
 	 * [new branch] HEAD -> next
 	EOF
 	test_cmp expect actual &&
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-B> refs/heads/master
+	<COMMIT-B> refs/heads/main
 	<COMMIT-A> refs/heads/next
 	EOF
 	test_cmp expect actual
 '
 
-# Refs of upstream : master(B)  next(A)
-# Refs of workbench: master(A)           tags/v123
-# git-push --atomic: master(A)  next(B)
+# Refs of upstream : main(B)  next(A)
+# Refs of workbench: main(A)           tags/v123
+# git-push --atomic: main(A)  next(B)
 test_expect_success "git-push --atomic ($PROTOCOL)" '
 	test_must_fail git -C workbench push --atomic origin \
-		master \
+		main \
 		$B:refs/heads/next \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out |
@@ -43,28 +43,28 @@ test_expect_success "git-push --atomic ($PROTOCOL)" '
 			>actual &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
-	 ! [rejected] master -> master (non-fast-forward)
+	 ! [rejected] main -> main (non-fast-forward)
 	 ! [rejected] <COMMIT-B> -> next (atomic push failed)
 	EOF
 	test_cmp expect actual &&
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-B> refs/heads/master
+	<COMMIT-B> refs/heads/main
 	<COMMIT-A> refs/heads/next
 	EOF
 	test_cmp expect actual
 '
 
-# Refs of upstream : master(B)  next(A)
-# Refs of workbench: master(A)           tags/v123
-# git-push         : master(A)  next(B)
+# Refs of upstream : main(B)  next(A)
+# Refs of workbench: main(A)           tags/v123
+# git-push         : main(A)  next(B)
 test_expect_success "non-fast-forward git-push ($PROTOCOL)" '
 	test_must_fail git \
 		-C workbench \
 		-c advice.pushUpdateRejected=false \
 		push origin \
-		master \
+		main \
 		$B:refs/heads/next \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
@@ -75,48 +75,48 @@ test_expect_success "non-fast-forward git-push ($PROTOCOL)" '
 	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/next
 	To <URL/of/upstream.git>
 	 <OID-A>..<OID-B> <COMMIT-B> -> next
-	 ! [rejected] master -> master (non-fast-forward)
+	 ! [rejected] main -> main (non-fast-forward)
 	EOF
 	test_cmp expect actual &&
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-B> refs/heads/master
+	<COMMIT-B> refs/heads/main
 	<COMMIT-B> refs/heads/next
 	EOF
 	test_cmp expect actual
 '
 
-# Refs of upstream : master(B)  next(B)
-# Refs of workbench: master(A)           tags/v123
-# git-push -f      : master(A)  NULL     tags/v123  refs/review/master/topic(A)  a/b/c(A)
+# Refs of upstream : main(B)  next(B)
+# Refs of workbench: main(A)           tags/v123
+# git-push -f      : main(A)  NULL     tags/v123  refs/review/main/topic(A)  a/b/c(A)
 test_expect_success "git-push -f ($PROTOCOL)" '
 	git -C workbench push -f origin \
 		refs/tags/v123 \
 		:refs/heads/next \
-		master \
-		master:refs/review/master/topic \
+		main \
+		main:refs/review/main/topic \
 		HEAD:refs/heads/a/b/c \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
-	remote: pre-receive< <COMMIT-B> <COMMIT-A> refs/heads/master
+	remote: pre-receive< <COMMIT-B> <COMMIT-A> refs/heads/main
 	remote: pre-receive< <COMMIT-B> <ZERO-OID> refs/heads/next
 	remote: pre-receive< <ZERO-OID> <TAG-v123> refs/tags/v123
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/review/master/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/review/main/topic
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/a/b/c
 	remote: # post-receive hook
-	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/heads/master
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/heads/main
 	remote: post-receive< <COMMIT-B> <ZERO-OID> refs/heads/next
 	remote: post-receive< <ZERO-OID> <TAG-v123> refs/tags/v123
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/review/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/review/main/topic
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/a/b/c
 	To <URL/of/upstream.git>
-	 + <OID-B>...<OID-A> master -> master (forced update)
+	 + <OID-B>...<OID-A> main -> main (forced update)
 	 - [deleted] next
 	 * [new tag] v123 -> v123
-	 * [new reference] master -> refs/review/master/topic
+	 * [new reference] main -> refs/review/main/topic
 	 * [new branch] HEAD -> a/b/c
 	EOF
 	test_cmp expect actual &&
@@ -124,19 +124,19 @@ test_expect_success "git-push -f ($PROTOCOL)" '
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
 	<COMMIT-A> refs/heads/a/b/c
-	<COMMIT-A> refs/heads/master
-	<COMMIT-A> refs/review/master/topic
+	<COMMIT-A> refs/heads/main
+	<COMMIT-A> refs/review/main/topic
 	<TAG-v123> refs/tags/v123
 	EOF
 	test_cmp expect actual
 '
 
-# Refs of upstream : master(A)  tags/v123  refs/review/master/topic(A)  a/b/c(A)
-# Refs of workbench: master(A)  tags/v123
+# Refs of upstream : main(A)  tags/v123  refs/review/main/topic(A)  a/b/c(A)
+# Refs of workbench: main(A)  tags/v123
 test_expect_success "cleanup ($PROTOCOL)" '
 	(
 		cd "$upstream" &&
-		git update-ref -d refs/review/master/topic &&
+		git update-ref -d refs/review/main/topic &&
 		git update-ref -d refs/tags/v123 &&
 		git update-ref -d refs/heads/a/b/c
 	)
diff --git a/t/t5411/test-0001-standard-git-push--porcelain.sh b/t/t5411/test-0001-standard-git-push--porcelain.sh
index 48f6fcc846..747307f8da 100644
--- a/t/t5411/test-0001-standard-git-push--porcelain.sh
+++ b/t/t5411/test-0001-standard-git-push--porcelain.sh
@@ -1,21 +1,21 @@
-# Refs of upstream : master(A)  
-# Refs of workbench: master(A)  tags/v123
-# git-push         : master(B)             next(A)
+# Refs of upstream : main(A)  
+# Refs of workbench: main(A)  tags/v123
+# git-push         : main(B)             next(A)
 test_expect_success "git-push ($PROTOCOL/porcelain)" '
 	git -C workbench push --porcelain origin \
-		$B:refs/heads/master \
+		$B:refs/heads/main \
 		HEAD:refs/heads/next \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
-	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
+	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
 	remote: # post-receive hook
-	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
 	To <URL/of/upstream.git>
-	     <COMMIT-B>:refs/heads/master    <OID-A>..<OID-B>
+	     <COMMIT-B>:refs/heads/main    <OID-A>..<OID-B>
 	*    HEAD:refs/heads/next    [new branch]
 	Done
 	EOF
@@ -23,18 +23,18 @@ test_expect_success "git-push ($PROTOCOL/porcelain)" '
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-B> refs/heads/master
+	<COMMIT-B> refs/heads/main
 	<COMMIT-A> refs/heads/next
 	EOF
 	test_cmp expect actual
 '
 
-# Refs of upstream : master(B)  next(A)
-# Refs of workbench: master(A)           tags/v123
-# git-push --atomic: master(A)  next(B)
+# Refs of upstream : main(B)  next(A)
+# Refs of workbench: main(A)           tags/v123
+# git-push --atomic: main(A)  next(B)
 test_expect_success "git-push --atomic ($PROTOCOL/porcelain)" '
 	test_must_fail git -C workbench push --atomic --porcelain origin \
-		master \
+		main \
 		$B:refs/heads/next \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out |
@@ -45,28 +45,28 @@ test_expect_success "git-push --atomic ($PROTOCOL/porcelain)" '
 			>actual &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
-	! refs/heads/master:refs/heads/master [rejected] (non-fast-forward)
+	! refs/heads/main:refs/heads/main [rejected] (non-fast-forward)
 	! <COMMIT-B>:refs/heads/next [rejected] (atomic push failed)
 	EOF
 	test_cmp expect actual &&
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-B> refs/heads/master
+	<COMMIT-B> refs/heads/main
 	<COMMIT-A> refs/heads/next
 	EOF
 	test_cmp expect actual
 '
 
-# Refs of upstream : master(B)  next(A)
-# Refs of workbench: master(A)           tags/v123
-# git-push         : master(A)  next(B)
+# Refs of upstream : main(B)  next(A)
+# Refs of workbench: main(A)           tags/v123
+# git-push         : main(A)  next(B)
 test_expect_success "non-fast-forward git-push ($PROTOCOL/porcelain)" '
 	test_must_fail git \
 		-C workbench \
 		-c advice.pushUpdateRejected=false \
 		push --porcelain origin \
-		master \
+		main \
 		$B:refs/heads/next \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
@@ -77,49 +77,49 @@ test_expect_success "non-fast-forward git-push ($PROTOCOL/porcelain)" '
 	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/next
 	To <URL/of/upstream.git>
 	     <COMMIT-B>:refs/heads/next    <OID-A>..<OID-B>
-	!    refs/heads/master:refs/heads/master    [rejected] (non-fast-forward)
+	!    refs/heads/main:refs/heads/main    [rejected] (non-fast-forward)
 	Done
 	EOF
 	test_cmp expect actual &&
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-B> refs/heads/master
+	<COMMIT-B> refs/heads/main
 	<COMMIT-B> refs/heads/next
 	EOF
 	test_cmp expect actual
 '
 
-# Refs of upstream : master(B)  next(B)
-# Refs of workbench: master(A)           tags/v123
-# git-push -f      : master(A)  NULL     tags/v123  refs/review/master/topic(A)  a/b/c(A)
+# Refs of upstream : main(B)  next(B)
+# Refs of workbench: main(A)           tags/v123
+# git-push -f      : main(A)  NULL     tags/v123  refs/review/main/topic(A)  a/b/c(A)
 test_expect_success "git-push -f ($PROTOCOL/porcelain)" '
 	git -C workbench push --porcelain -f origin \
 		refs/tags/v123 \
 		:refs/heads/next \
-		master \
-		master:refs/review/master/topic \
+		main \
+		main:refs/review/main/topic \
 		HEAD:refs/heads/a/b/c \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
-	remote: pre-receive< <COMMIT-B> <COMMIT-A> refs/heads/master
+	remote: pre-receive< <COMMIT-B> <COMMIT-A> refs/heads/main
 	remote: pre-receive< <COMMIT-B> <ZERO-OID> refs/heads/next
 	remote: pre-receive< <ZERO-OID> <TAG-v123> refs/tags/v123
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/review/master/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/review/main/topic
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/a/b/c
 	remote: # post-receive hook
-	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/heads/master
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/heads/main
 	remote: post-receive< <COMMIT-B> <ZERO-OID> refs/heads/next
 	remote: post-receive< <ZERO-OID> <TAG-v123> refs/tags/v123
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/review/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/review/main/topic
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/a/b/c
 	To <URL/of/upstream.git>
-	+    refs/heads/master:refs/heads/master    <OID-B>...<OID-A> (forced update)
+	+    refs/heads/main:refs/heads/main    <OID-B>...<OID-A> (forced update)
 	-    :refs/heads/next    [deleted]
 	*    refs/tags/v123:refs/tags/v123    [new tag]
-	*    refs/heads/master:refs/review/master/topic    [new reference]
+	*    refs/heads/main:refs/review/main/topic    [new reference]
 	*    HEAD:refs/heads/a/b/c    [new branch]
 	Done
 	EOF
@@ -128,19 +128,19 @@ test_expect_success "git-push -f ($PROTOCOL/porcelain)" '
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
 	<COMMIT-A> refs/heads/a/b/c
-	<COMMIT-A> refs/heads/master
-	<COMMIT-A> refs/review/master/topic
+	<COMMIT-A> refs/heads/main
+	<COMMIT-A> refs/review/main/topic
 	<TAG-v123> refs/tags/v123
 	EOF
 	test_cmp expect actual
 '
 
-# Refs of upstream : master(A)  tags/v123  refs/review/master/topic(A)  a/b/c(A)
-# Refs of workbench: master(A)  tags/v123
+# Refs of upstream : main(A)  tags/v123  refs/review/main/topic(A)  a/b/c(A)
+# Refs of workbench: main(A)  tags/v123
 test_expect_success "cleanup ($PROTOCOL/porcelain)" '
 	(
 		cd "$upstream" &&
-		git update-ref -d refs/review/master/topic &&
+		git update-ref -d refs/review/main/topic &&
 		git update-ref -d refs/tags/v123 &&
 		git update-ref -d refs/heads/a/b/c
 	)
diff --git a/t/t5411/test-0002-pre-receive-declined.sh b/t/t5411/test-0002-pre-receive-declined.sh
index c246f7e68e..e7d113a158 100644
--- a/t/t5411/test-0002-pre-receive-declined.sh
+++ b/t/t5411/test-0002-pre-receive-declined.sh
@@ -5,25 +5,25 @@ test_expect_success "setup pre-receive hook ($PROTOCOL)" '
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git-push         : master(B)             next(A)
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git-push         : main(B)             next(A)
 test_expect_success "git-push is declined ($PROTOCOL)" '
 	test_must_fail git -C workbench push origin \
-		$B:refs/heads/master \
+		$B:refs/heads/main \
 		HEAD:refs/heads/next \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
-	 ! [remote rejected] <COMMIT-B> -> master (pre-receive hook declined)
+	 ! [remote rejected] <COMMIT-B> -> main (pre-receive hook declined)
 	 ! [remote rejected] HEAD -> next (pre-receive hook declined)
 	EOF
 	test_cmp expect actual &&
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/main
 	EOF
 	test_cmp expect actual
 '
diff --git a/t/t5411/test-0003-pre-receive-declined--porcelain.sh b/t/t5411/test-0003-pre-receive-declined--porcelain.sh
index b14894de81..cc0cca6a47 100644
--- a/t/t5411/test-0003-pre-receive-declined--porcelain.sh
+++ b/t/t5411/test-0003-pre-receive-declined--porcelain.sh
@@ -5,18 +5,18 @@ test_expect_success "setup pre-receive hook ($PROTOCOL/porcelain)" '
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git-push         : master(B)             next(A)
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git-push         : main(B)             next(A)
 test_expect_success "git-push is declined ($PROTOCOL/porcelain)" '
 	test_must_fail git -C workbench push --porcelain origin \
-		$B:refs/heads/master \
+		$B:refs/heads/main \
 		HEAD:refs/heads/next \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
-	!    <COMMIT-B>:refs/heads/master    [remote rejected] (pre-receive hook declined)
+	!    <COMMIT-B>:refs/heads/main    [remote rejected] (pre-receive hook declined)
 	!    HEAD:refs/heads/next    [remote rejected] (pre-receive hook declined)
 	Done
 	EOF
@@ -24,7 +24,7 @@ test_expect_success "git-push is declined ($PROTOCOL/porcelain)" '
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/main
 	EOF
 	test_cmp expect actual
 '
diff --git a/t/t5411/test-0011-no-hook-error.sh b/t/t5411/test-0011-no-hook-error.sh
index bb6ec92a92..c50830982f 100644
--- a/t/t5411/test-0011-no-hook-error.sh
+++ b/t/t5411/test-0011-no-hook-error.sh
@@ -1,64 +1,64 @@
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         :                       next(A)  refs/for/master/topic(A)
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       next(A)  refs/for/main/topic(A)
 test_expect_success "proc-receive: no hook, fail to push special ref ($PROTOCOL)" '
 	test_must_fail git -C workbench push origin \
 		HEAD:next \
-		HEAD:refs/for/master/topic \
+		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
 	remote: error: cannot find hook "proc-receive"
 	remote: # post-receive hook
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
 	To <URL/of/upstream.git>
 	 * [new branch] HEAD -> next
-	 ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
+	 ! [remote rejected] HEAD -> refs/for/main/topic (fail to run proc-receive hook)
 	EOF
 	test_cmp expect actual &&
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/main
 	<COMMIT-A> refs/heads/next
 	EOF
 	test_cmp expect actual
 '
 
-# Refs of upstream : master(A)             next(A)
-# Refs of workbench: master(A)  tags/v123
+# Refs of upstream : main(A)             next(A)
+# Refs of workbench: main(A)  tags/v123
 test_expect_success "cleanup ($PROTOCOL)" '
 	git -C "$upstream" update-ref -d refs/heads/next
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push --atomic: (B)                   next(A)  refs/for/master/topic(A)
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push --atomic: (B)                   next(A)  refs/for/main/topic(A)
 test_expect_success "proc-receive: no hook, all failed for atomic push ($PROTOCOL)" '
 	test_must_fail git -C workbench push --atomic origin \
-		$B:master \
+		$B:main \
 		HEAD:next \
-		HEAD:refs/for/master/topic >out 2>&1 &&
+		HEAD:refs/for/main/topic >out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
-	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
+	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
 	remote: error: cannot find hook "proc-receive"
 	To <URL/of/upstream.git>
-	 ! [remote rejected] <COMMIT-B> -> master (fail to run proc-receive hook)
+	 ! [remote rejected] <COMMIT-B> -> main (fail to run proc-receive hook)
 	 ! [remote rejected] HEAD -> next (fail to run proc-receive hook)
-	 ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
+	 ! [remote rejected] HEAD -> refs/for/main/topic (fail to run proc-receive hook)
 	EOF
 	test_cmp expect actual &&
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/main
 	EOF
 	test_cmp expect actual
 '
diff --git a/t/t5411/test-0012-no-hook-error--porcelain.sh b/t/t5411/test-0012-no-hook-error--porcelain.sh
index 4814f74dc2..14ea433481 100644
--- a/t/t5411/test-0012-no-hook-error--porcelain.sh
+++ b/t/t5411/test-0012-no-hook-error--porcelain.sh
@@ -1,66 +1,66 @@
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         :                       next(A)  refs/for/master/topic(A)
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       next(A)  refs/for/main/topic(A)
 test_expect_success "proc-receive: no hook, fail to push special ref ($PROTOCOL/porcelain)" '
 	test_must_fail git -C workbench push --porcelain origin \
 		HEAD:next \
-		HEAD:refs/for/master/topic \
+		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
 	remote: error: cannot find hook "proc-receive"
 	remote: # post-receive hook
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
 	To <URL/of/upstream.git>
 	*    HEAD:refs/heads/next    [new branch]
-	!    HEAD:refs/for/master/topic    [remote rejected] (fail to run proc-receive hook)
+	!    HEAD:refs/for/main/topic    [remote rejected] (fail to run proc-receive hook)
 	Done
 	EOF
 	test_cmp expect actual &&
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/main
 	<COMMIT-A> refs/heads/next
 	EOF
 	test_cmp expect actual
 '
 
-# Refs of upstream : master(A)             next(A)
-# Refs of workbench: master(A)  tags/v123
+# Refs of upstream : main(A)             next(A)
+# Refs of workbench: main(A)  tags/v123
 test_expect_success "cleanup ($PROTOCOL/porcelain)" '
 	git -C "$upstream" update-ref -d refs/heads/next
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push --atomic: (B)                   next(A)  refs/for/master/topic(A)
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push --atomic: (B)                   next(A)  refs/for/main/topic(A)
 test_expect_success "proc-receive: no hook, all failed for atomic push ($PROTOCOL/porcelain)" '
 	test_must_fail git -C workbench push --porcelain --atomic origin \
-		$B:master \
+		$B:main \
 		HEAD:next \
-		HEAD:refs/for/master/topic >out 2>&1 &&
+		HEAD:refs/for/main/topic >out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
-	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
+	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
 	remote: error: cannot find hook "proc-receive"
 	To <URL/of/upstream.git>
-	!    <COMMIT-B>:refs/heads/master    [remote rejected] (fail to run proc-receive hook)
+	!    <COMMIT-B>:refs/heads/main    [remote rejected] (fail to run proc-receive hook)
 	!    HEAD:refs/heads/next    [remote rejected] (fail to run proc-receive hook)
-	!    HEAD:refs/for/master/topic    [remote rejected] (fail to run proc-receive hook)
+	!    HEAD:refs/for/main/topic    [remote rejected] (fail to run proc-receive hook)
 	Done
 	EOF
 	test_cmp expect actual &&
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/main
 	EOF
 	test_cmp expect actual
 '
diff --git a/t/t5411/test-0013-bad-protocol.sh b/t/t5411/test-0013-bad-protocol.sh
index c5fe4cb37b..854c3e884a 100644
--- a/t/t5411/test-0013-bad-protocol.sh
+++ b/t/t5411/test-0013-bad-protocol.sh
@@ -5,12 +5,12 @@ test_expect_success "setup proc-receive hook (unknown version, $PROTOCOL)" '
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         :                       refs/for/master/topic(A)
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       refs/for/main/topic(A)
 test_expect_success "proc-receive: bad protocol (unknown version, $PROTOCOL)" '
 	test_must_fail git -C workbench push origin \
-		HEAD:refs/for/master/topic \
+		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
 
@@ -20,7 +20,7 @@ test_expect_success "proc-receive: bad protocol (unknown version, $PROTOCOL)" '
 		<actual >actual-report &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
-	 ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
+	 ! [remote rejected] HEAD -> refs/for/main/topic (fail to run proc-receive hook)
 	EOF
 	test_cmp expect actual-report &&
 
@@ -36,7 +36,7 @@ test_expect_success "proc-receive: bad protocol (unknown version, $PROTOCOL)" '
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/main
 	EOF
 	test_cmp expect actual
 '
@@ -48,30 +48,30 @@ test_expect_success "setup proc-receive hook (hook --die-version, $PROTOCOL)" '
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         :                       refs/for/master/topic(A)
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       refs/for/main/topic(A)
 test_expect_success "proc-receive: bad protocol (hook --die-version, $PROTOCOL)" '
 	test_must_fail git -C workbench push origin \
-		HEAD:refs/for/master/topic \
+		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
 
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
 	remote: # proc-receive hook
 	remote: fatal: bad protocol version: 1
 	remote: error: proc-receive version "0" is not supported
 	To <URL/of/upstream.git>
-	 ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
+	 ! [remote rejected] HEAD -> refs/for/main/topic (fail to run proc-receive hook)
 	EOF
 	test_cmp expect actual &&
 
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/main
 	EOF
 	test_cmp expect actual
 '
@@ -83,21 +83,21 @@ test_expect_success "setup proc-receive hook (hook --die-readline, $PROTOCOL)" '
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         :                       refs/for/master/topic(A)
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       refs/for/main/topic(A)
 test_expect_success "proc-receive: bad protocol (hook --die-readline, $PROTOCOL)" '
 	test_must_fail git -C workbench push origin \
-		HEAD:refs/for/master/topic \
+		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
 
-	grep "remote: fatal: protocol error: expected \"old new ref\", got \"<ZERO-OID> <COMMIT-A> refs/for/master/topic\"" actual &&
+	grep "remote: fatal: protocol error: expected \"old new ref\", got \"<ZERO-OID> <COMMIT-A> refs/for/main/topic\"" actual &&
 
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/main
 	EOF
 	test_cmp expect actual
 '
@@ -109,38 +109,38 @@ test_expect_success "setup proc-receive hook (no report, $PROTOCOL)" '
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         :                       next(A)  refs/for/master/topic(A)
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       next(A)  refs/for/main/topic(A)
 test_expect_success "proc-receive: bad protocol (no report, $PROTOCOL)" '
 	test_must_fail git -C workbench push origin \
 		HEAD:refs/heads/next \
-		HEAD:refs/for/master/topic >out 2>&1 &&
+		HEAD:refs/for/main/topic >out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
 	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
 	remote: # post-receive hook
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
 	To <URL/of/upstream.git>
 	 * [new branch] HEAD -> next
-	 ! [remote rejected] HEAD -> refs/for/master/topic (proc-receive failed to report status)
+	 ! [remote rejected] HEAD -> refs/for/main/topic (proc-receive failed to report status)
 	EOF
 	test_cmp expect actual &&
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/main
 	<COMMIT-A> refs/heads/next
 	EOF
 	test_cmp expect actual
 '
 
-# Refs of upstream : master(A)             next(A)
-# Refs of workbench: master(A)  tags/v123
+# Refs of upstream : main(A)             next(A)
+# Refs of workbench: main(A)  tags/v123
 test_expect_success "cleanup ($PROTOCOL)" '
 	git -C "$upstream" update-ref -d refs/heads/next
 
@@ -154,29 +154,29 @@ test_expect_success "setup proc-receive hook (no ref, $PROTOCOL)" '
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         :                       refs/for/master/topic
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       refs/for/main/topic
 test_expect_success "proc-receive: bad protocol (no ref, $PROTOCOL)" '
 	test_must_fail git -C workbench push origin \
-		HEAD:refs/for/master/topic\
+		HEAD:refs/for/main/topic\
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
 	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
 	remote: proc-receive> ok
 	remote: error: proc-receive reported incomplete status line: "ok"
 	To <URL/of/upstream.git>
-	 ! [remote rejected] HEAD -> refs/for/master/topic (proc-receive failed to report status)
+	 ! [remote rejected] HEAD -> refs/for/main/topic (proc-receive failed to report status)
 	EOF
 	test_cmp expect actual &&
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/main
 	EOF
 	test_cmp expect actual
 '
@@ -185,33 +185,33 @@ test_expect_success "setup proc-receive hook (unknown status, $PROTOCOL)" '
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
-		-r "xx refs/for/master/topic"
+		-r "xx refs/for/main/topic"
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         :                       refs/for/master/topic
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       refs/for/main/topic
 test_expect_success "proc-receive: bad protocol (unknown status, $PROTOCOL)" '
 	test_must_fail git -C workbench push origin \
-			HEAD:refs/for/master/topic \
+			HEAD:refs/for/main/topic \
 			>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
 	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
-	remote: proc-receive> xx refs/for/master/topic
-	remote: error: proc-receive reported bad status "xx" on ref "refs/for/master/topic"
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
+	remote: proc-receive> xx refs/for/main/topic
+	remote: error: proc-receive reported bad status "xx" on ref "refs/for/main/topic"
 	To <URL/of/upstream.git>
-	 ! [remote rejected] HEAD -> refs/for/master/topic (proc-receive failed to report status)
+	 ! [remote rejected] HEAD -> refs/for/main/topic (proc-receive failed to report status)
 	EOF
 	test_cmp expect actual &&
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/main
 	EOF
 	test_cmp expect actual
 '
diff --git a/t/t5411/test-0014-bad-protocol--porcelain.sh b/t/t5411/test-0014-bad-protocol--porcelain.sh
index 53b47b0185..88c56311da 100644
--- a/t/t5411/test-0014-bad-protocol--porcelain.sh
+++ b/t/t5411/test-0014-bad-protocol--porcelain.sh
@@ -5,12 +5,12 @@ test_expect_success "setup proc-receive hook (unknown version, $PROTOCOL/porcela
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         :                       refs/for/master/topic(A)
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       refs/for/main/topic(A)
 test_expect_success "proc-receive: bad protocol (unknown version, $PROTOCOL/porcelain)" '
 	test_must_fail git -C workbench push --porcelain origin \
-		HEAD:refs/for/master/topic \
+		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
 
@@ -20,7 +20,7 @@ test_expect_success "proc-receive: bad protocol (unknown version, $PROTOCOL/porc
 		<actual >actual-report &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
-	!    HEAD:refs/for/master/topic    [remote rejected] (fail to run proc-receive hook)
+	!    HEAD:refs/for/main/topic    [remote rejected] (fail to run proc-receive hook)
 	Done
 	EOF
 	test_cmp expect actual-report &&
@@ -37,7 +37,7 @@ test_expect_success "proc-receive: bad protocol (unknown version, $PROTOCOL/porc
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/main
 	EOF
 	test_cmp expect actual
 '
@@ -49,39 +49,39 @@ test_expect_success "setup proc-receive hook (no report, $PROTOCOL/porcelain)" '
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         :                       next(A)  refs/for/master/topic(A)
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       next(A)  refs/for/main/topic(A)
 test_expect_success "proc-receive: bad protocol (no report, $PROTOCOL/porcelain)" '
 	test_must_fail git -C workbench push --porcelain origin \
 		HEAD:refs/heads/next \
-		HEAD:refs/for/master/topic >out 2>&1 &&
+		HEAD:refs/for/main/topic >out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
 	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
 	remote: # post-receive hook
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
 	To <URL/of/upstream.git>
 	*    HEAD:refs/heads/next    [new branch]
-	!    HEAD:refs/for/master/topic    [remote rejected] (proc-receive failed to report status)
+	!    HEAD:refs/for/main/topic    [remote rejected] (proc-receive failed to report status)
 	Done
 	EOF
 	test_cmp expect actual &&
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/main
 	<COMMIT-A> refs/heads/next
 	EOF
 	test_cmp expect actual
 '
 
-# Refs of upstream : master(A)             next(A)
-# Refs of workbench: master(A)  tags/v123
+# Refs of upstream : main(A)             next(A)
+# Refs of workbench: main(A)  tags/v123
 test_expect_success "cleanup ($PROTOCOL/porcelain)" '
 	git -C "$upstream" update-ref -d refs/heads/next
 
@@ -95,30 +95,30 @@ test_expect_success "setup proc-receive hook (no ref, $PROTOCOL/porcelain)" '
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         :                       refs/for/master/topic
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       refs/for/main/topic
 test_expect_success "proc-receive: bad protocol (no ref, $PROTOCOL/porcelain)" '
 	test_must_fail git -C workbench push --porcelain origin \
-		HEAD:refs/for/master/topic\
+		HEAD:refs/for/main/topic\
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
 	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
 	remote: proc-receive> ok
 	remote: error: proc-receive reported incomplete status line: "ok"
 	To <URL/of/upstream.git>
-	!    HEAD:refs/for/master/topic    [remote rejected] (proc-receive failed to report status)
+	!    HEAD:refs/for/main/topic    [remote rejected] (proc-receive failed to report status)
 	Done
 	EOF
 	test_cmp expect actual &&
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/main
 	EOF
 	test_cmp expect actual
 '
@@ -127,34 +127,34 @@ test_expect_success "setup proc-receive hook (unknown status, $PROTOCOL/porcelai
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
-		-r "xx refs/for/master/topic"
+		-r "xx refs/for/main/topic"
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         :                       refs/for/master/topic
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       refs/for/main/topic
 test_expect_success "proc-receive: bad protocol (unknown status, $PROTOCOL/porcelain)" '
 	test_must_fail git -C workbench push --porcelain origin \
-			HEAD:refs/for/master/topic \
+			HEAD:refs/for/main/topic \
 			>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
 	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
-	remote: proc-receive> xx refs/for/master/topic
-	remote: error: proc-receive reported bad status "xx" on ref "refs/for/master/topic"
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
+	remote: proc-receive> xx refs/for/main/topic
+	remote: error: proc-receive reported bad status "xx" on ref "refs/for/main/topic"
 	To <URL/of/upstream.git>
-	!    HEAD:refs/for/master/topic    [remote rejected] (proc-receive failed to report status)
+	!    HEAD:refs/for/main/topic    [remote rejected] (proc-receive failed to report status)
 	Done
 	EOF
 	test_cmp expect actual &&
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/main
 	EOF
 	test_cmp expect actual
 '
diff --git a/t/t5411/test-0020-report-ng.sh b/t/t5411/test-0020-report-ng.sh
index f726b7ca9c..5a9e0daf2d 100644
--- a/t/t5411/test-0020-report-ng.sh
+++ b/t/t5411/test-0020-report-ng.sh
@@ -2,32 +2,32 @@ test_expect_success "setup proc-receive hook (ng, no message, $PROTOCOL)" '
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
-		-r "ng refs/for/master/topic"
+		-r "ng refs/for/main/topic"
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         :                       refs/for/master/topic
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       refs/for/main/topic
 test_expect_success "proc-receive: fail to update (ng, no message, $PROTOCOL)" '
 	test_must_fail git -C workbench push origin \
-		HEAD:refs/for/master/topic \
+		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
 	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
-	remote: proc-receive> ng refs/for/master/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
+	remote: proc-receive> ng refs/for/main/topic
 	To <URL/of/upstream.git>
-	 ! [remote rejected] HEAD -> refs/for/master/topic (failed)
+	 ! [remote rejected] HEAD -> refs/for/main/topic (failed)
 	EOF
 	test_cmp expect actual &&
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/main
 	EOF
 	test_cmp expect actual
 '
@@ -36,32 +36,32 @@ test_expect_success "setup proc-receive hook (ng message, $PROTOCOL)" '
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
-		-r "ng refs/for/master/topic error msg"
+		-r "ng refs/for/main/topic error msg"
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         :                       refs/for/master/topic
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       refs/for/main/topic
 test_expect_success "proc-receive: fail to update (ng, with message, $PROTOCOL)" '
 	test_must_fail git -C workbench push origin \
-		HEAD:refs/for/master/topic \
+		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
 	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
-	remote: proc-receive> ng refs/for/master/topic error msg
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
+	remote: proc-receive> ng refs/for/main/topic error msg
 	To <URL/of/upstream.git>
-	 ! [remote rejected] HEAD -> refs/for/master/topic (error msg)
+	 ! [remote rejected] HEAD -> refs/for/main/topic (error msg)
 	EOF
 	test_cmp expect actual &&
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/main
 	EOF
 	test_cmp expect actual
 '
diff --git a/t/t5411/test-0021-report-ng--porcelain.sh b/t/t5411/test-0021-report-ng--porcelain.sh
index fbf5569103..93475a83cf 100644
--- a/t/t5411/test-0021-report-ng--porcelain.sh
+++ b/t/t5411/test-0021-report-ng--porcelain.sh
@@ -2,33 +2,33 @@ test_expect_success "setup proc-receive hook (ng, no message, $PROTOCOL/porcelai
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
-		-r "ng refs/for/master/topic"
+		-r "ng refs/for/main/topic"
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         :                       refs/for/master/topic
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       refs/for/main/topic
 test_expect_success "proc-receive: fail to update (ng, no message, $PROTOCOL/porcelain)" '
 	test_must_fail git -C workbench push --porcelain origin \
-		HEAD:refs/for/master/topic \
+		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
 	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
-	remote: proc-receive> ng refs/for/master/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
+	remote: proc-receive> ng refs/for/main/topic
 	To <URL/of/upstream.git>
-	!    HEAD:refs/for/master/topic    [remote rejected] (failed)
+	!    HEAD:refs/for/main/topic    [remote rejected] (failed)
 	Done
 	EOF
 	test_cmp expect actual &&
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/main
 	EOF
 	test_cmp expect actual
 '
@@ -37,33 +37,33 @@ test_expect_success "setup proc-receive hook (ng message, $PROTOCOL/porcelain)"
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
-		-r "ng refs/for/master/topic error msg"
+		-r "ng refs/for/main/topic error msg"
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         :                       refs/for/master/topic
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       refs/for/main/topic
 test_expect_success "proc-receive: fail to update (ng, with message, $PROTOCOL/porcelain)" '
 	test_must_fail git -C workbench push --porcelain origin \
-		HEAD:refs/for/master/topic \
+		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
 	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
-	remote: proc-receive> ng refs/for/master/topic error msg
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
+	remote: proc-receive> ng refs/for/main/topic error msg
 	To <URL/of/upstream.git>
-	!    HEAD:refs/for/master/topic    [remote rejected] (error msg)
+	!    HEAD:refs/for/main/topic    [remote rejected] (error msg)
 	Done
 	EOF
 	test_cmp expect actual &&
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/main
 	EOF
 	test_cmp expect actual
 '
diff --git a/t/t5411/test-0022-report-unexpect-ref.sh b/t/t5411/test-0022-report-unexpect-ref.sh
index 92a415b929..f8be8a0ba1 100644
--- a/t/t5411/test-0022-report-unexpect-ref.sh
+++ b/t/t5411/test-0022-report-unexpect-ref.sh
@@ -2,44 +2,44 @@ test_expect_success "setup proc-receive hook (unexpected ref, $PROTOCOL)" '
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
-		-r "ok refs/heads/master"
+		-r "ok refs/heads/main"
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         : (B)                   refs/for/master/topic
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         : (B)                   refs/for/main/topic
 test_expect_success "proc-receive: report unexpected ref ($PROTOCOL)" '
 	test_must_fail git -C workbench push origin \
-		$B:refs/heads/master \
-		HEAD:refs/for/master/topic \
+		$B:refs/heads/main \
+		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
-	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
 	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
-	remote: proc-receive> ok refs/heads/master
-	remote: error: proc-receive reported status on unexpected ref: refs/heads/master
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
+	remote: proc-receive> ok refs/heads/main
+	remote: error: proc-receive reported status on unexpected ref: refs/heads/main
 	remote: # post-receive hook
-	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
 	To <URL/of/upstream.git>
-	 <OID-A>..<OID-B> <COMMIT-B> -> master
-	 ! [remote rejected] HEAD -> refs/for/master/topic (proc-receive failed to report status)
+	 <OID-A>..<OID-B> <COMMIT-B> -> main
+	 ! [remote rejected] HEAD -> refs/for/main/topic (proc-receive failed to report status)
 	EOF
 	test_cmp expect actual &&
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-B> refs/heads/master
+	<COMMIT-B> refs/heads/main
 	EOF
 	test_cmp expect actual
 '
 
-# Refs of upstream : master(B)
-# Refs of workbench: master(A)  tags/v123
+# Refs of upstream : main(B)
+# Refs of workbench: main(A)  tags/v123
 test_expect_success "cleanup ($PROTOCOL)" '
-	git -C "$upstream" update-ref refs/heads/master $A
+	git -C "$upstream" update-ref refs/heads/main $A
 '
diff --git a/t/t5411/test-0023-report-unexpect-ref--porcelain.sh b/t/t5411/test-0023-report-unexpect-ref--porcelain.sh
index acbf93e40a..778150fa03 100644
--- a/t/t5411/test-0023-report-unexpect-ref--porcelain.sh
+++ b/t/t5411/test-0023-report-unexpect-ref--porcelain.sh
@@ -2,45 +2,45 @@ test_expect_success "setup proc-receive hook (unexpected ref, $PROTOCOL/porcelai
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
-		-r "ok refs/heads/master"
+		-r "ok refs/heads/main"
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         : (B)                   refs/for/master/topic
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         : (B)                   refs/for/main/topic
 test_expect_success "proc-receive: report unexpected ref ($PROTOCOL/porcelain)" '
 	test_must_fail git -C workbench push --porcelain origin \
-		$B:refs/heads/master \
-		HEAD:refs/for/master/topic \
+		$B:refs/heads/main \
+		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
-	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
 	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
-	remote: proc-receive> ok refs/heads/master
-	remote: error: proc-receive reported status on unexpected ref: refs/heads/master
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
+	remote: proc-receive> ok refs/heads/main
+	remote: error: proc-receive reported status on unexpected ref: refs/heads/main
 	remote: # post-receive hook
-	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
 	To <URL/of/upstream.git>
-	     <COMMIT-B>:refs/heads/master    <OID-A>..<OID-B>
-	!    HEAD:refs/for/master/topic    [remote rejected] (proc-receive failed to report status)
+	     <COMMIT-B>:refs/heads/main    <OID-A>..<OID-B>
+	!    HEAD:refs/for/main/topic    [remote rejected] (proc-receive failed to report status)
 	Done
 	EOF
 	test_cmp expect actual &&
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-B> refs/heads/master
+	<COMMIT-B> refs/heads/main
 	EOF
 	test_cmp expect actual
 '
 
-# Refs of upstream : master(B)
-# Refs of workbench: master(A)  tags/v123
+# Refs of upstream : main(B)
+# Refs of workbench: main(A)  tags/v123
 test_expect_success "cleanup ($PROTOCOL/porcelain)" '
-	git -C "$upstream" update-ref refs/heads/master $A
+	git -C "$upstream" update-ref refs/heads/main $A
 '
diff --git a/t/t5411/test-0024-report-unknown-ref.sh b/t/t5411/test-0024-report-unknown-ref.sh
index c3946f329a..d4e74e4681 100644
--- a/t/t5411/test-0024-report-unknown-ref.sh
+++ b/t/t5411/test-0024-report-unknown-ref.sh
@@ -2,12 +2,12 @@ test_expect_success "setup proc-receive hook (unexpected ref, $PROTOCOL)" '
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
-		-r "ok refs/for/master/topic"
+		-r "ok refs/for/main/topic"
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
 # git push         :                       refs/for/a/b/c/my/topic
 test_expect_success "proc-receive: report unknown reference ($PROTOCOL)" '
 	test_must_fail git -C workbench push origin \
@@ -19,8 +19,8 @@ test_expect_success "proc-receive: report unknown reference ($PROTOCOL)" '
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/my/topic
 	remote: # proc-receive hook
 	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/my/topic
-	remote: proc-receive> ok refs/for/master/topic
-	remote: error: proc-receive reported status on unknown ref: refs/for/master/topic
+	remote: proc-receive> ok refs/for/main/topic
+	remote: error: proc-receive reported status on unknown ref: refs/for/main/topic
 	To <URL/of/upstream.git>
 	 ! [remote rejected] HEAD -> refs/for/a/b/c/my/topic (proc-receive failed to report status)
 	EOF
@@ -28,7 +28,7 @@ test_expect_success "proc-receive: report unknown reference ($PROTOCOL)" '
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/main
 	EOF
 	test_cmp expect actual
 '
diff --git a/t/t5411/test-0025-report-unknown-ref--porcelain.sh b/t/t5411/test-0025-report-unknown-ref--porcelain.sh
index d093b1a579..039e8b6163 100644
--- a/t/t5411/test-0025-report-unknown-ref--porcelain.sh
+++ b/t/t5411/test-0025-report-unknown-ref--porcelain.sh
@@ -2,12 +2,12 @@ test_expect_success "setup proc-receive hook (unexpected ref, $PROTOCOL/porcelai
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
-		-r "ok refs/for/master/topic"
+		-r "ok refs/for/main/topic"
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
 # git push         :                       refs/for/a/b/c/my/topic
 test_expect_success "proc-receive: report unknown reference ($PROTOCOL/porcelain)" '
 	test_must_fail git -C workbench push --porcelain origin \
@@ -19,8 +19,8 @@ test_expect_success "proc-receive: report unknown reference ($PROTOCOL/porcelain
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/my/topic
 	remote: # proc-receive hook
 	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/my/topic
-	remote: proc-receive> ok refs/for/master/topic
-	remote: error: proc-receive reported status on unknown ref: refs/for/master/topic
+	remote: proc-receive> ok refs/for/main/topic
+	remote: error: proc-receive reported status on unknown ref: refs/for/main/topic
 	To <URL/of/upstream.git>
 	!    HEAD:refs/for/a/b/c/my/topic    [remote rejected] (proc-receive failed to report status)
 	Done
@@ -29,7 +29,7 @@ test_expect_success "proc-receive: report unknown reference ($PROTOCOL/porcelain
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/main
 	EOF
 	test_cmp expect actual
 '
diff --git a/t/t5411/test-0026-push-options.sh b/t/t5411/test-0026-push-options.sh
index d0c4da8b23..d414be87d0 100644
--- a/t/t5411/test-0026-push-options.sh
+++ b/t/t5411/test-0026-push-options.sh
@@ -3,19 +3,19 @@ test_expect_success "setup proc-receive hook and disable push-options ($PROTOCOL
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
-		-r "ok refs/for/master/topic"
+		-r "ok refs/for/main/topic"
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push -o ...  :                       refs/for/master/topic
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push -o ...  :                       refs/for/main/topic
 test_expect_success "proc-receive: not support push options ($PROTOCOL)" '
 	test_must_fail git -C workbench push \
 		-o issue=123 \
 		-o reviewer=user1 \
 		origin \
-		HEAD:refs/for/master/topic \
+		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
 	test_i18ngrep "fatal: the receiving end does not support push options" \
@@ -23,7 +23,7 @@ test_expect_success "proc-receive: not support push options ($PROTOCOL)" '
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/main
 	EOF
 	test_cmp expect actual
 '
@@ -32,9 +32,9 @@ test_expect_success "enable push options ($PROTOCOL)" '
 	git -C "$upstream" config receive.advertisePushOptions true
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push -o ...  :                       next(A)  refs/for/master/topic
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push -o ...  :                       next(A)  refs/for/main/topic
 test_expect_success "proc-receive: push with options ($PROTOCOL)" '
 	git -C workbench push \
 		--atomic \
@@ -42,38 +42,38 @@ test_expect_success "proc-receive: push with options ($PROTOCOL)" '
 		-o reviewer=user1 \
 		origin \
 		HEAD:refs/heads/next \
-		HEAD:refs/for/master/topic \
+		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
 	remote: # proc-receive hook
 	remote: proc-receive: atomic push_options
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
 	remote: proc-receive< issue=123
 	remote: proc-receive< reviewer=user1
-	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> ok refs/for/main/topic
 	remote: # post-receive hook
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
 	To <URL/of/upstream.git>
 	 * [new branch] HEAD -> next
-	 * [new reference] HEAD -> refs/for/master/topic
+	 * [new reference] HEAD -> refs/for/main/topic
 	EOF
 	test_cmp expect actual &&
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/main
 	<COMMIT-A> refs/heads/next
 	EOF
 	test_cmp expect actual
 '
 
-# Refs of upstream : master(A)             next(A)
-# Refs of workbench: master(A)  tags/v123
+# Refs of upstream : main(A)             next(A)
+# Refs of workbench: main(A)  tags/v123
 test_expect_success "cleanup ($PROTOCOL)" '
 	git -C "$upstream" update-ref -d refs/heads/next
 '
diff --git a/t/t5411/test-0027-push-options--porcelain.sh b/t/t5411/test-0027-push-options--porcelain.sh
index c89a1e7c57..d5d0dcb172 100644
--- a/t/t5411/test-0027-push-options--porcelain.sh
+++ b/t/t5411/test-0027-push-options--porcelain.sh
@@ -3,20 +3,20 @@ test_expect_success "setup proc-receive hook and disable push-options ($PROTOCOL
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
-		-r "ok refs/for/master/topic"
+		-r "ok refs/for/main/topic"
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push -o ...  :                       refs/for/master/topic
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push -o ...  :                       refs/for/main/topic
 test_expect_success "proc-receive: not support push options ($PROTOCOL/porcelain)" '
 	test_must_fail git -C workbench push \
 		--porcelain \
 		-o issue=123 \
 		-o reviewer=user1 \
 		origin \
-		HEAD:refs/for/master/topic \
+		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
 	test_i18ngrep "fatal: the receiving end does not support push options" \
@@ -24,7 +24,7 @@ test_expect_success "proc-receive: not support push options ($PROTOCOL/porcelain
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/main
 	EOF
 	test_cmp expect actual
 '
@@ -33,9 +33,9 @@ test_expect_success "enable push options ($PROTOCOL/porcelain)" '
 	git -C "$upstream" config receive.advertisePushOptions true
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push -o ...  :                       next(A)  refs/for/master/topic
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push -o ...  :                       next(A)  refs/for/main/topic
 test_expect_success "proc-receive: push with options ($PROTOCOL/porcelain)" '
 	git -C workbench push \
 		--porcelain \
@@ -44,39 +44,39 @@ test_expect_success "proc-receive: push with options ($PROTOCOL/porcelain)" '
 		-o reviewer=user1 \
 		origin \
 		HEAD:refs/heads/next \
-		HEAD:refs/for/master/topic \
+		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
 	remote: # proc-receive hook
 	remote: proc-receive: atomic push_options
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
 	remote: proc-receive< issue=123
 	remote: proc-receive< reviewer=user1
-	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> ok refs/for/main/topic
 	remote: # post-receive hook
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
 	To <URL/of/upstream.git>
 	*    HEAD:refs/heads/next    [new branch]
-	*    HEAD:refs/for/master/topic    [new reference]
+	*    HEAD:refs/for/main/topic    [new reference]
 	Done
 	EOF
 	test_cmp expect actual &&
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/main
 	<COMMIT-A> refs/heads/next
 	EOF
 	test_cmp expect actual
 '
 
-# Refs of upstream : master(A)             next(A)
-# Refs of workbench: master(A)  tags/v123
+# Refs of upstream : main(A)             next(A)
+# Refs of workbench: main(A)  tags/v123
 test_expect_success "cleanup ($PROTOCOL/porcelain)" '
 	git -C "$upstream" update-ref -d refs/heads/next
 '
-- 
gitgitgadget

