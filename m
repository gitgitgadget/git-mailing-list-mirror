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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A98BC4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 08:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DBD460E78
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 08:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239036AbhHQIQg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 04:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238843AbhHQIQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 04:16:28 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4CDC0613C1
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 01:15:55 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id q10so27330982wro.2
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 01:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ff1IbLdcvpD6MhimWYyxaTfLrj9k2S7N5XzYOYFduTA=;
        b=YJD19zooR7U5NnnRLIsuJDJzmF91H7ARTKWnJd26Pz0oGKBtD7C6N12yxZhNmt4Sus
         3SAlbYU1HMbZHu9goPbAzrdijMowDeCqAr/CO9tCwDOd1tQzS66T29nTysA2mDVTsuEi
         FNs/VsFDyq640x5MmeVKjwlPJaZm354ghcxdznktw8NQR4UbP/thn01AFMrwUlIy0caj
         15aFIvbnSaTN04nqWpIie8yeTHOMwsqy/5cXZRXurBoqogAl5JaTZPTFiK+wv8fr6wPd
         MxmaRMYONYBwQK31MleWyt4eyVUqrS5/Dnlf/M8DWUCdksXL0PKcCosUXPnGXYk0JpTx
         qluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ff1IbLdcvpD6MhimWYyxaTfLrj9k2S7N5XzYOYFduTA=;
        b=BXKMVtC98n80PQYNEkKG1+9zv3MFqR4Y9IEzwipWtpqs2YVRhD7Qhn6LmwnETxCVw4
         DhJM7kVM5qAmCx3TGRvv7+U1yYEN+qnRUoCMCjFJeqVTlGmo6N7V9OJ77scbLEIVMW2c
         cvVv5b/A+fy2k3IXnEGKVKtPKmKvYhqJwiyA7YZcE5jhwGfLCsLqNkpwa636CCW9B8qF
         G9GcL9VwBmXA40Qph3zdPfImzSCqVuQ+ZugMw8Cpx5AQWej8w6FOW9K1gga0fZ63mpro
         xVGm3q2mGCPDqs/03vC9keQ+ZYwE+4HOJ/i6ppDDwZGfU/PqkCinBKs0RUXiSjV6MfBQ
         iHew==
X-Gm-Message-State: AOAM531SrtmS8oR2BbeHepq1IOPfzwwhxCcco/AcFbYfNz6kEOFDDD+r
        Bx71rW8B414IRBnub1/7g+6MffA+dDc=
X-Google-Smtp-Source: ABdhPJx2CxfPrgmz4+WbvaZRHvQlZZMsM6b+JU/AkZz6Qp6zX4LpBKAVEvhKMtWUnALh9pbpYSuiow==
X-Received: by 2002:adf:f40d:: with SMTP id g13mr2431121wro.69.1629188154619;
        Tue, 17 Aug 2021 01:15:54 -0700 (PDT)
Received: from localhost.localdomain ([178.237.233.111])
        by smtp.gmail.com with ESMTPSA id l21sm1256238wmh.31.2021.08.17.01.15.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Aug 2021 01:15:54 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v4 3/6] run-command: make `exists_in_PATH()` non-static
Date:   Tue, 17 Aug 2021 10:14:55 +0200
Message-Id: <20210817081458.53136-4-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210817081458.53136-1-mirucam@gmail.com>
References: <20210817081458.53136-1-mirucam@gmail.com>
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

