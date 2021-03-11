Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E63C43381
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1989564FFB
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbhCKRFV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 12:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhCKREt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 12:04:49 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E688C061760
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 09:04:48 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id b130so21303470qkc.10
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 09:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=By4ZDw+6iwX13Ip2dovM5NjuD4lu7Lq1pVXXR7wZA+M=;
        b=fTctuxq1wQbdD3yIgcAfD23+1qdxelD83LiVTF0PBQakCWD66Yln11MDz3J3y3o+J3
         bjC1nwdgzGoODD6nQ4P8rijbZJlq5iWLrGQ1xhSEpf+2KXhvylIaf2DQD28cwjzQdEOw
         euZY35QPawmL9cMjHHpwOUbgLZ0pq87CKjGpxVGux6+qeTYIxE6eab8SOTZvjsD63WV8
         9inpn/0OyLZ1lBWhEKELqd9oVAfWZJqlIAu1INPbGmCOxo9bDdo2TErmZMr8s422fHjf
         1zNH8TLVO/1al9y3cnuvJEuIHQe5mKyUUq8fPbFXsidRjjwuXHg0I7Vq6OyHPTqb+YEz
         gULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=By4ZDw+6iwX13Ip2dovM5NjuD4lu7Lq1pVXXR7wZA+M=;
        b=il9z9W7mYYG09C9BONgNg1Ftt8VFHlnU5CA+LGD84huBNtYlOhRkAQ8y9oXKp6P/P0
         mSqJvWY7bB3VFCn4QgeuhvymnyLAMSJQTQ/l5Z0d0NgylvBcarmEkwg4kakVAi7oMbxv
         kH87JF85PeBnWxb+wiCIcV6ZGTs1ablI3RvtviBuLkJICiOPLV1KTriDEyOGCQCrilm+
         /nLa0GlunnaSChj0uRDzG/iDPbn2bEROy3hN9JxP96xzIMWQTvNsQql5WdmkNMgw85nQ
         KBVl+irZ/ojMizccV9wFdFnjrDJXbFS+MQ0Iyc1OIUhtGkrsiTQUcTSaj4K9oEocxanW
         iFYQ==
X-Gm-Message-State: AOAM531Ra+QRtaHWtxeE7kQ8UOsB4H7nokZw9JLnkSbhyN59Lv30slp1
        uf4R1RbniTnTv6IjBGCkkXiNXzJCwuO0nadN
X-Google-Smtp-Source: ABdhPJw+IyFhwzovLRsVSwlx7A2mn7Sng5DKfXapvR+O5xUBs3uJB0Ho6sLd+oRz5yDn/C/gJEqDmA==
X-Received: by 2002:a05:620a:6c1:: with SMTP id 1mr2605771qky.198.1615482287584;
        Thu, 11 Mar 2021 09:04:47 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:f947:1686:6ada:db5b])
        by smtp.gmail.com with ESMTPSA id t21sm2007324qtw.51.2021.03.11.09.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 09:04:47 -0800 (PST)
Date:   Thu, 11 Mar 2021 12:04:45 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com, peff@peff.net
Subject: [PATCH v3 03/16] builtin/multi-pack-index.c: define common usage
 with a macro
Message-ID: <94c498f0e25c8dde093b9a1ad8044c4ef37a6c5d.1615482270.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1615482270.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1615482270.git.me@ttaylorr.com>
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

