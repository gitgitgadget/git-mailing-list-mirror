Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E384CC433DB
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 20:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F89A64FBB
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 20:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbhBES2D (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 13:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbhBES12 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 13:27:28 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD63C06174A
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 12:09:12 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id y8so5037830plg.5
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 12:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=vGYYnPoEojSG5uquJsJ0BxYbISLULa9+gJdeAFFbwX8=;
        b=jgE0spBNmHvzrSQCQMBvX1Mi6xwY2tGgcMhQl5u1q9VN633z6jVFETZKh38DwbuvAS
         1IzRVmS7nkhGQ7DHY5OKyFXem9WTcX2xGCbmOUp9ysqM1kYYjMRg7NwlzDUMu6Ak6Sf3
         HBOZrdMBQWw3dlYom3maiY7PHlU6bVR4EH29dwaOtLSa16Q114Fd+RCrxg7cZIP4u/Ua
         xIg4PaXkr6mAnhetW7UzLP9epF46cWO/jOWaraR3jqAC1WMaTT9ftcAZ0L1zK6ED57/N
         0eXucm69LlSHfrUq5ip7Az0vRVIX8q//vX/KLuFlg0eH52/ouUiqjTeP17Bj5AtL3o5m
         kJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vGYYnPoEojSG5uquJsJ0BxYbISLULa9+gJdeAFFbwX8=;
        b=YdkYbahGFvP1b0grO0uc94S/KuJr0GnR9zHbT/ipZJTm1JP2NssI5tOOGTcpYW2DrI
         nS2jhGMGkiLQElfwcJY6XOeKxhpLOn8px6eBuM6rucn3hlpt/aen/85z5hhMAlpVY0RI
         4NSzS2bpLjDdLZEa9ieS6lg1lA7HcYP1Z18KdsTuGgAAgFcOhScrkO5UDUJDYHi0QvRK
         CdsRa4MHoZsxiCqSUkm/v+kyVhyTjatHhz+5NGdd1CbVy2hG+9Ob0P4QSCbMa/H1dBfK
         Lt0vNFdj8Tf6f7iOnlbltLERKs/LX0EHsNSppamAKKLY2rsgh39NyuoCwjJygltBh3pY
         yVGA==
X-Gm-Message-State: AOAM5337nAv8PQocVT5jK7g9JZis4LPoGDbuzeJwK9njzPHUAFamdn0K
        s+QxxHALowIIUdDNIg/AD3oSo7wmrnsX6M1hhNBeogYeRCcVgFonI77Mu57Al0MxlIU5Dgx3ltn
        +t7SRTsXbFz502FnCrLnvSyYg1l5FNJIPJHSiqWn2V2Km52gjJGtoePbn0zFSPR/NNB+hky/gPR
        2n
X-Google-Smtp-Source: ABdhPJwcNsKa2BT5kiLj2g5MF52geSBQSacckg4RXUeCzKxvoxaZTs2a471plbjrjml1coEyt0kV2JDMtBhOmcwOlWH7
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a63:1865:: with SMTP id
 37mr5935669pgy.206.1612555752006; Fri, 05 Feb 2021 12:09:12 -0800 (PST)
Date:   Fri,  5 Feb 2021 12:09:08 -0800
In-Reply-To: <20210205054914.104640-1-jonathantanmy@google.com>
Message-Id: <20210205200908.805639-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20210205054914.104640-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v2] usage: trace2 BUG() invocations
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        stolee@gmail.com, gitster@pobox.com, jeffhost@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

die() messages are traced in trace2, but BUG() messages are not. Anyone
tracking die() messages would have even more reason to track BUG().
Therefore, write to trace2 when BUG() is invoked.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Thanks everyone for your suggestions. I've used an in_bug static
variable (which does prevent the infinite loop - I injected the bug that
Peff described and verified that it indeed loops without the mitigation
and doesn't loop with the mitigation) and moved the trace2 to be below
the vreportf (necessitating a va_copy).
---
 t/helper/test-trace2.c   |  9 +++++++++
 t/t0210-trace2-normal.sh | 19 +++++++++++++++++++
 usage.c                  | 11 +++++++++++
 3 files changed, 39 insertions(+)

diff --git a/t/helper/test-trace2.c b/t/helper/test-trace2.c
index 823f33ceff..f93633f895 100644
--- a/t/helper/test-trace2.c
+++ b/t/helper/test-trace2.c
@@ -198,6 +198,14 @@ static int ut_006data(int argc, const char **argv)
 	return 0;
 }
 
+static int ut_007bug(int argc, const char **argv)
+{
+	/*
+	 * Exercise BUG() to ensure that the message is printed to trace2.
+	 */
+	BUG("the bug message");
+}
+
 /*
  * Usage:
  *     test-tool trace2 <ut_name_1> <ut_usage_1>
@@ -214,6 +222,7 @@ static struct unit_test ut_table[] = {
 	{ ut_004child,    "004child",  "[<child_command_line>]" },
 	{ ut_005exec,     "005exec",   "<git_command_args>" },
 	{ ut_006data,     "006data",   "[<category> <key> <value>]+" },
+	{ ut_007bug,      "007bug",    "" },
 };
 /* clang-format on */
 
diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
index ce7574edb1..81af180c4c 100755
--- a/t/t0210-trace2-normal.sh
+++ b/t/t0210-trace2-normal.sh
@@ -147,6 +147,25 @@ test_expect_success 'normal stream, error event' '
 	test_cmp expect actual
 '
 
+# Verb 007bug
+#
+# Check that BUG writes to trace2
+
+test_expect_success 'normal stream, exit code 1' '
+	test_when_finished "rm trace.normal actual expect" &&
+	test_must_fail env GIT_TRACE2="$(pwd)/trace.normal" test-tool trace2 007bug &&
+	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
+	cat >expect <<-EOF &&
+		version $V
+		start _EXE_ trace2 007bug
+		cmd_name trace2 (trace2)
+		error the bug message
+		exit elapsed:_TIME_ code:99
+		atexit elapsed:_TIME_ code:99
+	EOF
+	test_cmp expect actual
+'
+
 sane_unset GIT_TRACE2_BRIEF
 
 # Now test without environment variables and get all Trace2 settings
diff --git a/usage.c b/usage.c
index 1868a24f7a..1b206de36d 100644
--- a/usage.c
+++ b/usage.c
@@ -266,6 +266,10 @@ int BUG_exit_code;
 static NORETURN void BUG_vfl(const char *file, int line, const char *fmt, va_list params)
 {
 	char prefix[256];
+	va_list params_copy;
+	static int in_bug;
+
+	va_copy(params_copy, params);
 
 	/* truncation via snprintf is OK here */
 	if (file)
@@ -274,6 +278,13 @@ static NORETURN void BUG_vfl(const char *file, int line, const char *fmt, va_lis
 		snprintf(prefix, sizeof(prefix), "BUG: ");
 
 	vreportf(prefix, fmt, params);
+
+	if (in_bug)
+		abort();
+	in_bug = 1;
+
+	trace2_cmd_error_va(fmt, params_copy);
+
 	if (BUG_exit_code)
 		exit(BUG_exit_code);
 	abort();
-- 
2.30.0.365.g02bc693789-goog

