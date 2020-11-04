Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC60C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A6E722206
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="V83ZAjei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732174AbgKDUeZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 15:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732154AbgKDUeX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 15:34:23 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1457BC0613D4
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 12:34:23 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id l2so20686844qkf.0
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 12:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O9RLtFNMZomD/yozwWMk1L4zZxHAQwyEKgw7IYN/ljU=;
        b=V83ZAjei55RKdHC3imw5jxy7kvZxBV6wVzleycR7ugRQHjDFiQWwpWwYe1UaD+m2pc
         DRj5bQrhgWx9pdMl/ZTulvnHmn0mpo6AxFaynz57fROAMZo8Nse7IehMMmU6Ycen3FP5
         TRZ2wCBim1vACxcumWJP3sxRB1Gcumh0Nr8cDmoogdICsrVcjyartCsfp7iq0Mn14cd2
         kkHGTu1mQXePybJI7/rIgMXn3lGMWS4s2ALc9IaW8PXQcKTQbwDDp8c/Dekb06MD1jKN
         ibi0p4LMSoCUIvxI0Y3q56GaxxpNceRcLghdvffCPWXKXuOTkgVPCdKI73gkXq7bZ+3V
         T+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O9RLtFNMZomD/yozwWMk1L4zZxHAQwyEKgw7IYN/ljU=;
        b=t15aQ9INYPi17nybTRRxBxNRvqBRmZmBDZWxWGVIBUNuhk0Si9L8azVatzMi5TXbqM
         IHUKHJhPOQtBAiDoIt8AQl74fbaaQbf8eM9mc9eUbsr/r86gbXriE6DpBq7+2ma+UY/H
         bIDbul9hdxKjfydfFzwHSRgCgaxGO+tc8GemnDRZ0TpKt+B9GMwE5fOj3m36KiUhJADO
         HWAqYuBmGA8VJ6NR4o3FDmNFfW2EZtcwO1fvwQSWvM2qOVdEH5TzxDsJydCFA80WjLMv
         fVSuuAuhLQ/WGO4i2t+clMkDJLtVk/xuUebKZogxq7ugled2ltF/RsRRKDHpegCmK4hb
         +MUQ==
X-Gm-Message-State: AOAM533xHkNKFshd7WVcw7AtTogf8uebksCl6n3wVibp7wXjVOo0UQqh
        IUZIL2jn6slLUlNKc8oub/cMxJhMjAvMgg==
X-Google-Smtp-Source: ABdhPJyGd5DmphjsL/nt6Q+/fQO14dYa8TqyOyxoravbXa1HwT57eRf9fCwaIyfITN2+Wvi8URIqGQ==
X-Received: by 2002:a05:620a:2144:: with SMTP id m4mr27472618qkm.269.1604522061843;
        Wed, 04 Nov 2020 12:34:21 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id m15sm1100971qtc.90.2020.11.04.12.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 12:34:21 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@jeffhostetler.com, chriscool@tuxfamily.org,
        peff@peff.net, newren@gmail.com, jrnieder@gmail.com,
        martin.agren@gmail.com
Subject: [PATCH v4 15/19] checkout-index: add parallel checkout support
Date:   Wed,  4 Nov 2020 17:33:14 -0300
Message-Id: <a844451e580b6eb2c7c90b00e6a958855a1f85b0.1604521276.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1604521275.git.matheus.bernardino@usp.br>
References: <cover.1604521275.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/checkout-index.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 9276ed0258..9a2e255f58 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -12,6 +12,7 @@
 #include "cache-tree.h"
 #include "parse-options.h"
 #include "entry.h"
+#include "parallel-checkout.h"
 
 #define CHECKOUT_ALL 4
 static int nul_term_line;
@@ -169,6 +170,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 	int force = 0, quiet = 0, not_new = 0;
 	int index_opt = 0;
 	int err = 0;
+	int pc_workers, pc_threshold;
 	struct option builtin_checkout_index_options[] = {
 		OPT_BOOL('a', "all", &all,
 			N_("check out all files in the index")),
@@ -223,6 +225,14 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
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
@@ -262,12 +272,17 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 		strbuf_release(&buf);
 	}
 
-	if (err)
-		return 1;
-
 	if (all)
 		checkout_all(prefix, prefix_length);
 
+	if (pc_workers > 1) {
+		err |= run_parallel_checkout(&state, pc_workers, pc_threshold,
+					     NULL, NULL);
+	}
+
+	if (err)
+		return 1;
+
 	if (is_lock_file_locked(&lock_file) &&
 	    write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die("Unable to write new index file");
-- 
2.28.0

