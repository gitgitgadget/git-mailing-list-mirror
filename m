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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0E1C2D0D2
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160812082E
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uj5ILEyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfLTSOx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:14:53 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36178 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbfLTSOs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 13:14:48 -0500
Received: by mail-pf1-f195.google.com with SMTP id x184so5645688pfb.3
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 10:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vKYLPG02vVVLMxYbouq+GE4jjP3H+Ekb7R2xtayR5fQ=;
        b=Uj5ILEygTWfTBa7x2RESnTmsLfelSIMZcRNsXvweF87WhE+mQHhALJRF698K9bm79i
         ZYl6HS2tA8vq2h3Q/ON7d5IXzy/Lc4QXZfEurbrWUhVsBPkONIelMbuWX6lFbGjDJDhy
         bdbl5OyHXKApJFtdIq775slV+AGD27Z+Gsx1SGxDUKHtJet6lp1YMtAvkSa4iGozp7be
         8GR8hWW4vMPUo06Ja3lBTncIwf9CRW+xgNlUMdL3a8udzB5vAEWS8y2nalotk6Lyc9eX
         I87M/eQcevEzS4KeRkg4CNO+/0njScnEuWAd58bVnacr5IQu3UnspxYkTjOynu6jcRF9
         M2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vKYLPG02vVVLMxYbouq+GE4jjP3H+Ekb7R2xtayR5fQ=;
        b=iqv+cM1dnDEeR238fiPH1NUTNITJpWVZ31HwW7JCD9NDMOQ3q5ktOCnn+kmXGXCjh6
         0Gnjy3k4AcSqPU8V7Cw+Xdjc37glR6o1V7PSLItcvhxpAChfPO1AOA32VcplyiqwsE5w
         0Jo4Sj23DEi2zFQv4xvE+6MT6nB0+2qwOZrBipv2A3xN7iqc9XLB6zz+PfKXRBzV4Dho
         gbVFY/6sl/VNGU58UGjRWFtBeCm4vRyE/NIOxE6dxbomXkk9pFbNwW9YB2Kq+lUdh8IN
         re5B/wOXddUsvBVgBP5D1lj9a5WtICNfWdNrjMu3jz9ykExUwZKFXqmNrRbEPisHf/ng
         X1vA==
X-Gm-Message-State: APjAAAUUwE/mnMU91sRfk8jvuie4pXe2tjCqIr+fl5eXpHhggbYdniKM
        n9a1uadfUeG8bsnI5TKHNsr5cn2o
X-Google-Smtp-Source: APXvYqy9GN4fwIOR2rpJJv3361slks+nNEPiy7uq5wBPPNKg7A8Yhinj0QfeWlEr2DSzIWK8GjKV/Q==
X-Received: by 2002:a63:d047:: with SMTP id s7mr15928951pgi.81.1576865687025;
        Fri, 20 Dec 2019 10:14:47 -0800 (PST)
Received: from dentonliu-ltm.internal.salesforce.com.com ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id c78sm14063082pfb.122.2019.12.20.10.14.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 10:14:46 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 15/15] t1507: inline full_name()
Date:   Fri, 20 Dec 2019 10:16:02 -0800
Message-Id: <4fe445279b715b3a49e7635adc1af152de183bff.1576865664.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.703.g2f499f1283
In-Reply-To: <cover.1576865663.git.liu.denton@gmail.com>
References: <cover.1576794144.git.liu.denton@gmail.com> <cover.1576865663.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, we were running `test_must_fail full_name`. However,
`test_must_fail` should only be used on git commands. Inline full_name()
so that we can use test_must_fail on the git command directly.

When full_name() was introduced in 28fb84382b (Introduce
<branch>@{upstream} notation, 2009-09-10), the `git -C` option wasn't
available yet (since it was introduced in 44e1e4d67d (git: run in a
directory given with -C option, 2013-09-09)). As a result, the helper
function removed the need to manually cd each time. However, since
`git -C` is available now, we can just use that instead and inline
full_name().

An alternate approach was taken where we taught full_name() to accept an
optional `!` arg to trigger test_must_fail behavior. However, this added
more unnecessary complexity than inlining so we inline instead.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t1507-rev-parse-upstream.sh | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
index f68b77e7ba..dfc0d96d8a 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -28,11 +28,6 @@ test_expect_success 'setup' '
 	)
 '
 
