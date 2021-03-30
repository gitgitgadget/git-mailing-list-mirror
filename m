Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18250C433E1
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 15:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E301F619D0
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 15:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbhC3PEw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 11:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbhC3PEX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 11:04:23 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9B3C061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 08:04:22 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id r193so16750219ior.9
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 08:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=chAfj2MhKdOAg1JAo4haib3UAHcOP3zHfIDIZEwHVZI=;
        b=Pdh04Ma3r4Ial0FNpz7f3Ns9ZxKCKiPBFQ0Lfs9Y3aPYM4dzcHy0l5TlvXu5mDbHAb
         TGPf3f0/F3ebI1c4sLbVh36l5nOfcXx9aDBCwl2wiCwgpF1EfryczhOsDryiePNp0Evl
         9PJrUq+sQESQMXX1Wkx/zYiNS4Im7nWfnNNICpTnyjVE1luXJu4Y7LneG5jqjj/NC4Xs
         swAUIe1UGYJ+09DDCcI1S68uycKCngOAD+sBsl1sTpHyaEyPZm99lqoXFmd8F5vc7gBL
         a9TMtqtvOsigeL2FDtH4Wc/YGDGolB5+o1sjFzlY+ilGTptSEItChr5mE+RjxNkW567L
         BZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=chAfj2MhKdOAg1JAo4haib3UAHcOP3zHfIDIZEwHVZI=;
        b=T/bEglm2udKM2qMdAsxl+K8jmZ+LsjAJqzQhEBF8DE8hrEIP/7LpL+As2Zl9CSxWTY
         /+CoRaK9l/jJ8HflqnnBeJVgU1lb89s64VqePGwOLQ6Yt7nnFu7yhHVbu75gZXcWCnFx
         YRHS7Z+U4n+76cekJJv6pbwHmk4IIUqS1FjHJgfWzRrqhI/LcAty0aEoPiw+eRQfXE59
         rUGdCotg5fqT7VtvDbhjIlBsMTyr7nhLoehcYygsfOrtUvvC0QgP//1d857/dFAiYNaB
         CIQrrrlZKrnMEZ210ahYSwmmgEMDirUyuc8bkE53UbJVvnvBP65cv31yA5GDw3Gd+IJh
         ZdJA==
X-Gm-Message-State: AOAM532g3i7TBv8OSPaa7HQxUG63RsS9WFyn9KA17/d034o9Y/kTpqtB
        qxp95FzGjkuloyb0uDEGCaLhGenRlC77Gg==
X-Google-Smtp-Source: ABdhPJwsij/o1acmcDRJ8KOVnu0ObAHIvDXpLxeszpqLXTIxu5SDMUrIrzntI+3I88oxpGnLgwgLcQ==
X-Received: by 2002:a5e:c00a:: with SMTP id u10mr24866690iol.165.1617116662029;
        Tue, 30 Mar 2021 08:04:22 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:7b00:4f79:8763:6261])
        by smtp.gmail.com with ESMTPSA id v17sm11169535ios.46.2021.03.30.08.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 08:04:21 -0700 (PDT)
Date:   Tue, 30 Mar 2021 11:04:20 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, dstolee@microsoft.com,
        jonathantanmy@google.com
Subject: [PATCH v4 11/16] midx: make some functions non-static
Message-ID: <2ada3973202feb737af6c8cbeafae0241afdff90.1617116623.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1617116623.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1617116623.git.me@ttaylorr.com>
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
index 526795ff0e..2173a9b45c 100644
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

