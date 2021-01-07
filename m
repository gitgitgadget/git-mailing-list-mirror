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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15433C433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 20:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC3F523447
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 20:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbhAGUCV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 15:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbhAGUCO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 15:02:14 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81138C0612F9
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 12:01:33 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d26so6792135wrb.12
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 12:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jZK3pNu61wrQ/V04IYnePto8PDBrZpemvXpBnPivOPU=;
        b=SJpXqdmmErnp+cIrwLR3rYxff21X2vDCEewZigQ5n03ao+yrZegRDfe/a++2mJO0oP
         BZoczeQP99VAg037BObNhp9EwFE1X4A84fgZAUn0I0/F1J2dFWAo78rRCYJlY1fJb/jD
         /BGKPWoauPFeGsarob2eymB4RbTMMA94sAmaxy2CC1s71lGxAJW+aNQcW54QB4asTk3O
         Gm2tSqK5SL+GSACRTaQ0QXeGv78MaQ1uz8tPvVK3jYKKPJ7V9da33WSXVZsumwHK3mHS
         Mhrpe0mKNgHocI2AyF+KAqF/V2qsIxlYXjZgLERP6x8TS98TUshheYiqIRn+BoOdTbG+
         lUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jZK3pNu61wrQ/V04IYnePto8PDBrZpemvXpBnPivOPU=;
        b=mM54ZoQ14OBOz7r2vMcqTsQ1Oeo6YIHM8kvuZs/jUO+kvHU8Fc9TvhAQul0YVAaATU
         YXwOJ5Anq3vGXpw6FFHb0GxkP9zXFH/BlyihLdGYH/dAULQJSSP1tAjCCqxSLUjJT1tU
         /KzrOrgdfAj/aKOnYgM3pAj9FBZyp4YHEPcjSIDukI+a1NO3dyjZx6jjuQN0JbYtCTGT
         eWt6N+7FvICMBtI+KfMj1TsinBGfNg1DYis0VmN10cMbU/xvZYq5h/FB3A7R0KobTg97
         TmbgqwFjTM3GWAjQ/SsM2vlVCyKQx022yMK7YsBgYZdeR6mqtX3zaawgga/9i2vHNj+T
         BUYQ==
X-Gm-Message-State: AOAM531O2hr2BgFlMui7lw4jQvuZw/wIk5wjVx344H8gBfLtVuRvlDlz
        Ib/pN+zSIsuKRyaZsrfoYjB6ipvTFEc=
X-Google-Smtp-Source: ABdhPJwflP+2aTVisFlU7CGnFfRc0+iKZP9vpjsBRrtiymBO6MB4thd85E6F0a3UDSHrNUp7e1q7vw==
X-Received: by 2002:adf:eec7:: with SMTP id a7mr272489wrp.45.1610049691999;
        Thu, 07 Jan 2021 12:01:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z63sm9501090wme.8.2021.01.07.12.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 12:01:31 -0800 (PST)
Message-Id: <bb4b6d20480d996333b3b0dcafffb97fcaebe91e.1610049687.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.git.1610049687.gitgitgadget@gmail.com>
References: <pull.835.git.1610049687.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jan 2021 20:01:12 +0000
Subject: [PATCH 03/18] merge-ort: collect which directories are removed in
 dirs_removed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
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

