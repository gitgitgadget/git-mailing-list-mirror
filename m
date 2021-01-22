Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD293C433DB
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 13:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66E5F235F7
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 13:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbhAVNFv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 08:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbhAVNFj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 08:05:39 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C449C0617A7
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 05:04:09 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m2so4248337wmm.1
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 05:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8JFIK/fvNqDmX4Q3vEfnZadxvVhFeB1bH+XL9LjdH2g=;
        b=Z6jh/vU/Gg7PuTfZ1mGfAoXu2vN8wezgYJpOTbGZkmPFPqj2sTJic3ZUoDSbEUFnHZ
         zZUsnnKIuVQ/+cKsvstrdYN7yDUWIXjHDeedE8ZEIfZilykC/wOPO2klrEyv6OswYW1v
         4wxfYfmgW7QseyDgU7hBm1wgkeJaeyvtVRFkaPuHe2jhlt4Umm5ekXh98XI58zmIme1i
         E69YQ+S3ZiDIlDlPCsAafljLVIJ498BEkSj8B6vYBlA5XZ5yYfCBMrAMPv2omv00a40+
         Idqj46rBFseHKO46s/zXjyTxcv4v5PNgP9phhNq4MN+gOwKS9lbol79pSZ7SOGMAAoke
         ALjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8JFIK/fvNqDmX4Q3vEfnZadxvVhFeB1bH+XL9LjdH2g=;
        b=Y1FnjaPuHW8WY4ZJaodslM8YwCgmJFKqdKfPCgF6Z/DoaSv+9kEi/EOy2yNs9Ydhgl
         s5nXh3WwhGBsLdkgpEzBBFTrJ+2T6CIQS77x0hDb+98KsR/czH/JvTQwnSIrai30tncS
         mEPg41ouJd8tacL/UTblffPCAEjfO8hrHzFXszrVmDIKBM12NYNwDmlv+Pma5Bxm9DwA
         GahkVrKV4m5DiwDSqp4S8gkTD+LnP83MQ5XzYpgKxFGynFqjdL87BqEdTk8ctQSYe4sb
         5k24rLKwndCNGzLcLXstAQAempJ/LfbiO2H5nwOH/4XOCXshTOiunQL5kiVyaJMqC62C
         kefA==
X-Gm-Message-State: AOAM533sr6N7/8jgl+xiwZBh++BqGsdTQe74MPXvw1PZX9ivI7ZQH6Os
        e+BZA3kTylDrwPOzRLaFg39hzkCuhwk=
X-Google-Smtp-Source: ABdhPJytcXw77808nVZxPVdrDSq9msFiuevCb3gb4qdorkLJWJfb6g+CmwV50wsoihVGjbtD/rrZrA==
X-Received: by 2002:a1c:68c5:: with SMTP id d188mr4030993wmc.64.1611320647815;
        Fri, 22 Jan 2021 05:04:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u205sm11179966wme.42.2021.01.22.05.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 05:04:07 -0800 (PST)
Message-Id: <8832ce84623e9c74a88b14a05b1c303ed8aa809b.1611320640.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.839.v2.git.1611320639.gitgitgadget@gmail.com>
References: <pull.839.git.1611161639.gitgitgadget@gmail.com>
        <pull.839.v2.git.1611320639.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Jan 2021 13:03:58 +0000
Subject: [PATCH v2 7/8] test-lib: test_region looks for trace2 regions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <stolee@gmail.com>,
        gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>,
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
this check already, so use the helper function instead. Note that this
changes the expectations slightly. The old test (incorrectly) used two
patterns for the 'grep' invocation, but this performs an OR of the
patterns, not an AND. This means that as long as one region_enter event
was logged, the test would succeed, even if it was not due to the
progress category.

More uses will be added in a later change.

t6423-merge-rename-directories.sh also greps for region_enter lines, but
it verifies the number of such lines, which is not the same as an
existence check.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t0500-progress-display.sh |  3 +--
 t/test-lib-functions.sh     | 40 +++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
index 1ed1df351cb..84cce345e7d 100755
--- a/t/t0500-progress-display.sh
+++ b/t/t0500-progress-display.sh
@@ -303,8 +303,7 @@ test_expect_success 'progress generates traces' '
 		"Working hard" <in 2>stderr &&
 
 	# t0212/parse_events.perl intentionally omits regions and data.
-	grep -e "region_enter" -e "\"category\":\"progress\"" trace.event &&
-	grep -e "region_leave" -e "\"category\":\"progress\"" trace.event &&
+	test_region progress "Working hard" trace.event &&
 	grep "\"key\":\"total_objects\",\"value\":\"40\"" trace.event &&
 	grep "\"key\":\"total_bytes\",\"value\":\"409600\"" trace.event
 '
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 999982fe4a9..1170f7108ac 100644
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
+	grep -e "\"region_enter\".*\"category\":\"$1\",\"label\":\"$2\"" "$3"
+	exitcode=$?
+
+	if test $exitcode != $expect_exit
+	then
+		return 1
+	fi
+
+	grep -e "\"region_leave\".*\"category\":\"$1\",\"label\":\"$2\"" "$3"
+	exitcode=$?
+
+	if test $exitcode != $expect_exit
+	then
+		return 1
+	fi
+}
-- 
gitgitgadget

