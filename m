Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3D2C5517A
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA56920720
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="e2VV0Yxp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391072AbgJ2CQo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 22:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbgJ2CQV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 22:16:21 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFA9C0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 19:16:20 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b69so871182qkg.8
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 19:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O9RLtFNMZomD/yozwWMk1L4zZxHAQwyEKgw7IYN/ljU=;
        b=e2VV0YxpmNOX/qJU3llgOMwwQwcJ233tpN1ELPPB0od9wXwW9P9mkuAhD1gIpBiCvH
         u6D1JyyMmFt9nEbopTkT92fe1hgQptjrXqbYAKoXrCM9WcyUK3Wl0k/l/rb4XBts1V9z
         sCP7z+HBhSiosYXkJO4Om5FW5PMpHitculw4Lx4NuSMQHfjBbAEIno6QiARY6PNl5qvD
         /EaV6TUhKASuPrV5Cp2U1G3a5PfX3NMpK9Ptj3XJg0kixvAeV9udJ0ES8YH0/1LVh0D8
         EepCOs33cso7fR3ZPB3wfXJoSn6noQLy4kwQkJbjvwWdZ4tnBmT+HS3jvAnoDJUg8TWV
         Nufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O9RLtFNMZomD/yozwWMk1L4zZxHAQwyEKgw7IYN/ljU=;
        b=UvxRrqAn20EcnzOdtXhnHhAgtEhCMLGHec/ibH3z4Q5FnhqnRYloyKoBFKc93vYz05
         zGpWioetW21MnmsLYK/h79/mzAmMseVBg2EYPVlaLQDf2N8Fx+r7DhbHiP9nue9sA9hr
         8pDXUbHjl3DBhW4QlhDMn8JiOELtqL9BKDd0Wangq0wkn/PeC5qTHQtn1XUvzh5NOMeO
         3KbS66m2KmRogHG+gEvAzLdqbC1xUkKUkpSSUtN66TnD250wCSIcZw4KmYVW+Oy5UrVz
         I7mzbNxPO+yiOyKtLiCxt5EIf1PSeBVkhTHTWwHNw2V17DepfbcpoijbTyf6uR6vOJRy
         4Mnw==
X-Gm-Message-State: AOAM531Hi8bH5jehwqRYvzJ7HoqeN9PkV0XLES0NNqebmJGSmVPtk7Ar
        NIAcWMyckO2Q1dOlaA3JRHGGS/tQNtAPgg==
X-Google-Smtp-Source: ABdhPJySed+MHFteDzankat/xIyu7fDc8jE5Q426WIZkax8SK6i07c+t90cXDqroRkwaklasgDIrUg==
X-Received: by 2002:a37:a7c7:: with SMTP id q190mr156139qke.185.1603937779610;
        Wed, 28 Oct 2020 19:16:19 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id n201sm608371qka.32.2020.10.28.19.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 19:16:18 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@jeffhostetler.com, chriscool@tuxfamily.org,
        peff@peff.net, newren@gmail.com, jrnieder@gmail.com,
        martin.agren@gmail.com
Subject: [PATCH v3 15/19] checkout-index: add parallel checkout support
Date:   Wed, 28 Oct 2020 23:14:52 -0300
Message-Id: <ee34c6e1497852e52b19a1b1ff4c70468080885e.1603937110.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1603937110.git.matheus.bernardino@usp.br>
References: <cover.1603937110.git.matheus.bernardino@usp.br>
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

