Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB86DC433E6
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A3DF64FF3
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhCKRFx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 12:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhCKRFZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 12:05:25 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083B5C061762
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 09:05:25 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id s2so1653468qtx.10
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 09:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5A2fGCQ6jdCYNzw2r+1F9r2Ve0DTa4xEVfbRET9qGqw=;
        b=XbAtLJJl/0FQYvl5Iy3R2C4WnQbVV+inMkO0BzCNuSItk4A0HA097JOWSogGjNchgF
         rFQZWXY295nsH7rz+GZIcccuJPyZfvMgIz8TuhZd3KLqVRdugtIWEZd7JkgZalJ4UuDg
         JdLiFNkg77JxYvJ5tquCdHKr+XmlvQEb2hePDIfZn9c0b5aTPujE8xUTITrgliBFFEJ8
         IHKRztClKP9Dpj6JiUNWrXGthdpKs6QkNDk1ZKk6QzfCNJ82tuXplIwlRSCj8X4Z047H
         9gbtPomX+y2IhjREJgPa/fDcMRljtc5ZR8KithylIHBlqczbW4MJ7fVcjrzeA3rIGpS8
         fwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5A2fGCQ6jdCYNzw2r+1F9r2Ve0DTa4xEVfbRET9qGqw=;
        b=exFzs5Q1rNT+zUvQsVRYlM/C/ibAJydB/pO9J11nIcWiHCn/KWVG0n59BdxhcOHrbJ
         7Wq/0BoQQYbfQFNCj9JgB/ngnc83oQ14v4/Aw+MIGwCWJ+o5CRTtIZwA6bl7NrHuJd0y
         V74cxu30FEi9oqIDG7VCX6Xx5CEqW5pWkdXWexD14l6BdftLCabsqSfaPHvkz1jYzQAR
         UmoDCEfZatzzF+xoMo74yw2/qw/BwW/lyyzB2MZ2Lm6mTCsAJGMySTfB+T+7VbA9DekN
         6GoCLzgaJ6tuZawWdoxZEz/Ecy+Ys+QaTl7GtOXKjCAktYycVfqW5QFqxLXfks4c9Izz
         zNRg==
X-Gm-Message-State: AOAM531eicuETaruiTLlxGSUwk3klQhGtPDJD4TvpZ5pRndB1Rs2IhyA
        dXZp65HFT8vWY2nSuCJ6FEJoJPOf/o2fq+3B
X-Google-Smtp-Source: ABdhPJx06nMixOPyKUdLg9qiUtOkbYf5BxFRvAj9W8RzjJpQPlzQkR9h4gLZNwh8hHPBpBs5n3HeHw==
X-Received: by 2002:ac8:7747:: with SMTP id g7mr4730213qtu.144.1615482323972;
        Thu, 11 Mar 2021 09:05:23 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:f947:1686:6ada:db5b])
        by smtp.gmail.com with ESMTPSA id k7sm2021331qtm.10.2021.03.11.09.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 09:05:23 -0800 (PST)
Date:   Thu, 11 Mar 2021 12:05:21 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com, peff@peff.net
Subject: [PATCH v3 11/16] midx: make some functions non-static
Message-ID: <efa54479b15f51b7d87aca2071f19ce04faf7d78.1615482270.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1615482270.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1615482270.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a subsequent commit, pack-revindex.c will become responsible for
sorting a list of objects in the "MIDX pack order" (which will be
defined in the following patch). To do so, it will need to be know the
pack identifier and offset within that pack for each object in the MIDX.

The MIDX code already has functions for doing just that
(nth_midxed_offset() and nth_midxed_pack_int_id()), but they are
statically declared.

Since there is no reason that they couldn't be exposed publicly, and
because they are already doing exactly what the caller in
pack-revindex.c will want, expose them publicly so that they can be
reused there.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 4 ++--
 midx.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/midx.c b/midx.c
index 31e6d3d2df..0a5da49ed6 100644
--- a/midx.c
+++ b/midx.c
@@ -239,7 +239,7 @@ struct object_id *nth_midxed_object_oid(struct object_id *oid,
 	return oid;
 }
 
-static off_t nth_midxed_offset(struct multi_pack_index *m, uint32_t pos)
+off_t nth_midxed_offset(struct multi_pack_index *m, uint32_t pos)
 {
 	const unsigned char *offset_data;
 	uint32_t offset32;
@@ -258,7 +258,7 @@ static off_t nth_midxed_offset(struct multi_pack_index *m, uint32_t pos)
 	return offset32;
 }
 
-static uint32_t nth_midxed_pack_int_id(struct multi_pack_index *m, uint32_t pos)
+uint32_t nth_midxed_pack_int_id(struct multi_pack_index *m, uint32_t pos)
 {
 	return get_be32(m->chunk_object_offsets +
 			(off_t)pos * MIDX_CHUNK_OFFSET_WIDTH);
diff --git a/midx.h b/midx.h
index e7fea61109..93bd68189e 100644
--- a/midx.h
+++ b/midx.h
@@ -40,6 +40,8 @@ struct multi_pack_index {
 struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local);
 int prepare_midx_pack(struct repository *r, struct multi_pack_index *m, uint32_t pack_int_id);
 int bsearch_midx(const struct object_id *oid, struct multi_pack_index *m, uint32_t *result);
+off_t nth_midxed_offset(struct multi_pack_index *m, uint32_t pos);
+uint32_t nth_midxed_pack_int_id(struct multi_pack_index *m, uint32_t pos);
 struct object_id *nth_midxed_object_oid(struct object_id *oid,
 					struct multi_pack_index *m,
 					uint32_t n);
-- 
2.30.0.667.g81c0cbc6fd

