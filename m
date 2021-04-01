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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF415C43619
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA8D86023F
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbhDABuj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 21:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbhDABuP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 21:50:15 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A003C061574
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:15 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v11so182551wro.7
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7qKugyqjTL3Qic3WcAPItv5DSYivY5GEtPPJAkAOQqc=;
        b=cUky643FgEqggIT8LwTyUSDrFvDFXdcugNdzwG9Ni+6x/p/4+K4SSk/iVAhY/8raio
         xeoLKIFXmGR1q+4jL3TgqLnr0eRd4cBWP2R9/VtPvqyPDi17mLP8h51XX3RPpWk+N75A
         lyDTXLTAnJebH/HTaDKrAIvN2CpKRNdMtwwwWw7PpLvlL6/l59uvbN5FWV/Ut1Sb76sK
         91cf7NMrju96jkkKbAyzYjWJatpYQXfDIzNAnDeq2JFNINbG1TyALskLsRKGSqxjDHys
         CGEMO/1gSzLES7zdPx7uiEeodFoPacT5ZS2b9PWfoz6xba8dQAqjZ1bI/YGYIjPb/D88
         rctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7qKugyqjTL3Qic3WcAPItv5DSYivY5GEtPPJAkAOQqc=;
        b=spqn2CJSPaj2yYe3UK3MyDirmczU3B/uD1o2HGguxlemqCGIxovu5u5EoHFvSAwqL+
         M58mDz+u1xw7SCCmv6pFTEToSjKFMoRN8wn4PT+PgvX2dz1LKe8lnPZnVPInabtYD/lj
         VpsGYweGueUJ1qNq2fehnpTf447hBdwFM6hNT1lGBTJpWpFa5OiEwqEw6D6p7BCG4xYD
         BSoL+jBFVMKkXP3XzBuUeS7TA4h39IaZC83+oUZFryTR1IOWfIau7dECZSgFTDjDh514
         1djsLtYU4w9GDms1R+/zKz6nazghEasa2gMA4ap0LqSmTYc/ePn3J8ybmBQ3CC9HEhAh
         ISlQ==
X-Gm-Message-State: AOAM531dGb93J6cZtQ8ObhSRZr9Bkw58PfW8EPRhAk2seJjOr0egh2DK
        QX3O+xiTtYmxGSSbW0kf9OFg8dUw6VY=
X-Google-Smtp-Source: ABdhPJz7W1xmErRoW1QQLhvkU+NnEXCLMgKfBIMRJ+892/8VsGYVHwFUEANp3A5gaEFHVr1fzJc6hw==
X-Received: by 2002:adf:df10:: with SMTP id y16mr6654107wrl.372.1617241813934;
        Wed, 31 Mar 2021 18:50:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z15sm7236206wrw.50.2021.03.31.18.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 18:50:13 -0700 (PDT)
Message-Id: <fae4c078c3ef8f65dc6673969642a3b35a254ba6.1617241803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
        <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 01:49:54 +0000
Subject: [PATCH v2 17/25] dir: ensure full index
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
expanded to a full index to avoid unexpected behavior.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 dir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/dir.c b/dir.c
index 5b00dfb5b144..166238e79f52 100644
--- a/dir.c
+++ b/dir.c
@@ -3533,6 +3533,8 @@ static void connect_wt_gitdir_in_nested(const char *sub_worktree,
 	if (repo_read_index(&subrepo) < 0)
 		die(_("index file corrupt in repo %s"), subrepo.gitdir);
 
+	/* TODO: audit for interaction with sparse-index. */
+	ensure_full_index(subrepo.index);
 	for (i = 0; i < subrepo.index->cache_nr; i++) {
 		const struct cache_entry *ce = subrepo.index->cache[i];
 
-- 
gitgitgadget

