Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738ABC4332F
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 11:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240940AbiA0L4q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 06:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240910AbiA0L4l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 06:56:41 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392B4C061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 03:56:41 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id l25so4239213wrb.13
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 03:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xSDkcdMhbJ4Nq7eYpVzw3GX1xhJqUVatHn7BVTBFev4=;
        b=LI+NtVAplFlvuliNofveIMD0cqtKMFdoMjGxM7/3oyPujZvwbdUKSMDvJFoHdda1PS
         xBSqUWD+jHQhmwDpcp+yyqLTfCkk71qH3MYfD6tC9WDCsuOaO6B2N9QY6L2ZeY0G+eHN
         JFpw7I1M3Ibl2BsjD0EmnMbi4/HGhEmG9l6nNHttIc2DCnAoxIeIrKfq5lXExAdwl8oW
         fsNzCAHaAPgL65rihud1PB4ewvJJ1dSlSa1F3Y0+L82n+9aiOLfOSFFji+2JOnW97Z5K
         +ar1vRsAoX2+3YawQLPbx+RdNVvLd44yQr1WU5uuAQEAVI9boCfqRVjRBmyP7Nld8gvf
         WRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xSDkcdMhbJ4Nq7eYpVzw3GX1xhJqUVatHn7BVTBFev4=;
        b=QO0aVIAT7P/2PMbsF5irZ7xa+GIYPYSA75l5oEI8LDlw62Y/XKD4Ru4ss0P6p595q4
         Cvx4fGXqFXcBdAtakyrIUSNg0SyToAt8nnnd3e+72e/2xGMspdtFNt2qCugBH0E1bQfV
         xcU6+Tvj8M5c/W6IQcWvxKA1C2ewjBs/YUjQ6Kv3GpqKc+lNtypf+jswJsymm9XGSHQB
         Md5uvnDrEaLmYs+pDVrSt1yW1DjNq4aysl+9ae4B2MDE6HVkZFKwfOUckv1EC2DCUgGi
         s/otvAXxhW3gt1gy7A2+Tx1IFd2Q85oDlgzpNnO4Yx5vbKl/ePi0pJqsLCHmCsVXsvYI
         df1Q==
X-Gm-Message-State: AOAM531L8DS1mGplXVG6wxB2oYaEw2q5DDpMjW2yE2gUFbYF3Dp7VhbW
        IkGx6D4erxyeHu+XlSOYfyULV4k0Dl8mkA==
X-Google-Smtp-Source: ABdhPJzNRlgl0MjeIq/YgCDGrax901P7R4WMi6hIMryxbEro71brymPMxaWUNvdjf0Steyd6a/Nbvw==
X-Received: by 2002:a5d:6381:: with SMTP id p1mr2692510wru.549.1643284599634;
        Thu, 27 Jan 2022 03:56:39 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i94sm1910663wri.21.2022.01.27.03.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 03:56:38 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 5/9] grep.c: don't pass along NULL callback value
Date:   Thu, 27 Jan 2022 12:56:27 +0100
Message-Id: <patch-v9-5.9-fbcfea84696-20220127T115058Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.894.g563b84683b9
In-Reply-To: <cover-v9-0.9-00000000000-20220127T115058Z-avarab@gmail.com>
References: <cover-v8-00.10-00000000000-20220118T155211Z-avarab@gmail.com> <cover-v9-0.9-00000000000-20220127T115058Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change grep_cmd_config() to stop passing around the always-NULL "cb"
value. When this code was added in 7e8f59d577e (grep: color patterns
in output, 2009-03-07) it was non-NULL, but when that changed in
15fabd1bbd4 (builtin/grep.c: make configuration callback more
reusable, 2012-10-09) this code was left behind.

In a subsequent change I'll start using the "cb" value, this will make
it clear which functions we call need it, and which don't.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/grep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index d85cbabea67..5ec4cecae45 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -285,8 +285,8 @@ static int wait_all(void)
 
 static int grep_cmd_config(const char *var, const char *value, void *cb)
 {
-	int st = grep_config(var, value, cb);
-	if (git_color_default_config(var, value, cb) < 0)
+	int st = grep_config(var, value, NULL);
+	if (git_color_default_config(var, value, NULL) < 0)
 		st = -1;
 
 	if (!strcmp(var, "grep.threads")) {
-- 
2.35.0.894.g563b84683b9

