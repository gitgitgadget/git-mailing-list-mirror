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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F393CC433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 17:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE0D7610CC
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 17:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346663AbhIMRle (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 13:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243422AbhIMRlL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 13:41:11 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822BEC061787
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 10:39:16 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l18-20020a05600c4f1200b002f8cf606262so7631759wmq.1
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 10:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a2irW1fv9RC72W8TrdM2XrhdmNH14LBTJLZt6TJqbm4=;
        b=AihB8xTT+P81dNEheEnXVmKI2eJXcRtldlGYDenhTUA0fGiL80pqKcIOVvvM8MEcZC
         Rte4wgTWnRJLcvMru8CugeFxQbnAIdi4DYxa8sRNqZTnO0O8DKg1rQCxXscqkq0TABW8
         xk9viuyN4IgQ9kYflwEkn9vhzYllSjK55pgfjiVKIc+Lq1T+7DCZibV+lqY+Vjbwh8Fx
         T+6Pkf8ZcCSkHhwusEeNhUCpo8Cs11brTWxP3Lt32DhlOa/6pLdYwEH1njd/PrwL87A7
         ZPNdyJMmvNqpV7R6wwwnfM+MncnsGC0WVH98x1sHsB26S25l2KUTkwizK7A4F1RVlVy6
         6v2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a2irW1fv9RC72W8TrdM2XrhdmNH14LBTJLZt6TJqbm4=;
        b=q7/PBxIwvYQHOt/+gsiCURN9fo2jo63gMX3+QXO5xvoYssnRfd7ae26NW17LJVwvWf
         z0yAwtQpuczqrTXmfzeCC53lQhwc5gp0FVU0ikXFdKaScGk6/6MpD8Mutvrffnp33ZDM
         3B3aIc8uzLrERpJXosBHm+QT8+zRknhlPxDrF6qTWA2/+CdPgdCofiQU42BKoQV6P+Y4
         EPX6P2z9aGHnt+6eM3f4GVaIKXnT1cbGEP+0zNOyikio/nJSvrUBuF4+9kaZd+rit8+A
         Idxmq3juS4dm4hjbsiaZA9+BwLOwg+QJ16Tx1704ustFc5MstWn/rz0g11vLkG+WS9TQ
         cPiQ==
X-Gm-Message-State: AOAM530yM9lEk343AqdOXtfXzXYoVxP0aq5Z9Ire7Rc4nk0I9vb4FlEi
        KLZ8OVFMxdayDPON8RfilxbAsKidBPQ=
X-Google-Smtp-Source: ABdhPJxBreMrjLFkP9K8X998Rg9B2SWchKWlcJGXFLF0d2n9oiAcasZd8NCAByGb7oegJVFM1PNhhQ==
X-Received: by 2002:a05:600c:4ece:: with SMTP id g14mr12191904wmq.6.1631554755136;
        Mon, 13 Sep 2021 10:39:15 -0700 (PDT)
Received: from localhost.localdomain ([81.0.34.57])
        by smtp.gmail.com with ESMTPSA id u25sm4428959wmm.5.2021.09.13.10.39.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Sep 2021 10:39:14 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v7 3/6] run-command: make `exists_in_PATH()` non-static
Date:   Mon, 13 Sep 2021 19:39:01 +0200
Message-Id: <20210913173905.44438-4-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210913173905.44438-1-mirucam@gmail.com>
References: <20210913173905.44438-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

Remove the `static` keyword from `exists_in_PATH()` function
and declare the function in `run-command.h` file.
The function will be used in bisect_visualize() in a later
commit.

Mentored by: Christian Couder <chriscool@tuxfamily.org>
Mentored by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 run-command.c |  4 ++--
 run-command.h | 12 ++++++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/run-command.c b/run-command.c
index f72e72cce7..da02553f44 100644
--- a/run-command.c
+++ b/run-command.c
@@ -210,9 +210,9 @@ static char *locate_in_PATH(const char *file)
 	return NULL;
 }
 
-static int exists_in_PATH(const char *file)
+int exists_in_PATH(const char *command)
 {
-	char *r = locate_in_PATH(file);
+	char *r = locate_in_PATH(command);
 	int found = r != NULL;
 	free(r);
 	return found;
diff --git a/run-command.h b/run-command.h
index af1296769f..aad027984d 100644
--- a/run-command.h
+++ b/run-command.h
@@ -182,6 +182,18 @@ void child_process_clear(struct child_process *);
 
 int is_executable(const char *name);
 
+/**
+ * Check if the command exists on $PATH. This emulates the path search that
+ * execvp would perform, without actually executing the command so it
+ * can be used before fork() to prepare to run a command using
+ * execve() or after execvp() to diagnose why it failed.
+ *
+ * The caller should ensure that command contains no directory separators.
+ *
+ * Returns 1 if it is found in $PATH or 0 if the command could not be found.
+ */
+int exists_in_PATH(const char *command);
+
 /**
  * Start a sub-process. Takes a pointer to a `struct child_process`
  * that specifies the details and returns pipe FDs (if requested).
-- 
2.29.2

