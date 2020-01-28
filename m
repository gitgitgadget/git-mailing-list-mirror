Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CB4C33CB3
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 14:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D224207FD
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 14:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4o2YF2k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730405AbgA1OlU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:41:20 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55760 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729971AbgA1OlT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 09:41:19 -0500
Received: by mail-wm1-f67.google.com with SMTP id q9so2775916wmj.5
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 06:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9SpYi/ohrDgazNPtmVZM0LynCsl2zU9y8ZTkc7EorDM=;
        b=K4o2YF2kqXQJxo1OatIApPR4NPH3qsDrtiDQU8iFFwMtDwTyLyihgadvyVge2om35K
         1PSFgEJi34TjVhds0N1tZtTuUIulywLos6GSRvascc9ssg7c3FX7XzZ1NU1JY+iTmTbY
         uknFFs2VzcnPHTR+n4BXgMRk2/mXvmAt/sNlUKT+nVbpJLlvcYLye0VN1oaKWa0VM7+4
         JIh9pd2RnYgSkChiXGni5bBmfT769QLePjvvGxe/LIGLgTzZwOn+nTGZukK3rLHaFDZo
         79rw3HYtV2M2h/3wI6QJZ/6dmhVmoLnVrjSWXEN7dUfrrynJmytTvI1BJrLp0RRRv4vk
         ZtIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9SpYi/ohrDgazNPtmVZM0LynCsl2zU9y8ZTkc7EorDM=;
        b=RMYOuMmtyk4h3m/HPl0OrM0NpVNXajCyvqnFvZIFXvLUupitdYGEdNWbWtTH8Dtd9K
         PgKcgN9MZ47NBtRwri3hQUBM9IEVugPaBqFZpUZPNdJ+EPRcLCSQlN9Ts00oFErC5VNe
         fgjaWsOhbZ4ZeZRx6DEknDoZ2Q6vUzQiuxKpkDP5DuVpwWk5DpSyWXbrs3d6SI9tPr2h
         /TIJbqYdoTsfPJR4Azaf0PlGxKByKIauoEDE/EePh5OvMkc4svwrWHulo/0B4i+fYFjO
         PnfRA85gD4QC43nVFhquQkQpBWlc3WM4fr1jwHFlYbeCMGEG2yzNpD2jo4okbGT7VeKn
         gb0w==
X-Gm-Message-State: APjAAAWJ0qfAQ4XGmLu0WkXZbgZAOQr3Fen6EsDN5Iauli820OwJ7Bfi
        6iOX43VJ91rhU7p4ReeiOqXH3Ixz
X-Google-Smtp-Source: APXvYqxvwsbBol6es8glKqbmbUXWM63bWWUzsKEJSTUWRugb6SMXjymnZwPeIdMU5LNYUSrVTVyIqw==
X-Received: by 2002:a1c:c919:: with SMTP id f25mr5510892wmb.49.1580222476927;
        Tue, 28 Jan 2020 06:41:16 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id g7sm25732439wrq.21.2020.01.28.06.41.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jan 2020 06:41:16 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v2 04/11] run-command: make `exists_in_PATH()` non-static
Date:   Tue, 28 Jan 2020 15:40:19 +0100
Message-Id: <20200128144026.53128-5-mirucam@gmail.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
In-Reply-To: <20200128144026.53128-1-mirucam@gmail.com>
References: <20200128144026.53128-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
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
 run-command.h | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index f5e1149f9b..4df975178d 100644
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
index 592d9dc035..7c8e206d97 100644
--- a/run-command.h
+++ b/run-command.h
@@ -172,6 +172,17 @@ void child_process_clear(struct child_process *);
 
 int is_executable(const char *name);
 
+/**
+ * Returns if a $PATH given by parameter is found or not (it is NULL). This
+ * function uses locate_in_PATH() function that emulates the path search that
+ * execvp would perform. Memory used to store the resultant path is freed by
+ * the function.
+ *
+ * The caller should ensure that $PATH contains no directory
+ * separators.
+ */
+int exists_in_PATH(const char *);
+
 /**
  * Start a sub-process. Takes a pointer to a `struct child_process`
  * that specifies the details and returns pipe FDs (if requested).
-- 
2.21.1 (Apple Git-122.3)

