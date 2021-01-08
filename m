Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EF3C433E0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8648523A69
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbhAHSUs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 13:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbhAHSUs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 13:20:48 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3001EC0612FD
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 10:20:33 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id h19so7131523qtq.13
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 10:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5Mf8gKDjj3XIhPZjv3SqrlBeRDwCXz/5ajOwuex1ig4=;
        b=mCPvWDDrg8cxkH9+ZrDeD1Pbj2L8VadTjl0+swqltUVCbgBW5aohXVFtnExIIgK8Yy
         ILolIrJZDwY8lJAgnfbcqHpW8uyN4dBKyah6umU0K9n4FbD280wDoihCiQLNTPTQc02D
         wg+RoDjPfhSA3hvg3sqlSOBhnhlEYNx0M+GhulmxMh15XZ9u/P9pgkN4LabhySltgm1+
         7a0EI/PuL+dbv1wQjol4AZwK22sMK/vkHf1mOR8w4SSN7Qbs6bRTGFNl+nnrQDKq0Iu0
         LPXJgBLqSAowHZXCp+enY14PyyB2WNYzP2zdbmH16dOWcv6i4hNPubZ5G1DoG5D8akdK
         VXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5Mf8gKDjj3XIhPZjv3SqrlBeRDwCXz/5ajOwuex1ig4=;
        b=dE/2Fnc8E/hD/nvoI/6+ZsEwPzxqzL3bGeItycK48tVa6/NlDd/3zzfPHfn+8Zb4/9
         t4DnTA/1+Ac4XVoXfAGQ3nE/tsWx8gsGDQ3fEVWc4GAkgvGB9Z70GIsltuPjL6yEh7s9
         f4aemXTOaQ6TkJdbNXwiEdwpuI+2ItLopVGjAQV+Y9Dg5lA3lDItPQMYZJp6v+a85rkb
         QPVCq1ck9mtfY1Tdi8E+g81rhXYfPNwFElCR13vYeYyqPoXQ4OiD7kGOoICK30oNgd1o
         QbujCYdYzvA8dWTKKvoDYCTWPmOgWlQ+Scn2iyVArGlN9CbKEjKO8EqTzac9NrLUsN9V
         XV8w==
X-Gm-Message-State: AOAM532X3j1BCyCh2a13Ku47V0fQIR4Zwp2msneU8ak/nDDLGi6GjsIn
        RKXxKIC3ra58Wn1Xr9ay7yxelhoCUfdu/w==
X-Google-Smtp-Source: ABdhPJx+UWi3p4VW0nfk5pvSwrA2d8ZKgFkW9cTF6+ZXRwdI3qd3yDSDzUiuMQI8ZHrsm2cmAo/oBA==
X-Received: by 2002:aed:3b24:: with SMTP id p33mr4643778qte.299.1610130032115;
        Fri, 08 Jan 2021 10:20:32 -0800 (PST)
Received: from localhost ([8.9.92.205])
        by smtp.gmail.com with ESMTPSA id q3sm5144409qkb.73.2021.01.08.10.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 10:20:31 -0800 (PST)
Date:   Fri, 8 Jan 2021 13:20:29 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com
Subject: [PATCH 8/8] pack-revindex: ensure that on-disk reverse indexes are
 given precedence
Message-ID: <6e580d43d1d1e45bfe58606b98c5034a342d8241.1610129989.git.me@ttaylorr.com>
References: <cover.1610129989.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610129989.git.me@ttaylorr.com>
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
 t/t5325-reverse-index.sh | 8 ++++++++
 3 files changed, 13 insertions(+)

diff --git a/pack-revindex.c b/pack-revindex.c
index 1baaf2c42a..683d22e898 100644
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
index d2d466e298..e271da871a 100644
--- a/pack-revindex.h
+++ b/pack-revindex.h
@@ -2,6 +2,7 @@
 #define PACK_REVINDEX_H
 
 #define GIT_TEST_WRITE_REV_INDEX "GIT_TEST_WRITE_REV_INDEX"
+#define GIT_TEST_REV_INDEX_DIE_IN_MEMORY "GIT_TEST_REV_INDEX_DIE_IN_MEMORY"
 
 struct packed_git;
 
diff --git a/t/t5325-reverse-index.sh b/t/t5325-reverse-index.sh
index 5a59cc71e4..9d4eecccc9 100755
--- a/t/t5325-reverse-index.sh
+++ b/t/t5325-reverse-index.sh
@@ -83,4 +83,12 @@ test_expect_success 'pack-objects respects pack.writeReverseIndex' '
 	test_path_is_file pack-1-*.rev
 '
 
+test_expect_success 'reverse index is not generated when available on disk' '
+	git index-pack --rev-index $packdir/pack-$pack.pack &&
+
+	git rev-parse HEAD >tip &&
+	GIT_TEST_REV_INDEX_DIE_IN_MEMORY=1 git cat-file \
+		--batch-check="%(objectsize:disk)" <tip
+'
+
 test_done
-- 
2.30.0.138.g6d7191ea01
