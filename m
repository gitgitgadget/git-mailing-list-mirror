Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35FBC7EE22
	for <git@archiver.kernel.org>; Mon,  8 May 2023 22:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbjEHWAl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 18:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234487AbjEHWAV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 18:00:21 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE46D4EC1
        for <git@vger.kernel.org>; Mon,  8 May 2023 15:00:13 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-b9a6eec8611so27529868276.0
        for <git@vger.kernel.org>; Mon, 08 May 2023 15:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683583213; x=1686175213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wXulJv0GbS2RuuPN7kYulGtzj0vZAeVDDYhxBrfWDNs=;
        b=SiwDKqUhCga4bpvU09mZeV0Oflkteziys76cM2/uNTTPXzVWYqt5iJ6NmnqpxYHaQz
         XnwSydEKvFNnpWY2l4a6ByyRF4EiDl696P5PijyTLdwENkbqTateoBQt/JDmBmMg7oU+
         pVkRldw6+08+T/IRcZgR7uHUlGNHVniyu4yaQwhQu5gr+ToGeAAZvUmJX+A9+r9RuvQY
         XMwIy2TALq41d2PglHCHAt8mW5y9lg3w5mjo3Z+rbjOb9v5zrXsTQqp5qq5P7C/NDF6z
         TLEKYhWu3X9mj1OWPAoPRtkiVtu68zQP7jpslvefDYC/PZr839LRGaXplqf/L+g4Vm9V
         uK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683583213; x=1686175213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXulJv0GbS2RuuPN7kYulGtzj0vZAeVDDYhxBrfWDNs=;
        b=Ht5i/oTa8Iv7Qx7/YBm1kGFuQr1khSA3VOzExNyXnpaew7Bm8Dux9Ax0vFlcPE4DB+
         OdEWyLKXS6ODYXtmudTkg9a8wc0X9K4Hrg53il2jd4ehomErG+FYrb6aAzpiuGYDCn5D
         ARCdeq5o6IHV3zYmGNbytHWIwAmqZw8WV7+ikXcXE2IevvGTUzRmXNMVssPH3gBHErel
         S0K1ZnGJhWtxvNGa+0DsFzGB1I5WutFLgaf+xMegrukQkhSQPLj+mR4ucftg7X+YZ/o7
         bJl2XB6pRgZuKEJrH0rklPtxvKjjUfUxk1C7VdB7s4PQ8h3gwPv3ahQNhsX9fKiV6tvj
         6ftQ==
X-Gm-Message-State: AC+VfDzAlgh9kqfQ3wkbHpv946Pe5CsF6QjrZfanXYWJxETT6KnVM4ge
        NklfSucMQ4wS34YLqey81ydetQIvLe8moS9HjiiTTA==
X-Google-Smtp-Source: ACHHUZ4pDWhX0g+OSqNpvUA1t6NLq9gAMrxWqmRpu/B8G1he2KMYFf6/wjGWBN2nMdTDG4ds7vURkA==
X-Received: by 2002:a0d:ea0c:0:b0:550:65b4:ca60 with SMTP id t12-20020a0dea0c000000b0055065b4ca60mr13946504ywe.8.1683583213394;
        Mon, 08 May 2023 15:00:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g127-20020a0df685000000b0054fba955474sm2816978ywf.17.2023.05.08.15.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 15:00:13 -0700 (PDT)
Date:   Mon, 8 May 2023 18:00:11 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 10/15] refs/packed-backend.c: add trace2 counters for skip
 list
Message-ID: <5698c2794f8c780b4f8d8591ceb4475ec26d17c6.1683581621.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1683581621.git.me@ttaylorr.com>
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
 t/t1419-exclude-refs.sh | 54 ++++++++++++++++++++++++++++-------------
 trace2.h                |  2 ++
 trace2/tr2_ctr.c        |  5 ++++
 4 files changed, 46 insertions(+), 17 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 137a4233f6..ddfa9add14 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -11,6 +11,7 @@
 #include "../chdir-notify.h"
 #include "../wrapper.h"
 #include "../write-or-die.h"
