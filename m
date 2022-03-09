Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E545C433FE
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 13:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbiCINTk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 08:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbiCINTY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 08:19:24 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A6A17927C
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 05:18:01 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id x15so2937280wru.13
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 05:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q47Bc6EUgs/uL91pRbMV5QmlkFSaTGuv0FEKZptNJvA=;
        b=HY8Nsw2/RtoRfd/epI9wuECoPJ60v+IefF6Ev0z4yl70jGUHRqy6BCgQ6IPaUp54CY
         6Q/kFTpDhLCyYGe419UxGFI4b9YNeHyvarIhKvgqR0JvXSfTM6zEojTrJdN86YL5M3iZ
         5k+w+1etHcQukQR4/MNkbcD4b0TFCxBZPwylUNpgcqy/YQvopKGIcx5m7W6jxP5WWAbr
         kp8x4GtN+MhbrOyGUCCiIzr3NUvXAQ6wAfp9XbQbRR6YsJruCz4wRpElaioEnk0kASEe
         hYsWC16MWKwtm49FXk7jhIeY8Zp/NqgPbOhNwW0j+RxYXXmYZ6rhJ7icGEcwTWzGtTkp
         qiLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q47Bc6EUgs/uL91pRbMV5QmlkFSaTGuv0FEKZptNJvA=;
        b=fwqhEdXTGmODEMQnjojic1cMKYTSWonP5BXbjh+f6+L/sZzRaTw2saSB2nqNrxyB2B
         S73DucqA61bVtxoIMJbURuLtop6jUU4GTJDG9F0tdqgw354E54FScuRH6dAsCE6KRv08
         YkxHtTkwYjGLLcQ2Eo6Niq4wTtWBTNvd0C9e8skyFZlbkz3w7+jM2xtVxeZhxKY90F+j
         JerS6ZzS1L/1RE89DPzkZIsA8nnRkZw/11F1Q+uToN48MVMZFFk5+vOzWjOBvcBoTS8R
         iC0WJZwkPjoYRwRMfwlLR2ELWXEaKmSW+/bw6Fj3c2nPnmiiei8w7vGdn8uIZFEfDVEx
         M3ew==
X-Gm-Message-State: AOAM532/3Ah2mKEJe2V1VBXRibPj3R/VxlQ+g88J+kdfpV45f7HAlGxZ
        iuYNSqC44qRI+kag44omzOWaA2QWg1fT+A==
X-Google-Smtp-Source: ABdhPJzu8j5SFSYrsmXslWTNnp0B08YnLq0uP4ngFas8m51+j7CNUq8QLWHhU3frQEAenr69G4DRhw==
X-Received: by 2002:a05:6000:1448:b0:1f0:6620:968f with SMTP id v8-20020a056000144800b001f06620968fmr16340910wrx.714.1646831879672;
        Wed, 09 Mar 2022 05:17:59 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i74-20020adf90d0000000b0020373ba7beesm2599988wri.0.2022.03.09.05.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 05:17:59 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 18/24] revisions API: have release_revisions() release "grep_filter"
Date:   Wed,  9 Mar 2022 14:16:48 +0100
Message-Id: <patch-18.24-fc486e1bc46-20220309T123321Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1295.g6b025d3e231
In-Reply-To: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the the release_revisions() function so that it frees the
"grep_filter" in the "struct ref_info".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 revision.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/revision.c b/revision.c
index 6c83a715dee..f51a60b2a96 100644
--- a/revision.c
+++ b/revision.c
@@ -2953,6 +2953,7 @@ void release_revisions(struct rev_info *revs)
 	object_array_clear(&revs->pending);
 	release_revisions_cmdline(&revs->cmdline);
 	release_revisions_mailmap(revs->mailmap);
+	free_grep_patterns(&revs->grep_filter);
 }
 
 static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)
-- 
2.35.1.1295.g6b025d3e231

