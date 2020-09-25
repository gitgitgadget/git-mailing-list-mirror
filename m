Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778EAC4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 17:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2816E20936
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 17:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNr3Frso"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbgIYRDm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 13:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgIYRDm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 13:03:42 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DDEC0613CE
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 10:03:41 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id m34so3101406pgl.9
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 10:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=74tX/V/gfV+ZWhejhVVX4fvY5oR8pC9ModxDyQKKGv0=;
        b=aNr3Frso0vbwMZOtsn/T903f2khDZLfZlb1j++8JJLu8DVkzfqikiATwjIrwTXr8QG
         NffKv1UD7RTzaVKQmVdarbwSf4obYPkG+Im0LOSBN0xvldYrnw71S32u90QXfZlgC1CC
         Dx+n+fvx4toX/YAUuj22F3zJUj4ZDfTifMf2tJtV2TDPbNPcBIvfd768Vpe295C5CWlQ
         5ULFVi1Bg9tR6whsd5Bf6l6Ref8SIQDZI8oxaTqhfP/nkqs2YhrAaBVtaVzuT6v+rcl6
         n4pm8dj8b9rbrw1+fRDb6Qznj6Ww6GCbeeFrbQfaeId4pEXaMEK70kq3QzOEtKe6C969
         B6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=74tX/V/gfV+ZWhejhVVX4fvY5oR8pC9ModxDyQKKGv0=;
        b=GHdZ/3S9e71DKIT/QFm3yoGjk7+/qSMbpK6DTr9OWofYq2Zhb+lAbNDI/DU14rwX3V
         pGEQONEQIKiqCQTpNAsC/1HLeAhEi6PiiItCemIEACf2wRcQ+D74zHUUj3V7l3zaN+DC
         CStK9AuAFo0tdq5RKanri97JHoU7ZJ73LmaBSn/+4BynzzOav4jb8OwxbUrlxuHwmeuD
         LbqnzR/DgNa1DKBztPxspyJ1vYGW59uDLt3hYHgE7FotSVCU7jHCMhr7+/HqkjTO+w4F
         f+decV6Xd01JIT20T7kUR1WVRcHgR2GMjDAn4AF7WrOfH7Hods5xkjhtmuvs3s7z8MI2
         IhWg==
X-Gm-Message-State: AOAM530/W+TdHOlL6PdtsAvk2Qvbh8LWHtwEYCGBwk7Zc0FGMcnQhRYD
        NlEogNWLXybrKkG0AF1utQ1qla5UbsGnug==
X-Google-Smtp-Source: ABdhPJwV+uVpgH0xc9KV3hy2wj5FBEGnwz/go9zxAGppJyG7A4BedAZsVXQ2T36ZejmIhvshVNCRFA==
X-Received: by 2002:a62:7c43:0:b029:139:858b:8033 with SMTP id x64-20020a627c430000b0290139858b8033mr292413pfc.3.1601053420925;
        Fri, 25 Sep 2020 10:03:40 -0700 (PDT)
Received: from localhost.localdomain ([47.9.163.48])
        by smtp.gmail.com with ESMTPSA id k27sm2822467pgm.29.2020.09.25.10.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 10:03:40 -0700 (PDT)
From:   shubham verma <shubhunic@gmail.com>
To:     git@vger.kernel.org
Cc:     Shubham Verma <shubhunic@gmail.com>
Subject: [PATCH 11/11] t7001: move cleanup code from outside the tests into them
Date:   Fri, 25 Sep 2020 22:32:56 +0530
Message-Id: <20200925170256.11490-12-shubhunic@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200925170256.11490-1-shubhunic@gmail.com>
References: <20200925170256.11490-1-shubhunic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Shubham Verma <shubhunic@gmail.com>

Let's use test_when_finished() to include cleanup code inside the tests,
as it's cleaner and safer to not have any code outside the tests.

Signed-off-by: shubham verma <shubhunic@gmail.com>
---
 t/t7001-mv.sh | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 7bb4a7b759..b4d04ceaf8 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -32,6 +32,7 @@ test_expect_success 'commiting the change' '
 '
 
 test_expect_success 'checking the commit' '
+	test_when_finished "rmdir path1" &&
 	git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
 	grep "^R100..*path1/COPYING..*path0/COPYING" actual
 '
