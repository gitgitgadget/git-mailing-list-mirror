Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E9DC2D0D3
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 19:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0629206CB
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 19:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0O9Wor+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfL3TPf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 14:15:35 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36590 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727648AbfL3TPd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 14:15:33 -0500
Received: by mail-ed1-f66.google.com with SMTP id j17so33603063edp.3
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 11:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Cy4MF7NHiupaUgOV8LYfnl8CAAaHnHZMsTwLHd0WUlg=;
        b=d0O9Wor+NtK+mI0h+GQo4k0ov1jIDqaOJbkrs3urCcM0DBG+3IM/ksBfVtLrv7vxWN
         A9kYjsRGOVFPAOMEGsN94nlBk01scw2dx5aYiA0sVwkngvd3UQZz7hj5OyhWYPG6Ff+Y
         sas0rUSPrwFFMdcqDftXfuKCBX1F6jMRfb5TxXXKOQhyi8jxh4jCxCp8QfJMeY+syYMl
         +MUcLoL80EBfMYGD8jyICb0OVSI07V+dvRfbiBggQl9502cZcjAeafENiJm/qIsNwEi7
         bDNV93d1UI4NkQTZ0+kF6pfDSxdzghDIaaMhWWOXARds18IHc8tt5unSQPUaKqVZuZuy
         tVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Cy4MF7NHiupaUgOV8LYfnl8CAAaHnHZMsTwLHd0WUlg=;
        b=Xj0/KlBFPJJBaTf7AiMMaWaKK4PnLAzMWtTrrPmOa42z6I4WCYGB0rhCvsChoh1Pv1
         0w4k9nLXcaXFQ+mfN4nq/bvIkBsnukZXtL5LwFDSWQ3Ys8R5pP6y662wuGSA9zZUoM2R
         4QHaT8FtceANkomT0pFAzeB/uqEdrEORFqU84bM8KQPQiu7IkdQqw0WFMqJu1Vzo+zjP
         GnCGfzG/4YHZkMWhyJFJEfjh/p8pAemuPsJiM1FheOsDcBx2QqRl7OgHxPK9VAZ1ERXB
         wsAe5/D4HSPnd88JeF02QaRcZXXaOHaIwCZvd4QN7+Ao1T9vK9dpLQo9mqwO3s3fzBRN
         BH5w==
X-Gm-Message-State: APjAAAWKZWciEHn+S3fBDcQlRIxYYXomBpGLkyousVF/ZhrG503lS2nq
        zZ1S7wUk0B+/h1KCZ5KKp8yXBJ0D
X-Google-Smtp-Source: APXvYqwrfsllyal7/RXPUoQIUdhLKTzK4qBmNHSOVmJXb2yet+TOUSQB0FhpQSYqQO86GO72wVnqFA==
X-Received: by 2002:a17:906:52d7:: with SMTP id w23mr72537635ejn.74.1577733331475;
        Mon, 30 Dec 2019 11:15:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d8sm5448829edn.52.2019.12.30.11.15.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Dec 2019 11:15:30 -0800 (PST)
Message-Id: <6193dc7396b9cc6cb78f382c1b1679d6bb455fe4.1577733329.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.503.v2.git.1577733329.gitgitgadget@gmail.com>
References: <pull.503.git.1577727747.gitgitgadget@gmail.com>
        <pull.503.v2.git.1577733329.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 Dec 2019 19:15:26 +0000
Subject: [PATCH v2 1/3] t: fix quotes tests for --pathspec-from-file
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

Fix this by properly escaping one more time.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 t/t2026-checkout-pathspec-file.sh | 9 +++++++--
 t/t2072-restore-pathspec-file.sh  | 9 +++++++--
 t/t3704-add-pathspec-file.sh      | 9 +++++++--
 t/t7107-reset-pathspec-file.sh    | 9 +++++++--
 t/t7526-commit-pathspec-file.sh   | 9 +++++++--
 5 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/t/t2026-checkout-pathspec-file.sh b/t/t2026-checkout-pathspec-file.sh
index f62fd27440..2dc8901bca 100755
--- a/t/t2026-checkout-pathspec-file.sh
+++ b/t/t2026-checkout-pathspec-file.sh
@@ -109,7 +109,10 @@ test_expect_success 'CRLF delimiters' '
 test_expect_success 'quotes' '
 	restore_checkpoint &&
 
-	printf "\"file\\101.t\"" | git checkout --pathspec-from-file=- HEAD^1 &&
+	# shell  takes \\\\101 and spits \\101
+	# printf takes   \\101 and spits  \101
+	# git    takes    \101 and spits     A
+	printf "\"file\\\\101.t\"" | git checkout --pathspec-from-file=- HEAD^1 &&
 
 	cat >expect <<-\EOF &&
 	M  fileA.t
@@ -120,7 +123,9 @@ test_expect_success 'quotes' '
 test_expect_success 'quotes not compatible with --pathspec-file-nul' '
 	restore_checkpoint &&
 
-	printf "\"file\\101.t\"" >list &&
+	# shell  takes \\\\101 and spits \\101
+	# printf takes   \\101 and spits  \101
+	printf "\"file\\\\101.t\"" >list &&
 	test_must_fail git checkout --pathspec-from-file=list --pathspec-file-nul HEAD^1
 '
 
