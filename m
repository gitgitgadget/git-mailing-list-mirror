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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EF3C433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 09:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51B2B611BF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 09:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbhIIJsW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 05:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbhIIJsV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 05:48:21 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AF4C061575
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 02:47:12 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso976192wmb.2
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 02:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZkrfvFvHxoHMDOBTZSzqjARUmPAkGSl77AqRw+h74Qo=;
        b=AOh4t4IpFJ9s8SohFSV+55tRJLGfS40YVm7US6dPQCuq5KcDrQmXwJRCUyg7oKelgP
         RJY6EqCvVLF3k40wVj3QkPKPaGiFrvly5ssG8AFdcMSFfuKf5PTADLUwC3TKX1M7kRAV
         rtE4V9WkUAj95j0EF+qYwpQML31XF+TEvxtBeY+b79fbSdN8Tbm/tnoEzujZRpyJpVzg
         88b/VM2mWIBCScVlbnwBFh/Po4mPSScqthKe+SQR3IGeFpNJQhiVETx/adoCvtXogKk/
         u6FJoBdZkiS7nSDjmQikgpVCSoYXH9ja/rpkb01QRO57QZ8+B+OUdbnjOKPY9PsvZfHC
         ONyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZkrfvFvHxoHMDOBTZSzqjARUmPAkGSl77AqRw+h74Qo=;
        b=rAo5X6q6ZIyFxSD5ZVL1dcVX5VRf9d2hIOUbz9qkvJTIxmjaXEHEwosV0MOIvvzY+I
         mt9ETr/Sw/OdHbm0JnAE4TZ1PxrHRv85H3h3A76WBH/DuhDg8K979Mykn6Gf8CgJRJcd
         InRLz/ZXxCzKeEX+FaE8XZBMxY4bnK6C6VboPrSIX94d/NeDae6jQy3WeV6U6ETrModU
         sSCE1mL0NDgiyCAb+A33/ha/HAUb9ag6zUXTEUysSB/DuTZklQDgdWGPZTuRXX7OFmLK
         8mxEqgsOO96QCiHlWoR0tLc/rM+igdukm8uYi3daoXDv5mUL6SMj/R1Xo7TFurQEaa4O
         aHFg==
X-Gm-Message-State: AOAM532iSF79BQj0u8FPB3QZpWbeIS0XyIRYGe8XHgmngOGObCuQFlQx
        POyM43WO5HRzD127nJByq2fTfCtTvSg=
X-Google-Smtp-Source: ABdhPJxrpEGqIxtPCrq5htIibLi1K5hWQOpTKqm5HQ485k5lyMPk7RPM7Dt0nir0tXOOx1gqV3BVbA==
X-Received: by 2002:a1c:1fc2:: with SMTP id f185mr2014640wmf.22.1631180831190;
        Thu, 09 Sep 2021 02:47:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g1sm1334367wrc.65.2021.09.09.02.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 02:47:10 -0700 (PDT)
Message-Id: <75f39fc80f46455a93f312cce2e989711c748f8a.1631180828.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1035.git.1631180828.gitgitgadget@gmail.com>
References: <pull.1035.git.1631180828.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Sep 2021 09:47:05 +0000
Subject: [PATCH 1/4] run-command: prettify the `RUN_COMMAND_*` flags
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The values were listed unaligned, and with powers of two spelled out in
decimal. The list is easier to parse for human readers if the numbers
are aligned and spelled out as powers of two (using the bit-shift
operator `<<`).

While at it, remove a code comment that was unclear at best, and
confusing at worst.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 run-command.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/run-command.h b/run-command.h
index af1296769f9..3893193f32f 100644
--- a/run-command.h
+++ b/run-command.h
@@ -233,13 +233,13 @@ int run_hook_ve(const char *const *env, const char *name, va_list args);
  */
 int run_auto_maintenance(int quiet);
 
-#define RUN_COMMAND_NO_STDIN 1
-#define RUN_GIT_CMD	     2	/*If this is to be git sub-command */
-#define RUN_COMMAND_STDOUT_TO_STDERR 4
-#define RUN_SILENT_EXEC_FAILURE 8
-#define RUN_USING_SHELL 16
-#define RUN_CLEAN_ON_EXIT 32
-#define RUN_WAIT_AFTER_CLEAN 64
+#define RUN_COMMAND_NO_STDIN		(1<<0)
+#define RUN_GIT_CMD			(1<<1)
+#define RUN_COMMAND_STDOUT_TO_STDERR	(1<<2)
+#define RUN_SILENT_EXEC_FAILURE		(1<<3)
+#define RUN_USING_SHELL			(1<<4)
+#define RUN_CLEAN_ON_EXIT		(1<<5)
+#define RUN_WAIT_AFTER_CLEAN		(1<<6)
 
 /**
  * Convenience functions that encapsulate a sequence of
-- 
gitgitgadget

