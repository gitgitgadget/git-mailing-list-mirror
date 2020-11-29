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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0F4C83013
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 07:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B61C20809
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 07:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYALl4WA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgK2Hoy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Nov 2020 02:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgK2Hox (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Nov 2020 02:44:53 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81373C061A51
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 23:43:37 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id a3so15343191wmb.5
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 23:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=efzwHOWR7ZtL+4GXk0iNYDjO9FBieaEluKPMU0G8vwM=;
        b=cYALl4WAY1aqPSm8d8k+P1/lZox0OuB/fpCn/8CWBI8S0E38Sl6AZk+27MorHcPQc5
         nxZwBpEmeu7WlvTlpQgBqe2GYRNVd9olhb6NeZH4R26g3q7fB1nnzxAblgd4DGbQUoBC
         UCJnKp+siMVGOuSaJ8zz7/BbSCpyi62QLSMfpSxSs3rkbOKMAMP3NLBdVLNG4aWc/57p
         nlVRM1q78KlbUHhFtNXMhJxkJzEiMS98uDqOup0Sb3B9BPPPTNiv77vuHEdyjdoHgm2b
         5SLLOqDfSu0K3SQg0nlTisW6FqHmpDkJ6DJRNLcGdBtxB16dpRptjmJpDSm6KRwzvx5f
         kpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=efzwHOWR7ZtL+4GXk0iNYDjO9FBieaEluKPMU0G8vwM=;
        b=IlYB6NoBzhXMwj+4ay7654cOKQtMj0uS1j6w475pjY3+m3ez2Xlphd4xBPgS62ASnh
         VdbrJEKIc1j/KZiJnbcLiLOuGYSInrZpe/GMAhqKNI2dh5rA5W6XkmeQoKfLcKkLdHs5
         5K1nXeUv0nMOsQ0XsYwevg+dsV4bDT5X9BKl7W6zZwC0WgPVsEEkudBGBL7atmTXzOeG
         bo+dJFXp54BAaM7x2rg3PTp4LTVMIJLOMDfOAy9tOeDj38LeAV3OmKC5LR3AKfrmjSx4
         2m/GqjIoJu47ofDEsbBDpOoNucL9OTzSbDxiTYnFX+iwe6CZo6/KS9tAg687Itus6C81
         s7fA==
X-Gm-Message-State: AOAM532JOX0bXO73qsaqxuCklnvs4z1w3FU8wawOujUiwdlyxR8TBVNF
        iPdDxkJtwBGYCSeRdvkrfk5om+TFM3s=
X-Google-Smtp-Source: ABdhPJwJwROeMQCo3+4gGO1z8JDojokshdAEOeF+z1KmcUiuQAvhwvCezz5dKgmWlgFkQ8E65lbTdg==
X-Received: by 2002:a7b:c3ce:: with SMTP id t14mr17063575wmj.170.1606635816129;
        Sat, 28 Nov 2020 23:43:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w3sm20599654wma.3.2020.11.28.23.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 23:43:35 -0800 (PST)
Message-Id: <242c3cab1349905af9b645a0a3e213edd49846ad.1606635803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
References: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 29 Nov 2020 07:43:16 +0000
Subject: [PATCH 13/20] merge-ort: step 1 of tree writing -- record basenames,
 modes, and oids
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

As a step towards transforming the processed path->conflict_info entries
into an actual tree object, start recording basenames, modes, and oids
in a dir_metadata structure.  Subsequent commits will make use of this
to actually write a tree.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index eec3b41e7e..970708fff9 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -492,10 +492,31 @@ static int string_list_df_name_compare(const char *one, const char *two)
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
@@ -503,6 +524,14 @@ static void process_entry(struct merge_options *opt,
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
@@ -571,6 +600,7 @@ static void process_entry(struct merge_options *opt,
 	 */
 	if (!ci->merged.clean)
 		strmap_put(&opt->priv->conflicted, path, ci);
+	record_entry_for_tree(dir_metadata, path, &ci->merged);
 }
 
 static void process_entries(struct merge_options *opt,
@@ -580,6 +610,7 @@ static void process_entries(struct merge_options *opt,
 	struct strmap_entry *e;
 	struct string_list plist = STRING_LIST_INIT_NODUP;
 	struct string_list_item *entry;
+	struct directory_versions dir_metadata = { STRING_LIST_INIT_NODUP };
 
 	if (strmap_empty(&opt->priv->paths)) {
 		oidcpy(result_oid, opt->repo->hash_algo->empty_tree);
@@ -609,13 +640,16 @@ static void process_entries(struct merge_options *opt,
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

