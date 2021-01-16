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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FA3C43381
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 18:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AF132255F
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 18:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbhAPSMX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 13:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727886AbhAPSMF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 13:12:05 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BB4C061575
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 10:11:24 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id l12so7259719wry.2
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 10:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xoRicWyhiUAE/fzJwdKaDkEj93Xq55eXglhkH5BfEFY=;
        b=SFx6sRTbvRmw8JWxL8UtWgHq1tECqIS/F096lkm0SDGldWoTTzRoCl0zuytWm6WYr2
         Lw+934hUMlkOXG2jh1CWNp6mB72vROTY34UsPKy85SzusvRRce6Y7JKezaqsurfpix8t
         qFQNIUIgdmPD+4N22fWB8z73FA9l4wHwE39H/KPDVc9Kn3xpzkL7e3H2sSBHF2q1Y9C7
         tDa0Cd/yC/ZabdPGzpE4uFt+2RHCsxonVo+lNnpQKc7Wp6QNUB67X+OV8Itce4RLPC3e
         h6x905K3t9MTJ9whdmEHvblAHUT+a+a6Wqmxu3uv2xDSigtN3LuIvN2T/1ngNwB6CzfK
         BE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xoRicWyhiUAE/fzJwdKaDkEj93Xq55eXglhkH5BfEFY=;
        b=nN0U/z5IVSELwWcwq7KSrHgaS8h+tixLvVlnBYZ6nGLzO/lTnyMfzZ9Tw1nkzjgu49
         VFbufru4DS7wbRB/2BkSdeBZwsL6y5ctr1Rp7m/VHNyjYByoail2cVBXkGZQ7r6D8Ipo
         THY/2V9AlfUrRlk6STOZXJjyS6YulZUfSByqq9N+ajGFF7iEk+gSGeKut8pzbUpC5TJW
         i6LnDXqgdcAFsetlmtdR+Dm2lxpG0AIgNyy6LSenbyRygdn3i9F1pJwihMHTi3tfIA0X
         iHQfFeMmIgltuqGYBcvwmEHn5BDEe5nmNGcjApQLbLan9SgVlW+d6dNyhNNRQg1FXa0D
         ogPg==
X-Gm-Message-State: AOAM530VSPigx6Ld4SNimeaaeMVKA0zTssB41/ejz3/ClO6YudG+itHn
        mJQonGYy1wMKak2+OMWj/4qPo0EYtvk=
X-Google-Smtp-Source: ABdhPJyFP/Uu8z/GNcH1JPs3C8l5DY63AO8Rsa1GzgplmouYZMwPCqQG73wn/NVI0MlTGKY2WNOFwA==
X-Received: by 2002:adf:e710:: with SMTP id c16mr18978449wrm.295.1610820683006;
        Sat, 16 Jan 2021 10:11:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v6sm6768461wrx.32.2021.01.16.10.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 10:11:22 -0800 (PST)
Message-Id: <05dcb8628186d8a71b84cc3cd2ce4877abee039a.1610820679.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v6.git.1610820679.gitgitgadget@gmail.com>
References: <pull.676.v5.git.1609154168.gitgitgadget@gmail.com>
        <pull.676.v6.git.1610820679.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 16 Jan 2021 18:11:09 +0000
Subject: [PATCH v6 02/11] revision: parse parent in indegree_walk_step()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Taylor Blau <me@ttaylor.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhishek Kumar <abhishekkumar8222@gmail.com>

In indegree_walk_step(), we add unvisited parents to the indegree queue.
However, parents are not guaranteed to be parsed. As the indegree queue
sorts by generation number, let's parse parents before inserting them to
ensure the correct priority order.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 revision.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/revision.c b/revision.c
index 1bb590ece78..be2d828a4cc 100644
--- a/revision.c
+++ b/revision.c
@@ -3397,6 +3397,9 @@ static void indegree_walk_step(struct rev_info *revs)
 		struct commit *parent = p->item;
 		int *pi = indegree_slab_at(&info->indegree, parent);
 
+		if (repo_parse_commit_gently(revs->repo, parent, 1) < 0)
+			return;
+
 		if (*pi)
 			(*pi)++;
 		else
-- 
gitgitgadget