diff --git a/t/t2072-restore-pathspec-file.sh b/t/t2072-restore-pathspec-file.sh
index db58e83735..70e95ef3b6 100755
--- a/t/t2072-restore-pathspec-file.sh
+++ b/t/t2072-restore-pathspec-file.sh
@@ -109,7 +109,10 @@ test_expect_success 'CRLF delimiters' '
 test_expect_success 'quotes' '
 	restore_checkpoint &&
 
-	printf "\"file\\101.t\"" | git restore --pathspec-from-file=- --source=HEAD^1 &&
+	# shell  takes \\\\101 and spits \\101
+	# printf takes   \\101 and spits  \101
+	# git    takes    \101 and spits     A
+	printf "\"file\\\\101.t\"" | git restore --pathspec-from-file=- --source=HEAD^1 &&
 
 	cat >expect <<-\EOF &&
 	 M fileA.t
@@ -120,7 +123,9 @@ test_expect_success 'quotes' '
 test_expect_success 'quotes not compatible with --pathspec-file-nul' '
 	restore_checkpoint &&
 
-	printf "\"file\\101.t\"" >list &&
+	# shell  takes \\\\101 and spits \\101
+	# printf takes   \\101 and spits  \101
+	printf "\"file\\\\101.t\"" >list &&
 	test_must_fail git restore --pathspec-from-file=list --pathspec-file-nul --source=HEAD^1
 '
 
diff --git a/t/t3704-add-pathspec-file.sh b/t/t3704-add-pathspec-file.sh
index 3cfdb669b7..2e0141fcce 100755
--- a/t/t3704-add-pathspec-file.sh
+++ b/t/t3704-add-pathspec-file.sh
@@ -97,7 +97,10 @@ test_expect_success 'CRLF delimiters' '
 test_expect_success 'quotes' '
 	restore_checkpoint &&
 
-	printf "\"file\\101.t\"" | git add --pathspec-from-file=- &&
+	# shell  takes \\\\101 and spits \\101
+	# printf takes   \\101 and spits  \101
+	# git    takes    \101 and spits     A
+	printf "\"file\\\\101.t\"" | git add --pathspec-from-file=- &&
 
 	cat >expect <<-\EOF &&
 	A  fileA.t
@@ -108,7 +111,9 @@ test_expect_success 'quotes' '
 test_expect_success 'quotes not compatible with --pathspec-file-nul' '
 	restore_checkpoint &&
 
-	printf "\"file\\101.t\"" >list &&
+	# shell  takes \\\\101 and spits \\101
+	# printf takes   \\101 and spits  \101
+	printf "\"file\\\\101.t\"" >list &&
 	test_must_fail git add --pathspec-from-file=list --pathspec-file-nul
 '
 
diff --git a/t/t7107-reset-pathspec-file.sh b/t/t7107-reset-pathspec-file.sh
index 6b1a731fff..52a44f033d 100755
--- a/t/t7107-reset-pathspec-file.sh
+++ b/t/t7107-reset-pathspec-file.sh
@@ -105,8 +105,11 @@ test_expect_success 'CRLF delimiters' '
 test_expect_success 'quotes' '
 	restore_checkpoint &&
 
+	# shell  takes \\\\101 and spits \\101
+	# printf takes   \\101 and spits  \101
+	# git    takes    \101 and spits     A
 	git rm fileA.t &&
-	printf "\"file\\101.t\"" | git reset --pathspec-from-file=- &&
+	printf "\"file\\\\101.t\"" | git reset --pathspec-from-file=- &&
 
 	cat >expect <<-\EOF &&
 	 D fileA.t
@@ -117,8 +120,10 @@ test_expect_success 'quotes' '
 test_expect_success 'quotes not compatible with --pathspec-file-nul' '
 	restore_checkpoint &&
 
+	# shell  takes \\\\101 and spits \\101
+	# printf takes   \\101 and spits  \101
 	git rm fileA.t &&
-	printf "\"file\\101.t\"" >list &&
+	printf "\"file\\\\101.t\"" >list &&
 	# Note: "git reset" has not yet learned to fail on wrong pathspecs
 	git reset --pathspec-from-file=list --pathspec-file-nul &&
 
diff --git a/t/t7526-commit-pathspec-file.sh b/t/t7526-commit-pathspec-file.sh
index 4b58901ed6..e7dc2ff8b1 100755
--- a/t/t7526-commit-pathspec-file.sh
+++ b/t/t7526-commit-pathspec-file.sh
@@ -100,7 +100,10 @@ test_expect_success 'CRLF delimiters' '
 test_expect_success 'quotes' '
 	restore_checkpoint &&
 
-	printf "\"file\\101.t\"" | git commit --pathspec-from-file=- -m "Commit" &&
+	# shell  takes \\\\101 and spits \\101
+	# printf takes   \\101 and spits  \101
+	# git    takes    \101 and spits     A
+	printf "\"file\\\\101.t\"" | git commit --pathspec-from-file=- -m "Commit" &&
 
 	cat >expect <<-\EOF &&
 	A	fileA.t
@@ -111,7 +114,9 @@ test_expect_success 'quotes' '
 test_expect_success 'quotes not compatible with --pathspec-file-nul' '
 	restore_checkpoint &&
 
-	printf "\"file\\101.t\"" >list &&
+	# shell  takes \\\\101 and spits \\101
+	# printf takes   \\101 and spits  \101
+	printf "\"file\\\\101.t\"" >list &&
 	test_must_fail git commit --pathspec-from-file=list --pathspec-file-nul -m "Commit"
 '
 
-- 
gitgitgadget

