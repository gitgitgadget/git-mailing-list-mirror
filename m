Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484AEC2D0C8
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E8CA2082E
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/RuCGn9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfLTSOt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:14:49 -0500
Received: from mail-pl1-f181.google.com ([209.85.214.181]:46294 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727533AbfLTSOq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 13:14:46 -0500
Received: by mail-pl1-f181.google.com with SMTP id y8so4415120pll.13
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 10:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SeZOY/KKpQY2td5afYkTiUUHcs8wX+Qr20utB7VGqmc=;
        b=Q/RuCGn9AdkLJ9igOBaju/3tPoqphtqJZ2sx5z1hLaLSI0PFobPlltM9L5/nhi9/3b
         LitIzhOunRRMjCY+gtGwvRVTFzQYPQMQqi6wMhpwg/L6cwDcvuMRLpaOcovU8B6q+MZg
         d1OgwH4nQ9chdlYZaOVIxq2Ay4epzXofX0Ip9dnX1oeQktQ6E7Bq8nTuGScCz6S6zpyo
         DG5MjGZk4H1oYWqRq7heZBWgKhLWV/WKNrhFOWCQ/YDnioToBeCJCqetoPpTc8JNT/iL
         WBckzOwh6y1/Xs1Ij/03Dm0Iw9zAW0yzlsq+289m9SVClLyFB5qIlp7qLwbO095zn9WY
         SH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SeZOY/KKpQY2td5afYkTiUUHcs8wX+Qr20utB7VGqmc=;
        b=MgNraSjsnCH4pr0fz7RyVV+gd/M0gxNY1TqTCF9jkPBJ9GGbCd8Yiuw4AyzqyRtaX7
         /aiQnfC/lwPl4hTH4MP4HDWkhTaKVIy7CYds9xk10PAO+UrdKuGkjvYlWM0Vbrg2e0ug
         xZv/XE3BU83gJSmnzsR17cqVtq5S0s2hI7WkozvvJspBtwmTje9szAkH//vUETYwXrtq
         OpgB2CPNC11cJmFKWZvyc0Q4RzIs3928wX3N8gRM0P9xUi8JDTTTpWsdn45+WoRx1ACy
         FvZsdv/7ORdKoFqfN8fuGYfGYUUsTrYcfik6fzkBycbjkc9ntWLv2rAtgOGhMgLuqWpC
         Fg4w==
X-Gm-Message-State: APjAAAXcbTL2+jQyYc3xxk96Xmh6hs9Fd0RQBuRYCIp6KVhrqBiGg/qx
        TflHSqRst9YHMRXo3aBfMjQuHNWU
X-Google-Smtp-Source: APXvYqxuvr8eFNjAYhey+2oOwDDMqVKAzxPOX/j67I7xRi+8bCMPsyaPMuwFSyqWD0udCvrCMN2koQ==
X-Received: by 2002:a17:90b:1243:: with SMTP id gx3mr10019311pjb.117.1576865685422;
        Fri, 20 Dec 2019 10:14:45 -0800 (PST)
Received: from dentonliu-ltm.internal.salesforce.com.com ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id c78sm14063082pfb.122.2019.12.20.10.14.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 10:14:44 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 13/15] t1507: stop losing return codes of git commands
Date:   Fri, 20 Dec 2019 10:16:00 -0800
Message-Id: <63ca18207d58a846f47887926582af9b3c55284e.1576865664.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.703.g2f499f1283
In-Reply-To: <cover.1576865663.git.liu.denton@gmail.com>
References: <cover.1576794144.git.liu.denton@gmail.com> <cover.1576865663.git.liu.denton@gmail.com>
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

