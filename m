Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE0BC4724C
	for <git@archiver.kernel.org>; Fri,  1 May 2020 15:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEBB9208DB
	for <git@archiver.kernel.org>; Fri,  1 May 2020 15:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7dUM9p3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbgEAPae (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 11:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729396AbgEAPad (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 11:30:33 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E71C061A0E
        for <git@vger.kernel.org>; Fri,  1 May 2020 08:30:32 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h9so1584748wrt.0
        for <git@vger.kernel.org>; Fri, 01 May 2020 08:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RmgF5TDTH2YI6FYM/8ilYhDL1HN/g5InUDNye3oVdUQ=;
        b=J7dUM9p31pPCY1QhSD6HKhyyahL9KqXHbYsykKC9p1lDkuP3LMmD9Dqdbw+lms4Ihl
         lWkaI/ox/F8NSgoqrIea1CNtJqEmThCzIXG6RXDbqdEfldt9nYTKDxu9rjmPyt5S6en0
         6qZrixXE1uYZ69bEFB3IV4/xv6t7cEKXed2w5yORCWNj8+xccEvJP3wC2laPljig3Iep
         ILfL4REjCAOD/yKWp9yZWlv8RAQdptQ8WF6DIwbdOoHiolUr7J0TJU8ldxwKvXkttOlE
         IbFhxD3Ex7f53unLzUB3pCe5UrxuSQ4CZJWpqAgfcOynZsi3ZEdt2fUrcn3qDYfKaxxV
         0ffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RmgF5TDTH2YI6FYM/8ilYhDL1HN/g5InUDNye3oVdUQ=;
        b=t8EN8WLAx0mwN9yCAtdSu2vXz7eTC+PLnjJJ27k5VxjvFiQblnu0mci3aLbSLGmMn5
         84TD7gH3YS/m7fNpEs+8ugZfvGt2izNUaVYyBNJMv1z68gm3e/t0E7rRYU3Yi5iA3CGs
         s56EudYndKnKBOPsHL4UO59zkJKM/Lcr+2I6mWODKjZ3M5kcKb/3kIEVH09R65GP4pi5
         /YEgWjYiGx4pSnZE9FMBrFA8UHwolTRUTM/VJfiKHPQcLJco6CMMfJ9ItoJtQbGLqxvq
         ifPfFPmVGSVaJMmlCOS0dEbyZhnqk0ppfOEwe8IYXzFlAFRSHM8YXPumhfqLSJ4O3ieN
         qpRQ==
X-Gm-Message-State: AGi0Pua/F2p2E54EnbKeOrbnFro3owJuTG5tSkpDEhvqrZz8iScxMPPL
        6v9ZuXaI7xVp4+1CSUIUoS/OuRLo
X-Google-Smtp-Source: APiQypIIGpaYF9F2E2jkfq/b9KwbJZLF6+tqK3Sx0U6BKMFynbFFnMR4cjKn1KQ0uoTHkND8nVLTQg==
X-Received: by 2002:a5d:6082:: with SMTP id w2mr4600787wrt.163.1588347031535;
        Fri, 01 May 2020 08:30:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c10sm4722616wru.48.2020.05.01.08.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 08:30:31 -0700 (PDT)
Message-Id: <89625b0efae43c8cb0d444a843d389d6cb9f6772.1588347029.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.622.git.1588347029.gitgitgadget@gmail.com>
References: <pull.622.git.1588347029.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 May 2020 15:30:18 +0000
Subject: [PATCH 01/12] bloom: fix whitespace around tab length
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

