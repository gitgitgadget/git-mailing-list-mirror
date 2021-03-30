Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45E3C433E4
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 15:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B625A61953
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 15:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbhC3PEZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 11:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbhC3PD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 11:03:57 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52EFC061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 08:03:56 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id r193so16748586ior.9
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 08:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=By4ZDw+6iwX13Ip2dovM5NjuD4lu7Lq1pVXXR7wZA+M=;
        b=oYfwYywa4Azc3MrZ/+HJco6eZzG3NG+YOmIIw26elEnhU1sn+fpalfDyqauL/HpCDo
         NWQMNGEjZ5S4A9JIkHfcXAK2cS/cKdfOjqVaWEtf9xgALY6ZheHH8cSz9Vl6eZNVkt6o
         dYiIhjvcZ8OhNhYORRl6eHo6nJpj3/qqShX71TFO+riQjcPKF/SIkJWSLoFV0Gvi2joQ
         M+7B92tXPivtZ2ImGuTBLMcYBfl3YTTOf5+g9rNB4tQZwelZsgOesUc1zGs5uAvbPh9+
         yuwMzvz3v8UxNJ/nB6NKCh+W+wA6YkgJdNRaBK0dGhsdSegwxGm4gTSvWY5micq0cLdB
         KGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=By4ZDw+6iwX13Ip2dovM5NjuD4lu7Lq1pVXXR7wZA+M=;
        b=aOCk7VSVR9ItHH1/5CkVZnk3nrbCXT5vITMvlt0O4fSvY+S151MxVW/Q10QcF4vEGO
         BFuS80q7iF/2x5DPC5+zFVb4mwxccT2KOTcQVBYYI7bbfh/FvSnwN098CSTqXeefz5ln
         kWtS5jlOph8GBtZhVubtKQAknWIg8rg1ot8U5f4pZa9f70rw+MS7hfyXfADsm08zvsEy
         VZhPVvNDtXe3nXnjNyxhzSYH0uF16Cgd7MrvOtP79Iw2EZHDJMI9RyBXoPWyCJ6AQiZB
         tuywkZt0K2yF6AOG10NddFo4eu+0crm3YiyZAlLvGwoe6wCyG2CFsgJaSRN/eBGiKQSz
         H5Pg==
X-Gm-Message-State: AOAM530Ix7j5wDxMnrpno3Y7qHQFmPwNSpXjFy4GYHLrB011ZF/auane
        +rrFmJER8G2QR9nniD2wwGwwqud9UOkIaA==
X-Google-Smtp-Source: ABdhPJxd9DzgS52wn80QHVWGCazH+Q1O4inDvYyiot4szgjfFlKwzjZLHtoMMBiXC19ahyUdExxOfw==
X-Received: by 2002:a5d:81da:: with SMTP id t26mr24535534iol.129.1617116636013;
        Tue, 30 Mar 2021 08:03:56 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:7b00:4f79:8763:6261])
        by smtp.gmail.com with ESMTPSA id h8sm5770334ila.52.2021.03.30.08.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 08:03:55 -0700 (PDT)
Date:   Tue, 30 Mar 2021 11:03:54 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, dstolee@microsoft.com,
        jonathantanmy@google.com
Subject: [PATCH v4 03/16] builtin/multi-pack-index.c: define common usage
 with a macro
Message-ID: <5a274b909674401fa682b08ce08ad5b6acb47784.1617116623.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1617116623.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1617116623.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Factor out the usage message into pieces corresponding to each mode.
This avoids options specific to one sub-command from being shared with
another in the usage.

A subsequent commit will use these #define macros to have usage
variables for each sub-command without duplicating their contents.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/multi-pack-index.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index c70f020d8f..eea498e026 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -5,8 +5,23 @@
 #include "midx.h"
 #include "trace2.h"
 
+#define BUILTIN_MIDX_WRITE_USAGE \
+	N_("git multi-pack-index [<options>] write")
+
+#define BUILTIN_MIDX_VERIFY_USAGE \
+	N_("git multi-pack-index [<options>] verify")
+
+#define BUILTIN_MIDX_EXPIRE_USAGE \
+	N_("git multi-pack-index [<options>] expire")
+
+#define BUILTIN_MIDX_REPACK_USAGE \
+	N_("git multi-pack-index [<options>] repack [--batch-size=<size>]")
+
 static char const * const builtin_multi_pack_index_usage[] = {
-	N_("git multi-pack-index [<options>] (write|verify|expire|repack --batch-size=<size>)"),
+	BUILTIN_MIDX_WRITE_USAGE,
+	BUILTIN_MIDX_VERIFY_USAGE,
+	BUILTIN_MIDX_EXPIRE_USAGE,
+	BUILTIN_MIDX_REPACK_USAGE,
 	NULL
 };
 
-- 
2.30.0.667.g81c0cbc6fd

