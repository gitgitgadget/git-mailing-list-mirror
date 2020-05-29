Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F361CC433E1
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D45A720723
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwgA9ZTI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgE2Ivw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 04:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbgE2Ivk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 04:51:40 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C043AC08C5CB
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:37 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x14so2605197wrp.2
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M1jiwZwpSev+ojVUCt2eBacB1NNB5MBIy1HzFiFF75s=;
        b=hwgA9ZTIAtWlqPbG0maEw5yQ2gK2qtW0Vx7MHmXemOvtrsMdR/dSwpHKNL9Fo7BEty
         GwJPZkFHDmtaKXjGxFRTZGCh3zStrh00zYn22ylBhpit4z+kwlLY6GbhvbZn/sosPaJG
         8DH2MVvd0HS4mECEKQEp/3fmQBlDSsTfi1s8LRq+2o3FVBwauD8R9tK2tmHQrmFO3eg7
         jqHuebxKRpa0kczstSfsVWQq2tz1S47Ype5EC6KtH9I9WqXo4CbBQzSNRK8Zgzh8r7wo
         ITh6bAg0kd+LTF4ouHr49SIwtijO6Z5d0kyGLO+nc+sYND2mjg+2zSDO+YG5qhOr5+T7
         oUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M1jiwZwpSev+ojVUCt2eBacB1NNB5MBIy1HzFiFF75s=;
        b=rtnCSOCWTbxmM27EmEqp85rOu9aZKFp3miRIycBRvIW7nO4QrdPSMIbmivvvU3qSaH
         zqSjekhDSITcX0h3GbqJT+dRNhmShu9ChK0AjeL8qLXq85Gm2kzlmC5OqfYlmOLwEPHw
         BrcHlWl7ynxnb7pOxsyhgVtLOlYsVY5X0DFHNmzSHr6lInaHpb0/iYlIL2iH0xn8D5UH
         l/af6lI6J+JaVK4q7etF+G6XCPqOM0WtLi037GIvzpbykkLgHHe6DDPe9Hl5cnhRZ/53
         o3fXhkI6Ztyiy+VQIX3HfiRH2qPwIpoQcZX2jueiNOIW8cIsSILp2JJ801Wp4wf4n/Xu
         WYYQ==
X-Gm-Message-State: AOAM532vypLisJ9dxTYr+UiwwBp4hrzsR7U0k9pKkhPBJ5Ju/Qnmo20I
        FESDy+vsaMtcNDJTaCnQcGvh/3V1
X-Google-Smtp-Source: ABdhPJzP2hVeBT/3MfuTWJjGaPqlthoRmbLTqZPOG0cVCb6iAOrSPI/med1403RHTMCmvrnDjfQyDQ==
X-Received: by 2002:a5d:6391:: with SMTP id p17mr8222809wru.118.1590742296164;
        Fri, 29 May 2020 01:51:36 -0700 (PDT)
Received: from localhost.localdomain (84-236-109-105.pool.digikabel.hu. [84.236.109.105])
        by smtp.gmail.com with ESMTPSA id f11sm3525255wrj.2.2020.05.29.01.51.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 01:51:35 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 25/34] commit-graph: check embedded modified path Bloom filters with a mask
Date:   Fri, 29 May 2020 10:50:29 +0200
Message-Id: <20200529085038.26008-26-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.27.0.rc1.431.g5c813f95dc
In-Reply-To: <20200529085038.26008-1-szeder.dev@gmail.com>
References: <20200529085038.26008-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the previous patch we check the presence of all leading
directories of a pathspec in modified path Bloom filters to
significantly lower the false positive rate.  This means that we are
checking a lot of bit positions in the Bloom filters.  However, as
shown earlier in this series, a significant portion of commits have
embedded modified path Bloom filters, all with the same size of 63
bits.

Use a 64 bit mask to check all relevant bits in embedded modified path
Bloom filters in one step.

I don't have benchmark results at hand, but as far as I can recall
some old results this reduces the time spent loading and checking
modified path Bloom filters by up to 10%.  Checking Bloom filters is
of course only a small part of the whole runtime of a pathspec-limited
revision walk, so the overall improvement is only about 1-2%.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 commit-graph.c | 17 +++++++++++++++--
 pathspec.c     |  1 +
 pathspec.h     |  1 +
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 1fd1b4f8dd..56b8f33d10 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -918,10 +918,16 @@ enum bloom_result check_modified_path_bloom_filter(struct repository *r,
 	for (i = 0; i < pathspec->nr; i++) {
 		struct pathspec_item *pi = &pathspec->items[i];
 
-		if (bloom_filter_check_bits(&bf,
+		if (bf.nr_bits == GRAPH_MODIFIED_PATH_BLOOM_FILTER_EMBEDDED_NR_BITS) {
+			/* Gross!  And potential alignment issues?! */
+			if ((*((const uint64_t*)bf.bits) & pi->modified_path_bloom_mask) == pi->modified_path_bloom_mask)
+				return BLOOM_POSSIBLY_YES;
+		} else {
+			if (bloom_filter_check_bits(&bf,
 					pi->modified_path_bloom_hashes,
 					pi->modified_path_bloom_hashes_nr))
-			return BLOOM_POSSIBLY_YES;
+				return BLOOM_POSSIBLY_YES;
+		}
 	}
 
 	return BLOOM_DEFINITELY_NOT;
@@ -981,6 +987,7 @@ void init_pathspec_bloom_fields(struct repository *r,
 		size_t len = pi->len;
 		int path_component_nr = 0, j;
 		uint32_t *hashes;
+		struct bloom_filter embedded_bf;
 
 		/*
 		 * Pathspec parsing has normalized away any consecutive
@@ -1012,6 +1019,12 @@ void init_pathspec_bloom_fields(struct repository *r,
 					graph->num_modified_path_bloom_hashes,
 					hashes);
 		}
+
+		embedded_bf.nr_bits = GRAPH_MODIFIED_PATH_BLOOM_FILTER_EMBEDDED_NR_BITS;
+		embedded_bf.bits = (uint8_t*) &pi->modified_path_bloom_mask;
+		bloom_filter_set_bits(&embedded_bf,
+				      pi->modified_path_bloom_hashes,
+				      pi->modified_path_bloom_hashes_nr);
 	}
 
 	pathspec->can_use_modified_path_bloom_filters = 1;
diff --git a/pathspec.c b/pathspec.c
index 01e7ae6944..29cadce013 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -408,6 +408,7 @@ static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
 	item->attr_match_nr = 0;
 	item->modified_path_bloom_hashes_nr = 0;
 	item->modified_path_bloom_hashes = NULL;
+	item->modified_path_bloom_mask = 0;
 
 	/* PATHSPEC_LITERAL_PATH ignores magic */
 	if (flags & PATHSPEC_LITERAL_PATH) {
diff --git a/pathspec.h b/pathspec.h
index 0c661e1b03..c9975aea7a 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -64,6 +64,7 @@ struct pathspec {
 		 */
 		uint32_t modified_path_bloom_hashes_nr;
 		uint32_t *modified_path_bloom_hashes;
+		uint64_t modified_path_bloom_mask;
 	} *items;
 };
 
-- 
2.27.0.rc1.431.g5c813f95dc

