Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2133FC43460
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03335610A6
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbhDISMp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234665AbhDISMi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 14:12:38 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08892C061762
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 11:12:25 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id 7so6720069qka.7
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 11:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sAWq7ApHqrUs88UHszHQDp+raK9BhywjCqAJGMbjwdk=;
        b=s88Fv3l8pVvVdO5FuBbtEmJxlKx+Az0zT8ozzOnM5TMClUUjnGWrZkHDpUkoVr4qbn
         MIVQSfm6tF/SzFrQQjRlBzLKE6BICQfA6XEgqv9Uajdv+vfxDqVwjDRkNvNSfyELFwa6
         tofrtH8weSOdVkcYFCSWGF4UZHCQi21Z6f8l6h1DqvkzCttkzvwU9+6JETkuM/2w1YEv
         bKdSni69tMpNYJdQ7/gNr2ngRIpQi3iMMHmlKFKyYcubQVUifKKOagid92I9LUhOT0FD
         MpwtfseuAL7Cs3blkoShgScz0j6osp7tI+EjYixlZIPJcmjESU/2cUk5tyHgzK3xqCjq
         X6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sAWq7ApHqrUs88UHszHQDp+raK9BhywjCqAJGMbjwdk=;
        b=M4mKMMvvhmLEeeml+JYsyv9sdsrsoaZu79ZnaHHxQndexUcJYBetq/ZcOMH2er86jz
         I1iSj8B1Gr37JSiI2Y/0DrPe2xSShHuP2yuv8O9py8gZahUO21m6xmtOPbf0xQiRA1mb
         mJr/9Sv5VkDqbQ93Qk1K21+rnwPHw7aOI4JDcucAsPxWhAcU4QZqX1F+pjsrQ/QWAJod
         CuenL4thdpCXlBTZTYdU6G9SCdOn/QcQMTArho9FbSCyMHGtN9jaE13TCmlaD5WkmkQP
         8faMnDtFICa7nH1RvGdhWMEWw8r3PE73hCHebJRyKR8PPkX4j0zvZiUf1lCIXV/UYJ/7
         noQg==
X-Gm-Message-State: AOAM533Zl4UcPyx1O9efFYhR1pzq+o+5sNhyzq6Ceo59QU8EnxKjAWiv
        F3AidsZ3pGBmHW0VQTR2gS7Ryyps4+e5txjM
X-Google-Smtp-Source: ABdhPJwEx9uLqt8iX+Ezl+j/p7jIqHOBtjAf+z9Y34HWYDZB0Ky/A9D5WzZvl9nkWRUEV4yC0muBBw==
X-Received: by 2002:a37:9e4e:: with SMTP id h75mr14979295qke.180.1617991943994;
        Fri, 09 Apr 2021 11:12:23 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:64f1:fbc0:31eb:386a])
        by smtp.gmail.com with ESMTPSA id 130sm2378522qkg.22.2021.04.09.11.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:12:23 -0700 (PDT)
Date:   Fri, 9 Apr 2021 14:12:21 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH 21/22] p5310: extract full and partial bitmap tests
Message-ID: <2f3836bf2e2e7dafc6ad3c1cb20e00de49f638ef.1617991824.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1617991824.git.me@ttaylorr.com>
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

