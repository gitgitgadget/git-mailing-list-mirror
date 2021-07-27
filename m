Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B919C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5377060BD3
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbhG0VWa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 17:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbhG0VVw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 17:21:52 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9B2C06136B
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 14:20:27 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id a13so423378iol.5
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 14:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sAWq7ApHqrUs88UHszHQDp+raK9BhywjCqAJGMbjwdk=;
        b=Jtbgw6MJJNlcJGKxa9BeQwr5TEQMieCKc7c6bqagkamy4jYaoDRUU2TMpipNt1u0jn
         00DftxahR3R2OZAzppHGsf9X4NX3w/LG9lrywYze+Yv3Vsar2JaE4FDKOEPsWBduuBjB
         1uNDTz30WTs3JIIyu0p5yzlPuqn0xDnw7ivX0viU7e8UUJAXsIo39EvPiPpIb9qazFDV
         l/yPuafgAfiS2XgupZF4cH7c6YzxTy8I2nSEpMcYqTvR3Gd/ojA+dbsMRVs60r5z5943
         DHF3EXZvIaA61OBUK3h+MjQaWLxgjuRs098qhhuctKoAvg1Qvr9+ItqfqkwG+bjvDdRZ
         IfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sAWq7ApHqrUs88UHszHQDp+raK9BhywjCqAJGMbjwdk=;
        b=kwbT0RAikMN7CQczMdcOUUSl3Ox9D8BqLRNZa9/gTNfc8lSMfHBE8g7rTB5PgVP7UX
         fdA7g208vXhRtJFi2nAuCog+tjfeVvDuHneLb1hkC1gkfM0tdETW4isIQCTRK3TC98pE
         X4irCIcAoW9xzgcEzwUd/Qi3ImuyAxjKerE6Yw4UYwNc00jZ5HZSoJqpVEhMNtoVbu5Z
         WNh9qjfP7qysrLBBEM1l3TwPrmNuTYPz/QoT2rovmrcvIzUYS7adqFSzHLDTTc/PfgRd
         P+ZZFp1905NgWSaSbnZbWCAzAawMWpjSc8enopOe9NrPo6OSnQWn98pn18TJ4MF96+AS
         jSDw==
X-Gm-Message-State: AOAM53248isF1/vxVB95p9Lc/MCb4dQORxoxHzQKZfQcNcWJ/b/D0Fv0
        XsB2Vp9l2tMfigQa2rE7xZkuxmRTd6bguxuQ
X-Google-Smtp-Source: ABdhPJxch6hcbxjHKvJLE95gKt3EO+aj/ADR2XW4nWVUa5idSwHBI1P/uLmzzCs7pVjJAT8nbjxG1A==
X-Received: by 2002:a02:8206:: with SMTP id o6mr22906302jag.92.1627420826949;
        Tue, 27 Jul 2021 14:20:26 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:6813:d625:75e6:4f64])
        by smtp.gmail.com with ESMTPSA id k7sm2562511ilr.19.2021.07.27.14.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:20:26 -0700 (PDT)
Date:   Tue, 27 Jul 2021 17:20:26 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v3 24/25] p5310: extract full and partial bitmap tests
Message-ID: <0f1fd6e7d49d98ae7f7829b4debbef6382dfc3e1.1627420428.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1627420428.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1627420428.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A new p5326 introduced by the next patch will want these same tests,
interjecting its own setup in between. Move them out so that both perf
tests can reuse them.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/perf/lib-bitmap.sh         | 69 ++++++++++++++++++++++++++++++++++++
 t/perf/p5310-pack-bitmaps.sh | 65 ++-------------------------------
 2 files changed, 72 insertions(+), 62 deletions(-)
 create mode 100644 t/perf/lib-bitmap.sh

