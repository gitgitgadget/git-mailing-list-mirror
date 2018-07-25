Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E60F1F597
	for <e@80x24.org>; Wed, 25 Jul 2018 21:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731328AbeGYXJ6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 19:09:58 -0400
Received: from s019.cyon.net ([149.126.4.28]:35464 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731022AbeGYXJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 19:09:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=drbeat.li;
         s=default; h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=x+LWH+64+oSe8k4h3gQNwrWtvkzwyIqKGkouPJ56/rQ=; b=mO7paP9hhizT+VSSTho2zZu3+g
        pqsB4GKnZEmI2ylIUDnIlLuc5ssfAGAv1uoQOjhDysgzfHeKVEtvlBITzrgnCgOn3hG2Ge7LpfOcJ
        Sv4q4USEUqfxaMihrcs0mFUgJ67I2pb1I2sPNHXSX6OyZPLUGDAFtjk/+H+N2/xjMlWH/sHSJHStU
        uNXuH+nYT6MBcmjITRbG7RUGPUuzDL05YTR0sZpAn6fTXnJruapWUJU1M48XKWl6MBqQfrKZriSTt
        TRvgYmDrXiqYpnBKYZigdpSxb8gH0XRCHD/33kqNtDIH/omDsc5ult/zFhrXmeqCUQvGe02SHGLac
        PziEGEDQ==;
Received: from [10.20.10.231] (port=26370 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.91)
        (envelope-from <bb@drbeat.li>)
        id 1fiRlX-000Wvs-Na; Wed, 25 Jul 2018 23:56:17 +0200
Received: by drbeat.li (Postfix, from userid 1000)
        id 66C6621FF0; Wed, 25 Jul 2018 23:56:15 +0200 (CEST)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v2] packfile: ensure that enum object_type is defined
Date:   Wed, 25 Jul 2018 23:56:07 +0200
Message-Id: <20180725215607.19910-2-dev+git@drbeat.li>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
In-Reply-To: <20180725215607.19910-1-dev+git@drbeat.li>
References: <20180725215607.19910-1-dev+git@drbeat.li>
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When compiling under Apple LLVM version 9.1.0 (clang-902.0.39.2) with
"make DEVELOPER=1 DEVOPTS=pedantic", the compiler says

    error: redeclaration of already-defined enum 'object_type' is a GNU
    extension [-Werror,-Wgnu-redeclared-enum]

According to https://en.cppreference.com/w/c/language/declarations
(section "Redeclaration"), a repeated declaration after the definition
is only legal for structs and unions, but not for enums.

Drop the belated declaration of enum object_type and include cache.h
instead to make sure the enum is defined.

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 packfile.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/packfile.h b/packfile.h
index 51383774ec72..28318c5c7c42 100644
--- a/packfile.h
+++ b/packfile.h
@@ -1,12 +1,12 @@
 #ifndef PACKFILE_H
 #define PACKFILE_H
 
+#include "cache.h"
 #include "oidset.h"
 
 /* in object-store.h */
 struct packed_git;
 struct object_info;
-enum object_type;
 
 /*
  * Generate the filename to be used for a pack file with checksum "sha1" and
-- 
2.18.0

