Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66BEA1F775
	for <e@80x24.org>; Wed,  2 Jan 2019 09:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbfABJir (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Jan 2019 04:38:47 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:51384 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726499AbfABJir (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jan 2019 04:38:47 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id E39991F770;
        Wed,  2 Jan 2019 09:38:46 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] banned.h: mark strncat() as banned
Date:   Wed,  2 Jan 2019 09:38:46 +0000
Message-Id: <20190102093846.6664-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

strncat() has the same quadratic behavior as strcat() and is
difficult-to-read and bug-prone.  While it hasn't yet been a
problem in git iself, strncat() found it's way into 'master'
of cgit and caused segfaults on my system.

Signed-off-by: Eric Wong <e@80x24.org>
---
 banned.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/banned.h b/banned.h
index 28f5937035..447af24807 100644
--- a/banned.h
+++ b/banned.h
@@ -16,6 +16,8 @@
 #define strcat(x,y) BANNED(strcat)
 #undef strncpy
 #define strncpy(x,y,n) BANNED(strncpy)
+#undef strncat
+#define strncat(x,y,n) BANNED(strncat)
 
 #undef sprintf
 #undef vsprintf
-- 
EW

