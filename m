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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D405C43461
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4C946108C
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbhDABuc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 21:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbhDABuI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 21:50:08 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353C6C061574
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:08 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id k8so195514wrc.3
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=icvbxp/b5Ftybmb6oGJlzeU1p7Pw4+4yErHEotpNNtc=;
        b=IUWz1fU36WdSnA7SuNbfbSVZLkzbqdv1jGqePNUDzJjwZoXw4F5WzlV/5DGARkuph4
         bhewh2cBQt6O1dVEGay/eB011qI1zmBQ1MA7p/ROM6Nsi26MjF+B4zrQIDFvKN0s192L
         g3M7OcqQpevbj/BxyW+J5VQKRv0rdtTkNXN1XT+bfz3chrDmUh0HkIO2yER27fgZlM6Q
         l+TenWCTCElk/Jg+B3FQIdta7dCtLkA6dxfHneWfYddBfZRDRbtnyf3/QO8+GM3Uq335
         h9ufs/vag+01Q8YdNXmWIIPudVqRWFzp7iYwIgUGS9lU6bZUEcPf2e4E2BrA2CxOPS80
         0zCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=icvbxp/b5Ftybmb6oGJlzeU1p7Pw4+4yErHEotpNNtc=;
        b=Z0oNpV7AsN55byeM5vvGVySTeKG/KfMtgSaYzTLETfMlYPydUz6n3MoeZ7G5S2CzTU
         jkCX/8Zt34KJR74XVx1nJeqMgmy9qmZHK8a2LwcHf6R8XJGTTn+3NT7YM0SG95UqUUnv
         rtOME3ApQ2zBZ6cVeNKtYKBBds9WzEjc41FVUapYcZNN39IcqcH2F3Gt6ZZk7DgfH+Sm
         aJoIsrS60trCCFAH5uxbzxqzH3ieyTVWS5Grp/19TdR8RzBtX5WKosnGovzYyaIUv5ZL
         AeGQYDkQl+x4/mjllOdeH4LQxuyTV0H/ZL3SMsn0zLCRPeNXSxzkYAjlZj1bGxX/lw4w
         KYHg==
X-Gm-Message-State: AOAM530D84IEghMIFdY/KdWMv8tSwi+O5zmp8mAmC/Yzekb0/joExyeU
        PYU6eLb5i93MW7Z+wJBCjN8Uaft96Jo=
X-Google-Smtp-Source: ABdhPJwgCKZLCSCQRoAtlXZpn3UPAPitPzDKQ1zVcblziclc2D7UTSBwBo3ayIC7ocNnzGFfEvPHSQ==
X-Received: by 2002:adf:e412:: with SMTP id g18mr6834167wrm.159.1617241807061;
        Wed, 31 Mar 2021 18:50:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e8sm6210936wme.14.2021.03.31.18.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 18:50:06 -0700 (PDT)
Message-Id: <db5c100f3e2bc9841e922acca916555eeba194c5.1617241803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
        <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 01:49:41 +0000
Subject: [PATCH v2 04/25] cache: move ensure_full_index() to cache.h
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

Soon we will insert ensure_full_index() calls across the codebase.
Instead of also adding include statements for sparse-index.h, let's just
use the fact that anything that cares about the index already has
cache.h in its includes.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 cache.h        | 1 +
 sparse-index.h | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index 5006278c13ca..b7e20e9778db 100644
--- a/cache.h
+++ b/cache.h
@@ -350,6 +350,7 @@ void add_name_hash(struct index_state *istate, struct cache_entry *ce);
 void remove_name_hash(struct index_state *istate, struct cache_entry *ce);
 void free_name_hash(struct index_state *istate);
 
+void ensure_full_index(struct index_state *istate);
 
 /* Cache entry creation and cleanup */
 
diff --git a/sparse-index.h b/sparse-index.h
index 39dcc859735e..0268f38753c0 100644
--- a/sparse-index.h
+++ b/sparse-index.h
@@ -2,7 +2,6 @@
 #define SPARSE_INDEX_H__
 
 struct index_state;
-void ensure_full_index(struct index_state *istate);
 int convert_to_sparse(struct index_state *istate);
 
 struct repository;
-- 
gitgitgadget

