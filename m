Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D48FC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01F5961212
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbhHXQSH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 12:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbhHXQRh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 12:17:37 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1C3C06179A
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:16:52 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id b200so27052859iof.13
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sAWq7ApHqrUs88UHszHQDp+raK9BhywjCqAJGMbjwdk=;
        b=XhZy7F+Ina8SPksXzHtA108G/5S9Icqcbu61mGbQEdxgGQAptvKCqJKhwUR5RjqyKa
         zPBTvkFGv/74bKknSgG2j5NNe69rS+tj6O3oXQB0BFWZLFbozmz1l9vytGdiEN3KB5IE
         B2tlfBFQ97iSZU1blM5BkV5vSf+amqIwD9KicoYbQDsafzHl10eEARfH1+y1YB6XtW+C
         9C3J3XCKiv/OMCTBjWAOBd4aOMNoxcSDsB/IIOjdJyEhvzzBr2ZFRRH2X9OlrenorxXv
         VJ92ISqRibf6vZHzlnS1iKIZXrO/chDv0DyEaRZ3SZZlIomJF1/gUah8eBkOd8hmUQq1
         6rnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sAWq7ApHqrUs88UHszHQDp+raK9BhywjCqAJGMbjwdk=;
        b=f0U4NEcIY+kGrFqohhVa3FMi0eQcI5LqqWjd2Y9ZtjH7ffL/3L4XV5DKgUO8t8REkr
         zhjBFIxhvnWxnuP9HKCCVj5cK1n+Eo0AohB2UPlnKOaMbI6m0KOwHv8wgf4Z2Q1gtfbz
         JA62fS5bKLsgnUtQr/PewKMnw2WVUFrJ5oZokKLNuOe3OJ2CZbDm7K3OuUNa2NcQ2NfC
         +LjAf+vEIfhAdL+1CqMMC8hqXujLecalETRUAfgY5CnQ25Rz9DZhsHdp1Wn3JFnbfD25
         zYr+MbVGRJMSKEVfoBHPQ3qCfS+Ie94Btxg3ZaSuXLfQtWTYrmmdK0auhQzxw3H9jtxB
         p3IQ==
X-Gm-Message-State: AOAM533Ym+bh+Y+xjYted0k0rcrwkHeyKvTBYpgjSA9Mgy7b6GLga6yO
        3Ly4g9Bhm224/E9VJ6cI914TMb19b30m7Kgp
X-Google-Smtp-Source: ABdhPJyeUe6e2Hq2cyze7fzUQxdfeVPpeTt79QXoLr/lzVkGjcpQ2zaF1C9lrJrz+TuKtfseR0lPyw==
X-Received: by 2002:a02:7348:: with SMTP id a8mr34837476jae.116.1629821812246;
        Tue, 24 Aug 2021 09:16:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d14sm8693459iod.18.2021.08.24.09.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 09:16:52 -0700 (PDT)
Date:   Tue, 24 Aug 2021 12:16:51 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v4 24/25] p5310: extract full and partial bitmap tests
Message-ID: <6b03016c9937218071f1819dbbca988615b3b6a0.1629821743.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1629821743.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1629821743.git.me@ttaylorr.com>
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

