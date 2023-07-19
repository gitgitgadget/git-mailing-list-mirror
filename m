Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B5EC001B0
	for <git@archiver.kernel.org>; Wed, 19 Jul 2023 17:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjGSRzx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jul 2023 13:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjGSRzu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2023 13:55:50 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E18A1FD9
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 10:55:48 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7943bfaed0dso2440223241.0
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 10:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689789348; x=1692381348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OUK+kS+k7mtsGqJg0dt3rQfpUbUpYneqSPgxiJQ86o0=;
        b=FHUJXT5pC6PpXamxFTSFIVgbUvJB3RRNEgF8FWbZ0WbLlz7aCunvdLXXsusDZVKEbX
         FfOjk9mDG4EWOdBTTaAB3grgNz4Urx603dY1dfm8lBujrJArsAvDVUmjik4N2k/Kesdc
         5gfvznx3y7EYuzx7DhXs4oLAH62Mw/oiIUn5E9UX4ag3G6lwlV4aFFqSZf65ED+H0Eha
         VBAfSQ7YUQwh4XDeFDrnYN5IRJfRr7KcrSKCRqTpibIw7/4ljSv1OxIuKIBncow5yYzw
         aYZJJZCCp+B9q2t6X3W54L8rtbfcqao68dA3ASF0LlNPjaS2D+JHyH2uVR7+7ZXTQ+xe
         0QoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689789348; x=1692381348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUK+kS+k7mtsGqJg0dt3rQfpUbUpYneqSPgxiJQ86o0=;
        b=JAkO0RqI5pFtmRO20iHE+qtgOJHcS/MFpaJ0k7jvZjZsDrSZRjRLu61oUZfsVCRBBP
         hFO/mWnUOyqPK8PQygj3LosnGAzWdm4i1y+y5Xl88R6p9OZm/HwWyxxgSo6DNmqyifV2
         HltmUXop1lmenDncCy6ibzL7T302LzI0k7ZixRFcDB6loeO3EcGoFzsgq02HhexvjfVy
         YcU7yyIYw0IvyIJChw/QpikoKvlxTOF3VSxox70KNbNjANp1qTVs+V4GFH0q7Zq/Z6gE
         Tw4WVWMT+LTePfg0Sdwz/c3EfdS+y/flO8JxPwi6Ha4KuoOj8DJdNFCEIsZ45N9eP1zR
         lZVQ==
X-Gm-Message-State: ABy/qLYFMUzzv6UJ7p+mi4e3uFSymLf4f6wEajNW8TV3ZcbFgYmRQiwg
        RTmr2LSOq1U20TeEi0cGUdcBZ8qQmQ6Pd7Vh+j9FJw==
X-Google-Smtp-Source: APBJJlGzx0aCmeZcVQc1kH0M3v6dRHV36zk5BWFmaTSLhxZ2t96uOeK3c2+YXUrMHmBrBISp2qvQXw==
X-Received: by 2002:a67:fd62:0:b0:440:981b:3840 with SMTP id h2-20020a67fd62000000b00440981b3840mr2231104vsa.31.1689789347868;
        Wed, 19 Jul 2023 10:55:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a84-20020a0dd857000000b0057a560a9832sm1149401ywe.1.2023.07.19.10.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 10:55:47 -0700 (PDT)
Date:   Wed, 19 Jul 2023 13:55:46 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4] bloom.h: make `load_bloom_filter_from_graph()` public
Message-ID: <cc56e0afda2ea8ad501d58d207ce94f802342efa.1689789226.git.me@ttaylorr.com>
References: <ZLgc5q0FrL1s7j0j@nand.local>
 <cover.1689789226.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1689789226.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prepare for a future commit to use the load_bloom_filter_from_graph()
function directly to load specific Bloom filters out of the commit-graph
for manual inspection (to be used during tests).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 bloom.c | 6 +++---
 bloom.h | 5 +++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/bloom.c b/bloom.c
index aef6b5fea2d..3e78cfe79d4 100644
--- a/bloom.c
+++ b/bloom.c
@@ -29,9 +29,9 @@ static inline unsigned char get_bitmask(uint32_t pos)
 	return ((unsigned char)1) << (pos & (BITS_PER_WORD - 1));
 }
 
-static int load_bloom_filter_from_graph(struct commit_graph *g,
-					struct bloom_filter *filter,
-					uint32_t graph_pos)
+int load_bloom_filter_from_graph(struct commit_graph *g,
+				 struct bloom_filter *filter,
+				 uint32_t graph_pos)
 {
 	uint32_t lex_pos, start_index, end_index;
 
diff --git a/bloom.h b/bloom.h
index adde6dfe212..1e4f612d2c2 100644
--- a/bloom.h
+++ b/bloom.h
@@ -3,6 +3,7 @@
 
 struct commit;
 struct repository;
+struct commit_graph;
 
 struct bloom_filter_settings {
 	/*
@@ -68,6 +69,10 @@ struct bloom_key {
 	uint32_t *hashes;
 };
 
+int load_bloom_filter_from_graph(struct commit_graph *g,
+				 struct bloom_filter *filter,
+				 uint32_t graph_pos);
+
 /*
  * Calculate the murmur3 32-bit hash value for the given data
  * using the given seed.
-- 
2.41.0.366.g215419bf3c2.dirty

