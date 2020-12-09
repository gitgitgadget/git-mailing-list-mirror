Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B5BC433FE
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 19:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C323F2332A
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 19:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387867AbgLITm6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 14:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729345AbgLITmL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 14:42:11 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7A7C0613D6
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 11:41:31 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id y23so2950550wmi.1
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 11:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vc70ZGK6wBOuRDSpqyRxlNy56TEQli53YQsso/1Hg1A=;
        b=V+bPd2CWstMzfKR7mw57emxpmswUG5l30PEka5AKOoJCmNs4NaLOEyVHtj9yVQZ2Hc
         tCQtG4IJs0WCf+2HUnN0UaRQfcsHvuZyCLq9zmb9BjRcknVdKAAvbzErjtfBeyjo8kCy
         vb4H0BZxcgcPwopBMf2uWJy6E5zhaDuc9dCz4vtNOok0IfUpSEe9Lzl/+A8oCBwcdQeB
         Sz00s0Qp5nRIENKLfnLG+jh7ba6cuAF+48HmRGM4Wp0zm041WnEeLI2oigwO5N3j8hdF
         vu+9ZupyfoTF2QZyCQaNaspMfWPMTQvaAzsZYPA5RllDxOS+Nylg/5AN9FIYOYczyS69
         va6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vc70ZGK6wBOuRDSpqyRxlNy56TEQli53YQsso/1Hg1A=;
        b=XOq/BFjX2FBI3cs1hpnWwkNuG+QKklFk12uZZG19O3QPlOelQ0Zq93owWd+XOwsjRS
         frmiWqjvKkAJP7v6v/UeOqHTHVSV2mhVj9+oRQMkhpc/p0EeAn/jmn6JgJu2LHXWAj8x
         VG/josWd/e3O3QNW+BTRIu5zGrdhbEyzTWw2iinrc26W6uDDrbISowli+nFVBdqC6DEP
         Oy+GUO/tntjF0wGvcdk2eHi2tP4lz83WwN8Gs7LMvEd/+ItU5Pzt91hbl516tKXFPzfY
         2lTrCBUvmAFiOqTouCYijETjWil4IzhnTa1hpCbi2j4zDFDFdqep7eDf/VreM93W3aiP
         6EUQ==
X-Gm-Message-State: AOAM532Hn8lVnAvq7MJCHkqevrMf9pPBRV0VAHNuxfxPUUrEFOzCnTzP
        sQ9jwlO3Uob/M6rwGa9t8PtDrUsJTBE=
X-Google-Smtp-Source: ABdhPJyaaNtpHi5LWyuHTPYlyh0jFBv7bWXcHAByB2VYN7tW9y0qGdfuTagN72bip1jfaCsIQphWIw==
X-Received: by 2002:a1c:1c1:: with SMTP id 184mr4390333wmb.112.1607542889877;
        Wed, 09 Dec 2020 11:41:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w3sm5115874wma.3.2020.12.09.11.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 11:41:29 -0800 (PST)
Message-Id: <ef8f315f828319a3390fde14e3aee6c5e587405e.1607542887.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.812.git.1607542887.gitgitgadget@gmail.com>
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Dec 2020 19:41:17 +0000
Subject: [PATCH 01/11] merge-ort: add basic data structures for handling
 renames
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This will grow later, but we only need a few fields for basic rename
handling.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index ef143348592..90baedac407 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -29,6 +29,25 @@
 #include "unpack-trees.h"
 #include "xdiff-interface.h"
 
+struct rename_info {
+	/*
+	 * pairs: pairing of filenames from diffcore_rename()
+	 *
+	 * Index 1 and 2 correspond to sides 1 & 2 as used in
+	 * conflict_info.stages.  Index 0 unused.
+	 */
+	struct diff_queue_struct pairs[3];
+
+	/*
+	 * needed_limit: value needed for inexact rename detection to run
+	 *
+	 * If the current rename limit wasn't high enough for inexact
+	 * rename detection to run, this records the limit needed.  Otherwise,
+	 * this value remains 0.
+	 */
+	int needed_limit;
+};
+
 struct merge_options_internal {
 	/*
 	 * paths: primary data structure in all of merge ort.
@@ -96,6 +115,11 @@ struct merge_options_internal {
 	 */
 	struct strmap output;
 
+	/*
+	 * renames: various data relating to rename detection
+	 */
+	struct rename_info *renames;
+
 	/*
 	 * current_dir_name: temporary var used in collect_merge_info_callback()
 	 *
@@ -1356,6 +1380,7 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 
 	/* Initialization of opt->priv, our internal merge data */
 	opt->priv = xcalloc(1, sizeof(*opt->priv));
+	opt->priv->renames = xcalloc(1, sizeof(*opt->priv->renames));
 
 	/*
 	 * Although we initialize opt->priv->paths with strdup_strings=0,
-- 
gitgitgadget

