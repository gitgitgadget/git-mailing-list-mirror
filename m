Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76202EB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 14:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbjFTOWS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 10:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbjFTOWE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 10:22:04 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C175A10D5
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 07:21:56 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-57028539aadso54130077b3.2
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 07:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687270915; x=1689862915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=46Qr/BCb/UXyUnykbl7J91DtREjudIK3V0q0N/hKdII=;
        b=Ve7SYnMb1UJb1vVwEKpa1Ni9SVIRbY4CQIKxPA9u2M3VF1cgXdPGYzcO3OjcMAXgxc
         ME+5dOHyHt76Vsir2uaAeBC+/71nVEUyIic24ff8dj72GST8KzkoJ9XOVTPPW/z9kMA4
         pZYUXRjA0VGBUC1PkuxxzDKBmwl1fYWXz/7vV1+z/KjThgD3WW48/KqQLAtncmPdYzTH
         acZabjdRlfxl8cllfmj0PC0ZFznobplt3G0mMt/xOJRORby2KzoDdhwA0+6dqz2QXiIu
         nOegHVWxfm1QDTLySagQYtVE1BzJ5mWaAFAPBbXYhBl+vQ2JkitkNoCxxf7kgyjmIVJj
         Qmag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687270915; x=1689862915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46Qr/BCb/UXyUnykbl7J91DtREjudIK3V0q0N/hKdII=;
        b=S0+PGAgTjX5qbpQkbxq87LAVz5KKfPekOX5HwHZk7NxxMNw6lnxzpt1J4ikCMlS4RA
         8KPKiK1H+gLlYU4RAuWdQ6bhzCfypDqcc9rNEmPVD/Yluk54QNGOg8VQwElZQ/TgT6lO
         bgXulbHN6nK+bwLC3c626k+KSz3zU8d7JyvD4PsjAAl0jy1Gj7VnrHj6MrGTOjxvdRnz
         MayevkQIAeMafKGO1fZUi/le5yCMMzo96D4z85kNEIPnGh3AR9YfeMbevg4ilwKUc34N
         N7Z8VI6DZ+Cl4eg/i9kRt6gcU9TCpVcs82Oqr5YPRFc8ah5cX2YQ94Pcs6NPzhFao8sz
         na7Q==
X-Gm-Message-State: AC+VfDzbNY3cNMH6fiYIZ9vgwo08Oc5lKr+rYEyCvle91+665azEE3rg
        BcUQrixadHazH23vhKWDIiP1Bwz+EkdmVF+joVCYi1rE
X-Google-Smtp-Source: ACHHUZ5wN2hBJSS5xLKkPOGyODd53eOhKo+QpAM99ELTtbndA1BJb9cjQ38784ovu1knkx8QglDxTg==
X-Received: by 2002:a81:6b8a:0:b0:56f:eaef:9d40 with SMTP id g132-20020a816b8a000000b0056feaef9d40mr15522813ywc.46.1687270915670;
        Tue, 20 Jun 2023 07:21:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t21-20020a818315000000b00568e5a65698sm516155ywf.28.2023.06.20.07.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 07:21:55 -0700 (PDT)
Date:   Tue, 20 Jun 2023 10:21:52 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 10/16] refs/packed-backend.c: add trace2 counters for jump
 list
Message-ID: <49c8f5173aab19112afcd762337012a5c2f0f381.1687270849.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1687270849.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1687270849.git.me@ttaylorr.com>
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
index f624c9921a..80b877e00c 100644
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
 		iter->jump_cur++;
 		if (iter->pos < curr->end) {
 			iter->pos = curr->end;
+			trace2_counter_add(TRACE2_COUNTER_ID_PACKED_REFS_JUMPS, 1);
 			break;
 		}
 	}
diff --git a/t/t1419-exclude-refs.sh b/t/t1419-exclude-refs.sh
index bc534c8ea1..5d8c86b657 100755
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
2.41.0.44.gf2359540d2

