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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127B6C433E6
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 13:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4DF623106
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 13:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbhAVNIK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 08:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbhAVNFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 08:05:16 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548CAC061793
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 05:04:06 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id v184so4284474wma.1
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 05:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=y598NcID+pvqCAZAY/Tm1DdS/4I5fOF8T0v3YIlcS0c=;
        b=tRv+KnY9IMk/900tlcusmB1LZHuII9jfi526kwBxAMCDIbcGFMr8EoG/5SgPOvGu/6
         lEyNhlF5yh4M3bNeHC35Vs+V6N/3eBdeZy/N76lFhf9O8Z3BIMUXkFWUbhrrhp4Ps6Pu
         D8Gj6XR8Aoop/8972nl9y8FcSgby/QpTfWLb7KloM2eKB5T9ybr6gZolPQvFLezXIC4V
         DF34L2gzS3dt9V7D3RjCbO0XXpB11VYxiCfVyx3L+YOly5HY082Oq7S3OZqU3Nh7oDV5
         0POeIPCNycxNv4KNvZcvzlVB3egOUc+W6LDTlehLLZO0fVUYnNGDq6sBDJifETd/yKLx
         AkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=y598NcID+pvqCAZAY/Tm1DdS/4I5fOF8T0v3YIlcS0c=;
        b=jtUuvPkEAiHhVIy16fP5jKauvvGyzxWg0IOXlbQKX1wjoUUVuwPpsIc4OAtgXYqfmj
         htpVUsFwcCmMBSSBx35W4PylLtmSL3jjm3LvzWxjuYgMKhSR27yFvKk1Q5wWDifJJq1e
         RIICMuCePAnqIg+w5aFQ1WfuPZdln2pYT/J0o+u+vmc28PFqV4Hd2fc/KD6T9/H8oujE
         GZdFFTutTdbrHF7hk32bzvHJhbGIUtxtq0cdv5gtIXLFN7pWHUp7oYIjiZNOP95wkFVZ
         k0Jgj0WWm2a4NrOTQAGLh3XXeO51Cy8EWYDa8GIPmj2IMqXCDByCpraC7iav2TyGWQzL
         ijAA==
X-Gm-Message-State: AOAM532n6RCmCNfb8lO4BZILI8O+Tc2d2MA/B3MYIRsTYPwU8y/25dJJ
        xtODlq+1CWKKW38akBQBo1TnQHSzNcc=
X-Google-Smtp-Source: ABdhPJx4SEC3Vgx8proET5JS8qsdAnAoHAbvz0xrMsMxisEvZBVMUVRii178clmc3CsRE0BLoQn7cA==
X-Received: by 2002:a7b:c210:: with SMTP id x16mr3769137wmi.105.1611320644986;
        Fri, 22 Jan 2021 05:04:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u83sm11353027wmu.12.2021.01.22.05.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 05:04:04 -0800 (PST)
Message-Id: <a0d89d7a9731adeee4e2a432843b2f4a9c232dc4.1611320639.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.839.v2.git.1611320639.gitgitgadget@gmail.com>
References: <pull.839.git.1611161639.gitgitgadget@gmail.com>
        <pull.839.v2.git.1611320639.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Jan 2021 13:03:55 +0000
Subject: [PATCH v2 4/8] repository: add repo reference to index_state
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <stolee@gmail.com>,
        gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

It will be helpful to add behavior to index operations that might
trigger an object lookup. Since each index belongs to a specific
repository, add a 'repo' pointer to struct index_state that allows
access to this repository.

This will prevent future changes from needing to pass an additional
'struct repository *repo' parameter and instead rely only on the 'struct
index_state *istate' parameter.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 cache.h      | 1 +
 repository.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/cache.h b/cache.h
index 71097657489..f9c7a603841 100644
--- a/cache.h
+++ b/cache.h
@@ -328,6 +328,7 @@ struct index_state {
 	struct ewah_bitmap *fsmonitor_dirty;
 	struct mem_pool *ce_mem_pool;
 	struct progress *progress;
+	struct repository *repo;
 };
 
 /* Name hashing */
diff --git a/repository.c b/repository.c
index a4174ddb062..67a4c1da2d9 100644
--- a/repository.c
+++ b/repository.c
@@ -264,6 +264,10 @@ int repo_read_index(struct repository *repo)
 	if (!repo->index)
 		repo->index = xcalloc(1, sizeof(*repo->index));
 
+	/* Complete the double-reference */
+	if (!repo->index->repo)
+		repo->index->repo = repo;
+
 	return read_index_from(repo->index, repo->index_file, repo->gitdir);
 }
 
-- 
gitgitgadget

