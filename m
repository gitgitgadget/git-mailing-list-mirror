Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8986CC00528
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 18:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjHASmP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 14:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjHASmJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 14:42:09 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040D3CC
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 11:41:54 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-583312344e7so74223387b3.1
        for <git@vger.kernel.org>; Tue, 01 Aug 2023 11:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690915314; x=1691520114;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W4FSASYFJjEH2RUXE2DEfQwMxTomYyPk0dT3J9KyV5I=;
        b=d+lxOt4IzX9Rzy+E1Sb/oLWoOr6Sxg2cytLM04WQRr9pLWZBT5c8+N9RU+7V+WnK/c
         EiwlyZ/+g7XbCCTkAtiOkBdp+axVT8L00Xg7JLznqCO+JhWIYzzq0m7lfywHZItDH9oP
         ROZWx9Wqfzuh5rtSiF4th6m0YL4XQr/Z+UYDCaZ3fzuVlTxYEHb5nRvbzE3akbpjOsqz
         mdXJIcnnu+xLrOZ0Vi7mnJG915EoRGSCI0D3PIRhNks3BkgZphemkRQIOrn1nKXhfNZH
         0G3HnXlfzFSVVaw5hcsMZiKifPh7l8SyQI7IsNTfFZC71Llq6HXN7Re4Jh5sl4J0qyOD
         CE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690915314; x=1691520114;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W4FSASYFJjEH2RUXE2DEfQwMxTomYyPk0dT3J9KyV5I=;
        b=C/IzZwkZVPu9JroOn6s4I+J/8Sz1UgbhlljJ9RD1d/hIB6+3SNXjYaSxxQKJbNDMdA
         Dfzfh+n0jeEVVW4o9RDwgXegBfqx19pSd1KQcr/j9WrWYFRSSf8aBSgdqoEs93IHG2BU
         YzG7T1m4Wb8gnCrnrAIOUTURB4eKNcMCR9/y0jTxx/Jsy3M3GKrae4Tr7LPHJaS2PKvY
         lRwv4wMIJB4RDMC0HEg7WtzXafmzFjlSrcevnQ9bq6znTqVBJzXYAfwGEh2HL5Qb7erD
         h958FEwTeGzANJC207q4h13AyPxj/UZLdxiMIxyBBPTGyDRnjmz+vzwFM39yI6q+uy6n
         C2rw==
X-Gm-Message-State: ABy/qLaBhh0hBR69ToGjZUUAFBOKlXp5XcpqD4m3aJakPaOMgygPZIZR
        +0o2GtSbX+Gxg7iQdKxI+vwEhUqLJSH0wyNZrYN0poZT9w9t61oDu5lkLrcKCfpkIDwf1O9vADQ
        a8l8x/KO99imSh/12TLvU9rpDtz75RNgIi0ble7GQ18gAam65I/AKKgcb3nadrheASdD1bJzJGv
        c9
X-Google-Smtp-Source: APBJJlFY8qDNhDRRZbda942k0pEjxIbT8EvT2aP4cBushhNzquif/uKJY5FMFdaRQWM0lhfmaOV8hj28o5foBdmbw7Dh
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:a487:6e54:d296:9521])
 (user=jonathantanmy job=sendgmr) by 2002:a81:4007:0:b0:583:4551:858d with
 SMTP id l7-20020a814007000000b005834551858dmr120582ywn.9.1690915313974; Tue,
 01 Aug 2023 11:41:53 -0700 (PDT)
Date:   Tue,  1 Aug 2023 11:41:38 -0700
In-Reply-To: <cover.1690912539.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1684790529.git.jonathantanmy@google.com> <cover.1690912539.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <f144dc4b15ea97cb6214a4bfbf2d88d8f16f05be.1690912539.git.jonathantanmy@google.com>
Subject: [PATCH v7 3/7] bloom.h: make `load_bloom_filter_from_graph()` public
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Taylor Blau <me@ttaylorr.com>

Prepare for a future commit to use the load_bloom_filter_from_graph()
function directly to load specific Bloom filters out of the commit-graph
for manual inspection (to be used during tests).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
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
2.41.0.585.gd2178a4bd4-goog

