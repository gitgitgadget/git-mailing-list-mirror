Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8EAA1F87F
	for <e@80x24.org>; Sun, 18 Nov 2018 21:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbeKSHvX (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 02:51:23 -0500
Received: from srv1.79p.de ([213.239.234.118]:56692 "EHLO srv1.79p.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726746AbeKSHvX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 02:51:23 -0500
Received: from srv1.79p.de (localhost [127.0.0.1])
        by srv1.79p.de (Postfix) with ESMTP id F281D22527A
        for <git@vger.kernel.org>; Sun, 18 Nov 2018 22:29:57 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at srv1.79p.de
Received: by srv1.79p.de (Postfix, from userid 1000)
        id 78FAF225293; Sun, 18 Nov 2018 22:29:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs-ware.de;
        s=mail2018; t=1542576597;
        bh=lg++0vKXnDeHMZFxSdW5AiS+ILXfI8paxjNf/mo+gyc=;
        h=From:Date:Subject:To:CC:From;
        b=WZNEg75nmMpGSHtj1xfFdhKeiz6DP51p0ZtbzPCVNibNVMXGTvAeE2YQmM2NM27wq
         8aC0t8A8OlZwhiBNXsNHgv+AbWJ/11u9fg+hPvdyK501kzXC83PvTZBeBJvxDQl6KV
         PtzOaJBtd0syysQBq6n6EVA/jASmVo/Zx4RWtI0iCvHxlrS6UgvCKPz/HCTlNPHWNV
         SLjyIDAnDnV6ChFP9K0sWq+DFx+QooastMuQX9k3ksQqxcWxk/sBMDdUzcjoec2mJB
         RDe1XQFpBG1eqiZwgK83Kh94I0CNZUlIJdlqkVSt2pZrj94yKgfdEqx+vYTALnmCEa
         3CT9fZudqfFLg==
From:   Sven Strickroth <email@cs-ware.de>
Date:   Sun, 18 Nov 2018 22:02:02 +0100
Subject: [PATCH] msvc: Directly use MS version (_stricmp) of strcasecmp
Message-ID: <ad85731f-2c47-f455-c9d3-d47a5fj1e29@cs-ware.de>
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
index 580bb55bf4..ea6527f8b6 100644
--- a/compat/msvc.h
+++ b/compat/msvc.h
@@ -14,13 +14,7 @@
 #define ftruncate    _chsize
 #define strtoull     _strtoui64
 #define strtoll      _strtoi64
-
-static __inline int strcasecmp (const char *s1, const char *s2)
-{
-       int size1 = strlen(s1);
-       int sisz2 = strlen(s2);
-       return _strnicmp(s1, s2, sisz2 > size1 ? sisz2 : size1);
-}
+#define strcasecmp   _stricmp

 #undef ERROR

--
2.19.1.windows.1
