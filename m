Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD48EB64D9
	for <git@archiver.kernel.org>; Mon, 10 Jul 2023 21:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbjGJVNB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jul 2023 17:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjGJVMi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2023 17:12:38 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D25DE51
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 14:12:33 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5774335bb2aso56615497b3.0
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 14:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689023552; x=1691615552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S4SRKp02/Vp9FLRQJwOFgjkNGFbphg2TUJVzDCQhIWQ=;
        b=mc9GR6HskVEsU+8K/lO8aXzBh+JU44Shut+r+bVR267aZf2V1FBlmOyA6gbiB1D0AN
         +pb5NxC7rTX3h1jZjPrhwaGzsO1JlyNRNmyg7wnmr9bI7EquAUaeqaZgUj/y0gxv3X4b
         YyZdPnwjotfya476fw55akQoHgld83PTwVYrYELlAmDXs/0J49Vo5fZ+8qwcUuszFlTk
         PhYZ8nQ7/FDijmNyIdv1mH54XPefT7JBSPuvmLgPXBDP0Aohalt6sFtaOd9n2PkJ9f2w
         yJiFLTvot+SPSorDe98nBG2wcuSvBr6WC7u4IjRb9j0XX6fVVawiDQwQKtWQBw5DFKII
         h7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689023552; x=1691615552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4SRKp02/Vp9FLRQJwOFgjkNGFbphg2TUJVzDCQhIWQ=;
        b=k3youL7NS0GkWLzxDnSASEMTQeOejtmj4yyiBhmNsovVnkenPsKZxPwwBAomDECCUC
         GjNKWl4S2DyCc32b8uRtBWm8JMCkM43SN8VrXPILCGBQJW/4O/nhrNUKE0HNzwLrb8/C
         g9LvBILWcPEaxwLmn40zwK/2VJzsISWkAQvkzoytI5SR/4ewQ8lnoywZRmkN0PdfK1u1
         sqW/voPjG5IrhLJ1hNymTCn0mnlkSiWqDTLvTGJUrm+jWGCgmZz4CmQ83nthXTRe1YzG
         gQXptdhR2SFvO5xWDlXll5IZ4HxMwYed0Wt+GstkaEZO1apdARqAYh0NcRP9wDkyZCdw
         giBA==
X-Gm-Message-State: ABy/qLYwVWavOWZPzfEaDGfINKC4IaYmZpBLThqLlalAjmK4ovuFnx0E
        KVDpeW/gXLjAx0Vq4TBOKcwIPHjbIYZk0eQCn+71qg==
X-Google-Smtp-Source: APBJJlE6XHkxsa1KrdbVuM8rQBlWQplzjosZCptIMlyIBwkyqluKMWtWtB0fja/HogmyH7iVWcgSxw==
X-Received: by 2002:a0d:d94f:0:b0:573:1db2:7f7d with SMTP id b76-20020a0dd94f000000b005731db27f7dmr11886303ywe.2.1689023552363;
        Mon, 10 Jul 2023 14:12:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b62-20020a816741000000b0054f56baf3f2sm179886ywc.122.2023.07.10.14.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 14:12:32 -0700 (PDT)
Date:   Mon, 10 Jul 2023 17:12:31 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 10/16] refs/packed-backend.c: add trace2 counters for jump
 list
Message-ID: <e150941c1d1b98ee10094f9a7b7ce0346a2cd9f4.1689023520.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1689023520.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1689023520.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous commit added low-level tests to ensure that the packed-refs
iterator did not enumerate excluded sections of the refspace.

However, there was no guarantee that these sections weren't being
visited, only that they were being suppressed from the output. To harden
these tests, add a trace2 counter which tracks the number of regions
skipped by the packed-refs iterator, and assert on its value.

Suggested-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 refs/packed-backend.c   |  2 ++
 t/t1419-exclude-refs.sh | 59 ++++++++++++++++++++++++++++-------------
 trace2.h                |  2 ++
 trace2/tr2_ctr.c        |  5 ++++
 4 files changed, 49 insertions(+), 19 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index d9e008819b5..59c78d7941f 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -13,6 +13,7 @@
 #include "../statinfo.h"
 #include "../wrapper.h"
 #include "../write-or-die.h"
+#include "../trace2.h"
 
 enum mmap_strategy {
 	/*
@@ -846,6 +847,7 @@ static int next_record(struct packed_ref_iterator *iter)
 		iter->jump_cur++;
 		if (iter->pos < curr->end) {
 			iter->pos = curr->end;
+			trace2_counter_add(TRACE2_COUNTER_ID_PACKED_REFS_JUMPS, 1);
 			/* jumps are coalesced, so only one jump is necessary */
 			break;
 		}
diff --git a/t/t1419-exclude-refs.sh b/t/t1419-exclude-refs.sh
index bc534c8ea18..5d8c86b6573 100755
--- a/t/t1419-exclude-refs.sh
+++ b/t/t1419-exclude-refs.sh
@@ -9,7 +9,8 @@ TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 for_each_ref__exclude () {
-	test-tool ref-store main for-each-ref--exclude "$@" >actual.raw
+	GIT_TRACE2_PERF=1 test-tool ref-store main \
+		for-each-ref--exclude "$@" >actual.raw
 	cut -d ' ' -f 2 actual.raw
 }
 
@@ -17,6 +18,17 @@ for_each_ref () {
 	git for-each-ref --format='%(refname)' "$@"
 }
 