-full_name () {
-	(cd clone &&
-	 git rev-parse --symbolic-full-name "$@")
-}
-
 commit_subject () {
 	(cd clone &&
 	 git show -s --pretty=tformat:%s "$@")
@@ -45,50 +40,50 @@ error_message () {
 
 test_expect_success '@{upstream} resolves to correct full name' '
 	echo refs/remotes/origin/master >expect &&
-	full_name @{upstream} >actual &&
+	git -C clone rev-parse --symbolic-full-name @{upstream} >actual &&
 	test_cmp expect actual &&
-	full_name @{UPSTREAM} >actual &&
+	git -C clone rev-parse --symbolic-full-name @{UPSTREAM} >actual &&
 	test_cmp expect actual &&
-	full_name @{UpSTReam} >actual &&
+	git -C clone rev-parse --symbolic-full-name @{UpSTReam} >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success '@{u} resolves to correct full name' '
 	echo refs/remotes/origin/master >expect &&
-	full_name @{u} >actual &&
+	git -C clone rev-parse --symbolic-full-name @{u} >actual &&
 	test_cmp expect actual &&
-	full_name @{U} >actual &&
+	git -C clone rev-parse --symbolic-full-name @{U} >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'my-side@{upstream} resolves to correct full name' '
 	echo refs/remotes/origin/side >expect &&
-	full_name my-side@{u} >actual &&
+	git -C clone rev-parse --symbolic-full-name my-side@{u} >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'upstream of branch with @ in middle' '
-	full_name fun@ny@{u} >actual &&
+	git -C clone rev-parse --symbolic-full-name fun@ny@{u} >actual &&
 	echo refs/remotes/origin/side >expect &&
 	test_cmp expect actual &&
-	full_name fun@ny@{U} >actual &&
+	git -C clone rev-parse --symbolic-full-name fun@ny@{U} >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'upstream of branch with @ at start' '
-	full_name @funny@{u} >actual &&
+	git -C clone rev-parse --symbolic-full-name @funny@{u} >actual &&
 	echo refs/remotes/origin/side >expect &&
 	test_cmp expect actual
 '
 
 test_expect_success 'upstream of branch with @ at end' '
-	full_name funny@@{u} >actual &&
+	git -C clone rev-parse --symbolic-full-name funny@@{u} >actual &&
 	echo refs/remotes/origin/side >expect &&
 	test_cmp expect actual
 '
 
 test_expect_success 'refs/heads/my-side@{upstream} does not resolve to my-side{upstream}' '
-	test_must_fail full_name refs/heads/my-side@{upstream}
+	test_must_fail git -C clone rev-parse --symbolic-full-name refs/heads/my-side@{upstream}
 '
 
 test_expect_success 'my-side@{u} resolves to correct commit' '
@@ -103,9 +98,9 @@ test_expect_success 'my-side@{u} resolves to correct commit' '
 '
 
 test_expect_success 'not-tracking@{u} fails' '
-	test_must_fail full_name non-tracking@{u} &&
+	test_must_fail git -C clone rev-parse --symbolic-full-name non-tracking@{u} &&
 	(cd clone && git checkout --no-track -b non-tracking) &&
-	test_must_fail full_name non-tracking@{u}
+	test_must_fail git -C clone rev-parse --symbolic-full-name non-tracking@{u}
 '
 
 test_expect_success '<branch>@{u}@{1} resolves correctly' '
@@ -165,7 +160,7 @@ test_expect_success 'checkout other@{u}' '
 
 test_expect_success 'branch@{u} works when tracking a local branch' '
 	echo refs/heads/master >expect &&
-	full_name local-master@{u} >actual &&
+	git -C clone rev-parse --symbolic-full-name local-master@{u} >actual &&
 	test_cmp expect actual
 '
 
@@ -221,7 +216,7 @@ test_expect_success 'pull works when tracking a local branch' '
 # makes sense if the previous one succeeded
 test_expect_success '@{u} works when tracking a local branch' '
 	echo refs/heads/master >expect &&
-	full_name @{u} >actual &&
+	git -C clone rev-parse --symbolic-full-name @{u} >actual &&
 	test_cmp expect actual
 '
 
-- 
2.24.1.703.g2f499f1283

