Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DED2C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D4ED60F9E
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241356AbhHaUyH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 16:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241332AbhHaUxw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 16:53:52 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96ECCC0612A6
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:52:47 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id x5so730696ill.3
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IPXB1qBMlOGpG/jyerww7SfinUgH7Yh1oF/wkRRBjWg=;
        b=VyWo3Ej+Ij9j5RlhOJIvVHlSO9pwB87VJC7E7yMyLOlxiecClmE/GdB/T0IIeMO+HE
         G9Lpi3uO6jGBz8bTL+qSVxz9IK/oIxioje2K+ySYi833kxp33PvRvOVE4Mjnhev51tKM
         lOoP//Ca5rP9PtLxWJBrEBgPC7u/3XudOraNVmeKoM9Ojab8/wD/WLMqBO7WVO9YZSos
         0rUnKwekbfFc4mUxlmEOSBblMmyxkMnMvki8SlTlXofBGjHqUu76HBLfLRMEF+zsSLQh
         KquwSIAa186Ii9xDFXkKs5R/LoFs+SeBoCj0juglWOQS4xeyg+OoSkBgjdqnq7rANyyA
         uFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IPXB1qBMlOGpG/jyerww7SfinUgH7Yh1oF/wkRRBjWg=;
        b=MJ6N3XmP+HHOOWQu4x7sjHcoS6h5BTpsB4VjUxA1zwQhceT/4WNTa5zbY7vPBPyC7x
         UIKNdnZzdopUdDWSxpe4fo/NQaiZNPpPLo4aPtv56D7sLtWdVB+sTlFRqBCKUEthPS3r
         x24V6FkW09q/HQ0Lzj0bFxOA93t+0Mj7pebilVgyMCwxDNVsGlyKOGJwPeM4Y/wN4OQd
         6HRVkzuTDdjbfMK6cLzXNVNVW6U+bYYfMK64dVgiVrkGHuhP3M2uFEHcKKmeSvQjZJ78
         w+fd2p6HXeF9GyQ91XKeXbDXOuQ3pDxRT05q4BKO+aKjaY8Cdx8TjrRLiN4oWOHrmd8A
         sKIg==
X-Gm-Message-State: AOAM530EptyeZxV8nkTg9j28qri1aK5DLp0bJJD7GWb8asy1Hmv4RIlN
        jL/+NfcLei1Q7IPD45FACylzQX+pSQgrgqzW
X-Google-Smtp-Source: ABdhPJxM21cbCte9hger87Mv7FJhtBQ6pB62Yivya3T4RsZPXTJ8Cdfpewk66Ck1rd6fV+UySwDj7A==
X-Received: by 2002:a05:6e02:1d08:: with SMTP id i8mr22192869ila.185.1630443166865;
        Tue, 31 Aug 2021 13:52:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o18sm10404566ilh.52.2021.08.31.13.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 13:52:46 -0700 (PDT)
Date:   Tue, 31 Aug 2021 16:52:46 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v5 26/27] p5310: extract full and partial bitmap tests
Message-ID: <bf0981b606ebf2620752e1aeb8dcf7b6ce9222cb.1630443072.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1630443072.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1630443072.git.me@ttaylorr.com>
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
2.33.0.96.g73915697e6

