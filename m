Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B0CC2D0BE
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 16:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC12E207FD
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 16:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrFV/zwX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfLIQKQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 11:10:16 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38722 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfLIQKL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 11:10:11 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so15563607wmi.3
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 08:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WDklD2JX9l7ontB7B0w1M/kSgIVjukgaGNJHtkfp5Z0=;
        b=GrFV/zwXDzIRf8y1rpjUxGdKEfQcC6RscumegpjS5llZFT3gqNcFAwJLFHh0UXKdGz
         QdAA0r1+iLerIQdtN8TLJZYC+2FrMCDhiNUL6mGhf83/+3sQm+z5VIgRjaILOdRPVwqQ
         xVgESzYXZ2c+GsF0MAoC/657h8nXi+PAh1cvIF+Y+xAvyB9Vj8dYYEzEB2IyPZYZymFn
         wvtW0VZPkQzsg7wWtu0M9uoZRUPJfetkHF4olOKxRjBNVBvadE7zMhd7Q31GTpZIhtPb
         Q70yyZ/jawtbDtw8x++mFF3kz+gdhzuUCQSJ3OJxqhFzpt9FqArpZFKtSxlIOXcHze9k
         b4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WDklD2JX9l7ontB7B0w1M/kSgIVjukgaGNJHtkfp5Z0=;
        b=Q5mUlZ/+IeO/E/bm3SPvnBuz4dWpMUnBUYrAAnQZ5luveGYSSQFeFOnscnVVnr/xyz
         C69C+JSVXFrW17+V+cBCa9LZ6LtdzH1StlcPLvWtRlmplYwhzssghRJsujT8+JLwuA1+
         eLLnv4ZXMJtCpwDRzXkQjbfvQtTmwp56m9pzJC/UxNf25p2hI2//Zn+wU+hBHpSjP03j
         VEV7IPQCK0EWvxqUxi5QLhb+Jn7HE+mXVH1wTW8zP2PTjrr9f+dqJDvvjbbHSF8ZHjbg
         a2MITDBG5nIJK9UmatjqDTybGtzcfn30kxVZ/uwv5ZIRxnQPwXEfIIxHM4Aam6xSBLhx
         Ifuw==
X-Gm-Message-State: APjAAAU55/Qkh2tej7QLJHMGYnOVaIu5c6/Xls8l6EVByPDETyETLWzK
        ULsVgkWvZY3/ztpH/5NX3sopOORY
X-Google-Smtp-Source: APXvYqzxUcbAC6OAIap00p/D2CCeuLOHZAfTEw7p2i4jI+1l4m5ndjp/TYfahmJzuy9HqNeTewBL7g==
X-Received: by 2002:a1c:dc08:: with SMTP id t8mr26476413wmg.139.1575907809088;
        Mon, 09 Dec 2019 08:10:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a186sm196157wmd.41.2019.12.09.08.10.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 08:10:08 -0800 (PST)
Message-Id: <a5b0bf6ac7cd28fa47e26ab481f781d74c656f6a.1575907804.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.466.v2.git.1575907804.gitgitgadget@gmail.com>
References: <pull.466.git.1574374826.gitgitgadget@gmail.com>
        <pull.466.v2.git.1575907804.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 09 Dec 2019 16:10:01 +0000
Subject: [PATCH v2 5/8] tests: disable fsmonitor in submodule tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, ukshah2@illinois.edu,
        Kevin.Willford@microsoft.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The fsmonitor feature allows an external tool such as watchman to
monitor the working directory. The direct test
t7619-status-fsmonitor.sh provides some coverage, but it would be
better to run the entire test suite with watchman enabled. This
would provide more confidence that the feature is working as
intended.

The fsmonitor feature struggles with submodules. Disable the
GIT_TEST_FSMONITOR environment variable before running tests with
a lot of submodule interactions.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t3404-rebase-interactive.sh                | 1 +
 t/t3600-rm.sh                                | 1 +
 t/t4060-diff-submodule-option-diff-format.sh | 3 +++
 t/t5526-fetch-submodules.sh                  | 2 ++
 t/t7402-submodule-rebase.sh                  | 3 +++
 t/t7406-submodule-update.sh                  | 2 ++
 t/t7506-status-submodule.sh                  | 3 +++
 t/t7508-status.sh                            | 3 +++
 8 files changed, 18 insertions(+)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 461dd539ff..9dc7d1aefb 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -697,6 +697,7 @@ test_expect_success 'do "noop" when there is nothing to cherry-pick' '
 '
 
 test_expect_success 'submodule rebase setup' '
+	GIT_TEST_FSMONITOR="" &&
 	git checkout A &&
 	mkdir sub &&
 	(
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 66282a720e..64269bd89d 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -355,6 +355,7 @@ test_expect_success 'rm succeeds when given a directory with a trailing /' '
 '
 
 test_expect_success 'rm of a populated submodule with different HEAD fails unless forced' '
+	GIT_TEST_FSMONITOR="" &&
 	git reset --hard &&
 	git submodule update &&
 	git -C submod checkout HEAD^ &&
diff --git a/t/t4060-diff-submodule-option-diff-format.sh b/t/t4060-diff-submodule-option-diff-format.sh
index 9dcb69df5c..017417790e 100755
--- a/t/t4060-diff-submodule-option-diff-format.sh
+++ b/t/t4060-diff-submodule-option-diff-format.sh
@@ -15,6 +15,9 @@ This test tries to verify the sanity of --submodule=diff option of git diff.
 # Tested non-UTF-8 encoding
 test_encoding="ISO8859-1"
 
+# fsmonitor does not work well with submodules
+GIT_TEST_FSMONITOR=""
+
 # String "added" in German (translated with Google Translate), encoded in UTF-8,
 # used in sample commit log messages in add_file() function below.
 added=$(printf "hinzugef\303\274gt")
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 63205dfdf9..fb346bff05 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 # Copyright (c) 2010, Jens Lehmann
 
+GIT_TEST_FSMONITOR=""
+
 test_description='Recursive "git fetch" for submodules'
 
 . ./test-lib.sh
diff --git a/t/t7402-submodule-rebase.sh b/t/t7402-submodule-rebase.sh
index 8e32f19007..c78e9009cf 100755
--- a/t/t7402-submodule-rebase.sh
+++ b/t/t7402-submodule-rebase.sh
@@ -7,6 +7,9 @@ test_description='Test rebasing, stashing, etc. with submodules'
 
 . ./test-lib.sh
 
+# fsmonitor does not work well with submodules
+GIT_TEST_FSMONITOR=""
+
 test_expect_success setup '
 
 	echo file > file &&
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index c973278300..8d93aaef5f 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -11,6 +11,8 @@ submodule and "git submodule update --rebase/--merge" does not detach the HEAD.
 
 . ./test-lib.sh
 
+# fsmonitor does not work well with submodules
+GIT_TEST_FSMONITOR=""
 
 compare_head()
 {
diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index 08629a6e70..1a716f2c2a 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -4,6 +4,9 @@ test_description='git status for submodule'
 
 . ./test-lib.sh
 
+# fsmonitor does not work well with submodules
+GIT_TEST_FSMONITOR=""
+
 test_create_repo_with_commit () {
 	test_create_repo "$1" &&
 	(
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 4e676cdce8..bf0487632d 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -846,6 +846,9 @@ test_expect_success 'status refreshes the index' '
 	test_cmp expect output
 '
 
+# fsmonitor does not work well with submodules
+GIT_TEST_FSMONITOR=""
+
 test_expect_success 'setup status submodule summary' '
 	test_create_repo sm && (
 		cd sm &&
-- 
gitgitgadget

