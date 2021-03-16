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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53DFC4361B
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9053A64F91
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbhCPVSS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 17:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233075AbhCPVRa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 17:17:30 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7616BC061762
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:30 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id 61so8174746wrm.12
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7e4AcoLdYIle2Qt79qB+DRM6EytEgeiSq2MMKySkgrI=;
        b=Kz+U+wbUn1/30e4cy0veTJzuUzb56snUBhXqHOYpIioPBAMFr69BGILvjW+srKh7AC
         +c492hY4mknwbX7X69OX5lSkJ4jXOKxeHtt+BmJ1V2O4FTTzX/ptsgO8MdsnGpS5xQFX
         rnDih4KHXdcwmIjJkDI3xBXJrXxaDwhiOCXRk5QLrzosvJr17YVtUAk9ZeYeajVmQLFP
         8cmJjEDsJ23HoXjisqdSOljT6xirt/yXBiJnFogxg6FHABJ0lM9HB26Ju3594XhikrfQ
         45D8NNhTFs4+IDkaF7+LNmj9aB4FV7Qbx1AVeZQi8c4iofuzRB/NrESJPgWfnP9U1sjW
         p9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7e4AcoLdYIle2Qt79qB+DRM6EytEgeiSq2MMKySkgrI=;
        b=suPYzqIC+LeOywU/9mggBPsJCfncrrAEdCnZ+6Ws1P/9F72+dCzJ8riDav61ptSQN5
         I/oWKGhBK6pvUEt9gep5WqNnHk1f1PJKeZH5UrkjfZgkziHUIF4OTBkOt+rQVQ22gDop
         sxdXXg5wAHizZ7JwTjY9DmfLxjiWtcvaG95ahVqEqT0pIjzfYpsJrUWcpRzNVRjJovBp
         QqhfTbUNrFE5sHzjRjzQrlrzbzx/D8ePl0CDZy0GuatUdLVfZrLwoMwjTko/tFznSqEx
         OwHAfzdUp6wLc1FWnnC8vLwaDNTVmarZEua24FuqfRRhacWlLHDc6fFgEUwAFlrj98z1
         4lxA==
X-Gm-Message-State: AOAM53217PAcfpKSxqYcM+W0mqP6DwcEwY5lHPlF9HdMcA7WNMHIC6hV
        VyoXxQkSXLcvCERuNrvVc0r2qY9F894=
X-Google-Smtp-Source: ABdhPJyyZnziEI1ticPWegcOujyLst/1yPGQW+R333YRyz4zvEbFqdKtEbzs4mo7i/UBSBLTvtY4Rw==
X-Received: by 2002:a5d:404f:: with SMTP id w15mr1030290wrp.106.1615929449244;
        Tue, 16 Mar 2021 14:17:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c8sm9739595wrd.55.2021.03.16.14.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 14:17:28 -0700 (PDT)
Message-Id: <8ce1f80985a441b430f8e86b18586f60137d0805.1615929436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.git.1615929435.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 21:17:06 +0000
Subject: [PATCH 18/27] dir: ensure full index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
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
 dir.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dir.c b/dir.c
index 5b00dfb5b144..1c9f61566e66 100644
--- a/dir.c
+++ b/dir.c
@@ -3533,6 +3533,7 @@ static void connect_wt_gitdir_in_nested(const char *sub_worktree,
 	if (repo_read_index(&subrepo) < 0)
 		die(_("index file corrupt in repo %s"), subrepo.gitdir);
 
+	ensure_full_index(subrepo.index);
 	for (i = 0; i < subrepo.index->cache_nr; i++) {
 		const struct cache_entry *ce = subrepo.index->cache[i];
 
-- 
gitgitgadget