diff --git a/t/perf/lib-bitmap.sh b/t/perf/lib-bitmap.sh
new file mode 100644
index 0000000000..63d3bc7cec
--- /dev/null
+++ b/t/perf/lib-bitmap.sh
@@ -0,0 +1,69 @@
+# Helper functions for testing bitmap performance; see p5310.
+
+test_full_bitmap () {
+	test_perf 'simulated clone' '
+		git pack-objects --stdout --all </dev/null >/dev/null
+	'
+
+	test_perf 'simulated fetch' '
+		have=$(git rev-list HEAD~100 -1) &&
+		{
+			echo HEAD &&
+			echo ^$have
+		} | git pack-objects --revs --stdout >/dev/null
+	'
+
+	test_perf 'pack to file (bitmap)' '
+		git pack-objects --use-bitmap-index --all pack1b </dev/null >/dev/null
+	'
+
+	test_perf 'rev-list (commits)' '
+		git rev-list --all --use-bitmap-index >/dev/null
+	'
+
+	test_perf 'rev-list (objects)' '
+		git rev-list --all --use-bitmap-index --objects >/dev/null
+	'
+
+	test_perf 'rev-list with tag negated via --not --all (objects)' '
+		git rev-list perf-tag --not --all --use-bitmap-index --objects >/dev/null
+	'
+
+	test_perf 'rev-list with negative tag (objects)' '
+		git rev-list HEAD --not perf-tag --use-bitmap-index --objects >/dev/null
+	'
+
+	test_perf 'rev-list count with blob:none' '
+		git rev-list --use-bitmap-index --count --objects --all \
+			--filter=blob:none >/dev/null
+	'
+
+	test_perf 'rev-list count with blob:limit=1k' '
+		git rev-list --use-bitmap-index --count --objects --all \
+			--filter=blob:limit=1k >/dev/null
+	'
+
+	test_perf 'rev-list count with tree:0' '
+		git rev-list --use-bitmap-index --count --objects --all \
+			--filter=tree:0 >/dev/null
+	'
+
+	test_perf 'simulated partial clone' '
+		git pack-objects --stdout --all --filter=blob:none </dev/null >/dev/null
+	'
+}
+
+test_partial_bitmap () {
+	test_perf 'clone (partial bitmap)' '
+		git pack-objects --stdout --all </dev/null >/dev/null
+	'
+
+	test_perf 'pack to file (partial bitmap)' '
+		git pack-objects --use-bitmap-index --all pack2b </dev/null >/dev/null
+	'
+
+	test_perf 'rev-list with tree filter (partial bitmap)' '
+		git rev-list --use-bitmap-index --count --objects --all \
+			--filter=tree:0 >/dev/null
+	'
+}
diff --git a/t/perf/p5310-pack-bitmaps.sh b/t/perf/p5310-pack-bitmaps.sh
index 452be01056..7ad4f237bc 100755
--- a/t/perf/p5310-pack-bitmaps.sh
+++ b/t/perf/p5310-pack-bitmaps.sh
@@ -2,6 +2,7 @@
 
 test_description='Tests pack performance using bitmaps'
 . ./perf-lib.sh
+. "${TEST_DIRECTORY}/perf/lib-bitmap.sh"
 
 test_perf_large_repo
 
@@ -25,56 +26,7 @@ test_perf 'repack to disk' '
 	git repack -ad
 '
 
-test_perf 'simulated clone' '
-	git pack-objects --stdout --all </dev/null >/dev/null
-'
-
-test_perf 'simulated fetch' '
-	have=$(git rev-list HEAD~100 -1) &&
-	{
-		echo HEAD &&
-		echo ^$have
-	} | git pack-objects --revs --stdout >/dev/null
-'
-
-test_perf 'pack to file (bitmap)' '
-	git pack-objects --use-bitmap-index --all pack1b </dev/null >/dev/null
-'
-
-test_perf 'rev-list (commits)' '
-	git rev-list --all --use-bitmap-index >/dev/null
-'
-
-test_perf 'rev-list (objects)' '
-	git rev-list --all --use-bitmap-index --objects >/dev/null
-'
-
-test_perf 'rev-list with tag negated via --not --all (objects)' '
-	git rev-list perf-tag --not --all --use-bitmap-index --objects >/dev/null
-'
-
-test_perf 'rev-list with negative tag (objects)' '
-	git rev-list HEAD --not perf-tag --use-bitmap-index --objects >/dev/null
-'
-
-test_perf 'rev-list count with blob:none' '
-	git rev-list --use-bitmap-index --count --objects --all \
-		--filter=blob:none >/dev/null
-'
-
-test_perf 'rev-list count with blob:limit=1k' '
-	git rev-list --use-bitmap-index --count --objects --all \
-		--filter=blob:limit=1k >/dev/null
-'
-
-test_perf 'rev-list count with tree:0' '
-	git rev-list --use-bitmap-index --count --objects --all \
-		--filter=tree:0 >/dev/null
-'
-
-test_perf 'simulated partial clone' '
-	git pack-objects --stdout --all --filter=blob:none </dev/null >/dev/null
-'
+test_full_bitmap
 
 test_expect_success 'create partial bitmap state' '
 	# pick a commit to represent the repo tip in the past
@@ -97,17 +49,6 @@ test_expect_success 'create partial bitmap state' '
 	git update-ref HEAD $orig_tip
 '
 
-test_perf 'clone (partial bitmap)' '
-	git pack-objects --stdout --all </dev/null >/dev/null
-'
-
-test_perf 'pack to file (partial bitmap)' '
-	git pack-objects --use-bitmap-index --all pack2b </dev/null >/dev/null
-'
-
-test_perf 'rev-list with tree filter (partial bitmap)' '
-	git rev-list --use-bitmap-index --count --objects --all \
-		--filter=tree:0 >/dev/null
-'
+test_partial_bitmap
 
 test_done
-- 
2.31.1.163.ga65ce7f831