+#include "../trace2.h"
 
 enum mmap_strategy {
 	/*
@@ -844,6 +845,7 @@ static int next_record(struct packed_ref_iterator *iter)
 		iter->skip_pos++;
 		if (iter->pos < curr->end) {
 			iter->pos = curr->end;
+			trace2_counter_add(TRACE2_COUNTER_ID_PACKED_REFS_SKIPS, 1);
 			break;
 		}
 	}
diff --git a/t/t1419-exclude-refs.sh b/t/t1419-exclude-refs.sh
index da5265a5a8..051b5a54ce 100755
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
 
+assert_skips () {
+	local nr="$1"
+	local trace="$2"
+
+	grep -q "name:skips_made value:$nr" $trace
+}
+
+assert_no_skips () {
+	! assert_skips ".*" "$1"
+}
+
 test_expect_success 'setup' '
 	test_commit --no-tag base &&
 	base="$(git rev-parse HEAD)" &&
@@ -36,66 +48,74 @@ test_expect_success 'setup' '
 
 test_expect_success 'for_each_ref__exclude(refs/heads/foo/)' '
 	# region in middle
-	for_each_ref__exclude refs/heads refs/heads/foo >actual &&
+	for_each_ref__exclude refs/heads refs/heads/foo >actual 2>perf &&
 	for_each_ref refs/heads/bar refs/heads/baz refs/heads/quux >expect &&
 
-	test_cmp expect actual
+	test_cmp expect actual &&
+	assert_skips 1 perf
 '
 
 test_expect_success 'for_each_ref__exclude(refs/heads/bar/)' '
 	# region at beginning
-	for_each_ref__exclude refs/heads refs/heads/bar >actual &&
+	for_each_ref__exclude refs/heads refs/heads/bar >actual 2>perf &&
 	for_each_ref refs/heads/baz refs/heads/foo refs/heads/quux >expect &&
 
-	test_cmp expect actual
+	test_cmp expect actual &&
+	assert_skips 1 perf
 '
 
 test_expect_success 'for_each_ref__exclude(refs/heads/quux/)' '
 	# region at end
-	for_each_ref__exclude refs/heads refs/heads/quux >actual &&
+	for_each_ref__exclude refs/heads refs/heads/quux >actual 2>perf &&
 	for_each_ref refs/heads/foo refs/heads/bar refs/heads/baz >expect &&
 
-	test_cmp expect actual
+	test_cmp expect actual &&
+	assert_skips 1 perf
 '
 
 test_expect_success 'for_each_ref__exclude(refs/heads/bar/, refs/heads/quux/)' '
 	# disjoint regions
-	for_each_ref__exclude refs/heads refs/heads/bar refs/heads/quux >actual &&
+	for_each_ref__exclude refs/heads refs/heads/bar refs/heads/quux >actual 2>perf &&
 	for_each_ref refs/heads/baz refs/heads/foo >expect &&
 
-	test_cmp expect actual
+	test_cmp expect actual &&
+	assert_skips 2 perf
 '
 
 test_expect_success 'for_each_ref__exclude(refs/heads/bar/, refs/heads/baz/)' '
 	# adjacent, non-overlapping regions
-	for_each_ref__exclude refs/heads refs/heads/bar refs/heads/baz >actual &&
+	for_each_ref__exclude refs/heads refs/heads/bar refs/heads/baz >actual 2>perf &&
 	for_each_ref refs/heads/foo refs/heads/quux >expect &&
 
-	test_cmp expect actual
+	test_cmp expect actual &&
+	assert_skips 1 perf
 '
 
 test_expect_success 'for_each_ref__exclude(refs/heads/ba refs/heads/baz/)' '
 	# overlapping region
-	for_each_ref__exclude refs/heads refs/heads/ba refs/heads/baz >actual &&
+	for_each_ref__exclude refs/heads refs/heads/ba refs/heads/baz >actual 2>perf &&
 	for_each_ref refs/heads/foo refs/heads/quux >expect &&
 
-	test_cmp expect actual
+	test_cmp expect actual &&
+	assert_skips 1 perf
 '
 
 test_expect_success 'for_each_ref__exclude(refs/heads/does/not/exist)' '
 	# empty region
-	for_each_ref__exclude refs/heads refs/heads/does/not/exist >actual &&
+	for_each_ref__exclude refs/heads refs/heads/does/not/exist >actual 2>perf &&
 	for_each_ref >expect &&
 
-	test_cmp expect actual
+	test_cmp expect actual &&
+	assert_no_skips
 '
 
 test_expect_success 'for_each_ref__exclude(refs/heads/ba*)' '
 	# discards meta-characters
-	for_each_ref__exclude refs/heads "refs/heads/ba*" >actual &&
+	for_each_ref__exclude refs/heads "refs/heads/ba*" >actual 2>perf &&
 	for_each_ref >expect &&
 
-	test_cmp expect actual
+	test_cmp expect actual &&
+	assert_no_skips
 '
 
 test_done
diff --git a/trace2.h b/trace2.h
index 4ced30c0db..6a116f60a9 100644
--- a/trace2.h
+++ b/trace2.h
@@ -551,6 +551,8 @@ enum trace2_counter_id {
 	TRACE2_COUNTER_ID_TEST1 = 0, /* emits summary event only */
 	TRACE2_COUNTER_ID_TEST2,     /* emits summary and thread events */
 
+	TRACE2_COUNTER_ID_PACKED_REFS_SKIPS, /* counts number of skips */
+
 	/* Add additional counter definitions before here. */
 	TRACE2_NUMBER_OF_COUNTERS
 };
diff --git a/trace2/tr2_ctr.c b/trace2/tr2_ctr.c
index b342d3b1a3..f7efbc7646 100644
--- a/trace2/tr2_ctr.c
+++ b/trace2/tr2_ctr.c
@@ -27,6 +27,11 @@ static struct tr2_counter_metadata tr2_counter_metadata[TRACE2_NUMBER_OF_COUNTER
 		.name = "test2",
 		.want_per_thread_events = 1,
 	},
+	[TRACE2_COUNTER_ID_PACKED_REFS_SKIPS] = {
+		.category = "packed-refs",
+		.name = "skips_made",
+		.want_per_thread_events = 0,
+	},
 
 	/* Add additional metadata before here. */
 };
-- 
2.40.1.477.g956c797dfc

