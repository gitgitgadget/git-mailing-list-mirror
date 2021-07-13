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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACC0C11F66
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 19:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C3626128E
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 19:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbhGMTf7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 15:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhGMTf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 15:35:58 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E8EC0613E9
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 12:33:08 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r11so98637wro.9
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 12:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jTYYZdm9bq7NPN5b67LXlVdIpBH+R0ThjCtl7RWxqOU=;
        b=uDpxEY5zdZlihGcPytYNdF0HjQew3eRlYI2/MibSAubbQeMPnsGk+pOYYQzZdVP+/N
         ZWA+WG0xFZaHf4x4DJVjIaLBUYaTwDBYIihV1opMxlUUsOyxMFEQYsmaf1QrbllplBI1
         z2O6Cy+D4A1q81kDPM7XHGLet3MbZD7bXGzuM/lzc9ZkWozSuqRQ1ehn07y/srtb52Rj
         ljwBfa/HRLGGjbhIdrFhMdMcoT7gx3Wlmn/xcwHC1JrtrbZekbQJEgZnvQ8GNjgF0d8T
         WnL0vqp2mgpbx6CTRDX+ZuMHT1HegPLUNGYcAa2bHLSh7Mne9gE+YLOBVxxMlevFSneB
         ABSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jTYYZdm9bq7NPN5b67LXlVdIpBH+R0ThjCtl7RWxqOU=;
        b=qMMbLe5MsIdp7eQHdZ7YcOLz3Jb/EdTfXcAo0FMHi8Gv6rzPDaPT0m72SGHzr1+M8z
         /0CJW8wwWidkjJuPG6yy1x3uBgWYd4yEjER1HozaoYT1JwkS1EOfVvi8w4+FTzHXM2dX
         JrRCLJu8V6vENMpoAiWqjV0PZs1/qWHUMCDvmde0rcv1+sbe3vH+ysS86/AwmxH5IMeR
         w+Jf3iijdE0dWcQzdhEHemV2cMW/LNP5h7Qpv/Baqkbsv7zUQ1VUNyW6NMahfOQwOe6w
         HuAaPS/xrl4Ss5fpJ8ELfoiTkjliBPpGueLCjjiuIWLhEvXQGNsNTCQXf8JruFAvdVYn
         8SwQ==
X-Gm-Message-State: AOAM5320GQBo9896dczumWPHqVdpHN6QwoRyfJ93Ka1bLCrpKrK2pp8I
        81C0N8x8V0yqYpGn2YOWOpK6yMJN57A=
X-Google-Smtp-Source: ABdhPJyeddWyVZx45z/3BoD113UCAhRah/iRzoKvh0Ncq1B8T34j+/tdY/BjxXyL+06VeF9Hb4yt8g==
X-Received: by 2002:adf:f9cb:: with SMTP id w11mr7933189wrr.57.1626204787079;
        Tue, 13 Jul 2021 12:33:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o29sm14478023wms.13.2021.07.13.12.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 12:33:06 -0700 (PDT)
Message-Id: <8aea3713902b7d006f527ccd76faf6f944529bdb.1626204784.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.988.v2.git.1626204784.gitgitgadget@gmail.com>
References: <pull.988.git.1625111177.gitgitgadget@gmail.com>
        <pull.988.v2.git.1626204784.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Jul 2021 19:32:58 +0000
Subject: [PATCH v2 2/7] merge-ort: add some more explanations in
 collect_merge_info_callback()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
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

