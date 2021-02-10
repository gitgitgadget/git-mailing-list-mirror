Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A65C433E0
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 23:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 092C564EBB
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 23:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbhBJXD4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 18:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbhBJXDt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 18:03:49 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48820C06174A
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 15:03:09 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id j13so1731554qvu.10
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 15:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fDWzLTb3RLMRw0XvYnJ4/fOhMe4rEETEFQoOAZPN1lw=;
        b=XahASoggBSjS7blYdBUr0FgQrya0r9NHPMqBkNiAABHgd0Hf6hLkAtGgN20jHnIP5A
         K+jzfmBTko3i/Q40mWspM13gZvSTQF6XAtfcMWcTPmNAtnRrsZaGnAC59hF8yWbfids0
         5JSoaJTEh0bkDs3rZh1o8JXZx62LR8iV0yf3EryOD6f2TxDcJEis7LfxVARdHGR5QLfC
         lDH91+m4Ez3hdh9T8Ltgf99lKGaf8yY+vThHSyWeuYsGd0U267vm7gVaFx2NCwnw4Nx4
         L3ppczk0ZhevY1Swsk9XhXAtf5HPto5SiO76lPLL59dQKNc/pgKhApEF85vcgPoyzbqN
         j40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fDWzLTb3RLMRw0XvYnJ4/fOhMe4rEETEFQoOAZPN1lw=;
        b=RKCup4sdhtf4nSMEZFaxXcGoH4ca4PRJYaSe9KKqBQTTo3QR+m38WsAM5rqy4RdMBr
         G+/MikxyKxoAXrL8CO75JbJT8lmqpbYDvN/IRXiSuGzzaWg0GJjBxZpNJ0+sBPbzHaMD
         GDHOeaj0hbqLH5EYb4+V3KahL1aK9p8bqmFHqe6fJw7x7Sww+KRKbvRCZMHCbbYuGLps
         lYrzbWh81+xDtLvt+RsO/xWC5hJpNerPImzg/TzE9peWOzZc/krrk9BSvy6jbG92gabI
         6vMjkBZVqPo0l17TOWSjHWv519+kgdvi5w8P5bZQR4+noovvjqQsS9disg7jHoi1JjrW
         mtBw==
X-Gm-Message-State: AOAM533ZRhyaVlf8/gTJ6j1zs6YeA6hYeiOtAZdJYxL4E4CQxrLnYvm3
        EiDh5ogxQ2KaTg061CMD4sQkOrgLZ7W+nN1z
X-Google-Smtp-Source: ABdhPJzmyyKH5TbJ1LTK+CixfKFVQ1ktC9YSgyrf8hdRJJGeMyRAbH/QuvP8SP4V2LZYlwRUgiVwUQ==
X-Received: by 2002:a0c:f0d2:: with SMTP id d18mr898746qvl.58.1612998188245;
        Wed, 10 Feb 2021 15:03:08 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:2c3d:3179:bfad:c65])
        by smtp.gmail.com with ESMTPSA id x79sm2542327qka.75.2021.02.10.15.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 15:03:07 -0800 (PST)
Date:   Wed, 10 Feb 2021 18:03:05 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: [PATCH 5/9] midx: make some functions non-static
Message-ID: <953beabaa493eb0869b0b1f1f24c05067e333f8d.1612998106.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1612998106.git.me@ttaylorr.com>
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
index 6e47c726af..bf258c4fde 100644
--- a/midx.c
+++ b/midx.c
@@ -260,7 +260,7 @@ struct object_id *nth_midxed_object_oid(struct object_id *oid,
 	return oid;
 }
 
-static off_t nth_midxed_offset(struct multi_pack_index *m, uint32_t pos)
+off_t nth_midxed_offset(struct multi_pack_index *m, uint32_t pos)
 {
 	const unsigned char *offset_data;
 	uint32_t offset32;
@@ -279,7 +279,7 @@ static off_t nth_midxed_offset(struct multi_pack_index *m, uint32_t pos)
 	return offset32;
 }
 
-static uint32_t nth_midxed_pack_int_id(struct multi_pack_index *m, uint32_t pos)
+uint32_t nth_midxed_pack_int_id(struct multi_pack_index *m, uint32_t pos)
 {
 	return get_be32(m->chunk_object_offsets + pos * MIDX_CHUNK_OFFSET_WIDTH);
 }
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

