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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391F4C12002
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 04:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19FCF611C1
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 04:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbhGUDoQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 23:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbhGUDnd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 23:43:33 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DD0C061766
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 21:24:09 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id l7so647879wrv.7
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 21:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ANb4HRB/JZ4hsz38nwl51OvmtaqBsNmH6ehGSjafGmU=;
        b=EUpW4LasaWC9H7c/+GdZHsNNtjTietkviM5TCG3AkzXEd6Cu0IY23wav8v40RS2ime
         BjC07rT8fsy+eY9SslqoR1fUfFsTv5slj0dd4YShrnpOSPaTzw3hTs4Oa23P6Pzamf8W
         fAC1FeAPozJ2iXRmmMx9YxUySXil/AZIF/AD95BP8PdoCyyaX7f6Zi791C3KyhB/ZrxW
         WmmrSPFe0MXGiQQwTlCnbUP2rhXu6LPpQnx5lxV9krqY/3cO/vg7qkMMjsOdoQ0ouO78
         F1TBmrEhgbsybAiEyuJXu3IVk+rELIPRXNOGVnELnwAbR4DQsVUkZ1l/iZXTk4z6OnNM
         sEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ANb4HRB/JZ4hsz38nwl51OvmtaqBsNmH6ehGSjafGmU=;
        b=ItmG6a1OWpleL3S4zHe0vF7FStesmsKedDccs/WByjNJFYH9gyBPKD5HYId0Z9Mr7I
         0b+VbIu2oeC2yCtytVKPV+vCn1SdSTc+10JGouORk9q5Pgi9XYivbmlr09EGLs6Ivb40
         gdV53YOYPnNUgy3708DfzE3yVBGpsFPyVPB9G9v4jxgwjNvi7wpJlDpdgwaNlAkPxVmf
         t4CEG7MTOd4s6EbdVTTXceeS+B4yyx5yU1Fkhi5Poarg03TUdjg0dSDjrsL6Coy7D7zI
         5cYIs8onNo3tdYtdZqkB0Yq/yYutg9rvb8s6nInm4eeU+ilAW0xV87kgmZW5UB8pHQAI
         CEfA==
X-Gm-Message-State: AOAM530ZI0gDFVSQOMIOuqCX94awSZKOtc3T9r9rEGaZ2sArFm32pfKu
        R/QRbTE5Be3dZG0TaJ8i4CKvyNa4jI8=
X-Google-Smtp-Source: ABdhPJxf4b2z649mR+LfJtk+Je44/ysRzrQR/38CBQ153GCQNH0NTTgSIcukVkNQD84H3Krbfmw+Tg==
X-Received: by 2002:adf:e0c4:: with SMTP id m4mr40102043wri.312.1626841448270;
        Tue, 20 Jul 2021 21:24:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l22sm3959037wmp.41.2021.07.20.21.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 21:24:07 -0700 (PDT)
Message-Id: <ff568a612f5559789326108d5fb6d7090a6a56b6.1626841444.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.988.v4.git.1626841444.gitgitgadget@gmail.com>
References: <pull.988.v3.git.1626412958.gitgitgadget@gmail.com>
        <pull.988.v4.git.1626841444.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Jul 2021 04:24:01 +0000
Subject: [PATCH v4 4/7] merge-ort: add a handle_deferred_entries() helper
 function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In order to allow trivial directory resolution, we first need to be able
to gather more information to determine if the optimization is safe.  To
enable that, we need a way of deferring the recursion into the directory
until a later time.  Naturally, deferring the entry into a subtree means
that we need some function that will later recurse into the subdirectory
exactly the same way that collect_merge_info_callback() would have done.

Add a helper function that does this.  For now this function is not used
but a subsequent commit will change that.  Future commits will also make
the function sometimes resolve directories instead of traversing inside.

Acked-by: Derrick Stolee <stolee@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index d9263ec5aca..f0a07684df6 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1202,6 +1202,70 @@ static int collect_merge_info_callback(int n,
 	return mask;
 }
 
+MAYBE_UNUSED
+static int handle_deferred_entries(struct merge_options *opt,
+				   struct traverse_info *info)
+{
+	struct rename_info *renames = &opt->priv->renames;
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
+	int side, ret = 0;
+
+	for (side = MERGE_SIDE1; side <= MERGE_SIDE2; side++) {
+		renames->deferred[side].trivial_merges_okay = 0;
+		strintmap_for_each_entry(&renames->deferred[side].possible_trivial_merges,
+					 &iter, entry) {
+			const char *path = entry->key;
+			unsigned dir_rename_mask = (intptr_t)entry->value;
+			struct conflict_info *ci;
+			unsigned dirmask;
+			struct tree_desc t[3];
+			void *buf[3] = {NULL,};
+			int i;
+
+			ci = strmap_get(&opt->priv->paths, path);
+			VERIFY_CI(ci);
+			dirmask = ci->dirmask;
+
+			info->name = path;
+			info->namelen = strlen(path);
+			info->pathlen = info->namelen + 1;
+
+			for (i = 0; i < 3; i++, dirmask >>= 1) {
+				if (i == 1 && ci->match_mask == 3)
+					t[1] = t[0];
+				else if (i == 2 && ci->match_mask == 5)
+					t[2] = t[0];
+				else if (i == 2 && ci->match_mask == 6)
+					t[2] = t[1];
+				else {
+					const struct object_id *oid = NULL;
+					if (dirmask & 1)
+						oid = &ci->stages[i].oid;
+					buf[i] = fill_tree_descriptor(opt->repo,
+								      t+i, oid);
+				}
+			}
+
+			ci->match_mask &= ci->filemask;
+			opt->priv->current_dir_name = path;
+			renames->dir_rename_mask = dir_rename_mask;
+			if (renames->dir_rename_mask == 0 ||
+			    renames->dir_rename_mask == 0x07)
+				ret = traverse_trees(NULL, 3, t, info);
+			else
+				ret = traverse_trees_wrapper(NULL, 3, t, info);
+
+			for (i = MERGE_BASE; i <= MERGE_SIDE2; i++)
+				free(buf[i]);
+
+			if (ret < 0)
+				return ret;
+		}
+	}
+	return ret;
+}
+
 static int collect_merge_info(struct merge_options *opt,
 			      struct tree *merge_base,
 			      struct tree *side1,
-- 
gitgitgadget

