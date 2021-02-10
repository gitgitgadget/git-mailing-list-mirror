Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F73EC433E0
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 23:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 548C664DD6
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 23:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbhBJXDq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 18:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbhBJXDk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 18:03:40 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B381DC061788
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 15:02:59 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id h8so3515902qkk.6
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 15:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6kQ743JZ5c97JwYFYoMgV/9Jpqg1GQEms1AMox4wPFQ=;
        b=xODB6PGlaoJZMpBNvk/ao9VJlV95L8YmoaNJqTmF6LPceDLsIuOcZDDUZHkP5+bYUi
         SbMrnimxNMdsx7hiT2ysO953lKoWWrKc1Sx1VCVslblC4/mHx7usQRkelVTm7j0A+krz
         l9f2YJotikX8xErjveK2sXf8zWZoVPWECFko+x7UmGG3K13O/vzaa1upLS1JusBwX2hO
         4LElSK/tcJblU7qxtRD/nwlLbRZmu33sUjY437ICWBpi0wSIcutNXnyQzYadWc1zHP3x
         jyj7piw5fzhqtae+1+rXyIRLmuCDgKMpW0xXSj7Vr3BLjsoR2bnmLSWmMUudjR5emxeg
         0LNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6kQ743JZ5c97JwYFYoMgV/9Jpqg1GQEms1AMox4wPFQ=;
        b=FoP2VIgYCf81PReKSaFo9lAaJ1ld9ZPdPAITAC19ou9eN/hXsdnkXYrnH7cI4veDyH
         eXqJJTK9lmlmVi7GL0NLlzCwe5zHRhZleVvHmmIgAycDNMm9Hhfm5KOs//oo674UlvY3
         hgcYwZXhX741SufYKGGCYzGFL87N/JZHrZ0Nm64aioI8atfSq+iv/p3ELgFuscwjpC6r
         nfcvGoCDyVFNw4mZdwwhM/T/fenfgZSv8bDLFhL18NmROwGJM02s4ahV+OWB593Qz8EK
         1VQIGEybaNYUJV5Zaot/hhb1rp/8q1GnVC0UQRa0fjxyiM9TpVjzrQ9jFLCTrx2kX63/
         Z9nQ==
X-Gm-Message-State: AOAM530qqOktkrBXL8xTFX7DOpXfPJ9qery1aw9Y8WL+Jjgj6pmPZ49A
        lwEqdTVRLYpWei6SPzIOQDQj5UTGwAgnQ8GT
X-Google-Smtp-Source: ABdhPJxv6qJ4r47uJuFvtYWNCrbNDe9GhGRC/9KZ38/j44aHA/DwN5ngxlN1yiPfOBJKozSOQP/dHg==
X-Received: by 2002:a05:620a:227:: with SMTP id u7mr3945503qkm.226.1612998178755;
        Wed, 10 Feb 2021 15:02:58 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:2c3d:3179:bfad:c65])
        by smtp.gmail.com with ESMTPSA id j124sm2467329qkf.113.2021.02.10.15.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 15:02:58 -0800 (PST)
Date:   Wed, 10 Feb 2021 18:02:55 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: [PATCH 4/9] midx: keep track of the checksum
Message-ID: <b4b842fa1e8c711af30cc93b6f1100661791416c.1612998106.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1612998106.git.me@ttaylorr.com>
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
index 34fb9de3f3..6e47c726af 100644
--- a/midx.c
+++ b/midx.c
@@ -837,6 +837,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 {
 	unsigned char cur_chunk, num_chunks = 0;
 	char *midx_name;
+	unsigned char midx_hash[GIT_MAX_RAWSZ];
 	uint32_t i;
 	struct hashfile *f = NULL;
 	struct lock_file lk;
@@ -1098,7 +1099,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 		    written,
 		    chunk_offsets[num_chunks]);
 
-	finalize_hashfile(f, NULL, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
+	finalize_hashfile(f, midx_hash, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
 	commit_lock_file(&lk);
 
 cleanup:
-- 
2.30.0.667.g81c0cbc6fd

