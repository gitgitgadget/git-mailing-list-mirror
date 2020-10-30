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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5353EC4742C
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0F102098B
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjOL6ZrT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgJ3Dml (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 23:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgJ3Dmf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 23:42:35 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73281C0613DE
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:41:57 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id x203so5353472oia.10
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uSLjR+mw4410C/7AntQ68xJsxwFe3uCoyAyu8gQ9huU=;
        b=FjOL6ZrTxpnxD92uIQlmFxa2BPNA1LvOG/2iyldRlhe8e3GzVQrX16X/MCihIPzjww
         uhzcq3K30UuCBVIdB8PBAaAr8C0SOzTiAtrXgyCPZy1ndgXeIOQcOfGgOKGd29whVZRF
         ec0DK2OHjgIOYLpfberEL5Nmjh9LQtId75sU0IGSNWsbmXXmSmzcvqnpz3/4BGB4D85v
         qKQYX9Ouc/NtoKVnvgVXQ7vbpLjNJBUr3CNMy8pIyblCPHKLHwykgZ0XQI7YTaCNHMGF
         UWfC7EOSz64sx2KaUFdYd6sWvDVTyvzWjfA+HwRKU/h/UzTAJMMxoW6dmtmxSfNczcpk
         /BWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uSLjR+mw4410C/7AntQ68xJsxwFe3uCoyAyu8gQ9huU=;
        b=gY35EPik/av2rMKWX5fiY2vLR3UACWVuO4Up37YROdAt8kHd0sCt3laz5hF3BUo28H
         +OcKbn50zlO/OeDu3FJYRnD/JRtyrkvSCbBj6u7V5L3jH4P9VhpnajOvUM6dt3WqNlEH
         uTIl6R3JFjT4sk/yUY/do2ZrwZ65mUEJaI4W2DhaMVO/oc/ZxOBGtV869LjZilEnBd/V
         /WNG7sdN7joJBHYLVuDbhiqRTMmd+cII6TUzxhCApqafjv7MclPYgmNxA08WbWmJrVAe
         y0ED6DPw2VDjn7mb+mB9K0O/a6vsWOK+OQqGDBaeZI3j1ozacCP5/CSVw3sALWj0jH7A
         RKqQ==
X-Gm-Message-State: AOAM531JRzrsrYsfDbXu/3ouKWDichAyPsDphR8nbUo7BurUpCgbVReg
        brN/stYpVReAiYVd7+YH1Tv+mGnxk60e6w==
X-Google-Smtp-Source: ABdhPJxtryXmHnJ2ipWG77vUK3chVa4LfW6oYbl3Mb2jol4UDD68i7rieTC53wt2zsC72nuHphePew==
X-Received: by 2002:aca:383:: with SMTP id 125mr240744oid.171.1604029316653;
        Thu, 29 Oct 2020 20:41:56 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id x13sm1047063otg.66.2020.10.29.20.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 20:41:56 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 13/20] merge-ort: step 1 of tree writing -- record basenames, modes, and oids
Date:   Thu, 29 Oct 2020 20:41:24 -0700
Message-Id: <20201030034131.1479968-14-newren@gmail.com>
X-Mailer: git-send-email 2.29.1.56.ga287c268e6.dirty
In-Reply-To: <20201030034131.1479968-1-newren@gmail.com>
References: <20201030034131.1479968-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As a step towards transforming the processed path->conflict_info entries
into an actual tree object, start recording basenames, modes, and oids
in a dir_metadata structure.  Subsequent commits will make use of this
to actually write a tree.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 31c16edd3d..17159df5db 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -351,10 +351,31 @@ static int string_list_df_name_compare(const char *one, const char *two)
 	return onelen - twolen;
 }
 
+struct directory_versions {
+	struct string_list versions;
+};
+
+static void record_entry_for_tree(struct directory_versions *dir_metadata,
+				  const char *path,
+				  struct conflict_info *ci)
+{
+	const char *basename;
+
+	if (ci->merged.is_null)
+		/* nothing to record */
+		return;
+
+	basename = path + ci->merged.basename_offset;
+	assert(strchr(basename, '/') == NULL);
+	string_list_append(&dir_metadata->versions,
+			   basename)->util = &ci->merged.result;
+}
+
 /* Per entry merge function */
 static void process_entry(struct merge_options *opt,
 			  const char *path,
-			  struct conflict_info *ci)
+			  struct conflict_info *ci,
+			  struct directory_versions *dir_metadata)
 {
 	assert(!ci->merged.clean);
 	assert(ci->filemask >= 0 && ci->filemask <= 7);
@@ -434,6 +455,7 @@ static void process_entry(struct merge_options *opt,
 	 */
 	if (!ci->merged.clean)
 		strmap_put(&opt->priv->unmerged, path, ci);
+	record_entry_for_tree(dir_metadata, path, ci);
 }
 
 static void process_entries(struct merge_options *opt,
@@ -443,6 +465,7 @@ static void process_entries(struct merge_options *opt,
 	struct strmap_entry *e;
 	struct string_list plist = STRING_LIST_INIT_NODUP;
 	struct string_list_item *entry;
+	struct directory_versions dir_metadata;
 
 	if (strmap_empty(&opt->priv->paths)) {
 		oidcpy(result_oid, opt->repo->hash_algo->empty_tree);
@@ -459,6 +482,9 @@ static void process_entries(struct merge_options *opt,
 	plist.cmp = string_list_df_name_compare;
 	string_list_sort(&plist);
 
+	/* other setup */
+	string_list_init(&dir_metadata.versions, 0);
+
 	/*
 	 * Iterate over the items in reverse order, so we can handle paths
 	 * below a directory before needing to handle the directory itself.
@@ -471,11 +497,14 @@ static void process_entries(struct merge_options *opt,
 		 */
 		struct conflict_info *ci = entry->util;
 
-		if (!ci->merged.clean)
-			process_entry(opt, path, ci);
+		if (ci->merged.clean)
+			record_entry_for_tree(&dir_metadata, path, ci);
+		else
+			process_entry(opt, path, ci, &dir_metadata);
 	}
 
 	string_list_clear(&plist, 0);
+	string_list_clear(&dir_metadata.versions, 0);
 	die("Tree creation not yet implemented");
 }
 
-- 
2.29.1.56.ga287c268e6.dirty

