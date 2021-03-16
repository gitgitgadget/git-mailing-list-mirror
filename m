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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D371C43603
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0278A6511A
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236183AbhCPQoB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238896AbhCPQnQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 12:43:16 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846ABC061756
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:43:15 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j2so10799205wrx.9
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AD1RbgR+VdmkFM+nbObFdWpWSx5BgYQP2cy/vQr5rpM=;
        b=UK0PeDjfK6gryoss94YdloWQHWOaW25chpEcfmmG7jUeUMHpat+xRkdKnm6Ng2fDCE
         RqVqNqp3D2VWT3xXURn34Ijd2D81ZPc/ujR7d+KUCBDwwzYE2O8S5QlJiTXEMnh7GzLX
         hBLLYAXzniJNR6ooq5XGF11bquOWTNsbnLKB4U5BuYH/T3BV6wg60fvxfj4OiftUHpWS
         XfCO5rxTcLY16/fCdJXRfDSxLga6ZJEwhU72+ZV9LtjO5HznJvbcJoEtJAIuxMqCsR8d
         zaAQMaLaAtttB5eM2wmBGl46YU6xyhsH7RzZpE1hGI9zcdUFFvoyB84NHtnsLlIcrnD2
         zwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AD1RbgR+VdmkFM+nbObFdWpWSx5BgYQP2cy/vQr5rpM=;
        b=DPxoYKbikUwV7L/zT36k1pa6/3tJ2RDm/fhvp0Gfh6EFF/Ge2GX3gN1BkhobCqbNPR
         Io82JFv2h68Sf23aM/+NPHDTkn1DdjROIil3+duBvuvRVmF4ICHKZNPUYLDis1lee/mc
         BIZaEpxy190eaJK4JH/PgW4B0PVhxxZhRhxFo1UhrtQPNFi2W9cIVVQGSdwMfS8ycryI
         5OEYKPgcPCEgdkXPz0jmnGiR9KZTUl+ubxDqdSU68vv7TL5FNOXxKvBBd0v9b3Z/mJ3j
         RtLuMbolqCkkw6szi99GtTSS9NrVJEDPpW7i9cQLX+XLMlkB2ICJQx5qeTkwhsnRb4SZ
         ORxQ==
X-Gm-Message-State: AOAM530GJ00REL1OQpDAj7+aTX3eKjpyYfOiQfWeZU5ITrODOrm91CQY
        VEKrl3Vl+pslJcPjZTKXpEkvUcWMWgc=
X-Google-Smtp-Source: ABdhPJz6wU5za3bntoHldQYSeF1DUKzXFxCw9/qmHmD01cjNn6gJGq1RmNsKGhRWEBDOHOofqQrY/Q==
X-Received: by 2002:adf:f584:: with SMTP id f4mr5956232wro.311.1615912994380;
        Tue, 16 Mar 2021 09:43:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z13sm22315868wrh.65.2021.03.16.09.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:43:14 -0700 (PDT)
Message-Id: <4000c5cdd4cf6008358a02d1b0244b24e61b3e3e.1615912983.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
References: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
        <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 16:42:56 +0000
Subject: [PATCH v3 13/20] unpack-trees: allow sparse directories
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The index_pos_by_traverse_info() currently throws a BUG() when a
directory entry exists exactly in the index. We need to consider that it
is possible to have a directory in a sparse index as long as that entry
is itself marked with the skip-worktree bit.

The 'pos' variable is assigned a negative value if an exact match is not
found. Since a directory name can be an exact match, it is no longer an
error to have a nonnegative 'pos' value.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 unpack-trees.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 2da3e5ec77a1..e81d82d72d89 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -749,9 +749,12 @@ static int index_pos_by_traverse_info(struct name_entry *names,
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

