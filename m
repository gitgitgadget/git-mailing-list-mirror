Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED11DEE49A6
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 21:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjHUVoJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 17:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjHUVoI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 17:44:08 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A202F183
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 14:44:06 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-58dfe2d5b9aso52409917b3.1
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 14:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692654245; x=1693259045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NpeNsy9E+Tz9gW/gHL8pRzM+YaqzHk/FuZOzIAvMvfM=;
        b=rAUiAd9NDsymd/ORnw5EC2CfGgDsTDFQYyVyYiz7dyrTY1p/Xp2dfv+Oh8X8VQoy5U
         r43ALvnYcNMQDJNrs5MRPGy4gJ3pipsKEatrovxejUIC/9FL8ENvVD5XTGomY7MpcS98
         7vl5shAld13GsmM98mn/86HKiEbGuhv0APLr/DAohTGoPktrrr9Qv46vNpDKZiBT9483
         Xw6Zk9Leyg+PF7bKi3oXFXHPsBmdjyBgSa3Khhqo1k9swCxsvJXqYb/Bh0Bc7/p+Q0p3
         OmonjjOJbQbahOJzM4AN3IP8ogdyI3Atyb48RFlZw7ge642FH9v0AuZb1eLRgSJ+JTWG
         CpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692654245; x=1693259045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NpeNsy9E+Tz9gW/gHL8pRzM+YaqzHk/FuZOzIAvMvfM=;
        b=UEk8L6/Br9vgchCelunYiE6Ia33Iwj3Oa/flBOp6UXxEIqtuJNNdW1BQHn8TDqT2VN
         e9bMK9b2itys4AfGHxT1r00Lil6fRikuQcoMOKKP4/ShmyFtCdMgl8szWV/YHvqBORba
         BdvXaTXQMcBwuHOWsQM3JAw37aw7fMjY12ZXE9ngMeHOteddx4Mn2QOS5RdfQfwsEBIC
         Gg5xCAOLWrlMNUPa70iKqwpt7ABtOuUbEeqRwGB96+zHy0AoGQJiPDxmOwnW12xypFIM
         tOzGvqhBRZfohmJBWnsNtJ8DOYEob00TviKUdbl89B0L2LBgFGiJhkZAVyM2JXcMbb+J
         JFIg==
X-Gm-Message-State: AOJu0YxJeMP+yoMz68ueAeiD/N344JhInPF7ggXGxYw6vO2wfvUkjr5c
        GX42iFBu92kPqiNAmIZIx3caZ9ZueA2H/orhCnmCNw==
X-Google-Smtp-Source: AGHT+IFWx+qtAViGB8/wfYGdrzB6Fhvbdr8UzQAYre2sJIqkRkhjSN9jh1h4j6bGwgJbZ3EXyoOFzA==
X-Received: by 2002:a0d:ca0b:0:b0:57a:3942:bb74 with SMTP id m11-20020a0dca0b000000b0057a3942bb74mr5701110ywd.17.1692654245733;
        Mon, 21 Aug 2023 14:44:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l4-20020a81d544000000b005839a780c29sm2405784ywj.102.2023.08.21.14.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 14:44:05 -0700 (PDT)
Date:   Mon, 21 Aug 2023 17:44:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 03/15] bloom.h: make `load_bloom_filter_from_graph()` public
Message-ID: <766feac8cb8e796eaf99ecd4b92ff66293356814.1692654233.git.me@ttaylorr.com>
References: <cover.1692654233.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1692654233.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prepare for a future commit to use the load_bloom_filter_from_graph()
function directly to load specific Bloom filters out of the commit-graph
for manual inspection (to be used during tests).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 bloom.c | 6 +++---
 bloom.h | 5 +++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/bloom.c b/bloom.c
index aef6b5fea2..3e78cfe79d 100644
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
index adde6dfe21..1e4f612d2c 100644
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
2.42.0.4.g52b49bb434

