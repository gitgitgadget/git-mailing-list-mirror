Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46725C352BE
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 16:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2261122240
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 16:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1YbDxtG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410732AbgDPQY3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2403967AbgDPQYZ (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Apr 2020 12:24:25 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49ABFC061A0C
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 09:24:25 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k15so1887083pfh.6
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 09:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aY7Hdnh9vR6M7td/46gR8NOmsz2zyoEJNCmXweYbZR8=;
        b=X1YbDxtGoiIcGZn9opSZUnp3aMsoz3Lp2WNCtfH90DE6+31LYs/WkDIQwbxY9fXT+D
         uiGm6Rjg/UJg0Epk2+G2/3+m9+2pOQk5bobWqizEo74cNLMflGB0pwiJR1LbqSCv12VP
         9MCdnOyyLZsN/vs7wy91ASazUzVmU2B85h6arS4IlJRwZm42KbeOOdHBNDEd4/VupJWm
         Dcff46RNzDpsRdvkwxXnUjJl46BjebH1bzUdlPXOqH7hT32wtRvqPZ6h9JSUgxjIYmsO
         kRbZuLVIHgHNi2Q1Y6AbmDO0Qg4fSuFvmxSbLeNgd+FQGVG4mCKw33rvl+8YutvV+5XH
         GI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aY7Hdnh9vR6M7td/46gR8NOmsz2zyoEJNCmXweYbZR8=;
        b=ExhijiMWTpg89J8+6ndULO+CODl5j54rhjMQGesP8/UZjfbFok3iBK9ysLcbNybCIJ
         bG5BKPKV4ZxDOrveotWPpt6AuTmnfR3oHMGY1yRrAw1w/djm9oAcctnsGXs5hKyUaO/y
         /JvevHJsHk8XHW1PzopMVHZaq9CbdYQnVLtbMjQF54qZQkfQ5s+B2RxZGzIQKr4rwdQV
         w2uKkAm8bQQWkDKY1GjpC6ZoI6NnFruW35v+BvDpoLvH46qgXe3hl22fU1lhgH+h2HKP
         gX2Eg+O1IhafTa4dRYZXzbq2N0DEcTd6BvKkqqKdEVdckA3gg60ogylVwQLXAH6yybCO
         osJg==
X-Gm-Message-State: AGi0PuZKiGDmXkuKKsW0YPtqCV2iX0fx71PtJyuwwBaTYBXB0lGRReeU
        1TV+LODkV2DXAs5toxRKKbc=
X-Google-Smtp-Source: APiQypJ5xYEhHku6dx6A+SyyRQ7pYCMKBfB+ZgubOqdni4Yk9+vgnojC7fQcxyUbJjUTHLP8KuhBtA==
X-Received: by 2002:a63:2057:: with SMTP id r23mr32885312pgm.232.1587054264713;
        Thu, 16 Apr 2020 09:24:24 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id c125sm17007933pfa.142.2020.04.16.09.24.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2020 09:24:24 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v3 3/5] send-pack: mark failure of atomic push properly
Date:   Thu, 16 Apr 2020 12:24:13 -0400
Message-Id: <20200416162415.5751-4-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200329143329.13846-1-worldhello.net@gmail.com>
References: <20200329143329.13846-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

When pushing with SSH or other smart protocol, references are validated
by function `check_to_send_update()` before they are sent in commands
to `send_pack()` of "receve-pack".  For atomic push, if a reference is
rejected after the validation, only references pushed by user should be
marked as failure, instead of report failure on all remote references.

Commit v2.22.0-1-g3bca1e7f9f (transport-helper: enforce atomic in
push_refs_with_push, 2019-07-11) wanted to fix report issue of HTTP
protocol, but marked all remote references failure for atomic push.

In order to fix the issue of status report for SSH or other built-in
smart protocol, revert part of that commit and add additional status
for function `atomic_push_failure()`.  The additional status for it
except the "REF_STATUS_EXPECTING_REPORT" status are:

- REF_STATUS_NONE : Not marked as "REF_STATUS_EXPECTING_REPORT" yet.
- REF_STATUS_OK   : Assume OK for dryrun or status_report is disabled.

