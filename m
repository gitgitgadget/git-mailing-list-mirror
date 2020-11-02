Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F96C2D0A3
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D83F2071A
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uf6rzEJQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgKBUoI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 15:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbgKBUoD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 15:44:03 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CBEC0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 12:44:03 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id i18so9190336ots.0
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 12:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pkcPoDrRjJoW13tugZ4uXzSNmaonzfe2NBzDHxj/ryo=;
        b=Uf6rzEJQZrECSFyoWu6ROCij+MMx96ox7F8fIQ1/FXrGOjYqA7ytKYQmHpCRxepF85
         HgYGVY9SIeAcI5s/FxZvqv7iNbifv0yVFstGdrYAvpA02SGNjlJume2lBYce1vSFh2uQ
         ALr/zE/qq2ZbpOS2SGVZwJOpjZtPE2bdWyuwlQ29ZwIlcPVgZF3HVzBDh7OEeb3GXcgs
         Tn8G5n+Il4J7aZVClG6qGiT+RKnRSO6dVvOEbKiQap45WpMwavKxLC0zH3spJYM+W3SC
         AyEJo0leAyDrdx57RvxeVgO2ZQriC6LMVPBthCf9xk9MGrQHLERcaS6npc1UMTwX7piE
         s8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pkcPoDrRjJoW13tugZ4uXzSNmaonzfe2NBzDHxj/ryo=;
        b=JLNcuFsOQbxfDxYNVB09NJgTU6Vm39jQAddpvpneS9Nzxy/Sk8KMQMXxQc9AES9PA5
         WL9WRCMln7p7WsqBTxtO2INj0EZ9HUbh2TNwdIPSK83Wpq0e5FJLvNo+kUxJ0UJsMELn
         LNFjILwMFUl9Ldzn9ltGxFUXa07/Pv8m62eZ1MBi1EqjgNmvR+2TXxSzV4bljOiKyMVk
         xUhBARprwrAJsr20GLufXZSH5JUGb0QixPnJ4JZFcT3uLAJgtEvJNTO81w/dO9Ji8HIF
         K9YsGWYCBK0rFtuJRp/RHQdk0uiXL18EsZP3imypwtUI3V2URhbttsLh5PpRYog7Dq+Z
         kHMA==
X-Gm-Message-State: AOAM532bKDFdclKxZu7WrgzZTy/WfnSP3h+iyfVmSx9AhIAQj0MWo+eE
        OcVujw89Qr/HHdgO+Dimz2ymDt933MWyjg==
X-Google-Smtp-Source: ABdhPJx56K4CGiMEtWb+KcYpzQ6hrpZzPu+n92OR32vpcVPBoVjgfqquy3Dxk1MwB0v3uqxi/r/1xg==
X-Received: by 2002:a05:6830:17d6:: with SMTP id p22mr14286538ota.154.1604349843021;
        Mon, 02 Nov 2020 12:44:03 -0800 (PST)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id t27sm3848512otc.14.2020.11.02.12.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 12:44:02 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 13/20] merge-ort: step 1 of tree writing -- record basenames, modes, and oids
Date:   Mon,  2 Nov 2020 12:43:37 -0800
Message-Id: <20201102204344.342633-14-newren@gmail.com>
X-Mailer: git-send-email 2.29.0.471.ga4f56089c0
In-Reply-To: <20201102204344.342633-1-newren@gmail.com>
References: <20201102204344.342633-1-newren@gmail.com>
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
index 3d46d62ed3..ff4d455dce 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -350,10 +350,31 @@ static int string_list_df_name_compare(const char *one, const char *two)
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
@@ -433,6 +454,7 @@ static void process_entry(struct merge_options *opt,
 	 */
 	if (!ci->merged.clean)
 		strmap_put(&opt->priv->unmerged, path, ci);
+	record_entry_for_tree(dir_metadata, path, ci);
 }
 
 static void process_entries(struct merge_options *opt,
@@ -442,6 +464,7 @@ static void process_entries(struct merge_options *opt,
 	struct strmap_entry *e;
 	struct string_list plist = STRING_LIST_INIT_NODUP;
 	struct string_list_item *entry;
+	struct directory_versions dir_metadata;
 
 	if (strmap_empty(&opt->priv->paths)) {
 		oidcpy(result_oid, opt->repo->hash_algo->empty_tree);
@@ -458,6 +481,9 @@ static void process_entries(struct merge_options *opt,
 	plist.cmp = string_list_df_name_compare;
 	string_list_sort(&plist);
 
+	/* other setup */
+	string_list_init(&dir_metadata.versions, 0);
+
 	/*
 	 * Iterate over the items in reverse order, so we can handle paths
 	 * below a directory before needing to handle the directory itself.
@@ -470,11 +496,14 @@ static void process_entries(struct merge_options *opt,
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
2.29.0.471.ga4f56089c0

