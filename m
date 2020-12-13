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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB109C433FE
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 08:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94A2522D72
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 08:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404019AbgLMIH5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Dec 2020 03:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393502AbgLMIF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Dec 2020 03:05:59 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3103C061257
        for <git@vger.kernel.org>; Sun, 13 Dec 2020 00:04:41 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id r3so13280466wrt.2
        for <git@vger.kernel.org>; Sun, 13 Dec 2020 00:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=blbyNMGGXSWVTiGKLoyZLBEOol9B9r6IVAGKeByG294=;
        b=PTsyWIndmvh8UuE5h5TN/YLFxIqT+KGQvtjC5iH+1EFDk1U2WSYaYDPAdHh/HoEGEa
         MunXagD+TEmnPabxl53GUCGZD7cZ+fjciaOuqAOI59I8R+OeUxsrFUQML01+HW+OC4kM
         V1ALJjcAsNCVSdCc8kE8o71fEDMkTLEHK7Qd8b5oH6jcR8/LEfdDK2M1849bnCi/YOge
         PNshvzgQ7tU1DD3dDLcdIt/97hTQzgi/0v5i439yJy7cyPStOUZtVuyS6q0wTRmbuv/W
         klFqylFuJ96SX4/uwYZ45JQvEwOECom4SkiUi3Z+uoy498SEUCg565j1abIVTGYwhUR6
         6fkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=blbyNMGGXSWVTiGKLoyZLBEOol9B9r6IVAGKeByG294=;
        b=m46Zr2ZBkc/on/LJmAfgX9mTkTFt3FlDSzzE3x8qrDOJpDh1VlOC2aeY4EqSXS/mMV
         ynvfD26db6lxhJh7san7fK4ze+kWLILEGkGd1xUi44GE+gkoKZcE+LjKqmRH/Jbknuhr
         38GQuz9Ex+uPqpipx8JPzeQwI7z5xRGmTm9OVajgSFq+vYbz54Vol4D+brDrs9ZpTgem
         wxdiqW1hfOK/iUtqcs6eAOM2UmFYF8sxR3L9i0D/0PwnGhCUC/bLqSH8pQGWx+JNsPq1
         vk3Ob5Y5z/X4c5NXuOxrY/8L5IY8A8z2HUFxG6epkGLUrpEAwiplgeK6CrOLyMuOWeeu
         ZLVA==
X-Gm-Message-State: AOAM531XOBoyDZzj4bOJSuvCCkKcJ20FI4RoXidp2aY6Z/3DIF6MuOGw
        RjN0f/X1MjE6ZnO1wAbx5hRlekNsZRE=
X-Google-Smtp-Source: ABdhPJxmVy0G9ZrD0L57Jx+OT31DVQoNNUBEDsbPeaecGYoyT2B8vOEBusYsTXOk7F7Y5Asi0wVGww==
X-Received: by 2002:adf:9d49:: with SMTP id o9mr23319649wre.413.1607846680509;
        Sun, 13 Dec 2020 00:04:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z140sm24954045wmc.30.2020.12.13.00.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 00:04:40 -0800 (PST)
Message-Id: <092e77bbb153048a21a524aeae7ed5f75403452b.1607846667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.git.1607846667.gitgitgadget@gmail.com>
References: <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
        <pull.923.v3.git.git.1607846667.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 13 Dec 2020 08:04:20 +0000
Subject: [PATCH v3 13/20] merge-ort: step 1 of tree writing -- record
 basenames, modes, and oids
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

As a step towards transforming the processed path->conflict_info entries
into an actual tree object, start recording basenames, modes, and oids
in a dir_metadata structure.  Subsequent commits will make use of this
to actually write a tree.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index d83ed8768f5..95369c6a052 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -519,10 +519,31 @@ static int string_list_df_name_compare(const char *one, const char *two)
 	return onelen - twolen;
 }
 
+struct directory_versions {
+	struct string_list versions;
+};
+
+static void record_entry_for_tree(struct directory_versions *dir_metadata,
+				  const char *path,
+				  struct merged_info *mi)
+{
+	const char *basename;
+
+	if (mi->is_null)
+		/* nothing to record */
+		return;
+
+	basename = path + mi->basename_offset;
+	assert(strchr(basename, '/') == NULL);
+	string_list_append(&dir_metadata->versions,
+			   basename)->util = &mi->result;
+}
+
 /* Per entry merge function */
 static void process_entry(struct merge_options *opt,
 			  const char *path,
-			  struct conflict_info *ci)
+			  struct conflict_info *ci,
+			  struct directory_versions *dir_metadata)
 {
 	VERIFY_CI(ci);
 	assert(ci->filemask >= 0 && ci->filemask <= 7);
@@ -530,6 +551,14 @@ static void process_entry(struct merge_options *opt,
 	assert(ci->match_mask == 0 || ci->match_mask == 3 ||
 	       ci->match_mask == 5 || ci->match_mask == 6);
 
+	if (ci->dirmask) {
+		record_entry_for_tree(dir_metadata, path, &ci->merged);
+		if (ci->filemask == 0)
+			/* nothing else to handle */
+			return;
+		assert(ci->df_conflict);
+	}
+
 	if (ci->df_conflict) {
 		die("Not yet implemented.");
 	}
@@ -598,6 +627,7 @@ static void process_entry(struct merge_options *opt,
 	 */
 	if (!ci->merged.clean)
 		strmap_put(&opt->priv->conflicted, path, ci);
+	record_entry_for_tree(dir_metadata, path, &ci->merged);
 }
 
 static void process_entries(struct merge_options *opt,
@@ -607,6 +637,7 @@ static void process_entries(struct merge_options *opt,
 	struct strmap_entry *e;
 	struct string_list plist = STRING_LIST_INIT_NODUP;
 	struct string_list_item *entry;
+	struct directory_versions dir_metadata = { STRING_LIST_INIT_NODUP };
 
 	if (strmap_empty(&opt->priv->paths)) {
 		oidcpy(result_oid, opt->repo->hash_algo->empty_tree);
@@ -636,13 +667,16 @@ static void process_entries(struct merge_options *opt,
 		 */
 		struct merged_info *mi = entry->util;
 
-		if (!mi->clean) {
+		if (mi->clean)
+			record_entry_for_tree(&dir_metadata, path, mi);
+		else {
 			struct conflict_info *ci = (struct conflict_info *)mi;
-			process_entry(opt, path, ci);
+			process_entry(opt, path, ci, &dir_metadata);
 		}
 	}
 
 	string_list_clear(&plist, 0);
+	string_list_clear(&dir_metadata.versions, 0);
 	die("Tree creation not yet implemented");
 }
 
-- 
gitgitgadget

