Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BB9C433E9
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A7F564E24
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236122AbhBXTNn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236084AbhBXTMW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:12:22 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A481C0617A9
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:10:09 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id x124so3305086qkc.1
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4ZXleYMf9s8ZNcYrdTh9UAftkdmYXWKQAjFFPrJovzM=;
        b=hJk2Mn45Osb711TJsjzDfB5Y2BnMrxuxc/ekcXuuC0cAfx3THNqRxMtKjQT9Vnwent
         bUacu8vydtBtfZ664r1PjRuEKEyfZ/mFQ9upjDDRf6Cib5fKv54EzDsYzYOD+rtT8BSC
         +jlp+337YHoVf3F0duzlUVfFk26NFHo8S24ed2sJQacWuy9oex7M2H6UBSA7/b+sS6tF
         ZgV7PH7N1p6Nei5e/2GP2b8IlDFi5Y8s7Pe1CYvobHWYxiH2rsBn00aKQSRDkFnhjmE2
         IE67iSNiok6xDvc3Q82/lRii+d3Bxk8a/6TxFzL4+ulOz6xK1hUYwHfgOs4hHSZyzUGc
         VJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4ZXleYMf9s8ZNcYrdTh9UAftkdmYXWKQAjFFPrJovzM=;
        b=BZUC191OG4y2lFd9/9MQPzkZ8a9YaWFiioSYfCXzPB7hdSrOquplO3LpiC48EfWSqu
         vboRjEtqGhfUuJy41vGLDUf5+bacp0EoR7DMKWf/aGONuimYpDP6pN45juy8xUYfPuzd
         JyJPHhARRvtm9YZQPhqVDKnbzBJ3VQPCgK8wO4AA2p0oJp9VkEMIAEfEXZtNi3htT+EX
         EAM6XBpdDoIEBNXifeAH8n1zuQ3ls+6bAYDZLIGT+mEtsKsyyhyuE/A0UlB6NHpe8S0U
         3gvrg3ghL2eSpfYwN6k9ezbu9kBr6ZDKICkd4t3EeIC+MoqrI0EehZ8EzmqSmyXmXTxj
         Ttdw==
X-Gm-Message-State: AOAM532HMMCOR7X+5bAZyui50OpkVq+o8oOmKmQwzghH8N0cGL0YQVHn
        YHUAHNaxNxbVhn3QM1vGVg9sJY+1Gz8+ojQP
X-Google-Smtp-Source: ABdhPJxI5fL9T2yEs7+ZD5U/0Fc1AIWamagjuPQK3InHgXYX+OPZF7phMY8xg5nU87wZ5HXQ7Qikkg==
X-Received: by 2002:a05:620a:b95:: with SMTP id k21mr31971645qkh.125.1614193808544;
        Wed, 24 Feb 2021 11:10:08 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:268b:c46e:d22e:db6b])
        by smtp.gmail.com with ESMTPSA id b190sm2218059qkg.103.2021.02.24.11.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:10:08 -0800 (PST)
Date:   Wed, 24 Feb 2021 14:10:06 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, avarab@gmail.com,
        gitster@pobox.com
Subject: [PATCH v2 11/15] midx: make some functions non-static
Message-ID: <0292508e12582462b799d3ba6b190eb29915661d.1614193703.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1614193703.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1614193703.git.me@ttaylorr.com>
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
index 3ea795f416..27a8b76dfe 100644
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

