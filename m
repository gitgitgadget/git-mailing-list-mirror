Return-Path: <SRS0=sBbF=2V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E91C2D0C2
	for <git@archiver.kernel.org>; Tue, 31 Dec 2019 09:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973A1206DB
	for <git@archiver.kernel.org>; Tue, 31 Dec 2019 09:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLQ2TEN9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfLaJyA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Dec 2019 04:54:00 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43485 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfLaJx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Dec 2019 04:53:59 -0500
Received: by mail-ed1-f65.google.com with SMTP id dc19so34861027edb.10
        for <git@vger.kernel.org>; Tue, 31 Dec 2019 01:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xGvt1ITxACH7rT3R9X5+mBa7RJXMnMsOdSO5EG/YlBg=;
        b=eLQ2TEN9t0Ha5uHeZKUFpKmPZlMRxLAVbKr7umxxLlDdqxMAjLpvnB/BMAqX6SqBry
         +DYJR4zlYGASGzr0ZvB2ZuYYVG6fn8DP3ETPnvZgU25CyUdlnkaFn54hNZTcMx32mZdF
         W4aQaKMgVddePMCwV9na//yINzTRHZhGF/jL21fgeWBRvjJulFf8CU4vjsHKhh+Z+5XD
         tApu7ltUwCpQj6b1z5/te8PbonCAAHRpL6GzUto5lwKBWGrFg+QnCIQon6qKPOCLH89L
         X0JIpuGPJEbt1Gzc7AIBmPsn/Tip29M7AAQat+Bg47NTM1aKYIoyy2bzbngcSRzfj03h
         /Fhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xGvt1ITxACH7rT3R9X5+mBa7RJXMnMsOdSO5EG/YlBg=;
        b=pzP5oVDPl2iT6jOua4Jo7TU5CP2SOHYkzSuT5m6QTkfZyfMM9Yyvhnt8IYcx8xpbfq
         5L6kIjChwLXe18V/trvHnQ3TKHSk8vaBnSS44qIbwCAPkHk360V2mwGm5Y6Ju+r05SbY
         nCDjwE/tpC56tG2NV86SeyD3anVLD7nIfQWnT1gtFfaqOePcZNaSWIWBqMRo7J8z/7Tp
         744ig/Cb+muBTuLEbZPciqd9RKDOVxUyBHWqa9Iw6RGcH1h0ZRL5OEP0qjm6vP0+8C0k
         daCrdZlz3GeYMSesKf7g8xRJk6ERZC4TbsIk1tmHk5Ti2UcfUlPfCekmiGj4WK5xcIXe
         8j4g==
X-Gm-Message-State: APjAAAXypdOg0J4wr5tpmfarQ7xKL/cYXH8ORTlUALeqblis/5h+Xrxn
        EuTUhvUKxNtlCpGYKjhO9Kf6wX8j
X-Google-Smtp-Source: APXvYqwUn1LRltvyquVXaEDJNNB0Mq7m3tyYRkJvDYw/zPGvgHbtG4Mpo4hAnzl2poVeoCNeMlifog==
X-Received: by 2002:aa7:d982:: with SMTP id u2mr78828999eds.238.1577786036653;
        Tue, 31 Dec 2019 01:53:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j3sm5750698edb.50.2019.12.31.01.53.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Dec 2019 01:53:56 -0800 (PST)
Message-Id: <f71021b0dd65593eac2932991e437d739037bedb.1577786032.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.503.v3.git.1577786032.gitgitgadget@gmail.com>
References: <pull.503.v2.git.1577733329.gitgitgadget@gmail.com>
        <pull.503.v3.git.1577786032.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 31 Dec 2019 09:53:52 +0000
Subject: [PATCH v3 3/3] t: drop copy&pasted tests for --pathspec-from-file
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

With direct tests for `parse_pathspec_file()` already in place, it is
not very reasonable to copy&paste 6 tests for `parse_pathspec_file()`
for every git command that uses it (I counted 13 commands that could use
it eventually).

