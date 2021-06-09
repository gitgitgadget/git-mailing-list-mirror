Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2534DC48BCD
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 19:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02363613F9
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 19:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhFITcA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 15:32:00 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:37653 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhFITb7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 15:31:59 -0400
Received: by mail-oi1-f178.google.com with SMTP id h9so26253280oih.4
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 12:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gvAj1Rn/wiZgZDEYBBgOL/XNTbxoaGL0IGVkBRLllaI=;
        b=VUyCnLVWpkFtDoheuui+y5GpLrSl1LK432+yuodrwYIxQY26z8kApWdyTPlyr+tQ55
         W2fUASPCdfzkATR3DmDjcYEHRutK6zArwGtWXh1WE9DnRDtMjg7d4uHArEBC3IKEtQdR
         Msggzt/sFKzQv1yfU/XPItvnohoCu6kHGeL1QESrB8koUK/U/CLuCMm722R2er+8v+c7
         I7kWZ5Iy4jD172YyVYX/cNJXbXdBLi7BL93cGSqDkrJT2r7VU3ONrXWVCtQ3SnHQ4Hz+
         OMwRYt5oEyJIo/PCQ2ZJitFonng7j9ZfA7Y/2MLFi8CRG6Kd23slELJvqskTLX/EwQfJ
         aHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gvAj1Rn/wiZgZDEYBBgOL/XNTbxoaGL0IGVkBRLllaI=;
        b=OPSQTdvYHi4wqP0NpvV3KZtaKoFg9iR/yA8emboi9xaeunG+34HR2viYgTh8E6i21m
         TMHarGYfrFGRrzPn+U81l5DCBvkfxcAnEcYoma0SlOCjpfo7MMQpqMc8jNmIjfw9lb87
         IGdmlPiOghzxdmscGMbTILnW1lWRr5DsXJVU/LOXFtKFEf/UMJlAisrjDcw4tq09Hw1I
         86IGolcjU2wXvgz64QXPmVQEU7DxQXoFlPllcq81Oa6Hf205fZHcdK95eAXLc20Lm3k4
         Fp2WZBEwUPR/xsfgvcLrdBLk0JDZN+fX/gEBfuhhjDaksrusFVBrKaiJhz7NthIRyRbu
         4fmA==
X-Gm-Message-State: AOAM531UQdZVfsVkLGisha5pcfvkOlIvyTHNCcYKxUHfixWTeJLaNXIo
        YX7MIsN2LB7QyNGjXLnVo3x8MClLZMveOg==
X-Google-Smtp-Source: ABdhPJzbiucFV+U8b/QK2spphz+0kV7axtBo+W9x0yqTkHfVcV5dGrpaG8bpX1flDddLQGxXs7LKcQ==
X-Received: by 2002:aca:efc1:: with SMTP id n184mr7585380oih.23.1623266944335;
        Wed, 09 Jun 2021 12:29:04 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id z4sm185824otq.48.2021.06.09.12.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 12:29:04 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 6/7] xdiff: simplify style assignments
Date:   Wed,  9 Jun 2021 14:28:41 -0500
Message-Id: <20210609192842.696646-7-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.2.g41be0a4e50
In-Reply-To: <20210609192842.696646-1-felipe.contreras@gmail.com>
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is little value in checking that git_xmerge_style isn't 0 before
changing it's default value.

Most of the time it isn't 0 anyway, so just assign the value directly.

Also, add the missing constant for the default value: XDL_MERGE_STYLE_MERGE.

Additionally this change has the benefit that it gets rid of a Yoda
condition.

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/merge-file.c | 3 +--
 ll-merge.c           | 3 +--
 xdiff-interface.c    | 4 ++--
 xdiff/xdiff.h        | 1 +
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index a4097a596f..01951762ec 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -55,8 +55,7 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 	if (startup_info->have_repository) {
 		/* Read the configuration file */
 		git_config(git_xmerge_config, NULL);
-		if (0 <= git_xmerge_style)
-			xmp.style = git_xmerge_style;
+		xmp.style = git_xmerge_style;
 	}
 
 	argc = parse_options(argc, argv, prefix, options, merge_file_usage, 0);
diff --git a/ll-merge.c b/ll-merge.c
index 9a8a2c365c..4ce8d3f9cc 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -124,8 +124,7 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 	xmp.level = XDL_MERGE_ZEALOUS;
 	xmp.favor = opts->variant;
 	xmp.xpp.flags = opts->xdl_opts;
-	if (git_xmerge_style >= 0)
-		xmp.style = git_xmerge_style;
+	xmp.style = git_xmerge_style;
 	if (marker_size > 0)
 		xmp.marker_size = marker_size;
 	xmp.ancestor = orig_name;
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 64e2c4e301..19a030fbe2 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -299,7 +299,7 @@ int xdiff_compare_lines(const char *l1, long s1,
 	return xdl_recmatch(l1, s1, l2, s2, flags);
 }
 
-int git_xmerge_style = -1;
+int git_xmerge_style = XDL_MERGE_STYLE_MERGE;
 
 int git_xmerge_config(const char *var, const char *value, void *cb)
 {
@@ -309,7 +309,7 @@ int git_xmerge_config(const char *var, const char *value, void *cb)
 		if (!strcmp(value, "diff3"))
 			git_xmerge_style = XDL_MERGE_STYLE_DIFF3;
 		else if (!strcmp(value, "merge"))
-			git_xmerge_style = 0;
+			git_xmerge_style = XDL_MERGE_STYLE_MERGE;
 		/*
 		 * Please update _git_checkout() in
 		 * git-completion.bash when you add new merge config
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 45883f5eb3..d24cd9f6ae 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -64,6 +64,7 @@ extern "C" {
 #define XDL_MERGE_FAVOR_UNION 3
 
 /* merge output styles */
+#define XDL_MERGE_STYLE_MERGE 0
 #define XDL_MERGE_STYLE_DIFF3 1
 
 typedef struct s_mmfile {
-- 
2.32.0.2.g41be0a4e50

