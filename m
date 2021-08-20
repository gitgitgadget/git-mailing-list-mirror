Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B20C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 17:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 719B76115A
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 17:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbhHTRXn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 13:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbhHTRXk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 13:23:40 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A2DC061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 10:23:02 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r7so15357692wrs.0
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 10:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ff1IbLdcvpD6MhimWYyxaTfLrj9k2S7N5XzYOYFduTA=;
        b=BUGcktnaiAOkd7mdLe2/K9U/I3Ugu0+fbQU8Yuyp7sqmujKbvYsAzhGESHeohzrXxs
         QiHHrxnP++l7a8hvj4G6ZjqS36FfTikyaWTAdPdwWFZCAyf8kEA9lld5NgqjE50CjWGU
         27hU3oRUxhliykDh75IjFJED0Gx6yaEEf4Bacl4oanwRuRnL+aURaRqzlucQQv32XR4s
         VSN2JCFfGooWBfdVGCj0xov6VpA6QXlxBsD9m+f/HoUF6JI/iVRZoHP6VSD4F80AqUsk
         +A/0gzxzjbbXfrFQF7PB5aHUizP0lGCyU4OkKW/Ek50X5/iB04yzSt+yktVCIUBsC/Yh
         yuOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ff1IbLdcvpD6MhimWYyxaTfLrj9k2S7N5XzYOYFduTA=;
        b=jsg2vb9f1Nr7AnLpgq4VCQeBeB6Ej35P0DrK328j2CQyYSt3oVsCUSO+UUPOuIU0og
         L4bQlpKI/JPg7DGtnyNrHcv1hcYrnA573T6PQzc84+3INpnd123gjKUYh2mOZ1J/brWh
         rATjpSFM/FK7qW8VKewBHLAyhAnXKmwR428lRsDD7JEwZEVN6MZWiqqmoHaiT3a64yBf
         DwlEv3CPhM0Q+Ioch7Q3Hd36oCgtOaH5eapZv99BPAceh6ueq7/3eGvor+5uRrNDXgGB
         dpuoM8Y5/jEGquskMJhi07ESg03OSXT2hYtZmaHSLU9WGjPD8Tncep9wzGCIFXsCH1JJ
         hVCg==
X-Gm-Message-State: AOAM533cx+r1dHaR6SDc9VisrFHf9l41YEE/JGo77+fTlp5F1AbfMTai
        XXVcnXTJr90VopbBkJk/qGZUthgmHR8=
X-Google-Smtp-Source: ABdhPJyIJYhc1XKZ7k2q73YIoMQPpUhk3aqgnw0tpHjsYeI4lkCL3IWgisuP8qm3RLOAwOFaUoXQHA==
X-Received: by 2002:a5d:44c6:: with SMTP id z6mr9845645wrr.58.1629480180649;
        Fri, 20 Aug 2021 10:23:00 -0700 (PDT)
Received: from localhost.localdomain ([178.237.232.111])
        by smtp.gmail.com with ESMTPSA id x13sm6623278wrq.44.2021.08.20.10.22.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Aug 2021 10:23:00 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v5 3/6] run-command: make `exists_in_PATH()` non-static
Date:   Fri, 20 Aug 2021 19:21:45 +0200
Message-Id: <20210820172148.2249-4-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210820172148.2249-1-mirucam@gmail.com>
References: <20210820172148.2249-1-mirucam@gmail.com>
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

