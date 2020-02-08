Return-Path: <SRS0=24Vd=34=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81175C352A4
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 09:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A07217BA
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 09:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCA6UY6y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgBHJIb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Feb 2020 04:08:31 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39032 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbgBHJIa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Feb 2020 04:08:30 -0500
Received: by mail-wm1-f68.google.com with SMTP id c84so5237003wme.4
        for <git@vger.kernel.org>; Sat, 08 Feb 2020 01:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+qCo2LVoN7kUc0bghjWPOu/0zLYqhaSIxCXScK4jhRc=;
        b=YCA6UY6yJ/TFf0j9omZy0IxcZjSISajwJT1TA889O8YPAqJdF3hEVa8K8Mll6i0cjN
         riZOJZxcKFO6m7H2XeZDtAy0lAcHhCrW4y1i6H+nqsMEm/lgIx77xk0EoiLtxDVWH7Ff
         vjDKF2xoz2w5CfOCrt5Zu9XAJU9l8u+y962UIKGEYtWee6/Nk9l83qwkm7SWseoS+ymX
         FPMhNuyqC4bcsWBZGY8V1R1y7HSYZSe6Lqsa6jM+ilHIwuu6iI02lLlihsy5nH+BGQuU
         z1KHp5hnbO5L1wXgYE7Aq412NzS8VSXSAcmy/37+u3xs0tmr0sUhR/X5Iyr6e8/w9MW+
         Ai3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+qCo2LVoN7kUc0bghjWPOu/0zLYqhaSIxCXScK4jhRc=;
        b=HNjJZjVX5+8nAHHUnvnKZbqd7NfQ1LbtAHgx2y2Cb44fxDKlmciv1MM5wI4iSO6yga
         2updH1mXpF8CH7DzREUtqrzR7gEVCRGtFqUJNaO8A+Z3Te5WAbOBNPHQH9UUk/z/Wvib
         g4evU5+MaStRiM5JXjjdMEhOAEdOY68/rHyGXSMHK5fZhl+AQ3MaCDaOTNun2Y4+3HB6
         FkLkxNWy5IChpAjXVUFuvCLNdLaCnqxxBukCbM7r+LDp0kEnSTv3pOcbP9/p6hMqdahf
         ne3ZmGxA+bSzZ5o/toJizuSnxal9jlbwvbyC+x5JOw7gViNTONRy+Abz1sCM+z5CShqg
         hsCQ==
X-Gm-Message-State: APjAAAVwxJw9iGKOJeMSXcKywYZHSolRn1QdKUgGyg1XF6p+fcIjds2j
        vY4hELkF/ohnYDQGw2P+CgqgmmsY
X-Google-Smtp-Source: APXvYqzW+zLre+andgvnEomheb5y+JvGZIQMWBZHfFUGS7D/v4qr7dZZIwC2wyoyrzJ+IjNSBxYmTQ==
X-Received: by 2002:a1c:a752:: with SMTP id q79mr3389055wme.64.1581152908502;
        Sat, 08 Feb 2020 01:08:28 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id e1sm6999346wrt.84.2020.02.08.01.08.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Feb 2020 01:08:28 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v3 04/13] run-command: make `exists_in_PATH()` non-static
Date:   Sat,  8 Feb 2020 10:06:55 +0100
Message-Id: <20200208090704.26506-5-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200208090704.26506-1-mirucam@gmail.com>
References: <20200208090704.26506-1-mirucam@gmail.com>
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

`exists_in_PATH()` and `locate_in_PATH()` functions don't
depend on file-local variables.

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
2.25.0