I believe that indirect tests are redundant because I don't expect
direct tests to ever disagree with indirect tests.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 t/t2026-checkout-pathspec-file.sh | 77 +---------------------------
 t/t2072-restore-pathspec-file.sh  | 77 +---------------------------
 t/t3704-add-pathspec-file.sh      | 77 +---------------------------
 t/t7107-reset-pathspec-file.sh    | 85 +++----------------------------
 t/t7526-commit-pathspec-file.sh   | 77 +---------------------------
 5 files changed, 16 insertions(+), 377 deletions(-)

diff --git a/t/t2026-checkout-pathspec-file.sh b/t/t2026-checkout-pathspec-file.sh
index adad71f631..559b4528d7 100755
--- a/t/t2026-checkout-pathspec-file.sh
+++ b/t/t2026-checkout-pathspec-file.sh
@@ -35,7 +35,7 @@ verify_expect () {
 	test_cmp expect actual
 }
 
-test_expect_success '--pathspec-from-file from stdin' '
+test_expect_success 'simplest' '
 	restore_checkpoint &&
 
 	echo fileA.t | git checkout --pathspec-from-file=- HEAD^1 &&
@@ -46,19 +46,7 @@ test_expect_success '--pathspec-from-file from stdin' '
 	verify_expect
 '
 
-test_expect_success '--pathspec-from-file from file' '
-	restore_checkpoint &&
-
-	echo fileA.t >list &&
-	git checkout --pathspec-from-file=list HEAD^1 &&
-
-	cat >expect <<-\EOF &&
-	M  fileA.t
-	EOF
-	verify_expect
-'
-
-test_expect_success 'NUL delimiters' '
+test_expect_success '--pathspec-file-nul' '
 	restore_checkpoint &&
 
 	printf "fileA.t\0fileB.t\0" | git checkout --pathspec-from-file=- --pathspec-file-nul HEAD^1 &&
@@ -70,67 +58,6 @@ test_expect_success 'NUL delimiters' '
 	verify_expect
 '
 
-test_expect_success 'LF delimiters' '
-	restore_checkpoint &&
-
-	printf "fileA.t\nfileB.t\n" | git checkout --pathspec-from-file=- HEAD^1 &&
-
-	cat >expect <<-\EOF &&
-	M  fileA.t
-	M  fileB.t
-	EOF
-	verify_expect
-'
-
-test_expect_success 'no trailing delimiter' '
-	restore_checkpoint &&
-
-	printf "fileA.t\nfileB.t" | git checkout --pathspec-from-file=- HEAD^1 &&
-
-	cat >expect <<-\EOF &&
-	M  fileA.t
-	M  fileB.t
-	EOF
-	verify_expect
-'
-
-test_expect_success 'CRLF delimiters' '
-	restore_checkpoint &&
-
-	printf "fileA.t\r\nfileB.t\r\n" | git checkout --pathspec-from-file=- HEAD^1 &&
-
-	cat >expect <<-\EOF &&
-	M  fileA.t
-	M  fileB.t
-	EOF
-	verify_expect
-'
-
-test_expect_success 'quotes' '
-	restore_checkpoint &&
-
-	cat >list <<-\EOF &&
-	"file\101.t"
-	EOF
-
-	git checkout --pathspec-from-file=list HEAD^1 &&
-
-	cat >expect <<-\EOF &&
-	M  fileA.t
-	EOF
-	verify_expect
-'
-
-test_expect_success 'quotes not compatible with --pathspec-file-nul' '
-	restore_checkpoint &&
-
-	cat >list <<-\EOF &&
-	"file\101.t"
-	EOF
-
-	test_must_fail git checkout --pathspec-from-file=list --pathspec-file-nul HEAD^1
-'
-
 test_expect_success 'only touches what was listed' '
 	restore_checkpoint &&
 
diff --git a/t/t2072-restore-pathspec-file.sh b/t/t2072-restore-pathspec-file.sh
index b407f6b779..9b3125d582 100755
--- a/t/t2072-restore-pathspec-file.sh
+++ b/t/t2072-restore-pathspec-file.sh
@@ -35,7 +35,7 @@ verify_expect () {
 	test_cmp expect actual
 }
 
-test_expect_success '--pathspec-from-file from stdin' '
+test_expect_success 'simplest' '
 	restore_checkpoint &&
 
 	echo fileA.t | git restore --pathspec-from-file=- --source=HEAD^1 &&
