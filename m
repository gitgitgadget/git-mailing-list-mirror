Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219FFC4363A
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC09521582
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="li9KhdcW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgJ3Dm6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 23:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgJ3Dmf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 23:42:35 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2565C0613DA
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:41:52 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id j7so5348917oie.12
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8EAdQR7/bcDpixXRS/pkUWch9ufWkYYXtudDe5isTK0=;
        b=li9KhdcWqdRuuL8RKR1swxRrzlMqCIpWMguuw9XO1XGUIUaw2mjxj5k5UMk2yStEbk
         0clkdxDzH5VNSxJer7rq2xC//WmfWLcklHan6hOF91ji5gJ2NM5v2ENdWOEyXZk1uqK9
         XKRtsKLoRnlHxKXVttSDFpGvEhuMCGmyiE1NQw8UeTORjwhSdSz7giVu9YvKEwUZ0LzH
         xQ85V4LtX5YGuDKw6qMMMSWfBzEEJoWBz4bQhTkypRqLqJP1FpARcdrmV41mQA/cEsJB
         VUeJ24DRLvg3nxhoPx8iY5lhSz6WCuDgl4r4GaZmKYWmyB0vzSXtYxVA1Ml+KM/27MWP
         WU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8EAdQR7/bcDpixXRS/pkUWch9ufWkYYXtudDe5isTK0=;
        b=ZePnsd+Sd534POHPDqemSmnSC7Pdh9S4INjg3fNrFmf3LMk86NWANRvOz/GPdirbYT
         KYpsAULkMx6Fa72feZb43RBdcPOSmWdsBprfy8KPyQlYAY3tZmi407W7OkCNJEX63DTb
         8WGZoc0GfHkhkT620qkK7dYzMPCoX+bcCT8WAELgtckOTqzQbHnsgGcrrYZLY0VvzYrH
         ySGPTbJr5ZoDAejiEd7EXVxj4k9b8zn75Htf6sf7vszUdxXnd4SoZs1KhdSti5XO6H0z
         uD5vZyfuAD1Qr3G5J2UtuMQHyHnU4CZorrakn0VO8fyzOfDr81RvHpERYGOHJoHokeHt
         dycA==
X-Gm-Message-State: AOAM530MfXLNILcRiHKzJM7yyg9uM7wEpN5zMOOaGhjvNagcS76KD8ed
        iU92R3DL0oyefik2PzfyzeLmyy6cmDhOKA==
X-Google-Smtp-Source: ABdhPJwuFqB3UY376d873pM4yOeM75f+8nVIEBwfd+jAiZ3znbhwiu0Vm3rDzDtMiPAjI9py3ZpgVw==
X-Received: by 2002:a05:6808:8cc:: with SMTP id k12mr267091oij.179.1604029312115;
        Thu, 29 Oct 2020 20:41:52 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id x13sm1047063otg.66.2020.10.29.20.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 20:41:51 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 09/20] merge-ort: record stage and auxiliary info for every path
Date:   Thu, 29 Oct 2020 20:41:20 -0700
Message-Id: <20201030034131.1479968-10-newren@gmail.com>
X-Mailer: git-send-email 2.29.1.56.ga287c268e6.dirty
In-Reply-To: <20201030034131.1479968-1-newren@gmail.com>
References: <20201030034131.1479968-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a helper function, setup_path_info(), which can be used to record
all the information we want in a merged_info or conflict_info.  While
there is currently only one caller of this new function, and some of its
particular parameters are fixed, future callers of this function will be
added later.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 54 insertions(+), 7 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 86d9b87cb9..60e2b78e2d 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -77,6 +77,50 @@ static int err(struct merge_options *opt, const char *err, ...)
 	return -1;
 }
 
+static void setup_path_info(struct merge_options *opt,
+			    struct string_list_item *result,
+			    const char *current_dir_name,
+			    int current_dir_name_len,
+			    char *fullpath, /* we'll take over ownership */
+			    struct name_entry *names,
+			    struct name_entry *merged_version,
+			    unsigned is_null,     /* boolean */
+			    unsigned df_conflict, /* boolean */
+			    unsigned filemask,
+			    unsigned dirmask,
+			    int resolved          /* boolean */)
+{
+	struct conflict_info *path_info;
+
+	assert(!is_null || resolved);
+	assert(!df_conflict || !resolved); /* df_conflict implies !resolved */
+	assert(resolved == (merged_version != NULL));
+
+	path_info = xcalloc(1, resolved ? sizeof(struct merged_info) :
+					  sizeof(struct conflict_info));
+	path_info->merged.directory_name = current_dir_name;
+	path_info->merged.basename_offset = current_dir_name_len;
+	path_info->merged.clean = !!resolved;
+	if (resolved) {
+		path_info->merged.result.mode = merged_version->mode;
+		oidcpy(&path_info->merged.result.oid, &merged_version->oid);
+		path_info->merged.is_null = !!is_null;
+	} else {
+		int i;
+
+		for (i = 0; i < 3; i++) {
+			path_info->pathnames[i] = fullpath;
+			path_info->stages[i].mode = names[i].mode;
+			oidcpy(&path_info->stages[i].oid, &names[i].oid);
+		}
+		path_info->filemask = filemask;
+		path_info->dirmask = dirmask;
+		path_info->df_conflict = !!df_conflict;
+	}
+	result->string = fullpath;
+	result->util = path_info;
+}
+
 static int collect_merge_info_callback(int n,
 				       unsigned long mask,
 				       unsigned long dirmask,
@@ -91,10 +135,12 @@ static int collect_merge_info_callback(int n,
 	 */
 	struct merge_options *opt = info->data;
 	struct merge_options_internal *opti = opt->priv;
-	struct conflict_info *ci;
+	struct string_list_item pi;  /* Path Info */
+	struct conflict_info *ci; /* pi.util when there's a conflict */
 	struct name_entry *p;
 	size_t len;
 	char *fullpath;
+	const char *dirname = opti->current_dir_name;
 	unsigned filemask = mask & ~dirmask;
 	unsigned match_mask = 0; /* will be updated below */
 	unsigned mbase_null = !(mask & 1);
@@ -157,13 +203,14 @@ static int collect_merge_info_callback(int n,
 	make_traverse_path(fullpath, len+1, info, p->path, p->pathlen);
 
 	/*
-	 * TODO: record information about the path other than all zeros,
-	 * so we can resolve later in process_entries.
+	 * Record information about the path so we can resolve later in
+	 * process_entries.
 	 */
-	ci = xcalloc(1, sizeof(struct conflict_info));
-	ci->df_conflict = df_conflict;
+	setup_path_info(opt, &pi, dirname, info->pathlen, fullpath,
+			names, NULL, 0, df_conflict, filemask, dirmask, 0);
+	ci = pi.util;
 	ci->match_mask = match_mask;
-	strmap_put(&opti->paths, fullpath, ci);
+	strmap_put(&opti->paths, pi.string, pi.util);
 
 	/* If dirmask, recurse into subdirectories */
 	if (dirmask) {
@@ -204,7 +251,7 @@ static int collect_merge_info_callback(int n,
 		}
 
 		original_dir_name = opti->current_dir_name;
-		opti->current_dir_name = fullpath;
+		opti->current_dir_name = pi.string;
 		ret = traverse_trees(NULL, 3, t, &newinfo);
 		opti->current_dir_name = original_dir_name;
 
-- 
2.29.1.56.ga287c268e6.dirty

