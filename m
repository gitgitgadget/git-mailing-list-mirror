Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3735C4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE49D6124B
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhFUW2K (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 18:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbhFUW2H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 18:28:07 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6109C061768
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:25:52 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id q18so16721717ile.10
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=urkpKRCVUcnkeA5xm5AkC500A1RReChHW2zksdFNMEU=;
        b=tLtiapBP4Ey4ScnpcHyWu5rod+ArZR8voHCLYNsaVukPYDVzBcs/LbXZeIdBefrjKU
         uArbiSilApwqwUOt4ctZjWiBQv+9yKJ7JxlogjgSkmExBCsPRfGCz1dj/o0nz+3EuJxJ
         YF5rTiXJUDCUJoa6Gk9PiOD4k+H0xHECV6jeosLxylWS7kBZGJTI2htWWID5JbP+bz+p
         PW1ChEyQkI7ARVZfLiSEtlNMhUIZwT1DB3skL0+oUNdLhDOV3FkSIjnFowR5/GN9kbQB
         Q0mUpnemly3CyVnrTgvmHdL8fBK+hgVq8NI/6/OkHY7LWeyVCfGqHYn7MyxQo5xegZNt
         cepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=urkpKRCVUcnkeA5xm5AkC500A1RReChHW2zksdFNMEU=;
        b=UWORKOvFX22OhLtKCDo2Oyn8rsVZo6psd44rij2o+Ed6HjUw1v8X9Ipv3BhRzXmIkw
         5Trqm6rL5iw5IKsYA785A7n8Mwt+ZiJJHIDf3XPqPCMMRBN9xZtkSqjqI5lEYnSMfxg6
         ORge1LyJoBedqaIusgi9oahdrOtgsbafCimQxjLX4p7I/9EW9zj3YzY+1RxrYqMHt0Bf
         mDHzBdPa6S9xgKsYE8sPZKRhQ2/JH+FE8BF7WKg9mCJrxDPMBxdbc+fUsSk3BusaIjbW
         clEcJaPxwsyoLCs4A4v0BBBIQVqu02k4ooaBcX38LVhe8tFlMfetpKVgkRmL9YxO5JLf
         JpDg==
X-Gm-Message-State: AOAM5339VvqSNtFRKumv3wBoxQT+ic2UiFqG3j2N/5Z1mb/Jqqxw4zDE
        bwotRFb4ZRjm3O/PBM9N8KYebzgayRGlHK3o
X-Google-Smtp-Source: ABdhPJwKTjAuKnlLgWucTczKibgdUwO6r+fleqwScxpHp5FB32BDBp6jXIu1PqHBf0NTkXOAHuFNew==
X-Received: by 2002:a05:6e02:10c3:: with SMTP id s3mr342730ilj.37.1624314351989;
        Mon, 21 Jun 2021 15:25:51 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:f6bb:34fc:22a7:6a3])
        by smtp.gmail.com with ESMTPSA id r4sm1058708ilq.27.2021.06.21.15.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 15:25:51 -0700 (PDT)
Date:   Mon, 21 Jun 2021 18:25:50 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v2 20/24] t5319: don't write MIDX bitmaps in t5319
Message-ID: <4cbfaa0e978fd68bd5acd6ce5f96b34e9cd43656.1624314293.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1624314293.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test is specifically about generating a midx still respecting a
pack-based bitmap file. Generating a MIDX bitmap would confuse the test.
Let's override the 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP' variable to
make sure we don't do so.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5319-multi-pack-index.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 5641d158df..69f1c815aa 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -474,7 +474,8 @@ test_expect_success 'repack preserves multi-pack-index when creating packs' '
 compare_results_with_midx "after repack"
 
 test_expect_success 'multi-pack-index and pack-bitmap' '
-	git -c repack.writeBitmaps=true repack -ad &&
+	GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0 \
+		git -c repack.writeBitmaps=true repack -ad &&
 	git multi-pack-index write &&
 	git rev-list --test-bitmap HEAD
 '
-- 
2.31.1.163.ga65ce7f831