@@ -46,19 +46,7 @@ test_expect_success '--pathspec-from-file from stdin' '
 	verify_expect
 '
 
-test_expect_success '--pathspec-from-file from file' '
-	restore_checkpoint &&
-
-	echo fileA.t >list &&
-	git restore --pathspec-from-file=list --source=HEAD^1 &&
-
-	cat >expect <<-\EOF &&
-	 M fileA.t
-	EOF
-	verify_expect
-'
-
-test_expect_success 'NUL delimiters' '
+test_expect_success '--pathspec-file-nul' '
 	restore_checkpoint &&
 
 	printf "fileA.t\0fileB.t\0" | git restore --pathspec-from-file=- --pathspec-file-nul --source=HEAD^1 &&
@@ -70,67 +58,6 @@ test_expect_success 'NUL delimiters' '
 	verify_expect
 '
 
-test_expect_success 'LF delimiters' '
-	restore_checkpoint &&
-
-	printf "fileA.t\nfileB.t\n" | git restore --pathspec-from-file=- --source=HEAD^1 &&
-
-	cat >expect <<-\EOF &&
-	 M fileA.t
-	 M fileB.t
-	EOF
-	verify_expect
-'
-
-test_expect_success 'no trailing delimiter' '
-	restore_checkpoint &&
-
-	printf "fileA.t\nfileB.t" | git restore --pathspec-from-file=- --source=HEAD^1 &&
-
-	cat >expect <<-\EOF &&
-	 M fileA.t
-	 M fileB.t
-	EOF
-	verify_expect
-'
-
-test_expect_success 'CRLF delimiters' '
-	restore_checkpoint &&
-
-	printf "fileA.t\r\nfileB.t\r\n" | git restore --pathspec-from-file=- --source=HEAD^1 &&
-
-	cat >expect <<-\EOF &&
-	 M fileA.t
-	 M fileB.t
-	EOF
-	verify_expect
-'
-
-test_expect_success 'quotes' '
-	restore_checkpoint &&
-
-	cat >list <<-\EOF &&
-	"file\101.t"
-	EOF
-
-	git restore --pathspec-from-file=list --source=HEAD^1 &&
-
-	cat >expect <<-\EOF &&
-	 M fileA.t
-	EOF
-	verify_expect
-'
-
-test_expect_success 'quotes not compatible with --pathspec-file-nul' '
-	restore_checkpoint &&
-
-	cat >list <<-\EOF &&
-	"file\101.t"
-	EOF
-
-	test_must_fail git restore --pathspec-from-file=list --pathspec-file-nul --source=HEAD^1
-'
-
 test_expect_success 'only touches what was listed' '
 	restore_checkpoint &&
 
diff --git a/t/t3704-add-pathspec-file.sh b/t/t3704-add-pathspec-file.sh
index 61b6e51009..9009f8a9ac 100755
--- a/t/t3704-add-pathspec-file.sh
+++ b/t/t3704-add-pathspec-file.sh
@@ -23,7 +23,7 @@ verify_expect () {
 	test_cmp expect actual
 }
 
-test_expect_success '--pathspec-from-file from stdin' '
+test_expect_success 'simplest' '
 	restore_checkpoint &&
 
 	echo fileA.t | git add --pathspec-from-file=- &&
@@ -34,19 +34,7 @@ test_expect_success '--pathspec-from-file from stdin' '
 	verify_expect
 '
 
-test_expect_success '--pathspec-from-file from file' '
-	restore_checkpoint &&
-
-	echo fileA.t >list &&
-	git add --pathspec-from-file=list &&
-
-	cat >expect <<-\EOF &&
-	A  fileA.t
-	EOF
-	verify_expect
-'
-
-test_expect_success 'NUL delimiters' '
+test_expect_success '--pathspec-file-nul' '
 	restore_checkpoint &&
 
 	printf "fileA.t\0fileB.t\0" | git add --pathspec-from-file=- --pathspec-file-nul &&
@@ -58,67 +46,6 @@ test_expect_success 'NUL delimiters' '
 	verify_expect
 '
 
