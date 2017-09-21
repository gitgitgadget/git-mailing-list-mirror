Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BB2A202A5
	for <e@80x24.org>; Thu, 21 Sep 2017 16:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751629AbdIUQq1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 12:46:27 -0400
Received: from avasout07.plus.net ([84.93.230.235]:33147 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751581AbdIUQq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 12:46:26 -0400
Received: from [10.0.2.15] ([147.147.86.16])
        by avasout07 with smtp
        id CGmQ1w00B0M91Ur01GmR3g; Thu, 21 Sep 2017 17:46:25 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CrLPSjwD c=1 sm=1 tr=0
 a=dubYQqM3tRRTmV8xSh8cXQ==:117 a=dubYQqM3tRRTmV8xSh8cXQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=eJYRLf2lFUu4u5GP0DcA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 1/4] git-compat-util.h: xsize_t() - avoid -Wsign-compare
 warnings
Message-ID: <15367a04-754c-f6b8-a89b-2c1ff65dedf5@ramsayjones.plus.com>
Date:   Thu, 21 Sep 2017 17:46:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
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
 git-compat-util.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 9bc15b036..cedad4d58 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -898,9 +898,11 @@ static inline char *xstrdup_or_null(const char *str)
 
 static inline size_t xsize_t(off_t len)
 {
-	if (len > (size_t) len)
+	size_t size = (size_t) len;
+
+	if (len != (off_t) size)
 		die("Cannot handle files this big");
-	return (size_t)len;
+	return size;
 }
 
 __attribute__((format (printf, 3, 4)))
-- 
2.14.0