@@ -43,6 +44,7 @@ test_expect_success 'mv --dry-run does not move file' '
 '
 
 test_expect_success 'checking -k on non-existing file' '
+	test_when_finished "rm -f idontexist path0/idontexist" &&
 	git mv -k idontexist path0
 '
 
@@ -55,6 +57,7 @@ test_expect_success 'checking -k on untracked file' '
 
 test_expect_success 'checking -k on multiple untracked files' '
 	: > untracked2 &&
+	test_when_finished "rm -f untracked2 path0/untracked2" &&
 	git mv -k untracked1 untracked2 path0 &&
 	test -f untracked1 &&
 	test -f untracked2 &&
@@ -64,18 +67,14 @@ test_expect_success 'checking -k on multiple untracked files' '
 
 test_expect_success 'checking -f on untracked file with existing target' '
 	: > path0/untracked1 &&
+	test_when_finished "rm -f untracked1 path0/untracked1" &&
+	test_when_finished "rm -f .git/index.lock" &&
 	test_must_fail git mv -f untracked1 path0 &&
 	test ! -f .git/index.lock &&
 	test -f untracked1 &&
 	test -f path0/untracked1
 '
 
-# clean up the mess in case bad things happen
-rm -f idontexist untracked1 untracked2 \
-     path0/idontexist path0/untracked1 path0/untracked2 \
-     .git/index.lock
-rmdir path1
-
 test_expect_success 'moving to absent target with trailing slash' '
 	test_must_fail git mv path0/COPYING no-such-dir/ &&
 	test_must_fail git mv path0/COPYING no-such-dir// &&
@@ -149,10 +148,12 @@ test_expect_success 'do not move directory over existing directory' '
 '
 
 test_expect_success 'move into "."' '
+	test_when_finished "rm -fr path?" &&
 	git mv path1/path2/ .
 '
 
 test_expect_success "Michael Cassar's test case" '
+	test_when_finished "rm -fr papers partA" &&
 	rm -fr .git papers partA &&
 	git init &&
 	mkdir -p papers/unsorted papers/all-papers partA &&
@@ -168,8 +169,6 @@ test_expect_success "Michael Cassar's test case" '
 	git ls-tree -r $T | verbose grep partA/outline.txt
 '
 
-rm -fr papers partA path?
-
 test_expect_success "Sergey Vlasov's test case" '
 	rm -fr .git &&
 	git init &&
@@ -230,6 +229,7 @@ test_expect_success 'git mv to move multiple sources into a directory' '
 '
 
 test_expect_success 'git mv should not change sha1 of moved cache entry' '
+	test_when_finished "rm -f dirty dirty2" &&
 	rm -fr .git &&
 	git init &&
 	echo 1 >dirty &&
@@ -242,8 +242,6 @@ test_expect_success 'git mv should not change sha1 of moved cache entry' '
 	test "$entry" = "$(git ls-files --stage dirty | cut -f 1)"
 '
 
-rm -f dirty dirty2
-
 # NB: This test is about the error message
 # as well as the failure.
 test_expect_success 'git mv error on conflicted file' '
@@ -262,6 +260,7 @@ test_expect_success 'git mv error on conflicted file' '
 '
 
 test_expect_success 'git mv should overwrite symlink to a file' '
+	test_when_finished "rm -f moved symlink" &&
 	rm -fr .git &&
 	git init &&
 	echo 1 >moved &&
@@ -276,9 +275,8 @@ test_expect_success 'git mv should overwrite symlink to a file' '
 	git diff-files --quiet
 '
 
-rm -f moved symlink
-
 test_expect_success 'git mv should overwrite file with a symlink' '
+	test_when_finished "rm -f symlink" &&
 	rm -fr .git &&
 	git init &&
 	echo 1 >moved &&
@@ -292,11 +290,10 @@ test_expect_success 'git mv should overwrite file with a symlink' '
 '
 
 test_expect_success SYMLINKS 'check moved symlink' '
+	test_when_finished "rm -f moved" &&
 	test -h moved
 '
 
-rm -f moved symlink
-
 test_expect_success 'setup submodule' '
 	git commit -m initial &&
 	git reset --hard &&
-- 
2.25.1

