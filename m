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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7BDC433B4
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 09:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4444611CE
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 09:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbhDKJ43 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 05:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhDKJ42 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 05:56:28 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41EBC061574
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 02:56:12 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id a6so9859299wrw.8
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 02:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sVG2Tb+3jo8G5zdkc8IPV7f/mJRvdz3MdmkDy+VsCMc=;
        b=OLWiN9AoUw02SGY4gepEK2g6aM+o9MPXcb27V4TkqZKR+V2YCCOfXCY7UXY9VFuyjp
         fknWasZbV8v6odxECeWL1jv0DvQ4TBCrRs8aLGnuXmE+DaszQw59EidsJdt7uiOh3TN7
         0ViwCFevmEvUsQ649seVjoJvVLcwAl7QxSQ13Rb0WhiXMC9e42AuXGO8kJfGzBQxq6u+
         AGGtNnxyMt1s8IytNkUSs10ufkC0n/M/KgZiKI3Jotsu6a+p7+D8BmSyijmr3o81QMXw
         wVUOFUV87dlorpJvyAjGZIvjPSWPIj6IcoBt4hpXClLry3TpXPl4ozYKlrLuk59Jsd9y
         zb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sVG2Tb+3jo8G5zdkc8IPV7f/mJRvdz3MdmkDy+VsCMc=;
        b=qMX362pDR9U7bHqtMdG+UN1dmM95h6aOiQPzFxmPJaWqsEgQ3h71sY5NCY++ur80cR
         uBPXrP8ImS/gdmVZSuCuFWa7RnBUrL+bCfpbmnaYVrYZ2mo8eugDAmULONw0gU9+TDVf
         dt9jCmThq5Gd4HrQwZr3iMaOJqHmk3u2X7U432UjOQ5g/Bnp1yisAibOONerP8Vlwd4K
         1twi2VuQdStdBclMIamWQEf9r2fLQ9iAmxRrByl4Wdj4e/8JMh1EqM637woS4NIgcSO5
         sp4vL6wPI8/8KHCFaU/dAszvOQYR4qwi0GJFzekCZ975ygJkxqMGx6MLj9StilkY3Fz2
         qztw==
X-Gm-Message-State: AOAM532kzQVGwPlPMxJPoytJFs8VncVUfWcU7DZib/v9oRWCzz+Xu0g3
        FSqmvP24S8B4yc9ouVfr7qfemMXHQW0=
X-Google-Smtp-Source: ABdhPJw1VSccbF65DhX/DCFIEu5mQptynndcBvUwPk/frTf8N9dkfFMt2AXA2yhoN6IxMVSnozbWVQ==
X-Received: by 2002:a05:6000:251:: with SMTP id m17mr26560464wrz.171.1618134971544;
        Sun, 11 Apr 2021 02:56:11 -0700 (PDT)
Received: from localhost.localdomain ([81.0.37.230])
        by smtp.gmail.com with ESMTPSA id j30sm12994099wrj.62.2021.04.11.02.56.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Apr 2021 02:56:11 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v3 1/4] run-command: make `exists_in_PATH()` non-static
Date:   Sun, 11 Apr 2021 11:55:35 +0200
Message-Id: <20210411095538.34129-2-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210411095538.34129-1-mirucam@gmail.com>
References: <20210411095538.34129-1-mirucam@gmail.com>
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
index be6bc128cd..210b8858f7 100644
--- a/run-command.c
+++ b/run-command.c
@@ -211,7 +211,7 @@ static char *locate_in_PATH(const char *file)
 	return NULL;
 }
 
-static int exists_in_PATH(const char *file)
+int exists_in_PATH(const char *file)
 {
 	char *r = locate_in_PATH(file);
 	int found = r != NULL;
diff --git a/run-command.h b/run-command.h
index d08414a92e..cc6f1bad20 100644
--- a/run-command.h
+++ b/run-command.h
@@ -179,6 +179,18 @@ void child_process_clear(struct child_process *);
 
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