-test_expect_success 'LF delimiters' '
-	restore_checkpoint &&
-
-	printf "fileA.t\nfileB.t\n" | git add --pathspec-from-file=- &&
-
-	cat >expect <<-\EOF &&
-	A  fileA.t
-	A  fileB.t
-	EOF
-	verify_expect
-'
-
-test_expect_success 'no trailing delimiter' '
-	restore_checkpoint &&
-
-	printf "fileA.t\nfileB.t" | git add --pathspec-from-file=- &&
-
-	cat >expect <<-\EOF &&
-	A  fileA.t
-	A  fileB.t
-	EOF
-	verify_expect
-'
-
-test_expect_success 'CRLF delimiters' '
-	restore_checkpoint &&
-
-	printf "fileA.t\r\nfileB.t\r\n" | git add --pathspec-from-file=- &&
-
-	cat >expect <<-\EOF &&
-	A  fileA.t
-	A  fileB.t
-	EOF
-	verify_expect
-'
-
-test_expect_success 'quotes' '
-	restore_checkpoint &&
-
-	cat >list <<-\EOF &&
-	"file\101.t"
-	EOF
-
-	git add --pathspec-from-file=list &&
-
-	cat >expect <<-\EOF &&
-	A  fileA.t
-	EOF
-	verify_expect
-'
-
-test_expect_success 'quotes not compatible with --pathspec-file-nul' '
-	restore_checkpoint &&
-
-	cat >list <<-\EOF &&
-	"file\101.t"
-	EOF
-
-	test_must_fail git add --pathspec-from-file=list --pathspec-file-nul
-'
-
 test_expect_success 'only touches what was listed' '
 	restore_checkpoint &&
 
diff --git a/t/t7107-reset-pathspec-file.sh b/t/t7107-reset-pathspec-file.sh
index b0e84cdb42..5b845f4f7c 100755
--- a/t/t7107-reset-pathspec-file.sh
+++ b/t/t7107-reset-pathspec-file.sh
@@ -25,7 +25,7 @@ verify_expect () {
 	test_cmp expect actual
 }
 
-test_expect_success '--pathspec-from-file from stdin' '
+test_expect_success 'simplest' '
 	restore_checkpoint &&
 
 	git rm fileA.t &&
@@ -37,20 +37,7 @@ test_expect_success '--pathspec-from-file from stdin' '
 	verify_expect
 '
 
-test_expect_success '--pathspec-from-file from file' '
-	restore_checkpoint &&
-
-	git rm fileA.t &&
-	echo fileA.t >list &&
-	git reset --pathspec-from-file=list &&
-
-	cat >expect <<-\EOF &&
-	 D fileA.t
-	EOF
-	verify_expect
-'
-
-test_expect_success 'NUL delimiters' '
+test_expect_success '--pathspec-file-nul' '
 	restore_checkpoint &&
 
 	git rm fileA.t fileB.t &&
@@ -63,77 +50,21 @@ test_expect_success 'NUL delimiters' '
 	verify_expect
 '
 
-test_expect_success 'LF delimiters' '
-	restore_checkpoint &&
-
-	git rm fileA.t fileB.t &&
-	printf "fileA.t\nfileB.t\n" | git reset --pathspec-from-file=- &&
-
-	cat >expect <<-\EOF &&
-	 D fileA.t
-	 D fileB.t
-	EOF
-	verify_expect
-'
-
-test_expect_success 'no trailing delimiter' '
-	restore_checkpoint &&
-
-	git rm fileA.t fileB.t &&
-	printf "fileA.t\nfileB.t" | git reset --pathspec-from-file=- &&
-
-	cat >expect <<-\EOF &&
-	 D fileA.t
-	 D fileB.t
-	EOF
-	verify_expect
-'
-
-test_expect_success 'CRLF delimiters' '
+test_expect_success 'only touches what was listed' '
 	restore_checkpoint &&
 
-	git rm fileA.t fileB.t &&
-	printf "fileA.t\r\nfileB.t\r\n" | git reset --pathspec-from-file=- &&
+	git rm fileA.t fileB.t fileC.t fileD.t &&
+	printf "fileB.t\nfileC.t\n" | git reset --pathspec-from-file=- &&
 
 	cat >expect <<-\EOF &&
-	 D fileA.t
+	D  fileA.t
 	 D fileB.t
+	 D fileC.t
+	D  fileD.t
 	EOF
 	verify_expect
 '
 
