Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8470C4320A
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 09:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC7EE61057
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 09:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244971AbhIBJGV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 05:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244796AbhIBJGS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 05:06:18 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA75C061757
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 02:05:20 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id b10so1777818wru.0
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 02:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ff1IbLdcvpD6MhimWYyxaTfLrj9k2S7N5XzYOYFduTA=;
        b=X6L+Xh5T5etPrZMSAbXMCEDfa00lEfA8CKb3DJJ8ajO6cBUAzZ7SeMRGcMWmNNg4sI
         rRgA2QsYBzmUlZxxQr7hqyAh6x2aFwt+lOmC3cmGncI00oaE8h/C/WjGXcBoWPpYsYEu
         hfxvVF/FcRBmZ9lNyLlF9rRvwFLY1PB50+4Fk46BG8wEils7/Yoon9Ni8dWZRiteH1YL
         3p5D3hakd2+dQhjsF10g3HK2dWBIp1JlyeotNlNrjSdfY/vJ7HYURbi92ULE01B9VJ5O
         EFFgdUr4SkManqLNl0gWq9Me0rqJzQXxddqFXPJduY4/gv2p9lf82wNdTd+meeuJT9P+
         Muqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ff1IbLdcvpD6MhimWYyxaTfLrj9k2S7N5XzYOYFduTA=;
        b=DxacWnQZVfWXkNO4vmW7GUaqzt83bwDj3A5GBibXIyFeBCw6WFbZcPCGR56p2OXZiH
         hZVdbNO+7zUt8AWckHVw6LnVPMSqN++zuJYCHM2dcjUdWaXBKC+E2R/zV67xJIKPzT0d
         kj/Q86y83X8Xt6kr7wN0KiTUCbElUBsd4IizzX+58s5P3hqVenxxWwDS0gXXxTYfysks
         roT0oCO0I2raAedvzeFU52WR4rGe2Uvqosf65PnsYATydH/U9nxKn6QA9EcNjNvaRGUh
         CFqVT/dTiLHjua1cjXxU1i7Ow2a2+wlqXSVxNrsi5ObTIYZpgbOXM53+19SecUin5TXe
         6x+g==
X-Gm-Message-State: AOAM531i3KR04Gy6Z/lwmV9iL9gTrVkm4eiVl9pyz/+WqF5+qsc1SHSO
        GgFV/LoT1qpGRllow01JpfJko9WhF7A=
X-Google-Smtp-Source: ABdhPJzcStu5quGNtQTWBZWFC1cJ/mGvZmF/GauaVZKi7b2wlrC43YCKBpGMFKDwp/xjFCZYV3//wg==
X-Received: by 2002:a5d:470b:: with SMTP id y11mr2380257wrq.213.1630573519411;
        Thu, 02 Sep 2021 02:05:19 -0700 (PDT)
Received: from localhost.localdomain ([178.237.237.111])
        by smtp.gmail.com with ESMTPSA id l17sm1262516wrz.35.2021.09.02.02.05.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Sep 2021 02:05:19 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v6 3/6] run-command: make `exists_in_PATH()` non-static
Date:   Thu,  2 Sep 2021 11:04:18 +0200
Message-Id: <20210902090421.93113-4-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210902090421.93113-1-mirucam@gmail.com>
References: <20210902090421.93113-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

Removes the `static` keyword from `exists_in_PATH()` function
and declares the function in `run-command.h` file.
The function will be used in bisect_visualize() in a later
commit.

Mentored by: Christian Couder <chriscool@tuxfamily.org>
Mentored by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 run-command.c |  2 +-
 run-command.h | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index f72e72cce7..390f46819f 100644
--- a/run-command.c
+++ b/run-command.c
@@ -210,7 +210,7 @@ static char *locate_in_PATH(const char *file)
 	return NULL;
 }
 
-static int exists_in_PATH(const char *file)
+int exists_in_PATH(const char *file)
 {
 	char *r = locate_in_PATH(file);
 	int found = r != NULL;
diff --git a/run-command.h b/run-command.h
index af1296769f..54d74b706f 100644
--- a/run-command.h
+++ b/run-command.h
@@ -182,6 +182,18 @@ void child_process_clear(struct child_process *);
 
 int is_executable(const char *name);
 
+/**
+ * Search if a $PATH for a command exists.  This emulates the path search that
+ * execvp would perform, without actually executing the command so it
+ * can be used before fork() to prepare to run a command using
+ * execve() or after execvp() to diagnose why it failed.
+ *
+ * The caller should ensure that file contains no directory separators.
+ *
+ * Returns 1 if it is found in $PATH or 0 if the command could not be found.
+ */
+int exists_in_PATH(const char *file);
+
 /**
  * Start a sub-process. Takes a pointer to a `struct child_process`
  * that specifies the details and returns pipe FDs (if requested).
-- 
2.29.2

