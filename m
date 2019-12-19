Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EA6C2D0D1
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 22:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B930524672
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 22:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTKDkibl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfLSWV4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 17:21:56 -0500
Received: from mail-pg1-f175.google.com ([209.85.215.175]:39800 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbfLSWVs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 17:21:48 -0500
Received: by mail-pg1-f175.google.com with SMTP id b137so3874032pga.6
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 14:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SeZOY/KKpQY2td5afYkTiUUHcs8wX+Qr20utB7VGqmc=;
        b=FTKDkibl9U9Iz1XIssR74k7f7xzJKpgpo1dfbHItghhZc1hBiO174DuTQdGbw5GA9l
         9bkjnhRCSvknecxiRHoCnYgKZxKE+ahW95z4aFkMRvqYS/cjOE0c9QOIXUTWpaemEJjx
         RptcS0VBfSOmlb3f3jQobR66ZR4/nC4cKLk1PVsYLkZSVp4mbcwjg/aEXtfaaCb/R9FG
         Cwlqki8bEjLUF1R5PgoQ+eX/gZLQyzYwYvfTxi6YccmLEyYI8HLxmxBxBhGqtPZbZ+hI
         jx6XnSmN6/iDy/VgAv7l9EJ0krLAANcwv9Ov4t87YZCD24rmRtl0MgF1j8zTtI/7hKm0
         XMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SeZOY/KKpQY2td5afYkTiUUHcs8wX+Qr20utB7VGqmc=;
        b=uVe1UMD0h1UaASdAgqS0lhHuVCNJPbJPIV4M5IHVj3e7DBJcCgQEM+ePDo6n9h2bCL
         LfPclS7kUxklf/pLUOS5i6giYvkL0EY6D9RALwkB0kSU6YIdoZwI1ZbGRFZ7F8E526Jq
         ldJDN1d+gqNIL6fyBKkQn2qabftDwC+A6cevYR7O+iPKtKHjR+qi1mp3FrBo11A46eCV
         HnF6wOsS4Uv3xBWjQckxW4lHkacsmvan7CKDGbWC2SC7vXW3O/sPk5xUURrPp/41BVYG
         zi1Q2b//+VC39MQHMdSvEszvqclGZRoDyNcu+HOmMER3/4EeLzwnr8YCvxKZnYeuON/d
         rpZQ==
X-Gm-Message-State: APjAAAWXFwe9A1xiV2W9KEiHf+z6kKZxAApxIJlHSFn3hEDuNI4i0bFB
        FMTcVCGg0pw7iKZ4WCqxLW4/HJyi
X-Google-Smtp-Source: APXvYqwcGD4r41OBdFmb4TDWCoHaMWGbWGO0bZgnMOQJfgPZPNy8mET2yIrNs3xcFVJY29uE2o9Chw==
X-Received: by 2002:a63:d406:: with SMTP id a6mr11613993pgh.264.1576794107302;
        Thu, 19 Dec 2019 14:21:47 -0800 (PST)
Received: from dentonliu-ltm.internal.salesforce.com ([216.52.21.197])
        by smtp.gmail.com with ESMTPSA id o19sm11428528pjr.2.2019.12.19.14.21.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 14:21:46 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 14/16] t1507: stop losing return codes of git commands
Date:   Thu, 19 Dec 2019 14:22:49 -0800
Message-Id: <9e20865f94bd187dd1e50c1ddd57c435882cd6a0.1576794144.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.703.g2f499f1283
In-Reply-To: <cover.1576794144.git.liu.denton@gmail.com>
References: <cover.1576583819.git.liu.denton@gmail.com> <cover.1576794144.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The return code of git commands are lost when a command is in a
non-assignment command substitution in favour of the surrounding
command's. Rewrite instances of this so that git commands run
on their own.

In commit_subject(), use a `tformat` instead of `format` since,
previously, we were testing the output of a command substitution which
didn't care if there was a trailing newline since it was automatically
stripped. Since we use test_cmp() now, the trailing newline matters so
use `tformat` to always output it.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t1507-rev-parse-upstream.sh | 45 +++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
index 8b4cf8a6e3..d81f289ace 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -35,7 +35,7 @@ full_name () {
 
 commit_subject () {
 	(cd clone &&
-	 git show -s --pretty=format:%s "$@")
+	 git show -s --pretty=tformat:%s "$@")
 }
 
 error_message () {
@@ -44,18 +44,27 @@ error_message () {
 }
 
 test_expect_success '@{upstream} resolves to correct full name' '
-	test refs/remotes/origin/master = "$(full_name @{upstream})" &&
-	test refs/remotes/origin/master = "$(full_name @{UPSTREAM})" &&
-	test refs/remotes/origin/master = "$(full_name @{UpSTReam})"
+	echo refs/remotes/origin/master >expect &&
+	full_name @{upstream} >actual &&
+	test_cmp expect actual &&
+	full_name @{UPSTREAM} >actual &&
+	test_cmp expect actual &&
+	full_name @{UpSTReam} >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success '@{u} resolves to correct full name' '
-	test refs/remotes/origin/master = "$(full_name @{u})" &&
-	test refs/remotes/origin/master = "$(full_name @{U})"
+	echo refs/remotes/origin/master >expect &&
+	full_name @{u} >actual &&
+	test_cmp expect actual &&
+	full_name @{U} >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'my-side@{upstream} resolves to correct full name' '
-	test refs/remotes/origin/side = "$(full_name my-side@{u})"
+	echo refs/remotes/origin/side >expect &&
+	full_name my-side@{u} >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'upstream of branch with @ in middle' '
@@ -86,8 +95,11 @@ test_expect_success 'my-side@{u} resolves to correct commit' '
 	git checkout side &&
 	test_commit 5 &&
 	(cd clone && git fetch) &&
-	test 2 = "$(commit_subject my-side)" &&
-	test 5 = "$(commit_subject my-side@{u})"
+	echo 2 >expect &&
+	commit_subject my-side >actual &&
+	test_cmp expect actual &&
+	echo 5 >expect &&
+	commit_subject my-side@{u} >actual
 '
 
 test_expect_success 'not-tracking@{u} fails' '
@@ -99,8 +111,11 @@ test_expect_success 'not-tracking@{u} fails' '
 test_expect_success '<branch>@{u}@{1} resolves correctly' '
 	test_commit 6 &&
 	(cd clone && git fetch) &&
-	test 5 = $(commit_subject my-side@{u}@{1}) &&
-	test 5 = $(commit_subject my-side@{U}@{1})
+	echo 5 >expect &&
+	commit_subject my-side@{u}@{1} >actual &&
+	test_cmp expect actual &&
+	commit_subject my-side@{U}@{1} >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success '@{u} without specifying branch fails on a detached HEAD' '
@@ -149,7 +164,9 @@ test_expect_success 'checkout other@{u}' '
 '
 
 test_expect_success 'branch@{u} works when tracking a local branch' '
-	test refs/heads/master = "$(full_name local-master@{u})"
+	echo refs/heads/master >expect &&
+	full_name local-master@{u} >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'branch@{u} error message when no upstream' '
@@ -203,7 +220,9 @@ test_expect_success 'pull works when tracking a local branch' '
 
 # makes sense if the previous one succeeded
 test_expect_success '@{u} works when tracking a local branch' '
-	test refs/heads/master = "$(full_name @{u})"
+	echo refs/heads/master >expect &&
+	full_name @{u} >actual &&
+	test_cmp expect actual
 '
 
 commit=$(git rev-parse HEAD)
-- 
2.24.1.703.g2f499f1283

