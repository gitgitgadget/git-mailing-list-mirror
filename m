Return-Path: <SRS0=sBbF=2V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314EAC3F68F
	for <git@archiver.kernel.org>; Tue, 31 Dec 2019 10:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8773206E4
	for <git@archiver.kernel.org>; Tue, 31 Dec 2019 10:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ujf/2v0l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfLaKPS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Dec 2019 05:15:18 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:43551 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfLaKPR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Dec 2019 05:15:17 -0500
Received: by mail-ed1-f42.google.com with SMTP id dc19so34898029edb.10
        for <git@vger.kernel.org>; Tue, 31 Dec 2019 02:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mamBTIpI6RUiZZQUNzSTGXXJMrKd9H7YNNiekVfn2Sg=;
        b=ujf/2v0lrZPMMTT/EWtY/4yx2yaTgo2RdcCYj//VTfoVc2ktptgs/QbxA/Qrvvm1HY
         BvGPeIcPMlQrR4KCa2e9f2b4WmiKhRBQCcwoKgtuzm6HE2sguDaMyg1odPGYpUTvimhE
         MlYysJd9ihtNingbrA0ye1JuliqFn/UwM8P4Ihg/0Bh7zWLRlaHDiugZoAXTiHmik46P
         pC9dXzQNhRI76l9D+3hMBJqhIVnw1X5kYD6py8XL/63E0ONLSasukLP9AYMXQJ14tjtK
         drwT0w58q8Yq4ZmwsD8CkkJDph6uhB1LixYKbAL4OeAjVmKjLhjGJE2BFY3M4ZYWZkjk
         8Hkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mamBTIpI6RUiZZQUNzSTGXXJMrKd9H7YNNiekVfn2Sg=;
        b=T1lhm0WVWmSKUp+UQNRRflx/b2E8qP4H2lStaRNNLSj1hBeHA4/s+fNpbf6tNvvX5c
         amfCNgDAgs+vtHfF0fzLg8pnRqRUq4WwQLfk+DfYRruSstiTil3cX7ANHtnTBqu50C03
         zAMpI6b6H5V5DW8P7A11Z1Asx381C6sXscX0AARgf9l/H47A6KT3C/Vw//1dILz9f9gr
         mYHsGHUYdcjYQbj+QYIzLaj620sYUyqur2/GH1KuuaH5R7GyAIF6XzFI1mWoiTNaE1lH
         n5ljEG/r/xLXQGKGSTxtlwogUISzRgEQLn7AQTI1ANh6I0117XNwRPqdh+hMWs5zPir1
         CwwA==
X-Gm-Message-State: APjAAAV6vIXzkfkX7M5wiUeO6q5rZSHMpUX3rPApaHn6KWG/p+dFCxIa
        FoQhWb8j3nU/IB4xrRBTdzrXbTel
X-Google-Smtp-Source: APXvYqyaXeP2O28Wyt/n6eAncVtevtA+5xfeYB0iYGEIi4Ml8FI1DKbp71fjU127aAux9uhpViR4Uw==
X-Received: by 2002:aa7:cac7:: with SMTP id l7mr74952491edt.25.1577787315048;
        Tue, 31 Dec 2019 02:15:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u26sm6096425ejj.7.2019.12.31.02.15.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Dec 2019 02:15:14 -0800 (PST)
Message-Id: <ce0c592bb436112727d3636ce9a77494cd0ba8e3.1577787313.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.503.v4.git.1577787313.gitgitgadget@gmail.com>
References: <pull.503.v3.git.1577786032.gitgitgadget@gmail.com>
        <pull.503.v4.git.1577787313.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 31 Dec 2019 10:15:11 +0000
Subject: [PATCH v4 1/3] t: fix quotes tests for --pathspec-from-file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
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

