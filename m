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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F31C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 01:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27F426113C
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 01:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346726AbhIHBnv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 21:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235180AbhIHBnq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 21:43:46 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F081EC06175F
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 18:42:38 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id y132so485129wmc.1
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 18:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0n87QV9Z/mw0KmAZmpsOxn8gQVw5CMem+cn2Z07qKf8=;
        b=CEMopTY0UaBuwxqRFcbdqPo1XYCY3NSU80ZX1vZkhVDrHaPf8WU4UKqKl2PGw7ZE/A
         rxvuIbo/aOPxoSaId1Ei0iC4mObl13eXxCcrnDfphacwtTCMV0IV7u7gYvBgjvC19b9j
         M2OVflHaAeRa+/w240HzX5wi+U3AHyRn6mxENUusPViIMHIMpOhC4UuaX2+M534EPirj
         Y9XA8duiNzutQ6hresTQbYigWowb0UXxH/oPpIIhzraRe3kyJNb0e61saaB0tPl8wGFS
         Ka1owaHXKBl8Ob8RQKtDR9A2lOkTUoc44wo2336iPVzJ0pRyBu1630anOPa01f7MCmTp
         oTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0n87QV9Z/mw0KmAZmpsOxn8gQVw5CMem+cn2Z07qKf8=;
        b=W2XHTOvgVeEoMgQihuU00+ztjGQFWOYrBXX83utLAyn/orfeLoiJ6TEAfXlVBiX63P
         OPIulBioHuCnE+dXqp17QJT8PTm8MimqopRqIoOJqf1NAX8TEtdnj5lJlgCKbkJLJd7r
         ZbdCAWMYlW/f6NdAJi47R8+5tJb3556jYc4tQIqadDqURXvtUDtHA9KLsU8jmGjjoX5H
         BFArcGboFZfmFKrbJh5WfaYdWkeZOV0VheDWr7/RP4xv6TBRK+cHhdIEvQP5t41RMjyW
         7LmZ8Hsuzbj2yvue0Y+hcZka1OGSxa188fzOhVi+GmyNtK5z5V+5bPdQ8H9vGjwyYfqV
         wLjA==
X-Gm-Message-State: AOAM531Yae1gOOkjeDovXP7IbBgj/mdQrlXf5AaxDczsCTN8wcaYYHK2
        +18ti2fnTVCdK9J8UOrS5wA+PDXRAc4=
X-Google-Smtp-Source: ABdhPJyTocP4gntY/Q4V5EaiZqGaMXRs50blo13CrTfUGeA6j37tZxse/t3+JUsfGxp/lDfUEqIPtw==
X-Received: by 2002:a05:600c:2f90:: with SMTP id t16mr978844wmn.136.1631065357652;
        Tue, 07 Sep 2021 18:42:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o2sm597200wrh.13.2021.09.07.18.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 18:42:37 -0700 (PDT)
Message-Id: <c8620de61eb459c48919fbd4d122bc82cf8ed50a.1631065353.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1009.v5.git.1631065353.gitgitgadget@gmail.com>
References: <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com>
        <pull.1009.v5.git.1631065353.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 01:42:28 +0000
Subject: [PATCH v5 4/9] sparse-index: silently return when cache tree fails
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

If cache_tree_update() returns a non-zero value, then it could not
create the cache tree. This is likely due to a path having a merge
conflict. Since we are already returning early, let's return silently to
avoid making it seem like we failed to write the index at all.

If we remove our dependence on the cache tree within
convert_to_sparse(), then we could still recover from this scenario and
have a sparse index.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 sparse-index.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sparse-index.c b/sparse-index.c
index cd6e0d5f408..d9b07695953 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -178,10 +178,12 @@ int convert_to_sparse(struct index_state *istate)
 
 	/* Clear and recompute the cache-tree */
 	cache_tree_free(&istate->cache_tree);
-	if (cache_tree_update(istate, 0)) {
-		warning(_("unable to update cache-tree, staying full"));
-		return -1;
-	}
+	/*
+	 * Silently return if there is a problem with the cache tree update,
+	 * which might just be due to a conflict state in some entry.
+	 */
+	if (cache_tree_update(istate, 0))
+		return 0;
 
 	remove_fsmonitor(istate);
 
-- 
gitgitgadget

