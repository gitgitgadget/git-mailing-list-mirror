Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CE9C43331
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA53523A7B
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbhAHSST (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 13:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728707AbhAHSSS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 13:18:18 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FBFC0612A3
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 10:17:47 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id s6so4714412qvn.6
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 10:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HoRaU13iduWPn49awvL3lquMnX6J2oADKyWbLdNdiyg=;
        b=tZAvqsVJixYLyjyFPYafjMbD+QDjzjtpr1ELOTXN+rFgKu0F3Uo7sg2iRfPJi1O1lW
         Co3rU2+SoFmWzCTCIHqDCA/qPzxrC51XYwmhaMnjjSM9L26C8wLCgv9vrtckYhOx9a2b
         qEJz+XWTeV6SFF8N/IO+FjxwYC3rTwfVMpro2tNk3ULCBr1okBql1s7yJccXuzd1OxvC
         Op8vvWgIgtCzspYE/46iJwKVNC5Sjnm2wxBfYtvCYje0o6/edOjzapSd3QwP8t1F5a27
         NN4Fj2TDPDg5OFlkpbRvAwMsqxKI1GKDr9o191GtMKx5zvGcQwBbdiObg8LI7u+w0iYD
         fCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HoRaU13iduWPn49awvL3lquMnX6J2oADKyWbLdNdiyg=;
        b=aPsVlMy3ZENd2ptEFOs6OA/uSNHMN45ro5hzVPiD6zqNKLRF4NV2aECEN7cz1g+Apu
         hczFrbLvL4ddOvxm68nM1oE/VtugadaIYVwfdMzIsbqL19fx/pYmJ85jqKeO2DQKAEC5
         +t5+yFILSCsxmi64a2Hs5LPxkSYV+q0+N1ExP3kVVdXnEJmKRnVVwWz/DpeW6BuNRoCQ
         pu5VFXNqAUWZqM8K7TjH06i/o3X1mDhysgSde5FrL4E1Rz/VaKMElQVGK/Zy1zUo84TC
         AuWhTTh+M80R6Tb0fJF9wJ2HYhB5QbxFN1ckZlBC4J5a4cHyT2CIOccG+7um7vx022DQ
         bcVQ==
X-Gm-Message-State: AOAM530RywgByHo4aJU66ey0Rbt2c7fQJqftRu+mIWTejJ5l8VhraOB6
        d6B7uvQxs47LI/JThwhI4ScG7+rDcZurpg==
X-Google-Smtp-Source: ABdhPJz3AFYuQfVUcuBojQM6IuumVFIarupt6I1fC8le6B7Hocxy+bN9B5FmEy7/5KsXQRXQITLy5g==
X-Received: by 2002:a0c:b4d1:: with SMTP id h17mr4757511qvf.53.1610129866305;
        Fri, 08 Jan 2021 10:17:46 -0800 (PST)
Received: from localhost ([8.9.92.205])
        by smtp.gmail.com with ESMTPSA id w33sm4994459qth.34.2021.01.08.10.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 10:17:45 -0800 (PST)
Date:   Fri, 8 Jan 2021 13:17:43 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com
Subject: [PATCH 15/20] for_each_object_in_pack(): convert to new revindex API
Message-ID: <a3249986f9ab935825bc37e1bf980e44532700ae.1610129796.git.me@ttaylorr.com>
References: <cover.1610129796.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610129796.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid looking at the 'revindex' pointer directly and instead call
'pack_pos_to_index()'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 packfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/packfile.c b/packfile.c
index 34467ea4a3..46c9c7ea3c 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2082,7 +2082,7 @@ int for_each_object_in_pack(struct packed_git *p,
 		struct object_id oid;
 
 		if (flags & FOR_EACH_OBJECT_PACK_ORDER)
-			pos = p->revindex[i].nr;
+			pos = pack_pos_to_index(p, i);
 		else
 			pos = i;
 
-- 
2.30.0.138.g6d7191ea01

