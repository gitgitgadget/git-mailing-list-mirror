Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43168C433F5
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 11:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238536AbiAKLMU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 06:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238485AbiAKLMQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 06:12:16 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60210C061748
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 03:12:15 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id k18so32197911wrg.11
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 03:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Vf28m/YhjKyQ8I1xcJxoMdNfN+8oO7g4aG1WMNwoICM=;
        b=QHdZvnwX8Gi+lTPKSbiLA3zPAl7iIyN3LiyjJju0nvy+mtI5t/K5meh+/3C8lOhls+
         N9RPN887PhdNTRipNJ1ipVX6p278soFz8vZ2Rrx/hIx30bTvzOEbdcxiWc8ogMMspymu
         pDDw3wYuiOSzxYShzuzmASqNLTqmoIV1GgTt3YFrMYufC2ovHmnCrYD1x5GfPw/lpT8d
         dlNdg/2oMN9SgyFOx8QLUXsqLXWOQUBFpsI2r2T+z0zu0DhU1pja3MsvdeEXLW7BUEU7
         9VAXqyKKgyaV8tIMV4RjumxCIlEReu2RAXPWW438io7wEmU7ZFVNqKot93YYS1mbYqQn
         mfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Vf28m/YhjKyQ8I1xcJxoMdNfN+8oO7g4aG1WMNwoICM=;
        b=VxIdY1lEo0j1wBFkmfwrNX1me1Ciig4Qik3bAImabaqFig2KjQsynILq/XV6vKRTEr
         QKCiF7YKoJJSW7G3kEiwAlq/1lRqANBkvz4gnUjZZwpqxA8gftZAv/5wOpg/PUcwT7BL
         TTv/93p0npZbOXSaEHvah5ZQ5S94SlMuFcrvXmA7V0Wb0ak61a0F4C0IQPJ3D4QKX9lQ
         7uVs/2cKfwnyffcmS5j/edq/zoLaHknmvBlOZHmFNjiYckeZ5cGeylV4SPZtUIM/gMU/
         LdAbae+RrV5wz302D5OcebYLG9fPZdACf2pj5LlQasB/7za+6LFU+Wxm1Ph6f4xBtPwl
         mMeg==
X-Gm-Message-State: AOAM530QWn2B09fc8TZBgB0e9mJBR+nB1lZChdOuGGlBlk4y9peAScKD
        rIOLncU2klzZEjYRgxyS9qL8UcgnECY=
X-Google-Smtp-Source: ABdhPJybxh60v3FQjmS5JZ9d0XbagD0Yi1tiCktvAuvCXAiDe9QgACJbIm/zJQBIQbiYbjKVCdkSqw==
X-Received: by 2002:a05:6000:38b:: with SMTP id u11mr3472307wrf.408.1641899533784;
        Tue, 11 Jan 2022 03:12:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 11sm11916337wrz.63.2022.01.11.03.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 03:12:13 -0800 (PST)
Message-Id: <b698989e265cba851aa7ba55ea38d7e7b86548ac.1641899530.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1100.v2.git.1641899530.gitgitgadget@gmail.com>
References: <pull.1100.git.1640010777.gitgitgadget@gmail.com>
        <pull.1100.v2.git.1641899530.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 11 Jan 2022 11:12:10 +0000
Subject: [PATCH v2 2/2] builtin add -p: fix hunk splitting
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The C reimplementation of "add -p" fails to split the last hunk in a
file if hunk ends with an addition or deletion without any post context
line unless it is the last file to be processed.

To determine whether a hunk can be split a counter is incremented each
time a context line follows an insertion or deletion. If at the end of
the hunk the value of this counter is greater than one then the hunk
can be split into that number of smaller hunks. If the last hunk in a
file ends with an insertion or deletion then there is no following
context line and the counter will not be incremented. This case is
already handled at the end of the loop where counter is incremented if
the last hunk ended with an insertion or deletion. Unfortunately there
is no similar check between files (likely because the perl version
only ever parses one diff at a time). Fix this by checking if the last
hunk ended with an insertion or deletion when we see the diff header
of a new file and extend the existing regression test.

