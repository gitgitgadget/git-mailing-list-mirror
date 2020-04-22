Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE38BC55186
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 23:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C1352076E
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 23:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Hjhe0WXL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgDVXNh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 19:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725839AbgDVXNg (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Apr 2020 19:13:36 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B6FC03C1AA
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 16:13:35 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id e6so1646510pjt.4
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 16:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y1TkIm0sEdPUmBG+UMdtDWlyV9EMXbiFLUMQTeN9rpo=;
        b=Hjhe0WXLiZ/0wxGZPygamELF83gZohAwTJrSJMvn3aFQ9Atuskxd+kXD8m7z5DLLR3
         3OPu1Z5tXuXuAhEGgz7m9DUc3cEja9AOvC7K9JsVNPkS0Yh55EEYEU1Pi2oH8Ecg0vf9
         OQZvBdoqYtUmLqGwWh8+mx71ecvRPdZv5trv5/g03IfxsjvL+FTSkgkMzqMoysK9FGFA
         UpR3aV7ZsSKPreJeRcQBPkM5YxEeFKMT0T9aGpcE5/0sE2oVvN7qAC7b00qFiqtvLQrq
         /9vpLsYRmiCVlfhh41Oip/32bcwMOPQsijrlREfszVyM+eZSOfQJerbkXGOrPHbTkqKn
         AcJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y1TkIm0sEdPUmBG+UMdtDWlyV9EMXbiFLUMQTeN9rpo=;
        b=gcjpq6hvrxyMACvezK7wr/53WLN63mZYZMVKjxORgKUsdPhKRF0lyAC5yAy8t0rThW
         A87XcFG2d/q8r0GrPvi9gfCLNGO0Upjo9EYitO41DBi6FawhPx4nOaG4ltJdPmGo8AWM
         WX1fq9UzU3VRmbl20I7n3tYS1hNoID1s4xGzLNB+Z4nUMhLGJv2yoU8CjRQPXpLyqIKl
         YN5cdycXgA37PZUuK2Ltlo2Be9nP+Vm84Kn5ZJ75uwkKQgPO5OPaRQSIoWra64vBsE20
         VWpmlC8pAOsl/hP4WoJd+QOZHAtuR7KZEoHY5Xt0XMcdO8ucirR8jOq9oLj6ffh+yZ3l
         uXtw==
X-Gm-Message-State: AGi0PuYE4EQ1QAV9DI2o42+FK7zUxKK8Zkde7Z7xRk3jJgr07v/lbzs9
        CWbqcKuz3xsFXzr9bQsB0QWmsTpOBldSKQ==
X-Google-Smtp-Source: APiQypItxI0vvzIux74i2t35YOxtGxFIOkHc4CCJtLYIO3JKhm/l81ARt1dyP9FWelPpXhG6EpQCKg==
X-Received: by 2002:a17:90a:cb0b:: with SMTP id z11mr1163094pjt.62.1587597214212;
        Wed, 22 Apr 2020 16:13:34 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id g22sm312205pju.21.2020.04.22.16.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 16:13:33 -0700 (PDT)
Date:   Wed, 22 Apr 2020 17:13:32 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, chriscool@tuxfamily.org
Subject: [PATCH 3/4] pack-bitmap.c: support 'tree:0' filtering
Message-ID: <d42c35593c810fb3c87f67fdc5f042fc10bf2974.1587597151.git.me@ttaylorr.com>
References: <cover.1587597151.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1587597151.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the previous patch, we made it easy to define other filters that
exclude all objects of a certain type. Use that in order to implement
bitmap-level filtering for the '--filter=tree:<n>' filter when 'n' is
equal to 0.

The general case is not helped by bitmaps, since for values of 'n > 0',
the object filtering machinery requires a full-blown tree traversal in
order to determine the depth of a given tree. Caching this is
non-obvious, too, since the same tree object can have a different depth
depending on the context (e.g., a tree was moved up in the directory
hierarchy between two commits).

But, the 'n = 0' case can be helped, and this patch does so. Running
p5310.11 in this tree and on master with the kernel, we can see that
this case is helped substantially:

  Test                                  master              this tree
  --------------------------------------------------------------------------------
  5310.11: rev-list count with tree:0   10.68(10.39+0.27)   0.06(0.04+0.01) -99.4%

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c                      | 25 ++++++++++++++++++++++++-
 t/perf/p5310-pack-bitmaps.sh       |  5 +++++
 t/t6113-rev-list-bitmap-filters.sh | 21 +++++++++++++++++++++
 3 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 3693c9e62f..195ee8cad0 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -749,7 +749,7 @@ static void filter_bitmap_exclude_type(struct bitmap_index *bitmap_git,
 	eword_t mask;
 	uint32_t i;
 
-	if (type != OBJ_BLOB)
+	if (type != OBJ_BLOB && type != OBJ_TREE)
 		BUG("filter_bitmap_exclude_type: unsupported type '%d'", type);
 
 	/*
@@ -867,6 +867,20 @@ static void filter_bitmap_blob_limit(struct bitmap_index *bitmap_git,
 	bitmap_free(tips);
 }
 
+static void filter_bitmap_tree_depth(struct bitmap_index *bitmap_git,
+				     struct object_list *tip_objects,
+				     struct bitmap *to_filter,
+				     unsigned long limit)
+{
+	if (limit)
+		BUG("filter_bitmap_tree_depth given non-zero limit");
+
+	filter_bitmap_exclude_type(bitmap_git, tip_objects, to_filter,
+				   OBJ_TREE);
+	filter_bitmap_exclude_type(bitmap_git, tip_objects, to_filter,
+				   OBJ_BLOB);
+}
+
 static int filter_bitmap(struct bitmap_index *bitmap_git,
 			 struct object_list *tip_objects,
 			 struct bitmap *to_filter,
@@ -890,6 +904,15 @@ static int filter_bitmap(struct bitmap_index *bitmap_git,
 		return 0;
 	}
 
+	if (filter->choice == LOFC_TREE_DEPTH &&
+	    filter->tree_exclude_depth == 0) {
+		if (bitmap_git)
+			filter_bitmap_tree_depth(bitmap_git, tip_objects,
+						 to_filter,
+						 filter->tree_exclude_depth);
+		return 0;
+	}
+
 	/* filter choice not handled */
 	return -1;
 }
diff --git a/t/perf/p5310-pack-bitmaps.sh b/t/perf/p5310-pack-bitmaps.sh
index 7743f4f4c9..b629a211f9 100755
--- a/t/perf/p5310-pack-bitmaps.sh
+++ b/t/perf/p5310-pack-bitmaps.sh
@@ -57,6 +57,11 @@ test_perf 'rev-list count with blob:limit=1k' '
 		--filter=blob:limit=1k >/dev/null
 '
 
+test_perf 'rev-list count with tree:0' '
+	git rev-list --use-bitmap-index --count --objects --all \
+		--filter=tree:0 >/dev/null
+'
+
 test_perf 'simulated partial clone' '
 	git pack-objects --stdout --all --filter=blob:none </dev/null >/dev/null
 '
diff --git a/t/t6113-rev-list-bitmap-filters.sh b/t/t6113-rev-list-bitmap-filters.sh
index 145603f124..2b551e6fd0 100755
--- a/t/t6113-rev-list-bitmap-filters.sh
+++ b/t/t6113-rev-list-bitmap-filters.sh
@@ -53,4 +53,25 @@ test_expect_success 'blob:limit filter with specified blob' '
 	test_bitmap_traversal expect actual
 '
 
+test_expect_success 'tree:0 filter' '
+	git rev-list --objects --filter=tree:0 HEAD >expect &&
+	git rev-list --use-bitmap-index \
+		     --objects --filter=tree:0 HEAD >actual &&
+	test_bitmap_traversal expect actual
+'
+
+test_expect_success 'tree:0 filter with specified blob, tree' '
+	git rev-list --objects --filter=tree:0 HEAD HEAD:two.t >expect &&
+	git rev-list --use-bitmap-index \
+		     --objects --filter=tree:0 HEAD HEAD:two.t >actual &&
+	test_bitmap_traversal expect actual
+'
+
+test_expect_success 'tree:1 filter' '
+	git rev-list --objects --filter=tree:1 HEAD >expect &&
+	git rev-list --use-bitmap-index \
+		     --objects --filter=tree:1 HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.26.2.112.g65467a058e

