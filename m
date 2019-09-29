Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 245031F463
	for <e@80x24.org>; Sun, 29 Sep 2019 00:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbfI2A4x (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Sep 2019 20:56:53 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34975 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728569AbfI2A4x (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Sep 2019 20:56:53 -0400
Received: by mail-io1-f68.google.com with SMTP id q10so28007583iop.2
        for <git@vger.kernel.org>; Sat, 28 Sep 2019 17:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y1A/giyqVuzMK2wtUFD5xkGqrPTcLwPt+mHz+UQi2fc=;
        b=ETOMF+8R3iPDTP/bvkylYPIiO4DELDYGlZC6xJ13RgMRyd3jUD2Jzuhgu16qjazzMF
         o+2l9lgRofH+RRw2M2PCRzdc8jThhkxUqbKQIsmg6m8kLnMnraVZmL4AlEp2YiLMUSGC
         uQh8SVPpW/+7wmIidAYZeB78xqI5FwAY74E0wsYWnxwhfBTvAVDBuiEUwljoVkk2FkOb
         CGu8kTY+Ujw/LdN9yeowRhb5oa77LRd9KodDuNnarv8/c5wjrw6ePRiB0wnqR92TFr4k
         l2PNZDMqTgC4ds/yOsGErIeZSxfzLg4r+R50K9c0hiWWKwTBPRaBme5qLEvNVDLu2Stn
         KyHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y1A/giyqVuzMK2wtUFD5xkGqrPTcLwPt+mHz+UQi2fc=;
        b=l66Is9+s1bliO1sGoRHgrOWZE7rK2Ikd/k0mc8SbvfGa5YcZociTJh39UHowk+0hi2
         Masy1qQeMTKLidBWC1IjH7Ga7+khH45ldcStukR6KmlyiI/ulakXmkTrWiWCu7MO75ne
         jL8aRCuxBIiPL5ArOMXRPSx18FizfZdXqwUfskc3M1+RJB5jehhJL0sQdam4/Tl34wmI
         ReTmqqp4XUx1YDWYxAKR6iT+X2BNgZvTWebVoQ3cM3bOOEycGg4djIc1F0BLSdftXTpz
         UMPMPkYB7CBo4WvfYUMZ44Ylz83kGTLOeJTNN5TlLU/UGraVG2qpNflFPf/QggXQVHq1
         D2lg==
X-Gm-Message-State: APjAAAVIJXPCYDNJLSGk/BSqZ74FJgcDI8PPXwkF9wzRF+S/FvRjCL9A
        MEaZEmryjPJyI3fCxblms5BD5uaj05E=
X-Google-Smtp-Source: APXvYqx0SuUhLVMX0l97FHPYaiNVdIr8wcyLKrcltd5modfeikZBNVaE6OzeZ8JWXKJPhncxKa9bpA==
X-Received: by 2002:a92:3d95:: with SMTP id k21mr14040325ilf.203.1569718611967;
        Sat, 28 Sep 2019 17:56:51 -0700 (PDT)
Received: from xavier.hsd1.ut.comcast.net ([2601:681:4100:375e:3837:c90c:13fa:5c01])
        by smtp.gmail.com with ESMTPSA id t86sm3571939ila.21.2019.09.28.17.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2019 17:56:51 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v3] diffcore-break: use a goto instead of a redundant if statement
Date:   Sat, 28 Sep 2019 18:56:46 -0600
Message-Id: <20190929005646.734046-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The condition "if (q->nr <= j)" checks whether the loop exited normally
or via a break statement. This check can be avoided by replacing the
jump to the end of the loop with a jump to the end of the function.

With the break replaced by a goto, the two diff_q calls then can be
replaced with a single diff_q call outside of the outer if statement.

Reviewed-by: Derrick Stolee <stolee@gmail.com>
Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 diffcore-break.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/diffcore-break.c b/diffcore-break.c
index 875aefd3fe..f6ab74141b 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -286,18 +286,17 @@ void diffcore_merge_broken(void)
 					/* Peer survived.  Merge them */
 					merge_broken(p, pp, &outq);
 					q->queue[j] = NULL;
-					break;
+					goto done;
 				}
 			}
-			if (q->nr <= j)
-				/* The peer did not survive, so we keep
-				 * it in the output.
-				 */
-				diff_q(&outq, p);
+			/* The peer did not survive, so we keep
+			 * it in the output.
+			 */
 		}
-		else
-			diff_q(&outq, p);
+		diff_q(&outq, p);
 	}
+
+done:
 	free(q->queue);
 	*q = outq;
 
-- 
2.23.0

