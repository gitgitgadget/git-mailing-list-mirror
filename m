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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4609DC433DB
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 20:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E51AF22DBF
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 20:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbhAWUA1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 15:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbhAWT7w (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 14:59:52 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCB0C0617A7
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 11:58:29 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id a9so8362668wrt.5
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 11:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=K0JqViei2fw4QavZNgFk2sBZuOssyj5IlQ9XTxSxVVY=;
        b=SFFDR3WzDI2SvZE75DHQIwbxmeHwF6KKJ/nqGW/Eo+NhNyTHeSXScbbNuE/3ubibux
         82FyU3ZX8MnFMy5Ld3geVxazs1nRS5K7KaAx+pjtrCD/EBUiJd+Tn8RUBFBl25Vav/cA
         RCDKeXpFkOJYYM98Xik8bP1c/dmDCetPA1DWrEDFq5MTrWwuXAI0ypsOshQQpYcFp141
         J2lDJ0SDVMaXcwSJr8OujoslcXgEip8fPJGpFX5WWoI2pQ12rD34TxGNDTp0JPAjzU+j
         rCT3kynN/mtmm9NF2bZPuLrpTV8kkWTsEPJl7Utsw7iYtFYi92/vJKvEbkKlqpg9iuq/
         cY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=K0JqViei2fw4QavZNgFk2sBZuOssyj5IlQ9XTxSxVVY=;
        b=cxCLM5Auyzlyrsjgvtaeiq9N79Fadn1WaGaPCZt1knxO7ecLVWaWMl9lNUzqf+1cLM
         vZx5LTv5wCDuj1NnUk4vmGkDPbqiwuIC6zwqht/PbpVimo5CL855BZuZJzkoFbM9tZ3g
         WwxHeDnHiVL5nuy5AIncsRmPaPo5qVs91XKVy2K49EMgvmCJ8oJe6EhhE0rDZQLCUuRo
         vHxllo7lUmqnSmPYYL97Rgl1iMJ0HgZuyenOAsBe/i9TxnQWlkNkuYDXfnBB3DJZ630t
         Cjh51LAFjhmSSEKVMen6f6GHOmWR0aHo+nP1J4nG1VZVWl6KnXTnuvvIirSkxl6pU9rY
         2B/Q==
X-Gm-Message-State: AOAM5338B0RVp7xHrsiZ15wkBWa1LHEjktXUykUhJ0gfHSAaLjuBFVh1
        Ega4cl155BIFHHszqEJKdCuSLgmk4BY=
X-Google-Smtp-Source: ABdhPJx/XLPKmqDDdKv2CJaYiJSGzU8DaI29FNHWHbKeE3BrDNevsARgGaDkVe2ERXhvcuQ3hQOCSw==
X-Received: by 2002:adf:f6c9:: with SMTP id y9mr10433304wrp.121.1611431907905;
        Sat, 23 Jan 2021 11:58:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u6sm11077731wro.75.2021.01.23.11.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 11:58:27 -0800 (PST)
Message-Id: <b37181bdec43cfc798740f2bdd19f6d2482beb26.1611431900.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.839.v3.git.1611431899.gitgitgadget@gmail.com>
References: <pull.839.v2.git.1611320639.gitgitgadget@gmail.com>
        <pull.839.v3.git.1611431899.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 23 Jan 2021 19:58:18 +0000
Subject: [PATCH v3 8/9] test-lib: test_region looks for trace2 regions
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
 t/test-lib-functions.sh     | 42 +++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 2 deletions(-)

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
index 999982fe4a9..3f425deba18 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1655,3 +1655,45 @@ test_subcommand () {
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
+	grep -e	'"region_enter".*"category":"'"$1"'","label":"'"$2"\" "$3"
+	exitcode=$?
+
+	if test $exitcode != $expect_exit = 1]
+	then
+		return 1
+	fi
+
+	grep -e	'"region_leave".*"category":"'"$1"'","label":"'"$2"\" "$3"
+	exitcode=$?
+
+	if test $exitcode != $expect_exit = 1]
+	then
+		return 1
+	fi
+
+	return 0
+}
-- 
gitgitgadget

