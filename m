Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460B5C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 23:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23366206EB
	for <git@archiver.kernel.org>; Mon,  4 May 2020 23:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="w6MkwYOj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgEDXMi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 19:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbgEDXMh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 19:12:37 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC8AC061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 16:12:37 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t9so163451pjw.0
        for <git@vger.kernel.org>; Mon, 04 May 2020 16:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hKNtToHuliZ3nQ0FY+hFcX6SvM5rjP2ey+YWDHWEPGo=;
        b=w6MkwYOjpfeqH0f3sDJ7ErNJj0S3NNecYcH9kci9xXfnsUnHVFeNHF7cvSF3gYKkTL
         6WvK25J7y6x5C1RQ2icH18zCvFaWfJ34hTHRb5B+fdVveLWTKnyWG7rMt6FTq89uCGdd
         X6J8Rrm8RqQo3HQZ8UHMm0kjuCqh6TqblZ4XSb2HpZXz0RR8ni/cZ72tSwYsCed3Tr2F
         AuVn/nUMTuKUCVo8FGI9ArtdcszQXIsZoyzYf8yku3sHtuG9ih3GOiRBEietRDTXnh84
         5HCLNtVEYplPUB8+A7nWN37ct/qrxUqNGckgepsPYId/8EdfBNRlEQgv1J2MLked1NZ3
         SBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hKNtToHuliZ3nQ0FY+hFcX6SvM5rjP2ey+YWDHWEPGo=;
        b=ufa+ExCgu4eUsKYnfXwycWrcqfmav9KeoM3/jN4tudD6gGQ0QGUtByKvJXgkYODhek
         GZGYgUsUXzCUIw1WZYtEMAcrjZ/BZsOf3q83eaCTlYFd71duS60h3biakhXT0AZ/ga1E
         c/zfN1m20vosCeAAvbu+xN1xKE+J5HZ/oO6IKTqQrwQaoDQ786faTtEVU3vaocHWiNcA
         IB20EG5FhWbjhDfIfqfwOPoGNzsKHjSzjzOBgh0PFjzY7pRVL3QkIhnNMWTfk3m6ZANL
         GgLvMg8WfBzfOT1QrXnR3M2y57QhH6Mvjhl+EFRaduehhHH4o4g0hk65HZnIrCbkq1zO
         k7IA==
X-Gm-Message-State: AGi0Puam4k0tLy7J54W38OfWNv2IAQ4+3sJEjVpoyHGXrMJkAYbL3EL6
        av9GEP/qPWX0UJ2gXosOmxyoEC9oCxnD2w==
X-Google-Smtp-Source: APiQypJVHI/j23QQwPKbaXHtf14Rn6eJdg25I8MjH3WrGaYeIE7EPCzVCH4778lSwhhjM1xxpYEtQw==
X-Received: by 2002:a17:902:b187:: with SMTP id s7mr349048plr.0.1588633956789;
        Mon, 04 May 2020 16:12:36 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id b3sm100614pgh.75.2020.05.04.16.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 16:12:36 -0700 (PDT)
Date:   Mon, 4 May 2020 17:12:35 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, chriscool@tuxfamily.org
Subject: [PATCH 3/4] pack-bitmap.c: support 'tree:0' filtering
Message-ID: <87b21d72bb588f7366d928544aeaf4de68b027a7.1588633810.git.me@ttaylorr.com>
References: <cover.1588633810.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1588633810.git.me@ttaylorr.com>
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
index 80c53edca7..75ccf9f4e3 100755
--- a/t/perf/p5310-pack-bitmaps.sh
+++ b/t/perf/p5310-pack-bitmaps.sh
@@ -53,6 +53,11 @@ test_perf 'rev-list count with blob:limit=1k' '
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
2.26.0.113.ge9739cdccc

