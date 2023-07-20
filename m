Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A163CEB64DA
	for <git@archiver.kernel.org>; Thu, 20 Jul 2023 21:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjGTVrB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jul 2023 17:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjGTVqz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2023 17:46:55 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDB72733
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 14:46:49 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c83284edf0eso1064302276.3
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 14:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689889609; x=1690494409;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EFqosoDfu1CUILSMDQXaHaKglnGlXqY32Ka+o4CRm8A=;
        b=DEApSUaFSFkjrbj1BjCdQRz6lPco8Qa0FBzbKN/c5jqzeg3elVg6beQjevqIRdFBT1
         rLndzaSgkWM5MgrO+5OlR1uHHCC05zWAEZG85DrpOGmA8qDbIxBeCG1ElTgCRVSx/fi1
         R2Zh3VmKhfb20GQN9iuwOpgYDvsCkYGIBYlSrIqJDI0pXIuD0yhqKHGNnN5pfzAk2ehw
         +rMoFnzUALBS2mqgJz0hTNIlVop/9B6Cv0K9vCKIUfIt4koMK2RAfJJqj0hf+ngQ4D4j
         sBMibJoDmu+Hh3V6WpPGCzQJd0bo7fOnMu/WuDIvLgdLG6EeFNp2D+SpijdjJBBBeF77
         Fd8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689889609; x=1690494409;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EFqosoDfu1CUILSMDQXaHaKglnGlXqY32Ka+o4CRm8A=;
        b=HfXpoqy4XrYL2qwVzJUFUO+2h8woR+iEVrvgcWqeRjqUE8Xzmmo0SS8wHWgoYc7bBd
         gtI3964W11UFW6lFHqBO//x0NCfgtUTBHlDa5wYiwzAzFc/Y+aHaIr+lHSjMyPy9Rk9V
         qpRQHYUlesDaEQRpsSWfzsT1LfWR8AzqjMT9BwNguCzmG3CESRUdfH14kYMehrmN0TDn
         8yk95g543X9X3uw6Yc2MDH2aChKd4Jx+mUtRz6dsO4uEudPv/grF9rR35+u8Ovjizsxj
         vfAJC9DjzzyCVDfrwaqsw/ofjC9ITWsuaUoqL8pHinHXKAxdFV6nTl3lj/ItsHXFF7tx
         kSdA==
X-Gm-Message-State: ABy/qLZ+JqDHnqNBJsiiJuGxcBHcje3lexVXU31JYzWssK+I9unkjeJF
        a28utqbWEy7GdWdQO3LU9Qb+rm8qDy/ySJ5kGPCa+LUJhz5fSZxxtEiwdWL8OWlLEOacDv2dxSC
        0Jt0aGI6N8zFiuuyfsNheBX3/AdwSZe0vskceNW8mOTGg/cw62Q9L12FvqjGn90WS/YEXxe2ExB
        JZ
X-Google-Smtp-Source: APBJJlH6EcyXTVd6OtqgjqnUwBXy50zSAam2VEZgVITDB6NenPrDn0uVssNBQS3jd9yizuqjU0QYF3ELltGd48GfBZka
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:387b:f15b:5fda:c8a5])
 (user=jonathantanmy job=sendgmr) by 2002:a25:910f:0:b0:ca7:8c92:4f62 with
 SMTP id v15-20020a25910f000000b00ca78c924f62mr1274ybl.9.1689889609190; Thu,
 20 Jul 2023 14:46:49 -0700 (PDT)
Date:   Thu, 20 Jul 2023 14:46:36 -0700
In-Reply-To: <cover.1689889382.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1684790529.git.jonathantanmy@google.com> <cover.1689889382.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <4cf7c2f634c09b0912963fb2360aa31eb1d8dbba.1689889382.git.jonathantanmy@google.com>
Subject: [PATCH v6 3/7] bloom.h: make `load_bloom_filter_from_graph()` public
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
2.41.0.487.g6d72f3e995-goog

