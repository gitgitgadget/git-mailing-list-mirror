Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449B0C433E9
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 16:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FD5B233F6
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 16:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391592AbhATQ5B (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 11:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404077AbhATQz1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 11:55:27 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F57CC061793
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 08:54:09 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id a1so2462180wrq.6
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 08:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=g5rYqLWoWL2WCFNwvHUDqPp3kEwXKkEJegs8hgz8btI=;
        b=SEWO7wK84/SBeLS0loo6nDxNPfVqJko54rPtLBkRNCRL+DLA7Y9SrD8CCZU+MfmZl7
         ibu/ONw5wgRuz1Mc9wsIKTTZV/EYR4gfYsCSxh2pXtfmLl4yaJOr1l/B8DGy7vYxF+Ll
         GN+b6fvZHJ/VBmX737DRbMaq5qsS6EWtc1tto3X1aw/lSmdkl+Y7RAuRAWH3sJ9pymQK
         N36ODdwzOvXTGdWYVcqw4KgS+fN+b8ypp4dSko5duL8iXVDzYd83bdvtbxB9FgcRL2+M
         p+8Yn3ZOUHgFv6R07DUhnbI72cACp6JZWXZ3RcEYIMRmf+p9tPQHENL8WHXKa0Qnlo1M
         vTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=g5rYqLWoWL2WCFNwvHUDqPp3kEwXKkEJegs8hgz8btI=;
        b=jLDkgAS5PwXJHejGDBhn/zAvvKlWr/HSSvcPq9vEwKBi3QWFtwXCTU6+KqY4KQtBY+
         X8o8CcU/NxiGJJxomYIyZlJfSRALmIH+inbgx5QJfeS/tqm+xcYcRm02Dt/JsANDY9h3
         7NQfEPI4/YQTv7XBUc+dRnEDr0/YuG9MYJ3Bcfbdj0ucl81X4rKqQbKEVc6MEMduR8L/
         nWFD2n/7rWaI584CLzfHVYmDgn84iEbV9GTQQ30guoArmBsO8lWi/XxI9JMCgR8SCJoG
         FP7glPveWPINcnsrbKybCjxcxGQ9sRAVkJYiRRQ9l+Dmn02sosJeg7tG6XgrVKZzjI4+
         hQWA==
X-Gm-Message-State: AOAM532ZyqPEYs3BL1s5R8rcivmxi1QfBI3cT4nNLLkgU3MGYtTt9RYJ
        VQ8KJRL7A9nFHfki1TAUATF0M0R6hFc=
X-Google-Smtp-Source: ABdhPJy8+4R1jFIMFeTXKcq38FVYbcAK+bjEhE0NFFYGRRagsGov6IlQ4zpctb3oKVI1qZgr22xvtg==
X-Received: by 2002:a5d:6cc9:: with SMTP id c9mr9995416wrc.411.1611161647991;
        Wed, 20 Jan 2021 08:54:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h9sm5229274wre.24.2021.01.20.08.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 08:54:07 -0800 (PST)
Message-Id: <8326a9b5320e1e774caef568fcce2bfd2ec13cb1.1611161639.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.839.git.1611161639.gitgitgadget@gmail.com>
References: <pull.839.git.1611161639.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Jan 2021 16:53:58 +0000
Subject: [PATCH 8/9] test-lib: test_region looks for trace2 regions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Most test cases can verify Git's behavior using input/output
expectations or changes to the .git directory. However, sometimes we
want to check that Git did or did not run a certain section of code.
This is particularly important for performance-only features that we
want to ensure have been enabled in certain cases.

Add a new 'test_region' function that checks if a trace2 region was
entered and left in a given trace2 event log.

There is one existing test (t0500-progress-display.sh) that performs
this check already, so use the helper function instead. More uses will
be added in a later change.

t6423-merge-rename-directories.sh also greps for region_enter lines, but
it verifies the number of such lines, which is not the same as an
existence check.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t0500-progress-display.sh |  3 +--
 t/test-lib-functions.sh     | 40 +++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
index 1ed1df351cb..c461b89dfaf 100755
--- a/t/t0500-progress-display.sh
+++ b/t/t0500-progress-display.sh
@@ -303,8 +303,7 @@ test_expect_success 'progress generates traces' '
 		"Working hard" <in 2>stderr &&
 
 	# t0212/parse_events.perl intentionally omits regions and data.
-	grep -e "region_enter" -e "\"category\":\"progress\"" trace.event &&
-	grep -e "region_leave" -e "\"category\":\"progress\"" trace.event &&
+	test_region category progress trace.event &&
 	grep "\"key\":\"total_objects\",\"value\":\"40\"" trace.event &&
 	grep "\"key\":\"total_bytes\",\"value\":\"409600\"" trace.event
 '
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 999982fe4a9..c878db93013 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1655,3 +1655,43 @@ test_subcommand () {
 		grep "\[$expr\]"
 	fi
 }
+
+# Check that the given command was invoked as part of the
+# trace2-format trace on stdin.
+#
+#	test_region [!] <category> <label> git <command> <args>...
+#
+# For example, to look for trace2_region_enter("index", "do_read_index", repo)
+# in an invocation of "git checkout HEAD~1", run
+#
+#	GIT_TRACE2_EVENT="$(pwd)/trace.txt" GIT_TRACE2_EVENT_NESTING=10 \
+#		git checkout HEAD~1 &&
+#	test_region index do_read_index <trace.txt
+#
+# If the first parameter passed is !, this instead checks that
+# the given region was not entered.
+#
+test_region () {
+	local expect_exit=0
+	if test "$1" = "!"
+	then
+		expect_exit=1
+		shift
+	fi
+
+	grep -e "region_enter" -e "\"category\":\"$1\",\"label\":\"$2\"" "$3"
+	exitcode=$?
+
+	if test $exitcode != $expect_exit
+	then
+		return 1
+	fi
+
+	grep -e "region_leave" -e "\"category\":\"$1\",\"label\":\"$2\"" "$3"
+	exitcode=$?
+
+	if test $exitcode != $expect_exit
+	then
+		return 1
+	fi
+}
-- 
gitgitgadget

