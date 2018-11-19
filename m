Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8D191F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 15:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbeKTBjf (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 20:39:35 -0500
Received: from srv1.79p.de ([213.239.234.118]:35922 "EHLO srv1.79p.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729376AbeKTBje (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 20:39:34 -0500
Received: from srv1.79p.de (localhost [127.0.0.1])
        by srv1.79p.de (Postfix) with ESMTP id 5A53E220193;
        Mon, 19 Nov 2018 16:15:39 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at srv1.79p.de
Received: by srv1.79p.de (Postfix, from userid 1000)
        id A8FAA224867; Mon, 19 Nov 2018 16:15:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs-ware.de;
        s=mail2018; t=1542640538;
        bh=pfZvaP7tQ/4VUSDkNi8vhTNVfEsleyZHnOxxslhzBbQ=;
        h=From:Date:Subject:In-Reply-To:References:To:CC:From;
        b=F0lyAxa4bOTfVCKdLiUen/LuEfp5SSs25UO8k4haA90yLy9+CuDU8ZBeM70qpTcsp
         YQHtN6vuuJIwTy5ba7CqsIECtnk7LEpkYRmeSC/av9cAfFUM1mbNoZ8A9MqztX1Zsq
         aIDJM+o/6j64qH9vr+dQYx9HjTt6xm6z2QxJYxOk1QCq81txMxTyJZRpxMCT98TZOQ
         lSRVTNUOxagEaFs82UaHQdiSE4ZumvL7HvucDYL8J66jC9BsDi0NUKg77VP1VjExYD
         Rh5/HDxoBibYD6L3fR7EP7f8P9eakuCwdrUY8t60Evfuhyjn60LY+sqSUyRsHz+hEs
         pobOR7V3mPa6A==
From:   Sven Strickroth <email@cs-ware.de>
Date:   Mon, 19 Nov 2018 16:14:42 +0100
Subject: [PATCH] msvc: Directly use MS version (_stricmp) of strcasecmp
Message-ID: <15a7df69-25d8-c168-dd43-a43b7f0d34c1@cs-ware.de>
In-Reply-To: <xmqqk1l9esey.fsf@gitster-ct.c.googlers.com>
References: <ad85731f-2c47-f455-c9d3-d47a5fj1e29@cs-ware.de>
 <20181118215820.GA14514@sigill.intra.peff.net>
 <xmqqk1l9esey.fsf@gitster-ct.c.googlers.com>
To:     git@vger.kernel.org
CC:     gitster@pobox.com, peff@peff.net, Johannes.Schindelin@gmx.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This also removes an implicit conversion from size_t (unsigned) to int (signed).

_stricmp as well as _strnicmp are both available since VS2012.

Signed-off-by: Sven Strickroth <email@cs-ware.de>
---
 compat/msvc.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/compat/msvc.h b/compat/msvc.h
index e6e1a6bbf7..2d558bae14 100644
--- a/compat/msvc.h
+++ b/compat/msvc.h
@@ -14,18 +14,12 @@
 #define inline __inline
 #define __inline__ __inline
 #define __attribute__(x)
+#define strcasecmp   _stricmp
 #define strncasecmp  _strnicmp
 #define ftruncate    _chsize
 #define strtoull     _strtoui64
 #define strtoll      _strtoi64
 
-static __inline int strcasecmp (const char *s1, const char *s2)
-{
-	int size1 = strlen(s1);
-	int sisz2 = strlen(s2);
-	return _strnicmp(s1, s2, sisz2 > size1 ? sisz2 : size1);
-}
-
 #undef ERROR
 
 #define ftello _ftelli64
-- 
2.19.1.windows.1
