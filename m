Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8E0C432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 21:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2AD22071A
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 21:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3xBySyf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbfKYV23 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 16:28:29 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37890 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfKYV22 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 16:28:28 -0500
Received: by mail-wm1-f68.google.com with SMTP id z19so937237wmk.3
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 13:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=29kfKYIa+20ylMRQsVzEOYq9YF/ZAgL/Qbwdp5eTeoA=;
        b=U3xBySyfY8hrERPQwrxPxLbRfxvjG2twWjEGpowr0cRL5AlaSWJS+Yc3W632YqC68q
         gBLUCZEHjJtxtApkDUqB5BJ15fOSJm+W5FCmqKoRQKEOqgQcGRYUwYJAd1wrW2JMYu0r
         gfHXsT9cnVo/dH2nk8TkUVW/Nik7+LZ8rmvIJv+gVtdwq1nUtLRX9h6y0mlz2qfhWvqp
         kw6s99JtkOno9Jx1MhtULm7vDD/Vxc/xeHBZGPipBR3kRG+kHvdODRX2KVk12Bs1a3e9
         PTiaHi3CRPDv2eTiJqQc/vgXK+Jl3yAUYxcfDcIQ/CDK3p3IcNpeJ0gTpM8XFhbhWQd0
         m3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=29kfKYIa+20ylMRQsVzEOYq9YF/ZAgL/Qbwdp5eTeoA=;
        b=ZDqE7Tqe/izNxfbbbZvehKkjOKPjWmSXdmBteTiA9lXIZ+xqn7SYLxQIdOJmPBkT/d
         9IaBu0k1SsfwAFkP50naJhKRNw6MoV0fSwCEaiwqCY6K9by2++vcZ+cnXeMlSOySDBFW
         qxmNqi1e5BZMB/XIqCmizkO2ndUv82oF3PRXokibwZ1trPegC80TBdp7B1s/tCZUhBhS
         hMVqbSG58muiG3pOOnwoVpOF2P/0FG+O80f3KwPGc+/AyHcKmanL2bwzr7pd1JSmwy0A
         ZwT30x9egCbj6ECF/BH/wYiar9k/LuzPvQixZL7s1Uj1EO0lGKezyQLw6k/VR9CC3I64
         p6MQ==
X-Gm-Message-State: APjAAAXgdO7PJVgc1fkNKHz2EvS7h9/iMrZ7b4d7gQJ9q2jrTZRmsR56
        6q73X1tl/+rokch12sYfcThFoIPK
X-Google-Smtp-Source: APXvYqwjBVHV8CvF/LGL/5TvUFvseX6rHkR1BVtszTY937fk2+GGNDavtaNcTYG5u5+TbI72R3X/bg==
X-Received: by 2002:a05:600c:2911:: with SMTP id i17mr749701wmd.83.1574717305989;
        Mon, 25 Nov 2019 13:28:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e16sm12001370wrj.80.2019.11.25.13.28.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Nov 2019 13:28:25 -0800 (PST)
Message-Id: <a7acdf9c8f8c85f9f39750315716f21e83ce67c6.1574717303.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.450.v5.git.1574717303.gitgitgadget@gmail.com>
References: <pull.450.v4.git.1574351516.gitgitgadget@gmail.com>
        <pull.450.v5.git.1574717303.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Nov 2019 21:28:22 +0000
Subject: [PATCH v5 1/2] progress: create GIT_PROGRESS_DELAY
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ryenus@gmail.com, stolee@gmail.com, peff@peff.net,
        szeder.dev@gmail.com, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The start_delayed_progress() method is a preferred way to show
optional progress to users as it ignores steps that take less
than two seconds. However, this makes testing unreliable as tests
expect to be very fast.

In addition, users may want to decrease or increase this time
interval depending on their preferences for terminal noise.

Create the GIT_PROGRESS_DELAY environment variable to control
the delay set during start_delayed_progress(). Set the value
in some tests to guarantee their output remains consistent.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git.txt   |  4 ++++
 progress.c              | 15 +++++++++++++--
 t/t5318-commit-graph.sh |  4 ++--
 t/t6500-gc.sh           |  3 +--
 4 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 9b82564d1a..1c420da208 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -544,6 +544,10 @@ other
 	a pager.  See also the `core.pager` option in
 	linkgit:git-config[1].
 
+`GIT_PROGRESS_DELAY`::
+	A number controlling how many seconds to delay before showing
+	optional progress indicators. Defaults to 2.
+
 `GIT_EDITOR`::
 	This environment variable overrides `$EDITOR` and `$VISUAL`.
 	It is used by several Git commands when, on interactive mode,
diff --git a/progress.c b/progress.c
index 0063559aab..19805ac646 100644
--- a/progress.c
+++ b/progress.c
@@ -14,6 +14,7 @@
 #include "strbuf.h"
 #include "trace.h"
 #include "utf8.h"
+#include "config.h"
 
 #define TP_IDX_MAX      8
 
@@ -267,9 +268,19 @@ static struct progress *start_progress_delay(const char *title, uint64_t total,
 	return progress;
 }
 
+static int get_default_delay(void)
+{
+	static int delay_in_secs = -1;
+
+	if (delay_in_secs < 0)
+		delay_in_secs = git_env_ulong("GIT_PROGRESS_DELAY", 2);
+
+	return delay_in_secs;
+}
+
 struct progress *start_delayed_progress(const char *title, uint64_t total)
 {
-	return start_progress_delay(title, total, 2, 0);
+	return start_progress_delay(title, total, get_default_delay(), 0);
 }
 
 struct progress *start_progress(const char *title, uint64_t total)
@@ -294,7 +305,7 @@ struct progress *start_sparse_progress(const char *title, uint64_t total)
 struct progress *start_delayed_sparse_progress(const char *title,
 					       uint64_t total)
 {
-	return start_progress_delay(title, total, 2, 1);
+	return start_progress_delay(title, total, get_default_delay(), 1);
 }
 
 static void finish_if_sparse(struct progress *progress)
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index d42b3efe39..0824857e1f 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -132,7 +132,7 @@ test_expect_success 'commit-graph write progress off for redirected stderr' '
 
 test_expect_success 'commit-graph write force progress on for stderr' '
 	cd "$TRASH_DIRECTORY/full" &&
-	git commit-graph write --progress 2>err &&
+	GIT_PROGRESS_DELAY=0 git commit-graph write --progress 2>err &&
 	test_file_not_empty err
 '
 
@@ -150,7 +150,7 @@ test_expect_success 'commit-graph verify progress off for redirected stderr' '
 
 test_expect_success 'commit-graph verify force progress on for stderr' '
 	cd "$TRASH_DIRECTORY/full" &&
-	git commit-graph verify --progress 2>err &&
+	GIT_PROGRESS_DELAY=0 git commit-graph verify --progress 2>err &&
 	test_file_not_empty err
 '
 
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index c0f04dc6b0..7f79eedd1c 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -103,9 +103,8 @@ test_expect_success 'auto gc with too many loose objects does not attempt to cre
 '
 
 test_expect_success 'gc --no-quiet' '
-	git -c gc.writeCommitGraph=true gc --no-quiet >stdout 2>stderr &&
+	GIT_PROGRESS_DELAY=0 git -c gc.writeCommitGraph=true gc --no-quiet >stdout 2>stderr &&
 	test_must_be_empty stdout &&
-	test_line_count = 1 stderr &&
 	test_i18ngrep "Computing commit graph generation numbers" stderr
 '
 
-- 
gitgitgadget