-test_expect_success 'quotes' '
-	restore_checkpoint &&
-
-	cat >list <<-\EOF &&
-	"file\101.t"
-	EOF
-
-	git rm fileA.t &&
-	git reset --pathspec-from-file=list &&
-
-	cat >expect <<-\EOF &&
-	 D fileA.t
-	EOF
-	verify_expect
-'
-
-test_expect_success 'quotes not compatible with --pathspec-file-nul' '
-	restore_checkpoint &&
-
-	cat >list <<-\EOF &&
-	"file\101.t"
-	EOF
-
-	# Note: "git reset" has not yet learned to fail on wrong pathspecs
-	git reset --pathspec-from-file=list --pathspec-file-nul &&
-
-	cat >expect <<-\EOF &&
-	 D fileA.t
-	EOF
-	test_must_fail verify_expect
-'
-
 test_expect_success '--pathspec-from-file is not compatible with --soft or --hard' '
 	restore_checkpoint &&
 
diff --git a/t/t7526-commit-pathspec-file.sh b/t/t7526-commit-pathspec-file.sh
index 4a7c11368d..8d6c652690 100755
--- a/t/t7526-commit-pathspec-file.sh
+++ b/t/t7526-commit-pathspec-file.sh
@@ -26,7 +26,7 @@ verify_expect () {
 	test_cmp expect actual
 }
 
-test_expect_success '--pathspec-from-file from stdin' '
+test_expect_success 'simplest' '
 	restore_checkpoint &&
 
 	echo fileA.t | git commit --pathspec-from-file=- -m "Commit" &&
@@ -37,19 +37,7 @@ test_expect_success '--pathspec-from-file from stdin' '
 	verify_expect
 '
 
-test_expect_success '--pathspec-from-file from file' '
-	restore_checkpoint &&
-
-	echo fileA.t >list &&
-	git commit --pathspec-from-file=list -m "Commit" &&
-
-	cat >expect <<-\EOF &&
-	A	fileA.t
-	EOF
-	verify_expect
-'
-
-test_expect_success 'NUL delimiters' '
+test_expect_success '--pathspec-file-nul' '
 	restore_checkpoint &&
 
 	printf "fileA.t\0fileB.t\0" | git commit --pathspec-from-file=- --pathspec-file-nul -m "Commit" &&
@@ -61,67 +49,6 @@ test_expect_success 'NUL delimiters' '
 	verify_expect
 '
 
-test_expect_success 'LF delimiters' '
-	restore_checkpoint &&
-
-	printf "fileA.t\nfileB.t\n" | git commit --pathspec-from-file=- -m "Commit" &&
-
-	cat >expect <<-\EOF &&
-	A	fileA.t
-	A	fileB.t
-	EOF
-	verify_expect
-'
-
-test_expect_success 'no trailing delimiter' '
-	restore_checkpoint &&
-
-	printf "fileA.t\nfileB.t" | git commit --pathspec-from-file=- -m "Commit" &&
-
-	cat >expect <<-\EOF &&
-	A	fileA.t
-	A	fileB.t
-	EOF
-	verify_expect
-'
-
-test_expect_success 'CRLF delimiters' '
-	restore_checkpoint &&
-
-	printf "fileA.t\r\nfileB.t\r\n" | git commit --pathspec-from-file=- -m "Commit" &&
-
-	cat >expect <<-\EOF &&
-	A	fileA.t
-	A	fileB.t
-	EOF
-	verify_expect
-'
-
-test_expect_success 'quotes' '
-	restore_checkpoint &&
-
-	cat >list <<-\EOF &&
-	"file\101.t"
-	EOF
-
-	git commit --pathspec-from-file=list -m "Commit" &&
-
-	cat >expect <<-\EOF &&
-	A	fileA.t
-	EOF
-	verify_expect expect
-'
-
-test_expect_success 'quotes not compatible with --pathspec-file-nul' '
-	restore_checkpoint &&
-
-	cat >list <<-\EOF &&
-	"file\101.t"
-	EOF
-
-	test_must_fail git commit --pathspec-from-file=list --pathspec-file-nul -m "Commit"
-'
-
 test_expect_success 'only touches what was listed' '
 	restore_checkpoint &&
 
-- 
gitgitgadget
