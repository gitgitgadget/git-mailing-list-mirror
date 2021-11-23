Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC38C433FE
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 00:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhKWAXr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 19:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbhKWAXp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 19:23:45 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88DDC061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 16:20:37 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id y196so17063158wmc.3
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 16:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+eg35DJMCdU5TsE9YAXGI0p0oomtGVacKPQUl53M+C0=;
        b=U9ovAM9t1TPRJfrwPaBGKodWkJ1Gmz78w60NzxB/khTSQgRaU1n691i02CXwUINZVH
         theaXTQXgm4+ejBkZC+9Bhn99A6YDZ4T4n1lPvWp1fL76a1PcLvqAkfQInHkHSs6+3Tm
         Qvt2+39a7IRP1HE4BPJJIhqGRK5f2ncxh7fVCJxaVEeLu+e+l+exGwf1C+mHP822RuM5
         BRLpiwBiK8EoKer6EImQVk8AjsNjyN7lur2K0ocWlBXCbJB7red9AnxMlU65b3V/4CtH
         rL7bIgc+6fhic0KtpWtOLZc505TxXRcfCJL4y70U6yEEvE3Os+l2Rqagq0lHs09oFZOD
         Rt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+eg35DJMCdU5TsE9YAXGI0p0oomtGVacKPQUl53M+C0=;
        b=QugVoryVj/oMUJ0sfgk5v/KFZKPy/iqhzS/zseOGuHKOoIGUZzmx1iIShCg6QFZHpM
         xbjoMEL8VLlhrDpRZCzkrad6OpTtUREeo+WZkbk9Y1nhwdTXkpGZkrsBwAjwquu6CZfa
         8ZikU2jjQ2kSgXsbFjqeoTlEgztB6EhV8dV3c3QdmGNmPX+mILTbtL8EmRdk/c9/qjjW
         o/vM8JJJgjYOBYAre8BdnnOEGJSkgCD3o+BiUWy4sqn4k39t2cEKSu5VYe1LsY1Orlwi
         eVg/YwJN9wZGXul8O4U28/MEVKvB3m4useLb+ZghxkSSzMAPOrDgE50bdoh2FqY+Zq2z
         WuAg==
X-Gm-Message-State: AOAM531e3isL2jgCWfCqsYZUfquMyV5BSNGX6gZzYDZH8IwIemfsnlV0
        HCy4mHd58S6yjj+ydL4JdyoPsWiUVps=
X-Google-Smtp-Source: ABdhPJxsNMSl4p8v/u64Una+O1MbgFKH8tZzRYhACasq/Oi2CrmBRFf7I5eQfYL2Pr4CwOR5lDGnBQ==
X-Received: by 2002:a05:600c:2e46:: with SMTP id q6mr1663357wmf.6.1637626836277;
        Mon, 22 Nov 2021 16:20:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 10sm13353543wrb.75.2021.11.22.16.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 16:20:35 -0800 (PST)
Message-Id: <91351ac4bded2c19264cd2009e90ee71fcf67b81.1637626833.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.v5.git.1637626833.gitgitgadget@gmail.com>
References: <pull.1059.v4.git.1635515487.gitgitgadget@gmail.com>
        <pull.1059.v5.git.1637626833.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Nov 2021 00:20:31 +0000
Subject: [PATCH v5 2/4] sparse-index: avoid unnecessary cache tree clearing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

When converting a full index to sparse, clear and recreate the cache tree
only if the cache tree is not fully valid. The convert_to_sparse operation
should exit silently if a cache tree update cannot be successfully completed
(e.g., due to a conflicted entry state). However, because this failure
scenario only occurs when at least a portion of the cache tree is invalid,
we can save ourselves the cost of clearing and recreating the cache tree by
skipping the check when the cache tree is fully valid.

Helped-by: Derrick Stolee <dstolee@microsoft.com>
Co-authored-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 sparse-index.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/sparse-index.c b/sparse-index.c
index 7b7ff79e044..85613cd8a3a 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -175,17 +175,20 @@ int convert_to_sparse(struct index_state *istate, int flags)
 	if (index_has_unmerged_entries(istate))
 		return 0;
 
-	/* Clear and recompute the cache-tree */
-	cache_tree_free(&istate->cache_tree);
-	/*
-	 * Silently return if there is a problem with the cache tree update,
-	 * which might just be due to a conflict state in some entry.
-	 *
-	 * This might create new tree objects, so be sure to use
-	 * WRITE_TREE_MISSING_OK.
-	 */
-	if (cache_tree_update(istate, WRITE_TREE_MISSING_OK))
-		return 0;
+	if (!cache_tree_fully_valid(istate->cache_tree)) {
+		/* Clear and recompute the cache-tree */
+		cache_tree_free(&istate->cache_tree);
+
+		/*
+		 * Silently return if there is a problem with the cache tree update,
+		 * which might just be due to a conflict state in some entry.
+		 *
+		 * This might create new tree objects, so be sure to use
+		 * WRITE_TREE_MISSING_OK.
+		 */
+		if (cache_tree_update(istate, WRITE_TREE_MISSING_OK))
+			return 0;
+	}
 
 	remove_fsmonitor(istate);
 
-- 
gitgitgadget

