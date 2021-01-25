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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A59C433E0
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 18:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D3BF22C9E
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 18:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731128AbhAYSN1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 13:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731109AbhAYRzW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 12:55:22 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282FBC061356
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:27 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d16so13147125wro.11
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZLJFWeKJGZmF+8ekApYC8LfnEGt9a2eaYNT3MSN9DOM=;
        b=E40ybx291ptWFZxcQnwZm3IbEQB/h0OxwZ1ta6bfoco3MLYybCwnx1B984A/s90mAq
         M4A4u7v32Wu1SRVhpnggy6hNFVkRcZvbwPDx2PZ7MJETN2QC49QtHpOQfZKNhQoHjDAs
         a3i+jL05vFcLS0k5YNSxcDwlG+Zj+oEc8bEWG6qwTCKP+s927rPTzzOaCEySl2Tl5wlY
         XpJzXt1tkCb587jvCEOiBqU+afq2YB8qrjjajSchU8v6gdCVNzXORd/RE2noiQMQZ3Ub
         sOiC7BnNbJZzbNNYLUBqOR+nFfyEorfbKfbq/m7umAcuV73Ayj/q5hZaa4kDOf/ojfyM
         2Ccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZLJFWeKJGZmF+8ekApYC8LfnEGt9a2eaYNT3MSN9DOM=;
        b=EeCsZyTWOBHJFH3TElWUkOScddrRyafYS5aKCRlT90TR6vgOe2CmnXYa9B2SuazBn0
         hlNmIbu98nqMApJNoQIeseq6rbOWGNWsD9dMQywpPoInNoi76UKWOfqjJBOh9z856eyP
         m3VKoPKDJIuZWGHoxBhQXBbE48VreChP7fOn6xddnrdnSZlW99GgIiLvkBDJQ0ND7ZeP
         0yem7AAGaFOMn/R3qIfXRaotoFZ2MxbMxZviUQNCv1Rc8qzuyIZLdbx0DlmUUMPBVVSX
         tl8qADLWLIGfkOZ72GWv0KugWJRYTJInR9OTsfNURhK3/HBrjGkmZDmc6au9gKMqTQo1
         bc3w==
X-Gm-Message-State: AOAM533PvJRST5rL6cyKtNEhjmMaGy+EocusBqJLjbcNynhQBug5ad9a
        EvwgGbp+jFJS4n6zC56EdIIaP6ONPt4=
X-Google-Smtp-Source: ABdhPJyXpftGXS9mZyraCNIhMmorQ17CbkqOoX94CBbG/aR/hWqTwHqEXTy2rWSIOxw4zblsX9RcEg==
X-Received: by 2002:adf:ba0c:: with SMTP id o12mr2210839wrg.322.1611596545806;
        Mon, 25 Jan 2021 09:42:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u7sm11259152wrr.80.2021.01.25.09.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 09:42:25 -0800 (PST)
Message-Id: <09893b4a6bbe13e61395411bdae57ce041829042.1611596534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.git.1611596533.gitgitgadget@gmail.com>
References: <pull.847.git.1611596533.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Jan 2021 17:41:57 +0000
Subject: [PATCH 11/27] unpack-trees: allow sparse directories
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, peff@peff.net,
        jrnieder@gmail.com, sunshine@sunshineco.com, pclouds@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The index_pos_by_traverse_info() currently throws a BUG() when a
directory entry exists exactly in the index. We need to consider that it
is possible to have a directory in a sparse index as long as that entry
is itself marked with the skip-worktree bit.

The negation of the 'pos' variable must be conditioned to only when it
starts as negative. This is identical behavior as before when the index
is full.

The starts_with() condition matches because our name.buf terminates with
a directory separator, just like our sparse directory entries.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 unpack-trees.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 4dd99219073..b324eec2a5d 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -746,9 +746,12 @@ static int index_pos_by_traverse_info(struct name_entry *names,
 	strbuf_make_traverse_path(&name, info, names->path, names->pathlen);
 	strbuf_addch(&name, '/');
 	pos = index_name_pos(o->src_index, name.buf, name.len);
-	if (pos >= 0)
-		BUG("This is a directory and should not exist in index");
-	pos = -pos - 1;
+	if (pos >= 0) {
+		if (!o->src_index->sparse_index ||
+		    !(o->src_index->cache[pos]->ce_flags & CE_SKIP_WORKTREE))
+			BUG("This is a directory and should not exist in index");
+	} else
+		pos = -pos - 1;
 	if (pos >= o->src_index->cache_nr ||
 	    !starts_with(o->src_index->cache[pos]->name, name.buf) ||
 	    (pos > 0 && starts_with(o->src_index->cache[pos-1]->name, name.buf)))
-- 
gitgitgadget

