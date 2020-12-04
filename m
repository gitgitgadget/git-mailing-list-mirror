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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49678C433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E110D22CF6
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbgLDUth (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 15:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729435AbgLDUth (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 15:49:37 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB211C08E85E
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 12:48:22 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id l1so6557155wrb.9
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 12:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XZLXtauf7A66fSwsU7ObDyVwg4P5JldgSKJXv1l6wP0=;
        b=J/Eta9o+dUt/PQ2tBeNw0ZoNMgCA1lIo6FeNOOU4+0KEVQDM54ZkNbAz5ck9js10eH
         qqe8f9CoC3gnDI89tftUAwImv9BmbEf+u4BD//Pv1T3nU/+xP0JRsIVrCoFGnOYga/Uj
         EmqRY5TyZbcrMzbJmA65FvMOKrghfq6rj1LiaTHkf617LNQeIdyZd4Ja7yf9Ti/W8Sek
         KgR35uIc4V5q9SK9t7S/xjGbJPwPeBcJSwhRSHLwwxEPf+iV9vuIBM9cPikqX3H5a4GX
         KjtffTlNdI1IfpjvMtLz4c0+xWPMWMAmwrhrhTmhuMkGVqCKmwndys9e8yu3a0f96c7G
         bgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XZLXtauf7A66fSwsU7ObDyVwg4P5JldgSKJXv1l6wP0=;
        b=exRZFR9dM2iawN3Cl0TqgmmiTg4bObysrZVc+gJYe5ZkliASXiyJpnMS3eoXnh6pY/
         C95bv1CweTfTkg8OIbm938eyquQxhmX9H/BTd/8YHDsPhk0mQftIFoxddSSM1NghEjgj
         T7vOKzmqbRQh//NO3yyBkRwAWguD9ccRCMdlJAAu9ObI+Ye72HnfnVI8IfMwhKqB95KQ
         bJs3jAnvhkQKJJkQK7eX9n/rBZpyDkvQLw4ZpccbacHERonIE9H7vwx9WxDzRERhSXw5
         0p8m510rKx3pT1FiNAK7C1aOjxB04fZVYVzR+vwRvOeB+vyNc0hcEP2DdMU8bmq92IOp
         tQfw==
X-Gm-Message-State: AOAM532WCfj6YasAM9hWo6nFIgii3WduuZhKwXojOUAGQ8gXBSsvrtjD
        Ljr89fCqJjK8rm9dFysHEcNpFPds8Ew=
X-Google-Smtp-Source: ABdhPJyyiOaiIK+uygL4MwFZTOoHYnPhH0G+/2CCeVxDg/FEXjsiU2UbmBnnTVRZBDQ6OUT5pn7Z9w==
X-Received: by 2002:adf:82cc:: with SMTP id 70mr6975137wrc.74.1607114901373;
        Fri, 04 Dec 2020 12:48:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f18sm4842826wru.42.2020.12.04.12.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 12:48:20 -0800 (PST)
Message-Id: <93fd69fa3c6095ea65b55c76c3357ccf642b1ca2.1607114891.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
References: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
        <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Dec 2020 20:47:58 +0000
Subject: [PATCH v2 08/20] merge-ort: compute a few more useful fields for
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
index ab3119d2d8..b4e4c1f157 100644
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

