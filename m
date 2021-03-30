Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2E1C433C1
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 15:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C02A619C8
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 15:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbhC3PEv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 11:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbhC3PER (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 11:04:17 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11CCC061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 08:04:16 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id h7so7289449ilj.8
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 08:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GbZSZnTDLJ9YbpfXlEhG7/BQovTea6AP9dU5FLAlSRI=;
        b=g1Vl7wQ7tcGFoazyLbxa5jUyG5ikELxqYDpDAD00gRDNxDK2jiUWSFNCbZOw4t6uLA
         exGFglUBJDJix086ucE0qxjNXpcqdxYPDk6TxkwciKg8BjU2wwuoMbySCofi6Y2DO7fE
         5FybQ3mZpb9IBnt7KhYm9LKOZrUSyXvVoFFMvPEkF2Mw1fcr8mk+Ixbp7e3xcdOjFz3Y
         at3dWvws26HZzIj9F8LTjiy4lUzjJVGsOsbtuJn0q4ft0Lm14YDF1/cqwuMitGaLgz20
         kqFYAmuEDv+3k0Bff7aWMnc87i46j2QI42XIQWWBSv3MG2xcYF2eUJzStk7swT5j2kiu
         L1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GbZSZnTDLJ9YbpfXlEhG7/BQovTea6AP9dU5FLAlSRI=;
        b=eQ0R645px/WIIc2C+orlsG3SZ6a7+Vq+CXR5wFql7/Q4YAVspfI4qYZSuKX2MSActk
         Dv60dOwNBEbg5YvnLngR2qn54HFpmt7oQTmhiGt+Fgd68/lNf0Z4gASbQXeGBRkKP4w6
         RLF3pkOVEeRUmCjk33uYHIvwf2K8oRw1uNEHD4H6FNppZJTIb8MuL81Z00elJJcTtGGH
         GlQzrjX+NEwSNxlwBxdm/eFcAtPNB/Rpdxft8t8aJh/SFVAggASGxu4H2CBznqjLg8VU
         lmihw9EkFe8AeQekLWzCybpw/ngREFR7kpTfLbx4y0y2wOg/YNpYPlHjlJ1qazwK3ca6
         NbzA==
X-Gm-Message-State: AOAM530Z+9SRU3LdHzr8ExYBXRW24tF3csus/4zLHN0OCZi9f7i4NsOu
        yPHLUyCdxYeJas9U8/6sIRdfIylC6CmzjQ==
X-Google-Smtp-Source: ABdhPJx642M4FyqjBDiaQ0WyWjTod6NlTGCHyFyzutrL1sx8ORPlFbfko3y7Y37YY0TSCQh2je55EQ==
X-Received: by 2002:a92:6510:: with SMTP id z16mr24196722ilb.71.1617116655986;
        Tue, 30 Mar 2021 08:04:15 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:7b00:4f79:8763:6261])
        by smtp.gmail.com with ESMTPSA id z12sm11688392ilb.18.2021.03.30.08.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 08:04:15 -0700 (PDT)
Date:   Tue, 30 Mar 2021 11:04:14 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, dstolee@microsoft.com,
        jonathantanmy@google.com
Subject: [PATCH v4 09/16] midx: don't free midx_name early
Message-ID: <33b8af97e7c6fb2d3016422d084eae7aca7cb70c.1617116623.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1617116623.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1617116623.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A subsequent patch will need to refer back to 'midx_name' later on in
the function. In fact, this variable is already free()'d later on, so
this makes the later free() no longer redundant.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/midx.c b/midx.c
index 4a9d84352c..3edde2b68d 100644
--- a/midx.c
+++ b/midx.c
@@ -956,7 +956,6 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 
 	hold_lock_file_for_update(&lk, midx_name, LOCK_DIE_ON_ERROR);
 	f = hashfd(get_lock_file_fd(&lk), get_lock_file_path(&lk));
-	FREE_AND_NULL(midx_name);
 
 	if (ctx.m)
 		close_midx(ctx.m);
-- 
2.30.0.667.g81c0cbc6fd

