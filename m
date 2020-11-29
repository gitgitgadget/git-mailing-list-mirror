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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D28C71155
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 07:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44BE0207CD
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 07:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3/RfjkD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgK2Hou (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Nov 2020 02:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbgK2Hos (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Nov 2020 02:44:48 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E26DC061A49
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 23:43:33 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id 64so10808474wra.11
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 23:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=v6alr+KAGKKe5cHjqzKdUWEZEAwQg4ltW5eGxM4tM2U=;
        b=h3/RfjkDpZew19qNxANMGGRdMSryC3nP3RL+3hgiWozkhTCJCPmUKZv1/d3UXBV2UY
         TNz24+/i6KmVK8wf+a3HUTA9ORDgjdd0YX2ECpbkbwiwVMN8HytxoYbMrFj8pLas2w3d
         JTpQb5suaJPw/THaZwDcUbaSmt3lRiB3Qh+QVQHEOU2WwMfPKf+e0RiLPPJJ7fJxJH4n
         bD4r4uM+wXKMVxIZgGmm/xGTucPjGxiAcszrXh67lXEeBhcdIbvLCbj2jLt8JWETgPP4
         zRD9r5XJW9twm7vRnPOOQwij7NM0G3EDm9vfhPxsvVM8FX1SWKl6UDnCgUbF67KmzeDh
         8Arw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=v6alr+KAGKKe5cHjqzKdUWEZEAwQg4ltW5eGxM4tM2U=;
        b=DtI2omtX/6o4X0IOY4soo3M7WRT4jIWN4GtgnYZD/8lrRXXJ6DtwzaJYHv7qEwn/iN
         s0OEZfP9SHEWd3hPDbKw8jl1Ew674sNmDqw5f09XMmTnUrGP0qTTZYAZ6UcXVnMcjbVs
         Op8TbuX3U35Vq6rWpNf6uCNeKAjgz5CJWJe+WQmM8uM51yIvOZkscy3f/R+3ZXdG00yb
         sl34Iig8gt4YO8wcqkjLBq/jyzauvNXLL1p+Egx1tjfbfyLcROopD81yul8GOohpDpdC
         Yxpq3SoEpHiSi4q1jkWICMtRs7qJ4adKd5Iu9lIb0KwkajFl/wRZkY1FBa3k77lE+dhn
         wxog==
X-Gm-Message-State: AOAM533fsFAc5d6DImD5hN+zq80bAa62oe0+QAqRhVt18TeJPI/UuiLO
        EYPFbzOWVXtl/l6st0q5J6lr48gd6EQ=
X-Google-Smtp-Source: ABdhPJzRHzySTSaKY7TLtkrCsi4u3R+76treoHcMR0TZOG0+wnC2VEM2f3pJ9VSwkKPoYPOAwFEWSQ==
X-Received: by 2002:adf:e801:: with SMTP id o1mr21154270wrm.3.1606635812019;
        Sat, 28 Nov 2020 23:43:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n10sm21939893wrv.77.2020.11.28.23.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 23:43:31 -0800 (PST)
Message-Id: <61b3d66fdcfaf3230c44243e09f3ff9068b2abd5.1606635803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
References: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 29 Nov 2020 07:43:11 +0000
Subject: [PATCH 08/20] merge-ort: compute a few more useful fields for
 collect_merge_info
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

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 820809f67e..e5bca25a8d 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -193,6 +193,7 @@ static int collect_merge_info_callback(int n,
 	size_t len;
 	char *fullpath;
 	unsigned filemask = mask & ~dirmask;
+	unsigned match_mask = 0; /* will be updated below */
 	unsigned mbase_null = !(mask & 1);
 	unsigned side1_null = !(mask & 2);
 	unsigned side2_null = !(mask & 4);
@@ -206,6 +207,22 @@ static int collect_merge_info_callback(int n,
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
@@ -221,6 +238,14 @@ static int collect_merge_info_callback(int n,
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
@@ -239,6 +264,8 @@ static int collect_merge_info_callback(int n,
 	 * so we can resolve later in process_entries.
 	 */
 	ci = xcalloc(1, sizeof(struct conflict_info));
+	ci->df_conflict = df_conflict;
+	ci->match_mask = match_mask;
 	strmap_put(&opti->paths, fullpath, ci);
 
 	/* If dirmask, recurse into subdirectories */
@@ -255,6 +282,15 @@ static int collect_merge_info_callback(int n,
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
 
 		for (i = 0; i < 3; i++) {
 			if (i == 1 && side1_matches_mbase)
-- 
gitgitgadget

