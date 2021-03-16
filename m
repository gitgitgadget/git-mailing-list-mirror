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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6791C43331
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B053A6511A
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238928AbhCPQn6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238873AbhCPQnN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 12:43:13 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC64DC06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:43:12 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so4136598wmq.1
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PmQCSE6X5jEApHHEsKgETjtkB8Y7U5YQIJz9rmXLIWU=;
        b=Z0FDi4hNeAat94XYBIiqRbyyXkaFVnQR87Ka0bbh/kGI9o+AXUbIdHn1xTITUs+Pzm
         9bElf4ScvmITOkb9Ft6oekvHBAdBTYgPOpUVLU+SBTRZHoW/o+oxAT9ScFXpFCvJy/JJ
         eoLJWhgjpToJQpiOEKjXxJGFRGrGYsmipM8U+aBPWdE30Sl614LWJXosTU2vQyE3yKjC
         MX7Owa3ChGlJMbSCQ8Nj5aOH48i2l8iJICAf7DINgu3fFP9Av+9yny1bedn2OwDV729j
         P8/d+GMtF1ZT8bx8EQXPJYXyYwmnJoTEiDmiER/bH1t3W9wHB4f1KvtFH3qh1fnbPFnr
         hicg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PmQCSE6X5jEApHHEsKgETjtkB8Y7U5YQIJz9rmXLIWU=;
        b=a+VA25Q+7FkNLz9qYt6x5mrUIjwshoMi/4JsLdSSvDYaR/LPUayQY14JxgE+F44L4l
         wkb1Vq5oanTMaPdNMVYIIXktWLbSEIhCUDwsOqp44ifrpXxQSrWG4JfBs6CxFV36ajkM
         BMN3JqXLpTaaXTXC2m9/RFSpWh/9WTIEQXgqJtJu7oHlJVEX6SuT0CEBzN/DzwA9XWxJ
         9b/mToWoQDK4sbNITYOj7xMJRdev7c3JDVx9tyrhocCa7ncBKvszvrkCFpW8gwze26jU
         lMdbq4Y/alHzvoC3DsYK5/j/ksV1OIGtBtqhIQu41LidsXeiES9n8B96R/BNUceNXO5l
         XiAQ==
X-Gm-Message-State: AOAM532nykPqCjBU2FjxomxTpv0Z2TcG6tLJwi68N+hdEUDMkEiAkzig
        xMA9ceCnmGhRZ3Q7GqEjOevuq1a4pbE=
X-Google-Smtp-Source: ABdhPJyrQb3Ovg+1c741oBFCJMaSfExF6eGyYAZH0IlnjnzjphAwIrTCrXOc4yHw0bp3F2U1xd75AA==
X-Received: by 2002:a7b:cb99:: with SMTP id m25mr516946wmi.64.1615912991594;
        Tue, 16 Mar 2021 09:43:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c9sm8022wml.42.2021.03.16.09.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:43:11 -0700 (PDT)
Message-Id: <4780076a50df8c4db73c04baa95d8654fd04f38b.1615912983.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
References: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
        <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 16:42:52 +0000
Subject: [PATCH v3 09/20] unpack-trees: ensure full index
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
index eb8fcda31ba7..2da3e5ec77a1 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1570,6 +1570,7 @@ static int verify_absent(const struct cache_entry *,
  */
 int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options *o)
 {
+	struct repository *repo = the_repository;
 	int i, ret;
 	static struct cache_entry *dfc;
 	struct pattern_list pl;
@@ -1581,6 +1582,12 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
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

