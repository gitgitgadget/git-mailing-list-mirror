Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8792920286
	for <e@80x24.org>; Thu,  7 Sep 2017 16:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755282AbdIGQI1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 12:08:27 -0400
Received: from avasout08.plus.net ([212.159.14.20]:51756 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754518AbdIGQI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 12:08:26 -0400
Received: from [10.0.2.15] ([147.147.86.16])
        by avasout08 with smtp
        id 6g8P1w0040M91Ur01g8QnC; Thu, 07 Sep 2017 17:08:25 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=EJl26xRC c=1 sm=1 tr=0
 a=dubYQqM3tRRTmV8xSh8cXQ==:117 a=dubYQqM3tRRTmV8xSh8cXQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=4i9otrbcGBqTC3LgtfwA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] usage: conditionally compile unleak_memory() definition
Message-ID: <1cf112f5-aad1-e1c6-b507-9524f4b72fec@ramsayjones.plus.com>
Date:   Thu, 7 Sep 2017 17:08:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Jeff,

If you need to re-roll your 'jk/leak-checkers' branch, could you
please squash this into the relevant patch (commit c57586d954,
"add UNLEAK annotation for reducing leak false positives", 05-09-2017).

This was noticed by sparse, since it is not declared when the
SUPPRESS_ANNOTATED_LEAKS pre-processor macro is not defined.
(You could move the declaration out of the #ifdef in the header
file, I suppose, but it seems pointless to compile the function
if it isn't being used).

Thanks!

ATB,
Ramsay Jones

 usage.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/usage.c b/usage.c
index 780ed73be..cdd534c9d 100644
--- a/usage.c
+++ b/usage.c
@@ -242,6 +242,7 @@ NORETURN void BUG(const char *fmt, ...)
 }
 #endif
 
+#ifdef SUPPRESS_ANNOTATED_LEAKS
 void unleak_memory(const void *ptr, size_t len)
 {
 	static struct suppressed_leak_root {
@@ -254,3 +255,4 @@ void unleak_memory(const void *ptr, size_t len)
 	root->next = suppressed_leaks;
 	suppressed_leaks = root;
 }
+#endif
-- 
2.14.0
