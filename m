Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20630C4332D
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAC2522CA1
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgLUSBS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 13:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgLUSBS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 13:01:18 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12855C061793
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:00:38 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id qw4so14619911ejb.12
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eUK7HQQtb6M9Y8IMrQ8BaFwNOI4UclqRgx2ySDNUJmo=;
        b=nF4WOwHypqktJY0Dq7hpV93ZotwWHqWUZaNyxKEj+cd/OQOWY0FL5jxwUydIrFo+DE
         X1izt3JMyeCIx9BI8n8oSAEEigo0PHiqkR0VvjwVHkp9JjVznikFW/h8ibF0PNNAxpN0
         wqwOj1ycQhLFM6CCD/esyjToXCa5RbdYZyKVgFFsLAkObRIKDKyfJMgQ0KWJ3lot/cs8
         1tJGCZN4fQuvw4FDzz08LdTkmntBfvGIR+5V/gZCP3xAJFCkk7NdvGvFHeHY7rfu+A6U
         m/0evHE1UtVwIrProHGWfdh/UB+KqkdfiaBGCpq9ZlFY6Wvzi34P3ARS6on6mWUXeSn2
         X//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eUK7HQQtb6M9Y8IMrQ8BaFwNOI4UclqRgx2ySDNUJmo=;
        b=JIvpVVYF1HZPSoIFe/XKESJUGxjwV8ZvjgbSVKij7Np/7LdXLOwH4tmIis2LFbag0/
         Gr5q+SYtAyQuEibWdhwxrEhS98Juojr0mBMQYltkX2HuJbhK0Isx8D1/Irtcl4CFL5YJ
         62Olk16T5Cahu23ot97IqmNvob0HqUIWDQq49/gp33sd/313sGQI6uRqv//Vr4r7k0sz
         xfbT6X24ZWuTu4zYc3Xk93y3soGE8TmoyXOvpWi4R2w7LyT1EY6S0JBIcDE+uPKrgwG8
         HDb8uOq6QRJsKZu3gmoLlCuFKEYSmyvidiELDdE7JqkomlruCQyskHlOZ0qh9mzfkILH
         16CQ==
X-Gm-Message-State: AOAM531UMcn64lvs8nEaLEvnY1EDFfR2uV5eesgIKaqHEBbFkhM+4mKM
        pOXo01rXFXLGIr0zgmJpVRiF45nKRGc=
X-Google-Smtp-Source: ABdhPJxDMwGcVTfzSlzZHRMSHQWCoH/okQVNw/0VKVOOY6HgdVKD3F2GYMKLFieBQteoYS3rh9MwTg==
X-Received: by 2002:a2e:9757:: with SMTP id f23mr7538443ljj.55.1608564043770;
        Mon, 21 Dec 2020 07:20:43 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c5sm2220085ljj.67.2020.12.21.07.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 07:20:42 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 09/32] diff-merges: re-arrange functions to match the order they are called in
Date:   Mon, 21 Dec 2020 18:19:37 +0300
Message-Id: <20201221152000.13134-10-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201221152000.13134-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201221152000.13134-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For clarity, define public functions in the order they are called, to
make logic inter-dependencies easier to grok.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 diff-merges.c | 24 ++++++++++++++----------
 diff-merges.h |  7 +++----
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/diff-merges.c b/diff-merges.c
index 76c804579758..8325ab880166 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -2,6 +2,10 @@
 
 #include "revision.h"
 
+/*
+ * Public functions. They are in the order they are called.
+ */
+
 void diff_merges_init_revs(struct rev_info *revs)
 {
 	revs->ignore_merges = -1;
@@ -46,16 +50,6 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
 	return argcount;
 }
 
-void diff_merges_setup_revs(struct rev_info *revs)
-{
-	if (revs->combine_merges && revs->ignore_merges < 0)
-		revs->ignore_merges = 0;
-	if (revs->ignore_merges < 0)
-		revs->ignore_merges = 1;
-	if (revs->combined_all_paths && !revs->combine_merges)
-		die("--combined-all-paths makes no sense without -c or --cc");
-}
-
 void diff_merges_default_to_first_parent(struct rev_info *revs)
 {
 	if (revs->ignore_merges < 0)		/* No -m */
@@ -72,3 +66,13 @@ void diff_merges_default_to_dense_combined(struct rev_info *revs)
 		}
 	}
 }
+
+void diff_merges_setup_revs(struct rev_info *revs)
+{
+	if (revs->combine_merges && revs->ignore_merges < 0)
+		revs->ignore_merges = 0;
+	if (revs->ignore_merges < 0)
+		revs->ignore_merges = 1;
+	if (revs->combined_all_paths && !revs->combine_merges)
+		die("--combined-all-paths makes no sense without -c or --cc");
+}
diff --git a/diff-merges.h b/diff-merges.h
index 18861dc5480e..243ef915c4cd 100644
--- a/diff-merges.h
+++ b/diff-merges.h
@@ -13,11 +13,10 @@ void diff_merges_init_revs(struct rev_info *revs);
 
 int diff_merges_parse_opts(struct rev_info *revs, const char **argv);
 
-void diff_merges_setup_revs(struct rev_info *revs);
-
-void diff_merges_default_to_dense_combined(struct rev_info *revs);
-
 void diff_merges_default_to_first_parent(struct rev_info *revs);
 
+void diff_merges_default_to_dense_combined(struct rev_info *revs);
+
+void diff_merges_setup_revs(struct rev_info *revs);
 
 #endif
-- 
2.25.1

