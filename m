Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C109C43461
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 653F061181
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbhDISL0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbhDISLY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 14:11:24 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45331C061761
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 11:11:11 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id q3so6683405qkq.12
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 11:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NITf+oxH1I2YlyZzr2LDI7tPEwqBuAVwTNUkVA1ihwQ=;
        b=D2Mk8zB9Ji+LF7/1vlx/G5Big2bMO0Ec0+vf51V8XK0GFvLi1MYN1zeyLzjJf9/f+A
         Yi9IKR18pp213c9plQtCYpKzT124UqAkCxVqIaqzMx86NUv/kd1u1Qmx4qCH8reJvauI
         I/nLsSRFa3QMKoOesrSGiJJ9a72lvWXiLjrWQI733K9PQAMDThEuBaLG+PEHzzGnnGOs
         Py1/bN8BzGPXIq8T7XALCp7ESWst7g9KdF77PvoapttDSjDOFq/uzZZlxVylfHSwZ8we
         UOFOKmDYFqZfRxADxwaHkbxLYdnFAM/dv9u949SMSMRrrZX6awv04Sbr7yb5W77kybxb
         WFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NITf+oxH1I2YlyZzr2LDI7tPEwqBuAVwTNUkVA1ihwQ=;
        b=j1ghxi1Q2CIrYW/I2YBJ4Ia5Z/MtmCcWHGfAOJnvm3KSsUE7+AiypF03f/BMpdtISV
         myd3zatDo2s9rQTO8jf/cmw2KBI/lgCS7xXI+F661JEgI8BHhiCKcf3oQ8K2cdEa1zUg
         vrwa8Y4QFYJDJhbXERbrSn7DtUqeZ0oyDeSr604jMYePEbv11b6VjXX7bJJk3LonrMXS
         /ohmB+lZ52GKIz1h6ypaLEi/rnbJLY/5e16k0EbPsHRWmZM+g5Gbs2xdt3CQi1/zQdKm
         5nwiqFxwUGStBXnKuRRCd0gwuO+qgbLg2tWZ1rj+ErIBPYt2FICQOhPeq4jXeRo0h42F
         RK2w==
X-Gm-Message-State: AOAM531B0eoIrb6v5MONznICCP7fZhN0nPbeTOU/hNJ3y0DyswjoTLnh
        4Luq94LMu45I9ES1m2fyeNY+GHTmWFSBqoPW
X-Google-Smtp-Source: ABdhPJxbdL89q+N59b1yJbzp5CgR7YtXwSn3TpgcxTKt4LNDGrQYF1E3RchTLhEmDwzYU32xsJEXsQ==
X-Received: by 2002:a37:9c4b:: with SMTP id f72mr7423568qke.237.1617991870331;
        Fri, 09 Apr 2021 11:11:10 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:64f1:fbc0:31eb:386a])
        by smtp.gmail.com with ESMTPSA id z188sm2369343qkb.40.2021.04.09.11.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:11:10 -0700 (PDT)
Date:   Fri, 9 Apr 2021 14:11:08 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH 06/22] midx: make a number of functions non-static
Message-ID: <c76dfc198e2a458db241d1e53d91b07b9b2bc2ec.1617991824.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1617991824.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These functions will be called from outside of midx.c in a subsequent
patch.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 4 ++--
 midx.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/midx.c b/midx.c
index 9e86583172..5249802326 100644
--- a/midx.c
+++ b/midx.c
@@ -48,12 +48,12 @@ static uint8_t oid_version(void)
 	}
 }
 
-static const unsigned char *get_midx_checksum(struct multi_pack_index *m)
+const unsigned char *get_midx_checksum(struct multi_pack_index *m)
 {
 	return m->data + m->data_len - the_hash_algo->rawsz;
 }
 
-static char *get_midx_filename(const char *object_dir)
+char *get_midx_filename(const char *object_dir)
 {
 	return xstrfmt("%s/pack/multi-pack-index", object_dir);
 }
diff --git a/midx.h b/midx.h
index 8684cf0fef..1172df1a71 100644
--- a/midx.h
+++ b/midx.h
@@ -42,6 +42,8 @@ struct multi_pack_index {
 #define MIDX_PROGRESS     (1 << 0)
 #define MIDX_WRITE_REV_INDEX (1 << 1)
 
+const unsigned char *get_midx_checksum(struct multi_pack_index *m);
+char *get_midx_filename(const char *object_dir);
 char *get_midx_rev_filename(struct multi_pack_index *m);
 
 struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local);
-- 
2.31.1.163.ga65ce7f831

