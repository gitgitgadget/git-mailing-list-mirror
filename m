Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891B9C4346E
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 13:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 555692389F
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 13:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mi6uEfrA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgI0NQS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 09:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgI0NQP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 09:16:15 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70401C0613CE
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 06:16:15 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id n25so6136656ljj.4
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 06:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1zWAzbbGyNF4ujqsy3ndtQc7P0WBsL0MXLnk6Y9t6lw=;
        b=mi6uEfrAqHudX8d+Yo5tg5KCf7T2R/xOcf5UUTZB1pDpSOK+N1IoYXEduNBYLAG46m
         P6tmwohxl5MOTmIqz6MtqAQRAZ3lQcxWhHIfEL0wxfQ1BrMjM4mtv6MoSnQRNgqBLh2Z
         ZTHki62O3BAxxdyQAv3ILobiTT77l200sAnBAh8L710LD2CF7SKo6hHgsjITrykdvqh8
         PZCPEAx6O49f2rWbUs2V4h5KrGvkW04bWHc7SdPWRwd3Qgex4UJCYNSIbYStTMoVwk9U
         6iyO5h6ROP9wEC3LJpdyQVZF7M0vmrspO0XrR7vq/dg3o40D+KhCfwkoLsj0jn6XicNQ
         k1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1zWAzbbGyNF4ujqsy3ndtQc7P0WBsL0MXLnk6Y9t6lw=;
        b=Qkf31odQH58GGC3ut8pj8iWyUBwfV3wXIiMZymq5f+NQbMeRkZkNggwjL0KnUXKq9C
         pjEjCKsVkh48iG0SYs1x7Nr9SEuSHCgIV6WWPCyVqROC8eKQrn1eNymfnNh6sx2T7np4
         ywXXsrF3OQchULE5l1BEZgSjaLE29u7f/BZYpfB9VFwII4hJLs69/2Fcp8VSfLcc5Fmc
         hJ/Gq2clHOs+ohdDy2xFctbDZzJtRR0ja7WQPpxiR2q87nt+rCQ+K9HAFUfG5P3mkU/B
         QP10jYUtQgYd+Jmem94xDAEeqPR6wprJRyMOdMbpGbSUW3qiBr/w3E6zutnNzn6hmr21
         jrWA==
X-Gm-Message-State: AOAM531aovfFTMjwlx+P6lilW+g9DlzvoFW5bCl2aZst3kDfUgvTXyCm
        Rx29PmIYIn8jBUtPdhdES0ADu8hvOus=
X-Google-Smtp-Source: ABdhPJx2A2O+iONIL/w3NWK3HZGWnndMTzMgvxcieLPuDFUzUTCga4zdhoEt0zRGRonbw6nhWUEYnA==
X-Received: by 2002:a2e:9d98:: with SMTP id c24mr3546141ljj.281.1601212573626;
        Sun, 27 Sep 2020 06:16:13 -0700 (PDT)
Received: from localhost.localdomain (92-33-153-30.customers.ownit.se. [92.33.153.30])
        by smtp.gmail.com with ESMTPSA id o8sm2487616lfa.44.2020.09.27.06.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 06:16:13 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 5/7] worktree: update renamed variable in comment
Date:   Sun, 27 Sep 2020 15:15:45 +0200
Message-Id: <dbbc57cd833f95a59ef82ecac6046a43cd88cc31.1600281351.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.277.g9b3c35fffd
In-Reply-To: <cover.1600281350.git.martin.agren@gmail.com>
References: <cover.1599762679.git.martin.agren@gmail.com> <cover.1600281350.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The comment above `add_head_info()` mentions "head_sha1", but it was
renamed to "head_oid" in 0f05154c70 ("worktree: convert struct worktree
to object_id", 2017-10-15). Update the comment.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 worktree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/worktree.c b/worktree.c
index a37d543394..5c9ecec466 100644
--- a/worktree.c
+++ b/worktree.c
@@ -21,7 +21,7 @@ void free_worktrees(struct worktree **worktrees)
 }
 
 /**
- * Update head_sha1, head_ref and is_detached of the given worktree
+ * Update head_oid, head_ref and is_detached of the given worktree
  */
 static void add_head_info(struct worktree *wt)
 {
-- 
2.28.0.277.g9b3c35fffd

