Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06232C433FE
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 14:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbhLTOdD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 09:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbhLTOdB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 09:33:01 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B825C061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 06:33:01 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id v7so13205264wrv.12
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 06:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=2nBxaaOeoIalmnk3wfIjaUQCc0NzBmAu432EKKwphxQ=;
        b=aDdu+5sytKHkGrX8GkvNQQ5L7jt0b8i3w0FAiYBnebdlaVcTo/9B6zmw0qSyK9wrLC
         QWRaRRz7cZmrYqXfXhqwW2/02wSNM7ZSAJGIQtnVokvuSmjdP3KbDbSzKQAqGyc7e5ie
         f+QAPAv1jdfna7B/9U1gk4pkLSM2utQNxTmKgVkC/jI3wIE4yRCc6ETh/FnVPOoLk77/
         i/QfqLculsO774dzwV93T2e4GkB68AeurH7W7u2VufYiVoTpDIWK0Qum5YGlr7soWlyU
         hH7zy4pZC+rgOJaEZZyDHs3f6uHMncj5+qH2me6UNSmJtrBfeZEaDZCDYD2tD80mPj81
         Fdcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=2nBxaaOeoIalmnk3wfIjaUQCc0NzBmAu432EKKwphxQ=;
        b=Mp/YkTlrQM/sv0sZakrgw/0k/AjknKhSynczmeVKryY+BEAZRyiKdvm3in5vXxZ9Ao
         qzydYIU9yldbXe5SHU0I+7VjviwyQa0gy4FO0bnsU4GgnFeWxXJaioVlPkMmEYBpvwK/
         lIQczEPTM3UblxM1jbTmc194cqdVYLAmTWpSVT/Mn9zkCVSqq5RW81aH2yWWdvnxcD8h
         RmcXjMW01Ah9AnV1teMpE8Yu8auI6TtUVS2vS8dKQqvrwFHHApiJXfPHYG7IW3VufWYp
         edZLvVFKrz7xMc/gs5oOzDumCrUWAM+NX1rlxCL6MvvIm/kyrlySFmQ+7Nl7xwh9VVVI
         q0kw==
X-Gm-Message-State: AOAM531e3OwVVTot9+7bOd0l8af7VQYUgBGQ4ExgSquK8nC6a+P+G3Xz
        UnikVeEnE377nk1yihufo31mrBbF68Q=
X-Google-Smtp-Source: ABdhPJxw7Bkp/zRLDpwAHzc3thqpIIOsvr/Kd/u/JrHvd+TxB9MfL5XQ3q1FLVdoIudk7GHDyoLj2w==
X-Received: by 2002:adf:f3c5:: with SMTP id g5mr13379360wrp.683.1640010779647;
        Mon, 20 Dec 2021 06:32:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e11sm18578396wrq.28.2021.12.20.06.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 06:32:59 -0800 (PST)
Message-Id: <5d5639c2b0474680850b7adbb7c5ec81d124eb50.1640010777.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1100.git.1640010777.gitgitgadget@gmail.com>
References: <pull.1100.git.1640010777.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Dec 2021 14:32:57 +0000
Subject: [PATCH 2/2] builtin add -p: fix hunk splitting
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

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
 add-patch.c                |  7 ++++++
 t/t3701-add-interactive.sh | 46 ++++++++++++++++++++++++++++++++++----
 2 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 8c41cdfe39b..5cea70666e9 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -472,6 +472,13 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 			eol = pend;
 
 		if (starts_with(p, "diff ")) {
+			if (marker == '-' || marker == '+')
+				/*
+				 * Last hunk ended in non-context line (i.e. it
+				 * appended lines to the file, so there are no
+				 * trailing context lines).
+				 */
+				hunk->splittable_into++;
 			ALLOC_GROW_BY(s->file_diff, s->file_diff_nr, 1,
 				   file_diff_alloc);
 			file_diff = s->file_diff + s->file_diff_nr - 1;
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