+assert_jumps () {
+	local nr="$1"
+	local trace="$2"
+
+	grep -q "name:jumps_made value:$nr$" $trace
+}
+
+assert_no_jumps () {
+	! assert_jumps ".*" "$1"
+}
+
 test_expect_success 'setup' '
 	test_commit --no-tag base &&
 	base="$(git rev-parse HEAD)" &&
@@ -35,67 +47,76 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'excluded region in middle' '
-	for_each_ref__exclude refs/heads refs/heads/foo >actual &&
+	for_each_ref__exclude refs/heads refs/heads/foo >actual 2>perf &&
 	for_each_ref refs/heads/bar refs/heads/baz refs/heads/quux >expect &&
 
-	test_cmp expect actual
+	test_cmp expect actual &&
+	assert_jumps 1 perf
 '
 
 test_expect_success 'excluded region at beginning' '
-	for_each_ref__exclude refs/heads refs/heads/bar >actual &&
+	for_each_ref__exclude refs/heads refs/heads/bar >actual 2>perf &&
 	for_each_ref refs/heads/baz refs/heads/foo refs/heads/quux >expect &&
 
-	test_cmp expect actual
+	test_cmp expect actual &&
+	assert_jumps 1 perf
 '
 
 test_expect_success 'excluded region at end' '
-	for_each_ref__exclude refs/heads refs/heads/quux >actual &&
+	for_each_ref__exclude refs/heads refs/heads/quux >actual 2>perf &&
 	for_each_ref refs/heads/foo refs/heads/bar refs/heads/baz >expect &&
 
-	test_cmp expect actual
+	test_cmp expect actual &&
+	assert_jumps 1 perf
 '
 
 test_expect_success 'disjoint excluded regions' '
-	for_each_ref__exclude refs/heads refs/heads/bar refs/heads/quux >actual &&
+	for_each_ref__exclude refs/heads refs/heads/bar refs/heads/quux >actual 2>perf &&
 	for_each_ref refs/heads/baz refs/heads/foo >expect &&
 
-	test_cmp expect actual
+	test_cmp expect actual &&
+	assert_jumps 2 perf
 '
 
 test_expect_success 'adjacent, non-overlapping excluded regions' '
-	for_each_ref__exclude refs/heads refs/heads/bar refs/heads/baz >actual &&
+	for_each_ref__exclude refs/heads refs/heads/bar refs/heads/baz >actual 2>perf &&
 	for_each_ref refs/heads/foo refs/heads/quux >expect &&
 
-	test_cmp expect actual
+	test_cmp expect actual &&
+	assert_jumps 1 perf
 '
 
 test_expect_success 'overlapping excluded regions' '
-	for_each_ref__exclude refs/heads refs/heads/ba refs/heads/baz >actual &&
+	for_each_ref__exclude refs/heads refs/heads/ba refs/heads/baz >actual 2>perf &&
 	for_each_ref refs/heads/foo refs/heads/quux >expect &&
 
-	test_cmp expect actual
+	test_cmp expect actual &&
+	assert_jumps 1 perf
 '
 
 test_expect_success 'several overlapping excluded regions' '
 	for_each_ref__exclude refs/heads \
-		refs/heads/bar refs/heads/baz refs/heads/foo >actual &&
+		refs/heads/bar refs/heads/baz refs/heads/foo >actual 2>perf &&
 	for_each_ref refs/heads/quux >expect &&
 
-	test_cmp expect actual
+	test_cmp expect actual &&
+	assert_jumps 1 perf
 '
 
 test_expect_success 'non-matching excluded section' '
-	for_each_ref__exclude refs/heads refs/heads/does/not/exist >actual &&
+	for_each_ref__exclude refs/heads refs/heads/does/not/exist >actual 2>perf &&
 	for_each_ref >expect &&
 
-	test_cmp expect actual
+	test_cmp expect actual &&
+	assert_no_jumps perf
 '
 
 test_expect_success 'meta-characters are discarded' '
-	for_each_ref__exclude refs/heads "refs/heads/ba*" >actual &&
+	for_each_ref__exclude refs/heads "refs/heads/ba*" >actual 2>perf &&
 	for_each_ref >expect &&
 
-	test_cmp expect actual
+	test_cmp expect actual &&
+	assert_no_jumps perf
 '
 
 test_done
diff --git a/trace2.h b/trace2.h
index f5c5a9e6bac..850056128fc 100644
--- a/trace2.h
+++ b/trace2.h
@@ -552,6 +552,8 @@ enum trace2_counter_id {
 	TRACE2_COUNTER_ID_TEST1 = 0, /* emits summary event only */
 	TRACE2_COUNTER_ID_TEST2,     /* emits summary and thread events */
 
+	TRACE2_COUNTER_ID_PACKED_REFS_JUMPS, /* counts number of jumps */
+
 	/* Add additional counter definitions before here. */
 	TRACE2_NUMBER_OF_COUNTERS
 };
diff --git a/trace2/tr2_ctr.c b/trace2/tr2_ctr.c
index b342d3b1a3c..50570d01653 100644
--- a/trace2/tr2_ctr.c
+++ b/trace2/tr2_ctr.c
@@ -27,6 +27,11 @@ static struct tr2_counter_metadata tr2_counter_metadata[TRACE2_NUMBER_OF_COUNTER
 		.name = "test2",
 		.want_per_thread_events = 1,
 	},
+	[TRACE2_COUNTER_ID_PACKED_REFS_JUMPS] = {
+		.category = "packed-refs",
+		.name = "jumps_made",
+		.want_per_thread_events = 0,
+	},
 
 	/* Add additional metadata before here. */
 };
-- 
2.41.0.343.gdff068c469f

