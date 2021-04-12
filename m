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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789B8C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 567D66135C
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244048AbhDLVI4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 17:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241474AbhDLVIq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 17:08:46 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0B1C061343
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:26 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id c15so5372246wro.13
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/kQ/3c8UbEqQOrilneslkKpts4OYd95dOalBYXNQd/M=;
        b=g1m+/DOXLYBJhOsOf1E0Z+tJVJYHZ/pCimKCynVRS+3+EFcOPqoG9YHP2t8fbcOfXA
         5/w4lWPMz3mtX5L1s9gdUqLba3QIVu/7vFGQBuxQxZsUgExaJfadObOeyJzrtcpul08U
         FEZC3naeJ4AG9hi2zJOCKNuqdCuUmJOqoaU31gEMyBN/brtdsZ7cTqcZRokyWX6xEOcH
         u6ARJHh1kafqIXV6VpM0ThkPZiliKVELo8EpcVEc55Ds8IB1YROvIhVXVKqhQ/h1avvd
         SWs0n7PbiqulELCJmGzvZMEzXMfWdZqzsdMvucauTJtxxpT1qEXEE4n2qW8LJMVsHKGX
         v7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/kQ/3c8UbEqQOrilneslkKpts4OYd95dOalBYXNQd/M=;
        b=sgRBRqaGxCnj+GNkDiYx87Az3Ha9kVJmtBqOW4Kn6Ztt2GL9dvGEN4Q6U9AbzKEoE5
         MALlmdb4l4eW4iYZt0zyEze7ZZ4/aSe7EajA1RL6TKbPLoqfVaLrnFlZ9CCxpaPWCYRK
         yW0Xo1px453GEPQseo97OeHbiOjxFNQumiYq/UIkjaRbOyhL+X6yR+Zp8YmaXBZ8lxZr
         witqfR/7R9QCYtVe4llivxnQ8dasJxjoB3bB5rLKKWz6lEFv2HMZUGmTrooLrrtCRyDz
         gYkdLXGUrCmj5g92XicyrtxT07gblrZFNSkDo+DNpni5YAHm3WM+kkuw941gHjnIvHMQ
         JUYQ==
X-Gm-Message-State: AOAM531HzJ98ccVgSo6eCWADfgB3PLwF01M0d/ryh3lhjK/mxFX0oza5
        ys8ekOzodcUDLxWnY1ZyYFvTH8dPexo=
X-Google-Smtp-Source: ABdhPJx2GrgL/iUSliuD904wCbGSSFCVBc7LyeNrhHxO6fDmbqNfTEeLdXePg4L1Hlqy0W6KWq+ZhQ==
X-Received: by 2002:adf:a119:: with SMTP id o25mr2195974wro.36.1618261705072;
        Mon, 12 Apr 2021 14:08:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l4sm501287wmh.8.2021.04.12.14.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 14:08:24 -0700 (PDT)
Message-Id: <8c61d40dfe01d89d248ff9208e955801c1a18c18.1618261698.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
References: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
        <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Apr 2021 21:08:00 +0000
Subject: [PATCH v3 09/26] difftool: ensure full index
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

