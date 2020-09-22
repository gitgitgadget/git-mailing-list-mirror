Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E5FC2D0E2
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 22:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 261EE2076E
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 22:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="cORnHZfj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgIVWvV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 18:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgIVWvU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 18:51:20 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1413C061755
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 15:51:20 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id e7so17038007qtj.11
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 15:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lA2zZFhESSm+lGfZzZ5sKrw0x6AF5lYybK5HCYOPWxA=;
        b=cORnHZfji9pVfS/Zv90NmkFSkC/VismVhfHZBw2o//pd2fus+A651mnMpVbi+0hdOU
         2i4ADFcRz/V00/8OS0eXu2T+KB3QUaqW0NgZNgIIzx8iVnZHDGXZpdYx2bHN6WKWvaR4
         QRBxfBrvJLfHtjJ0HvDTQGcXH+eQRuwxYk38MxatOY+YF//avOfsOONJx8xRxI+0Maec
         q/C/yQwqDmjCSQ7JwTtwgnANW3hfVJWeHWEJCfC7vAxfSPeQ7rSD5wGgkoVqVOnP2YOW
         hHdsFf6SFqCJfR6B6xkj8d7pTn6kKe+HMzTUNKs5cBmviGggXNPB1++AvDOOTnWakUKx
         Gnkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lA2zZFhESSm+lGfZzZ5sKrw0x6AF5lYybK5HCYOPWxA=;
        b=X1cyvIi9IjwtPjcqg6itClTeqmolK+sg4yzEqAg3kKI2+U01sipagFPLXc7fDJS5wn
         4VbPP6DmqpuF+00poM23MzKoxnLIlFNJzhFVdNj7AcvAT7/7vAglcGpMB1priSZdkR7x
         HxlCSrtYPIhMmBEx1moGi+CppuOp+r0l05PO0QiLs8domDS2bEFSIXgdb12TcHGPpplk
         5pCIShurToseziHsulgvW0eeSAH603npyCHou4Y3viazAHPe7/Bhb2eC8vOgL3e1XyzG
         H030+Z2hgJno2w9iFbIluOt5SW42/wS8SkvShuEbARlBPW48FBo17vJFq1+i7zFNf9mE
         Cr8w==
X-Gm-Message-State: AOAM531o3VfksiizmloAYAbGXB3ie4XLOdifPFUJATFHFwHRScTVCRE1
        9P80v+yyuyfddv6m+5yri8rkb0jOIpAC0w==
X-Google-Smtp-Source: ABdhPJx1sFJIx1dEjJ2tS3bLFos12F8ftPi90MGLEtTq0J0UKNHifjk+beKtR6jg0T/baKlNOQe0Ag==
X-Received: by 2002:ac8:1c16:: with SMTP id a22mr6862811qtk.85.1600815078636;
        Tue, 22 Sep 2020 15:51:18 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.96.45])
        by smtp.gmail.com with ESMTPSA id p187sm12342359qkd.129.2020.09.22.15.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 15:51:17 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, chriscool@tuxfamily.org, peff@peff.net,
        t.gummerer@gmail.com, newren@gmail.com
Subject: [PATCH v2 15/19] checkout-index: add parallel checkout support
Date:   Tue, 22 Sep 2020 19:49:29 -0300
Message-Id: <1cf9b807f780467a3837b5e13939ead7c67eaef5.1600814153.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1600814153.git.matheus.bernardino@usp.br>
References: <cover.1600814153.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/checkout-index.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 0f1ff73129..33fb933c30 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -12,6 +12,7 @@
 #include "cache-tree.h"
 #include "parse-options.h"
 #include "entry.h"
+#include "parallel-checkout.h"
 
 #define CHECKOUT_ALL 4
 static int nul_term_line;
@@ -160,6 +161,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 	int prefix_length;
 	int force = 0, quiet = 0, not_new = 0;
 	int index_opt = 0;
+	int pc_workers, pc_threshold;
 	struct option builtin_checkout_index_options[] = {
 		OPT_BOOL('a', "all", &all,
 			N_("check out all files in the index")),
@@ -214,6 +216,14 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 		hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
 	}
 
+	if (!to_tempfile)
+		get_parallel_checkout_configs(&pc_workers, &pc_threshold);
+	else
+		pc_workers = 1;
+
+	if (pc_workers > 1)
+		init_parallel_checkout();
+
 	/* Check out named files first */
 	for (i = 0; i < argc; i++) {
 		const char *arg = argv[i];
@@ -256,6 +266,12 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 	if (all)
 		checkout_all(prefix, prefix_length);
 
+	if (pc_workers > 1) {
+		/* Errors were already reported */
+		run_parallel_checkout(&state, pc_workers, pc_threshold,
+				      NULL, NULL);
+	}
+
 	if (is_lock_file_locked(&lock_file) &&
 	    write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die("Unable to write new index file");
-- 
2.28.0

