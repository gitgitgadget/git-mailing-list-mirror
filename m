Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A75C433E6
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 23:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B8D5207B7
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 23:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732966AbhAYXlz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 18:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732935AbhAYXjK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 18:39:10 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8AFC0617A9
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 15:37:50 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id p5so7064918qvs.7
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 15:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dhDltsonVFeOsitxJwrFjgWBiRRPv9dUuKaI5hD0ZAE=;
        b=mgyWAgmWPtWaVDoXL7cP9WpKr5EkhlXxYbS/3WCUbtYLABg1jan+jN0MVWVNQ0Mo2p
         KjFLdjl39Q2m2fapBUpk3uLBopXTXTvHJC6zi4e+yVdsE0NgsWGVH4Wqzr3HqaBAmc+R
         yBxJGUCIgnxyzU4se8YUxP+F1Sbd4vW+9VDDMomPjJ5P5UBuIvHxlis16BxDV3OoRU8z
         EwJqScuWZwEXEugvl4V+RWTUQw/P9SWUZGF/jcvu6+TVKf9YMdJburwcFaW3GjQFwuax
         QLIB+pZEyRokybt5VP4mb0CsQ5tL9rqWL9vaJVpJ4TejTPcS9oGgbQUXu4PK6sT4aZT+
         Lm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dhDltsonVFeOsitxJwrFjgWBiRRPv9dUuKaI5hD0ZAE=;
        b=gX18iQA9vMWpezJJ6XA4UB14XMq1yy+NYgXkoxKzuSo89nQslPqqUdJfIdARkuVqQt
         /sZ35EuElh8K0apcWWnbr+EbbAJ93j0RSQSKeVxqSOuGjgwZ0XIt0eSqAJFWW7cFDhFp
         ee0LDYE9Bo8vinh9LfVA1wPneBsGFA2J6PxlmC7enbfb30TdJ0EHLyvqGSS/hxTWucMA
         QAw8hii14fVEPZ7xdec+r0VJm5EB3UV4O+unuAqCrULcdP4A9zPSv/6bHhQIqo//V2sR
         pwdTlfQm3s1k7zFiVZY3aot+7ZamtRAGRCGh+fZ3Jziw/JxxlTLqzwhzbazPdEJRvidg
         ttkg==
X-Gm-Message-State: AOAM530pnjhKfWOzPkqWHlQOKrMY7NcJDTRxxQXCNom3c0fCNgqwVDxP
        QTHPFeYOr8XjLekctBDlMuMkD4cLxguyug==
X-Google-Smtp-Source: ABdhPJxEDPPsKx2A8ZU8cz07Wd8ncSyjsSdMgZnEgoTpC+JQpuRyQRuJ+m/Y9v9JeSmjhKP+hr/PJg==
X-Received: by 2002:a05:6214:571:: with SMTP id cj17mr3182586qvb.38.1611617869502;
        Mon, 25 Jan 2021 15:37:49 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:5e9f:a2e5:e7ac:394d])
        by smtp.gmail.com with ESMTPSA id i18sm13051851qkg.66.2021.01.25.15.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 15:37:48 -0800 (PST)
Date:   Mon, 25 Jan 2021 18:37:46 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, jrnieder@gmail.com,
        peff@peff.net
Subject: [PATCH v3 09/10] pack-revindex: ensure that on-disk reverse indexes
 are given precedence
Message-ID: <a66d2f9f7c20eeb813656e66b3ad9d42f2eecf34.1611617820.git.me@ttaylorr.com>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1611617819.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1611617819.git.me@ttaylorr.com>
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
index a174fa5388..83fe4de773 100644
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
 
 static int create_pack_revindex_in_memory(struct packed_git *p)
 {
+	if (git_env_bool(GIT_TEST_REV_INDEX_DIE_IN_MEMORY, 0))
+		die("dying as requested by '%s'",
+		    GIT_TEST_REV_INDEX_DIE_IN_MEMORY);
 	if (open_pack_index(p))
 		return -1;
 	create_pack_revindex(p);
diff --git a/pack-revindex.h b/pack-revindex.h
index d1a0595e89..ba7c82c125 100644
--- a/pack-revindex.h
+++ b/pack-revindex.h
@@ -21,6 +21,7 @@
 #define RIDX_VERSION 1
 
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

