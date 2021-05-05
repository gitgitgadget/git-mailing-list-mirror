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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAD8C43462
	for <git@archiver.kernel.org>; Wed,  5 May 2021 12:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DC46613B3
	for <git@archiver.kernel.org>; Wed,  5 May 2021 12:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbhEEMPw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 08:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234239AbhEEMPB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 08:15:01 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B21C06135B
        for <git@vger.kernel.org>; Wed,  5 May 2021 05:12:04 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v12so1573136wrq.6
        for <git@vger.kernel.org>; Wed, 05 May 2021 05:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h2PTAh/wMWymgaVx4HKkgpXLocVby5mcfu7WWV7rNXo=;
        b=aV0OFrQnaF7Y7GbvMiXEs2CNHx5kpMMbd9YKg4YDkQOXQyXvKRN5lFzqmjCvAD3jyN
         PEt7N8wD6io4DhnaEW0ChavTTVZSY9FfyxeQI97oR6t72U3cxggkAGc3h1TvIYxeCu0d
         a4f1J6ao3wtj5oGwiKi/As6yoGqOqHqxyTk/z3baMh0FTQJz3HjjlVJ3TFkla3SBqhOo
         p75GwTKoZcXvJ32gnNNDuSxrtL5YsPy1rtVtjsJEDr/z2AbKcnwQWFDMrtf5tp8+HtQN
         50hS38gje3RXvJ3lwgVQPiFep8gNYazrs+/lVmHLB06migtNeZDE3kCgX7AUV60aseoc
         OXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h2PTAh/wMWymgaVx4HKkgpXLocVby5mcfu7WWV7rNXo=;
        b=sjFNHwqwlypQmJtmzsttZ+N2syiKodudqFFXYEG1TsF5AylwJNf2FcpBxqgv+4rUy8
         l4nigdxrUiAMyM0TJZBsi1B2YZDxWp6AnUtqPwSFo3vvWbgeCi+7GtoPHPqlUU39ubzq
         XjSz+321gR1/JWeQB3Ojke62rB/xoOv43xGT2MLXksQqPemugKM/I7+vsdvYB1XXYPHM
         EC36ozwoNBE9QGKLkokonZSNN0kOETedVozvCGW9iJkzpA6Ia08ERJJPRC2trTFAk/l6
         etlG8m8M9HblIdI2WzPUVIKh/spN3ONRtf/kyA+PftcP/6RCVNSVbJLjvm9i0zpjz6IS
         nmMg==
X-Gm-Message-State: AOAM533lgsNN8+vagksz9F9Xjmxg3ErFcyznjDvwqEHaGN+HQt5QSgoS
        hLzp5wvhbYS4RmLlbX2i/b1K/4ANuzBQPg==
X-Google-Smtp-Source: ABdhPJyWC6UiXdDppEhlb1mg9wnPiHb6QtIxoHxu/lNFwTk1bz9+T6h2RT/uM7lOs3VqGEWG2aGlUA==
X-Received: by 2002:adf:f50f:: with SMTP id q15mr36655700wro.279.1620216723256;
        Wed, 05 May 2021 05:12:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d3sm11144626wri.75.2021.05.05.05.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 05:12:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] sparse-index.c: don't call prepare_repo_settings() twice in a row
Date:   Wed,  5 May 2021 14:11:59 +0200
Message-Id: <patch-2.2-8bca02efcee-20210505T121028Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.838.g7ac6e98bb53
In-Reply-To: <cover-0.2-00000000000-20210505T121028Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20210505T121028Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code added in 58300f47432 (sparse-index: add index.sparse
config option, 2021-03-30) to only call prepare_repo_settings()
once. We know that our own set_sparse_index_config() has just finished
calling it, so we don't need to call it if we're acting on "test_env".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sparse-index.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sparse-index.c b/sparse-index.c
index b0d5dc5f081..5bad05de645 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -133,11 +133,12 @@ int convert_to_sparse(struct index_state *istate)
 	test_env = git_env_bool("GIT_TEST_SPARSE_INDEX", -1);
 	if (test_env >= 0)
 		set_sparse_index_config(istate->repo, test_env);
+	else
+		prepare_repo_settings(istate->repo);
 
 	/*
 	 * Only convert to sparse if index.sparse is set.
 	 */
-	prepare_repo_settings(istate->repo);
 	if (!istate->repo->settings.sparse_index)
 		return 0;
 
-- 
2.31.1.838.g7ac6e98bb53

