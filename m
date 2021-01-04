Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A66C433E9
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3864E2253D
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbhADXvT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 18:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbhADXvR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 18:51:17 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E20C0617A6
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 15:50:44 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id r9so27681280otk.11
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 15:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aHVe7bKOa7rO3CZHK14AowessT5lSzkarRPSP2gmUMc=;
        b=Ls0jDlIJKxaAkasjgTZ5sXd/j1q0ge+4OMujNH98cwfFwVcEBklQ5z/vviLpmvlyXB
         3FmU88a19q68pCQDB2VrjamwSx9w/JZ7LvRGqVSlmbM3oXCswxfLHiucol/s1LDt2+l1
         dFP8t0eFIHPB5br+RBzawCSy0bXXm5y97qJYpcJ/2gCfmyLmPnEpdpo7QW3TyjT9endK
         sZ6+uagFvrlkHFBOP96RqCdkg/enWNN6MSa5yGDDyn6ugTUpf2voklue6D1t7XKA3l+e
         wMqfrzDfXpnGKgMq13JcbHzByMUaMfVt6PkghUToPtIqpQPg5A3w6YVzjJOf/6UDZF65
         w9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aHVe7bKOa7rO3CZHK14AowessT5lSzkarRPSP2gmUMc=;
        b=MKIn0JVrIR7qeNRbxbjGIkb49P/F9kkWSwA3zUZMgf6olvDIs2o+8Xp+O2LuR07nd/
         cIagfts99AZs92DUufDr90ovvOj3yOJKb/oLVf0rBJY3dISp2SB8gJjzQmu6sdnUq2EF
         YS4u1Uw+EdGnvfVpNAZYsChd4nPPTcwfFcY+HJfjMrkaJUYTnDb+rgw//yWrHVkGWFLW
         UOsbXT6S38FrF9iEm/8+f1ksHKDsAeD/RykF/QqeeegxWHZlni7xTLeZcgmIlhEoh6oC
         wblW1PDl4RlS3aPk2LXghrDI3NM/RmRTua5mgDs/Xq57lMP5d2cpGENXl0KZMOMoCGQU
         Bxrw==
X-Gm-Message-State: AOAM531cRVNok1zrPiNn7O1n0nMtYkmzH/LoGT+xlcAM0Usoz1Qggzih
        Kx3c/HeN1gHCVAizSbORBzhE9ZdjPPQ=
X-Google-Smtp-Source: ABdhPJyHusW8VxnQWLJuyREKhoaSF9sLuyGsPb1pjU8F8+QO5SGB19j4gFTLei2ka1eTmHyIVNOpNg==
X-Received: by 2002:a05:6830:916:: with SMTP id v22mr55765770ott.257.1609804243777;
        Mon, 04 Jan 2021 15:50:43 -0800 (PST)
Received: from tiger.attlocal.net ([2600:1700:bae0:2de0::26])
        by smtp.gmail.com with ESMTPSA id o135sm13359600ooo.38.2021.01.04.15.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 15:50:43 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH 14/17] merge-ort: add a new toplevel_dir field
Date:   Mon,  4 Jan 2021 15:50:03 -0800
Message-Id: <20210104235006.2867404-15-newren@gmail.com>
X-Mailer: git-send-email 2.29.1.106.g3ff750dc32.dirty
In-Reply-To: <20210104235006.2867404-1-newren@gmail.com>
References: <20210104235006.2867404-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Due to the string-equality-iff-pointer-equality requirements placed on
merged_info.directory_name, apply_directory_rename_modifications() will
need to have access to the exact toplevel directory name string pointer
and can't just use a new empty string.  Store it in a field that we can
use.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index d0fb8f4282..230224e680 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -171,12 +171,15 @@ struct merge_options_internal {
 	struct rename_info renames;
 
 	/*
-	 * current_dir_name: temporary var used in collect_merge_info_callback()
+	 * current_dir_name, toplevel_dir: temporary vars
 	 *
-	 * Used to set merged_info.directory_name; see documentation for that
-	 * variable and the requirements placed on that field.
+	 * These are used in collect_merge_info_callback(), and will set the
+	 * various merged_info.directory_name for the various paths we get;
+	 * see documentation for that variable and the requirements placed on
+	 * that field.
 	 */
 	const char *current_dir_name;
+	const char *toplevel_dir;
 
 	/* call_depth: recursion level counter for merging merge bases */
 	int call_depth;
@@ -734,10 +737,10 @@ static int collect_merge_info(struct merge_options *opt,
 	int ret;
 	struct tree_desc t[3];
 	struct traverse_info info;
-	const char *toplevel_dir_placeholder = "";
 
-	opt->priv->current_dir_name = toplevel_dir_placeholder;
-	setup_traverse_info(&info, toplevel_dir_placeholder);
+	opt->priv->toplevel_dir = "";
+	opt->priv->current_dir_name = opt->priv->toplevel_dir;
+	setup_traverse_info(&info, opt->priv->toplevel_dir);
 	info.fn = collect_merge_info_callback;
 	info.data = opt;
 	info.show_all_errors = 1;
-- 
2.29.1.106.g3ff750dc32.dirty

