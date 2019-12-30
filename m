Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77513C2D0C2
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 19:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3639F206CB
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 19:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIxs9mbQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbfL3TPi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 14:15:38 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:44517 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbfL3TPf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 14:15:35 -0500
Received: by mail-ed1-f44.google.com with SMTP id bx28so33569595edb.11
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 11:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Vmz+WwZ7pDca1l5yXcR15q5m0qSpTWfj4qONzCMOWyE=;
        b=lIxs9mbQzUoHOlXwr+yAFZOFgxY3xmtPy3VyYkIMwSV0MP2y4pNDXKy2+B11tprIuq
         YL1qiefgOH1AdscgkynDbKYRour3mjXU+tPbR+LXRUQ2YwV/WdTMz4YEuLUUNv9MQmGZ
         C5lbNnGekT6qmCzDu8+BsxKQffmLxxt+tDJNcpwbaUkM9DUVOrQ0E9RdVgKVNnDqvqRC
         g8107bF5XicAMU2DI13FKIwPoMIhKmp0LnR/mfbN2pB7Hd6lLxIak4AwDuDh+AixFJP9
         suL9UvjfRbyT9V3t/MtUUDawvZmIsMAFqy8yyz2QOnBme0PEg9q5tbTNf0yTtSEStCOU
         0WMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Vmz+WwZ7pDca1l5yXcR15q5m0qSpTWfj4qONzCMOWyE=;
        b=dc4MGDSx+HWFm14pZiRK5HnKQZFPwMZmBB/1trbjm4z2CH/kV2eI5j6R/DryT/BdQ2
         Bk8hv1AkNTdyfvP+4ZKXQ5hDezs3zs0qvdZzELluzxuzEa1k9u2vISHB3BJeYUQsyU9T
         Trrebj4E4CBH8qc0f8yW+uTDrvxxaKDoZykuEPVAFbUyfb2UsujVjfRsLXMEI2dTxZtQ
         rLtSckPKIVsGYQH+Flu9efk8dUrLO0bfNY0fn2A7tCCNqCuySRutKcHwWPQsID5fytm1
         8kg+JdnNDs7gvbk4nTbbVgixCxxlP3xk8OvIxvIkBqgvcNBp6qL9UdmPU+kerzBSA67Y
         m1Zw==
X-Gm-Message-State: APjAAAV2vjmLmVltAl2gPeWQzFcMroQx4qW4HXhHfKQZXNTHRCRkogPq
        1Jl2J9eBrD6UjS+398tihsoYTIfN
X-Google-Smtp-Source: APXvYqx5gIDzTQCP+jcGGdub1KFNc7idAS4/0tOAMGkDhuTq/tGFPZ4j1pPZjpDJ/ncWOo18HCJRrA==
X-Received: by 2002:a17:906:1d50:: with SMTP id o16mr71501864ejh.111.1577733333044;
        Mon, 30 Dec 2019 11:15:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f2sm5702437ejr.52.2019.12.30.11.15.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Dec 2019 11:15:32 -0800 (PST)
Message-Id: <88086cebce73bcbc3eaf437bd86af5545d40e73b.1577733329.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.503.v2.git.1577733329.gitgitgadget@gmail.com>
References: <pull.503.git.1577727747.gitgitgadget@gmail.com>
        <pull.503.v2.git.1577733329.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 Dec 2019 19:15:28 +0000
Subject: [PATCH v2 3/3] t: drop copy&pasted tests for --pathspec-from-file
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
 t/t2026-checkout-pathspec-file.sh | 75 +--------------------------
 t/t2072-restore-pathspec-file.sh  | 75 +--------------------------
 t/t3704-add-pathspec-file.sh      | 75 +--------------------------
 t/t7107-reset-pathspec-file.sh    | 84 +++----------------------------
 t/t7526-commit-pathspec-file.sh   | 75 +--------------------------
 5 files changed, 16 insertions(+), 368 deletions(-)

