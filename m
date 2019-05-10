Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 537961F45F
	for <e@80x24.org>; Fri, 10 May 2019 06:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfEJG7D (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 02:59:03 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:44533 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfEJG7D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 02:59:03 -0400
Received: by mail-pg1-f178.google.com with SMTP id z16so2524818pgv.11
        for <git@vger.kernel.org>; Thu, 09 May 2019 23:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N6FjhKYS6FQckHZVGwp5WRbX43ucuxah8bF4ZfBDBFA=;
        b=B2NKsmz1RrgW+irSILsaFQJ7boxUvoMcky5f+Zrp7awSNYYVv8gRSDBfAqkbjP6ZUl
         Y5QuLGb+g8FxWkbXJd27LjuCO/CEHe4c5b4xO+No+t8aY3RjLVOd+8ru86XnQtqnzI4T
         CDH+f+QmsMF12SRfSQctr6HezXTTXPRBg19eoIxRKFNhBRrzTdscHCGigjiSm5OTl4iA
         K6N11xOcX3QuEp5qh4Lb/YVEILswiO+UflJhX29DaNxJhscZI+//4GvNP1jVYvexI3e4
         6VyBc+2yv+hK5s5NQ/UG6pHwhX+SZaTi77T8mTE0z7kkoBp9mbe0EDWZGw6oe8LidEQ+
         KB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N6FjhKYS6FQckHZVGwp5WRbX43ucuxah8bF4ZfBDBFA=;
        b=Qg0wV0b+xF9QEW6N6tKZ6lEHv2E8Zorg48gO1pzHsrgeVkyKei3timI/zRtePJ6eD6
         bQVAOy40NEWg66d5OLjtaAXc5D5VlUO3Js6tztSm0Np4t4qRp7kDMiFhNlLYEZv+Dhl8
         CTHtDRA3/FymHE9q3XNtCk5OKc16Ok6kfBdJtEkNd6rdmH3d1CJpRSfQbqEaNvyrSXDS
         NF3mwLpQarbUOU9Mqohs/S+axRaI8kNsE29fyR6L6pdgTtHkjZQgvUupR2+qWyoXlu/b
         iBR6kpRcl9XrgJgSPcfkXX/+hNh+u+8jhC+d3kc+4t+uiEMD1PuMxUrKJMpGjh7F+qqx
         vZOA==
X-Gm-Message-State: APjAAAWHw8Tvl1RQ+0fo2wa+5qkUb17r20OQRbR+iVM+ReXahBYtHxcu
        v294XQjuPiK7kSRoYE2O0+u8VHVC
X-Google-Smtp-Source: APXvYqyDxhBVJIw6J7VdYnXu8wOmxdghxLKAJ9byEkuP9Uh0fwkmSFnjjI94ICD/xI1CFnbpbip59w==
X-Received: by 2002:a62:4115:: with SMTP id o21mr11702329pfa.153.1557471541650;
        Thu, 09 May 2019 23:59:01 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id a80sm12308636pfj.105.2019.05.09.23.59.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 09 May 2019 23:59:01 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     nickh@reactrix.com, gitster@pobox.com
Subject: [PATCH] http-push: workaround for format overflow warning in gcc >= 9
Date:   Thu,  9 May 2019 23:58:48 -0700
Message-Id: <20190510065848.27606-1-carenas@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In function 'finish_request',
    inlined from 'process_response' at http-push.c:248:2:
http-push.c:587:4: warning: '%s' directive argument is null [-Wformat-overflow=]
  587 |    fprintf(stderr, "Unable to get pack file %s\n%s",
      |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  588 |     request->url, curl_errorstr);
      |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
---
 http-push.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/http-push.c b/http-push.c
index f675a96316..2db553ef38 100644
--- a/http-push.c
+++ b/http-push.c
@@ -585,7 +585,8 @@ static void finish_request(struct transfer_request *request)
 		int fail = 1;
 		if (request->curl_result != CURLE_OK) {
 			fprintf(stderr, "Unable to get pack file %s\n%s",
-				request->url, curl_errorstr);
+				request->url ? request->url : "",
+				curl_errorstr);
 		} else {
 			preq = (struct http_pack_request *)request->userData;
 
-- 
2.21.0

