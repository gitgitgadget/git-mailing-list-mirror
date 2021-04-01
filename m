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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7167C433B4
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAC4D6101E
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbhDABub (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 21:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbhDABuI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 21:50:08 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31F4C061761
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:07 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j18so198783wra.2
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gJLBcZut5BdoZ62MD0BUa+X2VnGfeSA3JBLk1DbzHGQ=;
        b=RiLHpllmzBRpvpSNNHUm1faX0KOVHTK1BCTqiedeqkx4CnGQXC9bE3BZh+XnwzbvaY
         4lZqKtmLvHqy8YL2eG4i41VjYLy7k8XZiMYXaYUYP7uZKwNKdch8YVxzK7A7Inrq3J0I
         FE8thFX2lBiedgEQRsSGb1huPup/q2JfoJQwcVfjQOAkfL4WFMWsCNZlF+IZOv8MslnM
         eYz/fse/Sva+FRz6XrvlEEt10ozO4q7vELKtujfhplRQTNa1+GNrjbiHs0EfxA9RJpU7
         urew5ypk/EEzX5BiEsDj5Lax5WsCHfgpBmACkcBXTVY+Mwk0HY9W8id8OwcVzs3W5XH6
         1PRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gJLBcZut5BdoZ62MD0BUa+X2VnGfeSA3JBLk1DbzHGQ=;
        b=p8piZQynJow5GnTGfWrBIiFisYkJdMQzZBSjOb+ts+4MeHxRwD6IQDD3C1MmUphv3A
         U3iKFSbFHV9WVduHecVvgvIC5bjpTrDZxvtDMuDT1jizknhRuBy8r8nXF/oxjuJoKVkd
         KzUBOXBBZ0zINEB1MUXSMNCwobQty5UKIpOt2nvb0r3H9u4bR0yr+p+0LjEKcIND8rM7
         ZZpvdvW/ilftDMDlgv2VCvTyFHAdQibQyU2XL2NX6ZJCR3tK1E6Xo/0wXS4YjfNEaouP
         x8dcV4VNwJ2YuCrl7xTTG/uciOZXOfpkWJQ6PrXkZ4eE9/oSoJQwXryVV0u3ZgEBWADk
         2DxQ==
X-Gm-Message-State: AOAM53309L84ImN72AzAfKRVpECPjBhXr2HQGKEM39YyVI5ob2RSqyXq
        BSvVHRN/7RMFodNgsGsrijSeCaKCCK4=
X-Google-Smtp-Source: ABdhPJynMIj3mYWDJaOBxbcIDknr/r9xrY9gVs+pFuB4jw5LsM7ASIjBqSgDF5gGNdN0+M+RYTgwDQ==
X-Received: by 2002:a5d:5088:: with SMTP id a8mr6737356wrt.294.1617241806578;
        Wed, 31 Mar 2021 18:50:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h9sm6208369wmb.35.2021.03.31.18.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 18:50:06 -0700 (PDT)
Message-Id: <737d27e18d64d7151447eca90e74bf58451cc9a6.1617241803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
        <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 01:49:40 +0000
Subject: [PATCH v2 03/25] read-cache: expand on query into sparse-directory
 entry
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

Callers to index_name_pos() or index_name_stage_pos() have a specific
path in mind. If that happens to be a path with an ancestor being a
sparse-directory entry, it can lead to unexpected results.

In the case that we did not find the requested path, check to see if the
position _before_ the inserted position is a sparse directory entry that
matches the initial segment of the input path (including the directory
separator at the end of the directory name). If so, then expand the
index to be a full index and search again. This expansion will only
happen once per index read.

Future enhancements could be more careful to expand only the necessary
sparse directory entry, but then we would have a special "not fully
sparse, but also not fully expanded" mode that could affect writing the
index to file. Since this only occurs if a specific file is requested
outside of the sparse checkout definition, this is unlikely to be a
common situation.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 read-cache.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index 3ad94578095e..3698bc7bf77d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -567,6 +567,27 @@ static int index_name_stage_pos(struct index_state *istate, const char *name, in
 		}
 		first = next+1;
 	}
+
+	if (istate->sparse_index &&
+	    first > 0) {
+		/* Note: first <= istate->cache_nr */
+		struct cache_entry *ce = istate->cache[first - 1];
+
+		/*
+		 * If we are in a sparse-index _and_ the entry before the
+		 * insertion position is a sparse-directory entry that is
+		 * an ancestor of 'name', then we need to expand the index
+		 * and search again. This will only trigger once, because
+		 * thereafter the index is fully expanded.
+		 */
+		if (S_ISSPARSEDIR(ce->ce_mode) &&
+		    ce_namelen(ce) < namelen &&
+		    !strncmp(name, ce->name, ce_namelen(ce))) {
+			ensure_full_index(istate);
+			return index_name_stage_pos(istate, name, namelen, stage);
+		}
+	}
+
 	return -first-1;
 }
 
-- 
gitgitgadget

