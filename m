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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2484AC433DB
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 05:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDC9F64F9F
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 05:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhBEFuA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 00:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhBEFt7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 00:49:59 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C375FC0613D6
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 21:49:19 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e62so5839332yba.5
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 21:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=KRvy67m6PuUIJjvCMVNkcFis/07uxtwphggk4k+gGik=;
        b=nBwfeNMLlz/Cj9vuajeo6UQ2MDv8tDfZCH/cFnLNHorPAMkHOb/x3I6TbUHEYhzSNT
         FOMw/+vvQ5f6SwcH9OnYi7iU0PKVrM1/L3Qxqetb1qvzcOlHfxw27fOfUmp3Ja/6ddbc
         OCgOk0e3YbMj03QFj9R5FIFMHUzIQ/S0Qo4gZonZmu1EdPBZ+gjTrv/jiG+F7n8vBzsb
         XftcBWq9pWzpOrKcb89IiHbW1uFLMOZqKeZ86zTsrocBPGqppvzTOA4q1/bs42WqyVfn
         TV7yfTfXDXjtnQfCHzRkr3tRgv8QIyXqNEDrOxTTOXe4Is3SJdXM58By0Qj+kkGX/h28
         JNPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=KRvy67m6PuUIJjvCMVNkcFis/07uxtwphggk4k+gGik=;
        b=VPEXR9ajH5zk40kfSEe1WRPeetGveJJXk7jlWmdske5OPyaEt/paeWRNalvurlMUiS
         mwQPBGhsblIx/DFYbPCpFig/JSx3dUtIN8ps5BP02KdPP8BvjlaITAXYHB0dOjZbwWRl
         ZQT8zujB73RxqbZz17xVRmhCmLgPWRnZ+2hIQWprBcDjjNu1n2rhYL3miuIYAbzC70vE
         9oXWVFEWYjdXkSpa42S2J43pmY4EmI9p3e06jIWQSIvoMc0Wrrz1FZZ5M2gNgQQjkelV
         w215pCQGsetNbDvv8vws6I3CFdPAMaC85E2/zo7PTdpR4w0pqAnTg5v+h43C4sM5mbza
         GBhA==
X-Gm-Message-State: AOAM531+4ncdbH3yTPNl8O8GzipcdcraAi6Nqq2AUBGREbVg/g6pqwHR
        vJ5AhAwPHOXl+ZW8Kt/3G2WkQlGAANMhXJEmE3HyZ9TqYQR7JKiZRDvyTeIXCXC398JLq5KyhiK
        S4O6Z9y1POMpY6UPl++xRUpgRQ/AIdLvQbrOHa6GzBi4YREUsrEtpCZQDReWlsgo60p829T10oP
        Pe
X-Google-Smtp-Source: ABdhPJy9BRthaMXH0GLGJ53azpo1J1GfqqfrVVhZG1IlyLuHiBFXvvAp5VFirZ3/J0TvOmcf75+wxIpg7KBdjabAw5tn
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:aba1:: with SMTP id
 v30mr4090362ybi.318.1612504158885; Thu, 04 Feb 2021 21:49:18 -0800 (PST)
Date:   Thu,  4 Feb 2021 21:49:14 -0800
Message-Id: <20210205054914.104640-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH] usage: trace2 BUG() invocations
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

die() messages are traced in trace2, but BUG() messages are not. Anyone
tracking die() messages would have even more reason to track BUG().
Therefore, write to trace2 when BUG() is invoked.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
This was noticed when we observed at $DAYJOB that a certain BUG()
invocation [1] wasn't written to traces.

[1] https://lore.kernel.org/git/YBn3fxFe978Up5Ly@google.com/
---
 t/helper/test-trace2.c   |  9 +++++++++
 t/t0210-trace2-normal.sh | 19 +++++++++++++++++++
 usage.c                  |  6 ++++++
 3 files changed, 34 insertions(+)

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
index 1868a24f7a..16272c5348 100644
--- a/usage.c
+++ b/usage.c
@@ -273,6 +273,12 @@ static NORETURN void BUG_vfl(const char *file, int line, const char *fmt, va_lis
 	else
 		snprintf(prefix, sizeof(prefix), "BUG: ");
 
+	/*
+	 * We call this trace2 function first and expect it to va_copy 'params'
+	 * before using it (because an 'ap' can only be walked once).
+	 */
+	trace2_cmd_error_va(fmt, params);
+
 	vreportf(prefix, fmt, params);
 	if (BUG_exit_code)
 		exit(BUG_exit_code);
-- 
2.30.0.365.g02bc693789-goog

