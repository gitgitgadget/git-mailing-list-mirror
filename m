Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E65C433DF
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52C18206DA
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="BesY85Te"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgHJVfg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgHJVfg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 17:35:36 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81801C061787
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 14:35:35 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id p4so9886844qkf.0
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 14:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uZ7xSdg5IPnYhdCWJBg2p+E3ZTG/S+5YSDTbJ2OAaZ0=;
        b=BesY85Tet11Uh9kobwIjb8ru9DZ/puskxRLK/o/DeH1D0aekpc5vaToAhs8+jVhr7Z
         XyYCXrecGY29v+saB669m/mdAoXgm00H8l0YJ2wHApnDzuqq571W8zjBC4X6xkwzpzB4
         lQ/X6sdN8Mzwja99NQkvIBt8ncxafvl/pFXF+5Dirve0OZwbCrn/H2DCcbAyM+f3BUG2
         57/SCFdtSA6j5xeMGeNlPw+P2DXj5r6u6ukDFdJpV6qiiFBZm6IZvvifOjRs4hZ9menb
         rpe/enaVxQuBxRri9sC27JWu0N/UYZ8BP3dfYQtDN+/Z7IQZoQsQoR1XbC7KQoYW7B9w
         g2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uZ7xSdg5IPnYhdCWJBg2p+E3ZTG/S+5YSDTbJ2OAaZ0=;
        b=OdhSNTni/jXN9BhOiM9M8F2fHpcjBVgCE2T2/Ww+kn9g3ch2/gD5JI+85LBT0taWeI
         i5Ruo8AR0n3+GOyaAA8k0m6klR7sl0JqOG+QST0RU18HA9JNNL1yo5p5Gp5QZDGc/jQM
         tKfcdJdP9VmU+eJWh8Kys35jsYe0GjG4Y+NGIYSeGcAkyMnD1VVv4Hb3SFd1DEv6XzT1
         LRFxQtGzMQVC5xXv4qjJnd0M11CQA/grjN7hkTCvEZbVc+Ql79jOHQwGmQPEeEzY+H7Z
         Q1+oJtYrdwhlOoDA5F0QFyEU9WYSV3t2hjYIBUiz2EpVlySQhQN+woN8bJNlaGvxmp2f
         CkAw==
X-Gm-Message-State: AOAM531zcCT1VBlwrTZncDZ0nJy8veVceUjFBqnXpZjhj79oXxPOabUI
        LRD0iXYIRhTJj2knz8/zxbPlajHyhcA=
X-Google-Smtp-Source: ABdhPJysceHsdpSOBh1kKCAf7xMyoKmWjfkGBqZz9wUs3ydxWX5m+U6kC5h4jqWe1GzYWs22c2nGXQ==
X-Received: by 2002:a37:a44b:: with SMTP id n72mr26697202qke.448.1597095334320;
        Mon, 10 Aug 2020 14:35:34 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:87c:466:1120:3c2c:21e4:5931])
        by smtp.gmail.com with ESMTPSA id z197sm15370674qkb.66.2020.08.10.14.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 14:35:33 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, jeffhost@microsoft.com,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 16/21] checkout-index: add parallel checkout support
Date:   Mon, 10 Aug 2020 18:33:24 -0300
Message-Id: <feed9d435589a308759a3e6b623db13e469c242a.1597093021.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1597093021.git.matheus.bernardino@usp.br>
References: <cover.1597093021.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
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
2.27.0

