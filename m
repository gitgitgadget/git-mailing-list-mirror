Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC05C433F5
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 11:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiBIL6U (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 06:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbiBIL5m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 06:57:42 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2360E00FEC8
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 02:59:20 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id n8so1186264wmk.3
        for <git@vger.kernel.org>; Wed, 09 Feb 2022 02:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iFVIor5x+NybBCLTT6A3Tjto5BK5C2mp2lyuL9wLXz4=;
        b=FcnpPSTZ3ZIA1GM32fuJfhLy+h7acCCpwJHQ5FTq3Tj+nslZ4u7ODWH/RRype+2TcY
         oAoXYQXoSO2oRLvP07MyjAdRx2PJBAZeSG/cnJO2cenqIla7uxPdNViW7TzEEgGEYij1
         /7DWFrmGqApifnHJ+wsE7XU4JBxnqUyf5i+uq3449YspKD+k2mJtjwV4thkn3kPeKSmw
         sYGNOSAQ2fTGlnkiPu1SxwSVRVImb3DmHsWKghzsqdW+/9Rq6qEgtlSqMnZV0sFvvQh2
         eAh7tzUKz2yFDQeLsfVy3+4b5kR+1mGZ3cbuRto803MdSa2tw/rVhFk3vvzkxPH/yvPT
         1/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iFVIor5x+NybBCLTT6A3Tjto5BK5C2mp2lyuL9wLXz4=;
        b=VuOC3ANrB3tov9DUADhsUQR+WpOheMBfJI69jk1bFWwYV4/D547DQkJvCENDAxudxl
         OzR0Zw/xDRLvml2oqX7YR+oy9H2ifH4EKmMzlKpCteChj7grCEi1hIvAjLdMJYNYWCE7
         DKserHYDznLtxJctGD5dj/rTyHa28LWHS+8pt3bL1fpjWnRrWKx4tJMrP9y4sUvrtFyy
         HvjcAqCo1pICr1fO0yqiNftcT7wn7zQ0gBzLzZgxPE0ZoY98gRoMz1Z9OPWR9c8XvU/o
         5zWkAZpCVv+/cWtO0FtG9phxAEiyK5e9WDq1ZfG4/5PKanf/TGdfwsmlwcZcbmMUiZKZ
         WNDQ==
X-Gm-Message-State: AOAM531ImVwvAwq8XAeMDm4vE+WM1WnfVlBEVodnDkedwMx4q1aVc2Rd
        2CjRl2cDRr6nj7z0Nauq6DGQWy9FbF8=
X-Google-Smtp-Source: ABdhPJy6ldm8x8g5ZpzIGwvex6tHzGECNujJaUBTA6Uj5vA9CYyp3Wrjce4NXYdsPFz1U+H8kj2UwQ==
X-Received: by 2002:a05:600c:34c2:: with SMTP id d2mr2043438wmq.120.1644404359459;
        Wed, 09 Feb 2022 02:59:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b6sm17988352wrd.29.2022.02.09.02.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 02:59:19 -0800 (PST)
Message-Id: <3e935abba1d1ea6cbf10883acf47edcb0162105c.1644404356.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.git.1644404356.gitgitgadget@gmail.com>
References: <pull.1140.git.1644404356.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Feb 2022 10:59:15 +0000
Subject: [PATCH 3/3] xdiff: handle allocation failure when merging
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Edward Thomson <ethomson@edwardthomson.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Other users of xdiff such as libgit2 need to be able to handle
allocation failures. These allocation failures were previously
ignored.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 xdiff/xmerge.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 48c5e9e3f35..b9d72f0e9f8 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -711,10 +711,18 @@ int xdl_merge(mmfile_t *orig, mmfile_t *mf1, mmfile_t *mf2,
 	status = 0;
 	if (!xscr1) {
 		result->ptr = xdl_malloc(mf2->size);
+		if (!result->ptr) {
+			status = -1;
+			goto out;
+		}
 		memcpy(result->ptr, mf2->ptr, mf2->size);
 		result->size = mf2->size;
 	} else if (!xscr2) {
 		result->ptr = xdl_malloc(mf1->size);
+		if (!result->ptr) {
+			status = -1;
+			goto out;
+		}
 		memcpy(result->ptr, mf1->ptr, mf1->size);
 		result->size = mf1->size;
 	} else {
-- 
gitgitgadget
