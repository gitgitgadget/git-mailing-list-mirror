Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E55FC54E8E
	for <git@archiver.kernel.org>; Mon, 11 May 2020 11:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9608206F5
	for <git@archiver.kernel.org>; Mon, 11 May 2020 11:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdODCwC8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbgEKL40 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 07:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728531AbgEKL4Y (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 May 2020 07:56:24 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BA2C05BD09
        for <git@vger.kernel.org>; Mon, 11 May 2020 04:56:23 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id s8so10576148wrt.9
        for <git@vger.kernel.org>; Mon, 11 May 2020 04:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RmgF5TDTH2YI6FYM/8ilYhDL1HN/g5InUDNye3oVdUQ=;
        b=VdODCwC8xsoCO6csJqi/BEYaG68DV0R9O/vNFIlhiutFOHmNpDKnMXRrHry0R8yeeD
         kwrVaDuqgWVwbyjdEH3MopZL7U1Z0zl6TZrjOTaK2H0BPOn0rbjdUx9NaaqCk2XdD8Fe
         Vy1If7G8hVcnIyUbM7saAqNjJW5/HVX2h9+2VirysvH5/9LIpdMsml5fOQv66nRyLxMi
         oVIks2YkRKyWj9dck3EhYzaAgYlNYHkC1jHHVKnXjPy/Bkn650/1zxc0bjyLnbj0Y46J
         OYKp4+5hMjo/x/I2Xsm0Y3PGLwIjokh2srF4OIYiymxfvJQ0Wjv/DEzu7G4PRsqlqT/9
         MGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RmgF5TDTH2YI6FYM/8ilYhDL1HN/g5InUDNye3oVdUQ=;
        b=iXT6xsusQ/cRYvBPKiCzAZW5p02kOtSJhxaNZsnbG7bZqs3BExAECH6Iz4DIGob9iW
         mczva3aZK9hMmMaSXwGZSWIBvz+76pbh8bxe2sv8EMdj/fzq+5PmRm466XcUoRvoZzKO
         n0IjweA3DrJVfjI8H93H8UEeWXHwfeCFb0fqmd3ZDr9w7jphBO84UBX+QvdV/zMvCRwe
         MX6Dc70KWsLYUENKNqSkGLjE4Qc3SS/eiMc3iRXgFN7V4VuCShOLGneaNnimCWixI7YW
         A70W6RLYjXL9xCEBLtP1cVJDVdFzWBQ7/EZ+WqEnEj9WjjuuVCIvy3ovF+/cWAXmWXk5
         k7tg==
X-Gm-Message-State: AGi0Puby7Bt9Neofx2jSEtbQPJU/ZcA/TM7WL0NBdirdQ1lCxrlohWiZ
        brDbvfkX+kmtRcxUn7sr7mMR5x7C
X-Google-Smtp-Source: APiQypIOclK0u/8tX/7phSTiSN9FUmdWg/MhuEYZ3aJmTCFRPTbXzjICH7V5w6pkP380SnBgK0GGIA==
X-Received: by 2002:a5d:6692:: with SMTP id l18mr19434213wru.423.1589198182181;
        Mon, 11 May 2020 04:56:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a9sm25685065wmm.38.2020.05.11.04.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 04:56:21 -0700 (PDT)
Message-Id: <89625b0efae43c8cb0d444a843d389d6cb9f6772.1589198180.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.622.v2.git.1589198180.gitgitgadget@gmail.com>
References: <pull.622.git.1588347029.gitgitgadget@gmail.com>
        <pull.622.v2.git.1589198180.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 May 2020 11:56:08 +0000
Subject: [PATCH v2 01/12] bloom: fix whitespace around tab length
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, me@ttaylorr.com, garimasigit@gmail.com,
        szeder.dev@gmail.com, jnareb@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Fix alignment issues that were likely introduced due to an editor
using tab lengths of 4 instead of 8.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 bloom.c | 16 ++++++++--------
 bloom.h |  4 ++--
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/bloom.c b/bloom.c
index dd9bab9bbd6..2e3e0f5037b 100644
--- a/bloom.c
+++ b/bloom.c
@@ -29,8 +29,8 @@ static inline unsigned char get_bitmask(uint32_t pos)
 }
 
 static int load_bloom_filter_from_graph(struct commit_graph *g,
-				   struct bloom_filter *filter,
-				   struct commit *c)
+					struct bloom_filter *filter,
+					struct commit *c)
 {
 	uint32_t lex_pos, start_index, end_index;
 
@@ -123,9 +123,9 @@ uint32_t murmur3_seeded(uint32_t seed, const char *data, size_t len)
 }
 
 void fill_bloom_key(const char *data,
-					size_t len,
-					struct bloom_key *key,
-					const struct bloom_filter_settings *settings)
+		    size_t len,
+		    struct bloom_key *key,
+		    const struct bloom_filter_settings *settings)
 {
 	int i;
 	const uint32_t seed0 = 0x293ae76f;
@@ -139,8 +139,8 @@ void fill_bloom_key(const char *data,
 }
 
 void add_key_to_filter(const struct bloom_key *key,
-					   struct bloom_filter *filter,
-					   const struct bloom_filter_settings *settings)
+		       struct bloom_filter *filter,
+		       const struct bloom_filter_settings *settings)
 {
 	int i;
 	uint64_t mod = filter->len * BITS_PER_WORD;
@@ -160,7 +160,7 @@ void init_bloom_filters(void)
 
 struct bloom_filter *get_bloom_filter(struct repository *r,
 				      struct commit *c,
-					  int compute_if_not_present)
+				      int compute_if_not_present)
 {
 	struct bloom_filter *filter;
 	struct bloom_filter_settings settings = DEFAULT_BLOOM_FILTER_SETTINGS;
diff --git a/bloom.h b/bloom.h
index b935186425d..a51e3715296 100644
--- a/bloom.h
+++ b/bloom.h
@@ -74,8 +74,8 @@ void fill_bloom_key(const char *data,
 		    const struct bloom_filter_settings *settings);
 
 void add_key_to_filter(const struct bloom_key *key,
-					   struct bloom_filter *filter,
-					   const struct bloom_filter_settings *settings);
+		       struct bloom_filter *filter,
+		       const struct bloom_filter_settings *settings);
 
 void init_bloom_filters(void);
 
-- 
gitgitgadget

