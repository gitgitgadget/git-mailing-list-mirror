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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4D8C07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 13:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7FB0613B7
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 13:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239423AbhGNNPr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 09:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239443AbhGNNPo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 09:15:44 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E80C061768
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 06:12:51 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id w13so1546262wmc.3
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 06:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ss7oOy6Yj3YNaOJhe7iENLeB4Bq6OmgltqDZywOCjk4=;
        b=Isxg+zHz7ObQ3MCuC9mM1gJUJW33HgQ9JP7ddTK+phb0nBBuCXN5oiBfHvxbCh9AP+
         nVRtS5AnBatFd7+Bj+JSogJ6ffUxXZzoRDPeiwmRm335dQ2m4/vM/lgKvDCQfJSzFHhs
         QemMANcPoWdgtkbhwKKIf/0QapvPXFpwq2WjKex4I7w/ur2Ibra3v4cs/Is/nx/mDdcj
         vbaWpeuCOatKYpthKPZksp56pBDuUg1LYHojEa5gkrMobE6BQCA5UMIIN4qk2VRBuLJj
         O311uKsPTmVx9UgHcViEruVDPvPuR/+YgGreAYwEskTGOll/AUuEn5h/V4gYiQjaYJxv
         jr8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ss7oOy6Yj3YNaOJhe7iENLeB4Bq6OmgltqDZywOCjk4=;
        b=dySil5QBwfyms3Be8SjUT78S1sGlBvOLqAaed2onbb+JP3D6qex3wcJDQorhqrlok1
         IRJTzcpSH6D1oN3JRW+XFxctdYIT0axj1x67seOXN15MYfbuO6kiL+PvHABnViITcpuR
         3/0nK166yrso8h9mD/4ycFtlExCdhfi5DZE8wyWiznFwGYhQC3ggRCgJB9T2zIV/RF5N
         HOmio34ryPCjRZI3mb82tmN6QFIbALwlusULJIB/9j4tYBzBsE8HIVt48jJmld7tbL2s
         CRMOt75Bkwv340nZy5y8m/izJkXyAwyaHX+rV3B38tTOXClm12w3wlZUgTv+KuUIPIyw
         28yQ==
X-Gm-Message-State: AOAM532ZqHMCewf08CScDHyTDxSHEhb7txquunQTE+yaKkOkWjG0z+hJ
        5I75864G/G0yRx6+/0yyWLgfuHA1EvI=
X-Google-Smtp-Source: ABdhPJyWdWQ1kPaO/4alkIIEyCkHId20WXmYqc9QBAr4POGIzILB/6IsD9wwcFCTpXziIJ4Km9w3lA==
X-Received: by 2002:a05:600c:a04:: with SMTP id z4mr10901712wmp.103.1626268367897;
        Wed, 14 Jul 2021 06:12:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p11sm2449242wro.78.2021.07.14.06.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 06:12:47 -0700 (PDT)
Message-Id: <0e4b7390f478e89d20e33894b69567e489d69c9b.1626268360.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v9.git.1626268360.gitgitgadget@gmail.com>
References: <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
        <pull.932.v9.git.1626268360.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Jul 2021 13:12:32 +0000
Subject: [PATCH v9 08/16] unpack-trees: rename unpack_nondirectories()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>, git@jeffhostetler.com,
        johannes.schindelin@gmx.de, Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

In the next change, we will use this method to unpack a sparse directory
entry, so change the name to unpack_single_entry() so these entries
apply. The new name reflects that we will not recurse into trees in
order to resolve the conflicts.

Reviewed-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 unpack-trees.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index b113cc750f2..d26386ce8b2 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -804,7 +804,7 @@ static int traverse_by_cache_tree(int pos, int nr_entries, int nr_names,
 		BUG("We need cache-tree to do this optimization");
 
 	/*
-	 * Do what unpack_callback() and unpack_nondirectories() normally
+	 * Do what unpack_callback() and unpack_single_entry() normally
 	 * do. But we walk all paths in an iterative loop instead.
 	 *
 	 * D/F conflicts and higher stage entries are not a concern
@@ -1075,11 +1075,11 @@ static struct cache_entry *create_ce_entry(const struct traverse_info *info,
  * without actually calling it. If you change the logic here you may need to
  * check and change there as well.
  */
-static int unpack_nondirectories(int n, unsigned long mask,
-				 unsigned long dirmask,
-				 struct cache_entry **src,
-				 const struct name_entry *names,
-				 const struct traverse_info *info)
+static int unpack_single_entry(int n, unsigned long mask,
+			       unsigned long dirmask,
+			       struct cache_entry **src,
+			       const struct name_entry *names,
+			       const struct traverse_info *info)
 {
 	int i;
 	struct unpack_trees_options *o = info->data;
@@ -1322,7 +1322,7 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 		}
 	}
 
-	if (unpack_nondirectories(n, mask, dirmask, src, names, info) < 0)
+	if (unpack_single_entry(n, mask, dirmask, src, names, info) < 0)
 		return -1;
 
 	if (o->merge && src[0]) {
-- 
gitgitgadget

