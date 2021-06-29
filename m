Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07FCC11F67
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 11:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5CC261DD2
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 11:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbhF2LPw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 07:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbhF2LPu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 07:15:50 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CBCC061760
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 04:13:22 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id a5-20020a7bc1c50000b02901e3bbe0939bso2174673wmj.0
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 04:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Fx27B90rLRJsIQFZEKdkqcKsgWl4kWveENFMBG1apg=;
        b=R3vZVyQLICHB2+YUEiizG0+z5vVRoVrlU3HnSdaelFZrNXpFxXuQnE04hQjlXm6VEQ
         oqHQHtRpZ+aq/XqYvbaeMYfuwCrWlgq57716DoDo71uHm7AdFVzzn6669BYW7ZSiF445
         xck4KPXJc1u7RkPsUDBml9stcdMXzIh9ExGUam2CTHQ5LvDYyYxOEOenusqzI4nowzXR
         d0fgOmt/6UxEXfdDnUUn6l9fTwkyKGflFr9LUsFOnApXEuusl5Zlm960YoDz1kJNrQRc
         cikybHnLNTxSp5EIgEhFHXEns7ZxJ/DW8WGfCGtqUVwS+57s5YGx2LMsdnuJd8c2mVgM
         AC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Fx27B90rLRJsIQFZEKdkqcKsgWl4kWveENFMBG1apg=;
        b=oNnihYHAGav6ylaXclulfD2EjIK6gGdw5JV4zJhxsz1NgkRgu7c3M596fA+RSeFqoO
         F/uvXoFV4LhGTkHNCsupW6947wedDRvlpbej944ZEH5h6GypsgWLsOwp/xYct/e7+wyu
         bk30XmdMoF4SgYVN8YeLO4AEExoi9GpZ3Wc0Hyu2gmgLayD5cni8BebiGyI2VNFLwxvb
         +rDn8xCtvcOJQqg9Eg4ImMr/YovkGj+Gl2yGh6K4RexF2NpkrzFSo+2PGcEXVFME4e8v
         DstL7IAcMOFCfW934EbUXoI6N58M09zGUM7R3a06fys+0tIZdxTUsrF2FqMqK9rPbIrl
         rbtQ==
X-Gm-Message-State: AOAM532M6sp28TyiGP/fT2ryw881GxuEdtwMjQvwouYgxXkw8lcGf+VU
        sLeqIFs4HE59N2quIXFstQcZTutj9RoXng==
X-Google-Smtp-Source: ABdhPJzEOMTOPyrVvdUAkTR01p7HVf1yygqBt+AH7DDXJqbxcvZQ4HeVWY+SGwNkATXd6C3oLbaPKw==
X-Received: by 2002:a7b:c117:: with SMTP id w23mr31865637wmi.102.1624965201085;
        Tue, 29 Jun 2021 04:13:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r1sm2499370wmn.10.2021.06.29.04.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 04:13:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Kristof Provost <Kristof@provost-engineering.be>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/5] Makefile: add QUIET_GEN to "cscope" target
Date:   Tue, 29 Jun 2021 13:12:56 +0200
Message-Id: <patch-2.5-56daa09738-20210629T110837Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.613.g20d5ce26552
In-Reply-To: <cover-0.5-0000000000-20210629T110837Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210622T141844Z-avarab@gmail.com> <cover-0.5-0000000000-20210629T110837Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Don't show the very verbose $(FIND_SOURCE_FILES) command on every
"make cscope" invocation.

See my recent 3c80fcb591 (Makefile: add QUIET_GEN to "tags" and "TAGS"
targets, 2021-03-28) for the same fix for the other adjacent targets.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 4dd9711a65..faa8900097 100644
--- a/Makefile
+++ b/Makefile
@@ -2739,7 +2739,7 @@ tags: FORCE
 
 .PHONY: cscope
 cscope:
-	$(RM) cscope*
+	$(QUIET_GEN)$(RM) cscope* && \
 	$(FIND_SOURCE_FILES) | xargs cscope -b
 
 ### Detect prefix changes
-- 
2.32.0.613.g20d5ce26552

