Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223DAC433EF
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 08:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353630AbhKYIoo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 03:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353370AbhKYImk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 03:42:40 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4B8C0613D7
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 00:39:26 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id j3so9940907wrp.1
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 00:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JsrOSNc7nQWW8eYxfSa7bNB/249vTV4VJg/WfpGDcBQ=;
        b=CcwvBo3M8F3CmpGYfvSce12ACBnJUWbgDNWGq+5mU/vJgL37KBtNRqScDbpeEcByll
         aSORt9J59TPKvlEQ5G1lnqEXA+wA3SWzTUzZheOQIVpMUaVjnlQkcX6zqNwoDlad+V5U
         kArDDBlsCE/SdbwZ06qTzyippWwlnHwiegHSCQ67Dmk7otxx3rX13FhCmSO7gvOnGajM
         95KhvChXgPolEB1RvhfDyoIZPDc51hQusEW/gO7QpofyEYLWi2MD5HoBsGVonwn25TtI
         wBYFs/7NIEiGmv/JrSBTHXSRjZdBG9mNsANcrTX6knY+owbaLAHXYe2y5AtLWYkpyNQm
         N3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JsrOSNc7nQWW8eYxfSa7bNB/249vTV4VJg/WfpGDcBQ=;
        b=mgLiMVdNRxX46KOGFkvistv38FeflaA8GfSb5EeM2Nq69kCigY5B1p2zuNTEVSVvKw
         34Jm+SEcB3+6eoSpQXbCPHPC/UddxD43EPed54HH8rt2e6oSYlU5M6u8/Z5OcG4+cwxg
         BZaSOYJfqLEpIuTFE0dPO4WH2XqZ5QwWm0yXpoM3Z1TZp4aRIgPgPd9lSZ+ZU9/ha/ea
         GhVv9QWKcHy8KJlfQz4S4dbIwWsKGarYDoX0baeM6mQGAkUOTdY0VUtuJkxgu+2TqbvN
         9DK6kfGCuiXbGRnd+h2A5jDt0dLFB7Ga/FpFyFJ51pjDFo96ErUzNy3GQv81ClLv+Jqn
         p8CQ==
X-Gm-Message-State: AOAM531ShsiBzKlbfyc6C0N1rknCm+7tXomdPSi80W+wgTTsd9yuX7TK
        OXiOWR/MrtZKyE5bqs50cPONfRCwrTk=
X-Google-Smtp-Source: ABdhPJxQtBd7IyjOWIo/siRPXY9pwFcbgzR81+HAEAb+X1ZB/iXRtd2eYa+HttKrHSvsrqV9Oc/DHg==
X-Received: by 2002:adf:c406:: with SMTP id v6mr4625991wrf.570.1637829564420;
        Thu, 25 Nov 2021 00:39:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x1sm2179277wru.40.2021.11.25.00.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 00:39:22 -0800 (PST)
Message-Id: <46728f74ea175a33ef592319893ed32146229b33.1637829556.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
        <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 25 Nov 2021 08:39:12 +0000
Subject: [PATCH v2 5/9] symlinks: do not include startup_info->original_cwd in
 dir removal
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

symlinks has a pair of schedule_dir_for_removal() and
remove_scheduled_dirs() functions that ensure that directories made
empty by removing other files also themselves get removed.  However, we
want to exclude startup_info->original_cwd and leave it around.  This
avoids the user getting confused by subsequent git commands (and non-git
commands) that would otherwise report confusing messages about being
unable to read the current working directory.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 symlinks.c           |  8 +++++++-
 t/t2501-cwd-empty.sh | 12 ++++++------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/symlinks.c b/symlinks.c
index 5232d02020c..c667baa949b 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -279,7 +279,9 @@ static void do_remove_scheduled_dirs(int new_len)
 {
 	while (removal.len > new_len) {
 		removal.buf[removal.len] = '\0';
-		if (rmdir(removal.buf))
+		if ((startup_info->original_cwd &&
+		     !strcmp(removal.buf, startup_info->original_cwd)) ||
+		    rmdir(removal.buf))
 			break;
 		do {
 			removal.len--;
@@ -293,6 +295,10 @@ void schedule_dir_for_removal(const char *name, int len)
 {
 	int match_len, last_slash, i, previous_slash;
 
+	if (startup_info->original_cwd &&
+	    !strcmp(name, startup_info->original_cwd))
+		return;	/* Do not remove the current working directory */
+
 	match_len = last_slash = i =
 		longest_path_match(name, len, removal.buf, removal.len,
 				   &previous_slash);
diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
index 526d8ec2ee3..b92e1a9bb16 100755
--- a/t/t2501-cwd-empty.sh
+++ b/t/t2501-cwd-empty.sh
@@ -24,7 +24,7 @@ test_expect_success setup '
 	git commit -m dirORfile
 '
 
-test_expect_failure 'checkout does not clean cwd incidentally' '
+test_expect_success 'checkout does not clean cwd incidentally' '
 	git checkout foo/bar/baz &&
 	test_path_is_dir foo/bar &&
 
@@ -53,7 +53,7 @@ test_expect_success 'checkout fails if cwd needs to be removed' '
 	test_path_is_dir dirORfile
 '
 
-test_expect_failure 'reset --hard does not clean cwd incidentally' '
+test_expect_success 'reset --hard does not clean cwd incidentally' '
 	git checkout foo/bar/baz &&
 	test_path_is_dir foo/bar &&
 
@@ -82,7 +82,7 @@ test_expect_success 'reset --hard fails if cwd needs to be removed' '
 	test_path_is_dir dirORfile
 '
 
-test_expect_failure 'merge does not remove cwd incidentally' '
+test_expect_success 'merge does not remove cwd incidentally' '
 	git checkout foo/bar/baz &&
 	test_when_finished "git clean -fdx" &&
 
@@ -109,7 +109,7 @@ test_expect_success 'merge fails if cwd needs to be removed' '
 	test_path_is_dir dirORfile
 '
 
-test_expect_failure 'cherry-pick does not remove cwd incidentally' '
+test_expect_success 'cherry-pick does not remove cwd incidentally' '
 	git checkout foo/bar/baz &&
 	test_when_finished "git clean -fdx" &&
 
@@ -136,7 +136,7 @@ test_expect_success 'cherry-pick fails if cwd needs to be removed' '
 	test_path_is_dir dirORfile
 '
 
-test_expect_failure 'rebase does not remove cwd incidentally' '
+test_expect_success 'rebase does not remove cwd incidentally' '
 	git checkout foo/bar/baz &&
 	test_when_finished "git clean -fdx" &&
 
@@ -163,7 +163,7 @@ test_expect_success 'rebase fails if cwd needs to be removed' '
 	test_path_is_dir dirORfile
 '
 
-test_expect_failure 'revert does not remove cwd incidentally' '
+test_expect_success 'revert does not remove cwd incidentally' '
 	git checkout foo/bar/baz &&
 	test_when_finished "git clean -fdx" &&
 
-- 
gitgitgadget

