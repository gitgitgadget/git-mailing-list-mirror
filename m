Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7507AC83F1F
	for <git@archiver.kernel.org>; Wed, 30 Aug 2023 18:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjH3S32 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343751AbjH3QoW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2023 12:44:22 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3FA19A
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 09:44:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7493fcd829so6783995276.3
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 09:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693413859; x=1694018659; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jgMmPprfbr6yxuzkSBvh6xzHrlrH6VPE5214ypOafUs=;
        b=52qzMA7xrFVkty2foWzNE8x5dL8fhIC+042rhcn/7AwLZ+jMBiJbXyGF6c3+VtZBDC
         4OvlD++Yl1z/CWD6U7Ojr9tj7IhGeVJGw2riTDQcuOghmNN5Su/HyWI+nTaPYW9bULIn
         bZuk+/xPZBSnKMYg8MKkPMDX1jZPgApGgTmUfHKw5D4DH5djNLm09OETG3BYIy7Yrplb
         pepNQQ1z4V1jVEnaugXqnTn8FBojtjiy3oTC5CXOgyEuW5P8k8Pk9fyAy5kVDU/ZuZKi
         UKZLMrIKoazT6oMRT7y/iylnf0/7hNFY6EWUeJKAIvH7cb21JgZfHim2t/SgvVvyIfEW
         LiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693413859; x=1694018659;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jgMmPprfbr6yxuzkSBvh6xzHrlrH6VPE5214ypOafUs=;
        b=f2ty82szlelqjRJKthjDC4/VeYWLejzX+MinWntxCmnI/W0hjZj1EXiSWibgTaQqNF
         jwtD0RhV0s5toVfi51wkCH0fxcMuX60hFqiSQ6rq+0bplv2Qbu6hzl1FbGCoH4SEJfOw
         w6sbmCukwo+bWarPcrnEYnjtRJyexzLEys+6OwnB2mRV8qhFi2HwKqYTLUZHPKruWAqe
         cx4kaC/d0ztHt9tHLNRllsdeoCKGnG4xXku3AwJw/Uo4SH+sIKykSXWbzCVpoBL/Ot9Q
         4JZDzjmXpk0eiECnnZV1mV3HP6z2llT8i63Qkm3hvPZ0LiYuLBbrJNTm3ft+LsenREd4
         BcQw==
X-Gm-Message-State: AOJu0YymeiFsbKHaiRAMsy/Ur3jcCIuZF90LdPo9s775F55UGervZT7N
        KGpSnjcc6AqHHQkNnj7MUCZpxpA0ghCj+D5ljCwPvkL5D8T+6+5PPOhChzkMyjPpC8oRNVY/++B
        70d5XW7gkHq+QKfOR2t7WTYJE0NyMksXUgd3updRhPLhdoqua0C7Mv0qGszpgAWlJqY2rbbZJTq
        ce
X-Google-Smtp-Source: AGHT+IFqiOwfgp8zk8P4TQtj1BQrkFZiwbEq1bAj9Uzn+w8vkx7E4Lz3z37VoQAG3bHZUXTtB3i7cwW+b0+zjYHVDRm/
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:2899:32d6:b7e3:8e6e])
 (user=jonathantanmy job=sendgmr) by 2002:a5b:acd:0:b0:d0f:a0a6:8e87 with SMTP
 id a13-20020a5b0acd000000b00d0fa0a68e87mr73739ybr.2.1693413859129; Wed, 30
 Aug 2023 09:44:19 -0700 (PDT)
Date:   Wed, 30 Aug 2023 09:43:50 -0700
In-Reply-To: <cover.1693413637.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1692654233.git.me@ttaylorr.com> <cover.1693413637.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <ef04389a0e791610551d420a8aaf503b503f6d0a.1693413637.git.jonathantanmy@google.com>
Subject: [PATCH v2 10/15] t/t4216-log-bloom.sh: harden `test_bloom_filters_not_used()`
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "SZEDER =?utf-8?B?R8OhYm9y?=" <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Taylor Blau <me@ttaylorr.com>

The existing implementation of test_bloom_filters_not_used() asserts
that the Bloom filter sub-system has not been initialized at all, by
checking for the absence of any data from it from trace2.

In the following commit, it will become possible to load Bloom filters
without using them (e.g., because `commitGraph.changedPathVersion` is
incompatible with the hash version with which the commit-graph's Bloom
filters were written).

When this is the case, it's possible to initialize the Bloom filter
sub-system, while still not using any Bloom filters. When this is the
case, check that the data dump from the Bloom sub-system is all zeros,
indicating that no filters were used.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4216-log-bloom.sh | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 1d0e11d7c1..940a71d8b8 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -81,7 +81,19 @@ test_bloom_filters_used () {
 test_bloom_filters_not_used () {
 	log_args=$1
 	setup "$log_args" &&
-	! grep -q "statistics:{\"filter_not_present\":" "$TRASH_DIRECTORY/trace.perf" &&
+
+	if grep -q "statistics:{\"filter_not_present\":" "$TRASH_DIRECTORY/trace.perf"
+	then
+		# if the Bloom filter system is initialized, ensure that no
+		# filters were used
+		data="statistics:{"
+		data="$data\"filter_not_present\":0,"
+		data="$data\"maybe\":0,"
+		data="$data\"definitely_not\":0,"
+		data="$data\"false_positive\":0}"
+
+		grep -q "$data" "$TRASH_DIRECTORY/trace.perf"
+	fi &&
 	test_cmp log_wo_bloom log_w_bloom
 }
 
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

