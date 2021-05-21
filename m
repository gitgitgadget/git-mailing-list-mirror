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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55779C433B4
	for <git@archiver.kernel.org>; Fri, 21 May 2021 12:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35A1C613D6
	for <git@archiver.kernel.org>; Fri, 21 May 2021 12:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbhEUMBo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 08:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234282AbhEUMBO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 08:01:14 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E879BC06138D
        for <git@vger.kernel.org>; Fri, 21 May 2021 04:59:48 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id x8so20804742wrq.9
        for <git@vger.kernel.org>; Fri, 21 May 2021 04:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Xlnwaf5kg5I86PpR29UBuzCeR2oJW7UhOX0TCCBSrvU=;
        b=OpYoM7rQJulmw+izVMlIR2/VeynrBzfU9SdCGFsvSBCunmILEvzfGO/jaWtN4eReGa
         qbg/vBf+SGjN+7errIZ//oy14abUzom2cEV1otpj0l47iqa39YipO9qoJJI2Rk08iHP0
         6i4u5dytePQfmfg1GSqEgj0VrQ3Z2dBFRy3v1jGUtlo0EAnRF3sLZCMzc64bk0oYHIIj
         lCyJPWHstoUI3y2BmKd7Nuu5f6k9Mw54zzPtaXmN5UaPyKjQOHoZDh8LJeMkGqTh8dkj
         L7EC4UXQBDT2NhPORgdXyBtrceO4ckLFDsI8+aqWDAwk+xaox5USfmJN0CGidCnViPyr
         wzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Xlnwaf5kg5I86PpR29UBuzCeR2oJW7UhOX0TCCBSrvU=;
        b=ulYWEIxw4ln0JDGYtainpSLaZSSqfkU4t8blKfz4H30qs+tErPM25DuV9+JUNEU5zE
         vkSmFfLRCvlqYTRWrbawj8Udos/38WSnmQcQM9HMn5wiou12G8EwKtUEkIcxlydZO4tB
         /uvrDcSHZCwmKCrOfn7+cITMfoD5qZdTSZDBbjmVpDPlfwydY4FuCpdymGVG80ghhovx
         Gw4eZvNISM6AhlsEvOyoDKXTTaiJYRFX4oGRW5CT0LYYayvgOw3Wc0n+ESKFK941NQLG
         ihVOx5mVSu/AP6rrTektgyjpXM6V1kNX+PmYBhv//D8MaSJscd2D+KeElXGbzkrVQXfo
         /tIQ==
X-Gm-Message-State: AOAM532sbgI+fK+kPgqnrOqapGh+abFWV3k1d+mWXl8eiOwu/+ugewuj
        h4mjhyXoCjUVocBKBoM6vHkIEAzQ9ds=
X-Google-Smtp-Source: ABdhPJzyJQCrYusKigGxlVWXuAqTpRplWdHrO+rMrvwGuRwIgX8FaThmO0Rves90uLxR33qno+T+IA==
X-Received: by 2002:a05:6000:1189:: with SMTP id g9mr9115023wrx.385.1621598387631;
        Fri, 21 May 2021 04:59:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x10sm1876109wrt.65.2021.05.21.04.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 04:59:47 -0700 (PDT)
Message-Id: <e28df7f9395da33f24d6b75fa30081074ac6b801.1621598382.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
References: <pull.932.v3.git.1621017072.gitgitgadget@gmail.com>
        <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 May 2021 11:59:36 +0000
Subject: [PATCH v4 07/12] unpack-trees: be careful around sparse directory
 entries
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The methods traverse_by_cache_tree() and unpack_nondirectories() have
similar behavior in trying to demonstrate the difference between and
index and a tree, with some differences about how they walk the index.

Each of these is expecting every cache entry to correspond to a file
path. We need to skip over the sparse directory entries in the case of a
sparse-index. Those entries are discovered in the portion that looks for
subtrees among the cache entries by scanning the paths for slashes.

Skipping these sparse directory entries will have a measurable effect
when we relax 'git status' to work with sparse-indexes: without this
change these methods would call call_unpack_fn() which in turn calls
oneway_diff() and then shows these sparse directory entries as added or
modified files.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 unpack-trees.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/unpack-trees.c b/unpack-trees.c
index ef6a2b1c951c..22634d98e72b 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -802,6 +802,9 @@ static int traverse_by_cache_tree(int pos, int nr_entries, int nr_names,
 
 		src[0] = o->src_index->cache[pos + i];
 
+		if (S_ISSPARSEDIR(src[0]->ce_mode))
+			continue;
+
 		len = ce_namelen(src[0]);
 		new_ce_len = cache_entry_size(len);
 
@@ -1074,6 +1077,9 @@ static int unpack_nondirectories(int n, unsigned long mask,
 	if (mask == dirmask && !src[0])
 		return 0;
 
+	if (src[0] && S_ISSPARSEDIR(src[0]->ce_mode))
+		return 0;
+
 	/*
 	 * Ok, we've filled in up to any potential index entry in src[0],
 	 * now do the rest.
-- 
gitgitgadget

