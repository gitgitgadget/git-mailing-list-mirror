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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D5BC433E4
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 13:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CF04619C0
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 13:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhCWNpC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 09:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbhCWNol (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 09:44:41 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99210C061574
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 06:44:39 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id o16so20846944wrn.0
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 06:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=i+gKe8EgHfQlDyjY32XCjj4qcNKDY7Jfl7pEV2IN20w=;
        b=oC7Iz2bkNx8t98Ww3+tqbux9qf824cDkVPz7V3HRB/3RRxugEnhkOkFooe4tY6R//S
         6EbrxMaYLVL1skKLqUTrwuQx0dLWF7SdXmcnQ4UEzSM+MVnlHxmfVJafM6EAPtkl+Jk7
         MuU0KG2nr1HK8BSFoSBbdWcKsUu0dQ/0/OLSY54i2wV355nXYfEu/iflZ/ZdY+ELaNta
         Wo15PSkZTjinXCuBManIHiwVLJzZjR+WnEnDYFshz1Ev9YOWi6esLX6ZJaP/O3/aFH+n
         1Hn0PlhHgivG9TyOWoSLMA3q2eECP5N50EgwodVOhLJAm94tLr4YKXW0pTDt4sDbjDdo
         f2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=i+gKe8EgHfQlDyjY32XCjj4qcNKDY7Jfl7pEV2IN20w=;
        b=AaE1hoGALDR4fmNY7utgZY/tpiAQGm45kVbWt7Br/P1eexvNM0JliQmx5BkYkhNB2b
         kuOcBVtRNBAQqUa9DOUkwqUDEsXgVrfE/yFuNDaLpB1Gy98BSUpAZvkJ/jsLcr8N9UD2
         FDUMKvzqIUYWEIajakK07rgOEzOCN2clzXuSaoeJkIOLyaQshAztt39EoVoB3Cgyr4+R
         M6qDaa0tRKfUlAbgUgeLE901f7AiTCHtQw8rfcQBAPHJ9k0PkLu72IHc81YhqxyruoFf
         LiCTNBPUnh4a5whukCDDZ9w/mUW4Uq+BdU69DIBG0tmhnndklOBhSccq2ot3CqWnB5AU
         IaYQ==
X-Gm-Message-State: AOAM531Nmm7A+WZQpH64Ehqwll1elbdTHVOnMBGS1mR/XsWpnDrZLa7r
        L/peCSs2QicxVBBgprBj9N2Vh0vs7uc=
X-Google-Smtp-Source: ABdhPJw1iJA4Kz5d96Hx6LV4t524Y50ARt7KjTOT/42X1Q2dvfHydryTinm+T+ZGKgj8h3UGA0rPTg==
X-Received: by 2002:a5d:6c67:: with SMTP id r7mr4060627wrz.373.1616507078445;
        Tue, 23 Mar 2021 06:44:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l15sm23475893wru.38.2021.03.23.06.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 06:44:38 -0700 (PDT)
Message-Id: <3ddd5e794b5edc862b6047328f61cad5e6134c9f.1616507069.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
References: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
        <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Mar 2021 13:44:17 +0000
Subject: [PATCH v4 09/20] unpack-trees: ensure full index
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

The next change will translate full indexes into sparse indexes at write
time. The existing logic provides a way for every sparse index to be
expanded to a full index at read time. However, there are cases where an
index is written and then continues to be used in-memory to perform
further updates.

unpack_trees() is frequently called after such a write. In particular,
commands like 'git reset' do this double-update of the index.

Ensure that we have a full index when entering unpack_trees(), but only
when command_requires_full_index is true. This is always true at the
moment, but we will later relax that after unpack_trees() is updated to
handle sparse directory entries.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 unpack-trees.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/unpack-trees.c b/unpack-trees.c
index f5f668f532d8..4dd99219073a 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1567,6 +1567,7 @@ static int verify_absent(const struct cache_entry *,
  */
 int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options *o)
 {
+	struct repository *repo = the_repository;
 	int i, ret;
 	static struct cache_entry *dfc;
 	struct pattern_list pl;
@@ -1578,6 +1579,12 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	trace_performance_enter();
 	trace2_region_enter("unpack_trees", "unpack_trees", the_repository);
 
+	prepare_repo_settings(repo);
+	if (repo->settings.command_requires_full_index) {
+		ensure_full_index(o->src_index);
+		ensure_full_index(o->dst_index);
+	}
+
 	if (!core_apply_sparse_checkout || !o->update)
 		o->skip_sparse_checkout = 1;
 	if (!o->skip_sparse_checkout && !o->pl) {
-- 
gitgitgadget

