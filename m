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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F39C2BBCA
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 20:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52B7C233CF
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 20:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbgLPUgE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 15:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbgLPUgE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 15:36:04 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30887C0617A6
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 12:35:24 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id m5so24420131wrx.9
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 12:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=blnPZRf9svROrs+qNuR+fBHyvJr8SF3u351Y7xxSTlI=;
        b=A63uef0K2fLh/g6/SKp1+dgW/6gFC7BTVya2cWWzD5VBcrRpBEbVV4AASesMfzJDcM
         tFZral1njv4Aj2iXqU481H8rIvF1oXMEkY/gGqdCV/J11ABxOMlsHSLq1CBdawergjKR
         OAsD0xuTKzuMe6bJl0HypQyg9tPgi9F7MdgBeCppjKWDIiYVP7f3dWygFsfbFAGTpXQO
         Sk33Q5QaoNLt6s/5ZB6cJg7nl48IlGTw7eNPKPGx8ZRGmt3wVZXiDeB5/XKCElgaxKRl
         +tokGLFRW1s5c1m+ElJ9+2nzHY4NpDbDIt3Q54i13wtcJAxmZkyBOZpIQxswYW9jH2WV
         fzmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=blnPZRf9svROrs+qNuR+fBHyvJr8SF3u351Y7xxSTlI=;
        b=Brg8kI8gfZI9tqKvCOy6XpPQ7h5Inut16YsoG5LVSwG3AbUJCYNOC186I8qFCOHnK3
         4R9hNjZE6qxTPCr7oJOL3bCtggz9iDvm5oHvQ7tS6AOejD+Ktnv4tSi0NbNLq7NCp+vn
         zaUHeGjos9AIfL/TiQ8GaUIFcSnennKHYX4KG2SA+XV2FwQcOq3Um2S9A3jK/So12zi1
         sFNGy8tSlyY2ajMTJA3byeDQa+2nqt2qbT+DC//VCgKkmw+PAa5WHWZ99AR8iM2LVfIv
         OOHt7etpE+Rb4VWv3A/B5cuhnwMIp9vE605tFX9jdF6o8p2UBFXM3mY69LSwQEGpXJxP
         sAOg==
X-Gm-Message-State: AOAM530yyp5ZFZc8C3FzanpQWMbkCJxMVcbOxS0A+21qafWsVFRUHyQG
        9LV8RQZEpwKBQS/DZNiBA6y3w0IOuQQ=
X-Google-Smtp-Source: ABdhPJwb1vErAbaeG2QOs8nn8djlluwFpOQNMalcFEeh+rgICLbFHw1rEk2GIOwmyeSorGa3R9Rv4g==
X-Received: by 2002:adf:f7d2:: with SMTP id a18mr18236049wrq.47.1608150922662;
        Wed, 16 Dec 2020 12:35:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i8sm4564367wma.32.2020.12.16.12.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 12:35:22 -0800 (PST)
Message-Id: <bffc45c6570774dcf4a74fe20b0aef3780ea8cde.1608150919.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.814.v4.git.1608150919.gitgitgadget@gmail.com>
References: <pull.814.v3.git.1608139034.gitgitgadget@gmail.com>
        <pull.814.v4.git.1608150919.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Dec 2020 20:35:18 +0000
Subject: [PATCH v4 2/3] merge-ort: make clear_internal_opts() aware of partial
 clearing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In order to handle recursive merges, after merging merge-bases we need
to clear away most of the data we had built up but some of it needs to
be kept -- in particular the "output" field.  Rename the function to
reflect its future change in use.

Further, since "reinitialize" means we'll be reusing the fields
immediately, take advantage of this to only partially clear maps,
leaving the hashtable allocated and pre-sized.  (This may be slightly
out-of-order since the speedups aren't realized until there are far
more strmaps in use, but the patch submission process already went out
of order because of various questions and requests for strmap.  Anyway,
see commit 6ccdfc2a20 ("strmap: enable faster clearing and reusing of
strmaps", 2020-11-05), for performance details about the use of
strmap_partial_clear().)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index b66f8a6f100..7679c1d08e2 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -253,10 +253,11 @@ static void free_strmap_strings(struct strmap *map)
 	}
 }
 
-static void clear_internal_opts(struct merge_options_internal *opti,
-				int reinitialize)
+static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
+					  int reinitialize)
 {
-	assert(!reinitialize);
+	void (*strmap_func)(struct strmap *, int) =
+		reinitialize ? strmap_partial_clear : strmap_clear;
 
 	/*
 	 * We marked opti->paths with strdup_strings = 0, so that we
@@ -266,14 +267,14 @@ static void clear_internal_opts(struct merge_options_internal *opti,
 	 * to deallocate them.
 	 */
 	free_strmap_strings(&opti->paths);
-	strmap_clear(&opti->paths, 1);
+	strmap_func(&opti->paths, 1);
 
 	/*
 	 * All keys and values in opti->conflicted are a subset of those in
 	 * opti->paths.  We don't want to deallocate anything twice, so we
 	 * don't free the keys and we pass 0 for free_values.
 	 */
-	strmap_clear(&opti->conflicted, 0);
+	strmap_func(&opti->conflicted, 0);
 
 	/*
 	 * opti->paths_to_free is similar to opti->paths; we created it with
@@ -1344,7 +1345,7 @@ void merge_finalize(struct merge_options *opt,
 
 	assert(opt->priv == NULL);
 
-	clear_internal_opts(opti, 0);
+	clear_or_reinit_internal_opts(opti, 0);
 	FREE_AND_NULL(opti);
 }
 
-- 
gitgitgadget

