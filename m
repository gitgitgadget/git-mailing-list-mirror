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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA36C43600
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C6466109F
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbhDABue (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 21:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbhDABuL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 21:50:11 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0B2C061763
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:10 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id g20so235051wmk.3
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/kQ/3c8UbEqQOrilneslkKpts4OYd95dOalBYXNQd/M=;
        b=QuoE3btE/OXFegoi+cHKmImwdgwRDw+fLHEekPg/JSuvSjLMTAYq57z13YfRselOjl
         5qDC7MyWyBfQMy+ez8drxCaoF5pZISl/Tts1I+wtEQOFel7dkPtXlKoJ6WtbwSvT6w3k
         a5886rASMaK+XR5w1NiTGQsG/sDS/nR5DMYhEWgQPffzTnXYaVHkRlFePSNS56At7WfR
         xIWtyaCfGp+/F5Geo97R2w+34Gbr3M4zkV4jRrf7IeROPZgGNJKbmNBpvo/8ltNSZvnG
         P+8V9tIntvWmP5Bzypy5dsA4YeA/e18V60sVW1npcuOmZTaGprdJzZCVSik6grnFL4OJ
         NiLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/kQ/3c8UbEqQOrilneslkKpts4OYd95dOalBYXNQd/M=;
        b=OBVxtirOvi43aq7YbNyMYzN43M/kyXUhrT4cXtxBTTff2q76r3KFP8d9H+Q8wEslwf
         8Blw61jrTWcgXnOgntFAVOKEIEcRmij8m8wjKovJ7MjokCrUctd4z2EwS2LbwtHUmVi8
         +DQmso8021MpcJFHtGvU64YCBZBgcxkemD0dZbLZMROaTvqkdKsPootjMcs70GIcssdO
         rLVdWhDwRzxcAvMeYytn0Qadv17xgE+qt45Gw1T2REH5RHPd6KbWGJyD6ZA18fabCZSr
         AtWWThLr/t0lh14mzeFw3kK2IYQNOLwVSTTuFDRiE00mebUd8cbDtYFhSaDXXRnidzpz
         wL6Q==
X-Gm-Message-State: AOAM532vBSEh7CRYm7z0e0YgztAdhPw0mZDjBvi6UBBBj5+hnyrSFj22
        43An3djpLPGaPECi0hFlvaQ3N5HNmzs=
X-Google-Smtp-Source: ABdhPJzM9YZU8N9Kf39DUtrdBlT6JeF2kG9jJYoT6ODeuLisSOZdAJdbxUmfphNFC3lTbjIDQMglZg==
X-Received: by 2002:a7b:c047:: with SMTP id u7mr5649013wmc.98.1617241809683;
        Wed, 31 Mar 2021 18:50:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g9sm7152629wrp.14.2021.03.31.18.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 18:50:09 -0700 (PDT)
Message-Id: <739f3fe9edf276555cfe153e6f165b0af68a72ba.1617241803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
        <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 01:49:46 +0000
Subject: [PATCH v2 09/25] difftool: ensure full index
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

Before iterating over all cache entries, ensure that a sparse index has
been expanded to a full one to avoid unexpected behavior.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/difftool.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index 6e18e623fddf..32c914dde6a0 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -584,6 +584,9 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 		setenv("GIT_DIFFTOOL_DIRDIFF", "true", 1);
 	rc = run_command_v_opt(helper_argv, flags);
 
+	/* TODO: audit for interaction with sparse-index. */
+	ensure_full_index(&wtindex);
+
 	/*
 	 * If the diff includes working copy files and those
 	 * files were modified during the diff, then the changes
-- 
gitgitgadget

