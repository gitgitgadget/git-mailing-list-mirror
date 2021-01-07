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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6834C433E9
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 21:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BF45235FD
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 21:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbhAGVha (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 16:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbhAGVha (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 16:37:30 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A00C0612FC
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 13:36:12 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id y17so7002918wrr.10
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 13:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jZK3pNu61wrQ/V04IYnePto8PDBrZpemvXpBnPivOPU=;
        b=rEJeKFYlQfVUsce4C7u9hvswJoIGDonw3EV5y+VqncEpNLiSvkszzJG3JpFsIQDu5k
         zNhcjLgmcHux0h/WikFpylwS3PwK6qIfEuRgeQHsyDFz8kB+0lKnn3jeY2TmOQ/GBie8
         7RX1kyMvT0cRHtoDPcWz24ADc/FBaagfuc/Xnm6DWPPrBrv40j3qVLnSiRX/Qn41H+RL
         6ZDX+SzoPoY+VNezZYMIcIZGhkylTEM5fjr45OetYIJZ4Xx9fwRTpSNJ68CGFY2P/CMs
         4NJz4miWlRN8nn3Uwd7RbHjwnQFPjiOkcI0MSvcHllp+u9y02Mjr4hwop8cFeG62iX+k
         qIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jZK3pNu61wrQ/V04IYnePto8PDBrZpemvXpBnPivOPU=;
        b=DDJwMVCE1PKRRdipyWTTS9cW5A+NWbbdLA5tVSlDQ7SqHZ2zViepCobC/0Wq0MTBxw
         8JCFYW5gy4ZRdTVs6foCfZ684cnpV5laY2+hzRaqExz7S8izSBACfAqVCYNhLR+qzlGb
         aPCYpwg452Z3UiEVX9Fn4SYk9absypguRLOzgiEFXKRHg/LSFnVxhuNgqZr++R6AR+8L
         paPeP+MsYIVPYDWv4cEt1huNw1Wo0B0GsUawFxSCzTkWIqyUqWL0ZJ/21t9JvBnxZMaS
         F6lxDtrXxvfI/ZtfvYsqI5dIxaDRu9Nx72uIpMJaCQcZcTuZmxGdTcHplveZJuqrala8
         RWew==
X-Gm-Message-State: AOAM5325TYtFvW0pU6/zpVkwzV2joQd8122Ze1SrZ6sGKbnlI/lEAuZN
        m9fZZpElOMlHqjnwyaGwG+3U2p4RRto=
X-Google-Smtp-Source: ABdhPJxuBFk5tOHugZiitXES5YGdXuYKhnakOqdW6V2VpVtteoQPdoOeDP9Zr0h6a80uvpMGY63twA==
X-Received: by 2002:a5d:68ce:: with SMTP id p14mr539630wrw.386.1610055371487;
        Thu, 07 Jan 2021 13:36:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h14sm10275085wrx.37.2021.01.07.13.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 13:36:11 -0800 (PST)
Message-Id: <bb4b6d20480d996333b3b0dcafffb97fcaebe91e.1610055365.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
References: <pull.835.git.1610049687.gitgitgadget@gmail.com>
        <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jan 2021 21:35:51 +0000
Subject: [PATCH v2 03/17] merge-ort: collect which directories are removed in
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