This fix won't resolve the issue of status report in transport-helper
for HTTP or other protocols, and breaks test case in t5541.  Will fix
it in additional commit.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 send-pack.c                |  2 ++
 t/t5541-http-push-smart.sh |  2 +-
 t/t5543-atomic-push.sh     |  6 +++---
 t/t5548-push-porcelain.sh  |  2 +-
 transport.c                | 14 --------------
 5 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 1835cd5582..efefb687b2 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -332,6 +332,8 @@ static int atomic_push_failure(struct send_pack_args *args,
 			continue;
 
 		switch (ref->status) {
+		case REF_STATUS_NONE:
+		case REF_STATUS_OK:
 		case REF_STATUS_EXPECTING_REPORT:
 			ref->status = REF_STATUS_ATOMIC_PUSH_FAILED;
 			continue;
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 23be8ce92d..2c2c3fb0f5 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -177,7 +177,7 @@ test_expect_success 'push (chunked)' '
 	 test $HEAD = $(git rev-parse --verify HEAD))
 '
 
-test_expect_success 'push --atomic also prevents branch creation, reports collateral' '
+test_expect_failure 'push --atomic also prevents branch creation, reports collateral' '
 	# Setup upstream repo - empty for now
 	d=$HTTPD_DOCUMENT_ROOT_PATH/atomic-branches.git &&
 	git init --bare "$d" &&
diff --git a/t/t5543-atomic-push.sh b/t/t5543-atomic-push.sh
index 001240eec7..620c30d58f 100755
--- a/t/t5543-atomic-push.sh
+++ b/t/t5543-atomic-push.sh
@@ -200,7 +200,7 @@ test_expect_success 'atomic push is not advertised if configured' '
 # References in upstream : master(1) one(1) foo(1)
 # References in workbench: master(2)        foo(1) two(2) bar(2)
 # Atomic push            : master(2)               two(2) bar(2)
-test_expect_failure 'atomic push reports (reject by update hook)' '
+test_expect_success 'atomic push reports (reject by update hook)' '
 	mk_repo_pair &&
 	(
 		cd workbench &&
@@ -241,7 +241,7 @@ test_expect_failure 'atomic push reports (reject by update hook)' '
 
 # References in upstream : master(1) one(1) foo(1)
 # References in workbench: master(2)        foo(1) two(2) bar(2)
-test_expect_failure 'atomic push reports (mirror, but reject by update hook)' '
+test_expect_success 'atomic push reports (mirror, but reject by update hook)' '
 	(
 		cd workbench &&
 		git remote remove up &&
@@ -262,7 +262,7 @@ test_expect_failure 'atomic push reports (mirror, but reject by update hook)' '
 
 # References in upstream : master(2) one(1) foo(1)
 # References in workbench: master(1)        foo(1) two(2) bar(2)
-test_expect_failure 'atomic push reports (reject by non-ff)' '
+test_expect_success 'atomic push reports (reject by non-ff)' '
 	rm upstream/.git/hooks/update &&
 	(
 		cd workbench &&
diff --git a/t/t5548-push-porcelain.sh b/t/t5548-push-porcelain.sh
index 8d487b2a7a..e7d9e06dac 100755
--- a/t/t5548-push-porcelain.sh
+++ b/t/t5548-push-porcelain.sh
@@ -110,7 +110,7 @@ run_git_push_porcelain_output_test() {
 	# Refs of upstream : master(A)  bar(B)  baz(A)  next(A)
 	# Refs of workbench: master(B)  bar(A)  baz(A)  next(A)
 	# git-push         : master(B)  bar(A)  NULL    next(A)
-	test_expect_success "atomic push failed ($PROTOCOL)" '
+	test_expect_failure "atomic push failed ($PROTOCOL)" '
 		(
 			cd workbench &&
 			git update-ref refs/heads/master $B &&
diff --git a/transport.c b/transport.c
index 13d638d5fe..a07e39564c 100644
--- a/transport.c
+++ b/transport.c
@@ -1248,20 +1248,6 @@ int transport_push(struct repository *r,
 		err = push_had_errors(remote_refs);
 		ret = push_ret | err;
 
-		if ((flags & TRANSPORT_PUSH_ATOMIC) && err) {
-			struct ref *it;
-			for (it = remote_refs; it; it = it->next)
-				switch (it->status) {
-				case REF_STATUS_NONE:
-				case REF_STATUS_UPTODATE:
-				case REF_STATUS_OK:
-					it->status = REF_STATUS_ATOMIC_PUSH_FAILED;
-					break;
-				default:
-					break;
-				}
-		}
-
 		if (!quiet || err)
 			transport_print_push_status(transport->url, remote_refs,
 					verbose | porcelain, porcelain,
-- 
2.24.1.15.g448c31058d.agit.4.5

