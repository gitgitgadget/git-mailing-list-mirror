Return-Path: <SRS0=sBbF=2V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309C2C3F68F
	for <git@archiver.kernel.org>; Tue, 31 Dec 2019 09:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF285206DB
	for <git@archiver.kernel.org>; Tue, 31 Dec 2019 09:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="stPbeizo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfLaJx6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Dec 2019 04:53:58 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:33103 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfLaJx5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Dec 2019 04:53:57 -0500
Received: by mail-ed1-f46.google.com with SMTP id r21so34868806edq.0
        for <git@vger.kernel.org>; Tue, 31 Dec 2019 01:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mamBTIpI6RUiZZQUNzSTGXXJMrKd9H7YNNiekVfn2Sg=;
        b=stPbeizoP6q0+aG3M4CyM7Yk/bV0uOJZsJiL/yByGW0+UmxMK+WeCH9jrz3zj7p46+
         VnDwWvC71krkCtImwUfej5OwmC8AZHHxFPFxyhDP9YYHnh7D5Zw6t3eBBQQC+dmdfTWM
         hlUW5tlraZSl+yGLnZD9P12Gpb6wkqM9RHlZdWbtMIErIXWZpzZbxCCtd02KmsC7FMr5
         F+iMTTDNN79Blp9x0dira/i55acxgzmI2I7hYkcwfnofREcHqW5UfTzh7KQ5wzR2xVXc
         JzMRs02mJ3dnEX5eaUi7weAQgrMzdEO2V6ZRS77n+WhQo/rQZ3MWlyM6N03vyhYs8oJW
         GXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mamBTIpI6RUiZZQUNzSTGXXJMrKd9H7YNNiekVfn2Sg=;
        b=ql/n8dHXgJa/wD8bR1Lqr3FXpFAXZePrXT35G09NnS3c4BvLK7o5CkkAPRP/tIEBG+
         L98LfTvJhST8v9Xg/7A2dWuzY0PDtncunj9PTezOG8iMQAlHZ9e27lh/jDOXcEqatRxV
         wGCcCySXmv2jMmsKVbu6Hg7Pb/YBxYbmunw+MnwqsH9VySd7Kt/Rw6Fqd6m8gTuwoNkq
         8eNjf0UWczfG8AmGR1hWXNYt5Bj5iZ0zSckjqSkhiNhhQjLZj+BeP7AE0KaP3sWrqZAw
         GJCvfb9cI5X/nvUwysUVgb3NTyTDw14URQRoyzW/44zsDMdzPz7eOJo3InRgTWLoY7h+
         6Jew==
X-Gm-Message-State: APjAAAUUQI3j/zCCsVONw8UGdzvuz/wzQ6BeHn6tv4lcOljqx8UBs/lp
        9ZOZPCVSV/YMtISldUEhSAOzQysa
X-Google-Smtp-Source: APXvYqzU7uBP7z0xKPCxtk6kHtKVZtn4qYNrqND73828WhCFBwMsYIBWGXxig3b7gAldcOgoMZqJyw==
X-Received: by 2002:a17:907:20c5:: with SMTP id qq5mr54139729ejb.238.1577786034885;
        Tue, 31 Dec 2019 01:53:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b9sm5950573ejj.24.2019.12.31.01.53.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Dec 2019 01:53:54 -0800 (PST)
Message-Id: <88790669ce44d591bad6b6f8c2985e6c8009f74e.1577786032.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.503.v3.git.1577786032.gitgitgadget@gmail.com>
References: <pull.503.v2.git.1577733329.gitgitgadget@gmail.com>
        <pull.503.v3.git.1577786032.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 31 Dec 2019 09:53:50 +0000
Subject: [PATCH v3 1/3] t: fix quotes tests for --pathspec-from-file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

While working on the next patch, I also noticed that quotes testing via
`"\"file\\101.t\""` was somewhat incorrect: I escaped `\` one time while
I had to escape it two times! Tests still worked due to `"` being
preserved which in turn prevented pathspec from matching files.

Fix this by using here-doc instead.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 t/t2026-checkout-pathspec-file.sh | 11 +++++++++--
 t/t2072-restore-pathspec-file.sh  | 11 +++++++++--
 t/t3704-add-pathspec-file.sh      | 11 +++++++++--
 t/t7107-reset-pathspec-file.sh    | 12 +++++++++---
 t/t7526-commit-pathspec-file.sh   | 11 +++++++++--
 5 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/t/t2026-checkout-pathspec-file.sh b/t/t2026-checkout-pathspec-file.sh
index f62fd27440..adad71f631 100755
--- a/t/t2026-checkout-pathspec-file.sh
+++ b/t/t2026-checkout-pathspec-file.sh
@@ -109,7 +109,11 @@ test_expect_success 'CRLF delimiters' '
 test_expect_success 'quotes' '
 	restore_checkpoint &&
 
-	printf "\"file\\101.t\"" | git checkout --pathspec-from-file=- HEAD^1 &&
+	cat >list <<-\EOF &&
+	"file\101.t"
+	EOF
+
+	git checkout --pathspec-from-file=list HEAD^1 &&
 
 	cat >expect <<-\EOF &&
 	M  fileA.t
