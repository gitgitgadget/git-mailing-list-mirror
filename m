Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C8CC7EE24
	for <git@archiver.kernel.org>; Mon, 15 May 2023 19:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245147AbjEOTYY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 15:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245073AbjEOTXq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 15:23:46 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D598916083
        for <git@vger.kernel.org>; Mon, 15 May 2023 12:23:38 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-55a6efe95c9so187775437b3.1
        for <git@vger.kernel.org>; Mon, 15 May 2023 12:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1684178618; x=1686770618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XBI7CbX1D1uTZmQxEGtIXC6FqAeaYOFo23OZECFFXrk=;
        b=tzrVuDh8SsTPBB7M4RuGZAYkdYKSz9rvr1IUMeTUkvzD7LHuZTMCPzMqsLtr6kanyi
         3emS2XNbrk9QXsFVoz8X/TI+w/HfwlBSOkXpSDs1X0GHWRDJ/oH9zJU0oaPWNBdP9PAi
         +eAKqrvvAHS9bheGbaADtcC7SI9HYcj5lfPACSrKYgtpZufokGhxT4fWVTQqpy8xcnZF
         CsqKGh6AvwfO9qPhkK5SbvJ7vRIHk8Zw5qL7xMeef4CNJZ2/vzV/7BIKrKOXLfabqdW7
         rx5vdHIyywn+2kAXmnHA5xADf4YbTUvBFSGYc+Je/Ydqgmti/IZuTIM02p7MTmWJxdhF
         coNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684178618; x=1686770618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBI7CbX1D1uTZmQxEGtIXC6FqAeaYOFo23OZECFFXrk=;
        b=g6rm/fZ4tJ8EB5SyyIFa0fTV2olVhq2LCQCg7ctw8auKeIISYbXSlghIcTZ9dHau1m
         m3sdEOoQ4XV72FnzsgG56TL+j/+Efx3KTFLow4pg70ZncNkoSKTjKWjXNGQLLR0nNjTO
         BULOK3vUOcyQFd6b9kzkkYWGrlBeisPrW54SyH9IMSijF8AfPB+qddk4jkVkWLCVUHzx
         2zB0J2mR6DRYfflhkk7uSo+Ia4utjqr+ednvvyDWT5GewqW4PrrtR0Zlc1m80qwYyH/N
         MJks49IZOYXQ1kMBcIUXF04irSjm6xNHJxkFGiEotPjrXI1p0XVkQO2XcP4TMca8l4P3
         FpHQ==
X-Gm-Message-State: AC+VfDzObnkSJlgCWjjigcHcniuv5gTDvHntqZkqsa8Kf4v5BhFUyQnR
        otgTAG3mDChVmvJGqzB8NVXbuG7+jD6nBh0TCNqA6g==
X-Google-Smtp-Source: ACHHUZ6DzDH7Ixs2ewjc4RL3FL7XLk0ziFXysXtPGfrpElAdSnPQ3TcL7AVm8pr6EwEyFRAfee+5mg==
X-Received: by 2002:a81:84ce:0:b0:55a:3b80:c00d with SMTP id u197-20020a8184ce000000b0055a3b80c00dmr30356624ywf.25.1684178617820;
        Mon, 15 May 2023 12:23:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u7-20020a814707000000b0055dfbb44d56sm4455ywa.144.2023.05.15.12.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 12:23:37 -0700 (PDT)
Date:   Mon, 15 May 2023 15:23:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 10/16] refs/packed-backend.c: add trace2 counters for jump
 list
Message-ID: <5059f5dd421c94164ce5aee19b8f920417aee27d.1684178576.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1684178576.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1684178576.git.me@ttaylorr.com>
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
index 67327e579c..7ba9fa2bb8 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -12,6 +12,7 @@
 #include "../chdir-notify.h"
 #include "../wrapper.h"
 #include "../write-or-die.h"
+#include "../trace2.h"
 
 enum mmap_strategy {
 	/*
@@ -845,6 +846,7 @@ static int next_record(struct packed_ref_iterator *iter)
 		iter->jump_pos++;
 		if (iter->pos < curr->end) {
 			iter->pos = curr->end;
+			trace2_counter_add(TRACE2_COUNTER_ID_PACKED_REFS_JUMPS, 1);
 			break;
 		}
 	}
diff --git a/t/t1419-exclude-refs.sh b/t/t1419-exclude-refs.sh
index bc534c8ea1..350a7d2587 100755
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
+	grep -q "name:jumps_made value:$nr" $trace
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
+	assert_no_jumps
 '
 
 test_expect_success 'meta-characters are discarded' '
-	for_each_ref__exclude refs/heads "refs/heads/ba*" >actual &&
+	for_each_ref__exclude refs/heads "refs/heads/ba*" >actual 2>perf &&
 	for_each_ref >expect &&
 
-	test_cmp expect actual
+	test_cmp expect actual &&
+	assert_no_jumps
 '
 
 test_done
diff --git a/trace2.h b/trace2.h
index 4ced30c0db..9452e291f5 100644
--- a/trace2.h
+++ b/trace2.h
@@ -551,6 +551,8 @@ enum trace2_counter_id {
 	TRACE2_COUNTER_ID_TEST1 = 0, /* emits summary event only */
 	TRACE2_COUNTER_ID_TEST2,     /* emits summary and thread events */
 
+	TRACE2_COUNTER_ID_PACKED_REFS_JUMPS, /* counts number of jumps */
+
 	/* Add additional counter definitions before here. */
 	TRACE2_NUMBER_OF_COUNTERS
 };
diff --git a/trace2/tr2_ctr.c b/trace2/tr2_ctr.c
index b342d3b1a3..50570d0165 100644
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
2.40.1.572.g5c4ab523ef

