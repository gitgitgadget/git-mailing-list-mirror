Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932F8C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A285610CE
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242574AbhDLVJC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 17:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242431AbhDLVIr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 17:08:47 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DB4C061756
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:28 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id a4so14339638wrr.2
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CJjXReyOnuxiS+rkr7b3ZvpKZ1VCS6UDhvoKhleGnNw=;
        b=dxNq3lwVlgdq3Ht0PFsUkasSEB+DjcdORysycppwN4UKBjUzgv4DpdH/E0tSiW1rLR
         NZqH3ba0yOyGbtiSG/RwlleHFbnt9bPoJWNSWCkXAxc+8+OWDtolOKfM8/gUHpu/6X+E
         wZbT3a8T+8aXGLSqy4cf1Cz/dvjb9l7v8Z5z3iZAxRSW7sPc49toriRsGW9Sy9nJQyVI
         jgQUyMuYPvYzLSs2ORi5yotyzEjxE/QIAXbI6dSmnRtqBNu8eQwHEUzXEezb3vq3ljEw
         hYt0bOa+700DMa9L6JiLDpq28m/zdHi8fPBDo50o5vXZfX58MMS3Y0q7FTophaqSX0ox
         UrsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CJjXReyOnuxiS+rkr7b3ZvpKZ1VCS6UDhvoKhleGnNw=;
        b=HpYJPOXVDBjc8uXjKz2DyiOTe7bnZqX+wMuJNFPaksFdBqOT2C862w7kmRAIura33v
         MrefWsEp1fu/4Ltji40KBUsmJCd0slyyGnYWYz6xjN9bWqzUwOTAqtsLPOfxB1wESN5T
         QIryvdWw894i5Kt8OURDs/kC1PoBMzCnGZhhv2BdTmXozMTg/n34ui5MNjOGg3phhgLQ
         IO4XTAJ4dvMPnc1keSA08S/B6VW2bSekPjjUW4zFIoR491/4cCctfv/zKLPajUVbTcel
         6/gcKtSztt+TfHcGQdrMQMmQdW6SB+CPlVhNnPIeKvO+teuvzyEHt6Y3clisnzHbJK01
         yTMQ==
X-Gm-Message-State: AOAM533FXW8Qcp2ozUVOgr7wm/pqLASUmzFZs8KqiIgX7HL9jHhtH5Eq
        2BkWAOXAh6e5YsaTkkHMn4r354u+9Eg=
X-Google-Smtp-Source: ABdhPJy1sbCoRdMQBEZnQ1UvstLZ5cdt2TICPGxx+bpt31s2prHleIurTekMpBn1A1QSMhQ8lnY9iw==
X-Received: by 2002:a5d:6e06:: with SMTP id h6mr3589678wrz.201.1618261707545;
        Mon, 12 Apr 2021 14:08:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v3sm475523wmj.25.2021.04.12.14.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 14:08:27 -0700 (PDT)
Message-Id: <6497f2ce225bba4f3706be3e5970f815b767b72d.1618261698.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
References: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
        <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Apr 2021 21:08:04 +0000
Subject: [PATCH v3 13/26] merge-index: ensure full index
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

Before iterating over all cache entries, ensure that a sparse index is
expanded to a full one to avoid unexpected behavior.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/merge-index.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index 38ea6ad6ca25..c0383fe9df9a 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -58,6 +58,8 @@ static void merge_one_path(const char *path)
 static void merge_all(void)
 {
 	int i;
+	/* TODO: audit for interaction with sparse-index. */
+	ensure_full_index(&the_index);
 	for (i = 0; i < active_nr; i++) {
 		const struct cache_entry *ce = active_cache[i];
 		if (!ce_stage(ce))
@@ -80,6 +82,9 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 
 	read_cache();
 
+	/* TODO: audit for interaction with sparse-index. */
+	ensure_full_index(&the_index);
+
 	i = 1;
 	if (!strcmp(argv[i], "-o")) {
 		one_shot = 1;
-- 
gitgitgadget

