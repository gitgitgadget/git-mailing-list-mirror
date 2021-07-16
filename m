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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A25EC12002
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 05:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DD38613E8
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 05:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbhGPFZh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 01:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbhGPFZh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 01:25:37 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D8CC061760
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 22:22:41 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a13so10559980wrf.10
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 22:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UtksxVEuW8oPlg3lwNLFR4T2YJ+49CjWCzglLfAr+Zc=;
        b=Tvap5UuoFt0PJh5Piuyobj9+Va+QXMIoraP1kuiJ0p8nP03zXOZlvZRGOYyGDPXTZx
         Hb9nOkkAlnQueyYOFaOReOx6hEl940IOU09eSH7Cf6spTfZcMXkR4ehWBOn2Egeb44In
         Xw8Y0d2vG2Ctykcmco1l3NyHXS7J2l/PGjeA3g8ScH+561HYyodYyzchcM8jIgcjuLzN
         pMDetLg4fdpdUI+hjceiu0pbSeIjflG6hv4i0S9sOeJcfrziLRIJYXBlCzCZL0jcHqnG
         iQLuXc1Odz4JESbSMwDFzJrbprZ3lHLDrw2K4SxAyN2K/TsmwW07XHPvCRqEe4P64SYE
         0Geg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UtksxVEuW8oPlg3lwNLFR4T2YJ+49CjWCzglLfAr+Zc=;
        b=h5vgRtZLF1sL06xLGrunug08O4ZlCBuLmk3kqvgSNHB+Y5SwZnwcgPe9WYXe2PaMyb
         T7PWPboN8t+c7jhncHmAJhruvcx6HWd/1wE4j232Vcp7VSvUvpU5gZF9mayjSwSiwexo
         /g3HWx9Y5G5F6Nav/Ag+y98LpsYeqmADJR4OnqsBIzOtC4tCBQ1eGCWXCmgJETOinqCU
         48BN+IWwEVaLeqekP5nLSqHqrl3jIxHqm8/Fausm4bIyETKlfTvY3zdeYOnsUBFKPVnq
         AFvQF7iJVA7xImnMj2Yr441lhEgEabigWvYINExMYAng+0wVSoCxDGGt+TE03jxcTIW8
         9iBA==
X-Gm-Message-State: AOAM532luFvW3G/OiWZrUtgW35ai/FYz0yVPOYSZOadIypn1gge+yT0y
        0GiO+5aJxy613ac40yKkrpDT3zwirvc=
X-Google-Smtp-Source: ABdhPJzbU+K9R0FWCNbSM7Az9tn4vUYLRuxpazaZiU/QVgYY0g2CKfWlByGrtVwCUeJ70hNpXF2BWg==
X-Received: by 2002:a5d:640d:: with SMTP id z13mr10067865wru.24.1626412960117;
        Thu, 15 Jul 2021 22:22:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q19sm9672732wmq.38.2021.07.15.22.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 22:22:39 -0700 (PDT)
Message-Id: <5dca982c0b061ae8d6335d4f22b78811dced054a.1626412958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.988.v3.git.1626412958.gitgitgadget@gmail.com>
References: <pull.988.v2.git.1626204784.gitgitgadget@gmail.com>
        <pull.988.v3.git.1626412958.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Jul 2021 05:22:31 +0000
Subject: [PATCH v3 1/7] merge-ort: resolve paths early when we have sufficient
 information
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

When there are no directories involved at a given path, and all three
sides have a file at that path, and two of the three sides of history
match, we can immediately resolve the merge of that path in
collect_merge_info() and do not need to wait until process_entries().

This is actually a very minor improvement: half the time when I run it,
I see an improvement; the other half a slowdown.  It seems to be in the
range of noise.  However, this idea serves as the beginning of some
bigger optimizations coming in the following patches.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index e3a5dfc7b31..6299b4f9413 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1023,6 +1023,43 @@ static int collect_merge_info_callback(int n,
 		return mask;
 	}
 
+	/*
+	 * If the sides match, and all three paths are present and are
+	 * files, then we can take either as the resolution.  We can't do
+	 * this with trees, because there may be rename sources from the
+	 * merge_base.
+	 */
+	if (sides_match && filemask == 0x07) {
+		/* use side1 (== side2) version as resolution */
+		setup_path_info(opt, &pi, dirname, info->pathlen, fullpath,
+				names, names+1, side1_null, 0,
+				filemask, dirmask, 1);
+		return mask;
+	}
+
+	/*
+	 * If side1 matches mbase and all three paths are present and are
+	 * files, then we can use side2 as the resolution.  We cannot
+	 * necessarily do so this for trees, because there may be rename
+	 * destinations within side2.
+	 */
+	if (side1_matches_mbase && filemask == 0x07) {
+		/* use side2 version as resolution */
+		setup_path_info(opt, &pi, dirname, info->pathlen, fullpath,
+				names, names+2, side2_null, 0,
+				filemask, dirmask, 1);
+		return mask;
+	}
+
+	/* Similar to above but swapping sides 1 and 2 */
+	if (side2_matches_mbase && filemask == 0x07) {
+		/* use side1 version as resolution */
+		setup_path_info(opt, &pi, dirname, info->pathlen, fullpath,
+				names, names+1, side1_null, 0,
+				filemask, dirmask, 1);
+		return mask;
+	}
+
 	/*
 	 * Gather additional information used in rename detection.
 	 */
-- 
gitgitgadget

