Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D53C432C3
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE2A123442
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbhANCEh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 21:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729368AbhAMWbj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 17:31:39 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67534C0617AB
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:28:41 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id h13so1581247qvo.1
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F+IzFX+eJQuZjoTzcoY0Nicg1W0SyqzlGAWjYAPf4iQ=;
        b=QHKNbPBpfrN4IarkRf0SGVkcnOUVB8oBckJL6aH+YFGjHNGGwOtD/+Jj/IOFqLLHz3
         LuBeuAA7l1cz0JHKfnh+J1WteDjrRk6Rbd6BaI7nOqVRTCrrxjp8ak1rskDeg5QIQJIY
         w1D/PiQPF98eGx/T76H0dbH2Fp80rMJWfSwZBuE6joMmUGyFArRQf43IEM7XEJejT0Us
         9EkESTpF0Cf2fLQvs5p6VL2aALsMbCbdPo2266y71bEE9JmZ520mFzBZaRgJk3UQ8iQ6
         E3XnZJnhpzuvidqWSYT9k0OtFIMe6I4tKaMxgAeklLJ7TIFG+TT3KiZm7xMJrSONWpIl
         PD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F+IzFX+eJQuZjoTzcoY0Nicg1W0SyqzlGAWjYAPf4iQ=;
        b=ZVkx9sJs/oZQ8l0K+Ct3juYxmRD1ks1UjfXgwJAirO+4SokWS+Zb20HdSngg8YcYRT
         einLMVaDRE22VkV+lWOkRuJTYCQ02FYk9lF6FCH6LR1S0IaENRdrNMwFywp3S7a0fZNd
         qsZu8HyF/WhZjRXMPbP3m/3hdk9r2EsYqUJ8FciOOVU8vN9UOS4+MseMb8Ny0RJ6OIjU
         9NP7QQADX5CuYzQ0fLhGUQhntdFOhQXbkLObMLT1kGGGfFwzKSCdiSThQ+FLBnZUcicq
         yGWmiyIYH0SxaIB0nS7OGCEGyL42XOj8P17UFUk9YrBPQ1cnS2eYIpP2Vq4lUDkEUwJn
         eYRg==
X-Gm-Message-State: AOAM533ASN3nukmpunjb2LssWQY1cexEKCucyH5NRTA8W/eXD2KZUmeO
        8kyQ9LntE10WYei0N2iZ5GdTruCRbeo15Q==
X-Google-Smtp-Source: ABdhPJzGNSkT/PrbAgwnFWJRJiX6Bi3ay+16WRDPNNHqRl96F+5AOAH5HhNrXKJ0WIonJ4SSab6NnA==
X-Received: by 2002:a0c:b4a8:: with SMTP id c40mr4807079qve.60.1610576920452;
        Wed, 13 Jan 2021 14:28:40 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:b172:2e4c:efe4:db53])
        by smtp.gmail.com with ESMTPSA id c7sm1791307qtw.70.2021.01.13.14.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 14:28:39 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:28:38 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, jrnieder@gmail.com,
        peff@peff.net
Subject: [PATCH v2 8/8] pack-revindex: ensure that on-disk reverse indexes
 are given precedence
Message-ID: <48926ae1821f026c00c6237b771e0f9150b8b267.1610576805.git.me@ttaylorr.com>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1610576805.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610576805.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When an on-disk reverse index exists, there is no need to generate one
in memory. In fact, doing so can be slow, and require large amounts of
the heap.

Let's make sure that we treat the on-disk reverse index with precedence
(i.e., that when it exists, we don't bother trying to generate an
equivalent one in memory) by teaching Git how to conditionally die()
when generating a reverse index in memory.

Then, add a test to ensure that when (a) an on-disk reverse index
exists, and (b) when setting GIT_TEST_REV_INDEX_DIE_IN_MEMORY, that we
do not die, implying that we read from the on-disk one.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-revindex.c          | 4 ++++
 pack-revindex.h          | 1 +
 t/t5325-reverse-index.sh | 9 +++++++++
 3 files changed, 14 insertions(+)

diff --git a/pack-revindex.c b/pack-revindex.c
index 369812dd21..f264319f34 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -2,6 +2,7 @@
 #include "pack-revindex.h"
 #include "object-store.h"
 #include "packfile.h"
+#include "config.h"
 
 struct revindex_entry {
 	off_t offset;
@@ -166,6 +167,9 @@ static void create_pack_revindex(struct packed_git *p)
 
 static int load_pack_revindex_from_memory(struct packed_git *p)
 {
+	if (git_env_bool(GIT_TEST_REV_INDEX_DIE_IN_MEMORY, 0))
+		die("dying as requested by '%s'",
+		    GIT_TEST_REV_INDEX_DIE_IN_MEMORY);
 	if (open_pack_index(p))
 		return -1;
 	create_pack_revindex(p);
diff --git a/pack-revindex.h b/pack-revindex.h
index 7237b2b6f8..97f5893d3a 100644
--- a/pack-revindex.h
+++ b/pack-revindex.h
@@ -17,6 +17,7 @@
  */
 
 #define GIT_TEST_WRITE_REV_INDEX "GIT_TEST_WRITE_REV_INDEX"
+#define GIT_TEST_REV_INDEX_DIE_IN_MEMORY "GIT_TEST_REV_INDEX_DIE_IN_MEMORY"
 
 struct packed_git;
 
diff --git a/t/t5325-reverse-index.sh b/t/t5325-reverse-index.sh
index be452bb343..a344b18d7e 100755
--- a/t/t5325-reverse-index.sh
+++ b/t/t5325-reverse-index.sh
@@ -85,4 +85,13 @@ test_expect_success 'pack-objects respects pack.writeReverseIndex' '
 	test_path_is_file pack-1-*.rev
 '
 
+test_expect_success 'reverse index is not generated when available on disk' '
+	test_index_pack true &&
+	test_path_is_file $rev &&
+
+	git rev-parse HEAD >tip &&
+	GIT_TEST_REV_INDEX_DIE_IN_MEMORY=1 git cat-file \
+		--batch-check="%(objectsize:disk)" <tip
+'
+
 test_done
-- 
2.30.0.138.g6d7191ea01
