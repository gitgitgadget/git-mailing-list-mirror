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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D14CC433F5
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 01:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83815610CF
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 01:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbhISBu1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 21:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234449AbhISBuY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 21:50:24 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7034BC061574
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 18:48:59 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d6so21821806wrc.11
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 18:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SLdCF+Ngdbza+qtXe71urI0mP8rSvHuNJLe06Z3AODQ=;
        b=iE5mi119MIFTg0q6QdOXbd8FocDN6QZR+zp8fVLo7nvi44VVXakrDWI78s7jRF0AxM
         WfSKvcPIajl6fUj9C4yTN1a6Qg8rdBJvn5b1s9nvf8oK9Z4sz2JMh8aYY3bMFSXMc4AG
         xGLFPYNCdovPHWdaZrorQxDu6IWZU2xCj2KINnO8ghhFVDMTDYkcHt+RyBhugttGDahM
         WPyZiITSTm8NZ0+odAMin93dM6UkAf00pZQYJ1TKMeEWLVyPEb0vZMUOZnxMmxWxYFQz
         cKRq5qdcpRKxeQAzsMi/ai/sNHwd/ZYT2R1JfEDPTxi4xh6JwtI71BnEGgg21Zc01qPc
         ZXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SLdCF+Ngdbza+qtXe71urI0mP8rSvHuNJLe06Z3AODQ=;
        b=d9mJJssZhiEIXCpj8SKtuWdw77eFskyncxDpCj1KRVir48LSP/F2hjYcNOdhaK/M8C
         PGag11lVpc/mET6XM3wMk8tluVQNAj1Smyr02n8j5HKlp0qki/ZxTu04SjB3yT3cR7kj
         f4BQZdZSK+DpTrSDi0DefKPRPAKNcPmS5QTDkVkEZ9fmdWmZKAWrxHSPgEOkhOTHsPxf
         YAZhCmISRxSgmntT6A18e0pRYgYb3eA/rNjXiK/YRlF3+vZmTljykBgXIomF2VPq4aYC
         EqYmZhaN073j3EgC2fvPxgot3vCbFqL8JNIVQeSXZH/xcUbHAAkPkwgZjwKDVMKASWj/
         Ei6w==
X-Gm-Message-State: AOAM532RvrTGsYKxdVUz0EYpZ+LMAtpEyhsMzR/jutcyPL4yGhmqdb3h
        M41m/PqtcXH3EeKQfWxPE/YucR6ElaQ=
X-Google-Smtp-Source: ABdhPJwbCcPs4wiHl3P+GQ8nGF5BAoRWuAFpH959Z4KIli97BjYNw67/QXYmwYV/yeQC2MikYOt+2Q==
X-Received: by 2002:adf:e74b:: with SMTP id c11mr20756668wrn.101.1632016138065;
        Sat, 18 Sep 2021 18:48:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c17sm13805613wrn.54.2021.09.18.18.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 18:48:57 -0700 (PDT)
Message-Id: <5dd56d0c5366eaac1d235ce374358ad0f072c617.1632016135.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1093.git.git.1632016135.gitgitgadget@gmail.com>
References: <pull.1093.git.git.1632016135.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 19 Sep 2021 01:48:55 +0000
Subject: [PATCH 2/2] merge-ort: fix completely wrong comment
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Not sure what happened, but the comment is describing code elsewhere in
the file.  Fix the comment to actually discuss the code that follows.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 515dc39b7f6..841196cf728 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4081,7 +4081,7 @@ static int record_conflicted_index_entries(struct merge_options *opt)
 	state.istate = index;
 	original_cache_nr = index->cache_nr;
 
-	/* Put every entry from paths into plist, then sort */
+	/* Append every entry from conflicted into index, then sort */
 	strmap_for_each_entry(&opt->priv->conflicted, &iter, e) {
 		const char *path = e->key;
 		struct conflict_info *ci = e->value;
-- 
gitgitgadget
