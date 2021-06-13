Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89767C48BE8
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 22:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6873A6124B
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 22:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbhFMXBB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 19:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbhFMXBB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 19:01:01 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F357C061574
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 15:58:45 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so9076737oth.9
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 15:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/vlpUfp9K00BVnxAIIyPR+nmhbV27ININ2rArAaXpSM=;
        b=M05/36iFmfx1OMfDiUQ5s9JFxWx03OwRJSzOjg3WIoKQ1oxhVfSk9Z8FQ96RKf/g7a
         8F07LMF7PyXhBrXkau2lESZ66Ui8IO2zrgL7FI9Zz3L+QIRMJJVJhJK4Dn6rtFZJCrL7
         hwJJHWO8HT6sFc08QCTOycYyS4gv/yf7i7fQOe8/aJ3GCdRAxPoeXCARGRA95wh+F5z2
         qL8QE8f3M0wP1HRw7so3jhG7EQgsZBq4WkZvYAla25ac3n4oVPqYNN+kY6Xv2zrcxr52
         w1tFg3dyLbP2Na+0CEUvZk8hzSad2H1+6l+52M749EoP8SkEWCreEHlHLRPpO/dS5c/N
         rJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/vlpUfp9K00BVnxAIIyPR+nmhbV27ININ2rArAaXpSM=;
        b=nqT2UMHL3ucMzUOx4/fwTtB3moQOxm/TsUKC1Rf4NoXO9l8bcjowEF01mWadx5xXJ4
         xhLrSP125fyuD3fF3j/lFr1ivaFSG/zd3B3Zetp4qn4NB5ulBYFPM4ulMZnnZoN/b7ys
         c63DBHkER+Nk4LgJMX1Kp12syMV0RWF2BNgldf3XmUhIdcdcUTjhMJgSMSN5Easy/KFY
         p2mEdVnimBowjUEGaG1i7eoz3XUBsaOVA/zFxoxQmnu9h/OgCARr7jdlhxpAbedjH6+n
         N+2wb2luBHp1CVes6nWyL3fl0hfy0AKnLs0tTOqeqeRjctJ1J+Ev2gidLZlWxnR5ny0n
         y/cQ==
X-Gm-Message-State: AOAM530+GvTI9kO5+Az3dnnlyCmQbt6cxVkfMZiknBZs3TtxF3EMlzJM
        RwyZssGx0UkovfoGZxgMIEDLEaU2AcbWJw==
X-Google-Smtp-Source: ABdhPJzbIMrRu3IPjyi51MWNvv2ayXduXs11T536OsMeZLN9htahCYJvLRo2dLSYAyLE09sVxQ0VPQ==
X-Received: by 2002:a9d:ea2:: with SMTP id 31mr11705355otj.200.1623625124382;
        Sun, 13 Jun 2021 15:58:44 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id r1sm2964049oth.19.2021.06.13.15.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 15:58:44 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/4] xdiff/xmerge: fix chg0 initialization
Date:   Sun, 13 Jun 2021 17:58:36 -0500
Message-Id: <20210613225836.1009569-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210613225836.1009569-1-felipe.contreras@gmail.com>
References: <20210613225836.1009569-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

chg0 is needed when style is XDL_MERGE_DIFF3, xdl_refine_conflicts()
currently is only called when level >= XDL_MERGE_ZEALOUS, which cannot
happen since the level is capped to XDL_MERGE_EAGER.

However, if at some point in the future we decide to not cap diff3, or
introduce a similar uncapped mode, an uninitialized chg0 would cause a
crash.

Let's initialize it to be safe.

Cc: Jeff King <peff@peff.net>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 xdiff/xmerge.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index b5b3f56f92..d9b3a0dccd 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -333,7 +333,7 @@ static int xdl_refine_conflicts(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m,
 		mmfile_t t1, t2;
 		xdfenv_t xe;
 		xdchange_t *xscr, *x;
-		int i1 = m->i1, i2 = m->i2;
+		int i0 = m->i0, i1 = m->i1, i2 = m->i2;
 
 		/* let's handle just the conflicts */
 		if (m->mode)
@@ -384,6 +384,8 @@ static int xdl_refine_conflicts(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m,
 			m->next = m2;
 			m = m2;
 			m->mode = 0;
+			m->i0 = i0;
+			m->chg0 = 0;
 			m->i1 = xscr->i1 + i1;
 			m->chg1 = xscr->chg1;
 			m->i2 = xscr->i2 + i2;
-- 
2.32.0

