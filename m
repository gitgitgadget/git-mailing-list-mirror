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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E36FC2D0C1
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 22:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E3524672
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 22:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EK9ks3z9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfLSWV5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 17:21:57 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35413 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfLSWVu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 17:21:50 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so3211414plt.2
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 14:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vKYLPG02vVVLMxYbouq+GE4jjP3H+Ekb7R2xtayR5fQ=;
        b=EK9ks3z9zhEHSLb5ch+2e8iTlkwPTqmVY1xEWuo+wZ3h5OohFF6/CivJFx82wDiDSz
         yQgBOBAaqbhQwVkDhwIwPnu3wYU8/4zBo79G383en3QGM4t6aBIP6D3tOirDQha9Sewv
         40p/RJWLYnDdILpEUyOSSGuPFi7pFh+P0yqKxuOEtz8Nz+C88GYDxBVBQVtnhc1LMEGw
         TvKCyhNNu394GXfzhukuJBqat2l3whZ7hXqC6yuCpKm+7mA8tWbq/k6mnYJsKeK0mptp
         Z2TrgsowPYjvOnwUE8cfl+K40uuu7F7Ksez40sAxBUB4Dc3x4QPaxJzCQOGbYmfMu6ef
         9LTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vKYLPG02vVVLMxYbouq+GE4jjP3H+Ekb7R2xtayR5fQ=;
        b=XkR6BJjpOvj7/hr9GZUiQ97AKKY7EWDSkEpirCb+03sYnRXh6mSaVeM0erosvllqbn
         qItmGAxgD6QuLUeR1uzbu/BvdF9SlLeM3iG8nktb/uqcqmkcoyKDj+z82QVEG5+lzV53
         bHw6Uy4lzb/0NXnB4+NlOVX2u+vVyTaPetkjN0iXf6GMn6BmAH0YaXLO1XJaubap9hJ/
         7YCvRguPT5pnaOunndTxY1V6pNfKqddBehqBd1GaZX19ED9kWgqObjrGg63pUkJvkWzq
         OnF+VkorQpdU1cndOONJUTUEUfXcLshwP1NnzAHohQ8gPfhr1BisxRrzXmntBQSQi4FY
         OpBg==
X-Gm-Message-State: APjAAAVxoo9s21SrcBUVbT4obZ1FSHUkesQysEiS6AWMAz02/0kXiNEj
        f8LPVlrZuXhEMjMa1+r64vPMaZjJ
X-Google-Smtp-Source: APXvYqwjnWvvPZ2meGBQnU6iYeTDlt1fhmSDaN4xO4P7O0onf9UwCMHAlRZD6WlMX145l8jQN0tCJQ==
X-Received: by 2002:a17:902:9a45:: with SMTP id x5mr11790311plv.310.1576794109020;
        Thu, 19 Dec 2019 14:21:49 -0800 (PST)
Received: from dentonliu-ltm.internal.salesforce.com ([216.52.21.197])
        by smtp.gmail.com with ESMTPSA id o19sm11428528pjr.2.2019.12.19.14.21.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 14:21:48 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 16/16] t1507: inline full_name()
Date:   Thu, 19 Dec 2019 14:22:51 -0800
Message-Id: <d09370455ffc9de30c0ca7ecce100754f725728a.1576794144.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.703.g2f499f1283
In-Reply-To: <cover.1576794144.git.liu.denton@gmail.com>
References: <cover.1576583819.git.liu.denton@gmail.com> <cover.1576794144.git.liu.denton@gmail.com>
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