diff --git a/t/t2026-checkout-pathspec-file.sh b/t/t2026-checkout-pathspec-file.sh
index 2dc8901bca..559b4528d7 100755
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
@@ -70,65 +58,6 @@ test_expect_success 'NUL delimiters' '
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
-	# shell  takes \\\\101 and spits \\101
-	# printf takes   \\101 and spits  \101
-	# git    takes    \101 and spits     A
-	printf "\"file\\\\101.t\"" | git checkout --pathspec-from-file=- HEAD^1 &&
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
-	# shell  takes \\\\101 and spits \\101
-	# printf takes   \\101 and spits  \101
-	printf "\"file\\\\101.t\"" >list &&
-	test_must_fail git checkout --pathspec-from-file=list --pathspec-file-nul HEAD^1
-'
-
 test_expect_success 'only touches what was listed' '
 	restore_checkpoint &&
 
diff --git a/t/t2072-restore-pathspec-file.sh b/t/t2072-restore-pathspec-file.sh
index 70e95ef3b6..9b3125d582 100755
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
@@ -70,65 +58,6 @@ test_expect_success 'NUL delimiters' '
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
-	# shell  takes \\\\101 and spits \\101
-	# printf takes   \\101 and spits  \101
-	# git    takes    \101 and spits     A
-	printf "\"file\\\\101.t\"" | git restore --pathspec-from-file=- --source=HEAD^1 &&
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
-	# shell  takes \\\\101 and spits \\101
-	# printf takes   \\101 and spits  \101
-	printf "\"file\\\\101.t\"" >list &&
-	test_must_fail git restore --pathspec-from-file=list --pathspec-file-nul --source=HEAD^1
-'
-
 test_expect_success 'only touches what was listed' '
 	restore_checkpoint &&
 
diff --git a/t/t3704-add-pathspec-file.sh b/t/t3704-add-pathspec-file.sh
index 2e0141fcce..9009f8a9ac 100755
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
@@ -58,65 +46,6 @@ test_expect_success 'NUL delimiters' '
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
-	# shell  takes \\\\101 and spits \\101
-	# printf takes   \\101 and spits  \101
-	# git    takes    \101 and spits     A
-	printf "\"file\\\\101.t\"" | git add --pathspec-from-file=- &&
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
-	# shell  takes \\\\101 and spits \\101
-	# printf takes   \\101 and spits  \101
-	printf "\"file\\\\101.t\"" >list &&
-	test_must_fail git add --pathspec-from-file=list --pathspec-file-nul
-'
-
 test_expect_success 'only touches what was listed' '
 	restore_checkpoint &&
 
diff --git a/t/t7107-reset-pathspec-file.sh b/t/t7107-reset-pathspec-file.sh
index 52a44f033d..5b845f4f7c 100755
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
@@ -63,76 +50,21 @@ test_expect_success 'NUL delimiters' '
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
-	# shell  takes \\\\101 and spits \\101
-	# printf takes   \\101 and spits  \101
-	# git    takes    \101 and spits     A
-	git rm fileA.t &&
-	printf "\"file\\\\101.t\"" | git reset --pathspec-from-file=- &&
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
-	# shell  takes \\\\101 and spits \\101
-	# printf takes   \\101 and spits  \101
-	git rm fileA.t &&
-	printf "\"file\\\\101.t\"" >list &&
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
index e7dc2ff8b1..8d6c652690 100755
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
@@ -61,65 +49,6 @@ test_expect_success 'NUL delimiters' '
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
-	# shell  takes \\\\101 and spits \\101
-	# printf takes   \\101 and spits  \101
-	# git    takes    \101 and spits     A
-	printf "\"file\\\\101.t\"" | git commit --pathspec-from-file=- -m "Commit" &&
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
-	# shell  takes \\\\101 and spits \\101
-	# printf takes   \\101 and spits  \101
-	printf "\"file\\\\101.t\"" >list &&
-	test_must_fail git commit --pathspec-from-file=list --pathspec-file-nul -m "Commit"
-'
-
 test_expect_success 'only touches what was listed' '
 	restore_checkpoint &&
 
-- 
gitgitgadget
