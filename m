Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1151F1F597
	for <e@80x24.org>; Tue, 24 Jul 2018 21:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388664AbeGXXBE (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 19:01:04 -0400
Received: from s019.cyon.net ([149.126.4.28]:43840 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728106AbeGXXBE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 19:01:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=drbeat.li;
         s=default; h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SCECplNL9lL+Alxb2x9+I1GVORnf+v6jrVdWiq7YleU=; b=BDgHb3Gx+1NSnJ0qkXQEZOj0+o
        XUDyETiYkm0NPDq3ifTln8bAa3b7bZxdEOPYkcJ0xG5NVe0dub9LHLU1GOmH35oHgm2YH25GreyUq
        3Ruk0rhOnMuNmFpd1pv3VzuV2tmqx2Erghp5MVbSuq+Z7/59H1VGe/QBcCIjIJisos4eGMii4zxce
        LfmT72DtoE402ACzTaQ6YjkpQNi0uXT9Rc2xuyo3H8BRKQYWoLKV75LqgPjvSqLtwkoOPU0nI9GUu
        NW0y0Gxr3uTP9TB98F8nbZEoV0dO/MEHw5WYI29+t02tSijFFSB8Yf2IGEWAw2Gc4ZG3jnB/J7WzL
        kxTnm4+w==;
Received: from [10.20.10.233] (port=36362 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.91)
        (envelope-from <bb@drbeat.li>)
        id 1fi5EN-00B54Q-FJ; Tue, 24 Jul 2018 23:52:33 +0200
Received: by drbeat.li (Postfix, from userid 1000)
        id 1A8E720F1D; Tue, 24 Jul 2018 23:52:31 +0200 (CEST)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 1/2] packfile: drop a repeated enum declaration
Date:   Tue, 24 Jul 2018 23:52:22 +0200
Message-Id: <20180724215223.27516-2-dev+git@drbeat.li>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
In-Reply-To: <20180724215223.27516-1-dev+git@drbeat.li>
References: <20180724215223.27516-1-dev+git@drbeat.li>
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

Drop the belated declaration of enum object_type. It seems that each
includer of packfile.h includes the definition of the enum before
including packfile.h.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 packfile.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/packfile.h b/packfile.h
index 51383774ec72..9b6198c4c7e0 100644
--- a/packfile.h
+++ b/packfile.h
@@ -6,7 +6,6 @@
 /* in object-store.h */
 struct packed_git;
 struct object_info;
-enum object_type;
 
 /*
  * Generate the filename to be used for a pack file with checksum "sha1" and
-- 
2.18.0

