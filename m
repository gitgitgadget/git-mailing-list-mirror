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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E28DC07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAC5D61154
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235783AbhGLR6u (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 13:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233555AbhGLR6t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 13:58:49 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE804C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 10:56:00 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id i94so26780828wri.4
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 10:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iy9XiTv1ciKF1QkjuiSZgTtadS+h+8sdv46VtmcVxm4=;
        b=SHelQ3fgxULS5Zsn00hKQDlg77bhLtx+qgfHzUrdDgN9+mM/sKObjIyPRXAcSrFcNA
         Q8vt5AWsjeAy7ANXSOvzVxfyf4KHylAQ9o3wAzDFFpOpxSOXJgvENn753Wh0HDF+S9wT
         gRrb0IA2ODEuNpEQRVHYZvgZyG4g+zmPZaNd/bWe6lrQzUnKHO7nRGRRxlt5A5ZNr9p0
         Cp6pGXpc/gCx1tN065kLNICOi5TUm1DMMrHd5aoPC6Xk+2QkiqHYyUpeSN0lxmSUXpHT
         6FGPtdNNgCc6kEs2Y0Hh7EHGz/6kO+9/Y4Y8zPI5bclwV/No0id8mSUzbmcPJvAKzWAR
         MXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iy9XiTv1ciKF1QkjuiSZgTtadS+h+8sdv46VtmcVxm4=;
        b=JEpatjlxP+kqwiVXDw1LNFpVL9R93of4UZH8cHTjLxf3yODawa78N8Eo4aGB2yjj+s
         Ty94AH5tl2taPbRSa83X+OxF+Vg1h0ch+/6w+UoltOTT2HTnTA+XXLRm16cbHb+/Z1ZC
         WLanW6LJsUEdYxbiz4HMsnlW+NWQ+rsoMejg+N5KQNPVfODSrI5CLvJemVbT8+iTmZi0
         CKtCCGpbA8DEsCnGamcCZ4Y+KGj0CqwfuZil3s9yNd0MQdurt8xtVhBGxNC+w+9QlDsZ
         Y3mC9ya6qEyGT3cF9lBfssIrkuYx6JsTd8sH85QcMyXG0suNYnf1u2lqQucYuAuMMYSA
         KcXg==
X-Gm-Message-State: AOAM532e/nDKkzjrgwi1qEKWfgZ8G0zTzO84EoE5jGZRfxLpzQBQOoou
        DqeQlcgoasoGWybNptVGiNGd3sFvI5w=
X-Google-Smtp-Source: ABdhPJysYBH/4/QTQlE9t8lZDPiOOfZ40OwGl6kVrvm38Qt5p1Yr08QC0/IHYrI0PTAN4dWJTVe8Pw==
X-Received: by 2002:a05:6000:1842:: with SMTP id c2mr234680wri.374.1626112559410;
        Mon, 12 Jul 2021 10:55:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h13sm14959154wrs.68.2021.07.12.10.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 10:55:59 -0700 (PDT)
Message-Id: <7bcde075d8db1f89c21213fb92f1d280b8adc032.1626112556.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
References: <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
        <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jul 2021 17:55:43 +0000
Subject: [PATCH v8 02/15] sparse-index: include EXTENDED flag when expanding
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

