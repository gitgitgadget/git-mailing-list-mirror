Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA71C2D0CE
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 17:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D38DD20722
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 17:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NETgcm0b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbfL3Rme (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 12:42:34 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:43368 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfL3Rme (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 12:42:34 -0500
Received: by mail-ed1-f44.google.com with SMTP id dc19so33276683edb.10
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 09:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Vmz+WwZ7pDca1l5yXcR15q5m0qSpTWfj4qONzCMOWyE=;
        b=NETgcm0bSLWECpvlrJyyj1FmmY9Lowmqny34C43uoU9LVw4Or7wQke7OxfEA1SwiIl
         XhXMt/UzOecBTBsB0sbwq15/RYIId4CKiLw7zrKwHWwos0Y6uErRAqNKnxhhdhUspzz9
         Emmk9m0Qza3lX5ida4ZMJQnmkv4M6QnCBgVRdF7ExfcCa4Vs2TO9hP3zLs0blZh7XN+/
         B+abOHA2mMwIlmzKjw6lIryeZ9AZUcxYMYBt2W0y6oevM0bq1XL7u8bEOV/A5uT8q3c0
         k3rHHPHExJjYU8BHPfdwkf5h072v+6i0Y5hnPM4VNVtrQT0yd0jZBU76XHFQP2fq85Ec
         NgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Vmz+WwZ7pDca1l5yXcR15q5m0qSpTWfj4qONzCMOWyE=;
        b=dxQD0CflXtA/5+hMOz+nxG90BQcli+1CwVBEO+Kn4pdGzWCb/IDCTOLMT42w983l0a
         i2gGY1+segJBJ6RTQss1utlGzKaIwEb09fy8Xe+KCKw3yZ3lBlJnb/kRhcMO8FHIiuUv
         CRRuMsJ3rd2hv7Cxaf3hrTHo7e1YkYVYUkzkxBxYK2dui0lt0dq2+bjG2GV2IXAYNylF
         n6BwgGxlyE3Qo0NA301OCYI6Ck/X5cr68MUsq7mWidw+vJZiw3KwzViwmYywhxRgAuSt
         kwCeWscaxdeWCSSV2qUdrrEBserkjfnTQMjaFHMxi2JdNYb6KH8TE3hwZ1L8Bdj6T75r
         JB8g==
X-Gm-Message-State: APjAAAVrYoVv5h0Vgd9kocixZ92tv+ZS/aXDY9jwuQOJqHvQkSJ/h+hL
        mhbeAMrub44gX+Izw0jMRxMV8uqh
X-Google-Smtp-Source: APXvYqwx0AlhM15bMyUhePDhO7Pa31eTyPKJS209dM8WPg8KBR/ejfddYVzmKw1Eo9NngnfQ44BPnA==
X-Received: by 2002:a17:907:2071:: with SMTP id qp17mr72774994ejb.176.1577727750507;
        Mon, 30 Dec 2019 09:42:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l26sm5441201edq.5.2019.12.30.09.42.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Dec 2019 09:42:29 -0800 (PST)
Message-Id: <daef256db3d740c88f3c363409de606f15dc4841.1577727747.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.503.git.1577727747.gitgitgadget@gmail.com>
References: <pull.503.git.1577727747.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 Dec 2019 17:42:27 +0000
Subject: [PATCH 3/3] t: drop copy&pasted tests for --pathspec-from-file
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
