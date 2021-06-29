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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B72C11F64
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D96ED61CD5
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbhF2ByS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 21:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhF2ByO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 21:54:14 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D1CC061766
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 18:51:46 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id y3so4253580wrq.3
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 18:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iy9XiTv1ciKF1QkjuiSZgTtadS+h+8sdv46VtmcVxm4=;
        b=XK5hNi0BsPsxedEsu/3uUI6HlE1MKGQy5QyjM5qjPirT5B5IVyOtUjUaEaiCxmPBXA
         HDKm7pR+ncxDM1tbn/nYj9T2lIZ99vszA30r6U+MrDx1mwcAljPDg6KdHfdkyB0gYuIc
         eBV/yhptpwlNcdW+pbo6RIMtxGBnuDdnh8iyss2N/tiT4wsiBc5TTw0CzYcJbvB4ESmW
         8y0b6N1jKyB4rg7lD68KxbREX+0AP80lAtd+LqfH2t0eZhL72M/T8HMhoE3qMJtO/PLj
         +PxZzxGLkC+PFUSzTtOOJ+M4NC7EkbEre7TJFXDa35LruDLZ6ftarI6LJ+EiidvyNs4/
         0eSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iy9XiTv1ciKF1QkjuiSZgTtadS+h+8sdv46VtmcVxm4=;
        b=XJS6MtTy4BXFT+llErqt42rD57jMMGahEzJXDobHRRuY32xMWO06lKFXkJe5t8kA9/
         /AO+S17w3JRb56+q+16SkTJYzKIsAd8BFwNhbNzZ0zqjGvBk+DYiIbdNr36aYQjivv32
         sxep5sWV2rMtd6YuYJ5qHpn+/CpAld1fKj/EmNuGwuyvqmZ4opX8qXnRUGZZWRdLd/RJ
         zZh5LMiqgIjeZqGLG+t3sqDSZ5pkMTDd1boDoruJ1GrodU8LbWyW1Uj5G6dEKJoeeP+X
         1/EpQTZ4x0eWfiKqu2miY2R2Z4bUISzXDRnTXTfUGB1iDpvWIPhNFNdfxOlyeKz2/R6M
         ThSQ==
X-Gm-Message-State: AOAM533wZyokDb/Fm1vuccXya9jz0GlXbTbyPWM1h9jwxxg6WAa/B96y
        trL6IktE7LJfMfIqyIYKd1e+5CGaxVM=
X-Google-Smtp-Source: ABdhPJxxBLQTJ/doqIpncTiVoxZhGlDhHEOcpn+n84fjN0bDrAbmRoysiDVNSVTkImxVw7EDWxvfNQ==
X-Received: by 2002:a5d:5685:: with SMTP id f5mr22680017wrv.101.1624931505176;
        Mon, 28 Jun 2021 18:51:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j35sm1046431wms.7.2021.06.28.18.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 18:51:44 -0700 (PDT)
Message-Id: <f5bae86014d0f76e4dc39560a5e73d5911255bd6.1624931502.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
References: <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
        <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Jun 2021 01:51:30 +0000
Subject: [PATCH v6 02/14] sparse-index: include EXTENDED flag when expanding
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>, git@jeffhostetler.com,
        johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When creating a full index from a sparse one, we create cache entries
for every blob within a given sparse directory entry. These are
correctly marked with the CE_SKIP_WORKTREE flag, but the CE_EXTENDED
flag is not included. The CE_EXTENDED flag would exist if we loaded a
full index from disk with these entries marked with CE_SKIP_WORKTREE, so
we can add the flag here to be consistent. This allows us to directly
compare the flags present in cache entries when testing the sparse-index
feature, but has no significance to its correctness in the user-facing
functionality.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 sparse-index.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sparse-index.c b/sparse-index.c
index 2c695930275..ef53bd2198b 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -213,7 +213,7 @@ static int add_path_to_index(const struct object_id *oid,
 	strbuf_addstr(base, path);
 
 	ce = make_cache_entry(istate, mode, oid, base->buf, 0, 0);
-	ce->ce_flags |= CE_SKIP_WORKTREE;
+	ce->ce_flags |= CE_SKIP_WORKTREE | CE_EXTENDED;
 	set_index_entry(istate, istate->cache_nr++, ce);
 
 	strbuf_setlen(base, len);
-- 
gitgitgadget

