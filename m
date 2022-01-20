Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0C5C433FE
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 15:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376508AbiATPMX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 10:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346200AbiATPMU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 10:12:20 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FABC06161C
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 07:12:19 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id v123so12782862wme.2
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 07:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AMPYXTx+eFm7luhlSKnYJkvbRFLbh+PvTxpJ8Mh2QOA=;
        b=cIHspsBwTzCzVE5M4aqRkyRLT2fI2Q3mrpJLD/2gtvPkH5oAdKu6HdzmQxJNSRRl1b
         QbMRgYhQznpGgsY5wJHvJ8PSbloOj2K+0CNedg3h+uXTh498WzD0Qw7jd8snwprRMKy2
         rg3PHXPRFehaktZQEOPVVa+FogAE3BvQcWEEwTVEQb46eSr1dyAIw9lw6V7iuEOiuou5
         Mi9cJqpUF8AbSSI5jmN/Vqtl8zbAlIqxR12c4tFlI48H9HEKBSbJOCBlHtMJ4dtlHPL5
         cIDpQm+IgsjQyXAhtDnZlmue1aOk2hfoyUBZAvLSchVZZhgO9o0FyGPDPAwaxF6fp7/2
         AYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AMPYXTx+eFm7luhlSKnYJkvbRFLbh+PvTxpJ8Mh2QOA=;
        b=4gwFXm9oxJKAfoLEkj0x3z7JG0g9Mc5zPt6gG4l8rfLbAAzI8LzAPdtvSQYqM5NX/2
         SO+TH6rua7Br2U+VLq+6qky5dgVP6ahdkRwxRqIsZdXiY5KA2GTRVfKtZnlIPIfnPArS
         3XikmW+qerWQtolF9r4+ay0yqkw36IZPm7yGOmRlau3qJF0ut9n7t/xkK9X1J+FZ97OP
         R5dPEE0cLzU1L2kV5Q2VEZi5Vi05NL5P8R/wTH0tBrkbYZbWBdLOlgxsWF8N7cD3E6UN
         3tKKyRbTFb2T1/WOCPk4CA9/aOWIP4I1VNOMAcVhsV1SYabfGr3WAcsRubLjAWesAdsm
         CQWA==
X-Gm-Message-State: AOAM531nnyHgYq5WZalCxd1iJxv7sFtEjEI18nohhwNfQmSQdql5xmym
        nO6WLd7oHG/LoS+bhUI1+QBN9sv6hpE=
X-Google-Smtp-Source: ABdhPJyv1vKnB8b9mBdnuKDqq2aVtslkAEZw4fdTvfqfXe54a5VbrXKIBejGWVPFvnGEliJnssyfpQ==
X-Received: by 2002:a7b:c042:: with SMTP id u2mr9503989wmc.18.1642691538288;
        Thu, 20 Jan 2022 07:12:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n14sm3368598wri.101.2022.01.20.07.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 07:12:17 -0800 (PST)
Message-Id: <7cf65e141cfb6de7668a06a8d66cc6e254fac691.1642691534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
References: <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
        <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 Jan 2022 15:12:02 +0000
Subject: [PATCH v6 03/15] reftable: fix resource leak blocksource.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Neeraj Singh <nksingh85@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This would be triggered in the unlikely event of fstat() failing on an
opened file.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/blocksource.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/reftable/blocksource.c b/reftable/blocksource.c
index 0044eecd9aa..2605371c28d 100644
--- a/reftable/blocksource.c
+++ b/reftable/blocksource.c
@@ -134,8 +134,10 @@ int reftable_block_source_from_file(struct reftable_block_source *bs,
 	}
 
 	err = fstat(fd, &st);
-	if (err < 0)
-		return -1;
+	if (err < 0) {
+		close(fd);
+		return REFTABLE_IO_ERROR;
+	}
 
 	p = reftable_calloc(sizeof(struct file_block_source));
 	p->size = st.st_size;
-- 
gitgitgadget

