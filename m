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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A038AC07E9B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 04:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86D396023F
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 04:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbhGUDnn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 23:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbhGUDnc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 23:43:32 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AC5C061574
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 21:24:08 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id n1so630844wri.10
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 21:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZjrST+x2g7njK0pDZhQy/jIgO7Hl+GqQVMHa3oDGsYc=;
        b=i9zmHdvttYnOlcB0+pKK7M0moed89B0oD1Ulyfty1dzsaqaEdfxIchU7QQ4EbIFHZ4
         9XMv8py86WFX1Y3/jYRct8fOwmzDdAWe3XTuSPVgyK3hAsb/HcoUaX7W8Ki+QRc7QdD8
         MywqrkGLPdDuTRP18zLhzuMG1MuNOqeTU1zBacuvuRtd5lTYG14moGHEscODVF7+b7AO
         KJMJYjq7RhUxDM+2MlmpPnXrif6qa+ccA37KYE0a/6dPn6WQ+Dvbqq9xtfnJPWfTzdek
         yDG0B+3uFBP5InjYhEG6f15s3BqN/ixNOyZsbKHenXUOboEqp9CHL5e1SYiKmhraC0PI
         BIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZjrST+x2g7njK0pDZhQy/jIgO7Hl+GqQVMHa3oDGsYc=;
        b=Ph4bjad+mNB8ywWlS/j9Zd3EPlqq6Sau4TMi43x3aqhvJQMxTQfTpXKlFC3ib2LOsK
         Q+9O4WKPlyV6si/G9QsmPOAnJizNGff4Ad984uui6ApnolTliyf2kngLeFzWrt3xqaPM
         fYtjMKjHz4d90cTiZcIiHMrBf8ekdCczzjflrqAjPpsSiq7UiBuNJrGYJZ0ijUI3ol4N
         eha1FXGtuQw4muJAKj0/smdp6K4sTxqnrftK5nKKjxvrEyD+DV/jkp1XWzr4ly98c398
         xoQduDBL30prsqdMQf1Op6cRTJiVVJHXST1zc1SWdSqTG5SjWbq6scJpD6y48na7PCvw
         JADA==
X-Gm-Message-State: AOAM531huElpNg6aVmAnRFvB8XMk1tBfchx2kEBaxZA8ZbAHZJzIcSrN
        vkx6VPYN6jOsJk/tZRJSP/9zQ1V3haE=
X-Google-Smtp-Source: ABdhPJzskvrMELazzZOnLhN3+r7MaSiLG/or8sllXn51VZsAuNZTWpZ+BrmI1WFPl6bRyUzy521Wmw==
X-Received: by 2002:a5d:457b:: with SMTP id a27mr39082272wrc.280.1626841447035;
        Tue, 20 Jul 2021 21:24:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m32sm3858734wms.23.2021.07.20.21.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 21:24:06 -0700 (PDT)
Message-Id: <7a0085f2da9d9517b20745dcb8be4c15852bd56f.1626841444.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.988.v4.git.1626841444.gitgitgadget@gmail.com>
References: <pull.988.v3.git.1626412958.gitgitgadget@gmail.com>
        <pull.988.v4.git.1626841444.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Jul 2021 04:23:59 +0000
Subject: [PATCH v4 2/7] merge-ort: add some more explanations in
 collect_merge_info_callback()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The previous patch possibly raises some questions about whether
additional cases in collect_merge_info_callback() can be handled early.
Add some explanations in the form of comments to help explain these
better.  While we're at it, add a few comments to denote what a few
boolean '0' or '1' values stand for.

Acked-by: Derrick Stolee <stolee@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 6299b4f9413..843fa693145 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1018,8 +1018,8 @@ static int collect_merge_info_callback(int n,
 	if (side1_matches_mbase && side2_matches_mbase) {
 		/* mbase, side1, & side2 all match; use mbase as resolution */
 		setup_path_info(opt, &pi, dirname, info->pathlen, fullpath,
-				names, names+0, mbase_null, 0,
-				filemask, dirmask, 1);
+				names, names+0, mbase_null, 0 /* df_conflict */,
+				filemask, dirmask, 1 /* resolved */);
 		return mask;
 	}
 
@@ -1061,14 +1061,24 @@ static int collect_merge_info_callback(int n,
 	}
 
 	/*
-	 * Gather additional information used in rename detection.
+	 * Sometimes we can tell that a source path need not be included in
+	 * rename detection -- namely, whenever either
+	 *    side1_matches_mbase && side2_null
+	 * or
+	 *    side2_matches_mbase && side1_null
+	 * However, we call collect_rename_info() even in those cases,
+	 * because exact renames are cheap and would let us remove both a
+	 * source and destination path.  We'll cull the unneeded sources
+	 * later.
 	 */
 	collect_rename_info(opt, names, dirname, fullpath,
 			    filemask, dirmask, match_mask);
 
 	/*
-	 * Record information about the path so we can resolve later in
-	 * process_entries.
+	 * None of the special cases above matched, so we have a
+	 * provisional conflict.  (Rename detection might allow us to
+	 * unconflict some more cases, but that comes later so all we can
+	 * do now is record the different non-null file hashes.)
 	 */
 	setup_path_info(opt, &pi, dirname, info->pathlen, fullpath,
 			names, NULL, 0, df_conflict, filemask, dirmask, 0);
-- 
gitgitgadget

