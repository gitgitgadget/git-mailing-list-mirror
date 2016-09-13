Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28D8520996
	for <e@80x24.org>; Tue, 13 Sep 2016 00:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752113AbcIMA0B (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 20:26:01 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:55816 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750975AbcIMA0B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 20:26:01 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 8FC8D20985;
        Tue, 13 Sep 2016 00:25:57 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     Yaroslav Halchenko <yoh@onerussian.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: [RFC 1/3] http: warn on curl_multi_add_handle failures
Date:   Tue, 13 Sep 2016 00:25:55 +0000
Message-Id: <20160913002557.10671-2-e@80x24.org>
In-Reply-To: <20160913002557.10671-1-e@80x24.org>
References: <20160913002557.10671-1-e@80x24.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This will be useful for tracking down curl usage errors.

Signed-off-by: Eric Wong <e@80x24.org>
---
 http.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/http.c b/http.c
index cd40b01..cac5db9 100644
--- a/http.c
+++ b/http.c
@@ -1022,6 +1022,8 @@ int start_active_slot(struct active_request_slot *slot)
 
 	if (curlm_result != CURLM_OK &&
 	    curlm_result != CURLM_CALL_MULTI_PERFORM) {
+		warning("curl_multi_add_handle failed: %s",
+			curl_multi_strerror(curlm_result));
 		active_requests--;
 		slot->in_use = 0;
 		return 0;
-- 
EW

