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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981D9C388F9
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 22:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A60C221F7
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 22:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYrPvOZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506927AbgJ0W6W (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 18:58:22 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:51997 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728193AbgJ0W6T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 18:58:19 -0400
Received: by mail-wm1-f41.google.com with SMTP id v5so2873785wmh.1
        for <git@vger.kernel.org>; Tue, 27 Oct 2020 15:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=deyJN4aJGHxT7BF1OvP7ApvWrHvhwEBRzGqFrzZ82D0=;
        b=XYrPvOZbYJFvwRX5ICWH0kaswv0VNSlAFKpV+GnIzj/mA6NGGrgV21GSQ3EcXNcCZP
         +jLic4abdinyOd2UNby6xbkyZqd00W4Qv3wuqzLH3CFg1E75G42D8EEM4RsStD4aF/+o
         mY8TY7jzRgxMJS1ixCP3QA2mAi5CrYGRZLOD8VTeJ0TbR3RsY7aN6WqojovV7xgeVBFA
         ASXicdFukeWTSdqKLHg8sEKGtNEJGO4Y+OrdcYJy2k8MJymt6ZoJBhpQo1BsfyDOMeA1
         e6zo2VbWD33WYTwpew3tpGe1m+cAm/D1kSNI18KB8P6TvLiVaps5n+i9VeeDBU0onE9u
         7e6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=deyJN4aJGHxT7BF1OvP7ApvWrHvhwEBRzGqFrzZ82D0=;
        b=IlJporYm1LkAuC8F5CdRmu+p+KbB4eH5abqBDBxIUPjOqexJNFmHixd5Hv4tafS6Yt
         u///bue8F1TSV/FlL2M87f4rCWdFRO8BASl5cDLTpOVE6FSC/kxzw8pevyy+8hncj4/S
         2dCKCyh6DzKJKY44D4Nbzu2tL5WMHVu37vZhsCYggv75n0cjslc5LQhYlAH/DTwHROBf
         QbFflBWkoAc4cG+CbK88BEU9mfxVI3ezeLN325wNVN7IAsxGh49jBPBFMHK1Kc8PwRD4
         LQ/3n4gAkpyB7TnuR0kLSuOLShNKXdEiysHBa11dbuBT6X2eiFr6KN1XXFSXvvHdiR07
         ShQw==
X-Gm-Message-State: AOAM532ygYNHodlyfAc8i4CCjfQpVOxX7Ka5BLjmqB4252dtq758VJqk
        jnt2F+PsrCaPbZCUUf2+VdKRckX+Ofk=
X-Google-Smtp-Source: ABdhPJyEigzfYlW+wmYf9CpGtr44LCOqSOQmfYZwDTD5qakgn2GKI92Tdt7NzDbfAz1Belt+T1D5UA==
X-Received: by 2002:a05:600c:2144:: with SMTP id v4mr4916948wml.172.1603839490902;
        Tue, 27 Oct 2020 15:58:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 3sm3791208wmd.19.2020.10.27.15.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 15:58:10 -0700 (PDT)
Message-Id: <b9fcc47eb7d14aa2c879a3ec2a7d1f5804fcb283.1603839487.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.760.git.1603839487.gitgitgadget@gmail.com>
References: <pull.760.git.1603839487.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Oct 2020 22:58:05 +0000
Subject: [PATCH 2/4] t5411: start adjusting the support files for
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
		-e 's/Master/Main/g' -- t/t5411/test-00[3-5]*

We do not convert the files in `t/t5411/` in one go because the patch
would be too big (mails larger than 100kB are rejected by the Git
mailing list). Instead, we start with roughly half of the support files.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5411/test-0030-report-ok.sh                |  22 ++--
 t/t5411/test-0031-report-ok--porcelain.sh     |  22 ++--
 t/t5411/test-0032-report-with-options.sh      | 120 +++++++++---------
 ...est-0033-report-with-options--porcelain.sh | 120 +++++++++---------
 t/t5411/test-0034-report-ft.sh                |  30 ++---
 t/t5411/test-0035-report-ft--porcelain.sh     |  30 ++---
 ...t-0036-report-multi-rewrite-for-one-ref.sh |  90 ++++++-------
 ...rt-multi-rewrite-for-one-ref--porcelain.sh |  82 ++++++------
 t/t5411/test-0038-report-mixed-refs.sh        |  40 +++---
 .../test-0039-report-mixed-refs--porcelain.sh |  40 +++---
 t/t5411/test-0040-process-all-refs.sh         |  42 +++---
 .../test-0041-process-all-refs--porcelain.sh  |  42 +++---
 ...t-0050-proc-receive-refs-with-modifiers.sh |  42 +++---
 13 files changed, 361 insertions(+), 361 deletions(-)

diff --git a/t/t5411/test-0030-report-ok.sh b/t/t5411/test-0030-report-ok.sh
index 44c99d3831..5d6feef118 100644
--- a/t/t5411/test-0030-report-ok.sh
+++ b/t/t5411/test-0030-report-ok.sh
@@ -2,34 +2,34 @@ test_expect_success "setup proc-receive hook (ok, $PROTOCOL)" '
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
-		-r "ok refs/for/master/topic"
+		-r "ok refs/for/main/topic"
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         :                       refs/for/master/topic
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       refs/for/main/topic
 test_expect_success "proc-receive: ok ($PROTOCOL)" '
 	git -C workbench push origin \
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
-	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
+	remote: proc-receive> ok refs/for/main/topic
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
 	To <URL/of/upstream.git>
-	 * [new reference] HEAD -> refs/for/master/topic
+	 * [new reference] HEAD -> refs/for/main/topic
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
diff --git a/t/t5411/test-0031-report-ok--porcelain.sh b/t/t5411/test-0031-report-ok--porcelain.sh
index 3223b26184..91666d32df 100644
--- a/t/t5411/test-0031-report-ok--porcelain.sh
+++ b/t/t5411/test-0031-report-ok--porcelain.sh
@@ -2,35 +2,35 @@ test_expect_success "setup proc-receive hook (ok, $PROTOCOL/porcelain)" '
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
-		-r "ok refs/for/master/topic"
+		-r "ok refs/for/main/topic"
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         :                       refs/for/master/topic
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       refs/for/main/topic
 test_expect_success "proc-receive: ok ($PROTOCOL/porcelain)" '
 	git -C workbench push --porcelain origin \
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
-	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
+	remote: proc-receive> ok refs/for/main/topic
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
 	To <URL/of/upstream.git>
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
 	EOF
 	test_cmp expect actual
 '
diff --git a/t/t5411/test-0032-report-with-options.sh b/t/t5411/test-0032-report-with-options.sh
index b77b78c49f..a0faf5c7ff 100644
--- a/t/t5411/test-0032-report-with-options.sh
+++ b/t/t5411/test-0032-report-with-options.sh
@@ -7,24 +7,24 @@ test_expect_success "setup proc-receive hook (option without matching ok, $PROTO
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/main/topic(A)
 test_expect_success "proc-receive: report option without matching ok ($PROTOCOL)" '
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
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
 	remote: proc-receive> option refname refs/pull/123/head
 	remote: proc-receive> option old-oid <COMMIT-B>
 	remote: error: proc-receive reported "option" without a matching "ok/ng" directive
 	To <URL/of/upstream.git>
-	 ! [remote rejected] HEAD -> refs/for/master/topic (proc-receive failed to report status)
+	 ! [remote rejected] HEAD -> refs/for/main/topic (proc-receive failed to report status)
 	EOF
 	test_cmp expect actual
 '
@@ -33,25 +33,25 @@ test_expect_success "setup proc-receive hook (option refname, $PROTOCOL)" '
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
-		-r "ok refs/for/master/topic" \
+		-r "ok refs/for/main/topic" \
 		-r "option refname refs/pull/123/head"
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/main/topic(A)
 test_expect_success "proc-receive: report option refname ($PROTOCOL)" '
 	git -C workbench push origin \
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
-	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
+	remote: proc-receive> ok refs/for/main/topic
 	remote: proc-receive> option refname refs/pull/123/head
 	remote: # post-receive hook
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/pull/123/head
@@ -65,25 +65,25 @@ test_expect_success "setup proc-receive hook (option refname and forced-update,
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
-		-r "ok refs/for/master/topic" \
+		-r "ok refs/for/main/topic" \
 		-r "option refname refs/pull/123/head" \
 		-r "option forced-update"
 	EOF
 '
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/main/topic(A)
 test_expect_success "proc-receive: report option refname and forced-update ($PROTOCOL)" '
 	git -C workbench push origin \
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
-	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
+	remote: proc-receive> ok refs/for/main/topic
 	remote: proc-receive> option refname refs/pull/123/head
 	remote: proc-receive> option forced-update
 	remote: # post-receive hook
@@ -98,26 +98,26 @@ test_expect_success "setup proc-receive hook (option refname and old-oid, $PROTO
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
-		-r "ok refs/for/master/topic" \
+		-r "ok refs/for/main/topic" \
 		-r "option refname refs/pull/123/head" \
 		-r "option old-oid $B"
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/main/topic(A)
 test_expect_success "proc-receive: report option refname and old-oid ($PROTOCOL)" '
 	git -C workbench push origin \
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
-	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
+	remote: proc-receive> ok refs/for/main/topic
 	remote: proc-receive> option refname refs/pull/123/head
 	remote: proc-receive> option old-oid <COMMIT-B>
 	remote: # post-receive hook
@@ -132,30 +132,30 @@ test_expect_success "setup proc-receive hook (option old-oid, $PROTOCOL)" '
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
-		-r "ok refs/for/master/topic" \
+		-r "ok refs/for/main/topic" \
 		-r "option old-oid $B"
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/main/topic(A)
 test_expect_success "proc-receive: report option old-oid ($PROTOCOL)" '
 	git -C workbench push origin \
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
-	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
+	remote: proc-receive> ok refs/for/main/topic
 	remote: proc-receive> option old-oid <COMMIT-B>
 	remote: # post-receive hook
-	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/for/main/topic
 	To <URL/of/upstream.git>
-	 <OID-B>..<OID-A> HEAD -> refs/for/master/topic
+	 <OID-B>..<OID-A> HEAD -> refs/for/main/topic
 	EOF
 	test_cmp expect actual
 '
@@ -164,32 +164,32 @@ test_expect_success "setup proc-receive hook (option old-oid and new-oid, $PROTO
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
-		-r "ok refs/for/master/topic" \
+		-r "ok refs/for/main/topic" \
 		-r "option old-oid $A" \
 		-r "option new-oid $B"
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/main/topic(A)
 test_expect_success "proc-receive: report option old-oid and new-oid ($PROTOCOL)" '
 	git -C workbench push origin \
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
-	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
+	remote: proc-receive> ok refs/for/main/topic
 	remote: proc-receive> option old-oid <COMMIT-A>
 	remote: proc-receive> option new-oid <COMMIT-B>
 	remote: # post-receive hook
-	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/main/topic
 	To <URL/of/upstream.git>
-	 <OID-A>..<OID-B> HEAD -> refs/for/master/topic
+	 <OID-A>..<OID-B> HEAD -> refs/for/main/topic
 	EOF
 	test_cmp expect actual
 '
@@ -201,7 +201,7 @@ test_expect_success "setup proc-receive hook (report with multiple rewrites, $PR
 		-r "ok refs/for/a/b/c/topic" \
 		-r "ok refs/for/next/topic" \
 		-r "option refname refs/pull/123/head" \
-		-r "ok refs/for/master/topic" \
+		-r "ok refs/for/main/topic" \
 		-r "option refname refs/pull/124/head" \
 		-r "option old-oid $B" \
 		-r "option forced-update" \
@@ -209,29 +209,29 @@ test_expect_success "setup proc-receive hook (report with multiple rewrites, $PR
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/main/topic(A)
 test_expect_success "proc-receive: report with multiple rewrites ($PROTOCOL)" '
 	git -C workbench push origin \
 		HEAD:refs/for/next/topic \
 		HEAD:refs/for/a/b/c/topic \
-		HEAD:refs/for/master/topic \
+		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
 	remote: # proc-receive hook
 	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
 	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
 	remote: proc-receive> ok refs/for/a/b/c/topic
 	remote: proc-receive> ok refs/for/next/topic
 	remote: proc-receive> option refname refs/pull/123/head
-	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> ok refs/for/main/topic
 	remote: proc-receive> option refname refs/pull/124/head
 	remote: proc-receive> option old-oid <COMMIT-B>
 	remote: proc-receive> option forced-update
@@ -250,7 +250,7 @@ test_expect_success "proc-receive: report with multiple rewrites ($PROTOCOL)" '
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/main
 	EOF
 	test_cmp expect actual
 '
diff --git a/t/t5411/test-0033-report-with-options--porcelain.sh b/t/t5411/test-0033-report-with-options--porcelain.sh
index 1fe352b686..32ae26bcfb 100644
--- a/t/t5411/test-0033-report-with-options--porcelain.sh
+++ b/t/t5411/test-0033-report-with-options--porcelain.sh
@@ -7,24 +7,24 @@ test_expect_success "setup proc-receive hook (option without matching ok, $PROTO
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/main/topic(A)
 test_expect_success "proc-receive: report option without matching ok ($PROTOCOL/porcelain)" '
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
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
 	remote: proc-receive> option refname refs/pull/123/head
 	remote: proc-receive> option old-oid <COMMIT-B>
 	remote: error: proc-receive reported "option" without a matching "ok/ng" directive
 	To <URL/of/upstream.git>
-	!    HEAD:refs/for/master/topic    [remote rejected] (proc-receive failed to report status)
+	!    HEAD:refs/for/main/topic    [remote rejected] (proc-receive failed to report status)
 	Done
 	EOF
 	test_cmp expect actual
@@ -34,25 +34,25 @@ test_expect_success "setup proc-receive hook (option refname, $PROTOCOL/porcelai
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
-		-r "ok refs/for/master/topic" \
+		-r "ok refs/for/main/topic" \
 		-r "option refname refs/pull/123/head"
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/main/topic(A)
 test_expect_success "proc-receive: report option refname ($PROTOCOL/porcelain)" '
 	git -C workbench push --porcelain origin \
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
-	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
+	remote: proc-receive> ok refs/for/main/topic
 	remote: proc-receive> option refname refs/pull/123/head
 	remote: # post-receive hook
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/pull/123/head
@@ -67,26 +67,26 @@ test_expect_success "setup proc-receive hook (option refname and forced-update,
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
-		-r "ok refs/for/master/topic" \
+		-r "ok refs/for/main/topic" \
 		-r "option refname refs/pull/123/head" \
 		-r "option forced-update"
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/main/topic(A)
 test_expect_success "proc-receive: report option refname and forced-update ($PROTOCOL/porcelain)" '
 	git -C workbench push --porcelain origin \
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
-	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
+	remote: proc-receive> ok refs/for/main/topic
 	remote: proc-receive> option refname refs/pull/123/head
 	remote: proc-receive> option forced-update
 	remote: # post-receive hook
@@ -102,26 +102,26 @@ test_expect_success "setup proc-receive hook (option refname and old-oid, $PROTO
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
-		-r "ok refs/for/master/topic" \
+		-r "ok refs/for/main/topic" \
 		-r "option refname refs/pull/123/head" \
 		-r "option old-oid $B"
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/main/topic(A)
 test_expect_success "proc-receive: report option refname and old-oid ($PROTOCOL/porcelain)" '
 	git -C workbench push --porcelain origin \
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
-	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
+	remote: proc-receive> ok refs/for/main/topic
 	remote: proc-receive> option refname refs/pull/123/head
 	remote: proc-receive> option old-oid <COMMIT-B>
 	remote: # post-receive hook
@@ -137,30 +137,30 @@ test_expect_success "setup proc-receive hook (option old-oid, $PROTOCOL/porcelai
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
-		-r "ok refs/for/master/topic" \
+		-r "ok refs/for/main/topic" \
 		-r "option old-oid $B"
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/main/topic(A)
 test_expect_success "proc-receive: report option old-oid ($PROTOCOL/porcelain)" '
 	git -C workbench push --porcelain origin \
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
-	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
+	remote: proc-receive> ok refs/for/main/topic
 	remote: proc-receive> option old-oid <COMMIT-B>
 	remote: # post-receive hook
-	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/for/main/topic
 	To <URL/of/upstream.git>
-	     HEAD:refs/for/master/topic    <OID-B>..<OID-A>
+	     HEAD:refs/for/main/topic    <OID-B>..<OID-A>
 	Done
 	EOF
 	test_cmp expect actual
@@ -170,32 +170,32 @@ test_expect_success "setup proc-receive hook (option old-oid and new-oid, $PROTO
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
-		-r "ok refs/for/master/topic" \
+		-r "ok refs/for/main/topic" \
 		-r "option old-oid $A" \
 		-r "option new-oid $B"
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/main/topic(A)
 test_expect_success "proc-receive: report option old-oid and new-oid ($PROTOCOL/porcelain)" '
 	git -C workbench push --porcelain origin \
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
-	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
+	remote: proc-receive> ok refs/for/main/topic
 	remote: proc-receive> option old-oid <COMMIT-A>
 	remote: proc-receive> option new-oid <COMMIT-B>
 	remote: # post-receive hook
-	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/main/topic
 	To <URL/of/upstream.git>
-	     HEAD:refs/for/master/topic    <OID-A>..<OID-B>
+	     HEAD:refs/for/main/topic    <OID-A>..<OID-B>
 	Done
 	EOF
 	test_cmp expect actual
@@ -208,7 +208,7 @@ test_expect_success "setup proc-receive hook (report with multiple rewrites, $PR
 		-r "ok refs/for/a/b/c/topic" \
 		-r "ok refs/for/next/topic" \
 		-r "option refname refs/pull/123/head" \
-		-r "ok refs/for/master/topic" \
+		-r "ok refs/for/main/topic" \
 		-r "option refname refs/pull/124/head" \
 		-r "option old-oid $B" \
 		-r "option forced-update" \
@@ -217,29 +217,29 @@ test_expect_success "setup proc-receive hook (report with multiple rewrites, $PR
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/main/topic(A)
 test_expect_success "proc-receive: report with multiple rewrites ($PROTOCOL/porcelain)" '
 	git -C workbench push --porcelain origin \
 		HEAD:refs/for/next/topic \
 		HEAD:refs/for/a/b/c/topic \
-		HEAD:refs/for/master/topic \
+		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
 	remote: # proc-receive hook
 	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
 	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
 	remote: proc-receive> ok refs/for/a/b/c/topic
 	remote: proc-receive> ok refs/for/next/topic
 	remote: proc-receive> option refname refs/pull/123/head
-	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> ok refs/for/main/topic
 	remote: proc-receive> option refname refs/pull/124/head
 	remote: proc-receive> option old-oid <COMMIT-B>
 	remote: proc-receive> option forced-update
@@ -259,7 +259,7 @@ test_expect_success "proc-receive: report with multiple rewrites ($PROTOCOL/porc
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/main
 	EOF
 	test_cmp expect actual
 '
diff --git a/t/t5411/test-0034-report-ft.sh b/t/t5411/test-0034-report-ft.sh
index aca2b0676c..c355c290d2 100644
--- a/t/t5411/test-0034-report-ft.sh
+++ b/t/t5411/test-0034-report-ft.sh
@@ -2,43 +2,43 @@ test_expect_success "setup proc-receive hook (ft, $PROTOCOL)" '
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
-		-r "ok refs/for/master/topic" \
+		-r "ok refs/for/main/topic" \
 		-r "option fall-through"
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         :                       refs/for/master/topic(B)
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       refs/for/main/topic(B)
 test_expect_success "proc-receive: fall throught, let receive-pack to execute ($PROTOCOL)" '
 	git -C workbench push origin \
-		$B:refs/for/master/topic \
+		$B:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-B> refs/for/master/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-B> refs/for/main/topic
 	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-B> refs/for/master/topic
-	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-B> refs/for/main/topic
+	remote: proc-receive> ok refs/for/main/topic
 	remote: proc-receive> option fall-through
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-B> refs/for/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-B> refs/for/main/topic
 	To <URL/of/upstream.git>
-	 * [new reference] <COMMIT-B> -> refs/for/master/topic
+	 * [new reference] <COMMIT-B> -> refs/for/main/topic
 	EOF
 	test_cmp expect actual &&
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-B> refs/for/master/topic
-	<COMMIT-A> refs/heads/master
+	<COMMIT-B> refs/for/main/topic
+	<COMMIT-A> refs/heads/main
 	EOF
 	test_cmp expect actual
 '
 
-# Refs of upstream : master(A)             refs/for/master/topic(A)
-# Refs of workbench: master(A)  tags/v123
+# Refs of upstream : main(A)             refs/for/main/topic(A)
+# Refs of workbench: main(A)  tags/v123
 test_expect_success "cleanup ($PROTOCOL)" '
-	git -C "$upstream" update-ref -d refs/for/master/topic
+	git -C "$upstream" update-ref -d refs/for/main/topic
 '
diff --git a/t/t5411/test-0035-report-ft--porcelain.sh b/t/t5411/test-0035-report-ft--porcelain.sh
index 30ffffb352..8ce4e58f2a 100644
--- a/t/t5411/test-0035-report-ft--porcelain.sh
+++ b/t/t5411/test-0035-report-ft--porcelain.sh
@@ -2,44 +2,44 @@ test_expect_success "setup proc-receive hook (fall-through, $PROTOCOL/porcelain)
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
-		-r "ok refs/for/master/topic" \
+		-r "ok refs/for/main/topic" \
 		-r "option fall-through"
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         :                       refs/for/master/topic(B)
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       refs/for/main/topic(B)
 test_expect_success "proc-receive: fall throught, let receive-pack to execute ($PROTOCOL/porcelain)" '
 	git -C workbench push --porcelain origin \
-		$B:refs/for/master/topic \
+		$B:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-B> refs/for/master/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-B> refs/for/main/topic
 	remote: # proc-receive hook
-	remote: proc-receive< <ZERO-OID> <COMMIT-B> refs/for/master/topic
-	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-B> refs/for/main/topic
+	remote: proc-receive> ok refs/for/main/topic
 	remote: proc-receive> option fall-through
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-B> refs/for/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-B> refs/for/main/topic
 	To <URL/of/upstream.git>
-	*    <COMMIT-B>:refs/for/master/topic    [new reference]
+	*    <COMMIT-B>:refs/for/main/topic    [new reference]
 	Done
 	EOF
 	test_cmp expect actual &&
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-B> refs/for/master/topic
-	<COMMIT-A> refs/heads/master
+	<COMMIT-B> refs/for/main/topic
+	<COMMIT-A> refs/heads/main
 	EOF
 	test_cmp expect actual
 '
 
-# Refs of upstream : master(A)             refs/for/master/topic(A)
-# Refs of workbench: master(A)  tags/v123
+# Refs of upstream : main(A)             refs/for/main/topic(A)
+# Refs of workbench: main(A)  tags/v123
 test_expect_success "cleanup ($PROTOCOL/porcelain)" '
-	git -C "$upstream" update-ref -d refs/for/master/topic
+	git -C "$upstream" update-ref -d refs/for/main/topic
 '
diff --git a/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh b/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
index 73283d81e8..fad8eea8a0 100644
--- a/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
+++ b/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
@@ -17,50 +17,50 @@ test_expect_success "setup proc-receive hook (multiple rewrites for one ref, no
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
-		-r "ok refs/for/master/topic" \
+		-r "ok refs/for/main/topic" \
 		-r "option old-oid $A" \
 		-r "option new-oid $B" \
-		-r "ok refs/for/master/topic" \
+		-r "ok refs/for/main/topic" \
 		-r "option refname refs/changes/24/124/1" \
 		-r "option old-oid $ZERO_OID" \
 		-r "option new-oid $A" \
-		-r "ok refs/for/master/topic" \
+		-r "ok refs/for/main/topic" \
 		-r "option refname refs/changes/25/125/1" \
 		-r "option old-oid $A" \
 		-r "option new-oid $B"
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         :                       refs/for/master/topic(A)
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       refs/for/main/topic(A)
 test_expect_success "proc-receive: multiple rewrite for one ref, no refname for the 1st rewrite ($PROTOCOL)" '
 	git -C workbench push origin \
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
-	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
+	remote: proc-receive> ok refs/for/main/topic
 	remote: proc-receive> option old-oid <COMMIT-A>
 	remote: proc-receive> option new-oid <COMMIT-B>
-	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> ok refs/for/main/topic
 	remote: proc-receive> option refname refs/changes/24/124/1
 	remote: proc-receive> option old-oid <ZERO-OID>
 	remote: proc-receive> option new-oid <COMMIT-A>
-	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> ok refs/for/main/topic
 	remote: proc-receive> option refname refs/changes/25/125/1
 	remote: proc-receive> option old-oid <COMMIT-A>
 	remote: proc-receive> option new-oid <COMMIT-B>
 	remote: # post-receive hook
-	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/main/topic
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/changes/24/124/1
 	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/changes/25/125/1
 	To <URL/of/upstream.git>
-	 <OID-A>..<OID-B> HEAD -> refs/for/master/topic
+	 <OID-A>..<OID-B> HEAD -> refs/for/main/topic
 	 * [new reference] HEAD -> refs/changes/24/124/1
 	 <OID-A>..<OID-B> HEAD -> refs/changes/25/125/1
 	EOF
@@ -68,7 +68,7 @@ test_expect_success "proc-receive: multiple rewrite for one ref, no refname for
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/main
 	EOF
 	test_cmp expect actual
 '
@@ -80,10 +80,10 @@ test_expect_success "proc-receive: check remote-tracking #1 ($PROTOCOL)" '
 	cat >expect <<-EOF &&
 	<COMMIT-A> refs/t/changes/24/124/1
 	<COMMIT-B> refs/t/changes/25/125/1
-	<COMMIT-B> refs/t/for/master/topic
+	<COMMIT-B> refs/t/for/main/topic
 	EOF
 	test_cmp expect actual &&
-	git -C workbench update-ref -d refs/t/for/master/topic &&
+	git -C workbench update-ref -d refs/t/for/main/topic &&
 	git -C workbench update-ref -d refs/t/changes/24/124/1 &&
 	git -C workbench update-ref -d refs/t/changes/25/125/1
 '
@@ -92,14 +92,14 @@ test_expect_success "setup proc-receive hook (multiple rewrites for one ref, no
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
-		-r "ok refs/for/master/topic" \
+		-r "ok refs/for/main/topic" \
 		-r "option refname refs/changes/24/124/1" \
 		-r "option old-oid $ZERO_OID" \
 		-r "option new-oid $A" \
-		-r "ok refs/for/master/topic" \
+		-r "ok refs/for/main/topic" \
 		-r "option old-oid $A" \
 		-r "option new-oid $B" \
-		-r "ok refs/for/master/topic" \
+		-r "ok refs/for/main/topic" \
 		-r "option refname refs/changes/25/125/1" \
 		-r "option old-oid $B" \
 		-r "option new-oid $A" \
@@ -107,45 +107,45 @@ test_expect_success "setup proc-receive hook (multiple rewrites for one ref, no
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         :                       refs/for/master/topic(A)
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       refs/for/main/topic(A)
 test_expect_success "proc-receive: multiple rewrites for one ref, no refname for the 2nd rewrite ($PROTOCOL)" '
 	git -C workbench push origin \
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
-	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
+	remote: proc-receive> ok refs/for/main/topic
 	remote: proc-receive> option refname refs/changes/24/124/1
 	remote: proc-receive> option old-oid <ZERO-OID>
 	remote: proc-receive> option new-oid <COMMIT-A>
-	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> ok refs/for/main/topic
 	remote: proc-receive> option old-oid <COMMIT-A>
 	remote: proc-receive> option new-oid <COMMIT-B>
-	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> ok refs/for/main/topic
 	remote: proc-receive> option refname refs/changes/25/125/1
 	remote: proc-receive> option old-oid <COMMIT-B>
 	remote: proc-receive> option new-oid <COMMIT-A>
 	remote: proc-receive> option forced-update
 	remote: # post-receive hook
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/changes/24/124/1
-	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/main/topic
 	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/changes/25/125/1
 	To <URL/of/upstream.git>
 	 * [new reference] HEAD -> refs/changes/24/124/1
-	 <OID-A>..<OID-B> HEAD -> refs/for/master/topic
+	 <OID-A>..<OID-B> HEAD -> refs/for/main/topic
 	 + <OID-B>...<OID-A> HEAD -> refs/changes/25/125/1 (forced update)
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
@@ -157,10 +157,10 @@ test_expect_success "proc-receive: check remote-tracking #2 ($PROTOCOL)" '
 	cat >expect <<-EOF &&
 	<COMMIT-A> refs/t/changes/24/124/1
 	<COMMIT-A> refs/t/changes/25/125/1
-	<COMMIT-B> refs/t/for/master/topic
+	<COMMIT-B> refs/t/for/main/topic
 	EOF
 	test_cmp expect actual &&
-	git -C workbench update-ref -d refs/t/for/master/topic &&
+	git -C workbench update-ref -d refs/t/for/main/topic &&
 	git -C workbench update-ref -d refs/t/changes/24/124/1 &&
 	git -C workbench update-ref -d refs/t/changes/25/125/1
 '
@@ -169,31 +169,31 @@ test_expect_success "setup proc-receive hook (multiple rewrites for one ref, $PR
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
-		-r "ok refs/for/master/topic" \
+		-r "ok refs/for/main/topic" \
 		-r "option refname refs/changes/23/123/1" \
-		-r "ok refs/for/master/topic" \
+		-r "ok refs/for/main/topic" \
 		-r "option refname refs/changes/24/124/2" \
 		-r "option old-oid $A" \
 		-r "option new-oid $B"
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         :                       refs/for/master/topic(A)
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       refs/for/main/topic(A)
 test_expect_success "proc-receive: multiple rewrites for one ref ($PROTOCOL)" '
 	git -C workbench push origin \
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
-	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
+	remote: proc-receive> ok refs/for/main/topic
 	remote: proc-receive> option refname refs/changes/23/123/1
-	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> ok refs/for/main/topic
 	remote: proc-receive> option refname refs/changes/24/124/2
 	remote: proc-receive> option old-oid <COMMIT-A>
 	remote: proc-receive> option new-oid <COMMIT-B>
@@ -208,7 +208,7 @@ test_expect_success "proc-receive: multiple rewrites for one ref ($PROTOCOL)" '
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/main
 	EOF
 	test_cmp expect actual
 '
diff --git a/t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh b/t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh
index 77b5b22ed4..dc254d57eb 100644
--- a/t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh
+++ b/t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh
@@ -2,50 +2,50 @@ test_expect_success "setup proc-receive hook (multiple rewrites for one ref, no
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
-		-r "ok refs/for/master/topic" \
+		-r "ok refs/for/main/topic" \
 		-r "option old-oid $A" \
 		-r "option new-oid $B" \
-		-r "ok refs/for/master/topic" \
+		-r "ok refs/for/main/topic" \
 		-r "option refname refs/changes/24/124/1" \
 		-r "option old-oid $ZERO_OID" \
 		-r "option new-oid $A" \
-		-r "ok refs/for/master/topic" \
+		-r "ok refs/for/main/topic" \
 		-r "option refname refs/changes/25/125/1" \
 		-r "option old-oid $A" \
 		-r "option new-oid $B"
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         :                       refs/for/master/topic(A)
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       refs/for/main/topic(A)
 test_expect_success "proc-receive: multiple rewrite for one ref, no refname for the 1st rewrite ($PROTOCOL/porcelain)" '
 	git -C workbench push --porcelain origin \
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
-	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
+	remote: proc-receive> ok refs/for/main/topic
 	remote: proc-receive> option old-oid <COMMIT-A>
 	remote: proc-receive> option new-oid <COMMIT-B>
-	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> ok refs/for/main/topic
 	remote: proc-receive> option refname refs/changes/24/124/1
 	remote: proc-receive> option old-oid <ZERO-OID>
 	remote: proc-receive> option new-oid <COMMIT-A>
-	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> ok refs/for/main/topic
 	remote: proc-receive> option refname refs/changes/25/125/1
 	remote: proc-receive> option old-oid <COMMIT-A>
 	remote: proc-receive> option new-oid <COMMIT-B>
 	remote: # post-receive hook
-	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/main/topic
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/changes/24/124/1
 	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/changes/25/125/1
 	To <URL/of/upstream.git>
-	     HEAD:refs/for/master/topic    <OID-A>..<OID-B>
+	     HEAD:refs/for/main/topic    <OID-A>..<OID-B>
 	*    HEAD:refs/changes/24/124/1    [new reference]
 	     HEAD:refs/changes/25/125/1    <OID-A>..<OID-B>
 	Done
@@ -54,7 +54,7 @@ test_expect_success "proc-receive: multiple rewrite for one ref, no refname for
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/main
 	EOF
 	test_cmp expect actual
 '
@@ -63,14 +63,14 @@ test_expect_success "setup proc-receive hook (multiple rewrites for one ref, no
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
-		-r "ok refs/for/master/topic" \
+		-r "ok refs/for/main/topic" \
 		-r "option refname refs/changes/24/124/1" \
 		-r "option old-oid $ZERO_OID" \
 		-r "option new-oid $A" \
-		-r "ok refs/for/master/topic" \
+		-r "ok refs/for/main/topic" \
 		-r "option old-oid $A" \
 		-r "option new-oid $B" \
-		-r "ok refs/for/master/topic" \
+		-r "ok refs/for/main/topic" \
 		-r "option refname refs/changes/25/125/1" \
 		-r "option old-oid $B" \
 		-r "option new-oid $A" \
@@ -78,38 +78,38 @@ test_expect_success "setup proc-receive hook (multiple rewrites for one ref, no
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         :                       refs/for/master/topic(A)
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       refs/for/main/topic(A)
 test_expect_success "proc-receive: multiple rewrites for one ref, no refname for the 2nd rewrite ($PROTOCOL/porcelain)" '
 	git -C workbench push --porcelain origin \
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
-	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
+	remote: proc-receive> ok refs/for/main/topic
 	remote: proc-receive> option refname refs/changes/24/124/1
 	remote: proc-receive> option old-oid <ZERO-OID>
 	remote: proc-receive> option new-oid <COMMIT-A>
-	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> ok refs/for/main/topic
 	remote: proc-receive> option old-oid <COMMIT-A>
 	remote: proc-receive> option new-oid <COMMIT-B>
-	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> ok refs/for/main/topic
 	remote: proc-receive> option refname refs/changes/25/125/1
 	remote: proc-receive> option old-oid <COMMIT-B>
 	remote: proc-receive> option new-oid <COMMIT-A>
 	remote: proc-receive> option forced-update
 	remote: # post-receive hook
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/changes/24/124/1
-	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/main/topic
 	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/changes/25/125/1
 	To <URL/of/upstream.git>
 	*    HEAD:refs/changes/24/124/1    [new reference]
-	     HEAD:refs/for/master/topic    <OID-A>..<OID-B>
+	     HEAD:refs/for/main/topic    <OID-A>..<OID-B>
 	+    HEAD:refs/changes/25/125/1    <OID-B>...<OID-A> (forced update)
 	Done
 	EOF
@@ -117,7 +117,7 @@ test_expect_success "proc-receive: multiple rewrites for one ref, no refname for
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/main
 	EOF
 	test_cmp expect actual
 '
@@ -126,31 +126,31 @@ test_expect_success "setup proc-receive hook (multiple rewrites for one ref, $PR
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
-		-r "ok refs/for/master/topic" \
+		-r "ok refs/for/main/topic" \
 		-r "option refname refs/changes/23/123/1" \
-		-r "ok refs/for/master/topic" \
+		-r "ok refs/for/main/topic" \
 		-r "option refname refs/changes/24/124/2" \
 		-r "option old-oid $A" \
 		-r "option new-oid $B"
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         :                       refs/for/master/topic(A)
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       refs/for/main/topic(A)
 test_expect_success "proc-receive: multiple rewrites for one ref ($PROTOCOL/porcelain)" '
 	git -C workbench push --porcelain origin \
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
-	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
+	remote: proc-receive> ok refs/for/main/topic
 	remote: proc-receive> option refname refs/changes/23/123/1
-	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> ok refs/for/main/topic
 	remote: proc-receive> option refname refs/changes/24/124/2
 	remote: proc-receive> option old-oid <COMMIT-A>
 	remote: proc-receive> option new-oid <COMMIT-B>
@@ -166,7 +166,7 @@ test_expect_success "proc-receive: multiple rewrites for one ref ($PROTOCOL/porc
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/main
 	EOF
 	test_cmp expect actual
 '
diff --git a/t/t5411/test-0038-report-mixed-refs.sh b/t/t5411/test-0038-report-mixed-refs.sh
index a74a2cb449..0d071ebaa6 100644
--- a/t/t5411/test-0038-report-mixed-refs.sh
+++ b/t/t5411/test-0038-report-mixed-refs.sh
@@ -4,63 +4,63 @@ test_expect_success "setup proc-receive hook ($PROTOCOL)" '
 	test-tool proc-receive -v \
 		-r "ok refs/for/next/topic2" \
 		-r "ng refs/for/next/topic1 fail to call Web API" \
-		-r "ok refs/for/master/topic" \
-		-r "option refname refs/for/master/topic" \
+		-r "ok refs/for/main/topic" \
+		-r "option refname refs/for/main/topic" \
 		-r "option old-oid $A" \
 		-r "option new-oid $B"
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         : (B)                   bar(A)  baz(A)  refs/for/next/topic(A)  foo(A)  refs/for/master/topic(A)
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         : (B)                   bar(A)  baz(A)  refs/for/next/topic(A)  foo(A)  refs/for/main/topic(A)
 test_expect_success "proc-receive: report update of mixed refs ($PROTOCOL)" '
 	test_must_fail git -C workbench push origin \
-		$B:refs/heads/master \
+		$B:refs/heads/main \
 		HEAD:refs/heads/bar \
 		HEAD:refs/heads/baz \
 		HEAD:refs/for/next/topic2 \
 		HEAD:refs/for/next/topic1 \
 		HEAD:refs/heads/foo \
-		HEAD:refs/for/master/topic \
+		HEAD:refs/for/main/topic \
 		HEAD:refs/for/next/topic3 \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
-	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
+	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/bar
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic2
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic1
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic3
 	remote: # proc-receive hook
 	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic2
 	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic1
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
 	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic3
 	remote: proc-receive> ok refs/for/next/topic2
 	remote: proc-receive> ng refs/for/next/topic1 fail to call Web API
-	remote: proc-receive> ok refs/for/master/topic
-	remote: proc-receive> option refname refs/for/master/topic
+	remote: proc-receive> ok refs/for/main/topic
+	remote: proc-receive> option refname refs/for/main/topic
 	remote: proc-receive> option old-oid <COMMIT-A>
 	remote: proc-receive> option new-oid <COMMIT-B>
 	remote: # post-receive hook
-	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/bar
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic2
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
-	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/main/topic
 	To <URL/of/upstream.git>
-	 <OID-A>..<OID-B> <COMMIT-B> -> master
+	 <OID-A>..<OID-B> <COMMIT-B> -> main
 	 * [new branch] HEAD -> bar
 	 * [new branch] HEAD -> baz
 	 * [new reference] HEAD -> refs/for/next/topic2
 	 * [new branch] HEAD -> foo
-	 <OID-A>..<OID-B> HEAD -> refs/for/master/topic
+	 <OID-A>..<OID-B> HEAD -> refs/for/main/topic
 	 ! [remote rejected] HEAD -> refs/for/next/topic1 (fail to call Web API)
 	 ! [remote rejected] HEAD -> refs/for/next/topic3 (proc-receive failed to report status)
 	EOF
@@ -71,17 +71,17 @@ test_expect_success "proc-receive: report update of mixed refs ($PROTOCOL)" '
 	<COMMIT-A> refs/heads/bar
 	<COMMIT-A> refs/heads/baz
 	<COMMIT-A> refs/heads/foo
-	<COMMIT-B> refs/heads/master
+	<COMMIT-B> refs/heads/main
 	EOF
 	test_cmp expect actual
 '
 
-# Refs of upstream : master(B)             foo(A)  bar(A))  baz(A)
-# Refs of workbench: master(A)  tags/v123
+# Refs of upstream : main(B)             foo(A)  bar(A))  baz(A)
+# Refs of workbench: main(A)  tags/v123
 test_expect_success "cleanup ($PROTOCOL)" '
 	(
 		cd "$upstream" &&
-		git update-ref refs/heads/master $A &&
+		git update-ref refs/heads/main $A &&
 		git update-ref -d refs/heads/foo &&
 		git update-ref -d refs/heads/bar &&
 		git update-ref -d refs/heads/baz
diff --git a/t/t5411/test-0039-report-mixed-refs--porcelain.sh b/t/t5411/test-0039-report-mixed-refs--porcelain.sh
index e4baa13ea3..d8409912fd 100644
--- a/t/t5411/test-0039-report-mixed-refs--porcelain.sh
+++ b/t/t5411/test-0039-report-mixed-refs--porcelain.sh
@@ -4,63 +4,63 @@ test_expect_success "setup proc-receive hook ($PROTOCOL/porcelain)" '
 	test-tool proc-receive -v \
 		-r "ok refs/for/next/topic2" \
 		-r "ng refs/for/next/topic1 fail to call Web API" \
-		-r "ok refs/for/master/topic" \
-		-r "option refname refs/for/master/topic" \
+		-r "ok refs/for/main/topic" \
+		-r "option refname refs/for/main/topic" \
 		-r "option old-oid $A" \
 		-r "option new-oid $B"
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         : (B)                   bar(A)  baz(A)  refs/for/next/topic(A)  foo(A)  refs/for/master/topic(A)
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         : (B)                   bar(A)  baz(A)  refs/for/next/topic(A)  foo(A)  refs/for/main/topic(A)
 test_expect_success "proc-receive: report update of mixed refs ($PROTOCOL/porcelain)" '
 	test_must_fail git -C workbench push --porcelain origin \
-		$B:refs/heads/master \
+		$B:refs/heads/main \
 		HEAD:refs/heads/bar \
 		HEAD:refs/heads/baz \
 		HEAD:refs/for/next/topic2 \
 		HEAD:refs/for/next/topic1 \
 		HEAD:refs/heads/foo \
-		HEAD:refs/for/master/topic \
+		HEAD:refs/for/main/topic \
 		HEAD:refs/for/next/topic3 \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
-	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
+	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/bar
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic2
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic1
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic3
 	remote: # proc-receive hook
 	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic2
 	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic1
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
 	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic3
 	remote: proc-receive> ok refs/for/next/topic2
 	remote: proc-receive> ng refs/for/next/topic1 fail to call Web API
-	remote: proc-receive> ok refs/for/master/topic
-	remote: proc-receive> option refname refs/for/master/topic
+	remote: proc-receive> ok refs/for/main/topic
+	remote: proc-receive> option refname refs/for/main/topic
 	remote: proc-receive> option old-oid <COMMIT-A>
 	remote: proc-receive> option new-oid <COMMIT-B>
 	remote: # post-receive hook
-	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/bar
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic2
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
-	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/main/topic
 	To <URL/of/upstream.git>
-	     <COMMIT-B>:refs/heads/master    <OID-A>..<OID-B>
+	     <COMMIT-B>:refs/heads/main    <OID-A>..<OID-B>
 	*    HEAD:refs/heads/bar    [new branch]
 	*    HEAD:refs/heads/baz    [new branch]
 	*    HEAD:refs/for/next/topic2    [new reference]
 	*    HEAD:refs/heads/foo    [new branch]
-	     HEAD:refs/for/master/topic    <OID-A>..<OID-B>
+	     HEAD:refs/for/main/topic    <OID-A>..<OID-B>
 	!    HEAD:refs/for/next/topic1    [remote rejected] (fail to call Web API)
 	!    HEAD:refs/for/next/topic3    [remote rejected] (proc-receive failed to report status)
 	Done
@@ -72,17 +72,17 @@ test_expect_success "proc-receive: report update of mixed refs ($PROTOCOL/porcel
 	<COMMIT-A> refs/heads/bar
 	<COMMIT-A> refs/heads/baz
 	<COMMIT-A> refs/heads/foo
-	<COMMIT-B> refs/heads/master
+	<COMMIT-B> refs/heads/main
 	EOF
 	test_cmp expect actual
 '
 
-# Refs of upstream : master(B)             foo(A)  bar(A))  baz(A)
-# Refs of workbench: master(A)  tags/v123
+# Refs of upstream : main(B)             foo(A)  bar(A))  baz(A)
+# Refs of workbench: main(A)  tags/v123
 test_expect_success "cleanup ($PROTOCOL/porcelain)" '
 	(
 		cd "$upstream" &&
-		git update-ref refs/heads/master $A &&
+		git update-ref refs/heads/main $A &&
 		git update-ref -d refs/heads/foo &&
 		git update-ref -d refs/heads/bar &&
 		git update-ref -d refs/heads/baz
diff --git a/t/t5411/test-0040-process-all-refs.sh b/t/t5411/test-0040-process-all-refs.sh
index b07c999f53..2565302a17 100644
--- a/t/t5411/test-0040-process-all-refs.sh
+++ b/t/t5411/test-0040-process-all-refs.sh
@@ -3,12 +3,12 @@ test_expect_success "config receive.procReceiveRefs = refs ($PROTOCOL)" '
 	git -C "$upstream" config --add receive.procReceiveRefs refs
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
 test_expect_success "setup upstream branches ($PROTOCOL)" '
 	(
 		cd "$upstream" &&
-		git update-ref refs/heads/master $B &&
+		git update-ref refs/heads/main $B &&
 		git update-ref refs/heads/foo $A &&
 		git update-ref refs/heads/bar $A &&
 		git update-ref refs/heads/baz $A
@@ -20,13 +20,13 @@ test_expect_success "setup proc-receive hook ($PROTOCOL)" '
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
-		-r "ok refs/heads/master" \
+		-r "ok refs/heads/main" \
 		-r "option fall-through" \
 		-r "ok refs/heads/foo" \
 		-r "option fall-through" \
 		-r "ok refs/heads/bar" \
 		-r "option fall-through" \
-		-r "ok refs/for/master/topic" \
+		-r "ok refs/for/main/topic" \
 		-r "option refname refs/pull/123/head" \
 		-r "option old-oid $A" \
 		-r "option new-oid $B" \
@@ -38,15 +38,15 @@ test_expect_success "setup proc-receive hook ($PROTOCOL)" '
 	EOF
 '
 
-# Refs of upstream : master(B)             foo(A)  bar(A))  baz(A)
-# Refs of workbench: master(A)  tags/v123
-# git push -f      : master(A)             (NULL)  (B)              refs/for/master/topic(A)  refs/for/next/topic(A)
+# Refs of upstream : main(B)             foo(A)  bar(A))  baz(A)
+# Refs of workbench: main(A)  tags/v123
+# git push -f      : main(A)             (NULL)  (B)              refs/for/main/topic(A)  refs/for/next/topic(A)
 test_expect_success "proc-receive: process all refs ($PROTOCOL)" '
 	git -C workbench push -f origin \
-		HEAD:refs/heads/master \
+		HEAD:refs/heads/main \
 		:refs/heads/foo \
 		$B:refs/heads/bar \
-		HEAD:refs/for/master/topic \
+		HEAD:refs/for/main/topic \
 		HEAD:refs/for/next/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
@@ -54,22 +54,22 @@ test_expect_success "proc-receive: process all refs ($PROTOCOL)" '
 	remote: # pre-receive hook
 	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/bar
 	remote: pre-receive< <COMMIT-A> <ZERO-OID> refs/heads/foo
-	remote: pre-receive< <COMMIT-B> <COMMIT-A> refs/heads/master
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: pre-receive< <COMMIT-B> <COMMIT-A> refs/heads/main
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
 	remote: # proc-receive hook
 	remote: proc-receive< <COMMIT-A> <COMMIT-B> refs/heads/bar
 	remote: proc-receive< <COMMIT-A> <ZERO-OID> refs/heads/foo
-	remote: proc-receive< <COMMIT-B> <COMMIT-A> refs/heads/master
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive< <COMMIT-B> <COMMIT-A> refs/heads/main
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
 	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
-	remote: proc-receive> ok refs/heads/master
+	remote: proc-receive> ok refs/heads/main
 	remote: proc-receive> option fall-through
 	remote: proc-receive> ok refs/heads/foo
 	remote: proc-receive> option fall-through
 	remote: proc-receive> ok refs/heads/bar
 	remote: proc-receive> option fall-through
-	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> ok refs/for/main/topic
 	remote: proc-receive> option refname refs/pull/123/head
 	remote: proc-receive> option old-oid <COMMIT-A>
 	remote: proc-receive> option new-oid <COMMIT-B>
@@ -81,13 +81,13 @@ test_expect_success "proc-receive: process all refs ($PROTOCOL)" '
 	remote: # post-receive hook
 	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/bar
 	remote: post-receive< <COMMIT-A> <ZERO-OID> refs/heads/foo
-	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/heads/master
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/heads/main
 	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/pull/123/head
 	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/pull/124/head
 	To <URL/of/upstream.git>
 	 <OID-A>..<OID-B> <COMMIT-B> -> bar
 	 - [deleted] foo
-	 + <OID-B>...<OID-A> HEAD -> master (forced update)
+	 + <OID-B>...<OID-A> HEAD -> main (forced update)
 	 <OID-A>..<OID-B> HEAD -> refs/pull/123/head
 	 + <OID-B>...<OID-A> HEAD -> refs/pull/124/head (forced update)
 	EOF
@@ -97,13 +97,13 @@ test_expect_success "proc-receive: process all refs ($PROTOCOL)" '
 	cat >expect <<-EOF &&
 	<COMMIT-B> refs/heads/bar
 	<COMMIT-A> refs/heads/baz
-	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/main
 	EOF
 	test_cmp expect actual
 '
 
-# Refs of upstream : master(A)             bar(A)  baz(B)
-# Refs of workbench: master(A)  tags/v123
+# Refs of upstream : main(A)             bar(A)  baz(B)
+# Refs of workbench: main(A)  tags/v123
 test_expect_success "cleanup ($PROTOCOL)" '
 	(
 		cd "$upstream" &&
diff --git a/t/t5411/test-0041-process-all-refs--porcelain.sh b/t/t5411/test-0041-process-all-refs--porcelain.sh
index 0dd9824616..e21420b60d 100644
--- a/t/t5411/test-0041-process-all-refs--porcelain.sh
+++ b/t/t5411/test-0041-process-all-refs--porcelain.sh
@@ -3,12 +3,12 @@ test_expect_success "config receive.procReceiveRefs = refs ($PROTOCOL/porcelain)
 	git -C "$upstream" config --add receive.procReceiveRefs refs
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
 test_expect_success "setup upstream branches ($PROTOCOL/porcelain)" '
 	(
 		cd "$upstream" &&
-		git update-ref refs/heads/master $B &&
+		git update-ref refs/heads/main $B &&
 		git update-ref refs/heads/foo $A &&
 		git update-ref refs/heads/bar $A &&
 		git update-ref refs/heads/baz $A
@@ -20,13 +20,13 @@ test_expect_success "setup proc-receive hook ($PROTOCOL/porcelain)" '
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
-		-r "ok refs/heads/master" \
+		-r "ok refs/heads/main" \
 		-r "option fall-through" \
 		-r "ok refs/heads/foo" \
 		-r "option fall-through" \
 		-r "ok refs/heads/bar" \
 		-r "option fall-through" \
-		-r "ok refs/for/master/topic" \
+		-r "ok refs/for/main/topic" \
 		-r "option refname refs/pull/123/head" \
 		-r "option old-oid $A" \
 		-r "option new-oid $B" \
@@ -38,15 +38,15 @@ test_expect_success "setup proc-receive hook ($PROTOCOL/porcelain)" '
 	EOF
 '
 
-# Refs of upstream : master(B)             foo(A)  bar(A))  baz(A)
-# Refs of workbench: master(A)  tags/v123
-# git push -f      : master(A)             (NULL)  (B)              refs/for/master/topic(A)  refs/for/next/topic(A)
+# Refs of upstream : main(B)             foo(A)  bar(A))  baz(A)
+# Refs of workbench: main(A)  tags/v123
+# git push -f      : main(A)             (NULL)  (B)              refs/for/main/topic(A)  refs/for/next/topic(A)
 test_expect_success "proc-receive: process all refs ($PROTOCOL/porcelain)" '
 	git -C workbench push --porcelain -f origin \
-		HEAD:refs/heads/master \
+		HEAD:refs/heads/main \
 		:refs/heads/foo \
 		$B:refs/heads/bar \
-		HEAD:refs/for/master/topic \
+		HEAD:refs/for/main/topic \
 		HEAD:refs/for/next/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
@@ -54,22 +54,22 @@ test_expect_success "proc-receive: process all refs ($PROTOCOL/porcelain)" '
 	remote: # pre-receive hook
 	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/bar
 	remote: pre-receive< <COMMIT-A> <ZERO-OID> refs/heads/foo
-	remote: pre-receive< <COMMIT-B> <COMMIT-A> refs/heads/master
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: pre-receive< <COMMIT-B> <COMMIT-A> refs/heads/main
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
 	remote: # proc-receive hook
 	remote: proc-receive< <COMMIT-A> <COMMIT-B> refs/heads/bar
 	remote: proc-receive< <COMMIT-A> <ZERO-OID> refs/heads/foo
-	remote: proc-receive< <COMMIT-B> <COMMIT-A> refs/heads/master
-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: proc-receive< <COMMIT-B> <COMMIT-A> refs/heads/main
+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
 	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
-	remote: proc-receive> ok refs/heads/master
+	remote: proc-receive> ok refs/heads/main
 	remote: proc-receive> option fall-through
 	remote: proc-receive> ok refs/heads/foo
 	remote: proc-receive> option fall-through
 	remote: proc-receive> ok refs/heads/bar
 	remote: proc-receive> option fall-through
-	remote: proc-receive> ok refs/for/master/topic
+	remote: proc-receive> ok refs/for/main/topic
 	remote: proc-receive> option refname refs/pull/123/head
 	remote: proc-receive> option old-oid <COMMIT-A>
 	remote: proc-receive> option new-oid <COMMIT-B>
@@ -81,13 +81,13 @@ test_expect_success "proc-receive: process all refs ($PROTOCOL/porcelain)" '
 	remote: # post-receive hook
 	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/bar
 	remote: post-receive< <COMMIT-A> <ZERO-OID> refs/heads/foo
-	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/heads/master
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/heads/main
 	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/pull/123/head
 	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/pull/124/head
 	To <URL/of/upstream.git>
 	     <COMMIT-B>:refs/heads/bar    <OID-A>..<OID-B>
 	-    :refs/heads/foo    [deleted]
-	+    HEAD:refs/heads/master    <OID-B>...<OID-A> (forced update)
+	+    HEAD:refs/heads/main    <OID-B>...<OID-A> (forced update)
 	     HEAD:refs/pull/123/head    <OID-A>..<OID-B>
 	+    HEAD:refs/pull/124/head    <OID-B>...<OID-A> (forced update)
 	Done
@@ -98,13 +98,13 @@ test_expect_success "proc-receive: process all refs ($PROTOCOL/porcelain)" '
 	cat >expect <<-EOF &&
 	<COMMIT-B> refs/heads/bar
 	<COMMIT-A> refs/heads/baz
-	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/main
 	EOF
 	test_cmp expect actual
 '
 
-# Refs of upstream : master(A)             bar(A)  baz(B)
-# Refs of workbench: master(A)  tags/v123
+# Refs of upstream : main(A)             bar(A)  baz(B)
+# Refs of workbench: main(A)  tags/v123
 test_expect_success "cleanup ($PROTOCOL/porcelain)" '
 	(
 		cd "$upstream" &&
diff --git a/t/t5411/test-0050-proc-receive-refs-with-modifiers.sh b/t/t5411/test-0050-proc-receive-refs-with-modifiers.sh
index c22849cbe2..2e29518ec5 100644
--- a/t/t5411/test-0050-proc-receive-refs-with-modifiers.sh
+++ b/t/t5411/test-0050-proc-receive-refs-with-modifiers.sh
@@ -2,7 +2,7 @@ test_expect_success "config receive.procReceiveRefs with modifiers ($PROTOCOL)"
 	(
 		cd "$upstream" &&
 		git config --unset-all receive.procReceiveRefs &&
-		git config --add receive.procReceiveRefs m:refs/heads/master &&
+		git config --add receive.procReceiveRefs m:refs/heads/main &&
 		git config --add receive.procReceiveRefs ad:refs/heads &&
 		git config --add receive.procReceiveRefs "a!:refs/heads"
 	)
@@ -12,7 +12,7 @@ test_expect_success "setup proc-receive hook ($PROTOCOL)" '
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
-		-r "ok refs/heads/master" \
+		-r "ok refs/heads/main" \
 		-r "option refname refs/pull/123/head" \
 		-r "option old-oid $A" \
 		-r "option new-oid $B" \
@@ -21,22 +21,22 @@ test_expect_success "setup proc-receive hook ($PROTOCOL)" '
 	EOF
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
-# git push         : master(B)  tags/v123
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         : main(B)  tags/v123
 test_expect_success "proc-receive: update branch and new tag ($PROTOCOL)" '
 	git -C workbench push origin \
-		$B:refs/heads/master \
+		$B:refs/heads/main \
 		v123 >out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
-	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
+	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
 	remote: pre-receive< <ZERO-OID> <TAG-v123> refs/tags/v123
 	remote: # proc-receive hook
-	remote: proc-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
+	remote: proc-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
 	remote: proc-receive< <ZERO-OID> <TAG-v123> refs/tags/v123
-	remote: proc-receive> ok refs/heads/master
+	remote: proc-receive> ok refs/heads/main
 	remote: proc-receive> option refname refs/pull/123/head
 	remote: proc-receive> option old-oid <COMMIT-A>
 	remote: proc-receive> option new-oid <COMMIT-B>
@@ -53,20 +53,20 @@ test_expect_success "proc-receive: update branch and new tag ($PROTOCOL)" '
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/main
 	EOF
 	test_cmp expect actual
 '
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
 test_expect_success "setup upstream: create tags/v123 ($PROTOCOL)" '
 	git -C "$upstream" update-ref refs/heads/topic $A &&
 	git -C "$upstream" update-ref refs/tags/v123 $TAG &&
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/main
 	<COMMIT-A> refs/heads/topic
 	<TAG-v123> refs/tags/v123
 	EOF
@@ -77,7 +77,7 @@ test_expect_success "setup proc-receive hook ($PROTOCOL)" '
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
-		-r "ok refs/heads/master" \
+		-r "ok refs/heads/main" \
 		-r "option refname refs/pull/123/head" \
 		-r "option old-oid $A" \
 		-r "option new-oid $ZERO_OID" \
@@ -87,26 +87,26 @@ test_expect_success "setup proc-receive hook ($PROTOCOL)" '
 	EOF
 '
 
-# Refs of upstream : master(A)  topic(A)  tags/v123
-# Refs of workbench: master(A)            tags/v123
+# Refs of upstream : main(A)  topic(A)  tags/v123
+# Refs of workbench: main(A)            tags/v123
 # git push         : NULL       topic(B)  NULL       next(A)
 test_expect_success "proc-receive: create/delete branch, and delete tag ($PROTOCOL)" '
 	git -C workbench push origin \
-		:refs/heads/master \
+		:refs/heads/main \
 		$B:refs/heads/topic \
 		$A:refs/heads/next \
 		:refs/tags/v123 >out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
 	remote: # pre-receive hook
-	remote: pre-receive< <COMMIT-A> <ZERO-OID> refs/heads/master
+	remote: pre-receive< <COMMIT-A> <ZERO-OID> refs/heads/main
 	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/topic
 	remote: pre-receive< <TAG-v123> <ZERO-OID> refs/tags/v123
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
 	remote: # proc-receive hook
-	remote: proc-receive< <COMMIT-A> <ZERO-OID> refs/heads/master
+	remote: proc-receive< <COMMIT-A> <ZERO-OID> refs/heads/main
 	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
-	remote: proc-receive> ok refs/heads/master
+	remote: proc-receive> ok refs/heads/main
 	remote: proc-receive> option refname refs/pull/123/head
 	remote: proc-receive> option old-oid <COMMIT-A>
 	remote: proc-receive> option new-oid <ZERO-OID>
@@ -128,7 +128,7 @@ test_expect_success "proc-receive: create/delete branch, and delete tag ($PROTOC
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/main
 	<COMMIT-B> refs/heads/topic
 	EOF
 	test_cmp expect actual
-- 
gitgitgadget

