Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 085231FEB3
	for <e@80x24.org>; Tue,  3 Jan 2017 18:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760596AbdACStL (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 13:49:11 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:33812 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760369AbdACStK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 13:49:10 -0500
Received: by mail-pg0-f52.google.com with SMTP id y62so165481294pgy.1
        for <git@vger.kernel.org>; Tue, 03 Jan 2017 10:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NGSiwNKi6kZOim8SEju7jbRqY7MQtcIgv+P8QX4pjYU=;
        b=f9zhgVqbnvu4PkgU/4mwo/NRuwBBjuRY3D6wGLr+sZqOmrSgEXBKl6If+BFigUqtxL
         PqoymfjjIxG7T0YLvnqLW25yXfeVAUcEvceHl8aJyHNAH1pNVWw5p2EGfFzG3cCK6/ma
         UizqeNpskHVvrA6ZK6n7iR/elzbjOYogLBph8eKnu+7mvdGNDSPPwx8Qxww5gU04ZADp
         /ZXBaec0mmZ2OASGLvA1IZeVH4uF4jiGWN3pn3EzkJ3OKN9iqMETDmR5qnlIXiECr0JN
         gTExMbqY6ag6WbjnrD9q0yvcUH7dasn2jquhqFeL8kUIvJY21w5iThBkB6DPMiVHSf1E
         ScGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NGSiwNKi6kZOim8SEju7jbRqY7MQtcIgv+P8QX4pjYU=;
        b=gnkP++xVCwL4syU7Pk/p27N9hzuRbYapCbR2t9oxR9xxk9++O3/gdZoDwrnxkXt+My
         nI78VvMgxgTRfkgwgHTULNBln0GzEDkd2kvkaHLVsZFnLwLx9t+4N5Thk4UlILsLdVK4
         zfH/NRlVC/6e1tZWuKEW5lTPz/fWybhwrNHv/VHXN839/cUKEZbBnZoDXrDl0Oxa1A8C
         MecmTxzlnG2GFPmH1oYXhZM2I833PqzU9ywZrtD8UL7winNejSGU+cpMriHULoozQ/xj
         Kt20PtfOE+TxfeBsD9X6UvPn9pHPNyCNKsrHamzZGsW0r9ZbgLTHxaJngPpXriKs54A4
         m/5g==
X-Gm-Message-State: AIkVDXJuKgb6dLqyad/uUjwMTJmaPfjkrCLwFgBThy8jtThI0pTCZ19Z7RkgYzDEHMEJNvYB
X-Received: by 10.99.54.140 with SMTP id d134mr117195148pga.132.1483468982130;
        Tue, 03 Jan 2017 10:43:02 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id e5sm141421338pfd.77.2017.01.03.10.43.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jan 2017 10:43:01 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v4 03/16] dir: convert fill_directory to use the pathspec struct interface
Date:   Tue,  3 Jan 2017 10:42:28 -0800
Message-Id: <20170103184241.128409-4-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170103184241.128409-1-bmwill@google.com>
References: <1481670870-66754-1-git-send-email-bmwill@google.com>
 <20170103184241.128409-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert 'fill_directory()' to use the pathspec struct interface from
using the '_raw' entry in the pathspec struct.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 dir.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/dir.c b/dir.c
index 1df61f10f..e8ddd7f8a 100644
--- a/dir.c
+++ b/dir.c
@@ -174,17 +174,21 @@ char *common_prefix(const struct pathspec *pathspec)
 
 int fill_directory(struct dir_struct *dir, const struct pathspec *pathspec)
 {
-	size_t len;
+	char *prefix;
+	size_t prefix_len;
 
 	/*
 	 * Calculate common prefix for the pathspec, and
 	 * use that to optimize the directory walk
 	 */
-	len = common_prefix_len(pathspec);
+	prefix = common_prefix(pathspec);
+	prefix_len = prefix ? strlen(prefix) : 0;
 
 	/* Read the directory and prune it */
-	read_directory(dir, pathspec->nr ? pathspec->_raw[0] : "", len, pathspec);
-	return len;
+	read_directory(dir, prefix, prefix_len, pathspec);
+
+	free(prefix);
+	return prefix_len;
 }
 
 int within_depth(const char *name, int namelen,
-- 
2.11.0.390.gc69c2f50cf-goog