@@ -120,7 +124,10 @@ test_expect_success 'quotes' '
 test_expect_success 'quotes not compatible with --pathspec-file-nul' '
 	restore_checkpoint &&
 
-	printf "\"file\\101.t\"" >list &&
+	cat >list <<-\EOF &&
+	"file\101.t"
+	EOF
+
 	test_must_fail git checkout --pathspec-from-file=list --pathspec-file-nul HEAD^1
 '
 
diff --git a/t/t2072-restore-pathspec-file.sh b/t/t2072-restore-pathspec-file.sh
index db58e83735..b407f6b779 100755
--- a/t/t2072-restore-pathspec-file.sh
+++ b/t/t2072-restore-pathspec-file.sh
@@ -109,7 +109,11 @@ test_expect_success 'CRLF delimiters' '
 test_expect_success 'quotes' '
 	restore_checkpoint &&
 
-	printf "\"file\\101.t\"" | git restore --pathspec-from-file=- --source=HEAD^1 &&
+	cat >list <<-\EOF &&
+	"file\101.t"
+	EOF
+
+	git restore --pathspec-from-file=list --source=HEAD^1 &&
 
 	cat >expect <<-\EOF &&
 	 M fileA.t
@@ -120,7 +124,10 @@ test_expect_success 'quotes' '
 test_expect_success 'quotes not compatible with --pathspec-file-nul' '
 	restore_checkpoint &&
 
-	printf "\"file\\101.t\"" >list &&
+	cat >list <<-\EOF &&
+	"file\101.t"
+	EOF
+
 	test_must_fail git restore --pathspec-from-file=list --pathspec-file-nul --source=HEAD^1
 '
 
diff --git a/t/t3704-add-pathspec-file.sh b/t/t3704-add-pathspec-file.sh
index 3cfdb669b7..61b6e51009 100755
--- a/t/t3704-add-pathspec-file.sh
+++ b/t/t3704-add-pathspec-file.sh
@@ -97,7 +97,11 @@ test_expect_success 'CRLF delimiters' '
 test_expect_success 'quotes' '
 	restore_checkpoint &&
 
-	printf "\"file\\101.t\"" | git add --pathspec-from-file=- &&
+	cat >list <<-\EOF &&
+	"file\101.t"
+	EOF
+
+	git add --pathspec-from-file=list &&
 
 	cat >expect <<-\EOF &&
 	A  fileA.t
@@ -108,7 +112,10 @@ test_expect_success 'quotes' '
 test_expect_success 'quotes not compatible with --pathspec-file-nul' '
 	restore_checkpoint &&
 
-	printf "\"file\\101.t\"" >list &&
+	cat >list <<-\EOF &&
+	"file\101.t"
+	EOF
+
 	test_must_fail git add --pathspec-from-file=list --pathspec-file-nul
 '
 
diff --git a/t/t7107-reset-pathspec-file.sh b/t/t7107-reset-pathspec-file.sh
index 6b1a731fff..b0e84cdb42 100755
--- a/t/t7107-reset-pathspec-file.sh
+++ b/t/t7107-reset-pathspec-file.sh
@@ -105,8 +105,12 @@ test_expect_success 'CRLF delimiters' '
 test_expect_success 'quotes' '
 	restore_checkpoint &&
 
+	cat >list <<-\EOF &&
+	"file\101.t"
+	EOF
+
 	git rm fileA.t &&
-	printf "\"file\\101.t\"" | git reset --pathspec-from-file=- &&
+	git reset --pathspec-from-file=list &&
 
 	cat >expect <<-\EOF &&
 	 D fileA.t
@@ -117,8 +121,10 @@ test_expect_success 'quotes' '
 test_expect_success 'quotes not compatible with --pathspec-file-nul' '
 	restore_checkpoint &&
 
-	git rm fileA.t &&
-	printf "\"file\\101.t\"" >list &&
+	cat >list <<-\EOF &&
+	"file\101.t"
+	EOF
+
 	# Note: "git reset" has not yet learned to fail on wrong pathspecs
 	git reset --pathspec-from-file=list --pathspec-file-nul &&
 
diff --git a/t/t7526-commit-pathspec-file.sh b/t/t7526-commit-pathspec-file.sh
index 4b58901ed6..4a7c11368d 100755
--- a/t/t7526-commit-pathspec-file.sh
+++ b/t/t7526-commit-pathspec-file.sh
@@ -100,7 +100,11 @@ test_expect_success 'CRLF delimiters' '
 test_expect_success 'quotes' '
 	restore_checkpoint &&
 
-	printf "\"file\\101.t\"" | git commit --pathspec-from-file=- -m "Commit" &&
+	cat >list <<-\EOF &&
+	"file\101.t"
+	EOF
+
+	git commit --pathspec-from-file=list -m "Commit" &&
 
 	cat >expect <<-\EOF &&
 	A	fileA.t
@@ -111,7 +115,10 @@ test_expect_success 'quotes' '
 test_expect_success 'quotes not compatible with --pathspec-file-nul' '
 	restore_checkpoint &&
 
-	printf "\"file\\101.t\"" >list &&
+	cat >list <<-\EOF &&
+	"file\101.t"
+	EOF
+
 	test_must_fail git commit --pathspec-from-file=list --pathspec-file-nul -m "Commit"
 '
 
-- 
gitgitgadget

