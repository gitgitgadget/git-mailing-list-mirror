Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E688AC433E0
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 19:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E13A23119
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 19:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbhASTzS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 14:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729969AbhASTyo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 14:54:44 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48B8C0613C1
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 11:53:58 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id v15so17273038wrx.4
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 11:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jZK3pNu61wrQ/V04IYnePto8PDBrZpemvXpBnPivOPU=;
        b=ZxWHcVhMy4gwXNyUJD6CvxQrvf0XvbS0jvUXAByW9NcAB3+VUL0Urd5jdSAjQ/PKgy
         doFSKvIJVByaZbbCPjAIUMb7Wtfwbj2R+cUq8L8LBFiIbfHy8LgGkiM0f9Q2C4jXM+3W
         zdRzHT1zVsdIvPTqnCFxU81omCj5XiG/R9fZ08psMcAU2oaIc6bBnmXCM7Hx/IwkZl90
         Zj7tl8h/GAKy2+/X+X42GHsJD0yFXXvU603xZVwShIFVdpvje8qEUta/7UOSlb8qVRyu
         jV6gcTIAWvYmtFCsjmIeG8fLYzu3vRzYuu1B6PrFMfRTcXeUmGFGtO+DS55KJltPZ6Pj
         Sfag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jZK3pNu61wrQ/V04IYnePto8PDBrZpemvXpBnPivOPU=;
        b=NQdcbNVuNjzGK95BFwi0BxFxENbdJFWRicOoMjmh57tjTwHfgFpz7bR7UbWoWZo1HM
         EwjbNRA9gXCzVKMKvOvurKIdDDuWqVqsOIeTy5jdU3r5czhiTROwuJBPiGfELRfOVNLw
         DrWqUwG/aWWmPtqfkHathBV+tGZv9amoZGSNQyCdeeAVcRf+e2xY4jdwI2heiBx0qmMo
         0Bg7QI3bT5g/JMm1mtizVGn6ApHO9ARGvS9xmHpb1wR9xmcjmBYA+HR+0WKVNQjA3vH1
         l7rfCdm4zVN3WpeV8MI7TDO2yFY5wKGVGrC+UGlIhrLgFnqRLw4avF2pq3Lgr9nmv3aJ
         Lkdg==
X-Gm-Message-State: AOAM532/OmAYvBS2oS6WDR84m4yDnVeCIEGXXYRm0drBiyUEJxE6Ra6W
        EgB1uGyZSSKnZYLmEV+WrmTWKsawyZs=
X-Google-Smtp-Source: ABdhPJyuScaxJSB2zpfuqBbyDljLjZz53i7N7OIDKX97XMRcrlDh212kz59dMG21cFHoaV7HF7eNRg==
X-Received: by 2002:adf:b781:: with SMTP id s1mr5978663wre.290.1611086037534;
        Tue, 19 Jan 2021 11:53:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 62sm6493030wmd.34.2021.01.19.11.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 11:53:57 -0800 (PST)
Message-Id: <3061a6ae69c167e2548d42de85851dd21cd1159f.1611086033.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v3.git.1611086033.gitgitgadget@gmail.com>
References: <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
        <pull.835.v3.git.1611086033.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jan 2021 19:53:39 +0000
Subject: [PATCH v3 03/17] merge-ort: collect which directories are removed in
 dirs_removed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 2e6d41b0a0f..999a7c91c52 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -480,6 +480,27 @@ static void setup_path_info(struct merge_options *opt,
 	result->util = mi;
 }
 
+static void collect_rename_info(struct merge_options *opt,
+				struct name_entry *names,
+				const char *dirname,
+				const char *fullname,
+				unsigned filemask,
+				unsigned dirmask,
+				unsigned match_mask)
+{
+	struct rename_info *renames = &opt->priv->renames;
+
+	/* Update dirs_removed, as needed */
+	if (dirmask == 1 || dirmask == 3 || dirmask == 5) {
+		/* absent_mask = 0x07 - dirmask; sides = absent_mask/2 */
+		unsigned sides = (0x07 - dirmask)/2;
+		if (sides & 1)
+			strset_add(&renames->dirs_removed[1], fullname);
+		if (sides & 2)
+			strset_add(&renames->dirs_removed[2], fullname);
+	}
+}
+
 static int collect_merge_info_callback(int n,
 				       unsigned long mask,
 				       unsigned long dirmask,
@@ -580,6 +601,12 @@ static int collect_merge_info_callback(int n,
 		return mask;
 	}
 
+	/*
+	 * Gather additional information used in rename detection.
+	 */
+	collect_rename_info(opt, names, dirname, fullpath,
+			    filemask, dirmask, match_mask);
+
 	/*
 	 * Record information about the path so we can resolve later in
 	 * process_entries.
-- 
gitgitgadget

