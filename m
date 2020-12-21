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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C28C433E9
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4DAD225AC
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgLUS4W (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 13:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgLUS4W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 13:56:22 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C626C0613D3
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:55:41 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id cw27so10602167edb.5
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hFQlziZ6dHmO6c8kZA0FgdRBVViP/3oud1A5ugh6jtw=;
        b=MLIor0xNwJeMgZRDVbPBg31PCoHSCeVCWrgpMygqNn7HAM35mpWbeplmMpcutzfLgn
         l1n6Uf2Zlf6eiMah3zvZ2M8SDBcGQ7LdxzE00vGdAkXi11NlS6CYGesGMmgsdby2GYp+
         S7lSxIWiPM2K+Gd+etWx77LTtfGfu5urj1W4JDZgTqvFUnmjuqKE2BQ8qhEEBfs+Dywx
         wCUtxMuNDJYrM/t3PGAv0fI0I+rSTvNpPmpb03ekj1mdHfK8z0M13lq7HoXRtv9Te4Xw
         zbaebzx4s3rVxCuHogzZVa1XH3+aJz4DzPRN03MDKneQk8Pe51yRYQkyvgrlU99TJebf
         Mx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hFQlziZ6dHmO6c8kZA0FgdRBVViP/3oud1A5ugh6jtw=;
        b=dgV99r4Stq6ESbTtvjCwccFUsjRqrAPcZLzoPfsSlyaq9Rg3hhxqbsDz9ZIdPhp08z
         IJMBNOw1Bc6u4cgawYRPLBgZNQKkq57nOWa41WYKypdpksRHgdWHGSHckFmcVXg1zUOO
         PX24xurP5rH70cTd5cjh1XEOkfz1IUKn1j3pXwvD+jGZlo/inkFSZ73gXeKlKADYVIy4
         j+/P/H6oeRW//IJB0iRS2TiNzLHeyU4JHBRk8vEKJfqQ6SOPXVoVJ3Ef/G8D0Yv6Ejgk
         9oBnt8VY4t0rkTD7DEGu68q+tNzUZFCbISCdsaGgsWAqKdQPEOTMkzTTUD3KQT4SYTOn
         a7mg==
X-Gm-Message-State: AOAM531IVcv0l6AC6TYHN/avuJSUOYGPiC39ZLZqlhJ/fBhf6rFq/3QP
        dYp6DyGNfDYOSs34JP6M+k3Aox61l5Q=
X-Google-Smtp-Source: ABdhPJwzSrSefdrSBrdfA1Jw8ObfvQeueMnw8SD8aqnvkJOkKzj/DWRp9bv53GRkl3/MQPwkYrgTHQ==
X-Received: by 2002:a19:641:: with SMTP id 62mr6790040lfg.424.1608564042461;
        Mon, 21 Dec 2020 07:20:42 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c5sm2220085ljj.67.2020.12.21.07.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 07:20:41 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 08/32] diff-merges: rename diff_merges_default_to_enable() to match semantics
Date:   Mon, 21 Dec 2020 18:19:36 +0300
Message-Id: <20201221152000.13134-9-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201221152000.13134-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201221152000.13134-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename diff_merges_default_to_enable() to
diff_merges_default_to_first_parent() to match its semantics.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 builtin/log.c | 4 ++--
 diff-merges.c | 2 +-
 diff-merges.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index a7791c003c91..63875c3aeec9 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -600,7 +600,7 @@ static void show_setup_revisions_tweak(struct rev_info *rev,
 				       struct setup_revision_opt *opt)
 {
 	if (rev->first_parent_only)
-		diff_merges_default_to_enable(rev);
+		diff_merges_default_to_first_parent(rev);
 	else
 		diff_merges_default_to_dense_combined(rev);
 	if (!rev->diffopt.output_format)
@@ -728,7 +728,7 @@ static void log_setup_revisions_tweak(struct rev_info *rev,
 		rev->diffopt.output_format = DIFF_FORMAT_PATCH;
 
 	if (rev->first_parent_only)
-		diff_merges_default_to_enable(rev);
+		diff_merges_default_to_first_parent(rev);
 }
 
 int cmd_log(int argc, const char **argv, const char *prefix)
diff --git a/diff-merges.c b/diff-merges.c
index a3bafa92f3e1..76c804579758 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -56,7 +56,7 @@ void diff_merges_setup_revs(struct rev_info *revs)
 		die("--combined-all-paths makes no sense without -c or --cc");
 }
 
-void diff_merges_default_to_enable(struct rev_info *revs)
+void diff_merges_default_to_first_parent(struct rev_info *revs)
 {
 	if (revs->ignore_merges < 0)		/* No -m */
 		revs->ignore_merges = 0;
diff --git a/diff-merges.h b/diff-merges.h
index 6937d46219f1..18861dc5480e 100644
--- a/diff-merges.h
+++ b/diff-merges.h
@@ -17,7 +17,7 @@ void diff_merges_setup_revs(struct rev_info *revs);
 
 void diff_merges_default_to_dense_combined(struct rev_info *revs);
 
-void diff_merges_default_to_enable(struct rev_info *revs);
+void diff_merges_default_to_first_parent(struct rev_info *revs);
 
 
 #endif
-- 
2.25.1

