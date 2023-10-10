Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247FCCD8CB4
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 20:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343647AbjJJUds (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 16:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234452AbjJJUdm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 16:33:42 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C369A4
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 13:33:39 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-4180b417309so35404631cf.0
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 13:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696970018; x=1697574818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9hlMWRvbuibDzGg8s6Dw+jhGsMoYGMxXXFJm4MZRO3c=;
        b=1QeINkwGeqZmNF+GFi3qmQXrMdO7THFLUQyqzMIoToPjITmo9GFyo9KL/lzJ3+dIlg
         QOe4idplqlNIFK7828tmMpejOh2RZXKXx2vdgi7YG6i3Qc1n2y0anoMv0loD/y/7U5fU
         19LtTW6Hj74+t7NyGUIUvbs3W9RFIOdOSsBfy6VFv2QTjl/lluvLTQLglbAlvOh4wwpe
         MD2WEvtVldWleJhTVAttj+gEkTTYVwWk8uYL+N6sjf9+GVBWfcWDDiRo7PmidHPWKtsC
         5JiLeeA+VFN2GrHmh1p3/iqHtpwSOlUiyza4+AX+N55XJWLzQqaFuHH+XOOyJQSF5Oxw
         CM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696970018; x=1697574818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hlMWRvbuibDzGg8s6Dw+jhGsMoYGMxXXFJm4MZRO3c=;
        b=SFlf8QsDFaMYv/c3Lauj8VDHw4TqwKU5hvadPjA+niaLZHW02l4Svg0yJeJo6btUEi
         E3ur8Kf3M5E/gijg3C3AHEJ8g0ZHvUiEborTbnoSeVLKt8DkvfB3hwUzQhxZI+72tNmv
         oXwNB3/L6+9RTHCsnDS3XIEi7uhULyp+V1BdR9Qm6WkhAYu5ZeJF5t4Q8wKZdvn5YlBu
         bK0JM/7/HTXbvc1HsLdh/HhcwtSvWKKdEXkopAC0WU8Zw43pQ3i9cSJ0ubb/LqVD3gal
         OQAspefEORslPvE6/0jGMoZ4cupSJHjZrQAG4d19muGHf/8ZyhUyOehP2h66Bc8ywzG5
         M9TQ==
X-Gm-Message-State: AOJu0YyCxa/oBIBhZPp48ZaiuyvTi8mbuk+CLRUPsKYTGVU1t7X+82Fg
        o7idVkykibvTyCkVIfYJsD8ACaRerBeoQ/rb6XzWsg==
X-Google-Smtp-Source: AGHT+IFG8jssftf8I1p4+1Ws0o5CYJqvMmmyfTdMD5DDz6I2v7XJ6fdpdCdm2e4KEvl87D2e4fN0Xw==
X-Received: by 2002:a05:622a:15d0:b0:418:1a08:729 with SMTP id d16-20020a05622a15d000b004181a080729mr20286750qty.10.1696970017784;
        Tue, 10 Oct 2023 13:33:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y12-20020a05622a120c00b0041991642c62sm4774605qtx.73.2023.10.10.13.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 13:33:37 -0700 (PDT)
Date:   Tue, 10 Oct 2023 16:33:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v3 06/17] bloom.h: make `load_bloom_filter_from_graph()`
 public
Message-ID: <3d81efa27b9b7c5b0cc2c77d080c7b65a4e46faa.1696969994.git.me@ttaylorr.com>
References: <cover.1692654233.git.me@ttaylorr.com>
 <cover.1696969994.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1696969994.git.me@ttaylorr.com>
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
2.42.0.342.g8bb3a896ee

