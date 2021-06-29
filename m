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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A98C11F64
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01AFE61CA3
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbhF2Byf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 21:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbhF2ByT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 21:54:19 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDA1C0617A6
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 18:51:51 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a13so23645151wrf.10
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 18:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cf9nIryTcanflZXsZH2iY6xWOpEH8H2fFRcItvZOPQc=;
        b=KlfMHPf9dtASy5ggCKaaJ/rJWMiVvhkDjGwrISLYm1IKyfztrRK52IvgMPG9l/hrbL
         OirRrkpD9M/1r7BCW/QboTZdlcfYK+URifE1rAlH0Xio4G8pEurMmZ/kMwcq2BnQxT5d
         7P3gR99Wpoz09SqJ0tpqksVPUVc87S0XDLXuwEX58fYU7Vx3k97bxdk+jXmn3lYcL6F+
         9IutEitRVbS84Iihi/J9z9kueTTmYZj72Kw6Fy1AESkdHelZDfNyUPKHOdADob3oUucH
         cRHZYYnvOSZC2wix3+Y6++CsGTK15xB/N2nAS+BwQ/7Z8Q+Djzfw+KAMy6mnM4iUMvM1
         zWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cf9nIryTcanflZXsZH2iY6xWOpEH8H2fFRcItvZOPQc=;
        b=iRbxehrtZuxX8co6jusjJGnfTvb9F+zM5O0X0ruXSi2L/S3cBVLchJuzCzzitc7bN2
         CG6Tr8pIwoh5px1g9Q+PkQfCNA1Nk4pNSp1Ss6nW83cGeLOVBdJWFR/jYJXhV4R7VR4J
         4ZhaQYs2hreFsWGRtFWrSdgqu/VJzMcCbaBYHZZBjIa3rwvypM0Dx/xUFk2QGWazvQna
         7nQ2pgVUrHO6uQmVwc+pE+7GzBdORGI9sthQswCx+0UINtt6B8Jvu723myZrZJRfGPj+
         +YWz1T/X8XJj3rDWUsdEyBATJsv7rqMufcFsdX2VdsJKGnGUbKTwfGSlxbmI8kAX85wI
         ZRuw==
X-Gm-Message-State: AOAM531FoaDR2qJFp8FjJNICa78FcA0weEh5+h4f5D2jcfh0EHBCaRqw
        MxUs6llywh6pDV/gOYFCEL3anYwpjhY=
X-Google-Smtp-Source: ABdhPJw4bVnbY8dsU/Dp9l60m5yHwQLTfRlgQweCFBX/nBXTrYodX9TK+Df2uc8cAKS4c8iJnZFYEg==
X-Received: by 2002:a5d:5182:: with SMTP id k2mr29856431wrv.126.1624931509738;
        Mon, 28 Jun 2021 18:51:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a11sm1220355wrt.71.2021.06.28.18.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 18:51:49 -0700 (PDT)
Message-Id: <ed11cfc791f65fe79db3d39471a6779138370c61.1624931502.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
References: <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
        <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Jun 2021 01:51:38 +0000
Subject: [PATCH v6 10/14] diff-lib: handle index diffs with sparse dirs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>, git@jeffhostetler.com,
        johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

While comparing an index to a tree, we may see a sparse directory entry.
In this case, we should compare that portion of the tree to the tree
represented by that entry. This could include a new tree which needs to
be expanded to a full list of added files. It could also include an
existing tree, in which case all of the changes inside are important to
describe, including the modifications, additions, and deletions. Note
that the case where the tree has a path and the index does not remains
identical to before: the lack of a cache entry is the same with a sparse
index.

Use diff_tree_oid() appropriately to appropriately compute the diff.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 diff-lib.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/diff-lib.c b/diff-lib.c
index c2ac9250fe9..3f32f038371 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -325,6 +325,11 @@ static void show_new_file(struct rev_info *revs,
 	unsigned dirty_submodule = 0;
 	struct index_state *istate = revs->diffopt.repo->index;
 
+	if (new_file && S_ISSPARSEDIR(new_file->ce_mode)) {
+		diff_tree_oid(NULL, &new_file->oid, new_file->name, &revs->diffopt);
+		return;
+	}
+
 	/*
 	 * New file in the index: it might actually be different in
 	 * the working tree.
@@ -347,6 +352,17 @@ static int show_modified(struct rev_info *revs,
 	unsigned dirty_submodule = 0;
 	struct index_state *istate = revs->diffopt.repo->index;
 
+	/*
+	 * If both are sparse directory entries, then expand the
+	 * modifications to the file level.
+	 */
+	if (old_entry && new_entry &&
+	    S_ISSPARSEDIR(old_entry->ce_mode) &&
+	    S_ISSPARSEDIR(new_entry->ce_mode)) {
+		diff_tree_oid(&old_entry->oid, &new_entry->oid, new_entry->name, &revs->diffopt);
+		return 0;
+	}
+
 	if (get_stat_data(istate, new_entry, &oid, &mode, cached, match_missing,
 			  &dirty_submodule, &revs->diffopt) < 0) {
 		if (report_missing)
-- 
gitgitgadget

