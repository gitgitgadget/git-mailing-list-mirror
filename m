Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB29C433E0
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 15:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5A8D619CF
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 15:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbhC3PEx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 11:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbhC3PEV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 11:04:21 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8C8C061762
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 08:04:19 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id c17so14425446ilj.7
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 08:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Zpiw/qHgGxWIVb8+wqZfv7qGGEiUS/itYgzFzNmgnnE=;
        b=1cQCsMmArQxL25ulxNFeupj4WrabIPgKI1kSff8+xZBd9LDB7i68cIrE4Fg/KS0jgq
         K57v2/sLTHfshpwDtFNGne1FbZMtgJLPUV4FicyAuOoMLy/8QN5T6/359jAi/ZpZWKDH
         7sf+9gFPon+ODf/sH+irSS8kAPyur4ZsiKK47DLQTxjQy7Vh4x1DNObBCYNUXYSLqSeK
         2Dik9NddVMpmDcKlxDDWYgM58ZnQomuv708PVkT9lu+7uJWKquXBnYMiiWNsB3VSLpKp
         kNgSe+warCfvIVNGJmLhJfA1ac5DLFMf/Wv/Tt2T6XACphNLLsc51u+u7GA5k9fWAVXX
         bPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zpiw/qHgGxWIVb8+wqZfv7qGGEiUS/itYgzFzNmgnnE=;
        b=XRccOPN4geD3SlrGj0D4DtzNyOrRtQcqLPjt+w5u7PwVMT21J9j3XZg9CReDU+YBBQ
         XVbQ35zjo5oT3tOVUWQOkCXIVhEtxhGl2yRu1+L6U3aHTmE/B3OQhBtOUR3wVlWsuHO7
         QypuzKe5kF8baa+IKnCnMw6k28aYu98nSlQBIw/D2cA8TONraHW1t0+XPlHYXIyxAuOV
         IDAz6w6fMcmy8fCQKrU+TXwewtMuPwLlSD+hvJLIEd3IyfkJiTTnxmdTXO2VEOyGIEyD
         i5Si6LlGQyKfQxXBPwKi5LdTZc0sQkQ0RtRagjjnTA7OrYi8QygHzt0qSQMLTHNLvAuo
         Xdnw==
X-Gm-Message-State: AOAM532PBxxGkWZ9t8TrgHX94KAcMYaorhdtXfZlEhqYShrwcUDTdt/9
        LvtNiirO+mHZqUqei1wXTczUkkwtkFR1xg==
X-Google-Smtp-Source: ABdhPJz815zN1pg9ZiIMFAIy2kq50tLXqEAzvI/ccOonJogPgSc9YUyqM+iS/hNneKFpUSWu+PvVlA==
X-Received: by 2002:a92:d382:: with SMTP id o2mr20504895ilo.94.1617116659053;
        Tue, 30 Mar 2021 08:04:19 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:7b00:4f79:8763:6261])
        by smtp.gmail.com with ESMTPSA id s3sm9853164ilj.77.2021.03.30.08.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 08:04:18 -0700 (PDT)
Date:   Tue, 30 Mar 2021 11:04:17 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, dstolee@microsoft.com,
        jonathantanmy@google.com
Subject: [PATCH v4 10/16] midx: keep track of the checksum
Message-ID: <3fc9b83dc61837409b3d68f4676fc7a982f10593.1617116623.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1617116623.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1617116623.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

write_midx_internal() uses a hashfile to write the multi-pack index, but
discards its checksum. This makes sense, since nothing that takes place
after writing the MIDX cares about its checksum.

That is about to change in a subsequent patch, when the optional
reverse index corresponding to the MIDX will want to include the MIDX's
checksum.

Store the checksum of the MIDX in preparation for that.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index 3edde2b68d..526795ff0e 100644
--- a/midx.c
+++ b/midx.c
@@ -811,6 +811,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 			       unsigned flags)
 {
 	char *midx_name;
+	unsigned char midx_hash[GIT_MAX_RAWSZ];
 	uint32_t i;
 	struct hashfile *f = NULL;
 	struct lock_file lk;
@@ -987,7 +988,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	write_midx_header(f, get_num_chunks(cf), ctx.nr - dropped_packs);
 	write_chunkfile(cf, &ctx);
 
-	finalize_hashfile(f, NULL, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
+	finalize_hashfile(f, midx_hash, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
 	free_chunkfile(cf);
 	commit_lock_file(&lk);
 
-- 
2.30.0.667.g81c0cbc6fd

