Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CDCC433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B32364EC4
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236023AbhBXTNi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236083AbhBXTMV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:12:21 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58A6C0617A7
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:10:05 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id d20so2280282qkc.2
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iz6OksybEjkqiZCof/6e7vf6VJgo67PXi7MqX8uuQ34=;
        b=ubc/Hm2JpcoLoT7jbKJVj3TMyx2tSd+fe5JvUVAQ6n2C3APQx6mfg/pj18f3/+i8Ld
         RBFaQDBF4Tq+n4KfH7hmA4xzDBd/gLG3Qf73qUNr26vtI6VEPFrcvgwcTksDW6KDsFDe
         6ZLLe3ijZ6mbKbL3evjGYLPjNgDMpnJoj59hkTmjtRNtCPkrUG+JwpnLefTbnxXFyKIt
         FtEzCn/6s4ltTrjFzsb6+pHxcQ4y7qSCOA0+39iNkUKLLiJdtNT67vVvNRXv2wEhn0gn
         bYtQ7QlJHErwaL6hpUWlQMIHFesgNpn6JC7yQ11BQ3I6CSO9p/DhN75lhDZcfgmVz+Dr
         sRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iz6OksybEjkqiZCof/6e7vf6VJgo67PXi7MqX8uuQ34=;
        b=kiR4siIc/Elimc/R8ZCsa/1KAWSga0R0DKB/wKbO5mncsBTiDHu3WTaNLbHyZYv0BA
         n/p1JDL9wNxzeyFHz21KK1ZF13dCeG2gcdegUC0bnXhhnCXWth9LaJp+cRbM0WreyknR
         pRYZJtMNSx+VhNvq/gkhfqmFYdjasVraGtAdWAvKnw7c6QY3+Kp7rNfqzdxS9NdsD4zd
         +xXJ6y52+ZrqQwkU+dUrkUyfruvnk10T3bGagSEUYvAHj1asDYia6+VnZzV0hxhYGEE7
         JzX25huXqfEyDgUeaMfPvypZwKdpu51b/hbMwgw0RMaqmsD79ZApgr//6uw7Us/hmYqk
         pdZw==
X-Gm-Message-State: AOAM531cCEcnpkosMicb/sbnHAFWWbvIG1rwg+yABbU7ibB7t0aT8Smn
        X3wH2K6Jm4vNmlfbxKr6v+G1qtxeATdsOShJ
X-Google-Smtp-Source: ABdhPJwzpEUmgWHRMTETuUwnE9SHF4K2vVXa1Y7aQVhpQBEz1aDH5O2JLOHqslPdLzdBFO0uKRpnQg==
X-Received: by 2002:a37:bd84:: with SMTP id n126mr32481988qkf.54.1614193804723;
        Wed, 24 Feb 2021 11:10:04 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:268b:c46e:d22e:db6b])
        by smtp.gmail.com with ESMTPSA id w5sm1869514qta.45.2021.02.24.11.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:10:04 -0800 (PST)
Date:   Wed, 24 Feb 2021 14:10:02 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, avarab@gmail.com,
        gitster@pobox.com
Subject: [PATCH v2 10/15] midx: keep track of the checksum
Message-ID: <5ed47f7e3a8c42bae051243061debd7b97f630da.1614193703.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1614193703.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1614193703.git.me@ttaylorr.com>
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
index db043d3e65..3ea795f416 100644
--- a/midx.c
+++ b/midx.c
@@ -821,6 +821,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 			       unsigned flags)
 {
 	char *midx_name;
+	unsigned char midx_hash[GIT_MAX_RAWSZ];
 	uint32_t i;
 	struct hashfile *f = NULL;
 	struct lock_file lk;
@@ -1004,7 +1005,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	write_midx_header(f, get_num_chunks(cf), ctx.nr - dropped_packs);
 	write_chunkfile(cf, &ctx);
 
-	finalize_hashfile(f, NULL, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
+	finalize_hashfile(f, midx_hash, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
 	free_chunkfile(cf);
 	commit_lock_file(&lk);
 
-- 
2.30.0.667.g81c0cbc6fd

