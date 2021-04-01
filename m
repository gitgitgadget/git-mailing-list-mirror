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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F67C43617
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C08261077
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbhDABuh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 21:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbhDABuM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 21:50:12 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7908BC061762
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:12 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id x13so174970wrs.9
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DOjJ2jNd1O2RVKGUUk1xSCeZyh/PdDSjmF8DqHmFsvk=;
        b=o6SWvgVcqKO5Wt06pA3w16hxHxPwZXMujbmXKWUrRpBXa3+M9142ULayexMaRtrCre
         T8fgMd3c9D3mYHuQZkU6sHPDJ2iJcYhprGLyNN+phl5xK5eL18wDLnD0VaR+w5AGrmE8
         9M+RdQyuw4xP7NzgWGT+O9gZTu35d4x+vmj1bhLS9JvCYKr8oS4EWb3czINe2deu5KpU
         79lWhQFqqw0gDpD+w3kXhhmpv077IImsdAy9EbFY0DeMhK7BacuFOiyE3FbJGOGoCUeD
         w6dE+Va6NYdhYHYkG2arqtEVVsyp+dV0TUFazgRu73jmK9cqQ8eV0WzgsLkq42ry/TIp
         +PQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DOjJ2jNd1O2RVKGUUk1xSCeZyh/PdDSjmF8DqHmFsvk=;
        b=cjZcMZdnCuapvGCqwmKCvFJ8XMM+0VSk+ZfWNuxG819im9xN3tA4hmAMjfdwpE85Ev
         tXvesxqavtnNjG5eHZ6neBgdAmJmjPSBFuDq9wNm483HzFwL32SmrEn+QR+Ydxprav9F
         i6mmrsZRha0B7g5lf7ZZ4xOWBumH+RiPUPas1LoLtUGtynX7oCciEPf3ieB6oV9tOSOz
         cljDkMf3kSLSUhxCVGz49esBtPm8D8bKmBSvDzWeIzhEsztbRTGbkqttvdaEa7WCoZEC
         MAjfUm5CfPN5gaOHC199+hLa78tT56CpxGN2Lkm6/zmTaR+07GqpcT5T5SBRGgC11QbN
         pmaQ==
X-Gm-Message-State: AOAM5338I+Ens8U0EGjQX+8BbgOcfye/PhVXGnAKMpCDXqza0urOf+BK
        QtQ6HM4RLpu7xBHzh4ng54Zfqw374fA=
X-Google-Smtp-Source: ABdhPJw4Bm4NCUPG8wqGv5A5bflNl8Cz/Nsaf7WwKJS0+TsnGvsfBuun7AW7EGNhFKBylXTDa5DUQQ==
X-Received: by 2002:adf:f4c1:: with SMTP id h1mr6694783wrp.71.1617241811332;
        Wed, 31 Mar 2021 18:50:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j30sm8018952wrj.62.2021.03.31.18.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 18:50:11 -0700 (PDT)
Message-Id: <beaa1467cabbdd27b2d8aba4538bfe7232faa116.1617241803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
        <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 01:49:49 +0000
Subject: [PATCH v2 12/25] ls-files: ensure full index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <stolee@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Before iterating over all cache entries, ensure that a sparse index is
expanded to a full one to avoid missing files.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/ls-files.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 4f9ed1fb29b7..a0b4e54d1149 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -317,6 +317,8 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 
 	if (!(show_cached || show_stage || show_deleted || show_modified))
 		return;
+	/* TODO: audit for interaction with sparse-index. */
+	ensure_full_index(repo->index);
 	for (i = 0; i < repo->index->cache_nr; i++) {
 		const struct cache_entry *ce = repo->index->cache[i];
 		struct stat st;
@@ -494,6 +496,8 @@ void overlay_tree_on_index(struct index_state *istate,
 		die("bad tree-ish %s", tree_name);
 
 	/* Hoist the unmerged entries up to stage #3 to make room */
+	/* TODO: audit for interaction with sparse-index. */
+	ensure_full_index(istate);
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
 		if (!ce_stage(ce))
-- 
gitgitgadget

