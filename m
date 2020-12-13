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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B93FC4361B
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 08:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2FBA22D6F
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 08:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403792AbgLMIGT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Dec 2020 03:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393158AbgLMIFw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Dec 2020 03:05:52 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710B3C0617B0
        for <git@vger.kernel.org>; Sun, 13 Dec 2020 00:04:37 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id i9so13258309wrc.4
        for <git@vger.kernel.org>; Sun, 13 Dec 2020 00:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yfwQ8J3b23+d8uTmuuKp67sJovO5cdSWtQBt3v2Hv7M=;
        b=gxqzDonTrARLsw5rLoi0lIcEEqblfzX+Zk7l+DX3ZI9zSTKZHbG490LnZE4C47HPtw
         Ka/FPGcx+8nvkQFJlgQYawiI7jSzxeiKBFbTNoPcaTs//hMdOhDNlVOlSP4XC567jex9
         FEA9ePrhn9Npr4fJb6IxGXrIBVaSJz2qwQxZwGRy8fCdpGTLtDfBdm893PVcfwq006iP
         62STK4yysozKTaKKAcmZeq9OCYCm17d8cfuiffnH4sArauTvN97suMpwuV9RwjtInKcB
         Sf45RRsKG4hMfSLEF73NfJz8DsrdhmGoaj/FNq1EbZbplgydEheJlJfJcEOIxFVm6dSX
         IUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yfwQ8J3b23+d8uTmuuKp67sJovO5cdSWtQBt3v2Hv7M=;
        b=d7P+JCCHtVQgk3UAwNAxjZ2MCW2KET37A2g0N6pD96aYe7OZp7ITjcCpsFwz5Cac9O
         4q6PJlr1/RkhjafL8PUQRmWUb8AraAw2bBULk4j2IhsHiuuaLKx4OtaQms7XDyCNGuAQ
         V4zS9YCIULMg2KOA7Vjg9qsQVNMyBHBt3Wudz1HBFbOo5aTMqo6X6FxrE076MKOeu+TV
         KFPsFpuDciXbQOrLTHW9shvYy6Ig9Z4x8Cok3wafYFnG90TS1Eetv1gATh3MsfuS2Swh
         BVj2iFB7h17ZNKg8hUUBNDlTPsHXh1znU1WfAFTTHVy1hdAX1Yz8uTlNhvlNy8fKhs4m
         9JyQ==
X-Gm-Message-State: AOAM5333exo9J1Q5Jd96XExQbnjzNj3Zlt1LPWOkB121BpE6Rd7d+q89
        UjnucGas/iwBrXc3umhUkKwaebi2fBs=
X-Google-Smtp-Source: ABdhPJzkabo5dFGrVyzd5H0pAOcT1h4yPCr35XaLQs+60pKrd2yZf7VN/oCTv73+q7qC4XdsuWqT6g==
X-Received: by 2002:a5d:4c45:: with SMTP id n5mr15023374wrt.396.1607846676063;
        Sun, 13 Dec 2020 00:04:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 35sm26750900wrf.9.2020.12.13.00.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 00:04:35 -0800 (PST)
Message-Id: <be5708dc628b23e9f6d9b6088f86f033605759a4.1607846667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.git.1607846667.gitgitgadget@gmail.com>
References: <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
        <pull.923.v3.git.git.1607846667.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 13 Dec 2020 08:04:15 +0000
Subject: [PATCH v3 08/20] merge-ort: compute a few more useful fields for
 collect_merge_info
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, dstolee@microsoft.com,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 690c64fe264..a6876191c02 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -220,6 +220,7 @@ static int collect_merge_info_callback(int n,
 	size_t len;
 	char *fullpath;
 	unsigned filemask = mask & ~dirmask;
+	unsigned match_mask = 0; /* will be updated below */
 	unsigned mbase_null = !(mask & 1);
 	unsigned side1_null = !(mask & 2);
 	unsigned side2_null = !(mask & 4);
@@ -233,6 +234,22 @@ static int collect_merge_info_callback(int n,
 				names[1].mode == names[2].mode &&
 				oideq(&names[1].oid, &names[2].oid));
 
+	/*
+	 * Note: When a path is a file on one side of history and a directory
+	 * in another, we have a directory/file conflict.  In such cases, if
+	 * the conflict doesn't resolve from renames and deletions, then we
+	 * always leave directories where they are and move files out of the
+	 * way.  Thus, while struct conflict_info has a df_conflict field to
+	 * track such conflicts, we ignore that field for any directories at
+	 * a path and only pay attention to it for files at the given path.
+	 * The fact that we leave directories were they are also means that
+	 * we do not need to worry about getting additional df_conflict
+	 * information propagated from parent directories down to children
+	 * (unlike, say traverse_trees_recursive() in unpack-trees.c, which
+	 * sets a newinfo.df_conflicts field specifically to propagate it).
+	 */
+	unsigned df_conflict = (filemask != 0) && (dirmask != 0);
+
 	/* n = 3 is a fundamental assumption. */
 	if (n != 3)
 		BUG("Called collect_merge_info_callback wrong");
@@ -248,6 +265,14 @@ static int collect_merge_info_callback(int n,
 	assert(!mbase_null || !side1_null || !side2_null);
 	assert(mask > 0 && mask < 8);
 
+	/* Determine match_mask */
+	if (side1_matches_mbase)
+		match_mask = (side2_matches_mbase ? 7 : 3);
+	else if (side2_matches_mbase)
+		match_mask = 5;
+	else if (sides_match)
+		match_mask = 6;
+
 	/*
 	 * Get the name of the relevant filepath, which we'll pass to
 	 * setup_path_info() for tracking.
@@ -266,6 +291,8 @@ static int collect_merge_info_callback(int n,
 	 * so we can resolve later in process_entries.
 	 */
 	ci = xcalloc(1, sizeof(struct conflict_info));
+	ci->df_conflict = df_conflict;
+	ci->match_mask = match_mask;
 	strmap_put(&opti->paths, fullpath, ci);
 
 	/* If dirmask, recurse into subdirectories */
@@ -282,6 +309,15 @@ static int collect_merge_info_callback(int n,
 		newinfo.name = p->path;
 		newinfo.namelen = p->pathlen;
 		newinfo.pathlen = st_add3(newinfo.pathlen, p->pathlen, 1);
+		/*
+		 * If this directory we are about to recurse into cared about
+		 * its parent directory (the current directory) having a D/F
+		 * conflict, then we'd propagate the masks in this way:
+		 *    newinfo.df_conflicts |= (mask & ~dirmask);
+		 * But we don't worry about propagating D/F conflicts.  (See
+		 * comment near setting of local df_conflict variable near
+		 * the beginning of this function).
+		 */
 
 		for (i = MERGE_BASE; i <= MERGE_SIDE2; i++) {
 			if (i == 1 && side1_matches_mbase)
-- 
gitgitgadget

