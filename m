Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 820B71F597
	for <e@80x24.org>; Thu, 19 Jul 2018 18:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732707AbeGSTk5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 15:40:57 -0400
Received: from mail-vk0-f74.google.com ([209.85.213.74]:45687 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732179AbeGSTk5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 15:40:57 -0400
Received: by mail-vk0-f74.google.com with SMTP id e127-v6so3200274vkg.12
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 11:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=INimGi8gyfNsVTRJRKa4Df5qjKADbyVsYPPmLcWfaBY=;
        b=EcghIyi1GIXfTJwMJwYsWhpdL9broKQ5x/oeZkMdMxfnYnaT47WK8efK8HyXDcv6wR
         PSaygcOL5iLUEFVYOuxdCUcWBZfruvjLUUNQoKRrXj02YfVzuPQHXv8AZ3zU77yrBrgz
         PZMKY3SJvayY36YTwDdxVHwovGzAc3ujK2YIlELkgrCr08/azGb/7hrQHAH+UqWrJWuW
         bWz542m2K8jgpbDe3OkD82Y2bSW32ZuGdskRE9yU/k0P/4GlzgQrBqhUoxLjYDuU24or
         es96iRy+nacBqdBxYnIVO97VfA4eGJNDYp8KWHMkzPxZTNZ2ILYPv4eVJAMEp+ThLp9U
         Mb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=INimGi8gyfNsVTRJRKa4Df5qjKADbyVsYPPmLcWfaBY=;
        b=oRo4SJRTQg2G2B+zRGRum+EdWnZ93ZdIqaxrD29dKxuICFQnDasxD9r+dl6l4h3FLL
         CKmXv/CNU24ZgF9Tlv73YlcweM5ikZTC5gPkJCK3LPjyrosZDLilS6Hm09W1FrWXiXOv
         sj3vqNcIYhKVBVUQ3RX2efklVWd+0gDUBpf0xMWsK9PWien9iqxMHnhxR1zhGAJDqjFS
         iitlWMsi1B1VSKqypYbghjDoWNBxs11Nh/R6FecfOnUpmCby7Sf84tbxSDP9rCstkqN2
         DEVI70gJsNPjL+i3R3cuPdjcILzGzAlXaWFdVm9p82aCfesbv3csbcr0u7NH5FjkkROX
         65rA==
X-Gm-Message-State: AOUpUlHyoL/YsCOikJtMtg+DIGE1SeB3XaAJ68OFzk9+rW26PBY4HOnf
        CwCCeyuHYMA0X79j7jn/XiXbHR5LlUW5B9WMxMnzD2KpeT64YNcvlJOPDnN1zAPoUmjrkHgu5BM
        YjeBs1YGx/n6P+cbIpRvGhHtKJIpPD+p7fsLli2ke7OcnhGgWdzPZNC3iRVwJ
X-Google-Smtp-Source: AAOMgpfHBgnB+QzirZOGX0fs2RMDsdiGwARRh2Hw0fwAlqjc3rHD1lqLiWxD44NOcRu9lE24LjPs1yQWOgvU
MIME-Version: 1.0
X-Received: by 2002:ab0:175b:: with SMTP id k27-v6mr5403203uaf.53.1532026589321;
 Thu, 19 Jul 2018 11:56:29 -0700 (PDT)
Date:   Thu, 19 Jul 2018 11:56:19 -0700
In-Reply-To: <20180719185620.124768-1-sbeller@google.com>
Message-Id: <20180719185620.124768-3-sbeller@google.com>
References: <20180719185620.124768-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Subject: [PATCH 2/3] xdiff/xhistogram: factor out memory cleanup into free_index()
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This will be useful in the next patch as we'll introduce multiple
callers.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 xdiff/xhistogram.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
index 6e20f75fe85..5098b6c5021 100644
--- a/xdiff/xhistogram.c
+++ b/xdiff/xhistogram.c
@@ -243,6 +243,14 @@ static int fall_back_to_classic_diff(xpparam_t const *xpp, xdfenv_t *env,
 				  line1, count1, line2, count2);
 }
 
+static inline void free_index(struct histindex *index)
+{
+	xdl_free(index->records);
+	xdl_free(index->line_map);
+	xdl_free(index->next_ptrs);
+	xdl_cha_free(&index->rcha);
+}
+
 static int find_lcs(struct histindex *index, struct region *lcs,
 	int line1, int count1, int line2, int count2) {
 	int b_ptr;
@@ -343,10 +351,7 @@ static int histogram_diff(xpparam_t const *xpp, xdfenv_t *env,
 	}
 
 cleanup:
-	xdl_free(index.records);
-	xdl_free(index.line_map);
-	xdl_free(index.next_ptrs);
-	xdl_cha_free(&index.rcha);
+	free_index(&index);
 
 	return result;
 }
-- 
2.18.0.233.g985f88cf7e-goog

