Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005A2C433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 18:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCF9D60FE3
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 18:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243792AbhJGStY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 14:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243763AbhJGStY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 14:49:24 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0634FC061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 11:47:30 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r10so22027587wra.12
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 11:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sp7uDfxLktpXMx3eAotCUnz9eBhfvnUS4IIF87Vfzmo=;
        b=k9xl8BzoTFHs/hGQb00+BtFo0L2Tjfhzghlzt6naCw287jjfC5nWwrDT0oWGaBDlgP
         ylztrlI5+89rfGDF6MCW+O8MHT8oDR/6JYCA0/9iA1kd7B0Dqnh/qg2MJpYWQemKignw
         yHJ77UUSfxGpsJAy7OB8g07slBiWI8oTla2gv8a+pAblQa9pHYzWZh75uCer9fB0cpAQ
         YXSctpTq/SQBe1tUwHd9fu2Q6lLYqjSbW8qWMjeV8M4FK8ZTprBMY7ggIeNSZLPnMFW1
         13PYsFLeoKB/oCCsAtr5gIqregXtvckip3NaCQ0JNjIP2lymF940fRZvgtpD2j87JiYP
         BXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sp7uDfxLktpXMx3eAotCUnz9eBhfvnUS4IIF87Vfzmo=;
        b=W9JB06CGM8FIbnvH59/cPoFeajA7zv9gFgqHJ8mnXLPwRgl87gdTMaL1QumNh3zg04
         Dc9mZ/ZSd91edofn/oylFscgjsATim0MXIy7ZMfwWn0HTigi973zNjjPpNjoVNTa18Qw
         gwx4Pit2aHrXPbmgF33T9v6mmk5PH+SmRkDEkhAam/PKQmJzuoS2UpkEZNPptz63lAeQ
         eyXXUewZgg4ya6pX687PFtqD15nvhIQSkA+hURcYfAup6S4qtVGtJzeUVNrRpod6m9zW
         Z5ieNgTd8b3/xhS10IQJhLH9R+RpDae/rivI63/gBXSWF+LFpGV4Q9E8EN0uMq7vrj3g
         P5qw==
X-Gm-Message-State: AOAM532Jd2vkpBcLoz8tvOzcjFIAwEPmGQ31tTYScYLxU0vuR5JpUosO
        1okVbLlLkTBpJc56ASFmL1A=
X-Google-Smtp-Source: ABdhPJwVI2c6UXEF8N0QY3WmlkqECboryKQKZXPFfL0536XZ6xOdAoi/r5XAIiqQfjv5Rl8niUW9CA==
X-Received: by 2002:adf:b355:: with SMTP id k21mr7624961wrd.380.1633632448566;
        Thu, 07 Oct 2021 11:47:28 -0700 (PDT)
Received: from localhost.localdomain (91.141.59.93.wireless.dyn.drei.com. [91.141.59.93])
        by smtp.gmail.com with ESMTPSA id r205sm211562wma.3.2021.10.07.11.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 11:47:28 -0700 (PDT)
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     aclopte@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, l.s.r@web.de
Subject: [PATCH] t/perf: do not run tests in user's $SHELL
Date:   Thu,  7 Oct 2021 20:47:16 +0200
Message-Id: <20211007184716.1187677-1-aclopte@gmail.com>
X-Mailer: git-send-email 2.33.0.rc2.dirty
In-Reply-To: <20211002112640.hrn2ojndhoa2dd4c@gmail.com>
References: <20211002112640.hrn2ojndhoa2dd4c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The environment variable $SHELL is usually set to the user's
interactive shell. We never use that shell for build and test scripts
because it might not be a POSIX shell.

Perf tests are run inside $SHELL via a wrapper defined in
t/perf/perf-lib.sh. Use $TEST_SHELL_PATH like elsewhere.

Signed-off-by: Johannes Altmanninger <aclopte@gmail.com>
---

Regarding the inconsistency around $(SHELL) in Makefiles: we could do
something like

	-SHELL_PATH ?= $(SHELL)
	+SHELL_PATH ?= /bin/sh
	+SHELL = $(SHELL_PATH)

in some Makefiles. Though the upside (consistency & slightly easier to build
with broken /bin/sh) seems fairly low, so I'd leave it be.

 t/perf/perf-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index f5ed092ee5..e6b59ecbf7 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -157,7 +157,7 @@ test_run_perf_ () {
 	test_cleanup=:
 	test_export_="test_cleanup"
 	export test_cleanup test_export_
-	"$GTIME" -f "%E %U %S" -o test_time.$i "$SHELL" -c '
+	"$GTIME" -f "%E %U %S" -o test_time.$i "$TEST_SHELL_PATH" -c '
 . '"$TEST_DIRECTORY"/test-lib-functions.sh'
 test_export () {
 	test_export_="$test_export_ $*"
-- 
2.33.0.rc2.dirty

