Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32C8C7EE23
	for <git@archiver.kernel.org>; Wed,  7 Jun 2023 10:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239696AbjFGKmC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jun 2023 06:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239699AbjFGKlr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2023 06:41:47 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9C71BFD
        for <git@vger.kernel.org>; Wed,  7 Jun 2023 03:41:46 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-568900c331aso82222747b3.3
        for <git@vger.kernel.org>; Wed, 07 Jun 2023 03:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1686134505; x=1688726505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=45LklVVipxjXTGAhiAAdWYFD4sw7+OHceu2D4E2NAvE=;
        b=4icinca/O9no73GLMMZ3ic1LE3fP1isz+aGa0Uw1yBdNhGtuSBoBlh2fU2aHjdSDcb
         AJ+23/qoBwTRM8sns7OW9e7R32ErGJITdBEVoVUWsHDoMTBuNVHLHsgJG5+EVE6aXp8V
         Sl4mk7TzEsrqPs+M/EQ+QzKyN2DV6LgdXGEwQXc0MQuB8zmwN0fJH1qjvDH9VErXCYtq
         ldwAHF4U05K6z4ybPgScFNID3U1j0jVRd69nayKE2OZjjI8X8Jo0qWSzrjUkV0ylCOsa
         3bxGMtwfzkZfgRp+tqR3aZBDw/t/gOTMfPVR0EPlGuefhYDwO+jcmiFq2ce6QLI+CzPM
         kyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686134505; x=1688726505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45LklVVipxjXTGAhiAAdWYFD4sw7+OHceu2D4E2NAvE=;
        b=aczCIXuUhvTkOIi7kka8lgUxfA9FDlS5F6giPYZjtFNHBQ3DQLg3a+93aJsmq7Rb0s
         HqsUFjHdQULfSXQkJuiFZub9W1itvMXBs3MAPsim1aUa3TyRMh0MClZfWuIn3SQ8w1Bx
         Q6SEDLWcT7/bU3QaOihHnTUrur9ih8PeN+FXWD3ByUPOPAUQb0kRBUHyxdN01ejw1ni2
         lUcUq4pV+qQjpvuCRb9albW8JkNFB4uw5otj5o4h5eONwhFzY3DnQ3pX/ipayy4vgXJr
         2ZExc4Tz0lIwvUw9A9WoWDO5SkmCvTvAKeQ8XA92E+0zTXuFZ4MZ7m5UbyxTDsYlttGf
         P7Cg==
X-Gm-Message-State: AC+VfDw4smPcMfBOUzi/dlOVpONC7KkEpLy0H/IWif0WNvQj2HkKqFnT
        DYP6E1yfMWirE/W7CNSIDTfyEvCzvO/BtWFSnHZUR7Ag
X-Google-Smtp-Source: ACHHUZ6zFWTMSdOAM3E1pGrVLH9Yt/1F7lnIsmTdaq7w0Td2Sy9hpbGbP2+N0xZ8dq4sPsEkA97DUQ==
X-Received: by 2002:a0d:df09:0:b0:565:cf40:238e with SMTP id i9-20020a0ddf09000000b00565cf40238emr5483534ywe.15.1686134505351;
        Wed, 07 Jun 2023 03:41:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i2-20020a81d502000000b0054c0f3fd3ddsm4668906ywj.30.2023.06.07.03.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 03:41:45 -0700 (PDT)
Date:   Wed, 7 Jun 2023 06:41:42 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 10/16] refs/packed-backend.c: add trace2 counters for jump
 list
Message-ID: <3c045076a95fab9d050a312114c9aca712eb7141.1686134440.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1686134440.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1686134440.git.me@ttaylorr.com>
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
2.41.0.16.g26cd413590