Reproted-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 add-patch.c                | 20 +++++++++++------
 t/t3701-add-interactive.sh | 46 ++++++++++++++++++++++++++++++++++----
 2 files changed, 55 insertions(+), 11 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 8c41cdfe39b..89ffda32b26 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -383,6 +383,17 @@ static int is_octal(const char *p, size_t len)
 	return 1;
 }
 
+static void complete_file(char marker, struct hunk *hunk)
+{
+	if (marker == '-' || marker == '+')
+		/*
+		 * Last hunk ended in non-context line (i.e. it
+		 * appended lines to the file, so there are no
+		 * trailing context lines).
+		 */
+		hunk->splittable_into++;
+}
+
 static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 {
 	struct strvec args = STRVEC_INIT;
@@ -472,6 +483,7 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 			eol = pend;
 
 		if (starts_with(p, "diff ")) {
+			complete_file(marker, hunk);
 			ALLOC_GROW_BY(s->file_diff, s->file_diff_nr, 1,
 				   file_diff_alloc);
 			file_diff = s->file_diff + s->file_diff_nr - 1;
@@ -598,13 +610,7 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 				file_diff->hunk->colored_end = hunk->colored_end;
 		}
 	}
-
-	if (marker == '-' || marker == '+')
-		/*
-		 * Last hunk ended in non-context line (i.e. it appended lines
-		 * to the file, so there are no trailing context lines).
-		 */
-		hunk->splittable_into++;
+	complete_file(marker, hunk);
 
 	/* non-colored shorter than colored? */
 	if (colored_p != colored_pend) {
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 77de0029ba5..94537a6b40a 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -326,7 +326,9 @@ test_expect_success 'correct message when there is nothing to do' '
 test_expect_success 'setup again' '
 	git reset --hard &&
 	test_chmod +x file &&
-	echo content >>file
+	echo content >>file &&
+	test_write_lines A B C D>file2 &&
+	git add file2
 '
 
 # Write the patch file with a new line at the top and bottom
@@ -341,13 +343,27 @@ test_expect_success 'setup patch' '
 	 content
 	+lastline
 	\ No newline at end of file
+	diff --git a/file2 b/file2
+	index 8422d40..35b930a 100644
+	--- a/file2
+	+++ b/file2
+	@@ -1,4 +1,5 @@
+	-A
+	+Z
+	 B
+	+Y
+	 C
+	-D
+	+X
 	EOF
 '
 
 # Expected output, diff is similar to the patch but w/ diff at the top
 test_expect_success 'setup expected' '
 	echo diff --git a/file b/file >expected &&
-	sed "/^index/s/ 100644/ 100755/" patch >>expected &&
+	sed -e "/^index 180b47c/s/ 100644/ 100755/" \
+	    -e /1,5/s//1,4/ \
+	    -e /Y/d patch >>expected &&
 	cat >expected-output <<-\EOF
 	--- a/file
 	+++ b/file
@@ -366,6 +382,28 @@ test_expect_success 'setup expected' '
 	 content
 	+lastline
 	\ No newline at end of file
+	--- a/file2
+	+++ b/file2
+	@@ -1,4 +1,5 @@
+	-A
+	+Z
+	 B
+	+Y
+	 C
+	-D
+	+X
+	@@ -1,2 +1,2 @@
+	-A
+	+Z
+	 B
+	@@ -2,2 +2,3 @@
+	 B
+	+Y
+	 C
+	@@ -3,2 +4,2 @@
+	 C
+	-D
+	+X
 	EOF
 '
 
@@ -373,8 +411,8 @@ test_expect_success 'setup expected' '
 test_expect_success 'add first line works' '
 	git commit -am "clear local changes" &&
 	git apply patch &&
-	test_write_lines s y y | git add -p file 2>error >raw-output &&
-	sed -n -e "s/^([1-2]\/[1-2]) Stage this hunk[^@]*\(@@ .*\)/\1/" \
+	test_write_lines s y y s y n y | git add -p 2>error >raw-output &&
+	sed -n -e "s/^([1-9]\/[1-9]) Stage this hunk[^@]*\(@@ .*\)/\1/" \
 	       -e "/^[-+@ \\\\]"/p raw-output >output &&
 	test_must_be_empty error &&
 	git diff --cached >diff &&
-- 
gitgitgadget
